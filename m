Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795719138;
	b=IxZi12LCJirmJxmIA7M+c7oGvpt86QLuy3XqE1vLMKzj9HnR2LKJVEt7r2OSNwxXSlEw
	 GI2pNJM82LdoEn//PF8sQ7DE1zoSwXhkpRT1SPhkxecUZR1L7vyMc9V+1oFpuzTHzrmMf
	 Jr6NzxhWG2c8wgKMbfsx4ZPS5RpAkit+NZWhtNQL/43u5yks0DmeF0beiWL/GK1bsdFyG
	 ukeIyf3hXn3ffryg9WiddE/WsLTlVK3z5mKg2NXAhSqHGl99KZhDeHRq8f5G0tCstjT5B
	 OE8QEsTYq+sFbuFBOQo4X8q9lFrXm7+3JFtRCjNXFAlcFdeC/viWPGuJ+l9g8d999jQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795719138;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=uATH8vRnOCM46AzAoKfdDLMgqNZkAeUKKJE9tEV1q+k=;
	b=yUO9RY7iV2HdZHOnmI+362nrVvVQEHY5u6LPBeajYiOGHIesUh1Aj7Rv2KHeZSYZExvy
	 Wk/ZN6IFu2Zs2AwMIytPnIMFG+Ru1mes9cQZL6iH2o5Oq7ovy5n04b3xmNEk2Ydqclrs4
	 lCRaaUG2FhqA+nj0+RmQlFwt/p9IfqrqTc3NoIcUqcN5jX3pFWSKxok6fmQxrL9H56VRG
	 lM4yw1594WE/uyrt8O7/v0SmQI+l6IWOK3ay2Mkum46+m+yArraLNriREMm4ADQ00LmLb
	 Jlb/5iLRIB0sNag/n16Y89/Vlf/hPlR7HSw+PSp/TD/D71TRaTfTHheT5lB2MrDLxAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=gwMoXQYC;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B9E606A31E
	for <live-patching@vger.kernel.org>; Thu, 26 Nov 2026 18:52:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41B9E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=gwMoXQYC
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4ad6219f7d8so6619098f8f.0
        for <live-patching@vger.kernel.org>; Thu, 26 Nov 2026 10:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1795719135; x=1796323935; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uATH8vRnOCM46AzAoKfdDLMgqNZkAeUKKJE9tEV1q+k=;
        b=gwMoXQYCy1oOhrUu4aNSP5bI1YJR8YKzN73uInOzgaBkPQTaTbMur5yKN2ASb8+F3F
         zpV5d8jtl1Yv6aHl9JrOOsnkwajf9RE5ziEpeNi7csDKfqn9UNmP1NhErz9Wl8YSAdtq
         CvmJP5BxCdf4C9Pw3+CRx54coKeVbp91urZR0ZNNnkxC23pzAdGs3PLTniXfLavDpnpX
         y+TiG9m26yo/9nAHrwVUkPC4jhTThPRxLOTJW2L4UFKT2do+XhWXs6qNjgdIQwrS8WxQ
         p1SWgIaX24HTPQsYfHngWHDy3A6BdSiuEcXlqeALjIlipHCHAlRdNXKhVmmmy3/0vzdj
         vWAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795719135; x=1796323935;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uATH8vRnOCM46AzAoKfdDLMgqNZkAeUKKJE9tEV1q+k=;
        b=aP8MXxsjVxjw1YNt54f1gkUsE8jbzHc3T5PjaFm9MHttgDHXSIIREZ+AWHizwb3w5Y
         ZGG/9hHpd3Sg+aQQdxHuJGK1XKYRYpLBZfGVzDX6hyCuM/P6jWTYsOJ7iA9vOHkjh0/S
         9bAHYRepeipp8o7sP5oLcLa9DNy7swyLtQQzYsJjW4lIYdBVwaEA6Vbadz1lLfzMTr+/
         klD2YafxHut3spVBDkFf5PNsyxuAPocrF2K8ZdzH2gX1mo/Yn4ibPa7/P6GKwk6rT0i7
         IUz12sc5zzhmBe4UXlp5jWT0RpPMhRdMtx/bbCaquw/a2WeOyRJu674FG3jBpU9+TIVG
         cjug==
X-Forwarded-Encrypted: i=1; AL+hErHR0umc9HN0K+FR+J2elMqLZLQI67tWgoSW3HHPe4UYSJYsP9upz5aiBzRjCnCKWSv4Hf+Zea29REEj7Knw@vger.kernel.org
X-Gm-Message-State: APuU4Z8zuOEzFh9pmJE5xl0PD8yTPpWG5tTRnTkI0fxfmVWJBHINYLJ6
	fF/uY3JQGsMcOV6j5GMfg1dG8tnYL9wIfhQwFx43NYKQOPi5ZX/Q1FmjV1SossFxzOQ=
X-Gm-Gg: AZFdTZcpQDUHSdcMbI2MalLEK5sG7QbJJiTx9+VaNpT9+cFKmih+x4nHjKLO2KUcL8r
	r4S3AQDvzdz0uQgPx2VQv8MWnAej/oKjw4gH8ANEG2j3jD2lxwojK7Z3do14q7kiDIwXbpGLKcH
	S8Aqlrh7xMcR0kjRT51QA8O0gcvFr1454d8pkZjFhzbfgQ++akTTmbS3b3og9qQ/2MRvuCAM4Bk
	ZzOHwmqtx9WL2/v+dVmTdzj5n1jF//T1VjO5KpEkP8+ZO05qXu/CLJhY23DDPdlTD3LONCS0E7c
	ZIPvD3VoN5luWnu3+vIp3QK6fSbRsjmUmdpnOup6HqonLZcz59EQRKqif1+SA8b90AzVnJpTcMV
	JDdIHRnf+lXwx34pjHq65YHCaJe67p2nuOcoIZgf1g/v7/yHEW7Fhdd23GgEaKdNufNI3MOzVyR
	8PymiAtyuLQ6sFW5801WowAj4y2QOqduCC4Jzt51G0ShwKAcrJfbLoMyDOc4KbtbJT4XecMbnUi
	OSt4LEsSGGFn7ZObXTsrkCNITZ/o9d8AQywuOpkJpivp2hwzuLjhXG1RBDIEy4Bn6QUk5t89d9V
	CmY0T/6v9PCO9MEkwZfIcdL8TSmSb6Q=
X-Received: by 2002:a05:600c:5307:b0:4a3:d327:6ed with SMTP id 5b1f17b1804b1-4bb888283d8mr435462125e9.17.1795719135509;
        Thu, 26 Nov 2026 10:52:15 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853b2437sm870851845e9.13.2026.11.26.10.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 10:52:15 -0800 (PST)
Date: Thu, 26 Nov 2026 19:52:12 +0100
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
Subject: Re: [PATCH v4 1/3] rcu-tasks: Add helpers to visit tasks on the exit
 lists
Message-ID: <awh_3OkWvI7dIRA-@pathway.suse.cz>
References: <20261126-klp-series-v3-v4-0-2ad73e9c9254@vt.edu>
 <20261126-klp-series-v3-v4-1-2ad73e9c9254@vt.edu>
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
In-Reply-To: <20261126-klp-series-v3-v4-1-2ad73e9c9254@vt.edu>

On Thu 2026-11-26 11:41:32, Binoy Ravindran via B4 Relay wrote:
> From: Binoy Ravindran <binoy@vt.edu>
> 
> A task joins its CPU's RCU-tasks exit list in exit_tasks_rcu_start(),
> before exit_notify() unhashes it from the task list, and leaves it in
> exit_tasks_rcu_finish(), after do_exit() has disabled preemption for the
> final switch. Once exit_notify() has unhashed it, the task is no longer
> found by for_each_process_thread(), but it still runs do_exit() and may
> sleep there. Code that must reach every task that can still be
> descheduled, such as the livepatch transition, has no way to find it.
> 
> Add two helpers. rcu_tasks_visit_exiting() calls a function on each
> task on the exit lists under the list locks, without allocating.
> rcu_tasks_snapshot_exiting() copies the tasks into a caller-supplied
> array with a reference held on each, for callers that must sleep or take
> other locks while examining them. Without CONFIG_TASKS_RCU there are no
> exit lists, and the helpers do nothing.

Nit: I would be nice to make the commit messages better human readable.
     The dense paragraphs generated by AI are not easy to read. I mean
     something like:

Add two helpers:

  1. rcu_tasks_visit_exiting() allows to do a quick operation on
     all exiting processes. It will be needed, for example, for...

  2. rcu_tasks_snapshot_exiting() ...


> rcu_tasks_postscan() keeps its place in an exit list with a bare
> list_head while it drops the lock to reschedule, relying on nobody else
> traversing the list. Move that cursor into struct rcu_tasks_percpu,
> next to the list it marks, so that the new helpers can recognize and
> skip it. Only the grace-period kthread runs postscan, one CPU's list at
> a time, so one cursor per CPU suffices.
> 
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -33,6 +33,8 @@ typedef void (*postgp_func_t)(struct rcu_tasks *rtp);
>   * @barrier_q_head: RCU callback for barrier operation.
>   * @rtp_blkd_tasks: List of tasks blocked as readers.
>   * @rtp_exit_list: List of tasks in the latter portion of do_exit().
> + * @rtp_exit_cursor: Placeholder that rcu_tasks_postscan() parks on @rtp_exit_list
> + *	while it drops the lock, so that exit-list walkers can skip it.
>   * @cpu: CPU number corresponding to this entry.
>   * @index: Index of this CPU in rtpcp_array of the rcu_tasks structure.
>   * @rtpp: Pointer to the rcu_tasks structure.
> @@ -49,6 +51,7 @@ struct rcu_tasks_percpu {
>  	struct rcu_head barrier_q_head;
>  	struct list_head rtp_blkd_tasks;
>  	struct list_head rtp_exit_list;
> +	struct list_head rtp_exit_cursor;
>  	int cpu;
>  	int index;
>  	struct rcu_tasks *rtpp;
> @@ -1068,7 +1071,6 @@ static void rcu_tasks_postscan(struct list_head *hop)
>  		struct rcu_tasks_percpu *rtpcp = per_cpu_ptr(rcu_tasks.rtpcpu, cpu);
>  		struct task_struct *t;
>  		struct task_struct *t1;
> -		struct list_head tmp;
>  
>  		raw_spin_lock_irq_rcu_node(rtpcp);
>  		list_for_each_entry_safe(t, t1, &rtpcp->rtp_exit_list, rcu_tasks_exit_list) {
> @@ -1081,14 +1083,15 @@ static void rcu_tasks_postscan(struct list_head *hop)
>  				continue;
>  
>  			// Keep our place in the list while pausing.
> -			// Nothing else traverses this list, so adding a
> -			// bare list_head is OK.
> -			list_add(&tmp, &t->rcu_tasks_exit_list);
> +			// The cursor lives in rtpcp so that the exit-list
> +			// visitors can recognize and skip it.
> +			list_add(&rtpcp->rtp_exit_cursor, &t->rcu_tasks_exit_list);
>  			raw_spin_unlock_irq_rcu_node(rtpcp);
>  			cond_resched(); // For CONFIG_PREEMPT=n kernels
>  			raw_spin_lock_irq_rcu_node(rtpcp);
> -			t1 = list_entry(tmp.next, struct task_struct, rcu_tasks_exit_list);
> -			list_del(&tmp);
> +			t1 = list_entry(rtpcp->rtp_exit_cursor.next, struct task_struct,
> +					rcu_tasks_exit_list);
> +			list_del(&rtpcp->rtp_exit_cursor);
>  			j = jiffies + 1;
>  		}
>  		raw_spin_unlock_irq_rcu_node(rtpcp);
> @@ -1332,6 +1335,60 @@ void exit_tasks_rcu_finish(void)
>  	raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
>  }
>  
> +/*
> + * Call fn on every task on the exit lists, in place, with the per-CPU list
> + * lock held and interrupts disabled. fn must not sleep. Does not allocate.
> + * These are the tasks that have passed exit_tasks_rcu_start() but not
> + * exit_tasks_rcu_finish(). Once exit_notify() has run they are no longer on
> + * the task list, but they still run do_exit() and may sleep there.
> + */
> +void rcu_tasks_visit_exiting(rcu_tasks_exiting_fn_t fn, void *arg)
> +{
> +	int cpu;
> +	unsigned long flags;
> +	struct task_struct *t;
> +
> +	for_each_possible_cpu(cpu) {
> +		struct rcu_tasks_percpu *rtpcp = per_cpu_ptr(rcu_tasks.rtpcpu, cpu);
> +
> +		raw_spin_lock_irqsave_rcu_node(rtpcp, flags);
> +		list_for_each_entry(t, &rtpcp->rtp_exit_list, rcu_tasks_exit_list) {
> +			if (&t->rcu_tasks_exit_list == &rtpcp->rtp_exit_cursor)
> +				continue;
> +			fn(t, arg);

Is it acceptable to process all entries while keeping the raw_spin_lock()?

rcu_tasks_postscan() contains the trick with the @tmp/@rtp_exit_cursor
list_head to be able to release the spin lock while walking the list.

You might argue that our fn() is short. But rcu_tasks_postscan() calls
rcu_tasks_pertask() in the loop and it seems to be quite simple as well.

IMHO, a better approach would be to make rcu_tasks_postscan() generic
function to do an operation on the rcu_tasks_exit_list and release
the spin lock regularly. The operation should be defined via a *fn
passed as a parameter.

I mean to allow to use the same RT-friendly for-cycle in both RCU
and livepatching code paths.

We might need more cursors. One for the RCU code path and
another for the livepatching code path.

It will be tricky. But it will remove the hack with copying the list
of exiting processes into a temporary allocated array. The allocation
and copying is problematic on its own. IMHO, it might cause a livelock
when many processes are exiting...

Best Regards,
Petr
