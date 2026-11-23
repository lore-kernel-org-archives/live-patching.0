Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795402361;
	b=xwRg6UL46Qs/xh2sVQ+T0cyavTc9zTzj+CNnSW3xZMhaDbKXptXwuPI2eObdcCy6BUlT
	 Ys5JANRoltz6NmyzrZvoi5HlJ0bMFAjR64QdFXkP/0KUvwQXIE+pN75mM8ND4bnB1m7I+
	 29W0Z6lJWO9R06N0ZUHKIKA0EJnA7WWx+aC2K7wwt4yjN/inElzSrmLdlLFL3jueNMhRD
	 h+eniefn00nhzSneBbhIeKyXRvYy+1CDSH6FcdrEnKmo6pakP6y8Q2Ht8VPBqSyvnMhRa
	 pcA7uv0gitRf+I/CRhq9Nq0cBye9WHdZvubzliBQsbqTPiAILFim4rhCkQarGsaaRTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795402361;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=pGDnKJMHddt1DWDu9fxUXWw+o7sa9bax3stqTwI5PGo=;
	b=vE1PZIOKwqc3uyGJqLzAmDfEX3xXX8HhCWN1YR5d0W55Yh00dNmCfVOrvFDmm0GlWLse
	 OeHiH9W/2VDHoD/P/PMMX1FyGErbAXibyZrj906mCW5aTLE7YOEZALcbY1dlzFGG2JojK
	 7xLT4HKkvwmqJ53Ncf62lQxlX30BaBbw1xwUkRtzpu/PoWHMuoMcKN3AgcBv5/bNKMwMd
	 SqJljy6L1AvKBdKkisHd8SXGnERl8kwzRwFyBn4EdNcBu6ArGLy+rWjudT1P4Ijfhzzcf
	 mCYo97YaZ/WW56RcrWGK946nsjZ3bpWYOekuODc5VrRV8oXLzC2bK4s1v1b+KxyBRUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GStFtryX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E2D606A31A
	for <live-patching@vger.kernel.org>; Mon, 23 Nov 2026 02:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GStFtryX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 551CC1F000C4;
	Mon, 23 Nov 2026 02:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795402360;
	bh=pGDnKJMHddt1DWDu9fxUXWw+o7sa9bax3stqTwI5PGo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GStFtryXigbLbJMsDYntZJtHc64cYHfmXdLWZvpJxzkTKVz3AF05PUlBV7UsiBc8+
	 9oyIDCnCBDELEUPqihh0nK7SkGM+HR0MI6FcMwlxzU+21yyVNhNXoPyZz1iLDrBFnG
	 WQvUCMeMLcEbpVLkd++xffV0ZPKy/tMfdT5UOHu++eOKaKEPuBA1BVaUxbQ65HZLFu
	 DDaiiIvn+HcNNCaHTKuBHgOb2GrLI97zHQwNDtT3cLyg4s5MnR45AL1A5+bXemL0GD
	 jtkPF7oG5S/u3sVgZgivos7sDb0hbYf4Y8jlj/AZ9emSlwsSltemYo2fPFU9RIAu6G
	 9r5tPg0SZR65Q==
Message-ID: <sashiko-outbox-228569@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] livepatch: Avoid blocking tasklist_lock too long
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yafang Shao" <laoar.shao@gmail.com>, jpoimboe@kernel.org, mbenes@suse.cz, pmladek@suse.com, joe.lawrence@redhat.com, song@kernel.org
Cc: live-patching@vger.kernel.org
In-Reply-To: <20261123024119.16154-1-laoar.shao@gmail.com>
References: <20261123024119.16154-1-laoar.shao@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 02:52:39 +0000
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
- [Medium] livepatch: broken current handling in
  klp_try_complete_transition()
--

commit 9627aa0e09bd9a194e83552843dfca92987dfda2
Author: Yafang Shao <laoar.shao@gmail.com>

livepatch: Avoid blocking tasklist_lock too long

This commit splits the task iteration in klp_try_complete_transition() into
a first pass under rcu_read_lock() and a conditional second pass under
tasklist_lock to reduce tasklist_lock hold times during livepatch
transitions.

Link: https://github.com/redis/redis [0]
Link: https://lore.kernel.org/all/20250227024733.16989-1-laoar.shao@gmail.c=
om/ [1]
Link: https://lore.kernel.org/all/Z8CRXxfI24E9_IHC@pathway.suse.cz/ [2]
Link: https://lore.kernel.org/all/20250213013603.i6uxtjvc3qxlsqwc@jpoimboe/=
 [3]

> diff --git a/kernel/livepatch/transition.c b/kernel/livepatch/transition.c
> index ef70ff582da18..e5df13fa6fbde 100644
> --- a/kernel/livepatch/transition.c
> +++ b/kernel/livepatch/transition.c
> @@ -444,12 +444,38 @@ void klp_try_complete_transition(void)
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
> -	read_lock(&tasklist_lock);
> -	for_each_process_thread(g, task)
> +
> +	/* First pass: Iterate over tasks using the lightweight RCU read lock. =
*/
> +	rcu_read_lock();
> +	for_each_process_thread(g, task) {
> +		/* klp_check_stack() requires preemption to be disabled */
> +		if (task =3D=3D current)
> +			continue;
> +
>  		if (!klp_try_switch_task(task))
>  			complete =3D false;
> -	read_unlock(&tasklist_lock);
> +	}
> +	rcu_read_unlock();
> +
> +	/*
> +	 * If the first pass succeeded, grab the more heavyweight tasklist lock
> +	 * to check current and any newly forked tasks.
> +	 */
> +	if (complete) {
> +		read_lock(&tasklist_lock);
> +		for_each_process_thread(g, task)
> +			if (!klp_try_switch_task(task))
> +				complete =3D false;
> +		read_unlock(&tasklist_lock);
> +	}

[Severity: Medium]
Does deferring current to the second pass still call klp_check_stack() with
preemption enabled on CONFIG_PREEMPT_RT?

As the new comment in klp_copy_process() notes, tasklist_lock is a sleeping
lock on CONFIG_PREEMPT_RT, so read_lock(&tasklist_lock) does not disable
preemption.  When task =3D=3D current, klp_try_switch_task() calls
klp_check_and_switch_task() directly instead of going through
task_call_func(), so klp_check_stack() triggers
lockdep_assert_preemption_disabled() and leaves the per-CPU klp_stack_entri=
es
array unprotected if current is preempted by a task that runs
__klp_sched_try_switch().

Skipping current in the first pass also leaves current unswitched whenever
any other task fails to switch (complete =3D=3D false), and forces an
unnecessary second pass under tasklist_lock when current itself cannot
switch.  Disabling preemption around klp_check_and_switch_task(current, ...)
in klp_try_switch_task() would avoid both issues and allow current to be
handled in the RCU pass.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123024119.1615=
4-1-laoar.shao@gmail.com?part=3D1
