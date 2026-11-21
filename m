Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795298142;
	b=yQaFUzMOIhfUu5LsJ+JaZfSb58c/ye9ToTmC7nDCtbLswG/byTR8I/FXKZ63jRoEo9UR
	 8a7Bb8sjlR4xpC1Pm5+d0AuDURmEoW6A1uZWQHNFvUkc0MG/mdL12kWuKj+Ld7XXv6vOo
	 DeN4pHejvkXyUYfCity8uDuxnRJVQiks5wuwUc27v54CVrbqvd8L1O/bCWL1ne4NkPQtM
	 gwaHwPWR5fKSB7ecEM2wBi4aBDZYqFbIWWN1VpP9FfWM1SJdQC+DzRFkYOmo4P/+Ho2r4
	 4a3eS0n35Qn6LymVhCgufqTDR2fg6A1+cySaIVOvsDevvqy9z9jLmuZRqLG2O4d7rrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795298142;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=M+VY7WrwsBtiuZdXQn3KrjU1Jy0B0DjsHMk6Q6K2UpU=;
	b=zbrpVGdqcEpyvJGweZ+TlL6KMijmp0oBGPTYV8p8LUIVSYS6EG0JyEdjSlsO98B3RbqG
	 rAzrkWIZalFUEuiP4/EzX17zgGOK0fI2N9eaMrbLaybX6ntnRUuN/cc5/4DpzIosqjUwT
	 xHWHWSxbeNtUXYzSrRewlipRP17Nic5TZhGuE6Us4URzLtpQL/ccMFAQ20Yu6FPOGSbHw
	 IWZyrmwiQwaF5cmbwE1kzDfrpenG7cUM94tyY0J3/uRtJuYm19gtY9c7vOVCv5AWjm5S5
	 xq5x7tdPx8qJ1Tds9NYgTSKpiia9Gvqst0Sb6uv6ZVGW6oqkxsVzixCeU3JntGksbxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="iPqRfy/w";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C107606A333;
	Sat, 21 Nov 2026 21:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iPqRfy/w
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DED741F000C0;
	Sat, 21 Nov 2026 21:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795298141;
	bh=M+VY7WrwsBtiuZdXQn3KrjU1Jy0B0DjsHMk6Q6K2UpU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iPqRfy/wBR9cKrARIIXT4Hu6ZqEts9+yPUAKv+YYLr8YbVK7lGuyeVq/7eKeZzyGl
	 6wvgupOG+3lYBI3ygoP19oUR4UXmZGr5uTSsvE7HA/8jKhhDgHBv6aazyKRhVELQ7K
	 WzXhRzh0xEpSA6GQ/b+K0kV9hVE1sGGku2YQ3H/RToyTk/3EwrU25ZfSUSwCHL0Kfg
	 0c1Vv07P56zI7btUZpRTTGyseT8jDfsf1HLZJtYBd9tz9xLl8gsErl5kNZvLfYzhxE
	 LiwW/qYzcEz/kJEP0TsSWwHe51MCx0EvAapMkqX5iUNqGBCIZCKHp8uwBKI/ud5YrY
	 od4s27Wuiz+gA==
Date: Sat, 21 Nov 2026 13:55:39 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Dylan Hatch <dylanbhatch@google.com>
Cc: Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, 
	Joe Lawrence <joe.lawrence@redhat.com>, Song Liu <song@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Shuah Khan <shuah@kernel.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner <tglx@kernel.org>, live-patching@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched, livepatch: Fix transition stall for CPU-bound
 tasks
Message-ID: <awIMltMpXzhXiDpU@jpoimboe>
References: <20261117045254.1048298-1-dylanbhatch@google.com>
 <20261117045254.1048298-2-dylanbhatch@google.com>
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261117045254.1048298-2-dylanbhatch@google.com>

On Tue, Nov 17, 2026 at 04:52:53AM +0000, Dylan Hatch wrote:
> Commit 676e8cf70cb0 ("sched,livepatch: Untangle cond_resched() and
> live-patching") moved klp_sched_try_switch() from cond_resched() into
> __schedule() and gated it on READ_ONCE(curr->__state) & TASK_FREEZABLE.
> This causes livepatch transitions to stall when a CPU-bound kthread or
> PF_USER_WORKER thread (such as vhost-<pid>) spins in a kernel loop with
> cond_resched() for two reasons:
> 
> 1. A sole runnable task on a CPU (cfs_rq->nr_queued == 1) never has
>    TIF_NEED_RESCHED set during sched_tick(), and wake_up_state(task,
>    TASK_INTERRUPTIBLE) in klp_send_signals() is a no-op for a
>    TASK_RUNNING kthread. Because _cond_resched() is a no-op under
>    CONFIG_PREEMPTION=y, the task only enters __schedule(SM_PREEMPT) on
>    return from interrupts via irqentry_exit_cond_resched() when
>    TIF_NEED_RESCHED is set.
> 2. Even when __schedule() is entered via preemption or an unfreezable
>    sleep (such as PF_NOFREEZE kthreads or PF_USER_WORKER threads
>    sleeping in TASK_INTERRUPTIBLE), curr->__state does not have
>    TASK_FREEZABLE set, so klp_sched_try_switch() skips the task.
>    Livepatch safety in __schedule() is already guaranteed by
>    stack_trace_save_tsk_reliable() inside klp_check_stack().
> 
> Fix both issues by:
> - Removing the TASK_FREEZABLE check from klp_sched_try_switch() and
>   checking TIF_PATCH_PENDING inline via klp_sched_need_resched().
> - Calling resched_curr(rq) in sched_tick() when klp_sched_need_resched()
>   is true for the current task, ensuring CPU-bound tasks with a pending
>   livepatch enter __schedule() at the next timer tick.
> 
> Note that when a CPU-bound task is the sole runnable task on its CPU,
> entering __schedule(SM_PREEMPT) from preempt_schedule_irq() leaves an
> in-kernel interrupt pt_regs frame on the stack during
> klp_sched_try_switch(). Completing the transition in that context
> requires arch_stack_walk_reliable() to support unwinding across
> in-kernel exception frames (as CONFIG_UNWINDER_ORC=y does on x86_64);
> configs and architectures whose reliable unwinder rejects in-kernel
> exception frames (x86 with CONFIG_FRAME_POINTER=y, arm64, powerpc, and
> s390) still require another runnable task to context-switch the spinning
> task out until exception-boundary reliable unwinding (e.g. via SFrame)
> is available.
> 
> Fixes: 676e8cf70cb0 ("sched,livepatch: Untangle cond_resched() and live-patching")

Oof, so Peter's patch broke all non-ORC for this case :-(

Not sure what we can do about that other than get kernel sframe/eh_frame
working for exception boundary unwinding, as you mention.

> Signed-off-by: Dylan Hatch <dylanbhatch@google.com>
> ---
>  include/linux/livepatch_sched.h | 13 +++++++++++--
>  kernel/sched/core.c             |  3 ++-
>  2 files changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/livepatch_sched.h b/include/linux/livepatch_sched.h
> index 065c185f27638..748b6012e2e06 100644
> --- a/include/linux/livepatch_sched.h
> +++ b/include/linux/livepatch_sched.h
> @@ -11,15 +11,24 @@ void __klp_sched_try_switch(void);
>  
>  DECLARE_STATIC_KEY_FALSE(klp_sched_try_switch_key);
>  
> +static __always_inline bool klp_sched_need_resched(struct task_struct *curr)
> +{
> +	return static_branch_unlikely(&klp_sched_try_switch_key) &&
> +	       unlikely(test_tsk_thread_flag(curr, TIF_PATCH_PENDING));
> +}
> +
>  static __always_inline void klp_sched_try_switch(struct task_struct *curr)
>  {
> -	if (static_branch_unlikely(&klp_sched_try_switch_key) &&
> -	    READ_ONCE(curr->__state) & TASK_FREEZABLE)
> +	if (klp_sched_need_resched(curr))
>  		__klp_sched_try_switch();
>  }
>  
>  #else /* !CONFIG_LIVEPATCH */
>  static inline void klp_sched_try_switch(struct task_struct *curr) {}
> +static inline bool klp_sched_need_resched(struct task_struct *curr)
> +{
> +	return false;
> +}
>  #endif /* CONFIG_LIVEPATCH */
>  
>  #endif /* _LINUX_LIVEPATCH_SCHED_H_ */
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 04b62c16fa8ca..fcea9cea3edf1 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -5854,7 +5854,8 @@ void sched_tick(void)
>  	hw_pressure = arch_scale_hw_pressure(cpu_of(rq));
>  	update_hw_load_avg(rq_clock_task(rq), rq, hw_pressure);
>  
> -	if (dynamic_preempt_lazy() && tif_test_bit(TIF_NEED_RESCHED_LAZY))
> +	if ((dynamic_preempt_lazy() && tif_test_bit(TIF_NEED_RESCHED_LAZY)) ||
> +	    klp_sched_need_resched(curr))
>  		resched_curr(rq);

Hm, so for unpatched tasks this forces a full preemption and stack walk
on every scheduler tick?

Instead can we just kick the thread in the existing klp_send_signals()
escalation path like below (untested)?

diff --git a/include/linux/livepatch_sched.h b/include/linux/livepatch_sched.h
index 065c185f27638..77161f5725dcc 100644
--- a/include/linux/livepatch_sched.h
+++ b/include/linux/livepatch_sched.h
@@ -13,8 +13,7 @@ DECLARE_STATIC_KEY_FALSE(klp_sched_try_switch_key);
 
 static __always_inline void klp_sched_try_switch(struct task_struct *curr)
 {
-	if (static_branch_unlikely(&klp_sched_try_switch_key) &&
-	    READ_ONCE(curr->__state) & TASK_FREEZABLE)
+	if (static_branch_unlikely(&klp_sched_try_switch_key))
 		__klp_sched_try_switch();
 }
 
diff --git a/kernel/livepatch/transition.c b/kernel/livepatch/transition.c
index e058d21d84b75..1ccbae2051c72 100644
--- a/kernel/livepatch/transition.c
+++ b/kernel/livepatch/transition.c
@@ -402,12 +402,22 @@ static void klp_send_signals(void)
 		 * Meanwhile the task could migrate itself and the action
 		 * would be meaningless. It is not serious though.
 		 */
-		if (task->flags & PF_KTHREAD) {
+		if (task->flags & (PF_KTHREAD | PF_USER_WORKER)) {
 			/*
 			 * Wake up a kthread which sleeps interruptedly and
 			 * still has not been migrated.
 			 */
-			wake_up_state(task, TASK_INTERRUPTIBLE);
+			if (wake_up_state(task, TASK_INTERRUPTIBLE))
+				continue;
+
+			/*
+			 * If it's running, force it through __schedule() so
+			 * it can switch itself in klp_sched_try_switch().
+			 */
+			if (task_curr(task)) {
+				set_tsk_need_resched(task);
+				kick_process(task);
+			}
 		} else {
 			/*
 			 * Send fake signal to all non-kthread tasks which are
