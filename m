Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F399313267;
	Fri,  1 May 2026 04:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777608548; cv=none; b=mAJpPAgyjiWW150iLUe+3/nPcipAcqtEWtF/JVqtUSA4pooyd2DZO9Mt/VAVaGqyxZh5B2OgnGaPMoVmmknI7Wh6OCC1s/+GSzrAkquMALjNyIJdKEsugpILhP7cTS2Fy8h3mHcR7rCllljTDwwBPq9ZO5wsqz0UKuIk05VrXEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777608548; c=relaxed/simple;
	bh=1YoJrPuxqlDAdZSZ/V51TZ5Nbry8SmQdApKpcxnsBJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xwydkra7O268TsmNKf/awvmG9Ki9NvTv02eU8gdFWQb0nUVJ/rvwsdlaZD65fT/IrXL36dFp3jz0rdt56Cji/PfYmXRgqJIdO5m5x4rcRrLETySyGWWTiH8Kd8yjIRrVtmJDp91vS7RiYapjrwJ5u8A23/V+bJsgdx6G2hMTtRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p5rjoy+p; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p5rjoy+p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C337DC2BCB7;
	Fri,  1 May 2026 04:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777608548;
	bh=1YoJrPuxqlDAdZSZ/V51TZ5Nbry8SmQdApKpcxnsBJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p5rjoy+p1FAxRycGSp6pA9H2+tvEoCSisShhI78cbZ4jQ7za2pra9mweZ5ajvoODS
	 jeHiKsH7mNwZK7VXQkoyv0UV9sn98oIdWlSSWFJnMG8dH41WtTkMghJfT/dynqR1AJ
	 UjfO7jDd+Sfe3RX/4Trprj0Dnd7eRVGDC1EQ8PY5AKeALvnzAGufrorMWM8Rqd+242
	 aLpUQC22bzIfjOZdeDPNA0VS/tUwpo65ad9aWSLO42NCIYpH9vW1YMWT59CSCbjpev
	 a3gljYuQ7dbkyuez5Tk16JPMQ1Uv286dy1Dsm2f7QAe4N8Hk7C1AB9+kWF6b2/Hzb3
	 U8jhlj5IbMmOw==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Song Liu <song@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH v2 38/53] objtool: Add is_cold_func() helper
Date: Thu, 30 Apr 2026 21:08:26 -0700
Message-ID: <a84513224f38c7c7ca2cf2a4930f87d43a76908b.1777575752.git.jpoimboe@kernel.org>
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

Add an is_cold_func() helper.  No functional changes intended.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/check.c               | 6 +++---
 tools/objtool/include/objtool/elf.h | 5 +++++
 tools/objtool/klp-diff.c            | 3 ++-
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 6c94eb32c090..93a054adf209 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2614,7 +2614,7 @@ static void mark_holes(struct objtool_file *file)
 		if (insn->jump_dest) {
 			struct symbol *dest_func = insn_func(insn->jump_dest);
 
-			if (dest_func && dest_func->cold)
+			if (dest_func && is_cold_func(dest_func))
 				dest_func->ignore = true;
 		}
 	}
@@ -4422,8 +4422,8 @@ static int create_prefix_symbol(struct objtool_file *file, struct symbol *func)
 	char name[SYM_NAME_LEN];
 	struct cfi_state *cfi;
 
-	if (!is_func_sym(func) || is_prefix_func(func) ||
-	    func->cold || func->static_call_tramp)
+	if (!is_func_sym(func) || is_prefix_func(func) || is_cold_func(func) ||
+	    func->static_call_tramp)
 		return 0;
 
 	if ((strlen(func->name) + sizeof("__pfx_") > SYM_NAME_LEN)) {
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index ccc72a692d9a..e452784df702 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -308,6 +308,11 @@ static inline bool is_prefix_func(struct symbol *sym)
 	return sym->prefix;
 }
 
+static inline bool is_cold_func(struct symbol *sym)
+{
+	return sym->cold;
+}
+
 static inline bool is_reloc_sec(struct section *sec)
 {
 	return sec->sh.sh_type == SHT_RELA || sec->sh.sh_type == SHT_REL;
diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
index 7e58ef36f805..8728dda1e08c 100644
--- a/tools/objtool/klp-diff.c
+++ b/tools/objtool/klp-diff.c
@@ -1709,7 +1709,8 @@ static int create_klp_sections(struct elfs *e)
 		unsigned long sympos;
 		void *func_data;
 
-		if (!is_func_sym(sym) || sym->cold || !sym->clone || !sym->clone->changed)
+		if (!is_func_sym(sym) || is_cold_func(sym) ||
+		    !sym->clone || !sym->clone->changed)
 			continue;
 
 		/* allocate klp_func_ext */
-- 
2.53.0

