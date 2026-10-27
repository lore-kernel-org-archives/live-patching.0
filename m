Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793109732;
	b=X7tjIR4menxo2MzJLoveNkpKNK1js92+csg4liVnhreiAf1yOhkQ6/2W0BmKG5q1fYGd
	 SxUNMUoiogGRG3A5+7eHpRJIbLqS6dQhS06UEVm5Pjm9q4tVd99i7BOc56zsJDN9KRI/m
	 VOZ5lIwXVxEuwxVWK/PaXSCa23Gui7M/OnuHS2k3icqxPpjtCDivsE153NDuTBHeLEhe4
	 SGv9bks4SfrahoXvHNahvSKpCieDkTTZ+zGUrECh/ZVDCalBaB7NtWzOd7krhPKKXtMMA
	 W8hI6bS7jZAkHrEPvhYTlES9s+YEO7FrKFsxx6FDV2gqVfL7gyG+EJMUCzfOsjH5rUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793109732;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:User-Agent:MIME-Version:Content-Type:X-Spam-Flag:
	 X-Spam-Level:X-Spamd-Result:X-Spam-Score;
	bh=vf4Ao8tnzx7MRA/wyLkcBxzQd6bdSmV+kWQgdB86Vec=;
	b=aeb18MvcWCyeWUecEpYpL7dGYuLkK4usOaXEofxBjuvkUQKsgAxFMNos0pRL8V/uTIgX
	 ICuQdc+L397QY6TA9EtBY9PiQLkhdafExO3Hmf1+d02RTon1d5C0wxJECSm/hB3rMAQ5F
	 x/5Tu002Gw07irWrEqU3DXFnDe7lJpewUn2BjOSa3GoQV08mvO1rTwJ2HNeW0XdkvZBUZ
	 LCpWx7UhnV6TWAtirBQN5XCe649AlQCJeBJAjH4/EMRcS+VsFohg/7sh0LAQShdF5TBX0
	 11VpRfuaP78ECinmZkMxJ573HHlcsLtgnfnmO1WXkOyHntkhEh9P/763kWwQptC4LCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=D0qD5mHd;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=cXJsDfAl;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=D0qD5mHd;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=cXJsDfAl;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54877606A31B;
	Tue, 27 Oct 2026 14:02:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54877606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=D0qD5mHd;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=cXJsDfAl;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=D0qD5mHd;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=cXJsDfAl
Received: from pobox.suse.cz (unknown [10.128.32.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 603D821EE4;
	Tue, 27 Oct 2026 14:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793109728; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vf4Ao8tnzx7MRA/wyLkcBxzQd6bdSmV+kWQgdB86Vec=;
	b=D0qD5mHd3eRsZRbNGpvxUBPECmeVWS2yGLxMJXd7iEA6o6rD0iw1w0qXpzlfJsov7Uz6c9
	6KFLEk9ZEpFMZM8cG+onwNXuM2jl/rSB7DnBjZaKRlCUPz4lwlKsE3AUUId4KYdvdD8v7i
	4qzORuddAsNA6Py/CAG8UTtVUg1ZIyw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793109728;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vf4Ao8tnzx7MRA/wyLkcBxzQd6bdSmV+kWQgdB86Vec=;
	b=cXJsDfAlMNGp5xm9URB0rO94no8sS1E8o7ne+6r71Inyab9o2iqUn9Ux3OJ/Yu3kUWBe3d
	r85z91iF1cfwoABA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793109728; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vf4Ao8tnzx7MRA/wyLkcBxzQd6bdSmV+kWQgdB86Vec=;
	b=D0qD5mHd3eRsZRbNGpvxUBPECmeVWS2yGLxMJXd7iEA6o6rD0iw1w0qXpzlfJsov7Uz6c9
	6KFLEk9ZEpFMZM8cG+onwNXuM2jl/rSB7DnBjZaKRlCUPz4lwlKsE3AUUId4KYdvdD8v7i
	4qzORuddAsNA6Py/CAG8UTtVUg1ZIyw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793109728;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vf4Ao8tnzx7MRA/wyLkcBxzQd6bdSmV+kWQgdB86Vec=;
	b=cXJsDfAlMNGp5xm9URB0rO94no8sS1E8o7ne+6r71Inyab9o2iqUn9Ux3OJ/Yu3kUWBe3d
	r85z91iF1cfwoABA==
Date: Tue, 27 Oct 2026 15:02:08 +0100 (CET)
From: Miroslav Benes <mbenes@suse.cz>
To: Petr Mladek <pmladek@suse.com>
cc: Harry Hsu <x90613@gmail.com>, jikos@kernel.org, joe.lawrence@redhat.com, 
    jpoimboe@kernel.org, linux-kernel@vger.kernel.org, 
    live-patching@vger.kernel.org, sashiko-reviews@lists.linux.dev, 
    shuah@kernel.org, song@kernel.org
Subject: Re: [PATCH v4 1/5] livepatch: Fail object initialization on duplicate
 patched function
In-Reply-To: <attsXfOPYrprACJw@pathway.suse.cz>
Message-ID: <alpine.LSU.2.21.2610271459550.28401@pobox.suse.cz>
References: <alpine.LSU.2.21.2609181452160.21788@pobox.suse.cz> <20261001043228.74946-1-x90613@gmail.com> <attsXfOPYrprACJw@pathway.suse.cz>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-13.30 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_ZERO(0.00)[0];
	RCPT_COUNT_SEVEN(0.00)[10];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,redhat.com,vger.kernel.org,lists.linux.dev];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[]
X-Spam-Score: -13.30

On Fri, 23 Oct 2026, Petr Mladek wrote:

> On Thu 2026-10-01 12:32:28, Harry Hsu wrote:
> > On Fri, 18 Sep 2026, Miroslav Benes wrote:
> > 
> > > Could we also check prev_func/func->nop in the check in
> > > klp_init_object_loaded() and have a pass if true?
> > 
> > Thanks for the suggestion.
> > 
> > Yes, I've updated the check to skip the pair when both klp_funcs are
> > nops. Two nops added by klp_add_nops() for replaced aliases are
> > interchangeable, so an atomic replace patch that inherits nops for
> > __do_sys_fork and __x64_sys_fork from two previous patches now loads
> > fine. A non-nop func colliding with a nop (or another non-nop func)
> > is still rejected, since the nop would land on top of the real
> > replacement on ops->func_stack and silently disable it.
> > 
> > The incremental change on top of v4 1/5 is:
> > 
> > --- a/kernel/livepatch/core.c
> > +++ b/kernel/livepatch/core.c
> > @@ -894,6 +894,8 @@ static int klp_init_object_loaded(struct klp_patch *patch,
> >  			if (prev_func == func)
> >  				break;
> >  			if (prev_func->old_func == func->old_func) {
> > +				if (prev_func->nop && func->nop)
> > +					continue;
> >  				pr_err("'%s' and '%s' resolve to the same address, aliased symbols are not supported\n",
> >  				       prev_func->old_name, func->old_name);
> >  				return -EINVAL;
> > 
> > If this direction looks good, I'll resend the series. Petr, should I
> > just bundle everything into a v5, or do you have changes on your side
> > that I should wait for?
> 
> I am afraid that this is still not enough.
> 
> Problem:
> 
> It would work when the livepatch gets applied the nops are removed.
> 
> But it might cause problems when the transition gets reverted
> in the middle. All processes should go back to use the previous
> implementations (original code or previous livepatch).
> But the ftrace handler would just go back from one nop to the other.

Hm, you are right. There will be two nop functions on the stack in this 
case and the redirection in the handler would not work.

> Solutions:
> 
> 1. A solution would be to create only one not in the first place.

Not a bad idea.

> 2. It seems that we are close to the scoped atomic replace feature.
>    It will prevent loading conflicting livepatches in parallel.
>    Well, it currently checks only the function names. We should
>    add another another check which would detect the conflict
>    also by the alias.

-ETOOMANYDEPENDENCIESBETWEENPATCHSETS. If the first solution is not 
difficult to implement, it might be better.

> PS: I am sorry for the late reply. This patchset is far from trivial
>     because it handles several levels of "what will happen if"
>     and makes my head spin. And it has lower priority because
>     it handles corner cases.
> 
>     Also I always forget all the details before I get an answer.
>     It seems that we are all in the same trap. ;-)

Yes, it took me a while to page it all in again :).

Miroslav
