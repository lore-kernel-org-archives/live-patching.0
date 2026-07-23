Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8963BE154
	for <live-patching@vger.kernel.org>; Thu, 23 Jul 2026 09:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784798734; cv=none; b=S71qBtG5S7FhzlmNcmw+rFxmkv682eQ+dRw/7Csio6kIm3LftGdMg7vxcHXaQVni53SpMbcXhW+epSfRkCm+5jm6TBRLzCN0sDHka6idjxK/9+NJPDOD4nd8ujg9mKuuI9kAQ/oCsUdeZjTTZT5vfD/HTRxDsWXjEx7yE+efMHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784798734; c=relaxed/simple;
	bh=Y1rhxqMPINo4Mp+TzcP1ApVCBEJHVxeylvzBt73UpQE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=LtVDpg5j6sYNpNC64/t49c1ESe0gnx3bPUYcWXQIUbGS/qZmKYriPcc7CBab5hsOlzkfkU1wYVM6qZPmfaxXLfKqZ7zvZf2w6VezQBpI091XUuSZKhI7Y+ZEaeh6hID5p0k+MfYdMKHrUWg5Y0ZGM0vEn0kqqWFW+zQh9dzpELQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=a1P3OWK5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ITB3d4SQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=a1P3OWK5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ITB3d4SQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="a1P3OWK5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ITB3d4SQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="a1P3OWK5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ITB3d4SQ"
Received: from pobox.suse.cz (unknown [10.128.32.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AD98A7AFD7;
	Thu, 23 Jul 2026 09:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1784798725; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=agYnmbZHoo3NkbJowVuMnHvtte67OKAH8RgoXBSjqW4=;
	b=a1P3OWK5yjkWliSSwV6cHtdhDU7FeWfbYfDsIkrtdUzvFNIwd+L8/TnbPpuZqEXGht3REd
	vu2p4OJUSFNxUewPXXkYZ0GFtkW3PjGNZwL3/kXb31LiICyrhN78n4cY/MWrK8SRxc3xtg
	BKIHcGEM7EeSGgzyjZK+0BiuO2aHIvQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1784798725;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=agYnmbZHoo3NkbJowVuMnHvtte67OKAH8RgoXBSjqW4=;
	b=ITB3d4SQgb5LxB6FXw6p1qgnIM4LcrJNsLhiQRS1xapg7c2mIABOJRN/efxanIjNJvobNL
	JGogDwKRlpIxE2Dg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1784798725; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=agYnmbZHoo3NkbJowVuMnHvtte67OKAH8RgoXBSjqW4=;
	b=a1P3OWK5yjkWliSSwV6cHtdhDU7FeWfbYfDsIkrtdUzvFNIwd+L8/TnbPpuZqEXGht3REd
	vu2p4OJUSFNxUewPXXkYZ0GFtkW3PjGNZwL3/kXb31LiICyrhN78n4cY/MWrK8SRxc3xtg
	BKIHcGEM7EeSGgzyjZK+0BiuO2aHIvQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1784798725;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=agYnmbZHoo3NkbJowVuMnHvtte67OKAH8RgoXBSjqW4=;
	b=ITB3d4SQgb5LxB6FXw6p1qgnIM4LcrJNsLhiQRS1xapg7c2mIABOJRN/efxanIjNJvobNL
	JGogDwKRlpIxE2Dg==
Date: Thu, 23 Jul 2026 11:25:25 +0200 (CEST)
From: Miroslav Benes <mbenes@suse.cz>
To: Joe Lawrence <joe.lawrence@redhat.com>
cc: live-patching@vger.kernel.org, Ben Procknow <bprockno@redhat.com>, 
    Jiri Kosina <jikos@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
    Petr Mladek <pmladek@suse.com>, Song Liu <song@kernel.org>
Subject: Re: [PATCH 0/1] Fix exported symbol klp-relocation bug
In-Reply-To: <20260713213128.3529250-1-joe.lawrence@redhat.com>
Message-ID: <alpine.LSU.2.21.2607231109210.6525@pobox.suse.cz>
References: <20260713213128.3529250-1-joe.lawrence@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.19)[-0.972];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_ZERO(0.00)[0];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pobox.suse.cz:mid,pobox.suse.cz:helo,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Score: -4.29
X-Spam-Level: 

Hi,

> Next: symbol namespaces
> =======================
> 
> Now a harder question, I think, about symbol namespaces.  In the past,
> kpatch-build had supported patching symbols in namespace where
> MODULE_IMPORT_NS() is allowed.  Looking at kvm :: mmu.c
> ::kvm_flush_remote_tlbs(), that is annotated with
> EXPORT_SYMBOL_FOR_KVM_INTERNAL() instead.
> 
> Should we make an effort to support klp-relocations / patching to this
> use-case?
> 
> If modpost were to let klp-relocation symbols through, I *think*
> (untested) that might be enough... but it seems like that may violate
> the spirit of what the namespacing effort is trying to achieve.
> 
> Note that klp-post-link converts these symbols to SHN_LIVEPATCH before
> the module is loaded, so the kernel module loader already skips them in
> simplify_symbols() (see SHN_LIVEPATCH case).  AFAICT, the namespace
> check in modpost is the only enforcement point, and it's checking a
> symbol that will never be resolved through the normal module loading
> path anyway.

I think we will see more and more EXPORT_SYMBOL_FOR_MODULES() in the 
kernel. kvm is probably by far the most interesting one for us as of now.

Tough. All changes in upstream so far, as I remember, around reducing the 
possibility to use internal symbols for OOT modules (like kallsyms API but 
there are probably more) have been done with KLP usage in mind. Or at 
least people tried. However, there is a limit to it. If we introduce a 
workaround in upstream for this, people will definitely use it to get 
around the enforcement in their OOT modules. We should avoid that in my 
opinion.

So I would keep whatever we come up with in downstream.

Reviewed-by: Miroslav Benes <mbenes@suse.cz> for the patch. Josh has 
already taken it so just for the record.

Miroslav
