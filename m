Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A843DA7C5
	for <live-patching@vger.kernel.org>; Wed, 16 Sep 2026 17:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789581109; cv=none; b=qoRltMYaQKSV8+QHU9bXTQKuxyqEUnK4K/pM/Z3+6i7wmWWKmG/7b6w/WSpsIkN7p6utYpecew/bi54ya8feFm9pd50W/uh1up3OI2nYn2KiAjcyUEswVaKr84eULkfT9EKQQfXbETn1QWPzEyDx08w6E5GBgDdadQHsHqL36vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789581109; c=relaxed/simple;
	bh=3A0G5Pe4pAFm0TGQ5xi1dN+pSR4EjRNmAAtc5zTHkek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oUajaGQQ12SEpSjj0ft/RBLv5SO54m8rvKO1ZS5FLR8cg09Fej76gQrVxQEUWC9bYTkqqZkJQAp6Q1WfJ/EZmQzQidhlB3nlbxAzfC1cbs4EoyI8Ta4fAFiSMW7Fa8/9JAC6OpOxyBu/dufovKyR9j1xeW9Jgl3zRpYcPtnVxsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ortTXmU3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ortTXmU3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F0EC1F0089D
	for <live-patching@vger.kernel.org>; Wed, 16 Sep 2026 17:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789581103;
	bh=0f4GMOSvUelDjB9gU1KrvKiigwJDQHiQeS+xocAliVM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ortTXmU3urYQB+jxjAsDdXrDGCpA7t7hnEy+xg7moECEJTeInVUzFiiQW3Kg0IfrE
	 To3VWJw4viu9hRo/dGDg5aH5u3eBZgMvyzrhBnkC/EaewQCpBBVbbOiFVgo2suwlto
	 VeGe/VKc7B+4uVdE2gGLKvl9h7l6wjBe10Fvp5sCMZ31Oeoj7QtxFy6O4CNbu2p4qy
	 cyTgi83C8INAzo22fq0F4daM7QpoYF66LyP/KtwP9GXWDgqjNgGXj7rD21OfqOXCgC
	 TbQT3SoAt78dVl5oJsp7XLzULS26yT6gLMh/TdUm893m/Lx8cHN2lsN7IhpFvzhqoW
	 Rw6oVvudHZw1A==
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-910399d8b09so8214176d6.2
        for <live-patching@vger.kernel.org>; Wed, 16 Sep 2026 10:51:43 -0700 (PDT)
X-Gm-Message-State: AFuF++lg4f1FRUUC4Tjr4ybUSu8wnH3mn2k43Y3OZ2jZk++t3J0mX6Ef
	qLyF8W4szImAGQMiUzlLEqOgAtZN8M/SAsRq/0TDCjos/blHt9X66LY89Vft2Z3bgUBASDXcPk9
	1s2Hin+o0oDBlKwVas2GMarKfzY5oyNc=
X-Received: by 2002:a05:620a:199d:b0:936:69dc:aedf with SMTP id
 af79cd13be357-93bb77391b6mr538479585a.16.1789581102702; Wed, 16 Sep 2026
 10:51:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915233454.2405019-1-song@kernel.org> <20260915233454.2405019-40-song@kernel.org>
 <20260915235145.23B361F000FF@smtp.kernel.org>
In-Reply-To: <20260915235145.23B361F000FF@smtp.kernel.org>
From: Song Liu <song@kernel.org>
Date: Wed, 16 Sep 2026 10:51:30 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5K7m8wB4bKYgq-ys0RAOLMz24qS3uo0v=c=OXXDKZCxw@mail.gmail.com>
X-Gm-Features: AcwNN1Xh9HJokIjXM3hI92EWJHWBeZg10HeoyHdk13UI84F4ktYjpCfS9bkBJkg
Message-ID: <CAPhsuW5K7m8wB4bKYgq-ys0RAOLMz24qS3uo0v=c=OXXDKZCxw@mail.gmail.com>
Subject: Re: [PATCH v4 39/58] objtool/klp: Add test for static locals which
 must not be correlated
To: sashiko-reviews@lists.linux.dev
Cc: live-patching@vger.kernel.org, kernel-team@meta.com, jpoimboe@kernel.org, 
	peterz@infradead.org, jikos@kernel.org, pmladek@suse.com, mbenes@suse.cz, 
	joe.lawrence@redhat.com, puranjay@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 4:51=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] objtool: klp test regex fails on architectures with small data=
 sections
> --
>
> commit 4400f73b697d110a1f506b61da1421c4d22b7608
> Author: Song Liu <song@kernel.org>
>
> objtool/klp: Add test for static locals which must not be correlated
>
> This commit adds an objtool livepatch test to verify that certain static
> local variables are properly uncorrelated in patched functions. It checks
> that .data..once flags and per-instance variables use a fresh copy, while
> ordinary static locals remain correlated.
>
> > diff --git a/tools/objtool/tests/generic/test-static-local-uncorrelated=
.sh b/tools/objtool/tests/generic/test-static-local-uncorrelated.sh
> > new file mode 100755
> > index 0000000000000..fa4ce88a79b1e
> > --- /dev/null
> > +++ b/tools/objtool/tests/generic/test-static-local-uncorrelated.sh
>
> [ ... ]
>
> > +
> > +# Not correlated: no klp symbol, and a copy cloned into the patch inst=
ead.
> > +out_symbols | grep -q '\.klp\.sym\..*__key' &&
> > +     fail "__key was correlated; it must use a fresh copy"
> > +out_sections | grep -qE '\.(bss|data)[^ ]*__key' ||
> > +     fail "__key was neither correlated nor cloned"
>
> [Severity: Medium]
> Will this grep pattern cause spurious test failures on architectures that=
 use
> small data sections?
>
> When compiling for architectures like PowerPC or LoongArch, the compiler =
might
> place small variables like __key into .sbss or .sdata rather than .bss or
> .data. Since the regex strictly expects .bss or .data, it appears it will=
 fail
> when small data sections are used.

I don't have PowerPC or LoongArch to test. Claude proposed something
like:

   out_sections | grep -qE '\.s?(bss|data)[^ ]*__key'

which allows .sbss and .sdata in addition to .bss and .data.

I will use this version in v5.

Thanks,
Song
