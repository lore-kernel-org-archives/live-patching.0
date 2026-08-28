Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B739936B92B;
	Fri, 28 Aug 2026 07:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787901552; cv=none; b=Qs+l/g0+jaogD/UlIpSnNY47Th/3/ZnKiwnga9IeW00HvC8LbAN4geOtqOmMicwFS46PPny7P0RiTgZJNXo1jzKPjDCMoGnJ8VW0mcyFasN0lDCC7ZU1XCH4TCMummzkhSFgONFyBEBd9dkah8C+fLwMhYQP5ktdWSdBjka3K6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787901552; c=relaxed/simple;
	bh=8pndCdjaKt6BV5pfJqLH5SkPOKsIAkONdpuGZn/WUyI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=occT8BbEXv6iOAbycBv9vCTTzsIhoHOBJPcrk4U/8jIrRsQpXSYYn5tE0YlafL0CRF4oI3dIMQQOd8OX9jDlW26z+33cg0nWyoj/y03EcRq3+2+6ZvrT6v0sEhpiu1WHlBcHDWG0rxCvjIUdd+tGIfO00azxS9SQoCrgTypI++U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lefVpXlM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VVBRUhOk; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=klvcUcv7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OZ3S28S9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lefVpXlM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VVBRUhOk";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="klvcUcv7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OZ3S28S9"
Received: from pobox.suse.cz (unknown [10.128.32.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6C19721D94;
	Fri, 28 Aug 2026 07:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1787901544; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VubAx1HgGVT9m4YDkA8KqR6kOjmkNBnfJYa3rtf5zHM=;
	b=lefVpXlMFdK2oqy9JnsFgJRnhOOBcXOILmvzZXknmiSrnAcrvtE5+pZqoh5ESyAW8I+K6W
	Qoh8PQTkS8d1BqvW8708kHWy0W+j0wBzrRhCVlRO92XI7MK6qEXuDNENOcyYN02VHSvwYu
	xFESmqMOnxAmYxVkNL2DEifnmXR18xo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1787901544;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VubAx1HgGVT9m4YDkA8KqR6kOjmkNBnfJYa3rtf5zHM=;
	b=VVBRUhOkTvUvgIouIjYIV32U9rwlB1gcnyRN9/7bCqgOsFKlUsuhQErB3Dqv8SAavx4jvv
	eAfnHJTJ3dr+TrAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1787901540; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VubAx1HgGVT9m4YDkA8KqR6kOjmkNBnfJYa3rtf5zHM=;
	b=klvcUcv7OW5AHhPc2xUyxtJZUbswpVkBwHhv6fvwuS6moFgMNFvrpx/nX3ML9pSRbWEeXT
	vBFsmdSJhSjNDvEau5RlqbkqsP/FH1IixzLIoIZo2jk2SMUUWefC+HaF5613Mb2L/j6RYT
	IGiymsO/g2cEWCbdC5O0YODAY7LAJ/I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1787901540;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VubAx1HgGVT9m4YDkA8KqR6kOjmkNBnfJYa3rtf5zHM=;
	b=OZ3S28S94A2TLm17/KvMSPUgIj8d/OAH4U2An/unPzj78cD+RZGiybB14iE3dvJWvhogME
	ywL2dKZpDTAWMlAQ==
Date: Fri, 28 Aug 2026 09:19:00 +0200 (CEST)
From: Miroslav Benes <mbenes@suse.cz>
To: Josh Poimboeuf <jpoimboe@kernel.org>
cc: Shihao Ren <rsh15355756202@163.com>, pmladek@suse.com, jikos@kernel.org, 
    joe.lawrence@redhat.com, live-patching@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] livepatch/klp-build: Fix wrong index in error cleanup
 loop
In-Reply-To: <apC-XG-jCLJHvcil@jpoimboe>
Message-ID: <alpine.LSU.2.21.2608280918230.9476@pobox.suse.cz>
References: <20260701060655.2343093-1-rsh15355756202@163.com> <akYnGv_tDPouw8nM@pathway.suse.cz> <alpine.LSU.2.21.2608241541220.17149@pobox.suse.cz> <apC-XG-jCLJHvcil@jpoimboe>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spam-Score: -4.30
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]

On Thu, 27 Aug 2026, Josh Poimboeuf wrote:

> On Mon, Aug 24, 2026 at 03:42:46PM +0200, Miroslav Benes wrote:
> > On Thu, 2 Jul 2026, Petr Mladek wrote:
> > 
> > > On Wed 2026-07-01 14:06:55, Shihao Ren wrote:
> > > > In the funcs allocation failure path, the cleanup loop iterates with
> > > > 'j' but frees objs[i].funcs, which uses the outer loop index 'i'
> > > > instead of the loop variable 'j'. As a result the just-failed (NULL)
> > > > entry is freed repeatedly, while the funcs buffers already allocated
> > > > for objs[0..i-1] are leaked.
> > > > 
> > > > Use objs[j].funcs so the previously allocated entries are correctly
> > > > released.
> > > > 
> > > > Fixes: 59adee07b568 ("livepatch/klp-build: Add stub init code for livepatch modules")
> > > > Signed-off-by: Shihao Ren <rsh15355756202@163.com>
> > > 
> > > Great catch!
> > > 
> > > Reviewed-by: Petr Mladek <pmladek@suse.com>
> > > 
> > > I assume that Josh would take this together with other klp-build
> > > related changes.
> > 
> > I do not see it merged yet. Josh, could you take it, please?
> 
> Sorry, I missed seeing this one, but I do have an identical patch
> already queued:
> 
>   https://lore.kernel.org/aocdq0hr_iQTimG0@jpoimboe

Ok, thanks. I did not get that far in my INBOX after holiday yet :/

Miroslav
