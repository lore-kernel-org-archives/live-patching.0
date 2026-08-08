Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A88F272816;
	Sat,  8 Aug 2026 00:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786149411; cv=none; b=uRY/NJu6zxBzds5j69VM6/2cfjImY84Slm4qTJflNJKlHbHj58lsOhHGaLWPFr5qBPtrNa5lQTk0R8+UykYKjE7hF5hqh26pGlVU3SHCquSAw9ApdSqBituck2z+2WwQ6NqmsSJV8YlVuyTXWu6gETMyo2bF6Hs7Dr8ipeKVGTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786149411; c=relaxed/simple;
	bh=PTBjlINsVWCRK1QARX5P9BV1eAoP4rlLHLn7yRx99Ig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lxIuFVKlmZu++bq3ob26/JaWvuiKnn3YX0hrXCydm0weMdWb6Sr9lK9mxYG0ZN+qSrqWqu+/R7dsw3cOfYl+KKTE8ooqtuBfYU9qLXL3AWC/3D9wQPtIHqO6Vzx2CQonkZwYg+luXGrbfhvPp8ZWeSEbQ3GSrs1sxXEZHESBuxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gpCQZEpR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gpCQZEpR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A707C1F000E9;
	Sat,  8 Aug 2026 00:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786149409;
	bh=MOSnxQzcmiqyC1BWTtii7cFL3Os2J8CSE8dSpLGK4HU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gpCQZEpREw06/WxueV2zhL/u7J32gYgkc+39TRkUlvH+P0ab9OCtRI/0q5qmf0PIZ
	 GhWZ/lhLlFTwHY9z5UinDTvXIopBOl2/hCBEvK84oHWiL6LMH1X0GAKePnSFjmlztQ
	 J29p+FouG9L1pw1ZsHqrKYOIkhM/dCDfLK/8bNfxgWPyQY769sdLNsHZ9dp+dSlSY0
	 2WdRiaY11al9hUElv4VAdoZI+OjdpZdUXrLMH0sY1iVyr+YoAKy7bAXsqOOng/r+nu
	 RXTBNLFMZMGtwyLwjSGrfTJqSvSssylJJTX9ml8LmgTBldLKP3rshVfdgKH82xCVf8
	 8LPBuF6ekniMA==
Date: Fri, 7 Aug 2026 17:36:47 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: sashiko-bot@kernel.org
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	Petr Mladek <pmladek@suse.com>, Song Liu <song@kernel.org>, live-patching@vger.kernel.org, 
	Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, 
	linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>, Miroslav Benes <mbenes@suse.cz>, 
	Catalin Marinas <catalin.marinas@arm.com>, Joe Lawrence <joe.lawrence@redhat.com>
Subject: Re: [PATCH v3 17/21] objtool/klp: Don't correlate arm64 mapping
 symbols
Message-ID: <usz3qfvjypkbrnynylipd5mxtupbvglld4ioetzuzim27tei4y@lhwiwgt3onnt>
References: <48efc64058f667159d3dedf367c1d4cdedf84f1c.1778642120.git.jpoimboe@kernel.org>
 <20260515011947.F225CC2BCC7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260515011947.F225CC2BCC7@smtp.kernel.org>

On Fri, May 15, 2026 at 01:19:47AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The `is_mapping_sym()` function relies on an overly broad substring match (`strchr(sym->name, '$')`), which risks falsely classifying any unannotated (`STT_NOTYPE`) symbol containing a `$` as an ARM64 mapping symbol.
> --
> 
> commit fb925cb10f7a9c6ab8ecefca87d3cd3b4e4da879
> Author: Josh Poimboeuf <jpoimboe@kernel.org>
> 
> objtool/klp: Don't correlate arm64 mapping symbols
> 
> This commit updates the livepatch diff tool to skip the correlation of arm64
> mapping symbols. These symbols mark transitions between code and data but are
> not standard symbols that require correlation.
> 
> > diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
> > index eb21f3bf3120b..e1d4d94c9d77c 100644
> > --- a/tools/objtool/klp-diff.c
> > +++ b/tools/objtool/klp-diff.c
> > @@ -501,6 +501,7 @@ static bool dont_correlate(struct symbol *sym)
> >  	       is_prefix_func(sym) ||
> >  	       is_uncorrelated_static_local(sym) ||
> >  	       is_local_label(sym) ||
> > +	       is_mapping_sym(sym) ||
> 
> Does this code risk falsely classifying user-defined or macro-generated
> assembly labels as mapping symbols?
> 
> Looking at the definition:
> 
> tools/objtool/include/objtool/elf.h:is_mapping_sym() {
>         return is_notype_sym(sym) && strchr(sym->name, '$');
> }
> 
> Because it relies on a broad substring match, could this exclude valid
> unannotated STT_NOTYPE symbols containing a $ from correlation across all
> architectures?
> 
> Triggering a livepatching failure would require an unusual edge case, but
> would it be safer to use a stricter match for standard arm64 mapping symbol
> formats like $x or $d?

Not realistic.

-- 
Josh
