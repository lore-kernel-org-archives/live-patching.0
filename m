Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0727493D49
	for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 20:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789419368; cv=none; b=c9ITwsh2Ho/1XpmeoK+O+eYM8NqMkyXEoXZAcjzymH/6WXkDXi7CV4WLQV7Ocd4ft0PC8ML/tWpElP8e5bQ8oShyOY/8iZeBveaj0z0DGpPOyqVZvXG8KPdA7jbnDIivMdh2IsS3RM0LszZZgkUyMgOysFCML/fx29zTnDhfLFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789419368; c=relaxed/simple;
	bh=kK+XZi3serLxSxlna0a7F+eRCY8aqT2zVyXAoySBNF0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IK+3tG9ZzBPA3kh5QDmv3+4kbArLc2NUZOgS9fuqq41T8+14ldbkme8BLTwI7zY+nan3of/1tfIB/JEF4vGySUtUnpAlZiZfltdz8aOW/Hs/JfwUiirvKVXSynpNxS0A1YJ6d909xkj5ctGMUxlzblYi/7ktezY2fUmSDtuOzdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K1Zcbpsr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K1Zcbpsr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DCE01F0089C
	for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 20:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789419367;
	bh=AJmm8xNxEyPjZePvLMeOoP9YufNJ6rDf23wcJS6k1MU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=K1ZcbpsrCXM0RMUU6I3FTKh6oBK/UXX84i/mYOwirKuIGWmsEb2pTMNlOpLc6zrIY
	 ZU+IUb7nC0YUx1+PkwU2GRQty18rUxz5kFjekdmmxCI6f7EklwINRb2kOWmrQ7Q8cx
	 /nnfR10v6L8cTUqdOVw5NeYiGXzhBuAqL1t2qi15NAK3tbJNWCosCHIzFqP9NYv2Ff
	 YJtXIT98Ah5okt12O9+D+TYhUdc5OIMdP6Rk0hsCGAg3dkTy+1xksGZrPt8uSFQ4cF
	 KNavK37wFg9Ipo2n9jgZO36445OlP5y1Rs0gQivG1gV+17VIm3rmyrNAyfGt1R60Dt
	 KJPYdz6ziy7Xg==
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-939109f067cso221994085a.3
        for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 13:56:07 -0700 (PDT)
X-Gm-Message-State: AFuF++nnInLaTyDA4E3+4kulA+YGTd0k6JeG05JGY96vniprquRG0dow
	Bt0/7w3+kTLnZ0Pf8yXyENqTq/Zq2yHLdm6ar8z4+TM8V5onUzl9q27qSthtTwzPAq8Uhsc67S+
	SL3bbw85sN8q1D+ZPra8ij3PQAe/h8A8=
X-Received: by 2002:a05:620a:2556:b0:937:5298:7820 with SMTP id
 af79cd13be357-93a2973a1e5mr625763385a.8.1789419366620; Mon, 14 Sep 2026
 13:56:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914062514.926997-1-song@kernel.org> <20260914062514.926997-20-song@kernel.org>
 <20260914064605.EE08C1F000FF@smtp.kernel.org>
In-Reply-To: <20260914064605.EE08C1F000FF@smtp.kernel.org>
From: Song Liu <song@kernel.org>
Date: Mon, 14 Sep 2026 13:55:54 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4yfq_VFNYLpFeivKOuk+YZ=X2i2Sk_Sb4Q8k-ey6ivCw@mail.gmail.com>
X-Gm-Features: AcwNN1W2BrB4WxApQZroyilrRnfbZnHV-IEDDnthtvKx1J9ofv3ZvbAtVXHktCw
Message-ID: <CAPhsuW4yfq_VFNYLpFeivKOuk+YZ=X2i2Sk_Sb4Q8k-ey6ivCw@mail.gmail.com>
Subject: Re: [PATCH v2 19/58] objtool/klp: Add test for jump table key relocations
To: sashiko-reviews@lists.linux.dev
Cc: live-patching@vger.kernel.org, joe.lawrence@redhat.com, pmladek@suse.com, 
	jikos@kernel.org, mbenes@suse.cz, jpoimboe@kernel.org, kernel-team@meta.com, 
	puranjay@kernel.org, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 13, 2026 at 11:46=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Low] The jump label test fixture hardcodes a 64-bit PC-relative reloca=
tion which causes assembler errors on 32-bit architectures.
> --
>
> commit 12aec6304341b6d166d36c18d507d8088ff90b91
> Author: Puranjay Mohan <puranjay@kernel.org>
>
> objtool/klp: Add test for jump table key relocations
>
> A cloned __jump_table entry must keep a relocation in its key slot.
> This patch adds tests and fixtures to ensure the relocation stays
> properly populated for both exported and unexported vmlinux keys
> during a klp diff.
>
> > diff --git a/tools/objtool/tests/generic/fixtures/jump_label.c b/tools/=
objtool/tests/generic/fixtures/jump_label.c
> > new file mode 100644
> > index 0000000000000..ecd3c06912af5
> > --- /dev/null
> > +++ b/tools/objtool/tests/generic/fixtures/jump_label.c
> > @@ -0,0 +1,76 @@
>
> [ ... ]
>
> > +int target(int x)
> > +{
> > +     int r =3D x;
> > +
> > +#if defined(NEW_KEY) && !defined(PATCHED)
> > +     /* The original has no static branch at all. */
> > +     return r + 1;
> > +#else
> > +     asm goto(
> > +             "1:     nop\n\t"
> > +             ".pushsection   __jump_table, \"aw\"\n\t"
> > +             ".balign        8\n\t"
> > +             "912:\n\t"
> > +             ".pushsection   .discard.annotate_data, \"M\", @progbits,=
 8\n\t"
> > +             ".long          912b - ., 1\n\t"
> > +             ".popsection\n\t"
> > +             ".long          1b - ., %l[l_yes] - .\n\t"
> > +             ".quad          %c0 - .\n\t"
>
> [Severity: Low]
> This inline assembly in target() explicitly requests a 64-bit PC-relative
> relocation. On 32-bit x86 (which is supported by the test runner), the GN=
U
> assembler cannot represent a 64-bit PC-relative relocation.
>
> Will this cause the test fixture to fail to build when running objtool
> tests in a 32-bit environment?

I guess we don't care 32-bit any more..

Thanks,
Song
