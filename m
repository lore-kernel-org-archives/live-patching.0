Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D293445D911;
	Wed,  7 Oct 2026 12:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791375308; cv=none; b=X1NXveN+p2s3HDU9ApMY/b1BKGu8KN91TeXbjDnIBkxcKny0lVsSPL4X1IQrBDkxLLSoB8bjdgAbCUXbGhsw1QIBlo+4DIEs/9dRG2gg93LDvKTyijlMVdlXfk1tZ/agp+gR2xJf9MljRmDECf5Cmd1YKdwzRP3M0yvHferZco8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791375308; c=relaxed/simple;
	bh=JxSrH/OdeFYCWyuy7iYjxRJs66pAu4oNxt3gjjhr3iM=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=ZDUl2vGn3oGDkl5PsVHrXxpNcBwfd/fL5izbwfKzdq2VTbgB+KyXAsmQ6Jplx6dEvvwt3XIuSBmdrpLeRGB2841mdK7v67eplZ1rjxzAXKAeOH5IvnHbz+k7P1DVZYq1ZtfNZcTNKvsgU8rY5Oy/l6nYI7ArWEdPqgtFFGIA8SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mzHMIN4o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mzHMIN4o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A4781F0089B;
	Wed,  7 Oct 2026 12:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791375298;
	bh=pgotGUP9ng09w4prtsqqHpwR1KpOaOmUE6z6DSePSnU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mzHMIN4oCYXHf3a2L9jlaCdT4LtnmTOvFubFfhzIFbFUp2F1V7zOReejtFfVPopGt
	 ChIy1dAjQmAhBObgfZ+8vjyD3JLqQq5p96APQ9HCtbGG3APeE80qLe3eAsgK+6BK2E
	 juNLz/pZhyvVX81gOvtt4EOX5EEl6OcpbWnfk9YI9ZY6dvTv8A/clEapRXe9aV5jMP
	 2kO2ZnyB4aIQ+KeO4y4Xhz5ow6Nz0Py0UHV6dSrPdI12t9mwiboa1JrIgBLgS9WPNY
	 2xAp/4ky4KrNyCAn9mRLA5XsD9JG7XYxFR/yeVQZyLjUELv5nk5qEoJwlMTPlEV4Fc
	 ybGZWfxFazH4Q==
Message-ID: <sashiko-outbox-162993@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 06/11] arm64/sframe: Validate IP addresses
Reply-To: sashiko-reviews@lists.linux.dev
To: "Weinan Liu" <wnliu@google.com>, "Will Deacon" <will@kernel.org>, "Indu
 Bhagat" <ibhagatgnu@gmail.com>, "Dylan Hatch" <dylanbhatch@google.com>, "Mark
 Rutland" <mark.rutland@arm.com>, "Roman Gushchin" <roman.gushchin@linux.dev>, "Steven
 Rostedt" <rostedt@goodmis.org>, "Jiri Kosina" <jikos@kernel.org>, "Jens
 Remus" <jremus@linux.ibm.com>, "Peter Zijlstra" <peterz@infradead.org>, "Catalin
 Marinas" <catalin.marinas@arm.com>, "Josh Poimboeuf" <jpoimboe@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, "Song Liu" <song@kernel.org>, live-patching@vger.kernel.org, linux-kernel@vger.kernel.org, linux-toolchains@vger.kernel.org, "Puranjay
 Mohan" <puranjay@kernel.org>, "Randy Dunlap" <rdunlap@infradead.org>, "Mostafa
 Saleh" <smostafa@google.com>, "Herbert Xu" <herbert@gondor.apana.org.au>, "Prasanna
 Kumar T S M" <ptsm@linux.microsoft.com>, joe.lawrence@redhat.com, "David S.
 Miller" <davem@davemloft.net>
In-Reply-To: <20261007114335.440322-7-dylanbhatch@google.com>
References: <20261007114335.440322-1-dylanbhatch@google.com>
 <20261007114335.440322-7-dylanbhatch@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 12:14:56 +0000
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] unwind: noinstr violation via static inline callees in sframe_find()
--

commit e12d5712c137b31d5aeba1eafd95262908a336d3
Author: Dylan Hatch <dylanbhatch@google.com>

arm64/sframe: Validate IP addresses

This commit adds validation for instruction pointers during sframe unwindin=
g.
It introduces architecture-specific checks for arm64 to ensure the IPs fall
within valid kernel or module text ranges, handling special sections like
.exit.text and .rodata.text.

[ ... ]
> diff --git a/arch/arm64/include/asm/unwind_sframe.h b/arch/arm64/include/=
asm/unwind_sframe.h
> new file mode 100644
> index 0000000000000..1b45d328c746f
> --- /dev/null
> +++ b/arch/arm64/include/asm/unwind_sframe.h
> @@ -0,0 +1,32 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_ARM64_UNWIND_SFRAME_H
> +#define _ASM_ARM64_UNWIND_SFRAME_H
> +
> +#include <linux/module.h>
> +#include <linux/sframe.h>
> +#include <asm/sections.h>
> +
> +static __always_inline bool sframe_is_kernel_ip_valid(unsigned long ip)
> +{
> +	if (__is_kernel_text(ip) || is_kernel_inittext(ip))
> +		return true;

[Severity: Low]
Since sframe_find() is marked noinstr and calls this helper, marking
sframe_is_kernel_ip_valid() as __always_inline helps prevent it from being
outlined. However, __is_kernel_text() and is_kernel_inittext() are standard
static inline functions. Could the compiler decide to outline these nested
helpers into the instrumentable .text section?

If that happens, objtool validation might fail during the build, and it cou=
ld
theoretically result in recursive instrumentation faults (e.g., KASAN) if
called during NMI stack unwinding.

> +
> +	/* .exit.text is retained in vmlinux on arm64. */
> +	if (ip >=3D (unsigned long)__exittext_begin &&
[ ... ]
> diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
> index 33883408581da..c95fcb63e7eaf 100644
> --- a/kernel/unwind/sframe.c
> +++ b/kernel/unwind/sframe.c
[ ... ]
> @@ -44,6 +44,45 @@ struct sframe_fre_internal {
[ ... ]
> +#ifdef CONFIG_MODULES
> +
> +static __always_inline bool sframe_is_sec_module_ip_valid(struct sframe_=
section *sec,
> +							  unsigned long ip)
> +{
> +	struct module *mod =3D container_of(sec, struct module, sframe_sec);
> +
> +	return within_module_mem_type(ip, mod, MOD_TEXT) ||
> +		within_module_mem_type(ip, mod, MOD_INIT_TEXT);

[Severity: Low]
Similarly, within_module_mem_type() is a regular static inline function
called from the noinstr path. Does this present the same outlining risk
as the kernel text helpers above?

> +}
> +
> +#else

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261007114335.4403=
22-1-dylanbhatch@google.com?part=3D6
