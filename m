Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795406210;
	b=VDSI8zOHkjG8ZR2HOPBb5PJMjv2x91+2kmx8iVRyMuusQat6PyamxL1uj9nYdGLM9KnP
	 sgfmeV4feE99Lmfx7mPi426c7Nf0s2NjKrMb+1ZINpRi+BFHcIk116vk3GjHvyA+SBuss
	 jG7o9JchOBA4L7EVZ1DicNUFqUFozaG77Cy0toefwDfJGdKX3OukeN/YZE8oNd+lFnxrn
	 BzYQc/s6HFq7rvcDyqsZYAEyKni23pNX7Gn3R7CpI5wjV5NAe9ntAfVkUumZqNmhv8OR2
	 7hbhyfBYHOo+05rs+lJMONjtfD1oE8xqefBX/MQv8AEShkNG2H1o/hZw3338mncrMdA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795406210;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=0XAlSRVn/qzq3PpDz35l2bOFmo6OtmXUHT+w0KVC5so=;
	b=M/hLe/c0SNVsrjHeVCFfBgF1D6r1Z6SG5/Rnqk9IlGcdnpDy64kw2gVCdhdg9iv/WvJH
	 v2pkNtdtghZffDyiZHngAD7t3bkWtqtwCELuetYNVVoZJgfVE9u0VDc7cUyT8C01D2M7d
	 ZcgfS5GgneZsD/w9ItwAga59sfs6Mkov77f2O8qhR1upuyF83ENMaoIAROaCSlgIa/Ugv
	 aP9iC/OEcNSz2Z7f8XobuCzYrsANgjlrmxSD6LDncqG0+8ZlzLIqoAkKYCJiXE2lRkyi0
	 u5gMziqQaablEaIkqxygUkgIV4jTcziCsdvLyv+Z0a/zXoUxsMnILX0KO2KmBz7/ICQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MCGQsE6R;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.52
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B7D606A31A
	for <live-patching@vger.kernel.org>; Mon, 23 Nov 2026 03:56:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61B7D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MCGQsE6R
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-67dabd38cdfso3150215d50.2
        for <live-patching@vger.kernel.org>; Sun, 22 Nov 2026 19:56:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795406209; cv=none;
        d=google.com; s=arc-20260327;
        b=BkxuLNrEhxl4O+1aRZiWpFGZrhRh13DBKhK4nP77zf49oLcGsTV7UXex8H3lF6m2fj
         JF/L/x4hHHkhmN9Prnd4ly0kJepy1Qb1oDHNInNwii+mHDlu7wcH05VxPYvobqgLIZx9
         u5J7R5o2Rp0e00KOHNovkr5lKd4aJy29T43nRofUCeuYxrDptUZDok1sFEFzDFd16tCR
         pLRVE5/OCnMNmN2WTfTXqMV+/pK/GbWNnPczSN1xyK+Z59BUuc795fisqnmSK5rxXpvw
         39Gr1LPZ+O/GKtziEtuG321ngQJBjnKJ20UllxCSSIZCItD7mysxFyHGofMEwMEMIMC4
         TvdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0XAlSRVn/qzq3PpDz35l2bOFmo6OtmXUHT+w0KVC5so=;
        fh=UGA08KoOwI92US9Kuh+IjzbFTH9+gbtjDhJKFBrUc6E=;
        b=A4DIViwPxY25THd3k9GbOXwgm4YyBCfFQR914UPceHylJo65B2w+zSDfcdvaHSMhp1
         JPIMHHD1L/8E8ZjPr34vqL1NMiAl5MSPvAd0ucHWSuKms297uZDw4JSlZurVo4qKvuWx
         kfZIdFLpv6cRYNyg9T3YeJMRWG43Th4q4wuloCFDiXoQZmvWvxG3gU99nhyyqMJZbjo1
         Dz12XaNcyHMhXPtLM+s5WuUhQt9rXKfr0ai4Xq8nlF9ze4MjaY2RfqXMPgcHvepF6C5g
         huXh9LbT6rjQ4IeUYxk4/QfBZSFDA1wZrsnvzCN9H1ujOVcGSXIncuFDtSC4vNM72y4p
         LPUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795406209; x=1796011009; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0XAlSRVn/qzq3PpDz35l2bOFmo6OtmXUHT+w0KVC5so=;
        b=MCGQsE6RrzgxFCQ6r977THrn/UwJo8Xlfq1GMpi4+Lw11RcZE7ACx6DH1tqf52nfYF
         UjhUVcW2WSc/iPgciMmVoThLjAr25B5nA6JqWh1Jl3WT0CwRVlcJyHqfr3SAoBdPawEm
         FyVTKLx04nYFpP3sVJNT5AjZIAJR2J9qinYXn737++Nvw2awVgrjR+u4KmzsYjbU8PMU
         0jzD/DSk284Aj13hbmcZKU5dShOzRAVKTtoqqFmbOp1swCemzswP3woEX5Ab/aTtKyKt
         s9v8yNpyPUAh9mhvnKYWAMWWH4EXfyzhvUgUqsE0FMyYkKeGbIFnOCKwfqu9jhd4aIUU
         cb1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795406209; x=1796011009;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0XAlSRVn/qzq3PpDz35l2bOFmo6OtmXUHT+w0KVC5so=;
        b=ocn2GUHbZolQcK+RWzRNniiP1Lg52p3+z8DHjWygqPfan3TNGP2X57GT0tD9TZCjWm
         PI6Iwp5e3YmsE5iK5TjKoWSoOCUDr3LgPTaec8E7nGGdUlpBuw8KqDN4VrXd4xXXY6lr
         3VhX6w3DfxlQ7B9zuyhYkshZMbRd+yHHSeJ+2U1c5ex3Bos2PHAtN0Gf1VJsH0gT74jv
         /vnDKxWE822arRr0RCvF3YMdSDauTuw2dIoJ+m4iCvbfoYmF5YE11IEu4hSydzcxZ6Kz
         iMVYd0Dn2Z+f5B8RfdzbK3MCAveKO8N/tz2O/msA4g447+vLioFLc6WNMRmCho/HUc64
         VEGA==
X-Forwarded-Encrypted: i=1; AL+hErEX2dSjnF6izxYQsivM6d1eRAeDT+uZyyZvvjsqM3OFYSwf6Dv5OVayAZ637NKzLdM2y+1mEzG/Ntq0b54N@vger.kernel.org
X-Gm-Message-State: APuU4Z82LZQBF26Z3OQszF79Y81+zc8b3WB30ngaO19ppEnQlOcUYSmv
	Lpi14dUJC7hhlRL89OdTVvS/DkL3sUuYKxGpQACX06dStuFesqme/6BIRhvuwoJUHdBDgyVtyaq
	HqQajQNhoUZpNfG/ZFta6+BrqiKXUd8E=
X-Gm-Gg: AZFdTZf908xd0VWNNFdPmtCiCJjUNVpel3s+ggPU7qmNTyDtKFINRfmXRsmCnrlbUfZ
	nS1AyVQkk5bvUbB/tUketJ/wFwGl4VGDLM3Vx0mrmEIjkLWxUsN2z9IWeSa781vS7EdNHxHzOvY
	gi5PzYnGwjcCFbngGzdr9Nx3qrvZYPZ8K8JtN17NsOibYkDMudinjakYNkZntMmDIqhKoM5f7hF
	u7aLRQBtLv5AqsqQ2oaUxblF+0rtHPRqB7A2l90BVOZQnGNEnD8WY3fQUgdLxae2wXB02GYTUis
	Evbk2Yvvlr7nIChYFARdn7E5lTHcj1fbVklUCDYF1M/Cmec0FJBF1PTdbbyC/TiKrs1+uKgz8bU
	azIfk7ST6NdVtM9oyibDvoqk/666i5jnCiAhDwskpaEglp+YJ0M9e178NpPl9VKPAqR0=
X-Received: by 2002:a05:690c:4d41:b0:8b3:527b:d18f with SMTP id
 00721157ae682-8b520456090mr38907817b3.11.1795406209376; Sun, 22 Nov 2026
 19:56:49 -0800 (PST)
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261123024119.16154-1-laoar.shao@gmail.com> <sashiko-outbox-228569@kernel.org>
In-Reply-To: <sashiko-outbox-228569@kernel.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Mon, 23 Nov 2026 11:56:13 +0800
X-Gm-Features: Aa3M54oMglN3bqLhJZ-1frdXYOAEnsKlrIa_hmlMxZKI1C4SyNpRQVJHxDpK1s4
Message-ID: <CALOAHbBQytiNG1+JQi0kDGRtkXzQR0Lua-DyeB1xq86HNBGASA@mail.gmail.com>
Subject: Re: [PATCH v2] livepatch: Avoid blocking tasklist_lock too long
To: sashiko-reviews@lists.linux.dev
Cc: jpoimboe@kernel.org, mbenes@suse.cz, pmladek@suse.com, 
	joe.lawrence@redhat.com, song@kernel.org, live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2026 at 10:52=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] livepatch: broken current handling in
>   klp_try_complete_transition()
> --
>
> commit 9627aa0e09bd9a194e83552843dfca92987dfda2
> Author: Yafang Shao <laoar.shao@gmail.com>
>
> livepatch: Avoid blocking tasklist_lock too long
>
> This commit splits the task iteration in klp_try_complete_transition() in=
to
> a first pass under rcu_read_lock() and a conditional second pass under
> tasklist_lock to reduce tasklist_lock hold times during livepatch
> transitions.
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
> > index ef70ff582da18..e5df13fa6fbde 100644
> > --- a/kernel/livepatch/transition.c
> > +++ b/kernel/livepatch/transition.c
> > @@ -444,12 +444,38 @@ void klp_try_complete_transition(void)
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
> > -     read_lock(&tasklist_lock);
> > -     for_each_process_thread(g, task)
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
> >               if (!klp_try_switch_task(task))
> >                       complete =3D false;
> > -     read_unlock(&tasklist_lock);
> > +     }
> > +     rcu_read_unlock();
> > +
> > +     /*
> > +      * If the first pass succeeded, grab the more heavyweight tasklis=
t lock
> > +      * to check current and any newly forked tasks.
> > +      */
> > +     if (complete) {
> > +             read_lock(&tasklist_lock);
> > +             for_each_process_thread(g, task)
> > +                     if (!klp_try_switch_task(task))
> > +                             complete =3D false;
> > +             read_unlock(&tasklist_lock);
> > +     }
>
> [Severity: Medium]
> Does deferring current to the second pass still call klp_check_stack() wi=
th
> preemption enabled on CONFIG_PREEMPT_RT?
>
> As the new comment in klp_copy_process() notes, tasklist_lock is a sleepi=
ng
> lock on CONFIG_PREEMPT_RT, so read_lock(&tasklist_lock) does not disable
> preemption.  When task =3D=3D current, klp_try_switch_task() calls
> klp_check_and_switch_task() directly instead of going through
> task_call_func(), so klp_check_stack() triggers
> lockdep_assert_preemption_disabled() and leaves the per-CPU klp_stack_ent=
ries
> array unprotected if current is preempted by a task that runs
> __klp_sched_try_switch().
>
> Skipping current in the first pass also leaves current unswitched wheneve=
r
> any other task fails to switch (complete =3D=3D false), and forces an
> unnecessary second pass under tasklist_lock when current itself cannot
> switch.  Disabling preemption around klp_check_and_switch_task(current, .=
..)
> in klp_try_switch_task() would avoid both issues and allow current to be
> handled in the RCU pass.

Makes sense.
Seems this is a pre-existing issue.

--=20
Regards
Yafang
