Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AF923C516
	for <live-patching@vger.kernel.org>; Thu, 25 Jun 2026 13:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782393892; cv=none; b=qDnmFXfJPvIv7mUlW4f3TB2xkYFI0VAIZXrV4BbGYecpjlqfmDXElSpgQ7dizWQ3iVRNtPUnFRkIkn+TGG8xkJMsd0L1ajhgKuzBVXEYDhHV26pdNvQZFgqw4M61uuIGZP5+2A7jmsYrTWH8nZNUsRl9NHeA3gFcEwCHsgdoTbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782393892; c=relaxed/simple;
	bh=amWgQvw+0BVxKx52smmHa9wvmijDbYfvt1ahB21BSYI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=E8n9hbp71bAr3GwXzHH1M1TF8gNxLK0EAL/2Z6vSCs0nZPgcuhynBGTT59/AGDUkBD1Dp/K36dPzPci8Tqv1ymg5CB1XBvboUf2bBO8i5/4PK6hy59Qr0MBna1WBuJTHfPWA87nQGPhKe4q/9VSoh0dTtFN2YawHHITTLQ8MdSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZaBrojtB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UoJFOJD/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZaBrojtB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UoJFOJD/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZaBrojtB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UoJFOJD/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZaBrojtB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UoJFOJD/"
Received: from pobox.suse.cz (unknown [10.128.32.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A07B471B44;
	Thu, 25 Jun 2026 13:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1782393889; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=adnXtSOsHeWirzFoFE30aG1r+y9bbJgtBJVZIShzLZk=;
	b=ZaBrojtBqBovyEdDJDQGepTgkC/peY4KZy5ojsxuXMhwUhtiAPI7pCywNJE5M2emrQ5t5W
	/AHTG1tkxOlu4Pwes+LZEh1rUiMCmVY6kne4DnRKgGYFj0PhNdlN/fxe/bZQvVXDz9PcR6
	YTPVn7M/eIgo7s7Q+KEdrl3/HOuuylQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1782393889;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=adnXtSOsHeWirzFoFE30aG1r+y9bbJgtBJVZIShzLZk=;
	b=UoJFOJD/5st4QPEZmMVyLmE6fJvpX5wCGZ8y05UIzkYQ+Hr0i1pkRJfbbqLJG4zRk0603k
	bvV0mLMraoSEWrBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1782393889; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=adnXtSOsHeWirzFoFE30aG1r+y9bbJgtBJVZIShzLZk=;
	b=ZaBrojtBqBovyEdDJDQGepTgkC/peY4KZy5ojsxuXMhwUhtiAPI7pCywNJE5M2emrQ5t5W
	/AHTG1tkxOlu4Pwes+LZEh1rUiMCmVY6kne4DnRKgGYFj0PhNdlN/fxe/bZQvVXDz9PcR6
	YTPVn7M/eIgo7s7Q+KEdrl3/HOuuylQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1782393889;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=adnXtSOsHeWirzFoFE30aG1r+y9bbJgtBJVZIShzLZk=;
	b=UoJFOJD/5st4QPEZmMVyLmE6fJvpX5wCGZ8y05UIzkYQ+Hr0i1pkRJfbbqLJG4zRk0603k
	bvV0mLMraoSEWrBw==
Date: Thu, 25 Jun 2026 15:24:49 +0200 (CEST)
From: Miroslav Benes <mbenes@suse.cz>
To: Yafang Shao <laoar.shao@gmail.com>
cc: jpoimboe@kernel.org, jikos@kernel.org, pmladek@suse.com, 
    joe.lawrence@redhat.com, song@kernel.org, live-patching@vger.kernel.org, 
    sashiko-bot <sashiko-bot@kernel.org>
Subject: Re: [PATCH] livepatch: Fix NULL pointer dereference in
 klp_find_func()
In-Reply-To: <20260623091638.76648-1-laoar.shao@gmail.com>
Message-ID: <alpine.LSU.2.21.2606251523310.18862@pobox.suse.cz>
References: <20260623091638.76648-1-laoar.shao@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Flag: NO
X-Spam-Score: -2.78
X-Spamd-Result: default: False [-2.78 / 50.00];
	BAYES_HAM(-2.98)[99.93%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.993];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_COUNT_ZERO(0.00)[0];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email]
X-Spam-Level: 

On Tue, 23 Jun 2026, Yafang Shao wrote:

> A NULL old_name in a newly loaded livepatch's function entry causes a
> NULL pointer dereference in strcmp():
> 
>   klp_init_patch()
>     klp_add_nops()
>       klp_find_func()
>         strcmp(old_func->old_name, func->old_name)
> 
> Add a sanity check at the beginning of klp_enable_patch() to reject
> patches with NULL old_name before they reach this code path.

The changelog could also mention the introduction of klp_check_patch().

Acked-by: Miroslav Benes <mbenes@suse.cz>

M
