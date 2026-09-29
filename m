Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4411249AA22
	for <live-patching@vger.kernel.org>; Tue, 29 Sep 2026 08:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790671477; cv=none; b=SEHfhbK+EWUThhB4dvVsBWCfbDD58w1h0g63AWJ3/doKwgOBs8DnXHpALQfkiyAM61QGXNugvlRY1ZFPxh0HuGkAoHBeMpi/xfNgypezDnd43+yzaqKfelcx6NzqsxfUKVIPxcfW2dal8vsGI7joQyB4eqFzJC5FO47wDt9bw40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790671477; c=relaxed/simple;
	bh=r1rmW3BGdxuAqDizQTvmX/aG/5tdKTFKtlQEpmki4Rk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jeRj8d4x1WHyIl59rAt+ItCcZ2D9hzDRHgc9H5E5KgQBaB24093SmTZ4S+oEil9DoUDCpkh2KTnAMdqvvxh1PFbuV0ZRrvMelODBCHxeTuLH3xJ8SPz6GHzhcbrDaOcY6W57u6tgaZ9Q/zcS7wZlwjn+Wd84kslbmrhkuNefPug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vt/BqqA7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HEgr2ZmH; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zZ9TG7re; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zFGhNWbx; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vt/BqqA7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HEgr2ZmH";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zZ9TG7re";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zFGhNWbx"
Received: from pobox.suse.cz (unknown [10.128.32.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1E71121BC7;
	Tue, 29 Sep 2026 08:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790671459; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0zBsGBgtLpZxg00hajyAlVW9wSjyH1HhiESiRGF8dm8=;
	b=vt/BqqA7pNduDonYfXs0GzDGUWl75YCkqYWMIeUkzIqlh562tsbNHZNu3w5yFWMZqNd6At
	ullbVQZ/jYM5QtB+Ti7X6gSvyP73KrykEaBB3GEonGnktu1flH+sAXolh0Jvo4LwqOGa7f
	iATsipnTNtQrU4CMlSFB6mpHt0HLG9U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790671459;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0zBsGBgtLpZxg00hajyAlVW9wSjyH1HhiESiRGF8dm8=;
	b=HEgr2ZmH/APPHYLHYS12KASTk8AtIuBxE/qTS3HIyxLpO2S8efoDtgj+cpYKbfU/UGjYkL
	vsYimH7vZAfssCDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790671455; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0zBsGBgtLpZxg00hajyAlVW9wSjyH1HhiESiRGF8dm8=;
	b=zZ9TG7relmWfHsQ3/cjB9Rqtczy3xhwJEN6kP3XBgW/JEJzjSWUAe8XEKeM5Ab7lCVIOlk
	EZm17XJO0vrbta0msmIgF5+VAJzboe0yKze1FWGxRutKDduxdIFoAHo34e02UpFXw7c/yc
	jKYZXb9WNx1kt5MX2ngtiFNh2EzFKcY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790671455;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0zBsGBgtLpZxg00hajyAlVW9wSjyH1HhiESiRGF8dm8=;
	b=zFGhNWbxeTDUBxcVO5Ft5QF2ZvNv4mG1BXTmg8hb+lt+B7nPBtPKTfIE0BBdXYOB5Rw25l
	nws0Q2PnlfJQGgCQ==
Date: Tue, 29 Sep 2026 10:44:15 +0200 (CEST)
From: Miroslav Benes <mbenes@suse.cz>
To: Yafang Shao <laoar.shao@gmail.com>
cc: jpoimboe@kernel.org, jikos@kernel.org, pmladek@suse.com, 
    joe.lawrence@redhat.com, song@kernel.org, live-patching@vger.kernel.org
Subject: Re: [PATCH v9 5/9] livepatch: Implement provides and obsoletes for
 scoped atomic replace
In-Reply-To: <CALOAHbAnQ-g_NSEWWj5dzpJsMuxibQ3ROqkrR1FeX1aPd=xEcw@mail.gmail.com>
Message-ID: <alpine.LSU.2.21.2609291043430.18161@pobox.suse.cz>
References: <20260913024228.72317-1-laoar.shao@gmail.com> <20260913024228.72317-6-laoar.shao@gmail.com> <179033754033.68715.11352947492609559639.b4-review@b4> <CALOAHbAnQ-g_NSEWWj5dzpJsMuxibQ3ROqkrR1FeX1aPd=xEcw@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ZERO(0.00)[0];
	FREEMAIL_TO(0.00)[gmail.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pobox.suse.cz:helo,pobox.suse.cz:mid]
X-Spam-Score: -1.80
X-Spam-Level: 
X-Spam-Flag: NO

> > > @@ -496,10 +496,10 @@ void klp_try_complete_transition(void)
> > >        * klp_complete_transition() but it is called also
> > >        * from klp_cancel_transition().
> > >        */
> > > -     if (!patch->enabled)
> > > -             klp_free_patch_async(patch);
> > > -     else if (patch->replace)
> > > +     if (patch->enabled)
> > >               klp_free_replaced_patches_async(patch);
> > > +     else
> > > +             klp_free_patch_async(patch);
> > >  }
> >
> > A total nit but just s/else if/else/ would also be fine here, no?
> 
> In v7, Petr suggested inverting the logic instead to improve readability [0].
> 
> [0]. https://lore.kernel.org/all/apfSMN5a9PTxTTsW@pathway.suse.cz/

Fair enough.

Miroslav
