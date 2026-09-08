Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD059538D8F
	for <live-patching@vger.kernel.org>; Tue,  8 Sep 2026 14:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788877536; cv=none; b=inrWzJPsPPmoYfEgcCyzOCfHsSXTeuapDfO+TZjH9fC20Uw1/1cyhzG4FwgIUzh3ExWmznBqdV24+nDyD7+NoIbubST5Qe2GFv3KzBT3IhH0XTGx9fvjXx66zZtNNdVE4rfZwMZ/Ke/WIvSk9iJGS/+RJJUUvMGsUBPxoOSsueQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788877536; c=relaxed/simple;
	bh=YksZhl4LANjlr4d9k9gLCqiZBu8BUbY3STnrIs7B10I=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=kEesbJkTxmS9GAKZRVLmuLCRgqUjaDGJxldr5Aw6XYRKNLxUwPJ1S/6hRtldsTPJ+b3imJvHjtgsNh1MY1/Yx2fGZhVC/t9M0hQCuhI+BMngztDKqCV/ZJ+TGiwkANrVdIR8ISMJMjMSEZj06yBOjkU2RL6A7zjUK1JRT+hk97o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gNwiG0st; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=I11FSujI; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ouvF387R; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fSpLuvM+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gNwiG0st";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="I11FSujI";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ouvF387R";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fSpLuvM+"
Received: from localhost.localdomain (unknown [IPv6:2a07:de40:b2bf:2b::1244])
	by smtp-out2.suse.de (Postfix) with ESMTP id 185251F839;
	Tue,  8 Sep 2026 14:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1788877505; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=majja17vx2/HhYZCkUGLoA9EYrAOgQzFGr5rvTR27dc=;
	b=gNwiG0stmc9WH7vSlBiRrlVvU4AmxwsjjZJfhAuGfai0nrKVmrmbjel7NA1C5rL0e0Dc0o
	o4MsZeQg9ni2nHqB4+e2mg14RanBjM75eKbO/A+v4nNJZNfh5Ly5aUn0t0im/oL1KKyWzi
	i92IdqAynXNflDAxSHI2JVmNwfCs9T8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1788877505;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=majja17vx2/HhYZCkUGLoA9EYrAOgQzFGr5rvTR27dc=;
	b=I11FSujIc7XVHOa4e0Iios/QE6Z+XJzRc8HON8VLL/gZS8w33MgiI7xNM3u8wdUlyAhJvy
	2NJCdd4Hm0BKOsAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ouvF387R;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=fSpLuvM+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1788877501; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=majja17vx2/HhYZCkUGLoA9EYrAOgQzFGr5rvTR27dc=;
	b=ouvF387R+cjcaNQlJq3MxaCfyiSbQqUUpaikfK+Dag89+NUcpkbDSwrr6iLpQK80dJwEJf
	FjMmPeYLjh/wSP6gp4ZJuTdwgNna/YI2VUcb7ZGCmbk/3FMKt19ScCN8Zl5/tbwcXIlkZC
	/SKz+O+RgtYg1iyGw2uERLQ/Eoe12Uo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1788877501;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=majja17vx2/HhYZCkUGLoA9EYrAOgQzFGr5rvTR27dc=;
	b=fSpLuvM+aesauHe4O64zJqldymqdUQgTEJCLTW0SWEc2cLCOByEhu2xeRuOFTLS72tgI3K
	QwlYZcpgJ6ZJG1AA==
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v7 for-next 2/8] livepatch: Call klp_init_patch_early()
 earlier
From: Miroslav Benes <mbenes@suse.cz>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com, 
 joe.lawrence@redhat.com, song@kernel.org, live-patching@vger.kernel.org
In-Reply-To: <20260825114641.80452-3-laoar.shao@gmail.com>
References: <20260825114641.80452-1-laoar.shao@gmail.com>
 <20260825114641.80452-3-laoar.shao@gmail.com>
Date: Tue, 08 Sep 2026 16:24:50 +0200
Message-Id: <178887749067.24106.6736354585361659469.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=360; i=mbenes@suse.cz;
 h=from:subject:message-id; bh=YksZhl4LANjlr4d9k9gLCqiZBu8BUbY3STnrIs7B10I=;
 b=owGbwMvMwMHYWJt9x2W1tA7jabUkhqwFUlu+XZZP7+JKZ5un0Fh0adu/1b2550/ccokO9vqre
 amk0X9RJ6M/CwMjB4OlmCLL673OcoZTcg00q9/dhRnEygQyRVqkgQEIWBj4chPzSo10jPRMtQ31
 DIEMHSMGLk4BmOrL8ez/c8+sf7VrkeOWlg3TzVr2bV1oX7S9aHGMpclOp3ixWXf3y9rN37v27je
 JA3tsp3w9W/74tKx1uknts3dnD+7b0eR0fEqH6qVvh5O3uvzvmfDIjP8lj9VOhcANVy4t3H42bL
 bsQ89lZSaJTDNd/87n7jpbWtycaWwzq0Mpa4VR56yef7yrdwXlKglwT0zr+KRdvYxf8kqb5QaHR
 oZlf9XWBdmtuzp77/L5XtsmxsvEyf/zd40Uftjg6aBgoHElYHL37x2+n99L99tPs3trdbPVPNLN
 yfxRRPLcMzb26oU/Sj9WbgmIFPmvzcCTfMwwPs7v/od3uocsV/rutBP5dXnNlj1dkrKlAs7uIfc
 C53ecAQA=
X-Developer-Key: i=mbenes@suse.cz; a=openpgp;
 fpr=91BB0699882EF39D46654BB3FF98A38DA80834DA
X-Spamd-Bar: ++++++++++++++++
X-Rspamd-Queue-Id: 185251F839
X-Rspamd-Action: add header
X-Spam-Flag: YES
X-Spam-Score: 16.62
X-Spam-Level: ****************
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [16.62 / 50.00];
	SPAM_FLAG(5.00)[];
	NEURAL_SPAM_LONG(3.50)[1.000];
	HFILTER_HELO_5(3.00)[localhost.localdomain];
	BAYES_HAM(-3.00)[99.99%];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	RDNS_NONE(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ONCE_RECEIVED(1.20)[];
	NEURAL_SPAM_SHORT(0.73)[0.244];
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
	SPAMHAUS_XBL(0.00)[2a07:de40:b2bf:2b::1244:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b2bf:2b::1244:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,localhost.localdomain:helo]
X-Spam: Yes

On Tue, 25 Aug 2026 19:46:35 +0800, Yafang Shao <laoar.shao@gmail.com> wrote:
> Invoke klp_init_patch_early() during early initialization to avoid
> mixing for_each_() and for_each_*_static() variants later in the code.
> 
> No functional change. This prepares the code for an upcoming patch.

Acked-by: Miroslav Benes <mbenes@suse.cz>

-- 
Miroslav

