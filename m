Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E20384CD6;
	Fri, 18 Sep 2026 22:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789772300; cv=none; b=eK8fzNmZLrQezMZW6Eo+cEB/EfYU9zG/byLN7ZTtfbktgDHjdPU91WsJGzVHOjDttTZwLwi9PQ1Pu8oiVmbf6+e6Lp++dzOfPsc4LuUMdc79YfagyDQ4mEXZQZNH6UX8D5ZpYZNpxuRH5Xr1I3keSZGAkOuczZ0j2EtGEBtyZgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789772300; c=relaxed/simple;
	bh=mNkTUn67zmGzc/jGWEYrIXWl3lwX0tuYcA2bZyAI2VA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HRYje9RBX6RMdcuT5SBOflvQ9ZFVUQT3lCmehTo/yNT/uBJLf8oxplc28csP1bbpzkdgRPq9sbEXt1UTqXBjvhnfQ98h1jbOTTvGk5JbyhZOAMtHRBybQPHHyCjLZ7Sd22Ek3NahDxpZyCE7lEkwroeR6Oy1c/o8hgOf3AymlGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fYyWHMS4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fYyWHMS4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5840A1F000FF;
	Fri, 18 Sep 2026 22:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789772299;
	bh=sHXwsGr1uavLjHSu6rlc+2w5RT2dJPcmThYuznQz0y0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fYyWHMS47LQnb+FfECXaQNJ/Y8oIM4F8d+0+1oA7LXEA+oMxpN020GMzYA0JRd3J2
	 zw8re8HCCQoTjcPrZ9LIxCFSpvhvJpJrz9eHS8KmAfr6WttP+BZwID657VRPR62OHA
	 CyWnSchK96yhS6XinnVAEht+F6qbQSFBES4X8cTWbSsryYVskzVOKlyFyUGTHLg7Of
	 X29J2CnW9jfdiYWzwkWLtgRp96dr86CzLfu2SeOQXfwSAqWynLK1gt76IowceucSn7
	 EsTX6e2H4WwA3qVKJ2CbcchbihJXcqAlX5bD4hXHJRSzQ/G2ZT/De8s4scKmXgnr3T
	 qKbhadLqYloHA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 10/11] arm64, crypto/lib: Annotate leaf functions
 with CFI info
Reply-To: sashiko-reviews@lists.linux.dev
To: "Peter Zijlstra" <peterz@infradead.org>, "Roman Gushchin" <roman.gushchin@linux.dev>, "Indu
 Bhagat" <ibhagatgnu@gmail.com>, "Dylan Hatch" <dylanbhatch@google.com>, "Jens
 Remus" <jremus@linux.ibm.com>, "Catalin Marinas" <catalin.marinas@arm.com>, "Steven
 Rostedt" <rostedt@goodmis.org>, "Jiri Kosina" <jikos@kernel.org>, "Weinan
 Liu" <wnliu@google.com>, "Mark Rutland" <mark.rutland@arm.com>, "Josh
 Poimboeuf" <jpoimboe@kernel.org>, "Will Deacon" <will@kernel.org>
Cc: "Mostafa Saleh" <smostafa@google.com>, "Herbert Xu" <herbert@gondor.apana.org.au>, "David
 S. Miller" <davem@davemloft.net>, linux-toolchains@vger.kernel.org, live-patching@vger.kernel.org, joe.lawrence@redhat.com, "Prasanna
 Kumar T S M" <ptsm@linux.microsoft.com>, "Puranjay Mohan" <puranjay@kernel.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Randy
 Dunlap" <rdunlap@infradead.org>, "Song Liu" <song@kernel.org>
In-Reply-To: <20260918224157.1471085-11-dylanbhatch@google.com>
References: <20260918224157.1471085-1-dylanbhatch@google.com>
 <20260918224157.1471085-11-dylanbhatch@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 22:58:16 +0000
Message-Id: <20260918225817.5840A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] arm64: CFI start directive placed before function alignment corr=
upts DWARF FDE bounds
--

commit 498fccd9732a9f4edcb2b385432263d6681de459
Author: Dylan Hatch <dylanbhatch@google.com>

arm64, crypto/lib: Annotate leaf functions with CFI info

This commit adds simple CFI annotations to assembly leaf functions so that
the link register can be recovered by the unwinder. It introduces the
SYM_LEAF_FUNC_START macro family for these annotations.

> diff --git a/arch/arm64/include/asm/linkage.h b/arch/arm64/include/asm/li=
nkage.h
> index d1f7a16729d25..c4377e6ba0a67 100644
> --- a/arch/arm64/include/asm/linkage.h
> +++ b/arch/arm64/include/asm/linkage.h
> @@ -47,4 +53,27 @@
> =20
>  #define __bss_pgtbl __section(".bss..pgtbl") __aligned(PAGE_SIZE)
> =20
> +/*
> + * SYM_[TYPED_]LEAF_FUNC_[START|END] macros add CFI minimal CFI directiv=
es
> + * allowing .sframe data to be generated for functions which do not modi=
fy the
> + * LR (x30). Unwind data will not be correct if these macros are used on
> + * non-leaf functions, as additional CFI directives would be necessary i=
n such
> + * cases.
> + */
> +#define SYM_LEAF_FUNC_START(name)			\
> +	.cfi_startproc ;				\
> +	SYM_FUNC_START(name)

[Severity: Medium]
Will placing .cfi_startproc before SYM_FUNC_START() cause the DWARF FDE bou=
nds
to include alignment padding bytes?

Since SYM_FUNC_START() emits the .balign directive for the function,
placing .cfi_startproc before it captures this padding. This can misalign
the FDE start address relative to the function symbol, which could confuse
stack unwinders like the sframe unwinder.

Should the .cfi_startproc directive be emitted after the alignment within
SYM_FUNC_START() completes?

> +
> +#define SYM_LEAF_FUNC_END(name)				\
> +	.cfi_endproc ;					\
> +	SYM_FUNC_END(name)
> +
> +#define SYM_LEAF_FUNC_START_LOCAL(name)			\
> +	.cfi_startproc ;				\
> +	SYM_FUNC_START_LOCAL(name)

[Severity: Medium]
Does the same alignment issue apply to SYM_LEAF_FUNC_START_LOCAL()? The
.cfi_startproc directive is emitted before SYM_FUNC_START_LOCAL(), which
also handles function alignment.

> +
> +#define SYM_TYPED_LEAF_FUNC_START(name)			\
> +	.cfi_startproc ;				\
> +	SYM_TYPED_FUNC_START(name)

[Severity: Medium]
Could this also lead to misaligned FDE start addresses for typed leaf
functions, since .cfi_startproc is placed before SYM_TYPED_FUNC_START()
alignment?

> +
>  #endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918224157.1471=
085-1-dylanbhatch@google.com?part=3D10
