Received: from mail-yx2-f42.google.com (mail-yx2-f42.google.com [74.125.224.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C186361947
	for <live-patching@vger.kernel.org>; Mon, 28 Sep 2026 03:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790565033; cv=pass; b=Ihm3p9hU6ZkqlJ0QQ5mahuztR0BTbg98K2AmNsPVZE6LfG3m4wNzbmy7UklryuLku9VzX9FAhcCXgqB52DsnG+xF/tTvsnHSwBCk8Ytw7ol8IYw0L3R87CKamhzJG35mISwuCJNLxWJlpgkk8qSqIod8OuzvM7LHMg0Lwx6zHzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790565033; c=relaxed/simple;
	bh=PSLJ3yppTD6CCL3w3Gsj53GdjvUW3BKvw3OdQHxjAro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bctR4oFq4/jhjUytaVhs6tz4rpOdwt6TK1k4rQVtpOUcERVDARpmVNajBQKOhoi1XLQ3TXAteB0TxPBZ/29T1N6xWxzKDQASwX31daxTw12Ze0JkpL9HjpFQVr+FOv/XIXnd3G32IumMD7mmw6mmd7N48xGGsBzAAY8w29NAH/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QTNocthQ; arc=pass smtp.client-ip=74.125.224.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QTNocthQ"
Received: by mail-yx2-f42.google.com with SMTP id 956f58d0204a3-672f516c271so2130305d50.2
        for <live-patching@vger.kernel.org>; Sun, 27 Sep 2026 20:10:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790565031; cv=none;
        d=google.com; s=arc-20260327;
        b=Qe4qFDGKxxDg7JYpTAekDiiK4vWCbtBm421g275ZYrClN9AFuIo5RHY/tw0qRnQkPO
         SELjeiDQq6IBn+c7uo47LL8PyQnn2ueQwPijf1JKyT9ISHPq1m6wUtKdnGsAosuSlDX+
         VprMr9bFHoOG1DvkOB29ohSMRPrl+v6G3kH6tE7YWbmh1h1aF7gQsSuJI8q40ZL4kpvC
         8CToKV31ZQw9qpL0F4aK3B9UoCAtjOEOLjgfBo9vpYv2o0vNPf9YSWJ+KJDxj5RRIcIv
         rA+KEItO3Mkg+0ZDQ1UhMqMtWt1k/YLtwtbjA1CWil/B/WGJbLZGjWHwY4e4265ubzEd
         GbZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LammAbbzP5D37TDtaIsTYV9EHyAPHDH/udjYbq0/Fd8=;
        fh=jaAPUAQXYVrlqpbqFG+Tvr1LeF+bvELOdcNS0fSq1HY=;
        b=fBU27lrV4p7ZcyLZZEUwa0aZz+WK+CnLJrXy2N6PxAZGSkHXkd8ucwnyceOFZR3JNF
         PS2tQJbea6DBz4UrZVlzbDiM0tHofS0i+DHS9tyOw14cDYCt/gRFOP/JvVd5TfkJ0rnP
         /Gz2q0iPIItc3uGUre3tOXetGmf6pbkAnfMYAmeycz+jsrDQ4MbggSeAJfmzFclB2KK0
         k1Jozy+mIulUi1lGxbp01rr1wja+4+Nz39gwlyLvIH2MIk5+GQ1JODHN9YSuX2SX9RII
         6NlJdldjWYqkBuVouhIkh1hrZi+NHk/8LBfh7+JhRB2/LNLv3aivVXpwFCorArjSf8Go
         yHuQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790565031; x=1791169831; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LammAbbzP5D37TDtaIsTYV9EHyAPHDH/udjYbq0/Fd8=;
        b=QTNocthQbGTtcDgVmjTqNn8cjUq82WAxRIWwU4Q+c4T2l4T80di14YUIo0bZvBiH/y
         HUmJIw95U8BAquo6Sclnu3OjnxQZJiA6IjKls6tiWHZLXQUFccW6RzC+iYUeT+3MfdRs
         5StrTsfSJidmTkxzvrxIasSESxkNXHOdyfvJtSyycFoJYNqmAO2J4czVd7xIvz+8TZqE
         EwCK6eLuzydf/4P0HSkRLPTr6jJND9nlI0BRO86+XsdJsc2USjLzJXOIsYd4fQ7T2MtJ
         vHfyjYkGr+oOUkZ20Dk6hEtSCI9xVMhuzvTSwh2sztwTzZLXvRJuhLte8jd+vp3nZmG3
         vuWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790565031; x=1791169831;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LammAbbzP5D37TDtaIsTYV9EHyAPHDH/udjYbq0/Fd8=;
        b=Uf+kpDGWcQM3gHhCmAHx+ydB5hMD08pVHAENmFWQZLeRPwQY5G9BteTMxgdm/mHtCx
         r0OT0aAPZD6pXq2tYh/oPUiRRQyKOkKULZC0wBbMf2LEADlWn+fyur6YjBCXqZfE/4yn
         6Jcy663hxcnafp+dBTdQRJtX8NUQEoICE9LgtkcDFmYSuSNQbWXp2WzcDUm4AkNTd+y6
         NBKYji11QizOTXhAFZ5p8WuoJqbHT+cKwA9z1x36CHhQ7VbL279i8ieAHtD8WtFFiwXr
         1ZKMkVzx+f1jQrt+UhOHMqM+5CWJunGDbBHdeXsYWv+9ThjJcPVV2lq2XLrMLLPdVUA+
         CXfQ==
X-Forwarded-Encrypted: i=1; AKwUvBx3VdFwfLDWHmFmGbDdFmsC86cHn7mTvwmOcZwA98FNrxjc3oD1vkXjIJzHGG916EZHhz+PCSQFNmg5MAXx@vger.kernel.org
X-Gm-Message-State: AFuF++lgVJQGboJvjXKqb3os+dO44eMZRMfvto+gMfWXma2ru0BmSSvE
	i7rDkFgDvsLRXoXbsgUs9Cm1yc3I2AggjqN1u+0rSZcv+SEO9aw5pl8QW1rOTTcT9YoKmx0lXBs
	eMBFz9W6EoCo1W+en5HdlOqPAsqeuPaY=
X-Gm-Gg: AYBFou3sQs7KiKFoI0TTBTpJP4t9n5Wohj1VqMW812EeCg96V0MDGSohuNIkhCsOLJE
	KcWBIbpUKWyBTnJwwwibZVcQeo4R1gm5uZemOKd6ggixJKQC1xWmc57uwWgiU+tnnHem+jS6YCZ
	Z4wIQWQnBOCBCsM8QCWqY21W1+TnxQ/pEmz0aRTb/vheYNflb0TKHp2roxj0dube6bgX66ZS3Zi
	lb+gIooMzb+9PAWssktZVpX+f0z0qIIcogQEFfDdb/EMk/CSIQpLM5c02lQR+BPxHnuqROAmayH
	9PPd/GPO9VYpYFdFOXJuOdZ8X3xsfpGAeIBu2H7sC22g/zUJfqJdWLvsoiLhJd9yazVNhUwV6H4
	OILBD2wv0cA==
X-Received: by 2002:a05:690e:d07:b0:672:964b:f071 with SMTP id
 956f58d0204a3-672ed568fe0mr5465792d50.94.1790565030841; Sun, 27 Sep 2026
 20:10:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260913024228.72317-1-laoar.shao@gmail.com> <20260913024228.72317-6-laoar.shao@gmail.com>
 <179033754033.68715.11352947492609559639.b4-review@b4>
In-Reply-To: <179033754033.68715.11352947492609559639.b4-review@b4>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Mon, 28 Sep 2026 11:09:51 +0800
X-Gm-Features: AclHuK_SUira0ARz3sQAhG1y2_GfZsWDZYCgJ2SMa3Zg0ZCI4-UziEMqNcuEea8
Message-ID: <CALOAHbAnQ-g_NSEWWj5dzpJsMuxibQ3ROqkrR1FeX1aPd=xEcw@mail.gmail.com>
Subject: Re: [PATCH v9 5/9] livepatch: Implement provides and obsoletes for
 scoped atomic replace
To: Miroslav Benes <mbenes@suse.cz>
Cc: jpoimboe@kernel.org, jikos@kernel.org, pmladek@suse.com, 
	joe.lawrence@redhat.com, song@kernel.org, live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 7:59=E2=80=AFPM Miroslav Benes <mbenes@suse.cz> wro=
te:
>

[...]

> >  {
> > @@ -618,6 +673,9 @@ static int klp_add_nops(struct klp_patch *patch)
> >       struct klp_object *old_obj;
> >
> >       klp_for_each_patch(old_patch) {
> > +             if (!klp_patch_replaces(patch, old_patch))
> > +                     continue;
> > +
> >               klp_for_each_object(old_patch, old_obj) {
> >                       int err;
>
> The comment before klp_add_nops() function would deserve an update as
> well.

I will update it.

>
> >
> > @@ -799,6 +857,8 @@ void klp_free_replaced_patches_async(struct klp_pat=
ch *new_patch)
> >       klp_for_each_patch_safe(old_patch, tmp_patch) {
> >               if (old_patch =3D=3D new_patch)
> >                       return;
> > +             if (!klp_patch_replaces(new_patch, old_patch))
> > +                     continue;
> >               klp_free_patch_async(old_patch);
> >       }
> >  }
> > @@ -995,11 +1055,9 @@ static int klp_init_patch(struct klp_patch *patch=
)
> >       if (ret)
> >               return ret;
> >
> > -     if (patch->replace) {
> > -             ret =3D klp_add_nops(patch);
> > -             if (ret)
> > -                     return ret;
> > -     }
> > +     ret =3D klp_add_nops(patch);
> > +     if (ret)
> > +             return ret;
> >
> >       klp_for_each_object(patch, obj) {
> >               ret =3D klp_init_object(patch, obj);
> > @@ -1214,6 +1272,8 @@ void klp_unpatch_replaced_patches(struct klp_patc=
h *new_patch)
> >       klp_for_each_patch(old_patch) {
> >               if (old_patch =3D=3D new_patch)
> >                       return;
> > +             if (!klp_patch_replaces(new_patch, old_patch))
> > +                     continue;
>
> And perhaps here as well.

Sure.

>
> >
> >               old_patch->enabled =3D false;
> >               klp_unpatch_objects(old_patch);
> > diff --git a/kernel/livepatch/core.h b/kernel/livepatch/core.h
> > index 361a0917a03f..b03cfc58b660 100644
> > --- a/kernel/livepatch/core.h
> > +++ b/kernel/livepatch/core.h
> > @@ -18,6 +18,7 @@ void klp_free_replaced_patches_async(struct klp_patch=
 *new_patch);
> >  void klp_unpatch_replaced_patches(struct klp_patch *new_patch);
> >  void klp_discard_nops(struct klp_patch *new_patch);
> >  struct klp_func *klp_find_func(struct klp_object *obj, struct klp_func=
 *func);
> > +bool klp_patch_replaces(struct klp_patch *new_patch, struct klp_patch =
*old_patch);
> >
> >  static inline bool klp_is_object_loaded(struct klp_object *obj)
> >  {
> > diff --git a/kernel/livepatch/state.c b/kernel/livepatch/state.c
> > index 2565d039ade0..3b262df48c35 100644
> > --- a/kernel/livepatch/state.c
> > +++ b/kernel/livepatch/state.c
> > @@ -85,24 +85,63 @@ EXPORT_SYMBOL_GPL(klp_get_prev_state);
> >
> >  /* Check if the patch is able to deal with the existing system state. =
*/
> >  static bool klp_is_state_compatible(struct klp_patch *patch,
> > +                                 struct klp_patch *old_patch,
> >                                   struct klp_state *old_state)
> >  {
> >       struct klp_state *state;
> >
> >       state =3D klp_get_state(patch, old_state->id);
> > +     if (klp_patch_replaces(patch, old_patch)) {
> > +             /*
> > +              * If the new livepatch will replace the old one, it must
> > +              * handle all already modified states (cumulative patch).
> > +              */
> > +             if (!state)
> > +                     return false;
> > +             return state->version >=3D old_state->version;
> >
> > -     /* A cumulative livepatch must handle all already modified states=
. */
> > -     if (!state)
> > -             return !patch->replace;
> > +     }
> >
> > -     return state->version >=3D old_state->version;
> > +     /*
> > +      * Two livepatches with a different "provides" must _not_ use
> > +      * the same "state->id".
> > +      */
> > +     return !state;
> >  }
> >
> >  /*
> > - * Check that the new livepatch will not break the existing system sta=
tes.
> > - * Cumulative patches must handle all already modified states.
> > - * Non-cumulative patches can touch already modified states.
> > + * Refuse loading a livepatch which would want to modify a function
> > + * which is already livepatched by a patch that will not be replaced.
> > + * A patch is replaced if it has the same provides id or if its
> > + * provides id is in the new patch's obsoletes list or if the new patc=
h's
> > + * provides id is in the old patch's obsoletes list.
> >   */
> > +static bool klp_has_function_conflict(struct klp_patch *patch,
> > +                                   struct klp_patch *old_patch)
> > +{
> > +     struct klp_object *obj, *old_obj;
> > +     struct klp_func *func;
> > +
> > +     if (klp_patch_replaces(patch, old_patch))
> > +             return false;
> > +
> > +     klp_for_each_object(patch, obj) {
> > +             klp_for_each_object(old_patch, old_obj) {
> > +                     if (!!obj->name !=3D !!old_obj->name)
> > +                             continue;
> > +                     if (obj->name && strcmp(obj->name, old_obj->name)=
)
> > +                             continue;
> > +
> > +                     klp_for_each_func(obj, func) {
> > +                             if (klp_find_func(old_obj, func))
> > +                                     return true;
> > +                     }
> > +             }
> > +     }
> > +     return false;
> > +}
> > +
> > +/* Check that the new livepatch will not break the existing system sta=
tes. */
> >  bool klp_is_patch_compatible(struct klp_patch *patch)
> >  {
> >       struct klp_patch *old_patch;
> > @@ -110,9 +149,12 @@ bool klp_is_patch_compatible(struct klp_patch *pat=
ch)
> >
> >       klp_for_each_patch(old_patch) {
> >               klp_for_each_state(old_patch, old_state) {
> > -                     if (!klp_is_state_compatible(patch, old_state))
> > +                     if (!klp_is_state_compatible(patch, old_patch, ol=
d_state))
> >                               return false;
> >               }
> > +
> > +             if (klp_has_function_conflict(patch, old_patch))
> > +                     return false;
> >       }
> >
> >       return true;
> > diff --git a/kernel/livepatch/transition.c b/kernel/livepatch/transitio=
n.c
> > index 2351a19ac2a9..ef70ff582da1 100644
> > --- a/kernel/livepatch/transition.c
> > +++ b/kernel/livepatch/transition.c
> > @@ -89,7 +89,7 @@ static void klp_complete_transition(void)
> >                klp_transition_patch->mod->name,
> >                klp_target_state =3D=3D KLP_TRANSITION_PATCHED ? "patchi=
ng" : "unpatching");
> >
> > -     if (klp_transition_patch->replace && klp_target_state =3D=3D KLP_=
TRANSITION_PATCHED) {
> > +     if (klp_target_state =3D=3D KLP_TRANSITION_PATCHED) {
> >               klp_unpatch_replaced_patches(klp_transition_patch);
> >               klp_discard_nops(klp_transition_patch);
> >       }
> > @@ -496,10 +496,10 @@ void klp_try_complete_transition(void)
> >        * klp_complete_transition() but it is called also
> >        * from klp_cancel_transition().
> >        */
> > -     if (!patch->enabled)
> > -             klp_free_patch_async(patch);
> > -     else if (patch->replace)
> > +     if (patch->enabled)
> >               klp_free_replaced_patches_async(patch);
> > +     else
> > +             klp_free_patch_async(patch);
> >  }
>
> A total nit but just s/else if/else/ would also be fine here, no?

In v7, Petr suggested inverting the logic instead to improve readability [0=
].

[0]. https://lore.kernel.org/all/apfSMN5a9PTxTTsW@pathway.suse.cz/

>
> >
> >  /*
> > @@ -720,11 +720,12 @@ void klp_force_transition(void)
> >               klp_update_patch_state(idle_task(cpu));
> >
> >       /* Set forced flag for patches being removed. */
> > -     if (klp_target_state =3D=3D KLP_TRANSITION_UNPATCHED)
> > +     if (klp_target_state =3D=3D KLP_TRANSITION_UNPATCHED) {
> >               klp_transition_patch->forced =3D true;
> > -     else if (klp_transition_patch->replace) {
> > +     } else {
> >               klp_for_each_patch(patch) {
> > -                     if (patch !=3D klp_transition_patch)
> > +                     if (patch !=3D klp_transition_patch &&
> > +                         klp_patch_replaces(klp_transition_patch, patc=
h))
> >                               patch->forced =3D true;
> >               }
> >       }
>
> This is probably fine but I still have an awkward feeling about it.
>
> The rest of the patch looks ok to me.

Thanks a lot for the review.

--=20
Regards
Yafang
