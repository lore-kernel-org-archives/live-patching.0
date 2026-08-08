Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878681862;
	Sat,  8 Aug 2026 00:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786147701; cv=none; b=inlCiX1jjWXRGYMCYJiJ5UHjKBZEcLGvwx+i6Tdo212SnuU+CXXIyUKkv1QlO4WgFC3yT1fY/5iofLkiv1ixX69pgF8RxI8KZ0ANlSaz5zIyKYKt5An41km2obVuzCogLIP7I/YFZizHvs+VeJI/CPn615sbFssUnWTD4A8JrvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786147701; c=relaxed/simple;
	bh=en/I8oWsUtyCrMkkxB3cm50VcAmMO93QPdV1s6oaj2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQncM/nQuJtgXJwQ1xIe8xEULPGYdxUVqyBuq71BYm4jZZi/HoT8nA79Em3Nrj+wTRhQB04DbBg/yLMcm+8ATHnpnlTy+geZA4YdewyxmbGuN7Jvg/5u4ePxNSYzTikP2Mf1GMZFlWiSJhMcNRmbRyNOIFgjT5d5k2t2A7qnR+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GzJtKfmm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GzJtKfmm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B38A1F000E9;
	Sat,  8 Aug 2026 00:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786147700;
	bh=uxgPgZY649uBFpZuPHL/PO7mmTC5hIC1hhbvXAzNB9w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GzJtKfmmGy/pTC6LyJvs2eEM4qcaiPYAzTZsobH/EDVOAo+c3OavmFkSvDk9u15AH
	 jz0+GU54Dw/X88CIQaFtf/qjSaxlLBMztlMnOsMDKWZDsoYkL5H7bKxwH7G6yqrp5v
	 lSY/Yi8ZGZ2NzAvuC5OBVfSL6YNSZe8UEFWxzEU1Fim81B/3AugLysGYm5jULnpHGN
	 QbR14GmJQBDYaoSdWyOPWkVfHjS+1OfTGAch1jHSqCGhtunw7UKPqevs4s9NsLcuhC
	 /z3TVGHcfbPsBJkd18yuqeDgmkKiBpu4ZrMQid9C/6MBhetFvDrz/xZ78NXv8HnEUJ
	 fzDQBBOojmR7w==
Date: Fri, 7 Aug 2026 17:08:17 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: sashiko-bot@kernel.org
Cc: x86@kernel.org, linux-arm-kernel@lists.infradead.org, 
	live-patching@vger.kernel.org, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, 
	Catalin Marinas <catalin.marinas@arm.com>, Joe Lawrence <joe.lawrence@redhat.com>, 
	Song Liu <song@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Petr Mladek <pmladek@suse.com>, Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH v3 12/21] objtool: Refactor elf_add_data() to use a
 growable data buffer
Message-ID: <emf3idmv3xmm7gplpbykmcnnp44fugljawqlh6yi2hz7acewxg@w2yndfif37f4>
References: <a0fe2363d017a2833e98ae50de797fe55c2796a4.1778642120.git.jpoimboe@kernel.org>
 <20260514231355.DD8D7C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260514231355.DD8D7C2BCB3@smtp.kernel.org>

On Thu, May 14, 2026 at 11:13:55PM +0000, sashiko-bot@kernel.org wrote:
> > -	sec->data->d_buf = calloc(1, size);
> > -	if (!sec->data->d_buf) {
> > -		ERROR_GLIBC("calloc");
> > -		return NULL;
> > +	size_old = sec->data->d_size;
> > +	offset = ALIGN(size_old, sec->sh.sh_addralign);
> > +	size_new = offset + size;
> 
> Could this ALIGN calculation overflow if a malformed ELF file provides an
> extremely large sh_addralign value?

Doesn't seem realistic...

> > -	if (data)
> > -		memcpy(sec->data->d_buf, data, size);
> > +	if (!sec->data_overallocated)
> > +		alloc_size_old = size_old;
> > +	else
> > +		alloc_size_old = max(64UL, roundup_pow_of_two(size_old ? : 1));
> >  
> > -	sec->data->d_size = size;
> > -	sec->data->d_align = sec->sh.sh_addralign;
> > +	alloc_size_new = max(64UL, roundup_pow_of_two(size_new ? : 1));
> >  
> > -	offset = ALIGN(sec_size(sec), sec->sh.sh_addralign);
> > -	sec->sh.sh_size = offset + size;
> > +	if (alloc_size_new > alloc_size_old) {
> > +		void *orig_buf = sec->data->d_buf;
> > +
> > +		sec->data->d_buf = calloc(1, alloc_size_new);
> > +		if (!sec->data->d_buf) {
> > +			ERROR_GLIBC("calloc");
> > +			return NULL;
> > +		}
> 
> If calloc fails here, does assigning its result directly to sec->data->d_buf
> clobber the valid pointer to orig_buf?
> 
> It appears orig_buf is never freed on this error path, which might leak the
> original buffer if it was previously owned by objtool. Would it be safer to
> keep the original buffer pointer intact on allocation failure?

A memory leak on the error path is fine, it's about to exit anyway.

-- 
Josh
