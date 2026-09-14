Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663473A9615
	for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 20:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789418859; cv=none; b=KarmSW2ZUtggOHU+zGCL/aPUrZPr2acGJaHo1S/5GVR4DVmZ5UEg3Oi7oyaeapF2aVWCgrJaRNEIl+f+H+NYYyIri5+39Qosljra845VbyAQpW3rV9DJUFgc4r140sLvWYEyNSodE5l850HCcQLffGSVDdGXAwzulu84MfosnKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789418859; c=relaxed/simple;
	bh=aWtJwXrr969IJGDp8stMTho08QWz0q+DjaZkDntRGB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T2XJY8DDQxzBuAfMJ0tOF8H0mMy6Uh9vkSUdTjQJZXZ2XxUlo8VH7uSnbCuvZjOHaM8ivOFQzWBlPiA5HCe0eb3P1kvZYhNVWHjQsgP4TUQKcAIKbcvJIgo5RKLLZ+78MLaKlwKPOwztX2Fk7jV/hLxkZzH4pVaKwuZrp+KwWTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QRogMqTa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QRogMqTa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18ACB1F00898
	for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 20:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789418858;
	bh=B4AyBC96h9hMvb0sDqqaHTJDXHA8V10BciDv4SmtB0g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=QRogMqTaGPavsjTpylgx0mSf2lcHGbT+pg9HC+OlrLt0ZzfLHDTS/iS/kpYY1XobW
	 ULW54PHxsW6LjvgA6zZbKI7+qMSyGtrVgNw7pEfXfL11Po6vxLg+EmaOc+DQH5pPH0
	 KtQ2Y72QcyT1Ure+qoHf/I1wyzlit2zCdcn0KJsMZO8+evDezZu8IqhE+pM8KlbQ9J
	 QIKrWc2/k9RRHEShFLBysnm/0+QCrjsUFpZOxPug8sj6XKnMN00axAb2TTf4DPYS10
	 G2G9izl0ukfo8h+c9TG1M8PCcDzuksJTTZRXr2qAXFSSPwNjIpNbVJhNToN8QF8dBz
	 KLPqIZODEpqpQ==
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-939fc329d35so219993485a.0
        for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 13:47:38 -0700 (PDT)
X-Gm-Message-State: AFuF++mljHur8kxO92IHERduLe7nAS77lyYt0dDZP89Z++5PwOM22aYG
	mGD931is90KqjQ5opcJ81GEycTTdzZindYEMaISxLBFVLEpqRES4ACzQEYJt84+uvZ3PxDuxRcb
	kZj0s+G8aj9VcKXck7z6E0CDreljG3sw=
X-Received: by 2002:a05:620a:43a2:b0:939:3100:750c with SMTP id
 af79cd13be357-93a297c2f85mr704571285a.22.1789418857341; Mon, 14 Sep 2026
 13:47:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914062514.926997-1-song@kernel.org> <20260914062514.926997-14-song@kernel.org>
 <20260914063801.BDD641F000FF@smtp.kernel.org>
In-Reply-To: <20260914063801.BDD641F000FF@smtp.kernel.org>
From: Song Liu <song@kernel.org>
Date: Mon, 14 Sep 2026 13:47:25 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6BVXa59vr7pfiZvHkCPMmWFhacvEGYsXcP29a2CmGojQ@mail.gmail.com>
X-Gm-Features: AcwNN1Xtn5KnTUkTZ2J1RX4b7AdzGkeVb7AeBQwiHSeWUXf1Uly7LdD8FL8Oi_0
Message-ID: <CAPhsuW6BVXa59vr7pfiZvHkCPMmWFhacvEGYsXcP29a2CmGojQ@mail.gmail.com>
Subject: Re: [PATCH v2 13/58] objtool/klp: Add test for newly introduced data
To: sashiko-reviews@lists.linux.dev
Cc: live-patching@vger.kernel.org, jikos@kernel.org, mbenes@suse.cz, 
	pmladek@suse.com, peterz@infradead.org, jpoimboe@kernel.org, 
	puranjay@kernel.org, joe.lawrence@redhat.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 13, 2026 at 11:38=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [Medium] The test uses `grep -q` which incorrectly matches section symb=
ols in newer binutils, bypassing the check for the actual object symbol.
> - [Medium] The test fixture uses a predictable, linear `static const int`=
 array which the compiler can easily optimize away into arithmetic, causing=
 a false test failure.
> --
>
> commit 5c5aee1d82edada34865ca44a6b863b5d7f437f3
> Author: Puranjay Mohan <puranjay@kernel.org>
>
> objtool/klp: Add test for newly introduced data
>
> Adding data differs from changing it: nothing in the running kernel refer=
s
> to a new variable, so it is safe and has to travel into the livepatch wit=
h
> the function using it.
>
> > diff --git a/tools/objtool/tests/generic/fixtures/new_data.c b/tools/ob=
jtool/tests/generic/fixtures/new_data.c
> > index 0000000000000..fa861fe813869
> > --- /dev/null
> > +++ b/tools/objtool/tests/generic/fixtures/new_data.c
> > @@ -0,0 +1,18 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Data introduced by the patch. */
> > +
> > +static const char __modinfo[]
> > +     __attribute__((section(".modinfo"), used, aligned(1))) =3D "\0nam=
e=3Dvmlinux";
> > +
> > +#ifdef PATCHED
> > +static const int klp_new_data[4] __attribute__((used)) =3D { 1, 2, 3, =
4 };
> > +#endif
> > +
> > +int target(int x)
> > +{
> > +#ifdef PATCHED
> > +     return x + klp_new_data[x & 3];
>
> [Severity: Medium]
> Can the compiler fold this array lookup into arithmetic? The predictable,
> linear sequence of values here makes it a target for array-to-math
> optimizations (e.g. GCC at -O2 might compile klp_new_data[x & 3] as
> (x & 3) + 1).
>
> If the compiler optimizes this away into scalar arithmetic, it would elim=
inate
> the necessary relocation to klp_new_data in the target() function. Since
> objtool klp diff relies on this relocation to pull in the variable,
> eliminating it would cause the test to spuriously fail.

This doesn't seem to happen, but fixed in v3 with something like:

klp_new_data[4] =3D { 7, 3, 11, 5 };

Also added a check if klp_new_data doesn't exist.

>
> > +#else
> > +     return x;
> > +#endif
> > +}
> > diff --git a/tools/objtool/tests/generic/test-new-data.sh b/tools/objto=
ol/tests/generic/test-new-data.sh
> > index 0000000000000..c7336752f09a8
> > --- /dev/null
> > +++ b/tools/objtool/tests/generic/test-new-data.sh
>
> [ ... ]
>
> > +run_diff
> > +
> > +assert_patched target
> > +out_symbols | grep -q 'klp_new_data' ||
> > +     fail "new data was not carried into the patch"
>
> [Severity: Medium]
> Will this test falsely pass if the actual object symbol is dropped but th=
e
> section is preserved?
>
Replaced this with "assert_symbol klp_new_data".

Thanks,
Song
