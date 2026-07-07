Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5292B414DCC
	for <live-patching@vger.kernel.org>; Tue,  7 Jul 2026 07:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783409033; cv=none; b=qKCgpq0ZMZ9SYKUMttCiFyWtJOgaXDntEFndNG6YKRC21EJlQwIyQW310wWdFEZWOPlIH8nmYEmVxG/6JczIiGkFVT8xRXmRDfDs10NMS2gpONla3RC9C1ed5w6+WiWgcRDWbzGb9JhMYa/MSt/XZ3kaFedFTjR6g6/RaOdMKYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783409033; c=relaxed/simple;
	bh=4xpsKQT0sIXN8YfZqyI5uDhGSFAUCUDLKrsALoCftLI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T09T3ijs7IHdGOrerBkYKOmcjvMr4YrOX2QWRQq5UNF7nlWGLebow1g939s54wdiS4/LC6SmPtQntcxtWZOaRrK7+3jxpQ6weJADVqxd/pVgs4zEf8i58k2Dhh1ot4SHd73stW0Rc70Q2Qkhhiy2GtQRXkY/0g/qkXSfbd2MagE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=l/gsU6+/; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="l/gsU6+/"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783409024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9FJ2LdWpihcFZMdGQ2dBam2UiMhzklP1ri1WDx8T5rI=;
	b=l/gsU6+/SC0eCHB4Jdda35a+zuTvRw4uiCZQKeo4brLFpug/LxSNHtwJdPqiSf4YeUfgPw
	pG6LMIAxR0k91NzvxZtXgtMwNPvfare5fgH/AVWZrN/5ahEfhUe9C/IW8yXe7qDBoWerkl
	H3k8LJdzQt03xjnt4PdVg27J84VnX68=
From: George Guo <dongtai.guo@linux.dev>
To: chenhuacai@kernel.org,
	jpoimboe@kernel.org,
	peterz@infradead.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com
Cc: kernel@xen0n.name,
	joe.lawrence@redhat.com,
	rostedt@goodmis.org,
	ardb@kernel.org,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	yangtiezhu@loongson.cn,
	jiaxun.yang@flygoat.com,
	liukexin@kylinos.cn,
	guodongtai@kylinos.cn,
	xry111@xry111.site,
	wangyuli@aosc.io,
	loongarch@lists.linux.dev,
	live-patching@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 12/12] objtool/klp: Fold LoongArch paired ADD/SUB relocations into PCREL
Date: Tue,  7 Jul 2026 15:20:31 +0800
Message-Id: <20260707072031.231066-13-dongtai.guo@linux.dev>
In-Reply-To: <20260707072031.231066-1-dongtai.guo@linux.dev>
References: <20260707072031.231066-1-dongtai.guo@linux.dev>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: George Guo <guodongtai@kylinos.cn>

On LoongArch, the "key - ." field of a __jump_table entry can come out
as two relocations at the same offset, R_LARCH_ADD64 plus
R_LARCH_SUB64.  clang's integrated assembler emits this pair when the
key symbol is not defined in the same translation unit (for example
__tracepoint_netif_rx); GAS, and clang for locally-defined keys,
produce a single R_LARCH_64_PCREL instead, which is why GCC builds do
not hit this.  objtool's elf_create_reloc() allows only one relocation
per offset, so cloning such an entry fails with:

  vmlinux.o: error: objtool: __jump_table_23683+0x8: duplicate reloc

When the SUB half points at the relocation's own position (the
"sym - ." pattern), the pair means the same thing as one PC-relative
relocation.  Add arch_normalize_paired_reloc() which rewrites the ADD
half to R_LARCH_32_PCREL/R_LARCH_64_PCREL and skips the SUB half.  The
LoongArch module loader supports both forms.

Reported-by: Joe Lawrence <joe.lawrence@redhat.com>
Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 tools/objtool/arch/loongarch/decode.c         | 62 +++++++++++++++++++
 .../objtool/arch/loongarch/include/arch/elf.h | 18 ++++++
 tools/objtool/klp-diff.c                      | 13 ++++
 3 files changed, 93 insertions(+)

diff --git a/tools/objtool/arch/loongarch/decode.c b/tools/objtool/arch/loongarch/decode.c
index 12facd0cc8d1..273398ea4486 100644
--- a/tools/objtool/arch/loongarch/decode.c
+++ b/tools/objtool/arch/loongarch/decode.c
@@ -39,6 +39,68 @@ u64 arch_adjusted_addend(struct reloc *reloc)
 	return reloc_addend(reloc);
 }
 
+/*
+ * A cross-section difference like the "key - ." field of a __jump_table
+ * entry may come out as a paired R_LARCH_ADD plus R_LARCH_SUB relocation
+ * at the same offset: clang's integrated assembler does this when the
+ * symbol is not defined in the same translation unit (GAS, and clang for
+ * locally-defined symbols, emit a single PCREL instead).  objtool allows
+ * only one relocation per offset, so the pair breaks cloning.
+ *
+ * When the SUB half points at the reloc's own position ("sym - ."), the
+ * pair means the same as a single PC-relative relocation, which the
+ * module loader also supports: rewrite the ADD half to R_LARCH_*_PCREL
+ * and tell the caller to skip the SUB half.
+ *
+ * Return 1 to skip the reloc, 0 to proceed, -1 on error.
+ */
+int arch_normalize_paired_reloc(struct elf *elf, struct reloc *reloc)
+{
+	struct section *rsec = reloc->sec;
+	unsigned int sub_type, pcrel_type;
+	struct reloc *sub, *add;
+
+	switch (reloc_type(reloc)) {
+	case R_LARCH_ADD32:
+		sub_type = R_LARCH_SUB32;
+		pcrel_type = R_LARCH_32_PCREL;
+		break;
+	case R_LARCH_ADD64:
+		sub_type = R_LARCH_SUB64;
+		pcrel_type = R_LARCH_64_PCREL;
+		break;
+	case R_LARCH_SUB32:
+	case R_LARCH_SUB64:
+		/*
+		 * Skip only if the paired ADD (the preceding reloc) has
+		 * been rewritten to PCREL; otherwise leave the pair
+		 * intact so a failed conversion stays loud.
+		 */
+		add = reloc_idx(reloc) ? reloc - 1 : NULL;
+		if (add && reloc_offset(add) == reloc_offset(reloc) &&
+		    (reloc_type(add) == R_LARCH_32_PCREL ||
+		     reloc_type(add) == R_LARCH_64_PCREL))
+			return 1;
+		return 0;
+	default:
+		return 0;
+	}
+
+	/* The paired SUB reloc immediately follows the ADD */
+	sub = rsec_next_reloc(rsec, reloc);
+	if (!sub || reloc_offset(sub) != reloc_offset(reloc) ||
+	    reloc_type(sub) != sub_type)
+		return 0;
+
+	/* Only a "sym - ." difference is PC-relative */
+	if (sub->sym->sec != rsec->base ||
+	    sub->sym->offset + reloc_addend(sub) != reloc_offset(sub))
+		return 0;
+
+	set_reloc_type(elf, reloc, pcrel_type);
+	return 0;
+}
+
 bool arch_pc_relative_reloc(struct reloc *reloc)
 {
 	return false;
diff --git a/tools/objtool/arch/loongarch/include/arch/elf.h b/tools/objtool/arch/loongarch/include/arch/elf.h
index ec79062c9554..0103f27fccfc 100644
--- a/tools/objtool/arch/loongarch/include/arch/elf.h
+++ b/tools/objtool/arch/loongarch/include/arch/elf.h
@@ -15,6 +15,18 @@
 #ifndef R_LARCH_64
 #define R_LARCH_64		2
 #endif
+#ifndef R_LARCH_ADD32
+#define R_LARCH_ADD32		50
+#endif
+#ifndef R_LARCH_ADD64
+#define R_LARCH_ADD64		51
+#endif
+#ifndef R_LARCH_SUB32
+#define R_LARCH_SUB32		55
+#endif
+#ifndef R_LARCH_SUB64
+#define R_LARCH_SUB64		56
+#endif
 #ifndef R_LARCH_32_PCREL
 #define R_LARCH_32_PCREL	99
 #endif
@@ -34,4 +46,10 @@
 #define R_TEXT32		R_LARCH_32_PCREL
 #define R_TEXT64		R_LARCH_32_PCREL
 
+#define ARCH_HAS_PAIRED_RELOCS	1
+
+struct elf;
+struct reloc;
+int arch_normalize_paired_reloc(struct elf *elf, struct reloc *reloc);
+
 #endif /* _OBJTOOL_ARCH_ELF_H */
diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
index 0fa3ce324346..02b2150e3ca3 100644
--- a/tools/objtool/klp-diff.c
+++ b/tools/objtool/klp-diff.c
@@ -1504,6 +1504,13 @@ static bool is_uncorrelated_section(struct section *sec)
 	       strstarts(sec->name, ".data..Lanon.");		/* Clang */
 }
 
+#ifndef ARCH_HAS_PAIRED_RELOCS
+static inline int arch_normalize_paired_reloc(struct elf *elf, struct reloc *reloc)
+{
+	return 0;
+}
+#endif
+
 /*
  * Convert a relocation symbol reference to the needed format: either a section
  * symbol or the underlying symbol itself.  Return -1 error, 0 success, 1 skip.
@@ -1511,10 +1518,16 @@ static bool is_uncorrelated_section(struct section *sec)
 static int convert_reloc_sym(struct elf *elf, struct reloc *reloc)
 {
 	struct section *sec = reloc->sym->sec;
+	int ret;
 
 	if (reloc_type(reloc) == R_NONE)
 		return 1;
 
+	/* Fold paired ADD/SUB relocs (LoongArch) into a single PCREL */
+	ret = arch_normalize_paired_reloc(elf, reloc);
+	if (ret)
+		return ret;
+
 	if (is_uncorrelated_section(sec))
 		return convert_reloc_sym_to_secsym(elf, reloc);
 
-- 
2.25.1

