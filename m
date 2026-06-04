Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E77E3C1F2B
	for <live-patching@vger.kernel.org>; Thu,  4 Jun 2026 06:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780556133; cv=none; b=IN7/d6JBZYqs9m+BHvc3q8gPGIcFvesrb2Mg7g9hRfY8NY5ymD4Oh84fUSLfeTuTZZAFfSn7EOVlzzmwSmLeBuyKC7qvlUjLvZaGr8NxwnWQSe/FZzWwMez7v/zufTTCUez4kJnaNNs/7RBDip96AOVSP1IXKQZo2o3PanWjrC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780556133; c=relaxed/simple;
	bh=ozODrf/YskxLh7GSBLFEFLirMysqauyIzAVNs8EwW8I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FmXFi7Dw9lDuZ4/t/qFIDGNhTuN6hXeotORFo0ANp9ONCpN8bwvSauVAYdyRbJgBWTcwR9VeMA6JMyi5AvQZRGYbh5JvUs3rBH7KweX4dAk7GHt03XRJiHL/rfKLpIIMELBVZH+lqxzLZg639Eo8ALLltY653Np6Qrv1mY7odAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cZ9pXfqE; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cZ9pXfqE"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780556128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y1V5SfkWutaG7THsFK665QVbmO8aunuz7f9TfyLp1sw=;
	b=cZ9pXfqE4JYoDJLEIGugeeA/Eh1KhhaZQIvYH66+snmuHRc34iQRj0oKsVuymiZoAPbR2M
	HSj5JBY709iBVA8lftRq4Tl3rOfbO/uDsTEVC9D5TPi3LF4D0dcewIuUN4lGLh4VgV5oKb
	kP3f4zHJMRNp0ktwM6GVrUGFjjQjtV4=
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
	xry111@xry111.site,
	liukexin@kylinos.cn,
	loongarch@lists.linux.dev,
	live-patching@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	George Guo <guodongtai@kylinos.cn>
Subject: [PATCH 3/8] LoongArch: Add special section entry sizes for KLP support
Date: Thu,  4 Jun 2026 14:53:12 +0800
Message-Id: <20260604065317.219777-4-dongtai.guo@linux.dev>
In-Reply-To: <20260604065317.219777-1-dongtai.guo@linux.dev>
References: <20260604065317.219777-1-dongtai.guo@linux.dev>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: George Guo <guodongtai@kylinos.cn>

Define entry sizes for .altinstructions, __ex_table, __bug_table, and
__jump_table sections to enable objtool to process livepatch modules
on LoongArch.

Co-developed-by: Kexin Liu <liukexin@kylinos.cn>
Signed-off-by: Kexin Liu <liukexin@kylinos.cn>
Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 arch/loongarch/include/asm/alternative-asm.h |  5 +--
 arch/loongarch/include/asm/alternative.h     |  6 ++--
 arch/loongarch/include/asm/asm-extable.h     | 10 ++++--
 arch/loongarch/include/asm/bug.h             | 15 +++++++-
 arch/loongarch/include/asm/jump_label.h      |  9 ++++-
 arch/loongarch/kernel/asm-offsets.c          | 36 ++++++++++++++++++++
 arch/loongarch/kernel/head.S                 |  1 +
 7 files changed, 74 insertions(+), 8 deletions(-)

diff --git a/arch/loongarch/include/asm/alternative-asm.h b/arch/loongarch/include/asm/alternative-asm.h
index 7dc29bd9b2f0..d940d9d2c0e1 100644
--- a/arch/loongarch/include/asm/alternative-asm.h
+++ b/arch/loongarch/include/asm/alternative-asm.h
@@ -5,6 +5,7 @@
 #ifdef __ASSEMBLER__
 
 #include <asm/asm.h>
+#include <generated/asm-offsets.h>
 
 /*
  * Issue one struct alt_instr descriptor entry (need to put it into
@@ -33,7 +34,7 @@
 	.fill - (((144f-143f)-(141b-140b)) > 0) * ((144f-143f)-(141b-140b)) / 4, 4, 0x03400000
 142 :
 
-	.pushsection .altinstructions, "a"
+	.pushsection .altinstructions, "aM", @progbits, ALT_INSTR_SIZE
 	altinstruction_entry 140b, 143f, \feature, 142b-140b, 144f-143f
 	.popsection
 
@@ -63,7 +64,7 @@
 		(alt_max_short(new_len1, new_len2) - (old_len)) / 4, 4, 0x03400000
 142 :
 
-	.pushsection .altinstructions, "a"
+	.pushsection .altinstructions, "aM", @progbits, ALT_INSTR_SIZE
 	altinstruction_entry 140b, 143f, \feature1, 142b-140b, 144f-143f, 142b-141b
 	altinstruction_entry 140b, 144f, \feature2, 142b-140b, 145f-144f, 142b-141b
 	.popsection
diff --git a/arch/loongarch/include/asm/alternative.h b/arch/loongarch/include/asm/alternative.h
index b5bae21fb3c8..8f7712ed2f4e 100644
--- a/arch/loongarch/include/asm/alternative.h
+++ b/arch/loongarch/include/asm/alternative.h
@@ -70,7 +70,8 @@ extern void apply_alternatives(struct alt_instr *start, struct alt_instr *end);
 /* alternative assembly primitive: */
 #define ALTERNATIVE(oldinstr, newinstr, feature)			\
 	OLDINSTR(oldinstr, 1)						\
-	".pushsection .altinstructions,\"a\"\n"				\
+	".pushsection .altinstructions, \"aM\", @progbits, "            \
+		 __stringify(ALT_INSTR_SIZE) "\n"                       \
 	ALTINSTR_ENTRY(feature, 1)					\
 	".popsection\n"							\
 	".subsection 1\n" \
@@ -79,7 +80,8 @@ extern void apply_alternatives(struct alt_instr *start, struct alt_instr *end);
 
 #define ALTERNATIVE_2(oldinstr, newinstr1, feature1, newinstr2, feature2)\
 	OLDINSTR_2(oldinstr, 1, 2)					\
-	".pushsection .altinstructions,\"a\"\n"				\
+	".pushsection .altinstructions, \"aM\", @progbits, "            \
+			__stringify(ALT_INSTR_SIZE) "\n"                \
 	ALTINSTR_ENTRY(feature1, 1)					\
 	ALTINSTR_ENTRY(feature2, 2)					\
 	".popsection\n"							\
diff --git a/arch/loongarch/include/asm/asm-extable.h b/arch/loongarch/include/asm/asm-extable.h
index d60bdf2e6377..2d7eef7c0b39 100644
--- a/arch/loongarch/include/asm/asm-extable.h
+++ b/arch/loongarch/include/asm/asm-extable.h
@@ -7,10 +7,15 @@
 #define EX_TYPE_UACCESS_ERR_ZERO	2
 #define EX_TYPE_BPF			3
 
+#ifndef COMPILE_OFFSETS
+#include <asm/asm-offsets.h>
+#endif
+
 #ifdef __ASSEMBLER__
 
 #define __ASM_EXTABLE_RAW(insn, fixup, type, data)	\
-	.pushsection	__ex_table, "a";		\
+	.pushsection    __ex_table, "aM", @progbits,    \
+			EXTABLE_SIZE;                   \
 	.balign		4;				\
 	.long		((insn) - .);			\
 	.long		((fixup) - .);			\
@@ -29,7 +34,8 @@
 #include <asm/gpr-num.h>
 
 #define __ASM_EXTABLE_RAW(insn, fixup, type, data)	\
-	".pushsection	__ex_table, \"a\"\n"		\
+	".pushsection   __ex_table, \"aM\", @progbits, "\
+	 __stringify(EXTABLE_SIZE) "\n"                 \
 	".balign	4\n"				\
 	".long		((" insn ") - .)\n"		\
 	".long		((" fixup ") - .)\n"		\
diff --git a/arch/loongarch/include/asm/bug.h b/arch/loongarch/include/asm/bug.h
index d090a5bec5eb..c067c858b918 100644
--- a/arch/loongarch/include/asm/bug.h
+++ b/arch/loongarch/include/asm/bug.h
@@ -22,8 +22,20 @@
 #ifndef CONFIG_GENERIC_BUG
 #define __BUG_ENTRY(cond_str, flags)
 #else
+
+#ifdef COMPILE_OFFSETS
+#define __BUG_ENTRY(cond_str, flags)				\
+		.pushsection __bug_table, "awM", @progbits, 0;	\
+		.align 2;					\
+	10000:	.long 10001f - .;				\
+		_BUGVERBOSE_LOCATION(WARN_CONDITION_STR(cond_str) __FILE__, __LINE__) \
+		.short flags;					\
+		.popsection;					\
+	10001:
+#else
+#include <generated/asm-offsets.h>
 #define __BUG_ENTRY(cond_str, flags)				\
-		.pushsection __bug_table, "aw";			\
+		.pushsection __bug_table, "awM", @progbits, BUG_ENTRY_SIZE; \
 		.align 2;					\
 	10000:	.long 10001f - .;				\
 		_BUGVERBOSE_LOCATION(WARN_CONDITION_STR(cond_str) __FILE__, __LINE__) \
@@ -31,6 +43,7 @@
 		.popsection;					\
 	10001:
 #endif
+#endif
 
 #define ASM_BUG_FLAGS(cond_str, flags)				\
 	__BUG_ENTRY(cond_str, flags)				\
diff --git a/arch/loongarch/include/asm/jump_label.h b/arch/loongarch/include/asm/jump_label.h
index 7ef4ae3abf08..26ae644755ea 100644
--- a/arch/loongarch/include/asm/jump_label.h
+++ b/arch/loongarch/include/asm/jump_label.h
@@ -23,9 +23,16 @@
 #define JUMP_LABEL_TYPE		".quad "
 #endif
 
+#ifdef COMPILE_OFFSETS
+#define JUMP_ENTRY_SIZE 0
+#else
+#include <generated/asm-offsets.h>
+#endif
+
 /* This macro is also expanded on the Rust side. */
 #define JUMP_TABLE_ENTRY(key, label)			\
-	 ".pushsection	__jump_table, \"aw\"	\n\t"	\
+	 ".pushsection	__jump_table, \"awM\", @progbits, " \
+			__stringify(JUMP_ENTRY_SIZE) "\n\t" \
 	 ".align	" __stringify(PTRLOG) "	\n\t"	\
 	 ".long		1b - ., " label " - .	\n\t"	\
 	 JUMP_LABEL_TYPE  key " - .		\n\t"	\
diff --git a/arch/loongarch/kernel/asm-offsets.c b/arch/loongarch/kernel/asm-offsets.c
index 2cc953f113ac..42f16e5da06d 100644
--- a/arch/loongarch/kernel/asm-offsets.c
+++ b/arch/loongarch/kernel/asm-offsets.c
@@ -18,6 +18,10 @@
 #include <asm/ftrace.h>
 #include <asm/sigframe.h>
 #include <vdso/datapage.h>
+#include <asm/alternative.h>
+#include <asm/extable.h>
+#include <asm/bug.h>
+#include <asm/jump_label.h>
 
 static void __used output_ptreg_defines(void)
 {
@@ -323,3 +327,35 @@ static void __used output_vdso_defines(void)
 	DEFINE(__VDSO_PAGES, VDSO_NR_PAGES);
 	BLANK();
 }
+
+static void __used output_extable_defines(void)
+{
+	COMMENT("LoongArch exception table entry offsets.");
+
+	DEFINE(EXTABLE_SIZE, sizeof(struct exception_table_entry));
+	BLANK();
+}
+
+static void __used output_alt_instr_defines(void)
+{
+	COMMENT("LoongArch alternative instructions offsets.");
+
+	DEFINE(ALT_INSTR_SIZE, sizeof(struct alt_instr));
+	BLANK();
+}
+
+static void __used output_bug_defines(void)
+{
+	COMMENT("LoongArch bug entry offsets.");
+
+	DEFINE(BUG_ENTRY_SIZE, sizeof(struct bug_entry));
+	BLANK();
+}
+
+static void __used output_jump_label_defines(void)
+{
+	COMMENT("LoongArch jump entry offsets.");
+
+	DEFINE(JUMP_ENTRY_SIZE, sizeof(struct jump_entry));
+	BLANK();
+}
diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.S
index 4eed7bc312a8..a8a2a98e0a5c 100644
--- a/arch/loongarch/kernel/head.S
+++ b/arch/loongarch/kernel/head.S
@@ -12,6 +12,7 @@
 #include <asm/regdef.h>
 #include <asm/loongarch.h>
 #include <asm/stackframe.h>
+#include <generated/asm-offsets.h>
 
 #ifdef CONFIG_EFI_STUB
 
-- 
2.25.1

