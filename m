Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F59733C50D;
	Thu, 23 Apr 2026 04:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776917067; cv=none; b=MCGNAra1bq5SPJxzq5HiH4fpda1FUoESePxdFi6CW+QAZKoOUUoaWVe+Sxww53snBT53U8T9yT6CuCsqzKBk/Pl2kuJ1rATrFcS/qSknAZMY4XYbHaR+i6SSfvzguyGywqqDK4JiGFgkg5M0ZSo6HWmejUVaIyaBTy3OWE3MRnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776917067; c=relaxed/simple;
	bh=gJ1+DoSFGtvcVD+smd+XFxno5et035NmMg4Kg1wvN8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mn//oD/dYsj0yKzweZIPtXu5QhU8DbJsACk9tOAaA/bXS9Uhjse23HrbKB9kEyox7M5mxKqwhYxxfM42YckDY8V5VDnpJdtTVPD3C7p0xin2Pun5DSJKKEuqZaybMWBtWa0c6k76K2TpYopgbGZoU9jZNd9Kb35cGh/MxF4wtsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wabissop; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wabissop"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C976CC2BCB4;
	Thu, 23 Apr 2026 04:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776917067;
	bh=gJ1+DoSFGtvcVD+smd+XFxno5et035NmMg4Kg1wvN8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wabissop1FapQwrgMoLvrQdVncN/GeQhBXpsfuatWX/8fDWMosxt/XzL77JCpv8Sm
	 uJ6vG16dCJGUs1kkP8QgIwq/KwpfWr8qBJ+6LVJy+alvucM3X3mRgnrxd4n2jPqPYc
	 Zah/w+FDBNhrKO2lqemQsKkS/UY63Tx1VKGJubPHQt9GxoA4djjoCFiktEnqETmz+H
	 5nz3QksxdLIXA+oCJ110gY+NG2aIUNLk2+oHGnbXIHoBVRdXrdRBLoEn65/COVxg37
	 vPvc/kvZDgrb89k7ufzAIe6LJfVkaKLHyVRaADao7sAQPjgJiKT685IYBzufFO5n9Q
	 mbnGf/dK9slRg==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Song Liu <song@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH 07/48] objtool/klp: Don't correlate absolute symbols
Date: Wed, 22 Apr 2026 21:03:35 -0700
Message-ID: <1dc8b127ff0b1252e53bb7e6130ed46c60f57c25.1776916871.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1776916871.git.jpoimboe@kernel.org>
References: <cover.1776916871.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some arch/x86/crypto/*.S files define local .set/.equ constants that get
duplicated in vmlinux.o.  This causes klp-diff to fail with "Multiple
correlation candidates" errors since it can't uniquely match these
between orig and patched builds.

Skip ABS symbols in dont_correlate().  They're purely compile-time
assembly constants that are never referenced by relocations, so they
don't need correlation.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/klp-diff.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
index f6597015b33b..05071d691b5f 100644
--- a/tools/objtool/klp-diff.c
+++ b/tools/objtool/klp-diff.c
@@ -361,6 +361,15 @@ static bool is_addressable_sym(struct symbol *sym)
 	return !strcmp(sym->sec->name, ".discard.addressable");
 }
 
+/*
+ * ABS symbols are typically assembly .set/.equ constants which are never
+ * referenced by relocations.  (Exclude FILE symbols which are also SHN_ABS.)
+ */
+static bool is_abs_sym(struct symbol *sym)
+{
+	return sym->sym.st_shndx == SHN_ABS && !is_file_sym(sym);
+}
+
 /*
  * These symbols should never be correlated, so their local patched versions
  * are used instead of linking to the originals.
@@ -370,6 +379,7 @@ static bool dont_correlate(struct symbol *sym)
 	return is_file_sym(sym) ||
 	       is_null_sym(sym) ||
 	       is_sec_sym(sym) ||
+	       is_abs_sym(sym) ||
 	       is_prefix_func(sym) ||
 	       is_uncorrelated_static_local(sym) ||
 	       is_clang_tmp_label(sym) ||
-- 
2.53.0

