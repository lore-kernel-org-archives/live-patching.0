Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E87D38A72B;
	Sat,  8 Aug 2026 23:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786231125; cv=none; b=bqunMs5YMQ9/aBJmEbaMSFjAPbsfcvGhU/TvBVwtPh0jG7mn3QMAqBHfzeytrlSqPMlrJMV43xZI7QDMJrDDoRt9xkc38P18Px/uFNou3lQADPMtWNGhAdqdGtE1HkZZPXdu+WbhXKMmlgSlAgFBWA+zg+ZPf9tr/c1jJFL48vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786231125; c=relaxed/simple;
	bh=YVoFnbRXzdAm3656N9+w6Aik7qaf7oeQUVjl7iA969o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=leJMsoWSEsQSD9m6FcJzEmC2zgtQ8pM9nQfpbrGx1qdQRDHiY0xu953WzxodTPZqIJfZw2PakDWWt64RIISq7haJkrQGmwgg8wYD0ofvvGXaYhoBCXX+CYnYCS0tpSbmn602c8/UVnC5n65pyrfXk0Q+tE3dhwvybYSZaheZz6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jAOhwt+8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jAOhwt+8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F33921F00A3A;
	Sat,  8 Aug 2026 23:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786231118;
	bh=ydJP/+WzOb4kIUyHuQZNxhoj1FmudpqW9aVIrC7YUX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jAOhwt+8yck4zA1bbe1gc6yQH7RfnncAZbSDQRPdPrEsJgS5C5otJEvDMziBD1h90
	 kmnEpmrEY8plfNQiCnyMg9XhZFPy/5krJ+XPl+C/EEcY5OZOVeBvzkoWEbeuZO9l69
	 gx5bMSmPqpr+H3LBU8VJGzWg6/2cA6bKZkbPyc4Whg5L+dzxJgLjHUbFC2F3+vV3lj
	 vKXaR8J8FGTQpT0VyjDCwQmV/tE+/b2Hru3rcfy/ZGAOM9oZvn6SxXxN/jF4enyZC4
	 QVB1iViYTAutZrdQyF+enu02e3y17xgrP2iZQXTqs6LnOu3Ei2pe9uGu4UvBBxQ2sB
	 Wc2AWfIqFIf/A==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Song Liu <song@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH v4 16/22] objtool/klp: Add arm64 support for prefix/PFE detection
Date: Sat,  8 Aug 2026 16:17:20 -0700
Message-ID: <ea399b0a3a37860ba71013c9ec72a1e8784b5712.1786230311.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1786230311.git.jpoimboe@kernel.org>
References: <cover.1786230311.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add arm64 support for detecting prefixed areas before functions (for
kCFI or ftrace with call ops), and __patchable_function_entries (for
ftrace with call ops or args).

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/arch/x86/include/arch/elf.h |   2 +
 tools/objtool/elf.c                       |  13 ++
 tools/objtool/include/objtool/elf.h       |   2 +
 tools/objtool/klp-diff.c                  | 166 ++++++++++++++++++++--
 4 files changed, 172 insertions(+), 11 deletions(-)

diff --git a/tools/objtool/arch/x86/include/arch/elf.h b/tools/objtool/arch/x86/include/arch/elf.h
index 7131f7f51a4e8..5ee0ccda7db18 100644
--- a/tools/objtool/arch/x86/include/arch/elf.h
+++ b/tools/objtool/arch/x86/include/arch/elf.h
@@ -10,4 +10,6 @@
 #define R_TEXT32	R_X86_64_PC32
 #define R_TEXT64	R_X86_64_PC32
 
+#define ARCH_HAS_PREFIX_SYMBOLS 1
+
 #endif /* _OBJTOOL_ARCH_ELF */
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 3bb04d6155a8b..180e0a0da00ff 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -275,6 +275,19 @@ struct symbol *find_func_containing(struct section *sec, unsigned long offset)
 	return NULL;
 }
 
+struct symbol *find_data_mapping_sym(struct section *sec, unsigned long offset)
+{
+	struct rb_root_cached *tree = (struct rb_root_cached *)&sec->symbol_tree;
+	struct symbol *sym;
+
+	__sym_for_each(sym, tree, offset, offset) {
+		if (sym->offset == offset && is_data_mapping_sym(sym))
+			return sym;
+	}
+
+	return NULL;
+}
+
 struct symbol *find_symbol_by_name(const struct elf *elf, const char *name)
 {
 	struct symbol *sym;
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index 796d154d447b6..d33d25d7472a0 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -131,6 +131,7 @@ struct elf {
 	struct list_head sections;
 	struct list_head symbols;
 	unsigned long num_relocs;
+	int pfe_offset;
 
 	int symbol_bits;
 	int symbol_name_bits;
@@ -230,6 +231,7 @@ struct reloc *find_reloc_by_dest(const struct elf *elf, struct section *sec, uns
 struct reloc *find_reloc_by_dest_range(const struct elf *elf, struct section *sec,
 				     unsigned long offset, unsigned int len);
 struct symbol *find_func_containing(struct section *sec, unsigned long offset);
+struct symbol *find_data_mapping_sym(struct section *sec, unsigned long offset);
 
 /*
  * Try to see if it's a whole archive (vmlinux.o or module).
diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
index 446ea6f9864a1..922de4c8e9e89 100644
--- a/tools/objtool/klp-diff.c
+++ b/tools/objtool/klp-diff.c
@@ -20,6 +20,7 @@
 #include <linux/stringify.h>
 #include <linux/string.h>
 #include <linux/jhash.h>
+#include <linux/kconfig.h>
 
 #define sizeof_field(TYPE, MEMBER) sizeof((((TYPE *)0)->MEMBER))
 
@@ -260,6 +261,98 @@ static int read_sym_checksums(struct elf *elf)
 	return 0;
 }
 
+/*
+ * For non-x86, detect the offset from the function entry point to its
+ * __patchable_function_entries (PFE) relocation target.  x86 doesn't need this,
+ * it clones the __cfi/__pfx symbol instead.
+ *
+ * offset < 0 (before function entry):
+ *
+ *    CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS (arm64)
+ *
+ * offset == 0 (at function entry):
+ *
+ *    CONFIG_DYNAMIC_FTRACE_WITH_ARGS without BTI (arm64)
+ *
+ * offset > 0 (after function entry):
+ *
+ *    CONFIG_DYNAMIC_FTRACE_WITH_ARGS with BTI (arm64)
+ */
+static int read_pfe_offset(struct elf *elf)
+{
+	bool has_pfe = false;
+	struct section *sec;
+
+	if (__is_defined(ARCH_HAS_PREFIX_SYMBOLS))
+		return 0;
+
+	for_each_sec(elf, sec) {
+		struct reloc *reloc;
+
+		if (strcmp(sec->name, "__patchable_function_entries"))
+			continue;
+		if (!sec->rsec)
+			continue;
+
+		has_pfe = true;
+
+		for_each_reloc(sec->rsec, reloc) {
+			unsigned long target = reloc->sym->offset + reloc_addend(reloc);
+			struct symbol *func;
+
+			/* arm64 func */
+			func = find_func_containing(reloc->sym->sec, target);
+			if (func) {
+				elf->pfe_offset = target - func->offset;
+				return 0;
+			}
+
+			/* arm64 CALL_OPS */
+			func = find_func_by_offset(reloc->sym->sec, target + 8);
+			if (func) {
+				elf->pfe_offset = -8;
+				return 0;
+			}
+		}
+	}
+
+	if (has_pfe) {
+		ERROR("can't find __patchable_function_entries offset");
+		return -1;
+	}
+
+	return 0;
+}
+
+/*
+ * Detect the size of the area before a function's entry point.  This prefix
+ * area is used for CFI type hashes or ftrace call ops.
+ *
+ *  $d mapping symbol (arm64):
+ *
+ *    CONFIG_CFI
+ *
+ *  PFE before function entry, no symbol (arm64):
+ *
+ *    CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS
+ */
+static unsigned long func_pfx_size(struct elf *elf, struct symbol *func)
+{
+	if (__is_defined(ARCH_HAS_PREFIX_SYMBOLS))
+		return 0;
+
+	/* arm64 kCFI $d data mapping symbol */
+	if (func->offset >= 4 &&
+	    find_data_mapping_sym(func->sec, func->offset - 4))
+		return 4;
+
+	/* arm64 CALL_OPS (mutually exclusive with kCFI) */
+	if (elf->pfe_offset < 0 && func->offset >= -elf->pfe_offset)
+		return -elf->pfe_offset;
+
+	return 0;
+}
+
 static struct symbol *first_file_symbol(struct elf *elf)
 {
 	struct symbol *sym;
@@ -348,6 +441,9 @@ static bool is_special_section(struct section *sec)
 		"__ex_table",
 		"__jump_table",
 		"__mcount_loc",
+#ifndef ARCH_HAS_PREFIX_SYMBOLS
+		"__patchable_function_entries",
+#endif
 
 		/*
 		 * Extract .static_call_sites here to inherit non-module
@@ -918,7 +1014,7 @@ static struct symbol *__clone_symbol(struct elf *elf, struct symbol *patched_sym
 				     bool data_too)
 {
 	struct section *out_sec = NULL;
-	unsigned long offset = 0;
+	unsigned long offset = 0, pfx_size = 0;
 	struct symbol *out_sym;
 
 	if (data_too && !is_undef_sym(patched_sym)) {
@@ -950,17 +1046,22 @@ static struct symbol *__clone_symbol(struct elf *elf, struct symbol *patched_sym
 			void *data = NULL;
 			size_t size;
 
+			/* Clone (non-x86) function prefix area */
+			pfx_size = is_func_sym(patched_sym) ? func_pfx_size(elf, patched_sym) : 0;
+
 			/* bss doesn't have data */
 			if (patched_sym->sec->data && patched_sym->sec->data->d_buf)
-				data = patched_sym->sec->data->d_buf + patched_sym->offset;
+				data = patched_sym->sec->data->d_buf + patched_sym->offset - pfx_size;
 
 			if (is_sec_sym(patched_sym))
 				size = sec_size(patched_sym->sec);
 			else
-				size = patched_sym->len;
+				size = patched_sym->len + pfx_size;
 
 			if (!elf_add_data(elf, out_sec, data, size))
 				return NULL;
+
+			offset += pfx_size;
 		}
 	}
 
@@ -1235,21 +1336,41 @@ static int convert_reloc_sym_to_secsym(struct elf *elf, struct reloc *reloc)
 	return 0;
 }
 
+/*
+ * __patchable_function_entries relocs point to the patchable entry NOPs,
+ * which are at 'pfe_offset' bytes from the function symbol.
+ *
+ * Some entries (e.g., removed weak functions, syscall -ENOSYS stubs) don't
+ * have a corresponding function symbol.  Skip those with a return value of 1.
+ */
+static int convert_pfe_reloc(struct elf *elf, struct reloc *reloc)
+{
+	struct symbol *func;
+
+	func = find_func_by_offset(reloc->sym->sec,
+				   reloc->sym->offset +
+				   reloc_addend(reloc) - elf->pfe_offset);
+	if (!func)
+		return 1;
+
+	reloc->sym = func;
+	set_reloc_sym(elf, reloc, func->idx);
+	set_reloc_addend(elf, reloc, elf->pfe_offset);
+	return 0;
+}
+
 /* Return -1 error, 0 success, 1 skip */
 static int convert_reloc_secsym_to_sym(struct elf *elf, struct reloc *reloc)
 {
 	struct symbol *sym = reloc->sym;
 	struct section *sec = sym->sec;
 
+	if (!strcmp(reloc->sec->name, ".rela__patchable_function_entries"))
+		return convert_pfe_reloc(elf, reloc);
+
 	if (!is_sec_sym(sym))
 		return 0;
 
-	/* If the symbol has a dedicated section, it's easy to find */
-	sym = find_symbol_by_offset(sec, 0);
-	if (sym && sym->len == sec_size(sec))
-		goto found_sym;
-
-	/* No dedicated section; find the symbol manually */
 	sym = find_symbol_containing_inclusive(sec, arch_adjusted_addend(reloc));
 	if (!sym) {
 		/*
@@ -1277,7 +1398,6 @@ static int convert_reloc_secsym_to_sym(struct elf *elf, struct reloc *reloc)
 		return -1;
 	}
 
-found_sym:
 	reloc->sym = sym;
 	set_reloc_sym(elf, reloc, sym->idx);
 	set_reloc_addend(elf, reloc, reloc_addend(reloc) - sym->offset);
@@ -1925,6 +2045,9 @@ static int validate_special_section_klp_reloc(struct elfs *e, struct symbol *sym
 
 static int clone_special_section(struct elfs *e, struct section *patched_sec)
 {
+	bool is_pfe = !strcmp(patched_sec->name, "__patchable_function_entries");
+	struct section *out_sec = NULL;
+	struct reloc *patched_reloc;
 	struct symbol *patched_sym;
 
 	/*
@@ -1932,6 +2055,7 @@ static int clone_special_section(struct elfs *e, struct section *patched_sec)
 	 * reference included functions.
 	 */
 	sec_for_each_sym(patched_sec, patched_sym) {
+		struct symbol *out_sym;
 		int ret;
 
 		if (!is_object_sym(patched_sym))
@@ -1946,8 +2070,23 @@ static int clone_special_section(struct elfs *e, struct section *patched_sec)
 		if (ret > 0)
 			continue;
 
-		if (!clone_symbol(e, patched_sym, true))
+		out_sym = clone_symbol(e, patched_sym, true);
+		if (!out_sym)
 			return -1;
+
+		if (!is_pfe || (out_sec && out_sec->sh.sh_link))
+			continue;
+
+		/*
+		 * For reasons, the patched object has multiple PFE sections,
+		 * but we only need to create one combined section for the
+		 * output.  Link the single PFE ouput section to a random text
+		 * section to satisfy the linker for SHF_LINK_ORDER.
+		 */
+		out_sec = out_sym->sec;
+		patched_reloc = find_reloc_by_dest(e->patched, patched_sec,
+						   patched_sym->offset);
+		out_sec->sh.sh_link = patched_reloc->sym->clone->sec->idx;
 	}
 
 	return 0;
@@ -2247,6 +2386,9 @@ int cmd_klp_diff(int argc, const char **argv)
 	if (read_sym_checksums(e.patched))
 		return -1;
 
+	if (read_pfe_offset(e.patched))
+		return -1;
+
 	if (correlate_symbols(&e))
 		return -1;
 
@@ -2260,6 +2402,8 @@ int cmd_klp_diff(int argc, const char **argv)
 	if (!e.out)
 		return -1;
 
+	e.out->pfe_offset = e.patched->pfe_offset;
+
 	/*
 	 * Special section fake symbols are needed so that individual special
 	 * section entries can be extracted by clone_special_sections().
-- 
2.54.0

