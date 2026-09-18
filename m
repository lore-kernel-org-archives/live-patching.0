Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6CF2F8E8F;
	Fri, 18 Sep 2026 14:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789740011; cv=none; b=rLDzhb6UT+VtIDMuUSxelmPeyc5uvYc+6wObMjFhA2kKlOKf5541/2P8uNZhoIUy9IFEuHQxjqk1me41C7y5rY8h3G0PPVlzwFHMKRdGSgVsI2SLq7VJ+KE0G06RRDzMbx486sAPb4dFjxNXQ8P0b/5KdpU8FSi+Ty3i1K5Fnr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789740011; c=relaxed/simple;
	bh=aqk3YDav5HeVMJ7+xgtZM5u6LmvWWQ0vJsl4wF9s+3k=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=E6IYnuqcGD7izLUvOTQS5mAOnzq0+Z6PTSjKOsUPLIfgOV7lQlRqWcJINj/GPPnPcneYKuUm600MverGWrH1xN/DrJlP0R1meg8+New4095bacdo/Jh2ObF1Q5ikXiFQ+opmjcYuNSXR7c/3oT2Vs+M0QhDmWX5SlF073jWnQo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PJbK7Se7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YiRYuoyD; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AXNhIH2j; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4zOi11F3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PJbK7Se7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YiRYuoyD";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AXNhIH2j";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4zOi11F3"
Received: from pobox.suse.cz (unknown [10.128.32.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 979BB21BE3;
	Fri, 18 Sep 2026 13:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789740003; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mi82+M1qUm63Q0/vdTyfceM6gBya9b/S9+dPgyBxeFU=;
	b=PJbK7Se7sz1gXTteTXJh6+msLaIxf0a5r+iKGHZIANc/wPJTO66buWLgOmQ87OnFDQYTAl
	hQn4HDyTO+ke3Tf5l5RF3Zfsx75o5VEerLPT86dRgoZEZnHoIVBGCELznrpQYAfJxmEW1T
	ww8+sPBIlJvYSIK//8EZuMyxZ3tHZsU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789740003;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mi82+M1qUm63Q0/vdTyfceM6gBya9b/S9+dPgyBxeFU=;
	b=YiRYuoyDhqlECamq0NRmUcZj466weD3clbUWSSsyJNG6pfRwx/0i0O8wgm8LzzH6xcyAB1
	CaepSWpEzsdpbZCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789739999; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mi82+M1qUm63Q0/vdTyfceM6gBya9b/S9+dPgyBxeFU=;
	b=AXNhIH2jldAvDDDG+JkVfwc6vLnSxgb8LauI0nm+0OCm+UFSLwlYGY0+9NuR1ZLEfyusrF
	ux+2ReyxE7Jh3SrCWdWo2PI/VNfVcNyQ3ce+6ebPRKKAVRoIWOZfkNM0g4YpsMaot44rzw
	I4Jlnx2MyB0D5Kd11ot66zhzwTs+XI4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789739999;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mi82+M1qUm63Q0/vdTyfceM6gBya9b/S9+dPgyBxeFU=;
	b=4zOi11F307FphON0d95nHmKAmKrwdrvjvI3Yn4G+byNLUl8eutjQu+TKzC9tSsxNfdPm0+
	5C0+qF9GZClzhYBw==
Date: Fri, 18 Sep 2026 15:59:59 +0200 (CEST)
From: Miroslav Benes <mbenes@suse.cz>
To: Petr Mladek <pmladek@suse.com>
cc: Harry Hsu <x90613@gmail.com>, jpoimboe@kernel.org, joe.lawrence@redhat.com, 
    jikos@kernel.org, live-patching@vger.kernel.org, shuah@kernel.org, 
    song@kernel.org, linux-kernel@vger.kernel.org, sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/5] livepatch: Clear relocations when klp_apply_object_relocs()
 fails
In-Reply-To: <20260908120325.299649-5-pmladek@suse.com>
Message-ID: <alpine.LSU.2.21.2609181554590.21788@pobox.suse.cz>
References: <20260908120325.299649-1-pmladek@suse.com> <20260908120325.299649-5-pmladek@suse.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO

On Tue, 8 Sep 2026, Petr Mladek wrote:

> When a module is loaded, klp_module_coming() updates all enabled
> livepatches. If an error occurs, it delegates cleanup to
> klp_cleanup_module_patches_limited(). However, this cleanup loop skips
> the partially updated patch, leaving any changes made prior to failure
> unreverted.
> 
> One unhandled failure path occurs inside klp_apply_object_relocs(). On
> architectures like x86_64, apply_relocate_add() performs a verification
> step using memcmp() to check that memory contains the expected relocated
> or zeroed value. If relocations left behind by a failed patch are not
> cleared, subsequent patch operations or reloads can fail this validation.
> 
> Introduce klp_write_object_relocs_limited() to unwind and clear only the
> relocations that were successfully applied before klp_write_object_relocs()
> encountered an error.
> 
> There is no need to clear relocations for other objects in the failing
> patch because klp_module_coming() operates strictly on the specific
> module being loaded.

Hm, I spent some quite time on that and I am not sure if I deciphered 
everything correctly.

It seems to me that all error handling in those paths you are mentioning 
above is correct and the only problematic thing is that 
klp_apply_object_relocs() in klp_init_object_loaded() returns ret 
immediately which leaves partially applied relocations in case of an 
error. Following calls in klp_init_object_loaded() go through err: label 
where klp_free_object_loaded() is called which should be fine.

Is it correct?

Wouldn't be better to be somehow consistent and clean up right in the 
error path of klp_apply_object_relocs() call in klp_init_object_loaded() 
similarly to what is already there. After all we want to clean the object.

But I also see why you want to do it this way. It only seems more fragile 
to me.

Miroslav
