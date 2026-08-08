Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302A9383328;
	Sat,  8 Aug 2026 23:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786231122; cv=none; b=FR5WzPkrXLno+DpbLNvDcZbXaln/Sr+1oaqzexSG1xcIlfup+/BQnPEf0gRoAr7JlI6NKSI4I5zWs9nHJUDjpCQfTozfddaAKyE0x7t4oCi9xGM2lpsABm9HsZlFSPl9AU9oGCNfY60hV2LU9eOPXSY+LExCjoez9p79/kle3Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786231122; c=relaxed/simple;
	bh=ag1m3lcDBWO1fL1wjntRXLz6wu95d7NPU1kqiURfeJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HbeqXvweCo7RDW4eI2qU0/RGgnDdOeW6s7Phuxj6CoySs9s36Xmf+TyQlfSGXYFllWxjKBexrdicSy6fGHbZi1K7I5iCIyz3QgXfH5NI72xvtXvYFg5gLgnpU7ySgaE5+bewkn6k1JtLGmrBCaV/bVt7MqLQQiJgCQGfR8prcRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=orXOKo9q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="orXOKo9q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 873B11F000E9;
	Sat,  8 Aug 2026 23:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786231117;
	bh=11okBX/oyddYUFhNnABa0TgcLV3f69gdODt8HzLMfH4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=orXOKo9qjPR4tUoRyS5GrhezG1fuSJkv0VWZxXK9NjhMCbP/DU0ccXupgX1G8cm24
	 AShdnfnt9F2eQZVGq6xMXVfMBw1O8wGr9VUq2XozBYzabR66Y1XURLcWIyq61e5Hsp
	 UOSolX1rPDFgJG/DjdHfIq9zcHORTqMRG27ljFDlBj6msHvV67Puusl9UlhvzyPhcI
	 okqJ69D9WSbO5mwshpN9zfhvdhGJEO/VF0q2bq+76foiOdehXLkEMP6ovj/5g8rpgW
	 lXE2QpQHy1lYYy7QtycuIOGMxuDbsZgw/KNeTy0Quh3itRAM7Pnh+Affq0wxR/Eyew
	 EbODE/gG8+MTA==
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
Subject: [PATCH v4 14/22] objtool: Reuse string references
Date: Sat,  8 Aug 2026 16:17:18 -0700
Message-ID: <e0856be4208a6bed2b22dffe2bf8e010470f49cf.1786230311.git.jpoimboe@kernel.org>
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

For duplicate strings, elf_add_string() just blindly adds duplicates.

That can be a problem for arm64 which often uses two consecutive
instructions (and corresponding relocations) to put an address into a
register, like:

  d8:   90000001        adrp    x1, 0 <meminfo_proc_show>       d8: R_AARCH64_ADR_PREL_PG_HI21  .rodata.meminfo_proc_show.str1.8
  dc:   91000021        add     x1, x1, #0x0    dc: R_AARCH64_ADD_ABS_LO12_NC   .rodata.meminfo_proc_show.str1.8

Referencing two different addresses in the ADRP+ADD pair would corrupt
the memory access.  Avoid that by detecting and reusing duplicates when
cloning string relocs.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/elf.c                 | 29 +++++++++++++++++++++++------
 tools/objtool/include/objtool/elf.h |  3 ++-
 tools/objtool/klp-diff.c            |  4 +++-
 3 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 8bf225d70d918..3bb04d6155a8b 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -1379,9 +1379,27 @@ struct elf *elf_create_file(GElf_Ehdr *ehdr, const char *name)
 	return elf;
 }
 
-unsigned int elf_add_string(struct elf *elf, struct section *strtab, const char *str)
+int elf_find_string(struct elf *elf, struct section *strtab, const char *str)
 {
-	unsigned int offset;
+	char *d_buf;
+	int i;
+
+	if (!strtab->data)
+		return -1;
+
+	d_buf = strtab->data->d_buf;
+
+	for (i = 0; i < strtab->data->d_size; i += strlen(d_buf + i) + 1) {
+		if (!strcmp(d_buf + i, str))
+			return i;
+	}
+
+	return -1;
+}
+
+int elf_add_string(struct elf *elf, struct section *strtab, const char *str)
+{
+	void *data;
 
 	if (!strtab)
 		strtab = find_section_by_name(elf, ".strtab");
@@ -1395,12 +1413,11 @@ unsigned int elf_add_string(struct elf *elf, struct section *strtab, const char
 		return -1;
 	}
 
-	offset = ALIGN(sec_size(strtab), strtab->sh.sh_addralign);
-
-	if (!elf_add_data(elf, strtab, str, strlen(str) + 1))
+	data = elf_add_data(elf, strtab, str, strlen(str) + 1);
+	if (!data)
 		return -1;
 
-	return offset;
+	return data - strtab->data->d_buf;
 }
 
 void *elf_add_data(struct elf *elf, struct section *sec, const void *data, size_t size)
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index 527dd10859de4..5cba96c6392cb 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -188,7 +188,8 @@ struct symbol *elf_create_section_symbol(struct elf *elf, struct section *sec);
 void *elf_add_data(struct elf *elf, struct section *sec, const void *data,
 		   size_t size);
 
-unsigned int elf_add_string(struct elf *elf, struct section *strtab, const char *str);
+int elf_find_string(struct elf *elf, struct section *strtab, const char *str);
+int elf_add_string(struct elf *elf, struct section *strtab, const char *str);
 
 struct reloc *elf_create_reloc(struct elf *elf, struct section *sec,
 			       unsigned long offset, struct symbol *sym,
diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
index 19dcf930a562b..446ea6f9864a1 100644
--- a/tools/objtool/klp-diff.c
+++ b/tools/objtool/klp-diff.c
@@ -1543,7 +1543,9 @@ static int clone_reloc(struct elfs *e, struct reloc *patched_reloc,
 
 		__dbg_clone("\"%s\"", escape_str(str));
 
-		addend = elf_add_string(e->out, out_sym->sec, str);
+		addend = elf_find_string(e->out, out_sym->sec, str);
+		if (addend == -1)
+			addend = elf_add_string(e->out, out_sym->sec, str);
 		if (addend == -1)
 			return -1;
 	}
-- 
2.54.0

