Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2E92652A2
	for <live-patching@vger.kernel.org>; Wed, 12 Aug 2026 04:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786509437; cv=none; b=SJOZVTrrYFLBYaN08mQXGM9z+RGtAH4gqXontgbW/vuZnEYSyNsYBEuuRbeGARFPSpD9JNQPodGsdlVlHCWIBM58K1gkWVKMm6Xo4y2TKfBL2eouGjLvj6R48ziH031iNJikd/EfT+/Sj0HXP0CV4hEIbNcWOn2U9FnJVq3dNl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786509437; c=relaxed/simple;
	bh=otf6oxPGIjdIm0v7VBrfNHwCaKStPO4F2JguUj9sgF8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OBiVNj+nhTORI5OYkgL9HWMv4w0qZV9DbIgbPTzTqGreWYK8gs5AMropo65aF5DQIFnqg07uoDcf+Y4PHScv2N6AK7C2VEsZjOWbbx/19LI9wCwEafQX4LSHytSFVcE+zOUlG9mP6GcDWvyb2PYeOf2oyhdgq+rCve5I5wtoRdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U78vCJUP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U78vCJUP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 308451F00ACF
	for <live-patching@vger.kernel.org>; Wed, 12 Aug 2026 04:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786509436;
	bh=NCqe/cWdK02FXGYSKzeyf0hCLxGe4BK/FM5s+h5uvo4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=U78vCJUPw56xZVuQli7wgT/yJXtN299A+KwaRMmtgLv5B0H5zAdX6HnEl8ftYByDC
	 ox6H1PXda35qd2TE81PUcShh0rEPJsuuW7wuk0PN7gQi4XBYfG2sF1xX//nrAmBjP8
	 GAMJ4bl0gHzkw7lV3GlCsddECFRM+2omzzY7fZ4NF7OsDBiS7P/R6lSGPs6SS/EP2p
	 DCV2yykEkDzQKKAXNKnZ/YOXKu1VKklSdHTm+8xczF+9mATWxSoUeejKfIREWOMuoW
	 CV7TxJwH+E3eukgw1YYm1mE8pdUnz4Ac9AsUluKpJ+3VmVP/V9JhNEixaWkHDZLs8B
	 8uutqlAxX0j0A==
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-92e57a753f9so56758385a.2
        for <live-patching@vger.kernel.org>; Tue, 11 Aug 2026 21:37:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RryOGrytk5ANGjW1NHQsCGC/a7sgMyodejXOKx2v5dg2ttXWlwy7oDGdU5eQePYrrlo+OTl0uVOSEAvdEYM@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ7GOk6UtbTWSxFLqYM/M33Ctgw/WE1HwfON/7JObrvKJMYAhc
	7beVxvx84ugsUnT2Qpic/k5njEI+cAheDiiMO/QrZ7yoTaUQD7H4T7nlcgNdK5zCj9PvirtPV8V
	Ud3CbCsVbuiO0ihgVnBn396Vw2b6Z9kM=
X-Received: by 2002:a05:620a:640c:b0:92e:f3ca:2eaf with SMTP id
 af79cd13be357-936b3ab4f51mr216275785a.11.1786509435420; Tue, 11 Aug 2026
 21:37:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1786230311.git.jpoimboe@kernel.org> <11e49187e13d36d4257bc60cd2606e0ff5481dfc.1786230311.git.jpoimboe@kernel.org>
 <CAPhsuW5tzBOHnw42d31r_5k9eS28VrDLGXoUzS=hYkZmAyRbhw@mail.gmail.com> <anu-Xbm02J7BgCIb@jpoimboe>
In-Reply-To: <anu-Xbm02J7BgCIb@jpoimboe>
From: Song Liu <song@kernel.org>
Date: Tue, 11 Aug 2026 21:37:04 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7Vdni1Bj7b9R_yR6TKvOYSbKDjz0qdWkfN6jO1JAYNSw@mail.gmail.com>
X-Gm-Features: AUfX_mzumLt3KMIKcIkcajkuhs4AijZt-NTw4ovfnyo-dTYEWOlhHsOVoBjk0Sk
Message-ID: <CAPhsuW7Vdni1Bj7b9R_yR6TKvOYSbKDjz0qdWkfN6jO1JAYNSw@mail.gmail.com>
Subject: Re: [PATCH v4 15/22] objtool: Prevent kCFI hashes from being decoded
 as instructions
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	live-patching@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Joe Lawrence <joe.lawrence@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	Mark Rutland <mark.rutland@arm.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nsc@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 5:30=E2=80=AFPM Josh Poimboeuf <jpoimboe@kernel.org=
> wrote:
>
> On Tue, Aug 11, 2026 at 04:58:05PM -0700, Song Liu wrote:
> > On Sat, Aug 8, 2026 at 4:18=E2=80=AFPM Josh Poimboeuf <jpoimboe@kernel.=
org> wrote:
> > [...]
> > >
> > > +/*
> > > + * ARM64 mapping symbols ($d, $x, $a, __pi_$d, etc) which mark trans=
itions
> > > + * between code and data.
> > > + */
> > > +static inline bool is_mapping_sym(struct symbol *sym)
> > > +{
> > > +       return is_notype_sym(sym) && strchr(sym->name, '$');
> > > +}
> > > +
> > > +static inline bool is_data_mapping_sym(struct symbol *sym)
> > > +{
> > > +       const char *dollar;
> > > +
> > > +       if (!is_mapping_sym(sym))
> > > +               return false;
> > > +
> > > +       dollar =3D strchr(sym->name, '$');
> > > +       return dollar && dollar[1] =3D=3D 'd';
> >
> > nit: is_data_mapping_sym() calls strchr() twice. Maybe we can
> > optimize it by eliminating a strchr()?
>
> I suppose it's a bit funky, but the compiler CSEs it, so it's harmless.

I see. Then this should be fine.

Thanks!

Acked-by: Song Liu <song@kernel.org>
