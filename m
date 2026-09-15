Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB91B47F2F8
	for <live-patching@vger.kernel.org>; Tue, 15 Sep 2026 23:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789515001; cv=none; b=CeKr3he75vTjOhhVaBQINDB+MEHHJGP3Hc4iCpIhj2H8+ZB/dvYeGglNrWfAz9kPXv922074VddXvsltorh3OzrNsdTr2J+h8frlCmP3QNgnz//AijG864KTLqDtr+CEAE7X7FBPtwJxxZnMYt0qXunRzMnw7xnSJ0tiYGTfuoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789515001; c=relaxed/simple;
	bh=gTxjiLsMdSD48ORVHPlAT//hJofrFDbSJ8aqYWl22GE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E1wdWRWcn2EYV1+nXpOLiWcRb+vKMrHQBqcK6OmhjzS3TyN2vynVIGuI6soyStyYK8QfN9ADTnYhcwV4DXrVguuVFoo5H6oDVIpU866haD4EWM/pxKVTQopamq3IVO0r/PqGR+NjLM43oiYxHvePJYmUD1hO74YZxU+hgrwEdt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZmhDGWRP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZmhDGWRP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 924FC1F0089A
	for <live-patching@vger.kernel.org>; Tue, 15 Sep 2026 23:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789515000;
	bh=u+KaZS23zFQh2bL06lpGbfBO/1T0wx8A2hhwk5A3DBI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ZmhDGWRPvX71hUTxbbi+jBmnWpdawBNEuxx4Z6O6ZqnlWyZ9RDq8s6/7cT86VuerZ
	 9F7nEJkCEISSJUDT3v+paArm0Lhi0QZFg3JezUBkAwVh2L2RmiO1Ky4M4rQ1nj8qLm
	 8SyC32qdTctHnKwv+85JPCKT+0QhAVPNXbfZR1AIJQXSNlwELra//mV4xbChGeRkiZ
	 6HwJZBI/iuAW+QE6avpY61xV850/DCZExj7Sy0pyeqVUo0nSV0wULyji4+N+m1Gmi8
	 qyEAqC6vtwGaImlLf/tMts2c2CTFGpZTI0+QDFg5Q586EecGiy/f2J4WWZaQiiBcDj
	 Lro3RR+5SJr+g==
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-93910cadeb7so42334185a.0
        for <live-patching@vger.kernel.org>; Tue, 15 Sep 2026 16:30:00 -0700 (PDT)
X-Gm-Message-State: AFuF++mOL/Ruv2Q1jE48TJT1WxgcyZLDGGmWLE8AOjraJQ147rZB0I/U
	6lwnKZEJ3pHNY/8PImDsEtXuZxEiIWBlyHsZTa35Cmwum0Gyo2LpnihfK6G6OdQ7VJxQyf8TOvu
	VKnHhrwcPueCjkc1QFFTm6vAGTSEDEZM=
X-Received: by 2002:a05:620a:17a4:b0:930:f337:ebeb with SMTP id
 af79cd13be357-93bb771dd18mr52201285a.12.1789514999472; Tue, 15 Sep 2026
 16:29:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914230355.3422996-1-song@kernel.org> <20260914230355.3422996-56-song@kernel.org>
 <20260915005318.9BAA41F000FF@smtp.kernel.org>
In-Reply-To: <20260915005318.9BAA41F000FF@smtp.kernel.org>
From: Song Liu <song@kernel.org>
Date: Tue, 15 Sep 2026 16:29:47 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4+RBhsm4S9FLprgVUiRFp2RtUwKDCRR6fETVMEO+XR=Q@mail.gmail.com>
X-Gm-Features: AcwNN1VoSQiWkbCgEfn2GFmyDM_PdFlsOCdYH9ezpKSjZRzxbce__aIg6LS1Svg
Message-ID: <CAPhsuW4+RBhsm4S9FLprgVUiRFp2RtUwKDCRR6fETVMEO+XR=Q@mail.gmail.com>
Subject: Re: [PATCH v3 55/58] objtool/klp: Add test for absolute and
 __ADDRESSABLE symbols
To: sashiko-reviews@lists.linux.dev
Cc: live-patching@vger.kernel.org, mbenes@suse.cz, peterz@infradead.org, 
	joe.lawrence@redhat.com, jikos@kernel.org, pmladek@suse.com, 
	kernel-team@meta.com, puranjay@kernel.org, jpoimboe@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 5:53=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] objtool: test suite build failure on 32-bit architectures due =
to .quad
> --
>
> commit 8413836c45f39cb1efbf4a2f69693cc56d13f861
> Author: Song Liu <song@kernel.org>
>
> objtool/klp: Add test for absolute and __ADDRESSABLE symbols
>
> This commit adds a test fixture and script to ensure that objtool's
> livepatching features correctly handle absolute symbols and __ADDRESSABLE
> pointers without failing or crashing. It uses inline assembly to emit
> these structures for the test framework.
>
> > diff --git a/tools/objtool/tests/generic/fixtures/abs_and_addressable.c=
 b/tools/objtool/tests/generic/fixtures/abs_and_addressable.c
> > new file mode 100644
> > index 0000000000000..6392ff99af421
> > --- /dev/null
> > +++ b/tools/objtool/tests/generic/fixtures/abs_and_addressable.c
> [ ... ]
> > +int helper(int x);
> > +int helper(int x) { return x + 1; }
> > +
> > +/* The shape of __ADDRESSABLE(helper). */
> > +__asm__(".pushsection .discard.addressable, \"aw\"\n"
> > +     ".balign 8\n"
> > +     ".quad helper\n"
>
> [Severity: Medium]
> Does using ".quad" here cause a build failure on 32-bit architectures?
>
> When running the generic klp test suite on a 32-bit host (like 32-bit x86=
),
> the assembler cannot emit a 64-bit absolute relocation for a symbol and f=
ails
> with an error like "cannot represent relocation type BFD_RELOC_64".
>
> Would using a pointer-sized assembly directive instead of hardcoding a 64=
-bit
> directive prevent this from causing a hard failure in build_one() when
> running `make tests` on 32-bit targets?

klp-build is for 64 bit only, so let's not worry about 32 bit targets.

Thanks,
Song
