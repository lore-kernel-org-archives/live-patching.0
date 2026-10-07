Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DF63CF1E7;
	Wed,  7 Oct 2026 11:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791374208; cv=none; b=RhFde+31qACa7TAx+9dRifTjHJbTF8LYfdqAMJXtpHAFfzSd109qIKw84y+JUQOL69yNJlw9w59wiWAwwwzI/yjzSyU6K8csJ7iEhDaLTiInrqxJRxjzNiIOhYellkVsBAUJqxiNTDqq2IPJ/avTjudYmBlxD53BmUbowe4EXkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791374208; c=relaxed/simple;
	bh=OkbGpd66+Nr9ShwHO3A+rLYZ3ox3/2jIuyWtiZPG3dU=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=r+OS1vGqgoSzH14YpaH+dhMTMTIKw/wgCoOUGqTEObsA6m7pcwAxQFvA9tt9OWsRyIaAV9TOayyeFiydcvqZX7EwmraAPIjG0pzesub2EhotviNEqMTWIzRhpsNFtNYqr2XnszEhqAPUTkKWCKsIKMH5h1kOAoqmH7pPmaLJprA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VczpgDLr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VczpgDLr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D5BC1F0089B;
	Wed,  7 Oct 2026 11:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791374193;
	bh=jQs8AwO3syyOhI3liJkXTsOu5/M8XoKj9b56OonPAFU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VczpgDLr9GTfPXPwOOjO3h794xiHVdi89uIwcixFdqTK0qk7TNS6mTR3sGVo9+9fN
	 EMM+EaHOJz3jk3GyJt77UWxjnbC/F05UqtT8J0kz4mjUrDoaKAfn/bKxtQqoCGV6Qc
	 kbHNS1R96EWTtzFmEW9tYtPIef3BU1iIFQdTSqnIxQgYSCFo682v8pCcpVokxPc37E
	 nCMOBX2retd49npX9NE4l8pbLWLxKZtN6K9u3kEjmCgZutoGLSzvV3wLtgmXqZRkxQ
	 oQIJsGgKblPzCXd4J6cpqn9Y98w4ItmvZEl/B4cjDTrqFOGWxT5cQrocOznKWa5Y5s
	 caBafrQd5MZFQ==
Message-ID: <sashiko-outbox-162957@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 01/11] arm64, unwind: build kernel with sframe V3
 info
Reply-To: sashiko-reviews@lists.linux.dev
To: "Roman Gushchin" <roman.gushchin@linux.dev>, "Peter Zijlstra" <peterz@infradead.org>, "Dylan
 Hatch" <dylanbhatch@google.com>, "Steven Rostedt" <rostedt@goodmis.org>, "Josh
 Poimboeuf" <jpoimboe@kernel.org>, "Catalin Marinas" <catalin.marinas@arm.com>, "Jens
 Remus" <jremus@linux.ibm.com>, "Indu Bhagat" <ibhagatgnu@gmail.com>, "Will
 Deacon" <will@kernel.org>, "Jiri Kosina" <jikos@kernel.org>, "Weinan Liu" <wnliu@google.com>, "Mark
 Rutland" <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-toolchains@vger.kernel.org, "Herbert
 Xu" <herbert@gondor.apana.org.au>, "Prasanna Kumar T S M" <ptsm@linux.microsoft.com>, joe.lawrence@redhat.com, live-patching@vger.kernel.org, "Song
 Liu" <song@kernel.org>, "Puranjay Mohan" <puranjay@kernel.org>, linux-arm-kernel@lists.infradead.org, "Randy
 Dunlap" <rdunlap@infradead.org>, "David S. Miller" <davem@davemloft.net>, "Mostafa
 Saleh" <smostafa@google.com>
In-Reply-To: <20261007114335.440322-2-dylanbhatch@google.com>
References: <20261007114335.440322-1-dylanbhatch@google.com>
 <20261007114335.440322-2-dylanbhatch@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 11:56:31 +0000
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] unwind: missing SFrame unwind information for Rust code
--

commit 531ea7668c66f4aab865a6399bb07911c3617223
Author: Dylan Hatch <dylanbhatch@google.com>

arm64, unwind: build kernel with sframe V3 info

To generate a .sframe section, build with -Wa,--gsframe-3 flags. Also,
add unwind-table options to ensure the necessary CFI directives are
emitted by the compiler, but discard .eh_frame unless
CONFIG_UNWIND_TABLES is explicitly enabled.

> diff --git a/Makefile b/Makefile
> index 7c855e6fe5448..5c2ca98a86786 100644
> --- a/Makefile
> +++ b/Makefile
[ ... ]
> @@ -1197,6 +1197,14 @@ CFLAGS_GCOV	+=3D $(call try-run,\
>  endif
>  export CFLAGS_GCOV
> =20
> +# build with sframe table
> +ifdef CONFIG_HAVE_UNWIND_KERNEL_SFRAME
> +CC_FLAGS_SFRAME :=3D -Wa,--gsframe-3
> +KBUILD_CFLAGS	+=3D $(CC_FLAGS_SFRAME)
> +KBUILD_AFLAGS	+=3D $(CC_FLAGS_SFRAME)

[Severity: Medium]
When CONFIG_HAVE_UNWIND_KERNEL_SFRAME is enabled, the generation flag is
added to C and ASM flags in Makefile, but no equivalent flag is passed to
the Rust compiler.

Because rustc emits object files directly using its LLVM backend and
currently lacks native SFrame emission, does it generate standard .eh_frame
data instead of .sframe?

> +export CC_FLAGS_SFRAME
> +endif
> +
>  # change __FILE__ to the relative path to the source directory
>  ifdef building_out_of_srctree
[ ... ]
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index 6b005c8fef706..ae1c23579ad2f 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
[ ... ]
> @@ -55,7 +55,7 @@ KBUILD_CFLAGS	+=3D $(call cc-option,-mabi=3Dlp64)
>  KBUILD_AFLAGS	+=3D $(call cc-option,-mabi=3Dlp64)
> =20
>  # Avoid generating .eh_frame* sections.
> -ifneq ($(CONFIG_UNWIND_TABLES),y)
> +ifeq ($(filter y, $(CONFIG_UNWIND_TABLES) $(CONFIG_HAVE_UNWIND_KERNEL_SF=
RAME)),)
>  KBUILD_CFLAGS	+=3D -fno-asynchronous-unwind-tables -fno-unwind-tables
>  KBUILD_AFLAGS	+=3D -fno-asynchronous-unwind-tables -fno-unwind-tables
>  KBUILD_RUSTFLAGS +=3D -Cforce-unwind-tables=3Dn

[Severity: Medium]
In arch/arm64/Makefile, this change ensures that Rust continues generating
unwind tables when SFrame is enabled. Does this mean Rust will continue to
generate DWARF unwind tables since -Cforce-unwind-tables=3Dn is not applied
when CONFIG_HAVE_UNWIND_KERNEL_SFRAME is enabled and CONFIG_UNWIND_TABLES
is disabled?

[ ... ]
> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.=
lds.S
> index af1d720209764..eb1f54829503c 100644
> --- a/arch/arm64/kernel/vmlinux.lds.S
> +++ b/arch/arm64/kernel/vmlinux.lds.S
[ ... ]
> @@ -145,14 +145,25 @@ jiffies =3D jiffies_64;
>  #endif
> =20
>  #ifdef CONFIG_UNWIND_TABLES
> +
>  #define UNWIND_DATA_SECTIONS				\
>  	.eh_frame : {					\
>  		__pi___eh_frame_start =3D .;		\
>  		*(.eh_frame)				\
>  		__pi___eh_frame_end =3D .;		\
>  	}
> +#define SFRAME_DISCARDS
> +
> +#elif defined(CONFIG_HAVE_UNWIND_KERNEL_SFRAME)
> +
> +#define UNWIND_DATA_SECTIONS
> +#define SFRAME_DISCARDS *(.eh_frame)

[Severity: Medium]
When only CONFIG_HAVE_UNWIND_KERNEL_SFRAME is enabled and
CONFIG_UNWIND_TABLES is disabled, the .eh_frame sections are explicitly
discarded here in arch/arm64/kernel/vmlinux.lds.S.

Since Rust code emits .eh_frame data instead of .sframe, does discarding
these sections silently leave all compiled Rust objects without any unwind
information? Could this break reliable stack unwinding across Rust frames?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261007114335.4403=
22-1-dylanbhatch@google.com?part=3D1
