Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B6D35C6B0
	for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 18:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789411180; cv=none; b=Xl9IM8FF3HHZ1fC0LjkKQVPwAEdQA5jeaCbvAVzAvAH7w/UbksiSFnxhLeBN1Dphb9cHkXsfRz6bps4lVH2LsQtFua643I6XxMDKzZ8ZEwRpFdfrm/Zww0bjsFEmxl4ytCseTUhgpXWwVQi6Gfc8t4aJG5K0WP3dyMvdhBw0izM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789411180; c=relaxed/simple;
	bh=0cjHsYPE4uzApcMmEedWQHQQybBBsMRH52pqMeGxe6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YcHUYOpnPlhW/aqmAkOOiVYJ/Igph/UtWJtdxj8wvNwfMiuAqJ8+T0cHmHHHn54dAp5oiXKGlgkGxDutnMQ8BXU3jU0l79l4JWFf1IJx/8eudRvd9w6ptdYU+KcNntslzO83Y+i0Yg68NmGcEA8hO0TQmku/fD55qD3NRRYiwhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nZiT0CY1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nZiT0CY1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70CA51F000FF
	for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 18:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789411178;
	bh=9gPO7vsbHabM/rxLVUYdhRPBBqKMntRT1m25EdVzS3E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=nZiT0CY162+oEfO8rreFGvhdpAR2CPKVj4tfSdp2CBrhyZEI+32bMRWKNvRwOPcYl
	 G1J2KSmy+TBTdAGg72xkD18NWmNQGJXguAycKY+Xfcs5jPYHp+GWoJ9V0OlE3OuEF3
	 kDuDLjysVavCqBaAP2hfYATpEeu9Ny9JvgauhbDmYaYQa+vuO2Lru8DnCfCWcG8viq
	 0hzBLi+afKxQY5vWEtnBi+awjhkLmVVK1WDvGCtKA12I42XjMVkKJ7y53hFzFRhPZa
	 Vc3fPmAjpKgrHcjqMZ+wP+YNn+/HZqC1p41aEvAo9v8mF9BE0qBnm7ycK5EmxGPh0t
	 z3oEux255bQFg==
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-939eb3249c1so301424185a.2
        for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 11:39:38 -0700 (PDT)
X-Gm-Message-State: AFuF++kF/sco4tXj2NCpV291z3Ui2b6eEDjf3/QC5S8yf+l4TfxkbvBk
	/e1kqAFZcOgOnGxgxpf4twIp9558ofnj/8J6la8r+H0DVnhssVGntybgyJaQFra0xVE3hd5Ve+3
	eKFeyYKfZDXE0ZGi6N0GAfF4gQ34vgrE=
X-Received: by 2002:a05:620a:890e:b0:939:2c5c:7977 with SMTP id
 af79cd13be357-93a29855523mr691895685a.20.1789411177574; Mon, 14 Sep 2026
 11:39:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914062514.926997-1-song@kernel.org> <20260914062514.926997-3-song@kernel.org>
 <20260914063745.7D8EE1F000FF@smtp.kernel.org>
In-Reply-To: <20260914063745.7D8EE1F000FF@smtp.kernel.org>
From: Song Liu <song@kernel.org>
Date: Mon, 14 Sep 2026 11:39:24 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5i0Kdmdx-4mn8w3AY8b1x9m2kYEHGAAt9muzSbgWOu7Q@mail.gmail.com>
X-Gm-Features: AcwNN1XIxiTJzpMs4h0zJm-HLRQTbp-DnYzC6713whLZkq_8rNDQmlWLzQYfzL8
Message-ID: <CAPhsuW5i0Kdmdx-4mn8w3AY8b1x9m2kYEHGAAt9muzSbgWOu7Q@mail.gmail.com>
Subject: Re: [PATCH v2 02/58] objtool/klp: Check the klp test environment
 once, before any test
To: sashiko-reviews@lists.linux.dev
Cc: live-patching@vger.kernel.org, pmladek@suse.com, kernel-team@meta.com, 
	jikos@kernel.org, jpoimboe@kernel.org, peterz@infradead.org, mbenes@suse.cz, 
	joe.lawrence@redhat.com, puranjay@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 13, 2026 at 11:37=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Low] Tool existence checks for READELF, OBJCOPY, and LD will fail if t=
hese variables contain CLI arguments, incorrectly aborting the test suite.
> --
>
> commit 2ddfaa45c9b45195802f915e9ca42e1e7b224f4b
> Author: Song Liu <song@kernel.org>
>
> objtool/klp: Check the klp test environment once, before any test
>
> This commit adds a preflight check to evaluate the objtool test environme=
nt
> once before the test suite runs. It exports the environment answers and f=
ails
> the entire run if prerequisites are missing, rather than skipping tests
> individually.
>
> > diff --git a/tools/objtool/tests/lib.sh b/tools/objtool/tests/lib.sh
> > index 714371232fa30..6e4e54b108659 100644
> > --- a/tools/objtool/tests/lib.sh
> > +++ b/tools/objtool/tests/lib.sh
> [ ... ]
> > +klp_preflight()
> > +{
> > +     local tmp tool cc_version host cc_arch
> > +
> > +     bail() { echo "Bail out! $*" >&2; exit 1; }
> [ ... ]
> > +     command -v "${CC%% *}" >/dev/null || bail "compiler not found: $C=
C"
> > +
> > +     for tool in "$READELF" "$OBJCOPY" "$LD"; do
> > +             command -v "$tool" >/dev/null || bail "$tool not found"
> > +     done
>
> [Severity: Low]
> Will this check fail if the toolchain variables contain CLI arguments?
>
> Unlike the compiler check just above it which correctly uses parameter
> expansion to strip arguments (`${CC%% *}`), passing the full string to
> `command -v` when it contains spaces (e.g., if a developer or CI system
> overrides `OBJCOPY=3D"llvm-objcopy --target=3Darm64"`) will cause `comman=
d -v`
> to treat the entire string as a single binary name and fail.
>
> Could this incorrectly abort the test suite under valid configurations?
>
Good catch, fixed in v3.

Thanks,
Song
