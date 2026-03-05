Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B669283FC3
	for <live-patching@vger.kernel.org>; Thu,  5 Mar 2026 23:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772752550; cv=none; b=Qie7dN8O1gtCHPo+YK9qplCHiMBKVcPCl29NWB5uh8vcSURXVhjChTJw/uWU7J0nXkAKzN7JtdKNnIhURh3PFicCjcf90gVcWm5LKVdp4Pna1Ndu0iUxqy9Ufnt0eGFOAQeWKKxD4o8HayxQvVmFeL+93SzfU7pCwotHg4LfSEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772752550; c=relaxed/simple;
	bh=Uzf1fp727mGT7MQF0cmYt5MUiMkcKHFywCvjA3CMRIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hKuhzFNQgYsPb+L9bqNZpTzxDlGtkG4bs2eYRch6a3mjI2YIFddc6TiY8siz9mUN8fuUiSC7IpbpSbhY3rgWhbe1shQ4nmpqrxvNTQ9M3PlptfBitSQ7Xo4e3yk+Qm8tSdNc34EeFJzzkEYiYbJqVkL20d+2sO9auGNVxRtJ/oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RrVfnrOv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RrVfnrOv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A491C116C6;
	Thu,  5 Mar 2026 23:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772752549;
	bh=Uzf1fp727mGT7MQF0cmYt5MUiMkcKHFywCvjA3CMRIE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RrVfnrOvtVbGwkPf9k/Rq2EmwvPQuAEU1dh1T8Eqwe6pmQy4fjDeZSXciaZlqBVjB
	 0UoWvHlEehdw+GyxaTonvazJEcUDnwvg/URT5+45atK2cyNBDbZIELMsICEPBSmXEO
	 9IFt7ahIyZqkhZA9L2Rv3h3jLY+hTHV0fSQL+L0vEYSe211gIb2ZDTVx6zhn0xz6ip
	 45HU54+J2DrvQ2s2CZuna83QpWiMPmhsjzhsR/dltS5E2EJo99RJxt/7F4QlANulpZ
	 fnyYsD9loBDjYswDgQTzcm2ggWfUenlcyrYLYeY4uzzlcQKg5n3xs3XOLuMFQoKoGo
	 kqgSWrWZXscgg==
From: Song Liu <song@kernel.org>
To: live-patching@vger.kernel.org
Cc: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	kernel-team@meta.com,
	Song Liu <song@kernel.org>
Subject: [PATCH v4 3/7] objtool/klp: Use sym->demangled_name for symbol_name hash
Date: Thu,  5 Mar 2026 15:15:27 -0800
Message-ID: <20260305231531.3847295-4-song@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260305231531.3847295-1-song@kernel.org>
References: <20260305231531.3847295-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For klp-build with LTO, it is necessary to correlate demangled symbols,
e.g., correlate foo.llvm.<num 1> and foo.llvm.<num 2>. However, these two
symbols do not have the same str_hash(name). To be able to correlate the
two symbols, calculate hash based on demanged_name, so that these two
symbols have the same hash.

No functional changes intended.

Signed-off-by: Song Liu <song@kernel.org>
---
 tools/objtool/elf.c | 58 +++++++++++++++++++++++++++++++--------------
 1 file changed, 40 insertions(+), 18 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 0d93e8496e8d..d9f883f7cff8 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -26,11 +26,18 @@
 #include <objtool/elf.h>
 #include <objtool/warn.h>
 
+static ssize_t demangled_name_len(const char *name);
+
 static inline u32 str_hash(const char *str)
 {
 	return jhash(str, strlen(str), 0);
 }
 
+static inline u32 str_hash_demangled(const char *str)
+{
+	return jhash(str, demangled_name_len(str), 0);
+}
+
 #define __elf_table(name)	(elf->name##_hash)
 #define __elf_bits(name)	(elf->name##_bits)
 
@@ -294,7 +301,7 @@ static struct symbol *find_local_symbol_by_file_and_name(const struct elf *elf,
 {
 	struct symbol *sym;
 
-	elf_hash_for_each_possible(symbol_name, sym, name_hash, str_hash(name)) {
+	elf_hash_for_each_possible(symbol_name, sym, name_hash, str_hash_demangled(name)) {
 		if (sym->bind == STB_LOCAL && sym->file == file &&
 		    !strcmp(sym->name, name)) {
 			return sym;
@@ -308,7 +315,7 @@ struct symbol *find_global_symbol_by_name(const struct elf *elf, const char *nam
 {
 	struct symbol *sym;
 
-	elf_hash_for_each_possible(symbol_name, sym, name_hash, str_hash(name)) {
+	elf_hash_for_each_possible(symbol_name, sym, name_hash, str_hash_demangled(name)) {
 		if (!strcmp(sym->name, name) && !is_local_sym(sym))
 			return sym;
 	}
@@ -441,6 +448,28 @@ static int read_sections(struct elf *elf)
 	return 0;
 }
 
+/*
+ * Returns desired length of the demangled name.
+ * If name doesn't need demangling, return strlen(name).
+ */
+static ssize_t demangled_name_len(const char *name)
+{
+	ssize_t idx;
+
+	if (!strstarts(name, "__UNIQUE_ID_") && !strchr(name, '.'))
+		return strlen(name);
+
+	for (idx = strlen(name) - 1; idx >= 0; idx--) {
+		char c = name[idx];
+
+		if (!isdigit(c) && c != '.' && c != '_')
+			break;
+	}
+	if (idx <= 0)
+		return strlen(name);
+	return idx + 1;
+}
+
 /*
  * Remove number suffix of a symbol.
  *
@@ -457,6 +486,7 @@ static int read_sections(struct elf *elf)
 static const char *demangle_name(struct symbol *sym)
 {
 	char *str;
+	ssize_t len;
 
 	if (!is_local_sym(sym))
 		return sym->name;
@@ -464,24 +494,16 @@ static const char *demangle_name(struct symbol *sym)
 	if (!is_func_sym(sym) && !is_object_sym(sym))
 		return sym->name;
 
-	if (!strstarts(sym->name, "__UNIQUE_ID_") && !strchr(sym->name, '.'))
+	len = demangled_name_len(sym->name);
+	if (len == strlen(sym->name))
 		return sym->name;
 
-	str = strdup(sym->name);
+	str = strndup(sym->name, len);
 	if (!str) {
 		ERROR_GLIBC("strdup");
 		return NULL;
 	}
 
-	for (int i = strlen(str) - 1; i >= 0; i--) {
-		char c = str[i];
-
-		if (!isdigit(c) && c != '.' && c != '_') {
-			str[i + 1] = '\0';
-			break;
-		}
-	}
-
 	return str;
 }
 
@@ -517,9 +539,13 @@ static int elf_add_symbol(struct elf *elf, struct symbol *sym)
 		entry = &sym->sec->symbol_list;
 	list_add(&sym->list, entry);
 
+	sym->demangled_name = demangle_name(sym);
+	if (!sym->demangled_name)
+		return -1;
+
 	list_add_tail(&sym->global_list, &elf->symbols);
 	elf_hash_add(symbol, &sym->hash, sym->idx);
-	elf_hash_add(symbol_name, &sym->name_hash, str_hash(sym->name));
+	elf_hash_add(symbol_name, &sym->name_hash, str_hash(sym->demangled_name));
 
 	if (is_func_sym(sym) &&
 	    (strstarts(sym->name, "__pfx_") ||
@@ -543,10 +569,6 @@ static int elf_add_symbol(struct elf *elf, struct symbol *sym)
 
 	sym->pfunc = sym->cfunc = sym;
 
-	sym->demangled_name = demangle_name(sym);
-	if (!sym->demangled_name)
-		return -1;
-
 	return 0;
 }
 
-- 
2.52.0

