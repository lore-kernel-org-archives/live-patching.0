Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794922189;
	b=pNc0wBNmhppLm9y83+N0esrx1iy4GaeZHNSMgokzSr8rCayRQMd9NgxNm4UeGVcPrROE
	 3Aumqt8mFoNLVrPslDe7IDXgECH/vEcJTal9Gq//1U3BiCVyDdJWzphaEGgAU+onfYnBe
	 Xb7AWPUkdnZW+swRtTl5XMSJhalu9CbKmxOChV0lW1W4JSOzvJTLLnn3lOiYGwNT6LCbV
	 NM3ZDFrdh9huuDpXGHsgMobJHtw4GZ3ZETd4TwMWzdHE8yVSpLn9GEP3eA1r5CIVk7xdQ
	 cOrWLSj5TmaivQiJ7k+v4zAnwNB17l3iYPMSov1RrQUpXComfLFWizaZOpC17jSiVHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794922189;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FeWrn1CXScmE5SU45X3WPAxtDfPS7l0DFyJP5d+KdPs=;
	b=Vq+cC0vpZh++qxkP9b0WRb3s8dIIPT8c1zW51VVgrzdOYf17wkeoeLNvM0ZsfQ2VZPZy
	 PinojCnb4dLG/T9JDd1zkvxrY0Lv3fZMv1XnduUPXwzHj3iWwoVyZrnAlaRhflbxnlxmS
	 ByNGchEOYIOhdl/gwkFDxnGEr2MwaB/Irk7OwkNtJqzL4CYhzhgIkiaSrtXxyRJzZnRLA
	 ewpwHeXlQpPm4arhIFI5pVLWzNPEVR293y7O7EEEzwT/qXUtso9zOQqn9OWXOwX/fBil1
	 NzTqK78JBJMY3EVwgURZ2sA1/VHW1Zuc1tXQiiB3ZxHSha8TCLF1Xi216Out1LdRYsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Lys/P3KD";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E44606A31C
	for <live-patching@vger.kernel.org>; Tue, 17 Nov 2026 13:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lys/P3KD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 086FB1F000C5;
	Tue, 17 Nov 2026 13:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794922189;
	bh=FeWrn1CXScmE5SU45X3WPAxtDfPS7l0DFyJP5d+KdPs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Lys/P3KD7S9RqeSYaXJ8DO1K8kzHj8s0dX/jsA7mzeOjrsG1409GNb9yPf45xcosh
	 i1jbB5/xykiz/aYPYx2PxD96kJIzXsufX6E5t9CfhnwBPyv2/0KqswijIZ/xwPb6n/
	 udOBx1mcAimhTqjI3B5pWS2sFW26AjOFAHADxmyFi/ubvKV/XaIPJbXSsn/M6KdrVh
	 eXTz39jp7UmvYgqpRYxWJ2bHO3mW40NgRrf4Ssk3J93iUHl89zKieffGF70V6vrEZZ
	 z515jHwBwFwTBwHUYzZUnNCtNqrnQkYArdOZQ0E6URZP46mZe/dOwyLg1+bXLfCL3Y
	 f5kLXKm30v+jQ==
Message-ID: <sashiko-outbox-218879@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] livepatch: Avoid blocking tasklist_lock too long
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yafang Shao" <laoar.shao@gmail.com>, jpoimboe@kernel.org, mbenes@suse.cz, pmladek@suse.com, joe.lawrence@redhat.com, song@kernel.org
Cc: live-patching@vger.kernel.org
In-Reply-To: <20261117130848.65142-1-laoar.shao@gmail.com>
References: <20261117130848.65142-1-laoar.shao@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 13:29:48 +0000
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
- [Medium] livepatch: race between klp_try_complete_transition() and
  klp_copy_process()
--

commit ceb01fc48f77409ab4a5313629520f441760c90c
Author: Yafang Shao <laoar.shao@gmail.com>

livepatch: Avoid blocking tasklist_lock too long

This commit splits the task iteration in klp_try_complete_transition() into
a first pass under rcu_read_lock() and a second pass under tasklist_lock to
reduce tasklist_lock hold times during livepatch transitions.

Link: https://github.com/redis/redis [0]
Link: https://lore.kernel.org/all/20250227024733.16989-1-laoar.shao@gmail.c=
om/ [1]
Link: https://lore.kernel.org/all/Z8CRXxfI24E9_IHC@pathway.suse.cz/ [2]
Link: https://lore.kernel.org/all/20250213013603.i6uxtjvc3qxlsqwc@jpoimboe/=
 [3]

> diff --git a/kernel/livepatch/transition.c b/kernel/livepatch/transition.c
> index 2351a19ac2a9e..e058d21d84b75 100644
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
> +	/* First pass: Iterate over tasks using the lightweight RCU read lock. =
*/
> +	rcu_read_lock();
> +	for_each_process_thread(g, task) {
> +		/* klp_check_stack() requires preemption to be disabled */
> +		if (task =3D=3D current)
> +			continue;
> +
> +		klp_try_switch_task(task);
> +	}
> +	rcu_read_unlock();

[Severity: Medium]
Can this RCU pass race with klp_copy_process() on CONFIG_PREEMPT_RT kernels
and leave a newly forked child with TIF_PATCH_PENDING still set when the
transition completes?

klp_copy_process() relies on tasklist_lock to serialize against transition
updates while copying TIF_PATCH_PENDING and patch_state from current to
child:

kernel/livepatch/transition.c:klp_copy_process() {
	if (test_tsk_thread_flag(current, TIF_PATCH_PENDING))
		set_tsk_thread_flag(child, TIF_PATCH_PENDING);
	else
		clear_tsk_thread_flag(child, TIF_PATCH_PENDING);

	child->patch_state =3D current->patch_state;
}

On CONFIG_PREEMPT_RT, write_lock_irq(&tasklist_lock) in copy_process() is a
preemptible rtmutex lock, and unwinders such as x86_64 ORC unwind reliably
across in-kernel preemption frames:

CPU0 (parent in fork)             CPU1 (klp_try_complete_transition)
copy_process()
  write_lock_irq(&tasklist_lock)
  klp_copy_process(child)
    set_tsk_thread_flag(child,
      TIF_PATCH_PENDING)
    <preempted>
                                  /* First pass under rcu_read_lock() */
                                  klp_try_switch_task(parent)
                                    ...
                                    clear_tsk_thread_flag(parent,
                                      TIF_PATCH_PENDING)
                                    parent->patch_state =3D klp_target_state
    child->patch_state =3D
      current->patch_state
  write_unlock_irq(&tasklist_lock)
                                  /* Second pass under tasklist_lock */
                                  klp_try_switch_task(child)
                                    if (task->patch_state =3D=3D klp_target=
_state)
                                      return true;
                                  klp_complete_transition()
                                    WARN_ON_ONCE(test_tsk_thread_flag(child,
                                      TIF_PATCH_PENDING))  <-- stale flag

Because child->patch_state already matches klp_target_state, the second pass
under tasklist_lock returns early in klp_try_switch_task() without clearing
TIF_PATCH_PENDING on child.  klp_complete_transition() then triggers
WARN_ON_ONCE(test_tsk_thread_flag(task, TIF_PATCH_PENDING)) and leaves the
flag set on the child task.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117130848.6514=
2-1-laoar.shao@gmail.com?part=3D1
