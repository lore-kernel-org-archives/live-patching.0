Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878D1415B76;
	Mon, 24 Aug 2026 13:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787578985; cv=none; b=RPDKAux2KBIgkNwcgXYPrSQUIiN5VpkXwdnIqdIKe064PaFZ13c+spepr2xc6bpE3Jb9pFkqIcFGz4Jmu/TonXanfP8XXxXacXtXA7JX9/SJsDqf+LhdkJ++gdYZhxsFz+f1fuEETPRc4fVxFHr0NIzBteQWW1jqOcRoXGtuRUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787578985; c=relaxed/simple;
	bh=3p+RDdvnaOV/vZrxofFiBHBGTGlo2QfPgbG10ngxBPw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=bzZSUSJ/11HyVGRykz9t5akiWzDvtjOchVH3CIzMqLbV3WO7G+MAv/kiyrqWrbCy1PQRBINR9CHZyJ9Cofe0MCZhpATSP/pLIe3kmAGJB1lMqXJDUe9Uouwp86ATsadqOEd33lnRZPRyMv0hhWqrBBNFCqbyO1rRCqgdVhQGoTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NEa5r7zM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sZgBOkdc; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qXNVuLLO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OToq3iTy; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NEa5r7zM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sZgBOkdc";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qXNVuLLO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OToq3iTy"
Received: from pobox.suse.cz (unknown [10.128.32.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8BE2D86839;
	Mon, 24 Aug 2026 13:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1787578970; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jjD2WaxnIZgst0qthduQwob7wA45WSynlXzp8guhr0Y=;
	b=NEa5r7zM5h/bwA52xy3FSmKsXvQWbfkACFQGuZuHsZoeXZF/Lau4HjaGjBXRh/WjpztoYV
	jyrTv6Moim9xATs7IWs+ZoRzwn4cwIjZY/7zTkjV5YCDYd65gzz5VfkQV31Arn3uby87ad
	6sPOFTA+kIedNU/ILfGCFJamjofLjAM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1787578970;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jjD2WaxnIZgst0qthduQwob7wA45WSynlXzp8guhr0Y=;
	b=sZgBOkdctuxXr8V/bJlyd3hVh+F0n2L5pS8XLT3/JPfhlS+1h4CvMCRiT21EzNmkQH24YU
	DZp/6AiCi1LmNtDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1787578966; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jjD2WaxnIZgst0qthduQwob7wA45WSynlXzp8guhr0Y=;
	b=qXNVuLLOZmeo+ngWMFrFXD55RZ9nRnZLNyM6iTKiI2EwVxfA8jY9590UpeLrKn80OEmqnP
	zTNvbGmKf2HbjN5GL5T/9T5Flupn/p/mOJMfloe2FJwuO1QJE8hfO9ccuPRv3G75c6lOGi
	Ll9TjVYawIkHLmZpO+/cxmJ/XXPDoEE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1787578966;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jjD2WaxnIZgst0qthduQwob7wA45WSynlXzp8guhr0Y=;
	b=OToq3iTykBUsCM9tH1NBC7Tci+9s9mICB38GftcEO0pH6DYjfwLkd25m6d9Ps/lO5cz2y/
	Sq11rq9bqadp0bAA==
Date: Mon, 24 Aug 2026 15:42:46 +0200 (CEST)
From: Miroslav Benes <mbenes@suse.cz>
To: jpoimboe@kernel.org
cc: Shihao Ren <rsh15355756202@163.com>, pmladek@suse.com, jikos@kernel.org, 
    joe.lawrence@redhat.com, live-patching@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] livepatch/klp-build: Fix wrong index in error cleanup
 loop
In-Reply-To: <akYnGv_tDPouw8nM@pathway.suse.cz>
Message-ID: <alpine.LSU.2.21.2608241541220.17149@pobox.suse.cz>
References: <20260701060655.2343093-1-rsh15355756202@163.com> <akYnGv_tDPouw8nM@pathway.suse.cz>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -4.21
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.11)[-0.568];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[7];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ZERO(0.00)[0];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[163.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_CC(0.00)[163.com,suse.com,kernel.org,redhat.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pobox.suse.cz:helo,pobox.suse.cz:mid,suse.com:email]

On Thu, 2 Jul 2026, Petr Mladek wrote:

> On Wed 2026-07-01 14:06:55, Shihao Ren wrote:
> > In the funcs allocation failure path, the cleanup loop iterates with
> > 'j' but frees objs[i].funcs, which uses the outer loop index 'i'
> > instead of the loop variable 'j'. As a result the just-failed (NULL)
> > entry is freed repeatedly, while the funcs buffers already allocated
> > for objs[0..i-1] are leaked.
> > 
> > Use objs[j].funcs so the previously allocated entries are correctly
> > released.
> > 
> > Fixes: 59adee07b568 ("livepatch/klp-build: Add stub init code for livepatch modules")
> > Signed-off-by: Shihao Ren <rsh15355756202@163.com>
> 
> Great catch!
> 
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> 
> I assume that Josh would take this together with other klp-build
> related changes.

I do not see it merged yet. Josh, could you take it, please?

Miroslav
