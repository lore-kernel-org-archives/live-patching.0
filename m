Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268403264DE;
	Tue, 28 Apr 2026 16:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777393547; cv=none; b=qL5/2JVyuudV3SRJDMMVKjEvTunVqJHaY1LhJgnfgTt1+QPgTr4zdNxmwz28+zi3X+lcpQCFQc8uBHhKUmx4iESHw9BnDM1k6f84or6vnYpb22/kLNlfCXNKFOHnxPo3Jm7Gtyi5DjHZlUogOS0Rn056PYyin7zf+4c6paEyIhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777393547; c=relaxed/simple;
	bh=pMA0m5ygSNkNMCdns3xiNl3YXUAk0R7qE3Y30G8XK2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XUpjMCNxTdewXdyMMn+/CVyIvQBCEJH4T2Fmwoe7udrLg4XvxUOguGgc1KmvP7jo25RiUW5aya7PLJJny1W/rQ3tB4BhV5SAESMDqyHiozfZpT0DXcQ2NEESbDdkvhbBhxKqRJcc2ID6bqVrVf6ddsUVnydqswovHQrhFJhjwxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iCwqFuTt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iCwqFuTt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE993C2BCAF;
	Tue, 28 Apr 2026 16:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777393546;
	bh=pMA0m5ygSNkNMCdns3xiNl3YXUAk0R7qE3Y30G8XK2g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iCwqFuTt+RL6rKi06cqfup+Iv7ceMCTuFk+yk9eVSaNySEtgUHxzBbB5jw1yJSt7E
	 pNc353/kpS9u+AzF/k4R5DiSeGX+NiLe+g/PAfwvI/fZCpuQ/bu8jT/38ysUD+3tvx
	 QBWVxh4rxo+WhQCVBuNQrP5OoBlmlcv0gaDdejp86/G7wdiNlfzDE0FqZc6Nr552Oz
	 nFj6ns5uFBZ1ruMulQKEimDejesDug+7FknanHGMyy0SnhqMYw0yyFItqqjRnBACaX
	 C+6N0YJPF+0hrbJEAYlNJx+ikzTncGd8+Fsrxmx9K96gw4GeP1arbeNKmhK3zp872o
	 XVYTsXpF7A9hg==
Date: Tue, 28 Apr 2026 09:25:44 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, x86@kernel.org, 
	linux-kernel@vger.kernel.org, live-patching@vger.kernel.org, 
	Joe Lawrence <joe.lawrence@redhat.com>, Song Liu <song@kernel.org>, Miroslav Benes <mbenes@suse.cz>, 
	Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH 45/48] x86/Kconfig: Enable CONFIG_PREFIX_SYMBOLS for
 FineIBT
Message-ID: <nipfo6idbjcrjztzqduuv4qx5ify4tenpl5rrtsjdoezfxxbfc@scjafbigdigv>
References: <cover.1776916871.git.jpoimboe@kernel.org>
 <70107aab81b01f8a2360f052ff550a9e97c30f79.1776916871.git.jpoimboe@kernel.org>
 <20260423084758.GY3126523@noisy.programming.kicks-ass.net>
 <n6xqf563o4moyl3sqp37ymakjhyvbxfinghi5k5lygeocak6ns@ugrn3b7csjot>
 <20260423151925.GG1064669@noisy.programming.kicks-ass.net>
 <gpq7mfal5gydlrqsm5mza5hzx5aa2rq7yk6olozlzotdnl7e24@ljzzzwwsputr>
 <d5ex4fawfive7trcvhsptu2dwr5l5yru5q6bsx5zh3sqlle26u@navby7ru5z6t>
 <c7vi7gpfrybjmngjoqu2jmirh6jp53bpw5edeoeupz5gwhw6gx@fvcn6l6vgl47>
 <20260428023717.6a7c68c6@pumpkin>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260428023717.6a7c68c6@pumpkin>

On Tue, Apr 28, 2026 at 02:37:17AM +0100, David Laight wrote:
> >  static const struct option check_options[] = {
> >  	OPT_GROUP("Actions:"),
> > -	OPT_BOOLEAN(0,		 "cfi", &opts.cfi, "annotate kernel control flow integrity (kCFI) function preambles"),
> >  	OPT_STRING_OPTARG('d',	 "disas", &opts.disas, "function-pattern", "disassemble functions", "*"),
> >  	OPT_CALLBACK_OPTARG('h', "hacks", NULL, NULL, "jump_label,noinstr,skylake", "patch toolchain bugs/limitations", parse_hacks),
> >  	OPT_BOOLEAN('i',	 "ibt", &opts.ibt, "validate and annotate IBT"),
> > @@ -84,7 +83,7 @@ static const struct option check_options[] = {
> >  	OPT_BOOLEAN('r',	 "retpoline", &opts.retpoline, "validate and annotate retpoline usage"),
> >  	OPT_BOOLEAN(0,		 "rethunk", &opts.rethunk, "validate and annotate rethunk usage"),
> >  	OPT_BOOLEAN(0,		 "unret", &opts.unret, "validate entry unret placement"),
> > -	OPT_INTEGER(0,		 "prefix", &opts.prefix, "generate prefix symbols"),
> > +	OPT_INTEGER(0,		 "prefix", &opts.prefix, "generate or grow prefix symbols for N-byte function padding"),
> >  	OPT_BOOLEAN('l',	 "sls", &opts.sls, "validate straight-line-speculation mitigations"),
> >  	OPT_BOOLEAN('s',	 "stackval", &opts.stackval, "validate frame pointer rules"),
> >  	OPT_BOOLEAN('t',	 "static-call", &opts.static_call, "annotate static calls"),
> > @@ -92,6 +91,7 @@ static const struct option check_options[] = {
> >  	OPT_CALLBACK_OPTARG(0,	 "dump", NULL, NULL, "orc", "dump metadata", parse_dump),
> >  
> >  	OPT_GROUP("Options:"),
> > +	OPT_BOOLEAN(0,		 "cfi", &opts.cfi, "annotate and grow kCFI preamble symbols (use with --prefix)"),
> >  	OPT_BOOLEAN(0,		 "backtrace", &opts.backtrace, "unwind on error"),
> >  	OPT_BOOLEAN(0,		 "backup", &opts.backup, "create backup (.orig) file on warning/error"),
> >  	OPT_BOOLEAN(0,		 "dry-run", &opts.dryrun, "don't write modifications"),
> > @@ -163,6 +163,11 @@ static bool opts_valid(void)
> >  		return false;
> >  	}
> >  
> > +	if (opts.cfi && !opts.prefix) {
> > +		ERROR("--cfi requires --prefix");
> > +		return false;
> > +	}
> > +
> 
> Wouldn't it be more friendly to have:
> 	opts.prefix |= opts.cfi;
> and change the help to (implies --prefix).

It would, if prefix didn't take an integer as an argument ;-)

-- 
Josh
