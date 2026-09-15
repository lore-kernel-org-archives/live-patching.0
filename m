Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6AE3603EF
	for <live-patching@vger.kernel.org>; Tue, 15 Sep 2026 21:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789506290; cv=none; b=kF7nVw7lqlSxwJUMuJxSrgvdZ5COSFq9tMIxTBv2fUl/c41RGrpWF4Yh1590wB09P1pukvCObbKOApLE2eddd75Zs0LkojSUQo5YEWQwdltmPxu9mjE2/+gA8ztgDNioz9TXo+H5G/rnAULnFaF/JnP7YSsH/A8t+Hu7Qg1Kq7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789506290; c=relaxed/simple;
	bh=yyIXuptmJwAPr4wTO/4PZiWiLUtiZfesBE2cNGieonk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pPNcbXuwT53lkGUpR7cZz906ySdlVeXXR5qRg0pZ0C8+5Pwre+mCbs5zHAq+63awKDb/GpxaTHj6hLeDvPk8TeTnR+ACdlRnTXGRmaHs1nlKtPkqMsE2vKxMp3ylCdiw9B6jYSBiiTzIlUWZ++EdtGhtGLLksiI7BFZ7ORlBRLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T1SrtN30; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T1SrtN30"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E70F1F000FF
	for <live-patching@vger.kernel.org>; Tue, 15 Sep 2026 21:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789506288;
	bh=78QAKCGz5gzQ8zvkiIKxAHRqaOVV/ffw/xD9brOGPSA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=T1SrtN302loYDcyp5F2T5HUYrXgXZ7JmGwnPWA7DYR7ntVkPp9IiXP30O6QhGKbkX
	 E02TYUqYOKqArjAutfD1yhJzqMWtFmkQLwBZh47J0MKM8mOvWuOCYpCn1qFA7RTeVu
	 ooEB5ZFieP+TkPfE5ryxx51ykBdqBRNAVXzBBRrOiUcjhHLxbk/DzMZ1l1RczGHSvQ
	 3WxGxJitS9R4s4Fnl6+OuDo+ulScyc7uFbmzCysiGHPkhPPNVUCysF3NA+KRrsTji5
	 Shf6PXnqgTkr7yf17A2+ZZPHWhLfRLI1skQgWP4okWntNPLNaow3WCWaS8zuSTK9Q/
	 kxz/jkRJ1sK+g==
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-93910cadea0so14744985a.1
        for <live-patching@vger.kernel.org>; Tue, 15 Sep 2026 14:04:48 -0700 (PDT)
X-Gm-Message-State: AFuF++nVhi2RFXDZSVbw3xlLumA6L2XohTp9CogFQO3kf43gKQ/W318N
	yBaWaRuCJBVkpS44pwVA4cuByn1hsfu8eFy9DRn48Ef5RAV0E7FHE9Yr6T8qP2PjZuUc0TLv87U
	SaX9HXP7r+maf5JHwRnswUuXf/2teMZM=
X-Received: by 2002:a05:620a:2b81:b0:93a:3e13:15f1 with SMTP id
 af79cd13be357-93a40797723mr439712485a.23.1789506287667; Tue, 15 Sep 2026
 14:04:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914230355.3422996-1-song@kernel.org> <20260914230355.3422996-12-song@kernel.org>
 <20260914234533.D81AF1F00893@smtp.kernel.org>
In-Reply-To: <20260914234533.D81AF1F00893@smtp.kernel.org>
From: Song Liu <song@kernel.org>
Date: Tue, 15 Sep 2026 14:04:35 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7zOkVVZ=f_XGd17LaGdRWt2dW=U+Jhd7Cd-svn5e8hRg@mail.gmail.com>
X-Gm-Features: AcwNN1X5OAyyRNduQJ-wDa9hV0u-e8IxGNWyYe4miL6RC61_voBMbwUtWN8HW2c
Message-ID: <CAPhsuW7zOkVVZ=f_XGd17LaGdRWt2dW=U+Jhd7Cd-svn5e8hRg@mail.gmail.com>
Subject: Re: [PATCH v3 11/58] objtool: Forward toolchain variables to the klp
 test runner
To: sashiko-reviews@lists.linux.dev
Cc: live-patching@vger.kernel.org, joe.lawrence@redhat.com, 
	jpoimboe@kernel.org, mbenes@suse.cz, peterz@infradead.org, pmladek@suse.com, 
	jikos@kernel.org, puranjay@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 4:45=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] objtool: tests target silently falls back to GNU objcopy under=
 LLVM=3D1
> --
>
> commit 11c79ea0e223d9512f0e164886cfdec6a0e5e3b2
> Author: Joe Lawrence <joe.lawrence@redhat.com>
>
> objtool: Forward toolchain variables to the klp test runner
>
> The tests target passes toolchain variables like CC, LD, READELF, and OBJ=
COPY
> into the test scripts so that fixtures are built and inspected with the
> selected toolchain.
>
> [ ... ]
>
> > diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
> > index ed5cf146ef2e2..a3d09a5af7a20 100644
> > --- a/tools/objtool/Makefile
> > +++ b/tools/objtool/Makefile
> > @@ -153,6 +153,8 @@ mrproper: clean
> >
> >  tests: $(OBJTOOL)
> >       $(Q)OBJTOOL=3D$(abspath $(OBJTOOL)) ARCH=3D$(ARCH) CROSS_COMPILE=
=3D$(CROSS_COMPILE) \
> > +             CC=3D'$(CC) $(CLANG_CROSS_FLAGS)' LD=3D'$(LD)' \
> > +             READELF=3D'$(READELF)' OBJCOPY=3D'$(OBJCOPY)' \
>
> [Severity: Medium]
> Will the tests target silently fall back to GNU objcopy when building wit=
h
> LLVM=3D1?
>
> It appears that tools/scripts/Makefile.include defines LLVM_OBJCOPY but l=
eaves
> OBJCOPY unset for LLVM builds. As a result, $(OBJCOPY) evaluates to an em=
pty
> string here in the tests recipe.
>
> When this empty variable is passed to tools/objtool/tests/lib.sh, the fal=
lback
> logic:
>
> OBJCOPY=3D"${OBJCOPY:-${CROSS_COMPILE}objcopy}"
>
> treats the empty OBJCOPY as null due to the :- operator. This substitutes=
 the
> default GNU objcopy instead of the intended llvm-objcopy, which defeats t=
he
> goal of using the selected LLVM toolchain.
>
OK, added the following to v4:

OBJCOPY ?=3D $(if $(LLVM),$(LLVM_OBJCOPY),$(CROSS_COMPILE)objcopy)

Thanks,
Song
