Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795581988;
	b=E0drwjMPxB/9UB6FHqCaqCoCust+Sr2tJ6D9WJ9BtkT8BP8W2DulfyQ8bHBo8yqrN3IM
	 ZboaPYomd9CDCve3dHWrhkkeErwGKkOCw3AP7nQEsvGw/0ZOmXJ8tQk4A+HRCznHOEQWU
	 A16AtvpAADZqEguzmPqLq61F7lYAinTaNfuSKEm4VowufRBuctc4ka1DMhXzNdhPyjBTX
	 2BCWZlciv3eqDzE+aSR2mpmOFDvJPEtSk1MYz0zqByrOCM6rvp1Xh8k7I27ORTiEFKYxK
	 INTJjzrKYIHqsDowkmVzKYKMfIQVW1w5f/Fb8L/54IxIW+juRTxwmDa5JaviNCsAxyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795581988;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=w5IFRfRWnbjbRoQCF0p762hOgKmmU2wQjQdXX9xoXfk=;
	b=a3bA+pdHVn75vcuEILN0bKozsklZA+Cfx1fViIBhgnY0Lbf87fTwwABMvQI71m9g6nrM
	 MHMps9ziCGIVWZ4ESIfVHCprwHdQSH8EkXioz0KDFyN/oi8I4BSX7MppbECUEU9HmTPEW
	 Ddfl3QK04uuIDRsWpjTYufI8Rp6j4RbFa6j0WpDWPFEbwiREO8hUtbPafOLfunqBncq9Y
	 fFK8ZQpSlAPkTpUFLkDoVfsltCBzNo+O69LvrFUM3OVx63azAV6fA6Syv0Maxt0sf/+lA
	 aPay+wvPBGt7JItrNURPE6kMBxLkNjRTs3HQ1P3FWSJlhmnpmtFWBLl+yhOhWOpprNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=alvK4Byz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA338606A31E
	for <live-patching@vger.kernel.org>; Wed, 25 Nov 2026 04:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=alvK4Byz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 392091F000CA;
	Wed, 25 Nov 2026 04:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795581988;
	bh=w5IFRfRWnbjbRoQCF0p762hOgKmmU2wQjQdXX9xoXfk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=alvK4ByzwjuMFO+s+yCqCWs2l52SIp0o/ftUUg77NE5tLngKewjHHET4puA7SD0Yy
	 LvGzQxbQkPSv60etMUWG5QjZZzxxhHleJ9wy0KlPxdA3/b2vWNnaeSDXF5Cra4Jhy/
	 1bdPQDai6zO4YC2WZxGYaTZhR474KmRkUJeNZbAd2JWeyEiZ26uF98UrY3JQolNYlB
	 RrLbJc+iYxX6fMEM7t8DrQQAQMBxManunHJS3+S7xJRiP6SSmEv5AanDLJjEe9YrUz
	 3HVTFNSgaR8itAKdQ4XBVwWJwnJn7z0f4JKeBxW1jDGt1gDJtXi62dImZ3edospeev
	 heY2ADsjSgilQ==
Message-ID: <sashiko-outbox-232592@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] sched, livepatch: Fix transition stall for
 CPU-bound tasks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dylan Hatch" <dylanbhatch@google.com>, "Josh Poimboeuf" <jpoimboe@kernel.org>, "Miroslav
 Benes" <mbenes@suse.cz>, "Petr Mladek" <pmladek@suse.com>, "Joe Lawrence" <joe.lawrence@redhat.com>, "Song
 Liu" <song@kernel.org>, "Ingo Molnar" <mingo@redhat.com>, "Peter Zijlstra" <peterz@infradead.org>, "Juri
 Lelli" <juri.lelli@redhat.com>, "Vincent Guittot" <vincent.guittot@linaro.org>, "Shuah
 Khan" <shuah@kernel.org>
Cc: "Dietmar Eggemann" <dietmar.eggemann@arm.com>, "Steven Rostedt" <rostedt@goodmis.org>, "Ben
 Segall" <bsegall@google.com>, "Mel Gorman" <mgorman@suse.de>, "Valentin
 Schneider" <vschneid@redhat.com>, "K Prateek Nayak" <kprateek.nayak@amd.com>, "Sebastian
 Andrzej Siewior" <bigeasy@linutronix.de>, "Thomas Gleixner" <tglx@kernel.org>, live-patching@vger.kernel.org
In-Reply-To: <20261125041900.3243569-2-dylanbhatch@google.com>
References: <20261125041900.3243569-1-dylanbhatch@google.com>
 <20261125041900.3243569-2-dylanbhatch@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 04:46:26 +0000
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] livepatch: klp_sched_try_switch() transitions task inside
  klp_ftrace_handler()
--

commit 838d28a5585cbc1f5e4b8cf8405e19da19b1f60d
Author: Dylan Hatch <dylanbhatch@google.com>

sched, livepatch: Fix transition stall for CPU-bound tasks

This commit removes the TASK_FREEZABLE check from klp_sched_try_switch() and
updates klp_send_signals() to wake PF_USER_WORKER threads and call
resched_cpu() on running tasks with pending livepatch transitions.

> diff --git a/include/linux/livepatch_sched.h b/include/linux/livepatch_sc=
hed.h
> index 065c185f27638..533b754f10da4 100644
> --- a/include/linux/livepatch_sched.h
> +++ b/include/linux/livepatch_sched.h
> @@ -14,7 +14,7 @@ DECLARE_STATIC_KEY_FALSE(klp_sched_try_switch_key);
>  static __always_inline void klp_sched_try_switch(struct task_struct *cur=
r)
>  {
>  	if (static_branch_unlikely(&klp_sched_try_switch_key) &&
> -	    READ_ONCE(curr->__state) & TASK_FREEZABLE)
> +	    unlikely(test_tsk_thread_flag(curr, TIF_PATCH_PENDING)))
>  		__klp_sched_try_switch();
>  }

[Severity: High]
Can removing the TASK_FREEZABLE check switch a task while it is preempted
at the end of klp_ftrace_handler(), after the handler has already redirected
ftrace_regs to the previous patch state's function?

During an unpatch transition (or a stacked/replace patch transition), a task
with current->patch_state =3D=3D KLP_TRANSITION_PATCHED calling a patched
function can be preempted before ftrace_caller transfers control to the
selected target:

ftrace_caller
  klp_ftrace_handler()
    ftrace_test_recursion_trylock()       /* disables preemption */
    ftrace_regs_set_instruction_pointer(fregs, func->new_func)
    ftrace_test_recursion_unlock()
      preempt_enable_notrace()
        preempt_schedule_notrace()
          __schedule(SM_PREEMPT)
            klp_sched_try_switch()
              klp_check_stack()           /* sees only func->old_func */
              klp_update_patch_state()    /* sets KLP_TRANSITION_UNPATCHED =
*/
  /* returns to func->new_func while task is KLP_TRANSITION_UNPATCHED */

ftrace_regs_set_instruction_pointer() only updates the saved IP inside
ftrace_regs; the return address slot unwound by arch_stack_walk_reliable()
still holds func->old_func + MCOUNT_INSN_SIZE until klp_ftrace_handler()
returns to ftrace_caller.  When klp_target_state is KLP_TRANSITION_UNPATCHED
(or when patching over a stacked patch), klp_check_stack_func() checks the
stack against func->new_func (or prev->new_func), so klp_check_stack()
succeeds and transitions the task.

When __schedule() returns, ftrace_caller jumps into func->new_func even
though the task's patch_state is now KLP_TRANSITION_UNPATCHED, breaking
per-task consistency.  If __schedule() context-switches the task out after
klp_sched_try_switch() marks it unpatched, klp_complete_transition() and
klp_synchronize_transition() can also finish unpatching and allow the
livepatch module to be unloaded before the task is scheduled back in and
jumps to the freed func->new_func address.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125041900.3243=
569-1-dylanbhatch@google.com?part=3D1
