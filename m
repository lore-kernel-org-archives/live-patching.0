Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794881228;
	b=Ig3EwXujM0bFjSlae0LuIKOUTjl6H8ViUcAItYvgFeDcqBLrVMsap91LyAN7h55l3T50
	 oy9iioWqP3zpY5wwq99wWjyvOOcFtpD3+uIA+RUg71nc9yb6mgRrUVAMpP6VuH3R3lRgH
	 Jm2YVmUylHljQhJIHlDKcwvl9+I632ktqcJBfBOrcprsAWliyUtR6OXS71bQKoXxrYsVp
	 oIUtVrUdET/M/HAD9Ttbju7LGIsO3E/hDSOFHMcoEWm4bItlpE42CERH0CdNAMAPCbLd6
	 CiuL3p96hW8ma8JObtUS1r5wN8oNg1XCj43r5udI+bzc2UMQZqKfaAG0blVwh7C4UuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794881228;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=4H9SESbbRGSoAq2gQL4B9mysuCtb/u5ZBxs535NDDIs=;
	b=3WpTfWtlWxTnzDkAicd3JjMYC/QsRFVJQPHz4V0dMNpw/7RFc75gxTkHScs2x2MirfWx
	 mQkEYImiSlCx1VYFzeRl4sKIDuZ7aGmutuHgvVRTrnKZ8pVN/K6e3x3bHBCZTb7rWEvgW
	 tLS4+rQfMligqHGtlZ3g0LveaKkv2KLaAIcHcwnDSpVtG5cdW4htJoSs42Lfsd25sZPpU
	 nZo4ABzJ96wWVCgOLw/UosARWiKs5mx5xVEb4Uk4SywvCeRt58loR5N1Ht3akmXRTRaP1
	 7VH2GAof0ogt4DoNGrRS+/tVHcuMilDZONJtBMeTxQjFLU6lw4h6vNUfyUZNQAeXStg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dylanbhatch.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=RS0NTd8l;
	arc=none smtp.remote-ip=209.85.214.197
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A63606A88C
	for <live-patching@vger.kernel.org>; Tue, 17 Nov 2026 02:07:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82A63606A88C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dylanbhatch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=RS0NTd8l
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ed08904845so25626395ad.3
        for <live-patching@vger.kernel.org>; Mon, 16 Nov 2026 18:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794881227; x=1795486027; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4H9SESbbRGSoAq2gQL4B9mysuCtb/u5ZBxs535NDDIs=;
        b=RS0NTd8lyLPhf1ahEd/zO9Zi59bEXgNqtB8SLdJu1WczJSgrtam5QL/5Sjdd5+WyBO
         bjsb+zcDHFy757WIlTyizzu6bFu4QSm7j6/qPbJanrYmIwczLMphCWySIHBtdv11SXHQ
         ihNrJ9FF7hwvizOy3FZxK1CbPesdEdUrrPw1s/THg7iwXrJxUXdDGfOXnQiw+uZXpyxk
         8TKe5Or2DFyjQgiK3owU/uwJLXn1/4hpzpmyyfPLcHOkF7dAGs/2bNsFbKmSlIPSRYvz
         kkCoKNjrhqhxah+92VifK9C+q7cVSctVOljOkAb/Upo4vNoqc8DxXCQ4h2Clz5H9JhsS
         XRuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794881227; x=1795486027;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4H9SESbbRGSoAq2gQL4B9mysuCtb/u5ZBxs535NDDIs=;
        b=FmBcUIR8GtOttCPMWdEfS4UiI+opBRndwVdBcXvSdJRRnH4k3khCmf4QiQGziT6eIF
         QPc1ebpR1pjg9HqaGJlzDRekJaTh3hH750NzvwppZGIScW+0YSvcqRthUCYyjA0uidQO
         ef6vZBffC5O8nPAkCSQHbwBBRwpsabYfJLe+sJ3hYEpF1RDmSZAxKaBrheOXLN0SvN2X
         KIQ2MDfY0tg3gOqPrPwTJ0Yi31uvcbqncEaQ9wjsG1yl16M24ROE1PG6EFPFvnwRGw9c
         GACBAe/ALGjISU/XQgzDtwwJiErL7QvYpXDBGfnjkvGBj3Qp3uwmEkzbzm3sbLUs621F
         95Og==
X-Forwarded-Encrypted: i=1; AL+hErG5sTRlDWyMSWFcYnzpH0u8Zm1U+M8sbDxrwvm2pHLttjEuiZUV6FWcoSq2LO6+8DzUk2DHtu/NMqzoR5u3@vger.kernel.org
X-Gm-Message-State: APuU4Z/OzmUURHQbYS5eBkl1H77wKr7sYBhyVOvbG03lxUfWiunpibjr
	IH5JYdMO4C/3A9dwIXBNd+9z0AZR6KvyfTeIga8wZLV4evtNdNyWOYCgQOO1quJ+jKIxZdlvoQl
	SHFDHlyvMMONhH71AKJPdY1zm1g==
X-Received: from plsb22.prod.google.com ([2002:a17:902:b616:b0:2ef:e0e7:c9d1])
 (user=dylanbhatch job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e5c9:b0:2e9:73db:3c78 with SMTP id d9443c01a7336-2ee0daa43c4mr117565405ad.17.1794881226561;
 Mon, 16 Nov 2026 18:07:06 -0800 (PST)
Date: Tue, 17 Nov 2026 02:06:46 +0000
In-Reply-To: <20261117020648.323464-1-dylanbhatch@google.com>
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261117020648.323464-1-dylanbhatch@google.com>
X-Mailer: git-send-email 2.56.0.679.gc527c65306-goog
Message-ID: <20261117020648.323464-10-dylanbhatch@google.com>
Subject: [PATCH v9 09/11] arm64: entry: add unwind info for call_on_irq_stack()
From: Dylan Hatch <dylanbhatch@google.com>
To: Roman Gushchin <roman.gushchin@linux.dev>, Weinan Liu <wnliu@google.com>, 
	Will Deacon <will@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Indu Bhagat <ibhagatgnu@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Jiri Kosina <jikos@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Jens Remus <jremus@linux.ibm.com>
Cc: Dylan Hatch <dylanbhatch@google.com>, Prasanna Kumar T S M <ptsm@linux.microsoft.com>, 
	Puranjay Mohan <puranjay@kernel.org>, Song Liu <song@kernel.org>, joe.lawrence@redhat.com, 
	linux-toolchains@vger.kernel.org, linux-kernel@vger.kernel.org, 
	live-patching@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Randy Dunlap <rdunlap@infradead.org>, Mostafa Saleh <smostafa@google.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S . Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"

From: Weinan Liu <wnliu@google.com>

DWARF CFI (Call Frame Information) specifies how to recover the return
address and callee-saved registers at each PC in a given function.
Compilers are able to generate the CFI annotations when they compile
the code to assembly language. For handcrafted assembly, we need to
annotate them by hand.

Frame pointers alone are usually sufficient to recover stack frames
(without CFI), except at the exception boundary, where more information
is needed to determine if the LR is live.

Since an exception can be taken from call_on_irq_stack(), annotate it
with CFI. The actual entry assembly functions are left untouched, since
they are not expected to take exceptions themselves.

Signed-off-by: Weinan Liu <wnliu@google.com>
Suggested-by: Jens Remus <jremus@linux.ibm.com>
Reviewed-by: Jens Remus <jremus@linux.ibm.com>
Signed-off-by: Dylan Hatch <dylanbhatch@google.com>

---

Changes since v8:
 - (sashiko) Use SYM_START() with .cfi_startproc before 'bti c' so the
   FDE covers the landing pad at call_on_irq_stack+0.
---
 arch/arm64/kernel/entry.S | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 8d17f61d1b5b2..cc9290b218204 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -30,6 +30,12 @@
 #include <asm/asm-uaccess.h>
 #include <asm/unistd.h>
 
+/*
+ * Do not generate .eh_frame.  Only generate .debug_frame and optionally
+ * .sframe (via assembler option --gsframe[-N]).
+ */
+	.cfi_sections .debug_frame
+
 	.macro	clear_gp_regs
 	.irp	n,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29
 	mov	x\n, xzr
@@ -881,7 +887,9 @@ NOKPROBE(ret_from_fork)
  *
  * Calls func(regs) using this CPU's irq stack and shadow irq stack.
  */
-SYM_FUNC_START(call_on_irq_stack)
+SYM_START(call_on_irq_stack, SYM_L_GLOBAL, SYM_A_ALIGN)
+	.cfi_startproc
+	bti	c
 	save_and_disable_daif x9
 #ifdef CONFIG_SHADOW_CALL_STACK
 	get_current_task x16
@@ -892,6 +900,9 @@ SYM_FUNC_START(call_on_irq_stack)
 	/* Create a frame record to save our LR and SP (implicit in FP) */
 	stp	x29, x30, [sp, #-16]!
 	mov	x29, sp
+	.cfi_def_cfa 29, 16
+	.cfi_offset 29, -16
+	.cfi_offset 30, -8
 
 	ldr_this_cpu x16, irq_stack_ptr, x17
 
@@ -907,9 +918,13 @@ SYM_FUNC_START(call_on_irq_stack)
 	 */
 	mov	sp, x29
 	ldp	x29, x30, [sp], #16
+	.cfi_restore 29
+	.cfi_restore 30
+	.cfi_def_cfa 31, 0
 	scs_load_current
 	restore_irq x9
 	ret
+	.cfi_endproc
 SYM_FUNC_END(call_on_irq_stack)
 NOKPROBE(call_on_irq_stack)
 
-- 
2.56.0.679.gc527c65306-goog

