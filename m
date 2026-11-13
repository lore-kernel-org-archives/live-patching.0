Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794540375;
	b=j5/CoDgcByt1CErQ5PCtzMie2o6MmReDa21Rxw1YxOtf6T2mpyoNAIXo/eT3xgFpThNx
	 6txD6HstFhLn27+2G2KXCMjlsmlLy5IscdA6HNDuZuC4sjpZfBLAakOfPtRlSSkJ/oH7g
	 WGJmUu1kiKxvqmFxLJ17rpxhBJnbRZI9cEWZFveza/AUEgRVXzVBI3i56RP6XEgLpCpkI
	 C7cVedlQ6dI71PWxDsPSsip+oh/fbFpSDwX7Ml/8u1FryYipxlNdr6j2bf5h1QsWduS5C
	 vd9Rj4rv3iEfUt4cdS8UAPi5TJnFWTnslXSZ4CpgCYzHdUPmPvmv9JEiQILioPbg5CA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794540375;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=417pJEna1raurgsv7ENLMfGf8yuMXWK58o/ChkD7YuA=;
	b=nfFsdzEF77ZJePihd4P9yVw78qxciVD1vQUQ+/3rzrtj+k3QtvUXXTkAXo3byfIPdaVW
	 ylRUjQz7iL8zfGaNwyIveUFrINk4FCTBp63ikqJr/uSZXmzL4h82JpG6cpEbuVx88wwQU
	 D3ZgKeMoavYmAqwGRTtgzsv5jY+8CNTY8L+P1IxWgMRAfMcr4nW4b1iPIUAPFycNOxC0k
	 tDN6FWrwLcudiZF3H1ueEFvjX6BU9mWmfcJ2ZPe10av8ypwkEeY658fRc1unA0CFYddJP
	 ZEr5DveKai+6o/j+bx4dgyCurwRRlYvHyRVgFJW7ixEgiL0KJi0c34VpUxa29o4aGjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XjMIGn9T;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0C9606A31C;
	Fri, 13 Nov 2026 03:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XjMIGn9T
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 852B61F000C4;
	Fri, 13 Nov 2026 03:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794540375;
	bh=417pJEna1raurgsv7ENLMfGf8yuMXWK58o/ChkD7YuA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XjMIGn9Tk3GYj6kUNLctq2fVWzIA7wq3Tz8ZKxI6rYifGkvjY+tHy0DRor8hB+Uve
	 Ft748nw1mooWJ2kqM3/BTTxo8E24hDj6v04UD9TWReyEZbW4ryMsVo1KeKFJkSrnQy
	 q5z8y4IzycX26waOfWeL+wMLo5ItUdLo2+t2VwzEPrUXP6jXM4MIG5Q+r+QodRfGRF
	 1AGs0z/QxrOpM4HltyZK6nl12e6M4nyR9sV+jH7QnPcVfdsqMAp9k4zqkspdkF6ikY
	 NtIO9+FISp2UvC2yxzFMw3Dh/VmqrEsQe82lQWu98CntM/TNX/7qTA6YwQhL0DSV4w
	 lsvGWwJppJyKQ==
Date: Thu, 12 Nov 2026 19:26:13 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Longjun Luo <luolongjuna@gmail.com>
Cc: peterz@infradead.org, mbenes@suse.cz, pmladek@suse.com, 
	joe.lawrence@redhat.com, song@kernel.org, puranjay@kernel.org, nathan@kernel.org, 
	ndesaulniers@google.com, morbo@google.com, justinstitt@google.com, 
	live-patching@vger.kernel.org, llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 00/11] objtool/klp: DWARF-based cross-build symbol
 correlation
Message-ID: <avZ9Ku61M8z-2axF@jpoimboe>
References: <20261104133158.3187525-1-luolongjuna@gmail.com>
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261104133158.3187525-1-luolongjuna@gmail.com>

On Wed, Nov 04, 2026 at 09:31:46PM +0800, Longjun Luo wrote: > Open Questions and Next Steps
> -----------------------------
> 
> This is a substantial change: 1,755 of the 4,010 added lines are tests,
> and about 1,300 implement the DWARF reader and identity layer. Before
> preparing a merge-ready series, I would like explicit maintainer guidance
> on how to stage its integration. My proposed sequence is:
> 
> - Submit Patches 1-3 separately with their regression tests.
> - Prepare the identity representation, DWARF reader, and ELF cross-checks
>   as a foundation that can be reviewed separately from twin matching.
> - Integrate the matching changes in Patches 7-10 together: reference
>   extension pairs repeated statics, and the reference checks reject
>   remaining ambiguous data references.
> - Submit the memory optimizations separately and pursue explicit state
>   annotations in a separate RFC.
> 
> This RFC retains upstream expectations for the three policy tests to
> make the behavior changes visible. For the merge-ready series, I will
> update their assertions to reflect the agreed policy and move Patch 11's
> tests alongside the changes they cover.
> 
> I plan to add triple-based DWARF correctness tests in upstream compilers,
> using known source definitions and optimization variants to check
> coverage, non-conflict, and attribution accuracy (with clones, pieces,
> anonymous scopes, and folding checked according to their respective
> semantics) without locking in a specific DIE layout or suffix scheme. My
> earlier bug reports and fixes on IPA-ICF, weak-override attribution, and
> assembly CU selection [2-6] provide concrete test inputs, and the same
> attribution model applies to consumers such as AutoFDO [7].
> 
> I would appreciate feedback on four questions:
> 
> 1. Would maintainers prefer to integrate the identity representation and
>    reader first, then evolve twin matching in a follow-up series, or keep
>    them together for integration?
> 2. Is constraining candidates by the identity triple and extending twins
>    via checksums and unchanged-function references the right foundation
>    for correlation, and how should the final ELF fallback be bounded?
> 3. Is the handling boundary in Case D reasonable, and should explicit
>    state annotations (such as `KLP_NEW_STATIC()` / `KLP_DEL_STATIC()`) be
>    pursued in a separate RFC?
> 4. How should we structure upstream compiler tests around the identity
>    triple to protect both DWARF producers and livepatch consumers?

There are a LOT of words in this cover letter.  The whole thing is a bit
overwhelming to try to review, much less answer these questions.  Please
don't use LLM-generated text, as it can be very difficult to follow.

Also, I noticed the cover letter has several back-references to v1,
adding to my confusion.  The cover letter should be self-contained, such
that a reviewer can easily understand what the patch series does without
first studying v1.

DWARF is the most controversial and complex part of this series.  Before
going there, we should look at whatever can be improved *without*
relying on DWARF.  That will then make it much easier to evaluate what
additional benefits can be provided by DWARF later on.

klp-build is very much a pragmatic tool, and most likely will never be
able to handle all possible AI-imagined edge cases.  It should always be
used with caution, with someone (or something) double checking its
results at the end.

I suggest splitting up the patch series, focusing on fixing the more
realistic and tractable issues first.  Maybe even one issue at a time.
Human reviewer attention is spread very thin right now, please make
legibility a top priority.

-- 
Josh
