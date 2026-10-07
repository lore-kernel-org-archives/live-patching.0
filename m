Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FC2492525
	for <live-patching@vger.kernel.org>; Wed,  7 Oct 2026 11:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791373465; cv=none; b=WCd4UgxnsKSJMWJl30/GC0pjzUuJ5W0M8Gy1xjzaPB4IEUqxS7obMl0lGsbTc9aYDUIr2Jf+GSSoxjrcA7Wr4AG4YmxQM9imxz/3kCRyplUqNW0zpv/IC8v4uuVGMLPZhCPzybCSSiQhcl16B/ubJB5++ZjhGVCkpCV2wXzAHh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791373465; c=relaxed/simple;
	bh=Vmj9YytmPy9ZL0StslQX+SkiMs58LX6OkLdyNwxdsmw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UksovmHuZoay8YSL9p8/WIoizKliBaC4ZhsSJmmatUMRmkR/xOdbJlQ29y2yL0ddQa41Vo7PDIjePyz2m8q5f3g2fqenaE+G5s/0fI7263o0bPeKNYFEwwaZdrHOlmP4yYuGzCFeGPfugbcylVEIDP8RzMXiVxX7ZagDp8sKkcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dylanbhatch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f38t3ER0; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dylanbhatch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f38t3ER0"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3a47617a0b3so4017099a91.2
        for <live-patching@vger.kernel.org>; Wed, 07 Oct 2026 04:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791373448; x=1791978248; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eFSHjFOLKNYfg5vGl5+rLOLoS1KQOBHgGSX+EFL2Pdg=;
        b=f38t3ER05wIcrglKkmBFK29SW8HsuDDi9WpC3vYWo9sGcBQSdZrQTyKnnOr5sAWkr0
         zcNNDw39UIwmyBAPJn8vOeYU5r2Ux6FVxIDfWsJ/biHFM04Y47fv7cK9YbqoJ8A+GJeF
         S6QagUgCJHTbgDgw07qJSY95DAMvpckLV4xx+RndwRUS3WkJAS4GA8W/bqQl+sjAggL9
         LmDGB/BsMEiD0nlaq8VdmQyBCh4uVswqSTCG3g4+z8x4pSHWQEbaJNMNV1dD1YS71JjW
         Y7eCffGij+peweZjL6pKe3XZjl1uDr1hzF8MxTq4hsLhn1hV4t+IDPXnXJy29OcDzM95
         5K5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791373448; x=1791978248;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eFSHjFOLKNYfg5vGl5+rLOLoS1KQOBHgGSX+EFL2Pdg=;
        b=YhHfA1TvEBkPs13hEx0Wyu5H0wcsE+cEJLQF/GH8hE80h1fn9Ld2VsV9lwavsWZYd7
         fpVaedh9A2bzrmn7RSWlLZlRQMlmovuQCI/e6VtdvkxIdvdcwh/MpraDm5FCP5PKgBDb
         gPeTC4yyZi1L/ARHuRZSTZ6uS/aXo3+zjzu9b0SmLtJS2FFkhYgw1g/62UQ2tHZqyFc1
         fWIOEeNi+0rPvOi3g3RJ//aClrudqbxveeTusVoF0bXg/ZhPdRAnU1Fs9arp5v9j5xl8
         6rG0N7onus/XEvGgYVA/2SB5loV3tOWptyVXGFOixGb8jC+H++zIXc3oy8o7TntEeBAY
         urow==
X-Forwarded-Encrypted: i=1; AKwUvBztK9ddLQUJ1CHEg0LzyAFLFlKo5wYJCq30NWCVD1kv8Y9NFtLJ/9nopmgBviu0TA0c4SY2fsGeNN/SdhWe@vger.kernel.org
X-Gm-Message-State: AFq9FYIRSBCniO3VM2ZC2nRjsXxlkx5y7VTR7b68lLN1yWWYh7culHg5
	YaHKCM0bl0FA16e4S2ZOtKioUoQ+RWf4OEfCOVDYkmtSbsqaxTV9t6iVowUkXnsAYJ0AEdK9TJo
	DBENk6YqLv9KrA1/Pj9K7i1PQjQ==
X-Received: from pjyp8.prod.google.com ([2002:a17:90a:e708:b0:3a7:ae0:3e6f])
 (user=dylanbhatch job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:544b:b0:3a8:5d57:a5e7 with SMTP id 98e67ed59e1d1-3a8a0ba18dbmr1349017a91.28.1791373447919;
 Wed, 07 Oct 2026 04:44:07 -0700 (PDT)
Date: Wed,  7 Oct 2026 11:43:35 +0000
In-Reply-To: <20261007114335.440322-1-dylanbhatch@google.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261007114335.440322-1-dylanbhatch@google.com>
X-Mailer: git-send-email 2.56.0.360.g66cac248cb-goog
Message-ID: <20261007114335.440322-12-dylanbhatch@google.com>
Subject: [PATCH v8 11/11] unwind: arm64: Use sframe to unwind interrupt frames
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
 arch/arm64/kernel/stacktrace.c | 184 +++++++++++++++++++++++++++++++--
 1 file changed, 173 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index 3ebcf8c53fb04..67f3f56fd994b 100644
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
@@ -181,7 +185,6 @@ int kunwind_next_regs_pc(struct kunwind_state *state)
 	state->regs = regs;
 	state->common.pc = regs->pc;
 	state->common.fp = regs->regs[29];
-	state->regs = NULL;
 	state->source = KUNWIND_SOURCE_REGS_PC;
 	return 0;
 }
@@ -244,6 +247,162 @@ kunwind_next_frame_record(struct kunwind_state *state)
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
+		if (state->common.fp < state->regs->sp)
+			return -EINVAL;
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
@@ -259,10 +418,20 @@ kunwind_next(struct kunwind_state *state)
 	state->flags.all = 0;
 
 	switch (state->source) {
+	case KUNWIND_SOURCE_REGS_PC:
+		err = kunwind_next_regs_sframe(state);
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
@@ -393,15 +562,7 @@ noinline noinstr void arch_stack_walk(stack_trace_consume_fn consume_entry,
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
@@ -452,6 +613,7 @@ static const char *state_source_string(const struct kunwind_state *state)
 	case KUNWIND_SOURCE_CALLER:	return "C";
 	case KUNWIND_SOURCE_TASK:	return "T";
 	case KUNWIND_SOURCE_REGS_PC:	return "P";
+	case KUNWIND_SOURCE_REGS_LR:	return "L";
 	default:			return "U";
 	}
 }
-- 
2.56.0.360.g66cac248cb-goog

