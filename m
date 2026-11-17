Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794925627;
	b=QZA0iz1UDWuHulXXH+4qsXfunszRZnlHXsNDW6eVVgy4wRDyANgikGVuj4lj5LShEPha
	 /PNTpeX5vwEOejIYxOlLGQL6XHDqiZ8RKrRnvZ10GaXHKQGIiFTm5scABgshW/LPkGLNK
	 3uL8jvKZ3j2grXm3dWqnRzy3YdV/dnh7i0pGebzxS/SUbV5qmF+gVjkes9Mgs0SoBe6wx
	 LBvQ2nIyZbPgORfMKlwBDxdd+S1bVw7Q2/W73OQBcr4TW/iOLH0P0vw/Hb1YeO4K9qVER
	 SyeRl53+kaY7PT/k42FBXQcgGrbbO2O7Lyg/7pUFq7l7VjCrvUcau3oJGcp6eL7Apcg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794925627;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=PlBEz0/R/Ef87STf82uOLT7Vkt0DOzSXLhqXXnaUz/0=;
	b=p1COj5ZlviWLbtu8AuGKjfmgky2czkYyYWpQun1YhS1H3qDvypBqVtFMzWpDCdhZ4s87
	 7xuyCM49R3u6JN14wDvERh0iMYP4zBON3dniKF0Z0t64jXqzAPeT5U79ZY/c96dlpUH8B
	 1eoMqs8RUlcyVhg16H2Vcg2Aqti+zmTWe1ZS8oIoHwQsnFmeUvo1Ixw5s5aF0lJ5pM6+5
	 IE1RmzlcdGRMzOxG7oCoxDTkwthLXO0xOcFH0oBZOCqCn4qtFBqxpw1l8QrZzIXcoj/A+
	 y+t/qFMgWODsOylGlzziEOmSxVZe91cZRq+gBpOL8byrNr/ZTDI5rkF2w+nar9tDPrA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EWDPyb3l;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.181
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E22606A323
	for <live-patching@vger.kernel.org>; Tue, 17 Nov 2026 14:27:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7E22606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EWDPyb3l
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-8b32daac9d7so8281587b3.0
        for <live-patching@vger.kernel.org>; Tue, 17 Nov 2026 06:27:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794925625; cv=none;
        d=google.com; s=arc-20260327;
        b=cByJbVeXl9fVU9IvJUTjVQwnGY3k+grJ/qG1IiMqwcbdzjnxMtxoLi/aG9z5/34Isa
         5+j3mKpmf+v2cLL4ObzZXr6K2B8uwQm9FW8W4cWD6hq5cieNLPMKZQlAtNhbYGhZP4C5
         6jT3JcZyKQAd/G7cmtpoHg0eGyY/e96N5iFRlQjOzlpNMFiNhamWpjmdZRMB14yzKZN7
         w/9t2LRmRyPYsRuiyg07cmCfkFNpEpjFb4NGYd/IEFHrxKb2FwNZL8gJSunpBVW1JHzz
         3Cai0nu7DlnTIbZ5I8z7XW9ElV5LVETukJQsA5ihPOGL+yvcnRY3tUoQSAzFDEYJdxsO
         zKEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PlBEz0/R/Ef87STf82uOLT7Vkt0DOzSXLhqXXnaUz/0=;
        fh=sh1IEMofIq/ifOhTgwKdFtms2TdHK0f4ZvwH8nWwpIw=;
        b=KICKajdrxcpPbabkLjhfsjoaaQG9aug19YNmrwixKWGHv2VsZm7lzkcuJBZmCLxcka
         l2+vGyNbldDx7JNr1ZLhIU/ARDk/ejNJGnt88EfnxjLwogrwHzKDSa/PuqVB+WY4bOLO
         kZDIC6nfQTbB1NqihZCzTxEpUiXWKbXGBVR06njrIZJ7KOidXTv/s9VtAED/JrRziFCu
         rAlbNTm5GujWA5eRLgLv82VylM4c4hBlqyw3NLnLppLII/K4g/frWz6Yjh3blgBB/E4Y
         0gvjtT5BEw8bJmHxjFHHQxm/o5WCBSqYbwd/Y6h8NBxy448FsZs26MlUO/ZCZIaORlCD
         vN2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794925625; x=1795530425; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PlBEz0/R/Ef87STf82uOLT7Vkt0DOzSXLhqXXnaUz/0=;
        b=EWDPyb3lMcIcplYFDqPf8PwygDFUfMZCQ88FeBNcF8GyzfmwEFzVs7u/ig/UHlL/Ci
         lV0VJ65OZb4N+CGorAGWOGrTcJnlaveuLJ7JW5afmt8Aa97JTOHJOUsE1e1AUHpgMAKK
         ZiGhpUBBvPY+sQGe/LfMwHq1/k4plwyKrk+yn3esR0nnUdojjSRqj+OTHmAHbuonuW8S
         vqSqIU34NhR4M2+uw3U9FpkUmgB9VFXcoA7xjJK6siVJvHyn7zDngxTTswEoSwRda61D
         G85aTJnPJwEoN2dR8yMUA0l+fJgeGZ8dHOmcE7mVfKKTlRFpCLFLo6kVzGMgse5iDXhX
         kUmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794925625; x=1795530425;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PlBEz0/R/Ef87STf82uOLT7Vkt0DOzSXLhqXXnaUz/0=;
        b=F307dsApOx+IIruEK/7kU4jzbp2H5eoDZXNWKEcDoLO8cholKCoQXVYzsHp6jPa/Wx
         zgUCZkmu6CvloC5uKSDS0PC5CDXincT+z3N6cTwmemlmUEC8gHE7ZZDzyCHMtZEX/YsU
         EpREKarsbxPVxG83jUj5GDvWm5eeKX/06WrL5xAlc1KALy0pGIHCWN+1BDFZpGm/Sw4h
         y14ZSD40z3lsSwpI8On2Mo4kpyUnf0gXAwfuyKTZqTz3QRcu0Zn/OCXESLMxOVb5UE0a
         216IoVL90egJCvVmtCGpdqyQr9XSAiR1ZQttxx14X3XrlSoavLWLBOAhiS2IJsur6pu2
         3Dgw==
X-Forwarded-Encrypted: i=1; AL+hErHcF4yugblU/2kKwmHtj/siJOheZpGQDCKT5ecug3fvjCxymA7bH5GPonFy00x+KfRVLrZ5biWpoKMhVPp+@vger.kernel.org
X-Gm-Message-State: APuU4Z/FrI4P+o6V8U0ey21Gg/pdF1a9boiVrxReqBz7Rpo31Pz0+G8S
	4rhdEmHurqezeaVlzYbGjCLacJhlDnZts6sL8wPRZPcRYFC0fkgT+u+Dj0OeXzegBpAHehYgRce
	QytWpSeLKtdwA/KfG/lxLiMp6bPv9Qrc=
X-Gm-Gg: AZFdTZftNS6OGuK6YYkg/3MLc4wFKjjbK3fJKneakp5URoUGb7X907/NRg7u9IEx1pB
	iyLTyiZIS3PI38zVNhKLxVBn9l55gbE4j737y2sCdJeydCpM/U8U529f9kPn3XscTxAiZ83IPzg
	VK8lp60fk9xt87YtW9CyW8nOQounnSpSsK6f9/bWw37i9IM1iM5iFK8vj6VZZqEh+SIkJQmfO1P
	K8N12VCvxF69pbAE/TSOW/YaIMOfuCQ3SRLXrrWBNPvI4NundtZC5GVDrrg5CA3j90OrwQQlJM5
	qCBUd2HYD/cOnxjh2j4wsaLU9ftxPDbhuEdnTbVZZca5CpkrRqQifV24E9iFHkDSHpwuhNcdIW+
	6B2yIJYkdXoNKa+H0xr0Tj939LxFaklHXiD0ObOEBniVz9B6jvr1NZXFMMgPpzWuRTOo=
X-Received: by 2002:a05:690c:d88:b0:8b4:caa5:b52c with SMTP id
 00721157ae682-8b4ee2ecf97mr16817967b3.16.1794925625274; Tue, 17 Nov 2026
 06:27:05 -0800 (PST)
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117130848.65142-1-laoar.shao@gmail.com> <sashiko-outbox-218879@kernel.org>
In-Reply-To: <sashiko-outbox-218879@kernel.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 17 Nov 2026 22:26:28 +0800
X-Gm-Features: AclHuK_7XQx9S0WE2CpZmD-evuYnumi4dxDiypwlbCMDCB8JZKCbklSyo6UFzBU
Message-ID: <CALOAHbCL8oJpne15Y1-Meh2u-jnrMLEB=dDR=bNuJ0i29hBg5w@mail.gmail.com>
Subject: Re: [PATCH] livepatch: Avoid blocking tasklist_lock too long
To: sashiko-reviews@lists.linux.dev
Cc: jpoimboe@kernel.org, mbenes@suse.cz, pmladek@suse.com, 
	joe.lawrence@redhat.com, song@kernel.org, live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 9:29=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] livepatch: race between klp_try_complete_transition() and
>   klp_copy_process()
> --
>
> commit ceb01fc48f77409ab4a5313629520f441760c90c
> Author: Yafang Shao <laoar.shao@gmail.com>
>
> livepatch: Avoid blocking tasklist_lock too long
>
> This commit splits the task iteration in klp_try_complete_transition() in=
to
> a first pass under rcu_read_lock() and a second pass under tasklist_lock =
to
> reduce tasklist_lock hold times during livepatch transitions.
>
> Link: https://github.com/redis/redis [0]
> Link: https://lore.kernel.org/all/20250227024733.16989-1-laoar.shao@gmail=
.com/ [1]
> Link: https://lore.kernel.org/all/Z8CRXxfI24E9_IHC@pathway.suse.cz/ [2]
> Link: https://lore.kernel.org/all/20250213013603.i6uxtjvc3qxlsqwc@jpoimbo=
e/ [3]
>
> > diff --git a/kernel/livepatch/transition.c b/kernel/livepatch/transitio=
n.c
> > index 2351a19ac2a9e..e058d21d84b75 100644
> > --- a/kernel/livepatch/transition.c
> > +++ b/kernel/livepatch/transition.c
> > @@ -444,7 +444,27 @@ void klp_try_complete_transition(void)
> >        *
> >        * Usually this will transition most (or all) of the tasks on a s=
ystem
> >        * unless the patch includes changes to a very common function.
> > +      *
> > +      * To avoid holding the tasklist_lock for too long, we iterate ov=
er the
> > +      * tasks in two passes. In the first pass, we use the lightweight=
 RCU
> > +      * read lock to iterate through most tasks. This pass will cover =
the
> > +      * majority of tasks, except for some newly forked tasks which ma=
y be
> > +      * added into the tasklist concurrently. In the second pass, we a=
cquire
> > +      * the tasklist_lock to handle the tasks missed in the first pass=
.
> >        */
> > +
> > +     /* First pass: Iterate over tasks using the lightweight RCU read =
lock. */
> > +     rcu_read_lock();
> > +     for_each_process_thread(g, task) {
> > +             /* klp_check_stack() requires preemption to be disabled *=
/
> > +             if (task =3D=3D current)
> > +                     continue;
> > +
> > +             klp_try_switch_task(task);
> > +     }
> > +     rcu_read_unlock();
>
> [Severity: Medium]
> Can this RCU pass race with klp_copy_process() on CONFIG_PREEMPT_RT kerne=
ls
> and leave a newly forked child with TIF_PATCH_PENDING still set when the
> transition completes?
>
> klp_copy_process() relies on tasklist_lock to serialize against transitio=
n
> updates while copying TIF_PATCH_PENDING and patch_state from current to
> child:
>
> kernel/livepatch/transition.c:klp_copy_process() {
>         if (test_tsk_thread_flag(current, TIF_PATCH_PENDING))
>                 set_tsk_thread_flag(child, TIF_PATCH_PENDING);
>         else
>                 clear_tsk_thread_flag(child, TIF_PATCH_PENDING);
>
>         child->patch_state =3D current->patch_state;
> }
>
> On CONFIG_PREEMPT_RT, write_lock_irq(&tasklist_lock) in copy_process() is=
 a
> preemptible rtmutex lock, and unwinders such as x86_64 ORC unwind reliabl=
y
> across in-kernel preemption frames:
>
> CPU0 (parent in fork)             CPU1 (klp_try_complete_transition)
> copy_process()
>   write_lock_irq(&tasklist_lock)
>   klp_copy_process(child)
>     set_tsk_thread_flag(child,
>       TIF_PATCH_PENDING)
>     <preempted>
>                                   /* First pass under rcu_read_lock() */
>                                   klp_try_switch_task(parent)
>                                     ...
>                                     clear_tsk_thread_flag(parent,
>                                       TIF_PATCH_PENDING)
>                                     parent->patch_state =3D klp_target_st=
ate
>     child->patch_state =3D
>       current->patch_state
>   write_unlock_irq(&tasklist_lock)
>                                   /* Second pass under tasklist_lock */
>                                   klp_try_switch_task(child)
>                                     if (task->patch_state =3D=3D klp_targ=
et_state)
>                                       return true;
>                                   klp_complete_transition()
>                                     WARN_ON_ONCE(test_tsk_thread_flag(chi=
ld,
>                                       TIF_PATCH_PENDING))  <-- stale flag
>
> Because child->patch_state already matches klp_target_state, the second p=
ass
> under tasklist_lock returns early in klp_try_switch_task() without cleari=
ng
> TIF_PATCH_PENDING on child.  klp_complete_transition() then triggers
> WARN_ON_ONCE(test_tsk_thread_flag(task, TIF_PATCH_PENDING)) and leaves th=
e
> flag set on the child task.

Nice catch!

Perhaps it can be resolved by explicitly disabling the preemption?

diff --git a/kernel/livepatch/transition.c b/kernel/livepatch/transition.c
index e058d21d84b7..81c3afa69f03 100644
--- a/kernel/livepatch/transition.c
+++ b/kernel/livepatch/transition.c
@@ -706,12 +706,14 @@ void klp_copy_process(struct task_struct *child)
         * klp_update_patch_state(current) and __klp_sched_try_switch(), bu=
t we
         * cannot race with them because we are current.
         */
+       preempt_disable();
        if (test_tsk_thread_flag(current, TIF_PATCH_PENDING))
                set_tsk_thread_flag(child, TIF_PATCH_PENDING);
        else
                clear_tsk_thread_flag(child, TIF_PATCH_PENDING);

        child->patch_state =3D current->patch_state;
+       preempt_enable();
 }

 /*

--=20
Regards
Yafang
