Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E2F3B6BF0
	for <live-patching@vger.kernel.org>; Tue,  7 Jul 2026 07:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783408917; cv=none; b=ErKlXl34Js8vxF4Dm23+we8LF7GYAxXevHyR1jLDKgh2ykvMOCDX9jhpB/zUGwiQd9BBb6VODYVIIqCK2hQSo+jA1erUlMgcVMf9Q1O2Q+ebD1FcJ0LcRk/N1TsCkJGRrQW1+s5UtiyWWf1cHiXXH7tuEOiwuCV0MrN9dDljI0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783408917; c=relaxed/simple;
	bh=cbS69o5iESsfbUbRgcNuv3uKnv/pE5hU4jIiUR0Ij9M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iMIE5t5OFJMrQgR+CKB5B8NbL8CqEWpolXOtr6jn5iIxd599+1z1cvRpgKeoi8jH/ZEJs3+nQ7f4gblwK+051q/rTf1chnnWJNG4p6s3ogr+Mmki/bdvquqgCtc2hTi6a9p4shsZ10XVllq8y3DH4zEbDZdq5IdfBtowB6KMxzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wSpcN6vQ; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wSpcN6vQ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783408903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/3FyhKq1xd5fu9klCT0mfTqjvkusYJv3Ps48W8w3NkU=;
	b=wSpcN6vQJ3fp2fmHTozakjNRkKSWF3WP3kpAcWK2kwjEQPk6iqy2KWn6o7whq5HsNspbP8
	tubgqnmw5NnmoYIX61roz/Df0X8XOY7vSEmjqXHEenDI3NWxZlNOANcfrea6i2CkXTFU3b
	NpgRDWWtlVJ0OBV0c0jS7NdGlEniPSs=
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
Subject: [PATCH v3 02/12] LoongArch: Mark special sections for KLP support
Date: Tue,  7 Jul 2026 15:20:21 +0800
Message-Id: <20260707072031.231066-3-dongtai.guo@linux.dev>
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

objtool needs to split the kernel's special sections into per-entry
symbols when generating livepatch modules. Mark them so it can:

 - .altinstructions and __ex_table are read-only, so set an explicit
   entry size via SHF_MERGE (ALT_INSTR_SIZE / EXTABLE_SIZE).

 - __bug_table and __jump_table are writable. SHF_MERGE cannot be
   combined with SHF_WRITE (Clang rejects it), so annotate each entry
   with ANNOTATE_DATA_SPECIAL instead, mirroring x86/arm64.

Co-developed-by: Kexin Liu <liukexin@kylinos.cn>
Signed-off-by: Kexin Liu <liukexin@kylinos.cn>
Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 arch/loongarch/include/asm/alternative-asm.h |  5 +++--
 arch/loongarch/include/asm/alternative.h     |  6 ++++--
 arch/loongarch/include/asm/asm-extable.h     | 10 ++++++++--
 arch/loongarch/include/asm/bug.h             |  1 +
 arch/loongarch/include/asm/jump_label.h      |  2 ++
 arch/loongarch/kernel/asm-offsets.c          | 20 ++++++++++++++++++++
 6 files changed, 38 insertions(+), 6 deletions(-)

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
index d090a5bec5eb..14e3acbaad8d 100644
--- a/arch/loongarch/include/asm/bug.h
+++ b/arch/loongarch/include/asm/bug.h
@@ -25,6 +25,7 @@
 #define __BUG_ENTRY(cond_str, flags)				\
 		.pushsection __bug_table, "aw";			\
 		.align 2;					\
+		__ANNOTATE_DATA_SPECIAL;				\
 	10000:	.long 10001f - .;				\
 		_BUGVERBOSE_LOCATION(WARN_CONDITION_STR(cond_str) __FILE__, __LINE__) \
 		.short flags;					\
diff --git a/arch/loongarch/include/asm/jump_label.h b/arch/loongarch/include/asm/jump_label.h
index 7ef4ae3abf08..d20f0fa24b6b 100644
--- a/arch/loongarch/include/asm/jump_label.h
+++ b/arch/loongarch/include/asm/jump_label.h
@@ -12,6 +12,7 @@
 #include <linux/types.h>
 #include <linux/stringify.h>
 #include <asm/asm.h>
+#include <linux/objtool.h>
 
 #define HAVE_JUMP_LABEL_BATCH
 
@@ -27,6 +28,7 @@
 #define JUMP_TABLE_ENTRY(key, label)			\
 	 ".pushsection	__jump_table, \"aw\"	\n\t"	\
 	 ".align	" __stringify(PTRLOG) "	\n\t"	\
+	 ANNOTATE_DATA_SPECIAL "\n\t"			\
 	 ".long		1b - ., " label " - .	\n\t"	\
 	 JUMP_LABEL_TYPE  key " - .		\n\t"	\
 	 ".popsection				\n\t"
diff --git a/arch/loongarch/kernel/asm-offsets.c b/arch/loongarch/kernel/asm-offsets.c
index 2cc953f113ac..470323aa022c 100644
--- a/arch/loongarch/kernel/asm-offsets.c
+++ b/arch/loongarch/kernel/asm-offsets.c
@@ -18,6 +18,8 @@
 #include <asm/ftrace.h>
 #include <asm/sigframe.h>
 #include <vdso/datapage.h>
+#include <asm/alternative.h>
+#include <asm/extable.h>
 
 static void __used output_ptreg_defines(void)
 {
@@ -323,3 +325,21 @@ static void __used output_vdso_defines(void)
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
+
-- 
2.25.1

