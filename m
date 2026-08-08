Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEA938238D;
	Sat,  8 Aug 2026 23:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786231113; cv=none; b=ViQxh/OqneH9ubiTP48YPQdbFGYSNc2pZw7bqctp90UA2DDF7+IDH23eNF6+PWhcY1hsNg5RlKw0VG5wMakAbm+WLR46gO8KHwTExEwx1qiG3/gyrrwSBnymuvubA587ix0srB58KDuyfrEFQFQe2gZrrIMqLAw54NX1meb5LLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786231113; c=relaxed/simple;
	bh=tOlz2teR2/J3TcdGSaCgdqG4nkAkpQxOqtEGc0KXXZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UhRqMfkmb01oxEzx2RgOrqR4o1s6L2+TlDpYCeoAfIhiZ7Ggz8/4HF9L4a/VqLJte4PdtWTOQKOPS6Ge218io08WmdSh1od48pDhNR0NxC2bzxXRS7TK0/jFojO7aQhHcvz4wr8wi+TQJyHGk1/hY+OplVIONRjF69uHGtYoZhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CjRtSu0U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CjRtSu0U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53AB31F00A3D;
	Sat,  8 Aug 2026 23:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786231111;
	bh=+2GPJTuBqAhwT7SdumyJDjy2VYWy7AtImOE6f1ugQ5U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CjRtSu0UVSLtNJT5CfBJd/qoE0TRbhXLrzIL9m0xdFfmwtB70ndU2eoG6sOxPTL2v
	 Gb1lvopN2qmS1pAl9GcTCue7Umbatz9lmRa1yf/EEuKqcCTBZMEGp345A041tbSjAP
	 DRRSdJ3zkukA8FZWEfjb/v2mk3f6tTPJMc4SxHOgxhi55czcIHDt8g39p1wTMuE5Cg
	 +G2rRucj2pnJDzp7uoWC4mhcKZFuYmjHZ2/RhLJekms4C8Vte1oEmCViTbdkZz1daA
	 RGZV9LL79awuNfQdmcdR2w8vAVaUKfyqhwe61c0K17sumHdbwrME9uLjeuhO43TCQ0
	 VLPGG97gyWEIA==
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
Subject: [PATCH v4 07/22] arm64: Annotate special section entries
Date: Sat,  8 Aug 2026 16:17:11 -0700
Message-ID: <ebc618f0e607903af13e881c71f6114e3c6ab479.1786230311.git.jpoimboe@kernel.org>
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

In preparation for adding arm64 support for "objtool klp checksum/diff"
to enable livepatch module generation, annotate special section entries.

This will allow objtool to determine the size and location of the
entries and to extract them when needed.

A new ANNOTATE_DATA_SPECIAL_END annotation is added to mark the end of
special data blocks, which is needed because arm64's replacement
instructions are emitted in .text rather than .altinstr_replacement, so
there's otherwise no way to determine where the last replacement block
ends.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/arm64/include/asm/alternative-macros.h | 27 ++++++++++++++++-----
 arch/arm64/include/asm/asm-bug.h            |  2 ++
 arch/arm64/include/asm/asm-extable.h        | 21 ++++++++++------
 arch/arm64/include/asm/jump_label.h         |  2 ++
 arch/arm64/kernel/asm-offsets.c             |  5 ++++
 include/linux/annotate.h                    | 14 ++++++++++-
 include/linux/objtool_types.h               |  1 +
 tools/include/linux/objtool_types.h         |  1 +
 tools/objtool/klp-diff.c                    |  5 +++-
 9 files changed, 62 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/include/asm/alternative-macros.h b/arch/arm64/include/asm/alternative-macros.h
index 8624166248528..ba86d655af1d7 100644
--- a/arch/arm64/include/asm/alternative-macros.h
+++ b/arch/arm64/include/asm/alternative-macros.h
@@ -3,11 +3,16 @@
 #define __ASM_ALTERNATIVE_MACROS_H
 
 #include <linux/const.h>
+#include <linux/annotate.h>
 #include <vdso/bits.h>
 
 #include <asm/cpucaps.h>
 #include <asm/insn-def.h>
 
+#ifndef COMPILE_OFFSETS
+#include <asm/asm-offsets.h>
+#endif
+
 /*
  * Binutils 2.27.0 can't handle a 'UL' suffix on constants, so for the assembly
  * macros below we must use we must use `(1 << ARM64_CB_SHIFT)`.
@@ -58,15 +63,18 @@
 	"661:\n\t"							\
 	oldinstr "\n"							\
 	"662:\n"							\
-	".pushsection .altinstructions,\"a\"\n"				\
+	".pushsection .altinstructions,\"aM\", @progbits, "		\
+		      __stringify(ALT_INSTR_SIZE) "\n"			\
 	ALTINSTR_ENTRY(cpucap)						\
 	".popsection\n"							\
 	".subsection 1\n"						\
+	ANNOTATE_DATA_SPECIAL "\n"					\
 	"663:\n\t"							\
 	newinstr "\n"							\
 	"664:\n\t"							\
 	".org	. - (664b-663b) + (662b-661b)\n\t"			\
 	".org	. - (662b-661b) + (664b-663b)\n\t"			\
+	ANNOTATE_DATA_SPECIAL_END "\n\t"					\
 	".previous\n"							\
 	".endif\n"
 
@@ -75,7 +83,8 @@
 	"661:\n\t"							\
 	oldinstr "\n"							\
 	"662:\n"							\
-	".pushsection .altinstructions,\"a\"\n"				\
+	".pushsection .altinstructions,\"aM\", @progbits, "		\
+		      __stringify(ALT_INSTR_SIZE) "\n"			\
 	ALTINSTR_ENTRY_CB(cpucap, cb)					\
 	".popsection\n"							\
 	"663:\n\t"							\
@@ -102,13 +111,15 @@
 .macro alternative_insn insn1, insn2, cap, enable = 1
 	.if \enable
 661:	\insn1
-662:	.pushsection .altinstructions, "a"
+662:	.pushsection .altinstructions, "aM", @progbits, ALT_INSTR_SIZE
 	altinstruction_entry 661b, 663f, \cap, 662b-661b, 664f-663f
 	.popsection
 	.subsection 1
+	ANNOTATE_DATA_SPECIAL
 663:	\insn2
 664:	.org	. - (664b-663b) + (662b-661b)
 	.org	. - (662b-661b) + (664b-663b)
+	ANNOTATE_DATA_SPECIAL_END
 	.previous
 	.endif
 .endm
@@ -137,7 +148,7 @@
  */
 .macro alternative_if_not cap
 	.set .Lasm_alt_mode, 0
-	.pushsection .altinstructions, "a"
+	.pushsection .altinstructions, "aM", @progbits, ALT_INSTR_SIZE
 	altinstruction_entry 661f, 663f, \cap, 662f-661f, 664f-663f
 	.popsection
 661:
@@ -145,17 +156,18 @@
 
 .macro alternative_if cap
 	.set .Lasm_alt_mode, 1
-	.pushsection .altinstructions, "a"
+	.pushsection .altinstructions, "aM", @progbits, ALT_INSTR_SIZE
 	altinstruction_entry 663f, 661f, \cap, 664f-663f, 662f-661f
 	.popsection
 	.subsection 1
 	.align 2	/* So GAS knows label 661 is suitably aligned */
+	ANNOTATE_DATA_SPECIAL
 661:
 .endm
 
 .macro alternative_cb cap, cb
 	.set .Lasm_alt_mode, 0
-	.pushsection .altinstructions, "a"
+	.pushsection .altinstructions, "aM", @progbits, ALT_INSTR_SIZE
 	altinstruction_entry 661f, \cb, (1 << ARM64_CB_SHIFT) | \cap, 662f-661f, 0
 	.popsection
 661:
@@ -168,7 +180,9 @@
 662:
 	.if .Lasm_alt_mode==0
 	.subsection 1
+	ANNOTATE_DATA_SPECIAL
 	.else
+	ANNOTATE_DATA_SPECIAL_END
 	.previous
 	.endif
 663:
@@ -182,6 +196,7 @@
 	.org	. - (664b-663b) + (662b-661b)
 	.org	. - (662b-661b) + (664b-663b)
 	.if .Lasm_alt_mode==0
+	ANNOTATE_DATA_SPECIAL_END
 	.previous
 	.endif
 .endm
diff --git a/arch/arm64/include/asm/asm-bug.h b/arch/arm64/include/asm/asm-bug.h
index a5f13801b7840..22e1a9df9851d 100644
--- a/arch/arm64/include/asm/asm-bug.h
+++ b/arch/arm64/include/asm/asm-bug.h
@@ -5,6 +5,7 @@
  */
 #define __ASM_ASM_BUG_H
 
+#include <linux/annotate.h>
 #include <asm/brk-imm.h>
 
 #ifdef CONFIG_DEBUG_BUGVERBOSE
@@ -24,6 +25,7 @@
 #define __BUG_ENTRY_START				\
 		.pushsection __bug_table,"aw";		\
 		.align 2;				\
+		__ANNOTATE_DATA_SPECIAL;		\
 	14470:	.long 14471f - .;			\
 
 #define __BUG_ENTRY_END					\
diff --git a/arch/arm64/include/asm/asm-extable.h b/arch/arm64/include/asm/asm-extable.h
index d67e2fdd1aee5..e81700edbb936 100644
--- a/arch/arm64/include/asm/asm-extable.h
+++ b/arch/arm64/include/asm/asm-extable.h
@@ -5,6 +5,10 @@
 #include <linux/bits.h>
 #include <asm/gpr-num.h>
 
+#ifndef COMPILE_OFFSETS
+#include <asm/asm-offsets.h>
+#endif
+
 #define EX_TYPE_NONE			0
 #define EX_TYPE_BPF			1
 #define EX_TYPE_UACCESS_ERR_ZERO	2
@@ -29,13 +33,13 @@
 
 #ifdef __ASSEMBLER__
 
-#define __ASM_EXTABLE_RAW(insn, fixup, type, data)	\
-	.pushsection	__ex_table, "a";		\
-	.align		2;				\
-	.long		((insn) - .);			\
-	.long		((fixup) - .);			\
-	.short		(type);				\
-	.short		(data);				\
+#define __ASM_EXTABLE_RAW(insn, fixup, type, data)			\
+	.pushsection	__ex_table, "aM", @progbits, EXTABLE_SIZE;	\
+	.align		2;						\
+	.long		((insn) - .);					\
+	.long		((fixup) - .);					\
+	.short		(type);						\
+	.short		(data);						\
 	.popsection;
 
 #define EX_DATA_REG(reg, gpr)	\
@@ -82,7 +86,8 @@
 #include <linux/stringify.h>
 
 #define __ASM_EXTABLE_RAW(insn, fixup, type, data)	\
-	".pushsection	__ex_table, \"a\"\n"		\
+	".pushsection	__ex_table, \"aM\", @progbits, "\
+			__stringify(EXTABLE_SIZE) "\n"	\
 	".align		2\n"				\
 	".long		((" insn ") - .)\n"		\
 	".long		((" fixup ") - .)\n"		\
diff --git a/arch/arm64/include/asm/jump_label.h b/arch/arm64/include/asm/jump_label.h
index 0cb211d3607d3..4dacb28641d72 100644
--- a/arch/arm64/include/asm/jump_label.h
+++ b/arch/arm64/include/asm/jump_label.h
@@ -11,6 +11,7 @@
 #ifndef __ASSEMBLER__
 
 #include <linux/types.h>
+#include <linux/annotate.h>
 #include <asm/insn.h>
 
 #define HAVE_JUMP_LABEL_BATCH
@@ -19,6 +20,7 @@
 #define JUMP_TABLE_ENTRY(key, label)			\
 	".pushsection	__jump_table, \"aw\"\n\t"	\
 	".align		3\n\t"				\
+	ANNOTATE_DATA_SPECIAL "\n\t"			\
 	".long		1b - ., " label " - .\n\t"	\
 	".quad		" key " - .\n\t"		\
 	".popsection\n\t"
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 44b92f582c127..76251586e31c7 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -23,6 +23,8 @@
 #include <asm/suspend.h>
 #include <linux/kbuild.h>
 #include <linux/arm-smccc.h>
+#include <asm/alternative.h>
+#include <asm/extable.h>
 
 int main(void)
 {
@@ -185,5 +187,8 @@ int main(void)
 #endif
   DEFINE(PIE_E0_ASM, PIE_E0);
   DEFINE(PIE_E1_ASM, PIE_E1);
+  BLANK();
+  DEFINE(ALT_INSTR_SIZE,		sizeof(struct alt_instr));
+  DEFINE(EXTABLE_SIZE,			sizeof(struct exception_table_entry));
   return 0;
 }
diff --git a/include/linux/annotate.h b/include/linux/annotate.h
index 2f1599c9e5732..7f5aa15f353d6 100644
--- a/include/linux/annotate.h
+++ b/include/linux/annotate.h
@@ -3,6 +3,7 @@
 #define _LINUX_ANNOTATE_H
 
 #include <linux/objtool_types.h>
+#include <linux/stringify.h>
 
 #ifdef CONFIG_OBJTOOL
 
@@ -11,6 +12,10 @@
 	.long label - ., type;						\
 	.popsection
 
+#define __ASM_ANNOTATE_DATA(type)					\
+912:									\
+	__ASM_ANNOTATE(.discard.annotate_data, 912b, type)
+
 #ifndef __ASSEMBLY__
 
 #define ASM_ANNOTATE_LABEL(label, type)					\
@@ -39,6 +44,9 @@
 #endif /* __ASSEMBLY__ */
 
 #else /* !CONFIG_OBJTOOL */
+
+#define __ASM_ANNOTATE_DATA(type)
+
 #ifndef __ASSEMBLY__
 #define ASM_ANNOTATE_LABEL(label, type) ""
 #define ASM_ANNOTATE(type)
@@ -106,10 +114,12 @@
 #define ANNOTATE_NOCFI_SYM(sym)		asm(ASM_ANNOTATE_LABEL(sym, ANNOTYPE_NOCFI))
 
 /*
- * Annotate a special section entry.  This emables livepatch module generation
+ * Annotate a special section entry.  This enables livepatch module generation
  * to find and extract individual special section entries as needed.
  */
 #define ANNOTATE_DATA_SPECIAL		ASM_ANNOTATE_DATA(ANNOTYPE_DATA_SPECIAL)
+#define __ANNOTATE_DATA_SPECIAL		__ASM_ANNOTATE_DATA(ANNOTYPE_DATA_SPECIAL)
+#define ANNOTATE_DATA_SPECIAL_END	ASM_ANNOTATE_DATA(ANNOTYPE_DATA_SPECIAL_END)
 
 #else /* __ASSEMBLY__ */
 #define ANNOTATE_NOENDBR		ANNOTATE type=ANNOTYPE_NOENDBR
@@ -122,6 +132,8 @@
 #define ANNOTATE_REACHABLE		ANNOTATE type=ANNOTYPE_REACHABLE
 #define ANNOTATE_NOCFI_SYM		ANNOTATE type=ANNOTYPE_NOCFI
 #define ANNOTATE_DATA_SPECIAL		ANNOTATE_DATA type=ANNOTYPE_DATA_SPECIAL
+#define __ANNOTATE_DATA_SPECIAL		__ASM_ANNOTATE_DATA(ANNOTYPE_DATA_SPECIAL)
+#define ANNOTATE_DATA_SPECIAL_END	ANNOTATE_DATA type=ANNOTYPE_DATA_SPECIAL_END
 #endif /* __ASSEMBLY__ */
 
 #endif /* _LINUX_ANNOTATE_H */
diff --git a/include/linux/objtool_types.h b/include/linux/objtool_types.h
index c6def4049b1ae..744118ffd025f 100644
--- a/include/linux/objtool_types.h
+++ b/include/linux/objtool_types.h
@@ -68,5 +68,6 @@ struct unwind_hint {
 #define ANNOTYPE_NOCFI			9
 
 #define ANNOTYPE_DATA_SPECIAL		1
+#define ANNOTYPE_DATA_SPECIAL_END	2
 
 #endif /* _LINUX_OBJTOOL_TYPES_H */
diff --git a/tools/include/linux/objtool_types.h b/tools/include/linux/objtool_types.h
index c6def4049b1ae..744118ffd025f 100644
--- a/tools/include/linux/objtool_types.h
+++ b/tools/include/linux/objtool_types.h
@@ -68,5 +68,6 @@ struct unwind_hint {
 #define ANNOTYPE_NOCFI			9
 
 #define ANNOTYPE_DATA_SPECIAL		1
+#define ANNOTYPE_DATA_SPECIAL_END	2
 
 #endif /* _LINUX_OBJTOOL_TYPES_H */
diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
index 890de34d1fa27..19dcf930a562b 100644
--- a/tools/objtool/klp-diff.c
+++ b/tools/objtool/klp-diff.c
@@ -1727,7 +1727,10 @@ static int create_fake_symbols(struct elf *elf)
 		 */
 		next_reloc = reloc;
 		for_each_reloc_continue(sec->rsec, next_reloc) {
-			if (annotype(elf, sec, next_reloc) != ANNOTYPE_DATA_SPECIAL ||
+			unsigned int next_type = annotype(elf, sec, next_reloc);
+
+			if ((next_type != ANNOTYPE_DATA_SPECIAL &&
+			     next_type != ANNOTYPE_DATA_SPECIAL_END) ||
 			    next_reloc->sym->sec != reloc->sym->sec)
 				continue;
 
-- 
2.54.0

