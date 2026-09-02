Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B67547F2F6
	for <live-patching@vger.kernel.org>; Wed,  2 Sep 2026 11:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788349876; cv=pass; b=SaX4l6ckE5Q8eP24+iuTUvOBEWjXSSWDKRsGgWyuFIaEABK3E/AR/uIHe70R42jmrrzF5fUaw9DZQHH8RYBLIjqLKkxTyj+6JiseWVsqkGzCFy1GmE2LjCK6dYbhX8HZwDq4sTg+5YpGxC+VsF8z1Mi7yRNUL41xT8agMQ2ORYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788349876; c=relaxed/simple;
	bh=FtlQ69PBZzqW1l19Q9HvAujuQ7BVg+QIIpGtnkEUD6I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LE+jyrzrU/o4XSnA9dwCq7E0Pd1YLgyB4AZU4dbEXxwygPGUtrKuXo0iivh+hhnRxxDIQ1X7eEjssVtKSG7v0H3PPKjiASj6bEmQ9N7WJZXwa0v0AgeTpahf1qzu+ZKvy7XuiWWEsjbHLfvM6HP6aZr0ocmfkmCRJXgqvsjgnfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ww4aJCVJ; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ww4aJCVJ"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-66bd7857841so1403691d50.3
        for <live-patching@vger.kernel.org>; Wed, 02 Sep 2026 04:51:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788349862; cv=none;
        d=google.com; s=arc-20260327;
        b=r4FDgYc7TDFdbeRX1hs0fVLf/Dlgu2ZHUTuVlNSvLkZ7jJxjkXSbuNnZj4bd1QJ7xt
         ALURHa3IbrOMGqZXvvIkC1KQVlTgeA1HzOeQvPhgmrpLxF6TA9Bbw43mXTZBCVX4mmjZ
         K57iIYQJEV6EqZi3CLQsv/LiUaI3YckjrEErIg1dj2JENirjL5L9RTV9EZSEoL+DFkWR
         7gJbOsldYKmtJVq/UfmIsFvOAz7GRP69a32OIaWDEzvoyvdc8AO/UOm6drSEsyg9En8d
         8ZY5yoF+Nil7MWL8ONHDsh3H8nvIsmg/w0Su0NsUkjga/efbevHh4on7CIWQ/iyC26N5
         3TAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h9AyGAukijDqEaZpCry5OGnvlxP6V2oKQsU79SroMho=;
        fh=tGscE/3OT/Kk0ZOwwULxTTT+BxUWmTjcIh1au6JE9Sw=;
        b=WL3ixYvnamFBbUhgEvyNCxREte7h042A1cRvY1tdGNZ9tXS8aFVzl6wuBPZYzAOzvV
         c1joHyO2CJY2t5j5JdyPxwRzg9j2sYXL+uln9tqbhUhMx1uYeywITzeALyHXk1xF1gFR
         UHXj+A3milKXzSjWKpwdlQbJp2X4VWw9XkKYEgnHasuB8z5sRWdZqnAxLJ8HGrixZY6O
         +9rtIvDvSnyEpK1GiZcY5qH18qPMEcYYZ5LyMVC1rf0W/pceuz85i/yxPKU9LvmejVZK
         MOEDsr4cXILtBhISPVTEUmm8Ef++orIbpN4MOCyzwUY1XRrl5T62T0HxPTkMunRze6E3
         9Uig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788349862; x=1788954662; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=h9AyGAukijDqEaZpCry5OGnvlxP6V2oKQsU79SroMho=;
        b=Ww4aJCVJz2fyzNciE1vwFwEM9bPVZ8ilqf9HKIrndpPlqOk7E2cmsbRBMkg13M6SiN
         wMA79ahg6yIn6u9g01sLVoP0IFVhMDa2NXWwXMgubwiA8Y17H19Lo93tByNLXVXHFQMa
         11UnxgbayViVBP8Ivdb39ztfU33f+ciCkshizqF1euO92j4oANrbPHmXpZv1AhedLa3n
         A1M5+ierd6Qh+8ZfhvDyr0OXIDZVdyR9NqKk/pQ+dpJgMLoNcoPn+bQ6os1CESRsJRQh
         J92i+PrmAsdr2TWrNwns3g4ZzA5Nghr0PcZSwZK5SCZg4LmzXZi+bmzCsON8KnTP5wJF
         MIdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788349862; x=1788954662;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h9AyGAukijDqEaZpCry5OGnvlxP6V2oKQsU79SroMho=;
        b=jiEzNfy3peAfSN96EVQEqM/+MHezctcszRc4r1FycZq1D/nRWIxkG1rhzE9H4Wrwxg
         9zYpyzSymsfSHJ2lbKFHB5WS7+xHakZ1Ktoy7/Lt+XdcQ76E/8JQT8/mOKklVCW2z4dm
         UaJJtmWMNz/tQbMorBXVujukrRwCzjKqIIWiPP4bueV4orPk32qvoE2VNb9cMGMWmEvC
         YU8XvCE1Zt2N5uLJIDArjEGkZctdJtgNw9oWdVph+UvHV9klqIYXvbHll7Whcby4YlN3
         ATLPGnaT61rWOGnPh0owR/HSw9WyKYA0qZ2ZTKOkzgfYWDLAA0eKAL8Zck15246rZdgL
         cqGg==
X-Forwarded-Encrypted: i=1; AKwUvBz3PfIMbXDaQLbC1LjT6l5nsUWvCczKxq1Wb/HLefxLUmsGcm4A8OMEpU94AyA5ISgQ0h+FxtLFyg4K6LiM@vger.kernel.org
X-Gm-Message-State: AFuF++mJLVE8GMfSTzdITHvoooEraftJ9tBp8dk7ko5I/+iupYws4QnP
	cfzcHA4UUoV/kFs237xGCB5xoUhFcB2r1FKdLmMEDQkCG61lZIfc82IAIn+I3NQv4mWLMzdtOSF
	bWRD6EVx8WUNAKmnTEyE2kZMsWHTyUUs=
X-Gm-Gg: AYBFou1dacDbe8oXw6L+FgNZbRsOsTZ13F8OQmaKbwcuMyrnE/QJVCG83y/IT/bBYur
	G9u1l1W9SBRE5m1QMSrRYDozDTxjAX7+8evRQLwMfOmJWkLis6/mewYZCvSYTTWg1NuZ8XoWt2U
	fQDSbZ4dEW2yIKu7pmpKwuPH++sJN7GvSgJRna3r56I/j55ybMXxD4NaYDK9WP4uOnC4pn9kljl
	7suQkf56HU3+whbRpffyyDr3v49l66KL++NP617LMfBL1lw5wtTk5i6YGML8PqzJU+9ie15C/HM
	CPvVlJrOvW/Q7/XV4hUPc6OKstmNhYoS01AEGV5RT2v4xo+Huj7ZLV+C88Np7069mghm7C7KLlz
	wSg==
X-Received: by 2002:a53:ac93:0:b0:66c:85e3:7f28 with SMTP id
 956f58d0204a3-66f9be6b625mr1367498d50.48.1788349861593; Wed, 02 Sep 2026
 04:51:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825114641.80452-1-laoar.shao@gmail.com> <20260825114641.80452-4-laoar.shao@gmail.com>
 <apfQ6c_3giN615Ll@pathway.suse.cz> <CALOAHbAb3Hiv5HZ0b0r_GjqCpZRx53Yq-NJo=eo7PxE_tD9asQ@mail.gmail.com>
In-Reply-To: <CALOAHbAb3Hiv5HZ0b0r_GjqCpZRx53Yq-NJo=eo7PxE_tD9asQ@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 2 Sep 2026 19:50:25 +0800
X-Gm-Features: AcwNN1XxXIFjUsWi8350U7moCY9m2dZQqgGlcjqdpx3b0Drdom77-0Ml9JbY3iU
Message-ID: <CALOAHbDVSD=sNb86VdtOG_KY3VL6Vz5EP+aO7GmY-TrkogOJXA@mail.gmail.com>
Subject: Re: Replace rules: was: Re: [PATCH v7 for-next 3/8] livepatch:
 Implement replace set for scoped atomic replace
To: Petr Mladek <pmladek@suse.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, 
	joe.lawrence@redhat.com, song@kernel.org, live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 5:40=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> w=
rote:
>
> On Wed, Sep 2, 2026 at 3:31=E2=80=AFPM Petr Mladek <pmladek@suse.com> wro=
te:
> >
> > On Tue 2026-08-25 19:46:36, Yafang Shao wrote:
> > > The current bool replace flag is too coarse: it is either all or
> > > nothing. A livepatch with .replace=3Dtrue replaces ALL existing
> > > livepatches, which is safe but inflexible. There is no way to have
> > > multiple independent livepatch sets coexist on the same system.
> > >
> > > Replace it with a more flexible model using two new fields in
> > > struct klp_patch:
> > >
> > > - provides: an unsigned int id identifying the patch replace set.
> > >   By default (provides=3D0), any livepatch replaces any other livepat=
ch.
> > >
> > > - obsoletes: an optional array of unsigned int ids specifying
> > >   additional provides ids to be replaced. This allows a new patch
> > >   to explicitly obsolete patches from different replace sets.
> >
> > > --- a/include/linux/livepatch.h
> > > +++ b/include/linux/livepatch.h
> > > @@ -123,7 +123,8 @@ struct klp_state {
> > >   * @mod:     reference to the live patch module
> > >   * @objs:    object entries for kernel objects to be patched
> > >   * @states:  system states that can get modified
> > > - * @replace: replace all actively used patches
> > > + * @provides:        only one active livepatch per id
> > > + * @obsoletes:       replace given livepatch id(s)
> > >   * @list:    list node for global list of actively used patches
> > >   * @kobj:    kobject for sysfs resources
> > >   * @obj_list:        dynamic list of the object entries
> > > @@ -137,7 +138,9 @@ struct klp_patch {
> > >       struct module *mod;
> > >       struct klp_object *objs;
> > >       struct klp_state *states;
> > > -     bool replace;
> > > +     unsigned int provides;
> > > +     unsigned int *obsoletes;
> > > +     unsigned int nr_obsoletes;
> >
> > This is a different sematic in compare with the other arrays.
> > I guess that you wanted to allow obsoleting livepatch with '0' ID.
>
> right.
>
> >
> > But '0' is special. It obsoletes anything. Maybe, we could
> > make it even more special and say that it can't obsoleted.
> > Then we would be able to use it as the trailing element
> > in the array...
> >
> > I do not have strong opinion about this. It is just an idea.
>
> Making '0' special is good for backward compatibility, but it
> complicates usage for users. Therefore, I prefer not to treat '0' as a
> special case.
>
> >
> >
> > Another question:
> >
> > Should we allow to enable a livepatch when its provides id
> > is obsoleted by a currently enabled livepatch?
>
> Good question.
> I believe it's best to refuse to load it, as doing otherwise might
> introduce potential issues. I will update this rule in the next
> version.
>
> >
> > For example, let's have:
> >
> >   + Livepatch A: provides:1
> >   + Livepatch B: provides:2, obsoletes:1
> >
> > Now, two scenarios:
> >
> >   1. Livepatch A can be replaced by livepatch B. This is easy.
> >   2. Can livepatch B get replaced by livepatch A?
>
> No, I don't believe B should be replaced by A. In this case, if B is
> already enabled, A should fail to load.

This brings up another question regarding large server fleets. In our
production environment, if a new livepatch introduces a regression, we
always roll back to the old version. For example, if A is the old
version and B is the new one, we will roll back to A if B causes
issues. In that case, if we refuse to load A while B is already
loaded, we can't roll back. (In practice, though, we haven't rolled
back a single livepatch after rolling out 40 versions on our 6.1.y
stable kernel.)
However, this isn't an unfixable issue.  In the future, I plan to
introduce dynamical provides IDs and obsoletes IDs at load time,
allowing us to change IDs on demand

>
> >
> > The current code would allow to replace B with A when there is
> > _no_ real conflict in the livaptched objects, functions, and states.
> >
> > But does it make sense?
> >
> > Reasoning: Livepatch B obsoleted the livepatch A for a reason.
> >         It sounds like they should not be enabled at the same time.
> >
> >
> > Special case:
> >
> > Should we allow to install a livepatch with non-zero provides
> > when a livepatch with zero provides is installed.
> >
> > For example, let's have:
> >
> >   + Livepatch A: provides:1
> >   + Livepatch B: provides:0
> >
> > Now, two scenarios:
> >
> >   1. Livepatch A can be replaced by livepatch B. This is easy.
> >   2. Can livepatch A be installed in parallel with B?
> >
> > Reasoning: The livepatch B replaces everything because it wants
> >         to be the only installed livepatch. It sounds weird
> >         to "break" it by installing A in parallel later again.
>
> So, let's just not treat '0' as a special case?
>
> --
> Regards
> Yafang



--=20
Regards
Yafang
