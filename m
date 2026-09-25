Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC13949E141
	for <live-patching@vger.kernel.org>; Fri, 25 Sep 2026 13:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790341219; cv=none; b=KVv903b2r/hhCysrAoPU/8O1gyhU4vGSPuBhIw6fsJDS789TvDOE5/a2VR3DHmaM6GAOwoq8Kuob8Mk863xs3zN0xp0UNd/xEfqrntR/z4zZawhwC+XtxXUCuNJG3aMs3wGIAeCcsG52ZRBbOnVXgIOxSNY4nzQlBpMu+DgjMMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790341219; c=relaxed/simple;
	bh=riSKendPTLFUtYkPb0IJs+bTjGIeuVTR+JmIMuRBOnU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=UU1e2NR0xAyIZfjA/zhjRHKKQkhLb0KGZRxZBp+ahGSbxQ5TovLLCeZRwMwUkBmR5ZZ8p3/Q8hyLVCPgvUqJgZrs2gnNgOkaKVRPGMs3lsuJaSyU+7S3K9/yFxB9TqCfEZPaYiDDAdmnDET5xmA0sJw9Gg3dAWJEyydEHzx2wIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Yr6yTRKr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hc6mL18p; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gjxF2PQk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9vtYLdaV; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Yr6yTRKr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hc6mL18p";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gjxF2PQk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9vtYLdaV"
Received: from pobox.suse.cz (unknown [10.128.32.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8537821FA3;
	Fri, 25 Sep 2026 13:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790341211; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M+Lw1zwjw+yQqeJu89nhxojF6iZKoKDtf+eerGfxK/w=;
	b=Yr6yTRKr2+V4mr46qgDcsBt4ho0hBIgpWdF9of2IICNsybWsHomgQXSKfOY9rs6GQk0O6e
	IGI4vGLhFl+0YS/sDMRew+ziC091ouEjmB69AivysZPP0/K7a9d5UdD6s735LkkNzbeIeB
	qa7X8Huxo2CtCWQqnfHrrBL3jfpq5mY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790341211;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M+Lw1zwjw+yQqeJu89nhxojF6iZKoKDtf+eerGfxK/w=;
	b=hc6mL18pJgNMOJu5s8fBLllSCmEG6dOgsUZ4yun/ZUgqKzjjrRvKKsudgz0pdOqgoXFJu8
	sjFyuqqHegVhxfDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790341207; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M+Lw1zwjw+yQqeJu89nhxojF6iZKoKDtf+eerGfxK/w=;
	b=gjxF2PQkzR4sOcBE5dbUvZXYQq62D+NDUY+Uwz6Le2XbS+HkyToOXCKMRfHmymBDeiDyoX
	YD0fIsWmZLJ6jJdHNWJym3Xhn0nJNnfr7KQ4MMDyQ2NCt96ShRx2yeoWdSQcAD5QGFo1Nb
	roAa9dLfpZj9mAb1PTqK91ttxHF6BTk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790341207;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M+Lw1zwjw+yQqeJu89nhxojF6iZKoKDtf+eerGfxK/w=;
	b=9vtYLdaVdue1HmtY8bJ6/d0Dg/eKMiFhudYW9gO9JZZjsS8JfSvRlCR/yir1/E0uU2deky
	CthdsDfLB4+ZDgCg==
Date: Fri, 25 Sep 2026 15:00:07 +0200 (CEST)
From: Miroslav Benes <mbenes@suse.cz>
To: Yafang Shao <laoar.shao@gmail.com>
cc: jpoimboe@kernel.org, jikos@kernel.org, pmladek@suse.com, 
    joe.lawrence@redhat.com, song@kernel.org, live-patching@vger.kernel.org, 
    Wardenjohn <zhangwarden@gmail.com>
Subject: Re: [PATCH v9 6/9] livepatch: Deprecate stack_order
In-Reply-To: <20260913024228.72317-7-laoar.shao@gmail.com>
Message-ID: <alpine.LSU.2.21.2609251459450.28305@pobox.suse.cz>
References: <20260913024228.72317-1-laoar.shao@gmail.com> <20260913024228.72317-7-laoar.shao@gmail.com>
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
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_ZERO(0.00)[0];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,suse.com,redhat.com,vger.kernel.org,gmail.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pobox.suse.cz:mid,pobox.suse.cz:helo,suse.cz:email,suse.com:email]

On Sun, 13 Sep 2026, Yafang Shao wrote:

> The stack_order sysfs attribute was added to determine which active
> livepatch is used for a given function. It is no longer needed because
> recent changes refuse loading another livepatch which would modify
> an already livepatched function unless the new livepatch would replace
> the conflicting one.
> 
> [Commit message authored by Petr.]
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Acked-by: Song Liu <song@kernel.org>
> Cc: Wardenjohn <zhangwarden@gmail.com>
> Cc: Petr Mladek <pmladek@suse.com>

Acked-by: Miroslav Benes <mbenes@suse.cz>

--
Miroslav
