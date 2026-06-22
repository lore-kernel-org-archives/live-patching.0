Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06893B0AE5
	for <live-patching@vger.kernel.org>; Mon, 22 Jun 2026 14:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782138080; cv=none; b=Ad5PhfKHqs5sR/O2bgl0e5hpt8LiFWhBTcnS4LvC5P3WYRCDUja540PBSwp/V2dUsjJj28iU69ew/RJi9AmyrrnNo9MowveJaKTUEVTtwFACLxqUJmLXhqMV5EIlFhcoT+xmQ+uR3ZLQes1Lx2ZYYwYsZ4IcOztTeGMKsiDgP3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782138080; c=relaxed/simple;
	bh=+N5Q3ZFto64Oq2qx8vr3M9NZyphgdteM7oMLgu+sg2w=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=Cz/j8Z5kjBeOl3sURkQIGmLdNYe/sWvoiX+8EMaRBwJwmLqwZBjU76vmobkO21HE6vmEB9HAgDIqS7N0xndemix+02GqtA7fO1gka8UgKBIvCzcqXnjjphLBvjbMHe00pc3+dvCdBqCyXhMiRewAuaV3Df9n9rBb/cElV5yVco8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sXOz9NLq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CnWgyk8f; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sXOz9NLq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CnWgyk8f; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sXOz9NLq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CnWgyk8f";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sXOz9NLq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CnWgyk8f"
Received: from localhost.localdomain (unknown [IPv6:2a07:de40:b2bf:1b::12ef])
	by smtp-out1.suse.de (Postfix) with ESMTP id A9D2270663;
	Mon, 22 Jun 2026 14:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1782138076; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PxYwLSrU2r6UyQeRMimoPgTihPglfymGXWzmBM0UafI=;
	b=sXOz9NLqOFtpqntFFcGDQFHNnee7kHoEqNIvKRyZHEtULSqTeIgt21MTJTyGghAYxUX/Ok
	eKQtvGGzwqLz3Fc+4H028Llh7bAHNDA46E7VsZsjYBIC1zCCEYwQa8M0xxk4FdW/a96AfQ
	ZMCiYmzYRvNIf8kSCTGcPf94TsWR9CU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1782138076;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PxYwLSrU2r6UyQeRMimoPgTihPglfymGXWzmBM0UafI=;
	b=CnWgyk8fqOGklcvyqAdzeUZwLE9ElFSXXqg8A2IqZKZMPrDpmDHMJclGTHnYV7/uhj/7+b
	Ia7dvmJurb1yZFDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=sXOz9NLq;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=CnWgyk8f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1782138076; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PxYwLSrU2r6UyQeRMimoPgTihPglfymGXWzmBM0UafI=;
	b=sXOz9NLqOFtpqntFFcGDQFHNnee7kHoEqNIvKRyZHEtULSqTeIgt21MTJTyGghAYxUX/Ok
	eKQtvGGzwqLz3Fc+4H028Llh7bAHNDA46E7VsZsjYBIC1zCCEYwQa8M0xxk4FdW/a96AfQ
	ZMCiYmzYRvNIf8kSCTGcPf94TsWR9CU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1782138076;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PxYwLSrU2r6UyQeRMimoPgTihPglfymGXWzmBM0UafI=;
	b=CnWgyk8fqOGklcvyqAdzeUZwLE9ElFSXXqg8A2IqZKZMPrDpmDHMJclGTHnYV7/uhj/7+b
	Ia7dvmJurb1yZFDA==
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 1/7] livepatch: Fix NULL pointer dereference in
 klp_find_func()
From: Miroslav Benes <mbenes@suse.cz>
To: Petr Mladek <pmladek@suse.com>
Cc: Yafang Shao <laoar.shao@gmail.com>, jpoimboe@kernel.org, 
 jikos@kernel.org, mbenes@suse.cz, joe.lawrence@redhat.com, song@kernel.org, 
 live-patching@vger.kernel.org, sashiko-bot <sashiko-bot@kernel.org>
In-Reply-To: <aigUttsudeR9ps0p@pathway.suse.cz>
References: <20260607131659.29281-1-laoar.shao@gmail.com>
 <20260607131659.29281-2-laoar.shao@gmail.com>
 <aigUttsudeR9ps0p@pathway.suse.cz>
Date: Mon, 22 Jun 2026 16:21:16 +0200
Message-Id: <178213807628.22518.1917005991720893454.b4-reply@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2637; i=mbenes@suse.cz;
 h=from:subject:message-id; bh=+N5Q3ZFto64Oq2qx8vr3M9NZyphgdteM7oMLgu+sg2w=;
 b=owGbwMvMwMHYWJt9x2W1tA7jabUkhixLlzsfn2y48eJGZPiXxuy7citbfr0+6NhelKZ0O8x69
 bH8v2ukOxn9WRgYORgsxRRZXu91ljOckmugWf3uLswgViaQKdIiDQxAwMLAl5uYV2qkY6Rnqm2o
 Zwhk6BgxcHEKwFT3aXEwNN843qG+XPPa23kuCxxUxR9vbP1t/SWKxeeNT5/l1GnS/zyn/Dy6ZK/
 Gj6qaNkOWyUUrrgrm7Jyeod31zz/NTepJVklRlp3dxVveWltmCB/8dnYi/8k3C8XV5T7sse5nfR
 ByX5iTTWh+aDf7AWtxQd+Tr77UfdGtiFOaaj658/EywdXq53VVepY5qZ7IUr/Lcj/DP7g/9RRHg
 NbKO9wa6WslnJze2diwxchM61lU/0h+57ILy7+uVlAK+tNxUtzlgbFIy6bsr9uqjkxmVjR1mLZG
 /dXt8JnPHK60bU5aGqemu7l4itDWNdL6C/8+6nq3YsbGHceLimMWfTtcy9uQ8HPVhvr2hWISjVv
 cwk0KAA==
X-Developer-Key: i=mbenes@suse.cz; a=openpgp;
 fpr=91BB0699882EF39D46654BB3FF98A38DA80834DA
X-Spamd-Bar: ++++++++++++++++++
X-Rspamd-Queue-Id: A9D2270663
X-Spam-Flag: YES
X-Spam-Score: 18.87
X-Spam-Level: ******************
X-Rspamd-Action: add header
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [18.87 / 50.00];
	SPAM_FLAG(5.00)[];
	NEURAL_SPAM_LONG(3.50)[1.000];
	HFILTER_HELO_5(3.00)[localhost.localdomain];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_SPAM_SHORT(2.98)[0.992];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	RDNS_NONE(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ONCE_RECEIVED(1.20)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	DIRECT_TO_MX(0.00)[b4 0.15.2];
	GREYLIST(0.00)[pass,meta];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b2bf:1b::12ef:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,suse.cz,redhat.com,vger.kernel.org];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,localhost.localdomain:helo]
X-Spam: Yes

On 2026-06-09 15:27:18+02:00, Petr Mladek wrote:
> On Sun 2026-06-07 21:16:53, Yafang Shao wrote:
> 
> > If a newly loaded livepatch provides a function entry with a NULL old_name,
> > func->old_name will be NULL when evaluated in strcmp():
> > 
> > klp_init_patch()
> >     klp_add_nops()
> >         klp_find_func()
> >             strcmp(old_func->old_name, func->old_name)
> > 
> > --- a/kernel/livepatch/core.c
> > +++ b/kernel/livepatch/core.c
> > @@ -92,7 +92,7 @@ static struct klp_func *klp_find_func(struct klp_object *obj,
> >  		 * Besides identical old_sympos, also consider old_sympos
> >  		 * of 0 and 1 are identical.
> >  		 */
> > -		if ((strcmp(old_func->old_name, func->old_name) == 0) &&
> > +		if ((func->old_name && strcmp(old_func->old_name, func->old_name) == 0) &&
> 
> I do not have a good feeling about this solution because it quietly
> ignores a problem. As a result, klp_add_object_nops() would
> call klp_alloc_func_nop() even though it does not make much sense.
> 
> A livepatch where any func->oldname is not defined should get
> rejected. It will actually happen but _later_ in:
> 
>   + klp_init_patch()
>     + klp_init_object()
>       + klp_init_func()
> 
> I see three better possibilities.
> 
> 1. We could move/add the sanity checks into klp_init_patch_early()
>    and return broken livepatches earlier.
> 
> 2. We could move/add the sanity check into a new klp_check_patch()
>    which will be called even before klp_init_patch_early().
> 
> 3. We could allow klp_find_func() to return ERR_PTR(-EINVAL).
>    klp_add_object_nops() should then return the error as well.

If you change it to do so.

> My preference:
> 
> I would do the 3rd variant because it is much easier than
> adding/moving all consistency checks between klp_init_*() and
> klp_init_*_early() or klp_check_*() functions.

Interesting issue. If I remember correctly, klp_init_*() path is meant
for the initial checking originally (among others). That is why
klp_init_func() has it right at the beginning. It got a lot complicated
later. We introduced atomic replace feature which added klp_add_nops()
and is called earlier. Then there was the kobject issue which introduced
early init path. Both forgot about the check and that is what we have
now. I would prefer it to fix cleanly. klp_init_patch_early() is not
enough because klp_is_patch_compatible() is called even earlier. So your
option 2 sounds best to me. On the other hand, it might be difficult to
disentangle it all.

Anyway, could you send the fix separately since it is an existing issue,
please?

