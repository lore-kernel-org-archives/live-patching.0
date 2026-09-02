Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB34537C927
	for <live-patching@vger.kernel.org>; Wed,  2 Sep 2026 09:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788342762; cv=pass; b=TGC+R4W+qxJaEXwLuqjVhjV76P7A1ye3+X/pdYSBoZpq6RQ7Yj9DD2rA817aEL0E6MHgozLsap+nmUeATmLC1p2LsJO2+xYR46DvjKUb9MNjGjwEefkkHVmJOqN/fyolFTALfFhF6ILXowhzDkwsjHSl3dwTWbaPQx+e4iGmNYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788342762; c=relaxed/simple;
	bh=umDFN02G9om7EBpTw6IZxcAW/O0RLeUR6prntAFFzZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uq5LoRP5XDDZpN9HptaeYyaWIVFHcGPbBOl+RpR8aOZ2F2Z63CdP/smUelZVkbaKsw1nLVNOVQI1S3lULvUc21Q+1z6vx3tZhp9uMsNqihutIGoXHem0/2MrSFnf1K+G2z+q0esMKPS2JDie3Up0/CBMNsfKFqJwNcknqPz0/2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fiyu90on; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fiyu90on"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-857ff9fef54so9661967b3.1
        for <live-patching@vger.kernel.org>; Wed, 02 Sep 2026 02:52:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788342760; cv=none;
        d=google.com; s=arc-20260327;
        b=RSRwY7Xyj5KRELBulUrL9gcQmluyWkWfezQ4x9W9RCNrSjxu/7xBOuNLi3y/k20rtj
         KfSEjT3jiA3R+MDsYnIr0SptEayq+b0sc3tAGinVeMob753GuHVRswbjGh68lnm/wECZ
         Ms7aSgTXsnfdzOCgOTW8D7dBry5aCDOePPNcPbdCSLYC7KTF3M+HVpwBepyY31ceRzg6
         bMqW+clah7hlLY49oBNVQUVqsWEpV9ZTKe9YwsapgLh2EILdf319UH1yp3Li+EDfpOgM
         EX51jDHlVlXgJ5wJ1MxV81RRqQsQsK8Mfyzb97/mjzf72lYldi+PTPYBUbqgI6G8GPMS
         HG5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3q9hdJb/hXyi9cYmhpfk2VY9GyrbgIkYPQRoT2ObgCM=;
        fh=FUOurPx5TUK7hvZSFOnu5SsDyfq5eHrvWkA0EAUzjGk=;
        b=a6FPX+F4WVOln/W9z4mP7qxzQ2QK8pvLMEeQmbhzYcR6v9McPBFH5QhfLJTOLRQG9+
         Eap0gFHtDpWjHiEVkCoBs4hehUtR1MFpmQKwum/XDABvHUN1Aj7XS48BVHDtAFoRjpYh
         llOFTff3G5xSgg/msZXKsbIqUyRuzzypRwyp+gm2m1o2xXj6SKqRVTvZw7fHH3Mw2UG1
         DN33TIk2zTD8UddWS09/0RuWIGcpCkulXLZcVkhGL/MhHm+DtVemuxVgTolTpfzbF1Ud
         iHEIxb9+BuDU+bDY8QWSEpAUXNaepmgyK7VGcWnWN718kpOIAY4bcE5QqKYP2MGyMzLz
         fbqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788342760; x=1788947560; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3q9hdJb/hXyi9cYmhpfk2VY9GyrbgIkYPQRoT2ObgCM=;
        b=fiyu90onpqEomVA+1U7m1rRxXiqXbiva/E36nWJXmHuEBd4TOoLxnGGc/Jf4XzYVRB
         +4PIJacFfOTOJB327s1BuvRpSdKAai397T1iZPQ88nvNbwnSNfcDnIgmLLlwgRsfH8rk
         t/qQjn+P7LdgPM00zvoT8FWs349FH4LmEKJd8/DbKM+haqVal39oKiHr4WYVC6pKDIOV
         6X5CoFKN06Nnjgc7SLokFNFTw+fjMzaghpj+IWh3vPovQHl2QnqDtTmcUh9rqDlAZKqO
         GUMIyWXHiymSlFFvQHL4kUinXJvYFfH8WeJTyz2Jrn4UKqn3UKlFtUZddlLAQt1LvBAJ
         EvHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788342760; x=1788947560;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3q9hdJb/hXyi9cYmhpfk2VY9GyrbgIkYPQRoT2ObgCM=;
        b=BkYrFSJfVS3AjieglO2aI68jJgPZLXDQiFKDFB8OcdXheNZawDng+JPoFSiCHe9YVi
         8A+G62yjyK9/Ec7SzGnOxOjgwkUqFGt7JL1oU3NKlSvXlGcrV6teeTQm9/A2QbRJBD9l
         2qdw2Qxrh/yJSIiRcRsy5ytS8zLp2HlC6yv9bYIkrjYARLWewhjOaJ1QjXybLnE5UgXy
         5BUA/yw8vnst/pY51xORgRYdfhlb0EK559G5fvP/t7af09p6FZjwHoF+NXXnmtfLt4LR
         WQ4Bpko7I6AlNe0UYtwjU+Z1ldMrlIibpTN8eOAEtJm1SBPddJ6KX5/dfgskm/pIEyvY
         8BAQ==
X-Forwarded-Encrypted: i=1; AKwUvBwebLyt76C4ZJM105TI2L9UFOSndZ4SYYzOVX3ETFreUpxbYxY3nL/V3qtv++kVu0GwxKOfHyGDxAV+ASHS@vger.kernel.org
X-Gm-Message-State: AFuF++lOJCMsRnAP9aweNNba7TXS81dGT1dS/OwJkt1/2CT62niY/pzr
	MJ11WYCcD/M70y/xP3+P3joFY4xldkKlhq/XlBa3RTe8IKtNUtj5LdfXouo0TUzOy/gtqf7KCgp
	np/ckfMjtoEOv3cFzTb9Gm5M0srd0U7k=
X-Gm-Gg: AYBFou0qMzo3eViJNx+UElkILSMVtaLYSDwjQP8rigaH8zgl9y+IQeynbVoQLtzPm8S
	ULj3UEZCIIHuTIDV3W93e5/ZxFuiOXgwT3PnbxUz0uWHJBOxWhwSfsvc+oNm1xuCxDXs4Z/Iyu3
	f1mGQLlyWETINTLN2BQZHhQBRj+anNTvzoWrSHRyVQIJa5vmKXsuylIUDEbqPoi6aHGDlNNqKXD
	YBbujabJil5DG7nbFMQszMSDH6dTe4K+zZR3iOYuHCrcxeYlZ+i/ZIDD8paHb47e62FoasyR/U+
	xRbyapE5jgkV3CVZM+AwmQzKFdHc9p4klrVtIvH1JaCOlR+cMwMt7nCozB7KZYQnA3i71ToAid8
	7Hg==
X-Received: by 2002:a05:690e:2367:b0:66c:e25c:f7ae with SMTP id
 956f58d0204a3-66f9be701d3mr947489d50.40.1788342759645; Wed, 02 Sep 2026
 02:52:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825114641.80452-1-laoar.shao@gmail.com> <20260825114641.80452-4-laoar.shao@gmail.com>
 <apfSMN5a9PTxTTsW@pathway.suse.cz>
In-Reply-To: <apfSMN5a9PTxTTsW@pathway.suse.cz>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 2 Sep 2026 17:52:03 +0800
X-Gm-Features: AcwNN1UArjZZE4pPmAzC-MMWxQnpKyhITDMu_ogrHGQk0qSxdnPm4atplmOBD1E
Message-ID: <CALOAHbBFU324Oz2r6VAqVnKk-oje5FRm5TSGy=hUrq8PcYsMYw@mail.gmail.com>
Subject: Re: code cleanup: was: Re: [PATCH v7 for-next 3/8] livepatch:
 Implement replace set for scoped atomic replace
To: Petr Mladek <pmladek@suse.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, 
	joe.lawrence@redhat.com, song@kernel.org, live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 3:37=E2=80=AFPM Petr Mladek <pmladek@suse.com> wrote=
:
>
> On Tue 2026-08-25 19:46:36, Yafang Shao wrote:
> > The current bool replace flag is too coarse: it is either all or
> > nothing. A livepatch with .replace=3Dtrue replaces ALL existing
> > livepatches, which is safe but inflexible. There is no way to have
> > multiple independent livepatch sets coexist on the same system.
> >
> > Replace it with a more flexible model using two new fields in
> > struct klp_patch:
> >
> > - provides: an unsigned int id identifying the patch replace set.
> >   By default (provides=3D0), any livepatch replaces any other livepatch=
.
> >
> > - obsoletes: an optional array of unsigned int ids specifying
> >   additional provides ids to be replaced. This allows a new patch
> >   to explicitly obsolete patches from different replace sets.
>
> > --- a/kernel/livepatch/core.c
> > +++ b/kernel/livepatch/core.c
> > @@ -448,13 +449,32 @@ static ssize_t force_store(struct kobject *kobj, =
struct kobj_attribute *attr,
> >       return count;
> >  }
> >
> > -static ssize_t replace_show(struct kobject *kobj,
> > +static ssize_t provides_show(struct kobject *kobj,
> >                           struct kobj_attribute *attr, char *buf)
> >  {
> >       struct klp_patch *patch;
> >
> >       patch =3D container_of(kobj, struct klp_patch, kobj);
> > -     return sysfs_emit(buf, "%d\n", patch->replace);
> > +     return sysfs_emit(buf, "%u\n", patch->provides);
> > +}
> > +
> > +static ssize_t obsoletes_show(struct kobject *kobj,
> > +                           struct kobj_attribute *attr, char *buf)
> > +{
> > +     struct klp_patch *patch;
> > +     unsigned int i;
> > +     int len =3D 0;
> > +
> > +     patch =3D container_of(kobj, struct klp_patch, kobj);
> > +     if (!patch->obsoletes || !patch->nr_obsoletes)
> > +             return sysfs_emit(buf, "\n");
> > +
> > +     for (i =3D 0; i < patch->nr_obsoletes; i++)
> > +             len +=3D sysfs_emit_at(buf, len, "%u%s", patch->obsoletes=
[i],
> > +                                  i < patch->nr_obsoletes - 1 ? "," : =
"");
>
> It would be easier if we swithed the oder of %u and %s:
>
>                 len +=3D sysfs_emit_at(buf, len, "%s%u", patch->obsoletes=
[i],
>                                      i =3D=3D 0, "" : ",");

I will update it.

>
> > +
> > +     len +=3D sysfs_emit_at(buf, len, "\n");
> > +     return len;
> >  }
> >
> >  static ssize_t stack_order_show(struct kobject *kobj,
> > --- a/kernel/livepatch/transition.c
> > +++ b/kernel/livepatch/transition.c
> > @@ -498,7 +498,7 @@ void klp_try_complete_transition(void)
> >        */
> >       if (!patch->enabled)
> >               klp_free_patch_async(patch);
> > -     else if (patch->replace)
> > +     else
> >               klp_free_replaced_patches_async(patch);
>
> Nit: I would use this opportunity and invert the logic.
>      Positive checks are always easier to read.
>      I mean to use:
>
>         if (patch->enabled)
>                 klp_free_replaced_patches_async(patch);
>         else
>                 klp_free_patch_async(patch);
>

Thanks for your suggestion.
I will update it.

--=20
Regards
Yafang
