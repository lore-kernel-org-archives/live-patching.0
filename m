Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E3317BA2;
	Thu, 23 Apr 2026 08:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776934526; cv=none; b=WbABIUeh85+HkeNSzaYemGMWGucaHYoV/Lpuo3HvgZ/YGX9+oHgtls+c3UUYvEMBmtNhhz4SI93Xq8CWP6KuE9/JKwnw1PVBtxbU8CQ/F69IL7hl2O7i8YtTKDqWmCyEfEy4UrszU+pfWzeJGXqImcGodIGoSaMcGATCg12yRp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776934526; c=relaxed/simple;
	bh=RK430LBAZGUg+A4+p2VVUW6mf61Js+EXkmJuVLaqTgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KvDflLZw/CKJUJH4yZ5UAxxgyaDCGFbGrUalDB+KjAd8Co621rXmBKxwr50Gav17JQ+ct6LcK7MJjdc9AFvE8b8oj0o5P/77iPH6YnX70wVJX6x0pd0ddIogGtPSU9u8OLG5fe0DXcyBE+QkCznuzxQBH/bgfn5Sup/Tyf4OUIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=j6IqTs35; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="j6IqTs35"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RK430LBAZGUg+A4+p2VVUW6mf61Js+EXkmJuVLaqTgM=; b=j6IqTs35aEFvhob45xez5PzDni
	+9YqaN0lIyMZmuAe3QenOcdXCLRFaSTiitGtcDwhz7PagwgEMuuTBJ6Q0hUpOYSi5zmZWWFDvv/AP
	b/f5Cf2ohPR0+A+lG9yG2wbabjcwXfNLncpgaiAkbcIkzQv+UKWekbPpuZsjC4DqEoYraOpcWdFQn
	if2GoNrX/KFcM6EJXpSyoQMTm+LicErO3a2vsIP04HuSRZcvt4Ke7az5HvqSBNm82tvQs8h9Ccsf0
	O/U0AAO8fplvYhJYOpZXTjaWJuWViC2+vhFXKEFJr6q5wZ2aKdhNs60ZV/goHYuRoKwQAqri8GGt5
	qKB/Gbdg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFpqD-0000000CgAa-3Jmk;
	Thu, 23 Apr 2026 08:55:22 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7AB7F3008E2; Thu, 23 Apr 2026 10:55:20 +0200 (CEST)
Date: Thu, 23 Apr 2026 10:55:20 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org,
	Joe Lawrence <joe.lawrence@redhat.com>, Song Liu <song@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH 47/48] objtool: Improve and simplify prefix symbol
 detection
Message-ID: <20260423085520.GZ3126523@noisy.programming.kicks-ass.net>
References: <cover.1776916871.git.jpoimboe@kernel.org>
 <45d385f7112ccb71f991a8524e3f9f48b37c1fd9.1776916871.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45d385f7112ccb71f991a8524e3f9f48b37c1fd9.1776916871.git.jpoimboe@kernel.org>

On Wed, Apr 22, 2026 at 09:04:15PM -0700, Josh Poimboeuf wrote:
> Only create prefix symbols for functions that have
> __patchable_function_entries entries, since those are the only functions
> where prefix NOPs are intentional.

__CFI_TYPE() as used in SYM_TYPED_ENTRY() will also generate the NOPs
but will not have __patchable_function_entries, because ASM not
compiler.
