Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC35149D5AC
	for <live-patching@vger.kernel.org>; Wed,  7 Oct 2026 11:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791373456; cv=none; b=aOP6hyjjznuwF96aVaGBwP4xXtxdJJyj5ENjwnszCWqy5oJD0FY+XL6PDBmXBOl5g7IfJDcnuadrhjcpwT3YeXIhFUSNN7Xdl6fBjmFiGsiF//rTsxKtGb7yxkeVx1thVwhchcxMqymzJdggC+BditCp2BGBPl4rUQgKohPP6BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791373456; c=relaxed/simple;
	bh=9otGNsuAvu+C9nOqBLqYzUvRo5+HMUNzJSPIQKaiCow=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XoPpuu/3yE1Q6JZzQEkQsXQ/JPjnZ08nyRKdAj0D6JAu7jlherJGODHNU7GBWrT7ajtscCAvEgBDtxjNFewjv2MxrEqzG4KvGA9HJoZPXhPePo2ztSDK7ANOxFCeEmYGtTIGUEFHEGlhuZd94ejVh4bNnJ+lygH4TFjxU4TnUGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dylanbhatch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ish0aGPZ; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dylanbhatch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ish0aGPZ"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-88c768886a6so3149799b3a.2
        for <live-patching@vger.kernel.org>; Wed, 07 Oct 2026 04:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791373443; x=1791978243; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l81J79D4i1POsrCPf+Pwq64LjZ2oqmV8MJetLifQiQs=;
        b=ish0aGPZwlOWsElTfmXU8aZ4rZPZahdm6rN8mJ931D7akbKCMVZ3a4dALUC7pKZktH
         MnnXVmXYgwHDs4UK+0ZTittRklGBXSCHoNGb10lojQ9c/Z/jGCbUgjpKSK+2vbRvfqnR
         ELIFu40MynISwGTzGsZVmiLz4KN6SgneHD8ZSt526vMsurk9AYmQXwg8c9YujvQVGymK
         LJIKIB6AZbq38IN1dQ3RQdsfZBQQ9Nz9ADbRSnKtB6OQU/EP6ednQYCavdzEFAEThY6P
         0EzMTM5G8z73LLbNPXo9GnB5Cp47DVwmOkXTSo4XN5uO0oORs2EphRigVAi9nwq9umTb
         nTGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791373443; x=1791978243;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l81J79D4i1POsrCPf+Pwq64LjZ2oqmV8MJetLifQiQs=;
        b=GDXQk9DysZRqEWn+ipbqPfNp8pCGsLYAsGvpv2Ox0Yp3iyAgqiv1kAlRebzBleu+FJ
         QQ6e8IgqAE0cIEX/PvTKCiKIHMj46muMbeCxrX4tMri2sEKY5HuUOEhvRucZDFaAjVFk
         UOyewmMAtkOALr6YgTDArnYUoEYug6Cn/wCzZ/OYnQd5evF4W6F5rSptK53A8+Y26y7a
         y4Gt/GAIUB9/VC6aZQUIAvv0IRR7zfheev9jzrAsbsJfJpP7RHFHL5JBsr31CaYkLqoK
         GoQOkyQW3qzb4SKri77zW9YUfHU5h4hOpYhUY8RKTJcbubpCRyZPvybnXzf9q9WVq3a5
         Xf/A==
X-Forwarded-Encrypted: i=1; AKwUvBxu9u2lvkQJGJurg1xTLeJHQtZwKRfqBMAfHz4ZEpb3IveG/IRVQ+lg1FMPpkGZow/bmarj7W8sKtC9gkKX@vger.kernel.org
X-Gm-Message-State: AFuF++lPBChj7khbaiflmK+yT2gif7hjfg4+ypG2JpMZ691jQGEZULOU
	u22RnvkgUrIEoBKZ811Lf2EQOKmjGvDDaME5ujgawHqrQ6ZHWN8I3OkZ09ErKwBIAl6RQC6aV14
	6SyLS+maq3qxfC6ORf4KhD7Vsjw==
X-Received: from pfbfs11.prod.google.com ([2002:a05:6a00:818b:b0:880:3605:84e5])
 (user=dylanbhatch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2995:b0:878:3507:8d5e with SMTP id d2e1a72fcca58-891b48f75edmr1559429b3a.37.1791373442790;
 Wed, 07 Oct 2026 04:44:02 -0700 (PDT)
Date: Wed,  7 Oct 2026 11:43:33 +0000
In-Reply-To: <20261007114335.440322-1-dylanbhatch@google.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261007114335.440322-1-dylanbhatch@google.com>
X-Mailer: git-send-email 2.56.0.360.g66cac248cb-goog
Message-ID: <20261007114335.440322-10-dylanbhatch@google.com>
Subject: [PATCH v8 09/11] arm64: entry: add unwind info for call_on_irq_stack()
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
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>
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
 arch/arm64/kernel/entry.S | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index f63049ac32dc6..3703acbeb16a5 100644
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
@@ -866,6 +872,7 @@ NOKPROBE(ret_from_fork)
  * Calls func(regs) using this CPU's irq stack and shadow irq stack.
  */
 SYM_FUNC_START(call_on_irq_stack)
+	.cfi_startproc
 	save_and_disable_daif x9
 #ifdef CONFIG_SHADOW_CALL_STACK
 	get_current_task x16
@@ -876,6 +883,9 @@ SYM_FUNC_START(call_on_irq_stack)
 	/* Create a frame record to save our LR and SP (implicit in FP) */
 	stp	x29, x30, [sp, #-16]!
 	mov	x29, sp
+	.cfi_def_cfa 29, 16
+	.cfi_offset 29, -16
+	.cfi_offset 30, -8
 
 	ldr_this_cpu x16, irq_stack_ptr, x17
 
@@ -891,9 +901,13 @@ SYM_FUNC_START(call_on_irq_stack)
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
2.56.0.360.g66cac248cb-goog

