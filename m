Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225D2346E75
	for <live-patching@vger.kernel.org>; Fri, 24 Jul 2026 11:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784893552; cv=none; b=XPbu9nGQ72uURqK7Q6lUjnpqRe/04u7b7fbNRreXtZh+jUulKNgbrjHMYEm1zzxUxJmj8a5L7V81X5rA+PH659u0HlP0xsLJnnZoc6lQGpEQUlZmmRsPE7J6GqA0zMggMrz7GDzh5DrpUjMAr2KZXWfdbPaM+2KgxPaRXUtkLbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784893552; c=relaxed/simple;
	bh=bMdIMN3HQu5vLCUuxN14UQxRrmpE/mPqNXKEvoYv2tA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C4ZHoKtF2ppgfMXkSKp3UvMePi9wcBEkPSDCSFwYqJTn/a4AxZEcPe/7ESoqd5yvV3GJEOgMOx8417azmITmYlqukZBuXiUz4NZflTsaewyrjZoR97A4XK+aojY5GsKAc+Bh6VlAiaL4XuSFvkwHXrpGvdpg1nhRZW7MCdYITU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ak7Lvi6Z; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ak7Lvi6Z"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784893546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LIo2KtyLunyD7pJOq9hd/zxxpBKhcVHigJ3J1NZnnHA=;
	b=ak7Lvi6ZviCnhDVhkWQJVAhooQLajLD1k22QrQZy/zbqs+vgEc0THLZgOWgwNZyL8ciR3Q
	gyJSbMhYMAVzGH2mFuGXiA7+KBq3eIHJBPx1dJeiz6sR3YiGUpfPh+yQjL0kQmA9e0cal4
	2HEWi5X3eZhP005mtgIC2SpCRmUJJw0=
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
	wangrui@loongson.cn,
	liukexin@kylinos.cn,
	guodongtai@kylinos.cn,
	xry111@xry111.site,
	wangyuli@aosc.io,
	loongarch@lists.linux.dev,
	live-patching@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 14/14] objtool/klp: Rewrite PC-relative data references to GOT on LoongArch
Date: Fri, 24 Jul 2026 19:41:27 +0800
Message-ID: <20260724114128.31451-15-dongtai.guo@linux.dev>
In-Reply-To: <20260724114128.31451-1-dongtai.guo@linux.dev>
References: <20260724114128.31451-1-dongtai.guo@linux.dev>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: George Guo <guodongtai@kylinos.cn>

A livepatch module is mapped far more than the +-2GB reachable by a
pcalau12i/addi.d pair, so a klp relocation that resolves to a symbol in
vmlinux cannot be reached PC-relatively: the relocation overflows and
the patched function computes a wild pointer.  Far calls are already
handled by the module loader, which redirects them through a PLT stub,
but there is no such indirection for data, whose address is
materialized inline.

Compilers emit the direct PC-relative form for any symbol they consider
local.  In particular file-local 'static' data is never interposable, so
-fPIC does not route it through the GOT.  This is correct for vmlinux and
for ordinary modules; it only breaks once klp-diff extracts the function
into the far livepatch module while its data stays behind.  It is not
Clang-specific: GCC emits the same PC-relative form.

Add an arch hook, arch_klp_convert_reloc_to_got(), invoked when a klp
relocation is created, and implement it for LoongArch: rewrite the
reference to its GOT-indirect equivalent, which loads the full 64-bit
address from a GOT slot the module loader fills in:

	pcalau12i rd, %pc_hi20(sym)      ->  pcalau12i rd, %got_pc_hi20(sym)
	addi.d    rd, rj, %pc_lo12(sym)  ->  ld.d      rd, rj, %got_pc_lo12(sym)

The loader already sizes the module GOT from every SHT_RELA section that
targets executable code, including .klp.rela.*, so the slot is reserved
at load time and filled when the patch is enabled.

Only an adjacent, register-consistent pcalau12i/addi.d pair that
materializes an address can be converted.  A PCALA_LO12 on any other
instruction is a load or store that reads the symbol directly; going
through the GOT there needs an extra instruction to dereference the
slot, and the function cannot grow without shifting every offset,
relocation and ORC entry.  A pcalau12i shared by several addi.d with
different addends would likewise need one GOT slot per addend, which a
single GOT_PC_HI20 cannot express.  Reject both rather than emit a
livepatch that is quietly broken.

The LoongArch decoder in tools/ lacks the reg1i20 instruction format
used to identify pcalau12i; add it to the tools/ copy of asm/inst.h.

Reproduced by a livepatch for proc_pid_status() (the shadow-newpid
test), which reads the file-local task_state_array[].

Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 tools/arch/loongarch/include/asm/inst.h       |  11 ++
 tools/objtool/arch/loongarch/decode.c         | 104 ++++++++++++++++++
 .../objtool/arch/loongarch/include/arch/elf.h |  16 +++
 tools/objtool/klp-diff.c                      |  23 +++-
 4 files changed, 152 insertions(+), 2 deletions(-)

diff --git a/tools/arch/loongarch/include/asm/inst.h b/tools/arch/loongarch/include/asm/inst.h
index d68fad63c8b7..0d4caa6522f1 100644
--- a/tools/arch/loongarch/include/asm/inst.h
+++ b/tools/arch/loongarch/include/asm/inst.h
@@ -25,6 +25,10 @@ enum reg1i21_op {
 	bcnez_op	= 0x12, /* bits[9:8] = 0x01 */
 };
 
+enum reg1i20_op {
+	pcalau12i_op	= 0x0d,
+};
+
 enum reg2_op {
 	ertn_op		= 0x1920e,
 };
@@ -66,6 +70,12 @@ struct reg0i26_format {
 	unsigned int opcode : 6;
 };
 
+struct reg1i20_format {
+	unsigned int rd : 5;
+	unsigned int immediate : 20;
+	unsigned int opcode : 7;
+};
+
 struct reg1i21_format {
 	unsigned int immediate_h  : 5;
 	unsigned int rj : 5;
@@ -111,6 +121,7 @@ union loongarch_instruction {
 	unsigned int word;
 	struct reg0i15_format	reg0i15_format;
 	struct reg0i26_format	reg0i26_format;
+	struct reg1i20_format	reg1i20_format;
 	struct reg1i21_format	reg1i21_format;
 	struct reg2_format	reg2_format;
 	struct reg2i12_format	reg2i12_format;
diff --git a/tools/objtool/arch/loongarch/decode.c b/tools/objtool/arch/loongarch/decode.c
index 273398ea4486..99765b13058c 100644
--- a/tools/objtool/arch/loongarch/decode.c
+++ b/tools/objtool/arch/loongarch/decode.c
@@ -101,6 +101,110 @@ int arch_normalize_paired_reloc(struct elf *elf, struct reloc *reloc)
 	return 0;
 }
 
+static bool klp_read_insn(struct section *sec, unsigned long offset,
+			  union loongarch_instruction *insn)
+{
+	if (offset + sizeof(*insn) > sec_size(sec))
+		return false;
+
+	memcpy(insn, sec->data->d_buf + offset, sizeof(*insn));
+	return true;
+}
+
+/*
+ * A livepatch module is mapped far more than the +-2GB reachable by
+ * pcalau12i/addi.d, so a klp reloc which resolves to a symbol in vmlinux cannot
+ * be reached PC-relatively: the relocation overflows and the patched function
+ * computes a wild pointer.  Far calls are already handled by the module loader,
+ * which redirects them through a PLT stub, but there is no such indirection for
+ * data: the address is materialized inline.
+ *
+ * Compilers emit the direct PC-relative form for any symbol they consider local
+ * (in particular file-local 'static' data, which is never interposable, so
+ * -fPIC does not route it through the GOT).  This is correct for vmlinux and
+ * for ordinary modules; it only breaks once klp-diff extracts the function into
+ * a far away livepatch module while its data stays behind.
+ *
+ * Convert the reference to its GOT-indirect equivalent, which loads the full
+ * 64-bit address from a GOT slot the module loader fills in and so works at any
+ * distance:
+ *
+ *	pcalau12i rd, %pc_hi20(sym)	->  pcalau12i rd, %got_pc_hi20(sym)
+ *	addi.d    rd, rj, %pc_lo12(sym)	->  ld.d      rd, rj, %got_pc_lo12(sym)
+ *
+ * Only an adjacent pcalau12i/addi.d pair which materializes an address can be
+ * converted, and only that exact shape is accepted:
+ *
+ *  - A PCALA_LO12 on anything but addi.d is a load or store reading the symbol
+ *    directly.  Going through the GOT would need an extra instruction to
+ *    dereference the slot, and the function cannot grow without shifting every
+ *    offset, relocation and ORC entry.
+ *
+ *  - The pair must be adjacent and register-consistent.  If one pcalau12i is
+ *    shared by several addi.d with different addends, each needs its own GOT
+ *    slot, but the single GOT_PC_HI20 only spans one page: the result would be
+ *    correct only if those slots happened to share a page.  Requiring
+ *    adjacency rejects that (the second addi.d is not preceded by a pcalau12i),
+ *    as well as a pair the compiler scheduled apart.
+ *
+ * Bail out on anything else instead of emitting a livepatch which is quietly
+ * broken.
+ */
+int arch_klp_convert_reloc_to_got(struct elf *elf, struct section *sec,
+				  unsigned long offset, unsigned int *type)
+{
+	union loongarch_instruction hi, lo;
+	unsigned long hi_offset, lo_offset;
+
+	switch (*type) {
+	case R_LARCH_PCALA_HI20:
+		hi_offset = offset;
+		lo_offset = offset + LOONGARCH_INSN_SIZE;
+		break;
+
+	case R_LARCH_PCALA_LO12:
+		if (offset < LOONGARCH_INSN_SIZE) {
+			ERROR("%s+0x%lx: PCALA_LO12 with no preceding instruction",
+			      sec->name, offset);
+			return -1;
+		}
+		hi_offset = offset - LOONGARCH_INSN_SIZE;
+		lo_offset = offset;
+		break;
+
+	default:
+		return 0;
+	}
+
+	if (!klp_read_insn(sec, hi_offset, &hi) ||
+	    !klp_read_insn(sec, lo_offset, &lo)) {
+		ERROR("%s+0x%lx: PCALA pair runs past end of section",
+		      sec->name, offset);
+		return -1;
+	}
+
+	if (hi.reg1i20_format.opcode != pcalau12i_op ||
+	    lo.reg2i12_format.opcode != addid_op ||
+	    lo.reg2i12_format.rj != hi.reg1i20_format.rd) {
+		ERROR("%s+0x%lx: cannot make klp reference GOT-indirect: expected an adjacent pcalau12i/addi.d pair, found 0x%08x/0x%08x",
+		      sec->name, offset, hi.word, lo.word);
+		return -1;
+	}
+
+	if (*type == R_LARCH_PCALA_HI20) {
+		*type = R_LARCH_GOT_PC_HI20;
+		return 0;
+	}
+
+	/* addi.d rd, rj, %pc_lo12(sym) -> ld.d rd, rj, %got_pc_lo12(sym) */
+	lo.reg2i12_format.opcode = ldd_op;
+	if (elf_write_insn(elf, sec, lo_offset, sizeof(lo), (const char *)&lo))
+		return -1;
+
+	*type = R_LARCH_GOT_PC_LO12;
+	return 0;
+}
+
 bool arch_pc_relative_reloc(struct reloc *reloc)
 {
 	return false;
diff --git a/tools/objtool/arch/loongarch/include/arch/elf.h b/tools/objtool/arch/loongarch/include/arch/elf.h
index e2843679f24e..7a97cf69dc86 100644
--- a/tools/objtool/arch/loongarch/include/arch/elf.h
+++ b/tools/objtool/arch/loongarch/include/arch/elf.h
@@ -27,6 +27,18 @@
 #ifndef R_LARCH_SUB64
 #define R_LARCH_SUB64		56
 #endif
+#ifndef R_LARCH_PCALA_HI20
+#define R_LARCH_PCALA_HI20	71
+#endif
+#ifndef R_LARCH_PCALA_LO12
+#define R_LARCH_PCALA_LO12	72
+#endif
+#ifndef R_LARCH_GOT_PC_HI20
+#define R_LARCH_GOT_PC_HI20	75
+#endif
+#ifndef R_LARCH_GOT_PC_LO12
+#define R_LARCH_GOT_PC_LO12	76
+#endif
 #ifndef R_LARCH_32_PCREL
 #define R_LARCH_32_PCREL	99
 #endif
@@ -48,9 +60,13 @@
 
 #define ARCH_HAS_INLINE_ALTS	1
 #define ARCH_HAS_PAIRED_RELOCS	1
+#define ARCH_HAS_KLP_GOT_RELOCS	1
 
 struct elf;
 struct reloc;
+struct section;
 int arch_normalize_paired_reloc(struct elf *elf, struct reloc *reloc);
+int arch_klp_convert_reloc_to_got(struct elf *elf, struct section *sec,
+				  unsigned long offset, unsigned int *type);
 
 #endif /* _OBJTOOL_ARCH_ELF_H */
diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
index f151ffc71184..1538f8f92f1f 100644
--- a/tools/objtool/klp-diff.c
+++ b/tools/objtool/klp-diff.c
@@ -1525,6 +1525,14 @@ static inline int arch_normalize_paired_reloc(struct elf *elf, struct reloc *rel
 }
 #endif
 
+#ifndef ARCH_HAS_KLP_GOT_RELOCS
+static inline int arch_klp_convert_reloc_to_got(struct elf *elf, struct section *sec,
+						unsigned long offset, unsigned int *type)
+{
+	return 0;
+}
+#endif
+
 /*
  * Convert a relocation symbol reference to the needed format: either a section
  * symbol or the underlying symbol itself.  Return -1 error, 0 success, 1 skip.
@@ -1565,12 +1573,23 @@ static int clone_reloc_klp(struct elfs *e, struct reloc *patched_reloc,
 	char sym_name[SYM_NAME_LEN];
 	struct klp_reloc klp_reloc;
 	unsigned long sympos;
+	unsigned int type;
 
 	if (!patched_sym->twin) {
 		ERROR("unexpected klp reloc for new symbol %s", patched_sym->name);
 		return -1;
 	}
 
+	/*
+	 * This reference resolves to a symbol which stays in the patched
+	 * object, arbitrarily far from the livepatch module.  Give the arch a
+	 * chance to convert a PC-relative reference into an indirect one which
+	 * can reach it (LoongArch: PCALA -> GOT).
+	 */
+	type = reloc_type(patched_reloc);
+	if (arch_klp_convert_reloc_to_got(e->out, sec, offset, &type))
+		return -1;
+
 	/*
 	 * Keep the original reloc intact for now to avoid breaking objtool run
 	 * which relies on proper relocations for many of its features.  This
@@ -1591,7 +1610,7 @@ static int clone_reloc_klp(struct elfs *e, struct reloc *patched_reloc,
 		sym->clone = patched_sym;
 	}
 
-	if (!elf_create_reloc(e->out, sec, offset, sym, addend, reloc_type(patched_reloc)))
+	if (!elf_create_reloc(e->out, sec, offset, sym, addend, type))
 		return -1;
 
 	/*
@@ -1648,7 +1667,7 @@ static int clone_reloc_klp(struct elfs *e, struct reloc *patched_reloc,
 	klp_reloc_off = sec_size(klp_relocs);
 	memset(&klp_reloc, 0, sizeof(klp_reloc));
 
-	klp_reloc.type = reloc_type(patched_reloc);
+	klp_reloc.type = type;
 	if (!elf_add_data(e->out, klp_relocs, &klp_reloc, sizeof(klp_reloc), true))
 		return -1;
 
-- 
2.53.0

