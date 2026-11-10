Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794276624;
	b=fJ/WM42pg+mDlcTIN8vOpvYu/dZCXAWVuQff/PC3cujWnYzyV99pewBf/aQEkLUNfcU2
	 dCTJHsWxZMEn5XWL+GeFa30E4kqQSLcBlpggDHvyQ7JOlD2jun/j56PkVYRXljy/a0UpZ
	 QExdeobN/ymT6VBNZ/NmZveSxiZDSpdOoR6Ns3MzN/eI0avBQigUAdJVzUwGgP35mYypH
	 SUdsQNWoVMmC5OvbH4FskUNKhSJXfKKXilHQWJnDtm8sXD8d5fy5yOS03IOO5u7mHlQLF
	 /W5f1ZOH0tw+5llnjvcOkcBWc6JwbIzD5nsEXAcxaj7w6OYqX1R+PH/Lt/a3xYPQM5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794276624;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=nPnnMOZqYt8lLl9l7pm+LsWMW6V6ExRJbWXpfXCeafc=;
	b=QOvrE1e2ETDhKGffWuWeMK67w/7q/W7YHDnIWTx4NzXhZqFWGunPwd3+h8zZCcC0XdBe
	 cjtFt1vAlViIO9ujvSFpu0TL8ZMJ/+hGZ8Yo4a17vVlJy+yCj+XfESc2gn3hQxuVLDojf
	 7YroyB5eGi82+Pn7OFcX++D5kDWY0YIceufxIQEMiWqb8D8e5oui330TB2dZBg/NAwCOI
	 VFRYdmbYoOr9HXpq4SgBC8hyiTZF5SjsVTEMvUq+3Ng81R6UoJ5GCNzqnya3dogwzDzgT
	 bdsTTuPf+SemBD1lUxOFhTEcGKaSw2Ok9rqZK2ARpyrnUoJwCs/hPgf8cT7iGdIfqGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dYYtq4R3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C59606A31C;
	Tue, 10 Nov 2026 02:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dYYtq4R3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76D661F0089F;
	Tue, 10 Nov 2026 02:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794276624;
	bh=nPnnMOZqYt8lLl9l7pm+LsWMW6V6ExRJbWXpfXCeafc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dYYtq4R3ZId/jd4Hvlul01rATjsJnXAP8BEsjmdUkmixQmtxvuz+oJwby3w5AO5xX
	 y1CuDC/pY1smjweqqP1jigJ+7H1WHCUdhptx9WCnar+brlDbpx1/W4dp/O5EG0spqb
	 eWNU2+w+Qxt5OT2Av6ldyIknsUG6LVTGjCfALVZI247mQTse8CTj+3ALdJQhwoHwda
	 2PuNxOnp+1nLAvhznvOZcuBHP4b7CW5yoC+kO/QtAzxWwJcARlHuT7T4qF+0fT9LZJ
	 xwbTVIulS7Naw9VgEB9Qo1cDBA+iHJdeyge/Wo0Ne3LOtNmAjUfeI0LdBU9i4wK1VS
	 cccnkbquyCaww==
Message-ID: <sashiko-outbox-206030@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 09/10] riscv: Kconfig: enable
 HAVE_RELIABLE_STACKTRACE and HAVE_LIVEPATCH
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shuai Xue" <xueshuai@linux.alibaba.com>, palmer@dabbelt.com, pjw@kernel.org, aou@eecs.berkeley.edu
Cc: alex@ghiti.fr, oleg@redhat.com, rostedt@goodmis.org, mhiramat@kernel.org, mark.rutland@arm.com, peterz@infradead.org, mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org, jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com, joe.lawrence@redhat.com, shuah@kernel.org, mpdesouza@suse.com, martin@kaiser.cx, kmehltretter@gmail.com, oliver.yang@linux.alibaba.com, zhuo.song@linux.alibaba.com, jkchen@linux.alibaba.com, linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, live-patching@vger.kernel.org
In-Reply-To: <20261110013750.36800-10-xueshuai@linux.alibaba.com>
References: <20260914092648.51254-1-xueshuai@linux.alibaba.com>
 <20261110013750.36800-1-xueshuai@linux.alibaba.com>
 <20261110013750.36800-10-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 02:10:22 +0000
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
- [High] riscv: module: fault and UAF in apply_relocate_add() for klp
  relocs
- [Medium] riscv: stacktrace: ftrace_caller() omits frames in reliable
  unwind
- [Medium] riscv: stacktrace: uninitialized frame read in
  return_to_handler()
- [Medium] riscv: stacktrace: arch_rethook_trampoline() omits caller
  frame
--

commit 57947c1aaf895b44b13bb74dddecd8c57f82bb66
Author: Wang Han <wanghan@linux.alibaba.com>

riscv: Kconfig: enable HAVE_RELIABLE_STACKTRACE and HAVE_LIVEPATCH

This commit selects HAVE_RELIABLE_STACKTRACE and HAVE_LIVEPATCH on 64-bit
RISC-V configurations with FRAME_POINTER enabled, and sources
kernel/livepatch/Kconfig.

> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index e7891a2a89da6..4512f67bbfd98 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -186,6 +186,7 @@ config RISCV
>  	select HAVE_KRETPROBES
>  	# https://github.com/ClangBuiltLinux/linux/issues/1881
>  	select HAVE_LD_DEAD_CODE_DATA_ELIMINATION if !LD_IS_LLD
> +	select HAVE_LIVEPATCH if FRAME_POINTER && 64BIT

[Severity: High]
Can klp_apply_object_relocs() -> apply_relocate_add() trigger a store page
fault and use-after-free when applying late .klp.rela.<module>.* relocation=
s?

During load_module(), complete_formation() marks module text and rodata
(including .plt, .got, and .got.plt) read-only under CONFIG_STRICT_MODULE_R=
WX
before klp_enable_patch() or klp_module_coming() runs.  When
apply_relocate_add() is later called on a module with mod->state !=3D
MODULE_STATE_UNFORMED, the relocation handlers in arch/riscv/kernel/module.c
(such as riscv_insn_rmw()) and module_emit_got_entry() /
module_emit_plt_entry() in arch/riscv/kernel/module-sections.c write direct=
ly
to read-only module memory instead of using text patching helpers and
flushing the instruction cache:

arch/riscv/kernel/module.c:riscv_insn_rmw() {
	...
	parcel[0] =3D cpu_to_le16(insn);
	parcel[1] =3D cpu_to_le16(insn >> 16);
	return 0;
}

In addition, module_frob_arch_sections() caches pointers into the temporary
info->sechdrs buffer in mod->arch.plt.shdr, mod->arch.got.shdr, and
mod->arch.got_plt.shdr, which free_copy() frees via vfree() at the end of
load_module():

arch/riscv/kernel/module-sections.c:module_frob_arch_sections() {
	...
	for (i =3D 0; i < ehdr->e_shnum; i++) {
		if (!strcmp(secstrings + sechdrs[i].sh_name, ".plt"))
			mod->arch.plt.shdr =3D sechdrs + i;
		else if (!strcmp(secstrings + sechdrs[i].sh_name, ".got"))
			mod->arch.got.shdr =3D sechdrs + i;
		else if (!strcmp(secstrings + sechdrs[i].sh_name, ".got.plt"))
			mod->arch.got_plt.shdr =3D sechdrs + i;
	}
	...
}

When late livepatch relocations emit GOT or PLT entries,
module_emit_got_entry() and module_emit_plt_entry() dereference these freed
shdr pointers (e.g. got_sec->shdr->sh_addr), and re-applying relocations wh=
en
a target module is reloaded increments num_entries past max_entries and hits
BUG_ON().

>  	select HAVE_MOVE_PMD
>  	select HAVE_MOVE_PUD
>  	select HAVE_PAGE_SIZE_4KB
> @@ -195,6 +196,7 @@ config RISCV
>  	select HAVE_PERF_USER_STACK_DUMP
>  	select HAVE_POSIX_CPU_TIMERS_TASK_WORK
>  	select HAVE_REGS_AND_STACK_ACCESS_API
> +	select HAVE_RELIABLE_STACKTRACE if FRAME_POINTER && 64BIT

[Severity: Medium]
Does arch_stack_walk_reliable() silently omit the traced function and its
caller when unwinding a task inside an ftrace callback or direct trampoline?

With CONFIG_DYNAMIC_FTRACE_WITH_ARGS, the patchable entry of a traced
function jumps to ftrace_caller before the function sets up its stack frame.
At that point, t0 holds the traced function's PC, ra holds the return addre=
ss
in its caller, and s0 still holds the caller's frame pointer.  In
arch/riscv/kernel/mcount-dyn.S, SAVE_ABI_REGS saves t0, x1, and x8 into
struct __arch_ftrace_regs without constructing frame records on the stack or
updating s0:

arch/riscv/kernel/mcount-dyn.S:SAVE_ABI_REGS {
	addi	sp, sp, -FREGS_SIZE_ON_STACK
	REG_S	t0,  FREGS_EPC(sp)
	REG_S	x1,  FREGS_RA(sp)
	REG_S	x8,  FREGS_S0(sp)
	...
}

When ftrace_caller calls op->func, op->func saves the unchanged s0 in its
frame record.  Unwinding that frame record in kunwind_next_frame_record()
advances directly to the caller's caller with state->source =3D=3D
KUNWIND_SOURCE_FRAME, which arch_reliable_kunwind_consume_entry() accepts as
reliable.  During a livepatch transition, klp_check_stack() can miss that a
preempted or blocked task is executing inside a patched function or its
caller.

[Severity: Medium]
Can kunwind_next_frame_record() read uninitialized stack memory when
unwinding through return_to_handler()?

In arch/riscv/kernel/mcount.S, SAVE_RET_ABI_STATE allocates
FREGS_SIZE_ON_STACK bytes, saves ra and s0 at low offsets from sp, and sets
s0 to sp + FREGS_SIZE_ON_STACK before return_to_handler calls
ftrace_return_to_handler():

arch/riscv/kernel/mcount.S:SAVE_RET_ABI_STATE {
	addi	sp, sp, -FREGS_SIZE_ON_STACK
	REG_S	ra, FREGS_RA(sp)
	REG_S	s0, FREGS_S0(sp)
	REG_S	a0, FREGS_A0(sp)
	REG_S	a1, FREGS_A1(sp)
	addi	s0, sp, FREGS_SIZE_ON_STACK
}

The 16 bytes at s0 - 16 (sp + FREGS_SIZE_ON_STACK - 16) are never
initialized.  When unwinding a task inside ftrace_return_to_handler(),
kunwind_next_frame_record() restores fp =3D sp + FREGS_SIZE_ON_STACK and on=
 the
next step reads fp - sizeof(*record) as a struct frame_record, either
triggering WARN_ON_ONCE(tsk =3D=3D current) in kunwind_next_frame_record_me=
ta()
if those bytes happen to be zero or following a bogus frame pointer and
skipping live frames while returning 0 (reliable).

[Severity: Medium]
Does unwinding from inside arch_rethook_trampoline_callback() omit the call=
er
of the probed function while still reporting a reliable stack trace?

When a kretprobed function returns to arch_rethook_trampoline(), its epilog=
ue
has already restored s0 to its caller's frame pointer, while the return
address in the caller is held in current->rethooks.  In
arch/riscv/kernel/probes/rethook_trampoline.S, arch_rethook_trampoline
allocates PT_SIZE_ON_STACK without initializing S_STACKFRAME
(FRAME_META_TYPE_PT_REGS) or updating s0 before calling
arch_rethook_trampoline_callback():

arch/riscv/kernel/probes/rethook_trampoline.S:arch_rethook_trampoline() {
	addi sp, sp, -(PT_SIZE_ON_STACK)
	save_all_base_regs

	move a0, sp /* pt_regs */

	call arch_rethook_trampoline_callback
	...
}

When kunwind unwinds arch_rethook_trampoline_callback()'s frame record,
state->common.pc is inside arch_rethook_trampoline (past the entry address
checked by is_kretprobe_trampoline()) and state->common.fp is the caller's
frame pointer.  The next unwind step reads the frame record of the caller's
caller, skipping the caller of the probed function and returning 0
(reliable).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110013750.3680=
0-1-xueshuai@linux.alibaba.com?part=3D9
