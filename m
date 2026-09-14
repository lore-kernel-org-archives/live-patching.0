Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DB5490C1C
	for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 19:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789415572; cv=none; b=dCFmq8SR0KgRNcNM1fKKAAzeyn5iKq9A09I2Vond4jAM+BrmjSRDulU4QFoG0VlzsjuVPh733OZ5pMg8QhRvdfzgfcVgUQVsk1ro0ORiRoXQt9z6iu7plT7EvsrANttlWx/9s1W0ibhQtIXxs9VpyQWSBEIWnVBvvbDBQzOX/+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789415572; c=relaxed/simple;
	bh=tBnKPHKbQF4/+sshJ5lDUvnmcBdfLWpNulWGrNkziJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rX73vyBGpuJRFCeJXqmKHC9xfzNgBBkzH26SGf8SKrrILYOWBktq3JY7d2K4gE4ELc+u7Tga7ixaUhMmVXQ3wZYTKl2iaOyBpXXB4lUtRsNUGcv11wbqdq78rD4GPC31+wTn6RssgaxgXJkMgQbUTZ1PjhjE5YjIrPN21nrHdXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C9TkjpHQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C9TkjpHQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7E011F0089E
	for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 19:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789415568;
	bh=NCRCQOwCdlxdC2Xk4UsHu6fuiCgej9VScIjR7G5rl4U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=C9TkjpHQHZFATwMBNSAc5GpMKk7QlOfi3AqKJP+xFcei7glxr4LQlyJiq9APlgHWg
	 pG61Ivp6dCWpAJnB6I+X7IcBHzOGGoCNNd8BdEDurHO8hMlpAfigl4WvRmy8P8/1bi
	 ov3fJLnpqKsazdAs3dBJlsppoNiXQ6UPxIgf5eAD1nP4ke4qWX3T8Ni9+i8PtLqNga
	 a7IYfcWdaVIJxnDsL07dLOsF0Fe5i6H8ohMGAlL+sp3FHKDs22Mj0tAN+ARr88gvIa
	 BNlQX9bJDl4Zo0XT/AaLqORf0t/cH27A2NpALcjKod7s90FD2fr0l9Q9Jv+4x2VaQV
	 gLHnjCVRa6Mdw==
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-93a00298c53so179243985a.1
        for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 12:52:48 -0700 (PDT)
X-Gm-Message-State: AFuF++mYnhsKm8KKReODTJW9ZyHrH1mxA7iyevhxkHwwJjzWrBpOpK3T
	i87oTtaotQ+kTAJrgjxbwmkFEywiHq4QIYsnSHJmdEo0M4LkqBCDSB7nZqIxChBTivdWy1luteV
	KUnZT4hLwdiXB9U7IyigEyXw20v4lmIc=
X-Received: by 2002:a05:620a:2a03:b0:93a:1048:7d2f with SMTP id
 af79cd13be357-93a29a19943mr589250385a.41.1789415568027; Mon, 14 Sep 2026
 12:52:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914062514.926997-1-song@kernel.org> <20260914062514.926997-6-song@kernel.org>
 <20260914064122.F118C1F000FF@smtp.kernel.org>
In-Reply-To: <20260914064122.F118C1F000FF@smtp.kernel.org>
From: Song Liu <song@kernel.org>
Date: Mon, 14 Sep 2026 12:52:36 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5edxhb5x4Tvzptzpp1VJW0VjB4pOJaVE9ztJUnWQFJZg@mail.gmail.com>
X-Gm-Features: AcwNN1XXYfGSuEtoHUJZtd3HR-ham_tQsSrQDVtJuHgg9_7u6-dZfQzJ0aP-jYM
Message-ID: <CAPhsuW5edxhb5x4Tvzptzpp1VJW0VjB4pOJaVE9ztJUnWQFJZg@mail.gmail.com>
Subject: Re: [PATCH v2 05/58] objtool/klp: Build klp test fixtures through the harness
To: sashiko-reviews@lists.linux.dev
Cc: live-patching@vger.kernel.org, jpoimboe@kernel.org, kernel-team@meta.com, 
	peterz@infradead.org, joe.lawrence@redhat.com, pmladek@suse.com, 
	jikos@kernel.org, mbenes@suse.cz, puranjay@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 13, 2026 at 11:41=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 3 potential issu=
e(s) to consider:
> - [Medium] The global `orig_obj` and `patched_obj` variables are not rese=
t by `build_pair()`, causing state leakage between sequential test segments=
.
> - [Medium] `make_vmlinux_pair()` masks malformed test invocations as tool=
chain deficiencies, resulting in silent test skips.
> - [Medium] `run_objtool_check` fails to invalidate the `.checksummed` cac=
he flag after modifying object files in-place.
> --
>
> commit 19435afd8ba9b070d7a97986a8ecde2ed711708b
> Author: Song Liu <song@kernel.org>
> Subject: objtool/klp: Build klp test fixtures through the harness
>
> This commit refactors the objtool livepatch testing harness to standardiz=
e
> fixture compilation, abstracting build and linking routines. It extracts =
object
> creation and checksum generation into helper functions. It also adds logi=
c to
> handle vmlinux pairs and properly sequence objtool checks.
>
> > diff --git a/tools/objtool/tests/lib.sh b/tools/objtool/tests/lib.sh
> > index 7185198253bb7..0a9da178f4dc8 100644
> > --- a/tools/objtool/tests/lib.sh
> > +++ b/tools/objtool/tests/lib.sh
>
> [ ... ]
>
> > @@ -211,17 +224,64 @@ clang_only()
> >       declared_skip "clang only${1:+: $1}"
> >  }
> >
> > +# build_one <fixture.c> <output object> [cflags...]
> > +build_one()
> > +{
>
> [ ... ]
>
> > +}
> > +
> >  # build_pair <fixture.c> [cflags...]
> >  build_pair()
> >  {
> > -     local fixture=3D"$FIXTURES_DIR/$1"; shift
> > +     local fixture=3D"$1"; shift
> >
> > -     [ -f "$fixture" ] || fail "missing fixture $fixture"
> > +     build_one "$fixture" orig.o "$@"
> > +     build_one "$fixture" patched.o "$@" -DPATCHED
> >  }
>
> [Severity: Medium]
> Does this code leave orig_obj pointing to stale data if run after
> make_vmlinux_pair()?
>
> If a test sequences its segments so that make_vmlinux_pair() is called fi=
rst
> (which sets the global orig_obj=3Dvmlinux.o), and then build_pair() is ca=
lled,
> build_pair() does not reset orig_obj to orig.o.
>
> Would this cause a subsequent run_diff() to erroneously diff the stale
> vmlinux.o instead of the newly built orig.o?
>
> > +# run_objtool_check <objtool arguments...>
> > +#
> > +# Run objtool's ordinary check pass over the pair, as the kernel build=
 does.
> > +#
>
> [ ... ]
>
> > +run_objtool_check()
> > +{
> > +     local obj
> > +
> > +     for obj in "$orig_obj" "$patched_obj"; do
> > +             "$OBJTOOL" "$@" "$workdir/$obj" ||
> > +                     fail "objtool $* failed on $obj"
> > +     done
> > +}
>
> [Severity: Medium]
> Can this function leave a stale checksum cache in place?
>
> Other functions that create or modify objects, like build_one() and
> partial_link(), remove the $workdir/.checksummed marker.
>
> Since run_objtool_check() executes objtool directly on the test objects, =
which
> can append new sections like ORC metadata, should it also remove the
> .checksummed file to prevent subsequent run_checksum() calls from skippin=
g
> generation and using stale checksum data?
>
> [ ... ]
>
> > +make_vmlinux_pair()
> > +{
> > +     local orig=3D() patched=3D() seen=3D arg
> > +
> > +     for arg in "$@"; do
> > +             if [ "$arg" =3D -- ]; then seen=3Dy; continue; fi
> > +             if [ -n "$seen" ]; then patched+=3D( "$arg" ); else orig+=
=3D( "$arg" ); fi
> > +     done
> > +
> > +     partial_link "$workdir/vmlinux.o" "${orig[@]}" ||
> > +             probe_skip "partial link unavailable"
>
> [Severity: Medium]
> Will this silently mask test definition bugs as toolchain deficiencies?
>
> If a test author accidentally malforms the arguments by omitting the --
> delimiter, the $orig or $patched arrays will be empty. Calling partial_li=
nk
> with empty input arrays would correctly fail, but capturing that failure =
here
> and executing probe_skip masks it.
>
> Doesn't this contradict the commit's design principle that a fixture whic=
h will
> not compile should be a failure rather than a skip?

Fixed in v3. Thanks!
