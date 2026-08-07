Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783882F30;
	Fri,  7 Aug 2026 22:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786142890; cv=none; b=I1X986BaRN4kGtcIoOi8r+RGo5azsa/+XXVaTky+wca8CDuC0ygAS764sOw8iu36rlRD1dFm6uL+Cj8PMktS1bSQpI1FKlKlhR0ytFYNf9+c+XzkZv2+3jfDCnTMmTY/T30flumgHD5nmBxYmiRsRX09pBTOGbZ/UkN/xfXe9jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786142890; c=relaxed/simple;
	bh=fDSdP1bnuiEgKwIZaVjbWsAhuvM2e5tmpZ7YzQzrfyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KIkX68t11tnHISqMtdrcD52yZtmGSPlLRALCHn6hTK6kyOTmDSXg2hb9XAv5YmS4H+r80P6eH2OoDBhxCdzRrIaBsy0Pq65jSEWPpnqLTHo1b4JsGlQh198Hy2p1J7Lgpw+U6Ojq8Bl7rcVGXZqFWHFDBy2xLX4v/3kaxVf28Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hWTRQCy6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hWTRQCy6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 661941F000E9;
	Fri,  7 Aug 2026 22:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786142889;
	bh=e5d/ApPq9zKbEYsjvmT4dzXT3sPT/1q+7IIhU9CC4Ho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hWTRQCy6854hksUwK/VkgIwM3NsNKUB/Y+ZrRFbRlL+nZAWlFl17tJfYFsNP649jO
	 KY5n1rO7h1Sjc/7LFbBXUo+NPh2IdoTkUg44lV39YEr0RDr2NY1T+TKCVlcb4n9BwR
	 zzbMNr3uc/VhgGQNiTDz4sU61TpCXcnUShnzTvtI2yxx9OhHiKhe8SVPiKbxWKOto6
	 HbK83zumiS5UlywAgLiVmAylllQU7gbZNFNeuvBzwEdwEU4iGQ0neNVhmbUZl1eOoA
	 RqG8MOUEdCRHM0lOvDrQ8oUQfwgnCoayylFD08fCs/anXPWypZKnE1ZxM++VZX1ugH
	 UdvUchmmtB3Aw==
Date: Fri, 7 Aug 2026 15:48:06 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: sashiko-bot@kernel.org
Cc: x86@kernel.org, Mark Rutland <mark.rutland@arm.com>, 
	live-patching@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, 
	Will Deacon <will@kernel.org>, Song Liu <song@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Joe Lawrence <joe.lawrence@redhat.com>, 
	Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v3 10/21] objtool: Ignore jumps to the end of the
 function for checksum runs
Message-ID: <2jmchblm2lryol7crl2n7rv6f5h4ej7hl3cmnixpv7amkuztsn@t4qigaqzvqg6>
References: <b3b58101e15e1bb5266e57134f0b65f7d8efdd4b.1778642120.git.jpoimboe@kernel.org>
 <20260514223021.1326AC2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260514223021.1326AC2BCB3@smtp.kernel.org>

On Thu, May 14, 2026 at 10:30:20PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Missing parentheses in the jump destination check causes objtool to silently ignore all missing jump targets when branch validation is disabled, instead of only jumps to the end of the function.
> --
> 
> commit aa068d4053e8b92ff17082c7a023821e72f5d625
> Author: Josh Poimboeuf <jpoimboe@kernel.org>
> 
> objtool: Ignore jumps to the end of the function for checksum runs
> 
> Sometimes Clang arm64 code jumps to the end of the function for UB.
> This commit ignores these jumps to the end of the function for
> checksum runs to avoid errors.
> 
> > diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> > index 10b18cf9c3608..73451aef68029 100644
> > --- a/tools/objtool/check.c
> > +++ b/tools/objtool/check.c
> 
> [ ... ]
> 
> > @@ -1593,10 +1609,14 @@ static int add_jump_destinations(struct objtool_file *file)
> >  			/*
> >  			 * GCOV/KCOV dead code can jump to the end of
> >  			 * the function/section.
> > +			 *
> > +			 * Clang on arm64 also does this sometimes for
> > +			 * undefined behavior.
> >  			 */
> > -			if (file->ignore_unreachables && func &&
> > -			    dest_sec == insn->sec &&
> > -			    dest_off == func->offset + func->len)
> > +			if (!validate_branch_enabled() ||
> > +			    (file->ignore_unreachables && func &&
> > +			     dest_sec == insn->sec &&
> > +			     dest_off == func->offset + func->len))
> >  				continue;
> 
> Does this condition silently ignore all missing jump targets when branch
> validation is disabled?
> 
> Because of the || without proper parenthetical grouping around the first
> two terms, if !validate_branch_enabled() is true (which it is for
> --checksum or --noinstr runs), the rest of the condition short-circuits.
> 
> This appears to cause objtool to skip the error reporting and silently
> leave the jump destination as NULL for any unresolvable jump in the binary,
> instead of only those jumping to the end of the function.
> 
> Should the logic be grouped to restrict the exception to the end of the
> function?
> 
> 			if ((!validate_branch_enabled() || file->ignore_unreachables) &&
> 			    func &&
> 			    dest_sec == insn->sec &&
> 			    dest_off == func->offset + func->len)

Yes, we should tighten that up.

-- 
Josh
