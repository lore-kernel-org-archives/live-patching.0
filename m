Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA04309EEB
	for <live-patching@vger.kernel.org>; Fri,  1 May 2026 17:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777656732; cv=none; b=IGnhgNvaDOBSn09BcF9Mo4uDfoJMv1+rRyX4UgV0Nr1ffcXocqL5rx352q7yC8NUyaTHyALTbGBK314CU7g36xxN1N2xK9K9bfGLTS0jdFQXBCiCXeEEVEbQ2mTDMXnOr1aPTaS2tLxqfucQX+LTyy8frTDSx6BRakmlaBwLkxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777656732; c=relaxed/simple;
	bh=5eo6lfNzKdH9YY6bFtxwgN9ShMWuYIE63HkUxXvPsFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hZEDsAZi65YJTG0TV/xYfyN+yYPjs1mUVb3s+CvaMjL3s8QnVkbfjD0dNC8pRDVAcKivzNXdlMHemmsJSSwS4HJlVuuUG5vSLJFAPYBwfR8DEg/qqgeVr8ogggdZ1TD2+R0/+pdoSMVkZXGXI+Uqm+f6CLUZJJjurNZ01jhX9tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TTjAygrj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TTjAygrj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9873C2BCB4
	for <live-patching@vger.kernel.org>; Fri,  1 May 2026 17:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777656731;
	bh=5eo6lfNzKdH9YY6bFtxwgN9ShMWuYIE63HkUxXvPsFI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TTjAygrjxjyMa0MrbDYqeDew8yAryCc7/oUx5QgziMSMmvHNftzEAMcYayxCO6tuI
	 R41Ol3atb01za4wsqlfW/DkpNxgWoiYK8nxRsyReFo0b6yRWcJrVarRntkxc0CLTCe
	 WPToBjutT85ue6I/MX+/QG15VBCIVgRYiY59IlgiNqVTXHp8v7OWF5D8BRtGafc0yF
	 jBPVI0YizVwkCpPuPj6yJJYig6Q3RUBduce/scjx6lSM45yvN/UrpdNqHv3uwmQhPU
	 jOoR41kOh0AIwApByJZJH6YN4f7hEenm5VU6cUSCtzFE3v4ZmGPP30FRLvZpWv9iKi
	 r8mqsJbtMfmRA==
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-6055a0414d7so612446137.2
        for <live-patching@vger.kernel.org>; Fri, 01 May 2026 10:32:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8wKHUPGMjvoGnK7ZNsGo0ir2ZZ1DeilWgxBylunFF47hF6kOx+B8vTZ0PEMUpxf0acudYacTb2jSyks2tb@vger.kernel.org
X-Gm-Message-State: AOJu0YzXSnKWzF6lEwn53pY1mkiw//VKjTQEic+UCqJ98hjPyuN+3HHX
	phgGRG0Ig+1Hn2MVcRF9nxFZOA+zYhGQ5Ia4A0iaOYXbErjjrIjAWO884Uq+iKiVKfTMmOQT2aN
	ruMt74xhrVJhPRXSQODGPOdlj+bbmjTc=
X-Received: by 2002:a05:6102:4b0c:b0:611:d979:a38 with SMTP id
 ada2fe7eead31-62d84b6dd82mr168580137.6.1777656726005; Fri, 01 May 2026
 10:32:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1777575752.git.jpoimboe@kernel.org> <80d6f8df4db610a6c9f68031dc0153f04814f2fa.1777575752.git.jpoimboe@kernel.org>
 <CAPhsuW7wAG1MEb2xVxFLN2V_BG4KddhKRXaL9LPxWEP2DUFAJQ@mail.gmail.com> <yd3becobjg77p7yylqqgmrdznkejvwbdzojzxk5lqlsihp4377@d6yfaqstriec>
In-Reply-To: <yd3becobjg77p7yylqqgmrdznkejvwbdzojzxk5lqlsihp4377@d6yfaqstriec>
From: Song Liu <song@kernel.org>
Date: Fri, 1 May 2026 18:31:51 +0100
X-Gmail-Original-Message-ID: <CAPhsuW7QvgDYRhqoWqNpCP9T135wWbZgMASDh73aq=5SBUQeSg@mail.gmail.com>
X-Gm-Features: AVHnY4JyLKoe0sXbdcyywnxNSIp0XPjTrTVt7BeSEgZxTaAEhSlYUqSMmC0iCy0
Message-ID: <CAPhsuW7QvgDYRhqoWqNpCP9T135wWbZgMASDh73aq=5SBUQeSg@mail.gmail.com>
Subject: Re: [PATCH v2 20/53] objtool/klp: Don't correlate .rodata.cst*
 constant pool objects
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	live-patching@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Joe Lawrence <joe.lawrence@redhat.com>, Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 1, 2026 at 6:04=E2=80=AFPM Josh Poimboeuf <jpoimboe@kernel.org>=
 wrote:
>
> On Fri, May 01, 2026 at 11:37:49AM +0100, Song Liu wrote:
> > > +/*
> > > + * Some .rodata is anonymous and can't be correlated due to there be=
ing no
> > > + * symbol names.
> > > + *
> > > + * The .rodata.cst* sections aren't technically anonymous, they're S=
HF_MERGE
> > > + * constant pool sections containing small fixed-size data (lookup t=
ables,
> > > + * bitmasks) which are only read by value, so pointer equivalence is=
n't needed.
> > > + * They are typically referenced by UBSAN data sections.
> > > + */
> > > +static bool is_anonymous_rodata(struct symbol *sym)
> > > +{
> > > +       return is_rodata_sec(sym->sec) &&
> > > +              (!is_object_sym(sym) || strstarts(sym->sec->name, ".ro=
data.cst"));
> > > +}
> > > +
> > >  /*
> > >   * These symbols should never be correlated, so their local patched =
versions
> > >   * are used instead of linking to the originals.
> > > @@ -386,7 +401,7 @@ static bool dont_correlate(struct symbol *sym)
> > >                is_uncorrelated_static_local(sym) ||
> > >                is_local_label(sym) ||
> > >                is_string_sec(sym->sec) ||
> > > -              (is_rodata_sec(sym->sec) && !is_object_sym(sym)) ||
> > ^^^^
> > This line was added in 19/53. Maybe we can merge 19 and 20?
>
> I think I'd prefer to keep them separate as they are two distinct issues
> related to rodata: pointer equivalence (patch 19) and UBSAN mergeable
> constants (patch 20).

Fair enough. I think we can keep these two patches as-is.

Thanks,
Song

Acked-by: Song Liu <song@kernel.org>
