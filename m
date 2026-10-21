Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792624162;
	b=nER/w2V4+jA6VZvm9/fGCFBGKzIf/6LIKluqPJ2cQa2nxR/7vFMER/92kopA/fegHESf
	 RMaiKr+yzTjGVoTM7MpsxFZvlZOFdEhutH4iIifCDSWG6jKGC6XkpVRJfmfwPv0vjHUkN
	 PmvicOeU4WTke+gBU8N1KOygryd3xr1SD2f05X8K9PWkizcRi5CbSSDSedaeD9Yckxjpf
	 sEGuqeqOktxc//VUTZPYXUpu/n+9IbxkoqejmNCrqK9Vo21QwJb6eMIXBvtxIxtsiA3SB
	 g+cr4vWhtSvNiO4W0MnfSqeINXJveWyoGU9TlK5Asc/d/cMmaJyvB5Q4+qBQk4XgNlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792624162;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=IXmhOLYSaLLBSsDnflWwLGqPDRhkCeTUe+LBGh9K3EU=;
	b=lTXwvKmhbTKoncKRun9O87VQQinUObI7irp49Ym5OtmbISp6L56s5mKQBswoZ/hA3+QC
	 tG3HJlyLteM2Qk5MZXsHs8tuYbuh2XJUd+SGLeN1WKycRBjqMmbgSvL4+APM292hzJLXG
	 Coi+7+QEnai6FUVdpXwI8LF+E6zz6Mb7uWdL4m/gpEl1Yjw3UG4MgONVQGgmmqw7gGrB+
	 qodj/EAdFbeNvJXsauYbiWjDiYGsW34ttDatLlrpD8lHp5JHzLwF11CQ2vjvE01Z0rCzD
	 9ymWgb5LIxAbqy8MkAMDaX1CpoA+vU+AgK96IUJ8N8WtlMbng4AgDuqJYNow+RNn49g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bTkHcvxj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35389606A319;
	Wed, 21 Oct 2026 23:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bTkHcvxj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C27C81F000C1;
	Wed, 21 Oct 2026 23:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792624162;
	bh=IXmhOLYSaLLBSsDnflWwLGqPDRhkCeTUe+LBGh9K3EU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bTkHcvxjodDLvQImc9qN0fEeiXmx9RvaGLKLH/6OgoGT7ryTsCdS1OUar+IgV1GsQ
	 Xj9l7f65fucp4EiKPovA98H7px6obcIkm/X6elLEJPKnm/Mfm4ij6HNw5gofy7aRp8
	 kqo2HgiVFXxbtjaw3FNKkWhT/HiVGLJsP8ZpO7JLS0lha2gDuhe1i/jD+jDAoYSmmN
	 DurgycNRcRe4SkiGLENeHAOkhXrGlzo51XGBVC8uCtsay+lI3JUa7bCRD0cufruWf4
	 At6u1R+n/LEu24dNf7n7RJHw6yXwU1Nd/J/EdfHLMKMX+G/qp1vhJiWCETaaLSmaFT
	 c4LhH3kKjQ1Iw==
Message-ID: <sashiko-outbox-180771@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] compiler_types: Do not mark inline functions notrace
Reply-To: sashiko-reviews@lists.linux.dev
To: "Song Liu" <song@kernel.org>, linux-trace-kernel@vger.kernel.org, live-patching@vger.kernel.org
Cc: rostedt@goodmis.org, mhiramat@kernel.org, mark.rutland@arm.com, kernel-team@meta.com
In-Reply-To: <20261021222255.3124940-1-song@kernel.org>
References: <20261021222255.3124940-1-song@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 23:09:21 +0000
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Critical] x86/paravirt: removing notrace from inline instruments pv_ops =
and resume
- [High] tracing: removing notrace from inline breaks ftrace recursion prot=
ection
- [High] rcu: srcu_read_lock_fast_notrace() and tracepoints lose notrace at=
tribute
- [High] bpf: removing notrace from inline exposes trampoline helpers to fe=
ntry
- [High] entry: removing notrace from inline instruments unvalidated entry =
helpers
--

commit 1eb6626c4a5ab70e5858a8a8f1c9edfca235db57
Author: Song Liu <song@kernel.org>

compiler_types: Do not mark inline functions notrace

This commit removes the notrace attribute from the inline macro definition
in include/linux/compiler_types.h so that inline functions emitted
out-of-line by the compiler can be traced by ftrace, attached to via BPF
fentry/fexit, and livepatched.

> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_type=
s.h
> index c5921f1390079..ea7f2a928b4da 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -230,9 +230,8 @@ struct ftrace_likely_data {
>   * externally visible function. This makes extern inline behave as per g=
nu89
>   * semantics rather than c99. This prevents multiple symbol definition e=
rrors
>   * of extern inline functions at link time.
> - * A lot of inline functions can cause havoc with function tracing.
>   */
> -#define inline inline __gnu_inline __inline_maybe_unused notrace
> +#define inline inline __gnu_inline __inline_maybe_unused
> =20
>  /*
>   * gcc provides both __inline__ and __inline as alternate spellings of

[Severity: Critical]
Could removing notrace from inline cause a triple-fault during x86 suspend
resume, secondary CPU bringup, or kexec when function tracing or call-depth
tracking is active?

In include/linux/compiler_attributes.h, __always_inline expands to inline:

    #define __always_inline inline __attribute__((__always_inline__))

Because __always_inline only inherits notrace through inline, removing
notrace here strips notrace from both inline and __always_inline functions
whenever their address is taken and the compiler emits an out-of-line copy.

In arch/x86/kernel/paravirt.c (compiled with CC_FLAGS_FTRACE when
CONFIG_PARAVIRT_XXL=3Dy and CONFIG_FUNCTION_TRACER=3Dy), pv_ops takes the
addresses of static inline and static __always_inline native_* helpers
(including native_load_idt, native_load_gdt, native_load_tr_desc,
native_set_ldt, native_write_gdt_entry, native_write_idt_entry,
native_write_ldt_entry, native_load_tls, native_load_gs_index,
native_load_sp0, native_store_tr, native_cpuid, native_read_cr0,
native_write_cr0, native_write_cr4, native_read_msr, native_write_msr,
native_read_msr_safe, native_write_msr_safe, native_read_pmc, and
native_halt):

    .cpu.read_cr0       =3D native_read_cr0,
    .cpu.write_cr0      =3D native_write_cr0,
    .cpu.write_cr4      =3D native_write_cr4,
    .cpu.read_msr       =3D native_read_msr,
    .cpu.write_msr      =3D native_write_msr,
    .cpu.read_msr_safe  =3D native_read_msr_safe,
    .cpu.write_msr_safe =3D native_write_msr_safe,
    .cpu.read_pmc       =3D native_read_pmc,
    .cpu.load_tr_desc   =3D native_load_tr_desc,
    .cpu.set_ldt        =3D native_set_ldt,
    .cpu.load_gdt       =3D native_load_gdt,
    .cpu.load_idt       =3D native_load_idt,

This forces the compiler to emit out-of-line bodies in paravirt.o with
__fentry__ callsites.

During S3 or hibernation resume, __restore_processor_state() in
arch/x86/power/cpu.c is marked notrace (rather than noinstr, so objtool does
not validate it) and calls wrmsrq(), __write_cr4(), write_cr3(),
write_cr0(), and load_idt(&ctxt->idt) -> pv_ops.cpu.load_idt ->
native_load_idt() before MSR_GS_BASE (%gs) is restored:

    static void notrace __restore_processor_state(struct saved_context *ctx=
t)
    {
        ...
        wrmsrq(MSR_EFER, ctxt->efer);
        __write_cr4(ctxt->cr4);
    #endif
        write_cr3(ctxt->cr3);
        write_cr2(ctxt->cr2);
        write_cr0(ctxt->cr0);

        /* Restore the IDT. */
        load_idt(&ctxt->idt);
        ...
        wrmsrq(MSR_GS_BASE, ctxt->gs_base);

Similarly, start_secondary() -> cpu_init_exception_handling() in
arch/x86/kernel/cpu/common.c calls write_gdt_entry(), load_TR_desc(), and
load_current_idt() -> load_idt() before the secondary CPU IDT is loaded, and
machine_kexec() in arch/x86/kernel/machine_kexec_64.c calls load_segments()
(which resets %gs to 0) followed by the static inline virt_to_phys() in
arch/x86/include/asm/io.h:

    load_segments();

    /* now call it */
    image->start =3D relocate_kernel_ptr((unsigned long)image->head,
                                       virt_to_phys(control_page),

Won't executing __fentry__ in these paths dereference %gs per-CPU state
(such as current->trace_recursion or call-depth tracking) before %gs or the
IDT is valid?

[Severity: High]
What prevents infinite ftrace recursion when out-of-line inline helpers are
called inside ftrace recursion protection itself?

Ftrace callbacks use ftrace_test_recursion_trylock() ->
trace_test_and_set_recursion() in include/linux/trace_recursion.h at entry
and ftrace_test_recursion_unlock() -> trace_clear_recursion() at exit:

    static __always_inline int trace_test_and_set_recursion(unsigned long i=
p,
                                                            unsigned long p=
ip,
                                                            int start)
    {
        unsigned int val =3D READ_ONCE(current->trace_recursion);
        int bit;

        if (trace_warn_on_no_rcu(ip))
            return -1;

        bit =3D trace_get_context_bit() + start;

In translation units compiled with $(CC_FLAGS_FTRACE) (such as
kernel/livepatch/patch.c, fs/pstore/ftrace.c,
arch/x86/kernel/kprobes/ftrace.c, arch/powerpc/kernel/kprobes-ftrace.c,
kernel/rcu/tree.c, and kernel/trace/trace_events.c under
CONFIG_FUNCTION_SELF_TRACING=3Dy), several functions called before
current->trace_recursion is set (or after it is cleared) are plain static
inline:

1. trace_test_and_set_recursion() evaluates current -> get_current() (plain
   static inline in arch/powerpc/include/asm/current.h and
   arch/m68k/include/asm/current.h), trace_warn_on_no_rcu() ->
   rcu_is_watching() (plain static inline in include/linux/rcutiny.h, and
   calls preempt_disable_notrace() / preempt_enable_notrace() in
   kernel/rcu/tree.c), and trace_get_context_bit() ->
   interrupt_context_level() -> preempt_count() (plain static inline in
   arch/arm64/include/asm/preempt.h).

2. In arch/arm64/include/asm/preempt.h, preempt_count(),
   __preempt_count_add(), __preempt_count_sub(), should_resched(), and
   __preempt_count_dec_and_test() are plain static inline without
   __always_inline or notrace, so preempt_disable_notrace() and
   preempt_enable_notrace() can be traced if emitted out-of-line.

3. In kernel/trace/trace_events.c (compiled with $(CC_FLAGS_FTRACE) when
   CONFIG_FUNCTION_SELF_TRACING=3Dy), __init function_test_events_call() is
   registered without FTRACE_OPS_FL_RECURSION and calls static inline
   helpers tracing_gen_ctx(), tracing_gen_ctx_flags(),
   arch_local_save_flags(), preempt_disable_notrace(), and
   atomic_inc_return() before incrementing ftrace_test_event_disable, as
   well as atomic_dec() and preempt_enable_notrace() when decrementing it:

    trace_ctx =3D tracing_gen_ctx();
    preempt_disable_notrace();
    cpu =3D raw_smp_processor_id();
    disabled =3D atomic_inc_return(&per_cpu(ftrace_test_event_disable, cpu)=
);

If the compiler emits any of these helpers out-of-line, won't tracing them
recurse infinitely before the recursion guard takes effect?

[Severity: High]
Should the _notrace SRCU helpers and tracepoint dispatch wrappers retain an
explicit notrace or __always_inline annotation?

In include/linux/srcu.h, srcu_read_lock_fast_notrace() and
srcu_read_unlock_fast_notrace() are documented as non-traceable, but unlike
srcu_read_lock_notrace() and srcu_read_unlock_notrace() (which are marked
static inline notrace), they rely on inline for notrace:

    /*
     * Used by tracing, cannot be traced and cannot call lockdep.
     * See srcu_read_lock_fast() for more information.
     */
    static inline struct srcu_ctr __percpu *srcu_read_lock_fast_notrace(str=
uct srcu_struct *ssp)

Their callee srcu_check_read_flavor() in include/linux/srcutree.h and the
CONFIG_TINY_SRCU helpers in include/linux/srcutiny.h are also plain static
inline.

Similarly, in include/linux/tracepoint.h, __do_trace_##name (which uses
guard(srcu_fast_notrace)(&tracepoint_srcu) and is called on the cold
static_branch_unlikely() path as well as from notrace void
rust_do_trace_##name), trace_##name, and trace_call__##name are plain static
inline:

    static inline void __do_trace_##name(proto)                     \
    {                                                               \
        TRACEPOINT_CHECK(name)                                      \
        if (cond) {                                                 \
            guard(srcu_fast_notrace)(&tracepoint_srcu);             \
            __DO_TRACE_CALL(name, TP_ARGS(args));                   \
        }                                                           \
    }

Because __do_trace_##name is on the cold branch of trace_##name, compilers
frequently emit it out-of-line. Without notrace on inline, won't these
tracepoint and _notrace SRCU helpers become ftrace and fentry targets?

[Severity: High]
Can attaching a BPF fentry or fexit program to an uninlined helper in
kernel/bpf/trampoline.c or kernel/bpf/memalloc.c trigger infinite recursion
or llist corruption?

Unlike ftrace_ops callbacks, BPF trampolines do not use
ftrace_test_recursion_trylock(). In kernel/bpf/trampoline.c (compiled with
$(CC_FLAGS_FTRACE)), notrace __bpf_prog_enter*(), __bpf_prog_exit*(),
__bpf_tramp_enter(), and __bpf_tramp_exit() call plain static inline helpers
before prog->active recursion protection is acquired or after it is
released:

    static u64 notrace __bpf_prog_enter_recur(struct bpf_prog *prog, struct=
 bpf_tramp_run_ctx *run_ctx)
        __acquires(RCU)
    {
        rcu_read_lock_dont_migrate();

        run_ctx->saved_run_ctx =3D bpf_set_run_ctx(&run_ctx->run_ctx);

        if (unlikely(!bpf_prog_get_recursion_context(prog))) {

and:

    static void notrace __bpf_prog_exit_recur(struct bpf_prog *prog, u64 st=
art,
                                              struct bpf_tramp_run_ctx *run=
_ctx)
        __releases(RCU)
    {
        bpf_reset_run_ctx(run_ctx->saved_run_ctx);

        update_prog_stats(prog, start);
        bpf_prog_put_recursion_context(prog);
        rcu_read_unlock_migrate();
    }

The static inline helpers called here include __migrate_disable() and
__migrate_enable() (include/linux/sched.h), rcu_read_unlock_migrate(),
rcu_read_lock(), and rcu_read_unlock() (include/linux/rcupdate.h),
rcu_read_lock_trace() and rcu_read_unlock_trace()
(include/linux/rcupdate_trace.h), bpf_set_run_ctx(), bpf_reset_run_ctx(),
bpf_prog_get_recursion_context(), and bpf_prog_put_recursion_context()
(include/linux/bpf.h), percpu_ref_get() and percpu_ref_put()
(include/linux/percpu-refcount.h), and u64_stats_update_begin_irqsave() and
u64_stats_update_end_irqrestore() (include/linux/u64_stats_sync.h). In
kernel/bpf/verifier.c, btf_id_deny only blocks the out-of-line wrappers
migrate_disable, migrate_enable, ___migrate_enable, rcu_read_unlock_strict,
preempt_count_add, preempt_count_sub, __rcu_read_lock, and
__rcu_read_unlock, not these static inline functions.

In addition, unit_alloc(), unit_free(), and unit_free_rcu() in
kernel/bpf/memalloc.c are marked notrace specifically so BPF programs cannot
attach to them and corrupt free_llist or free_llist_extra, yet they call
plain static inline helpers __llist_add(), __llist_add_batch(), llist_add(),
llist_add_batch(), local_inc_return(), local_add_return(), and local_dec():

    static void notrace unit_free(struct bpf_mem_cache *c, void *ptr)
    {
        ...
        local_irq_save(flags);
        if (local_inc_return(&c->active) =3D=3D 1) {
            __llist_add(llnode, &c->free_llist);
            cnt =3D ++c->free_cnt;
        } else {
            llist_add(llnode, &c->free_llist_extra);
        }
        local_dec(&c->active);

If any of these static inline helpers is emitted out-of-line and attached to
via fentry/fexit, won't the trampoline recurse infinitely or corrupt the
bpf_mem_alloc freelist?

[Severity: High]
How are entry, exit, and NMI inline helpers protected against ftrace
instrumentation on architectures without objtool noinstr validation?

CONFIG_HAVE_NOINSTR_VALIDATION is only selected on X86_64 (in
arch/x86/Kconfig, when CONFIG_DEBUG_ENTRY=3Dy); powerpc, arm64, riscv, s390,
loongarch, and x86_32 do not have build-time objtool noinstr validation:

1. On PowerPC, arch/powerpc/include/asm/interrupt.h defines
   interrupt_handler with notrace rather than noinstr because of linker
   branch stub range limitations:

    #define interrupt_handler __visible noinline notrace __no_kcsan __no_sa=
nitize_address

   The notrace interrupt, NMI, and syscall entry/exit paths in
   arch/powerpc/kernel/traps.c and arch/powerpc/kernel/interrupt.c call
   large static inline helpers in arch/powerpc/include/asm/entry-common.h,
   arch/powerpc/include/asm/ftrace.h, and arch/powerpc/include/asm/hw_irq.h,
   including check_return_regs_valid(), arch_interrupt_enter_prepare(),
   arch_interrupt_exit_prepare(), arch_interrupt_nmi_enter_prepare(),
   arch_interrupt_nmi_exit_prepare(), this_cpu_disable_ftrace(),
   this_cpu_enable_ftrace(), this_cpu_set_ftrace_enabled(),
   this_cpu_get_ftrace_enabled(), and (from prep_irq_for_enabled_exit() in
   arch/powerpc/kernel/interrupt.c) exit_must_hard_disable(),
   __hard_EE_RI_disable(), __hard_RI_enable(), __hard_irq_disable(),
   lazy_irq_pending_nocheck(), arch_local_irq_disable(), and
   arch_local_irq_save(). These run while MSR[RI]=3D0 (unrecoverable except=
ion
   state), in real mode on Book3S-64 NMI entry, before
   this_cpu_set_ftrace_enabled(0) disables ftrace in NMI, with unreconciled
   irq_soft_mask, or after user_enter_irqoff() while RCU is not watching.

2. On arm64, arch/arm64/kernel/entry-common.c is compiled with
   $(CC_FLAGS_FTRACE), and its noinstr handlers
   (arm64_enter_from_kernel_mode(), __arm64_exit_to_kernel_mode(),
   arm64_exit_to_kernel_mode_preempt(), el0_pc(), and __sdei_handler()) call
   plain static inline helpers outside instrumentation_begin() /
   instrumentation_end(): irqentry_exit_to_kernel_mode_preempt()
   (include/linux/irq-entry-common.h), __kern_my_cpu_offset()
   (arch/arm64/include/asm/percpu.h), mte_check_tfsr_entry(),
   mte_check_tfsr_exit(), and mte_disable_tco_entry()
   (arch/arm64/include/asm/mte.h), sme_enter_from_user_mode() and
   sme_exit_to_user_mode() (arch/arm64/include/asm/fpsimd.h),
   instruction_pointer() (arch/arm64/include/asm/ptrace.h), and
   system_supports_mte(), system_has_prio_mask_debugging(),
   system_uses_hw_pan(), and cpu_has_pan()
   (arch/arm64/include/asm/cpufeature.h).

3. In generic entry code (include/linux/irq-entry-common.h),
   enter_from_user_mode() and exit_to_user_mode() call user_exit_irqoff()
   and user_enter_irqoff() (include/linux/context_tracking.h, which are
   plain static inline when !CONFIG_CONTEXT_TRACKING_USER) and
   lockdep_hardirqs_off() and lockdep_hardirqs_on()
   (include/linux/irqflags.h, which are plain static inline when
   !CONFIG_PROVE_LOCKING) outside instrumentation_begin() /
   instrumentation_end().

Won't an out-of-line copy of these helpers be instrumented by ftrace and
execute when MSR[RI]=3D0, in real mode, or while RCU is not watching?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021222255.3124=
940-1-song@kernel.org?part=3D1
