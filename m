Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795580297;
	b=1oO2vAd+IPrVwdz+abkPH5g5a9Me8vwwz0MiikBZXm9ZYMBAVwfStCTn3zAz7k/s+z0m
	 0IKxie24Qj+1dheO47shEmrBkFVK/Q0tX9ld/HYdcyZqDf3Qmoh4XbLB55M7ubz/NQjLf
	 YcwQzIKp1Sp/3+JT+sqsc+0kuJ/LomDKulZJh3imF1oPTEhQlr1U3Cq4w+wZNrE7cKpL6
	 J5oeY25y6ZZkqY25M6Le32sTE+ARuMALdK7YUGOBFmPGBAscEuTNL44ozPZCSNL3oRJ+3
	 w21/ZGUoRdEeEvc6mU5CQUMAYwA3AjM6ojWnqtTyLFHPufVrLD/Eg7xxNyh7Cg3m7iQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795580297;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=kLeHDG2VnEXhT3JsLotiTiwhgWFVUUN1QQojkOZhb2I=;
	b=c+dI5a4rrMz6dFoG9YyCkKRvDq+jfisYtIDERhfbjqy+PanRAJZe4VqCWoB5ja793LaO
	 a/ZMZ1+wNXZ08TJJjuNsLVUxoN0L8c8M3ETTFY5geVwNFnwI3mUNYjnNl0LQNqKkkBRkz
	 A18YepDQnCid2GPMLGyHG7q1ZW/biBoj+wxdupJWujl9ADUpvilbMpQtbEm5QHV6iSUN5
	 jymb69WkaZ9o8m00+AC+NzHOL71SN0nof44TfmHMeXiKurPb7jmlVDPxk6kODwoXS9k7s
	 qMALdWz/u6Hk9cJatZw6Vy9PvuyHlrtJQGbCfWTmMZWLXoYvkasdEgsDHs6eDmbgk/g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Gr4V25J5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.43
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FD1606A321
	for <live-patching@vger.kernel.org>; Wed, 25 Nov 2026 04:18:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24FD1606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Gr4V25J5
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-7d2d95c5d81so3669233137.0
        for <live-patching@vger.kernel.org>; Tue, 24 Nov 2026 20:18:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795580296; cv=none;
        d=google.com; s=arc-20260327;
        b=mHvAn7bkoicEDHQYZnIvLqyFxoJcrvDApEKHqEioLJPJUBp3UiMLOFVovajiMYyEKq
         uV4Ghs8CsaXrbAMYgmL6lDaY/HE++9TGdQsF6VECSzfgf5V+FyEY8wwPH3Ge8iqN+m7u
         NTXjSCM6UHiFWEa3a8G9nLuUH2BN7ThQeQTs+3E9g6mwcpBkDlNLM2oW6wPlORyjwIsh
         itakgDaCDnJEr9wLOcVPwWYjyoahtBFSB8K+44+xxDoIqS8moRnceHMa2Ev4Ku6khT9M
         qZvfRqPnQPpFWOMgokWlnyEHkfnq+RJHC50QRXQvFKytQl5gh0n7/gMDcJwjjcrifSEf
         RYtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kLeHDG2VnEXhT3JsLotiTiwhgWFVUUN1QQojkOZhb2I=;
        fh=hKnitUo6Vw2nWRSAOxXSfemlcKOX5W24GNT+FETlGTw=;
        b=ktDy4mg3nXo4R9FIx1p1BSE1Z/5BFyN/0QYGSspGFnk67G715TOGAaenR49iuR3Fnr
         0Vcd9/ImXMHOLy49tDyrNzLLTlhrTvhVsEWzS3FvLGeTj5oGVioTSxgYCQH8OlAxaaQZ
         faK0JIN84S2QzGrTjoVgLKl94/9ckqd3BtassWWzQ6v+1mh00fnABb+Aa+cRLObpm5DN
         +/RAbLOKqihUVhvYgDeeMxJnmeThp+k7KKdovZgjja6NP2cnJPazPzfa4WiazSC9v0Lo
         K0hcgwUAD3TQbv+ov10yRhktQS4SpC599ojIJdrlmjshdloCL8kgSPUBC0qi9d/VYsyH
         IRGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795580296; x=1796185096; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kLeHDG2VnEXhT3JsLotiTiwhgWFVUUN1QQojkOZhb2I=;
        b=Gr4V25J5P7BKBn0hrLKwdOaxCKfi33xlDSKABVG9b3SBg7R49I/LmFG/rHdDo+/IDj
         8ABDwK3CAw+gRQE7tMTvB/me+goYNKDSPf/+CXTiO4lsY4mdOSgJsUYeFwKxy7tKNkcn
         N8qi46Fw3QR151tdVh3lddwqDAv2gPij7WkmvoLz8Lirw4fjJvx5OZemRS1kTSkZXLTa
         kfo1Lm+wSMhAtdWExiTl9EsbBYmC+J8d/1dfUSmExuybUJmGpKmfhYSzQU7VfqjIAz95
         pmjSXmMMZ28kMPG69JhJltRejSQFGg5AMgKnOKhgRX2ShFWSfenhoeYPOmRYbQQisxhA
         oYgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795580296; x=1796185096;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kLeHDG2VnEXhT3JsLotiTiwhgWFVUUN1QQojkOZhb2I=;
        b=iZSi+yQVi/15o1fQovTm/bFILXoM2nFuGx/ryRTXfnXPvAZnNB1JddUUpuX7tQjv5I
         j+tc7fg2ZeGghrmPb9qCGtW9LYMxYjBW0Nxd4TTMY9MspH25BR9GvytcosqRt05GYyAn
         e0rvfvsOgmotHrMYSK5fQOiFF0orxsBzpBkkUEnUByDycRXpvy9GhwxzPkyfgDJKLhTJ
         Tf8LBE89pucr/E4J+jdWhqDyOySa4TPaH9fpkcYID4jrhVIQnWastuA8wzacgE3cI1cL
         A8YVxTd5XZ+gFxBbF5uMwTRFsb8zUppOa+8AvV4sMNQlZ8/zXVtXKGiAXxfttGc5b/6O
         XizA==
X-Forwarded-Encrypted: i=1; AL+hErHOnEGs7E6vJrE70mSSqjJKQHDKui7ABiMcHXisEfYqYdeO3sIOkJRBhMdFDO235Vo34WpR329Nr+9vkvfT@vger.kernel.org
X-Gm-Message-State: APuU4Z8czonxJAo+g0vaTAugh4OrdRp4RgBFLTVjc2XfPNs71FLZwwoM
	7Ii5wWFIB/GQiqOJKs+S7Ubg5nTFYDwE6211ZjIfDBa+aTcuUuFF0E9cGjz8tAZLR1CRnMiIe8t
	1Gj/A/lRMu3nWM2iQo4V5wckmdstfvYvs+uNBvQM9
X-Gm-Gg: AZFdTZcUAdqKNz7sVJB2cz7Lg1ITSgpM3TjnfIozZMz4Z2ZksGGC8r9Laxeg8kE0r/S
	LIxXib4dV8QwPgddbYFMgT7HHKNEGq5PDm/KkZa1ToTMs/EAVf2UpYZ+BrqcART2YF2nkrZxlVm
	8UWVZYMXGkKaVCbdNkIFRm+I3QLrNFWPbkKmdgEeGI8qa9Nl0C3q4QTHE1D1FK3riTuUN+X8tKh
	1zDgPVNiZASYH12M5Rx3twyTZBQbQS4Sic8zKzVkhfWPaYOILommIGz0Xu1csstJSOLPA1IqAll
	QetHtd9h3DMDsSubNseubN3tZZGqfvMd7SwzCZN077TBmy4PxrIpvtsCtrzSTtpuV/Yf+xsRY7C
	T3GZDSvBnwjBvPCgCdjxipk6/wkLg72Bu0Nkf6d3BcwYxgLBOtdRIuYgyRQ==
X-Received: by 2002:a05:6102:41a3:b0:7a3:b2c2:2e70 with SMTP id
 ada2fe7eead31-7d7395e32c3mr5734305137.11.1795580295324; Tue, 24 Nov 2026
 20:18:15 -0800 (PST)
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117045254.1048298-1-dylanbhatch@google.com>
 <20261117045254.1048298-2-dylanbhatch@google.com> <awIMltMpXzhXiDpU@jpoimboe>
In-Reply-To: <awIMltMpXzhXiDpU@jpoimboe>
From: Dylan Hatch <dylanbhatch@google.com>
Date: Tue, 24 Nov 2026 20:18:04 -0800
X-Gm-Features: Aa3M54pyIniNB_vn7eg13DbCLk1cWp5ylttVhb4AKr3piHRNkIg2PU3xZVlnsAY
Message-ID: <CADBMgpzifnY=3wF2vt01UTaqPE68N2e9oe5WoSMDUrdgBSWgvA@mail.gmail.com>
Subject: Re: [PATCH 1/2] sched, livepatch: Fix transition stall for CPU-bound tasks
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, 
	Joe Lawrence <joe.lawrence@redhat.com>, Song Liu <song@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Shuah Khan <shuah@kernel.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner <tglx@kernel.org>, live-patching@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Josh,

On Sat, Nov 21, 2026 at 1:55=E2=80=AFPM Josh Poimboeuf <jpoimboe@kernel.org=
> wrote:
>
> On Tue, Nov 17, 2026 at 04:52:53AM +0000, Dylan Hatch wrote:
> > Commit 676e8cf70cb0 ("sched,livepatch: Untangle cond_resched() and
> > live-patching") moved klp_sched_try_switch() from cond_resched() into
> > __schedule() and gated it on READ_ONCE(curr->__state) & TASK_FREEZABLE.
> > This causes livepatch transitions to stall when a CPU-bound kthread or
> > PF_USER_WORKER thread (such as vhost-<pid>) spins in a kernel loop with
> > cond_resched() for two reasons:
> >
> > 1. A sole runnable task on a CPU (cfs_rq->nr_queued =3D=3D 1) never has
> >    TIF_NEED_RESCHED set during sched_tick(), and wake_up_state(task,
> >    TASK_INTERRUPTIBLE) in klp_send_signals() is a no-op for a
> >    TASK_RUNNING kthread. Because _cond_resched() is a no-op under
> >    CONFIG_PREEMPTION=3Dy, the task only enters __schedule(SM_PREEMPT) o=
n
> >    return from interrupts via irqentry_exit_cond_resched() when
> >    TIF_NEED_RESCHED is set.
> > 2. Even when __schedule() is entered via preemption or an unfreezable
> >    sleep (such as PF_NOFREEZE kthreads or PF_USER_WORKER threads
> >    sleeping in TASK_INTERRUPTIBLE), curr->__state does not have
> >    TASK_FREEZABLE set, so klp_sched_try_switch() skips the task.
> >    Livepatch safety in __schedule() is already guaranteed by
> >    stack_trace_save_tsk_reliable() inside klp_check_stack().
> >
> > Fix both issues by:
> > - Removing the TASK_FREEZABLE check from klp_sched_try_switch() and
> >   checking TIF_PATCH_PENDING inline via klp_sched_need_resched().
> > - Calling resched_curr(rq) in sched_tick() when klp_sched_need_resched(=
)
> >   is true for the current task, ensuring CPU-bound tasks with a pending
> >   livepatch enter __schedule() at the next timer tick.
> >
> > Note that when a CPU-bound task is the sole runnable task on its CPU,
> > entering __schedule(SM_PREEMPT) from preempt_schedule_irq() leaves an
> > in-kernel interrupt pt_regs frame on the stack during
> > klp_sched_try_switch(). Completing the transition in that context
> > requires arch_stack_walk_reliable() to support unwinding across
> > in-kernel exception frames (as CONFIG_UNWINDER_ORC=3Dy does on x86_64);
> > configs and architectures whose reliable unwinder rejects in-kernel
> > exception frames (x86 with CONFIG_FRAME_POINTER=3Dy, arm64, powerpc, an=
d
> > s390) still require another runnable task to context-switch the spinnin=
g
> > task out until exception-boundary reliable unwinding (e.g. via SFrame)
> > is available.
> >
> > Fixes: 676e8cf70cb0 ("sched,livepatch: Untangle cond_resched() and live=
-patching")
>
> Oof, so Peter's patch broke all non-ORC for this case :-(
>
> Not sure what we can do about that other than get kernel sframe/eh_frame
> working for exception boundary unwinding, as you mention.
>
> > Signed-off-by: Dylan Hatch <dylanbhatch@google.com>
> > ---
> >  include/linux/livepatch_sched.h | 13 +++++++++++--
> >  kernel/sched/core.c             |  3 ++-
> >  2 files changed, 13 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/linux/livepatch_sched.h b/include/linux/livepatch_=
sched.h
> > index 065c185f27638..748b6012e2e06 100644
> > --- a/include/linux/livepatch_sched.h
> > +++ b/include/linux/livepatch_sched.h
> > @@ -11,15 +11,24 @@ void __klp_sched_try_switch(void);
> >
> >  DECLARE_STATIC_KEY_FALSE(klp_sched_try_switch_key);
> >
> > +static __always_inline bool klp_sched_need_resched(struct task_struct =
*curr)
> > +{
> > +     return static_branch_unlikely(&klp_sched_try_switch_key) &&
> > +            unlikely(test_tsk_thread_flag(curr, TIF_PATCH_PENDING));
> > +}
> > +
> >  static __always_inline void klp_sched_try_switch(struct task_struct *c=
urr)
> >  {
> > -     if (static_branch_unlikely(&klp_sched_try_switch_key) &&
> > -         READ_ONCE(curr->__state) & TASK_FREEZABLE)
> > +     if (klp_sched_need_resched(curr))
> >               __klp_sched_try_switch();
> >  }
> >
> >  #else /* !CONFIG_LIVEPATCH */
> >  static inline void klp_sched_try_switch(struct task_struct *curr) {}
> > +static inline bool klp_sched_need_resched(struct task_struct *curr)
> > +{
> > +     return false;
> > +}
> >  #endif /* CONFIG_LIVEPATCH */
> >
> >  #endif /* _LINUX_LIVEPATCH_SCHED_H_ */
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 04b62c16fa8ca..fcea9cea3edf1 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -5854,7 +5854,8 @@ void sched_tick(void)
> >       hw_pressure =3D arch_scale_hw_pressure(cpu_of(rq));
> >       update_hw_load_avg(rq_clock_task(rq), rq, hw_pressure);
> >
> > -     if (dynamic_preempt_lazy() && tif_test_bit(TIF_NEED_RESCHED_LAZY)=
)
> > +     if ((dynamic_preempt_lazy() && tif_test_bit(TIF_NEED_RESCHED_LAZY=
)) ||
> > +         klp_sched_need_resched(curr))
> >               resched_curr(rq);
>
> Hm, so for unpatched tasks this forces a full preemption and stack walk
> on every scheduler tick?
>
> Instead can we just kick the thread in the existing klp_send_signals()
> escalation path like below (untested)?

Sounds good to me, moving to klp_send_signals() for v2. I encountered
two issues with your suggested diff as-is:

1. Based on kernel/trace/rv/monitors/opid/opid.c it looks like we
can't call set_tsk_need_resched from here:

rv: monitor opid does not allow event sched_need_resched on state any
with env irq_off=3D0,preempt_off=3D1

It looks like resched_cpu() works (suggested by my AI tool), so
sending v2 calling this instead.

2. I think this also misses user tasks stuck in the kernel with the
same behavior, so I moved the resched logic out of the (PF_KTHREAD |
PF_USER_WORKER) block. I also added coverage in the selftest, so the
same cond_resched situation is also created from a user task.

>
> diff --git a/include/linux/livepatch_sched.h b/include/linux/livepatch_sc=
hed.h
> index 065c185f27638..77161f5725dcc 100644
> --- a/include/linux/livepatch_sched.h
> +++ b/include/linux/livepatch_sched.h
> @@ -13,8 +13,7 @@ DECLARE_STATIC_KEY_FALSE(klp_sched_try_switch_key);
>
>  static __always_inline void klp_sched_try_switch(struct task_struct *cur=
r)
>  {
> -       if (static_branch_unlikely(&klp_sched_try_switch_key) &&
> -           READ_ONCE(curr->__state) & TASK_FREEZABLE)
> +       if (static_branch_unlikely(&klp_sched_try_switch_key))
>                 __klp_sched_try_switch();
>  }
>
> diff --git a/kernel/livepatch/transition.c b/kernel/livepatch/transition.=
c
> index e058d21d84b75..1ccbae2051c72 100644
> --- a/kernel/livepatch/transition.c
> +++ b/kernel/livepatch/transition.c
> @@ -402,12 +402,22 @@ static void klp_send_signals(void)
>                  * Meanwhile the task could migrate itself and the action
>                  * would be meaningless. It is not serious though.
>                  */
> -               if (task->flags & PF_KTHREAD) {
> +               if (task->flags & (PF_KTHREAD | PF_USER_WORKER)) {
>                         /*
>                          * Wake up a kthread which sleeps interruptedly a=
nd
>                          * still has not been migrated.
>                          */
> -                       wake_up_state(task, TASK_INTERRUPTIBLE);
> +                       if (wake_up_state(task, TASK_INTERRUPTIBLE))
> +                               continue;
> +
> +                       /*
> +                        * If it's running, force it through __schedule()=
 so
> +                        * it can switch itself in klp_sched_try_switch()=
.
> +                        */
> +                       if (task_curr(task)) {
> +                               set_tsk_need_resched(task);
> +                               kick_process(task);
> +                       }
>                 } else {
>                         /*
>                          * Send fake signal to all non-kthread tasks whic=
h are
>
