Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B37647044E
	for <live-patching@vger.kernel.org>; Thu,  3 Sep 2026 21:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788470314; cv=none; b=IKJLoN3eUI367JAEv8gJ0RtxyFkg+xN9SEcsYFYj1B3kb9XHg7WGVgXSPLj9ggvpA7s4sgrEYWXxMzyov6N42/UZSVEUXegJjk/ZXjGOvXJdXfQjWkVkDvmdIVqHDUtVOrlb2gAR8MDFMZZRrkQ/KwJmq97AYV2BTA9YWuAjvPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788470314; c=relaxed/simple;
	bh=ZNhT5YbawNeK38uD8bMLp7GNfbfBJvvuPpzqb7Mj23s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L5yY1ShxNcnMFfwfpdAcaiQOU0ED4GncxG9jlo4yO/7yLqEV/wI0s4X1mNKQcn5j3jDKLGdtulkmTuAu9FdfRr4sJnGd0JYG+IRT/Z7cbU1GmFlj8rt0Jckx2cWACbS/44xtkMMHOsHkcjXg6Kd69NN6NadL9LovTMOJDURkuGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Opm1seZA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Opm1seZA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43ACF1F000E9
	for <live-patching@vger.kernel.org>; Thu,  3 Sep 2026 21:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788470311;
	bh=yBT/w4H1nByHxcEeE8KfgBIAkWuXul7cj6fIHk2LA4U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Opm1seZAWbwLB3gOKwv4wiqRV8C+B6wphNNDt978lUbEWVSQgn5bcANQzuULfcylP
	 SeuTeWDSvu3IGHhgkV6dvkgsnLGo2SZgDGX06Np1EOVyRhDCDOZ7T9U91b7PcOrQvb
	 Rh71L2fjOUUzgvOBHA7CUIzY3k23tM5tmbCvdIeVPfa3je86UrPUKqBcHQeH/bLCPp
	 k82Pe1cKH35DakXeWZmeEMbFZe06mD1+Sg0KsKxpH0eAhQcM63j5Fav2eRBh7gKXm/
	 3N6Mwh28hxyBZMkHN2KRpdBXx1NcXOuU8Zxdln8lZx6rUX+Gv0u+DJsxkeQxdfeGrT
	 BJaQVmzPYmKew==
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-92ea24a2dbfso38625785a.0
        for <live-patching@vger.kernel.org>; Thu, 03 Sep 2026 14:18:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBz6YXUXoRYBQ0KXecise20/Wv8gK3xfX5xPdSVDPkw/0DlDeK40Dr68BSbNE5qnSoqUN8cnAPkTcsf+3t13@vger.kernel.org
X-Gm-Message-State: AFuF++nauVv/EogjNOLd3OmeovLPFGfrOa0r24torO1JWCheGtp/JHrA
	pBvcxcEG8OWu3ujQulwiNdN91cj/RduCKPrdI1o9oW5y25kaDjIlMyDq8z8x6A0WT1V3KBlLRUX
	pKffHH4RtUaQGu6AzkjtRztWVcoo7l68=
X-Received: by 2002:a05:620a:4443:b0:92e:5d44:73fc with SMTP id
 af79cd13be357-939805cd179mr103565585a.12.1788470310565; Thu, 03 Sep 2026
 14:18:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825114641.80452-1-laoar.shao@gmail.com> <20260825114641.80452-4-laoar.shao@gmail.com>
 <apfQ6c_3giN615Ll@pathway.suse.cz> <CALOAHbAb3Hiv5HZ0b0r_GjqCpZRx53Yq-NJo=eo7PxE_tD9asQ@mail.gmail.com>
 <apk9f_LsGRYHzN0Z@pathway.suse.cz>
In-Reply-To: <apk9f_LsGRYHzN0Z@pathway.suse.cz>
From: Song Liu <song@kernel.org>
Date: Thu, 3 Sep 2026 14:18:18 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4sac0Xzumm0sRPXTy7Pe=OZucA4RDEBmmgF-e_fT_tqA@mail.gmail.com>
X-Gm-Features: AcwNN1WvABViPozAs2xN3ws_olz2nLOEbUfEbUoU7nNy6ixTG4KcCLekIEzvoXE
Message-ID: <CAPhsuW4sac0Xzumm0sRPXTy7Pe=OZucA4RDEBmmgF-e_fT_tqA@mail.gmail.com>
Subject: Re: Replace rules: was: Re: [PATCH v7 for-next 3/8] livepatch:
 Implement replace set for scoped atomic replace
To: Petr Mladek <pmladek@suse.com>
Cc: Yafang Shao <laoar.shao@gmail.com>, jpoimboe@kernel.org, jikos@kernel.org, 
	mbenes@suse.cz, joe.lawrence@redhat.com, live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 2:27=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrote=
:
[...]
> > > Reasoning: The livepatch B replaces everything because it wants
> > >         to be the only installed livepatch. It sounds weird
> > >         to "break" it by installing A in parallel later again.
> >
> > So, let's just not treat '0' as a special case?
>
> I am not sure.
>
> I personally think that '0' should not be special. A better solution
> for a forced cleanup is the "replace_all" module option.

If we want '0' to be special, let's make it "not replace anything".
Then folks who prefer to have all the live patch loaded at the
same time have an easy solution.

> The module option would need to be implemented in the livepatch code.
> But it will need some support in the livepatch core as well, either
> a flag in struct klp_patch or parameter in klp_enable_patch().
> IMHO, the flag in struct klp_patch might be more practical.

What is the use case of replace_all?

Thanks,
Song
