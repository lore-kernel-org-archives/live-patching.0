Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB5F364058
	for <live-patching@vger.kernel.org>; Fri, 28 Aug 2026 17:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787939545; cv=none; b=qjxtaa4e/FCpFfyFtnQOLqLtvRiOGRvPMJl1Yvr1/wog7JBYEE9avRw85obmU8iGAWDJB50VWbjeKRcPpwktrXV7YINI4VNAtgtPwF9h/rRiIVWyd9DDQaMdf5GbjvPrDhiLYjey+MTb8in0CiyMWwGbCzEAa/lvH7rMmxNAgyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787939545; c=relaxed/simple;
	bh=m1DdmCSN9uEY+DKBCIu+by7nuS2fItCZk6XFGLkO7tY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dyeXWxLxAjlcW7+2jWN/+00wFpNcYR+QA9jdQB8JNYGZvMkN8Z2hdy+FTvZXVacYLJay28K2IupPCaTqhB9iSM45kGzZJMOxifwEyPiNBgYn9uhqXVb0Uz33350mOFQcCGwvaupecbJ0o4TwHmpTWNx+HEKTQkD/btlKNHH41Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CHZ8nZyo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CHZ8nZyo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C17AC1F00A3D
	for <live-patching@vger.kernel.org>; Fri, 28 Aug 2026 17:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787939543;
	bh=m1DdmCSN9uEY+DKBCIu+by7nuS2fItCZk6XFGLkO7tY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=CHZ8nZyoDho0A/kqSs6ClYzH9i5HI3Rp1WkoQHoAYGYdEod3vuKiiuM/4m9+wr3ZD
	 txbJRdkmeG7a2Nqfk0D+iQj7h9l1bO+gC/ixqfIfzVhgFrSzZmKkYuxef+6+tGNdsE
	 J8RJY5HScXSTJuq2cgQkFT0UaySzSQZVdXYI9TsjGzHPjTKBV+HV6u9JByUL2BDuxE
	 CRmJBwrsf7Fj5f4Ttm/+wv8e5vtH+uj8/qStHQ8piYGPs6odHm8BY0xo1icunzqakg
	 nrDps1Cf8m0iNeH3z8SQHeB0Jw/1RYv9UyIX6bbCmCuQ28kkNIUINIhVlebwpAfY3T
	 MXvmzf0NE6UNA==
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-84e27035206so1183506b3a.3
        for <live-patching@vger.kernel.org>; Fri, 28 Aug 2026 10:52:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpBBVek2nTTnnrVcDX+pPYxRfocTT1Kw3244xXs+ddxrCvgHU9zPH6qCIrIZvl+s/85F1n/S/00ZP0mvqRP@vger.kernel.org
X-Gm-Message-State: AFuF++m3Y7ka9EOXIdv/P2ozNz9RDpLJ3T1qY9PBJgISPa55PksZk60W
	SqtP7nBVtmMNqRrh0ySSi084Hp3FSRWF5l4LA2Fw1lR5qNEGQHXPpz3cKHCR3jlwfY/8M4SQ3Lq
	RC0pkrUFFA63fIGk3oBTGewlsRlMh2Xg=
X-Received: by 2002:a05:6a20:cfa8:b0:3d3:b00b:50fc with SMTP id
 adf61e73a8af0-3d3b00b6d05mr2436803637.28.1787939543472; Fri, 28 Aug 2026
 10:52:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <apBbjoEHJ98DWN_W@pathway.suse.cz> <20260828125244.509977-1-pmladek@suse.com>
 <20260828125244.509977-2-pmladek@suse.com> <CAPhsuW72hqxThCfDWY=gXffwcGvGL62pwhwMgE-39AGEv7DvCw@mail.gmail.com>
 <apHH5-VsffdBQtuX@jpoimboe>
In-Reply-To: <apHH5-VsffdBQtuX@jpoimboe>
From: Song Liu <song@kernel.org>
Date: Fri, 28 Aug 2026 10:52:10 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6e7YzfTP_Qs1fmh=JTvDGLM6oF-x=FOgGf6eN5ox7CEw@mail.gmail.com>
X-Gm-Features: AcwNN1X5yhd3bVqoCnf-JSL7X4LNHA7YKvg_AWovSQV5reUrhiIXcik9L5af_X8
Message-ID: <CAPhsuW6e7YzfTP_Qs1fmh=JTvDGLM6oF-x=FOgGf6eN5ox7CEw@mail.gmail.com>
Subject: Re: [PATCH 1/2] livepatch: Move code for updating livepatch object relocations
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Petr Mladek <pmladek@suse.com>, Harry Hsu <x90613@gmail.com>, mbenes@suse.cz, 
	joe.lawrence@redhat.com, jikos@kernel.org, live-patching@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 10:41=E2=80=AFAM Josh Poimboeuf <jpoimboe@kernel.or=
g> wrote:
>
> On Fri, Aug 28, 2026 at 10:02:09AM -0700, Song Liu wrote:
> > On Fri, Aug 28, 2026 at 5:53=E2=80=AFAM Petr Mladek <pmladek@suse.com> =
wrote:
> > >
> > > klp_free_object_loaded() is supposed to clear changes made by
> > > klp_init_object_loaded(). It should call klp_clear_object_relocs()
> > > which is currently defined later.
> > >
> > > Move the code for updating object relocations up.
> > >
> > > This is just a preparation step. No functional changes.
> > >
> > > Signed-off-by: Petr Mladek <pmladek@suse.com>
> >
> > Do we really need to move them? I think adding a function
> > declaration is cleaner for git log/blame, etc.
>
> Personally I prefer a cleaner end result (put the function where it more
> naturally belongs), though I wouldn't object to combining them into a
> single patch.

Noted. It is indeed a trade-off.

Thanks,
Song
