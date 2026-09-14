Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6788940B38C
	for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 21:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789419616; cv=none; b=ine6S3jXizroQMG/5A+a2FX5HL2BNHcbdKE3xl2oQ29MEV9HNVQ1fgjkm2LM5bAkFstI6OxnGJGEJBx6kjH9LOVJ2kuPQMfVRkJGR/jZi61afvbNKoJip9Xhf+C0dnbzy1S8WZ4hBs3FUFwxwedRoALyNZ56/M1OnjZPYLn/ypY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789419616; c=relaxed/simple;
	bh=L9lqllNeKNsf8TrePCGxoGJHWQhACcyaX9C0qyK7a+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mHx5/OMXzrCBB6c5PNo9deyStsHD/lIHywnOQi8XTFrqEjqJxkUIPZiSVwji2kmQFbZ2abuwzL2XkugYegbmmEajP68ZHAx0iRoMwh4VM9xlHp68if8QSbQQEGzhzTMmmUoWj68lWQhWHTLXVGD+C5yDnTwVkDjZ694ROV1pBrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4MpjL8y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4MpjL8y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 479A21F0089E
	for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 21:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789419615;
	bh=CiO7ZdmwCpv/3NbmnJYrA2RsCZNp/esQFGO5uV3ucQg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=h4MpjL8yG64EDHN+vqN5RDJ8S2bVves/N2F71gLGUgeW75CCOR8IXW7CkBquKkpIh
	 sKSzxPDpm3VUAXr2Too1jF1SarXgkZw5N0la1il164AVMTEFNM59bfbeWRRTeyT9kQ
	 lZG5x3y3gyxSUj299+ZlfKdOlXBdTpOMaLeGdqlAIFMzYF1RyrOWJGP+1Jra0ijUaP
	 M1rnx6IdR2zT3etlojXd5aSot7O2weYNfPLAFZ/rRL95yJCtTUGQhjyRawvMOMf9zb
	 1ehuvWOlT4zpHxCoAf4Xf0+E1RnDFdybdXDw3u5GL+hYUDIzL3NPFAWMjRo7ZVKIgv
	 C8yY7m36Fd9Yg==
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-9103f5b813aso28271036d6.3
        for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 14:00:15 -0700 (PDT)
X-Gm-Message-State: AFuF++lfpwcLwKlJF6vFinTFJCebDM8dD6PUkIUnFO/VW4CGqRUTN+VS
	LzWiKbafpssi6QJeYUEYtZf9/R3v17nEu8nz3x66eczUnv+0utlNH6jeKX6YnMeiusnaITg0cDD
	FQ+FX0gV8mxGIofzoFzFn/zw3Uoi0hQw=
X-Received: by 2002:a05:620a:438b:b0:93a:214:a4a8 with SMTP id
 af79cd13be357-93a298d58aamr585188785a.23.1789419614337; Mon, 14 Sep 2026
 14:00:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914062514.926997-1-song@kernel.org> <20260914062514.926997-32-song@kernel.org>
 <20260914064653.505A21F00893@smtp.kernel.org>
In-Reply-To: <20260914064653.505A21F00893@smtp.kernel.org>
From: Song Liu <song@kernel.org>
Date: Mon, 14 Sep 2026 14:00:01 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7fZB0Lo4gtTdW_dqcuK4aw9nn+7uJxfuBnCwgi-Qn-uQ@mail.gmail.com>
X-Gm-Features: AcwNN1VzzmTRSz0SrakJHJeLQi3sq0T0pShD_WGFhQYeOdesbaZKARjvjKpvSOo
Message-ID: <CAPhsuW7fZB0Lo4gtTdW_dqcuK4aw9nn+7uJxfuBnCwgi-Qn-uQ@mail.gmail.com>
Subject: Re: [PATCH v2 31/58] objtool/klp: Add test for the contents of the
 klp_funcs list
To: sashiko-reviews@lists.linux.dev
Cc: live-patching@vger.kernel.org, pmladek@suse.com, jpoimboe@kernel.org, 
	peterz@infradead.org, puranjay@kernel.org, kernel-team@meta.com, 
	joe.lawrence@redhat.com, mbenes@suse.cz, jikos@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 13, 2026 at 11:46=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Low] Test script relies on non-portable `grep` features (`\b` and `-w`=
 on non-word boundaries), causing false test failures on BSD/macOS environm=
ents.
> --
>
> commit 4a06859b140cc416baf636400fbe85d7c99ad01c
> Author: Song Liu <song@kernel.org>
>
> objtool/klp: Add test for the contents of the klp_funcs list
>
> The patch list is what livepatch acts on, and asserting only that it exis=
ts
> does not say it is right. The fixture changes two of three functions and
> asserts on all three: the two by name, and the third by its absence.
>
> > diff --git a/tools/objtool/tests/generic/test-klp-funcs-content.sh b/to=
ols/objtool/tests/generic/test-klp-funcs-content.sh
> > new file mode 100755
> > index 0000000000000..c4ec7098d9482
> > --- /dev/null
> > +++ b/tools/objtool/tests/generic/test-klp-funcs-content.sh
> > @@ -0,0 +1,44 @@
> [ ... ]
> > +# The names the kernel matches on are real strings, not just relocatio=
ns.
> > +out_strings .rodata.klp.str1.1 |
> > +     grep -q '\bfirst\b' ||
> > +     fail "no 'first' string in .rodata.klp.str1.1"
>
> [Severity: Low]
> Is it possible to use POSIX regex features instead of \b here? The \b
> extension is a GNU/PCRE feature and is unsupported by BSD grep, which can
> cause spurious test failures on non-GNU platforms such as macOS or FreeBS=
D.
>
> > +out_strings .rodata.klp.str1.1 |
> > +     grep -q '\bsecond\b' ||
> > +     fail "no 'second' string in .rodata.klp.str1.1"
>
> [Severity: Low]
> Does this code also need to avoid the \b extension to prevent false test
> failures on environments using BSD grep?

Fixed \b.

>
> > +
> > +# The object list has to reach the function list, or nothing is walked=
.
> > +assert_reloc_sym .init.klp_objects .init.klp_funcs
>
> [Severity: Low]
> Will this assertion fail on BSD grep? This passes a section name starting
> with '.' to a helper that uses grep -qw.

-qw was fixed in earlier patches.

Thanks,
Song
>
> On BSD grep, the -w option requires a transition between word and non-wor=
d
> characters, which always fails when the matched pattern begins with a
> non-word character like a dot.
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914062514.92=
6997-1-song@kernel.org?part=3D31
