Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792679239;
	b=yciEHII73pT0DeELTBO8vK5RjmWf8CVevEg66L30K25lNBEmSaBanYV0SVgdnh7ZddbW
	 T0kEfATs2HVdL9I3OmoFpkXz3VRkMDqKzwq10Cs0wUPiX151iF1jxRbq+LlfG8pzTqKvM
	 hzHF10nOP90JzW4NwfnSonJLkjjbprQc2tM1htJjiHmsIH8rsmzXMVYEczyobPrEoeaz2
	 1xbtzotZ2UAt7P9a3ar26B/RrK3S2DUSlvJmoihtoUAS2xI7YMEWWP3gAagvuuT2juhZa
	 9Hg0/KlNW2SsC9Fxe51jAkniLAX4YrVudD1C49wrXmULeLBZjOgmnWSuVfH7qMCXnmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792679239;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=PWTwdXz739qDubZv3PzMlWOlUVDAFnpK6YYpPguc15I=;
	b=tNpLwPhLQP2+WBxZp1dymf6rO56s7Jl88Bvy0Wr6EH9o+kxphQbdwHLacLVPInFWNZ+A
	 W57YUgdhMxrlrBDV3hBRGQM9NFUNbTzzIMyYse0Nqddvb8T23Ave4be35mtQRtFqNBa7u
	 T6zIPhiaMigR/0jyA6hgrcHOW2mgo0K+y2hc2LQgSEcRmE3PAmElRn5OMOyQSTpRBvV81
	 YoEPCQX/NjWM/NxiqrJVzfGa7FF8+3eiT7IQXoP+vcsbAoVksh81zooVujt3IKjhxQpYE
	 Mvz9ORfwS4q7GvyE/067rVpu+Wkv6kjuEazDAHoaT3Y1/Ylpoxdk9+gO6g/u5hd50Lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=5Fdqmxat;
	arc=none smtp.remote-ip=216.40.44.13
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF12B606A31A;
	Thu, 22 Oct 2026 14:27:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF12B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=5Fdqmxat
Received: from omf07.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id F0FC340139;
	Thu, 22 Oct 2026 14:27:10 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id EB69C2002C;
	Thu, 22 Oct 2026 14:27:08 +0000 (UTC)
Date: Thu, 22 Oct 2026 10:27:07 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: sashiko-bot@kernel.org
Cc: sashiko-reviews@lists.linux.dev, "Song Liu" <song@kernel.org>,
 linux-trace-kernel@vger.kernel.org, live-patching@vger.kernel.org,
 mhiramat@kernel.org, mark.rutland@arm.com, kernel-team@meta.com
Subject: Re: [PATCH] compiler_types: Do not mark inline functions notrace
Message-ID: <20261022102707.67a8a010@gandalf.local.home>
In-Reply-To: <sashiko-outbox-180771@kernel.org>
References: <20261021222255.3124940-1-song@kernel.org>
	<sashiko-outbox-180771@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: EB69C2002C
X-Stat-Signature: z8wcboef5fbactoco8c59uau8dnhi14c
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+Fk0YnJXEkfIzfEopqidMPlITZ9tyiqGg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=PWTwdXz739qDubZv3PzMlWOlUVDAFnpK6YYpPguc15I=; b=5FdqmxatsCiJYKQ+WJHedhTJckXpxevfeZ0Tp4gv6uHGTLiYtDBtTC/6iwuayc82M0KuRZfnduQRGLRlIj5PzwIFJCpto8+aoBNHWugjyXJteGKTPYuQE0/ZvKOdzAmqeM+stHk0WNLTjmUWY7efJ9H5jJHYx6Cud/YEWFo0U4E=
X-HE-Tag: 1792679228-962234
X-HE-Meta: U2FsdGVkX19FyUWBZC7c1BWpWOBChmEKZfA+CCr6R8dZWyAh/yUrXiC6XMiuC0POAShe+79ImUms6eJRp4xNHLHnT38VxHGn1xTLelyUrGuewUEV/qMVmfkhPQjloHaDFmxKGiYOv792pXOQeg4EsZ4TRwxqS/xrNWP1L8xmD2XzjAxjX7aN+yUmBS5orTQnzyqlOx2S1sUVBFPR5l7ns09Ex2OJvwl/szh7ZodqdDMui9/EgrOW2tBj12BvfuwYZB8YD3kKiHsKUDk+0lHdDZqRm6X2g5OPBzcubtSuRtGWBPeIYKcBsCUPCQrPjLdQrg7IkNVg2rT8Eei2ReXYSl2zdbQEPpTKpCXeJN6TivsdxLEkXDFEWw==

On Wed, 21 Oct 2026 23:09:21 +0000
sashiko-bot@kernel.org wrote:

> 
> > diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> > index c5921f1390079..ea7f2a928b4da 100644
> > --- a/include/linux/compiler_types.h
> > +++ b/include/linux/compiler_types.h
> > @@ -230,9 +230,8 @@ struct ftrace_likely_data {
> >   * externally visible function. This makes extern inline behave as per gnu89
> >   * semantics rather than c99. This prevents multiple symbol definition errors
> >   * of extern inline functions at link time.
> > - * A lot of inline functions can cause havoc with function tracing.
> >   */
> > -#define inline inline __gnu_inline __inline_maybe_unused notrace
> > +#define inline inline __gnu_inline __inline_maybe_unused
> >  
> >  /*
> >   * gcc provides both __inline__ and __inline as alternate spellings of  
> 
> [Severity: Critical]
> Could removing notrace from inline cause a triple-fault during x86 suspend
> resume, secondary CPU bringup, or kexec when function tracing or call-depth
> tracking is active?
> 
> In include/linux/compiler_attributes.h, __always_inline expands to inline:
> 
>     #define __always_inline inline __attribute__((__always_inline__))
> 
> Because __always_inline only inherits notrace through inline, removing
> notrace here strips notrace from both inline and __always_inline functions
> whenever their address is taken and the compiler emits an out-of-line copy.

Correct. If we remove "notrace" from "inline" we must add it to
"__always_inline"

> 
> In arch/x86/kernel/paravirt.c (compiled with CC_FLAGS_FTRACE when
> CONFIG_PARAVIRT_XXL=y and CONFIG_FUNCTION_TRACER=y), pv_ops takes the
> addresses of static inline and static __always_inline native_* helpers
> (including native_load_idt, native_load_gdt, native_load_tr_desc,
> native_set_ldt, native_write_gdt_entry, native_write_idt_entry,
> native_write_ldt_entry, native_load_tls, native_load_gs_index,
> native_load_sp0, native_store_tr, native_cpuid, native_read_cr0,
> native_write_cr0, native_write_cr4, native_read_msr, native_write_msr,
> native_read_msr_safe, native_write_msr_safe, native_read_pmc, and
> native_halt):
> 
>     .cpu.read_cr0       = native_read_cr0,
>     .cpu.write_cr0      = native_write_cr0,
>     .cpu.write_cr4      = native_write_cr4,
>     .cpu.read_msr       = native_read_msr,
>     .cpu.write_msr      = native_write_msr,
>     .cpu.read_msr_safe  = native_read_msr_safe,
>     .cpu.write_msr_safe = native_write_msr_safe,
>     .cpu.read_pmc       = native_read_pmc,
>     .cpu.load_tr_desc   = native_load_tr_desc,
>     .cpu.set_ldt        = native_set_ldt,
>     .cpu.load_gdt       = native_load_gdt,
>     .cpu.load_idt       = native_load_idt,
> 
> This forces the compiler to emit out-of-line bodies in paravirt.o with
> __fentry__ callsites.
> 
> During S3 or hibernation resume, __restore_processor_state() in
> arch/x86/power/cpu.c is marked notrace (rather than noinstr, so objtool does
> not validate it) and calls wrmsrq(), __write_cr4(), write_cr3(),
> write_cr0(), and load_idt(&ctxt->idt) -> pv_ops.cpu.load_idt ->
> native_load_idt() before MSR_GS_BASE (%gs) is restored:

Seems that we need to find these and add "notrace" to each of them individually.

> 
>     static void notrace __restore_processor_state(struct saved_context *ctxt)
>     {
>         ...
>         wrmsrq(MSR_EFER, ctxt->efer);
>         __write_cr4(ctxt->cr4);
>     #endif
>         write_cr3(ctxt->cr3);
>         write_cr2(ctxt->cr2);
>         write_cr0(ctxt->cr0);
> 
>         /* Restore the IDT. */
>         load_idt(&ctxt->idt);
>         ...
>         wrmsrq(MSR_GS_BASE, ctxt->gs_base);
> 
> Similarly, start_secondary() -> cpu_init_exception_handling() in
> arch/x86/kernel/cpu/common.c calls write_gdt_entry(), load_TR_desc(), and
> load_current_idt() -> load_idt() before the secondary CPU IDT is loaded, and
> machine_kexec() in arch/x86/kernel/machine_kexec_64.c calls load_segments()
> (which resets %gs to 0) followed by the static inline virt_to_phys() in
> arch/x86/include/asm/io.h:

Anything that is compiled in common.c via headers is not a concern as the
Makefile has:

  CFLAGS_REMOVE_common.o = -pg

Which removes all fentry calls to common.o.

That doesn't stop fentry being added to functions that
cpu_init_exception_handling() calls that is defined in another C file that
is compiled with -pg.

But for those you mention:

  write_gdt_entry() is defined in headers (safe)
  load_TR_desc() is defined in headers (safe)

  load_current_idt() is itself currently traced. If what it calls is an
  issue then we have the issue now anyway.

The virt_to_phys() could be converted to __always_inline


> 
>     load_segments();
> 
>     /* now call it */
>     image->start = relocate_kernel_ptr((unsigned long)image->head,
>                                        virt_to_phys(control_page),
> 
> Won't executing __fentry__ in these paths dereference %gs per-CPU state
> (such as current->trace_recursion or call-depth tracking) before %gs or the
> IDT is valid?

Probably should test this.

> 
> [Severity: High]
> What prevents infinite ftrace recursion when out-of-line inline helpers are
> called inside ftrace recursion protection itself?
> 
> Ftrace callbacks use ftrace_test_recursion_trylock() ->
> trace_test_and_set_recursion() in include/linux/trace_recursion.h at entry
> and ftrace_test_recursion_unlock() -> trace_clear_recursion() at exit:
> 
>     static __always_inline int trace_test_and_set_recursion(unsigned long ip,
>                                                             unsigned long pip,
>                                                             int start)

Fixed by adding "notrace" to "__always_inline".

>     {
>         unsigned int val = READ_ONCE(current->trace_recursion);
>         int bit;
> 
>         if (trace_warn_on_no_rcu(ip))
>             return -1;
> 
>         bit = trace_get_context_bit() + start;
> 
> In translation units compiled with $(CC_FLAGS_FTRACE) (such as
> kernel/livepatch/patch.c, fs/pstore/ftrace.c,
> arch/x86/kernel/kprobes/ftrace.c, arch/powerpc/kernel/kprobes-ftrace.c,
> kernel/rcu/tree.c, and kernel/trace/trace_events.c under
> CONFIG_FUNCTION_SELF_TRACING=y), several functions called before
> current->trace_recursion is set (or after it is cleared) are plain static
> inline:
> 
> 1. trace_test_and_set_recursion() evaluates current -> get_current() (plain
>    static inline in arch/powerpc/include/asm/current.h and
>    arch/m68k/include/asm/current.h), trace_warn_on_no_rcu() ->
>    rcu_is_watching() (plain static inline in include/linux/rcutiny.h, and
>    calls preempt_disable_notrace() / preempt_enable_notrace() in
>    kernel/rcu/tree.c), and trace_get_context_bit() ->
>    interrupt_context_level() -> preempt_count() (plain static inline in
>    arch/arm64/include/asm/preempt.h).

Perhaps we should be more strict and convert them to __always_inline.

> 
> 2. In arch/arm64/include/asm/preempt.h, preempt_count(),
>    __preempt_count_add(), __preempt_count_sub(), should_resched(), and
>    __preempt_count_dec_and_test() are plain static inline without
>    __always_inline or notrace, so preempt_disable_notrace() and
>    preempt_enable_notrace() can be traced if emitted out-of-line.

Again, __always_inline having notrace will fix this.

> 
> 3. In kernel/trace/trace_events.c (compiled with $(CC_FLAGS_FTRACE) when
>    CONFIG_FUNCTION_SELF_TRACING=y), __init function_test_events_call() is
>    registered without FTRACE_OPS_FL_RECURSION and calls static inline
>    helpers tracing_gen_ctx(), tracing_gen_ctx_flags(),
>    arch_local_save_flags(), preempt_disable_notrace(), and
>    atomic_inc_return() before incrementing ftrace_test_event_disable, as
>    well as atomic_dec() and preempt_enable_notrace() when decrementing it:

All the above do need to be made to explicitly have notrace.

> 
>     trace_ctx = tracing_gen_ctx();
>     preempt_disable_notrace();
>     cpu = raw_smp_processor_id();
>     disabled = atomic_inc_return(&per_cpu(ftrace_test_event_disable, cpu));
> 
> If the compiler emits any of these helpers out-of-line, won't tracing them
> recurse infinitely before the recursion guard takes effect?
> 
> [Severity: High]
> Should the _notrace SRCU helpers and tracepoint dispatch wrappers retain an
> explicit notrace or __always_inline annotation?

Probably.

> 
> In include/linux/srcu.h, srcu_read_lock_fast_notrace() and
> srcu_read_unlock_fast_notrace() are documented as non-traceable, but unlike
> srcu_read_lock_notrace() and srcu_read_unlock_notrace() (which are marked
> static inline notrace), they rely on inline for notrace:
> 
>     /*
>      * Used by tracing, cannot be traced and cannot call lockdep.
>      * See srcu_read_lock_fast() for more information.
>      */
>     static inline struct srcu_ctr __percpu *srcu_read_lock_fast_notrace(struct srcu_struct *ssp)
> 
> Their callee srcu_check_read_flavor() in include/linux/srcutree.h and the
> CONFIG_TINY_SRCU helpers in include/linux/srcutiny.h are also plain static
> inline.
> 
> Similarly, in include/linux/tracepoint.h, __do_trace_##name (which uses
> guard(srcu_fast_notrace)(&tracepoint_srcu) and is called on the cold
> static_branch_unlikely() path as well as from notrace void
> rust_do_trace_##name), trace_##name, and trace_call__##name are plain static
> inline:
> 
>     static inline void __do_trace_##name(proto)                     \

This probably should be converted to __always_inline


>     {                                                               \
>         TRACEPOINT_CHECK(name)                                      \
>         if (cond) {                                                 \
>             guard(srcu_fast_notrace)(&tracepoint_srcu);             \
>             __DO_TRACE_CALL(name, TP_ARGS(args));                   \
>         }                                                           \
>     }
> 
> Because __do_trace_##name is on the cold branch of trace_##name, compilers
> frequently emit it out-of-line. Without notrace on inline, won't these
> tracepoint and _notrace SRCU helpers become ftrace and fentry targets?
> 
> [Severity: High]
> Can attaching a BPF fentry or fexit program to an uninlined helper in
> kernel/bpf/trampoline.c or kernel/bpf/memalloc.c trigger infinite recursion
> or llist corruption?

Hmm, perhaps we need to add to kernel/bpf/Makefile:

  CFLAGS_REMOVE_trampoline.o = $(CC_FLAGS_FTRACE)


> 
> Unlike ftrace_ops callbacks, BPF trampolines do not use
> ftrace_test_recursion_trylock(). In kernel/bpf/trampoline.c (compiled with
> $(CC_FLAGS_FTRACE)), notrace __bpf_prog_enter*(), __bpf_prog_exit*(),
> __bpf_tramp_enter(), and __bpf_tramp_exit() call plain static inline helpers
> before prog->active recursion protection is acquired or after it is
> released:
> 
>     static u64 notrace __bpf_prog_enter_recur(struct bpf_prog *prog, struct bpf_tramp_run_ctx *run_ctx)
>         __acquires(RCU)
>     {
>         rcu_read_lock_dont_migrate();
> 
>         run_ctx->saved_run_ctx = bpf_set_run_ctx(&run_ctx->run_ctx);
> 
>         if (unlikely(!bpf_prog_get_recursion_context(prog))) {
> 
> and:
> 
>     static void notrace __bpf_prog_exit_recur(struct bpf_prog *prog, u64 start,
>                                               struct bpf_tramp_run_ctx *run_ctx)
>         __releases(RCU)
>     {
>         bpf_reset_run_ctx(run_ctx->saved_run_ctx);
> 
>         update_prog_stats(prog, start);
>         bpf_prog_put_recursion_context(prog);
>         rcu_read_unlock_migrate();
>     }
> 
> The static inline helpers called here include __migrate_disable() and
> __migrate_enable() (include/linux/sched.h), rcu_read_unlock_migrate(),
> rcu_read_lock(), and rcu_read_unlock() (include/linux/rcupdate.h),
> rcu_read_lock_trace() and rcu_read_unlock_trace()

Yeah, this patch will likely need to turn into a series where we have to
convert several "inline" to "__always_inline" to prevent from tracing. Or
add explicit "notrace".

> (include/linux/rcupdate_trace.h), bpf_set_run_ctx(), bpf_reset_run_ctx(),
> bpf_prog_get_recursion_context(), and bpf_prog_put_recursion_context()
> (include/linux/bpf.h), percpu_ref_get() and percpu_ref_put()
> (include/linux/percpu-refcount.h), and u64_stats_update_begin_irqsave() and
> u64_stats_update_end_irqrestore() (include/linux/u64_stats_sync.h). In
> kernel/bpf/verifier.c, btf_id_deny only blocks the out-of-line wrappers
> migrate_disable, migrate_enable, ___migrate_enable, rcu_read_unlock_strict,
> preempt_count_add, preempt_count_sub, __rcu_read_lock, and
> __rcu_read_unlock, not these static inline functions.
> 
> In addition, unit_alloc(), unit_free(), and unit_free_rcu() in
> kernel/bpf/memalloc.c are marked notrace specifically so BPF programs cannot
> attach to them and corrupt free_llist or free_llist_extra, yet they call
> plain static inline helpers __llist_add(), __llist_add_batch(), llist_add(),
> llist_add_batch(), local_inc_return(), local_add_return(), and local_dec():
> 
>     static void notrace unit_free(struct bpf_mem_cache *c, void *ptr)
>     {
>         ...
>         local_irq_save(flags);
>         if (local_inc_return(&c->active) == 1) {
>             __llist_add(llnode, &c->free_llist);
>             cnt = ++c->free_cnt;
>         } else {
>             llist_add(llnode, &c->free_llist_extra);
>         }
>         local_dec(&c->active);
> 
> If any of these static inline helpers is emitted out-of-line and attached to
> via fentry/fexit, won't the trampoline recurse infinitely or corrupt the
> bpf_mem_alloc freelist?
> 
> [Severity: High]
> How are entry, exit, and NMI inline helpers protected against ftrace
> instrumentation on architectures without objtool noinstr validation?
> 
> CONFIG_HAVE_NOINSTR_VALIDATION is only selected on X86_64 (in
> arch/x86/Kconfig, when CONFIG_DEBUG_ENTRY=y); powerpc, arm64, riscv, s390,
> loongarch, and x86_32 do not have build-time objtool noinstr validation:
> 
> 1. On PowerPC, arch/powerpc/include/asm/interrupt.h defines
>    interrupt_handler with notrace rather than noinstr because of linker
>    branch stub range limitations:
> 
>     #define interrupt_handler __visible noinline notrace __no_kcsan __no_sanitize_address
> 
>    The notrace interrupt, NMI, and syscall entry/exit paths in
>    arch/powerpc/kernel/traps.c and arch/powerpc/kernel/interrupt.c call
>    large static inline helpers in arch/powerpc/include/asm/entry-common.h,
>    arch/powerpc/include/asm/ftrace.h, and arch/powerpc/include/asm/hw_irq.h,
>    including check_return_regs_valid(), arch_interrupt_enter_prepare(),
>    arch_interrupt_exit_prepare(), arch_interrupt_nmi_enter_prepare(),
>    arch_interrupt_nmi_exit_prepare(), this_cpu_disable_ftrace(),
>    this_cpu_enable_ftrace(), this_cpu_set_ftrace_enabled(),
>    this_cpu_get_ftrace_enabled(), and (from prep_irq_for_enabled_exit() in
>    arch/powerpc/kernel/interrupt.c) exit_must_hard_disable(),
>    __hard_EE_RI_disable(), __hard_RI_enable(), __hard_irq_disable(),
>    lazy_irq_pending_nocheck(), arch_local_irq_disable(), and
>    arch_local_irq_save(). These run while MSR[RI]=0 (unrecoverable exception
>    state), in real mode on Book3S-64 NMI entry, before
>    this_cpu_set_ftrace_enabled(0) disables ftrace in NMI, with unreconciled
>    irq_soft_mask, or after user_enter_irqoff() while RCU is not watching.
> 
> 2. On arm64, arch/arm64/kernel/entry-common.c is compiled with
>    $(CC_FLAGS_FTRACE), and its noinstr handlers
>    (arm64_enter_from_kernel_mode(), __arm64_exit_to_kernel_mode(),
>    arm64_exit_to_kernel_mode_preempt(), el0_pc(), and __sdei_handler()) call
>    plain static inline helpers outside instrumentation_begin() /
>    instrumentation_end(): irqentry_exit_to_kernel_mode_preempt()
>    (include/linux/irq-entry-common.h), __kern_my_cpu_offset()
>    (arch/arm64/include/asm/percpu.h), mte_check_tfsr_entry(),
>    mte_check_tfsr_exit(), and mte_disable_tco_entry()
>    (arch/arm64/include/asm/mte.h), sme_enter_from_user_mode() and
>    sme_exit_to_user_mode() (arch/arm64/include/asm/fpsimd.h),
>    instruction_pointer() (arch/arm64/include/asm/ptrace.h), and
>    system_supports_mte(), system_has_prio_mask_debugging(),
>    system_uses_hw_pan(), and cpu_has_pan()
>    (arch/arm64/include/asm/cpufeature.h).

These will need to be looked through.

> 
> 3. In generic entry code (include/linux/irq-entry-common.h),
>    enter_from_user_mode() and exit_to_user_mode() call user_exit_irqoff()
>    and user_enter_irqoff() (include/linux/context_tracking.h, which are
>    plain static inline when !CONFIG_CONTEXT_TRACKING_USER) and
>    lockdep_hardirqs_off() and lockdep_hardirqs_on()
>    (include/linux/irqflags.h, which are plain static inline when
>    !CONFIG_PROVE_LOCKING) outside instrumentation_begin() /
>    instrumentation_end().
> 
> Won't an out-of-line copy of these helpers be instrumented by ftrace and
> execute when MSR[RI]=0, in real mode, or while RCU is not watching?

I think most of those are stubs. I would hope a compiler would never
out-of-line them.

-- Steve
