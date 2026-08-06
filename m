Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F363D47BF
	for <live-patching@vger.kernel.org>; Thu,  6 Aug 2026 20:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786049496; cv=none; b=r4W5QUXRkEDKLC1aKOcBm9paz54nYh+hKJ4bSAAhSqn8RwyXf92PEcox39yZVxyieQvxUtRQYw0/bcVDpczrIfnGs9ujIRlFVIWGOh9/3nzhVYgieq4dCQZjyi378FRYP5uPXtMwhZIP6Z8esb8qLSknSy/yo8vlrc1e/tB/hKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786049496; c=relaxed/simple;
	bh=XSr4jiIN+IbLU5OWkGzLTRf7CRvEGItFML2nDQdSJkU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N+jaeOO57y700GVJWFti8e9z3o4FBFhQka3qGVxjPjtTdePMvIkIvX3YzS4HEpkyzQE8AI+NQjPofqaUF45zAPm9wQBd1VruO3d+I+fc3k7MNWbgmpgj5kTP/4Yll0qImXIRYUQ3Ea5Frx9vDd3sA5Ya2qechzf5ACsu2m3dagw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BDZFqDQk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BDZFqDQk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB8A71F00A3F
	for <live-patching@vger.kernel.org>; Thu,  6 Aug 2026 20:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786049494;
	bh=UyFkqO8eyZy1bfK31eDmPTdvIXytfNIs/515ao8PabA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=BDZFqDQkryr90ckCWRTN7SpL3/yHL0GFgCxN6uJUiWHmT3/ajtplNU/W77X19x49J
	 ArsJtgseukKeTxFKKrZI4j+SB632kyCwaSNvC4ikha2OqEXjC1177AyCWNIx3rpBCA
	 oRXz7x3e8OnLRQzIxiqSJM5Drqenn5KFDgkBg3kPeWjNKeeVArF1OEQUFQQ6eeipc6
	 LEc/X9OcHAjT2dquHILRCwGP4cUfXtg697mfyw/pbpxI8KOwjsJx5tWRqSvWorRbco
	 VQqPK0+Qz6MRxPWb9HSzjxTH+6y/KwiGpIhFiEwjDbGiNxoiS/nUWk5xONfFjBd2Aa
	 eVhxzogujnXwg==
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-930f618435cso180273585a.3
        for <live-patching@vger.kernel.org>; Thu, 06 Aug 2026 13:51:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rq3zkSeJUJnqvT5lFkGM/xXB0azh8tvqRfLULQuQPs7nNy6gkD5asdy+skCWedde2XLXAe+DYkYv+YVpmgm@vger.kernel.org
X-Gm-Message-State: AOJu0YzpaO9I9S7Db1+sbXux1q+/uFuRfBkq5FF80B1DT2NoTIt47/t9
	OGWt12GxmnYnmzPwYiW7t16qeUZotNPMDrKmdyVJPcTRK/9sr/4snonjFOT6cmTQZlVepqD3nZl
	kIbMb3R4eycrQXwm6eswG+4gc7jM/EMM=
X-Received: by 2002:a05:620a:a809:b0:934:ab73:ac53 with SMTP id
 af79cd13be357-93648e27310mr1711283985a.0.1786049493909; Thu, 06 Aug 2026
 13:51:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1785939903.git.jpoimboe@kernel.org> <d9debc941bd06c1a606ed7a366bff73d1680f0f8.1785939903.git.jpoimboe@kernel.org>
 <CAPhsuW69pBfEzN=apAzQkSgY+FJvxeukgydNZwYSrpA6+kQ42Q@mail.gmail.com> <a7ljeflolo25c22ay4uawzwmqueimkio452fgyf47turjmbvsh@qzc3coik37yq>
In-Reply-To: <a7ljeflolo25c22ay4uawzwmqueimkio452fgyf47turjmbvsh@qzc3coik37yq>
From: Song Liu <song@kernel.org>
Date: Thu, 6 Aug 2026 13:51:22 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5eDasiSJSiHaMFKy+eK6dF_0nBzFD=7HyhXzGBoUPfOw@mail.gmail.com>
X-Gm-Features: AUfX_mxWb8AaeyYW_nq6rFuNJpcY23mPwsK2M5o8OFHJ9Otb7pt5F7khdWissaw
Message-ID: <CAPhsuW5eDasiSJSiHaMFKy+eK6dF_0nBzFD=7HyhXzGBoUPfOw@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] objtool/klp: Fix size of empty special section entries
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	live-patching@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Joe Lawrence <joe.lawrence@redhat.com>, Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 10:11=E2=80=AFPM Josh Poimboeuf <jpoimboe@kernel.org=
> wrote:
>
> On Wed, Aug 05, 2026 at 01:36:26PM -0700, Song Liu wrote:
> > On Wed, Aug 5, 2026 at 7:30=E2=80=AFAM Josh Poimboeuf <jpoimboe@kernel.=
org> wrote:
> > >
> > [...]
> > >
> > > diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
> > > index 492d7a012cffe..11e8f3ddbb0e6 100644
> > > --- a/tools/objtool/klp-diff.c
> > > +++ b/tools/objtool/klp-diff.c
> > > @@ -1627,6 +1627,7 @@ static int create_fake_symbols(struct elf *elf)
> > >         for_each_reloc(sec->rsec, reloc) {
> > >                 unsigned long offset, size;
> > >                 struct reloc *next_reloc;
> > > +               bool last =3D true;
> > >
> > >                 if (annotype(elf, sec, reloc) !=3D ANNOTYPE_DATA_SPEC=
IAL)
> > >                         continue;
> > > @@ -1641,10 +1642,11 @@ static int create_fake_symbols(struct elf *el=
f)
> > >                                 continue;
> > >
> > >                         size =3D reloc_addend(next_reloc) - offset;
> > > +                       last =3D false;
> > >                         break;
> > >                 }
> > >
> > > -               if (!size)
> > > +               if (last)
> > >                         size =3D sec_size(reloc->sym->sec) - offset;
> >
> > Some comments about "last" logic here can be very helpful.
> >
> > Also, with the last flag, "size =3D 0;" before the for_each_reloc_conti=
nue()
> > loop can be removed.
> >
> > Other than these nitpicks:
> >
> > Acked-by: Song Liu <song@kernel.org>
>
> How about this on top?

Looks great! Thanks!

Song

> diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
> index 11e8f3ddbb0e6..38fae861d12c7 100644
> --- a/tools/objtool/klp-diff.c
> +++ b/tools/objtool/klp-diff.c
> @@ -1634,7 +1634,10 @@ static int create_fake_symbols(struct elf *elf)
>
>                 offset =3D reloc_addend(reloc);
>
> -               size =3D 0;
> +               /*
> +                * Find the start of the next entry so the fake symbol si=
ze can
> +                * be calculated.
> +                */
>                 next_reloc =3D reloc;
>                 for_each_reloc_continue(sec->rsec, next_reloc) {
>                         if (annotype(elf, sec, next_reloc) !=3D ANNOTYPE_=
DATA_SPECIAL ||
> @@ -1646,6 +1649,10 @@ static int create_fake_symbols(struct elf *elf)
>                         break;
>                 }
>
> +               /*
> +                * If no next entry found, this is the last entry, so its=
 size
> +                * is from the current offset to the end of the section.
> +                */
>                 if (last)
>                         size =3D sec_size(reloc->sym->sec) - offset;
>
