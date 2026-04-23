Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D0729A9C3;
	Thu, 23 Apr 2026 15:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776957130; cv=none; b=EJnyopSXM8C/gGkkPrqi3YOZqrvrWfV1EKDmxjQ3/6QArvlB39/qeGAy/Z7weSoGVzlzqLsnV1BIvxMlYT2Ofme3c42cEwWwXABRCA+RormUtzEGElu2Y+mOe5qPweciAGUTIQPjkunV3ZHVVL0StgceLTPzUOiRYOBtT+acxBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776957130; c=relaxed/simple;
	bh=nTiDpa4feuXbBh6mk7yRMESlrC50Zukpokm2Osm6Q8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CN8HfnwsguZSBnrVK7r0Lw+2N28kmSkZycnnBl/wTQWX3G2S/mKCMVbn6DU/64u4EvcnNRW0PXTnk9gRh5TZ05pLhfgqPYQ7WS9K7+Uv4znEMKrzMnBTMFFWHcu9aN7GwzjTP7SRrqWKa4B4B5u+Bm6gSprXkhDCvMSdXAxPXjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l8C53gr6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l8C53gr6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F264C2BCAF;
	Thu, 23 Apr 2026 15:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776957130;
	bh=nTiDpa4feuXbBh6mk7yRMESlrC50Zukpokm2Osm6Q8E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l8C53gr6Y8rUGi+JUsXqXNBteLh8PbkM5MssP4Rv+pKIAU1JoFS4RFZv4R/MdDhy5
	 +YruMqQp37ky/fqS12geXcE2XN78zkPyySx5zoobDidJLHM//awNKaln5Pok9DqKEQ
	 96dl0+B3ofOF3eUG3+/Eoc38y1tl8iTNzPrxifvvsz+8AsJhrETjhuIvW54TGfdL7U
	 7X/KWAI5bcXSc5NNXMy9581Ah9DOBSUhbXVLPXYflrFjvEELzo0qydo+hIyN2tlEOq
	 c4Ur4LQgzaETMpVXV3/XbbHgGMwTUh5GqEHMPQzLcWk5Lu80h/ZAJC3XiOeryLwulC
	 KDvV1B6knGwfg==
Date: Thu, 23 Apr 2026 08:12:07 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	live-patching@vger.kernel.org, Joe Lawrence <joe.lawrence@redhat.com>, 
	Song Liu <song@kernel.org>, Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH 32/48] objtool: Add is_cold_func() helper
Message-ID: <qp7srvaafzmgsh334jeidseax2zgvt2j65iugsru5co3wrm6ka@opizry3c2m6d>
References: <cover.1776916871.git.jpoimboe@kernel.org>
 <8eea11ea7d0efc5fcd2e57a10c4285fe998f0cec.1776916871.git.jpoimboe@kernel.org>
 <20260423083849.GV3126523@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260423083849.GV3126523@noisy.programming.kicks-ass.net>

On Thu, Apr 23, 2026 at 10:38:49AM +0200, Peter Zijlstra wrote:
> On Wed, Apr 22, 2026 at 09:04:00PM -0700, Josh Poimboeuf wrote:
> 
> > diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
> > index 00c2389f345f..8a6e1338af97 100644
> > --- a/tools/objtool/elf.c
> > +++ b/tools/objtool/elf.c
> > @@ -586,8 +586,11 @@ static int elf_add_symbol(struct elf *elf, struct symbol *sym)
> >  	if (strstarts(sym->name, ".klp.sym"))
> >  		sym->klp = 1;
> >  
> > +	sym->pfunc = sym->cfunc = sym;
> > +
> >  	if (!sym->klp && !is_sec_sym(sym) && strstr(sym->name, ".cold")) {
> > -		sym->cold = 1;
> > +		/* Tell read_symbols() this is a cold subfunction */
> > +		sym->pfunc = NULL;
> >  
> >  		/*
> >  		 * Clang doesn't mark cold subfunctions as STT_FUNC, which
> > @@ -596,8 +599,6 @@ static int elf_add_symbol(struct elf *elf, struct symbol *sym)
> >  		sym->type = STT_FUNC;
> >  	}
> >  
> > -	sym->pfunc = sym->cfunc = sym;
> > -
> >  	return 0;
> >  }
> 
> So now the cold subfunction has a NULL parent-function and a
> child-function that points to the parent?
> 
> I'm confused.

It's a bit clunky.  As the comment implies, 'sym->pfunc = NULL' is a
signal to it caller read_symbols() that this is a .cold function.  Then,
after all the symbols have been added, read_symbols() goes and finds the
parent.

I think I did it this way because klp-diff.c calls elf_add_symbol() (via
elf_create_symbol()) and later needs to call is_cold_func() on it.  In
that case, even though the parent isn't set, it still works because
is_cold_func() returns true for sym->pfunc != sym;

-- 
Josh
