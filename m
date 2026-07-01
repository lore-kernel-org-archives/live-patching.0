Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587F643E49B
	for <live-patching@vger.kernel.org>; Wed,  1 Jul 2026 11:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782904573; cv=none; b=rI3wkGDFooEOdeeSlmS8CUgX1MT7YRkP2Mtv7M4Wz0mMkMOM/oCqleuNomGDIPHdxeReIZrCVJwItEaqjWRnJMSaurrsXOiJm3+1JSUEUkLu/541el4g6yYZF2flzLczlRQLD+AxUJRfo48+C2ZioxhCWQeuXIeY6f6JqmE5kh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782904573; c=relaxed/simple;
	bh=amA5+kwUDh9LcdWF/ryCspzx6g7k4EFajxueb3RUkpc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=SZjpyNRx0C8PdjvU4HIcok/6u/mu5lH1rhFOPB0RkOJth/aYlKV+sTFx6NqTMPInZXEVX6Xvn1OVSI5kFnuMNVS/OCAQ554OQX/AOMOU/0mYfPF6sOnB/b3iWRekt7FKCegDKkMj/pKm22tanR3LtiqrwkqVe7qgEsnzwy4hp/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZH6CCDFM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VkIoS0pC; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nR9fDPbC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dFqIl7eF; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZH6CCDFM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VkIoS0pC";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nR9fDPbC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dFqIl7eF"
Received: from pobox.suse.cz (unknown [10.128.32.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A96E473A65;
	Wed,  1 Jul 2026 11:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1782904570; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h0UZwKWpBnLaOjJCRAZjFVxtZOB+Ev7/v2D5I+G0gaU=;
	b=ZH6CCDFMUzYGjRLUgv5SpX6mz/U5CJY8uDqTeXURsEg/Emg4ZnGRDV7dc2TFXJTXdDKNNX
	58ArfDBc6wfLZ51Z1cK3q2X1j5jFXL9/DM+D36vQotu2al9NHYx12HiQUd4hC3AoBO7r9k
	Zt1YbDX87KamMtt+94TWlcedbUBtJCw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1782904570;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h0UZwKWpBnLaOjJCRAZjFVxtZOB+Ev7/v2D5I+G0gaU=;
	b=VkIoS0pCDp8RCR1CuY+GOJXDamPXzY/VLPf8n99R//6KvgUNrKu89PqPkEfgjco1oQiYsq
	eQTppNGt5jhKuSDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1782904569; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h0UZwKWpBnLaOjJCRAZjFVxtZOB+Ev7/v2D5I+G0gaU=;
	b=nR9fDPbCRIfrzCLiDLP9vjq6y9ehO2p9cAXasxyi1ythdstvLVtwaKu2Z41BWqmD/bVAT4
	ZTdMMp6owlOf4eGGUY6SEjOpgc3DOEVmWc+wCE+4oPTsBRXpHCiWDzZiAqMZRglEMMYqZi
	/nUwX/RFgqokM4CjdyHL7CcrkZkZUZQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1782904569;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h0UZwKWpBnLaOjJCRAZjFVxtZOB+Ev7/v2D5I+G0gaU=;
	b=dFqIl7eFI1cUkhAHoyFl+AL93TQbc14Sopdi/QSrisufmWUK5S3laLZmaBb85JdlXU11ud
	yFU2euVd4fGyTbDw==
Date: Wed, 1 Jul 2026 13:16:09 +0200 (CEST)
From: Miroslav Benes <mbenes@suse.cz>
To: Shihao Ren <rsh15355756202@163.com>
cc: jpoimboe@kernel.org, jikos@kernel.org, pmladek@suse.com, 
    joe.lawrence@redhat.com, live-patching@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] livepatch/klp-build: Fix wrong index in error cleanup
 loop
In-Reply-To: <20260701060655.2343093-1-rsh15355756202@163.com>
Message-ID: <alpine.LSU.2.21.2607011315500.22639@pobox.suse.cz>
References: <20260701060655.2343093-1-rsh15355756202@163.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.27 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.17)[-0.843];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[163.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ZERO(0.00)[0];
	FREEMAIL_TO(0.00)[163.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email]
X-Spam-Level: 
X-Spam-Score: -4.27

On Wed, 1 Jul 2026, Shihao Ren wrote:

> In the funcs allocation failure path, the cleanup loop iterates with
> 'j' but frees objs[i].funcs, which uses the outer loop index 'i'
> instead of the loop variable 'j'. As a result the just-failed (NULL)
> entry is freed repeatedly, while the funcs buffers already allocated
> for objs[0..i-1] are leaked.
> 
> Use objs[j].funcs so the previously allocated entries are correctly
> released.
> 
> Fixes: 59adee07b568 ("livepatch/klp-build: Add stub init code for livepatch modules")
> Signed-off-by: Shihao Ren <rsh15355756202@163.com>

Acked-by: Miroslav Benes <mbenes@suse.cz>

M
