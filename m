Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21FD4457B2;
	Tue,  4 Aug 2026 10:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785839806; cv=none; b=MbKmPr4iZ3Z2qHcGP3nAgsVS1i4ia7JbIvtJdC85Cyh+oih+TZ/Ps0suUkCKBWnDU45SuGz1EoFhR2uHDaU/wYUWbKjXX2y/8Qh6dvm8xSXlLxyiIqUKjLPjNf0N81BhFS9oiKGHngruGQczErfWBzdGOIkC2reXiy8p8Yy1uPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785839806; c=relaxed/simple;
	bh=aoFnItxafuGwRzyxr0iB9CMcmYlbAkZEp2m0mZecDZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xn2zpSAPJyXK14qYhBgcoHPl2zZsbElZqlKt2UWl491q7jzIc9q6HBKWdpFNGjcTaxJt94ev78q4stFD1Z3c5m2tAlJePHYrwa3rsWLibKLBYJ0yI00TIP12MsTBcxfEx5NELnH95R8z/rWbJpK4rZ8aXENhyZ6FKaFBLeuBbl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=VjXmdHnk; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="VjXmdHnk"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1785839796; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=9qthyqQX/Ih/uUwRYMYrPDP5NZjEf9dKmI4Qn+fFJ20=;
	b=VjXmdHnkYMYoQwRN1jPIg2hRaZiAxxAknAyMK5g7D697Omeutczn1ZeZDR9auxHF0dJTIqvPq7sfDILvudQTh7rzs9fhhs+8kT7XhJ2sPTBtS1t/Qf1z7TZmgOQrqgQbGB08iv3KfkseCfgIYs4QUTETZkjkj0Bp1HqQlJ4JwgA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R791e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=wanghan@linux.alibaba.com;NM=1;PH=DS;RN=34;SR=0;TI=SMTPD_---0X8NlqWZ_1785839792;
Received: from wanghan-Workstation..(mailfrom:wanghan@linux.alibaba.com fp:SMTPD_---0X8NlqWZ_1785839792 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 04 Aug 2026 18:36:34 +0800
From: Wang Han <wanghan@linux.alibaba.com>
To: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Alexandre Ghiti <alex@ghiti.fr>,
	linux-riscv@lists.infradead.org,
	Oleg Nesterov <oleg@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	oliver.yang@linux.alibaba.com,
	xueshuai@linux.alibaba.com,
	zhuo.song@linux.alibaba.com,
	jkchen@linux.alibaba.com,
	Marcos Paulo de Souza <mpdesouza@suse.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	live-patching@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v5 0/7] riscv: Add reliable stack unwinding for livepatch
Date: Tue,  4 Aug 2026 18:36:19 +0800
Message-ID: <20260804103626.2803112-1-wanghan@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This is v5 of the RISC-V reliable stack unwinding series for livepatch.

The series adds explicit frame-record metadata, preserves the frame
pointer through dynamic ftrace, and replaces the open-coded stack walker
with a conservative frame-pointer based unwinder. It then enables the
RISC-V livepatch capability and adds the syscall-wrapper selftest prefix.

Changes since v4:
  * Use sizeof(struct frame_record) for STACKFRAME_RECORD_SIZE, as
    requested by Shuai Xue.
  * Guard IRQ stack accessors and IRQ stack entries with
    CONFIG_IRQ_STACKS, addressing the link-time issue reported by Shuai
    Xue and Sashiko.
  * Add the corresponding Reviewed-by tag from Shuai Xue to 1/7.
  * Rebase onto the latest riscv/for-next; no other functional changes.

The review replies have been sent in the v4 RESEND thread.

Base:
  riscv/for-next ff492e321c47 ("Revert \"riscv: hwprobe: Fix stale vDSO data for late-initialized keys at boot\"")

Previous versions:
  v4 RESEND: https://lore.kernel.org/r/20260629072713.3273743-1-wanghan@linux.alibaba.com
  v3: https://lore.kernel.org/r/cover.194d76e3a15b.v3.riscv-livepatch.wanghan@linux.alibaba.com
  v2: https://lore.kernel.org/r/20260528082310.1994388-1-wanghan@linux.alibaba.com
  v1: https://lore.kernel.org/r/20260527123530.2593918-1-wanghan@linux.alibaba.com

Validation:
  * Built Linux 7.2.0-rc6 with riscv64-unknown-linux-gnu-gcc 15.2.0
    and binutils 2.46.
  * Standard livepatch configuration built successfully, including
    Image, vmlinux, modules, compile_commands.json and GDB scripts.
  * CONFIG_IRQ_STACKS=n variant linked successfully with GCC.
  * QEMU 8.2.2, 1 CPU: livepatch selftests PASS: 7, SKIP: 1,
    FAIL: 0; ftrace function graph 3 passed, 0 failed, 3 unsupported.
  * QEMU 8.2.2, 4 CPUs: livepatch selftests PASS: 7, SKIP: 1,
    FAIL: 0; ftrace function graph 3 passed, 0 failed, 3 unsupported.
  * No BUG, WARNING, Oops, panic, unreliable stack or Call Trace found
    by the validation log scans. Expected negative livepatch errors are
    part of the selftests.

Wang Han (7):
  riscv: stacktrace: Add frame record metadata
  riscv: stacktrace: disable KASAN and KCOV instrumentation for
    stacktrace.o
  riscv: ftrace: always preserve s0 in dynamic ftrace register frame
  riscv: stacktrace: introduce stack-bound tracking helpers
  riscv: stacktrace: switch to frame-pointer based unwinder
  riscv: Kconfig: enable HAVE_RELIABLE_STACKTRACE and HAVE_LIVEPATCH
  selftests/livepatch: Add RISC-V syscall wrapper prefix

 arch/riscv/Kconfig                            |   4 +
 arch/riscv/include/asm/ptrace.h               |   9 +
 arch/riscv/include/asm/stacktrace.h           |  67 ++-
 arch/riscv/include/asm/stacktrace/common.h    | 159 +++++
 arch/riscv/include/asm/stacktrace/frame.h     |  53 ++
 arch/riscv/kernel/Makefile                    |   6 +
 arch/riscv/kernel/asm-offsets.c               |   6 +
 arch/riscv/kernel/entry.S                     |  39 +-
 arch/riscv/kernel/ftrace.c                    |   6 +-
 arch/riscv/kernel/head.S                      |  23 +
 arch/riscv/kernel/mcount-dyn.S                |   4 -
 arch/riscv/kernel/perf_callchain.c            |   2 +-
 arch/riscv/kernel/process.c                   |  33 +-
 arch/riscv/kernel/stacktrace.c                | 561 +++++++++++++++---
 .../livepatch/test_modules/test_klp_syscall.c |   2 +
 15 files changed, 868 insertions(+), 106 deletions(-)
 create mode 100644 arch/riscv/include/asm/stacktrace/common.h
 create mode 100644 arch/riscv/include/asm/stacktrace/frame.h

Range-diff against v4:
1:  8cef363cfed7 ! 1:  cbb1dc004d0f riscv: stacktrace: Add frame record metadata
    @@ Commit message
             the secondary CPU path sets up s0 before smp_callin() so idle-task
             unwinding does not inherit an undefined caller frame;
           * copy_thread creates matching final metadata records for new kernel
    -        and user tasks, and keeps s0 available for the frame-pointer chain;
    -      * call_on_irq_stack still reserves an aligned stack slot, but links the
    -        saved {fp, ra} with the raw frame-record size so s0 points at the
    -        RISC-V frame record rather than past the alignment padding.
    +        and user tasks, and keeps s0 available for the frame-pointer chain.
     
    -    The call_on_irq_stack adjustment fixes a latent RV32 issue. On RV64,
    -    sizeof(struct stackframe) is equal to the stack alignment, so the old
    -    s0 value happened to point just above the saved {fp, ra}. On RV32, the
    -    raw frame record is 8 bytes while the reserved stack slot is 16-byte
    -    aligned, so the old s0 value pointed into the padding. Using the raw
    -    record size makes s0 point above the saved frame record on both RV32
    -    and RV64 while still reserving the aligned slot.
    +    Keep the embedded metadata-record field offsets distinct from the
    +    s0-relative STACKFRAME_* offsets used by call_on_irq_stack(), because
    +    the latter describe a frame record relative to s0 rather than to the
    +    record base.
     
         These changes keep s0 reserved for the frame-pointer chain at task and
    -    stack-switch boundaries.
    +    exception boundaries.
     
    +    Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
         Signed-off-by: Wang Han <wanghan@linux.alibaba.com>
     
      ## arch/riscv/include/asm/ptrace.h ##
    @@ arch/riscv/kernel/asm-offsets.c: void asm_offsets(void)
      
      	OFFSET(HIBERN_PBE_ADDR, pbe, address);
     @@ arch/riscv/kernel/asm-offsets.c: void asm_offsets(void)
    - 	OFFSET(SBI_HART_BOOT_STACK_PTR_OFFSET, sbi_hart_boot_data, stack_ptr);
    - 
      	DEFINE(STACKFRAME_SIZE_ON_STACK, ALIGN(sizeof(struct stackframe), STACK_ALIGN));
    -+	DEFINE(STACKFRAME_RECORD_SIZE, sizeof(struct stackframe));
    - 	OFFSET(STACKFRAME_FP, stackframe, fp);
    - 	OFFSET(STACKFRAME_RA, stackframe, ra);
    + 	DEFINE(STACKFRAME_FP, offsetof(struct stackframe, fp) - sizeof(struct stackframe));
    + 	DEFINE(STACKFRAME_RA, offsetof(struct stackframe, ra) - sizeof(struct stackframe));
    ++	DEFINE(STACKFRAME_RECORD_SIZE, sizeof(struct frame_record));
    ++	OFFSET(FRAME_RECORD_FP, frame_record, fp);
    ++	OFFSET(FRAME_RECORD_RA, frame_record, ra);
      #ifdef CONFIG_FUNCTION_TRACER
    + 	DEFINE(FTRACE_OPS_FUNC,		offsetof(struct ftrace_ops, func));
    + #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
     
      ## arch/riscv/kernel/entry.S ##
     @@
    @@ arch/riscv/kernel/entry.S: SYM_CODE_START(handle_exception)
     +	 * Create a metadata frame record. The unwinder will use this to
     +	 * identify and unwind exception boundaries.
     +	 */
    -+	REG_S zero, (S_STACKFRAME + STACKFRAME_FP)(sp) /* stackframe.record.fp = 0 */
    -+	REG_S zero, (S_STACKFRAME + STACKFRAME_RA)(sp) /* stackframe.record.ra = 0 */
    ++	REG_S zero, (S_STACKFRAME + FRAME_RECORD_FP)(sp) /* stackframe.record.fp = 0 */
    ++	REG_S zero, (S_STACKFRAME + FRAME_RECORD_RA)(sp) /* stackframe.record.ra = 0 */
     +#ifdef CONFIG_RISCV_M_MODE
     +	li t0, SR_MPP
     +	and t0, s1, t0
    @@ arch/riscv/kernel/entry.S: SYM_CODE_START_LOCAL(handle_kernel_stack_overflow)
     +	 * pt_regs boundary and the unwinder can resume from the pre-overflow
     +	 * frame pointer saved in PT_S0.
     +	 */
    -+	REG_S zero, (S_STACKFRAME + STACKFRAME_FP)(sp)
    -+	REG_S zero, (S_STACKFRAME + STACKFRAME_RA)(sp)
    ++	REG_S zero, (S_STACKFRAME + FRAME_RECORD_FP)(sp)
    ++	REG_S zero, (S_STACKFRAME + FRAME_RECORD_RA)(sp)
     +	li t0, FRAME_META_TYPE_PT_REGS
     +	REG_S t0, S_STACKFRAME_TYPE(sp)
     +	addi s0, sp, S_STACKFRAME + STACKFRAME_RECORD_SIZE
    @@ arch/riscv/kernel/entry.S: ASM_NOKPROBE(handle_kernel_stack_overflow)
      	move a2, sp /* pt_regs */
      	call ret_from_fork_kernel
      	j ret_from_exception
    -@@ arch/riscv/kernel/entry.S: SYM_FUNC_START(call_on_irq_stack)
    - 	addi	sp, sp, -STACKFRAME_SIZE_ON_STACK
    - 	REG_S	ra, STACKFRAME_RA(sp)
    - 	REG_S	s0, STACKFRAME_FP(sp)
    --	addi	s0, sp, STACKFRAME_SIZE_ON_STACK
    -+	addi	s0, sp, STACKFRAME_RECORD_SIZE
    - 
    - 	/* Switch to the per-CPU shadow call stack */
    - 	scs_save_current
    -@@ arch/riscv/kernel/entry.S: SYM_FUNC_START(call_on_irq_stack)
    - 	scs_load_current
    - 
    - 	/* Switch back to the thread stack and restore ra and s0 */
    --	addi	sp, s0, -STACKFRAME_SIZE_ON_STACK
    -+	addi	sp, s0, -STACKFRAME_RECORD_SIZE
    - 	REG_L	ra, STACKFRAME_RA(sp)
    - 	REG_L	s0, STACKFRAME_FP(sp)
    - 	addi	sp, sp, STACKFRAME_SIZE_ON_STACK
     
      ## arch/riscv/kernel/head.S ##
     @@
    @@ arch/riscv/kernel/head.S: SYM_CODE_START(_start_kernel)
     +	 * fp/s0 points above the metadata record (RISC-V
     +	 * convention).
     +	 */
    -+	REG_S zero, (S_STACKFRAME + STACKFRAME_FP)(sp)
    -+	REG_S zero, (S_STACKFRAME + STACKFRAME_RA)(sp)
    ++	REG_S zero, (S_STACKFRAME + FRAME_RECORD_FP)(sp)
    ++	REG_S zero, (S_STACKFRAME + FRAME_RECORD_RA)(sp)
     +	li t0, FRAME_META_TYPE_FINAL
     +	REG_S t0, S_STACKFRAME_TYPE(sp)
     +	addi s0, sp, S_STACKFRAME + STACKFRAME_RECORD_SIZE
2:  237864b66d78 = 2:  c63daa8759a6 riscv: stacktrace: disable KASAN and KCOV instrumentation for stacktrace.o
3:  e6035966a35a = 3:  352269306907 riscv: ftrace: always preserve s0 in dynamic ftrace register frame
4:  d132087ea01e ! 4:  2cc86f5728c1 riscv: stacktrace: introduce stack-bound tracking helpers
    @@ arch/riscv/include/asm/stacktrace.h: extern void notrace walk_stackframe(struct
     +/*
     + * IRQ stack accessors
     + */
    ++#ifdef CONFIG_IRQ_STACKS
     +static inline struct stack_info stackinfo_get_irq(void)
     +{
     +	unsigned long low = (unsigned long)raw_cpu_read(irq_stack_ptr);
    @@ arch/riscv/include/asm/stacktrace.h: extern void notrace walk_stackframe(struct
     +
     +	return stackinfo_on_stack(&info, sp, size);
     +}
    ++#endif /* CONFIG_IRQ_STACKS */
     +
     +/*
     + * Task stack accessors
5:  02adea3ece82 ! 5:  57c5e7d08cf8 riscv: stacktrace: switch to frame-pointer based unwinder
    @@ arch/riscv/kernel/stacktrace.c: unsigned long __get_wchan(struct task_struct *ta
     +	struct task_struct *tsk = task ?: current;
     +	struct stack_info stacks[] = {
     +		stackinfo_get_task(tsk),
    ++#ifdef CONFIG_IRQ_STACKS
     +		STACKINFO_CPU(tsk, irq),
    ++#endif
     +#ifdef CONFIG_VMAP_STACK
     +		STACKINFO_CPU(tsk, overflow),
     +#endif
6:  c7d7dbe7a8a1 = 6:  9b3379fe9320 riscv: Kconfig: enable HAVE_RELIABLE_STACKTRACE and HAVE_LIVEPATCH
7:  ae94a234b34a < -:  ------------ selftests/livepatch: Add RISC-V syscall wrapper prefix
-:  ------------ > 7:  07dddd25aae1 selftests/livepatch: Add RISC-V syscall wrapper prefix

base-commit: ff492e321c477f0c8899ac2b875635a84e928d78
-- 
2.43.0
