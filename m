Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794881230;
	b=Rz/1/r52LQ/53xeU61BjQ9UOfueVTKH1Hv54W6gq9TrVSv3ZmuPDW14IRA6keHVz0yxK
	 nmBjxfxo+i2xx7p50c2LNCZYC3AwtgUyQSrpLDclRDBtEACnQqWOsZ8+VWGaGuLciBQEw
	 LBYe/L+bdIBfHshy1pXPopv5GcbtrXTy5ynqFlAmGJ1t6AnzpNjdYHMpfpLdqqabc6RR3
	 P16+RguCihASb9VTHgcOH1z3RFOwLcOtuetwgrWGxWWVhjYDz1ZKbv4LMnp0JWxFl8Xss
	 7zdxDL6sNYe5qwFcczd8TesI71CS3MH5fFJCTqVJefRHNuZm8HpwwgxbIdqAUNOh3zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794881230;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=vA+hkqkTbHX9a8DOepJDZfPRSPWPvv4RpwYIaThVROM=;
	b=JjhIaPSFJBrSrZx1EAxa13OPqGppZQlUokQ+G4U7k/cxQYi94+SefiY3kRB2pQPqmJ09
	 NBCuY2DsJBr+hpG5y+d6Tb4ALdROyGFCJ+jmUGaJaYL7Ea0U9nmrWHs4v+OLKxjDAHPSF
	 PVElqM/S2dzenta67SWYX/xOCICCTW3l3Gb6dUo/dzAQgWejPMa8mFW83NJ4u6syHthb7
	 oN4TXBFPdo2NonXxkcIFkGGNa3gDcIZeg+5l4iadc1yEOMzgR1TZw8xVDsoOaKvTzjyDn
	 GqVX1lOTKdbsJcOUZl0s3l7CpGZ7TJkJ3vpSabiHj2wAyJRpDcxrJeqUVBxB9flf9ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dylanbhatch.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=brA4y9Yi;
	arc=none smtp.remote-ip=209.85.215.199
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68617606A88D
	for <live-patching@vger.kernel.org>; Tue, 17 Nov 2026 02:07:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68617606A88D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dylanbhatch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=brA4y9Yi
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cdb8c46e240so2278037a12.1
        for <live-patching@vger.kernel.org>; Mon, 16 Nov 2026 18:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794881230; x=1795486030; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vA+hkqkTbHX9a8DOepJDZfPRSPWPvv4RpwYIaThVROM=;
        b=brA4y9YiVZeZWAxSwQVEU8SVfn4A7zza8CU/05H6YVzEOzwC/V3jDv6XoG9UEy2mjh
         yHcXADr8oxBWxXE6nuHQ/hmeGgy3xofusAJOyhRiB/Z9xaeMLxUNoWLK8Y9+NXlZvsi8
         5o9oQi5T1U90TwX0RsqWv2KnVvzXJeKgnMZT6cLjFyTBPwBcqVyquvaK/HzWv/ffjr7w
         0jPW4ufAdBlmY1Z7XigIcbWgMIhGcy9b/FK+R5/EFqECeQ54d5BsYz4kulp0w+nahOzj
         HS6riKVUSg7hQDTYMg3hXK0rebyylq+ubrXm5rBQFVLqA2gHT1AAcJEla3Dzp818nmlr
         d2Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794881230; x=1795486030;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vA+hkqkTbHX9a8DOepJDZfPRSPWPvv4RpwYIaThVROM=;
        b=dNqRVnkGRsQkAabJ54BX+GJjzTQf/cHLupsWCaeYDBXc6D8gvWoIOjr3P/JvR99un5
         F8JVaDQZTDro/5tIVdXGZ+jCLC6P7gPevTgPfdA+D1SYhhJaodzV4yztCxP1lqCUNytJ
         PDVD9ww564tZ7Xk2eCszsY4K9ReKnFsaCxf2pWKYEUgXjQr0O0lURf6Hbv+3kRqg98Ha
         mHqzkgwUlbwIHVIYizarYRobK5WZl13S3P9TOwB+8my7I1gQatJEEUOnG2cziORd+k47
         vU3GZrPsr+JMptrTXrj3KbohbPWF1muMGp+nEXer3SecrcsZd9nj3mEiSbdMw68FXUWJ
         b74A==
X-Forwarded-Encrypted: i=1; AL+hErEjlzbtXccTRC/NOlywJmoa1aeAInGuWTo55flrBSI1zfiRXP/+OY9f1Ej8m2eIfE/TkstBfmlusZptwQcZ@vger.kernel.org
X-Gm-Message-State: APuU4Z+iResr8gzG/zjkD+3ZLv7Yhk4DCKi54KM8IjZkpL+4GEz08h2D
	bMzrryPyqCmaTJi3t3tSVYirfLZqRJjHyXX64JEcoY3/UUNdIVzvQsizdId1F2Dm/R2kn91RIlC
	pETe2QlAYfB/BwWlcstl/umk1+w==
X-Received: from pgjk8-n1.prod.google.com ([2002:a05:6a02:81c8:10b0:cdb:932c:948b])
 (user=dylanbhatch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:7e05:b0:3e2:b85c:4b2a with SMTP id adf61e73a8af0-3f7a8fe1586mr9088034637.73.1794881229362;
 Mon, 16 Nov 2026 18:07:09 -0800 (PST)
Date: Tue, 17 Nov 2026 02:06:48 +0000
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
Message-ID: <20261117020648.323464-12-dylanbhatch@google.com>
Subject: [PATCH v9 11/11] unwind: arm64: Use sframe to unwind interrupt frames
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

Add kunwind_next_regs_sframe() function to unwind by sframe info if
present. Use this method at exception boundaries, falling back to
frame-pointer unwind only on failure. In such failure cases, the
stacktrace is considered unreliable. During normal unwind, prefer frame
pointer unwind (for better performance).

This change restores the LR behavior originally introduced in commit
c2c6b27b5aa14fa2 ("arm64: stacktrace: unwind exception boundaries"),
But later removed in commit 32ed1205682e ("arm64: stacktrace: Skip
reporting LR at exception boundaries")

This can be done because the sframe data can be used to determine
whether the LR is current for the PC value recovered from pt_regs at the
exception boundary.

Co-developed-by: Weinan Liu <wnliu@google.com>
Signed-off-by: Weinan Liu <wnliu@google.com>
Reviewed-by: Prasanna Kumar T S M <ptsm@linux.microsoft.com>
Reviewed-by: Jens Remus <jremus@linux.ibm.com>
Signed-off-by: Dylan Hatch <dylanbhatch@google.com>

---

Changes since v8:
 - (sashiko) Restrict SFrame unwinding at KUNWIND_SOURCE_REGS_PC to real
   on-stack FRAME_META_TYPE_PT_REGS exception frames so synthetic pt_regs
   fall back to frame-pointer unwinding.
 - (sashiko) Remove invalid cross-stack 'fp < sp' check in
   UNWIND_CFA_RULE_FP_OFFSET and enforce 8-byte alignment in get_word().
 - (sashiko) Propagate state->unreliable when kunwind_next() terminates
   with -ENOENT in do_kunwind().
---
 arch/arm64/kernel/stacktrace.c | 211 +++++++++++++++++++++++++++++++--
 1 file changed, 198 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index 3ebcf8c53fb04..e876af54a4055 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -13,6 +13,7 @@
 #include <linux/sched.h>
 #include <linux/sched/debug.h>
 #include <linux/sched/task_stack.h>
+#include <linux/sframe.h>
 #include <linux/stacktrace.h>
 
 #include <asm/efi.h>
@@ -26,6 +27,7 @@ enum kunwind_source {
 	KUNWIND_SOURCE_CALLER,
 	KUNWIND_SOURCE_TASK,
 	KUNWIND_SOURCE_REGS_PC,
+	KUNWIND_SOURCE_REGS_LR,
 };
 
 union unwind_flags {
@@ -45,6 +47,7 @@ union unwind_flags {
  * @kr_cur:      When KRETPROBES is selected, holds the kretprobe instance
  *               associated with the most recently encountered replacement lr
  *               value.
+ * @unreliable:  Stacktrace is unreliable.
  */
 struct kunwind_state {
 	struct unwind_state common;
@@ -56,6 +59,7 @@ struct kunwind_state {
 	enum kunwind_source source;
 	union unwind_flags flags;
 	struct pt_regs *regs;
+	bool unreliable;
 };
 
 static __always_inline void
@@ -80,12 +84,31 @@ static __always_inline void
 kunwind_init_from_regs(struct kunwind_state *state,
 		       struct pt_regs *regs)
 {
+	struct stack_info *info;
+
 	kunwind_init(state, current);
 
-	state->regs = regs;
 	state->common.fp = regs->regs[29];
 	state->common.pc = regs->pc;
 	state->source = KUNWIND_SOURCE_REGS_PC;
+
+	/*
+	 * Synthetic pt_regs (e.g. from perf_fetch_caller_regs() or
+	 * ftrace_fill_perf_regs()) do not have a full register state
+	 * consistent with regs->pc and cannot be unwound with SFrame.
+	 * Real exception pt_regs have FRAME_META_TYPE_PT_REGS.
+	 */
+	if (!regs->stackframe.record.fp && !regs->stackframe.record.lr &&
+	    regs->stackframe.type == FRAME_META_TYPE_PT_REGS) {
+		info = unwind_find_stack(&state->common, (unsigned long)regs,
+					 sizeof(*regs));
+		if (info) {
+			unwind_consume_stack(&state->common, info,
+					     (unsigned long)regs,
+					     sizeof(*regs));
+			state->regs = regs;
+		}
+	}
 }
 
 /*
@@ -181,7 +204,6 @@ int kunwind_next_regs_pc(struct kunwind_state *state)
 	state->regs = regs;
 	state->common.pc = regs->pc;
 	state->common.fp = regs->regs[29];
-	state->regs = NULL;
 	state->source = KUNWIND_SOURCE_REGS_PC;
 	return 0;
 }
@@ -244,6 +266,163 @@ kunwind_next_frame_record(struct kunwind_state *state)
 	return 0;
 }
 
+#ifdef CONFIG_HAVE_UNWIND_KERNEL_SFRAME
+
+static __always_inline struct stack_info *
+get_word(struct unwind_state *state, unsigned long *word)
+{
+	unsigned long addr = *word;
+	struct stack_info *info;
+
+	if (addr & 0x7)
+		return NULL;
+
+	info = unwind_find_stack(state, addr, sizeof(addr));
+	if (!info)
+		return info;
+
+	*word = READ_ONCE(*(unsigned long *)addr);
+
+	return info;
+}
+
+static __always_inline int
+get_consume_word(struct unwind_state *state, unsigned long *word)
+{
+	struct stack_info *info;
+	unsigned long addr = *word;
+
+	info = get_word(state, word);
+	if (!info)
+		return -EINVAL;
+
+	unwind_consume_stack(state, info, addr, sizeof(addr));
+	return 0;
+}
+
+/*
+ * Unwind from a pt_regs according to sframe.
+ */
+static __always_inline int
+kunwind_next_regs_sframe(struct kunwind_state *state)
+{
+	struct unwind_frame frame;
+	unsigned long cfa, fp, ra;
+	enum kunwind_source source = KUNWIND_SOURCE_FRAME;
+	struct pt_regs *regs = state->regs;
+
+	int err;
+
+	if (WARN_ON_ONCE(state->source != KUNWIND_SOURCE_REGS_PC))
+		return -EINVAL;
+	if (WARN_ON_ONCE(!state->regs))
+		return -EINVAL;
+
+	/* FP/SP alignment 8 bytes */
+	if (state->common.fp & 0x7)
+		return -EINVAL;
+
+	err = sframe_find(state->common.pc, &frame);
+	if (err)
+		return -EINVAL;
+
+	/*
+	 * A kernel unwind should always end at a FRAME_META_TYPE_FINAL
+	 * frame. There should be no outermost frames within the kernel.
+	 */
+	if (frame.outermost)
+		return -EINVAL;
+
+	/* Get the Canonical Frame Address (CFA) */
+	switch (frame.cfa.rule) {
+	case UNWIND_CFA_RULE_SP_OFFSET:
+		cfa = state->regs->sp;
+		break;
+	case UNWIND_CFA_RULE_FP_OFFSET:
+		cfa = state->common.fp;
+		break;
+	/*
+	 * UNWIND_CFA_RULE_REG_OFFSET and UNWIND_CFA_RULE_REG_OFFSET_DEREF not
+	 * implemented -- flexible FDEs are not currently generated by assembler
+	 * for arm64.
+	 */
+	default:
+		WARN_ON_ONCE(1);
+		return -EINVAL;
+	}
+	cfa += frame.cfa.offset;
+
+	/* CFA alignment 16 bytes */
+	if (cfa & 0xf)
+		return -EINVAL;
+
+	/*
+	 * Consume RA and FP from the stack. The frame record puts FP at a lower
+	 * address than RA, so we read FP first.
+	 */
+	switch (frame.fp.rule) {
+	case UNWIND_RULE_RETAIN:
+		fp = state->common.fp;
+		break;
+	/*
+	 * UNWIND_RULE_CFA_OFFSET is currently not used for FP
+	 * (e.g. SFrame cannot represent this rule).
+	 */
+	case UNWIND_RULE_CFA_OFFSET_DEREF:
+		fp = cfa + frame.fp.offset;
+		if (!get_word(&state->common, &fp))
+			return -EINVAL;
+		break;
+	/*
+	 * UNWIND_RULE_REG_OFFSET and UNWIND_RULE_REG_OFFSET_DEREF not
+	 * implemented -- flexible FDEs are not currently generated by assembler
+	 * for arm64.
+	 */
+	default:
+		WARN_ON_ONCE(1);
+		return -EINVAL;
+	}
+
+	switch (frame.ra.rule) {
+	case UNWIND_RULE_RETAIN:
+		ra = regs->regs[30];
+		source = KUNWIND_SOURCE_REGS_LR;
+		break;
+
+	/*
+	 * UNWIND_RULE_CFA_OFFSET doesn't make sense for RA.
+	 * The return address cannot legitimately be a stack address.
+	 */
+	case UNWIND_RULE_CFA_OFFSET_DEREF:
+		ra = cfa + frame.ra.offset;
+		if (get_consume_word(&state->common, &ra))
+			return -EINVAL;
+		break;
+	/*
+	 * UNWIND_RULE_REG_OFFSET and UNWIND_RULE_REG_OFFSET_DEREF not
+	 * implemented -- flexible FDEs are not currently generated by assembler
+	 * for arm64.
+	 */
+	default:
+		WARN_ON_ONCE(1);
+		return -EINVAL;
+	}
+
+	state->common.pc = ra;
+	state->common.fp = fp;
+
+	state->source = source;
+
+	return 0;
+}
+
+#else /* !CONFIG_HAVE_UNWIND_KERNEL_SFRAME */
+
+static __always_inline int
+kunwind_next_regs_sframe(struct kunwind_state *state) { return -EINVAL; }
+
+#endif /* !CONFIG_HAVE_UNWIND_KERNEL_SFRAME*/
+
 /*
  * Unwind from one frame record (A) to the next frame record (B).
  *
@@ -259,10 +438,23 @@ kunwind_next(struct kunwind_state *state)
 	state->flags.all = 0;
 
 	switch (state->source) {
+	case KUNWIND_SOURCE_REGS_PC:
+		if (state->regs)
+			err = kunwind_next_regs_sframe(state);
+		else
+			err = -EINVAL;
+
+		if (err) {
+			/* Fallback to FP based unwinder */
+			err = kunwind_next_frame_record(state);
+			state->unreliable = true;
+		}
+		state->regs = NULL;
+		break;
 	case KUNWIND_SOURCE_FRAME:
 	case KUNWIND_SOURCE_CALLER:
 	case KUNWIND_SOURCE_TASK:
-	case KUNWIND_SOURCE_REGS_PC:
+	case KUNWIND_SOURCE_REGS_LR:
 		err = kunwind_next_frame_record(state);
 		break;
 	default:
@@ -294,7 +486,7 @@ do_kunwind(struct kunwind_state *state, kunwind_consume_fn consume_state,
 			return -EINVAL;
 		ret = kunwind_next(state);
 		if (ret == -ENOENT)
-			return 0;
+			return state->unreliable ? -EINVAL : 0;
 		if (ret < 0)
 			return ret;
 	}
@@ -393,15 +585,7 @@ noinline noinstr void arch_stack_walk(stack_trace_consume_fn consume_entry,
 static __always_inline bool
 arch_reliable_kunwind_consume_entry(const struct kunwind_state *state, void *cookie)
 {
-	/*
-	 * At an exception boundary we can reliably consume the saved PC. We do
-	 * not know whether the LR was live when the exception was taken, and
-	 * so we cannot perform the next unwind step reliably.
-	 *
-	 * All that matters is whether the *entire* unwind is reliable, so give
-	 * up as soon as we hit an exception boundary.
-	 */
-	if (state->source == KUNWIND_SOURCE_REGS_PC)
+	if (state->unreliable)
 		return false;
 
 	return arch_kunwind_consume_entry(state, cookie);
@@ -452,6 +636,7 @@ static const char *state_source_string(const struct kunwind_state *state)
 	case KUNWIND_SOURCE_CALLER:	return "C";
 	case KUNWIND_SOURCE_TASK:	return "T";
 	case KUNWIND_SOURCE_REGS_PC:	return "P";
+	case KUNWIND_SOURCE_REGS_LR:	return "L";
 	default:			return "U";
 	}
 }
-- 
2.56.0.679.gc527c65306-goog

