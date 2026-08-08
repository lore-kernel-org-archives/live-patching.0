Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFF9384228;
	Sat,  8 Aug 2026 23:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786231123; cv=none; b=B5HqJxRcc95AJrWf3IHMWAVFJzKsBC7WaIeY1KCAjngwnWxCAL9Xyn6/9NBpE5/w17N8OXhmFAQClZ5qjQLIwrw/XBr2ZqjJk85ZjKSJQ7are6T6iMqXcs9gvAl9ak4e7Rr/vAXzp7OKjWBlgZmyJwShq5KJRHxk+uywN+lXe1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786231123; c=relaxed/simple;
	bh=NS6tK0Zo79hmFyEYzvb1IpQSDc7aH+6k5s86Qwj3jB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UgCTfTXw0kjJn4o0nZQ+hJ/GVNP4aN923GxouFDf2yjtBRtKfKfdEWMlJwgEr4elb/mxLjkIriFcACMg5OQc21K6reG8O9wg9jFt7GNKmrQamIUGxZegezl5sHqzRwv2HV66KhwMcFmrB8V20vCX7pNLKhXi2I05S5G+wsCovks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kTe+Ym3S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kTe+Ym3S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 589B31F00A3D;
	Sat,  8 Aug 2026 23:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786231120;
	bh=vxvjU/LsBii/ygttaMwT+U6HhQA2XQkmzKkMSjzc2JU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kTe+Ym3SyOyvbhzj+vexDJPDKp5QznjYuV0/J1odXdOPapukSUlK5kTHtV6fDtOCV
	 uiyboZfn3bst/unAiZHD/HRxg/a7Q5R64Wo5QP1PHhYpW2cu+wPcKRqqjpOajS4bFD
	 Gq2m1JOZEtrK76TKVw20ruLXXMkJh1xelDOuIwZPnilpzz9NoBQk+TE8ZQb9MQt0Ee
	 eUqBVn8l4/7pZ889RonqNjbRWdkM1Ur6pbDaphvURfK9a0gfTFht3CM8ZI/exqBnH1
	 gCCyZBgPf87kB91C3xWkzES0YNLORwdeoC3Ee9dBl7hegWxwsyvbli8Og/pnXPZfOm
	 2ie51YjEwSxvw==
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
Subject: [PATCH v4 19/22] objtool/klp: Clone inline alternative replacements
Date: Sat,  8 Aug 2026 16:17:23 -0700
Message-ID: <ebbfa4c78e459a21cebfb635225c046984d86b6a.1786230311.git.jpoimboe@kernel.org>
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

Unlike x86-64, arm64 places alternative replacement instructions in
.text, immediately after the affected function.

So if the replacement instructions have PC-relative branches without
relocations, their offsets relative to the function have to remain
constant.

Achieve that by cloning the function's alternative replacements
immediately after cloning the function itself.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/elf.c                 |  9 ++---
 tools/objtool/include/objtool/elf.h |  6 +++-
 tools/objtool/klp-diff.c            | 54 ++++++++++++++++++++++++-----
 tools/objtool/klp-symid.c           |  2 +-
 4 files changed, 57 insertions(+), 14 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index f9d49325dbe0d..f6219f495efdc 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -1426,14 +1426,15 @@ int elf_add_string(struct elf *elf, struct section *strtab, const char *str)
 		return -1;
 	}
 
-	data = elf_add_data(elf, strtab, str, strlen(str) + 1);
+	data = elf_add_data(elf, strtab, str, strlen(str) + 1, true);
 	if (!data)
 		return -1;
 
 	return data - strtab->data->d_buf;
 }
 
-void *elf_add_data(struct elf *elf, struct section *sec, const void *data, size_t size)
+void *elf_add_data(struct elf *elf, struct section *sec, const void *data,
+		   size_t size, bool align)
 {
 	unsigned long offset, size_old, size_new, alloc_size_old, alloc_size_new;
 	Elf_Scn *s;
@@ -1460,7 +1461,7 @@ void *elf_add_data(struct elf *elf, struct section *sec, const void *data, size_
 	}
 
 	size_old = sec->data->d_size;
-	offset = ALIGN(size_old, sec->sh.sh_addralign);
+	offset = ALIGN(size_old, align ? sec->sh.sh_addralign : 1);
 	size_new = offset + size;
 
 	if (!sec->data_overallocated)
@@ -1603,7 +1604,7 @@ static int elf_alloc_reloc(struct elf *elf, struct section *rsec)
 	unsigned long nr_alloc_old = 0, nr_alloc_new;
 	struct symbol *sym;
 
-	if (!elf_add_data(elf, rsec, NULL, elf_rela_size(elf)))
+	if (!elf_add_data(elf, rsec, NULL, elf_rela_size(elf), true))
 		return -1;
 
 	rsec->data->d_type = ELF_T_RELA;
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index d33d25d7472a0..fba0a0e08f8b6 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -107,6 +107,7 @@ struct symbol {
 	u8 klp		     : 1;
 	u8 dont_correlate    : 1;
 	u8 fake		     : 1;
+	u8 unalign	     : 1;
 	struct list_head pv_target;
 	struct reloc *relocs;
 	struct section *group_sec;
@@ -187,7 +188,7 @@ struct symbol *elf_create_symbol(struct elf *elf, const char *name,
 struct symbol *elf_create_section_symbol(struct elf *elf, struct section *sec);
 
 void *elf_add_data(struct elf *elf, struct section *sec, const void *data,
-		   size_t size);
+		   size_t size, bool align);
 
 int elf_find_string(struct elf *elf, struct section *strtab, const char *str);
 int elf_add_string(struct elf *elf, struct section *strtab, const char *str);
@@ -533,6 +534,9 @@ static inline void set_sym_next_reloc(struct reloc *reloc, struct reloc *next)
 #define sec_for_each_sym_from(sec, sym)					\
 	list_for_each_entry_from(sym, &sec->symbol_list, list)
 
+#define sec_for_each_sym_continue(sec, sym)				\
+	list_for_each_entry_continue(sym, &sec->symbol_list, list)
+
 #define sec_prev_sym(sym)						\
 	sym->sec && sym->list.prev != &sym->sec->symbol_list ?		\
 	list_prev_entry(sym, list) : NULL
diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
index d76d2f5b5acbf..841651e3ad746 100644
--- a/tools/objtool/klp-diff.c
+++ b/tools/objtool/klp-diff.c
@@ -1014,8 +1014,9 @@ static int clone_sym_relocs(struct elfs *e, struct symbol *patched_sym);
 static struct symbol *__clone_symbol(struct elf *elf, struct symbol *patched_sym,
 				     bool data_too)
 {
-	struct section *out_sec = NULL;
 	unsigned long offset = 0, pfx_size = 0;
+	bool align = !patched_sym->unalign;
+	struct section *out_sec = NULL;
 	struct symbol *out_sym;
 
 	if (data_too && !is_undef_sym(patched_sym)) {
@@ -1041,7 +1042,7 @@ static struct symbol *__clone_symbol(struct elf *elf, struct symbol *patched_sym
 		}
 
 		if (!is_sec_sym(patched_sym))
-			offset = ALIGN(sec_size(out_sec), out_sec->sh.sh_addralign);
+			offset = ALIGN(sec_size(out_sec), align ? out_sec->sh.sh_addralign : 1);
 
 		if (patched_sym->len || is_sec_sym(patched_sym)) {
 			void *data = NULL;
@@ -1059,7 +1060,7 @@ static struct symbol *__clone_symbol(struct elf *elf, struct symbol *patched_sym
 			else
 				size = patched_sym->len + pfx_size;
 
-			if (!elf_add_data(elf, out_sec, data, size))
+			if (!elf_add_data(elf, out_sec, data, size, align))
 				return NULL;
 
 			offset += pfx_size;
@@ -1101,6 +1102,37 @@ static const char *sym_bind(struct symbol *sym)
 	}
 }
 
+static struct symbol *clone_symbol(struct elfs *e, struct symbol *patched_sym,
+				   bool data_too);
+
+/*
+ * For arm64 alternatives, the replacement instructions come immediately after
+ * the function.  Clone any such blocks of instructions in place to preserve
+ * their offsets relative to the function in case they have hard-coded PC
+ * relative branches.
+ */
+static int clone_inline_alternatives(struct elfs *e, struct symbol *patched_sym)
+{
+	struct symbol *next;
+
+	if (!__is_defined(ARCH_HAS_INLINE_ALTS) || !is_func_sym(patched_sym))
+		return 0;
+
+	next = patched_sym;
+	sec_for_each_sym_continue(patched_sym->sec, next) {
+		if (next->offset < (patched_sym->offset + patched_sym->len) ||
+		    is_mapping_sym(next))
+			continue;
+		if (!next->fake)
+			break;
+		next->unalign = 1;
+		if (!clone_symbol(e, next, true))
+			return -1;
+	}
+
+	return 0;
+}
+
 /*
  * Copy a symbol to the output object, optionally including its data and
  * relocations.
@@ -1125,7 +1157,13 @@ static struct symbol *clone_symbol(struct elfs *e, struct symbol *patched_sym,
 	if (!__clone_symbol(e->out, patched_sym, data_too))
 		return NULL;
 
-	if (data_too && clone_sym_relocs(e, patched_sym))
+	if (!data_too || is_undef_sym(patched_sym))
+		return patched_sym->clone;
+
+	if (clone_sym_relocs(e, patched_sym))
+		return NULL;
+
+	if (clone_inline_alternatives(e, patched_sym))
 		return NULL;
 
 	return patched_sym->clone;
@@ -1585,7 +1623,7 @@ static int clone_reloc_klp(struct elfs *e, struct reloc *patched_reloc,
 	memset(&klp_reloc, 0, sizeof(klp_reloc));
 
 	klp_reloc.type = reloc_type(patched_reloc);
-	if (!elf_add_data(e->out, klp_relocs, &klp_reloc, sizeof(klp_reloc)))
+	if (!elf_add_data(e->out, klp_relocs, &klp_reloc, sizeof(klp_reloc), true))
 		return -1;
 
 	/* klp_reloc.offset */
@@ -2164,7 +2202,7 @@ static int create_klp_sections(struct elfs *e)
 		return -1;
 
 	/* allocate klp_object_ext */
-	obj_data = elf_add_data(e->out, obj_sec, NULL, obj_size);
+	obj_data = elf_add_data(e->out, obj_sec, NULL, obj_size, true);
 	if (!obj_data)
 		return -1;
 
@@ -2199,7 +2237,7 @@ static int create_klp_sections(struct elfs *e)
 			continue;
 
 		/* allocate klp_func_ext */
-		func_data = elf_add_data(e->out, funcs_sec, NULL, func_size);
+		func_data = elf_add_data(e->out, funcs_sec, NULL, func_size, true);
 		if (!func_data)
 			return -1;
 
@@ -2345,7 +2383,7 @@ static int copy_import_ns(struct elfs *e)
 			}
 		}
 
-		if (!elf_add_data(e->out, out_sec, import_ns, strlen(import_ns) + 1))
+		if (!elf_add_data(e->out, out_sec, import_ns, strlen(import_ns) + 1, true))
 			return -1;
 	}
 
diff --git a/tools/objtool/klp-symid.c b/tools/objtool/klp-symid.c
index 21d8708013aba..1934c2a1afc4d 100644
--- a/tools/objtool/klp-symid.c
+++ b/tools/objtool/klp-symid.c
@@ -95,7 +95,7 @@ int klp_create_symid_sections(struct objtool_file *file)
 	if (!sec)
 		return -1;
 
-	symids = elf_add_data(elf, sec, NULL, nr * sizeof(struct klp_symid));
+	symids = elf_add_data(elf, sec, NULL, nr * sizeof(struct klp_symid), true);
 	if (!symids)
 		return -1;
 
-- 
2.54.0

