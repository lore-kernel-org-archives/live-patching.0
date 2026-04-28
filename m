Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5A8346A08
	for <live-patching@vger.kernel.org>; Tue, 28 Apr 2026 06:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777358126; cv=none; b=WZD78VR98pkbBivB7ysDyg92IEAwFZ/PYrox3CuoiOLaIjR2LV4SDITnMTahGvyf+X5RKLhHuY0rtlp3+Djtb4zpUQaJKFwiEfMZLiCa3yZDktHONi+rKgreLWmXk4Bd9lywFmZnOeNnPbEPKPPYvCNF+cidLKY7GTqttco/oR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777358126; c=relaxed/simple;
	bh=/Qaq47g/1X/EE4NO6iUKVmBgfhEJTmL50wz4eIz0l6Y=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=lPoQ1atbHVGQNE0mVZr4WFIBDEMsgesle7I2zXHFnBemMraPtRkKzlYLOXLGxAv3RLMyzJr8l/UDchu9vTDTBjZk/e/k5hMHX6Ph353ec7AomcN1TUtOqA2+x8LkAuilIsNYN1DvWc+eqOwF43+3RR+cCHwIM1NhQD+bJJC+ovg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kkZTaNYW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=umrreBd5; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kkZTaNYW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=umrreBd5; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kkZTaNYW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="umrreBd5";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kkZTaNYW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="umrreBd5"
Received: from pobox.suse.cz (unknown [10.128.32.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 21C336A83D;
	Tue, 28 Apr 2026 06:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777358123; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OxzyTAdBevBlLi05wI+0I0z2/Qi5MxFC4A9Qg5iM2lM=;
	b=kkZTaNYW4U7G/jpFulV+bQdvrPMeTCEOKBT3TGWzcNRDqKNUNkyYdppmcYaGs0TqobAh/5
	JwtGkc+JMBKG2UFgQWAiqgh+POf1aqgwGiEgOkqKGqMLfUPRwpkKgwSqEMdqf1H1MQhvF0
	GYh0eLkoGXg5MGndZXgN3+99cxj3Ih4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777358123;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OxzyTAdBevBlLi05wI+0I0z2/Qi5MxFC4A9Qg5iM2lM=;
	b=umrreBd5M9m2dKazEzv4IqOOGDpdXEbAm95i+WY4FGcHQkLn+a9XBbH05Twt5MTCemQ7d7
	1DugAdaRqAzQorAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777358123; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OxzyTAdBevBlLi05wI+0I0z2/Qi5MxFC4A9Qg5iM2lM=;
	b=kkZTaNYW4U7G/jpFulV+bQdvrPMeTCEOKBT3TGWzcNRDqKNUNkyYdppmcYaGs0TqobAh/5
	JwtGkc+JMBKG2UFgQWAiqgh+POf1aqgwGiEgOkqKGqMLfUPRwpkKgwSqEMdqf1H1MQhvF0
	GYh0eLkoGXg5MGndZXgN3+99cxj3Ih4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777358123;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OxzyTAdBevBlLi05wI+0I0z2/Qi5MxFC4A9Qg5iM2lM=;
	b=umrreBd5M9m2dKazEzv4IqOOGDpdXEbAm95i+WY4FGcHQkLn+a9XBbH05Twt5MTCemQ7d7
	1DugAdaRqAzQorAw==
Date: Tue, 28 Apr 2026 08:35:23 +0200 (CEST)
From: Miroslav Benes <mbenes@suse.cz>
To: Josh Poimboeuf <jpoimboe@kernel.org>
cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
    live-patching@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
    Joe Lawrence <joe.lawrence@redhat.com>, Song Liu <song@kernel.org>, 
    Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH 03/48] objtool/klp: Don't correlate __ADDRESSABLE()
 symbols
In-Reply-To: <3ca4kejjaoy4kj4p2232xtb6rpgog5q7dm65ljq5tvqwp6liij@yfxb3womgfnv>
Message-ID: <alpine.LSU.2.21.2604280835070.12492@pobox.suse.cz>
References: <cover.1776916871.git.jpoimboe@kernel.org> <ea9af1b6136e9aa11589e592d0fc59e4ef414579.1776916871.git.jpoimboe@kernel.org> <177702262868.199199.17632749620515020845.b4-review@b4> <alpine.LSU.2.21.2604241133330.25696@pobox.suse.cz>
 <3ca4kejjaoy4kj4p2232xtb6rpgog5q7dm65ljq5tvqwp6liij@yfxb3womgfnv>
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
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	FROM_EQ_ENVFROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO

On Mon, 27 Apr 2026, Josh Poimboeuf wrote:

> On Fri, Apr 24, 2026 at 11:34:33AM +0200, Miroslav Benes wrote:
> > On Fri, 24 Apr 2026, Miroslav Benes wrote:
> > 
> > > On Wed, 22 Apr 2026 21:03:31 -0700, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> > > > Symbols created by __ADDRESSABLE() are only used to convince the
> > > > toolchain not to optimize out the referenced symbol.
> > > 
> > > Reviewed-by: Miroslav Benes <mbenes@suse.cz>
> > 
> > Looking at it again... wouldn't it be better to address this in 
> > is_special_section() which is looking at .discard.addressable already 
> > (only the outcome is different)?
> 
> No, I don't think so.  If .discard.addressable were classified as a
> "special" section then klp-diff would try to extract its entries into
> the livepatch module, which is completely unnecessary as these are
> throwaway symbols.

True. Thanks.

Miroslav
