Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795649610;
	b=tUuwKsLPuutgDgjGp0477kYTlHsrOEilKIBk88sYLg7ztKpRKGC14+AkNzyV7w+rovVc
	 LqHcxiSblShdhLSYku2e+5yGaaWfuOjbRFOSuEZvXTfbSQ6fmSs6mokapcLL1W9W4jmWm
	 GQLLePpj/cW8pie9J8woPiz8aYw0kJr8J58T/EDBFpYJSGvFQ+ZfkfBNcc5I8Q4yz5xN5
	 NVA2hLwEfMfh/R2aAh1XNIXJ22gTSHeI4Zqv1CbjPbV50L+6DYI6Q/c89A3n6p/QINsWY
	 +njzrtRz5utRvbVgMgmwnLf1MbLFTKRFbMRcx9ckc3p1N2d5YbPZXpA5Vf0akIfWT8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795649610;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/if7nkCA6ABnS6m0gEnbrOkWCeSd100m7Z7EjpK7RwM=;
	b=ZCsE7WGI/TwmSc4vYU+mWZl+9y2uxJy3ODLeU1hNWu2NUGf4qgAY6QMRvB+ZmL4q+A9g
	 y3yWMK93J6eFZiBSq1NWXvPu5qcjl5hiaXqvS71ymxcUgZEEOZLKh563uHvq6Cxdtvjqq
	 94vJ4UwGgbs/iWaIHi4jSIP/ytI7lM3/LMtRyd9BHYjbllqT4c1S0QXDlWX96PCxBxZPO
	 vusk2yy6R9UNsN0uafLegjWoiyXISyYMPUu94N6up9kTHgPhvPHn8uv8MqCgICBfNhULY
	 RXNuUPAHnzunmrYwp75Gx91R/47//m3A4SBpmsDINgj1kiUqGs7s12PwKkgIkG67JiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MqM5GAmJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51303606A321
	for <live-patching@vger.kernel.org>; Wed, 25 Nov 2026 23:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MqM5GAmJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA7CE1F000C4;
	Wed, 25 Nov 2026 23:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795649610;
	bh=/if7nkCA6ABnS6m0gEnbrOkWCeSd100m7Z7EjpK7RwM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MqM5GAmJv6WPZCX12G8Hk5hLsYnn1KQaz8dd8Fy4R7ZhKko1O5iirsXFnTSdpgDJK
	 +8ZWL0E75Lo7yLMVrfuRkC8pXRz0Xv8INFZAj33lzGwBMHeRFKi+izfyQXJYz6hhZW
	 oTuf0NXS+j3VIwF3oPEM7beCZLndKkISpSwTVajsaMmCbu8NXY8dy/EtGM7pDS6sdc
	 HMrxpQlFqnrNJF2DP55j7BsqpSGUIWEm4l5HHuxu8qy9BD443b1klFL9zhmjvk6rYG
	 2/NHqUFox47A+3D2Yw3AoUbEt1cj4/OOnBHertE0xfbQVOdNip8yoYviHAXDfHlGT2
	 FdS7oNC+K8NRg==
Message-ID: <sashiko-outbox-234405@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/3] livepatch: Include exiting tasks in the
 transition
Reply-To: sashiko-reviews@lists.linux.dev
To: "Binoy Ravindran" <binoy@vt.edu>, "Paul E. McKenney" <paulmck@kernel.org>, "Frederic
 Weisbecker" <frederic@kernel.org>, "Neeraj Upadhyay" <neeraj.upadhyay@kernel.org>, "Joel
 Fernandes" <joelagnelf@nvidia.com>, "Josh Triplett" <josh@joshtriplett.org>, "Boqun
 Feng" <boqun@kernel.org>, "Uladzislau Rezki" <urezki@gmail.com>, "Steven
 Rostedt" <rostedt@goodmis.org>, "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>, "Lai
 Jiangshan" <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, "Josh
 Poimboeuf" <jpoimboe@kernel.org>, "Miroslav Benes" <mbenes@suse.cz>, "Petr
 Mladek" <pmladek@suse.com>, "Joe Lawrence" <joe.lawrence@redhat.com>, "Song
 Liu" <song@kernel.org>, "Ingo Molnar" <mingo@kernel.org>, "Jiri Kosina" <jikos@kernel.org>
Cc: live-patching@vger.kernel.org, "Yafang Shao" <laoar.shao@gmail.com>, "Jaidev
 Shastri" <jaidevshastri@vt.edu>
In-Reply-To: <20261125-klp-series-v3-v3-2-b1e0f79af331@vt.edu>
References: <20261125-klp-series-v3-v3-0-b1e0f79af331@vt.edu>
 <20261125-klp-series-v3-v3-2-b1e0f79af331@vt.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 23:33:28 +0000
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
- [Medium] livepatch: synchronize_rcu() returns before dying task
  finishes __schedule()
--

commit 92ba6cc4a8d2e1bcb38ce05b46cd777e11fa7ede
Author: Binoy Ravindran <binoy@vt.edu>

livepatch: Include exiting tasks in the transition

This commit extends livepatch transitions to visit exiting tasks on the
RCU-tasks exit lists and uses synchronize_rcu() to wait for tasks that
have already left the exit lists to finish their final context switch.

Link: https://lore.kernel.org/all/20250127063526.76687-1-laoar.shao@gmail.c=
om/

> diff --git a/kernel/livepatch/transition.c b/kernel/livepatch/transition.c
> index 2351a19ac2a9e..0edcb9f9c663b 100644
> --- a/kernel/livepatch/transition.c
> +++ b/kernel/livepatch/transition.c

[ ... ]

> @@ -489,6 +570,12 @@ void klp_try_complete_transition(void)
>  	/* Done!  Now cleanup the data structures. */
>  	klp_resched_disable();
>  	patch =3D klp_transition_patch;
> +	/*
> +	 * A task can leave the exit lists unswitched after the snapshot. It
> +	 * runs with preemption disabled until its final switch, so
> +	 * synchronize_rcu() waits it out, as in rcu_tasks_postgp().
> +	 */
> +	synchronize_rcu();
>  	klp_complete_transition();
> =20
>  	/*

[ ... ]

> @@ -590,6 +679,14 @@ void klp_init_transition(struct klp_patch *patch, in=
t state)
>  		task->patch_state =3D initial_state;
>  	}
> =20
> +	/*
> +	 * A task that has passed exit_tasks_rcu_finish() is on neither list but
> +	 * may still call patched code until its final switch. It runs with
> +	 * preemption disabled, so synchronize_rcu() returns only after every
> +	 * such task is gone, as in rcu_tasks_postgp().
> +	 */
> +	synchronize_rcu();
> +
>  	/*
>  	 * Enforce the order of the task->patch_state initializations and the
>  	 * func->transition updates to ensure that klp_ftrace_handler() doesn't

[Severity: Medium]
Can synchronize_rcu() in klp_try_complete_transition() and
klp_init_transition() return while a dying task is still executing
__schedule() before switch_to()?

When do_exit() reaches do_task_dead() -> __schedule(),
klp_sched_try_switch() is a no-op because curr->__state is TASK_DEAD
rather than TASK_FREEZABLE, and rcu_note_context_switch() reports the RCU
quiescent state near the start of __schedule() while current is still the
dying task:

CPU0 (dying task)                 CPU1 (livepatch transition)
do_exit()
  preempt_disable()
  exit_tasks_rcu_finish()
                                  klp_init_transition()
                                    /* walks miss CPU0's task */
                                    synchronize_rcu()
  do_task_dead()
    __schedule()
      klp_sched_try_switch(prev)
      rcu_note_context_switch()
                                    /* synchronize_rcu() returns */
                                    func->transition =3D true
      pick_next_task()
        klp_ftrace_handler()
          <-- sees patch_state =3D=3D KLP_TRANSITION_IDLE
      context_switch()
        switch_to()

If a livepatch patches any function called in __schedule() between
rcu_note_context_switch() and switch_to() (such as update_rq_clock(),
try_to_block_task(), pick_next_task(), or psi_sched_switch()),
klp_ftrace_handler() can hit WARN_ON_ONCE(patch_state =3D=3D
KLP_TRANSITION_IDLE) on the uninitialized task during
klp_init_transition(), or klp_complete_transition() can unpatch replaced
patches and clear func->transition while an unswitched dying task is
still running inside __schedule().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125-klp-series=
-v3-v3-0-b1e0f79af331@vt.edu?part=3D2
