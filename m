Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEE83C0630
	for <live-patching@vger.kernel.org>; Tue, 11 Aug 2026 16:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786465664; cv=pass; b=qA9b8+zV4iMoCx56H/aaqni6G2M+jjwbppQJP1EqRTue6z//J1F6l58KSVxIbZtGTBIYraMRrnblSXM0MBAX8GrDgi+PV57DvYATwWXwwntXSFI5cWep9AY4uGQ0GEF34f3KryMWtYwdpTbIy/kJVZqX+oETdp8F4ObSFjpQLOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786465664; c=relaxed/simple;
	bh=Xj9tz9KrKkfgGDO7aYlQKxsjPRxj3Jv2rjInFCZNb+0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NOl/ey+3F7ENq0a0EU9SP6CQn0LEJ8yAW2EQtHDXPz3ADWPydqP5uo9oZxtcq6aApsrBELVxsrklQut558cdhgg4KrV+NRWtmPBZ/2Y9gPVWkbr+DRJMzQZdbinpeZhPJHodsi6zhVMdzvyy7OYjaEBe9qYdBDxw2Ky14u7ojBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bZ4AR9bA; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bZ4AR9bA"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c2074710751so4381766b.1
        for <live-patching@vger.kernel.org>; Tue, 11 Aug 2026 09:27:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786465661; cv=none;
        d=google.com; s=arc-20260327;
        b=krPc/yx2YiovNZsIsdKqzmxU/clDik8TGuCPpWe/g3f3mXYZd9Y3zgs4QrbKXdciD7
         ITcbryTDbHUmF9S57tl/qUyyNImO2+yldE0bz2o4pM3GUaUTrxOXNM7YGGkBWPBXNM7a
         osbwVN9qz2x6U/2Hnyiu+zZ4zuEqRGBDqnfO/cQjNHXOZkH9m2/l4mrd4NN4S5No3Lkt
         L1ba0om/V8GclqD8AaeZaLD5F7Ds8IceP3S/LUKHMeewveREyIm1EYlKK2RRHde0jQu1
         14YqAIFxTN/NkyKgKMVViwQ+dU1iruo4eDr8tIqQaEum5tEh3+cIBtmTM79VYt1IJDOl
         og5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1wKcDZWZ9xIIi9sBYEFNIjetmSuFBzmeNKPPo41MolE=;
        fh=8O7xuJauKau3Op7QN9/JDHmQpxTi4PTU2c2RnxercWQ=;
        b=C/3oRdtTt+5fPjae2IeaX3oFXTB9UrqUWmZ2oSybcw2eKl37/89s0ArkiMssQ9uo6F
         C51NOBb/RT1jA5Ow4i5GOp0ikmTDj9GOYVnpx5NiFYDzNbrPTPwtrzfSyT7jvRX9nvKI
         OLdoN+yqHo+m0y9aZ/BRYbH6NUgzPyY1ks/MqBTzp9bUS5o1DcDJV3HaPB7y/GvCD/BU
         8kp/sLfcEuPrVmhf/3zUawBp7H00vFFUTkoMKGVWb6rNaVRBBzUR3WHw1msmsizMAmjh
         iMM+p9+s1zTRHHn72dvEzH4TBcaQtye43ZXgL0cq5uDUmiJzetar4APZ7iMV5iJb5TiK
         3lyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786465661; x=1787070461; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1wKcDZWZ9xIIi9sBYEFNIjetmSuFBzmeNKPPo41MolE=;
        b=bZ4AR9bAEOm45/oojOHP/O80y6EhaNdFimOtTzkmD5bsy3F5c1/lKSXDMDN1zv3wXN
         h2JKqQFgeKOFylK7bGBDKI/WwGEzZYk4IKnRNxKcDCBmNBibKH7kNxS0HM2t5i9feVhy
         VErSWJv0hfeQ2BHnSD/TEqG9lXpKmcAkiDKqkRDkMcL41Ay/cHBDV8Ng5KH1lGsb06LP
         v8sAItCbjehmF4nBznQGosQgXm5oE+xUpDNo/EGUkc2scivGpMdzMddH8gn0CCmdLm8y
         w3FMc0Ww1SYV+jV0eSkDswvgH2zzHqmoo9dfdILqyzosWE8RFdRAMVRssvPgxj5BOna/
         II8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786465661; x=1787070461;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1wKcDZWZ9xIIi9sBYEFNIjetmSuFBzmeNKPPo41MolE=;
        b=D7O4vhLqxFQdwN1Gj7Icydz84Jw5RWDOnVo4EJmSvZ2zHY6SoFxOKwRcMAfpLFK5eJ
         xh1SM1DhMGfX4XxAfbAmjoCofilmxr9ODCwbRcS3Y70pPIoE+4CVHRITParjLmAAN77C
         Pun0aAfOmYn/95reiDO3OvZNGe3COb1HYdSmjxRx8uswiWfopzN+nHpe3TuJzQB1ItIM
         EIMFFhXpxD7MTUvJ9IMTQaYsIMi/+5tRCyDv6uLTWfglW1SnvCot7gttgDBR2vLYSp2H
         k70ubiQ1/FBv9itRGwkjnkMLgyTwaj/IwSAXH2Y5NvQPl+bgk58pKEN6nIPE+6yqKpT3
         rcNQ==
X-Forwarded-Encrypted: i=1; AHgh+RpOXmlsfXApc5+TUKpSeg1EzuEshlkmD5g3tDivo7EhWzSvHqg1FGJmV7rWLYz8Xzyqlfl5wzIND0RfaKkW@vger.kernel.org
X-Gm-Message-State: AOJu0YzAuw1JNTaaaS5xOBBR+z1CaNxHM/glL9sUh0caNtCcCUVm5rdJ
	5pqNt2wCCs5t6fHVvLIJxFz96Osk/sx5bbAVCM0rmrPUJDFwplGeAj4We6cQhkjVfpHKHgxzYoJ
	amPqpmuFPri80Cnlig/6hO6gIe9tgqcQqepC310QU
X-Gm-Gg: AR+sD13Ryx8Lo5jtSlPLCQ7YwGQf7BdsRwFBJ46qawy2TrffJbtTVzfwgjYyADgxgYR
	1TwxlQxklUqtJs0d2ORnTGG3OQL+Fwl8yppt2DZ07DTAePZwV01aN4+tdFpDK6KvrCd7ZxvNuAC
	/1oLenRzneUqQShfte2VVPeldQqe3a3Xrs39X21oSTKE4bYd9g0QVHLNqLjV0IyKBDDbo950Ehb
	bHDDBIWGiKW0gpnov2jWt0878SI+085PRSKILEQ8i8F+xMaaNEmLYMa+KVV6dwYUztsvFzQ2x1i
	pLiJ5ypeouyk9GONQPc6u8oHbvGbDC7ng3Bj6hBFkkCu4mgNhqpFTATc601hk3HIVKptrKuVVIV
	ihFNIFeVzi/XA2+XlLw2wN10YzVzSRNlfi9BDA2stH9cfZP7K/UJHBA/yIgFFtBpzgjQ=
X-Received: by 2002:a17:907:d15:b0:c1f:e9d3:a3f0 with SMTP id
 a640c23a62f3a-c20e60df3a8mr254587866b.7.1786465660246; Tue, 11 Aug 2026
 09:27:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ed4fe1f95071897859ec7fbe9176246cbd4962bf.1786138806.git.jpoimboe@kernel.org>
 <anmobvJXiBQqWn6S@willie-the-truck> <e5q2mvqtf6iw4lco55uny5ffhppw6vlflxguhc4gg5nm3zdvmo@zs6rw7iov5qc>
 <08d6c5cd-9924-4359-9181-a03718161528@app.fastmail.com> <kp4rvh4vxo65gipgqz4i4dnw2ueylmus4yys6xfrbngp5nefzn@4a4ekjlzqlph>
 <CAKwvOdmSVjY0TmOTc6WMmDHcLbn=tOV3R3zH_TO4zXZiYEsaBw@mail.gmail.com>
 <anrvDIWMNGIa4WPK@willie-the-truck> <4986ac98-d6da-474a-b218-b6468b68cb9f@app.fastmail.com>
 <16e3ed42-1b1f-4ddc-9d8c-5e12ee7dbe3c@app.fastmail.com> <answWdRpVQLtIzIj@willie-the-truck>
In-Reply-To: <answWdRpVQLtIzIj@willie-the-truck>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Tue, 11 Aug 2026 09:27:28 -0700
X-Gm-Features: AUfX_mx63tcWy1Jtv82HuXBCB2XJ2aiGhpU71NomFwpZ9zzDnDI_X6osGygKWm8
Message-ID: <CAKwvOdkrxJ_9qjaBNQS+o=+_m_f3e9k6jMEmXB-S3+nXGoLV7w@mail.gmail.com>
Subject: Re: [PATCH] arm64/module: Fix livepatch BTI exceptions with Clang 21+
To: Will Deacon <will@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, live-patching@vger.kernel.org, 
	Song Liu <song@kernel.org>, Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, 
	Joe Lawrence <joe.lawrence@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Mark Brown <broonie@kernel.org>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 7:23=E2=80=AFAM Will Deacon <will@kernel.org> wrote=
:
>
> On Tue, Aug 11, 2026 at 03:18:17PM +0200, Ard Biesheuvel wrote:
> >
> > On Tue, 11 Aug 2026, at 14:02, Ard Biesheuvel wrote:
> > > On Tue, 11 Aug 2026, at 11:44, Will Deacon wrote:
> > >> On Mon, Aug 10, 2026 at 09:41:35AM -0700, Nick Desaulniers wrote:
> > >
> > >>> Sure, but let's replace this with a link to a bug report in llvm's
> > >>> issue tracker?
> > >>
> > >> Yes, please! I can apply the patch once we have the bug number.
> > >>
> > >
> > > I can look into that.
> >
> > https://github.com/llvm/llvm-project/issues/215547
>
> Thanks, Ard. I've ended up with the patch below.

What's the extent that HAVE_LIVEPATCH will be used?

Does this penalize kernels built with BTI in favor of HAVE_LIVEPATCH?

For example, with my Android hat on, if we have a kernel that's built
with ARM64_BTI_KERNEL=3Dy, and _dont_ use HAVE_LIVEPATCH, we're going to
turn off BTI for a feature we're not using?  But maybe we _do_ intend
to use HAVE_LIVEPATCH, and my assumption was wrong?

>
> Will
>
> --->8
>
> Author: Josh Poimboeuf <jpoimboe@kernel.org>
> Date:   Tue Aug 11 14:11:44 2026 +0000
>
>     arm64: bti: Disable in-kernel BTI with recent versions of Clang
>
>     The following BTI exception was seen when loading a livepatch module:
>
>       Internal error: Oops - BTI: 0000000036000001 [#1]  SMP
>       pstate: 634004c9 (nZCv daIF +PAN -UAO +TCO +DIT -SSBS BTYPE=3Djc)
>       pc : kill_orphaned_pgrp+0x0/0x150
>       lr : do_exit+0x498/0xaf0 [livepatch_combined]
>
>     The problem is that the patch module's do_exit() is branching to a
>     static function in vmlinux using a module PLT veneer (indirect branch=
),
>     but the target function doesn't have a BTI landing pad.
>
>     Clang 21+ omits the landing pad for static functions which can only b=
e
>     reached by a direct branch.  That's normally fine for ordinary module=
s
>     which only branch to global exported functions, but Mark Brown points
>     out [1] that this isn't guaranteed if the module branches between
>     sections. Futhermore, livepatch modules use klp relocations to refere=
nce
>     arbitrary kernel symbols, so with CONFIG_RANDOMIZE_MODULE_REGION_FULL
>     the module is far enough from the kernel that every R_AARCH64_CALL26
>     needs a PLT.
>
>     Put Clang 21+ in the naughty corner alongside GCC, which suffers from
>     the same issue, by disabling CONFIG_ARM64_BTI_KERNEL until we have a
>     version of the toolchain with the problem resolved.
>
>     Cc: Ard Biesheuvel <ardb@kernel.org>
>     Link: https://lore.kernel.org/r/da06bbd3-d04b-4d0f-b331-f5b91bc373a5@=
sirena.org.uk [1]
>     Fixes: fd1e0fd71f65 ("arm64: Implement HAVE_LIVEPATCH")
>     Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
>     [will: Stitched together commit message, diff and bug number]
>     Signed-off-by: Will Deacon <will@kernel.org>
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index b3afe0688919..fc57d90d92c1 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -2116,6 +2116,8 @@ config ARM64_BTI_KERNEL
>         depends on !CC_IS_GCC || GCC_VERSION >=3D 100100
>         # https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D106671
>         depends on !CC_IS_GCC
> +       # https://github.com/llvm/llvm-project/issues/215547
> +       depends on !CC_IS_CLANG || CLANG_VERSION < 210000
>         depends on (!FUNCTION_GRAPH_TRACER || DYNAMIC_FTRACE_WITH_ARGS)
>         help
>           Build the kernel with Branch Target Identification annotations
>


--=20
Thanks,
~Nick Desaulniers
