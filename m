Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DFF1DB95E
	for <live-patching@vger.kernel.org>; Mon, 12 Oct 2026 06:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791787609; cv=none; b=XIkcoIFDTLPvg0SLRD08mBwOFg9G8q8Q3i74YsS8rrFFFLJpNuXxkya8BoimBnk+t1BMzlrgXxc/fX2DUeIWuyENk5S//eHANOTl/0p7SLBHx89U+LBsLG4FoN6WkcSM/nvCUK1HNoBO6WABh2hZYU85BcXj5AT8nm66KMyDM00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791787609; c=relaxed/simple;
	bh=SbWZvZ6Aq73/GG9Aa9a1Ai9xALssZMKffG8SzMOqxXE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=r5p85Pp+2b3s9o4v1hzJIFya44wVn1cdDfyouIylV5XHEZh4k0eTjYAAWnSB21TL7vpuqxnROQvyg8Msj4i45q2Alc3Y5MGX7oU0ULPDhKDcLjR0qDwxYxg19KmWbQqWBiQ4diXVKhqN1aqQ8llEygtd5AvtcX8OyYJ3bHOrRNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2EH9aZ+G; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DYS0C4ii; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=3UP1Ixyw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BrT10HYJ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2EH9aZ+G";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DYS0C4ii";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3UP1Ixyw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BrT10HYJ"
Received: from pobox.suse.cz (unknown [10.128.32.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D29A321E6D;
	Mon, 12 Oct 2026 06:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1791787605; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uAusn+iItgi+5fTV7ozXmXzAMj7nWO6jvIZLaEHqvcg=;
	b=2EH9aZ+GSB4zCOAo066+dQbGOG6kGh1bbzVWUzcCfJFSP1sOpnF+38z0WFXk/0E1GdzfJV
	bqTlMDT0heZuuY1S+aPxn3hij9bjVnKoB7DtaPMokGRhxELKfq3CGdvW6oEXtWEn8jOwk2
	gM+MbCdsw9tULRjXp9qMwT6B1gfqXXQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1791787605;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uAusn+iItgi+5fTV7ozXmXzAMj7nWO6jvIZLaEHqvcg=;
	b=DYS0C4ii4o9rEfOd2l+NcgsyM0loi+VblfJj1tlJuLYuqxvuvtKEJ9B1aTSQMIbDc2jCye
	PIEgsswTqy+aNqBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1791787604; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uAusn+iItgi+5fTV7ozXmXzAMj7nWO6jvIZLaEHqvcg=;
	b=3UP1IxywRBiRYfqyUYby81bJ9TVEcB/kKj3XrPfgzmOCO3oG8J4Qypa+poyrNskPO8XPRr
	YBcsHuaW+L5mmgsrxIxa6BBexXILCpEA4hZ8T6QYa8t1HG/fqR29QhIHdJXDF6ZeJPuybO
	1iLdK9f1bM84fp6vQxYWm9EuO4fFPQk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1791787604;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uAusn+iItgi+5fTV7ozXmXzAMj7nWO6jvIZLaEHqvcg=;
	b=BrT10HYJik8jMEBJlS1LCUDJioMa+OaG35D0EwGKd8PhzyxlH1dEeuhSj0Y0Gx307iVGgT
	1KcBIpTDp8GvMzDA==
Date: Mon, 12 Oct 2026 08:46:44 +0200 (CEST)
From: Miroslav Benes <mbenes@suse.cz>
To: Jiri Kosina <jikos@kernel.org>
cc: Josh Poimboeuf <jpoimboe@kernel.org>, Petr Mladek <pmladek@suse.com>, 
    Joe Lawrence <joe.lawrence@redhat.com>, live-patching@vger.kernel.org
Subject: Re: [PATCH] livepatch: remove myself from MAINTAINERS
In-Reply-To: <6pq4rr41-0p23-2oq5-o750-0259410q9680@xreary.bet>
Message-ID: <alpine.LSU.2.21.2610120846240.27149@pobox.suse.cz>
References: <6pq4rr41-0p23-2oq5-o750-0259410q9680@xreary.bet>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email]
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spam-Flag: NO

On Thu, 8 Oct 2026, Jiri Kosina wrote:

> From: Jiri Kosina <jkosina@suse.com>
> 
> As discussed at LPC 2026 with Josh -- I am not an active kernel 
> livepatching maintainer any more, so let's properly reflect that.
> 
> Signed-off-by: Jiri Kosina <jkosina@suse.com>

Acked-by: Miroslav Benes <mbenes@suse.cz>

M
