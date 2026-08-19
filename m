Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C4E2F3621
	for <live-patching@vger.kernel.org>; Wed, 19 Aug 2026 12:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787143077; cv=pass; b=oOxB+7EV46EbPHUpbj0MAWkNjFj0SyUTBCDuP1P+RWsi0N8isc0nsB3dKVTQ8XRywDbnv1Dz4q2wVOqlYeBLhxOyLn21ynjwRvnMhEC1OkX7HylEqCgEPQ+XKDq8Wt61zymsU7tIxLTgqTfVwah/ho/wK0uLlD+qm5M/cApCv3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787143077; c=relaxed/simple;
	bh=crfwHT9a/SDUQZye1YQkoQ2jYUckgGz3UhCm2x1NYuc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fq3YiWnzUc7aD+bWO3mBIMD+va8tky2QvGEdFlL84DZFrR63M6fA14HmwOWB4r6Oi2jWrJ4lvhNC6+vsUQg8qj7wgLajlWJ9ZjIozvd5W2EdDC0MVgSORqLof/8CgoHfmbKemaofoUsViofw7FgFbzAHFqutbzWVyXw15qdLmT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a4HlWXK5; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a4HlWXK5"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-81ff017d420so28323627b3.0
        for <live-patching@vger.kernel.org>; Wed, 19 Aug 2026 05:37:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787143074; cv=none;
        d=google.com; s=arc-20260327;
        b=CaQpWgY5S+Mh4PvpVNawR0Lj+nmSVanz42lFD/M+x1MFXog9prJpSdbiu9iT8YPHUk
         wdZ8DHW/HAgYkzx1c2SlGTdv3QN75RaDX8IGLsttHscxskroyvbDsMv1xk6owEGi8XKb
         mM6oFHyUcUC9WJFKNXVVyppNLA+BF1gOBcjqlMLbW3J/0Rzp1FOF59LZ84Nx0H+ZkMb4
         I9VeMPosTfiQgFzHHOzL0ab5kwgmXH0KZVBcA/SpuOvqXx0ITkxEdDCldYra+aH1NevE
         RNZc6RHazyCJiftMiArihUUfLo0U0UcxM+CTVA0gpzzFZsUUynwtuLuXhGzpXV1271fn
         0L7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3Va6bPG3YQJTCxJi28ABfkzhSYLMZmNQjMTdjwgP/gs=;
        fh=hryzvHO/LJ8rics7zrhtjqW7Pphptn/dLiKzJ3yl4fQ=;
        b=Z/DZW5Ghunjr39pyiUOi0pxivSyYsMWI2KFJgOR9MRpD3nueFuUd57kwtc5f0JL4TY
         XOPvvgWqoJe2CAkqG9ECzYJ2ajimiz+TIgKwJeKEHLrcdVRRWdFHkYqMtEiqx+vpX2vj
         dC97U5kP2Fd+Vakr6WA4DLel8A+9BDlKRPLPgjWA+lgq8bkeIfrb0QH2+aZGPqNr/LJi
         4r7WwNyQP+gDDxz09IySTYCpC19qZNNsmw48fuMG4EsKkb4cXM/8T1+2h/NTEOTVTmU3
         o2P79rTRB6tfwm+aUxepND/s0pzGA4yFfJGFRK0uCP1suRTf/ocQXCdFN5KsVuYADtm0
         lzng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787143074; x=1787747874; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3Va6bPG3YQJTCxJi28ABfkzhSYLMZmNQjMTdjwgP/gs=;
        b=a4HlWXK5ghY1K7E8VsBl9sCBjWL7cI+cCTdbz3qrt+uNX9zZuo/SaM3bR+60b+umXH
         va/HUstGzolgLGPfywuJ8vG67GulSgtuuSVa0DcB6fHUzQx/k+EvVquY6JG7jr+kOMYz
         DJ9ozHSjM2iWwSNPaWbVm89qmSGoMfOB7sT787dmTvJsm8HNz6K1Zul41lqHqdnOj6QM
         7zwWpS3FmEJzh1LrC7TZAa1eSK4H9DoIXAbEfGIYcY7NJFYgjUDec9eJJZQcP+9+X8kD
         UFVyrc4KGhl58bU6F7twQdFKoidPlrXKuh8KAFyQhISlHMXcBoFmWI+xsXRE7CA+qaeL
         +RvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787143074; x=1787747874;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3Va6bPG3YQJTCxJi28ABfkzhSYLMZmNQjMTdjwgP/gs=;
        b=rckqxlcrO7kwkLk1DrJEg1WjmJgb2xvLgaPTQbOh7v1HlZXs4ES+TvHbBJz/XGmQCc
         IrQZ17J6DmEnGeiLwp7AgDYvXq6bCI7EAIGVv+fIPPLmnWNXbHCtQjl2hVUBM2kp7mlO
         USoLPx0Hl/WcqDF7r6bKoyOX9Puhri88HWMUovRbmHHxmf0MpMeOI+aeSwGrfPUym1dF
         uvfgyFSO3UDPZ73VF3UrXs1Dcvi14qUQ7A6MX4rJX5PUjjuqcusshVJJbuiIyDHkELDt
         9Fuk4oAzelK8hm9mkYnImErk+jAI+BX07+0k4Wuz4aeBtZarTVCQ7OuCvPkahi0OYZC7
         cI1g==
X-Forwarded-Encrypted: i=1; AHgh+RpNvDnqotAaxS9DgaRlPDgzK/YnBSTHOQauaYy7SKbtYRQiJn9Jh0fiCbMGqLmwHYsGHlui16WWiWd/wFXY@vger.kernel.org
X-Gm-Message-State: AFuF++n8v9bfrgjWHj72UtlEJY55JoePFyMiCX4Kss6sl74cuUclB+KL
	Ei6Hudsbq9Mh5GV2u7Czgf8CYYErX9KRz3KLf3p+OeYHR5+IHiLqEP42USQpTE/LDUpMbZdUNc9
	XX4Use2BzV8y2xDmap39+ukCdGHkPq/QjWff8
X-Gm-Gg: AR+sD134PEME0GEofxTie8Z87Lf54mynGB3gLNf4E4l4IDeRTkv42Ft3nAXv7cDr+S2
	TxzVBMOCuRMBnFiwb3MlNFuqmoNkYyWD8LqOTRi7LQig0sHF7gQs3updrgdpox00hTydKwOcqea
	b7U9SfbjDqaA5VfR/FxWb12Lt8eFn1RynCkzsy2EfTy1Z9pQrjOyvSamKTxeP2ugCz1nQZT1gKi
	KAf0Vivf3K3K5/XDPUCyqAIPMr0ZGM+5uH7qvTirkc1ZsQUDBT2pNXYI+qhukc4fqZ/OVvHc36s
	chdI7y6eDrzQ5/YyV6y1zx02N4zvjQOs1VjYX7scH0YZWGvx6PHDAkJeVG67EVuvBA6qD+iL0w2
	+EA==
X-Received: by 2002:a05:690c:a1d6:b0:834:fadf:603c with SMTP id
 00721157ae682-844e2be8823mr13678227b3.2.1787143074386; Wed, 19 Aug 2026
 05:37:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260816090442.18128-1-laoar.shao@gmail.com> <20260816090442.18128-3-laoar.shao@gmail.com>
 <aoWRDIjvE5jYNR9_@pathway.suse.cz>
In-Reply-To: <aoWRDIjvE5jYNR9_@pathway.suse.cz>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 19 Aug 2026 20:37:17 +0800
X-Gm-Features: AcwNN1VqZboFNFrjM2R0Pddlm6WDzcOualMk0dS5ExCCp3AthxSt0FmTngtnR8Q
Message-ID: <CALOAHbAwO4VCWEhMxkywv9W4wf8CfHJfgtaithBBpoSp5LJDkw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] livepatch: Fix UAF of unregistered patch kobjects
To: Petr Mladek <pmladek@suse.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, 
	joe.lawrence@redhat.com, song@kernel.org, live-patching@vger.kernel.org, 
	sashiko-bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2026 at 7:18=E2=80=AFPM Petr Mladek <pmladek@suse.com> wrot=
e:
>
> On Sun 2026-08-16 17:04:42, Yafang Shao wrote:
> > When klp_enable_patch() fails after klp_init_patch_early() has run,
> > the error path calls klp_free_patch_start() and klp_free_patch_finish()=
.
> > The former drops the references of all object and function kobjects via
> > klp_free_objects(), the latter drops the patch kobject reference and
> > waits for the patch kobject release only:
> >
> >     klp_free_patch_finish():
> >         kobject_put(&patch->kobj);
> >         wait_for_completion(&patch->finish);
> >
> > With CONFIG_DEBUG_KOBJECT_RELEASE enabled, kobject_put() does not
> > release the kobject synchronously but schedules a delayed release with
> > a random delay of up to 4 seconds (see kobject_release() in
> > lib/kobject.c).
>
> Yes.
>
> > Because klp_free_patch_finish() only waits for the
> > patch kobject release, it may return while object and function kobject
> > releases are still pending. The caller can then unload the livepatch
> > module, which frees the klp_object and klp_func structures. The delayed
> > kobject release callbacks later access this freed memory in
> > kobject_cleanup(), resulting in a use-after-free.
> >
> > This issue can occur in two scenarios:
> >
> > 1. The patch kobject was never added to sysfs (e.g., klp_init_patch()
> >    failed at kobject_add()). All child kobjects were only initialized
> >    via kobject_init() but never added to sysfs. They do not hold
> >    references to the patch kobject, so the patch kobject can be
> >    released independently, unblocking patch->finish before the child
> >    releases complete.
> >
> > 2. The patch kobject was added to sysfs, but a subsequent operation
> >    such as klp_add_nops() or klp_init_object() failed. Some child
> >    kobjects were initialized but not yet added to sysfs. These
> >    un-added children do not hold references to the patch kobject
> >    either, so the same race can occur.
>
> In short, this says that the races might happen when some kobjects
> were not added into sysfs. Am I right, please?

right

>
> I agree. My undestading:
>
> The klp_kobj_release_*() callbacks are called by kobject_cleanup()
> which calls kobject_put(parent) as the last step. It should make sure
> that:
>
>   + klp_kobj_release_patch() is scheduled/called only when
>     klp_kobj_release_object() has been called for all patch->objs.
>
>   + klp_kobj_release_object() is scheduled/called only when
>     klp_kobj_release_func() has been called for all obj->funcs.
>
> But it works only when "kobj->parent" is set and
> "parent->kref" has been incremented for each child before.
>
> This is true only when kobject_add() is called for all all used
> kobjects. But it is not guaranteed when any klp_init_*() failed.

correct

>
> > Fix this by tracking all static kobject releases with a per-patch
> > atomic counter (kobj_pending). klp_free_patch_start() counts the
> > patch kobject plus all static object and function kobjects.
> > klp_free_patch_finish() waits until kobj_pending reaches zero,
> > ensuring all kobject releases have completed before the module is
> > unloaded.
>
> I think that we do not need an extra couter. We might use
> the existing kobj->kref. We just need to explicitely
> increment/decrement it.

good idea

>
> I mean something like:
>
> diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
> index 28d15ba58a26..023f666ddcc4 100644
> --- a/kernel/livepatch/core.c
> +++ b/kernel/livepatch/core.c
> @@ -652,6 +652,8 @@ static void klp_kobj_release_object(struct kobject *k=
obj)
>
>         if (obj->dynamic)
>                 klp_free_object_dynamic(obj);
> +       else
> +               kobject_put(&obj->patch.kobj);
>  }

It appears that klp_init_object_early() also initializes non-dynamic
objects, right?
Therefore, we should call kobject_put() unconditionally.

 static void klp_kobj_release_object(struct kobject *kobj)
 {
        struct klp_object *obj;
+       struct klp_patch *patch;

        obj =3D container_of(kobj, struct klp_object, kobj);
+       patch =3D obj->patch;

        if (obj->dynamic)
                klp_free_object_dynamic(obj);
+
+       kobject_put(&patch->kobj);
 }

>
>  static const struct kobj_type klp_ktype_object =3D {
> @@ -668,6 +670,8 @@ static void klp_kobj_release_func(struct kobject *kob=
j)
>
>         if (func->nop)
>                 klp_free_func_nop(func);
> +       else
> +               kobject_put(&func->obj.kobj);
>  }

Similarly, klp_init_func_early() initializes the nop function, so
kobject_put() must be called unconditionally.

 static void klp_kobj_release_func(struct kobject *kobj)
 {
        struct klp_func *func;
+       struct klp_object *obj;

        func =3D container_of(kobj, struct klp_func, kobj);
+       obj =3D func->obj;

        if (func->nop)
                klp_free_func_nop(func);
+
+       kobject_put(&obj->kobj);
 }

>
>  static const struct kobj_type klp_ktype_func =3D {
> @@ -946,6 +950,7 @@ static void klp_init_func_early(struct klp_object *ob=
j,
>                                 struct klp_func *func)
>  {
>         kobject_init(&func->kobj, &klp_ktype_func);
> +       kobject_get(&obj->kobj);
>         list_add_tail(&func->node, &obj->func_list);
>  }
>
> @@ -954,6 +959,7 @@ static void klp_init_object_early(struct klp_patch *p=
atch,
>  {
>         INIT_LIST_HEAD(&obj->func_list);
>         kobject_init(&obj->kobj, &klp_ktype_object);
> +       kobject_get(&patch->kobj);
>         list_add_tail(&obj->node, &patch->obj_list);
>  }
>
> We really would need to add the back references (obj->patch,
> func->obj) because we could not rely on kobj->parent. It is
> set only when kobject_add() was called...
>
> That said, I doubt that livepatching is the only subsystem using
> kobjects in static structures. It might make sense to handle
> this on the kobject API level. I mean to add a kobject() API
> which would just set kobj->parent and increment kobj->kref
> and can't fail. But it seems to be against the existing philosophy
> of the kobject API. So, we might need the workaround after all.

--=20
Regards
Yafang
