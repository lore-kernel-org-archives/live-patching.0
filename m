Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA91D20299B
	for <live-patching@vger.kernel.org>; Wed, 10 Jun 2026 03:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781060510; cv=pass; b=YA2aQQVoMb2h/K0zSUrd686sShFVPal+GIdaziDbM3S1C8t1P7HBLrMoWd5Lr87RdIULKcORghjZptE65sOqdFdJPWgNm62wWykD72B32T0CkLi07LIsJ/BLxC/qIXOY7Yxp/ucyyv1wVFffuzLrRxrqyA3D146UIlEKNJd+gzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781060510; c=relaxed/simple;
	bh=vzaQBKBlvjvsV3ZVo4o/Z6mh5HW7lHAbYwAmVkXTsz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GdwiITpMOhc3yOcMF+eOz1QC9djHwxdYdkOi7rJdOEynkRyXuK2wDnVfaqBazW48dg2WA6Iml1a7siLGPH8hhrsgqJByfk2yk1W2l0o7f1aGMWR9QGUSzR0fPi0qjhqxjtSV5MMYzKCrnuQKMTjMenEWA/RnklQZWC8rQd3dXwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b1MJzn++; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b1MJzn++"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7e87602f26aso69105897b3.1
        for <live-patching@vger.kernel.org>; Tue, 09 Jun 2026 20:01:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781060507; cv=none;
        d=google.com; s=arc-20240605;
        b=kciFKaPbHDRg8ln9CLnV3+gYRtR9fbTIcTI04bAM6Jv9RZRLh+WApYb1+6c8Was/+Z
         LdT991V/v9zvSz1lJ1DBAOhoz1++7ECjzphMEY836NDzEyfBIV+yOrHnmyTFCLO9wOo/
         QOX9hrtj2NoglGBWDBRyQ3fSvVHpiaevzavHE6dL2Bweq+lmdqWzRjYb+7WOkvO8/7Bp
         MHYZgUspqnV8VtlpXfhD1T+kERdoZe8cJn77YW3qm67jB5pxyKqXF2fqnkho8m/5Tq6U
         sRLuD1m+6AlYYWEKhZrVambRZ1WmrU7oxSiT67u6p8vlzyXpTxZ6Sj5fBp+CcqmiYlww
         dQwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fDpJI/r8f5NU9mloW84XzkdjG6wmo6tIRLHRWQuoSQw=;
        fh=VCrRG4smLNWZnSQRFVzMd8FnqXjjV+aOI29ZQQolAuQ=;
        b=RGlHyNhRsupbSVSAccnwXXKCQ69eWLP8WkPfA/mdPXMamYeuvu7yJLqn+lF4teGmDr
         fk3hWfmrMgKr1LPf925mQS204gPTmkOJgYrurPxrd9UmzPb/V7U52ONEdYxPHQL90to7
         LXDx4uUSfGTZ5DGKK8t184sutS+ShaMDhAYPIRcPMH3klXir298kFeD6IkXWPt/j7mNB
         PQgXqvT1dldLDGd2V5X31GPRT4DnryTtZfF5AOSQ9xCXa1HUih5nxNqolvwqb0/cb6x1
         e+dWaNkSobmMa3qKdSvG/0sQPcXODQ7Z9+M8HpUmqwNtq9qdEW7dft1m71MhE7MY9fMi
         qtxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781060507; x=1781665307; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fDpJI/r8f5NU9mloW84XzkdjG6wmo6tIRLHRWQuoSQw=;
        b=b1MJzn++dn8IKz3k1K6gjOX73Ls3Cgz1P/PO7i4UM0PGkqVhXDkrxDB0qv0GctE9nT
         XwztWMbEOt5I9Ycsr5pOcDEFm0d6ahIXUeAfysC9KyRa3lHfkZAfCogqG4bdERRa3b3/
         p7ga/xjOHq3O6Nfk6f6PfjIqps8DUx2SxAiUTboQ9MVuEvB8ybC7yfoGqptq2LxpRDgt
         1vU6dFursgxm31jrmlPKXdw8omt1TvZJqtqYqFcYpUCH7wQ/y64yjc4fJ5sotih7sW4G
         p047y9sv8oStVQ8lBgHYKdiSDOwe+PbAtxNEcs+KtFOzgzpjywHXRkJRWH1DPRQH80Ye
         fcSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781060507; x=1781665307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fDpJI/r8f5NU9mloW84XzkdjG6wmo6tIRLHRWQuoSQw=;
        b=XjtQxK4maW7DXIOpgI9Zluu56L9LC1yhvUZAYYhGUILP95O8Oi95wlSB7Dxq6GXuqO
         eBxMvkjvk8y89VHFqrCYv321IL6M/0JIOmlUxUT6Y/9Vu+VJQjE3a9VmMoOgS8Ue9owP
         Xe9IIH4hRSrQBMrletq/CqpdStM383oeEsz9Fn4JOIfiY6aqQCmvK9zstNYiFldcbZ49
         HTI5kwI44vzSmokn994/FpZZqPkUnkYlNwap2WANWBCxZl6BWyfrfEom6tqypDaUBjEo
         Sih4gEsb4iXVJYrZK7V71xAG65DJOHyH3781Qn0xpxdebblc10CkMGY8eP3xKcFc7qXo
         UHCg==
X-Forwarded-Encrypted: i=1; AFNElJ97f6oizmPw+56fKQpOAZ7bzVkKpZSbkELXymAqBWwjHwb5X4Zpk6sMURcLd4AcSW+ylibilago58cm87QB@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5vTyboSjF7DD3+eFqiLz//0p7HdvjnWTECwFtQ8qxHuO5qoJr
	d2objKi7BCTuJq8ogp4ecVsPsB1/jqrvMrV0F6x9imHjf/RjYMHie4SnKwVyWMq4CKE5QOaZJ9P
	yMYaK+daHGcgyKhOjeCZgqEU0FTGYUCM=
X-Gm-Gg: Acq92OHh3wddvsAEdVd34rp+Qk7E7pkMGcnZFvckPm10uuLjiKv3TQfzCIRHZ4xYi/r
	BjRF8G/ZFbGH6SluSBm0SQbyD8XeB9lGd1YqN5hJ1agXYHHoDCMkyM1U7NdOSbMM+Prwr9IeDg3
	2W0NArFFa1VvnY25Cmg1voYb9v09zqZ8oSyeYhmklgEFmpqiXiqDlbksyn/rJOr9PU3cUOYZ40p
	ITMSr51Yej22+jYohmDpVH0TVKTSFhY5/qL5zh0Hp6O3p6w4iNVloiOxhGKONXzIjPyVeK+KSXR
	xJLogd6zJdMRHR7QHOfX7YgHmLsnJYxcx55QOez6onHP/zp5EWQ=
X-Received: by 2002:a05:690c:c11c:b0:7dc:7dfa:7266 with SMTP id
 00721157ae682-7ed53d80449mr154207657b3.34.1781060507276; Tue, 09 Jun 2026
 20:01:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260607131659.29281-1-laoar.shao@gmail.com> <20260607131659.29281-3-laoar.shao@gmail.com>
 <aigxL-BRGq_Qn9Dq@pathway.suse.cz>
In-Reply-To: <aigxL-BRGq_Qn9Dq@pathway.suse.cz>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 10 Jun 2026 11:01:11 +0800
X-Gm-Features: AVVi8Cf77tQj5XPF8F_bq8PxaivoWsiRyIXt3BTauy5rWuE0ymtjwF131I09L6o
Message-ID: <CALOAHbBrXYGosCqYLrwkC78L_-U4YWwDyc8aDDmwvh0oDUDw5Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] livepatch: Move klp_find_func() into core.h
To: Petr Mladek <pmladek@suse.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, 
	joe.lawrence@redhat.com, song@kernel.org, live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 9, 2026 at 11:28=E2=80=AFPM Petr Mladek <pmladek@suse.com> wrot=
e:
>
> On Sun 2026-06-07 21:16:54, Yafang Shao wrote:
> > This function will be used in other source file in the following patch.
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  kernel/livepatch/core.c | 21 ---------------------
> >  kernel/livepatch/core.h | 21 +++++++++++++++++++++
> >  2 files changed, 21 insertions(+), 21 deletions(-)
> >
> > diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
> > index 95117f7a5b00..6e15ae96a0a7 100644
> > --- a/kernel/livepatch/core.c
> > +++ b/kernel/livepatch/core.c
> > @@ -82,27 +82,6 @@ static bool klp_initialized(void)
> >       return !!klp_root_kobj;
> >  }
> >
> > -static struct klp_func *klp_find_func(struct klp_object *obj,
> > -                                   struct klp_func *old_func)
> > -{
> > -     struct klp_func *func;
> > -
> > -     klp_for_each_func(obj, func) {
> > -             /*
> > -              * Besides identical old_sympos, also consider old_sympos
> > -              * of 0 and 1 are identical.
> > -              */
> > -             if ((func->old_name && strcmp(old_func->old_name, func->o=
ld_name) =3D=3D 0) &&
> > -                 ((old_func->old_sympos =3D=3D func->old_sympos) ||
> > -                  (old_func->old_sympos =3D=3D 0 && func->old_sympos =
=3D=3D 1) ||
> > -                  (old_func->old_sympos =3D=3D 1 && func->old_sympos =
=3D=3D 0))) {
> > -                     return func;
> > -             }
> > -     }
> > -
> > -     return NULL;
> > -}
> > -
> >  static struct klp_object *klp_find_object(struct klp_patch *patch,
> >                                         struct klp_object *old_obj)
> >  {
> > diff --git a/kernel/livepatch/core.h b/kernel/livepatch/core.h
> > index 38209c7361b6..8f01eae875eb 100644
> > --- a/kernel/livepatch/core.h
> > +++ b/kernel/livepatch/core.h
> > @@ -56,4 +56,25 @@ static inline void klp_post_unpatch_callback(struct =
klp_object *obj)
> >       obj->callbacks.post_unpatch_enabled =3D false;
> >  }
> >
> > +static inline struct klp_func *klp_find_func(struct klp_object *obj,
> > +                                          struct klp_func *old_func)
> > +{
> > +     struct klp_func *func;
> > +
> > +     klp_for_each_func(obj, func) {
> > +             /*
> > +              * Besides identical old_sympos, also consider old_sympos
> > +              * of 0 and 1 are identical.
> > +              */
> > +             if ((func->old_name && strcmp(old_func->old_name, func->o=
ld_name) =3D=3D 0) &&
> > +                 ((old_func->old_sympos =3D=3D func->old_sympos) ||
> > +                  (old_func->old_sympos =3D=3D 0 && func->old_sympos =
=3D=3D 1) ||
> > +                  (old_func->old_sympos =3D=3D 1 && func->old_sympos =
=3D=3D 0))) {
> > +                     return func;
> > +             }
> > +     }
> > +
> > +     return NULL;
> > +}
>
> This is too big for in-lining to my taste. I would prefer to just
> remove the static and declare it in the header file.
>
> Also it would be nice to add a description of the function when we are
> going to use it on more locations. Especially, if we allow to pass
> errors via ERR_PTR.

I will update it.

--=20
Regards
Yafang
