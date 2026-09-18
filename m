Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F303B42E0;
	Fri, 18 Sep 2026 12:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789736052; cv=none; b=mAdZ7pFowGHXoOeYHLngRZWsrAKBRPyYX/ZrY5EVgHdY5GTlernw/tsv3mvTccPahDmGlvm5rGUUvP3nxBHVgzYjyyw853C8fbUpa2Nxvg2Dv/BHdalpif8NlYP2fBIPiADHJaTanAe5J5k0NlabanbjwIvSe89bULBoH1pTcFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789736052; c=relaxed/simple;
	bh=2iNBoZxSstrk0r9oQODWfc6wCfvzQI153E4ct4gGy3c=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=OTBbiaS6c23Dk8KQ3TfPvgCpRN3JXOok2aXa4RLKmogkBtcS0rgMilSisuMu3xiMgsu3ekEGJgW67c3ZJG4lj1EFWxbWFgmu3cNepbeEPsKADnZHBUWMZvUov92e6rSgyIS132N76dW2wXA5wSH4d1EDn6bDJbxa3xPSZfrg+Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Uhc8NhEo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qjmDHYnZ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HSdZuaf4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lcWbmhkY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Uhc8NhEo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qjmDHYnZ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HSdZuaf4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lcWbmhkY"
Received: from pobox.suse.cz (unknown [10.128.32.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 210E721DAC;
	Fri, 18 Sep 2026 12:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789736044; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lBBBWCqHsiNlUhjmYq/WLrwwKy4QikepSdDZAZ5FYWE=;
	b=Uhc8NhEo9yHWmXYQH7OPyVPZp2eAwQJmfdPh7QamrcDP1KS7L2A3sqMu7g5JV66aG0dSA+
	P5x51YICGkhkCQI+38+SmE88IxxUczGk6N7nUDBShig4kiDH3KdZxneckYIOo2ydrdpU0/
	kjaw3NILGcrLk69YdHv7KLztZDQdPR4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789736044;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lBBBWCqHsiNlUhjmYq/WLrwwKy4QikepSdDZAZ5FYWE=;
	b=qjmDHYnZjY5hxTMQigxWcbufakKNaslXXtfGKVefnNcosdCgAsoZrCiTF55gGeNlpvDSQQ
	DiFomEScvRROXvBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789736040; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lBBBWCqHsiNlUhjmYq/WLrwwKy4QikepSdDZAZ5FYWE=;
	b=HSdZuaf40j2m39W2xQR8dOdWUqbgXCUo7JO1DOEeLK+L0ymbJoc5n+O/8b1OfBG84W+3Y6
	EngDrOJt8YDCoDY63BRZdjIxUtE/vHTeNxa1e4HNCAfN3uv9FrYj4Bm9ozM2xptUTTV3BN
	DfdT3xt0R7peOulXgy1CfEoSNZVzU1Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789736040;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lBBBWCqHsiNlUhjmYq/WLrwwKy4QikepSdDZAZ5FYWE=;
	b=lcWbmhkYzV6dX3VO/ezupKZFQ9YxxYdpuYTU75Kbd80ZyjMsY2LuHFS+RRsl2wrsOEj/D1
	+3GQQf8oD1ZPkeBw==
Date: Fri, 18 Sep 2026 14:54:00 +0200 (CEST)
From: Miroslav Benes <mbenes@suse.cz>
To: Petr Mladek <pmladek@suse.com>
cc: sashiko-reviews@lists.linux.dev, Harry Hsu <x90613@gmail.com>, 
    joe.lawrence@redhat.com, jpoimboe@kernel.org, song@kernel.org, 
    shuah@kernel.org, live-patching@vger.kernel.org, jikos@kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/5] livepatch: Fail object initialization on duplicate
 patched function
In-Reply-To: <aqAHU9Qecqvl88VT@pathway>
Message-ID: <alpine.LSU.2.21.2609181452160.21788@pobox.suse.cz>
References: <20260908120325.299649-1-pmladek@suse.com> <20260908120325.299649-2-pmladek@suse.com> <20260908121744.81D641F00A3A@smtp.kernel.org> <aqAHU9Qecqvl88VT@pathway>
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
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[10];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ZERO(0.00)[0];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_CC(0.00)[lists.linux.dev,gmail.com,redhat.com,kernel.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pobox.suse.cz:helo,pobox.suse.cz:mid]
X-Spam-Flag: NO

On Tue, 8 Sep 2026, Petr Mladek wrote:

> On Tue 2026-09-08 12:17:44, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > - [High] Atomic replace patches will fail to load if previous patches targeted aliased functions.
> > --
> > 
> > commit e5553650270f93e11fe885d264a3829802223d3a
> > Author: Harry Hsu <x90613@gmail.com>
> > 
> > livepatch: Fail object initialization on duplicate patched function
> > 
> > This commit introduces a check to prevent patching multiple aliases of a
> > function within a single livepatch. It fails object initialization if aliases
> > resolving to the same address are detected.
> > 
> > > diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
> > > index a240d1144e89c..a6762cbe74b70 100644
> > > --- a/kernel/livepatch/core.c
> > > +++ b/kernel/livepatch/core.c
> > [ ... ]
> > > @@ -885,6 +885,21 @@ static int klp_init_object_loaded(struct klp_patch *patch,
> > >  		if (ret)
> > >  			return ret;
> > >  
> > > +		/*
> > > +		 * Aliased symbols share one address, so they would resolve to
> > > +		 * the same klp_ops and stack up on a single ops->func_stack,
> > > +		 * leaving the redirection ambiguous.
> > > +		 */
> > > +		klp_for_each_func(obj, prev_func) {
> > > +			if (prev_func == func)
> > > +				break;
> > > +			if (prev_func->old_func == func->old_func) {
> > > +				pr_err("'%s' and '%s' resolve to the same address, aliased symbols are not supported\n",
> > > +				       prev_func->old_name, func->old_name);
> > > +				return -EINVAL;
> > 
> > [Severity: High]
> > Will this check inadvertently reject nop functions generated by an atomic
> > replace patch when previous patches targeted aliased functions?
> > 
> > If previously loaded livepatches targeted aliased functions (for example, one
> > patch targets __do_sys_fork and another targets __x64_sys_fork), they were
> > permitted since they resided in different patches.
> > 
> > When an atomic replace patch is loaded, klp_add_nops() loops over all
> > previously patched functions and adds nops for them to the new patch. Since
> > nop deduplication is based on old_name, nops for both aliases are added.
> > 
> > Later, this check in klp_init_object_loaded() resolves their addresses and
> > finds duplicate old_func addresses. This causes the initialization to fail
> > with -EINVAL, which prevents the system from atomically replacing existing
> > livepatches and might force a reboot if the old patches cannot be safely
> > disabled manually.
> 
> Wow, this is a nice catch. I would say that it is a corner case but
> the problem seems to exist. Now, the question is how to deal with it.
> 
> I see three possibilities:
> 
> 1. We might detect the aliases in klp_find_func() and create only
>    one "nop" entry or do not create it all.
> 
> 2. The problem might be easier to solve after adding
>    the provides/obsoletes, aka replace set, feature [1].
>    It should prevent loading the other livepatch for the aliased
>    symbol in the 1st place.
> 
> 3. Just document the problem as a limitation. It might be hit only
>    when installing more liveapatches in parallel that current
>    wild way.
> 
> I personally prefer to wait for the provides/requires feature.

Perhaps.

Could we also check prev_func/func->nop in the check in 
klp_init_object_loaded() and have a pass if true?

Miroslav 
