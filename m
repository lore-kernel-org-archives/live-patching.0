Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794277254;
	b=UB6jhqdEM6AUgOTJ53GHQK+AR6TdjUBzbiWi8TAhsircjrKyV58VI3xT5yTS8GiUzkkw
	 Rh0eHEvX1liCep7htBxjvtElHqPMl+z34Jizv9ZEX0jGZ3YZaY74Av2HQB5WJuqDhlpy8
	 soxjNlqHQmhOvgTj+8nJz2YNKZhTePyxUrIhRIsiaaXtNvGSwUio1ihM4p7iWqJBrQbzb
	 T8KRqJLZQs4x2cPK3PbafPc1oiHB5x9Ie/fm3DnUubXa/qn3lOMI1KgKR2yQ1fe+F2o6+
	 yC5aVUCIItPGxtHAeitr3v3fH1nMCaa3Go8BoDyY2wLSMcEopEjviPYEldE3g2H2iAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794277254;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=NIqOQmbsfVs3wvBHQaYPOQv0i+lEO+2NVk/bDq2h60Y=;
	b=el9p0vOB3zhJA7S58nBQnmLkWKmRlHh0uSFIt5Aep2VfCuaQ0kmlcxc01+eb8fW0b1IV
	 NS7efikxp+SXjIz2T2/q+A4bvAaUIdp7o6lFsHygv5YLOiG7sisFIyXJNS8zui5OQUW2o
	 TyRybc5XbmWoxz9er/mi9Be9uujEri1G9gka3OGbJnqCfhhxoJhkKEfcmID6kqzTv/sVN
	 jGUZx2BGz+d8Ii15CfIKOTTDWptjh+G+78yAUrpUoR3yYx1ZlpOY7JpIHnU7D3BC/fJnO
	 2PzXM0WkwZQzyTt72t+I0pJtxWgQjGX9tsOFI/OJVyxTogXz+IKFrRk4wYHyr1yOn7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ELyIfafJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E000E606A321;
	Tue, 10 Nov 2026 02:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ELyIfafJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1ECB1F0089F;
	Tue, 10 Nov 2026 02:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794277253;
	bh=NIqOQmbsfVs3wvBHQaYPOQv0i+lEO+2NVk/bDq2h60Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ELyIfafJoLme1SBv2N0kim2ovxiAblyx8rpe39Xe2lJv3YZHR1PtncVAZVOo+pQpK
	 z3Ds8uM4DD8eqpvJlBPwhAh2rxz60HmswaxL6SoXBwiDYg+09c5Q+Mb0ePV39BvduQ
	 e0Gbn9lUgEi+QnFXLBsdndXBC9dd1YEs7bzQ7ZjUUjlZLqY85WziElPyNz77GjKUOn
	 hob0NLZOk3GhFyTDGN8PuElbcMnkJb+H8mrsPap3pEDamsBPatSzcxo+o0jtVGfgDD
	 Tx4mgxUDW3j388V0JBRbY4Ofk1Bczk1CwqQH2AL7sv3NpCE/QWEzE83oeOBic+oczM
	 +un1q94/LQWAQ==
Message-ID: <sashiko-outbox-206040@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 08/10] riscv: stacktrace: switch to frame-pointer
 based unwinder
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shuai Xue" <xueshuai@linux.alibaba.com>, palmer@dabbelt.com, pjw@kernel.org, aou@eecs.berkeley.edu
Cc: alex@ghiti.fr, oleg@redhat.com, rostedt@goodmis.org, mhiramat@kernel.org, mark.rutland@arm.com, peterz@infradead.org, mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org, jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com, joe.lawrence@redhat.com, shuah@kernel.org, mpdesouza@suse.com, martin@kaiser.cx, kmehltretter@gmail.com, oliver.yang@linux.alibaba.com, zhuo.song@linux.alibaba.com, jkchen@linux.alibaba.com, linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, live-patching@vger.kernel.org
In-Reply-To: <20261110013750.36800-9-xueshuai@linux.alibaba.com>
References: <20260914092648.51254-1-xueshuai@linux.alibaba.com>
 <20261110013750.36800-1-xueshuai@linux.alibaba.com>
 <20261110013750.36800-9-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 02:20:51 +0000
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [High] riscv: stacktrace: broken leaf-function unwind in
  kunwind_next_frame_record()
- [High] riscv: stacktrace: broken unwind across ftrace_caller and
  return_to_handler
- [Medium] riscv: stacktrace: bogus walk_stackframe entry in
  __walk_stackframe()
- [Low] riscv: stacktrace: inaccurate metadata type offset comment
--

commit 263985113a916e8cd08cc4485092812e49e28303
Author: Wang Han <wanghan@linux.alibaba.com>

riscv: stacktrace: switch to frame-pointer based unwinder

This commit replaces the open-coded frame-pointer stack walker with a
kunwind state machine, adds arch_stack_walk_reliable(), and routes
perf_callchain_kernel(), dump_backtrace(), and __get_wchan() through
arch_stack_walk().

> diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrac=
e.c
> index a5abb705d43ba..490092c28d612 100644
> --- a/arch/riscv/kernel/stacktrace.c
> +++ b/arch/riscv/kernel/stacktrace.c

[ ... ]

> +/*
> + * Unwind from one frame record to the next.
> + *
> + * On RISC-V, the frame record sits at fp - sizeof(struct frame_record),
> + * immediately below the address pointed to by fp/s0. This applies to bo=
th
> + * normal frame records and metadata frame records (embedded in pt_regs).
> + *
> + * A metadata record is identified by both fp and ra being zero in the
> + * frame_record portion, with a type value following at fp + 16.
> + */

[Severity: Low]
This isn't a bug, but since fp points immediately above struct
frame_record on RISC-V (meta_base =3D fp - sizeof(struct frame_record)),
meta->type is located at fp rather than fp + 16.

> +static __always_inline int
> +kunwind_next_frame_record(struct kunwind_state *state)
> +{
> +	unsigned long fp =3D state->common.fp;
> +	struct frame_record *record;
> +	struct stack_info *info;
> +	unsigned long new_fp, new_pc;
> +	unsigned long record_base;
> +
> +	if (fp & 0x7)
> +		return -EINVAL;
> +
> +	record_base =3D fp - sizeof(*record);
> +
> +	info =3D unwind_find_stack(&state->common, record_base, sizeof(*record)=
);
> +	if (!info)
> +		return -EINVAL;
> +
> +	record =3D (struct frame_record *)record_base;
> +	new_fp =3D READ_ONCE(record->fp);
> +	new_pc =3D READ_ONCE(record->ra);
> +
> +	if (!new_fp && !new_pc)
> +		return kunwind_next_frame_record_meta(state);
> +
> +	unwind_consume_stack(&state->common, info, record_base,
> +			     sizeof(*record));
> +
> +	state->common.fp =3D new_fp;
> +	state->common.pc =3D new_pc;
> +	state->source =3D KUNWIND_SOURCE_FRAME;
> +
> +	return 0;
> +}

[Severity: High]
Does unwinding from KUNWIND_SOURCE_REGS_PC corrupt the unwind and leak
kernel stack addresses when an exception or interrupt hits a leaf
function?

On RISC-V with CONFIG_FRAME_POINTER=3Dy, leaf functions do not push ra onto
the stack: they save only the caller's s0 at fp - sizeof(unsigned long)
(which aliases record->ra), leave the return address in regs->ra, and
leave fp - 2 * sizeof(unsigned long) (record->fp) as uninitialized stack
padding or local storage.

The previous unwinder checked for this case, whereas kunwind_init_from_regs=
()
and kunwind_next_regs_pc() store regs in state->regs without ever reading
it back, and kunwind_next_frame_record() unconditionally reads record->ra
as new_pc and record->fp as new_fp.  Because __kernel_text_address()
filtering is also removed and perf_callchain_kernel() now calls
arch_stack_walk(), a PMU sample in a leaf function passes the caller's
saved kernel stack pointer in record->ra to fill_callchain() ->
perf_callchain_store(), exposing it to userspace, while regs->ra is lost
and the uninitialized word in record->fp is used as the next frame
pointer.

[ ... ]

> +static __always_inline bool
> +arch_reliable_kunwind_consume_entry(const struct kunwind_state *state, v=
oid *cookie)
> +{
> +	/*
> +	 * At an exception boundary we can reliably consume the saved PC. We do
> +	 * not know whether ra was live when the exception was taken, and
> +	 * so we cannot perform the next unwind step reliably.
> +	 *
> +	 * All that matters is whether the *entire* unwind is reliable, so give
> +	 * up as soon as we hit an exception boundary.
> +	 */
> +	if (state->source =3D=3D KUNWIND_SOURCE_REGS_PC)
> +		return false;
> +
> +	return arch_kunwind_consume_entry(state, cookie);
> +}

[Severity: High]
Can kunwind_next_frame_record() and arch_stack_walk_reliable() unwind
across ftrace_caller and return_to_handler?

Unlike arm64, RISC-V's ftrace trampolines do not maintain a valid struct
frame_record chain at s0 - sizeof(struct frame_record):

arch/riscv/kernel/mcount-dyn.S:SAVE_ABI_REGS {
	addi	sp, sp, -FREGS_SIZE_ON_STACK
	REG_S	t0,  FREGS_EPC(sp)
	REG_S	x1,  FREGS_RA(sp)
	REG_S	x8,  FREGS_S0(sp)
    ...
}

arch/riscv/kernel/mcount.S:SAVE_RET_ABI_STATE {
	addi	sp, sp, -FREGS_SIZE_ON_STACK
	REG_S	ra, FREGS_RA(sp)
	REG_S	s0, FREGS_S0(sp)
	REG_S	a0, FREGS_A0(sp)
	REG_S	a1, FREGS_A1(sp)
	addi	s0, sp, FREGS_SIZE_ON_STACK
}

In ftrace_caller, SAVE_ABI_REGS saves ftrace_regs without updating s0 or
creating a frame record, so a C tracer callback saves the traced
function's caller s0 alongside a return address in ftrace_caller.  Walking
past the callback jumps straight from ftrace_caller to the caller of the
traced function, silently skipping both the traced function and its
immediate caller while arch_stack_walk_reliable() still succeeds.  (Commit
"riscv: ftrace: always preserve s0 in dynamic ftrace register frame" noted
that the reliable unwinder would read ftrace_regs_get_frame_pointer(fregs)
directly, but kunwind has no ftrace_regs handling.)

In return_to_handler, SAVE_RET_ABI_STATE sets s0 to sp +
FREGS_SIZE_ON_STACK after saving only ra, s0, a0, and a1.  When unwinding
past ftrace_return_to_handler(), kunwind_next_frame_record() reads
s0 - sizeof(struct frame_record), which sits in the uninitialized upper
words of the __arch_ftrace_regs allocation rather than at FREGS_S0(sp).

[ ... ]

> +/*
>   * The generic code expects the first entry for the current task to be t=
he
>   * return address of arch_stack_walk() itself, the way x86 and arm64 rep=
ort
> - * it, and stack_trace_save() sizes its skip count accordingly.  Walking=
 from
> - * inside a called walk_stackframe() adds that function's own frame on t=
op,
> - * so inline the walker here and start from this frame instead.
> + * it, and stack_trace_save() sizes its skip count accordingly.  Walking
> + * from inside a called walk_stackframe() adds that function's own frame
> + * on top, so call the always-inlined walker here and start from this
> + * frame instead.
>   */
> -noinline noinstr void arch_stack_walk(stack_trace_consume_fn consume_ent=
ry, void *cookie,
> -		     struct task_struct *task, struct pt_regs *regs)
> +noinline noinstr void arch_stack_walk(stack_trace_consume_fn consume_ent=
ry,
> +				      void *cookie, struct task_struct *task,
> +				      struct pt_regs *regs)
>  {
>  	__walk_stackframe(task, regs, consume_entry, cookie);
>  }

[Severity: Medium]
On !CONFIG_FRAME_POINTER builds, doesn't __walk_stackframe() still report
walk_stackframe as the first entry when unwinding the current task?

arch/riscv/kernel/stacktrace.c:__walk_stackframe() {
    ...
	} else if (task =3D=3D NULL || task =3D=3D current) {
		sp =3D current_stack_pointer;
		pc =3D (unsigned long)walk_stackframe;
	} else {
    ...
	ksp =3D (unsigned long *)sp;
	while (!kstack_end(ksp)) {
		if (__kernel_text_address(pc) && unlikely(!fn(arg, pc)))
			break;
		pc =3D READ_ONCE_NOCHECK(*ksp++);
	}
}

Unlike the removed CONFIG_FRAME_POINTER version (which started at
level =3D -1 to skip the placeholder pc), the !CONFIG_FRAME_POINTER loop
calls fn(arg, pc) before reading *ksp++.  As a result, arch_stack_walk()
reports walk_stackframe before scanning its own stack frame, shifting
stack_trace_save() and return_address() off by one and printing a bogus
walk_stackframe entry in dump_backtrace().

Also, since all callers of walk_stackframe() are converted to
arch_stack_walk() by this patch, walk_stackframe() has no remaining
callers and its extern declaration in arch/riscv/include/asm/stacktrace.h
is left without a definition when CONFIG_FRAME_POINTER=3Dy.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110013750.3680=
0-1-xueshuai@linux.alibaba.com?part=3D8
