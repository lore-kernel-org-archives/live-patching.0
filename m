Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C562F9D98;
	Fri,  1 May 2026 04:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777608532; cv=none; b=MGp3LW6Ev057VkZUDqrrDpM4V01+w2G4k0GeawGU1S00SnZMaz11T3k6m5RkCsGrP/YVWZdZ35dYtV9mBhI7hpsBncMTcPgcKUuFB77pp4E3sOqSHznYG2ANmYGnI1FFECpjJB3+TBEtMcwGSFTiBfbCwm4HDJyKFboGiBObCsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777608532; c=relaxed/simple;
	bh=qH4RZkCPnkCHZ+L+3uEq2QGmezXAYx2GOoMqX7Scsoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZTx4QsXKgHJ0fKdNGD3kkWGnzlCwt9+YzqNZCwdfInrKa/Rq65zqyUuRgzpssp/AbpRyhZzXtLhMebQdCZHUJaMVU5pPGoDVDyijkOARP70mFY1WZesC1e/oilZeBZMx9gXHuyEf6gpVesD5Df53jDv8yS78ySSb0DO2mmhBJU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X16wkMbh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X16wkMbh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5C9AC2BCC9;
	Fri,  1 May 2026 04:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777608532;
	bh=qH4RZkCPnkCHZ+L+3uEq2QGmezXAYx2GOoMqX7Scsoc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X16wkMbhUQYyQBV0wTQPttuyyXnD8v2BypPkt+h9aMPZJy0dqb6c6FbZr1X7Fe/4M
	 6Gh5Q3TnzZHdBY1x6W0hOB9TuVefmGqWxoHReOEqJBkBQGBB5UYpQ/pBJptpSjLC7U
	 lm95KPvozbFekVtR1cRCK+5tsCtsJ9RlE9jhPw7IND2t36o6TVAy6i9f90RQS6sJDW
	 kg5WLfpbAk9/0nUBrjOc1nbBgPOsAHV+qYA18u2ji//+Yb46B9X6+7A8zCiIc0J+/g
	 99MGIEmM8BkkKtxWdf5TjYhZiSWokF28+tint/ZG4YV8H5P6e+5XotHDRlvsOnQzBY
	 pisIpNXIrgP3A==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Song Liu <song@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH v2 04/53] objtool/klp: Don't correlate absolute symbols
Date: Thu, 30 Apr 2026 21:07:52 -0700
Message-ID: <b613d611357065a5162f73b23e8d64797904c6bd.1777575752.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1777575752.git.jpoimboe@kernel.org>
References: <cover.1777575752.git.jpoimboe@kernel.org>
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

Acked-by: Song Liu <song@kernel.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/klp-diff.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
index 36753eeba58c..27ebe1b1f463 100644
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

