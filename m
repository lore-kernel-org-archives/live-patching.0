Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94429352001
	for <live-patching@vger.kernel.org>; Thu, 27 Aug 2026 15:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787845525; cv=none; b=YG/S8bcAmgxwBrWYuoHEG0WgRxLI0DTz+IxjWbradZkGnhnrYK9lBVsuAn6ZcS1bUe0BS7McPbnPijqxfOVkzcR0EltzGks2cHyctQw37IC5Y5ZOFqLCKVa2hG0xXgjr7cbe4VCl1KKUWZ5z9veNuCfdgRBKQ8XRFBofIrRt/QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787845525; c=relaxed/simple;
	bh=/fxAMBlf0kUAuzwPRUNe7r1h2X/Fn3SIGCrrk8cVO+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uW74a3b4lUz7LZr35ZAHGtqIKvIUlWFoOpXW2/z9bUGMnw5xdQMiGObUFhOui45gsRSni5JONYKqpjGNqhsGqdrXdl/9aL+4+BOzDKMAuj346XKbR8evoLkUsRxr0iKWL2IQ80P4ca4/DH/RpzO5P9Bf0g5q84GrXFqBMm2UHYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DDMeJzkd; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DDMeJzkd"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-499d1ab3f9dso9697135e9.3
        for <live-patching@vger.kernel.org>; Thu, 27 Aug 2026 08:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1787845522; x=1788450322; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZHwo+xGhyHn5BFSs+/et2NTgWRMdJNfULKw3PzDr3AE=;
        b=DDMeJzkdaGm2SLozuoK/PnbGkUHkcubus9fh2wHIT2eck5lD3DGFEwX0tUFKJHPkYo
         Qo9ff96P79zzXmNgE3JWE4j2j+fx9YRT9U6D14gigHLhNSE36G1YQWY5mHXxVGL/vwmk
         JTwFq0ElrIt75tXpaIcd95fj+xJ1F4GFg7Hg+eA5BtvEdsCTkMTZH+KcfBIVjzIkFFPY
         FJ8ZmAXaaKzfK+UruvxDpCYwRY7nD5PGJpd45bAkq1XoWoH1SFVDMIgh2Y2EyS3jYvt5
         1ivZGIlf5HMRW1dz6P9X6d+oDZ5XRIkJ1796Jb6a6KnXC4miSxwCRjlSExHiHgOO2NU6
         ig8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787845522; x=1788450322;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZHwo+xGhyHn5BFSs+/et2NTgWRMdJNfULKw3PzDr3AE=;
        b=Lp1UofQdoK0hd+AKGto1CkYQ/eRaTdqaqBhPJXLtOkZnha3fBHZHNULaOl0EUiIqfy
         nwqaJoWj+xqIeZYLNciA/C2m1wVT32m+B/6F5gmrxwBDJ6SPBP80ZYccBb2cWqMjsK68
         mTTjdkyjrXTfbhgNqKYTobLTNn4AMnF7qtbog36s0i/8fj+VuiK6bMSFFmQ3APDZZe+k
         6uNehTk1fqWaKpJNCdcIgOA4jTTmZ3wrH35jnQgoV4zNfh0e3wklT6BTTfiknpcKnewb
         2L9yGOM8t4IG+JfyS4x/yl3TswHhStDUkfAAQkj5CAwhcyhnwlc2DAVH28EPwOavWWTl
         xiEg==
X-Forwarded-Encrypted: i=1; AHgh+RpsFe6YTkt8GQfwTYco+mVqHjsFzZNP214J88eKjC8rLDbLKaMjmdzx8rnCIDe296QwIxJeo8A+K+q5Bbsi@vger.kernel.org
X-Gm-Message-State: AFuF++nhoH5+piFf33poyg8KppYYX9E7No+NwOYsYvxW9t/DUTmF4WLt
	Un8W3FbTNfAlSYSpkzy9ebWA+XSyKlBVwxB+Sz98luONTBM03RTl0rgt8Wy+HuRWq5U=
X-Gm-Gg: AR+sD12v6sqnP4YJcM28rTc7B3nLv1N2/SP0U4IeuzOmpu7cT9zTvantMh8vm6sPG/T
	0jkqp/SCStYdfPAfE2a5YLpRcQPDhM33hnDlWi52aN5s9vJ3cGjKIhRrNBcB9u9txy1BuAdCjrH
	PkXJUE4eiEXv8DF/hkN1CAesnovqMwMmKH2Tw/G0mpnAt6VffkdDlNiiCtUuIKCFNkwg2/tRfBV
	zRou/8G/GW8kAaim3Red3W9PSGloNuFmLFvxNUC7M01e2Pcm/OmiVLZesvEHCFh7T4RYObuqFzv
	9FMZ8GLhOLev8cqAunWB+rj6Atyyqtlb0GLpIGwboKAfH8KZ7AUwXWRcxXe8KBu59TaiEW5BgG2
	8v0e2Oo2LOijO9uRmK7BbbKoNC9s8+knDXOq9ApOKI1ck6FgHUHax3WQh7mKqi5jYDbfaart+VW
	Wy4gmkf61f+FMP83+jwggCQIbAgqetUUc5NmXs9zSKJOubn2ptW7mXnMF1S7baow==
X-Received: by 2002:a05:600c:8109:b0:49b:910c:7703 with SMTP id 5b1f17b1804b1-49b910c77a6mr21605835e9.9.1787845521714;
        Thu, 27 Aug 2026 08:45:21 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499dd56acedsm90464825e9.3.2026.08.27.08.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 08:45:20 -0700 (PDT)
Date: Thu, 27 Aug 2026 17:45:18 +0200
From: Petr Mladek <pmladek@suse.com>
To: sashiko-reviews@lists.linux.dev
Cc: Harry Hsu <x90613@gmail.com>, live-patching@vger.kernel.org,
	linux-kernel@vger.kernel.org, jikos@kernel.org, jpoimboe@kernel.org,
	mbenes@suse.cz, joe.lawrence@redhat.com
Subject: Re: [PATCH v2] livepatch: Reject livepatches with aliased old_func
Message-ID: <apBbjoEHJ98DWN_W@pathway.suse.cz>
References: <20260823060734.58443-1-x90613@gmail.com>
 <20260823062313.1321B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260823062313.1321B1F000E9@smtp.kernel.org>

On Sun 2026-08-23 06:23:12, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Initialization failures in klp_init_object_loaded() leave livepatch module relocations uncleared, leading to state corruption and permanently preventing target module loading.
> --
> 
> --- Patch [1]: [PATCH v2] livepatch: Reject livepatches with aliased old_func ---
> commit 230a471112d181b2e9810c9877ffebb05a42d61c
> Author: Harry Hsu <x90613@gmail.com>
> 
> livepatch: Reject livepatches with aliased old_func
> 
> This patch adds a check during livepatch initialization to reject
> configurations where multiple functions resolve to the same alias address.
> It prevents ambiguity when the redirection logic evaluates the func_stack
> in the ftrace handler.
> 
> Link: https://lore.kernel.org/all/20260812140232.48079-1-x90613@gmail.com/
> 
> > diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
> > index 28d15ba58a26d..c35cf08c27c86 100644
> > --- a/kernel/livepatch/core.c
> > +++ b/kernel/livepatch/core.c
> > @@ -866,7 +866,7 @@ static void klp_clear_object_relocs(struct klp_patch *patch,
> >  static int klp_init_object_loaded(struct klp_patch *patch,
> >  				  struct klp_object *obj)
> >  {
> > -	struct klp_func *func;
> > +	struct klp_func *func, *prev_func;
> >  	int ret;
> >  
> >  	if (klp_is_module(obj)) {
> [ ... ]
> > @@ -888,6 +888,21 @@ static int klp_init_object_loaded(struct klp_patch *patch,
> >  		if (ret)
> >  			return ret;
> >  
> > +		/*
> > +		 * Aliased symbols share one address, so they would resolve to
> > +		 * the same klp_ops and stack up on a single ops->func_stack,
> > +		 * leaving the redirection ambiguous.  Reject the livepatch.
> > +		 */
> > +		klp_for_each_func(obj, prev_func) {
> > +			if (prev_func == func)
> > +				break;
> > +			if (prev_func->old_func == func->old_func) {
> > +				pr_err("'%s' and '%s' resolve to the same address, aliased symbols are not supported\n",
> > +				       prev_func->old_name, func->old_name);
> > +				return -EINVAL;
> 
> [Severity: High]
> This is a pre-existing issue, but returning an error here leaves the
> module relocations applied earlier in this function uncleared.
> 
> When a module is loaded, klp_module_coming() iterates over patches and
> calls klp_init_object_loaded(). If initialization fails, it delegates
> cleanup to the error path:
> 
> kernel/livepatch/core.c:klp_module_coming() {
> 	...
> 	ret = klp_init_object_loaded(patch, obj);
> 	if (ret) {
> 		...
> 		goto err;
> 	}
> 	...
> err:
> 	...
> 	klp_cleanup_module_patches_limited(mod, patch);
> 	...
> }
> 
> However, the cleanup loop skips the failing patch entirely:
> 
> kernel/livepatch/core.c:klp_cleanup_module_patches_limited() {
> 	...
> 	klp_for_each_patch(patch) {
> 		if (patch == limit)
> 			break;
> 		...
> 		klp_clear_object_relocs(patch, obj);
> 	}
> }
> 
> Because it breaks when reaching the limit patch, klp_clear_object_relocs()
> is never called for the relocations that were successfully applied at the
> start of klp_init_object_loaded() via klp_apply_object_relocs().
> 
> Could this permanently corrupt the livepatch module's state and prevent
> the target module from safely loading again, since the relocations are
> never reverted?

This is a good catch. Functions called in klp_module_coming() are
supposed to revert their own changes on failure. Or
klp_module_coming() is supposed to call the counter-part
(pre/post scripts).

It seems to work, except for the changes done by
klp_init_object_loaded().

I think that it was not important in the original design.
The only important revert is the clearing of relocations
which was added later.

I am working on a patch which would fix it. I want to do it
the right way and call also klp_free_object_loaded() and
clearing obj->mod separately...

It is getting late here. I hope that I'll send it tomorrow...

Best Regards,
Petr
