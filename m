Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7694D49B5D9
	for <live-patching@vger.kernel.org>; Thu, 10 Sep 2026 21:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789077598; cv=none; b=TjebQp3CTDYh7xyRLhJwa+YhJbnVEwExCQ0uR1WOsvGHmNv4yPiCsohIbQyb3X7CToHxdh3M7Ygt28qKE+q6cr7+01OQGWXtqI2HIreZU2MiGxl1w75j0ccZ6GuA6M8gMcytYdsh5OhbMrFFCqqPayF2oBjpMncXnS7YfsXWm/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789077598; c=relaxed/simple;
	bh=dA1s9egCac7HuWOZ0ym0DPuEA647TpSZpBFicau1Go8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P8+pm3KeQv/fHvcORUdvPQwY9BW7lq1bB6oBSVpm6+8FF1JsD376IZmOek1cg+ZPfGx4iDVapHYkuk1yIG4PvMGj7Hhl+BYWdx7Ox5juRXXQ/VH+ky9bs9F30L20Q5P/sXEX17hb70MeEbCwVfBEqBZ3OhLj3j4vrSxLtTWLfOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZhcaXcOu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZhcaXcOu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 070B31F000FF
	for <live-patching@vger.kernel.org>; Thu, 10 Sep 2026 21:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789077596;
	bh=tC8Aswk4UztqImAdEWDmAGfFDgdlcEaDTEg2MB6bjxY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ZhcaXcOucup3kndHjSS19b4EitdTp1vx+BtwiNT/lU63qgiJGPXGjZM6QVQw1KSQr
	 zLwDLLDZ+WKHl1tILmRSO4/kBd3kHHHOaEYO6TPmsauQWHFP7ftH8OyYLR3XGjTEXG
	 btaQeSFRYfNJylq/B/V0Y9PFTNC7FcvcqYKlVyRnS0QpN+84Ghs+lLvMxR7rtKiebR
	 eJn8pvV7jw1v96LgXB7YH3Mscnq8PczrJgMNTs3YJNxZiSYHGIkX9lVpUKcfU2sqbU
	 kxeDthKTyM0ywjFDFTYMCMSRa7hrzO/y1ihmAkhSiyuhQN1gt4eGBN7Ia8rAz+XiTM
	 fg5SICBFq4qsA==
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-9399a1c21c1so17977585a.3
        for <live-patching@vger.kernel.org>; Thu, 10 Sep 2026 14:59:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByZ+nyLmSxvnENtVpaXkmLDHnzsQV9wBHYg3NklO9RBX5tVip6Q6rYEO8iINlWx5AO9BZc+GW8S4csn2+Nw@vger.kernel.org
X-Gm-Message-State: AFuF++nF4YKLoGHFA+MHRdw+oAZOKJCVXS5ihaKSMlZkYSPDMxOxjA+u
	sYM0pGESdK4SsqNg3+61HMsmTAadEOb9rP+af7uWwKl9AjcRYLoKBCXuA+JNBzXfg7fGu4cxY4p
	q1N1uBOwxDLW+Gtvh+FQa3zuq1EIRMf0=
X-Received: by 2002:a05:620a:171e:b0:939:35e5:94ba with SMTP id
 af79cd13be357-939ea105fafmr131046385a.6.1789077595344; Thu, 10 Sep 2026
 14:59:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825114641.80452-1-laoar.shao@gmail.com> <20260825114641.80452-4-laoar.shao@gmail.com>
 <apfQ6c_3giN615Ll@pathway.suse.cz> <CALOAHbAb3Hiv5HZ0b0r_GjqCpZRx53Yq-NJo=eo7PxE_tD9asQ@mail.gmail.com>
 <apk9f_LsGRYHzN0Z@pathway.suse.cz> <alpine.LSU.2.21.2609091424420.10918@pobox.suse.cz>
 <CAPhsuW6OVt8oYr3YW9MbapXi6Z97CF-7J0fHXakKYkvvOp6A_Q@mail.gmail.com> <alpine.LSU.2.21.2609101029080.608@pobox.suse.cz>
In-Reply-To: <alpine.LSU.2.21.2609101029080.608@pobox.suse.cz>
From: Song Liu <song@kernel.org>
Date: Thu, 10 Sep 2026 14:59:43 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4hEe9aj=Fgcr85x3yi4Ob8ohcc2bRkRSYPtoy6+D4F9g@mail.gmail.com>
X-Gm-Features: AcwNN1WNXW6LXQzQTdvOqSk_dCYtMJTjoHIWVKMT3XZj9WKayABgYknzC4hY0DQ
Message-ID: <CAPhsuW4hEe9aj=Fgcr85x3yi4Ob8ohcc2bRkRSYPtoy6+D4F9g@mail.gmail.com>
Subject: Re: Replace rules: was: Re: [PATCH v7 for-next 3/8] livepatch:
 Implement replace set for scoped atomic replace
To: Miroslav Benes <mbenes@suse.cz>
Cc: Petr Mladek <pmladek@suse.com>, Yafang Shao <laoar.shao@gmail.com>, jpoimboe@kernel.org, 
	jikos@kernel.org, joe.lawrence@redhat.com, live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 1:31=E2=80=AFAM Miroslav Benes <mbenes@suse.cz> wro=
te:
>
> On Wed, 9 Sep 2026, Song Liu wrote:
>
> > On Wed, Sep 9, 2026 at 5:32=E2=80=AFAM Miroslav Benes <mbenes@suse.cz> =
wrote:
> > [...]
> > > >
> > > > It might be useful for OS providers who want to make sure that thei=
r
> > > > kernel critical fixes can be installed on the user system. Otherwis=
e,
> > > > customers might complain that some update failed, ...
> > > >
> > > > Of course, it has a drawback that any livepatch with ``prov ides=3D=
 0``
> > > > would wipe any 3rd party livepatches, even when they are against 3r=
d
> > > > party modules.
> > >
> > > My intention was not to regress and disallow a use case which is curr=
ently
> > > supported. That is to replace everything applied no matter what.
> >
> > I am curious about this use case. Do we really have users who:
> >   - Load patch A, with replace=3Dfalse;
> >   - Load patch B, with replace=3Dfalse;
> >   - Load patch C, with replace=3Dtrue, replacing both A and B?
> >
> > I think this is not good practice anyway. Instead, users would either u=
se
> > a bunch of patches with replace=3Dfalse; or only load one patch at a ti=
me,
> > and keep replace=3Dtrue for all of them.
> >
> > Did I miss any reasonable users or use cases here?
>
> I am not aware of anyone specific but the scenario above does not look to=
o
> crazy to me. And the experience taught me that if something is possible,
> there is definitely someone out there doing it. However, as I said, I
> think the current implementation of the scoped replace should be enough
> for everybody. If not, we will learn about the use case in a couple of
> years.

Agreed that current version is capable to cover all these cases. Let's
ship it. :)

Thanks,
Song
