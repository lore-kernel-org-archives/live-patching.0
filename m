Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385A13D953B;
	Thu, 27 Aug 2026 22:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787871480; cv=none; b=tzkMlxumOJ+lc5NBzqfLCzJOTLk4cTrVxMAnGfbDfTJgLnTJgJRB0kg04cnN7NaqcfGMTdxdjL3VTTBg4QNdQc5Wjcu75GXYgw5KkkpqqymevXS00U5a00uDdfeZnLKU5/ONSVY4YJXToUfXuiW+ob81GGx9O65EF5gJxMAuG10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787871480; c=relaxed/simple;
	bh=tBugFbnMG2hyKpu3+/5uTfS8V6SWR7dJqc6LPVx+UfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uIChqN30tRzZCYdxGeZJT/tdwdMhB+cLW10iQXEq9szaZec34P7+xO9EeZfahSAtHKQy2bXurnOMAaN5M104bTyYm5TEhVlEK217c8Wa4g2vwWTC4aP01Qyd4XjQ0jn0R03cyY8ktxxWkKi1cmzpyLlVx8kujySMWORjimvL5cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lIFCNvCG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lIFCNvCG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 482E51F000E9;
	Thu, 27 Aug 2026 22:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787871467;
	bh=S3btrNpTURY2mZcdQLSd8hAqIBUH6Qf57Ots+Wju3r4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lIFCNvCGTfhMisuOpFYhd74OppuL0c2MmF24444F35lnKptstwJEnzd6JGM6+QbbD
	 /VD8loz29mjycf1fnMQ5KfuVXJlezIgckMdFcG+aD0inNyaQRSUiwDF01c0gngvwed
	 3ReAJAG7iQOOXsj8osy5RiKOzZoJr2MC5alAl4Ng91aYsZm5KpNgpDWKkIGLt1UvoP
	 ab/xZKG2KZeLEZMr4eHpP26Rd310KXGZz2dXez16WJ7U8R6RV6Jxhe48vdf0DuFxmF
	 31iZF0mW9hCawArO4rNwBM2NWct7zlrlTUP2OsejC9hKGy7OBxxzEV6JiWCSd9/dq7
	 3qiJxUeodA8Kw==
Date: Thu, 27 Aug 2026 15:57:44 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Harry Hsu <x90613@gmail.com>
Cc: pmladek@suse.com, jikos@kernel.org, mbenes@suse.cz, 
	joe.lawrence@redhat.com, live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] livepatch: Reject livepatches with aliased old_func
Message-ID: <apDA3pKwtqYYA5kJ@jpoimboe>
References: <20260823060734.58443-1-x90613@gmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260823060734.58443-1-x90613@gmail.com>

On Sun, Aug 23, 2026 at 02:07:34PM +0800, Harry Hsu wrote:
> Several symbols can share one address:
> 
>   ffffffff8ed7fef0 t __do_sys_fork
>   ffffffff8ed7fef0 T __ia32_sys_fork
>   ffffffff8ed7fef0 T __x64_sys_fork
> 
> klp_find_ops() looks the ops up by func->old_func, i.e. by address, so
> two klp_funcs of the same livepatch naming two of these symbols resolve
> to the same klp_ops and are both pushed onto one ops->func_stack.
> 
> This breaks the assumption that a single livepatch contributes at most
> one entry to any func_stack.  klp_ftrace_handler() picks the entry at
> the top of the stack, but when both entries belong to the same livepatch
> there is nothing that says which of them should be used in the PATCHED
> state, and the UNPATCHED state has to end up at the original function
> either way.  klp_check_stack_func() cannot tell them apart either: it
> asks whether the preceding entry is the original function or another
> livepatch's replacement, and an aliased sibling is neither.
> 
> Patching two aliases of one function from a single livepatch was never
> meaningful, so reject it while the object is being initialized rather
> than leave the redirection undefined.  Compare the resolved old_func of
> each klp_func against the ones already resolved for the same klp_object
> and return -EINVAL on a match, naming both symbols so that the offending
> pair can be found in the livepatch source.
> 
> Fixes: 3c33f5b99d68 ("livepatch: support for repatching a function")
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Harry Hsu <x90613@gmail.com>
> ---
> v2:
>   - Drop the klp_check_stack_func() change.  As Petr pointed out, using
>     list_is_last() only made the last entry behave, still checked the
>     aliased sibling's range for the other entries, and did nothing about
>     klp_ftrace_handler() being unable to pick between them.  Reject the
>     livepatch in klp_init_object_loaded() instead, as suggested.
>   - Rewrite the changelog around rejecting the configuration rather than
>     around the out-of-bounds read that v1 described.

Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>

-- 
Josh
