Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D1876026;
	Sat,  8 Aug 2026 00:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786149674; cv=none; b=pF9owNbZ3Jj1WbbcDDRbmJikbSch/A/9u32SP7Mc4SSouzSwuCC2mPcSprd+QQQDRC8oypYFx+y37lV6OXyRe/YphvUzflwnH1w1gTRJWtWTnZZIUJfaK8K00fYgxjqHH2/RmC7pH9Tv9CCcxnwD7y9x7jWhI7wFbXp+RvbT0g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786149674; c=relaxed/simple;
	bh=/j5ZbbpMUe4bhlK2uDq4zM5EsfSsND+SmBt3r6C5qyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bM5lU7IYYf5F2vXDH1vBzZ3ZlNJpEuyq1bisfzCXLMUsBmoWljEIoj7QZaJ2zZwJ388fu9cP5tRGnz8hy6PJ+Wn2OgrZYC7B1wULrQLVeuO2gqBAEqpRXXKpgQKa/3bQhZE22QNmZWGSBhMZLFtUGULXAPWnnTgkSWYSf4QTCyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mGHeSRHP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mGHeSRHP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A53AA1F000E9;
	Sat,  8 Aug 2026 00:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786149672;
	bh=98aVebFo2ZoGfQEah6KnP9OcE5j2THfDpj4TyKk+wKM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mGHeSRHPCALXQ2CKGzJk0XT8cIV1NasjJulNs0XvN+XouLKRIAibTVD3t4a2NJDkV
	 HuRkgSc6LIT/xxrdkhmSLmES1SO2x9w0UkdURNjHVTCbtkwvijiqT3HzCfpOO2DdTw
	 f+iQl6vtkmKmJMxypHbois9i54yMmN8Y/p28QWJdhruxvFcp5iPgNZQens00qek6Tj
	 mlgqaEY2QPR5MkilBGgPPbIQ8rKwjrCkOPnXdJcdN9DSCulD342EtyQGLuZj0WhwP9
	 q8DARi8OzrMXmHfeDLetWjdqV2KADRrubBjZupItcbQEB9yorbT05LU/WjAtft0eKr
	 ZFU2DKQzbzrvA==
Date: Fri, 7 Aug 2026 17:41:10 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: sashiko-bot@kernel.org
Cc: x86@kernel.org, live-patching@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Song Liu <song@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>, Miroslav Benes <mbenes@suse.cz>, 
	Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v3 19/21] objtool/klp: Introduce objtool for arm64
Message-ID: <7owxhuwmxb2kbaioac5cm3qgqgqezcn6vgz34md47zuvm3ajjj@sgxpuzvuulmm>
References: <5b66146373b1ff1aba1318fd51867dea2eb882f6.1778642121.git.jpoimboe@kernel.org>
 <20260515020845.CE5B2C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260515020845.CE5B2C2BCB3@smtp.kernel.org>

On Fri, May 15, 2026 at 02:08:45AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The arm64 instruction decoder misclassifies trap instructions (e.g., `brk #0x800` used for `BUG()`) as `INSN_OTHER` instead of `INSN_BUG`.
> --
> 
> commit dd63f0c03bab6a47f34cfcb310454460653638ed
> Author: Josh Poimboeuf <jpoimboe@kernel.org>
> 
> objtool/klp: Introduce objtool for arm64
> 
> This commit adds basic support for arm64 in objtool, initially enabling 
> only the "objtool klp" subcommands.
> 
> > diff --git a/tools/objtool/arch/arm64/decode.c b/tools/objtool/arch/arm64/decode.c
> > new file mode 100644
> > index 0000000000000..47658c76e1af0
> > --- /dev/null
> > +++ b/tools/objtool/arch/arm64/decode.c
> 
> [ ... ]
> 
> > +int arch_decode_instruction(struct objtool_file *file, const struct section *sec,
> > +			    unsigned long offset, unsigned int maxlen,
> > +			    struct instruction *insn)
> > +{
> 
> [ ... ]
> 
> > +	if (ins == 0xd503201f) {
> > +		/* NOP: static branch */
> > +		insn->type = INSN_NOP;
> > +	} else if ((ins & 0xfc000000) == 0x14000000) {
> 
> [ ... ]
> 
> > +	} else if ((ins & 0x7e000000) == 0x36000000) {
> > +		/* TBZ/TBNZ: intra-TU sibling call */
> > +		insn->type = INSN_JUMP_CONDITIONAL;
> > +		insn->immediate = sign_extend64((ins >> 5) & 0x3fff, 13);
> > +	} else {
> > +		insn->type = INSN_OTHER;
> > +	}
> 
> Does this code misclassify trap instructions?
> 
> On arm64, BUG() is implemented using the brk instruction (such as brk #0x800).
> Since the decoder doesn't appear to check for brk, it will fall through to the
> else block and classify it as INSN_OTHER.
> 
> If INSN_BUG is misclassified as a normal instruction, won't this lose dead-end
> propagation and corrupt objtool's control-flow analysis?

Nope, as the comment above this says:

	/*
	 * These are the bare minimum needed for static branch detection and
	 * checksum calculations.
	 */

For arm64 we don't have any reason to care about INSN_BUG.

-- 
Josh
