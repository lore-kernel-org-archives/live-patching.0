Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAA9322A
	for <live-patching@vger.kernel.org>; Wed, 12 Aug 2026 00:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786492965; cv=none; b=dRvikTn6qO1MUqX+y1ur70q0K4qKIjxvRfdJW0bCjEsW9RD+n3u+JIxr3Wp45VJkTxNtNCFUbmiNlA5+oXybcMVRD4gV0rBjGtuA31Fh3503PYJ/AjNoQSMNw8ul8FAT+/b99DMmCdtXqP3AOI7h7UdtIYEbGqOTOF64kJudOdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786492965; c=relaxed/simple;
	bh=TWp+nuJW5phRormZshGSUWCfKxKDQpSCgRfi+DKVwNs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=si2GZhuObl6oYQ3S5UqeE/PBnFJ2mynmalHormEnq8RQwUBCX6fLuZUCA6MQRrK4jfGSuik0WMWKWNnBU6Ej+B80BvxUojxQbn0Yn1zSv4r4pDpewzOhJPyuFuloAqsaFsZOtnPmD/Jymh22VcU3fv+VWg3Y8DIw1tunFVqSv9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fLxVzLve; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fLxVzLve"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 523841F000E9
	for <live-patching@vger.kernel.org>; Wed, 12 Aug 2026 00:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786492964;
	bh=DX8AcDd8xiFvnAw086KkQaBdTXODmm6DYHpS2UGNDUI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=fLxVzLveCDQ38M556RCq1p1TVni/ud467RdrvXXAbN8c+bRq+DqlkaH9RW0nl6AP3
	 t4SKOK2+oUARzpzfMAFhVWziQ/gVzMtuwKJX5DvOkLdB/cdRfI6oUwiCHN+BVCI2VO
	 jLDQ5YJdxNcf/aOpUr09TS+zBmvVjHEyztvvb/XyZTJBLidbiYSi7L6sU+2Sb2WFx2
	 cLU1BNie+SuGsdzSfmBCoRvnpuVY6tImUNt0VCqNlMTGszR5mn1zOYorUeGBrL/u8d
	 pdsJzCjcqlbIU/Pcxl/yNNNs1f4P6S75chOUw1X5vtZJ2WNeBCvFK8WSBdT3uEgmhc
	 Edn/wUPkQaFuw==
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-92e55b62640so28440085a.0
        for <live-patching@vger.kernel.org>; Tue, 11 Aug 2026 17:02:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqMZZ9NGtoQbxma9Ek7L6piYsyDYPADrHY4ar4REhhZnaiee6W+bsCZTCnGyyRFv3tra+1n94J2b0tRCWvx@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8jRYB0KgkBsS8lrLWPx/bIMvIAjQai2L+bcmGYw5GONw6th07
	Jy6fvfInqdSaTFUfhoGAjGCDAIh9OEbgo0MMLNnjbFiGGqlOE5Dhw/+SFb6Mb1AIFQg20Voqja6
	Ab9V1EFVxNhAKcCtX0tASqNJzerCApIc=
X-Received: by 2002:a05:620a:2789:b0:915:cb40:f76a with SMTP id
 af79cd13be357-936b3d5c7b6mr123863585a.39.1786492963606; Tue, 11 Aug 2026
 17:02:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1786230311.git.jpoimboe@kernel.org> <afba3774f6a8a818f899e3d04a22ac55e9cca0e2.1786230311.git.jpoimboe@kernel.org>
In-Reply-To: <afba3774f6a8a818f899e3d04a22ac55e9cca0e2.1786230311.git.jpoimboe@kernel.org>
From: Song Liu <song@kernel.org>
Date: Tue, 11 Aug 2026 17:02:32 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5MefQs4Cv78wm1i5YJJnSG3p1neRqoXgo0Np1BcTpAJg@mail.gmail.com>
X-Gm-Features: AUfX_mzRyX-pZscT-qwuNT-GinBTphaTag_fBwZM1aCRGssM85AEKHR4m8vNWTw
Message-ID: <CAPhsuW5MefQs4Cv78wm1i5YJJnSG3p1neRqoXgo0Np1BcTpAJg@mail.gmail.com>
Subject: Re: [PATCH v4 21/22] klp-build: Support cross-compilation
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	live-patching@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Joe Lawrence <joe.lawrence@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	Mark Rutland <mark.rutland@arm.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nsc@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 8, 2026 at 4:18=E2=80=AFPM Josh Poimboeuf <jpoimboe@kernel.org>=
 wrote:
>
> Add support for cross-compilation.  The user must export ARCH, and
> either CROSS_COMPILE or LLVM as needed.
>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

Acked-by: Song Liu <song@kernel.org>
