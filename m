Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F91377558
	for <live-patching@vger.kernel.org>; Mon, 17 Aug 2026 19:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786996502; cv=pass; b=S33XDE1JlgtZ0bTf4bdAQvkgE0ImkfWFComf96hqnAwVHyJ15yQk/5RuJFkwC511JlbQpdWhcMqX+7l7tmSMPbWOLFkTVrItVemlscP1rzZtzgx7GrjRDWFD/jux7gEHjcoRj0MIeDW3rLGIVOPMF4nMAeqUWDpT85ZVkR0MSPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786996502; c=relaxed/simple;
	bh=yvICGRDviZ9Mxl2myEhHYYGBApOjkwX/h1S7R98bUPI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LSQd7++aWxbfvhngEyJCUFLhO5TceSqNX2TlHJJ2eVMmIKOWT7lcKA081mSWFrj3Xmtj1dCQlCJN/Im8VT6cvZDIWO4l/RvduvUrCDzlCzB+3av6OGdV0iQSX0kL9c9MSmaUNF0gSGjIiY4/Yh4ucWZR3rDKv7hZUqZwZ3LX2bk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c3yG6BnW; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c3yG6BnW"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c20e70a0962so504709966b.2
        for <live-patching@vger.kernel.org>; Mon, 17 Aug 2026 12:55:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786996499; cv=none;
        d=google.com; s=arc-20260327;
        b=ZWY4s1trwSZlVP7IptoXW0Dr8OV22qx3gDryfXIh4PC3RbLGp4ECBmRGu2I8SNwCTg
         5Q4egGMyEWQg5tHOUQvC6WfbbFNVMFkPtow7AxUgDUxwq79Gg+ipCgmsS+CNiVt64n/f
         ZNuFJAWfJm1b6YAH3SBL95fkMvhySJySHSm/SGggf1MVgystCkswU88D0azAo7iztSmO
         97G1NytK5j4YOJuIsN4al6mO9lqtwOOpK1NzGcwMJEhahXO/Qg7M8wcxHMCHzyD+wNTR
         3OwlPaqRi2Kcowxdc2hn4FTApnw1D77kP57rjr3M/EBqWl8EqlMQJP5qZQrkoC8cXmh+
         xYcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fSMWOgsnzrhn6WjSaQuzJQj5JGPMtb+BQqa114k3Tnc=;
        fh=TsCK5CP0yxIRjWQFV9N3oSZJYYgRzlWajR5l383tDyc=;
        b=GJci3XWK+DJWkE6fRhv1sSLk1+hoYmF2grS+oW7giENUXwd5QfNpRNCgCDmKlJ8bPR
         63mK76Tt+ctZy/Qn1iGe0RicsD3r8yA90q64Po2wzu0XXUCHUMOKTOVBZanm4QjiPMl/
         waXDeE3Ooo9aCLC+KJhHB+y98OWjLIhekOjDi22wIoDMkA3jkNzWwNQdi/kbB4Ld3+u9
         ju5xMF8PXtMf3ueBQNLFKGAQwmKsvW2GDxPUZ9jiFF2zNAg+P1nisOP4KD+b3JJhWPIo
         Cu/uFhJTAxP2d0WLWrWLzhTDLLxvzlBgxgRh8wrMRKKiJvQFKpEcQKHonLV32srJJmV+
         RIGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786996499; x=1787601299; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fSMWOgsnzrhn6WjSaQuzJQj5JGPMtb+BQqa114k3Tnc=;
        b=c3yG6BnW8Ng/4aF73RgyvEdOt+kptrEGMBWykeT8cTOGHQunu8Ij7NyMdPNOdehuwp
         ipR9uQxP9tMExU1+T/urPQbN1I1vTVPN6xm3k/lTK5HCL6nUcOu0ZrFNI6RzVHK15B3n
         ybh+jcP9ArJeSZNIY0P2IhcK6c5phZluSxNnbK0/80kdkyJq0oMpi4cD0MR5gUZ8qrNg
         Xv+usTWzWI3emesGkuOR4uVTWOBTVz5A+ohcG+rppA/RIBvzn/vpb+M70bJn31ld5luT
         Z+/SZPcl3dDmVBsuNGh2Pjc2jmpclehlfD2GcO5y9kPPCQQAZkeHYW1k3mb9gh4JsPq1
         WYrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786996499; x=1787601299;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fSMWOgsnzrhn6WjSaQuzJQj5JGPMtb+BQqa114k3Tnc=;
        b=l+3bYyr6dHVTyOUCF6fFBlkLvcHl5gdgKJX/y+V9JBpgzg/HN35j5ndP2FgCJ3ZuAG
         5+CRJq4AYWKpxbVnsJjLP2rBdU9Ytap5hR5lts6XtU6Wt3nGe94tzGXtz1ZXUiHn4zo9
         FKZaf6Mk7RJ2RCL+dUeOxlZ5wAfC9T25NIQy4tK7DoMeGov4eyp/QTcsVmEhA+vNT/4y
         Dx3ltUHyV+bS3raw8NkNioR8W9PWTUqs97SdAXRMprrDO0tPPFJEW883EcFdk6MJsStr
         4y9i4ZmTuJB+j+yc92W/9aePZdyss5uj1ZuqZKfV6pheccDopEwc3FWu+ZarD9QJ8PDo
         sEUQ==
X-Forwarded-Encrypted: i=1; AHgh+RoostojjhXX4LHg+g0ctHpTMha95j+wK0W+whvsCWwpZxVmA1NRFXK7zNCQO9rhHhf3OHZOrLHs+5H6wpbB@vger.kernel.org
X-Gm-Message-State: AOJu0YwX/Smde7BS6XKSG8GozG+lVe3Ps4Rmm2V5oBJNx+eVeZaOEpIj
	LWIO8+WZLy8ep6U1bxSH/RgRWuVAjgbQIUMMrECE7rempcRpzwowkDMI6JUAcKDYaWm/OXRrn7M
	vvArd4U6BF8AG5L2DAy841lNKpvMftGRwTBx5bMB+
X-Gm-Gg: AR+sD13/tdWeMMWfqo3Q7o587SSyg4rOiBVewVpLIsyY7268c11+WtrA5jqkU/6d+dt
	WeDYZpVyHZ7m0FpQvtHNw3PuxBypJsqsrV61eUdzDCIsXUMO2yPIaWl/SaXHKsRgoudDDM9neM7
	HaZHMmz8zCCH8crHzYhJyUAX3zZkYFRqlP9dU/ff3CtctyP9CjU57zoprjqooKkFZ5bEybp8rPM
	7V/wzAtAwGzSQfmUuOOjUKU/7aPRM/Pw1SCPD7pmhl45eQsORAM+H9TymyWED0OppIyWckW/hwH
	fWh0e39wO8lKN6a6QuZCP52ZxXq8P1dDpdmTqWFU0tXOnuBxK4aQ3BMk8JImPANlAOf08bjILy5
	ljydYG8TcZohIjLklVJE/pJIU6x+f3868ucaTj0mOxEMopP+A+Y2kOgyB
X-Received: by 2002:a05:6938:a081:20b0:c16:12ff:dc93 with SMTP id
 a640c23a62f3a-c21885d0e18mr100346666b.18.1786996498684; Mon, 17 Aug 2026
 12:54:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1786768375.git.jpoimboe@kernel.org> <e5c957d816240e749a92588d4a9bb44da791f8e3.1786768375.git.jpoimboe@kernel.org>
In-Reply-To: <e5c957d816240e749a92588d4a9bb44da791f8e3.1786768375.git.jpoimboe@kernel.org>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Mon, 17 Aug 2026 12:54:47 -0700
X-Gm-Features: AcwNN1X5GYhNIXFwByZPWbcQ7Kc1jXcOVcJq-v_hRwbMgl2NTJnecge5Wd_AP5Q
Message-ID: <CAKwvOd=Vn4L1sJ=8zVk9qcDLtaDYxfxn+0aG4tMrbETsqY5_PQ@mail.gmail.com>
Subject: Re: [PATCH 10/12] efi/libstub: Remove obsolete .note.gnu.property workaround
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, live-patching@vger.kernel.org, 
	Song Liu <song@kernel.org>, Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, 
	Joe Lawrence <joe.lawrence@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Mark Brown <broonie@kernel.org>, Kees Cook <kees@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, linux-toolchains@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2026 at 9:45=E2=80=AFPM Josh Poimboeuf <jpoimboe@kernel.org=
> wrote:
>
> Commit e2179a09ab08 ("efi/libstub: Disable -mbranch-protection") added
> --remove-section=3D.note.gnu.property to the stub objcopy invocation to
> work around a Clang bug where the note was emitted for code-less object
> files even with -mbranch-protection=3Dnone.
>
> That was fixed by LLVM commit a48f6079f288 ("[AArch64] Generate
> .note.gnu.property based on module flags") which was released with
> Clang 12.  The minimum Clang version is now Clang 17, so this workaround
> is no longer needed.
>
> On arm64, the stub also no longer builds with -mbranch-protection=3Dnone,
> as it has inherited the kernel's flags since commit 8358098b9787
> ("arm64: efi: Enable BTI codegen and add PE/COFF annotation").

I verified the above all looks correct.  Thanks for the cleanup.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> Remove the workaround.  This fixes BTI on arm64, and is a no-op on
> RISC-V and LoongArch where the vmlinux generic NOTES macro discards it,
> and the x86 and ARM decompressors discard .note.* explicitly.
>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>  drivers/firmware/efi/libstub/Makefile | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi=
/libstub/Makefile
> index b1c95f69e807d..e18e124a89acf 100644
> --- a/drivers/firmware/efi/libstub/Makefile
> +++ b/drivers/firmware/efi/libstub/Makefile
> @@ -106,12 +106,6 @@ lib-$(CONFIG_UNACCEPTED_MEMORY) +=3D unaccepted_memo=
ry.o bitmap.o find.o
>  targets                                :=3D $(lib-y)
>  lib-y                          :=3D $(patsubst %.o,%.stub.o,$(lib-y))
>
> -# Even when -mbranch-protection=3Dnone is set, Clang will generate a
> -# .note.gnu.property for code-less object files (like lib/ctype.c),
> -# so work around this by explicitly removing the unwanted section.
> -# https://llvm.org/pr46480
> -STUBCOPY_FLAGS-y               +=3D --remove-section=3D.note.gnu.propert=
y
> -
>  STUBCOPY_RELOC-$(CONFIG_X86_32)        :=3D R_386_32
>  STUBCOPY_RELOC-$(CONFIG_X86_64)        :=3D R_X86_64_64
>
> --
> 2.55.0
>


--=20
Thanks,
~Nick Desaulniers
