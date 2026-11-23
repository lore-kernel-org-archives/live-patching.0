Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795468338;
	b=EwDocMCwZ2yMXNsD5P5tb6ueE+E+GV0t9ATV0gLGE0LnCSWfr5qNTtJrvXS5/iZSc/+Z
	 HMhyjP/cTAI4xelkL96PO2BYzz1YlCMAak/5rtTrFbg/2d3YvdPRV74Uw5NAH/tVhZrNj
	 ikyVwjmi0O5we1geBtS9vVoeZR4oLGYVnYCIGX7EaqZUeBebP3QBWe9ZpU+6DYV14M1XH
	 huoR6CraeXU/WCnHQ9FTyD8/53gbKGrq7wIkaC2gOqnvG2EswwQQriMHZT4Y7hv+Bx94p
	 yHPG2EADnGkbtsNEbmX7XKYDpbG3uDiGU7pUbIJ86fn4CW0oQTuhsetXurm826NtLOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795468338;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=R1oqExIXSWBtg0BC5DAPMoFi1VQWg96eIzGMSmLfVyY=;
	b=gR9YcyOo3+GoiJ9/HKD0Ern0Tnp5VcL/HMQvE+WtKK7YmzUKcziYJ24HLIQ45npskvw5
	 OYggtBlvbBfuRYGk2MzWdkg+Y5EvHSHgpFSbPTaBrc87dPKzB6aqj7MzOTwrYQKp+/zsx
	 ilZVvJBWj8g4Hx11R5kDzaSmOyOKXqcpRR0mL8vZ5RoULha83PKQ8FDlyAJRr2hsGPLsZ
	 t8ncg/QMmvsEPCGJ9dktTJaDUFGrJ2C5SliPeTCGRL2eFu6QNCNhmBfYjt9FTq42wlyS3
	 z80xUH43lK0QxgdLtFxsjhDGslsMJDQ9uGownavYVAfpV33FjMmTX+pBxHN5LsoepsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mAy0q8zh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505C6606A321
	for <live-patching@vger.kernel.org>; Mon, 23 Nov 2026 21:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mAy0q8zh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC6571F000CF;
	Mon, 23 Nov 2026 21:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795468338;
	bh=R1oqExIXSWBtg0BC5DAPMoFi1VQWg96eIzGMSmLfVyY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mAy0q8zhmT8bZRC4FN5/gdgjvaDp9DjKYSwXZnziSIP9+aSiLPmNkWCt3XqRhdBF1
	 wvffw5Sa9QmzgrZXnz619FJKCQ3vh/egxa8wZXJB53S8xPZq6SkIIOiJ6ebLRiDyuy
	 kQAk+iGqJhhs/G6CnnR6Cb4VuSD4EKEDICyEMy9H6jTjY/ItQZeO3UMU+vMDiYlP9h
	 SN/A37DYHDn2dWBnfybWQXFg7u63Ek8rjjIFaYXAhEFvpHT6I1/CG9VkZnzP0sRI2D
	 thdbCpXojXcmFvCHGxZiNacLF9/OSOY76d58JBTcWDZ4CVeQF45UY7rrd7JYn7vDMW
	 Y0Xu8tmfKnZMQ==
Message-ID: <sashiko-outbox-230067@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] livepatch: Include exiting tasks in the transition
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
In-Reply-To: <20261123-klp-series-v3-v1-2-427c95811d9b@vt.edu>
References: <20261123-klp-series-v3-v1-0-427c95811d9b@vt.edu>
 <20261123-klp-series-v3-v1-2-427c95811d9b@vt.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 21:12:15 +0000
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] livepatch: race in klp_start_transition() re-sets
  TIF_PATCH_PENDING
- [Medium] livepatch: per-task consistency race after
  exit_tasks_rcu_finish()
--

commit 82efb900438952dc8b24689159b1d649ddb674e7
Author: Binoy Ravindran <binoy@vt.edu>

livepatch: Include exiting tasks in the transition

This commit extends each livepatch transition step to walk the RCU-tasks
exit lists so that unhashed tasks still executing in do_exit() are covered
by the transition.

Link: https://lore.kernel.org/all/20250127063526.76687-1-laoar.shao@gmail.c=
om/

> diff --git a/kernel/livepatch/transition.c b/kernel/livepatch/transition.c
> index 2351a19ac2a9e..cab167417190f 100644
> --- a/kernel/livepatch/transition.c
> +++ b/kernel/livepatch/transition.c

[ ... ]

> @@ -527,6 +595,7 @@ void klp_start_transition(void)
>  		if (task->patch_state !=3D klp_target_state)
>  			set_tsk_thread_flag(task, TIF_PATCH_PENDING);
>  	read_unlock(&tasklist_lock);
> +	rcu_tasks_visit_exiting(klp_exiting_start, NULL);

[Severity: Medium]
Can klp_exiting_start() re-set TIF_PATCH_PENDING on a task that has already
switched to klp_target_state during the first loop?

Between exit_tasks_rcu_start() and unhashing in release_task(), an exiting
task is on both tasklist and rtp_exit_list (for example, a PID namespace
child reaper sleeping with TASK_FREEZABLE set in zap_pid_ns_processes()).
When klp_reverse_transition() calls klp_start_transition(),
klp_sched_try_switch_key is already enabled from the initial
klp_start_transition(), so the task can switch in schedule() between the two
walks:

CPU0                                  CPU1 (exiting task)
klp_reverse_transition()
  klp_start_transition()
    for_each_process_thread()
      set_tsk_thread_flag(t,
        TIF_PATCH_PENDING)
                                      schedule()
                                        __klp_sched_try_switch()
                                          ...
                                          klp_check_and_switch_task()
                                            clear_tsk_thread_flag(t,
                                              TIF_PATCH_PENDING)
    rcu_tasks_visit_exiting()
      klp_exiting_start()
        if (t->patch_state !=3D
            klp_target_state)
          set_tsk_thread_flag(t,
            TIF_PATCH_PENDING)
                                            t->patch_state =3D klp_target_s=
tate

Subsequent klp_try_switch_task() calls see t->patch_state =3D=3D klp_target=
_state
and return true without clearing TIF_PATCH_PENDING.  When
klp_complete_transition() runs, its for_each_process_thread() loop executes
before rcu_tasks_visit_exiting(klp_exiting_complete, NULL) and hits
WARN_ON_ONCE(test_tsk_thread_flag(task, TIF_PATCH_PENDING)) if the task is
still on tasklist (or is an EXIT_ZOMBIE task that has already passed
exit_tasks_rcu_finish()).

[ ... ]

> @@ -580,6 +649,7 @@ void klp_init_transition(struct klp_patch *patch, int=
 state)
>  		task->patch_state =3D initial_state;
>  	}
>  	read_unlock(&tasklist_lock);
> +	rcu_tasks_visit_exiting(klp_exiting_init, &initial_state);

[Severity: Medium]
Can an unhashed task that has already called exit_tasks_rcu_finish() be
missed by both walks here and in klp_try_complete_transition()?

In do_exit(), exit_tasks_rcu_finish() removes the task from rtp_exit_list
with interrupts enabled while the task continues executing as current
through lockdep_free_task(), do_task_dead(), and __schedule(SM_NONE) up to
context_switch():

CPU0                                  CPU1 (self-reaping task)
                                      do_exit()
                                        exit_notify() (unhashed)
                                        preempt_disable()
                                        exit_tasks_rcu_finish()
klp_init_transition()
  for_each_process_thread()
  rcu_tasks_visit_exiting()
  func->transition =3D true
                                        do_task_dead() / <hardirq>
                                          klp_ftrace_handler()
                                            patch_state =3D=3D KLP_TRANSITI=
ON_IDLE
                                            <-- WARN_ON_ONCE and wrong func

Because the task is on neither list after exit_tasks_rcu_finish() and
klp_init_transition() does not call klp_synchronize_transition() before
setting func->transition =3D true, any patched function called before
context_switch() (or from an IRQ before local_irq_disable() in __schedule())
observes KLP_TRANSITION_IDLE (or a stale patch_state if an earlier
klp_complete_transition() also missed the task), triggers WARN_ON_ONCE(),
and selects func->new_func regardless of initial_state.

Likewise, if an unswitched exiting task passes exit_tasks_rcu_finish() just
before klp_try_complete_transition() snapshots the exit lists, the
transition completes and klp_complete_transition() runs
klp_unpatch_replaced_patches(), klp_discard_nops(), klp_unpatch_objects(),
and clears func->transition =3D false before klp_synchronize_transition()
waits for the non-preemptible tail of do_exit() to switch out.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123-klp-series=
-v3-v1-0-427c95811d9b@vt.edu?part=3D2
