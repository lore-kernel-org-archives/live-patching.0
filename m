Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795294887;
	b=IwPnAwnhwRHewoVCyyTQZjeSoQEV0p7ppB2wbncuXt8QC0oUj2ilyiw9yo+IrelZgmRn
	 X4Sp7SDQDKwiIxox94Rbcna8GzyC4qphvtZozpN5zNU8M7CJH6rsopAUko+FdMJ4cqYmr
	 bUjpNQrMBIm5oUvqhKRwkfh3Ok/xRh3j/icfYVMcJn5KvoTKQwCNnitvmbjfkjAhIVoHf
	 M6qO8f1+4rr4MJ/YHbwk3/Z+Y9opubRg6sM+fpqpz1QzYq74sPktldlgGhgIi/Zs7Y7ZB
	 H28unQQhhtVKVtd1Obj097Y9XQubcx/wob0JWnTgtZSWA7O8IKxvtUQu5nFsdsmVnRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795294887;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=62zNnSv/5OwcioeFLjZHN1oIXQgOF6jZ0dIhGJCk0F8=;
	b=BpPNxk9lS6ts8wCUMvLwn3RbuEG6oIfUJch65rvjE8E/hj7z1ivRug/5bLv1SgTMnTUx
	 827SWBgbJ/1bLPwbiQc4lOOlzfbgnHGWtjPEduVILQZfGX7SUUITPPiMErGRRu8nzzjKQ
	 kq91F25+W2IIHJPpt3tqbp9fVrum5zH0Q1kOiIdRjKwl3YnbQm2Ml3PLoomKdv4D69Va9
	 wa+60q5DXvYJZcd3irAJG7LkHH2nCQyB/zrQHS8hPoiJ52LfzW/u6pYVvyR2/AY5MzcxY
	 fHpoD9q6FrgzPapzP03doTIGW0xy15nv5/sPLIwD6zB3XDVqS1PpV7FZXjR8hcu2kXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S7R1TqVV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456F1606A32C
	for <live-patching@vger.kernel.org>; Sat, 21 Nov 2026 21:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S7R1TqVV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D03371F000CF;
	Sat, 21 Nov 2026 21:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795294887;
	bh=62zNnSv/5OwcioeFLjZHN1oIXQgOF6jZ0dIhGJCk0F8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=S7R1TqVVBRZ/X/J4vURSEIe3pgYkfk3VMhWuq6O4ZHwQAi1iZzWX1RV/9yQ4STo0y
	 ktu2xBxiW2ktwZYYdqOpft374bGb48YZkpo4YNbkV5aWFi57uhDJ1kWP1FMuDuUchT
	 Xp280PgrMKaojw6oR69eYqHRweZy4H2Lrluhrs2iSL2ndj4WHy9tKScsg/K1PQAwm0
	 Y2u+Z3OJKvJQXGw6AHnea16wSnJx2B2Euo7o6k3NCks9RySpRTT2lxc04i7J8wWP/e
	 kmTFb6JjzMksA597efJrm9O546yk1x7tMG9aW8+JqN9suoZtu+KZAzZo3SZ2hSznB9
	 KKsiCL9mxFqWA==
Date: Sat, 21 Nov 2026 13:01:25 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: mbenes@suse.cz, pmladek@suse.com, joe.lawrence@redhat.com, 
	song@kernel.org, live-patching@vger.kernel.org
Subject: Re: [PATCH] livepatch: Avoid blocking tasklist_lock too long
Message-ID: <awIDmjHwiQqwuSC8@jpoimboe>
References: <20261117130848.65142-1-laoar.shao@gmail.com>
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
In-Reply-To: <20261117130848.65142-1-laoar.shao@gmail.com>

On Tue, Nov 17, 2026 at 09:08:48PM +0800, Yafang Shao wrote:
> Problem
> =======
> 
> As more and more patches accumulate in the cumulative livepatch, we see an
> increasing number of latency spikes from latency-sensitive services during
> livepatch upgrades. The most recent case is the redis data_server [0].
> 
> With some tracing added to the userspace redis code and a hard trace in the
> kernel, we finally tracked the root cause down to tasklist_lock contention
> during livepatch transition.
> 
> When redis flushes data, it clones a new task, which takes the write side of
> tasklist_lock. If a livepatch upgrade is in progress at the same time,
> tasklist_lock is held for the whole transition. Below is the trace we
> captured while reproducing the issue:
> 
> === [2026-11-15 15:18:06] tid=1635309 comm=data_server  WRITE wait=79372 us
> 
>         queued_write_lock_slowpath+276
>         queued_write_lock_slowpath+276
>         _raw_write_lock_irq+69
>         copy_process+3474
>         kernel_clone+157
>         __do_sys_clone+102
>         __x64_sys_clone+37
>         do_syscall_64+56
>         entry_SYSCALL_64_after_hwframe+100
> 
> === [2026-11-15 15:18:06] klp scan held tasklist_lock(read) ~ 96864 us (comm=insmod)
> 
>         klp_enable_patch.cold+247
>         init_module+477
>         do_one_initcall+70
>         do_init_module+82
>         load_module+2526
>         __do_sys_finit_module+200
>         __x64_sys_finit_module+24
>         do_syscall_64+56
>         entry_SYSCALL_64_after_hwframe+100
> 
> === [2026-11-15 15:18:08] klp scan held tasklist_lock(read) ~ 3504145 us (comm=kworker/8:2)
> 
>         klp_transition_work_fn+36
>         process_one_work+492
>         worker_thread+83
>         kthread+235
>         ret_from_fork+31
> 
>   crash> p klp_signals_cnt
>   klp_signals_cnt = $1 = 1
> 
> The latency budget of our redis workload is 50 ms, while the clone() call
> observed during the livepatch transition took ~79 ms.
> 
> Environment used for the reproduction
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
>   server: 256C AMD EPYC server
>   tasks: 1000~2000
>   number of patched functions: around 80
> 
> Solution
> ========
> 
> The redis application can work around this issue by removing the clone()
> from its data flush path, but I believe we should improve this in the kernel
> if we can.
> 
> In 2025, we discussed completely replacing tasklist_lock with RCU [1], but
> Petr pointed out that it is far more complicated than we expected [2], so we
> ended up abandoning that idea.
> 
> We still have a more lightweight way to partially replace this heavy
> tasklist_lock with RCU, as Josh suggested [3]:
> 
>   : Maybe klp_try_complete_transition() could iterate the tasks in two
>   : passes?  The first pass would use rcu_read_lock().  Then if all tasks
>   : appear to be patched, try again with tasklist_lock.
> 
> This patch implements that suggestion.
> 
> Verification
> ============
> 
> I verified this solution on my test server:
> 
>   server: 64C AMD virtual server
>   tasks: ~2000 processes with ~8000 threads, ~30 running
>   number of patched functions: 200
> 
> - Before this patch
>   the maximum clone() latency during the livepatch transition exceeded
>   500 ms.
> 
> - After this patch
>   the maximum clone() latency during the livepatch transition is below
>   20 ms, which is within the range expected by the redis side.
> 
> Link: https://github.com/redis/redis [0]
> Link: https://lore.kernel.org/all/20250227024733.16989-1-laoar.shao@gmail.com/ [1]
> Link: https://lore.kernel.org/all/Z8CRXxfI24E9_IHC@pathway.suse.cz/ [2]
> Link: https://lore.kernel.org/all/20250213013603.i6uxtjvc3qxlsqwc@jpoimboe/ [3]
> Suggested-by: Josh Poimboeuf <jpoimboe@kernel.org>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  kernel/livepatch/transition.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/kernel/livepatch/transition.c b/kernel/livepatch/transition.c
> index 2351a19ac2a9..e058d21d84b7 100644
> --- a/kernel/livepatch/transition.c
> +++ b/kernel/livepatch/transition.c
> @@ -444,7 +444,27 @@ void klp_try_complete_transition(void)
>  	 *
>  	 * Usually this will transition most (or all) of the tasks on a system
>  	 * unless the patch includes changes to a very common function.
> +	 *
> +	 * To avoid holding the tasklist_lock for too long, we iterate over the
> +	 * tasks in two passes. In the first pass, we use the lightweight RCU
> +	 * read lock to iterate through most tasks. This pass will cover the
> +	 * majority of tasks, except for some newly forked tasks which may be
> +	 * added into the tasklist concurrently. In the second pass, we acquire
> +	 * the tasklist_lock to handle the tasks missed in the first pass.
>  	 */
> +
> +	/* First pass: Iterate over tasks using the lightweight RCU read lock. */
> +	rcu_read_lock();
> +	for_each_process_thread(g, task) {
> +		/* klp_check_stack() requires preemption to be disabled */
> +		if (task == current)
> +			continue;
> +
> +		klp_try_switch_task(task);
> +	}
> +	rcu_read_unlock();
> +
> +	/* Second pass: Iterate over missed tasks, holding tasklist_lock. */
>  	read_lock(&tasklist_lock);
>  	for_each_process_thread(g, task)
>  		if (!klp_try_switch_task(task))

I think the performance can be improved further by only doing the 2nd
pass if the 1st pass fully succeeded?

diff --git a/kernel/livepatch/transition.c b/kernel/livepatch/transition.c
index e058d21d84b75..8cbfc61ce87cf 100644
--- a/kernel/livepatch/transition.c
+++ b/kernel/livepatch/transition.c
@@ -460,16 +460,22 @@ void klp_try_complete_transition(void)
 		if (task == current)
 			continue;
 
-		klp_try_switch_task(task);
+		if (!klp_try_switch_task(task))
+			complete = false;
 	}
 	rcu_read_unlock();
 
-	/* Second pass: Iterate over missed tasks, holding tasklist_lock. */
-	read_lock(&tasklist_lock);
-	for_each_process_thread(g, task)
-		if (!klp_try_switch_task(task))
-			complete = false;
-	read_unlock(&tasklist_lock);
+	/*
+	 * If the first pass succeeded, grab the more heavyweight tasklist lock
+	 * to check current and any newly forked tasks.
+	 */
+	if (complete) {
+		read_lock(&tasklist_lock);
+		for_each_process_thread(g, task)
+			if (!klp_try_switch_task(task))
+				complete = false;
+		read_unlock(&tasklist_lock);
+	}
 
 	/*
 	 * Ditto for the idle "swapper" tasks.
