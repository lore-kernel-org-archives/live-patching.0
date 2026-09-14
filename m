Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF395396D1A
	for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 18:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789411842; cv=none; b=jc1oQU5W/DW3fo8BkzOEus5flh2MXLyUs9SNy4EvA0PU6E648wMrVoMDxP2r3xt9iLc+y0fAzZGcGwvO4IsE0ltLNLiIPk1CjgmfKC3mVWa6rlWLXvMbUQffa5A3PLUl1lD2DhwZ7zz9P9OF2tEg8y/AbKXmVTWaDS2cMDlccHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789411842; c=relaxed/simple;
	bh=E9q1DJdg0472QlXMjxwYvaljUHOOvgxBJY7nyPZKCME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MRG1+Kbrw2XAQtYrLUcm6y+oT44FTqyqZYPo+c37YJVxJahih959Md6Mv1yobH53JPfP0QXPiJayd4kZTsPwhbR3pTUDZl4BPaV3CmmhEuas39BjHbl6FZeO+UfC2HPs5ybYga24ZzStrJwvq/7Nhz59mN7y+NPVz5z+HD2Hjwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l76juJDK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l76juJDK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 916C31F0089F
	for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 18:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789411840;
	bh=ZPlZzEDD1mFZWNrLhXM48j7ztWTsjBkQryMVet4AyjQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=l76juJDKykcTaLyfx/V2NZWjhS18kmWF0N8uNb2BfdheCbGkdiCYo+OwNisK+/Saf
	 Wq8PjcNXtxYk5kI2ByTugiF/5mI7vzEXpBc6jPoAwvTfx/KtiPrsfoKFPKiqJlFQgQ
	 7a4VpKXPltn9lt9cVnoQczfOq8Lg3QZNGtD6HTtO1ECojXow6z4nW82UAIvyCKMf/x
	 gZul4BOAh56hhNezctBuqkydnJ2lWBR8Nw7K5Su7z6cOlTBAJEhrze7A7xSMeURrxn
	 87UoZg/Ij52WtsS33iVzJDAfJGa59JyF8rjtPUca6Sy3c3SmW5yMXvRD8rg26uAd+g
	 dtxPpUtL45ajA==
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-939b5ded99dso361840385a.2
        for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 11:50:40 -0700 (PDT)
X-Gm-Message-State: AFuF++nf4iPV0iNv4kyaXITjbM7HYCTt/cNW/nv6ZdnUlhhMsSZ8N3DH
	SC9rmL694O4f4PkcGleSEu+yxKhfGw3lo197Hzj5WHoXFQEWdESJ8BjRe4fZB6zF4w+hp0EjprV
	AUPmhYzV6blY+G2PyPFN6dREXWnIJOZo=
X-Received: by 2002:a05:620a:6504:b0:939:13a7:70f0 with SMTP id
 af79cd13be357-93a297251cbmr564811685a.5.1789411839763; Mon, 14 Sep 2026
 11:50:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914062514.926997-1-song@kernel.org> <20260914062514.926997-5-song@kernel.org>
 <20260914063950.CE1F21F000FF@smtp.kernel.org>
In-Reply-To: <20260914063950.CE1F21F000FF@smtp.kernel.org>
From: Song Liu <song@kernel.org>
Date: Mon, 14 Sep 2026 11:50:27 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4C7gB38T4GdEDCc8O=CmbVSMQ639AeBWwd8tfmTbT62A@mail.gmail.com>
X-Gm-Features: AcwNN1VLWJ01ullAT8oDW2BrT9LU5DNk8famPpHVoi1dvYsxnzaM6jbYvo5NsKU
Message-ID: <CAPhsuW4C7gB38T4GdEDCc8O=CmbVSMQ639AeBWwd8tfmTbT62A@mail.gmail.com>
Subject: Re: [PATCH v2 04/58] objtool/klp: Classify klp test outcomes
To: sashiko-reviews@lists.linux.dev
Cc: live-patching@vger.kernel.org, mbenes@suse.cz, puranjay@kernel.org, 
	joe.lawrence@redhat.com, kernel-team@meta.com, jikos@kernel.org, 
	jpoimboe@kernel.org, peterz@infradead.org, pmladek@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 13, 2026 at 11:39=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Low] Literal `$'\n'` string is appended instead of a newline character=
 during TAP output manipulation.
> --
>
> commit df7f112de2ce31cfbac30c00e5d997457d3c2710
> Author: Song Liu <song@kernel.org>
>
> objtool/klp: Classify klp test outcomes
>
> This commit introduces better classification of test outcomes for objtool=
 klp
> tests, distinguishing between different types of skips (declared, probe,
> undeclared) and TAP directives (xfail, xpass). It modifies the test runne=
r to
> explicitly handle these cases and improve result reporting.
>
> > diff --git a/tools/objtool/tests/run-tests.sh b/tools/objtool/tests/run=
-tests.sh
> > index 48728a98d9950..6b937fc7f5bda 100755
> > --- a/tools/objtool/tests/run-tests.sh
> > +++ b/tools/objtool/tests/run-tests.sh
> [ ... ]
> > @@ -23,31 +61,99 @@ cd "$(dirname "$0")" || exit 1
> [ ... ]
> > +     case "$result" in
> > +     *"# SKIP (declared)"*)  static_skip=3D$((static_skip + 1)) ;;
> > +     *"# SKIP (probe)"*)     probe_skip=3D$((probe_skip + 1)) ;;
> > +     *"# SKIP"*)
> > +             # An undeclared skip: the test gave up for a reason it ne=
ver
> > +             # said it might.  That is a hole, not an expected outcome=
.
> > +             #
> > +             # Replace the line rather than adding one.  Every test ow=
es the
> > +             # plan exactly one result, and a consumer counting them i=
s
> > +             # entitled to say so when the totals disagree.
> > +             rest=3D"$rest${rest:+$'\n'}was: $result"
>
> [Severity: Low]
> Does this append a literal dollar sign and single quotes instead of a new=
line?
>
> When a test fails via an undeclared skip and has already produced other o=
utput,
> the test runner attempts to append a newline to the rest string. Due to B=
ash's
> double-quoting rules, the $'\n' syntax is not expanded inside double quot=
es and
> is instead appended as literal characters. This can garble the terminal o=
utput.
>
> > +             result=3D"not ok - $(basename "$t" .sh): undeclared skip"
> > +             result=3D"$result (use gcc_only/clang_only or require_inp=
ut_*)"
> > +             fail=3D$((fail + 1)) ;;
> > +     "not ok"*"# TODO"*)     xfail=3D$((xfail + 1)) ;;
> > +     "ok"*"# TODO"*)         xpass=3D$((xpass + 1)) ;;
> > +     "not ok"*)              fail=3D$((fail + 1)) ;;
> > +     "ok"*)                  pass=3D$((pass + 1)) ;;
> > +     *)
> > +             # No result line at all: the test died before reporting.
> > +             rest=3D"$rest${rest:+$'\n'}exited $rc without a result li=
ne"
>
> [Severity: Low]
> Is it possible this will also append literal characters rather than a new=
line
> when a test dies without outputting a valid TAP result line?

This doesn't seem to be an issue.

Thanks,
Song
