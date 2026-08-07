Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4099A3F4845;
	Fri,  7 Aug 2026 23:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786146041; cv=none; b=LI3c//PbAbAF8T+68Coh4MQLM+fKU8qK5mXHsPP4cysuDjIi2fSgXGcX1BJ5ZEtm53MjfjySM9Q6Kt96xVjOv6gFqbiExOW5dFGKTwXHUK/M9jI0IIyFe7y2pnlmGUQ39P3dbl5tZJhZGBtVr5khRsNdH+I2oqk9jGVxbW41af0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786146041; c=relaxed/simple;
	bh=btltByYeJ7XRrjhe5RMFt+su4KQiVc6/qLnnE8QiBFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jbU853q2rvs3tc9CaqyL3kLA14EEKFrLudcvEl5lDnfiafWRkGntvAPWuTKdQBYN9JfD1m/JNegnl57D0hKs613xDQSbvvBtpeSj+zJiVakMXGVnzbAj/3GqD+ZR6jxl8hnrWqteoM/fC4QDSX5OdErKD+5O7hhLuhFG6wzG2Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OgRIrG5p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OgRIrG5p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D3A71F000E9;
	Fri,  7 Aug 2026 23:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786146038;
	bh=itKP/luZUo3Ldz8OJ7wrr1SQkDgbCS31ssYxUZVwy7Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OgRIrG5pRos8h8lfONzMyx050dIhhOGub3B32Bxg4y8jDSqLXd08RqhWyJYIFsgrY
	 YMber64ZrKQ4WcueROkthKjBInFfH8zErIjEySus8ZC4E+dhvvXLBHtTPxcXdhqFPM
	 VBPezQDaEPRrfGIoQxTBIYjZ3lzeDXKJrNtXOfcZ80mAu+i3+cozqBFXI9FCeRMgIg
	 9hjcDJ6KEtxWdWyx8lNPk8qGsjucAPGF+fqDuFFqMepx2GYEdXcuQpPh4Rt+qHAca3
	 xC3rXyv9DvwOLJiX3FCU3qNL97p3CGRPJGUab8L/h0IVcJR0j32TKsMefSugfxY0T1
	 vgLs8c5eklR5Q==
Date: Fri, 7 Aug 2026 16:40:34 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	live-patching@vger.kernel.org, Joe Lawrence <joe.lawrence@redhat.com>, 
	Song Liu <song@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	Mark Rutland <mark.rutland@arm.com>, Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v3 11/21] objtool: Allow empty alternatives
Message-ID: <jbjmteak3slp5jxytozuaxvh34lv5uvqzvq7gv47ch363mc4s3@frpc2izplmhp>
References: <cover.1778642120.git.jpoimboe@kernel.org>
 <3c474673ec5ddc9f27fbf5ddb1fd0f66ef6a779f.1778642120.git.jpoimboe@kernel.org>
 <20260513073711.GI1889694@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260513073711.GI1889694@noisy.programming.kicks-ass.net>

On Wed, May 13, 2026 at 09:37:11AM +0200, Peter Zijlstra wrote:
> On Tue, May 12, 2026 at 08:33:45PM -0700, Josh Poimboeuf wrote:
> > arm64 can have empty alternatives, which are effectively no-ops.  Ignore
> > them.  While at it, fix a memory leak.
> 
> How does this happen?

Yeah, that commit log sucks...

The case I stumbled on was the dcache_by_myline_op_nosync macro:

alternative_if ARM64_WORKAROUND_4311569
	.ifnc	\op, cvau
	mov	\start, \tmp
	mov	\tmp, xzr
	cbnz	\start, .Ldcache_op\@
	.endif
alternative_else_nop_endif

That's actually a bit weird, the .ifnc should probably be outside the
alternative_if.  Let me try fixing that instead.

-- 
Josh
