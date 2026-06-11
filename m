Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15CE40D56B
	for <live-patching@vger.kernel.org>; Thu, 11 Jun 2026 03:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781147246; cv=pass; b=clGz3CnbUfRXhiKJiMe2l7XpM8CbWgBiYiEQZn0cbq1OZaf4te3QOGOW78g5xGOrio8yrTxcfWurRJH/oamWeK9eubFWxj9UCk/PcyIDYGuxsIv5DZQpGqMN4UmrzJQH8epUDpOxBp5w9HtcPaxDLqr08nrpolPAs4p5b4EN+r4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781147246; c=relaxed/simple;
	bh=TxE9MlGOCWtCIYpgc15HDGxYh0qnQT9Uah7gQaugdH4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lYBFmSLO+pMJ0au5m40qSwYXUmzdezy57jTl7Quwh6gFdcsbtdggnV5MgHXrDAECNI/UbQkGlknCAvgLJB/yQi+8uoyPQsELUpTSbHT7PYYAi7lop8iDmNglakIgtBktR9hv0410XVH3kNCHPtwR0Ox7DTBlaF153uf/5Uz2wUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JKn5Fh0b; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKn5Fh0b"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7dee6b76a73so73890457b3.0
        for <live-patching@vger.kernel.org>; Wed, 10 Jun 2026 20:07:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781147244; cv=none;
        d=google.com; s=arc-20240605;
        b=O0UVGILv0Yyn+Zd9Rtis1Zt5qg7V8xtbmk6GIVmPVoLp4tuumY/6EDx++LimPBxZWz
         iG0NMyhEfBIe2BLJCHdY9cX25/2/NwJnAvjz0/vXqMTZwjo0ExfhSj7G5KsmXhRJT4Ge
         vSKLqvNWQhmvxNN9mzdBjYdRawim5JbrWV+Q/ujGmQrO3kkAmTTXmBLFxs5vTgSpbYLn
         rTDWV+eInCRGZojJOKl0OdaVPhrMiiO/AFtfpfujYPKIXMbducS/XOiHjlVHFOEzmv99
         6yUUjcxCzUS78KnahO37ulFfdPQn1jVmvLRLa1R7u7NEvnJ534oDqnFZZbiPZ7uM23wr
         hzKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qJXZN/rbKmksRclmm2hBgFVvay43+kqHVXX1HZVE4y4=;
        fh=mOtJPPJqgcaJCJbwgse67HgkmXQCkaPkpjWm2KLjNZA=;
        b=kVrRN6dg5qJ9ZJloWk/gWjJSvW0E9WnpD2eIudSiswtYSlSXu8gczOKNKCBJY4IvCX
         119TWv7Xqs7JBTWwZ8329H6Ul3V9ZaLKQSC2df9jqsvD7IaB69zDnRaLSMPksbBKUGoJ
         1PGjbdoCjHUEpLfxCFNgwOMhG6FuICbp01vu6fBXQOOUFys1H7xfSv0DblB3md1PxS3E
         boOiPAIFtaeCSXUaO5Yep+oqA1AevtzQSMOR3S/jsgVndsTz6TkCPQVZFurSRM6bNXMp
         tduD8IdayUMv3YItDDBPVVSaHlGKTJht2Tywt02vKiRgsTPKJ1iZCVO5emIvgqVS0csr
         ftZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781147244; x=1781752044; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qJXZN/rbKmksRclmm2hBgFVvay43+kqHVXX1HZVE4y4=;
        b=JKn5Fh0bHJWpjvyDReVwSmLpWbEjXk4FANW7TlrxSkzOrXqFj6BWWX5YHVVF+Ye7iw
         L70gZTujb7JxWj6YFyuIcNQs5G3D309VPy8vjrQJwl2xk42HkeKk50VXSPuIIbc8rYl2
         bK0CYhAgvTWLIgAY9UrGiHfQM0hZ1ojgbP45wMNpPVpzLAXunGYAcqfBXkrm4Yo2pxar
         pou2TT3QvBw2o/szbwk8t9S9+gioruoZ3sRqq5VPlhtwtYrH8si6uH+BRMnzaDL6rEwS
         cMIYXHa6mWAhBHy7MvNrhZSomr9j2P0fGJD3W+dUSudbZWhBfmGFhYHTkErZzTSWswxv
         So7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781147244; x=1781752044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qJXZN/rbKmksRclmm2hBgFVvay43+kqHVXX1HZVE4y4=;
        b=G84CqI1m2IagKA9BBycDlyDtTIGHQWr3sjqLKKtmeV7xW4HH2MQSglQ3/dnJozxS1a
         9jYU4n4H57j4aZlP98J1fchC1uVdf20pkSHaxbc8PJaz61/nbzMuenOl07w1kJ6CwDIj
         qUWr+Y0fTlAOrRp6V1JN5Pt2DxVOnKOnGD6sWuHyZTol12G00eG23n4aoq21ekhOd/s+
         2Ju6dd5yO38IPbT6y44Me5TSOQE1Tq0EPUKtcEGZIhJeQzCLRyCDQkhYngG38KdQR26F
         ul8IAuQJCN2YacQALmcShyIXjmlZaNdreV4U8eXe8zbSSXuCI6coPBrLTtNBOsHGeFG8
         oMog==
X-Forwarded-Encrypted: i=1; AFNElJ8wcABIKUw3n6c1e5KhCTAqRwTcyQUL6OU15fP7rT0fYpiTgdIXISAwpFpwqRMlWR/k9NbKClxbnmBBsXGG@vger.kernel.org
X-Gm-Message-State: AOJu0Yxotf3bIsKqdjmCtSUDBrbnQqH0FRroOtEMwir/urvskTIXlTxG
	ifmr8yctCREkA0CsQTp3guf3wWg8+trDPMLSp3rAWbsmTarNOHHYZEdZtN1v8u47lLK4q9XmB2L
	kZx8xMomXqMC/QQB4z+ky6YxXujbtz1Y=
X-Gm-Gg: Acq92OGe4u6njoG8X/WRLy06Qk9jC12PPctnhm5+HjZgZ3MS8Hv8YEcY7BOW1oNUz7F
	OOzBa6FciwTuZk7ccmPFc17WVTuHormrqgvlNihdOAxeqozy469FeA+DLuIwT41VQEsOTVjdLUY
	734vYfafnOcexmblggKkPQw3Lw72ZvRUdBCJqY1UHZW1dmkaD+lNCKKdR+rmfSm/2oBvIeU+HYJ
	elee01mkLecqUPIGgpnDFgsQnolzZ07kGuB5qhbsf/naX9LkaHhS1t76rZI0Cp0SulPrhs7Nhqi
	s34JVV8TxR695utpneUCwT/7m+W5l7VQW2hm5owAK/JfPIEfo8C9xBUNKNJ64w==
X-Received: by 2002:a05:690c:4989:b0:7ba:f1a2:a448 with SMTP id
 00721157ae682-7f6558e9b3emr11627607b3.10.1781147243736; Wed, 10 Jun 2026
 20:07:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260607131659.29281-1-laoar.shao@gmail.com> <20260607131659.29281-4-laoar.shao@gmail.com>
 <ail4pUt-t-0AB2wi@pathway.suse.cz>
In-Reply-To: <ail4pUt-t-0AB2wi@pathway.suse.cz>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 11 Jun 2026 11:06:46 +0800
X-Gm-Features: AVVi8CelR6gYPR4SJ-ZBa3qip5ZWdxB7mgwAupjGK7AEV706z_uB8PtN6SH_Yb8
Message-ID: <CALOAHbDmWpHZ8eNCDLV1DZei8KndNu0zT1vuts8muknmXf-KuA@mail.gmail.com>
Subject: Re: code review: was: Re: [PATCH v3 3/7] livepatch: Support scoped
 atomic replace using replace_set
To: Petr Mladek <pmladek@suse.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, 
	joe.lawrence@redhat.com, song@kernel.org, live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 10:46=E2=80=AFPM Petr Mladek <pmladek@suse.com> wro=
te:
>
> On Sun 2026-06-07 21:16:55, Yafang Shao wrote:
> > Convert the replace attribute from a boolean to a u32 to function as a
> > "replace set." A newly loaded livepatch will now atomically replace any
> > existing patch belonging to the same set. There can only ever be one ac=
tive
> > livepatch for a given replace_set number.
> >
> > This change currently supports function replacement only. Livepatches t=
hat
> > belong to different replace sets cannot modify the same function. If a =
new
> > livepatch attempts to modify a function already modified by an older
> > livepatch from a different replace_set, the loading of the new livepatc=
h
> > will be refused.
> >
> > Similarly, for the KLP state, livepatches belonging to different replac=
e
> > sets cannot use the same state ID. The system will refuse to load a new
> > livepatch if it uses a state ID already in use by an older livepatch fr=
om
> > a different replace_set.
> >
> > For the KLP shadow variable mechanism, developers must assign unique sh=
adow
> > IDs to livepatches that belong to different replace sets.
> >
> > Support for replace_set compatibility with KLP state and shadow variabl=
es
> > will be implemented after Petr's KLP state transfer work is completed [=
0].
> >
> > Other user-visible changes include:
> > - The non-replace model is now deprecated
> > - /sys/kernel/livepatch/livepatch_XXX/replace attribute is replaced by
> >   /sys/kernel/livepatch/livepatch_XXX/replace_set
> >
> > --- a/Documentation/ABI/testing/sysfs-kernel-livepatch
> > +++ b/Documentation/ABI/testing/sysfs-kernel-livepatch
> > @@ -47,13 +47,12 @@ Description:
> >               disabled when the feature is used. See
> >               Documentation/livepatch/livepatch.rst for more informatio=
n.
> >
> > -What:                /sys/kernel/livepatch/<patch>/replace
> > +What:                /sys/kernel/livepatch/<patch>/replace_set
> >  Date:                Jun 2024
> >  KernelVersion:       6.11.0
>
> The Date and KernelVersion should be upsated as well.
> It is a new attribute...

Sure

>
> >  Contact:     live-patching@vger.kernel.org
> >  Description:
> > -             An attribute which indicates whether the patch supports
> > -             atomic-replace.
> > +             An attribute to show the replace_set of this livepatch.
> >
> >  What:                /sys/kernel/livepatch/<patch>/stack_order
> >  Date:                Jan 2025
> > diff --git a/Documentation/livepatch/cumulative-patches.rst b/Documenta=
tion/livepatch/cumulative-patches.rst
> > index 1931f318976a..0361adb12f6d 100644
> > --- a/Documentation/livepatch/cumulative-patches.rst
> > +++ b/Documentation/livepatch/cumulative-patches.rst
> > @@ -17,18 +17,20 @@ from all older livepatches and completely replace t=
hem in one transition.
>
> We need to update also the introduction part above. I propose
> the following text:
>
> <proposal>
> Livepatches are used to fix kernel bugs. New fixes need to be added over =
time.
> The fixes might be independent, but they might also depend on each other.=
 This
> brings a challenge of how to keep the livepatched system safe and consist=
ent.
>
> Part of the solution is the "Atomic Replace" feature, which allows the ke=
rnel to
> atomically replace an existing livepatch with another one. These newer
> livepatches are designed as "Cumulative Patches". They include all wanted
> changes from all older livepatches and completely replace them in one
> transition.
>
> The second part of the solution is the newly introduced ``replace_set`` f=
eature,
> which allows the installation of multiple livepatches in parallel. A live=
patch
> will only replace other livepatches that share the same ``replace_set`` n=
umber.
> This might be used to fix independent problems separately, for example, t=
he
> livepatches might be prepared by separate teams focusing on particular
> functionality or a subsystem.
>
> It should be emphasized that the preferred and most secure way is to alwa=
ys use
> the default ``replace_set =3D 0``. In this mode, any livepatch replaces a=
ny other
> livepatch, preventing any unexpected interactions between incompatible
> livepatches.
> </proposal>

I will update it.

>
> >  Usage
> >  -----
>
> I would split the "Usage" section into two new sections, see below.
>
> > -The atomic replace can be enabled by setting "replace" flag in struct =
klp_patch,
> > -for example::
> > +The "replace_set" attribute in ``struct klp_patch`` acts as a **replac=
e_set**,
> > +defining the scope of the replacement. By default, the replace_set is =
0.
> > +
> > +For example::
> >
> >       static struct klp_patch patch =3D {
> >               .mod =3D THIS_MODULE,
> >               .objs =3D objs,
> > -             .replace =3D true,
> > +             .replace_set =3D 0,
> >       };
>
> I would use the above text in a new section called "Replace Set":
>
> <proposal>
> Replace Set
> -----------
>
> The "replace_set" attribute in ``struct klp_patch`` acts as a **replace_s=
et**,
> defining the scope of the replacement. By default, the replace_set is 0.
>
> For example::
>
>         static struct klp_patch patch =3D {
>                 .mod =3D THIS_MODULE,
>                 .objs =3D objs,
>                 .replace_set =3D 0,
>         };
>
> Any ``replace_set`` value might be associated with a set of livepatched s=
ymbols,
> callbacks, shadow variables, and state IDs. By definition, there can only=
 ever
> be one active livepatch for a given ``replace_set`` number.
>
> On the contrary, livepatches with a different ``replace_set`` number must=
 not
> modify the same function, or use the state with the same ID. Any attempt =
to
> load an incompatible livepatch will be rejected by the kernel.
> </proposal>
>
> And the rest would be in a new section called:
>
> Atomic Replace
> --------------
>
> >  All processes are then migrated to use the code only from the new patc=
h.
> > -Once the transition is finished, all older patches are automatically
> > -disabled.
> > +Once the transition is finished, all older patches with the same repla=
ce
> > +set are automatically disabled. Patches with different tags remain act=
ive.
>
> There always could be only one livepatch with the given replace set.
> I would write something like:
>
> <proposal>
> A livepatch with a given ``replace_set`` number is replaced by another
> livepatch using the same number. All processes are migrated to use
> the code only from the new patch. Once the transition is finished,
> the older patch. Patches with different replace sets are not affected
> and remain active.
> </proposal>

I will update it.

>
> >  Ftrace handlers are transparently removed from functions that are no
> >  longer modified by the new cumulative patch.
> > --- a/kernel/livepatch/core.c
> > +++ b/kernel/livepatch/core.c
> > @@ -600,6 +600,8 @@ static int klp_add_nops(struct klp_patch *patch)
> >               klp_for_each_object(old_patch, old_obj) {
> >                       int err;
> >
> > +                     if (patch->replace_set !=3D old_patch->replace_se=
t)
> > +                             continue;
>
> This should be checked on the klp_for_each_patch(old_patch) level.
> The result is the same for each old_obj from the given old_patch...

will update it.

>
> >                       err =3D klp_add_object_nops(patch, old_obj);
> >                       if (err)
> >                               return err;
> > @@ -1174,6 +1176,8 @@ void klp_unpatch_replaced_patches(struct klp_patc=
h *new_patch)
> >               if (old_patch =3D=3D new_patch)
> >                       return;
> >
>
> Nit: Remove the empty line here.
>
> > +             if (old_patch->replace_set !=3D new_patch->replace_set)
> > +                     continue;
>
> Nit: And put it here instead. To separate if/return/continue part from
>      the changes done for the eligible old_patch.

Thanks for the code style improvements.

>
> >               old_patch->enabled =3D false;
> >               klp_unpatch_objects(old_patch);
> >       }
> > diff --git a/kernel/livepatch/state.c b/kernel/livepatch/state.c
> > index 2565d039ade0..a1ac46637336 100644
> > --- a/kernel/livepatch/state.c
> > +++ b/kernel/livepatch/state.c
> > @@ -85,34 +85,65 @@ EXPORT_SYMBOL_GPL(klp_get_prev_state);
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
> > +     if (patch->replace_set =3D=3D old_patch->replace_set) {
> > +             /*
> > +              * If the new livepatch shares a state set with an existi=
ng
> > +              * one, it must maintain compatibility with all states
> > +              * modified by the old patch.
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
> > +      * Two livepatches with a different "replace_set" must _not_ use
> > +      * the same "state->id.
> > +      */
> > +     return !state;
> >  }
> >
> > -/*
> > - * Check that the new livepatch will not break the existing system sta=
tes.
> > - * Cumulative patches must handle all already modified states.
> > - * Non-cumulative patches can touch already modified states.
> > - */
> > +/* Check that the new livepatch will not break the existing system sta=
tes. */
> >  bool klp_is_patch_compatible(struct klp_patch *patch)
> >  {
> > +     struct klp_object *obj, *old_obj;
> >       struct klp_patch *old_patch;
> >       struct klp_state *old_state;
> > +     struct klp_func *func;
> >
> >       klp_for_each_patch(old_patch) {
> >               klp_for_each_state(old_patch, old_state) {
> > -                     if (!klp_is_state_compatible(patch, old_state))
> > +                     if (!klp_is_state_compatible(patch, old_patch, ol=
d_state))
> >                               return false;
> >               }
> > +
> > +             if (old_patch->replace_set =3D=3D patch->replace_set)
> > +                     continue;
> > +
> > +             /*
> > +              * Refuse loading a livepatch which would want to modify =
a
> > +              * function which is already livepatched with the livepat=
ch
> > +              * with another "replace_set".
> > +              */
> > +             klp_for_each_object_static(patch, obj) {
> > +                     klp_for_each_object(old_patch, old_obj) {
> > +                             if (!!obj->name !=3D !!old_obj->name)
> > +                                     continue;
> > +                             if (obj->name && strcmp(obj->name, old_ob=
j->name))
> > +                                     continue;
> > +                             klp_for_each_func_static(obj, func) {
> > +                                     if (klp_find_func(old_obj, func))
> > +                                             return false;
> > +                             }
>
> The combination of for_each_() and for_each_*_static() variants look
> correct but it is a bit scarry.
>
> I think about calling klp_init_patch_early() before
> klp_is_patch_compatible() so that we could use the non-static
> for_each_*() variants even for the new patch. It would make the life
> easier. But I do not have strong opinion about it.

I will think about it.

>
> > +                     }
>
> Anyway, please, put the new check into a separate function, something
> like:
>
> bool klp_has_function_conflict(struct klp_patch *patch,
>                                struct klp_patch *old_patch);

I will update it.

>
>
> > +             }
> >       }
> >
> >       return true;
>
> The rest looks good.

Thanks a lot for the review!

--=20
Regards
Yafang
