Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C406A3BB101
	for <live-patching@vger.kernel.org>; Mon,  8 Jun 2026 10:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780914234; cv=none; b=Tb0zm+YScpRoh0sC/wNVRlxQfcCtb+4d2iCJhJaMHCdTduf6+nmCeQak8lpEHkjr94Sbfkf3heiwiI8gno4qSjEUtTNfXUeBZxuS4VBBzhIEynG4dTv0u/nmq9EW+RBgmxaa64Xh8BgIFFWMHECS9B/GxrvLm6tIRwstd+09MVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780914234; c=relaxed/simple;
	bh=6MpELDIbjqygMFP+/6YKmfA7rLMrKRE0M9AoqCx77A4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TlG9Wy5t4/Q+HDVYnDgApKT1wGpXUWE9GVTACEhsLN9D3S6qnlM3v+fuAI3O4HoJWBwtt7rb0h0qF76MZJJYStyfSyKjjjjiv51j7nIaRZYoS5gKTlBg3pSE5iIkgMaXi+GMrcrcj/q0meNISmY3qHll/yXXv7qYX01dIdSO2F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NKXtyIeq; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NKXtyIeq"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780914230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6IBL5TRYOu/3lqZwzTym9/c5iAqkJ0FxNm8ULU12h2A=;
	b=NKXtyIeqG03UbCilB01TT09eYT8a6i8EXX71dITkXgsQX+Xc4q6VrlPrmeCEeNqmMhuXg5
	4hqwbsQDU+ThZDn7u+iGPyhd7lhvQsoMdF9YhX4vTb/Cy3P8PhUfOGNEa5uQZAmWcy8OJh
	XKBGUdxCCoLTAWhFYpNETnoZfhe7g+w=
From: George Guo <dongtai.guo@linux.dev>
To: Xi Ruoyao <xry111@xry111.site>,
	chenhuacai@kernel.org,
	jpoimboe@kernel.org,
	peterz@infradead.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com
Cc: kernel@xen0n.name,
	joe.lawrence@redhat.com,
	rostedt@goodmis.org,
	ardb@kernel.org,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	yangtiezhu@loongson.cn,
	jiaxun.yang@flygoat.com,
	liukexin@kylinos.cn,
	loongarch@lists.linux.dev,
	live-patching@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	George Guo <guodongtai@kylinos.cn>
Subject: Re: [PATCH 5/8] LoongArch: fix kernel panic with -fPIC for same-compilation-unit symbol references
Date: Mon,  8 Jun 2026 18:23:26 +0800
Message-Id: <20260608102326.334246-1-dongtai.guo@linux.dev>
In-Reply-To: <046da9c8886dcb35d6427b7467ce551ef1426480.camel@xry111.site>
References: <20260604065317.219777-6-dongtai.guo@linux.dev> <046da9c8886dcb35d6427b7467ce551ef1426480.camel@xry111.site>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Fri, 2026-06-05 at 16:10 +0800, Xi Ruoyao wrote:
> This is incorrect.
>
> With GCC and Clang, -fPIC does not mean generating position independent
> code.  It means generating position independent code *suitable for
> SVR4-style shared objects*.
>
> The kernel has nothing to do with SVR4-style shared objects.  The
> kernel modules are not SVR4 shared objects but relocatable ELF object
> files.

You are right, and thank you for the correction. The commit message was
wrong: with CONFIG_RELOCATABLE=y the kernel is already built with -fPIE,
so the reference is not "absolute addressing" as I claimed. I will fix
the description in v2.

> If you only need position independent code (without the shared object
> stuff) you should use -fPIE instead.  The kernel is already built with
> -fPIE if CONFIG_RELOCATABLE=y.
>
> Thus if you only need position independent code you should make live
> patching depend on CONFIG_RELOCATABLE.

This is the part I should have explained better. CONFIG_RELOCATABLE=y is
already set in my config, so the kernel is already -fPIE, and the panic
still happens. I also tried building the KLP objects with -fPIE
explicitly and it does not help -- only -fPIC fixes it.

The reason is not "position independence" but GOT indirection, which is
exactly the SVR4-shared-object behaviour you mention. A minimal
'return uts_sem;' (uts_sem defined in the same TU) compiles like this on
loongarch64 -- same conclusion under both gcc 14.2.1 and clang 19.1.6:

  -fPIE:
    pcalau12i $a0, ...        R_LARCH_PCALA_HI20   uts_sem
    addi.d    $a0, $a0, ...   R_LARCH_PCALA_LO12   uts_sem
    ld.w      $a0, $a0, 0

  -fPIC:
    pcalau12i $a0, ...        R_LARCH_GOT_PC_HI20  uts_sem
    ld.d      $a0, $a0, ...   R_LARCH_GOT_PC_LO12  uts_sem
    ld.w      $a0, $a0, 0

So under -fPIE the access is direct (no GOT); under -fPIC it goes through
the GOT. (As an aside, gcc additionally collapses the -fPIE reference
onto a local anchor .LANCHOR0, leaving no named 'uts_sem' relocation at
all; clang keeps the name but still emits the direct, non-GOT form.)

klp-build extracts the patched function out of its original object file
and links it into a separate livepatch module, while the referenced
symbol (e.g. 'uts_sem') stays in the core kernel. The klp relocation
machinery resolves such cross-object references through GOT entries it
creates in the patch module. The direct R_LARCH_PCALA reference emitted
under -fPIE has no GOT slot for it to fix up, so once the function is
moved into the module its target is wrong and it faults.

So this is one of the cases where the KLP machinery genuinely relies on
the GOT-indirect ("shared object style") access that -fPIC provides and
-fPIE deliberately optimizes away. In v2 I will keep -fPIC but rewrite
the commit message to explain this GOT-vs-direct-PCALA reason instead of
the incorrect "absolute addressing" wording.

I can also include the readelf -r / objdump diff (R_LARCH_PCALA_* under
-fPIE vs R_LARCH_GOT_PC_* under -fPIC) in the v2 commit message if that
is useful.

Thanks again for the review.
