Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CB43822A8
	for <live-patching@vger.kernel.org>; Fri, 19 Jun 2026 12:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781872101; cv=none; b=XW16fJEpekr7idILUnPnRbKxY4fqmb68R8L7tioG40I88ywogwnfnf1xzXkjWjAkTxeKzz00B08pTRMkXIkxaXYUB8bMcGn07s0foo+efZFj1/84M4M2M0aAmQkaiAsS9s4hN0ReTdWt6glD3ZqmKmijhLTZ4hTxe2EiSeWk5TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781872101; c=relaxed/simple;
	bh=GIQDBBY8DvStE84JLDMAK3eOrzMpQCDBiWKpNsLi6ZI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=lcn2G/e0Rja1vznAtK7DmNfLdV6UkECaqAHV0klZFkym7ViP15jkbJDk3Wl2Ua8UhnuKmqVbOP5meTXiffLVDuBXqpMhauY3x27kVLLhCIMOWkEuNwxLIya5csni2ReTPbSCmyNAAmLmRq6wO1x57yUawi3uoxaXvvMRFYyEPfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CmSQbsQJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dUS/9bTA; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CmSQbsQJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dUS/9bTA; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CmSQbsQJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dUS/9bTA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CmSQbsQJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dUS/9bTA"
Received: from pobox.suse.cz (unknown [10.128.32.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9C5E16B578;
	Fri, 19 Jun 2026 12:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1781872092; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0WJKXG6TA5qq0lZqdJMboiZKlhuHxls1iEfWFK1N2mg=;
	b=CmSQbsQJEubIVIHnP9IPgYGUEqljOepTmHYvtOSzuA7CgDhEWCpVwe8BoPG19qtrUBAYyh
	jPDJNOCpwFft5ReZSe+0EZQzFDy5+YIUQdCiomSvTptTwFgH0jSEWnx2RmzCGsbQD8ch5N
	KfJF5MCt38wtrfZs4Dw9OgW87QGAFBE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1781872092;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0WJKXG6TA5qq0lZqdJMboiZKlhuHxls1iEfWFK1N2mg=;
	b=dUS/9bTA+E0oy6DRiW2za/DmFwDPONXnjoaGgIsmCSyNBokos7POX/CT5vf7Bmgzntx/8U
	lncWhrFwSg4btUDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1781872092; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0WJKXG6TA5qq0lZqdJMboiZKlhuHxls1iEfWFK1N2mg=;
	b=CmSQbsQJEubIVIHnP9IPgYGUEqljOepTmHYvtOSzuA7CgDhEWCpVwe8BoPG19qtrUBAYyh
	jPDJNOCpwFft5ReZSe+0EZQzFDy5+YIUQdCiomSvTptTwFgH0jSEWnx2RmzCGsbQD8ch5N
	KfJF5MCt38wtrfZs4Dw9OgW87QGAFBE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1781872092;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0WJKXG6TA5qq0lZqdJMboiZKlhuHxls1iEfWFK1N2mg=;
	b=dUS/9bTA+E0oy6DRiW2za/DmFwDPONXnjoaGgIsmCSyNBokos7POX/CT5vf7Bmgzntx/8U
	lncWhrFwSg4btUDA==
Date: Fri, 19 Jun 2026 14:28:12 +0200 (CEST)
From: Miroslav Benes <mbenes@suse.cz>
To: Song Liu <song@kernel.org>
cc: Joe Lawrence <joe.lawrence@redhat.com>, live-patching@vger.kernel.org, 
    Josh Poimboeuf <jpoimboe@kernel.org>, Petr Mladek <pmladek@suse.com>
Subject: Re: [RFC 0/4] klp-build: simple OOT module support
In-Reply-To: <CAPhsuW6YGdh4xFcsfUiGtVzLg2nR_cEiQpvmyEN+Ffyf_O53LA@mail.gmail.com>
Message-ID: <alpine.LSU.2.21.2606191427090.26638@pobox.suse.cz>
References: <20260512221102.2720763-1-joe.lawrence@redhat.com> <CAPhsuW6YGdh4xFcsfUiGtVzLg2nR_cEiQpvmyEN+Ffyf_O53LA@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-2146828000-432254606-1781872092=:26638"
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	CTYPE_MIXED_BOGUS(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Spam-Level: 
X-Spam-Score: -3.30

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---2146828000-432254606-1781872092=:26638
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 12 May 2026, Song Liu wrote:

> Hi Joe,
> 
> On Tue, May 12, 2026 at 3:11 PM Joe Lawrence <joe.lawrence@redhat.com> wrote:
> >
> > This patchset introduces support for patching basic out-of-tree (OOT)
> > modules.  The primary motivation is to streamline testing for objtool klp
> > diff by providing a flexible and stable environment.
> 
> Thanks for this work!
> 
> I would like to add to the motivation here:
> 
> It is actually useful to livepatch OOT modules in production.
> When using kpatch-build, we (Meta) generally do not patch OOT
> modules. But there was one case where we had to do it, and it
> required quite some manual work.
> 
> If we can make building livepatch for OOT easy, we are likely to
> use it regularly in the future.

I know I am late, sorry about that, but I also think it is a nice feature 
to have. Testing would definitely benefit.

Miroslav
---2146828000-432254606-1781872092=:26638--
