Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E833DA7F5;
	Thu, 23 Apr 2026 04:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776917079; cv=none; b=V6/0RA8XeGGDXOjcnnSvXIsCmkvg4wrquSOp4uwWPzv7MxBBxnfFOXVZ6V3tB5rkYBGdTaYzBQxyNLv3QPWa2HMWAPwHVTc7ZowTFcFPn5b0Ax9nGdBCbwi/2JrGdOLbx8ztwV7oWBPcoOqDxCTAmMMtWwUUYH1xi+Lfw/kP1AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776917079; c=relaxed/simple;
	bh=XbcxHpw4uNE+IqekwDvaZ6DdyZ/BQ3OprymmdKhzlBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aDpjBxDFqyVcoXWFjWMRuDqbihwYKxffvWaFy+5Pt5scBG0ehUlJJolp/EcwDssZFw8RbQMDxoX89A6OuIkZTPd91kzWAMSyeFpqRlgTtU7M9WKddd6zAOIYqTHLmclmSUx54mzIKyxBWNHvP+UFWNqhBgWukIlSDmjt11ZcOTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QWEis7Tv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QWEis7Tv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64E9BC2BCB4;
	Thu, 23 Apr 2026 04:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776917079;
	bh=XbcxHpw4uNE+IqekwDvaZ6DdyZ/BQ3OprymmdKhzlBw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QWEis7TvAB7Vg5ENluoGzKpx+kegITEYzcABHxGej7FaLpvFCt1siydDvMEp7Gfns
	 +/f0QeS9B6DoPohejA+6zGD1w+yMkH2EOkNYXbawWVB9dzMCMhYvCM+sr7qcjkNtX5
	 8TU6sC2JB7do7MBjLrHiFd3Sn3TsnxArwgLYkHlHEM+QLWVAI58Uc2sKT0wwwaAr5w
	 Ab0o4OJB2drn14GmY+JU2DXdR6eUQ/8tCR0q3Ku4gu1nULMySPCv8rvUkXiKsM+JuM
	 3+okCSdAirBw2meTqas8662CUYeMlNnwKw/suRajq5g+J94dpgsyJy0D1elpHURypR
	 iCmxhj1wB2I9Q==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Song Liu <song@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH 32/48] objtool: Add is_cold_func() helper
Date: Wed, 22 Apr 2026 21:04:00 -0700
Message-ID: <8eea11ea7d0efc5fcd2e57a10c4285fe998f0cec.1776916871.git.jpoimboe@kernel.org>
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

Add an is_cold_func() helper.  The sym->cold bit is redundant and can be
removed.

No functional changes intended.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/check.c               | 6 +++---
 tools/objtool/elf.c                 | 9 +++++----
 tools/objtool/include/objtool/elf.h | 6 +++++-
 tools/objtool/klp-diff.c            | 3 ++-
 4 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 4c18d6e7f6c3..4ed27c53c718 100644
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
@@ -4426,8 +4426,8 @@ static int create_prefix_symbol(struct objtool_file *file, struct symbol *func)
 	char name[SYM_NAME_LEN];
 	struct cfi_state *cfi;
 
-	if (!is_func_sym(func) || is_prefix_func(func) ||
-	    func->cold || func->static_call_tramp)
+	if (!is_func_sym(func) || is_prefix_func(func) || is_cold_func(func) ||
+	    func->static_call_tramp)
 		return 0;
 
 	if ((strlen(func->name) + sizeof("__pfx_") > SYM_NAME_LEN)) {
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 00c2389f345f..8a6e1338af97 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -586,8 +586,11 @@ static int elf_add_symbol(struct elf *elf, struct symbol *sym)
 	if (strstarts(sym->name, ".klp.sym"))
 		sym->klp = 1;
 
+	sym->pfunc = sym->cfunc = sym;
+
 	if (!sym->klp && !is_sec_sym(sym) && strstr(sym->name, ".cold")) {
-		sym->cold = 1;
+		/* Tell read_symbols() this is a cold subfunction */
+		sym->pfunc = NULL;
 
 		/*
 		 * Clang doesn't mark cold subfunctions as STT_FUNC, which
@@ -596,8 +599,6 @@ static int elf_add_symbol(struct elf *elf, struct symbol *sym)
 		sym->type = STT_FUNC;
 	}
 
-	sym->pfunc = sym->cfunc = sym;
-
 	return 0;
 }
 
@@ -695,7 +696,7 @@ static int read_symbols(struct elf *elf)
 			char *pname;
 			size_t pnamelen;
 
-			if (!sym->cold)
+			if (sym->pfunc)
 				continue;
 
 			coldstr = strstr(sym->name, ".cold");
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index 3abe4cbc584c..82b9fb05af26 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -83,7 +83,6 @@ struct symbol {
 	u8 frame_pointer     : 1;
 	u8 ignore	     : 1;
 	u8 nocfi             : 1;
-	u8 cold		     : 1;
 	u8 prefix	     : 1;
 	u8 debug_checksum    : 1;
 	u8 changed	     : 1;
@@ -289,6 +288,11 @@ static inline bool is_prefix_func(struct symbol *sym)
 	return sym->prefix;
 }
 
+static inline bool is_cold_func(struct symbol *sym)
+{
+	return sym->pfunc != sym;
+}
+
 static inline bool is_reloc_sec(struct section *sec)
 {
 	return sec->sh.sh_type == SHT_RELA || sec->sh.sh_type == SHT_REL;
diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
index 1951a8b2df44..266f0d2ba4fe 100644
--- a/tools/objtool/klp-diff.c
+++ b/tools/objtool/klp-diff.c
@@ -1718,7 +1718,8 @@ static int create_klp_sections(struct elfs *e)
 		unsigned long sympos;
 		void *func_data;
 
-		if (!is_func_sym(sym) || sym->cold || !sym->clone || !sym->clone->changed)
+		if (!is_func_sym(sym) || is_cold_func(sym) ||
+		    !sym->clone || !sym->clone->changed)
 			continue;
 
 		/* allocate klp_func_ext */
-- 
2.53.0

