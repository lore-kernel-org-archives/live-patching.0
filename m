Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9550676026;
	Sat,  8 Aug 2026 00:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786149693; cv=none; b=P2YVCOYdXRkH9Ha4AnK6u563lQGf7xI2335W5yBfipFYmx0+CDcHSdJ02HOVjIgM5LBLcmUEHzpLZemnmc3fvwSiUazzZ+u8nslwFTCnxMJf2q/dRY8e2Rmi2yEBgMcYImZIbMXH7P9IdoHpcD1N+M/X/c8HDiIRcC4jJfa86jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786149693; c=relaxed/simple;
	bh=xSTT2Y8Nt9jx8WBkqZ80pRQURZ5LGdw/S2Af9cuUghQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZRK6HgwrrX9mUMAkTgE1yOcGGwFRmzmbyxuprnSN3d7PTRRI/oNZZhM0dQi5j9bEMGzEf16PbD3IRghYQRl0nXMljRNfnOaMDRPHxSmUpnPkwV0E3xHXd5m2i9jUfqKXCjYBXFUMpIB8J9pFPVJ25qqbC1txxw0/gEz7RSs+mEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K53J4Ewg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K53J4Ewg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DAE91F000E9;
	Sat,  8 Aug 2026 00:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786149692;
	bh=6YL3HWaNN5b5xlcbD6Iu0baOSlDyk7lrzsw42UJpYVQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=K53J4EwgWESmb4+iPlvtXScn1NwwXR6CY25zq1b7E5QgLdz/dD0opuhjJH39GouHr
	 XVNhK1u3QBJK9ibmFxUFN2rabfvb4xxojyfbsq41XdaDKgVoB+Nesx1h3zyZUVLgaB
	 1n3CeyuyjHRZ7YsukULcTlLCvRXP/HMA5FDxnhNN+ZyBBaXzMrU1l25o5AI3p5Ty9n
	 a9vZUGce40/6/tVwfjQN7HlqOdbO8lAZOBb3nnzSWsdjrk/GeECo2qeHeHw+t60gZR
	 wcR0POjMlY0zTnqFXXBva+wwEKCnUOSekdeWFDCF2ZEc+5bjc/hlyfeebh1lZ9ykIH
	 xmIJokT0MVUQA==
Date: Fri, 7 Aug 2026 17:41:30 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: sashiko-bot@kernel.org
Cc: x86@kernel.org, Miroslav Benes <mbenes@suse.cz>, 
	live-patching@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Will Deacon <will@kernel.org>, Joe Lawrence <joe.lawrence@redhat.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, linux-arm-kernel@lists.infradead.org, 
	Mark Rutland <mark.rutland@arm.com>, Song Liu <song@kernel.org>, linux-kernel@vger.kernel.org, 
	Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v3 21/21] klp-build: Add arm64 syscall patching macro
Message-ID: <rumkp7mj6x4jo3r4x3erzkcwqkssbf5n46fxvrgcan7u4n2fuk@pkleqal5rqgr>
References: <3bf3cee43039fc4da84e83d0891a92e25f40f00f.1778642121.git.jpoimboe@kernel.org>
 <20260515024439.AF2B7C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260515024439.AF2B7C2BCB3@smtp.kernel.org>

On Fri, May 15, 2026 at 02:44:39AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The arm64 __KLP_SYSCALL_DEFINEx macro omits the ALLOW_ERROR_INJECTION declaration, silently breaking BPF error injection for livepatched syscalls.
> --
> 
> commit b4d1a9ea352f196a7fd3e7198fdade51440d08e5
> Author: Josh Poimboeuf <jpoimboe@kernel.org>
> 
> klp-build: Add arm64 syscall patching macro
> 
> This commit adds arm64 support for KLP_SYSCALL_DEFINEx(). The commit
> message states it is mirroring the arm64 __SYSCALL_DEFINEx() pattern from
> arch/arm64/include/asm/syscall_wrapper.h.
> 
> > diff --git a/include/linux/livepatch_helpers.h b/include/linux/livepatch_helpers.h
> > index 99d68d0773fa8..4b647b83865f9 100644
> > --- a/include/linux/livepatch_helpers.h
> > +++ b/include/linux/livepatch_helpers.h
> > @@ -72,6 +72,25 @@
> >  	}								\
> >  	static inline long __klp_do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
> >  
> > +#elif defined(CONFIG_ARM64)
> > +
> > +#define __KLP_SYSCALL_DEFINEx(x, name, ...)				\
> > +	static long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__));	\
> > +	static inline long __klp_do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
> > +	asmlinkage long __arm64_sys##name(const struct pt_regs *regs);	\
> > +	asmlinkage long __arm64_sys##name(const struct pt_regs *regs)	\
> > +	{								\
> > +		return __se_sys##name(SC_ARM64_REGS_TO_ARGS(x,__VA_ARGS__));\
> > +	}								\
> 
> Does this macro definition omit the ALLOW_ERROR_INJECTION declaration?
> 
> The standard arm64 __SYSCALL_DEFINEx() macro explicitly registers the top-level
> syscall handler with ALLOW_ERROR_INJECTION() to enable BPF error injection
> workflows like bpf_override_return(). The x86 implementation correctly
> preserves this functionality.
> 
> Because this macro is missing that declaration, it looks like it might
> introduce a regression where BPF cannot inject errors into the replacement
> syscalls in a livepatch module on arm64.

Fixed.

-- 
Josh
