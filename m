Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A16A2248A5
	for <live-patching@vger.kernel.org>; Sun,  6 Sep 2026 02:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788663526; cv=pass; b=j0rEDEAv5hrEKnhO7ev70pHIKRKcCuSse6wuxCgSm+h71PqCDJ/WI0y6hfedmctr78ZvoFNmlpf2DSZDxqeKKG8J1T0mlPkQvrkFrxdBdloImQ4U3kgGtKQhffQXA3mcZfAbbxJwHF1Ozwv4hp1raz8PRxV8kytfzXpQUBs9Ucs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788663526; c=relaxed/simple;
	bh=dSpGuVsZj0gh+C+US0OCeXFiKeQE+2VK6Is/As6Gugc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HO1tMO1OZIb/5kV7Jb7pbRrntSqhroeIKiKcjyI7Dzz2lFEu1d9WG6uZbm5iZuQxiqvnB0nIMLjhmyZZiKtKXmNqA8baigrOx8vhYQujppe0h0dvoizcLSDtszMOTwFhM+SoRD/CUTEcgKdk69SBidnq5pNBvyM9yOT5vuloHbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LUcWjRmV; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LUcWjRmV"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-861feb6d61bso22941807b3.2
        for <live-patching@vger.kernel.org>; Sat, 05 Sep 2026 19:58:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788663524; cv=none;
        d=google.com; s=arc-20260327;
        b=dntZeHy0DiYVUMcPzUGqpouQ2JHFluLREBvCXipRw49W78PF7mcBpx3cGLQ9uWRRWq
         6OuqPaulJm+3GRdkz7y+rO7kpgNpoORzHxO7tjIov6mlqr+gltDBpronw1wbcAEDOeby
         7J4AGpiJIGWq7eoE2H5gaH9V0lqtcHFj883Q8pfcGgWQoGniAGtg/ExugiHvPw5iL9QF
         PFEe+JyIuQUWUwbdPtgMt/iBhit+DXUBdQxnuwRKDXXCrVZSZD4X8tLZ9Li8saTEkdMd
         +p2+nIRxFA7v54Ar7pj9l3C1brWViUNINgea8ML5NPNu59bAdjUYfTcWhtWNQG+k76TZ
         Vlfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=N5CuI1C3rpit1C3XFVw0WNU4TDuQ0C6n4PNOJ0mrhe8=;
        fh=cVdFUX1V7bWyLlVEIRZXLNZkwjM6GajZhx8pNpjqsA4=;
        b=EaE3S+gYrsujSAjL0qShZZzwilrSiv7Yxu/XBzpXi9iVTln2cJaXp36/1SvkOpWRUM
         wXAiOivESI72nYjHTxOrjLTiQbABcSONlow5Z9dMG45c+Ss0r1jy9PIzJhxUCri+lA/1
         1qYo3U2Khm6XaJqBcr5FbEyCbfJkuAEKATQ+33hvomBzgp716ka8wgCi50mAsiaU6XAV
         oqXl1vRmZPPQ8E5yVeaK+lbKnpRh5Hv02N43XNHzY2uD2RIOWJDTMzpNWaZOosMj/Vml
         Itq69MIWLs2SER3S/UlOViTOrhKnHcZslQRZqG+uQCR6+QRQfc3mFm8Gths4CgETthMC
         MQkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788663524; x=1789268324; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=N5CuI1C3rpit1C3XFVw0WNU4TDuQ0C6n4PNOJ0mrhe8=;
        b=LUcWjRmVoRtVdRH7JzVw8mL7Y+iRsfJ7zZ10C4AkxKuKZIf41dBhGCDTXGZ+u1ryE1
         9XTP/aOIOIRZ2xn1gOCBhK7Mse13hxnUdCsdt03WHh9swWFjSM28+EhkQeV8uIv0OAVw
         bi0N6v04CVapd6qhAheutqJM0BuoQiDLRn/JBlU5yUVAjLc+EaGtwEuixAMpYZ/3iJhq
         QkDrnYsLOHPZ+SeTszxYRtwWluejUAbxoH07J2mspEf98kDszhkfn7EQsNXVoXhuxJUh
         M972OWRBp+OMyXeJ3Pou1/TaUt+wEwvaFRh99oP/mzkmQ68UTnjFkRV8uOBayCL4g6y3
         jQvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788663524; x=1789268324;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N5CuI1C3rpit1C3XFVw0WNU4TDuQ0C6n4PNOJ0mrhe8=;
        b=OLaPE6/V6bAoST2mOzV0MXGlqZLymQ20uIb5HUirswF5JiTpBoak6B2vsFwbfjnRBm
         pJq5R/89VDMKP3CPgl56MQnUcRbEK9SeRqBu41cgBbg2Qdf6eYbfuJPVrjPHxkN1pNLC
         PN5E6quxED1G3nfL6NkRKudQag9vRrKjnoQWMrpAciNg0QtwmQrpHjkCdniBFpvNACRB
         FPx8EPPut1/i9jXfk/ccXF6T/eVXynY+Bcti+ONruYL82Swkz/+Pky6fduih7P/d44Pn
         1UNKM8pQjKsGwRFKjfeaybQ1jhzNC1qNOJntUe4HSJ/KklN1W5r2yqF71aatALxl84bN
         26uA==
X-Forwarded-Encrypted: i=1; AKwUvBz/ISmP5L+ZPK5aoalPR0ux9Jywe8/G3yKAiWU8OcLMn/SNPr348Qf2bwpN3YZQwy0gHUCXEUoJlmIHFzPY@vger.kernel.org
X-Gm-Message-State: AFuF++nUsxSBjrqUE6gXFhCmTFwnHrrZ6/3a1ZrIZhRfk/lQy+chpVB3
	bSk+/LU7JhoNpuiI4CFh3vpp8LR3n348mPrkAjwOgOU/yjdR2fCj5oquMBuTLZK4YR3Ub1WE24h
	lvn/ot5jlg+PzBup9TPU7A9BvAWJ+5e0=
X-Gm-Gg: AYBFou06bYPEeTElAhR1TfN5XmYhs5R920wPqRftWWYqJ2CKJVyakFGHmAVgaLfCACz
	0pUSKaCTzT5GhOKUNy5AnDhGahEv2pk0b3ey7It+unlN7LxPoTj9iZBxKQyEcFvKCh+zDKj/hXG
	dNFrtl9aY9pa8uAOuu3zQQreczrULxP5ZAci60JmYVtXm16UwKx0NffDaKkowmBudYdMf9+4sjn
	y/OxfbhnNYPu6592SUN0SYYZz3fiCUI2HjtP6APUPIB+KWc3QkDobPmZ7eRm+nMNMPVdrhJmDc7
	UZ3ZKxnGTQ0CTFqj7t3jRirgD/kpiTnslDOCDHuOf9nLn/rW6YS7GA5gBlgMqJZ6VBcVir+E0kC
	k1A==
X-Received: by 2002:a05:690c:f02:b0:7e8:a091:6c4b with SMTP id
 00721157ae682-8712a70a29emr68028067b3.24.1788663524153; Sat, 05 Sep 2026
 19:58:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825114641.80452-1-laoar.shao@gmail.com> <20260825114641.80452-4-laoar.shao@gmail.com>
 <apfQ6c_3giN615Ll@pathway.suse.cz> <CALOAHbAb3Hiv5HZ0b0r_GjqCpZRx53Yq-NJo=eo7PxE_tD9asQ@mail.gmail.com>
 <CALOAHbDVSD=sNb86VdtOG_KY3VL6Vz5EP+aO7GmY-TrkogOJXA@mail.gmail.com> <aplFds1grx-d5y-m@pathway.suse.cz>
In-Reply-To: <aplFds1grx-d5y-m@pathway.suse.cz>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 6 Sep 2026 10:58:08 +0800
X-Gm-Features: AcwNN1VSYi4M86b0t5ge8cLnFyxD2sf2e5hnDedlU4ytJyHy81BMDww79rayBUk
Message-ID: <CALOAHbC9vhpo+LXPnQo=1A_U10bejc_AAS1rN2SARcAOZLEoHw@mail.gmail.com>
Subject: Re: Replace rules: was: Re: [PATCH v7 for-next 3/8] livepatch:
 Implement replace set for scoped atomic replace
To: Petr Mladek <pmladek@suse.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, 
	joe.lawrence@redhat.com, song@kernel.org, live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 6:01=E2=80=AFPM Petr Mladek <pmladek@suse.com> wrote=
:
>
> On Wed 2026-09-02 19:50:25, Yafang Shao wrote:
> > On Wed, Sep 2, 2026 at 5:40=E2=80=AFPM Yafang Shao <laoar.shao@gmail.co=
m> wrote:
> > >
> > > On Wed, Sep 2, 2026 at 3:31=E2=80=AFPM Petr Mladek <pmladek@suse.com>=
 wrote:
> > > >
> > > > On Tue 2026-08-25 19:46:36, Yafang Shao wrote:
> > > > > The current bool replace flag is too coarse: it is either all or
> > > > > nothing. A livepatch with .replace=3Dtrue replaces ALL existing
> > > > > livepatches, which is safe but inflexible. There is no way to hav=
e
> > > > > multiple independent livepatch sets coexist on the same system.
> > > > >
> > > > > Replace it with a more flexible model using two new fields in
> > > > > struct klp_patch:
> > > > >
> > > > > - provides: an unsigned int id identifying the patch replace set.
> > > > >   By default (provides=3D0), any livepatch replaces any other liv=
epatch.
> > > > >
> > > > > - obsoletes: an optional array of unsigned int ids specifying
> > > > >   additional provides ids to be replaced. This allows a new patch
> > > > >   to explicitly obsolete patches from different replace sets.
> > > >
> > > > > --- a/include/linux/livepatch.h
> > > > > +++ b/include/linux/livepatch.h
> > > > > @@ -123,7 +123,8 @@ struct klp_state {
> > > > >   * @mod:     reference to the live patch module
> > > > >   * @objs:    object entries for kernel objects to be patched
> > > > >   * @states:  system states that can get modified
> > > > > - * @replace: replace all actively used patches
> > > > > + * @provides:        only one active livepatch per id
> > > > > + * @obsoletes:       replace given livepatch id(s)
> > > > >   * @list:    list node for global list of actively used patches
> > > > >   * @kobj:    kobject for sysfs resources
> > > > >   * @obj_list:        dynamic list of the object entries
> > > > > @@ -137,7 +138,9 @@ struct klp_patch {
> > > > >       struct module *mod;
> > > > >       struct klp_object *objs;
> > > > >       struct klp_state *states;
> > > > > -     bool replace;
> > > > > +     unsigned int provides;
> > > > > +     unsigned int *obsoletes;
> > > > > +     unsigned int nr_obsoletes;
> > > >
> > > > This is a different sematic in compare with the other arrays.
> > > > I guess that you wanted to allow obsoleting livepatch with '0' ID.
> > >
> > > right.
> > >
> > > >
> > > > But '0' is special. It obsoletes anything. Maybe, we could
> > > > make it even more special and say that it can't obsoleted.
> > > > Then we would be able to use it as the trailing element
> > > > in the array...
> > > >
> > > > I do not have strong opinion about this. It is just an idea.
> > >
> > > Making '0' special is good for backward compatibility, but it
> > > complicates usage for users. Therefore, I prefer not to treat '0' as =
a
> > > special case.
> > >
> > > >
> > > >
> > > > Another question:
> > > >
> > > > Should we allow to enable a livepatch when its provides id
> > > > is obsoleted by a currently enabled livepatch?
> > >
> > > Good question.
> > > I believe it's best to refuse to load it, as doing otherwise might
> > > introduce potential issues. I will update this rule in the next
> > > version.
> > >
> > > >
> > > > For example, let's have:
> > > >
> > > >   + Livepatch A: provides:1
> > > >   + Livepatch B: provides:2, obsoletes:1
> > > >
> > > > Now, two scenarios:
> > > >
> > > >   1. Livepatch A can be replaced by livepatch B. This is easy.
> > > >   2. Can livepatch B get replaced by livepatch A?
> > >
> > > No, I don't believe B should be replaced by A. In this case, if B is
> > > already enabled, A should fail to load.
> >
> > This brings up another question regarding large server fleets. In our
> > production environment, if a new livepatch introduces a regression, we
> > always roll back to the old version.
>
> Good point. Well, note that the above example with two livepatches
> is artificial. More realistic example would be with three livepatches,
> for example:
>
>   + livepatch A: funcs[] =3D {a, b}; provides =3D 1;
>   + livepatch B: funcs[] =3D {c, d}; provides =3D 2;
>   + livepatch C: funcs[] =3D {a, b, c, d, e}; provides =3D 1; obsoletes[]=
 =3D {2}
>
> Now, imagine that C does some semantic changes in the function 'e'
> so that all other functions {a,b,c,d} have to be updated accordingly.
>
> You could not install B when C is installed. The functions {c,d} would
> break because they won't be compatible with the rest.
>
> The only safe solution would be to replace:
>
>   1. C with B and install A later
>   2. C with A and install B later
>   3. C with A+B atomically
>
> The 3rd solution would be the best. But it might need some significant
> changes in the core code. We would need to handle an array of
> transition patches instead of just one.
>
> But we might allow 1st and 2nd solution after all.
>
> Summary: We should not allow to install B in parallel with C.
>          Instead, we might allow to replace C with B.

Sounds good.

>
> > For example, if A is the old
> > version and B is the new one, we will roll back to A if B causes
> > issues. In that case, if we refuse to load A while B is already
> > loaded, we can't roll back. (In practice, though, we haven't rolled
> > back a single livepatch after rolling out 40 versions on our 6.1.y
> > stable kernel.)
>
> Good to know. We should keep it simple. For example, it might be
> nice to allow atomit update to more livepatches but it probably
> is not worth the effort.
>
> > However, this isn't an unfixable issue.  In the future, I plan to
> > introduce dynamical provides IDs and obsoletes IDs at load time,
> > allowing us to change IDs on demand
>
> This sounds hacky and dangerous. IMHO, this should not be needed
> if we allow to replace C with B in the above example.

Thanks for your suggestion.
I will proceed with implementing this update accordingly

--=20
Regards
Yafang
