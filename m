Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAE93EB0E8
	for <live-patching@vger.kernel.org>; Tue,  4 Aug 2026 08:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785830706; cv=pass; b=Af85ddUBhanlALqQP7mV7Z/ex+LdOrvwnbhewMuE51Wt8jXwZJNFH1bWQIfQapVWhuUpmexTp575woM/QyiBMHExkfu5n7ejCkhXLewsXC3A9A7wXXKAdGvlfBkjpOD/BFCmCQgnhqO2H278q9lpNGknpcXhCbNsfOqnlsnFmCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785830706; c=relaxed/simple;
	bh=+Hb1SpzFF3V8KPLkO13v6cUxu1h5CbiM4NFRrHqr13w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M1v9iwtOgcZZaGOwQst9thr6HQvJzMNXd/IO6ALZTkwnDX/J0WUZdYEqUB2HPm3CUhlYpxc9prGusKBG4WUWsnxIgS5yePPjz3gHE2PSWf6z54XRlPTbzyed3hGo0hmpRkjndZbihNC/QyzqotKwAollW9YPDSGWADYs2HqY7vg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fKgKC0rE; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fKgKC0rE"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-8143daf89c7so41826887b3.1
        for <live-patching@vger.kernel.org>; Tue, 04 Aug 2026 01:05:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785830702; cv=none;
        d=google.com; s=arc-20260327;
        b=UR6Wguk2OSTyS8VckVzK4NrLeZNueOG5wD/koIdAMgi7TfvhV0acqn+Y8h55SeV3yk
         RIJmI3vVP9ltR+o+3VgGeR2H1NloW1ik8IhwV6pl8sdTQ0pUSAfrr5B7uD48+D9awuP+
         FShs9XTOxFX6IDsBcKN8JT1VeN5KVazMlgQWEcB3gR/+cqjvJX2XNGZxjmsdY936Ki20
         kovQR0voxBQdjF+s6qFmfVzBjr/tFvD/apKr9heKn9miJRarYJzZdlhsZVSMaYI3Sa4k
         bIlXHwqanMpAqxM8WNutGwrgJBtX4L2GDtaQKptQvsYIaFa4S4gFsOfTbrSs6vLR2Psq
         ZP8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DxODsGuSrXyYDuLdsSOihL33BxJS8kfi8qZptAhXGXo=;
        fh=jK92vzhjnq08YH51E2cRjTzfyAYV/0WBY5Zb//b1aX0=;
        b=UbrXjhQyoR3A9lfkD+Kco2BX9IPX4Doqf1mFdm1gghX8AF+CFfZTP5fZ1JUbJME2tB
         3XGKy1DGkMfLSv6fxsLscZZNvCUaYWuSRuJpM2I+IYdDPlaeIlOwf3MmnQn9LxAyI0h1
         vXDU7/oHzPOQ4l6Qs8CGcUUHRps/Y3fwVZ/IkxGK4OwNmcflMO8YlYK/2Y+XYhg15iCo
         /fkqtrMdHqOTWktJPDNocMz2CugAH8timwZatOZxHWhWzZN/DOn8kgjwtOafx+ac5v+B
         Im6kd3h3Mzx3Yis+N7bdwdg04g41x7ppAu9hz9vb6mEciGqz0YTcJw/kGS6gaOWUkSyM
         wZjQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785830702; x=1786435502; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DxODsGuSrXyYDuLdsSOihL33BxJS8kfi8qZptAhXGXo=;
        b=fKgKC0rE22sIZOWHb09XSm+Af+bBZCN8sU1jde2zvsCQjXPwvNJZLeq+GFNswOtzEW
         PK7pqaFDvpGE9aKXihgPxs1dYrg+8kDHNzmoWzo08EXnyR8M0V7Lx66+d7ROxZhGsr09
         2wV3pkje7bVlPUAeyuj/2Q3dcZk5uzvFlgIcOUT4sTMkJEyHPDSIeYyLYhUCA3JODeZJ
         rqPvq8/DsB4gVpyT25UsNXk+iI3s7l+JvffTOLGgI71lbeToa0bHMi0W/Hpoixq4NehT
         W4GCYhH2Jr3lnpbp5LjPdUHPiUwkN1L9RFXyhOOXIM6q+UccJmlSeYXrULXjN/Re9Qmh
         WY8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785830702; x=1786435502;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DxODsGuSrXyYDuLdsSOihL33BxJS8kfi8qZptAhXGXo=;
        b=SqbFPf7utpsXNu3blo7UAKzSOS8YwG4O07QyYFGbgFA0ccqoKDyjsdVYLX7I6PfPTe
         D4DTZ2G7r70o0Hs1yQfNcPbr7j23c9VQKUN8A+ccPa/4G5w1JrmFr9M4ycDXmLICKdbi
         8zmQ+jlmZ1PjFEUr07/0Ry/1WKpXNrP1iredBbUEROJ8NHX9X6ufEj6qgMbNYkqkXMGm
         NTSddD30s3ipVoNfjCdFX4t3r+5MDq9JDioad1D8FdZFRpx/JzVx+GsvDvGfoa2TRZRe
         RN5yR+BMU43ocpJbDW5gPWuRUrmPwtOW3pnPN04ahCbMvu1ZQC4mauGGnMiPzA1C9L+f
         lBJw==
X-Forwarded-Encrypted: i=1; AHgh+RoctWyG2BprloN3/d0gupTKu/gGJklPaeXBrG4BLEhWu/VAYMZ9ijXj2yylnT1v/h88sJd/n99xt+/rngEI@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0q4LWIqlJ4eIexpp3j8nLa/hp8F7O15rDQ2AcazsJO3bth5gT
	AUg6y884+Sj/r9CGGqY3sRmUyprdklx94GJ3mbUxynk3GQql0XdeNapEDprK7oBi5/6cvGQC5qt
	yAsXkcZIeuQWisxsWZlHV09DIKhV2QtQ=
X-Gm-Gg: AR+sD11yhjyo64QwCWc3Eta2ByryewaeLQEtdHS3lOcsFV8QhFoZaGtGX9xQtXpZVze
	Ji5e+pYUKoP2MzBkiFGk7VeqXwYVqI9+Y4S2XVAkKFAIgRQzKY9qen5Zh6+1CJpAjSNZzCMLfRV
	m0IRktq3w8KPoa5uh0ivQrOPUDxUNUsbNdRPlDQYJSeOaCpsfty56XP3q9yyOuaPRGC18Di9fhD
	AsTJUz3Qaa8qAR55lmrwEqU2gLJcRij2smi8fCcLoPHzt7BoxMNfKYnRQpmuU85BauHcBEdrHU5
	V7B6o/QO8CPJ8t8PhZw9ede6Am+LwlbpaheqCN06BSaSIChjxFQhFghJ6gEzlA1+QIz8R9vEib9
	QLA==
X-Received: by 2002:a05:690c:6b11:b0:80c:3848:bde5 with SMTP id
 00721157ae682-81fd4a22e3emr170966087b3.13.1785830702256; Tue, 04 Aug 2026
 01:05:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804065010.44922-1-laoar.shao@gmail.com> <20260804065010.44922-2-laoar.shao@gmail.com>
 <20260804065633.0D6A31F00A3E@smtp.kernel.org>
In-Reply-To: <20260804065633.0D6A31F00A3E@smtp.kernel.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 4 Aug 2026 16:04:25 +0800
X-Gm-Features: AUfX_mzjzWFOup3b8CRhesfJVIRE_EvKUp-y3mYxG0ZbV58cKl29zxrmTeo9fLY
Message-ID: <CALOAHbA-5v9p4U6=RnNap1iFRNUpooABqfv1MLAuG7qQYRu5MA@mail.gmail.com>
Subject: Re: [RFC PATCH v4 1/4] livepatch: Make klp_find_func() non static
To: sashiko-reviews@lists.linux.dev
Cc: jpoimboe@kernel.org, joe.lawrence@redhat.com, song@kernel.org, 
	mbenes@suse.cz, jikos@kernel.org, pmladek@suse.com, 
	live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 2:56=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] klp_find_func() incorrectly returns the search parameter inste=
ad of the matched object from the list.
> --
>
> --- Patch [1]: [RFC PATCH v4 1/4] livepatch: Make klp_find_func() non sta=
tic ---
> commit 59916304ff12f7685cb556f7a7c1f4a1c5a25b00
> Author: Yafang Shao <laoar.shao@gmail.com>
>
> livepatch: Make klp_find_func() non static
>
> This commit makes klp_find_func() non static so it can be used in other
> source files by an upcoming patch. It also renames the old_func parameter
> to func to better reflect its generic purpose.
>
> > diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
> > index 28d15ba58a26d..e07c41a0f3ac8 100644
> > --- a/kernel/livepatch/core.c
> > +++ b/kernel/livepatch/core.c
> [ ... ]
> > -static struct klp_func *klp_find_func(struct klp_object *obj,
> > -                                   struct klp_func *old_func)
> > +/* Check if @func is present in @obj. */
> > +struct klp_func *klp_find_func(struct klp_object *obj, struct klp_func=
 *func)
> >  {
> > -     struct klp_func *func;
> > +     struct klp_func *obj_func;
> >
> > -     klp_for_each_func(obj, func) {
> > +     klp_for_each_func(obj, obj_func) {
> >               /*
> >                * Besides identical old_sympos, also consider old_sympos
> >                * of 0 and 1 are identical.
> >                */
> > -             if ((strcmp(old_func->old_name, func->old_name) =3D=3D 0)=
 &&
> > -                 ((old_func->old_sympos =3D=3D func->old_sympos) ||
> > -                  (old_func->old_sympos =3D=3D 0 && func->old_sympos =
=3D=3D 1) ||
> > -                  (old_func->old_sympos =3D=3D 1 && func->old_sympos =
=3D=3D 0))) {
> > +             if ((strcmp(obj_func->old_name, func->old_name) =3D=3D 0)=
 &&
> > +                 ((obj_func->old_sympos =3D=3D func->old_sympos) ||
> > +                  (obj_func->old_sympos =3D=3D 0 && func->old_sympos =
=3D=3D 1) ||
> > +                  (obj_func->old_sympos =3D=3D 1 && func->old_sympos =
=3D=3D 0))) {
> >                       return func;
>
> [Severity: Medium]
> Will this return the correct object? It looks like this now returns the
> search parameter (func) instead of the newly introduced list iterator
> variable (obj_func).
>
> If a caller relies on the returned pointer to access the matched object
> from the list, they will receive the search parameter instead. This could
> lead to incorrect state manipulation or memory corruption for new users
> of this exported function.
>
> Should this return obj_func instead?

Good catch. It should return obj_func instead.

--=20
Regards
Yafang
