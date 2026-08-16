Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4611F3C5522;
	Sun, 16 Aug 2026 09:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786873295; cv=none; b=p5BXJNgFvygXamWreg77/aHGTCuPS7yRvVNvO7lZcNXECcIUUg/3pR2Tv8YtGTxbBY/NjhIXL+vCc/HI+KhNl61G5wAegRFwH1M6OM4uPX+hnibR8IQwN+8v5hMJ1bfxXUa0VFmKZcvh7cfTObesHF2SDH7UZaF79+DYZbXv/UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786873295; c=relaxed/simple;
	bh=f4QgNZ1U1Ud7kiufpBMuaJ/ofofTBWIYdhm/RINrpvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RSaHlcT6fmaeQvmGjq1QAAmSLQdUf4/ZPST2J8Xo3euoP/KRraf4QoqdL+O+IGPUY3hLy078JeHxcWTUy0HagVLXECeMIHHKP6gKaTrADGryBraY8csTKVyYiMU/wLkPgm2ZDdWBKj9syBceW0BbQG9Md2May94U1wUHExMt5Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E37Rk6Q0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E37Rk6Q0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FF751F000E9;
	Sun, 16 Aug 2026 09:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786873294;
	bh=sMC7Xv3ObNnQLqHKFbABJEE/ltn5mUM5anIYIaQaIlw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=E37Rk6Q0IFrIINsZVlHK4ylTf50BhpYIf8vgyOELq6XFUZ1ODv+oWePHPwIf1hIS4
	 cRkG6PmsMPWHHesGQUJVZmFlUddPHQy9MeN4oBScJDn5jJ7JwXqvuirPoinIzAT5yj
	 6uOEGTYWk4pnFF5nN9sz/NrigFFmyoOW73ib01kZAQXwKNe0YX+pjQEl8zOgqLRJ26
	 j22OdcDLG9GYe9DdiOvItRHJwnW1GZrgWrZPS/eT9jNn0r3y6jrXPg1LFB1Zj436XB
	 ae1sPOCeT8ENRA0akt3CbcEZxNjje7p9/6jV2OZupuZ+79tcFaTG2eV4+0L2AMYFdA
	 0AS5KgXEabd0g==
Date: Sun, 16 Aug 2026 10:41:27 +0100
From: Will Deacon <will@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	live-patching@vger.kernel.org, Song Liu <song@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Mark Brown <broonie@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Kees Cook <kees@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
	linux-toolchains@vger.kernel.org
Subject: Re: [PATCH 02/12] arm64/module: Fix BTI exceptions caused by omitted
 landing pads in Clang 21
Message-ID: <aoGFxycNrA0p-H4T@willie-the-truck>
References: <cover.1786768375.git.jpoimboe@kernel.org>
 <2ff1b2482406c61ca5979d6284ba5f948a3fbc20.1786768375.git.jpoimboe@kernel.org>
 <6bc20c00-21a9-4315-8ec3-33c7ad6ae95f@app.fastmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bc20c00-21a9-4315-8ec3-33c7ad6ae95f@app.fastmail.com>

Hi Josh, Ard,

On Sat, Aug 15, 2026 at 12:56:11PM +0300, Ard Biesheuvel wrote:
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

Sorry to jump in here, but I couldn't figure out a better place to get
involved as we have a few threads on this now.

Overall, it seems to me like there are three cases we need to consider
for re-enabling BTI in the kernel:

1. A cross-section call that spans beyond the 128M range and therefore
   needs a veneer. I think the static linker should resolve this, probably
   by emitting a second veneer with the landing pad. Do we know if LLD
   gets this right?

2. Calls from modules to exported symbols that end up going via a PLT
   due to module placement. Exported symbols shouldn't be static, so we
   should have the correct BTI landing pad in this case (and if we don't,
   we should fix EXPORT_SYMBOL() to add it).

3. The livepatch case where a module appears to branch directly to
   static functions in the kernel. For this, I frankly think we should
   either make in-kernel BTI depend on !LIVEPATCH _or_ pass some compiler
   option (tbd) when livepatch is enabled so that we get landing pads
   for static functions (which is what I believe Clang/GCC used to do?).

What am I missing?

Will
