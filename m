Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CE12F4A16;
	Fri,  1 May 2026 04:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777608532; cv=none; b=jLlH4fqKxZpoJQWJ9ojoDlgJvogVhMpV4oJkLMlXIfXPYQvvHV7QEXVQNty3o7qRNEigOQduhF8aZGITV11plhKK5rnWKKxCS9i8PHJVxuC4WG3Tdo9lGqhstbF0W4JZ7LvAGY1a8/w8sn0JDaNO/k9Texfps6M1/JfUfu7251o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777608532; c=relaxed/simple;
	bh=+NM3TboCjx9zMokNZj1lQYyUCDXizYcds2lJrXgjfgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mwPeaH0YCiW02dCWEtHo6H2/IYuM6byH/+8cGTu2jMFteBy2bX+hKhlnBiqyi6NnoiReogHFkVhu6PaD1NuNKtk/htR5TMy/LG+qqny3RtctKC9T1/veWuGs6P+6Jv7wZTAm8xrTiKMUtdV9YBkyT6Rwrb8ljAkH8o+TPjt0IFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FgnM87Yl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FgnM87Yl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65E8EC2BCB7;
	Fri,  1 May 2026 04:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777608531;
	bh=+NM3TboCjx9zMokNZj1lQYyUCDXizYcds2lJrXgjfgQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FgnM87YlXl6u+uSiby63QlCT85KpQZPEkzYWC/p0Fi7GP8mSB2kkoGY5SHfXbAV6T
	 lZCwjYmNG8zHqVP8p+RfiN7sAMiITbRFFGp8b6j35LTW33T+S82ZgRMO6c/PhY0oK2
	 jLxZbLNgebcNe44h1bp2LcdN0048DB7JM3lN4r4TUIfFkpwjz+t83/Fg3rfhbUofmy
	 8n49ss2pWAxUW0Zekt0U8F4xSG5I78hYD9vvIUu0YM/GcunyHlz0v44WEbifppCOaH
	 sQQZhcHYQa09IjtPXtZlTdL3w1WMuqRfMfqO5KSt7jjVu+zlTSHklLmNkc1shvMclO
	 Jn/6HTPRKYRuQ==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Song Liu <song@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH v2 03/53] objtool/klp: Don't correlate __ADDRESSABLE() symbols
Date: Thu, 30 Apr 2026 21:07:51 -0700
Message-ID: <8e69c287bd6c33cec1535228e2239b33f4602bc6.1777575752.git.jpoimboe@kernel.org>
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

Symbols created by __ADDRESSABLE() are only used to convince the
toolchain not to optimize out the referenced symbol.

Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/klp-diff.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
index cb26c1c92a74..36753eeba58c 100644
--- a/tools/objtool/klp-diff.c
+++ b/tools/objtool/klp-diff.c
@@ -352,6 +352,15 @@ static bool is_special_section_aux(struct section *sec)
 	return false;
 }
 
+/*
+ * Symbols created by ___ADDRESSABLE() are only used to convince the toolchain
+ * not to optimize out the referenced symbol.
+ */
+static bool is_addressable_sym(struct symbol *sym)
+{
+	return !strcmp(sym->sec->name, ".discard.addressable");
+}
+
 /*
  * These symbols should never be correlated, so their local patched versions
  * are used instead of linking to the originals.
@@ -365,6 +374,7 @@ static bool dont_correlate(struct symbol *sym)
 	       is_uncorrelated_static_local(sym) ||
 	       is_clang_tmp_label(sym) ||
 	       is_string_sec(sym->sec) ||
+	       is_addressable_sym(sym) ||
 	       is_special_section(sym->sec) ||
 	       is_special_section_aux(sym->sec) ||
 	       strstarts(sym->name, "__initcall__");
-- 
2.53.0

