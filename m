Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770CF47A88C
	for <live-patching@vger.kernel.org>; Thu, 20 Aug 2026 15:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787240448; cv=none; b=g6PhJMgvV+upVU91+jPrNe8SkM+pXaaEig1mStrGZgQ6rjRhJ1auiC8U+29UbZEVDxJv1cMeXpD7wXwItxteTlxl0yfTizQQpXw6TycW/pcbJBvtE4PVl5t23quoAMIGSZAgOt7i9wCeHcn9TLlKN8teTk1aCN3jKRbNP9cG148=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787240448; c=relaxed/simple;
	bh=77satGdBHO3pUnGsJidkcTGdDcXPWWvKWbTbUm0Btt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oAj9WmQmVTeghVfZm6F88rlPrHS6TeZGEWTVF6kHN6mJjvoYfXKsUd2NhPzMMEglMcAJCg/rZY0HaV9LfGN2GM6APl5JGIuJcwfglXmG0KX5Y9bYybZAJFuLffm0ZcK4Y0khVirP9VOxmfCZ01lIQghda7N2yT3cIEqp6OtaYIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OruaEB3q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OruaEB3q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CA401F00ACA;
	Thu, 20 Aug 2026 15:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787240443;
	bh=hdzghv+fdEYy7MCMZMweoIIEmbz1jStMGvvw61gjRaE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OruaEB3qTGMJZ2eG0AQqS7o0k5bM2AGjCyUIx+2TrQmU59WyTMSBMskIa3V2kdHBj
	 w+59genFJMymiPSwNFhxaQm2N76MBB185HkfjFjy8d+z2g6DKqKKs4QBORyrIHfuNH
	 zoWmbW1EAsEjrgNDbADsNP0u3iENt8/u0Q2vOWXOsUyvAW3cFSyWjN4Fg6pcZYW301
	 iIOcRBPRyI/2GaJBvDs+mR2lfE+61+1NJEby8gJuGEqiEITmdFiz1nqVKb5NWzesKX
	 eptrcrvzoIUhunSk1qR8LIE0mwZYUnb2B37QmtAAOHAQkkzMzx2ztzihXnxBXJ4tic
	 pr7BB4Mz9wyXA==
Date: Thu, 20 Aug 2026 08:40:40 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Petr Mladek <pmladek@suse.com>
Cc: jikos@kernel.org, mbenes@suse.cz, joe.lawrence@redhat.com, 
	song@kernel.org, live-patching@vger.kernel.org, 
	Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH v2 0/2] ivepatch: Fix several bugs found during replace
 set implementation
Message-ID: <aocdq0hr_iQTimG0@jpoimboe>
References: <20260816090442.18128-1-laoar.shao@gmail.com>
 <aoWEX89bxOpo4873@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aoWEX89bxOpo4873@pathway.suse.cz>

On Wed, Aug 19, 2026 at 12:24:31PM +0200, Petr Mladek wrote:
> On Sun 2026-08-16 17:04:40, Yafang Shao wrote:
> > These fixes were found while implementing the replace set series [0].
> > They are independent of that series and can be applied separately.
> > 
> > Link: https://lore.kernel.org/live-patching/20260809091954.22930-1-laoar.shao@gmail.com [0]
> > 
> > Changes:
> > v1->v2:
> > - minor improvements and acked-by (Song)
> > - fix issues reported by sashiko
> > 
> > v1: https://lore.kernel.org/live-patching/20260813030408.9761-1-laoar.shao@gmail.com/
> > 
> > Yafang Shao (2):
> >   livepatch: Fix wrong index in funcs cleanup error path
> 
> This patch is against scripts/livepatch/init.c which is part of
> klp-build framework. The klp-build-related changes usually
> go via the "tip" tree by Josh.
> 
> >   livepatch: Fix UAF of unregistered patch kobjects
> 
> This patch is against the kernel/livepatch/* code. These changes
> usually go via the "livepatching" tree by me.
> 
> Honestly, I am not sure how to handle this situation.
> Josh?

The scripts/livepatch changes have tended to be tied to objtool, which
is why they have gone through the tip tree.

I'm open to suggestions or ideas.  We could possibly rename or move that
scripts/livepatch directory (scripts/klp-build/?  tools/objtool/klp-build/?)
if that makes the boundary less confusing.

Or might there be some other maintainership model or way of splitting up
the files?

In any case, I'll go ahead and queue up patch 1 for tip for now.

-- 
Josh
