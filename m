Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AD74766B3;
	Wed,  7 Oct 2026 12:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791375012; cv=none; b=Q7HNIeSJDuSZAFMm5AHGNU89hjueOFOPr8EaNHhV4YBxBaDf9ExblKf9xlKtOWvYooiKnPzYogOWccwa7S0Zfc24rZ5ThgebzRljUaFSRMPU1waVg3nWZUow2/i8BuE5m09ztoFWTgl4t980gMZUcScbplmz1GECskW147xcrmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791375012; c=relaxed/simple;
	bh=Gka9R2lCN7IsdSH3RU0577zVXsSE9TgupBQ9jklnLVI=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=ubm+yhNW4Gcg5LsNc11oG3IL64/RYtsoqt22IFSa08o84VhjElKyQm4peqLW5ercoqXdqjUfaMYUW5pwho4XX1XvZGYYG9cFQLs6e5EAulYrkJb9RnkGLBvU+no+tu51chT3Hx3D+oN/TbZ3MrvftfPOpoiwO0w8jCnM2/1gsTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VNcvca9Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VNcvca9Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D996B1F0089B;
	Wed,  7 Oct 2026 12:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791374995;
	bh=naMvJAfcGvrFcLacfffBq4dCKTYyPBgJUQraZGSFLco=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VNcvca9Q/wslzLqGXs9/Wr32B94+T4l0oXh/GBzOzyzU6ufuYbSd8dRrrJDarwLon
	 Sw4pCkESH+e4CjHt1QA0jaeBbHUpkzNLaC5JjcoprxCdlIHA/ov5N6R9JRqcFFAqUQ
	 B/S7w6uQaXvBpOkwAXmIkkQ1BeVrZvx1d1mHPaBXYTNJMiljpYc+wb+eQW61CjLdZX
	 uFZsK7xVo3OxA8kZvlee7IivCIok3zmTt9ZF9Kv3gEfglvWbnodgu6oP/lFRZuQ4e4
	 QIK+oSCJur2ivHX9cOoFq197zNireI3ZWAsB2BW9G9Z1LGdIO+iQBxUrihJJpgqx9x
	 hIhGTEeh/L5iA==
Message-ID: <sashiko-outbox-162979@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 07/11] sframe: Add debug helpers with object name
Reply-To: sashiko-reviews@lists.linux.dev
To: "Catalin Marinas" <catalin.marinas@arm.com>, "Jiri Kosina" <jikos@kernel.org>, "Josh
 Poimboeuf" <jpoimboe@kernel.org>, "Indu Bhagat" <ibhagatgnu@gmail.com>, "Steven
 Rostedt" <rostedt@goodmis.org>, "Will Deacon" <will@kernel.org>, "Mark
 Rutland" <mark.rutland@arm.com>, "Weinan Liu" <wnliu@google.com>, "Peter
 Zijlstra" <peterz@infradead.org>, "Dylan Hatch" <dylanbhatch@google.com>, "Roman
 Gushchin" <roman.gushchin@linux.dev>, "Jens Remus" <jremus@linux.ibm.com>
Cc: "Herbert Xu" <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org, "Randy
 Dunlap" <rdunlap@infradead.org>, linux-toolchains@vger.kernel.org, "Puranjay
 Mohan" <puranjay@kernel.org>, "Prasanna Kumar T S M" <ptsm@linux.microsoft.com>, "Song
 Liu" <song@kernel.org>, linux-kernel@vger.kernel.org, live-patching@vger.kernel.org, joe.lawrence@redhat.com, "Mostafa
 Saleh" <smostafa@google.com>
In-Reply-To: <20261007114335.440322-8-dylanbhatch@google.com>
References: <20261007114335.440322-1-dylanbhatch@google.com>
 <20261007114335.440322-8-dylanbhatch@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 12:09:53 +0000
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] build: missing <linux/module.h> in sframe_debug.h
--

commit 586ddaf5514eed589ba4352e7a7684af607fdccf
Author: Dylan Hatch <dylanbhatch@google.com>

sframe: Add debug helpers with object name

This commit adds debug helpers that include the object name, formatting
messages with either the module name or vmlinux for kernel SFrame sections.

> diff --git a/kernel/unwind/sframe_debug.h b/kernel/unwind/sframe_debug.h
> new file mode 100644
> index 0000000000000..f0bc2136eaad0
> --- /dev/null
> +++ b/kernel/unwind/sframe_debug.h
> @@ -0,0 +1,34 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _SFRAME_DEBUG_H
> +#define _SFRAME_DEBUG_H
> +
> +#include <linux/sframe.h>
> +#include "sframe.h"
> +
> +#ifdef CONFIG_MODULES
> +
> +#define objname(sec) ((sec) =3D=3D &kernel_sfsec					\
> +		     ? "vmlinux"						\
> +		     : container_of((sec), struct module, sframe_sec)->name)

[Severity: Low]
Does this header need to include <linux/module.h> and <linux/stddef.h>?

The objname macro uses container_of and struct module, but the required
headers are not explicitly included. Any future C file including
sframe_debug.h directly without first including <linux/module.h> will fail
to compile.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261007114335.4403=
22-1-dylanbhatch@google.com?part=3D7
