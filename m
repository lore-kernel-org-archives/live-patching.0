Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FB6515991;
	Fri, 18 Sep 2026 13:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789738843; cv=none; b=eb+vjH8VvklE+L+ayhWwIrXP5e5K4Xan4m02l7jfzQeVaxpqn9sWYJyb7UpYXLSsvxw3KyEPe4Iw3sWZSGTYVoYMWKxKmRBBn+Qu8INCTpbBsPldda8wVGZUN2jKRVlJEEq6K7LSiOGQv4gu8aZ5ZVfzoQw3A1W2kTCqZihhfKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789738843; c=relaxed/simple;
	bh=6X2H0cYw5BXf8SrRzpOWnKGB7AjpuDzdDWCxpklR+2A=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=UV6+FzuQ7hGkYKKtG2aPw5BVHl5eQT7mn4DexfudnemaWgRSf2wSyty2I1KGir/F2kmug4oQXh08UeJyRGtUFMCTUygrU9O53H2nDmQXLQF5GFuMdJysQell6/w0ikPbzu2JmpAX85x9jKn672fOWIFwmJIExV6xdXTyAMrpBKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=txNiuKaA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Kw6ux2ao; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=23Xs+yCW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IQIuWVBQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="txNiuKaA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Kw6ux2ao";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="23Xs+yCW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IQIuWVBQ"
Received: from localhost.localdomain (unknown [IPv6:2a07:de40:b2bf:2b::1244])
	by smtp-out1.suse.de (Postfix) with ESMTP id F3C5A21A80;
	Fri, 18 Sep 2026 13:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789738836; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HhrYS3fm/7DV2qb9aSKlUvh50uOjtmNuz8r9jggyTUs=;
	b=txNiuKaA1tLUsuxKUPr6PpCT9b9iOe+WxlDeecCaP5kjqQ8IJbywJeHjXAxJZ4S5Aiosie
	YWo8iJSPyek2bSLJkSm49Oimu1i7TlN4A5Cb2Z/l/QhKgIcJYUgmR8VcK8FtcOrl0u1qRU
	OvT/rKiPS/Zt7iSxLqzuTQ+NMG7S2pY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789738836;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HhrYS3fm/7DV2qb9aSKlUvh50uOjtmNuz8r9jggyTUs=;
	b=Kw6ux2aobxL1OnGJbmh4hdRvyblns99isTfMK4R1QHNSvIRvVESkQPq69e3cDFusUUtsuA
	/OD+k3nLb0DokPAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=23Xs+yCW;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=IQIuWVBQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789738832; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HhrYS3fm/7DV2qb9aSKlUvh50uOjtmNuz8r9jggyTUs=;
	b=23Xs+yCWNTE5MRtRIGjtX66asHpveEg4f747Oaw3sRPPLrvFqonEMMgiop9vaA7sRp1Zel
	DDy6ITtd/w2iGfSJjalb3sDF1hsqcoVubEnS5dpdeL5thlptppYH2I+58F4k8UulIlLxvv
	6XcX9WoxrYcoiYVGH7iwFcYkaR4QP5E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789738832;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HhrYS3fm/7DV2qb9aSKlUvh50uOjtmNuz8r9jggyTUs=;
	b=IQIuWVBQ0+qtDjEokkimR0CansdLZJkB9YKu66P3t65pm0O1d9BDuYaKlaN2cw8FWQcQm6
	S5Vq8uXeinZRXgBA==
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 3/5] livepatch: Move code for updating livepatch
 object relocations
From: Miroslav Benes <mbenes@suse.cz>
To: Petr Mladek <pmladek@suse.com>
Cc: Harry Hsu <x90613@gmail.com>, jpoimboe@kernel.org, mbenes@suse.cz, 
 joe.lawrence@redhat.com, jikos@kernel.org, live-patching@vger.kernel.org, 
 shuah@kernel.org, song@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260908120325.299649-4-pmladek@suse.com>
References: <20260908120325.299649-1-pmladek@suse.com>
 <20260908120325.299649-4-pmladek@suse.com>
Date: Fri, 18 Sep 2026 15:40:18 +0200
Message-Id: <178973881852.131521.17296451585194399346.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=442; i=mbenes@suse.cz;
 h=from:subject:message-id; bh=6X2H0cYw5BXf8SrRzpOWnKGB7AjpuDzdDWCxpklR+2A=;
 b=owGbwMvMwMHYWJt9x2W1tA7jabUkhqy19u4he55OW61t92Bip6hwx67GZh/WW/t2JoVHZRi6x
 /UmXTHoZPRnYWDkYLAUU2R5vddZznBKroFm9bu7MINYmUCmSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 IZChY8TAxSkAU81wj/2vtBr3tEOFeWeefNmRet0wUPmXqp7bjexFpfotU0MeNHBP1g4svv5z6bk
 JsnoSuzu3vFXY3xj3J/6R+/PIo7HNj58J5ezvLjTOCNOerVcreFdlsRO/4SPNqR1xJ2s0Betm9z
 eYCjzZeybhZKaLo73c645I2yO7dp+4l7PPt+uqVPiWJfl/5RML/Y/rLJnGr58efHHb9QM+h1Quc
 nJ/n3pSzaFpiujkTWKP5L9MPtjxrzoyoPTbro37Hup/MzDrFUsuu3B8v/KCdZXyoaEtr/88rH9k
 7SOW82TZ/v5tJ+V6stSypDZ832I7eXuJMLtU/f3pq0q+erW37O94st7o7SK/7uB7DtJnP9zjntB
 2vTAGAA==
X-Developer-Key: i=mbenes@suse.cz; a=openpgp;
 fpr=91BB0699882EF39D46654BB3FF98A38DA80834DA
X-Spamd-Bar: +++++++++++++++
X-Rspamd-Queue-Id: F3C5A21A80
X-Rspamd-Action: add header
X-Spam-Flag: YES
X-Spam-Score: 15.27
X-Spam-Level: ***************
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [15.27 / 50.00];
	SPAM_FLAG(5.00)[];
	NEURAL_SPAM_LONG(3.50)[1.000];
	HFILTER_HELO_5(3.00)[localhost.localdomain];
	BAYES_HAM(-3.00)[99.99%];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	RDNS_NONE(2.00)[];
	ONCE_RECEIVED(1.20)[];
	NEURAL_SPAM_SHORT(0.88)[0.292];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email]
X-Spam: Yes

On Tue, 08 Sep 2026 14:03:23 +0200, Petr Mladek <pmladek@suse.com> wrote:
> klp_free_object_loaded() is supposed to clear changes made by
> klp_init_object_loaded(). It should call klp_clear_object_relocs()
> which is currently defined later.
> 
> Move the code for updating object relocations up.
> 
> This is just a preparation step. No functional changes.
> 
> [...]

Acked-by: Miroslav Benes <mbenes@suse.cz>

-- 
Miroslav

