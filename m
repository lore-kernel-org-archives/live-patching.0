Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794274699;
	b=ETw4zVvqIG1BVCxSqxwA7+VHCyDnyRo4zjfh7DOiOaPAl9/T2wF3bSO0Xt8SEkavPJ/U
	 sE+afansaXZX+bZFW8HsvGK7BXev/ii6y9cDg04TnsPUtiUAaoCC9MeebvLdDJH+qJMeh
	 PwUJOk+poVDLZyXRI6focxGsr87IMenOCCfCuu1M7DLuQGItzyacB8xVr7ys1RVgZmjTe
	 r8zPAlvHZWHg01Ff/6CJ+EeNCv4lck3F2ztXPVMUpzZGtKhygaqasP1gEb3AGtOpgsKOZ
	 9mXrpNORsBEuQA86Qv8oWxTx9BBH9T7dXS/3Xfp8kY7J1qbyasuGTbLDUmkaOJejbUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794274699;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qtL12tPj0UANHhr+zb7I/FGfbJPG4yRpNtN1L+RRhXk=;
	b=3cjos4+xEU686Ijfzr6WIwPla5yGhUMlJxa7TTEugjzTDIbGj/CkxdqFSvQya46D02w2
	 Z1RfvGrdQz/KlIzXlh05jCXixSLFxXErfnKe6wDxKlkRMatngiTHkSbRGl5mBVXnodydw
	 kApbji4uSw2Kks9499pL+uQRzctEwdA4anGyumVDD02PU/jxU8MvwW0jt9GkTkBh3L8PD
	 LMQai3sT3jxwkEFfOENkSObVXNoVpG+Vz0CRU3oTBcZjLadfeb4zm34pP3+KgIyh1BIIN
	 mD3CDVWVwFyCyc/zFYI6tTqn/4gq5i68RwP0sMNOu5rIxBcNW1hR+4P1Zon3hGhB2qA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=NwFVaABC;
	arc=none smtp.remote-ip=115.124.30.133
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C1B60A2613;
	Tue, 10 Nov 2026 01:38:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91C1B60A2613
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=NwFVaABC
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1794274695; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=qtL12tPj0UANHhr+zb7I/FGfbJPG4yRpNtN1L+RRhXk=;
	b=NwFVaABCYBMmknHsf90Q5F52zFiqdoLxgWnZhWCOQfZKn7ffAOBnGn6+3VXSbaCTrPOkKRnhLn5NuXYJdqAuMmdiJ08j3Af7hQiLtLwgn4XPa04fN3rqDeJukCQ/Ez5MGOZQajML/rm6Z6MkhxJAHkdWl7pW5PJPPMx3b3gkk4s=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R371e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=36;SR=0;TI=SMTPD_---0XETOX8Q_1794274691;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0XETOX8Q_1794274691 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 10 Nov 2026 09:38:12 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: palmer@dabbelt.com,
	pjw@kernel.org,
	aou@eecs.berkeley.edu
Cc: alex@ghiti.fr,
	linux-riscv@lists.infradead.org,
	oleg@redhat.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mark.rutland@arm.com,
	peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	shuah@kernel.org,
	mpdesouza@suse.com,
	martin@kaiser.cx,
	kmehltretter@gmail.com,
	oliver.yang@linux.alibaba.com,
	zhuo.song@linux.alibaba.com,
	xueshuai@linux.alibaba.com,
	jkchen@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	live-patching@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v7 07/10] riscv: stacktrace: introduce stack-bound tracking helpers
Date: Tue, 10 Nov 2026 09:37:47 +0800
Message-Id: <20261110013750.36800-8-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261110013750.36800-1-xueshuai@linux.alibaba.com>
References: <20260914092648.51254-1-xueshuai@linux.alibaba.com>
 <20261110013750.36800-1-xueshuai@linux.alibaba.com>
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wang Han <wanghan@linux.alibaba.com>

A reliable unwinder needs to validate that every frame record it reads
is fully contained in a known kernel stack, and it needs to refuse to
walk back into a stack it has already left. Add the building blocks
for that:

  * struct stack_info / struct unwind_state in a new
    asm/stacktrace/common.h, modelled on the arm64 reference
    implementation.
  * stackinfo_get_irq() / stackinfo_get_task() / stackinfo_get_overflow()
    plus the corresponding on_*_stack() predicates in asm/stacktrace.h,
    so callers can ask "is this object on stack X?" by stack kind
    rather than open-coded address arithmetic.
  * unwind_init_common(), unwind_find_stack() and
    unwind_consume_stack() helpers that enforce the
    forward-progress-only invariant required for reliability.

No existing user is wired up to these helpers in this commit; the
unwinder switch comes in a follow-up. The header changes leave
on_thread_stack() with the same semantics as before, just expressed in
terms of the new helpers.

Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
Reviewed-by: Martin Kaiser <martin@kaiser.cx>
Tested-by: Martin Kaiser <martin@kaiser.cx>
Signed-off-by: Wang Han <wanghan@linux.alibaba.com>
Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 arch/riscv/include/asm/stacktrace.h        |  67 ++++++++-
 arch/riscv/include/asm/stacktrace/common.h | 159 +++++++++++++++++++++
 2 files changed, 224 insertions(+), 2 deletions(-)
 create mode 100644 arch/riscv/include/asm/stacktrace/common.h

diff --git a/arch/riscv/include/asm/stacktrace.h b/arch/riscv/include/asm/stacktrace.h
index b1495a7e06ce..df4d022f6430 100644
--- a/arch/riscv/include/asm/stacktrace.h
+++ b/arch/riscv/include/asm/stacktrace.h
@@ -3,8 +3,13 @@
 #ifndef _ASM_RISCV_STACKTRACE_H
 #define _ASM_RISCV_STACKTRACE_H
 
+#include <linux/percpu.h>
 #include <linux/sched.h>
+#include <linux/sched/task_stack.h>
+
+#include <asm/irq_stack.h>
 #include <asm/ptrace.h>
+#include <asm/stacktrace/common.h>
 
 struct stackframe {
 	unsigned long fp;
@@ -16,14 +21,72 @@ extern void notrace walk_stackframe(struct task_struct *task, struct pt_regs *re
 extern void dump_backtrace(struct pt_regs *regs, struct task_struct *task,
 			   const char *loglvl);
 
-static inline bool on_thread_stack(void)
+/*
+ * IRQ stack accessors
+ */
+#ifdef CONFIG_IRQ_STACKS
+static inline struct stack_info stackinfo_get_irq(void)
+{
+	unsigned long low = (unsigned long)raw_cpu_read(irq_stack_ptr);
+	unsigned long high = low + IRQ_STACK_SIZE;
+
+	return (struct stack_info) {
+		.low = low,
+		.high = high,
+	};
+}
+
+static inline bool on_irq_stack(unsigned long sp, unsigned long size)
+{
+	struct stack_info info = stackinfo_get_irq();
+
+	return stackinfo_on_stack(&info, sp, size);
+}
+#endif /* CONFIG_IRQ_STACKS */
+
+/*
+ * Task stack accessors
+ */
+static inline struct stack_info stackinfo_get_task(const struct task_struct *tsk)
 {
-	return !(((unsigned long)(current->stack) ^ current_stack_pointer) & ~(THREAD_SIZE - 1));
+	unsigned long low = (unsigned long)task_stack_page(tsk);
+	unsigned long high = low + THREAD_SIZE;
+
+	return (struct stack_info) {
+		.low = low,
+		.high = high,
+	};
+}
+
+static inline bool on_task_stack(const struct task_struct *tsk,
+				 unsigned long sp, unsigned long size)
+{
+	struct stack_info info = stackinfo_get_task(tsk);
+
+	return stackinfo_on_stack(&info, sp, size);
 }
 
+/*
+ * Cast is necessary since current->stack is an opaque ptr.
+ */
+#define on_thread_stack()	(on_task_stack(current, current_stack_pointer, 1))
 
+/*
+ * Overflow stack accessors
+ */
 #ifdef CONFIG_VMAP_STACK
 DECLARE_PER_CPU(unsigned long [OVERFLOW_STACK_SIZE/sizeof(long)], overflow_stack);
+
+static inline struct stack_info stackinfo_get_overflow(void)
+{
+	unsigned long low = (unsigned long)raw_cpu_ptr(overflow_stack);
+	unsigned long high = low + OVERFLOW_STACK_SIZE;
+
+	return (struct stack_info) {
+		.low = low,
+		.high = high,
+	};
+}
 #endif /* CONFIG_VMAP_STACK */
 
 #endif /* _ASM_RISCV_STACKTRACE_H */
diff --git a/arch/riscv/include/asm/stacktrace/common.h b/arch/riscv/include/asm/stacktrace/common.h
new file mode 100644
index 000000000000..360a26e34349
--- /dev/null
+++ b/arch/riscv/include/asm/stacktrace/common.h
@@ -0,0 +1,159 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * RISC-V common stack unwinder types and helpers.
+ *
+ * See: arch/arm64/include/asm/stacktrace/common.h for the reference
+ * implementation.
+ *
+ * Copyright (C) 2026
+ */
+#ifndef __ASM_RISCV_STACKTRACE_COMMON_H
+#define __ASM_RISCV_STACKTRACE_COMMON_H
+
+#include <linux/compiler.h>
+#include <linux/errno.h>
+#include <linux/types.h>
+
+#include <asm/stacktrace/frame.h>
+
+/**
+ * struct stack_info - describes the bounds of a stack.
+ *
+ * @low:  The lowest valid address on the stack.
+ * @high: The highest valid address on the stack.
+ */
+struct stack_info {
+	unsigned long low;
+	unsigned long high;
+};
+
+/**
+ * struct unwind_state - state used for robust unwinding.
+ *
+ * @fp:        The fp value in the frame record (or the real fp).
+ * @pc:        The ra value in the frame record (or the real ra).
+ *
+ * @stack:     The stack currently being unwound.
+ * @stacks:    An array of stacks which can be unwound.
+ * @nr_stacks: The number of stacks in @stacks.
+ */
+struct unwind_state {
+	unsigned long fp;
+	unsigned long pc;
+
+	struct stack_info stack;
+	struct stack_info *stacks;
+	int nr_stacks;
+};
+
+/**
+ * stackinfo_get_unknown() - Get an unknown stack_info.
+ *
+ * Return: a stack_info with low and high set to 0.
+ */
+static inline struct stack_info stackinfo_get_unknown(void)
+{
+	return (struct stack_info) {
+		.low = 0,
+		.high = 0,
+	};
+}
+
+/**
+ * stackinfo_on_stack() - Check whether an object is fully within a stack.
+ *
+ * @info: The stack to check against.
+ * @sp:   The base address of the object.
+ * @size: The size of the object.
+ *
+ * Return: true if the object is fully contained within the stack.
+ */
+static inline bool stackinfo_on_stack(const struct stack_info *info,
+				      unsigned long sp, unsigned long size)
+{
+	if (!info->low)
+		return false;
+
+	if (sp < info->low || sp + size < sp || sp + size > info->high)
+		return false;
+
+	return true;
+}
+
+/**
+ * unwind_init_common() - Initialize the common parts of the unwind state.
+ *
+ * @state: the unwind state to initialize.
+ */
+static inline void unwind_init_common(struct unwind_state *state)
+{
+	state->stack = stackinfo_get_unknown();
+}
+
+/**
+ * unwind_find_stack() - Find the accessible stack which entirely contains an
+ * object.
+ *
+ * @state: the current unwind state.
+ * @sp:    the base address of the object.
+ * @size:  the size of the object.
+ *
+ * Return: a pointer to the relevant stack_info if found; NULL otherwise.
+ */
+static inline struct stack_info *unwind_find_stack(struct unwind_state *state,
+						   unsigned long sp,
+						   unsigned long size)
+{
+	struct stack_info *info = &state->stack;
+
+	if (stackinfo_on_stack(info, sp, size))
+		return info;
+
+	for (int i = 0; i < state->nr_stacks; i++) {
+		info = &state->stacks[i];
+		if (stackinfo_on_stack(info, sp, size))
+			return info;
+	}
+
+	return NULL;
+}
+
+/**
+ * unwind_consume_stack() - Update stack boundaries so that future unwind steps
+ * cannot consume this object again.
+ *
+ * @state: the current unwind state.
+ * @info:  the stack_info of the stack containing the object.
+ * @sp:    the base address of the object.
+ * @size:  the size of the object.
+ *
+ * Stack transitions are strictly one-way, and once we've
+ * transitioned from one stack to another, it's never valid to
+ * unwind back to the old stack.
+ *
+ * Note that stacks can nest in several valid orders, e.g.
+ *
+ *   TASK -> IRQ -> OVERFLOW
+ *
+ * ... so we do not check the specific order of stack
+ * transitions.
+ */
+static inline void unwind_consume_stack(struct unwind_state *state,
+					struct stack_info *info,
+					unsigned long sp,
+					unsigned long size)
+{
+	struct stack_info tmp;
+
+	tmp = *info;
+	*info = stackinfo_get_unknown();
+	state->stack = tmp;
+
+	/*
+	 * Future unwind steps can only consume stack above this frame record.
+	 * Update the current stack to start immediately above it.
+	 */
+	state->stack.low = sp + size;
+}
+
+#endif /* __ASM_RISCV_STACKTRACE_COMMON_H */
-- 
2.39.3

