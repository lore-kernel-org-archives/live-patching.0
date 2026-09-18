Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFBC4FD791;
	Fri, 18 Sep 2026 13:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789738836; cv=none; b=fZG73932SRuNrCs/pwy7oAtZ+rUoUlu/+q6gWl1eaKFD4On2XhPZEll1zQJgsv3vW8Wkl1rWS4PRBd3Y4OqnZDTYy0nUx3wuikIdchTU+s5T2HJg7Cew2QW+AlcmAvUdUpFlET4sQI9YAqPHmmU/rD4IvyRCQ9QYc2k/oHgJLEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789738836; c=relaxed/simple;
	bh=SBCFnMgrySgpjn88d31NjLPy+RxxfirrS8EQJWlwCeE=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=pWDKqkHu8VE6DjJp8LXBHv41G93aYhpETjJK9U8K3IpWJ0Rm6ptiYFpSRsXpiSM5/8zHiDTacps5jClXUxQsYElXcf2PrBU0w1YOGkOemJeU3c25F0P9gLxGZf+8cQl4zx2o800NvjN8zcjddM1yw8h0FGh7FaHfjDrvQIa3eK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BPHz0wNR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=abDQuKSn; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EQIFTwNn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=upzX7ss7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BPHz0wNR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="abDQuKSn";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EQIFTwNn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="upzX7ss7"
Received: from localhost.localdomain (unknown [IPv6:2a07:de40:b2bf:2b::1244])
	by smtp-out1.suse.de (Postfix) with ESMTP id 67C3821E18;
	Fri, 18 Sep 2026 13:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789738827; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t/D8OD6tqb7woVRhy+17kledhxGJ4T7AOT0piDyaX58=;
	b=BPHz0wNRZka/4FhuyLMbXpkqsGhO1nWz/ZdTL9WmorIcIFO+ZSGsmPeLsauKZ2RNptC8dq
	2PHNL4+WvxbZxnnV7q7nqNJXfl6Pb28aU5ElXA+OP5eVE8M3yXJFRPA407RUXrF44uCRtr
	wGO0J2keCQfTpZ0wag9AjxTHd3nx9xw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789738827;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t/D8OD6tqb7woVRhy+17kledhxGJ4T7AOT0piDyaX58=;
	b=abDQuKSnlY06e190estwTihwaPG2PaeLZ9VNhAqaQWL514PemBRjDuVjEB4bgg6loQo/lx
	+CIG5++a4nXuPFCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=EQIFTwNn;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=upzX7ss7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789738823; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t/D8OD6tqb7woVRhy+17kledhxGJ4T7AOT0piDyaX58=;
	b=EQIFTwNnqrBCeLKR/orbJgFWTzhBk+hexPz9Dyz8lCh0tnXOSnP8ZMWgTlJwo4X36fxE9V
	M1s0YshpIQ6jjncSltOz8KYg5/C3s92fiSXnGBzehG6rsCnmQICalbpdFscoC50vvqr9bT
	aLmK/a7YZOHTtRm9QCIj4m4vuEGH/DI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789738823;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t/D8OD6tqb7woVRhy+17kledhxGJ4T7AOT0piDyaX58=;
	b=upzX7ss7+BUVNLZXyCQz7+uLAMoWK1S7dVzl920TzOQj+5DfjShc61Cb7C8DIuS7kAPddC
	6ozdYXUUXcbmv1CQ==
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 2/5] selftests/livepatch: Test rejection of aliased
 symbols in one object
From: Miroslav Benes <mbenes@suse.cz>
To: Petr Mladek <pmladek@suse.com>
Cc: Harry Hsu <x90613@gmail.com>, jpoimboe@kernel.org, mbenes@suse.cz, 
 joe.lawrence@redhat.com, jikos@kernel.org, live-patching@vger.kernel.org, 
 shuah@kernel.org, song@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260908120325.299649-3-pmladek@suse.com>
References: <20260908120325.299649-1-pmladek@suse.com>
 <20260908120325.299649-3-pmladek@suse.com>
Date: Fri, 18 Sep 2026 15:40:18 +0200
Message-Id: <178973881851.131521.4245005602518214030.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=809; i=mbenes@suse.cz;
 h=from:subject:message-id; bh=SBCFnMgrySgpjn88d31NjLPy+RxxfirrS8EQJWlwCeE=;
 b=owGbwMvMwMHYWJt9x2W1tA7jabUkhqy19i7HTWXtGBVnFZYY2CYvNFQR+NUUzrLgzO9fb+05l
 HY9/qvTyejPwsDIwWAppsjyeq+znOGUXAPN6nd3YQaxMoFMkRZpYAACFga+3MS8UiMdIz1TbUM9
 QyBDx4iBi1MApvrCBfZ/Jve9ms2mcyjxM0XP4NF/bRqnWr3ObY3CpJk/HU96cLZdFTT72Oq98WA
 gu49duJs+m7HjodVft4gvMtuvrvQj5mBx8xGppVt+6OUyeSwrretp2HROQen+lVz/Q5rr76ikrj
 N4lNKx+5/BIe3kvTuUU9Sca7PMfqnuk/KoXXvy8JaEv6cDueQsvhxT/BKqOkOpwERuqUjeN6nSK
 a2TZA8/0DvwaZcke064wd5Lnac898gJts9Ypm52r3zx3lvS9iY/H+xQ376sySm74WSql63dT4XF
 frJJolemzi7KtVWvckuxnBb6a8mRvOMKfBdkcl+wf/x8ReGluMCdnbEcPhrcv/VtNkxODfD7JRK
 gIQ8A
X-Developer-Key: i=mbenes@suse.cz; a=openpgp;
 fpr=91BB0699882EF39D46654BB3FF98A38DA80834DA
X-Spam-Level: ***************
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: add header
X-Rspamd-Queue-Id: 67C3821E18
X-Spamd-Result: default: False [15.25 / 50.00];
	SPAM_FLAG(5.00)[];
	NEURAL_SPAM_LONG(3.50)[1.000];
	HFILTER_HELO_5(3.00)[localhost.localdomain];
	BAYES_HAM(-3.00)[99.99%];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	RDNS_NONE(2.00)[];
	ONCE_RECEIVED(1.20)[];
	NEURAL_SPAM_SHORT(0.86)[0.288];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	DIRECT_TO_MX(0.00)[b4 0.17-dev];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,suse.cz,redhat.com,vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b2bf:2b::1244:from];
	RCVD_COUNT_ZERO(0.00)[0];
	RCPT_COUNT_SEVEN(0.00)[10];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spamd-Bar: +++++++++++++++
X-Spam-Flag: YES
X-Spam-Score: 15.25
X-Spam: Yes

On Tue, 08 Sep 2026 14:03:22 +0200, Petr Mladek <pmladek@suse.com> wrote:
> klp_init_object_loaded() now rejects an object whose klp_funcs resolve to
> the same address, because aliased symbols would push two klp_funcs of one
> livepatch onto a single ops->func_stack and leave the redirection
> ambiguous.
> 
> Add a target module providing test_klp_alias_show() together with its
> __alias() sibling, and a livepatch naming both of them.  Two test cases
> cover both callers of klp_init_object_loaded(): the klp_enable_patch()
> path, where the target module is loaded before the livepatch, and the
> klp_module_coming() path, where the livepatch is loaded first and the
> module loader has to refuse the target module.
> 
> [...]

Acked-by: Miroslav Benes <mbenes@suse.cz>

-- 
Miroslav

