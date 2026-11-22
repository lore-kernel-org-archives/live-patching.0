Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795326722;
	b=x35X4DUjoJmDnpN7Z1oCjDtgs1oZbleOut7qyiG0jECAX3ea83W9h19uOmdRYF5/4xBQ
	 4H5cRdag7f8TPZFAYMWizDYrjfwFP+8FS6aN97H//bXqsaeyV31cLO/VppnYGcAepbdSP
	 bescAtcfgbVJ5/60ZNf2fEy5tQtvn1Ojyc6dwlTa7oEDoLVmIWO7S5BLsbTAcCcWCG3XA
	 aX95kqv1mL28k/wnEWDru0gxuKvISSFu/wVzFIwDBSHG9VeBbHqT+NgTqFOImfexDHLgp
	 xkaAltjXcQnbJeejjV1S0sqm2ZQPs+ncLhKf4Vha/3PydcAxWsUKH79o6zogcOhzwsQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795326722;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=6+prbOy6R2e3wzzP/a3qKoRX9ufIut6U2qKgOvJk6xs=;
	b=LmfH3e7aNpBrltT+CvhJafUM6AfBwbGit1aLrn1g2EA6F/jwmCZxdtOaetpzUL4s//Z3
	 QO60X4K4qjZebcx15lZBBwqnnsx6V/9ak0dqKn/vhls/wg1lCqxG7jfTjasY6RGWPHRYK
	 f+BeZZcvS/xGOPRA/awqCeFkZ2LoMllvZzy8D+ndMU8VcbuHzIgFWOJU31lddWl9mGB3i
	 06P0XEo+XpYHnnt00wmi3eoMNstyZI8Xtni/+e0++fpMYZfMbFQQKfXZJtSsW05iVj1Pf
	 NtZvPY4NpptmUdpRUPQKy37aND+JnVif9l//dI77fXEwkGrzwnkaK6IgVA/ZgV2PFHg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UcA+AFSf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.174
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7350E606A320
	for <live-patching@vger.kernel.org>; Sun, 22 Nov 2026 05:52:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7350E606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UcA+AFSf
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-8b4ea3c5afaso14946287b3.1
        for <live-patching@vger.kernel.org>; Sat, 21 Nov 2026 21:52:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795326721; cv=none;
        d=google.com; s=arc-20260327;
        b=WlMt9aPkomeb7NcTCDyT+LPkixHH7QPPfjaMlxC2NMUNYx6uIigRlQ+DHtuq5aF5E5
         2nHJ/jv1GxRuQ++le4/eUQLVjsGHCfh3VXbUK42RCN/yBVrbvMoe87D8TtVrksZE8ziq
         zQzAQdVBrevPrtzXq+qtu4U/VGtwK1nlVKV2iaLAjIibBfMvacCS7Pu4E2n0aQ7up3Wx
         WUaBxjg73CjEAnhKfRMtGHZoZ0MPh0JozD1gfolmFlHcOMFrAsMigu9WSo5Vxqbs5SH+
         vo35S5tYhPMQ4ghwW1QIApPsb27HGG9cWkwwydrYdq2fHZa+9vn551lnH/EKHqm3z0aA
         rJAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6+prbOy6R2e3wzzP/a3qKoRX9ufIut6U2qKgOvJk6xs=;
        fh=aJ2WkFOr5NvtMo9f7i14OnuxAC5KtV2+GjlWRga/bxk=;
        b=YrywJYE3/Eml1ZdIH5ipz/5BkyFEZQtxnPX4ZfV8f9+l0EIglnYxW8HYKn+ILYwOwX
         TKPrO/L2nzX60nikIaDMejcuSXft2jUXsN0TVAHv8udJpgaS5ekU501UqRjBPRpr19JW
         IgkVO4WhRg4KHh6CeVsbFTVmV1TsAoLIEuBStlEza6xzkK19AKp08Qv3Udbf46e7L0aO
         +DVsn8FjhjWPH8aQDYLPZyHQ5CkuitfzqjO1APiGN0smdRe4CNF0u9l6+DHLgi9A1eaZ
         Cue2nl8ITxsnZeDu6zvToIEDf6rVDuttRgwjJoSnIlDtj1NLV9hAsBMwVaIIDepbGDZO
         pxRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795326721; x=1795931521; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6+prbOy6R2e3wzzP/a3qKoRX9ufIut6U2qKgOvJk6xs=;
        b=UcA+AFSfV+YIRdQ9kD70/Md6YmCoFLJiwjAUXR+wCf1tPPv3jlsyPbYGfYuYdUO8db
         h/l3u0l7tg9cK8C3vxa0t+biMIJt4TTrrM0MvwMWKEFlXYRJiy0uuuzAFpnsbodhUvtB
         WwqLBcQ/lz3Jy1e5DV4E4kaeY5QtU2GklURDiqoycjuOAmWhZGBJk/B/VuSCGksr8Cfr
         bvjJFElHaj2sd68GXCYMhSY19+8yiqdCvvc3XdzoefAX+Q30HENHieBsnXz+JQnf9Chp
         p+4kJnwOd1IlCyIp9JCccpS9iHSAU5aD1NERcd3ht8CwvPIZq+00x4jHeepBi7LowP6G
         Jj2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795326721; x=1795931521;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6+prbOy6R2e3wzzP/a3qKoRX9ufIut6U2qKgOvJk6xs=;
        b=bAC+KTn32kkYzT4n+6Yc62bPEEXaHdLtxVEq9cLOosukAkYhhZWNL8PQW1d5h0bLyu
         2al83o7LMe+FEleiCooOV4DAzouRGxHRBQ7rwBnSIlG9QxEzOJcOGAfIicXxyHRXqzvv
         CfweGQwGRwPH4HQEHEyNBhe9sDsDukf8VpxFiPLHAgYCZbIrdgswMSuceYwjksz/u/IU
         qYmHm3XS7f6ZhgOhUIUndIGgbifT4qlOs7nKrJnuC/nAdaOmVhspKVRMkyQ9DiGq4Lo9
         n8P0zQkwDjUIpe1UG4vhmTRo+AfpVP/PefZVgRSmO8mdBWANNhsS/BddRS41OHwmIPID
         X74Q==
X-Forwarded-Encrypted: i=1; AL+hErGUCIkyi3cfIpmYJpcELoxdRY+JXgBbyKakmfdkTc7c4IOeEOOGI9EYFWlsKBTPDAnaTuGZKRZnJ7hoaQUg@vger.kernel.org
X-Gm-Message-State: APuU4Z/7WHJyPsHWtIlvhsriwE8oy3bVhYzRgNAT+XLv66wDnZ4WM70C
	6kqLPAE/G6So5WTNGZLcwyrEJ2KIsV6Fr8rr5Zmy8Tol8O+LKlHeKPtWK4bOgG2K8bijii1H+no
	90zLNTR5LylYcAbXQCWROfCpZlr8oGoM=
X-Gm-Gg: AZFdTZeF5e0aa9/9Ik+NpW+qxXOc0XxhWqa2vCiyXhDY8WKWHagBaVZPBNzmrePGrQb
	2XhXoMQaSkHO5H1a11TMZHAXimU/iSuUXiarisUeceyi3EhoWpK8kSYjL6tjtbaaeZRO9JBNDiq
	3pA+O9mXIq6mXfqJHl+Mxsp4pXRXCI29dkBk4xEnMyYWYahbGnSvfjxoB1voAynPMLQblXgizN0
	z5mmSRWN3g9foxQWggsLChTSgy9h2UQocadMmJPk5a3K6947QxqCaHxVtnc7XVz3a0jivCMKvPI
	3v+97RvEVfNozSeEcMgMIjzardr+PxGxpTkxzijXIJXJc/yX+zrRk7Nnl3e3f+mDqR/j+yjza4Y
	eHZmhRXvdeWpv4LBDzgfF9oVlJJwGBh1UFx9ZexBo3ySzVOYR7u8NCVAMWFXNJxn17Yg=
X-Received: by 2002:a05:690c:6213:b0:8b4:cd96:e2dd with SMTP id
 00721157ae682-8b52032afc8mr23783917b3.14.1795326721337; Sat, 21 Nov 2026
 21:52:01 -0800 (PST)
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117130848.65142-1-laoar.shao@gmail.com> <awIDmjHwiQqwuSC8@jpoimboe>
In-Reply-To: <awIDmjHwiQqwuSC8@jpoimboe>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 22 Nov 2026 13:51:23 +0800
X-Gm-Features: Aa3M54pe6i9kKOJRvzTHVsKO06jX5gehkfSr00H6MSY6xvkC4j199kOrY7uLxLk
Message-ID: <CALOAHbDZME2hGtFMFCuv7XM3bx-uoR5bEM5Z-+jUx4CjESz-pg@mail.gmail.com>
Subject: Re: [PATCH] livepatch: Avoid blocking tasklist_lock too long
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: mbenes@suse.cz, pmladek@suse.com, joe.lawrence@redhat.com, song@kernel.org, 
	live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 22, 2026 at 5:01=E2=80=AFAM Josh Poimboeuf <jpoimboe@kernel.org=
> wrote:
>
> On Tue, Nov 17, 2026 at 09:08:48PM +0800, Yafang Shao wrote:
> > Problem
> > =3D=3D=3D=3D=3D=3D=3D
> >
> > As more and more patches accumulate in the cumulative livepatch, we see=
 an
> > increasing number of latency spikes from latency-sensitive services dur=
ing
> > livepatch upgrades. The most recent case is the redis data_server [0].
> >
> > With some tracing added to the userspace redis code and a hard trace in=
 the
> > kernel, we finally tracked the root cause down to tasklist_lock content=
ion
> > during livepatch transition.
> >
> > When redis flushes data, it clones a new task, which takes the write si=
de of
> > tasklist_lock. If a livepatch upgrade is in progress at the same time,
> > tasklist_lock is held for the whole transition. Below is the trace we
> > captured while reproducing the issue:
> >
> > =3D=3D=3D [2026-11-15 15:18:06] tid=3D1635309 comm=3Ddata_server  WRITE=
 wait=3D79372 us
> >
> >         queued_write_lock_slowpath+276
> >         queued_write_lock_slowpath+276
> >         _raw_write_lock_irq+69
> >         copy_process+3474
> >         kernel_clone+157
> >         __do_sys_clone+102
> >         __x64_sys_clone+37
> >         do_syscall_64+56
> >         entry_SYSCALL_64_after_hwframe+100
> >
> > =3D=3D=3D [2026-11-15 15:18:06] klp scan held tasklist_lock(read) ~ 968=
64 us (comm=3Dinsmod)
> >
> >         klp_enable_patch.cold+247
> >         init_module+477
> >         do_one_initcall+70
> >         do_init_module+82
> >         load_module+2526
> >         __do_sys_finit_module+200
> >         __x64_sys_finit_module+24
> >         do_syscall_64+56
> >         entry_SYSCALL_64_after_hwframe+100
> >
> > =3D=3D=3D [2026-11-15 15:18:08] klp scan held tasklist_lock(read) ~ 350=
4145 us (comm=3Dkworker/8:2)
> >
> >         klp_transition_work_fn+36
> >         process_one_work+492
> >         worker_thread+83
> >         kthread+235
> >         ret_from_fork+31
> >
> >   crash> p klp_signals_cnt
> >   klp_signals_cnt =3D $1 =3D 1
> >
> > The latency budget of our redis workload is 50 ms, while the clone() ca=
ll
> > observed during the livepatch transition took ~79 ms.
> >
> > Environment used for the reproduction
> > ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >
> >   server: 256C AMD EPYC server
> >   tasks: 1000~2000
> >   number of patched functions: around 80
> >
> > Solution
> > =3D=3D=3D=3D=3D=3D=3D=3D
> >
> > The redis application can work around this issue by removing the clone(=
)
> > from its data flush path, but I believe we should improve this in the k=
ernel
> > if we can.
> >
> > In 2025, we discussed completely replacing tasklist_lock with RCU [1], =
but
> > Petr pointed out that it is far more complicated than we expected [2], =
so we
> > ended up abandoning that idea.
> >
> > We still have a more lightweight way to partially replace this heavy
> > tasklist_lock with RCU, as Josh suggested [3]:
> >
> >   : Maybe klp_try_complete_transition() could iterate the tasks in two
> >   : passes?  The first pass would use rcu_read_lock().  Then if all tas=
ks
> >   : appear to be patched, try again with tasklist_lock.
> >
> > This patch implements that suggestion.
> >
> > Verification
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > I verified this solution on my test server:
> >
> >   server: 64C AMD virtual server
> >   tasks: ~2000 processes with ~8000 threads, ~30 running
> >   number of patched functions: 200
> >
> > - Before this patch
> >   the maximum clone() latency during the livepatch transition exceeded
> >   500 ms.
> >
> > - After this patch
> >   the maximum clone() latency during the livepatch transition is below
> >   20 ms, which is within the range expected by the redis side.
> >
> > Link: https://github.com/redis/redis [0]
> > Link: https://lore.kernel.org/all/20250227024733.16989-1-laoar.shao@gma=
il.com/ [1]
> > Link: https://lore.kernel.org/all/Z8CRXxfI24E9_IHC@pathway.suse.cz/ [2]
> > Link: https://lore.kernel.org/all/20250213013603.i6uxtjvc3qxlsqwc@jpoim=
boe/ [3]
> > Suggested-by: Josh Poimboeuf <jpoimboe@kernel.org>
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  kernel/livepatch/transition.c | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >
> > diff --git a/kernel/livepatch/transition.c b/kernel/livepatch/transitio=
n.c
> > index 2351a19ac2a9..e058d21d84b7 100644
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
> > +
> > +     /* Second pass: Iterate over missed tasks, holding tasklist_lock.=
 */
> >       read_lock(&tasklist_lock);
> >       for_each_process_thread(g, task)
> >               if (!klp_try_switch_task(task))
>
> I think the performance can be improved further by only doing the 2nd
> pass if the 1st pass fully succeeded?

nice suggestion.
I will do it.

>
> diff --git a/kernel/livepatch/transition.c b/kernel/livepatch/transition.=
c
> index e058d21d84b75..8cbfc61ce87cf 100644
> --- a/kernel/livepatch/transition.c
> +++ b/kernel/livepatch/transition.c
> @@ -460,16 +460,22 @@ void klp_try_complete_transition(void)
>                 if (task =3D=3D current)
>                         continue;
>
> -               klp_try_switch_task(task);
> +               if (!klp_try_switch_task(task))
> +                       complete =3D false;
>         }
>         rcu_read_unlock();
>
> -       /* Second pass: Iterate over missed tasks, holding tasklist_lock.=
 */
> -       read_lock(&tasklist_lock);
> -       for_each_process_thread(g, task)
> -               if (!klp_try_switch_task(task))
> -                       complete =3D false;
> -       read_unlock(&tasklist_lock);
> +       /*
> +        * If the first pass succeeded, grab the more heavyweight tasklis=
t lock
> +        * to check current and any newly forked tasks.
> +        */
> +       if (complete) {
> +               read_lock(&tasklist_lock);
> +               for_each_process_thread(g, task)
> +                       if (!klp_try_switch_task(task))
> +                               complete =3D false;
> +               read_unlock(&tasklist_lock);
> +       }
>
>         /*
>          * Ditto for the idle "swapper" tasks.



--=20
Regards
Yafang
