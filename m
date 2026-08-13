Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177712749DC
	for <live-patching@vger.kernel.org>; Thu, 13 Aug 2026 03:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786593524; cv=pass; b=rEVZRQw5BSPcOmNShUQbCEgesHTNq5oOw6nNc9FxAineO0a3WLSgLkiKnaeCp6p0IP4DnjBK6LFPHEjdeVRT46LjGU93gce1XZMdArq26CqpcFHwt4fqimLNIhj//MT4qp7VwnAj+tIQ/gNFFCCMb4jJgld0cECPGEPHpK6KqEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786593524; c=relaxed/simple;
	bh=sq+W5BI112adXKFE8UlROpt4/+kIDwenyAibUSeEa7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JKlag5g5kdcJ20pA/JkmC/B3C5WM/hpdoGoQj45PeVFtaqJmvgZ67WdES0PwtK3nw2xB6gHoH5cLvhUp2fHY/8F6SpTDov6wVYoqpzcTQAJq13PXW3WFZ5a68ik0J7IzHozQCAN8gMqmg2baDJx7b+qwFMLWPQYQlbscJLduRb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PMxaNdxx; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PMxaNdxx"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-80c5cb9a888so18641627b3.3
        for <live-patching@vger.kernel.org>; Wed, 12 Aug 2026 20:58:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786593522; cv=none;
        d=google.com; s=arc-20260327;
        b=aupQ7ki+BVbqfTQ8zOSMFDN5JrTo6X9fDk9TyusFSxfvwcDU+oJ81HfE+QRNV+9MFA
         aKUzkXDec51esBTKA/WZeJM3Klx6gl8CBQwfr2K/DSV21Dq3S82KHEe6yw9dlEEI9Qss
         2x+RsPTlplsHMNq9BXcXpw6AyuzodIPJttt5RllHNYChsa2wrbsaXZJvjXUQhk+nKuOM
         OpZKjQKj3SLzx77KhZjOpvUhjWl2eqFP/XbEEr0gfAmALlSQ9qmeA64OolIgvNllXW8D
         HB2NKzmi1XVUuwRwnmPN2uhWQ9XTbJ7RWGbksnqiaWi1OZ6+U7ILIgQmSDT+eC2LXqp+
         74Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IXgqwLmrRycVe6Jgbf2eYsL3a6mEgCeWhuuMuTwa43Q=;
        fh=OXEJ05mZBHIRzYXbw0TbPwMC6DDFFj1UkAxWVTLDgNg=;
        b=GNe5frq2KxmiOvEElf0YsMx6pkTaLHwcT0BQSDooLzGaUO4D4vq02AXQDWCu4UNspm
         Glgt8b1Vh1mLJuBGLrE0OZkMaoZ7UDfudXk71rHB+af7Ttj71J8mlVqr+5i0RtBZ8KnN
         cvlM+y+MoexECYJn58Y34NH3VU2viMR8ypwe+TtePBVTD7OMeRc24n/ihab/4NKi7e5M
         RdJEEN+RUB7TI0qdJI3GvAai7viEPDI/yhYmPVAmDYKrZn1iK3Omtfgo9C9jxpQhN6Zg
         tsMnIk/frD1ZwsHLmZgunkmmuiqN8PnbRL/3RbrEDEjoBVCUYkKJwhRb+fsZ9wUe1Pcm
         HnOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786593522; x=1787198322; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IXgqwLmrRycVe6Jgbf2eYsL3a6mEgCeWhuuMuTwa43Q=;
        b=PMxaNdxxObFyL7nQKle+HcKwnguM/ECN7rVIXbs2TjSNNxjovgVSCObobrjw6emD3E
         dzrMIMVm5S8TQnxxkDG7MqTlGfEjRT7BihfKHK7mIQokoHEoVkbZ3V+NPjbkx4tF1V1b
         f8qJsHQW7qNa+ktrd5OGI40nR1TZYrwNWQ7ujyaOgiMkP39xgOpY/8MxsfRys/Ok2Ukg
         YLqpBMEiXAMvqvIq5RY9Rl7i/E7bPaLnYxIK0kdhW6DtdM11UzlI6xgQi+HRepilGs9Z
         2LM9ajeCoamEoyTh4rpjUZDssbwP5X0/9L3ryMume81t6aRCf15Q2ZYfToQciBcFYTeI
         OCkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786593522; x=1787198322;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IXgqwLmrRycVe6Jgbf2eYsL3a6mEgCeWhuuMuTwa43Q=;
        b=BoQcbwIXtIRzTVAk9Js2HtTayK1TKVKr1Ega1YzWBqnyx/DmuO+PPPVybe1HVGPzNQ
         ZjBbRU1cc9LYFvixxcwpxvBAznm+uAGh4zXH1FgsyRNXpFTlZ/5aBjQjNkNE5ss7oAaq
         ufoCoTiMaMhmo7ztX7+J50H7ua/7wey60abF7qL1ZfmMg5U6e5KoUk5UWDPg41uAJvbh
         BA9wTENAqVhAaO9AzacemThNjSmc6sUHbPFMI8ojDbNPR0M7JbPCGb/yUkpu5sJz6hsZ
         IgUsv09hwdAnN4/lfEeJcP4VxNsdHM8rMJmWcI9QsGoIqWVqf+5H/nwTIjD2kxsXbm3E
         cCLA==
X-Forwarded-Encrypted: i=1; AHgh+Ro9jwMTTcFNV1pZYltLXbiXqtpL107cs3erm+en/ajtFNYeGOmWYkxwalrUi9HPXFxDx/twNy2rG49+ywSJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhx78aw5Y5Ju8OHBRZz4PfrqW/pBlGHt9lraZFFENlJ8VoPAc4
	VvCDWyX9atvKKO6k1LBH5Gwd4wMAeeu9Inad/bcMoq3P8Dx1JBIvdg3yFVkpC9rNXywwDTGIFoP
	Nmw3hgvz7BVUz4iF/+D5yfWGM+zkzw4s=
X-Gm-Gg: AR+sD12FlV/B+SW+A5D+LXA/3ZRZEtG/ftDZ9tVvxqOBMIJmwWfwZjlZb+l5+RQSYR9
	3BCVAcBp9D5JnRIB+/o+WIE4//6G72PO1d2XlqKc9McxSrVOOwHjMxno+X0qnZcLRqQZAkZBo5w
	Ty+jX1keOIpysG+yGAz0ZEgKb4nlGpg47FqLoEXT3ijW4dfDqyrB9pqCzVsxC3ALYMaSYh+uh34
	8PpPVv6QRwwQc5w0VwcsePQTzpEmgrRXpMX5d4DZ2RnjZQBPyhSGmIDMkPtW2iCed0F6BfHtuC3
	hA+enVTQ8nWLJWEOaqgHLdEQ+98vzVzdFeNsTY2NyhfvqRHeom5H6OMprsccshH5/U7EHCPg0tc
	qRQ==
X-Received: by 2002:a05:690c:12:b0:820:a55:3ca3 with SMTP id
 00721157ae682-83476ef4715mr12735707b3.33.1786593521873; Wed, 12 Aug 2026
 20:58:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813030408.9761-1-laoar.shao@gmail.com> <20260813030408.9761-3-laoar.shao@gmail.com>
 <20260813031611.A4EAD1F000E9@smtp.kernel.org>
In-Reply-To: <20260813031611.A4EAD1F000E9@smtp.kernel.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 13 Aug 2026 11:58:06 +0800
X-Gm-Features: AUfX_mxjwMtfVSIIOYiDzXqChSPXVXfq6yEZZda0dfVJvd-yBFpxVxLTadP0QtA
Message-ID: <CALOAHbAEc_hKR6Fz4JkVyZkhjHepBe_s_mpTe3Q8sa0V9oH2Lw@mail.gmail.com>
Subject: Re: [PATCH 2/2] livepatch: Fix UAF of unregistered patch kobjects
To: sashiko-reviews@lists.linux.dev
Cc: joe.lawrence@redhat.com, jpoimboe@kernel.org, mbenes@suse.cz, 
	jikos@kernel.org, pmladek@suse.com, song@kernel.org, 
	live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 11:16=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
>
> New issues:
> - [Critical] The newly added release signaling logic introduces a direct =
Use-After-Free when processing dynamically allocated objects and NOP functi=
ons in the kobject release paths.
>
> Pre-existing issues:
> - [High] The patch fails to fully resolve the original delayed kobject re=
lease Use-After-Free if partial initialization fails after the patch kobjec=
t has been added, leaving child kobjects un-added.
> --
>
> --- Patch [2]: [PATCH 2/2] livepatch: Fix UAF of unregistered patch kobje=
cts ---
> commit ac38837d810b471eed544191021bf254f8b9e585
> Author: Yafang Shao <laoar.shao@gmail.com>
>
> livepatch: Fix UAF of unregistered patch kobjects
>
> When klp_enable_patch() fails after klp_init_patch_early() has run,
> delayed kobject releases can cause use-after-free bugs when the module
> is unloaded. This patch tracks pending kobject releases and waits for
> them before completion.
>
> Link: https://lore.kernel.org/all/20260809094046.50ED31F000E9@smtp.kernel=
.org/
>
> > diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
> > index 28d15ba58a26d..e07b026feeb99 100644
> > --- a/kernel/livepatch/core.c
> > +++ b/kernel/livepatch/core.c
>
> [ ... ]
>
> > @@ -652,6 +653,14 @@ static void klp_kobj_release_object(struct kobject=
 *kobj)
> >
> >       if (obj->dynamic)
> >               klp_free_object_dynamic(obj);
> > +
> > +     /*
> > +      * The object kobject was initialized but never added to sysfs.
> > +      * Signal the release to the owning patch.
> > +      */
> > +     if (!obj->patch->kobj_added &&
> > +         atomic_dec_and_test(&obj->patch->kobj_pending))
> > +             complete(&obj->patch->finish);
> >  }
>
> [Severity: Critical]
> Does this dereference the freed obj pointer?
>
> If obj->dynamic is true, klp_free_object_dynamic(obj) is called, which
> frees the object structure. Immediately after this intentional free, the
> newly added logic dereferences the freed pointer by evaluating
> !obj->patch->kobj_added.

makes sense.
It seems we only fix it for the !obj->dynamic case.

>
> > @@ -668,6 +677,13 @@ static void klp_kobj_release_func(struct kobject *=
kobj)
> >
> >       if (func->nop)
> >               klp_free_func_nop(func);
> > +     /*
> > +      * The function kobject was initialized but never added to sysfs.
> > +      * Signal the release to the owning patch.
> > +      */
> > +     if (!func->obj->patch->kobj_added &&
> > +         atomic_dec_and_test(&func->obj->patch->kobj_pending))
> > +             complete(&func->obj->patch->finish);
> >  }
>
> [Severity: Critical]
> Similarly here, does this access func after it has been freed?
>
> If func->nop is true, klp_free_func_nop(func) frees the function,
> but the new check immediately dereferences func->obj->patch->kobj_added.
>

makes sense.
We only need to fix it for the !func->nop case.

> [ ... ]
>
> > @@ -737,9 +753,29 @@ static void klp_free_objects_dynamic(struct klp_pa=
tch *patch)
> >   */
> >  static void klp_free_patch_start(struct klp_patch *patch)
> >  {
> > +     struct klp_object *obj;
> > +     struct klp_func *func;
> > +
> >       if (!list_empty(&patch->list))
> >               list_del(&patch->list);
> >
> > +     if (!patch->kobj_added) {
>
> [Severity: High]
> This is a pre-existing issue, but does this check leave child kobjects
> unprotected if partial initialization fails after the patch kobject has
> been added?
>
> If klp_init_patch() successfully adds the patch kobject, it sets
> patch->kobj_added =3D true. If a subsequent operation like klp_add_nops()
> or klp_init_object() fails, klp_free_patch_start() is called on the
> error path.
>
> Because patch->kobj_added is true, this check is bypassed and
> patch->kobj_pending tracking is not initialized. However, child kobjects
> that were initialized early but not yet added to sysfs do not hold a
> reference to patch->kobj. Thus, patch->kobj will be released
> independently, unblocking patch->finish, and allowing the livepatch
> module to be unloaded while un-added child kobjects may still trigger
> their delayed releases and access freed module memory.

Right.
The kobj_added flag is insufficient because it doesn't account
for partial initialization failures where the patch kobject was added
to sysfs but some child kobjects were not. Removing kobj_added and
always counting all static kobjects in kobj_pending handles both the
fully-unadded and partially-added cases uniformly.

--=20
Regards
Yafang
