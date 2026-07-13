Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370D2265629
	for <live-patching@vger.kernel.org>; Mon, 13 Jul 2026 14:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783953218; cv=none; b=gb20c0bTij6rmOiGSm75/SOwvz160h7LQNV3/qKIP5etvkVNXpH/TnNzWWwADmseK0+z3dMYnHJlf3VzPAttrfwI/Amr6INbOJILRvBkyrQ4fYHWL86g6T2zGbuzyvYFrsZ816gSugBQwM4ZjrSDmnSeDwShynNsBUBjnAwgdnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783953218; c=relaxed/simple;
	bh=rcYOTNdcj2ibiwqJfeJZQ8JuzAGrI+5pZvaHR/F+XvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B96xT5BCWytTDwOoaKCox02E8UJQwWAXxHEoIfwYYC1KI3OvaYczNEUTG/rWMiUzRZe4Swfx/VA/flLhREgERPqpYqFCwJ+NMN7Hifn1yBi3hqVfec0HvgU1dHmmtdrNP+P63tYyLDSNMU4Ky54/tt6QG2w1gtrIX+Z5FvFty0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=X7+Ieqn2; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="X7+Ieqn2"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783953214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z8Y2MZq+OsXMv1ZBbMCu0RMLJ/nz8XEP3l5zITko3Sw=;
	b=X7+Ieqn2v0Wu1W6tHVlyw6iottaQb0tPXKJZesrNF2HkF3USEoUZjtGDnDH7XsdRVy+8j/
	qtD6hZT0sEd3k3mKs+0FnNKF23xY6ToyG7UxbbYQ9+zS7rQ+Hb3Dguxe3q9V7ZATdfiGyT
	pI6WUWfimaeww3e9EbYAx4C7nxKr4Ok=
From: George Guo <dongtai.guo@linux.dev>
To: joe.lawrence@redhat.com
Cc: chenhuacai@kernel.org,
	jpoimboe@kernel.org,
	peterz@infradead.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	kernel@xen0n.name,
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
Subject: Re: [PATCH v3 02/12] LoongArch: Mark special sections for KLP support
Date: Mon, 13 Jul 2026 22:33:24 +0800
Message-ID: <20260713143324.16887-1-dongtai.guo@linux.dev>
In-Reply-To: <ak7QBSm3mmDlB-4u@redhat.com>
References: <ak7QBSm3mmDlB-4u@redhat.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi Joe,

Thanks for the test case.

> Should v3 (or a follow-up patch) include the inline alternative
> cloning support?  Or is patching functions that contain ALTERNATIVE()
> intentionally out of scope for LoongArch KLP for now?

It should be supported.  It is a real gap, and there is a fix.

LoongArch emits the ALTERNATIVE replacement into ".subsection 1", the
same as arm64.  The replacement is appended to the function's own
section, after the body.  objtool already handles that layout for arm64,
through two pieces that LoongArch was missing:

  - arm64's ALTERNATIVE macros wrap the replacement with
    ANNOTATE_DATA_SPECIAL / ANNOTATE_DATA_SPECIAL_END, so
    create_fake_symbols() makes a fake symbol for the replacement block.
  - arm64 defines ARCH_HAS_INLINE_ALTS, so clone_inline_alternatives()
    clones that block after the function.

LoongArch had neither.  So clone_inline_alternatives() was a no-op, the
replacement was never cloned, and objtool reported "can't find new
instruction".

The fix adds both, matching arm64: annotate the replacement in the
ALTERNATIVE and ALTERNATIVE_2 macros (asm and inline-asm), and define
ARCH_HAS_INLINE_ALTS in objtool.  It keeps the .subsection layout, so no
objtool logic changes.

With it, your exact test case builds.  I verified on LoongArch hardware
with Clang 21.  The replacement is cloned as its own fake symbol, and the
.altinstructions entry points at it:

  DEBUG: vmlinux.o: _text_klp_build_alt_test_compute_110 [+DATA]
  DEBUG: vmlinux.o:  .altinstructions+0x4: _text_klp_build_alt_test_compute_110+0x0 [NOTYPE LOCAL]
  vmlinux.o: changed function: klp_build_alt_test_compute
  Building patch module: livepatch-test-alternatives.ko
  SUCCESS

I will fold this into the next revision.  In the series it splits in two:
the annotation goes with the special-section marking, which is this patch
(LoongArch: Mark special sections for KLP support), and the
ARCH_HAS_INLINE_ALTS define goes with the objtool arch hooks.

Diff below.

---
 arch/loongarch/include/asm/alternative-asm.h  | 5 ++++-
 arch/loongarch/include/asm/alternative.h      | 5 ++++-
 tools/objtool/arch/loongarch/include/arch/elf.h | 1 +
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/loongarch/include/asm/alternative-asm.h b/arch/loongarch/include/asm/alternative-asm.h
index d940d9d2c0e1..92122a258a8e 100644
--- a/arch/loongarch/include/asm/alternative-asm.h
+++ b/arch/loongarch/include/asm/alternative-asm.h
@@ -6,6 +6,7 @@

 #include <asm/asm.h>
 #include <generated/asm-offsets.h>
+#include <linux/annotate.h>

 /*
  * Issue one struct alt_instr descriptor entry (need to put it into
@@ -39,9 +40,11 @@
 	.popsection

 	.subsection 1
+	ANNOTATE_DATA_SPECIAL
 143 :
 	\newinstr
 144 :
+	ANNOTATE_DATA_SPECIAL_END
 	.previous
 .endm

@@ -70,11 +73,13 @@
 	.popsection

 	.subsection 1
+	ANNOTATE_DATA_SPECIAL
 143 :
 	\newinstr1
 144 :
 	\newinstr2
 145 :
+	ANNOTATE_DATA_SPECIAL_END
 	.previous
 .endm

diff --git a/arch/loongarch/include/asm/alternative.h b/arch/loongarch/include/asm/alternative.h
index 8f7712ed2f4e..1d3ac2f667d1 100644
--- a/arch/loongarch/include/asm/alternative.h
+++ b/arch/loongarch/include/asm/alternative.h
@@ -7,6 +7,7 @@
 #include <linux/types.h>
 #include <linux/stddef.h>
 #include <linux/stringify.h>
+#include <linux/objtool.h>
 #include <asm/asm.h>

 struct alt_instr {
@@ -75,7 +76,9 @@ extern void apply_alternatives(struct alt_instr *start, struct alt_instr *end);
 	ALTINSTR_ENTRY(feature, 1)					\
 	".popsection\n"							\
 	".subsection 1\n" \
+	ANNOTATE_DATA_SPECIAL "\n" \
 	ALTINSTR_REPLACEMENT(newinstr, feature, 1)			\
+	ANNOTATE_DATA_SPECIAL_END "\n" \
 	".previous\n"

 #define ALTERNATIVE_2(oldinstr, newinstr1, feature1, newinstr2, feature2)\
@@ -86,8 +89,10 @@ extern void apply_alternatives(struct alt_instr *start, struct alt_instr *end);
 	ALTINSTR_ENTRY(feature2, 2)					\
 	".popsection\n"							\
 	".subsection 1\n" \
+	ANNOTATE_DATA_SPECIAL "\n" \
 	ALTINSTR_REPLACEMENT(newinstr1, feature1, 1)			\
 	ALTINSTR_REPLACEMENT(newinstr2, feature2, 2)			\
+	ANNOTATE_DATA_SPECIAL_END "\n" \
 	".previous\n"

 /*
diff --git a/tools/objtool/arch/loongarch/include/arch/elf.h b/tools/objtool/arch/loongarch/include/arch/elf.h
index 0103f27fccfc..e2843679f24e 100644
--- a/tools/objtool/arch/loongarch/include/arch/elf.h
+++ b/tools/objtool/arch/loongarch/include/arch/elf.h
@@ -46,6 +46,7 @@
 #define R_TEXT32		R_LARCH_32_PCREL
 #define R_TEXT64		R_LARCH_32_PCREL

+#define ARCH_HAS_INLINE_ALTS	1
 #define ARCH_HAS_PAIRED_RELOCS	1

 struct elf;

Thanks,
George
