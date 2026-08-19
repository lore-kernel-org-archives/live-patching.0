Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C8330274D
	for <live-patching@vger.kernel.org>; Wed, 19 Aug 2026 12:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787144386; cv=none; b=VtjogcKFhBpFQGk3Sohx8rjH8YjHJdNE3BsOqyPvSMDVr+IeAdqa/MhZyrFzCHeJ+aDj0uiBHIKyfeZbrIFzmkVfXsqwJvkTP1OdNUjy1see8P4FqmQEf/tMUPJa5KeR8KKaNiZJEeUyxk9cDUmHWf4tx+tFbeaO665UlukPmxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787144386; c=relaxed/simple;
	bh=wxWdDA/OQxdpGyjcEEMeoSm55oJgOwzx8cpmmdH3L2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YNk86yjtDnoQqgPASBdxwXb8aEBjXtiLUs6Ed7dfipQBnGhp5TO0leIGkYn0VHFEBpJH+nSsmlUCZNPW/o3rFVWZyw7xd7FOfRvsfIUJ1QDe0Fa34U0XD89UkF5mJf7WslWt1/DrgiHUtM+wYicTEXpTzm+tPppx2qvE2jCpQ6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LpWSstIE; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LpWSstIE"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-495437bb891so7785625e9.1
        for <live-patching@vger.kernel.org>; Wed, 19 Aug 2026 05:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1787144383; x=1787749183; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KKUZ68+2oy4CCiqh/DqOSs4VstN5uj/eU8eWIQyQY2I=;
        b=LpWSstIEuUFMjkbm+Cjycozi0EQ/cjDiqoE0G/Ew/HljXEqRn5qE2gTlDmkMebzLhL
         y8EXptttwhKdrkOw2I/34660hjxv7RsUz+j4lxewSQBrxbDbnOk4oDsK7t46JE3zRYkV
         GU6cBBZxLYZ/W2Ct/7uBC+bfiyFu/lHdGsgO97g9rhHgOeBRErphYQy8KmfVvTpvdSJJ
         tMOk8R1ug4Tx4KFyOYL2DkYeExZLJNvoSdvzI4fWSrMOZbBxz9oGujS6XpWk6YvfQafY
         hF3avCqC0Y2jvFFOLsLe2jncSsZg/GF18lh+2WDIe216fCyDi7RMBTPxDnTbCdRgHvGx
         mwbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787144383; x=1787749183;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KKUZ68+2oy4CCiqh/DqOSs4VstN5uj/eU8eWIQyQY2I=;
        b=Hs7hLh7DZ8wSeJrwJ4PESSLV/8/QDAAEXsHSkCAmzjl5+ii8/hzeZuxBlRpBggS3rh
         vjLjn5Tl8FPMtjxu1KX//T+rg/JR/+Gewa+2/aLYwvPgPZsWkn8UPMs+3f9Bszrc//4t
         VQb2aRAWUUnwYTctuDI+R54qiU3nz9ymNcBBRuuOz/XuzszaPfBsNRvenBmr+05nhQAt
         Dr+HzL1YPUNFnBTnkMIGWQzNjxxZKyBEeXS0j6JehgOfprTjoo08q/S6ZQ5+YCLrQb0/
         OfWZm+Cg5zchC9cu5MtprO9XBmzV2qR7KL7AwJD2o/2q7E81wUOge18VqzBV5fNjxSkY
         q9UQ==
X-Forwarded-Encrypted: i=1; AHgh+RpjTWzaO83aQTfgw6Ukql7qhK2UHzBIBvHtkP6nngHUcjKEyAD356X044ONk2qRpgvVK14NhCM+GhRuC1tT@vger.kernel.org
X-Gm-Message-State: AOJu0YwL5ygcHywE5iaFkv028bncLOiAotERtpAFkkSG2bnIywGjGgHc
	Tqkfx7cZ5lqzgVP59P+M6HGHBeENSrLnIpnsrM79n4btairVY/QkBrnKJEB2/v3T+Ws=
X-Gm-Gg: AR+sD12hgr1OFLbdMJkwvqq14Q4qTVpqWSp46riv1P/sOAfBVY5VAVjbhjh+8oiQTX4
	8T2Cj2r1oQeR9Tfd3iLcKbkQ/CxvNbep6daft4VhBlm4qV61SddOqHLUmmrNfrKxrd4R5kvY9VP
	8gQSLijbOVqD0uwbfZI4Ruue20/WyHJ2q6Lx9wxTP27fPzBH9tkUFzJfmZK9Ons2lydT0BYrpt+
	w8/f5q6XDGduldtKMYihvXPNu7LYAZ1mlzhjZkswXakT4hfT1bnnvZFGEFdizb1pia4oB6FcASy
	s2lN3CLqbjI5Hw2AePIk9HGkP67JXtR2R+Ejmi/1UypXeHtkXxAiuUX7BdKMYEFmpld9CiaPqtx
	hyzQg/50aukp4S+YbZtTdOGqgcftO2GCpJrYbRqQEf7GkoG3PcUbFOTRimiTNrWI+UjZWawlm66
	FoEi+hibZmqeEpqwmsqj00gMrdyiNwYGV6dShFRnQ2cQSnDWB5n0my9oYlYiHUxQ==
X-Received: by 2002:a05:600c:8712:b0:499:a0a5:e13f with SMTP id 5b1f17b1804b1-499aa0aaf56mr77029315e9.2.1787144382901;
        Wed, 19 Aug 2026 05:59:42 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499a9e00bddsm49415795e9.3.2026.08.19.05.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 05:59:42 -0700 (PDT)
Date: Wed, 19 Aug 2026 14:59:40 +0200
From: Petr Mladek <pmladek@suse.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz,
	joe.lawrence@redhat.com, song@kernel.org,
	live-patching@vger.kernel.org, sashiko-bot <sashiko-bot@kernel.org>
Subject: Re: [PATCH v2 2/2] livepatch: Fix UAF of unregistered patch kobjects
Message-ID: <aoWovB9T0ovJb7Yq@pathway.suse.cz>
References: <20260816090442.18128-1-laoar.shao@gmail.com>
 <20260816090442.18128-3-laoar.shao@gmail.com>
 <aoWRDIjvE5jYNR9_@pathway.suse.cz>
 <CALOAHbAwO4VCWEhMxkywv9W4wf8CfHJfgtaithBBpoSp5LJDkw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbAwO4VCWEhMxkywv9W4wf8CfHJfgtaithBBpoSp5LJDkw@mail.gmail.com>

On Wed 2026-08-19 20:37:17, Yafang Shao wrote:
> On Wed, Aug 19, 2026 at 7:18 PM Petr Mladek <pmladek@suse.com> wrote:
> >
> > On Sun 2026-08-16 17:04:42, Yafang Shao wrote:
> > > When klp_enable_patch() fails after klp_init_patch_early() has run,
> > > the error path calls klp_free_patch_start() and klp_free_patch_finish().
> > > The former drops the references of all object and function kobjects via
> > > klp_free_objects(), the latter drops the patch kobject reference and
> > > waits for the patch kobject release only:
> > >
> > >     klp_free_patch_finish():
> > >         kobject_put(&patch->kobj);
> > >         wait_for_completion(&patch->finish);
> > >
> > > With CONFIG_DEBUG_KOBJECT_RELEASE enabled, kobject_put() does not
> > > release the kobject synchronously but schedules a delayed release with
> > > a random delay of up to 4 seconds (see kobject_release() in
> > > lib/kobject.c).
> >
> > Yes.
> >
> > > Because klp_free_patch_finish() only waits for the
> > > patch kobject release, it may return while object and function kobject
> > > releases are still pending. The caller can then unload the livepatch
> > > module, which frees the klp_object and klp_func structures. The delayed
> > > kobject release callbacks later access this freed memory in
> > > kobject_cleanup(), resulting in a use-after-free.
> > >
> > > This issue can occur in two scenarios:
> > >
> > > 1. The patch kobject was never added to sysfs (e.g., klp_init_patch()
> > >    failed at kobject_add()). All child kobjects were only initialized
> > >    via kobject_init() but never added to sysfs. They do not hold
> > >    references to the patch kobject, so the patch kobject can be
> > >    released independently, unblocking patch->finish before the child
> > >    releases complete.
> > >
> > > 2. The patch kobject was added to sysfs, but a subsequent operation
> > >    such as klp_add_nops() or klp_init_object() failed. Some child
> > >    kobjects were initialized but not yet added to sysfs. These
> > >    un-added children do not hold references to the patch kobject
> > >    either, so the same race can occur.
> >
> > In short, this says that the races might happen when some kobjects
> > were not added into sysfs. Am I right, please?
> 
> right
> 
> >
> > I agree. My undestading:
> >
> > The klp_kobj_release_*() callbacks are called by kobject_cleanup()
> > which calls kobject_put(parent) as the last step. It should make sure
> > that:
> >
> >   + klp_kobj_release_patch() is scheduled/called only when
> >     klp_kobj_release_object() has been called for all patch->objs.
> >
> >   + klp_kobj_release_object() is scheduled/called only when
> >     klp_kobj_release_func() has been called for all obj->funcs.
> >
> > But it works only when "kobj->parent" is set and
> > "parent->kref" has been incremented for each child before.
> >
> > This is true only when kobject_add() is called for all all used
> > kobjects. But it is not guaranteed when any klp_init_*() failed.
> 
> correct
> 
> >
> > > Fix this by tracking all static kobject releases with a per-patch
> > > atomic counter (kobj_pending). klp_free_patch_start() counts the
> > > patch kobject plus all static object and function kobjects.
> > > klp_free_patch_finish() waits until kobj_pending reaches zero,
> > > ensuring all kobject releases have completed before the module is
> > > unloaded.
> >
> > I think that we do not need an extra couter. We might use
> > the existing kobj->kref. We just need to explicitely
> > increment/decrement it.
> 
> good idea
> 
> >
> > I mean something like:
> >
> > diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
> > index 28d15ba58a26..023f666ddcc4 100644
> > --- a/kernel/livepatch/core.c
> > +++ b/kernel/livepatch/core.c
> > @@ -652,6 +652,8 @@ static void klp_kobj_release_object(struct kobject *kobj)
> >
> >         if (obj->dynamic)
> >                 klp_free_object_dynamic(obj);
> > +       else
> > +               kobject_put(&obj->patch.kobj);
> >  }
> 
> It appears that klp_init_object_early() also initializes non-dynamic
> objects, right?

I was a bit confused by the sentence. The dynamic objects
do not exist when klp_init_object_early() is called in
klp_init_patch_early().

But I see that it is called also in klp_alloc_object_dynamic().

> Therefore, we should call kobject_put() unconditionally.

Great catch. Yes, we should call it unconditionally.

>  static void klp_kobj_release_object(struct kobject *kobj)
>  {
>         struct klp_object *obj;
> +       struct klp_patch *patch;
> 
>         obj = container_of(kobj, struct klp_object, kobj);
> +       patch = obj->patch;
> 
>         if (obj->dynamic)
>                 klp_free_object_dynamic(obj);
> +
> +       kobject_put(&patch->kobj);
>  }

Looks good. Same with klp_kobj_release_func().

Best Regards,
Petr
