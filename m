Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794835125;
	b=3hUuaWu4QCWxp1WKxjxnFM319zYOzzlHCVBL0doDsgBZGCNCd5ErXkN//5kQ9NzIXsls
	 0mb6MFYZ4BFhNHGnToWER7stM46UuAuXQxFnjXbFT3qm1lAYm/v9t/Fsn3nqgUA9eJxpQ
	 uDd2VBufD1iPHn4n06dbEKp0IRxYwkdql/2cU/WYY6/X51is45JpsokIrZgsh/OzcRToC
	 XHpt2x62OzgnyKlBTlGFYRWjqEQ2AK8fFpMFgVio91Jcqh30jJKxsUYcA9QRQ7CpfLOqB
	 nTwWlJQoL5T0+5S6TrfCOVGuzAGlX3dq0h3lR5nPdCLIKqy/Ngbfl3hjlKkkdJ86DBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794835125;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:User-Agent:MIME-Version:Content-Type:X-Spamd-Result:
	 X-Spam-Score:X-Spam-Level:X-Spam-Flag;
	bh=XITG7m3rbPra3sXs5zKucRYsnoiuwa05zb/n9aPPhos=;
	b=kw+bQt+z+MrUnbrBYxXCZy06SuKVQQy/O0P4KXBzAn5gBWqUm2LkgicC73k7xtzEckH9
	 fA8FtKYyetDjSDDVQDgQ2GUaRal04rOzjfz1nQaOgb7Lqe3eCBFRETLSFqoO1EthO6lk2
	 nhQ4Cn5yvY5q1+et/4VKMbxIaAPcUMrzcYvfFWjAilBiZkoJ+SI5eDJB4/a7l+TQfeGRj
	 WvyjapmMkHyK3kE053tWcfSuj0TWn1mbskqg8CmxAJuh8o0xzQvDgh4fDKyd0rmEYbq4a
	 UG0I0AzqroR2z0wQGWrQbgxK55ctbutuAEWI/E65mSEIIBC5noUfdfGsNhPh6J2Qw7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=tkZ3EQOi;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=322PO45e;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=DbISCXfR;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=SBzbL3vA;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C144606A895
	for <live-patching@vger.kernel.org>; Mon, 16 Nov 2026 13:18:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C144606A895
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=tkZ3EQOi;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=322PO45e;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=DbISCXfR;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=SBzbL3vA
Received: from pobox.suse.cz (unknown [10.128.32.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B7C41221AC;
	Mon, 16 Nov 2026 13:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794835123; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XITG7m3rbPra3sXs5zKucRYsnoiuwa05zb/n9aPPhos=;
	b=tkZ3EQOiOOnhXhNPIIBznp6CD3WCrLLm19j3nyAmuPi4HidXK4Tha1T0iH0iPN/OxoYxyv
	QN6pYAsHakWMuQgF1ZHS6Iwce5DYtPYOClpHhsQ2u89BoNzSHosSFSqaX9NqE19PU9K5o7
	D3+pIEchbB6o25h9zQzeePUtFQ09WTo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794835123;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XITG7m3rbPra3sXs5zKucRYsnoiuwa05zb/n9aPPhos=;
	b=322PO45eF0eM/Cez6FybRUitvFjZoAenbbLr889PJmhvbqoEoImm3LEuwZ1uo/YHr1lS+F
	QH2+aRXyNLyFWLBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794835121; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XITG7m3rbPra3sXs5zKucRYsnoiuwa05zb/n9aPPhos=;
	b=DbISCXfRV1Dl7JARrR/a8/WxB9fzlQV+SxSYIbQF5nJ4I0BgxQKksQpYF/ZYMMbjmZKvw+
	rYGxs/d/fz9eHIYrBGRH6F15RX3jVKWQ4p5TF7c1UlfYJ9B8tIyXrbsZ2RoxsLkdy6TUaa
	Mp7savoS2dBuEL6Pxi47A5dAu1YHIZc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794835121;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XITG7m3rbPra3sXs5zKucRYsnoiuwa05zb/n9aPPhos=;
	b=SBzbL3vAFljhC7+0ptEe/3xz/69gLSH7Phu/FfAu1O+ScUDV5OWDjjy2izKfHv/ax0TMnG
	DjEUfiPu5ZZt32DA==
Date: Mon, 16 Nov 2026 14:18:42 +0100 (CET)
From: Miroslav Benes <mbenes@suse.cz>
To: Yafang Shao <laoar.shao@gmail.com>
cc: jpoimboe@kernel.org, pmladek@suse.com, joe.lawrence@redhat.com, 
    song@kernel.org, live-patching@vger.kernel.org
Subject: Re: [PATCH 0/2] livepatch: reject internal flags set by a patch
In-Reply-To: <20261116130402.76743-1-laoar.shao@gmail.com>
Message-ID: <alpine.LSU.2.21.2611161415040.24417@pobox.suse.cz>
References: <20261116130402.76743-1-laoar.shao@gmail.com>
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
X-Spamd-Result: default: False [-11.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TAGGED_RCPT(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pobox.suse.cz:helo]
X-Spam-Score: -11.80
X-Spam-Level: 
X-Spam-Flag: NO

Hi,

On Mon, 16 Nov 2026, Yafang Shao wrote:

> While upgrading an atomic-replace livepatch, an application in a k8s
> environment reported high latency spikes.  While writing a reproducer
> for it on a test server, I unintentionally set the .nop flag for a
> function in the patch, which triggered the issue described in #1. I then
> checked for other similar issues and found the one in #2.

a nice example of shooting oneself in the foot... is it really worth 
fixing this? If yes, I would rather vote for silently setting both 
obj->dynamic and func->nop to false somewhere in klp_init_*_early() path.

Btw I do not think you need to add the splat and the live patch source 
code to the changelog. A simple description would be enough.

Miroslav
