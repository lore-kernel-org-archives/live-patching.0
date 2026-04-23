Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0598364E9A;
	Thu, 23 Apr 2026 08:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776933305; cv=none; b=uvgVLiJur3Z4l4ng3LEpRK5s0tz8PEZK7GqSJxW6ET5JeN2g2+8nUSwfD5uF2jmgQmj1vB9FoEq3QQG5cEVzP6KTmtu0MojnTjTVjERFOnT1hRb9fj3uxn7iDKF3rwVfP33MeJ+HMTAqDmWkDWEORqj2KWTl/3mRh3m7Jmkkrh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776933305; c=relaxed/simple;
	bh=Jqr8I+n11kA39V7sdxYQAu8Ft1JHiTUPHtHeBwVvxXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=buovZdSHouRQrD1bPQu7XVtliOHB3ROL/jEXV2o0lY62i0GMiRBM4iq/k7W1GD2x9VTLEx1bF72YAuy2T5k2nSJ/LqbB5zVgtUGt3La8CO6hp9yvv9yOPPR73bRx3Hz3tzIS/7Ptn2rTUPzoN7LCR0YqTg3yT5ZSJ7UvkEUUa7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=M2gAO6l+; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="M2gAO6l+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ck2Us983cC4Tm8+GTHhxpojd5ZkS3td/H0F5aHDjK6c=; b=M2gAO6l+Z0tYSvB54QwH2qqWay
	G9pWvACFgf2hmEnTH7FFJWCJtrO3YwSyFXDFaF6db/bLVFKOONpERWsfOxsh5/sZmWb9G5M9AjoB9
	qmjHzU9G+laVJD82+0aAr21qFbLnpXNTiF4booHGajKrjpvHgqpRjnnTPjDtWIFD5oivgKFbNXZaS
	vu3umkbHtB6+JgWAd/tek9LJeumxCJNvo0/VbUbb8GGRpNgNUNcYsT3dKte9O+XIsT4T1Fdo3dWkm
	hDu6Ijn6T5YoY1OAGfemCQulbHfQJcEDy74mx8M8tazRvyq8k4eosp/T72R8rqnF32cxsOKvx1O6n
	ZYCKEydQ==;
Received: from 2001-1c00-8d85-4b00-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:4b00:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFpWX-0000000D7dR-3iHx;
	Thu, 23 Apr 2026 08:35:01 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B70BA3008E2; Thu, 23 Apr 2026 10:35:00 +0200 (CEST)
Date: Thu, 23 Apr 2026 10:35:00 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org,
	Joe Lawrence <joe.lawrence@redhat.com>, Song Liu <song@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH 31/48] objtool: Add is_alias_sym() helper
Message-ID: <20260423083500.GU3126523@noisy.programming.kicks-ass.net>
References: <cover.1776916871.git.jpoimboe@kernel.org>
 <360097539ed947aea82ce5392548a898a346ffa7.1776916871.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <360097539ed947aea82ce5392548a898a346ffa7.1776916871.git.jpoimboe@kernel.org>

On Wed, Apr 22, 2026 at 09:03:59PM -0700, Josh Poimboeuf wrote:
> Improve readability with a new is_alias_sym() helper.
> 
> No functional changes intended.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> ---
>  tools/objtool/check.c               | 6 +++---
>  tools/objtool/include/objtool/elf.h | 5 +++++
>  2 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index 54ceac857979..4c18d6e7f6c3 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -491,7 +491,7 @@ static int decode_instructions(struct objtool_file *file)
>  				return -1;
>  			}
>  
> -			if (func->embedded_insn || func->alias != func)
> +			if (func->embedded_insn || is_alias_sym(func))
>  				continue;
>  
>  			if (!find_insn(file, sec, func->offset)) {
> @@ -2229,7 +2229,7 @@ static int add_jump_table_alts(struct objtool_file *file)
>  		return 0;
>  
>  	for_each_sym(file->elf, func) {
> -		if (!is_func_sym(func) || func->alias != func)
> +		if (!is_func_sym(func) || is_alias_sym(func))
>  			continue;
>  
>  		mark_func_jump_tables(file, func);
> @@ -4527,7 +4527,7 @@ static int validate_symbol(struct objtool_file *file, struct section *sec,
>  		return 1;
>  	}
>  
> -	if (sym->pfunc != sym || sym->alias != sym)
> +	if (sym->pfunc != sym || is_alias_sym(sym))
>  		return 0;
>  
>  	insn = find_insn(file, sec, sym->offset);
> diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
> index cd5844c7b4e2..3abe4cbc584c 100644
> --- a/tools/objtool/include/objtool/elf.h
> +++ b/tools/objtool/include/objtool/elf.h
> @@ -279,6 +279,11 @@ static inline bool is_local_sym(struct symbol *sym)
>  	return sym->bind == STB_LOCAL;
>  }
>  
> +static inline bool is_alias_sym(struct symbol *sym)
> +{
> +	return sym->alias != sym;
> +}
> +
>  static inline bool is_prefix_func(struct symbol *sym)
>  {
>  	return sym->prefix;
> -- 
> 2.53.0
> 
