Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D30381EB4;
	Sat,  8 Aug 2026 23:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786231120; cv=none; b=pZEPRLBkphcwLDmIrYI4ZzESr7GVdaHujuMV0A+b3VdHnKEcYOKS6U06bo2Z+Jkg++fKNlqa1lsXEjC7hdweQmeC2XZe/LK51pJ8jVCbPZaQEVkoIKdTPMR2Z+JDXob+Gb7kySnSAui0knig736ORayc8wwqmY5PgTYHD+nLRxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786231120; c=relaxed/simple;
	bh=pg+tc++Rl7SF1/WkWtk/Sq+xGlpSzahN09+kSeyTKC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oDNMSUADX8ZzN3lJY+rp4zaQqfimTtnAJVTMrkYLzZb1s84fmqSbM6k0C5E/M1qiW6qEJ94jjwI/HTFsENpWfvnrRK51V1FTtGa+H1pFrYH0jxM1NdMX5mo98weVki+sbRXIrQOkqF0rNiSKZxwNQR9IxY0IwpPyr0WD8Er+bMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iv0xdtvB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iv0xdtvB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7B861F00ADB;
	Sat,  8 Aug 2026 23:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786231116;
	bh=q/7ZXZiGZL3y71MydQCQYr/Z0bjpjJ17DIbARhGctuY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Iv0xdtvBkQcf23BLNLWiWwmP13Vp89P8TfitdbZSgxGXAulLeguZOHk3YEwIn0Rcs
	 xKI/ejyJLwvwwb/Nx5m4NJdGiQQqYIbuZyF4MYkqaNk1JXiMCd1unSz1880JiWbOUW
	 S9nbJHbzcob2LcllovdJLuICjkAokI+J1RKY+glWMvCaY+diW1NYn9rfXyvVNVBIfa
	 MDouCeAkOeVpjVegX56j7YUBYCZRUPsAvv+D607QhKBihPmVNWqx7TphFBwryBwrOg
	 ZTv/tsF17GuaLLWOU1wgHkeTA5/X2EspajLm9y1Jv71M3ecboFIBjXDQ3KyC627cq9
	 hgKm47DvF+3TA==
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
Subject: [PATCH v4 13/22] objtool: Refactor elf_add_data() to use a growable data buffer
Date: Sat,  8 Aug 2026 16:17:17 -0700
Message-ID: <3c65abcb71c23d04470f45862523b0363ee4d709.1786230311.git.jpoimboe@kernel.org>
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

Instead of calling elf_newdata() for each new piece of data with its own
separate buffer, keep it all in the same growable buffer so the
section's entire data can be accessed if needed.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/elf.c                 | 123 ++++++++++++++--------------
 tools/objtool/include/objtool/elf.h |  13 ++-
 2 files changed, 71 insertions(+), 65 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index a791f4ea6ec19..8bf225d70d918 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -1147,9 +1147,6 @@ static int read_relocs(struct elf *elf)
 
 		rsec->base->rsec = rsec;
 
-		/* nr_alloc_relocs=0: libelf owns d_buf */
-		rsec->nr_alloc_relocs = 0;
-
 		rsec->relocs = calloc(sec_num_entries(rsec), sizeof(*reloc));
 		if (!rsec->relocs) {
 			ERROR_GLIBC("calloc");
@@ -1408,7 +1405,7 @@ unsigned int elf_add_string(struct elf *elf, struct section *strtab, const char
 
 void *elf_add_data(struct elf *elf, struct section *sec, const void *data, size_t size)
 {
-	unsigned long offset;
+	unsigned long offset, size_old, size_new, alloc_size_old, alloc_size_new;
 	Elf_Scn *s;
 
 	if (!sec->sh.sh_addralign) {
@@ -1422,30 +1419,55 @@ void *elf_add_data(struct elf *elf, struct section *sec, const void *data, size_
 		return NULL;
 	}
 
-	sec->data = elf_newdata(s);
 	if (!sec->data) {
-		ERROR_ELF("elf_newdata");
-		return NULL;
+		sec->data = elf_newdata(s);
+		if (!sec->data) {
+			ERROR_ELF("elf_newdata");
+			return NULL;
+		}
+
+		sec->data->d_align = sec->sh.sh_addralign;
 	}
 
-	sec->data->d_buf = calloc(1, size);
-	if (!sec->data->d_buf) {
-		ERROR_GLIBC("calloc");
-		return NULL;
+	size_old = sec->data->d_size;
+	offset = ALIGN(size_old, sec->sh.sh_addralign);
+	size_new = offset + size;
+
+	if (!sec->data_overallocated)
+		alloc_size_old = size_old;
+	else
+		alloc_size_old = max(64UL, roundup_pow_of_two(size_old ? : 1));
+
+	alloc_size_new = max(64UL, roundup_pow_of_two(size_new ? : 1));
+
+	if (alloc_size_new > alloc_size_old) {
+		void *orig_buf = sec->data->d_buf;
+
+		sec->data->d_buf = calloc(1, alloc_size_new);
+		if (!sec->data->d_buf) {
+			ERROR_GLIBC("calloc");
+			return NULL;
+		}
+
+		if (size_old)
+			memcpy(sec->data->d_buf, orig_buf, size_old);
+
+		if (orig_buf && sec->data_owned)
+			free(orig_buf);
+
+		sec->data_owned = 1;
+		sec->data_overallocated = 1;
 	}
 
 	if (data)
-		memcpy(sec->data->d_buf, data, size);
-
-	sec->data->d_size = size;
-	sec->data->d_align = sec->sh.sh_addralign;
-
-	offset = ALIGN(sec_size(sec), sec->sh.sh_addralign);
-	sec->sh.sh_size = offset + size;
+		memcpy(sec->data->d_buf + offset, data, size);
+	else
+		memset(sec->data->d_buf + offset, 0, size);
 
+	sec->data->d_size = size_new;
+	sec->sh.sh_size = size_new;
 	mark_sec_changed(elf, sec, true);
-
-	return sec->data->d_buf;
+	return sec->data->d_buf + offset;
 }
 
 struct section *elf_create_section(struct elf *elf, const char *name,
@@ -1496,6 +1518,8 @@ struct section *elf_create_section(struct elf *elf, const char *name,
 			ERROR_GLIBC("calloc");
 			return NULL;
 		}
+
+		sec->data_owned = 1;
 	}
 
 	if (!gelf_getshdr(s, &sec->sh)) {
@@ -1546,60 +1570,33 @@ static int elf_alloc_reloc(struct elf *elf, struct section *rsec)
 	struct reloc *old_relocs, *old_relocs_end, *new_relocs;
 	unsigned int nr_relocs_old = sec_num_entries(rsec);
 	unsigned int nr_relocs_new = nr_relocs_old + 1;
-	unsigned long nr_alloc;
+	unsigned long nr_alloc_old = 0, nr_alloc_new;
 	struct symbol *sym;
 
-	if (!rsec->data) {
-		rsec->data = elf_newdata(elf_getscn(elf->elf, rsec->idx));
-		if (!rsec->data) {
-			ERROR_ELF("elf_newdata");
-			return -1;
-		}
+	if (!elf_add_data(elf, rsec, NULL, elf_rela_size(elf)))
+		return -1;
 
-		rsec->data->d_align = 1;
-		rsec->data->d_type = ELF_T_RELA;
-		rsec->data->d_buf = NULL;
-	}
+	rsec->data->d_type = ELF_T_RELA;
 
-	rsec->data->d_size = nr_relocs_new * elf_rela_size(elf);
-	rsec->sh.sh_size   = rsec->data->d_size;
+	if (rsec->relocs_overallocated)
+		nr_alloc_old = max(64UL, roundup_pow_of_two(nr_relocs_old ? : 1));
+	else
+		nr_alloc_old = nr_relocs_old;
 
-	nr_alloc = max(64UL, roundup_pow_of_two(nr_relocs_new));
-	if (nr_alloc <= rsec->nr_alloc_relocs)
+	nr_alloc_new = max(64UL, roundup_pow_of_two(nr_relocs_new ? : 1));
+
+	if (nr_alloc_old == nr_alloc_new)
 		return 0;
 
-	if (rsec->data->d_buf && !rsec->nr_alloc_relocs) {
-		void *orig_buf = rsec->data->d_buf;
-
-		/*
-		 * The original d_buf is owned by libelf so it can't be
-		 * realloced.
-		 */
-		rsec->data->d_buf = malloc(nr_alloc * elf_rela_size(elf));
-		if (!rsec->data->d_buf) {
-			ERROR_GLIBC("malloc");
-			return -1;
-		}
-		memcpy(rsec->data->d_buf, orig_buf,
-		       nr_relocs_old * elf_rela_size(elf));
-	} else {
-		rsec->data->d_buf = realloc(rsec->data->d_buf,
-					    nr_alloc * elf_rela_size(elf));
-		if (!rsec->data->d_buf) {
-			ERROR_GLIBC("realloc");
-			return -1;
-		}
-	}
-
-	rsec->nr_alloc_relocs = nr_alloc;
-
-	old_relocs = rsec->relocs;
-	new_relocs = calloc(nr_alloc, sizeof(struct reloc));
+	new_relocs = calloc(nr_alloc_new, sizeof(struct reloc));
 	if (!new_relocs) {
 		ERROR_GLIBC("calloc");
 		return -1;
 	}
 
+	rsec->relocs_overallocated = 1;
+
+	old_relocs = rsec->relocs;
 	if (!old_relocs)
 		goto done;
 
@@ -1644,6 +1641,7 @@ static int elf_alloc_reloc(struct elf *elf, struct section *rsec)
 	}
 
 	free(old_relocs);
+
 done:
 	rsec->relocs = new_relocs;
 	return 0;
@@ -1673,7 +1671,6 @@ struct section *elf_create_rela_section(struct elf *elf, struct section *sec,
 	if (nr_relocs) {
 		rsec->data->d_type = ELF_T_RELA;
 
-		rsec->nr_alloc_relocs = nr_relocs;
 		rsec->relocs = calloc(nr_relocs, sizeof(struct reloc));
 		if (!rsec->relocs) {
 			ERROR_GLIBC("calloc");
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index a82517a76a0f6..527dd10859de4 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -58,9 +58,18 @@ struct section {
 	Elf_Data *data;
 	const char *name;
 	int idx;
-	bool _changed, text, rodata, noinstr, init, truncate;
+	u32 _changed			: 1,
+	    text			: 1,
+	    rodata			: 1,
+	    noinstr			: 1,
+	    init			: 1,
+	    truncate			: 1,
+	    data_owned			: 1,
+	    data_overallocated		: 1,
+	    relocs_overallocated	: 1;
+	    /* 23 bit hole */
+
 	struct reloc *relocs;
-	unsigned long nr_alloc_relocs;
 	struct section *twin;
 };
 
-- 
2.54.0

