Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFE63806B0;
	Fri, 28 Aug 2026 18:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787941270; cv=none; b=EEqWWPE2b3LwHz5Ybpwk7beLFvikg/YCd1hy5QVX4F+ZA57S+AvU35Trj6ykG71bmprF5C1m7DFH8BPSDzbme+0p8QdazZNXMemrrVjLAikszKqqYuuQc9ehrHDmYxxwvmcO62jvzmwg6eJ3fm13nplyqo644aYJ2T5jHIVuDDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787941270; c=relaxed/simple;
	bh=MyE/EC0o9YWsIANSKx1Tx0JSNx+gMw7iBo5/okolDaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lzHItGLtZcc/K3mlKyNdNp5P6bvGKkCASXraxxZJb6muBB3k2FV9xCu9f95ojEf+tzfUe0ajujLLQ04phebLQxqcZQqJJ83ibV8pO7GDTeRvIBNEKCBGoYoXGAKza1Ud67v+yQ384XZANRQhfvOOUYPyb1Kh+8WSvj6OOqcYu58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CBbCzLHn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CBbCzLHn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4237C1F00A3E;
	Fri, 28 Aug 2026 18:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787941269;
	bh=A/k664QFyYRwzcNr4KYnjEmuHDQ6OKV/1WoYk0ZksFE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CBbCzLHn4auYDKqANWY/yY/eApy4GRFPyx7gmTvLSI9eZlYQqaBFSWXA6UQY0SLt0
	 IjrGEVpQH32SiH9L0gjdlhXZr6mRnYPwCX8vzIKHuCPq8uQXynUBsZCBwRGV7G8nsO
	 2/HPhCRXBpLvrwQm7IBbuFo+6yDcnKdyD73+nGPP/0UFU/eQ/CaERT37l/uFfNamCM
	 gKqqrBeBoAo76jkjL5+23386A9iWTH3h6kKE5NUoq5dqH6OQh1eT2zers+Zlm0kGEs
	 oS3QatC3mfZyfKRykcfjYBgAHd6HZ1R566FMYPn66FBEbshJJ1GPEZiw8Klo28TSEu
	 Fg+oR48D4Y8tg==
Date: Fri, 28 Aug 2026 11:21:06 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: sashiko-bot@kernel.org
Cc: x86@kernel.org, Petr Mladek <pmladek@suse.com>, 
	Joe Lawrence <joe.lawrence@redhat.com>, linux-kernel@vger.kernel.org, live-patching@vger.kernel.org, 
	Song Liu <song@kernel.org>, Miroslav Benes <mbenes@suse.cz>, 
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2] objtool/klp: Fix checksums for constant pool
 references
Message-ID: <apHRd-me1otNaFir@jpoimboe>
References: <f3a9e74ceebc6475ce94bcfe985401140857814a.1787939301.git.jpoimboe@kernel.org>
 <20260828175935.AA3E21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260828175935.AA3E21F000E9@smtp.kernel.org>

On Fri, Aug 28, 2026 at 05:59:35PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The checksum calculation for anonymous constants does not align the relocation addend, potentially reading past the end of the constant and out-of-bounds of the section.
> --
> 
> commit 40a0e3ccdee64d957ccae4cb27dbc7318ac09355
> Author: Josh Poimboeuf <jpoimboe@kernel.org>
> 
> objtool/klp: Fix checksums for constant pool references
> 
> This commit addresses false positive changed functions in livepatches by
> including the underlying data of anonymous constant pool references in the
> objtool checksum calculation, rather than relying on arbitrary symbol names.
> 
> > diff --git a/tools/objtool/klp-checksum.c b/tools/objtool/klp-checksum.c
> > index b8e47f28997e9..ebe25f9c5260a 100644
> > --- a/tools/objtool/klp-checksum.c
> > +++ b/tools/objtool/klp-checksum.c
> 
> [ ... ]
> 
> > @@ -129,6 +142,14 @@ static void checksum_update_insn(struct objtool_file *file, struct symbol *func,
> >  		goto alts;
> >  	}
> >  
> > +	if (is_anonymous_const_data(sym)) {
> > +		void *cst;
> > +
> > +		cst = sym->sec->data->d_buf + sym->offset + offset;
> > +		__checksum_update_insn(func, insn, cst, sym->sec->sh.sh_entsize);
> 
> [Severity: Medium]
> Could this result in an out-of-bounds read if the relocation addend is
> unaligned?
> 
> In checksum_update_insn(), the code calculates the cst pointer by adding the
> potentially unaligned offset to the symbol base, but then unconditionally
> hashes a full sym->sec->sh.sh_entsize bytes.
> 
> If the compiler emits a relocation to a constant pool section with an
> unaligned addend (for example, when an instruction accesses a sub-element of
> a 16-byte constant), reading a full sh_entsize bytes from a mid-constant
> offset could cross the section buffer boundary if this constant is at the
> end of the section.
> 
> Can this lead to non-deterministic checksums by incorporating unrelated memory
> into the hash, or potentially cause a segfault during the kernel build?

Doesn't happen.

-- 
Josh
