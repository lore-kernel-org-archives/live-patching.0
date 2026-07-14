Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB751DE8BF
	for <live-patching@vger.kernel.org>; Tue, 14 Jul 2026 00:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783988928; cv=none; b=FXe9G4oWjfYThcahZEMEpk0R5h80r4hMEeYBli+xoqkjfSUQGrfSeXhUnpZ9zGkZbs9GwJeouJrIIbVFPrL2m6zKYs8HAcpPPu1BkxDevH3g/LeqTSHCBFIisQIp0baVvZoxt7VlGtHoS4wd8Qk2ud4iFfO2BtJHEPBfSbQtCzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783988928; c=relaxed/simple;
	bh=36MCrMLUPiWMv/YeGFcP8R+p3e0PbBLgemBah4u0ZP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=alI0CSBadyjRsdCGwNlUWK/wSxsbNENZxtIY8VEQ6xhKQxpgqnSnG9PSkr5EhqgrJA3WRyrF+WoGiTPmKiHz0psZK6wkB4udBNg0QoFpBi7riaYZSa96wp7290B4iyW/qdw9icr9fHelQxcXesOcHVwhuckcJKjjAr848Ud3OII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=F/12HbvM; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="F/12HbvM"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ceb096e675so25452785ad.0
        for <live-patching@vger.kernel.org>; Mon, 13 Jul 2026 17:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1783988925; x=1784593725; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/KLAlmdqk7zVgY56HlRPXq3QqECg7aFAIKoSOWepQBw=;
        b=F/12HbvMaploI5Fhz0F9bqeyBqN3wcaGS5a7eyl7oeorkcXAlDvPAjBafY4WxVED3d
         oiGvd7xh5uNPQhU7/32BOjgTsgmvXCJK7UAZLzEifbcd+M8vfhVtMJQbcsST3sqHCvqH
         nRrpamcW+fVvcXZ9h1Rbla2xOHvU8rUfJKU3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783988925; x=1784593725;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/KLAlmdqk7zVgY56HlRPXq3QqECg7aFAIKoSOWepQBw=;
        b=BUEy/JXM7ZRJXj1vYq4Wy0CCaAoYiFynQyNMraHCi8maZ7zOUzhLr14vsBpzybDh/I
         +za4Xa82sCwgUeSAGLGwfJNbx7p1HEcFJRb87jDr2pN/TemsN1TFKEB878ATjdSJo5uY
         PmlzNeKW852DXwN8SYf0obk6mJLMGEHoJWqz3cwBnA6kzt9vf1Jmw+pRzvpVxn6jQg2A
         ND4j4aaMf+R6LfTN0cGiZML5v5uwL1GU85QDS4+E+mwPcGOn1wMLogU+TwNu41I/IT8J
         lLPvN5mJnckqKSnxTC6OZW+h3s1lMyeFGjMikBiYfS00S/IsX+GvyLHtXnezrutZpd+D
         1Kjg==
X-Forwarded-Encrypted: i=1; AHgh+Ron1P2hZSskYMNxPQufFARbUtJ3C4RNpmmgLEiV/NL7e+zKdzYRRWCNvdB2vM4X7bIGItFnWH7A8ub2RvQK@vger.kernel.org
X-Gm-Message-State: AOJu0YwZmfDOCSeecKbLptpvwsMms4e89fd+2V64+x+Q1aA8EIF2BTGg
	Sc4ZEFZNb/aXGoR0ICgqGFQI07UoW7R7+oAu4vOgVXmFYEZSBleBEquei+nLF3v+Rg==
X-Gm-Gg: AfdE7cmga0hno6HoYWYFHC5faZ81wTHFAnPJDFtZ2dR6h62Nmq/u9XR2ggj7WPASspx
	L7nUl0SgU0dL+ka7YCHbVw1DabeMlyJDpjKzhGhR+9urOUF5asQuD25SmcfIIsBPEtpUhoZ1TvX
	ysS3UWvl7dlggcTDSMRvJ8AUkKm+Ko93cpIPRVLKiiK+N+uRxCXh546MZm/6EnUMD84zkIMrxE0
	qtMf+AgCWLBQ6iBMy8wPB8g9xPuSbFduLtUStZJt9XoYs4REeQVeebWw3aiN6qZ+JXFgRU+nwP6
	1TyCHn7+eu929kH3OFDY8iUA97hpa9COHTHccIsS+F1Q6Xe2ys4lWjJHR1iw3UDWJ00E+B8Herz
	bE2pf81cX1Ctxb1DMmQjXpdbGWC1Vxooda4/RGGoYjOejjUACLyFNzKpX8DDbJvMnFE42bEMZpu
	XCztV6avOrBGwCsclT9BPVq1GafGeIzT+oScnCgEPWHLDLQMN+hL8=
X-Received: by 2002:a05:6a21:d82:b0:3bf:6c08:fb98 with SMTP id adf61e73a8af0-3c110a1b5d2mr12532962637.58.1783988924631;
        Mon, 13 Jul 2026 17:28:44 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:5106:b6e9:abed:6332])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-13b659c865asm80749507c88.11.2026.07.13.17.28.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 17:28:43 -0700 (PDT)
Date: Mon, 13 Jul 2026 17:28:40 -0700
From: Brian Norris <briannorris@chromium.org>
To: Jens Remus <jremus@linux.ibm.com>
Cc: Dylan Hatch <dylanbhatch@google.com>,
	Mostafa Saleh <smostafa@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Weinan Liu <wnliu@google.com>, Will Deacon <will@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Indu Bhagat <ibhagatgnu@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Kosina <jikos@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Prasanna Kumar T S M <ptsm@linux.microsoft.com>,
	Puranjay Mohan <puranjay@kernel.org>, Song Liu <song@kernel.org>,
	joe.lawrence@redhat.com, linux-toolchains@vger.kernel.org,
	linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v5 0/8] unwind, arm64: add sframe unwinder for kernel
Message-ID: <alWCuAA7r1otvROg@google.com>
References: <20260428183643.3796063-1-dylanbhatch@google.com>
 <agcEMEl-QR0g6DgF@google.com>
 <CADBMgpx38SUUuYYCm612STqh01jqv817WnJeeXYTD7Uc1r-fug@mail.gmail.com>
 <4f429a50-df5d-411f-b40e-048d3cad5133@linux.ibm.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <4f429a50-df5d-411f-b40e-048d3cad5133@linux.ibm.com>

Hi Jens,

On Tue, May 19, 2026 at 01:05:23PM +0200, Jens Remus wrote:
> Hi Dylan and Mostafa!

I also work at the same company as Dylan and Mostafa, and am therefore
probably using the same company-maintained Linux distribution.

> On 5/18/2026 7:55 PM, Dylan Hatch wrote:
> > On Fri, May 15, 2026 at 4:32=E2=80=AFAM Mostafa Saleh <smostafa@google.=
com> wrote:
> >> Not sure if related, but after updating my toolchain
> >> (aarch64-linux-gnu-gcc (Debian 15.2.0-4) 15.2.0), I hit link errors:
> >> ld.lld: error: arch/arm64/kernel/vdso/vgettimeofday.o:(.sframe) is bei=
ng placed in '.sframe'
> >> ld.lld: error: arch/arm64/kernel/vdso/vgetrandom.o:(.sframe) is being =
placed in '.sframe`

I've also been hitting this for some time, and I'd like to see if I can
figure out what's going wrong. My current workaround is:

--- a/Makefile
+++ b/Makefile
@@ -946,6 +946,8 @@ ifdef CONFIG_CC_IS_GCC
 KBUILD_CFLAGS	+=3D $(call cc-option,--param=3Dallow-store-data-races=3D0)
 KBUILD_CFLAGS	+=3D $(call cc-option,-fno-allow-store-data-races)
 endif
+# No sframe generation for kernel if enabled by default
+KBUILD_CFLAGS	+=3D $(call cc-option,-Xassembler --gsframe=3Dno)
=20
 ifdef CONFIG_READABLE_ASM
 # Disable optimizations that make assembler listings hard to read.

> > Previously when developing against the SFrame V2 format, I had fixed
> > these warnings with the VDSO Makefile change currently in this series:
> >=20
> > diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/M=
akefile
> > index 7dec05dd33b7..c60ef921956f 100644
> > --- a/arch/arm64/kernel/vdso/Makefile
> > +++ b/arch/arm64/kernel/vdso/Makefile
> > @@ -38,7 +38,7 @@ ccflags-y +=3D -DDISABLE_BRANCH_PROFILING -DBUILD_VDSO
> >  CC_FLAGS_REMOVE_VDSO :=3D $(CC_FLAGS_FTRACE) -Os $(CC_FLAGS_SCS) \
> >                         $(RANDSTRUCT_CFLAGS) $(KSTACK_ERASE_CFLAGS) \
> >                         $(GCC_PLUGINS_CFLAGS) \
> > -                       $(CC_FLAGS_LTO) $(CC_FLAGS_CFI) \
> > +                       $(CC_FLAGS_LTO) $(CC_FLAGS_CFI) $(CC_FLAGS_SFRA=
ME) \
> >                         -Wmissing-prototypes -Wmissing-declarations
> >=20
> >  CC_FLAGS_ADD_VDSO :=3D -O2 -mcmodel=3Dtiny -fasynchronous-unwind-tables
> >=20
> > But the warnings seem to have returned after upgrading my toolchain,
> > possibly due to SFrame V3 or some confounding change in GCC. The
> > --gsframe in the assembler should be set to 'no' by default, so
> > perhaps GCC is providing an override --gsframe internally?
>=20
> Could it be that your build of binutils was configured with
> --enable-default-sframe, so that the GNU assembler defaults to generate
> .sframe?  AFAIK this configure option was meant for distributors and
> package maintainers.
>=20
> You can check as follows whether --gsframe defaults to "no" or "yes":
>=20
> $ as --help | grep -A1 gsframe
>   --gsframe[=3D{no|yes}]    whether to generate SFrame stack trace inform=
ation
>                           (default: no)
> ...

$ aarch64-linux-gnu-as --help | grep -A1 gsframe
  --gsframe[=3D{no|yes}]    whether to generate SFrame stack trace informat=
ion
                          (default: no)
--
  --gsframe-<N>           generate SFrame version <N> information. 3 =3D=3D=
 <N>
  --scfi=3Dexperimental     Synthesize DWARF CFI for hand-written asm

> Maybe build the VDSO separately with V=3D1 to see what assembler/compiler
> options are effectively used (e.g. for vgettimeofday.o and vgetrandom.o
> mentioned in the linker error message above)?

A slightly tweaked version of my vgetrandom.o build line:

# CC      arch/arm64/kernel/vdso/vgetrandom.o
  aarch64-linux-gnu-gcc -Wp,-MMD,arch/arm64/kernel/vdso/.vgetrandom.o.d -no=
stdinc -I./arch/arm64/include -I./arch/arm64/include/generated -I./include =
-I./include -I./arch/arm64/include/uapi -I./arch/arm64/include/generated/ua=
pi -I./include/uapi -I./include/generated/uapi -include ./include/linux/com=
piler-version.h -include ./include/linux/kconfig.h -include ./include/linux=
/compiler_types.h -D__KERNEL__ -mlittle-endian -DCC_USING_PATCHABLE_FUNCTIO=
N_ENTRY -DKASAN_SHADOW_SCALE_SHIFT=3D -Werror -fshort-wchar -funsigned-char=
 -fno-common -fno-PIE -fno-strict-aliasing -std=3Dgnu11 -fms-extensions -mg=
eneral-regs-only -DCONFIG_CC_HAS_K_CONSTRAINT=3D1 -Wno-psabi -mabi=3Dlp64 -=
fno-asynchronous-unwind-tables -fno-unwind-tables -mbranch-protection=3Dpac=
-ret -Wa,-march=3Darmv8.5-a -DARM64_ASM_ARCH=3D'"armv8.5-a"' -DKASAN_SHADOW=
_SCALE_SHIFT=3D -fno-delete-null-pointer-checks -O2 -fno-allow-store-data-r=
aces -fstack-protector-strong -fno-omit-frame-pointer -fno-optimize-sibling=
-calls -ftrivial-auto-var-init=3Dzero -fzero-init-padding-bits=3Dall -fno-s=
tack-clash-protection -fno-inline-functions-called-once -fmin-function-alig=
nment=3D8 -fstrict-flex-arrays=3D3 -fno-strict-overflow -fno-stack-check -f=
conserve-stack -fno-builtin-wcslen -Wall -Wextra -Wundef -Werror=3Dimplicit=
-function-declaration -Werror=3Dimplicit-int -Werror=3Dreturn-type -Werror=
=3Dstrict-prototypes -Wno-format-security -Wno-trigraphs -Wno-frame-address=
 -Wno-address-of-packed-member -Wframe-larger-than=3D2048 -Wno-main -Wno-ty=
pe-limits -Wno-dangling-pointer -Wvla-larger-than=3D1 -Wno-pointer-sign -Wc=
ast-function-type -Wno-unterminated-string-initialization -Wno-array-bounds=
 -Wno-stringop-overflow -Wno-alloc-size-larger-than -Wimplicit-fallthrough=
=3D5 -Werror=3Ddate-time -Werror=3Dincompatible-pointer-types -Werror=3Ddes=
ignated-init -Wenum-conversion -Wunused -Wno-unused-but-set-variable -Wno-u=
nused-const-variable -Wno-packed-not-aligned -Wno-format-overflow -Wno-form=
at-truncation -Wno-stringop-truncation -Wno-override-init -Wno-missing-fiel=
d-initializers -Wno-shift-negative-value -Wno-maybe-uninitialized -Wno-sign=
-compare -Wno-unused-parameter -g -mstack-protector-guard=3Dsysreg -mstack-=
protector-guard-reg=3Dsp_el0 -mstack-protector-guard-offset=3D1344 -fno-com=
mon -fno-builtin -fno-stack-protector -ffixed-x18 -DDISABLE_BRANCH_PROFILIN=
G -DBUILD_VDSO -O2 -mcmodel=3Dtiny -fasynchronous-unwind-tables -include ./=
lib/vdso/getrandom.c   -I./arch/arm64/kernel/vdso -Iarch/arm64/kernel/vdso =
   -DKBUILD_MODFILE=3D'"arch/arm64/kernel/vdso/vgetrandom"' -DKBUILD_BASENA=
ME=3D'"vgetrandom"' -DKBUILD_MODNAME=3D'"vgetrandom"' -D__KBUILD_MODNAME=3D=
vgetrandom -c -o arch/arm64/kernel/vdso/vgetrandom.o ./arch/arm64/kernel/vd=
so/vgetrandom.c

I mostly don't know what I'm looking for w.r.t. gsframe features, but
I'm willing to poke at my compiler/assembler/build-process.

Brian
