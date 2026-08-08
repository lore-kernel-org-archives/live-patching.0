Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DD822083;
	Sat,  8 Aug 2026 00:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786147895; cv=none; b=kA4PS3X1hIvFrHPShh6wUv15pgYzyBNPnza7IrxFcZ/XpbssP9AqUtrhWcyCkft4ZRslMFQP2XzUbd/YSCjFCwQUpdBajwWWbDi+IESOxITS5S6ibAhik5SH14f9Lmv6tGSMoTCDM80bGmM9FZ9mgta8yb6ES9oIeW+5h6XOx+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786147895; c=relaxed/simple;
	bh=2zwk/e7A358PmwAsRq0e5KJYDGTtuIFnePr2LpkGwwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=twHstG7VfHhBKpyRuzjZBmj1JTYnhULz8usgXgvg8aRxeGszS7uMVcMcFNDnUBq2dwhTlrpQaTsIugZsj0DP1xI/jesjyGvqCjUPFj4WvsyUFPQ1r544BFSS+LsbhPBBBwufdaSBw2NOqZMi7aEqyzeN3Mtj4QwMLsT0swzaBKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ePwUA1CY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ePwUA1CY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCBD61F000E9;
	Sat,  8 Aug 2026 00:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786147893;
	bh=2LveIhWTPzg6Gu5DfHx0xwV39eUz2DOfyxOY7EwK5aU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ePwUA1CYnS/FhTDJv4Ir/iMYm3iG4dDABCHqo0TS0h549Hrebs+wRDQiaLQ6KEbpa
	 QMKPz/Lau6dz8iCakdQIOE0ZszA3u3B8DEYKsdnEJjfmwkAFIIpmiCpaJB0PtwI05j
	 scu+Yzu3t6kHuqjASVcu3bOM8JrGMtLXOScfdOnybk1BZv+jw1XA0PpeRj4cbJiaRm
	 07HvE54noBglpCfoCFJej7OVGYwcpLGSDRgBdO2xVhv6N3rBcn+6s086B5LI6DSd0S
	 HgprRgVodPgtoGFkX4txioOS0oZVxgOsJ6gjbuvV+x5vFXnSxBz/dHAoYEtK9BOBlq
	 gmNrRYXq8BMSg==
Date: Fri, 7 Aug 2026 17:11:31 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	live-patching@vger.kernel.org, Joe Lawrence <joe.lawrence@redhat.com>, 
	Song Liu <song@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	Mark Rutland <mark.rutland@arm.com>, Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v3 11/21] objtool: Allow empty alternatives
Message-ID: <ykyqrueqcpoxuondp2hcbjpqnmvshxmlqinlqamsmb626rd7h7@x64cqzsmlqr5>
References: <cover.1778642120.git.jpoimboe@kernel.org>
 <3c474673ec5ddc9f27fbf5ddb1fd0f66ef6a779f.1778642120.git.jpoimboe@kernel.org>
 <20260513073711.GI1889694@noisy.programming.kicks-ass.net>
 <jbjmteak3slp5jxytozuaxvh34lv5uvqzvq7gv47ch363mc4s3@frpc2izplmhp>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <jbjmteak3slp5jxytozuaxvh34lv5uvqzvq7gv47ch363mc4s3@frpc2izplmhp>

On Fri, Aug 07, 2026 at 04:40:34PM -0700, Josh Poimboeuf wrote:
> On Wed, May 13, 2026 at 09:37:11AM +0200, Peter Zijlstra wrote:
> > On Tue, May 12, 2026 at 08:33:45PM -0700, Josh Poimboeuf wrote:
> > > arm64 can have empty alternatives, which are effectively no-ops.  Ignore
> > > them.  While at it, fix a memory leak.
> > 
> > How does this happen?
> 
> Yeah, that commit log sucks...
> 
> The case I stumbled on was the dcache_by_myline_op_nosync macro:
> 
> alternative_if ARM64_WORKAROUND_4311569
> 	.ifnc	\op, cvau
> 	mov	\start, \tmp
> 	mov	\tmp, xzr
> 	cbnz	\start, .Ldcache_op\@
> 	.endif
> alternative_else_nop_endif
> 
> That's actually a bit weird, the .ifnc should probably be outside the
> alternative_if.  Let me try fixing that instead.

I'll probably drop the above patch (leaving empty alternatives as a hard
error) and replace it with this one:

commit 5dd83bdddff38f4df2829b05f876e57215b2e850
Author: Josh Poimboeuf <jpoimboe@kernel.org>
Date:   Fri Aug 7 16:41:10 2026 -0700

    arm64: Remove unnecessary empty alternatives
    
    The code in arch/arm64/mm/cache.S creates three empty alternatives, all
    from calling the dcache_by_myline_op_nosync asm macro.  If \op == cvau,
    it creates an empty alternative for ARM64_WORKAROUND_4311569.
    
    Since orig_len == 0, the alternative patching code mostly ignores it,
    though it does do an unnecessary clean_dcache_range_nopatch().  It also
    triggers an objtool error ("empty alternative entry").
    
    Clean it up by moving the .ifnc check outside the alternative emit.
    
    Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index effae53e9739d..6e059efced5bb 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -404,13 +404,13 @@ alternative_else_nop_endif
 	add	\start, \start, \linesz
 	cmp	\start, \end
 	b.lo	.Ldcache_op\@
-alternative_if ARM64_WORKAROUND_4311569
 	.ifnc	\op, cvau
+alternative_if ARM64_WORKAROUND_4311569
 	mov	\start, \tmp
 	mov	\tmp, xzr
 	cbnz	\start, .Ldcache_op\@
-	.endif
 alternative_else_nop_endif
+	.endif
 
 	_cond_uaccess_extable .Ldcache_op\@, \fixup
 	.endm
