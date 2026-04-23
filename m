Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204DD2D238A;
	Thu, 23 Apr 2026 08:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776933941; cv=none; b=SXSPldRGkd2ItuHk2mAvbQOzMKtc/0ok2ZCb3ZUzW1swz4pY29+uya+4bRUejKklYDJZD29Xt3gTn8p5WIuTHkwYUA6CF4fyrSX7SS9FdBXN/7Ws1PYYDCY83J49NYKdbMy3pvts0wF2OmQS5gs+TjYHuX5MLJBzqcPDBlPPgFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776933941; c=relaxed/simple;
	bh=Aoh12+wnfOm4m17s1nC1LvTIvi+P6SNBvlvIELt/5zk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DWav6O3dKUJ+R3IPABt9R1lJE32R/K+Z253VNbeQg0uP8RGnkQjmpmj0VqZz58mnw9utETNNT8i7aIYJG/0BEOTOAGndPrR4ai64t/nxGw8uny6+B8QnmUBc9ayrlOpkU30N1UqEn+tr1CHDSootyfGLsRV/DgRmSksl0H0lKRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Qz8g36ld; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Qz8g36ld"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=b4OL9ZSo8mKCmS4wHneqHTDZXQmz5A1JwpnqQK4oqXQ=; b=Qz8g36ldQzwyitP9jm8/PnntrT
	iulEV/OM0GR3kMsHmJj+v3adjhz941hr1EMRk3HZSMzqW/82Hb+6jLiPSu/4qmIhxC8J/0ToBRzzZ
	XSfMalgFmlx2IIFibR5p0AUbHPlCCLfDmadM1DO6I6+ik4NKL5k1W6SCD4u5Gm1ivT0vMsftglYhV
	0MVQyExfe8kBgqT9rpWqkZuQX85EBbNQiHPkixD4PanHShRlX31KJ5e9Pdljy//dv7dDVRFj+F/Em
	en96wqg/bdMqhfsdjNzukesdsN7WCmYx7AMkUx0Ua2tYAwIvLL32UCKX7PKMTSA2I7Ko1F8BF80Bc
	gu22jYLA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFpgn-0000000D8Lz-2zrE;
	Thu, 23 Apr 2026 08:45:37 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 43DC83008E2; Thu, 23 Apr 2026 10:45:37 +0200 (CEST)
Date: Thu, 23 Apr 2026 10:45:37 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org,
	Joe Lawrence <joe.lawrence@redhat.com>, Song Liu <song@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH 43/48] objtool: Add insn_sym() helper
Message-ID: <20260423084537.GX3126523@noisy.programming.kicks-ass.net>
References: <cover.1776916871.git.jpoimboe@kernel.org>
 <d0762e0bd04d4d93940c212d2b8080bdced0cb29.1776916871.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0762e0bd04d4d93940c212d2b8080bdced0cb29.1776916871.git.jpoimboe@kernel.org>

On Wed, Apr 22, 2026 at 09:04:11PM -0700, Josh Poimboeuf wrote:
> Alternative replacement instructions awkwardly have insn->sym set to the
> function they get patched to rather than the symbol (or rather lack
> thereof) they belong to in the file.
> 
> This makes it difficult to know where a given instruction actually
> lives.
> 
> Add a new insn_sym() helper which preserves the existing semantic of
> insn->sym.  Rename insn->sym to insn->_sym, which contains the actual
> ELF binary symbol (or NULL, for alternative replacements) an instruction
> lives in.
> 
> The private insn->_sym value will be needed for a subsequent patch.
> 

> +/*
> + * Return the symbol associated with an instruction.  For alternative
> + * replacements, return the symbol of the original code being replaced rather
> + * than NULL.  insn->_sym reflects the actual location in the ELF file.
> + */
> +static inline struct symbol *insn_sym(struct instruction *insn)
> +{
> +	struct symbol *sym = insn->_sym;
> +
> +	if (!sym && insn->alt_group && insn->alt_group->orig_group)
> +		sym = insn->alt_group->orig_group->first_insn->_sym;
> +
> +	return sym;
> +}

That is a bit of a deref fest -- this does not affect performance
negatively?
