Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B873F493D38
	for <live-patching@vger.kernel.org>; Thu, 10 Sep 2026 14:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789050940; cv=none; b=Z12vGcw2fFiafmkKKYpM2i/t0MinDSi4Gm/sQ5NydKZH/IaFhSWeDautp+uMyULUuaa7CHVlKQhH84Xd3SUk/B08z9QMAnk0AAXxu+LqtAw87qwD8T2C/YC0xjyERcYKjUDlKVCOts52p6c2C13Wy4DHWh1Bp+Tl20pSxN0NQTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789050940; c=relaxed/simple;
	bh=d0qq7l4EMSnbx7kf8u7QtuJ2r/Loq7RkomqrBYj+9xw=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=fk4mi7xOEIF0Ju/onerWAIyZrhZhW+exPoq1IDOCTyYYAu9L0t9zdOJsIE2WBUNi137LuyflUy1mBUL3AEezMc/RS2ZrL9t08pyxM0fCnWqj3lQjbGB/bNETW6DwYuhoVu96leVdYxvDbfRiaDEccUoyDOkM+QDUH7h8Lrzkuhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=q4zPNjcm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BAxtsp+R; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=M7ou+Xwv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NSegt3uR; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="q4zPNjcm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BAxtsp+R";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="M7ou+Xwv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NSegt3uR"
Received: from localhost.localdomain (unknown [IPv6:2a07:de40:b2bf:1b::12ef])
	by smtp-out2.suse.de (Postfix) with ESMTP id 5BA241FDEE;
	Thu, 10 Sep 2026 14:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789050932; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=naNgGb18c5hseLGubNK40HH6qX7ZwZUvj5DSjTRQFKY=;
	b=q4zPNjcmqGe0QNe+j2rMb1QTzPhO600VGxDsUZYBVk6Ijn7d3lZo8Lb2bfwmriu2z1jtXz
	kkZwvxIREE/vsr8LauQsFUdY2HkQkfW2Z2lr3haTS0ixHNoZTY/cj67du6ynswNdfksZzI
	XJu3p7ziFvmZWc7muo/CtsTlw4oze20=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789050932;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=naNgGb18c5hseLGubNK40HH6qX7ZwZUvj5DSjTRQFKY=;
	b=BAxtsp+RsaYeunaQwgcnPgzk7TtLBBVlV+HGjFeLoS/Wi+njkm7m1+2Zs4eWCIxNCxARY4
	EIM1Ji5ADNGydNDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=M7ou+Xwv;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=NSegt3uR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789050928; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=naNgGb18c5hseLGubNK40HH6qX7ZwZUvj5DSjTRQFKY=;
	b=M7ou+Xwv85WvQHyQb8KkXoDLDVd22XjgLmjkF09EaCNTF/ECfJlklU+EvPrrt1an5F9YbT
	M7ysdmebZ0kpevBnKbEb92o2hLtFro5oh+mXmmO2UtXalipp0To6InDF6/e8aBbBFJqyDf
	ZK2Em8NNQmCaH7iAsxXjMq4CR3ye42Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789050928;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=naNgGb18c5hseLGubNK40HH6qX7ZwZUvj5DSjTRQFKY=;
	b=NSegt3uRMTiHo95lXq3T59D46pQgvWWcErnxyloZ1N6A/ZbL/+Wke+YlsDUuz3dQXNWYu3
	vasy54gomtzk1MCw==
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [RFC PATCH v2 1/7] objtool/klp: simplify read_exports file
 handling
From: Miroslav Benes <mbenes@suse.cz>
To: Joe Lawrence <joe.lawrence@redhat.com>
Cc: live-patching@vger.kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>, 
 Song Liu <song@kernel.org>, Miroslav Benes <mbenes@suse.cz>, 
 Petr Mladek <pmladek@suse.com>, Yafang Shao <laoar.shao@gmail.com>
In-Reply-To: <20260826195000.455905-2-joe.lawrence@redhat.com>
References: <20260826195000.455905-1-joe.lawrence@redhat.com>
 <20260826195000.455905-2-joe.lawrence@redhat.com>
Date: Thu, 10 Sep 2026 16:35:26 +0200
Message-Id: <178905092669.252327.914570466322543182.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=246; i=mbenes@suse.cz;
 h=from:subject:message-id; bh=d0qq7l4EMSnbx7kf8u7QtuJ2r/Loq7RkomqrBYj+9xw=;
 b=owEBiQF2/pANAwAIAYF9a9xEqxssAcsmYgBqosAvFdw2JqcZebgr22BPtB3mG41RVbNu7BfFx
 RJKyyCMvP+JAU8EAAEIADkWIQTrvUMeMZRtMCl77t2BfWvcRKsbLAUCaqLALxsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQgX1r3ESrGyydHQgAksGRSIKHLZLJcIgQHeapzWzlof/nCIG
 yFwvXKpYq0XDhZSWRdWWkwHb56wX//w6YVo/uC4OrmVGTtt/+89mQ2a+i06LpJpxFdaSmYFJYzz
 BXW1LhmyBBHxruwv73W4XotdR9sfmP01GIEmMrrqClB0PD+wPOpag+1G+zkovv3e9YXr6TK9HPV
 l26cqeS/m4hV5Su38at9Ksw9V6gKiwGzK+/CIpwM12YIViOerdTDhcJrFFeC9Mdxtvpk3siwBgs
 BmaA8xZyAYrWfdyXjPCmuNIunRyiS6c52TXQFeXyCkA4nN42k9K4iGq5/VnvgwObrbbX03l3fRS
 pGo93PDWcIw==
X-Developer-Key: i=mbenes@suse.cz; a=openpgp;
 fpr=91BB0699882EF39D46654BB3FF98A38DA80834DA
X-Spam-Level: ****************
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: add header
X-Rspamd-Queue-Id: 5BA241FDEE
X-Spamd-Result: default: False [16.44 / 50.00];
	SPAM_FLAG(5.00)[];
	NEURAL_SPAM_LONG(3.50)[1.000];
	HFILTER_HELO_5(3.00)[localhost.localdomain];
	BAYES_HAM(-3.00)[99.98%];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	RDNS_NONE(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ONCE_RECEIVED(1.20)[];
	NEURAL_SPAM_SHORT(0.55)[0.183];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b2bf:1b::12ef:from];
	DIRECT_TO_MX(0.00)[b4 0.17-dev];
	GREYLIST(0.00)[pass,body];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
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
X-Spamd-Bar: ++++++++++++++++
X-Spam-Flag: YES
X-Spam-Score: 16.44
X-Spam: Yes

On Wed, 26 Aug 2026 15:49:54 -0400, Joe Lawrence <joe.lawrence@redhat.com> wrote:
> Consolidate the Module.symvers handling in klp-diff's read_exports()
> with a single error path.

Acked-by: Miroslav Benes <mbenes@suse.cz>

-- 
Miroslav

