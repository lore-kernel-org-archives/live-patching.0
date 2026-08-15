Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048CC2F1FEC;
	Sat, 15 Aug 2026 05:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786770185; cv=none; b=jQL8CWAmg8UhaFDZAwfsc/AxLXorQEB4joBRbamspVn7Zb45RbgCRki90z1qUMJwMk/iMQDXnl6Vp+QDFpXxVnzd623/N+J04Ig2yV+Zmjw3Qnn0V/Pxm1CP0a8R2jbDTRg31hMyuqEJc0DJ//kYjYiQMC8w688nmGdwM2mgC10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786770185; c=relaxed/simple;
	bh=1QPQ63BbI83Ca9dYKrD1tqjDVy1V++amfAARpoYmmoU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Y5ZZiI6ZSRJGl+Y3MhHC9hCck+qBCzzuJs0jiqWKBH6B4lnIyB1q4qWV/EV38YBSinnS7R60cMO6JjC0hz8M4ZA2tGPTc2dVDB+e4qwYXS35RATvT3mTOBQ7tlp0EHsGd2Am9u3Kan/Lsf012KjHuWwfJFEJhCNWmOYgmgKb5FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PiBAATCa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PiBAATCa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86F851F000E9;
	Sat, 15 Aug 2026 05:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786770183;
	bh=rRTMgmRzAZtXNEOmAT8IbS28wddZr0+Lj7+LsIfEVA4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PiBAATCa8itJIkC++xchS6eUKPAdw1nwxt5GQa+XskLRQECxWmrgh/+OWayeeupcd
	 A6HAANOhSFRwCoijLQxbJbWbOO3QA6ADCy7ct196zSsyPppPm6SC68PToJlYG+z/XA
	 DqYgkXAQ02WUrS8uY3QYWpikWDNuHnvZERW0ebOwR7qnl7sD2LDrgkXgi+hnVvv9ll
	 wfGHZmB6g4g1uQbxvrDIK5RFsPsNqTzEI3H4oBIkMPFzGk3qnzouWkPzeRW8ZdSRYV
	 435PSrUXzLRdUADF9l3HrhFAViwzGoEzWjWby77EjsB36F0fubFFSADc4Zc23cqrb5
	 +WS4QRT8h/IeQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/12] arm64/bti: Advertise BTI in assembly objects
Reply-To: sashiko-reviews@lists.linux.dev
To: "Catalin Marinas" <catalin.marinas@arm.com>, "Josh Poimboeuf" <jpoimboe@kernel.org>, "Will
 Deacon" <will@kernel.org>
Cc: "Ard Biesheuvel" <ardb@kernel.org>, "Miroslav Benes" <mbenes@suse.cz>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Petr
 Mladek" <pmladek@suse.com>, "Mark Brown" <broonie@kernel.org>, live-patching@vger.kernel.org, "Nick
 Desaulniers" <ndesaulniers@google.com>, "Mark Rutland" <mark.rutland@arm.com>, "Joe
 Lawrence" <joe.lawrence@redhat.com>, "Kees Cook" <kees@kernel.org>, "Nathan
 Chancellor" <nathan@kernel.org>, "Song Liu" <song@kernel.org>, linux-toolchains@vger.kernel.org
In-Reply-To: <5340f3df281bebc81aad3cd9a7471d95061b4b9d.1786768375.git.jpoimboe@kernel.org>
References: <cover.1786768375.git.jpoimboe@kernel.org>
 <5340f3df281bebc81aad3cd9a7471d95061b4b9d.1786768375.git.jpoimboe@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 15 Aug 2026 05:03:02 +0000
Message-Id: <20260815050302.86F851F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch fails to enable BTI veneers for the kernel because EFI s=
tub and PI object files explicitly strip the property note.
--

--- Patch [7]: [PATCH 07/12] arm64/bti: Advertise BTI in assembly objects -=
--
commit f368db6f176a29dc1fd3803f6ac93282119ab6aa
Author: Josh Poimboeuf <jpoimboe@kernel.org>

arm64/bti: Advertise BTI in assembly objects

This commit forces the inclusion of a GNU property note with the BTI bit
into every assembly file. This is intended to ensure the linker emits BTI
veneers for >128MB kernels by ensuring all input objects have the property.

> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index 6b005c8fef706..4eee721c0b278 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -23,6 +23,10 @@ ifeq ($(CONFIG_ARM64_ERRATUM_843419),y)
>  LDFLAGS_vmlinux	+=3D --fix-cortex-a53-843419
>  endif
> =20
> +ifeq ($(CONFIG_ARM64_BTI_KERNEL),y)
> +KBUILD_AFLAGS	+=3D -include $(srctree)/arch/arm64/include/asm/bti-note.h
> +endif

[Severity: High]
This isn't a bug introduced by this patch, but will this approach still
fail to emit BTI veneers for the kernel?

The GNU linker requires all input objects to have the BTI property, but
the EFI stub and PI object files explicitly strip the property note before
they are linked into vmlinux.

In drivers/firmware/efi/libstub/Makefile:

STUBCOPY_FLAGS-y		+=3D --remove-section=3D.note.gnu.property

And in arch/arm64/kernel/pi/Makefile:

$(obj)/%.pi.o: OBJCOPYFLAGS :=3D --prefix-symbols=3D__pi_ \
			       --remove-section=3D.note.gnu.property

Since these objects are stripped of the note and linked into vmlinux,
will the linker continue to evaluate the global link with objects lacking
the BTI property, leaving the original large-kernel crash unresolved?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1786768375.gi=
t.jpoimboe@kernel.org?part=3D7
