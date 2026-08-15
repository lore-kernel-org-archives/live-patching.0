Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FC43438A1;
	Sat, 15 Aug 2026 18:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786820264; cv=none; b=tQHhjZjwVGiz1aKqx9qG53whqYPZdXag3eoK42SJR0wPH79VDQX8AID7uJFl0nmg0u/C7W12EZ5BKMVN6mHmFzvTB8XG4NyD3np74sL27cb+ASVWig6GVVpEgbNg8jTtFBkJAAY0X6p3qKtWxZ9NPEPck2rGeXmLvE4/3rDAHoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786820264; c=relaxed/simple;
	bh=N14uvnaFcW1aR3YiyayMMcheI6lB9cI+v9gSDuOWduY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BqYJmoOMs5cvC16WYRLSADmEkdg/uiv3ABos0kAkdbwDr4QIUmIetZxfjg6lZ7PRrbrWyB8MlcJdscQGiR/JsByrR0ZW0JOrsovChsFSOXXB6Esn+0Gid/uaQecXfsTBAHBwKiBusJR2Ztcnl5xZ0PGRHPI23sswkBRcMi0M/2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hLVS2htW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hLVS2htW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF9611F000E9;
	Sat, 15 Aug 2026 18:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786820262;
	bh=cLQgMJZ7qnH5wLoYqijNKlZhPRcRBbKGvpe7JT4LVTA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hLVS2htWqLJ5MvFYiOttx0lg2QZpf3PJv8nCEkD30sbNXKgFUnBN89t0mTJhDnLwx
	 6afjE4m5BBNR+Hq0DdokfIDUHetpkxeaPLIFxlt6afZgM37mgtw49tvEpZLFo8Hv73
	 zALCMqJxvqTBCGNWdSCl/+iG+5cjll82SYz49Vkt2yL9AeyImuUmFyn25AVvLYn3jq
	 o3WPl/uVc7fgMOaIi1qLsWlztu/ZQO+QeaS+QixxA4rck7ufOf1f0h2xJIRMASAAlA
	 DVpAtvBUsqRHHal0LBVAdITb5FoRG05/pLJT73tTggnl3fG1wMh95EEBKmFLTNLADB
	 Emwd50OrO6WGw==
Date: Sat, 15 Aug 2026 11:57:40 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, live-patching@vger.kernel.org, Song Liu <song@kernel.org>, 
	Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, 
	Joe Lawrence <joe.lawrence@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Mark Brown <broonie@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Kees Cook <kees@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	linux-toolchains@vger.kernel.org
Subject: Re: [PATCH 02/12] arm64/module: Fix BTI exceptions caused by omitted
 landing pads in Clang 21
Message-ID: <aoCu66bx1Qg14-uD@jpoimboe>
References: <cover.1786768375.git.jpoimboe@kernel.org>
 <2ff1b2482406c61ca5979d6284ba5f948a3fbc20.1786768375.git.jpoimboe@kernel.org>
 <6bc20c00-21a9-4315-8ec3-33c7ad6ae95f@app.fastmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6bc20c00-21a9-4315-8ec3-33c7ad6ae95f@app.fastmail.com>

On Sat, Aug 15, 2026 at 12:56:11PM +0300, Ard Biesheuvel wrote:
> Hi Josh,
> 
> On Sat, 15 Aug 2026, at 07:45, Josh Poimboeuf wrote:
> > The following BTI exception was seen when loading a livepatch module:
> >
> >   Internal error: Oops - BTI: 0000000036000001 [#1]  SMP
> >   pstate: 634004c9 (nZCv daIF +PAN -UAO +TCO +DIT -SSBS BTYPE=jc)
> >   pc : kill_orphaned_pgrp+0x0/0x150
> >   lr : do_exit+0x498/0xaf0 [livepatch_combined]
> >
> > The problem is that the patch module's do_exit() is branching to a
> > static function in vmlinux using a module PLT veneer (indirect branch),
> > but the target function doesn't have a BTI landing pad.
> >
> > Clang 21+ omits the landing pad for static functions which can only be
> > reached by a direct branch.  But livepatch modules use klp relocations
> > to reference arbitrary kernel symbols, and with
> > CONFIG_RANDOMIZE_MODULE_REGION_FULL the module is far enough away that
> > every call to vmlinux needs a PLT.
> >
> > Note this problem is actually not specific to livepatch.  It's possible
> > for any module's .init section to be allocated > 128MB away from its
> > .text section.  So calls from .init to .text via a PLT can trigger a BTI
> > exception when the target function doesn't have a landing pad.
> >
> > GCC has always omitted the landing pad when possible, so kernel BTI is
> > already considered incompatible with GCC since commit c0a454b9044f
> > ("arm64/bti: Disable in kernel BTI when cross section thunks are
> > broken").
> >
> > When missing landing pads are detected, allocate a page close to the
> > target which can be used to hold BTI veneers which receive PLT veneer
> > indirect branches and direct branch to the final target:
> >
> 
> This does not work for cross-section calls from .init.text to .text.
> 
> If .init.text is far away from .text, it is likely because .text
> ended up in the 128M 'near' module region, and .init.text did not.
> (They tend to end up in direct branching range of each otherwise.)
> 
> Given that the module init code is typically small, I don't think
> it is safe to assume that allocating a single page close enough to
> .text is going to be possible if allocating the space for .init.*
> was not.
> 
> IOW, the fix I proposed for cross-section calls is still needed
> with this approach.

But the BTI veneer page is allocated from a *256MB* window, of which the
near region is only a 128MB subset.

There is a theoretical case where the 256MB window around the target is
completely full without any fragmentation, but I would think that there
would almost always be some fragmentation.  If that window is modules
stacked together, most modules have at least .init.plt and .init.text,
and many have .init.data.

Right now it needs two pages (because of the default guard page) but we
could maybe fall back to VM_NO_GUARD in case of emergency.

-- 
Josh
