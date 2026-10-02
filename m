Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C9F2C21DF
	for <live-patching@vger.kernel.org>; Fri,  2 Oct 2026 12:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790944045; cv=none; b=uJWBcW/oI7rwF6Y6omoZMBPsG211KEr/4EAqa/UHCyLLz8WaD31AysJdmzqiu00t1RS6wHQ9FZEGwgfkTQFnS8Ynx8UYS2eMXgIBqmjh7J2BbwVhjOagul639UYYT94v2P+1gCzn4uIHJD4xWKPXvop/feg20Dq04+Vq5NiIC10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790944045; c=relaxed/simple;
	bh=TDOy8It7lXuzQxxGM1dm00K2RWjaKtMYchYkIXILMCA=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=CkQU18EKBSpVG2jnqM3snHjuep3Rc4jIaY05ye3/63VPAUrB9ogjHek7SlYhs5bwryHBaPNhJcRlynJ+p8oTSHq44KmrAegXHsaNEAQ4uWFD1yZiQXSI9EBCDcyyiboKTlanw3CVFgBPrL8JW6WOg3mnyo3BOrwvaxwWJEDQzWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DRg/Ltk9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=q4yeR/bT; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UAYT59pN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=trgcIuaP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DRg/Ltk9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="q4yeR/bT";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UAYT59pN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="trgcIuaP"
Received: from localhost.localdomain (unknown [IPv6:2a07:de40:b2bf:1b::12ef])
	by smtp-out2.suse.de (Postfix) with ESMTP id 6510B1FE4D;
	Fri,  2 Oct 2026 12:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790944037; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1CXPRmPTf3eBq+IGcDF4CEAeklzQqTopE94x44VKNJo=;
	b=DRg/Ltk94NVsugCN2aEBm25vUwPTWx/fPCvvoKtHq3sjf71fhvcAPCYYspDPBGhN+tTBfN
	7hUColxvM3MWk3RN7MfjZ8xmPasYf06hE+ek11JWjCV7KWf5NkyczFmbLAIF3lUznPABFp
	Z8Xe+6GaZL8PER0aC0YyrDtd9kNTorE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790944037;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1CXPRmPTf3eBq+IGcDF4CEAeklzQqTopE94x44VKNJo=;
	b=q4yeR/bTp+e9UDIa4a7WmQyLs93MrOuLKCHJZB+sryKoF2UHV79O5HJFB3xxGtc4WEqrCz
	EbbgJRuisBMDbNDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=UAYT59pN;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=trgcIuaP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790944033; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1CXPRmPTf3eBq+IGcDF4CEAeklzQqTopE94x44VKNJo=;
	b=UAYT59pNgIKdasKORv0Z6lWMGaVptNqiFUr3dH2eVwHSB99a5NZaWHjVoI0lnHNllgzEgs
	mXpvqNLnI6eaWIUjgQ0oGMGPQHlPIbl09jQyPR4X4Eg3YJBoBbrVCD24PHhLeWC8ZfkiRV
	vwROVO6mp3RIWf8i8cWzxMDUbpY2JvE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790944033;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1CXPRmPTf3eBq+IGcDF4CEAeklzQqTopE94x44VKNJo=;
	b=trgcIuaPdWJnRRdbYraVd18n6tONJkrUm4SoTL9UCSMhzSZ259UpOVIkk8wdYR7JlEcVTo
	dkgQZHzqcN6GU1Dg==
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v10 7/9] selftests/livepatch: Add provides/obsoletes
 test scenarios
From: Miroslav Benes <mbenes@suse.cz>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com, 
 joe.lawrence@redhat.com, song@kernel.org, live-patching@vger.kernel.org
In-Reply-To: <20260930030323.14396-8-laoar.shao@gmail.com>
References: <20260930030323.14396-1-laoar.shao@gmail.com>
 <20260930030323.14396-8-laoar.shao@gmail.com>
Date: Fri, 02 Oct 2026 14:27:12 +0200
Message-Id: <179094403215.135114.5637407995388985580.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=691; i=mbenes@suse.cz;
 h=from:subject:message-id; bh=TDOy8It7lXuzQxxGM1dm00K2RWjaKtMYchYkIXILMCA=;
 b=owGbwMvMwMHYWJt9x2W1tA7jabUkhqz9ixUl/Xy+i1hvYOcL2DIntyubc2P6Gad8M8X+u6vn2
 GrpPNXoZPRnYWDkYLAUU2R5vddZznBKroFm9bu7MINYmUCmSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 IZChY8TAxSkAU731Efv/xPe70n6mJKUm5wg5T/Os954dI735nUFy2lTLKIVfdqF2i69O2m+sukC
 Zf0Op2LlQKz1BNZ49nnc6ZxWkuIccWbn34mT3OHe7W5e4mH4/yDxokt3z7ciugpSTcfP69BTndW
 +qv73KYCoLt1MhQ/w358y209xzZru3cKqWv0teI3/tg0vCbKV12V+C07Y1Bq15aLWfkee87uZpW
 Vat1grbtCZXeX+f+ujP9tl/Zk/Sv15pWC5p78yzdavY3Ai9rV3PvE7rcSh7L969YX+9RJ7DpQnx
 j3ltKkqszv1NOuG6Kv+xb77eg9kP137k2OCZzW0+Z4t+XN2Odek5y05odDZwB0zfqpaiv/6Sv3h
 3zVsA
X-Developer-Key: i=mbenes@suse.cz; a=openpgp;
 fpr=91BB0699882EF39D46654BB3FF98A38DA80834DA
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [19.18 / 50.00];
	SPAM_FLAG(5.00)[];
	NEURAL_SPAM_LONG(3.50)[1.000];
	HFILTER_HELO_5(3.00)[localhost.localdomain];
	NEURAL_SPAM_SHORT(3.00)[1.000];
	BAYES_HAM(-2.71)[98.74%];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	RDNS_NONE(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ONCE_RECEIVED(1.20)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DIRECT_TO_MX(0.00)[b4 0.17-dev];
	TO_DN_SOME(0.00)[];
	GREYLIST(0.00)[pass,meta];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b2bf:1b::12ef:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b2bf:1b::12ef:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[localhost.localdomain:helo,suse.cz:email,suse.cz:dkim]
X-Spamd-Bar: +++++++++++++++++++
X-Rspamd-Queue-Id: 6510B1FE4D
X-Spam-Score: 19.18
X-Spam-Flag: YES
X-Rspamd-Action: add header
X-Spam-Level: *******************
X-Spam: Yes

> Now that the legacy "replace" field has been replaced by the
> provides/obsoletes mechanism, add test scenarios to verify the new
> behavior.
> 
> The test modules gain provides/obsoletes module parameters, and
> test-provides-obsoletes.sh covers the new replace semantics: provides=0
> replacement, same-provides replacement, obsoletes-based replacement
> and coexistence of different provides ids.
> 
> These tests are skipped on kernels that still support the legacy
> "replace" attribute.
> 
> Assisted-by: LLM
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

With the comment reported by Sashiko fixed

Acked-by: Miroslav Benes <mbenes@suse.cz>

-- 
Miroslav

