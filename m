Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669E54DAFAC
	for <live-patching@vger.kernel.org>; Wed, 16 Sep 2026 17:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789580468; cv=none; b=ODrAUZaGhn0ttxh4lePP1FTECL+R7ozSlCg6mu8iJ/tIQSSm9XXbYOKl3c+/Va3bs+XBm3bm+zloosxxdsbsioQOcyKgAItiKzibIU2esp6uzq/+7gOLxAMdwLmbDlK/o18JY0hr3LcfCiqE8WvoeS2lOUJ2i5nvQe6WBSNZIM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789580468; c=relaxed/simple;
	bh=dxpwpG48vHd326uWo5d0W130oDui6n80/LDZ23KFy7o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HvLkxPNevTGRdazGloWdpixlFQekEZU865dFIJJ3S5aFF7qPXpKePwh6Uf0ziJbogPQVR1KPN+jfEXbovgB0OKcR03osmqA7uAgRNyLEvMPqQ/ub7lzAjID5UHva4uM5Z3hm8L0uUZPgyGKVbG47ZThD+yPDT7ADw+5tkIjvWnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dn+ESpl1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dn+ESpl1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D25921F00893
	for <live-patching@vger.kernel.org>; Wed, 16 Sep 2026 17:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789580464;
	bh=KPJMRVcZ1s4lZbJv6amD0f260CpHAJxAnWW0OxZC/9o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Dn+ESpl19rVdEMnK+i6VRRlfXh9VyfNXYWpliTInPglT2dYDtCYwMNs7xVofjDxGq
	 5QVBrOF7tIH2ybRPewEaKZ8t5ggCq7pn7NJhCXDa9ch+mo3ZCMrJahv9zSYZqDtsOk
	 5bFrnZMTqOYgKM0aZfUNPVKgBeAc+g7AejX0NmJCCbUuaNWRUxkyVnEkYXI2HBTdHc
	 haJQsGcp40BEwYpeeDUl1sJ1EoP8tqvQIfkvvawLM9tIr5ZvnJtvcNQo7iM6HIZBg9
	 JOuxJkalcgOfhpvdO1h6kk703dijpfFGxpWmkr6RydWRmZ3cKXUtmFf5Yd8/NJaj20
	 md3qnT0b+oYRg==
Received: by mail-qk2-f27.google.com with SMTP id af79cd13be357-939ca12ab70so125489585a.1
        for <live-patching@vger.kernel.org>; Wed, 16 Sep 2026 10:41:04 -0700 (PDT)
X-Gm-Message-State: AFuF++lsnYdW5ecxOyCk7GYlsZ2Lp3cWPVXj6FUqOhuwCYYCqLbNdBQZ
	kUpCSIw4cCcgXumrvR2M01RGr8B/K7+zWofmgr4T7qlf8LeQZ9zOxDzUL7nc22pROlUsTyI2/w8
	6Vol6v9lOjW3LoY1t3QLdh/F/RUdgWpc=
X-Received: by 2002:a05:620a:4504:b0:939:6132:62cc with SMTP id
 af79cd13be357-93bb785a7d3mr572863485a.27.1789580464038; Wed, 16 Sep 2026
 10:41:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915233454.2405019-1-song@kernel.org> <20260915233454.2405019-34-song@kernel.org>
 <20260915234848.1C5841F000FF@smtp.kernel.org>
In-Reply-To: <20260915234848.1C5841F000FF@smtp.kernel.org>
From: Song Liu <song@kernel.org>
Date: Wed, 16 Sep 2026 10:40:52 -0700
X-Gmail-Original-Message-ID: <CAPhsuW56bXdhyMNKgZoRax=HFuSWLMNiXXBBZeHTO5QzpEk5dg@mail.gmail.com>
X-Gm-Features: AcwNN1UFxqkvoloSfliZkS4CRYGAHV4QPyW_K9nHAMhD4PPtorlRWq8GnC2v2rw
Message-ID: <CAPhsuW56bXdhyMNKgZoRax=HFuSWLMNiXXBBZeHTO5QzpEk5dg@mail.gmail.com>
Subject: Re: [PATCH v4 33/58] objtool/klp: Add test for new references to
 exported symbols
To: sashiko-reviews@lists.linux.dev
Cc: live-patching@vger.kernel.org, jikos@kernel.org, mbenes@suse.cz, 
	puranjay@kernel.org, joe.lawrence@redhat.com, kernel-team@meta.com, 
	jpoimboe@kernel.org, peterz@infradead.org, pmladek@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 4:48=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] objtool: test omits allowed module dependency case
> --
>
> commit f7100fa9cd984257015aa5ab4b28f4c57a67cb53
> Author: Song Liu <song@kernel.org>
>
> objtool/klp: Add test for new references to exported symbols
>
> This commit adds a test to verify the behavior of objtool livepatching wh=
en a
> patch introduces a new reference to an exported symbol. It tests both vml=
inux
> exports and undeclared module exports.
>
> > diff --git a/tools/objtool/tests/generic/fixtures/new_export_ref.c b/to=
ols/objtool/tests/generic/fixtures/new_export_ref.c
> > --- /dev/null
> > +++ b/tools/objtool/tests/generic/fixtures/new_export_ref.c
> > @@ -0,0 +1,20 @@
> [ ... ]
> > +/*
> > + * A reference which only exists in the patched build.  The symbol has=
 no twin
> > + * in the original object, so what klp diff may do with it depends ent=
irely on
> > + * whether Module.symvers says it is exported, and by what.
> > + */
> > +
> > +static const char __modinfo[]
> > +     __attribute__((section(".modinfo"), used, aligned(1))) =3D "\0nam=
e=3Dvmlinux";
>
> [Severity: Medium]
> Does hardcoding the object name to "vmlinux" in __modinfo prevent simulat=
ing a
> module patch? It seems this might make it impossible to test the allowed =
module
> dependency path.
>
> > +
> > +extern int newly_referenced(int x);
> [ ... ]
> > diff --git a/tools/objtool/tests/generic/test-new-export-ref.sh b/tools=
/objtool/tests/generic/test-new-export-ref.sh
> > --- /dev/null
> > +++ b/tools/objtool/tests/generic/test-new-export-ref.sh
> > @@ -0,0 +1,34 @@
> [ ... ]
> > +export_syms
> > +add_exports other_mod newly_referenced
> > +run_diff 255
> > +assert_diff_log 'undeclared module dependency'
> > +
> > +pass "new reference allowed to a vmlinux export, rejected for a module=
 export"
>
> [Severity: Medium]
> Does this test omit the allowed module dependency case? The script assert=
s that
> new module exports are strictly rejected, completely missing the scenario=
 where
> they are allowed (when a pre-existing module dependency exists) as descri=
bed in
> commit 72d76d0c18eb.

Adding a new case in v5 to cover this case.

Thanks,
Song
