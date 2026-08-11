Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763F72DCC1C;
	Tue, 11 Aug 2026 09:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786441492; cv=none; b=ON9m02DAlk8ajEu77fAE7Ku8ojBeN9bmF8Z/7AHwIcHYdDZsAkhZ1EawGoi+8TC+tsa9yR/fY37sxRVFtwfBeP+JvWz7tZcac0e+91au2frO0FMJ5g44k6IAHhanZaEvGmZlfcTWyIvo5LyU2dBuwhg038N8y6w8peBzOVydOP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786441492; c=relaxed/simple;
	bh=u0rMRqVKA99RhoKL9NpWprBdY6LmOMRErGsSXiUUqi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CxSl5GIYucSJh6uQUJHr6Pv+NEhWr9ZNN4bavWL53nNJGRtJMDXaaEI+2t3d/NjBN0FdVB0DgrD4I/19v+T1mVNJdF8QiOO+ctoBlakAMmYYfGCtN99LGh2kzL7DTJkR3A/1C/yMByiMjFzS+Cr1URwjhu/6i1ak8VU+B58wyKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AC5sqQEs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AC5sqQEs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 715571F000E9;
	Tue, 11 Aug 2026 09:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786441491;
	bh=tSpeYlqtnZyA+k5/9LIRfgyP93yJj/4XvuLOfnmiRCM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AC5sqQEs+79Lxz8J+5irzfru6WqJ+WMNPNbg0BlsFRTYHLYNbJwKeTGoX/USNeXec
	 qAHDt6fEvxZwkTQ0OkhSRJd9usYhQgHEvhI5g+ypsQIL23jvgewpj5nwaqHYC+6UkR
	 zDs2sf/mhlntAhxfTUJvorenxXxBr0BVgNVACoI3eygn3tHiMvKXYkyieGSLa68kuy
	 epnY2UANh4597IM2lyYPJchtIfF1HcGwBX9dtBGFtcKys1j8jrzRy+MyZp5o1wYNHe
	 cz4zpMRPAcGysjFIRDbvmhuH41/xP3I5oQht3eFUqy94N6DKua+F7kG11roR8FQVtL
	 FEgaji01XnGaA==
Date: Tue, 11 Aug 2026 10:44:44 +0100
From: Will Deacon <will@kernel.org>
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	live-patching@vger.kernel.org, Song Liu <song@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Mark Brown <broonie@kernel.org>, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH] arm64/module: Fix livepatch BTI exceptions with Clang 21+
Message-ID: <anrvDIWMNGIa4WPK@willie-the-truck>
References: <ed4fe1f95071897859ec7fbe9176246cbd4962bf.1786138806.git.jpoimboe@kernel.org>
 <anmobvJXiBQqWn6S@willie-the-truck>
 <e5q2mvqtf6iw4lco55uny5ffhppw6vlflxguhc4gg5nm3zdvmo@zs6rw7iov5qc>
 <08d6c5cd-9924-4359-9181-a03718161528@app.fastmail.com>
 <kp4rvh4vxo65gipgqz4i4dnw2ueylmus4yys6xfrbngp5nefzn@4a4ekjlzqlph>
 <CAKwvOdmSVjY0TmOTc6WMmDHcLbn=tOV3R3zH_TO4zXZiYEsaBw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKwvOdmSVjY0TmOTc6WMmDHcLbn=tOV3R3zH_TO4zXZiYEsaBw@mail.gmail.com>

On Mon, Aug 10, 2026 at 09:41:35AM -0700, Nick Desaulniers wrote:
> On Mon, Aug 10, 2026 at 9:39 AM Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> >
> > On Mon, Aug 10, 2026 at 06:12:10PM +0200, Ard Biesheuvel wrote:
> > > On Mon, 10 Aug 2026, at 17:48, Josh Poimboeuf wrote:
> > > > In which case I think to properly support BTI going forward we would
> > > > need two "veneers"?  Either that or remove BTI kernel support
> > > > altogether.
> > > >
> > >
> > > Yeah, it seems we did not argue our case convincingly: their assumption
> > > that veneers/PLTs can be placed within -/+ 128M of their target does not
> > > hold for us. But I don't think it holds for .text sections larger than
> > > 128M either, so I'm not convinced their reasoning is sound even for the
> > > general case.
> > >
> > > I suppose we could special-case the PLT logic to use direct branches
> > > where possible, which would probably catch most of these (assuming
> > > .text and .init.text tend to end up close to each other also for KLP
> > > modules)
> > >
> > > For the remaining cases, we'd indeed need a second veneer at the callee
> > > end (i.e., inside .text in this case) that is emitted when resolving a
> > > cross-section indirect call to a function that lacks the BTI landing
> > > pad. But that would be its sole purpose, so I don't think we should go
> > > down this route. Instead, the 'address taken' check should include 'called
> > > directly from a different section'. Emitting veneers to work around a
> > > compiler optimization is just plain silly.
> > >
> > > I'll try and poke people on the Clang side of things to revisit this.
> > > I guess that leaves kernel BTI broken for the foreseeable future but so
> > > be it.
> >
> > Ok, so for now I suppose we need something like so?
> >
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index 06b30924509ac..972988238f367 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -2117,6 +2117,8 @@ config ARM64_BTI_KERNEL
> >         depends on !CC_IS_GCC || GCC_VERSION >= 100100
> >         # https://gcc.gnu.org/bugzilla/show_bug.cgi?id=106671
> >         depends on !CC_IS_GCC
> > +       # https://github.com/llvm/llvm-project/commit/7af2b51e761f49974a64c3009882239cea618f2a
> 
> Sure, but let's replace this with a link to a bug report in llvm's
> issue tracker? I meet with Arm's toolchain team (of which Simon
> is...on or adjacent to). I can bring this up then.

Yes, please! I can apply the patch once we have the bug number.

Will
