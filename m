Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795795844;
	b=uFJAkOzrtoR3Rs7WsVAz4Fw6bKhZD6qDdpRQSY2NOr+GNnWqJjulASTPdnVmGoEwVA+Q
	 DU2mB+Yea3Qmzpu4ID+SqvJaKnK63jrPZJoSShDibW89HnXtFkttBnSJ0DsABuTuOfzim
	 etVsyXaPNiNm3dxLvtWl5GqXZxkxkWoirJludLXTZHM5D5hjvcB2crzZcvHAPjMvGGvtk
	 2cxqKY0ke7ozt4z+eV/jzlSR7zNkP2JzQTSyx8IhwsqqmA6jyKqfMN70j+dHC73L0xhCb
	 2bVcDFQOjmHwOkUKP+MWR+PLElB7gqGotbNkoEZ8bZLU7ecPNHak8mqEvhTxJ4JuXSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795795844;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=iVhsmly2cOT49BUGNNoiSt8eC/rvBwIir2jFZoGobdk=;
	b=cULLwWscYEputx9I8aemn9Ek26DpsFqZghTdn39Cpf23cdnhMAUon4/hHd71IYBA0vVw
	 DKqlz5vkjIsYi3yTu3YhWE5skbhdMGEaar1gS3jGIoiFfyWBhnqLckOqaxozdIoy82gHk
	 tEy55FNxq6stkuvWMLUT9zC/Eb1eJLOUf4hsgTBIan/vfYi20B0Qb3NTnXQxfWOsXhxD6
	 alCdi0KCvYgNtb0fHERPTqSytsJdEqwgBTSnHEhDaSUUuuVJsXIeYFATmtED/JxhFER/k
	 NMb9KawxsXLSQ4i0/Tyn7rGzQ+gEnlI8+c8br+1vKN6xyHHMugzWlA8P9T+YTeLNAeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=GisTdvnI;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8386606A31C
	for <live-patching@vger.kernel.org>; Fri, 27 Nov 2026 16:10:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8386606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=GisTdvnI
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a207b02a2cso59552045e9.1
        for <live-patching@vger.kernel.org>; Fri, 27 Nov 2026 08:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1795795842; x=1796400642; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iVhsmly2cOT49BUGNNoiSt8eC/rvBwIir2jFZoGobdk=;
        b=GisTdvnIDRCUhv3R+I2OJ0AwssL5m38E6DNw06NjxXL9Rt2ti1b5mU01ujDGI39Wch
         dI/SW4E4vevX5f3TxBlg8fUsT312YaEiUyl1R3ulTQadSYfBbl2bOByJnjkOoPGMfg+c
         xTo7vvZ+MEFNWDt5xJ05IPOLT+hBTG1JLadCU4mH7FH6oMNkRt3/lq1FxzzlVxtaBYAs
         xQmRKPQpd7dd9gXi5cer2vjteUh/4trlioaMxreIlG5SRyaWT1dIcpZ0H2FFLl9EiFr9
         xMYYi8bqixWie4TzIOcHbscp1pQGiJXKQ0EtTBaNEBCqlBqhwbGX5kr2+KEQMjUB00qT
         YOkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795795842; x=1796400642;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iVhsmly2cOT49BUGNNoiSt8eC/rvBwIir2jFZoGobdk=;
        b=do3IOuDZkNf5MsF+cwPsKnA7LKAJ3TmnowUKZcLWfPWGK1rfMByycm/f8D+cv1z2iO
         EY13niDfP/vOQ7clWsnP1jCRwMFnkf/gNS/TFzW+BcBKAPhAXuMCsD3jfAd6VewH6CzT
         nQ879fXi51bmVSFmSD1kyYdEYE0jehizgB5cn/ElfvXE8u4CpvHAA5sXiSVvhB/KTFZf
         3hXGeVtvogzsJe62pyQo3SmIuYjyHJmlmROTZT7gMxUbTaguQ/rv8DeKB2mwBQ1jrOPA
         ad+PbQ3NRTm9LZGB3HCrDVQs3cbPatprpPxrnAFrhu+F1CCg11QZ1cYQM/6vsQkjbAiv
         OMYg==
X-Forwarded-Encrypted: i=1; AL+hErHz2mhq+1s9B4mTbAQ4xhJ25dES4ISxd9Jmfu7Om7ZHz5TD4cL77Y07bADOvux1YJP+VyTosqOsZur1dLPD@vger.kernel.org
X-Gm-Message-State: APuU4Z81zFI0C/rdN7x1pYECsxhIH5dU/ziIZ1ugn/DMiRxja+rwNmxV
	HOMapuKAjI3/72oAOZam0rj0gIUtDeegjHHfD/jbe6mLY8N0coPoi42e43XmvnnAsAU=
X-Gm-Gg: AZFdTZdG+dyT6DXk8Lr7fEpWnladx+elAdxkiOWP6RWXETEs4bcxsIp3UFcBoyKNKlw
	Z3Mp10ADZjvzfaOl7szsfyl61BfUYNyhW8oN/CukORLAE0iXdscY932n778HmBKjJq+98R3i5GB
	geUQuzzF6PISLCLwwCJV2D1VW35Xf9IlyBYYaun0UL8uJl5EgaD/7aDTR0zHhMMzFqkB5Qi3KHy
	7EtAXdJPlIJreokgVzOYMx3zgeGPZ9f6YLcWdt5Nky9KzLeZbDOVk7P2i+ll8jI1EJqu0lVKo3d
	t4GrtRTNfi9WZV95Lwpn9gFzQmDCf8mzTVdBGRQzcU6iBX27j+0gjighxVvlGH+wU7hU+zlewuq
	fPktWm2xie9EKIpFskwfDZh1vuMQ62NVmClD4bshPbzAIeDDAvGlABdJtEsQKSHCZFlMNgSX3Bx
	USRL038WFh320/T4jLtp/tzIyGxMco5BpKHTKxvzTQwRphc10xyflDoacNNYtobP27ASLjdrqUo
	TmJkKCw5nnOcSoxXuwoFy9iqKKE0hSUejO0su0dH3W5pXe8KMCU8qQPMmzK2A39nE3tstZEoNtu
	TgYaGVb/4t970zsN5CTS++vRUK4VCZo=
X-Received: by 2002:a05:600c:3b9e:b0:4a1:cf60:dcc3 with SMTP id 5b1f17b1804b1-4bb88820687mr578562595e9.29.1795795841986;
        Fri, 27 Nov 2026 08:10:41 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853a12acsm733027025e9.8.2026.11.27.08.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 08:10:41 -0800 (PST)
Date: Fri, 27 Nov 2026 17:10:38 +0100
From: Petr Mladek <pmladek@suse.com>
To: binoy@vt.edu
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Joe Lawrence <joe.lawrence@redhat.com>, Song Liu <song@kernel.org>,
	Ingo Molnar <mingo@kernel.org>, Jiri Kosina <jikos@kernel.org>,
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>,
	Jaidev Shastri <jaidevshastri@vt.edu>
Subject: Re: [PATCH v4 2/3] livepatch: Include exiting tasks in the transition
Message-ID: <awmrfuzTlVWgGgEM@pathway.suse.cz>
References: <20261126-klp-series-v3-v4-0-2ad73e9c9254@vt.edu>
 <20261126-klp-series-v3-v4-2-2ad73e9c9254@vt.edu>
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261126-klp-series-v3-v4-2-2ad73e9c9254@vt.edu>

On Thu 2026-11-26 11:41:33, Binoy Ravindran via B4 Relay wrote:
> From: Binoy Ravindran <binoy@vt.edu>
> 
> The transition walks tasks with for_each_process_thread(). A
> self-reaping task is unhashed in exit_notify() but keeps running the rest
> of do_exit(), so the walk never sees it. The transition can then
> complete, and with atomic replace the previous patch module can be
> freed, while that task is still executing, or about to return into, the
> previous module's copy of a patched function. This is the race discussed
> in the thread linked below.

I would use [1] to reference the discussion, see below.

> An exiting task is on an RCU-tasks exit list from exit_tasks_rcu_start(),
> before exit_notify(), until exit_tasks_rcu_finish(). Make every step of
> a transition also visit the tasks on these lists, using the helpers from
> the previous patch.

I would start another paragraph here.

> klp_init_transition(), klp_start_transition(),
> klp_complete_transition(), klp_reverse_transition() and
> klp_force_transition() only set fields and flags. They walk the exit
> lists in place, under tasklist_lock, and skip tasks that are still
> hashed, so that each task is visited exactly once.

I was confused by the meaning of "tasks still hashed".

Later I realized that it pointed to __unhash_process() function.
I heard about this function for the first time. I have never
met a term "hashed process" before. I never needed to study pids this
deeply.

Honestly, I think that "hashed task" is a term invented by LLMS.
It does not mean much. It is just a "poorly" chosen helper
function name in kernel/exit.c. There is no counter part
in kernel/fork.c...

Instead, I would write something like: "skip tasks which are still
accessible via the for_each_process_thread() walk, so that each
task is visited only once."

BTW: Would it hurt to process the same task twice?

     I think that it should not be a big deal. It looks like an
     optimization. But the dependence between pid_alive(),
     for_each_process_thread(), and task_list lock is pretty
     tricky. I am not sure if it is worth relying on it.

Also I would start another paragraph here.

> klp_try_complete_transition() may inspect a task's stack, so it takes a
> snapshot with a reference on each task. If the snapshot cannot be
> allocated, or more tasks start exiting than it has room for, the
> transition is treated as incomplete and retried. An exiting task must
> therefore switch, like any other task, before the transition can
> complete.
> 
> Fixes: d83a7cb375ee ("livepatch: change to a per-task consistency model")
> Link: https://lore.kernel.org/all/20250127063526.76687-1-laoar.shao@gmail.com/

This points to the cover letter of a patchset. Many things were
discussed there. It might be better to mention here the mail
where the discussion about livepatching do_exit() started.

Also I would use:

[1] https://lore.kernel.org/...

instead of "Link: " so that [1] can be used as a reference in
the text above.

> Assisted-by: Claude:claude-opus-5-5

This is not needed.

> Signed-off-by: Binoy Ravindran <binoy@vt.edu>
> --- a/kernel/livepatch/transition.c
> +++ b/kernel/livepatch/transition.c
> @@ -74,6 +75,54 @@ static void klp_synchronize_transition(void)
>  	schedule_on_each_cpu(klp_sync);
>  }
>  
> +/*
> + * Tasks past exit_notify() are off the task list but still run do_exit() and its
> + * callees, possibly from this patch's or a replaced patch's code, so the
> + * transition must cover them too. The try step inspects stacks, which needs a
> + * reference on each task, so klp_try_switch_exiting_tasks() works on a
> + * snapshot of the exit lists.
> + *
> + * The other steps run with tasklist_lock held and skip tasks that are still
> + * hashed, so every task is visited exactly once: an exiting task can be on
> + * both lists until release_task() unhashes it.

I would be more explicit here.

  * Important: Both for_each_process_thread() and rcu_tasks_exit_list
  *	must be traversed under tasklist_lock. It prevents calling
  *	__unhash_process() so that pid_alive() can be used to detect
  *	whether the task has already been proceed in
  *	for_each_process_thread() cycle.

But as I have said, I am not sure of it is worth it.

> + */
> +static void klp_exiting_init(struct task_struct *t, void *arg)
> +{
> +	if (pid_alive(t))
> +		return;	/* still on the task list: already visited */
> +	t->patch_state = *(int *)arg;
> +}
> +
> +static void klp_exiting_start(struct task_struct *t, void *arg)
> +{
> +	if (pid_alive(t))
> +		return;	/* still on the task list: already visited */
> +	if (t->patch_state != klp_target_state)
> +		set_tsk_thread_flag(t, TIF_PATCH_PENDING);
> +}
> +
> +static void klp_exiting_complete(struct task_struct *t, void *arg)
> +{
> +	if (pid_alive(t))
> +		return;	/* still on the task list: already visited */
> +	clear_tsk_thread_flag(t, TIF_PATCH_PENDING);
> +	t->patch_state = KLP_TRANSITION_IDLE;
> +}
> +
> +static void klp_exiting_clear_pending(struct task_struct *t, void *arg)

The name of other callbacks seems to follow the name of the function
where they are called. This one is called in klp_reverse_transition()
so I would call it:

	klp_exiting_reverse();

> +{
> +	if (pid_alive(t))
> +		return;	/* still on the task list: already visited */
> +	clear_tsk_thread_flag(t, TIF_PATCH_PENDING);
> +}
> +
> +static void klp_exiting_force(struct task_struct *t, void *arg)
> +{
> +	if (pid_alive(t))
> +		return;	/* still on the task list: already visited */
> +	klp_update_patch_state(t);
> +}

That said, the names look a bit confusing. It feels like these
callbacks are initializing, starting, completing, ... some exit.

I would use:

   + prefix: "klp_exit_task_*" to make it more clear
	that it is manipulating a task in some exit state.

   + same suffix as the caller, .e.g "init_transition" to
	make it clear which stage of the transition it
	manipulates.

So, rename:

  + klp_exiting_init	 -> klp_exit_task_init_transition
  + klp_exiting_start	 -> klp_exit_task_start_transition
  + klp_exiting_complete -> klp_exit_task_complete_transition
  ...


> +
>  /*
>   * The transition to the target patch state is complete.  Clean up the data
>   * structures.
> @@ -123,6 +172,7 @@ static void klp_complete_transition(void)
>  		WARN_ON_ONCE(test_tsk_thread_flag(task, TIF_PATCH_PENDING));
>  		task->patch_state = KLP_TRANSITION_IDLE;
>  	}
> +	rcu_tasks_visit_exiting(klp_exiting_complete, NULL);
>  	read_unlock(&tasklist_lock);
>  
>  	for_each_possible_cpu(cpu) {
> @@ -419,6 +469,35 @@ static void klp_send_signals(void)
>  	read_unlock(&tasklist_lock);
>  }
>  
> +/*
> + * Try to switch every task on the exit lists. Returns false if one of them
> + * could not be switched yet, or if the snapshot could not be taken in full.
> + */
> +static bool klp_try_switch_exiting_tasks(void)
> +{
> +	struct task_struct **xt;
> +	bool complete = true;
> +	int i, n, max;
> +
> +	/*
> +	 * Size the array from a count taken now, plus slack for tasks that
> +	 * start exiting before the copy is made. If even more arrive, report
> +	 * an incomplete walk: klp_try_complete_transition() runs again later.
> +	 */
> +	max = rcu_tasks_snapshot_exiting(NULL, 0) + 64;
> +	xt = kvmalloc_array(max, sizeof(*xt), GFP_KERNEL);
> +	if (!xt)
> +		return false;
> +	n = rcu_tasks_snapshot_exiting(xt, max);
> +	for (i = 0; i < min(n, max); i++) {
> +		if (!klp_try_switch_task(xt[i]))
> +			complete = false;
> +		put_task_struct(xt[i]);
> +	}
> +	kvfree(xt);
> +	return complete && n <= max;
> +}

I did not check this function. I think that we will do it another way,
see my reply to the 1st patch.

>  /*
>   * Try to switch all remaining tasks to the target patch state by walking the
>   * stacks of sleeping tasks and looking for any to-be-patched or
> @@ -450,6 +529,8 @@ void klp_try_complete_transition(void)
>  		if (!klp_try_switch_task(task))
>  			complete = false;
>  	read_unlock(&tasklist_lock);
> +	if (!klp_try_switch_exiting_tasks())
> +		complete = false;
>  
>  	/*
>  	 * Ditto for the idle "swapper" tasks.
> @@ -489,6 +570,13 @@ void klp_try_complete_transition(void)
>  	/* Done!  Now cleanup the data structures. */
>  	klp_resched_disable();
>  	patch = klp_transition_patch;
> +	/*
> +	 * A task can leave the exit lists unswitched after the snapshot. It
> +	 * runs with preemption disabled until its final switch, so wait until
> +	 * every CPU has switched context.

Just imagine that you see this comment 2 years from now without
the fresh context. "exit list" sounds a bit vague. Also "the snapshot"
is a term that was not mentioned anywhere else.

I would be more precise. I suggest something like:

	* There might still be tasks which were already removed from
	* rcu_tasks_exit_list and were not checked above. They run with
	* the preemption disabled until they finally stop in TASK_DEAD state.
	* Make sure that they stopped running and will never run again.

Now the question is why we need to call it here and not,
for example, in klp_start_transition() or klp_reverse_transition().

IMHO, we need it here to avoid removing the ftrace trampolines and
the livepatch module when the code still might be in use.

BTW: Do we need it in all situations, for example, when the 1st
     livepatch gets enabled? In this case, nothing is removed.

Anyway, we should explain in the comment why exactly we need
the synchronization here.

> synchronize_rcu() is not enough:
> +	 * __schedule() reports the quiescent state before switch_to().

I would say that synchronize_rcu() is not enough by definition.
We are waiting for tasks which are not longer visible for RCU.

But I agree that the comment above rcu_tasks_postgp() might be confusing.
I guess that RCU does not care about tracking the rest of __schedule().

So, it makes sense to keep the comment here. I would just add it into
a separate paragraph (after an empty line).

> +	 */
> +	klp_synchronize_transition();

Hmm, I would move this up, above the comment: "/* Done!  Now cleanup
the data structures. */". Let's be on the safe side and
make sure that all tasks are safe before we start the clean up...

Or is there any reason why it is done here?

>  	klp_complete_transition();
>  
>  	/*
> @@ -526,6 +614,7 @@ void klp_start_transition(void)
>  	for_each_process_thread(g, task)
>  		if (task->patch_state != klp_target_state)
>  			set_tsk_thread_flag(task, TIF_PATCH_PENDING);
> +	rcu_tasks_visit_exiting(klp_exiting_start, NULL);
>  	read_unlock(&tasklist_lock);
>  
>  	/*
> @@ -579,6 +668,7 @@ void klp_init_transition(struct klp_patch *patch, int state)
>  		WARN_ON_ONCE(task->patch_state != KLP_TRANSITION_IDLE);
>  		task->patch_state = initial_state;
>  	}
> +	rcu_tasks_visit_exiting(klp_exiting_init, &initial_state);
>  	read_unlock(&tasklist_lock);
>  
>  	/*
> @@ -590,6 +680,16 @@ void klp_init_transition(struct klp_patch *patch, int state)
>  		task->patch_state = initial_state;
>  	}
>  
> +	/*
> +	 * A task that has passed exit_tasks_rcu_finish() is on neither list but
> +	 * may still call patched code until its final switch, which it makes
> +	 * with preemption disabled. This returns only after every CPU has
> +	 * switched context, so every such task is gone. synchronize_rcu() is
> +	 * not enough: __schedule() reports the quiescent state before
> +	 * switch_to().
> +	 */
> +	klp_synchronize_transition();

Why exactly do we need the synchronization here, please?

We should not need this for livepatching of do_exit(). We do not care
which do_exit() implementation is used by the about-to-die processes
at this stage.

The only problem might be if we want to livepatch a function which
is called in do_exit() after the process gets removed from the
rcu_tasks_exit_list. It might be only:

  + raw_spin_unlock_irqrestore_rcu_node()
  + lockdep_free_task()
  + do_task_dead()
  + set_special_state()
  + __schedule()

They all might start calling klp_ftrace_handler() and could need to
see consistent state current->patch_state.

But wait! If this is the problem then we might need to call
klp_synchronize_transition() in each stage which calls
rcu_tasks_visit_exiting(). Otherwise, the klp_ftrace_handler()
might see some inconsistence and trigger a WARN() or
use an inconsistent task->patch_state.

>  	/*
>  	 * Enforce the order of the task->patch_state initializations and the
>  	 * func->transition updates to ensure that klp_ftrace_handler() doesn't
> @@ -642,6 +742,7 @@ void klp_reverse_transition(void)
>  	read_lock(&tasklist_lock);
>  	for_each_process_thread(g, task)
>  		clear_tsk_thread_flag(task, TIF_PATCH_PENDING);
> +	rcu_tasks_visit_exiting(klp_exiting_clear_pending, NULL);
>  	read_unlock(&tasklist_lock);
>  
>  	for_each_possible_cpu(cpu)
> @@ -714,6 +815,7 @@ void klp_force_transition(void)
>  	read_lock(&tasklist_lock);
>  	for_each_process_thread(g, task)
>  		klp_update_patch_state(task);
> +	rcu_tasks_visit_exiting(klp_exiting_force, NULL);
>  	read_unlock(&tasklist_lock);
>  
>  	for_each_possible_cpu(cpu)

Best Regards,
Petr

PS: It is an amazing work for a newcomer.
