Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E9E156F45;
	Sat, 15 Aug 2026 05:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786770060; cv=none; b=DxUvBvhPA6ur4pk/84cJHdc2QlcEbljv7Ua/vdvagM9J+rukIIhlMP75W8SU3VPJVEK+GpnRm+7hAEYrK/9ngGkjbXHg1tSyrEvSUstD6zn0VFxaTLzRuTp0Cti+i03Tn/k6OGYjs8XHTwyp96x4wgpYrZnbHBA/TY8LwnCTzsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786770060; c=relaxed/simple;
	bh=AP+qWrHtSEIYZghT9Y0S8lDw/neHcN3BVQVYJuD1yRI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dmU3KAKoEjmFO+OPqMxJ1TI2t3iTTj9OYKroj4Pq7fswUMUzaCfDrahufvEBMIud1+voYdDBYLOxE+Gw/UyntPZNRo0+Eja4GlqI1f+RdUL4QeInFvBoSmZscB5krs3UdPTLM4c3b/26NoK1f572cVWQFxsUu2CQJLVhB0JXU3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bcspw1rc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bcspw1rc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACCE51F00A3D;
	Sat, 15 Aug 2026 05:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786770059;
	bh=7eS07SXGwx21modMUDcvK0pVgzUSuDjnYthy1a/bug4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Bcspw1rcBO+0xUhrc2Mh/ffAdtwMmJcp2rEpgBMdUZRmNf6verFXl6gM3uTEOdIqx
	 25jyvCRBaCuZlTQ5/Eoajypagq4fk1yOtTqMW+0Z1MWnCPH/VVL8YjcaedntxjE1Rf
	 ccjnY2Ty5EWsj4LyXf/4TlOAxCOpOj833/0vBPuSmN6EaVn4xRCawW5RXn8K+6uLMp
	 NJG9Y8WaTh0utSCQFLEusI3m/I9pxn3AnqmhsY27sNlHQZlsxz80RD6yyjNNUBDXZf
	 YpZJpsS89ffSRMglEMYwo6ZgulXofYUv29ce/MTW9gQXOXUooR+if1JJVSpbbNjgsw
	 ZzzXy054KXRCw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/12] arm64/bti: Force-enable BTI linker veneers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Catalin Marinas" <catalin.marinas@arm.com>, "Josh Poimboeuf" <jpoimboe@kernel.org>, "Will
 Deacon" <will@kernel.org>
Cc: "Mark Brown" <broonie@kernel.org>, "Joe Lawrence" <joe.lawrence@redhat.com>, "Song
 Liu" <song@kernel.org>, "Ard Biesheuvel" <ardb@kernel.org>, "Petr Mladek" <pmladek@suse.com>, linux-kernel@vger.kernel.org, "Mark
 Rutland" <mark.rutland@arm.com>, linux-toolchains@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Nick
 Desaulniers" <ndesaulniers@google.com>, live-patching@vger.kernel.org, "Miroslav
 Benes" <mbenes@suse.cz>, "Kees Cook" <kees@kernel.org>, "Nathan Chancellor" <nathan@kernel.org>
In-Reply-To: <edae8b52c1cba6eecd0bc75f709f6009816b80b8.1786768375.git.jpoimboe@kernel.org>
References: <cover.1786768375.git.jpoimboe@kernel.org>
 <edae8b52c1cba6eecd0bc75f709f6009816b80b8.1786768375.git.jpoimboe@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 15 Aug 2026 05:00:58 +0000
Message-Id: <20260815050058.ACCE51F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] ld-option incorrectly evaluates to true for -z force-bti on olde=
r GNU ld versions, causing build failures.
--

--- Patch [11]: [PATCH 11/12] arm64/bti: Force-enable BTI linker veneers ---
commit dc92fd3fe21010a76154b8b30a8e4ff7c0d55416
Author: Josh Poimboeuf <jpoimboe@kernel.org>

arm64/bti: Force-enable BTI linker veneers

This commit force-enables BTI veneers using the "-z force-bti" linker
option to ensure they are created even if some input objects are missing
the BTI feature bit. This aims to prevent silent runtime BTI exceptions
on larger kernels.

> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index 4eee721c0b278..d0db9a6766a2f 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -25,6 +25,7 @@ endif
> =20
>  ifeq ($(CONFIG_ARM64_BTI_KERNEL),y)
>  KBUILD_AFLAGS	+=3D -include $(srctree)/arch/arm64/include/asm/bti-note.h
> +LDFLAGS_vmlinux	+=3D $(call ld-option,-z force-bti)

[Severity: Medium]
Does this ld-option check reliably detect if the linker supports "-z force-=
bti"?

When Kbuild's ld-option tests linker support, it executes the linker with "=
-v".
However, when GNU ld is invoked with "-v" and no input files, it prints its
version information and immediately exits with a 0 status code, completely
bypassing any validation of keyword arguments like "-z".

Because of this, ld-option will falsely report that "-z force-bti" is suppo=
rted
on all versions of GNU ld, even older versions (prior to 2.34) where the op=
tion
was not yet introduced.=20

During the actual kernel link, ld parses the "-z" list, fails to recognize
"force-bti", and emits an ignored warning. If CONFIG_WERROR=3Dy is set, the=
 linker
escalates this warning to a fatal error and breaks the build. On builds wit=
hout
CONFIG_WERROR, the warning is ignored and the patch silently fails to enfor=
ce
the intended BTI veneers.

>  endif
> =20
>  cc_has_k_constraint :=3D $(call try-run,echo				\

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1786768375.gi=
t.jpoimboe@kernel.org?part=3D11
