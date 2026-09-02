Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC59415F06
	for <live-patching@vger.kernel.org>; Wed,  2 Sep 2026 09:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788342042; cv=pass; b=hQKhwvyZpiOCj99LkUAcgqzOfKcqaJKysjO4WLuWcNsk7jHA9a0OHYwRn64ikuBwDnsAtK3FaXhACHaJj6bJadVA7z/8MbrK56ocNeJipYBOaPhncKG99PbiqMBcrZJ0XecIMcL9XwPRG+GeQXgUygpxOOGt5LJVK0UxOUpyxmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788342042; c=relaxed/simple;
	bh=SRP7ROtWdG1u5SQ+Y8PdEqZ70l9tS88bYYpEUzGsk3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oa6uFIoSuzcf0zlvgGVvuHsBcLL4d+kMFtZLlsjhozy9Ka1Z+xsWU6lLhUALuKApbfr3UUmR5YbUb41flaEzgYW3RBCCK3v/Uqj7DCKO7GAYjExnu8uZDRgw+b5fbxr8XbiSae6Eu5f1MmLTJJnFp0LFLhCnDHjVyK9Kv3pKhJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rmtW6paZ; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rmtW6paZ"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-86cba60d4f2so2864547b3.1
        for <live-patching@vger.kernel.org>; Wed, 02 Sep 2026 02:40:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788342039; cv=none;
        d=google.com; s=arc-20260327;
        b=Ns6vqzyC/ActCj7/CWGn1J7W/RP3s0gA/JE9CY6TTBr3iVE5HSdJUIrOMsQLpQyq6D
         klLxfNWxOuqWDcM5x73OIneo8Jr1KQvZM6iY11uIaUvom8lVQeRtkfouMS8gPwCnoFFO
         wEGP9fGystIXxVXK0o7TuKQAque1Fg/G0baMkwBFPEErX9fAZqZ/KmPcuzDCPAuFRkzz
         DjvTy9fGZPFTSCar20mu5vEFuIiyBCGu8u8sh8lzPDBHlBuM80BXrWpqS7N8F3l/1blK
         jBmN90VhR6ekHIM+rofZnnr4MuTNCBzkHBvrFVuQrbaBo2GeMTboGWRpF+/KW+6OgCHg
         xXvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XO5/geKL/0UgYD5wNvzo08BofDPaE4kvQPv9HsySbLw=;
        fh=loReIVq+dAD9UqNyHaOZo+TR5ZpD434568NOKOc3M58=;
        b=G8cC/b1fgDA1ppQ7gameCwAxPKS1VP11BpiP4tHdax/nwbTknCQzfsV1oyv+af9znz
         8Lzekj8GAey985E9bHANVOH+hCQO9SSpQWSkxHJrf3m4pnSZnhrd60Ds9P4nwe9Ac6GL
         TFGB8p3kP3v5cAPdoaBhCL9m0sjjavAfdncky4/wcNItyaYM6DUlLPnunNx1FSRgCvOD
         Jkfny+eZol0OkEUfF1vMYxhgZis39nKgVP6yAMabg7GK8gep1tPlN1Qx8LECkbeT9E9Q
         wn0nxo+lGo2iTEdvV0V6XT3IHib11k0OhUaF/tzYihfKKDoMJMMcxCte+sB4kSQ/O4LV
         KRIw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788342039; x=1788946839; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XO5/geKL/0UgYD5wNvzo08BofDPaE4kvQPv9HsySbLw=;
        b=rmtW6paZti5lpqH0f7yr6kKIlADWdFsvMJ9Fj/JWJhrCsDGuje+3U+nJFl1J4bSgmg
         IwkdWwsf4Wpq2x9xlpxLdjoMCrXj4vGoe3y6PYU7J/QP3d5JL21s1lD7if/0WtTJGaBB
         jDxI+O/caKWYHpzfa1j/z3JgbAUyYIoOWi9xWUg/pHYSsgu0dp+NmtK42yzplug803xD
         lPZ0/GPgzQagTZM6CoAdyU775l4UUeLjWr3j1x+rc/NxiGGlD1Zew/ZBSXoJM2tcu2E2
         xCwl0Li82tXQCs54SJIsxhyucL+n0do8HIOJJd0MnJrBaqnGn1DOUSzAKUhXIYrr71oa
         nOsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788342039; x=1788946839;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XO5/geKL/0UgYD5wNvzo08BofDPaE4kvQPv9HsySbLw=;
        b=U+SYiozYFKHalOQsNxkLFY8lWfcu1G2wP3V/jx3g8yMac+CrRmcJyC1lyHZ+voEVt1
         NDkrH2LUlXvbFQyCjIdGr6mf8LPQNHrkUSMgRBtBt7ztSDxpO/ok/W8YmiCRd1gXHOT6
         emJwLIPAf58z+UXA58AtUYpVgNGbZfxhRRJd5fxSfnfV4tBh/GDBOYM1pYCNEAqEmoSp
         gOzlJ6Oxl3ZCxo1S8cdVjX0N2vGyenbjvih7c74AnIkTThZb2g3z2tYmEUZ72bRNDocd
         bUXo3Ubg4FUSN2FmttS5zr9DoDRid4Wq0M9bde9McxHwJcTYWnkeFsBumUi8L/5ZhMC+
         p7xQ==
X-Forwarded-Encrypted: i=1; AKwUvBxeY+KwV/kAyptKITY9wppbGVV+qsNwASdwaaH4Mtz0MWxKS+H5TNefOtoS1Dg/DCj0agZJF2Ehg455bKN3@vger.kernel.org
X-Gm-Message-State: AFuF++nKqS26yP4OhWS6pg+3zxS48uONAol5r4CbwXz+T6Ror55FjkYa
	mZ3yxnwKHnu8ARx5etqgWt88Y8cf1jvBpUF8cYrcRKYVzDB5l87PuE3uXNT+UZdRebE1oTPJto3
	6mrt+8QIzIGK0lkDb+AhdT/8a5vys3uM=
X-Gm-Gg: AYBFou3fxsF1EWBqhFOG1+SambpYMuum1gjxhoPsGSub6H/gi2FLXmcpsMJfyVAeS1E
	R0UYP8QNXBKENSIBXBx8eGdd2n6bIf17JfRr87Yd8WkDqBfy/v1Yg0tZSC/y8tIiU/GDg6U7EB9
	GVRoYbqKw33i6uifPbya8srA1pyyw2s3VaAmpBUl9zyIfmAAIw+yDZR5MV2xZvJUtrvOp+Q4UAc
	UtjUcCttgBrTjhmUg9fTkIQI23NceW5SHKZyWtTdsnO5RhiR382IZHEXMImoI+LHmMql++tmYTD
	1qBxAgDhi2FfM1uDBq0cQ64BcaWU351rJ1mmqN6YNPuk7Zvj7ynCPeNy9kMydGdbtodvxJssMCq
	gvA==
X-Received: by 2002:a05:690c:c01c:b0:80c:5cfa:34bc with SMTP id
 00721157ae682-86c4e9bfbcemr13768297b3.11.1788342039121; Wed, 02 Sep 2026
 02:40:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825114641.80452-1-laoar.shao@gmail.com> <20260825114641.80452-4-laoar.shao@gmail.com>
 <apfQ6c_3giN615Ll@pathway.suse.cz>
In-Reply-To: <apfQ6c_3giN615Ll@pathway.suse.cz>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 2 Sep 2026 17:40:02 +0800
X-Gm-Features: AcwNN1UXAvx0gUCE91G9X23dQ3znMoTmqBbkjegOcES4aC6hid3M6jNdtalVr38
Message-ID: <CALOAHbAb3Hiv5HZ0b0r_GjqCpZRx53Yq-NJo=eo7PxE_tD9asQ@mail.gmail.com>
Subject: Re: Replace rules: was: Re: [PATCH v7 for-next 3/8] livepatch:
 Implement replace set for scoped atomic replace
To: Petr Mladek <pmladek@suse.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, 
	joe.lawrence@redhat.com, song@kernel.org, live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 3:31=E2=80=AFPM Petr Mladek <pmladek@suse.com> wrote=
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
> > --- a/include/linux/livepatch.h
> > +++ b/include/linux/livepatch.h
> > @@ -123,7 +123,8 @@ struct klp_state {
> >   * @mod:     reference to the live patch module
> >   * @objs:    object entries for kernel objects to be patched
> >   * @states:  system states that can get modified
> > - * @replace: replace all actively used patches
> > + * @provides:        only one active livepatch per id
> > + * @obsoletes:       replace given livepatch id(s)
> >   * @list:    list node for global list of actively used patches
> >   * @kobj:    kobject for sysfs resources
> >   * @obj_list:        dynamic list of the object entries
> > @@ -137,7 +138,9 @@ struct klp_patch {
> >       struct module *mod;
> >       struct klp_object *objs;
> >       struct klp_state *states;
> > -     bool replace;
> > +     unsigned int provides;
> > +     unsigned int *obsoletes;
> > +     unsigned int nr_obsoletes;
>
> This is a different sematic in compare with the other arrays.
> I guess that you wanted to allow obsoleting livepatch with '0' ID.

right.

>
> But '0' is special. It obsoletes anything. Maybe, we could
> make it even more special and say that it can't obsoleted.
> Then we would be able to use it as the trailing element
> in the array...
>
> I do not have strong opinion about this. It is just an idea.

Making '0' special is good for backward compatibility, but it
complicates usage for users. Therefore, I prefer not to treat '0' as a
special case.

>
>
> Another question:
>
> Should we allow to enable a livepatch when its provides id
> is obsoleted by a currently enabled livepatch?

Good question.
I believe it's best to refuse to load it, as doing otherwise might
introduce potential issues. I will update this rule in the next
version.

>
> For example, let's have:
>
>   + Livepatch A: provides:1
>   + Livepatch B: provides:2, obsoletes:1
>
> Now, two scenarios:
>
>   1. Livepatch A can be replaced by livepatch B. This is easy.
>   2. Can livepatch B get replaced by livepatch A?

No, I don't believe B should be replaced by A. In this case, if B is
already enabled, A should fail to load.

>
> The current code would allow to replace B with A when there is
> _no_ real conflict in the livaptched objects, functions, and states.
>
> But does it make sense?
>
> Reasoning: Livepatch B obsoleted the livepatch A for a reason.
>         It sounds like they should not be enabled at the same time.
>
>
> Special case:
>
> Should we allow to install a livepatch with non-zero provides
> when a livepatch with zero provides is installed.
>
> For example, let's have:
>
>   + Livepatch A: provides:1
>   + Livepatch B: provides:0
>
> Now, two scenarios:
>
>   1. Livepatch A can be replaced by livepatch B. This is easy.
>   2. Can livepatch A be installed in parallel with B?
>
> Reasoning: The livepatch B replaces everything because it wants
>         to be the only installed livepatch. It sounds weird
>         to "break" it by installing A in parallel later again.

So, let's just not treat '0' as a special case?

--=20
Regards
Yafang
