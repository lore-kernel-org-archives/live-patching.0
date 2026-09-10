Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B31048EC81
	for <live-patching@vger.kernel.org>; Thu, 10 Sep 2026 14:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789050948; cv=none; b=mklxg4jG0FcT4y9Z05ztEhAxQx0Y6i7OoLJc7Xz/enMmfm9RRo02dYVo66t6qZ69yj2N0X+i3jgm6tUUuq69t+lG6HF/IKRQd/sdXKykQrIEmZM7tQTfaKFIj3Ja/Xp0Kj2gFdpdOcH9S0XWarvhhtKzCcsDOWSL0ffKvh1Ni3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789050948; c=relaxed/simple;
	bh=g+zOxmN9RwhlXSel6vt7Zl15hRPIn8T/kNZiR0QbLAY=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=peGqyIPs6yf7Tcz+CeMHvnZfNZtk/G2rjkpUuaDh50zZeiJFqGRfgxfxyok5ctvYhYQTsKodHGreg4FO4t0ncBj8BdgqRXxYr41H29TYfgg3nAULZ4wZz6CNNHqM2FYyEUq7nO4487Uuj1mmw1pX65D7OqQcEzKX+iO7wZnE+5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wIBF2GoQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WV8E7a6d; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tZmKzt/f; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iStaBfRo; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wIBF2GoQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WV8E7a6d";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tZmKzt/f";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iStaBfRo"
Received: from localhost.localdomain (unknown [IPv6:2a07:de40:b2bf:1b::12ef])
	by smtp-out2.suse.de (Postfix) with ESMTP id C77071FDF2;
	Thu, 10 Sep 2026 14:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789050941; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tH/BE4epPf0p7EBxoWr1I+hOLSQRfuDhKDDJfQ7MJx8=;
	b=wIBF2GoQABAdszNMgp5FMNsihKOqrD4NzFBFr0k6r6YcfiGK0T5CdNdZ7KTwwjHa1+lT/V
	aguDuYYk+hDfKsu6sUc55MiwRWDhifc7UzJQgHPylUCaDjn03vnMryYDr8Wlxmfr/cF/Su
	uBrESV2lggv3xYy3cNqXPqeAleF404U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789050941;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tH/BE4epPf0p7EBxoWr1I+hOLSQRfuDhKDDJfQ7MJx8=;
	b=WV8E7a6d/ElSB4qB/GlUqLoezdPhPpHhFwadV0zgcwfvv2TpgyWYIZBdMv5Ku1L6q8BRB0
	hE4M31i3xAP4urAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="tZmKzt/f";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=iStaBfRo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789050936; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tH/BE4epPf0p7EBxoWr1I+hOLSQRfuDhKDDJfQ7MJx8=;
	b=tZmKzt/f+nIe0xVZUDJMb7Vzk6jYg17zV39Nzc3qTaQuAuYvcu3oJDkAap3L/228oa04hN
	5Jfv5hTK0anxVXhgo4J/z12clHyQ8vTvlutIcBS5qb2vngKX67NXBW42i54T2Im6FzvLLC
	uzeVmc7u/6AiAXY6KMO4Ni2zIrl4pao=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789050936;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tH/BE4epPf0p7EBxoWr1I+hOLSQRfuDhKDDJfQ7MJx8=;
	b=iStaBfRoek88gjyT3LaxKq2yLw0/4TLEK+kJuCLFC8ESIIxJyEF0FwhUFbiWZ5adqlcFcm
	QhA7pfQIGpzKPfCg==
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [RFC PATCH v2 2/7] objtool/klp: add --symvers option to klp
 diff
From: Miroslav Benes <mbenes@suse.cz>
To: Joe Lawrence <joe.lawrence@redhat.com>
Cc: live-patching@vger.kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>, 
 Song Liu <song@kernel.org>, Miroslav Benes <mbenes@suse.cz>, 
 Petr Mladek <pmladek@suse.com>, Yafang Shao <laoar.shao@gmail.com>
In-Reply-To: <20260826195000.455905-3-joe.lawrence@redhat.com>
References: <20260826195000.455905-1-joe.lawrence@redhat.com>
 <20260826195000.455905-3-joe.lawrence@redhat.com>
Date: Thu, 10 Sep 2026 16:35:26 +0200
Message-Id: <178905092670.252327.4898761340529367463.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=518; i=mbenes@suse.cz;
 h=from:subject:message-id; bh=g+zOxmN9RwhlXSel6vt7Zl15hRPIn8T/kNZiR0QbLAY=;
 b=owGbwMvMwMHYWJt9x2W1tA7jabUkhqxFBwxatSOfcjsw7tsyl/P1i9dXDx1fIveJXzHUwnUOm
 4B5B+fWTkZ/FgZGDgZLMUWW13ud5Qyn5BpoVr+7CzOIlQlkirRIAwMQsDDw5SbmlRrpGOmZahvq
 GQIZOkYMXJwCMNVvl7L/lVzsz8axI5hfvnDO1SNyn58XXTcMtz2q0njo8GX75eqlCz9+rvdd25D
 7tqogWjntxbfLslWrhSbIl4lkO0t/6A2SnDF7quWznQ/qpC+arHpVVpmdb/ug5KHLZBHdEvfYiE
 8ZFc6LfAu/z98QcjSlWeVz57SEF2JqLwse/JF8FiMUPPvo54Zv3M9EHmddXvRTLSZr7U2/H5uvL
 pn5K/BHxgyrugPny08eFy8OPXbP7uXcWJ323N37zjn68Ttk3Y/exrFfsqI8nfvUvPa29wr2k3Nf
 JcYFeIgrLtjyqz3h9R+VtgXpQhKz1q4Jrshe+G3y4m3VCi8Tl2xO2VZSv9DY8I28RXFSpolcTqd
 4sMJVAA==
X-Developer-Key: i=mbenes@suse.cz; a=openpgp;
 fpr=91BB0699882EF39D46654BB3FF98A38DA80834DA
X-Spamd-Bar: ++++++++++++++++
X-Rspamd-Queue-Id: C77071FDF2
X-Rspamd-Action: add header
X-Spam-Flag: YES
X-Spam-Score: 16.48
X-Spam-Level: ****************
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [16.48 / 50.00];
	SPAM_FLAG(5.00)[];
	NEURAL_SPAM_LONG(3.50)[1.000];
	HFILTER_HELO_5(3.00)[localhost.localdomain];
	BAYES_HAM(-3.00)[99.99%];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	RDNS_NONE(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ONCE_RECEIVED(1.20)[];
	NEURAL_SPAM_SHORT(0.59)[0.197];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DIRECT_TO_MX(0.00)[b4 0.17-dev];
	GREYLIST(0.00)[pass,meta];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b2bf:1b::12ef:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b2bf:1b::12ef:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,suse.cz,suse.com,gmail.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[localhost.localdomain:helo,suse.cz:dkim,suse.cz:email]
X-Spam: Yes

On Wed, 26 Aug 2026 15:49:55 -0400, Joe Lawrence <joe.lawrence@redhat.com> wrote:
> Add a --symvers (-s) option that accepts a path to Module.symvers.  When
> provided, it replaces the default "Module.symvers" filename used by the
> auto-detection logic.
> 
> This decoupling helps to enable scenarios like out-of-tree module
> patching and unit testing of klp-diff, where object files /
> Module.symvers live outside the kernel tree.
> 
> [...]

Acked-by: Miroslav Benes <mbenes@suse.cz>

-- 
Miroslav

