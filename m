Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38C83CF200
	for <live-patching@vger.kernel.org>; Tue, 23 Jun 2026 09:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782207635; cv=none; b=r/yxqqgOR/9DmOZv5QhPxu/vFkfM+7q44+1J/6QAxi852ENAwuwZm0ZMacholK0Ut1Dgqn9vSGUFB1t8Q0J0hMuFLEnwHm08iUQZH4AV4f7kL49mLmBnUzqFtU9dgfs0jlaelJZs4N24kKG4dwjr7oPPkSKhP8WH3+5rFg9msVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782207635; c=relaxed/simple;
	bh=KksThkIBVVLL7OuZ/fgPGkbOgRhzunHE4Ux9LYzTkzU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=r4VNUqS9LPdnG+CFc2bvMRd69FvaPWccf+xFYcR63F06ZaVQMCi7fWaFfLvvWPNIdygq+0XrbEZ1m1vFUSUmICSutS2zppD0NfnQnmLT34VWZKQ9SRY0TjWyFW6j+VEZG4Vr532Ljaf+Mp5VOD9x4f6VynrSHmNZj2e5yAlsiKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hLfTuO5J; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CrUKKWNP; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hLfTuO5J; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CrUKKWNP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hLfTuO5J";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CrUKKWNP";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hLfTuO5J";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CrUKKWNP"
Received: from pobox.suse.cz (unknown [10.128.32.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 014A670D7A;
	Tue, 23 Jun 2026 09:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1782207632; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hw4c4qBz9azZDrI3wA5zCVI/syrxyyLU2z8HrJyOVII=;
	b=hLfTuO5Je/Rdhn5EJ52JiLA2zwHMo+azgwvW3cyqvFn3mP9DRGGWqM7njh6uqzs4PP2h1/
	d3f2gbDN+wLdx3PJ/Yx2fQRQkOVl+aE2+Eehs9ukCOhxoQDsLF2l/OHyphGxjdQypLwx3I
	Tx69vpQSLBtP9mGbMaejf/7ZwDjPbv0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1782207632;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hw4c4qBz9azZDrI3wA5zCVI/syrxyyLU2z8HrJyOVII=;
	b=CrUKKWNPyMMLIvfXGjFPkW3iriueh/sRtIn/zxhhxiMr28CnLYrgNAr1dfbLWYfhJgyr1R
	08K+6+9XNHzHa9Dw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1782207632; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hw4c4qBz9azZDrI3wA5zCVI/syrxyyLU2z8HrJyOVII=;
	b=hLfTuO5Je/Rdhn5EJ52JiLA2zwHMo+azgwvW3cyqvFn3mP9DRGGWqM7njh6uqzs4PP2h1/
	d3f2gbDN+wLdx3PJ/Yx2fQRQkOVl+aE2+Eehs9ukCOhxoQDsLF2l/OHyphGxjdQypLwx3I
	Tx69vpQSLBtP9mGbMaejf/7ZwDjPbv0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1782207632;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hw4c4qBz9azZDrI3wA5zCVI/syrxyyLU2z8HrJyOVII=;
	b=CrUKKWNPyMMLIvfXGjFPkW3iriueh/sRtIn/zxhhxiMr28CnLYrgNAr1dfbLWYfhJgyr1R
	08K+6+9XNHzHa9Dw==
Date: Tue, 23 Jun 2026 11:40:31 +0200 (CEST)
From: Miroslav Benes <mbenes@suse.cz>
To: Yafang Shao <laoar.shao@gmail.com>
cc: jpoimboe@kernel.org, jikos@kernel.org, pmladek@suse.com, 
    joe.lawrence@redhat.com, song@kernel.org, live-patching@vger.kernel.org
Subject: Re: [PATCH v3 3/7] livepatch: Support scoped atomic replace using
 replace_set
In-Reply-To: <20260607131659.29281-4-laoar.shao@gmail.com>
Message-ID: <alpine.LSU.2.21.2606231124200.1711@pobox.suse.cz>
References: <20260607131659.29281-1-laoar.shao@gmail.com> <20260607131659.29281-4-laoar.shao@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	FREEMAIL_TO(0.00)[gmail.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[]
X-Spam-Level: 

Hi,

On Sun, 7 Jun 2026, Yafang Shao wrote:

> Convert the replace attribute from a boolean to a u32 to function as a
> "replace set." A newly loaded livepatch will now atomically replace any
> existing patch belonging to the same set. There can only ever be one active
> livepatch for a given replace_set number.
> 
> This change currently supports function replacement only. Livepatches that
> belong to different replace sets cannot modify the same function. If a new
> livepatch attempts to modify a function already modified by an older
> livepatch from a different replace_set, the loading of the new livepatch
> will be refused.
> 
> Similarly, for the KLP state, livepatches belonging to different replace
> sets cannot use the same state ID. The system will refuse to load a new
> livepatch if it uses a state ID already in use by an older livepatch from
> a different replace_set.
> 
> For the KLP shadow variable mechanism, developers must assign unique shadow
> IDs to livepatches that belong to different replace sets.
> 
> Support for replace_set compatibility with KLP state and shadow variables
> will be implemented after Petr's KLP state transfer work is completed [0].
> 
> Other user-visible changes include:
> - The non-replace model is now deprecated
> - /sys/kernel/livepatch/livepatch_XXX/replace attribute is replaced by
>   /sys/kernel/livepatch/livepatch_XXX/replace_set

I will add my feedback here because the thread where it would belong to is 
more about details now. I am sorry that I got to it later than I wanted 
to.

What I like about the current state (non-replace and replace_all patches) 
is that it is simple when it comes to the code and it is agnostic to 
different use cases as we know them. Yes, it can lead to really 
problematic scenarios on users' side but the kernel code is 
relatively simple and flexible to allow that. As a distributor we chose 
something that suits our needs and what we think suits our customers as 
well. However, it is a downstream choice and implementation.

Now we learnt that some users would welcome a specific use case of keeping 
parallel live patches applied on their system and they lack the kernel 
support for that. That is ok and we should do something about that. There 
are two things which I am concerned about though.

1. I think that we should not leave our existing users (which we do not 
know much about) behind and regress. I mean we should still allow the same 
level of flexibility. If not possible, it should be seriously thought 
through. I am talking about non-replace patches here.

2. Slightly connected. We should not optimize too much for specific 
scenarios. It seems perfectly fine to introduce a specific feature which 
helps someone but I am concerned about restricting different use cases at 
the same time. The latest discussion next door dives into very specific 
scenarios and my question is "Do we really care?". The user (either a 
distributor or anyone else) can choose what they want to implement in the 
end (policy) and how to maintain it (a distributor will typically refuse 
to support a system with a user applied live patches not provided by the 
distributor).

I think that latest proposals in the other thread go in the right 
direction if I understand them correctly but I also think that we should 
keep the above in mind (or disagree with me please).

It might be difficult to keep the code simple and maintainable in the end 
and it certainly would not have benefits as the original replace_set 
proposal where it would all be very simple in the end (only one live patch 
per function allowed which might lead to substantial code simplification 
all around the stack).

Regards,
Miroslav
