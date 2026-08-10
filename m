Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36943D6CCE
	for <live-patching@vger.kernel.org>; Mon, 10 Aug 2026 16:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786380111; cv=pass; b=mldq5l2Hmlu6sHuEmTju3jJNs6CFaYQ8hmvR7Hv/0TjzoPeCmxVEMsDfNnQv3GR6mp9kWygKDkLzFVKk7YHmpW0ueeblw1+9J/LCAghzCmqiz3EuELpbTtHky6LYcOTmN+u//O/CvtGmAS9f0SVl/c1JfforUPTDpF7AYKFxbuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786380111; c=relaxed/simple;
	bh=P9E2W15Qi/+bk3GPD6znrErXMIIhhLmb8D0XJNPwkCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LWu1LmY7zePbHrjyyzvg16C9IqPPvM9/wpIMVrYPKgJOD2VNmUV5TEqJhgUk8lcPtDO410tIrkMSXptyD1qeeBRx4xPs4FyAOx40iQyOq8Y8StZ80uOLshmWPOJQME4n8A5ViW62BWlf3N0XrLofyzOjHsg397u3W47H/jHIy/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XR26ECpw; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XR26ECpw"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c15cd3fd760so212139166b.2
        for <live-patching@vger.kernel.org>; Mon, 10 Aug 2026 09:41:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786380108; cv=none;
        d=google.com; s=arc-20260327;
        b=BhfxhVRJVAWxA12R6JbASvIycKO7ClzNy7MMrfqsQ6BKzvuAWlOptQnSPUkn8kLW3K
         eyYUpLcTFcdjuiP4CSuzqwXAunNTHIjZs3/B8LkZNb1O8R8zFNemXt+l8b1FAVOc9JxE
         pt4tW2KUZVgvqtMRfx65stxSMkQ2cNwvQ6EmeLDJNd1hhmxv7OOvUjTwBW9uf2vszYk+
         gFJ3eIEGQHAm4EfvtMOy12vS7dnXJeFnFk2GdaFQOt8UWWD0tRuiLDZt3pRafkG83/+j
         /0lblb/TO00Yg7BrsUG9k5ZXDcj0Apok2vMZQEPfheTxfirj8qM+SNC5eOTB4G+eXgyn
         tPTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QSKatUPQUSBPvcMC3lseZ9L6C9yIZfA5H7J4cOXY5tI=;
        fh=ZdU7p4LkX6DnNqS2uzP0AwNGxOQJWktzfyiBGLhHCnw=;
        b=gVFfXV/5WOhdhlqs3sHe753n2Qr86VbjviexXKWvTkj7lpAS+o/QYGPztx+NmQIi2L
         Ej5+L/1/F3GeOt/aNGyLt2K0H1TNKTkpbIaBiwqPYp+O+HYcGE4B2IMQNYuxEwTGCHBg
         LhZRMzbQ8QoQZEwYZMCBmbmDyAlTjAdE4GtNEPVtSaTom6h49oHod5LDLKcdXUUOOgKE
         AdcdE9HbCSKPBQ3zVFigJL2uU+xmY3CrIHvoz8H6S47SS19R+keTzNB3nIe7pN+0IY3M
         JYc7Q5ova9wOUBTvmcFR+Ek62x0zFQGVC0SFTdeGIGHv67qNOcA0WeMEEW90RFSuclpZ
         mB8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786380108; x=1786984908; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QSKatUPQUSBPvcMC3lseZ9L6C9yIZfA5H7J4cOXY5tI=;
        b=XR26ECpwBSNHS/XtoomJVskkwWD3h1wvRdy+NdB56kXbVJ2LJmNHoV10LYusayGjGk
         ArRuR6BDUceMpxGzXCCFzUOCUKky7KVD+25hIAEe0dN0jD3Ttn43+ntHrUygo3M1I+ma
         UxGNRSZT/NkK6rDMcqFi4yMYUeXRtywcNxWvL0PIVFwhPDvvimAYCjLMi18s+Niq0fzk
         +Z2blD1NA2kce9N+uTokePHtM0rwwhKzfISnL9MNXw8OaT6rXn1ROaQaqvAbIXpG9hj5
         RY1LkESiNDqPyhgpMCZQQ0sO/wFvncvAytIdPHYQEfh1EIyYOhEjFV8nGS8HvPVUQwI7
         JxrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786380108; x=1786984908;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QSKatUPQUSBPvcMC3lseZ9L6C9yIZfA5H7J4cOXY5tI=;
        b=DUDLjCS+rUebnFG2VIoiDLCXcBRMlLAV+eJzM9Gltk0zu393duPZ1Htd26nhgD4sEs
         H9aQDUw/HrFlNS+gczCHulQkKlTfKifX43yT8OtPx3TMrWFK7yo7jWdSl9spSSCDQDJp
         EFNEFWxz/KRjjFiWdrYdpr89og140xw6C2ZJJZdXEFl8ilsv54+XfNtRCjIXfpiYiyqo
         mJmWFYk9dLqWrknX55/cf1tdcYTFXMBY1hKJf0XFok/4DitylnugzLWUQrhvguoD4Z2Y
         qsL8THBTXtBvz0hIjvSptSB3usYKfxQXZclXN1x4HA4wm+Koh8gHvPbu9DGiPVpzcRll
         VSSg==
X-Forwarded-Encrypted: i=1; AHgh+Rqm5ogJMkbf4ebuxRSfabygIertcyjQZFekUh96nEb0T87gYFOTRJiWvkNC43s4cMQW7DH56XFaNkOSgrx3@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7iGVb08YS9rvxL3NDD/bKOIFs0JP9cXhjpvf77A3RRwvgXdsO
	zA+USkRY/wEYO7pNnNDYGBNM6sNFCrofVWeLvZiZpOUyfxUhIOm+yHTED+QOCK0kUtjLu4diekw
	aZJt72aPdqW5M0lUm52hHdZryK6ND3zcN6sQd/Dh4
X-Gm-Gg: AR+sD13D2YLoFV42K7lCzuQPu9guxF4a69InTnJTFiuL1/g8DGxPQAbj8sb662TTWy6
	Kb49yQyYNdYk84nUZON4OdERwSoH/xYR4gzV7IXLKX72S8VmUB6TxFD5M22n3mcw8grA+53M04u
	6jbyDBPCeBaaZe0d18Ae2Z+9GPMwmzHcojQFw0vmTw+GytGdEPTMXH3ogFYamUOpFXK28C8snBQ
	NchVAIurkG/B9tGGwaQBNK5T8VwtJl+uWEssYgSmRFZkRqEXX/bSUReUi11lf3O2kTiPoWma7Ep
	MXWhaWTAa7ZvPGvEEDw1cM/UfY6TYjz7YblUxnuRWVkGXcpczl2oS1oz1TibbmWenXTqhYyPbVQ
	/tAOX+0DuFit1kdTb3t5qklK03plxF98jR/PFmfAsWZ8z5eywfhqAs/1MPsg=
X-Received: by 2002:a17:907:9609:b0:c16:209f:d48e with SMTP id
 a640c23a62f3a-c20c6bdf463mr142480466b.30.1786380107271; Mon, 10 Aug 2026
 09:41:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ed4fe1f95071897859ec7fbe9176246cbd4962bf.1786138806.git.jpoimboe@kernel.org>
 <anmobvJXiBQqWn6S@willie-the-truck> <e5q2mvqtf6iw4lco55uny5ffhppw6vlflxguhc4gg5nm3zdvmo@zs6rw7iov5qc>
 <08d6c5cd-9924-4359-9181-a03718161528@app.fastmail.com> <kp4rvh4vxo65gipgqz4i4dnw2ueylmus4yys6xfrbngp5nefzn@4a4ekjlzqlph>
In-Reply-To: <kp4rvh4vxo65gipgqz4i4dnw2ueylmus4yys6xfrbngp5nefzn@4a4ekjlzqlph>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Mon, 10 Aug 2026 09:41:35 -0700
X-Gm-Features: AUfX_myt_EPgVNH9ESgpTukvUmbQ0LwgwTGLNV8fLE5SC2HKTnOUXN47dXl1kP0
Message-ID: <CAKwvOdmSVjY0TmOTc6WMmDHcLbn=tOV3R3zH_TO4zXZiYEsaBw@mail.gmail.com>
Subject: Re: [PATCH] arm64/module: Fix livepatch BTI exceptions with Clang 21+
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>, Will Deacon <will@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, live-patching@vger.kernel.org, 
	Song Liu <song@kernel.org>, Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, 
	Joe Lawrence <joe.lawrence@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Mark Brown <broonie@kernel.org>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 9:39=E2=80=AFAM Josh Poimboeuf <jpoimboe@kernel.org=
> wrote:
>
> On Mon, Aug 10, 2026 at 06:12:10PM +0200, Ard Biesheuvel wrote:
> > On Mon, 10 Aug 2026, at 17:48, Josh Poimboeuf wrote:
> > > In which case I think to properly support BTI going forward we would
> > > need two "veneers"?  Either that or remove BTI kernel support
> > > altogether.
> > >
> >
> > Yeah, it seems we did not argue our case convincingly: their assumption
> > that veneers/PLTs can be placed within -/+ 128M of their target does no=
t
> > hold for us. But I don't think it holds for .text sections larger than
> > 128M either, so I'm not convinced their reasoning is sound even for the
> > general case.
> >
> > I suppose we could special-case the PLT logic to use direct branches
> > where possible, which would probably catch most of these (assuming
> > .text and .init.text tend to end up close to each other also for KLP
> > modules)
> >
> > For the remaining cases, we'd indeed need a second veneer at the callee
> > end (i.e., inside .text in this case) that is emitted when resolving a
> > cross-section indirect call to a function that lacks the BTI landing
> > pad. But that would be its sole purpose, so I don't think we should go
> > down this route. Instead, the 'address taken' check should include 'cal=
led
> > directly from a different section'. Emitting veneers to work around a
> > compiler optimization is just plain silly.
> >
> > I'll try and poke people on the Clang side of things to revisit this.
> > I guess that leaves kernel BTI broken for the foreseeable future but so
> > be it.
>
> Ok, so for now I suppose we need something like so?
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 06b30924509ac..972988238f367 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -2117,6 +2117,8 @@ config ARM64_BTI_KERNEL
>         depends on !CC_IS_GCC || GCC_VERSION >=3D 100100
>         # https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D106671
>         depends on !CC_IS_GCC
> +       # https://github.com/llvm/llvm-project/commit/7af2b51e761f49974a6=
4c3009882239cea618f2a

Sure, but let's replace this with a link to a bug report in llvm's
issue tracker? I meet with Arm's toolchain team (of which Simon
is...on or adjacent to). I can bring this up then.

> +       depends on !CC_IS_CLANG || CLANG_VERSION < 210000
>         depends on (!FUNCTION_GRAPH_TRACER || DYNAMIC_FTRACE_WITH_ARGS)
>         help
>           Build the kernel with Branch Target Identification annotations



--=20
Thanks,
~Nick Desaulniers
