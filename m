Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E669363C5B;
	Tue,  9 Jun 2026 06:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780986618; cv=none; b=RrkHiBTEaYwMTj2wrz5j90UhzE6qmFofq7bylRVoKwnoS/JsYys9KsYZzG/Rrx3dXZm0xNSwzjA9ssvs+6VIZAf7UaziOQFhCkbpLiUUxeBTIBZ3IfEivDZqp3555vZj/fC6mq9jrV/8bRaP0Tp2/D7dQQjXzi+SwKpz4GTvac4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780986618; c=relaxed/simple;
	bh=vc47y2MseE3FN1ND1yk8JZHsjOd/7uHey8sXVqSW4cc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AqLYvvq0QHGJI9G0wtYrrloI7pDburijkrb7ex9RIGdU8LcT/MPnFFg3yx4/udJb504WAD+mg6X3gDBOl3p4xykZl3KTay/e2oG2Ye1ywSq9+ldf0oNMNcWED5MH9zheO/vyYoFGMC6asKXuYyWlk10brKUcWQVmvpDzuUiby3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=fqrFpuAq; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="fqrFpuAq"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780986607; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=TaX/e7fsS/0tUV/XjJ/cdqlDDb/DgTOkmTQLnN0eAzU=;
	b=fqrFpuAqlDR0clCgCntCJMbm4IPQacTKb3HQAgXXK9gatUTtS80UtBCElQj1gSg6ho/u3aRRC7wQ+hBeR7p/lTFnyB2yKMkLv7qAY87mdjdAJo5qa7ZknltAaqp5DnmwMZ8qpXQB5xZKlieECQpfDIL6TE+LpLDC+0H/CnHRgbg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R731e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=wanghan@linux.alibaba.com;NM=1;PH=DS;RN=34;SR=0;TI=SMTPD_---0X4VD5.R_1780986603;
Received: from wanghan-Workstation..(mailfrom:wanghan@linux.alibaba.com fp:SMTPD_---0X4VD5.R_1780986603 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 09 Jun 2026 14:30:05 +0800
From: Wang Han <wanghan@linux.alibaba.com>
To: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Chen Pei <cp0613@linux.alibaba.com>,
	Andy Chiu <andybnac@gmail.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Deepak Gupta <debug@rivosinc.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	oliver.yang@linux.alibaba.com,
	xueshuai@linux.alibaba.com,
	zhuo.song@linux.alibaba.com,
	jkchen@linux.alibaba.com,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	live-patching@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v3 2/8] riscv: stacktrace: Add frame record metadata
Date: Tue,  9 Jun 2026 14:29:53 +0800
Message-ID: <20260609063002.3943001-2-wanghan@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.194d76e3a15b.v3.riscv-livepatch.wanghan@linux.alibaba.com>
References: <20260528082310.1994388-1-wanghan@linux.alibaba.com> <cover.194d76e3a15b.v3.riscv-livepatch.wanghan@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reliable frame-pointer unwinding needs an explicit way to identify
exception boundaries and the final entry frame. The existing unwinder
infers those boundaries from return addresses, which is too loose for a
future reliable unwinder.

Add a small metadata frame record to pt_regs and initialize it on
exception entry, kernel stack overflow, kernel thread fork, user fork,
and early idle task setup. The record uses a zero {fp, ra} sentinel plus
a type field so a later unwinder can distinguish a final user-to-kernel
boundary from a nested kernel pt_regs boundary.

This follows the arm64 metadata frame-record model, adapted to the
RISC-V {fp, ra} frame record convention.

The metadata is established at the RISC-V entry boundaries that need an
explicit unwind marker:

  * exception entry clears the metadata {fp, ra} pair and uses SPP
    (or MPP in M-mode) to record whether the pt_regs frame is the final
    user-to-kernel boundary or a nested kernel boundary;
  * the kernel stack overflow path builds a nested pt_regs metadata
    record on the overflow stack so an unwinder can resume from the
    pre-overflow s0 saved in PT_S0;
  * _start_kernel builds the init task's final metadata record, while
    the secondary CPU path sets up s0 before smp_callin() so idle-task
    unwinding does not inherit an undefined caller frame;
  * copy_thread creates matching final metadata records for new kernel
    and user tasks, and keeps s0 available for the frame-pointer chain;
  * call_on_irq_stack still reserves an aligned stack slot, but links the
    saved {fp, ra} with the raw frame-record size so s0 points at the
    RISC-V frame record rather than past the alignment padding.

The call_on_irq_stack adjustment fixes a latent RV32 issue. On RV64,
sizeof(struct stackframe) is equal to the stack alignment, so the old
s0 value happened to point just above the saved {fp, ra}. On RV32, the
raw frame record is 8 bytes while the reserved stack slot is 16-byte
aligned, so the old s0 value pointed into the padding. Using the raw
record size makes s0 point above the saved frame record on both RV32
and RV64 while still reserving the aligned slot.

These changes keep s0 reserved for the frame-pointer chain at task and
stack-switch boundaries.

Signed-off-by: Wang Han <wanghan@linux.alibaba.com>
---
 arch/riscv/include/asm/ptrace.h           |  9 ++++
 arch/riscv/include/asm/stacktrace/frame.h | 53 +++++++++++++++++++++++
 arch/riscv/kernel/asm-offsets.c           |  4 ++
 arch/riscv/kernel/entry.S                 | 43 ++++++++++++++++--
 arch/riscv/kernel/head.S                  | 23 ++++++++++
 arch/riscv/kernel/process.c               | 33 +++++++++++++-
 6 files changed, 159 insertions(+), 6 deletions(-)
 create mode 100644 arch/riscv/include/asm/stacktrace/frame.h

diff --git a/arch/riscv/include/asm/ptrace.h b/arch/riscv/include/asm/ptrace.h
index addc8188152f..4b9b0f279214 100644
--- a/arch/riscv/include/asm/ptrace.h
+++ b/arch/riscv/include/asm/ptrace.h
@@ -8,6 +8,7 @@
 
 #include <uapi/asm/ptrace.h>
 #include <asm/csr.h>
+#include <asm/stacktrace/frame.h>
 #include <linux/compiler.h>
 
 #ifndef __ASSEMBLER__
@@ -53,6 +54,14 @@ struct pt_regs {
 	unsigned long cause;
 	/* a0 value before the syscall */
 	unsigned long orig_a0;
+
+	/*
+	 * This frame record is entirely zeroed on exception entry, allowing the
+	 * unwinder to identify exception boundaries. The type field encodes
+	 * whether the exception was taken from user (FINAL) or kernel (PT_REGS)
+	 * mode.
+	 */
+	struct frame_record_meta stackframe;
 };
 
 #define PTRACE_SYSEMU			0x1f
diff --git a/arch/riscv/include/asm/stacktrace/frame.h b/arch/riscv/include/asm/stacktrace/frame.h
new file mode 100644
index 000000000000..5720a6c65fe8
--- /dev/null
+++ b/arch/riscv/include/asm/stacktrace/frame.h
@@ -0,0 +1,53 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __ASM_RISCV_STACKTRACE_FRAME_H
+#define __ASM_RISCV_STACKTRACE_FRAME_H
+
+/*
+ * See: arch/arm64/include/asm/stacktrace/frame.h for the reference
+ * implementation.
+ */
+
+/*
+ * - FRAME_META_TYPE_NONE
+ *
+ *   This value is reserved.
+ *
+ * - FRAME_META_TYPE_FINAL
+ *
+ *   The record is the last entry on the stack.
+ *   Unwinding should terminate successfully.
+ *
+ * - FRAME_META_TYPE_PT_REGS
+ *
+ *   The record is embedded within a struct pt_regs, recording the registers at
+ *   an arbitrary point in time.
+ *   Unwinding should consume pt_regs::epc, followed by pt_regs::ra.
+ *
+ * Note: all other values are reserved and should result in unwinding
+ * terminating with an error.
+ */
+#define FRAME_META_TYPE_NONE		0
+#define FRAME_META_TYPE_FINAL		1
+#define FRAME_META_TYPE_PT_REGS		2
+
+#ifndef __ASSEMBLER__
+/*
+ * A standard RISC-V frame record.
+ */
+struct frame_record {
+	unsigned long fp;
+	unsigned long ra;
+};
+
+/*
+ * A metadata frame record indicating a special unwind.
+ * The record::{fp,ra} fields must be zero to indicate the presence of
+ * metadata.
+ */
+struct frame_record_meta {
+	struct frame_record record;
+	unsigned long type;
+};
+#endif /* __ASSEMBLER__ */
+
+#endif /* __ASM_RISCV_STACKTRACE_FRAME_H */
diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
index af827448a609..8dfcb5a44bb8 100644
--- a/arch/riscv/kernel/asm-offsets.c
+++ b/arch/riscv/kernel/asm-offsets.c
@@ -131,6 +131,9 @@ void asm_offsets(void)
 	OFFSET(PT_BADADDR, pt_regs, badaddr);
 	OFFSET(PT_CAUSE, pt_regs, cause);
 
+	DEFINE(S_STACKFRAME,		offsetof(struct pt_regs, stackframe));
+	DEFINE(S_STACKFRAME_TYPE,	offsetof(struct pt_regs, stackframe.type));
+
 	OFFSET(SUSPEND_CONTEXT_REGS, suspend_context, regs);
 
 	OFFSET(HIBERN_PBE_ADDR, pbe, address);
@@ -501,6 +504,7 @@ void asm_offsets(void)
 	OFFSET(SBI_HART_BOOT_STACK_PTR_OFFSET, sbi_hart_boot_data, stack_ptr);
 
 	DEFINE(STACKFRAME_SIZE_ON_STACK, ALIGN(sizeof(struct stackframe), STACK_ALIGN));
+	DEFINE(STACKFRAME_RECORD_SIZE, sizeof(struct stackframe));
 	OFFSET(STACKFRAME_FP, stackframe, fp);
 	OFFSET(STACKFRAME_RA, stackframe, ra);
 #ifdef CONFIG_FUNCTION_TRACER
diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index d011fb51c59a..8df74d14b551 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -11,6 +11,7 @@
 #include <asm/asm.h>
 #include <asm/csr.h>
 #include <asm/scs.h>
+#include <asm/stacktrace/frame.h>
 #include <asm/unistd.h>
 #include <asm/page.h>
 #include <asm/thread_info.h>
@@ -193,6 +194,27 @@ SYM_CODE_START(handle_exception)
 	REG_S s4, PT_CAUSE(sp)
 	REG_S s5, PT_TP(sp)
 
+	/*
+	 * Create a metadata frame record. The unwinder will use this to
+	 * identify and unwind exception boundaries.
+	 */
+	REG_S zero, (S_STACKFRAME + STACKFRAME_FP)(sp) /* stackframe.record.fp = 0 */
+	REG_S zero, (S_STACKFRAME + STACKFRAME_RA)(sp) /* stackframe.record.ra = 0 */
+#ifdef CONFIG_RISCV_M_MODE
+	li t0, SR_MPP
+	and t0, s1, t0
+#else
+	andi t0, s1, SR_SPP
+#endif
+	bnez t0, 1f
+	li t0, FRAME_META_TYPE_FINAL
+	j 2f
+1:
+	li t0, FRAME_META_TYPE_PT_REGS
+2:
+	REG_S t0, S_STACKFRAME_TYPE(sp)
+	addi s0, sp, S_STACKFRAME + STACKFRAME_RECORD_SIZE
+
 	/*
 	 * Set the scratch register to 0, so that if a recursive exception
 	 * occurs, the exception vector knows it came from the kernel
@@ -349,6 +371,19 @@ SYM_CODE_START_LOCAL(handle_kernel_stack_overflow)
 	REG_S s3, PT_BADADDR(sp)
 	REG_S s4, PT_CAUSE(sp)
 	REG_S s5, PT_TP(sp)
+
+	/*
+	 * Create a metadata frame record for the overflow pt_regs. The
+	 * overflow path is entered from kernel context, so this is a nested
+	 * pt_regs boundary and the unwinder can resume from the pre-overflow
+	 * frame pointer saved in PT_S0.
+	 */
+	REG_S zero, (S_STACKFRAME + STACKFRAME_FP)(sp)
+	REG_S zero, (S_STACKFRAME + STACKFRAME_RA)(sp)
+	li t0, FRAME_META_TYPE_PT_REGS
+	REG_S t0, S_STACKFRAME_TYPE(sp)
+	addi s0, sp, S_STACKFRAME + STACKFRAME_RECORD_SIZE
+
 	move a0, sp
 	tail handle_bad_stack
 SYM_CODE_END(handle_kernel_stack_overflow)
@@ -357,8 +392,8 @@ ASM_NOKPROBE(handle_kernel_stack_overflow)
 
 SYM_CODE_START(ret_from_fork_kernel_asm)
 	call schedule_tail
-	move a0, s1 /* fn_arg */
-	move a1, s0 /* fn */
+	move a0, s3 /* fn_arg */
+	move a1, s2 /* fn */
 	move a2, sp /* pt_regs */
 	call ret_from_fork_kernel
 	j ret_from_exception
@@ -383,7 +418,7 @@ SYM_FUNC_START(call_on_irq_stack)
 	addi	sp, sp, -STACKFRAME_SIZE_ON_STACK
 	REG_S	ra, STACKFRAME_RA(sp)
 	REG_S	s0, STACKFRAME_FP(sp)
-	addi	s0, sp, STACKFRAME_SIZE_ON_STACK
+	addi	s0, sp, STACKFRAME_RECORD_SIZE
 
 	/* Switch to the per-CPU shadow call stack */
 	scs_save_current
@@ -399,7 +434,7 @@ SYM_FUNC_START(call_on_irq_stack)
 	scs_load_current
 
 	/* Switch back to the thread stack and restore ra and s0 */
-	addi	sp, s0, -STACKFRAME_SIZE_ON_STACK
+	addi	sp, s0, -STACKFRAME_RECORD_SIZE
 	REG_L	ra, STACKFRAME_RA(sp)
 	REG_L	s0, STACKFRAME_FP(sp)
 	addi	sp, sp, STACKFRAME_SIZE_ON_STACK
diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index f6a8ca49e627..00e16a24f149 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -14,6 +14,7 @@
 #include <asm/hwcap.h>
 #include <asm/image.h>
 #include <asm/scs.h>
+#include <asm/stacktrace/frame.h>
 #include <asm/usercfi.h>
 #include "efi-header.S"
 
@@ -177,6 +178,14 @@ secondary_start_sbi:
 	REG_S a0, (a1)
 1:
 #endif
+
+	/*
+	 * Set up the frame pointer for the secondary idle task so reliable
+	 * stack unwinding terminates at the metadata frame in task_pt_regs().
+	 * Without this, the first frame records can inherit an undefined caller
+	 * fp and unwind past smp_callin() into .Lsecondary_park.
+	 */
+	addi s0, sp, S_STACKFRAME + STACKFRAME_RECORD_SIZE
 	scs_load_current
 	call smp_callin
 #endif /* CONFIG_SMP */
@@ -305,6 +314,20 @@ SYM_CODE_START(_start_kernel)
 	la tp, init_task
 	la sp, init_thread_union + THREAD_SIZE
 	addi sp, sp, -PT_SIZE_ON_STACK
+
+	/*
+	 * Set up a metadata frame record for the init task so that
+	 * the unwinder can identify the outermost frame by its
+	 * {fp, ra} = {0, 0} sentinel at the bottom of pt_regs.
+	 * fp/s0 points above the metadata record (RISC-V
+	 * convention).
+	 */
+	REG_S zero, (S_STACKFRAME + STACKFRAME_FP)(sp)
+	REG_S zero, (S_STACKFRAME + STACKFRAME_RA)(sp)
+	li t0, FRAME_META_TYPE_FINAL
+	REG_S t0, S_STACKFRAME_TYPE(sp)
+	addi s0, sp, S_STACKFRAME + STACKFRAME_RECORD_SIZE
+
 #if defined(CONFIG_RISCV_SBI) && defined(CONFIG_RISCV_USER_CFI)
 	li a7, SBI_EXT_FWFT
 	li a6, SBI_EXT_FWFT_SET
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index b2df7f72241a..0dc90bf7a652 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -258,8 +258,23 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 		/* Supervisor/Machine, irqs on: */
 		childregs->status = SR_PP | SR_PIE;
 
-		p->thread.s[0] = (unsigned long)args->fn;
-		p->thread.s[1] = (unsigned long)args->fn_arg;
+		/*
+		 * Set up a metadata frame record at the bottom of the
+		 * stack for the unwinder. Use FRAME_META_TYPE_FINAL
+		 * since this is the outermost kernel entry for the new
+		 * task. The frame_record::{fp,ra} are already zero from
+		 * memset().
+		 *
+		 * fp/s0 points above the metadata record (RISC-V
+		 * convention). fn and fn_arg are passed via s2/s3,
+		 * keeping s0 available for the frame pointer chain.
+		 */
+		childregs->stackframe.type = FRAME_META_TYPE_FINAL;
+
+		p->thread.s[0] = (unsigned long)(&childregs->stackframe)
+				+ sizeof(struct frame_record);
+		p->thread.s[2] = (unsigned long)args->fn;
+		p->thread.s[3] = (unsigned long)args->fn_arg;
 		p->thread.ra = (unsigned long)ret_from_fork_kernel_asm;
 	} else {
 		/* allocate new shadow stack if needed. In case of CLONE_VM we have to */
@@ -278,6 +293,20 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 		if (clone_flags & CLONE_SETTLS)
 			childregs->tp = tls;
 		childregs->a0 = 0; /* Return value of fork() */
+
+		/*
+		 * Set up the unwind boundary: ensure the metadata
+		 * frame record has its {fp,ra} sentinel zeroed and
+		 * point fp/s0 above the metadata record. Mark it as
+		 * FINAL since this is the outermost kernel entry for
+		 * the new task.
+		 */
+		childregs->stackframe.record.fp = 0;
+		childregs->stackframe.record.ra = 0;
+		childregs->stackframe.type = FRAME_META_TYPE_FINAL;
+		p->thread.s[0] = (unsigned long)(&childregs->stackframe)
+				+ sizeof(struct frame_record);
+
 		p->thread.ra = (unsigned long)ret_from_fork_user_asm;
 	}
 	p->thread.riscv_v_flags = 0;
-- 
2.43.0

