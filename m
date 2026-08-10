Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB1D3BADA9;
	Mon, 10 Aug 2026 10:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786357877; cv=none; b=l63Abm6WUIuv89srZd9PRm+iZ65mBs9HEq3L0Q29bgS7uqGJRh/NUYBf5Z87p01c6dMnBP9v2O8CuxTRHSjExNylPLHSWKW02Y06O4cudVnXSawq7z/qlxp8t8HsDRTlt8BpzqpFDAY6sfc1fZTwteHgoWt89jwLWk0ASunrJQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786357877; c=relaxed/simple;
	bh=D7O1chavq7mnVPlCIi+Q1UQnC6ZftpNXMABBkouh1ME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lr1apluwbu3OtqBcSETy8gc4ddSGavEevS5iEfqV8lFtbZinf7uQd1bK8lcoZgGusEJQTaMpscleJiNqO4LkaJYg2T2zlhqCtboNKulzL6feOuwAR28gSnPSinOPaKFuZAO4FjJ+MRr9ohtSHxeKmZ3htCYU1Ro1DjwnpppcaD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A6utgY3L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A6utgY3L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 696901F000E9;
	Mon, 10 Aug 2026 10:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786357876;
	bh=T2rdagmXWfGPAIzO27YZsC0M9W0VZdij5BhCuKZjYSw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=A6utgY3LlJYWRMPuC8wdlIE0qKmJ4qA+6NPGz7UORV9rorxpaxw5NZAHYWukKfQ8U
	 glXgp06JMMtMIuNpYLyBiQLRu4an7OgUgZV9S0jtIWEdu67gs4wjZAaaAMuG6vyIyh
	 t02gjfWlF/peX2XVlpNoqOgcdfr00m+r03D1t76AcGeJ3uR94RYAPK78cz3WB/asrB
	 kWhxEZHKNGVeTnjTRRHs3eKDO0nIg5WDcgEYNimF6ATH2/+lwdjVEuXAyq/wMC6Qds
	 gOqKod//7rfFRkA+1+/BD0T14oFQEJUIlZcFmD2fwJw3C9A/SP1LaAHsONs47nEchy
	 x8fyX9kdGHfEA==
Date: Mon, 10 Aug 2026 11:31:10 +0100
From: Will Deacon <will@kernel.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-arm-kernel@lists.infradead.org, live-patching@vger.kernel.org,
	Song Liu <song@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] arm64/module: Fix livepatch BTI exceptions with Clang 21+
Message-ID: <anmobvJXiBQqWn6S@willie-the-truck>
References: <ed4fe1f95071897859ec7fbe9176246cbd4962bf.1786138806.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed4fe1f95071897859ec7fbe9176246cbd4962bf.1786138806.git.jpoimboe@kernel.org>

On Fri, Aug 07, 2026 at 02:46:11PM -0700, Josh Poimboeuf wrote:
> The following BTI exception was seen when loading a livepatch module:
> 
>   Internal error: Oops - BTI: 0000000036000001 [#1]  SMP
>   pstate: 634004c9 (nZCv daIF +PAN -UAO +TCO +DIT -SSBS BTYPE=jc)
>   pc : kill_orphaned_pgrp+0x0/0x150
>   lr : do_exit+0x498/0xaf0 [livepatch_combined]
> 
> The problem is that the patch module's do_exit() is branching to a
> static function in vmlinux using a module PLT veneer (indirect branch),
> but the target function doesn't have a BTI landing pad.
> 
> Clang 21+ omits the landing pad for static functions which can only be
> reached by a direct branch.  That's fine for ordinary modules which only
> branch to global exported functions.  But livepatch modules use klp
> relocations to reference arbitrary kernel symbols, and with
> CONFIG_RANDOMIZE_MODULE_REGION_FULL the module is far enough from the
> kernel that every R_AARCH64_CALL26 needs a PLT.
> 
> RET is exempt from BTI checking, so use it instead of BR when the target
> has no landing pad, similar to what ftrace and BPF do.

Hmm, doesn't that somewhat undermine the purpose of using BTI in the
kernel? Now we're going to create PLTs that can branch to arbitrary
addresses.

> This was found by testing with klp-build and Clang 21, but the issue is
> not specific to klp-build.  It's inherent to any livepatch module use of
> klp relocations.
> 
> Previous tests with Clang 20 did not show this problem, as older Clang
> unconditionally emits "bti c" for every C function.

Is there an option to restore that behaviour if CONFIG_LIVEPATCH=y?
Otherwise, I think I'd be more inclined to add yet-another dependency
to CONFIG_ARM64_BTI_KERNEL so it's disabled if LIVEPATCH is selected.

Will
