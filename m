Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC0755293B
	for <live-patching@vger.kernel.org>; Wed,  9 Sep 2026 12:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788957137; cv=none; b=ZW8Pr1sG40pc5EhKzKk9l7mHIy896fY3HlM0JnVQPdpheyGkcalYA955reoLkADd/GOplzpwL22qTdwc7G2l4fhdjLLVuJpbcSDp/VOB3lpQnexhi4Qigizs7i10QU53oKoqI5MWhU/qSZtkXVkhPJ808i+P4AwcsPlUtxZ6zjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788957137; c=relaxed/simple;
	bh=kEHLN3SxNVbJlYznjW2P5RT3Cdy6unfbFuvHn38Upds=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=i0/gB7ze33Ks7vtPeWpN0NukJODsqaiq7XqqsWpS3+gIh8qsCcYxF2DROUdQKlmHkCiki2XXxZZHIDex+xyLesgU6DW/aio2nG0g4Cb/X3EkyQOGNrdqbrzhG8hROExQXc4G1owIQvNzADsAFgmPys68znP5nCitjZnayLFY7NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YO/JgPR1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5HQsvzGq; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ns0hAuFj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TikDKPai; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YO/JgPR1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5HQsvzGq";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ns0hAuFj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TikDKPai"
Received: from pobox.suse.cz (unknown [10.128.32.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 341F02193C;
	Wed,  9 Sep 2026 12:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1788957129; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ha9LLJuHIQjtS+3QwoANDmPwXPppOWITrUzxxHxGD8A=;
	b=YO/JgPR1QUGEu2K9MnlBf9bV9UPWCG8GUcp476PYPH7smW46Rz5Qilcoyd94rksGWV4lUY
	CfwnS5rtqMvf3phoUk7xbQIuSDX9WMATHrw7CIJACZ/pOMDUyGnB9oSm8RPZ3yxMheCI17
	iEwVdrz3ILAK/UJLXPUpMeuuVr7pxN8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1788957129;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ha9LLJuHIQjtS+3QwoANDmPwXPppOWITrUzxxHxGD8A=;
	b=5HQsvzGqRP6llxChhsqTi8u1CsnW5YbbSF04h4qniy8UY0gJ8g6tOH3I40MozRrJ3Q+Lpf
	38kg7fpRhju5azBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1788957125; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ha9LLJuHIQjtS+3QwoANDmPwXPppOWITrUzxxHxGD8A=;
	b=Ns0hAuFjg3s3vVNS1U/1H+/l/YyYUmaoXD7cZlWNgYCN0JjT5xJRWNCoHodp6LaWfyaMh7
	EIe0ftC2sDjfuvjEAgIRTr1b+a+0gbyqaMMb2kDxiHA7/bUEkPZy0Yfw3Fkv/lkLSp/uzo
	lyZsspXvmPT8ywRJYsAUqLNS8vuTDBI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1788957125;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ha9LLJuHIQjtS+3QwoANDmPwXPppOWITrUzxxHxGD8A=;
	b=TikDKPaimHsLN6I5ty6WEMZrRnstEFmpiXb+5jAYsc/uX9fpBD5GC30PsSaijS5tGkGAc8
	jktSJFBYrpZymIDw==
Date: Wed, 9 Sep 2026 14:32:05 +0200 (CEST)
From: Miroslav Benes <mbenes@suse.cz>
To: Petr Mladek <pmladek@suse.com>
cc: Yafang Shao <laoar.shao@gmail.com>, jpoimboe@kernel.org, jikos@kernel.org, 
    joe.lawrence@redhat.com, song@kernel.org, live-patching@vger.kernel.org
Subject: Re: Replace rules: was: Re: [PATCH v7 for-next 3/8] livepatch:
 Implement replace set for scoped atomic replace
In-Reply-To: <apk9f_LsGRYHzN0Z@pathway.suse.cz>
Message-ID: <alpine.LSU.2.21.2609091424420.10918@pobox.suse.cz>
References: <20260825114641.80452-1-laoar.shao@gmail.com> <20260825114641.80452-4-laoar.shao@gmail.com> <apfQ6c_3giN615Ll@pathway.suse.cz> <CALOAHbAb3Hiv5HZ0b0r_GjqCpZRx53Yq-NJo=eo7PxE_tD9asQ@mail.gmail.com> <apk9f_LsGRYHzN0Z@pathway.suse.cz>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spam-Score: -2.80
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_ZERO(0.00)[0];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[]

> > > But '0' is special. It obsoletes anything. Maybe, we could
> > > make it even more special and say that it can't obsoleted.
> > > Then we would be able to use it as the trailing element
> > > in the array...
> > >
> > > I do not have strong opinion about this. It is just an idea.
> > 
> > Making '0' special is good for backward compatibility, but it
> > complicates usage for users. Therefore, I prefer not to treat '0' as a
> > special case.
> 
> Ah, I have missed that the current code does not treat '0' special.
> I was confused by the following sentence in the commit message:
> 
> <paste>
>   By default (provides=0), any livepatch replaces any other livepatch.
> </paste>
> 
> and this paragraph in the documentation:
> 
> <paste>
>  It should be emphasized that the preferred and most secure way is to always use
>  the default ``provides = 0``. In this mode, any livepatch replaces any other
>  livepatch, preventing any unexpected interactions between incompatible
>  livepatches.
> </paste>
> 
> I understood it the way that ``provides = 0`` was supposed to be
> special and always replace all other livepatches.
> 
> I think that I was affected by Miroslav. I had an off-list discussion
> with him about this some time ago. My understanding is that Miroslav
> would prefer to somehow preserve the original ``replace = true``
> when the livepatch patch replaced anything.
> 
> It might be useful for OS providers who want to make sure that their
> kernel critical fixes can be installed on the user system. Otherwise,
> customers might complain that some update failed, ...
> 
> Of course, it has a drawback that any livepatch with ``prov ides= 0``
> would wipe any 3rd party livepatches, even when they are against 3rd
> party modules.

My intention was not to regress and disallow a use case which is currently 
supported. That is to replace everything applied no matter what.

If I take my SUSE hat on, I think we can happily live with provides being 
set to a random number and be done with it. A customer with their own live 
patches applied is on their own anyway so we can ignore it.

[ changing hats ]

So I only wanted to preserve the behaviour for a potential user out there 
relying on it. Maybe not worth it if it complicates the implementation. It 
can be emulated using provides/obsoletes and the fact that a 
user/admin/distributor should have their systems under control. If not, it 
can lead to weird states anyway (yes, I still think that allowing 
different parties to livepatch the same fleet is a call for trouble :)).

Miroslav
