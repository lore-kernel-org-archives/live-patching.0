Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461214E323C
	for <live-patching@vger.kernel.org>; Tue, 29 Sep 2026 10:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790676934; cv=none; b=hLLHLEVqYHMQX34+1Xdnv6hAQPlYLEuJcex7FQyvFJMoS+wzp+moeVJCvIvW8sOpKRipDZMphAKJ9fDUJRKY9Am7+fQKdjVX7iaeMQt6p/54+toMRLmql1Tv8O6cHig8rFx8R+KVZf2FEnpo9yfIMCzB48On5MdibS1tCpAasYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790676934; c=relaxed/simple;
	bh=bHoIWwqaSEmNuhq/7Su8GgJzy/1MjHgm8cw5oiDpfmg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=MsaD3itbxhZI5WLgCROZrrlZHZ5h+F9BzhkizDIOveYbZVK1vH9FdPLvSnV4O/AeTi2VPej2biY6kSq1Kr1BWORLM6riKQ+6VP/SYBQtlmYzF+bcSCiyjIOK+PLm6G/TCRltEjXe84P+FWgsZfd7A7/ezeeYP9U3/I8XRj1hsu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pQnlcMUp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BjNML6zk; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RGaDK7gl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9tMO1wf1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pQnlcMUp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BjNML6zk";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RGaDK7gl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9tMO1wf1"
Received: from pobox.suse.cz (unknown [10.128.32.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F024E21DAF;
	Tue, 29 Sep 2026 10:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790676914; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/UXEsjbEx1IkFlMtZBZqnGwHoR8kcWpb3mOgc9yrOok=;
	b=pQnlcMUp8+sjHGa6vSZ1ky/tfAIY7wy++J23WfyBvdQaK6NoxRQWrI+GANV1f+bCl3T2dS
	dCwFYKeU2oxds+voBBFX5y+E5vi28k+0VkqiWGgaHzIJskFmCxGjz8lMM846UcqvfVJAD3
	2wmjaukBWp0ChIPm+qEPdWsxicYda6U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790676914;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/UXEsjbEx1IkFlMtZBZqnGwHoR8kcWpb3mOgc9yrOok=;
	b=BjNML6zkFBwfVhWyLJuNSxXgvh33Z2Q/iUyRJe9awE1L47sZmZuaZfKXlBz0YPY7/as3Ls
	L5ZATa6WNZJjgaDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790676909; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/UXEsjbEx1IkFlMtZBZqnGwHoR8kcWpb3mOgc9yrOok=;
	b=RGaDK7gly+A2cE2WlNU5iadTvsP3bqAnhjnfJEYEP/rEX6NqUjMgMgFB7Eq0ZoQBMHOLQI
	y8JVD0jJsny/AhENT+XmMb8zYgm1zGcXnyBWweEGlzpWGlJw9ogH8ysH0tZkxk2InjVE76
	3tYMdJZudrHwhY/MuxCljbvE9FXjnQQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790676909;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/UXEsjbEx1IkFlMtZBZqnGwHoR8kcWpb3mOgc9yrOok=;
	b=9tMO1wf1zybzJDLYCDaZMB8zE7cFL9EpZqFLt1GTsk7qRjjqbnBBTPINvs47iOcFoRpMGD
	4w9W6r9dfGY/ruDw==
Date: Tue, 29 Sep 2026 12:15:10 +0200 (CEST)
From: Miroslav Benes <mbenes@suse.cz>
To: Petr Mladek <pmladek@suse.com>
cc: Matthias Goergens <matthias.goergens@gmail.com>, 
    Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
    Joe Lawrence <joe.lawrence@redhat.com>, live-patching@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: name the livepatching for-next branch
In-Reply-To: <art_zcXuSXahklz3@pathway.suse.cz>
Message-ID: <alpine.LSU.2.21.2609291211090.18161@pobox.suse.cz>
References: <20260926055219.3678061-1-matthias.goergens@gmail.com> <art_zcXuSXahklz3@pathway.suse.cz>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_ZERO(0.00)[0];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,redhat.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Spam-Score: -1.80
X-Spam-Level: 
X-Spam-Flag: NO

Hi,

On Tue, 29 Sep 2026, Petr Mladek wrote:

> On Sat 2026-09-26 13:52:19, Matthias Goergens wrote:
> > The T: entry for LIVE PATCHING names livepatching/livepatching without a
> > branch.  The repository's HEAD points to branch master, which mainline
> > already contains.  linux-next merges the for-next branch of this
> > repository (Next/Trees).  Name that branch in the entry.
> > 
> > Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
> > ---
> > This is part of a cleanup of all T: entries whose repository HEAD is
> > not where development happens: one patch per repository, sent in small
> > batches.  The plan is at [1], and why it goes out in batches at [2].
> > 
> > [1] https://lore.kernel.org/all/20260924033200.3615554-1-matthias.goergens@gmail.com/
> > [2] https://lore.kernel.org/all/20260924101844.2403008-1-matthias.goergens@gmail.com/

what is the main motivation then? The changelog talks about linux-next but 
that would not be a good reason in my opinion. T: has a link to the repo, 
not to some arbitrary branch.

The thread above mentions Sashiko. Is that the issue then? Yes, it is 
sometimes annoying that Sashiko bases reviews on our master branch and 
disregards patches in for-next branch, but as Petr explains below it is 
not a serious issue in our tree. There is usually not much happening.

> It seems that the motivation is that "master" is outdated in various
> projects.
> 
> But I maintain livepatching/livepatching.git the following way:
> 
>   + "master" branch points to the last merge commit in Linus tree.
> 
>   + "linux-next" is based on "master" plus there are merged the "for-X-Y/*"
>     development branches for the next merge window.
> 
> As a result, "master" and "linux-next" differ only by the few patches
> which are in the queue for the next release. I believe that most
> people actually sent patches based on the "master" branch because
> they work with the Linus tree.
> 
> Note that livepatching is a pretty slowly moving subsystem.
> 
> By other worse, I believe that "master" is more appropriate for
> livepatching.git.

Agreed.

If it becomes a problem, we should consider 
https://korg.docs.kernel.org/gitolite/index.html#symbolic-ref as mentioned 
in the linked thread above.

Or perhaps have a specific pointer for Sashiko in MAINTAINERS file but 
that would be more involved.

Miroslav
