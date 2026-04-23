Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF17134888F;
	Thu, 23 Apr 2026 15:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776957705; cv=none; b=LvdDBBhdWyKGaHCjfbkRA0Ejeb/CaQsDh/qURYuksm4v0Moto4ZZVN2IjqrGNsMsK8cerzDo+Rdfq6YRYhHTXv3jrv6bHYlWoOV+pkHW619FrGm+gBwJmY1yfZ0rhsW5JyNMltK4icZmfWfkL1mfc13jxZrquplHcd4gsEo4s4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776957705; c=relaxed/simple;
	bh=aLYhz8FQiLE9uxu2tn4cyRXv1kA7/PjHruVaz1VewRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s0Uf6d8zLJxRMQAorSe2b2BKP8AeP/CmGHV9T7CbFgvJI35OwSQQBPiNxuJmu+RMg/MGyCCjqzqNMJsWM/Oa71LLZB5HQ8qILtWX/bO2ARKtKAiVl1/95F/qLkiFKzKE38v1rRFX2hIweRntCP2GWnj2+uFyJiOcSd2ZTob2asA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tkVlmWlM; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tkVlmWlM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=h2GWoOwltM3/dsQrjiQXASdBd5uHGYYZDhhg3bfR8jA=; b=tkVlmWlMoKjOhlyMPCL2qH5jEK
	fh8dh+HJ4tAYKvQh2yMqzpzsphTAClt7oepF6WE1H5OhyhGZCftAYysYdgNMHmaNph/IMPxhCEyUH
	N8dSM8Lgb+I5xeB5ad6I23gXgRIBRK+d7A6bFaBW00FJDF4CLT86+QyEaJ1REyzh/qc9yYkwu3a6E
	uBhPaMgBEwoiH/t7M7IEI0J3W5iRK5nbnMV0UX3tQojKAsXSFMq5oSidLcRMc692OJp1F35kyVRD9
	oxdtSxcl0N9gwrxaOE+J1PzxQd20ERnW1eCzRAjVbiAqvUcWrNSBlfwvpUh9wwnbM7TGPrYaqDnCd
	pAmBYcGQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFvs4-0000000DelZ-0MER;
	Thu, 23 Apr 2026 15:21:40 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9E8873021A4; Thu, 23 Apr 2026 17:21:39 +0200 (CEST)
Date: Thu, 23 Apr 2026 17:21:39 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org,
	Joe Lawrence <joe.lawrence@redhat.com>, Song Liu <song@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH 47/48] objtool: Improve and simplify prefix symbol
 detection
Message-ID: <20260423152139.GH1064669@noisy.programming.kicks-ass.net>
References: <cover.1776916871.git.jpoimboe@kernel.org>
 <45d385f7112ccb71f991a8524e3f9f48b37c1fd9.1776916871.git.jpoimboe@kernel.org>
 <20260423085520.GZ3126523@noisy.programming.kicks-ass.net>
 <be5iv2gj7mfmizs6v3dsygnv2c2tn7aniabz3fopgrbnnnfdnj@433avj4qybyp>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be5iv2gj7mfmizs6v3dsygnv2c2tn7aniabz3fopgrbnnnfdnj@433avj4qybyp>

On Thu, Apr 23, 2026 at 08:19:57AM -0700, Josh Poimboeuf wrote:
> On Thu, Apr 23, 2026 at 10:55:20AM +0200, Peter Zijlstra wrote:
> > On Wed, Apr 22, 2026 at 09:04:15PM -0700, Josh Poimboeuf wrote:
> > > Only create prefix symbols for functions that have
> > > __patchable_function_entries entries, since those are the only functions
> > > where prefix NOPs are intentional.
> > 
> > __CFI_TYPE() as used in SYM_TYPED_ENTRY() will also generate the NOPs
> > but will not have __patchable_function_entries, because ASM not
> > compiler.
> 
> Hm, but those already have __cfi_ symbols, no?

Yes, but you said those were 'short' -- but fair, I did not check if the
asm stub generated symbols of the correct length.
