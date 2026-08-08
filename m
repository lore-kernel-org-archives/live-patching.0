Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E795629B78B;
	Sat,  8 Aug 2026 21:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786226386; cv=none; b=sfwtdifKGRmVhl3XNP10GqG7TMBgKr1h1M7RUhRSmIc2eoxfhR3GwXrEutlwBjyfR4imR2Zbq9qPlDIwke1k5y2FeCkkex7lSF3oPAID05g1zvNdr6PK9eeK8L1G0HgLmFbqgIjD6kkGSGHQ2h3bORYfGmJeXLmMcfQQ/qhbi+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786226386; c=relaxed/simple;
	bh=wRnyEN52eYUHGp90kotjD/tXVW5UARtGV9G1muIPv60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eFP0wAGAAj9nAy4JeP9HKNo7yunNEqxMLmU0kEqcMivrXuyf/0F3BNOJcwGli4ji5qQpPi+uHr4crzbUsSQfplNSOJUhMg/lPBgK5FVivEcjJ7PfaTwSo8kzT8kHWFgfEPclTYBAe543B76PxFxn4MmBisBuPAZrcoRPURR3MtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UWV56ivw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UWV56ivw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A13B11F000E9;
	Sat,  8 Aug 2026 21:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786226384;
	bh=kfgpSe5xinaL9ifATlL93o/2t8Nm4a+z+ScqI0DWC/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UWV56ivwCqk4ftHy4r6UIgshsW0TohA3CSZacQEFDg8LLwHbtX08Ey9g0bh4EGCHT
	 d3fER0gKson63vkEYWLKK4mwfBoM1CoASF7UZu9vlh0kOub9ViIdZT3UvfVdQbiQwz
	 kXonsZKcpBu+3qGwN6GrKi0wxCatUY3CqWwQpsl1G4g7yvrTC5HOZWuPyRKl4j+Uj/
	 b0BEB1GHXcmZZ4jk3k7NH0WsU8/cXQEUxU2+b3QTO5o8YtdimEhjA0zNEyESBbyOt3
	 q/cHmltOOQAg7eA8UqgekF84i1/k7kJpCBUR4gxCg0EGqYHQfB0Nd3jrC75YwhsDiQ
	 7qthu1qs6dSAg==
Date: Sat, 8 Aug 2026 14:59:42 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Joe Lawrence <joe.lawrence@redhat.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	live-patching@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Song Liu <song@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	Mark Rutland <mark.rutland@arm.com>, Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v3 14/21] objtool: Prevent kCFI hashes from being decoded
 as instructions
Message-ID: <s275kky5bqb5w5agrseielj66zvm53hr3yv7n33tenz4swnvpb@c63r6czxpeil>
References: <cover.1778642120.git.jpoimboe@kernel.org>
 <b1d50c9fc9e6b9bca43833cc4ccbd88a31fed84b.1778642120.git.jpoimboe@kernel.org>
 <akQNqlfFC0T5pcMa@redhat.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <akQNqlfFC0T5pcMa@redhat.com>

On Tue, Jun 30, 2026 at 02:40:42PM -0400, Joe Lawrence wrote:
> The root cause is that create_fake_symbols() skips the entire special
> section if any symbol exists at offset 0.  But Clang places a .Ltmp*
> label at the start of .kcfi_traps, so no per-entry fake symbols are
> created and clone_special_sections() extracts nothing.
> 
>   static int create_fake_symbols(struct elf *elf)
>   {
>   ...
>   	/*
>   	 * 2) Make symbols for sh_entsize, and simple arrays of pointers:
>   	 */
>   entsize:
>   	for_each_sec(elf, sec) {
>   		unsigned int entry_size;
>   		unsigned long offset;
> 
>   		if (!is_special_section(sec) || find_symbol_by_offset(sec, 0))
>   			continue;
> 
>   $ llvm-readelf --wide --symbols klp-tmp/3-checksum-patched/vmlinux.o | \
>           awk '$7 == 74993'
>    93266: 0000000000000000     0 NOTYPE  LOCAL  DEFAULT   74993 .Ltmp78
>    93544: 0000000000000000     0 SECTION LOCAL  DEFAULT   74993 .kcfi_traps
> 
> 
> Possible fix: ignore .L* assembler-local labels at section offset 0
> using the existing is_local_label() helper.
> 
> -->8-- -->8-- -->8-- -->8-- -->8-- -->8-- -->8-- -->8-- -->8-- -->8--
> 
> diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
> index b9624bd9439b..4ba400926647 100644
> --- a/tools/objtool/klp-diff.c
> +++ b/tools/objtool/klp-diff.c
> @@ -1860,8 +1860,17 @@ static int create_fake_symbols(struct elf *elf)
>  	for_each_sec(elf, sec) {
>  		unsigned int entry_size;
>  		unsigned long offset;
> +		struct symbol *sym_at_0;
> 
> -		if (!is_special_section(sec) || find_symbol_by_offset(sec, 0))
> +		if (!is_special_section(sec))
> +			continue;
> +
> +		/*
> +		 * Clang may place assembler-local .L* labels at offset 0;
> +		 * they must not prevent per-entry fake symbol creation.
> +		 */
> +		sym_at_0 = find_symbol_by_offset(sec, 0);
> +		if (sym_at_0 && !is_local_label(sym_at_0))
>  			continue;

Thanks, I'll fix this with my other series of fixes in the next version.

find_symbol_by_offset() might not work because there can be multiple
symbols at offset 0.  Instead we can just traverse the symbols in the
section, looking for sym->fake.

-- 
Josh
