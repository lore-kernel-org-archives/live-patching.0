Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3314F390C85
	for <live-patching@vger.kernel.org>; Wed,  9 Sep 2026 18:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788979553; cv=none; b=lDRbo8DutmOcAthXbtucnXJXVtOYMJlBbp5f+Xvb7cqThTkkyx5zDKxaqT5H/X+bG1epxFQIO62jAr37rF+vbL8idBRvGQ7YiCdM79c8zi+6PyBYUb22T9s5iSKzNlL10wTLAzUGk9kVLaqiskZpX4/zki4NbrHXeVX7l07zdvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788979553; c=relaxed/simple;
	bh=Zydztau70fLZSHUtd4yn9s3W7XIdRmEVbfcyS5BEgOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CCmsSwUokh1rxRNgICPvC+a8Mlgv7Hx6869/QK6UmqrSO9DztJqB0nhYz0KE8IQtBtf9RUmJVBV6AdSvOUcme+OKs9wjgBspVMmRl8rQ/oXP+Fbtg8hRgMpt29+vJZRNWWpKP0d+U+50MXESArCh2C6sJp7nzf1CmygHxiyjp8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EPgrPWEp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EPgrPWEp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ADE01F00898
	for <live-patching@vger.kernel.org>; Wed,  9 Sep 2026 18:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788979552;
	bh=kCJBFHK9fnhPpt/u8J2CAPv+PsWUUOY3jn7fr2cghxM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=EPgrPWEpoJr9QenX37DJONQCS3s9pQ1IcJR7u5ul857PB3LClVVWm6/7xq/y3hOE4
	 4HQ+cPgqtEwDd1oQ9/uNCQbkpIZAZL36W2tLlsIuEGxgjtADUag4Z1zQj+SKXYSdrk
	 8h/IY3YqK1YtYSAklqOGkkcqntIcDUzJUECmcJ3XhP8QadDyueLfpv2BNPANACjIDP
	 1H64tEubKZit4kF6H+6dsUpZLxXExqSWcGeYcnaqO/lVW/jlstOau5CM5FqWDCqhDC
	 9Y5TgckqmRQUxIpLAdCiMtX8XVh+kcwAOPVkEfWFlrboGvTeoq3sChqWhr9ejwpP9C
	 ij2vceVbRacVw==
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-939695b5741so51983285a.1
        for <live-patching@vger.kernel.org>; Wed, 09 Sep 2026 11:45:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBykDUz4O2FylhpAGBvC/cguOzCDwtizZEG2eIeCMZu0s4YBZAvru9h/MeuECeaTGGSTD13iWc0uMU16O6uG@vger.kernel.org
X-Gm-Message-State: AFuF++kebKAOuymlfrJAaQsSmoNwmV7GXyuMyTfTQPiy6tVWaVa7ckcw
	iPS3M4TSu7w/QX0ixlBDOCqZGFJUTiGXurb5vZt9pugqdKLEa8+hD8FdrP+30axi/3T7LTX9BMG
	49QsJe8Y49aZvChwYaxgRFzGSN4nn3uw=
X-Received: by 2002:a05:620a:440c:b0:937:80a9:94b4 with SMTP id
 af79cd13be357-939d4919d54mr324031085a.2.1788979551226; Wed, 09 Sep 2026
 11:45:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825114641.80452-1-laoar.shao@gmail.com> <20260825114641.80452-4-laoar.shao@gmail.com>
 <apfQ6c_3giN615Ll@pathway.suse.cz> <CALOAHbAb3Hiv5HZ0b0r_GjqCpZRx53Yq-NJo=eo7PxE_tD9asQ@mail.gmail.com>
 <apk9f_LsGRYHzN0Z@pathway.suse.cz> <alpine.LSU.2.21.2609091424420.10918@pobox.suse.cz>
In-Reply-To: <alpine.LSU.2.21.2609091424420.10918@pobox.suse.cz>
From: Song Liu <song@kernel.org>
Date: Wed, 9 Sep 2026 11:45:38 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6OVt8oYr3YW9MbapXi6Z97CF-7J0fHXakKYkvvOp6A_Q@mail.gmail.com>
X-Gm-Features: AcwNN1XeMUayLuVQfOAAcPDeZRe3miHCm9WPNUuurlXNrFpJWaYcmaovl7FP8wI
Message-ID: <CAPhsuW6OVt8oYr3YW9MbapXi6Z97CF-7J0fHXakKYkvvOp6A_Q@mail.gmail.com>
Subject: Re: Replace rules: was: Re: [PATCH v7 for-next 3/8] livepatch:
 Implement replace set for scoped atomic replace
To: Miroslav Benes <mbenes@suse.cz>
Cc: Petr Mladek <pmladek@suse.com>, Yafang Shao <laoar.shao@gmail.com>, jpoimboe@kernel.org, 
	jikos@kernel.org, joe.lawrence@redhat.com, live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 5:32=E2=80=AFAM Miroslav Benes <mbenes@suse.cz> wrot=
e:
[...]
> >
> > It might be useful for OS providers who want to make sure that their
> > kernel critical fixes can be installed on the user system. Otherwise,
> > customers might complain that some update failed, ...
> >
> > Of course, it has a drawback that any livepatch with ``prov ides=3D 0``
> > would wipe any 3rd party livepatches, even when they are against 3rd
> > party modules.
>
> My intention was not to regress and disallow a use case which is currentl=
y
> supported. That is to replace everything applied no matter what.

I am curious about this use case. Do we really have users who:
  - Load patch A, with replace=3Dfalse;
  - Load patch B, with replace=3Dfalse;
  - Load patch C, with replace=3Dtrue, replacing both A and B?

I think this is not good practice anyway. Instead, users would either use
a bunch of patches with replace=3Dfalse; or only load one patch at a time,
and keep replace=3Dtrue for all of them.

Did I miss any reasonable users or use cases here?

Thanks,
Song

> If I take my SUSE hat on, I think we can happily live with provides being
> set to a random number and be done with it. A customer with their own liv=
e
> patches applied is on their own anyway so we can ignore it.
>
> [ changing hats ]
>
> So I only wanted to preserve the behaviour for a potential user out there
> relying on it. Maybe not worth it if it complicates the implementation. I=
t
> can be emulated using provides/obsoletes and the fact that a
> user/admin/distributor should have their systems under control. If not, i=
t
> can lead to weird states anyway (yes, I still think that allowing
> different parties to livepatch the same fleet is a call for trouble :)).
>
> Miroslav
