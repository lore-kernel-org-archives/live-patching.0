Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60F71F8AC5;
	Thu, 23 Apr 2026 08:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776933533; cv=none; b=OZK6/5duG5V2nLI9K0Bx9yIehwBIJYT5fAmcfX9zwB8k3vMgWjxFw2fU9TUs2NZzV4H3071kwIi3JW0yYujQBPL0oDVqgXLNpRGL5BNigoHTU9szpiBUkVQjHbNyILbI8l4nHxCMdS62x3j81HuVNbuW0XJu9ur8T2ctOBLghdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776933533; c=relaxed/simple;
	bh=Z6FUgiPu6MoRV6q1JVe3ZOHTx7IrWM3n7NB5KJ1HCrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SZ08Tbi7Gw7TVSWDzoI2ldTHffO3fLyDeYMDltGM3BJBUvSM6wV8lYUAx3mbtVisNoBQ+FD3NaRXlanVDapzXzACEK+oL6ruAsRa9D+8XA/M1pXkHRtCqNK6HGB6eTsMTtVCxr7qQpYFMHp9NZWEribykoECDHyevI5fsZcqI10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bB0QSZqa; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bB0QSZqa"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1HyNG2dtYiEOvNfbvr0l4UjOG7PPoGRUZX5RDYQU918=; b=bB0QSZqa+l4KvR4jParrTC8ISK
	Wc8oLYwhK44zjG8BmGIa2TunRgwz10oMlM9UubENZU5//kElhIDeiJim7bb7vxXbo6spY90Ba9oYX
	H+p9lfr3R738ER0Yf8KA2JmbzfCRXMJV3AwiQFnzO2E5LoiXYjKhkRx9Ly8Iqa/boQFIxv9km+Fz0
	r3I1hdepSUW64ochNNpJND6d+UebJBLKVQoqOt8s9KNk8nhrBHjOVMSc4lMeQgZbmTvFdNeGTbvjb
	7mHvzj5d974kdRvzr9zo1Tx1Zf7hjFFD3oK4AJh15l1TLLN2DV8xn80hZiwA18VfyIxlx6uXS8chY
	Q4nMmCoQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFpaE-0000000D7oF-0IhM;
	Thu, 23 Apr 2026 08:38:50 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 98FF63008E2; Thu, 23 Apr 2026 10:38:49 +0200 (CEST)
Date: Thu, 23 Apr 2026 10:38:49 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org,
	Joe Lawrence <joe.lawrence@redhat.com>, Song Liu <song@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH 32/48] objtool: Add is_cold_func() helper
Message-ID: <20260423083849.GV3126523@noisy.programming.kicks-ass.net>
References: <cover.1776916871.git.jpoimboe@kernel.org>
 <8eea11ea7d0efc5fcd2e57a10c4285fe998f0cec.1776916871.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8eea11ea7d0efc5fcd2e57a10c4285fe998f0cec.1776916871.git.jpoimboe@kernel.org>

On Wed, Apr 22, 2026 at 09:04:00PM -0700, Josh Poimboeuf wrote:

> diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
> index 00c2389f345f..8a6e1338af97 100644
> --- a/tools/objtool/elf.c
> +++ b/tools/objtool/elf.c
> @@ -586,8 +586,11 @@ static int elf_add_symbol(struct elf *elf, struct symbol *sym)
>  	if (strstarts(sym->name, ".klp.sym"))
>  		sym->klp = 1;
>  
> +	sym->pfunc = sym->cfunc = sym;
> +
>  	if (!sym->klp && !is_sec_sym(sym) && strstr(sym->name, ".cold")) {
> -		sym->cold = 1;
> +		/* Tell read_symbols() this is a cold subfunction */
> +		sym->pfunc = NULL;
>  
>  		/*
>  		 * Clang doesn't mark cold subfunctions as STT_FUNC, which
> @@ -596,8 +599,6 @@ static int elf_add_symbol(struct elf *elf, struct symbol *sym)
>  		sym->type = STT_FUNC;
>  	}
>  
> -	sym->pfunc = sym->cfunc = sym;
> -
>  	return 0;
>  }

So now the cold subfunction has a NULL parent-function and a
child-function that points to the parent?

I'm confused.
