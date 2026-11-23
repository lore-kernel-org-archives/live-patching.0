Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795438402;
	b=zNKjSC1Qjj3iUUiBxj2XK6BRVxe5xkqA36y36Qfsoq0nLRhWP+mFuHOhwvn5Zv7jfCmM
	 LOnucpgN6Apb7I5d7HvQjTzb2NW8VUBZYmHYF4jJpPYVaMezP5EVua5cpeMFkyVuDdkSh
	 +CEu4+Qx+jChQ/wZXy4ceNiHGerVsFw8fSE8pHM9O3q8jFimoBbb9bFc7VhZBhicHh4xM
	 AoaMcY9Uu4z3NDAY39FQUfnpzxRkWmWrnH2iOzRfWTWGZz8rDj/+rsRsMgcbAPtsITdG8
	 54qqzkjEEyy2eVEm4TnWEIjPs7yHPXqsoicL55BEvETmnYrFpIKSCHAH9798nUplL2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795438402;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:User-Agent:MIME-Version:Content-Type:X-Spamd-Result:
	 X-Spam-Score:X-Spam-Level:X-Spam-Flag;
	bh=MoVZGgFSknxuhmxQ2EcJuliGRiUE0WfStLh+wY9rmGI=;
	b=Xajzd9VJ/INPKziQTJHmFIw7NY9pmc7veObqu2LbswD2LLcd1tg7BCCtB/Frdz7+BnFG
	 fxp1JzM3t+0SegKaRL3EE8tCYWDNECxUaLt6nVwkG4TLciyXfv7GRa6OHmvNJX+YrUTlV
	 sSsaWWY08XrCgN5fyx+l+vCvMl1zXMuaywWk3ln2ha3qope6WI4nUMcaV2zosKhDaHI8b
	 pis/YboQT8zD7fIARFxPKUdx9EYZRsqBGLOb2qFXPSNfhmOwGeUDSeYJtIBHdsfgDw5bx
	 UiLUYtaMoJOyej9LN/UyYykCojMMmefFAtHSQjiNzRlFCTLM5bHV/2jksRtsSgQJRzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=nYLhIYZo;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="q/8utAhV";
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=dou9wGyd;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=nkWJ0fxk;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D0C606A31E;
	Mon, 23 Nov 2026 12:53:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30D0C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=nYLhIYZo;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=q/8utAhV;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=dou9wGyd;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=nkWJ0fxk
Received: from pobox.suse.cz (unknown [10.128.32.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2987F21E4E;
	Mon, 23 Nov 2026 12:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795438400; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MoVZGgFSknxuhmxQ2EcJuliGRiUE0WfStLh+wY9rmGI=;
	b=nYLhIYZoZt+z8/qQL1wNLYzwcoT9etR7xuWAOprZP2lYQA42dXFDm57RqHIVn2bmA9s9T9
	Zcv7werF81yUDNfmuNxgP7OTbZjmY7Vcqm+rUmlfX/1eu91MHIRyHdnukXttLJxkwH0uvK
	glx8fjOBeSZ8PsSzNUtNHV1ljqMxmek=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795438400;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MoVZGgFSknxuhmxQ2EcJuliGRiUE0WfStLh+wY9rmGI=;
	b=q/8utAhVa8dTOdmzAZoXP1X4C4yIMI7h6iD83BqfxFo1f+Xu9JRpkwfcNDF6wxgRZpG3Mr
	+lQmBXAEVA3nL9Cg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795438399; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MoVZGgFSknxuhmxQ2EcJuliGRiUE0WfStLh+wY9rmGI=;
	b=dou9wGydYm5qki2o3EwiOEvLgYBrRHZH7Ynj/yJ5sFVDkF9EDxu2CCFjR13R64y7iqpL/h
	NLHrMaFQIxs1n1umEcDoTXoF1LSN83SKDK9f17Ybe+zFJZJXLdRU+p4n4ugN5vP8pgZqgN
	wJlmlp7A6E3cBDti0IhNt3h2jlGQel4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795438399;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MoVZGgFSknxuhmxQ2EcJuliGRiUE0WfStLh+wY9rmGI=;
	b=nkWJ0fxkAETTO0eRhC5dGXKPcnwqnLxsmfX+0c6rBGOvORF4dPGVrbyiQkIkgxJ5bavT1u
	J0WCduZY+EblGtCw==
Date: Mon, 23 Nov 2026 13:53:19 +0100 (CET)
From: Miroslav Benes <mbenes@suse.cz>
To: Yafang Shao <laoar.shao@gmail.com>
cc: jpoimboe@kernel.org, pmladek@suse.com, joe.lawrence@redhat.com, 
    song@kernel.org, live-patching@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] livepatch: clear internal flags at init
In-Reply-To: <20261123024000.15130-1-laoar.shao@gmail.com>
Message-ID: <alpine.LSU.2.21.2611231352550.30311@pobox.suse.cz>
References: <20261123024000.15130-1-laoar.shao@gmail.com>
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
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_COUNT_ZERO(0.00)[0];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pobox.suse.cz:helo,suse.cz:email]
X-Spam-Score: -11.80
X-Spam-Level: 
X-Spam-Flag: NO

On Mon, 23 Nov 2026, Yafang Shao wrote:

> func->nop and obj->dynamic are internal flags. However, a patch module can
> set them in its static initializer and nothing validates that. The release
> path uses them to decide whether kfree() has to be called, so with such a
> patch the kernel ends up calling kfree() on memory it does not own.
> 
> Explicitly clear these flags during init to avoid that.
> 
> Suggested-by: Miroslav Benes <mbenes@suse.cz>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

Thank you
M
