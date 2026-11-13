Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794565450;
	b=E5LAut4gsHIsz62M6/G3zpOy611qeI+no8R2EZ+RDZ/eh/0yMWwl4W4skCligiLOFVoU
	 shM0apHr6O/cSEy/MftNmZy731G7pT6Lv6iO76nG0Ssd9f5jlDfWrveX00IrLSITMYp5/
	 l2I9ecXZVpQrlj1OBVnd8PM5TU/6bEqghvNhKftBvl43/YrFwKzPGUgKQjlzI9f1hBBf8
	 Yu56FQlV5MQA3t08FMnBirQ0dnSf0WxhqgPLGB/FnQdKahE//D3wIEhWTlqhT4JV6xdel
	 y1ZA6+QLDGp9I/feGfAJqx/ukd47TXUMynGaVvL94skujYnx5uBf51hc9hNVAiEzxwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794565450;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Subject:From:To:Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Spamd-Result:X-Rspamd-Server:
	 X-Rspamd-Action:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Rspamd-Queue-Id;
	bh=HSieFlOlMjp828o7t2yDrBal0B1VDxJlxpte1OL0BeE=;
	b=4qqVH6JVFTQW/2AgCDKTyNfhAvhCc2kWzIWrSiaxy1bBSD0QBj5o5TVqT0XYmzcWicw0
	 0x8PXdjrCghfQsTqz4IzQmdAbRYFyJDPQ5ww5jSTawIuywjpU33D/p6W+HZqNmGUf9G4Q
	 fqRAyhTxlun5JtgSc0zIHk9is/pVT8M9syfgrbgTS7OVJjfvqFHU3z0WSLLqOi3oyV4vl
	 6/qsE4hmw8xmdcn1N6tI5nylVfEin27t+koGigEAL8u0HVK6sQPxz3cLtA0jPFX2NI3FF
	 KJsa88tNRCFNHC5Xr1MJEePlvxVLjno5M/9YDviok32JLRNtDk2twav+fQ/xm0cPsRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=IGquWqVc;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=dHDWs5lP;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=IGquWqVc;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=dHDWs5lP;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD076606A31C;
	Fri, 13 Nov 2026 10:24:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD076606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=IGquWqVc;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=dHDWs5lP;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=IGquWqVc;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=dHDWs5lP
Received: from localhost.localdomain (unknown [IPv6:2a07:de40:b2bf:1b::12ef])
	by smtp-out2.suse.de (Postfix) with ESMTP id 7BBC01F8C2;
	Fri, 13 Nov 2026 10:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794565440; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HSieFlOlMjp828o7t2yDrBal0B1VDxJlxpte1OL0BeE=;
	b=IGquWqVcRngtiuNWq6fT58Tf9NsooO5dW9agDePXWSsd2W/Vg4AGfUjHuU3SMnhTVttqlZ
	5ih4UnDffR2Cdp4Nz8OW1Y7rT8AzdOtEaOxZngOYEUcNwA72jylvMLAEdJkqQxhqt0li4J
	I+qJWHyyo1GTAH1SzuipjwguY38iqOQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794565440;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HSieFlOlMjp828o7t2yDrBal0B1VDxJlxpte1OL0BeE=;
	b=dHDWs5lPG0J4JcvtvPSJ5aNB/FJ9t59Eb3DwKAjI0qm/m4g8fQ15gwIgLw3W4FUzBnLF2+
	N/WhYZIlUr5nzGAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=IGquWqVc;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=dHDWs5lP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794565440; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HSieFlOlMjp828o7t2yDrBal0B1VDxJlxpte1OL0BeE=;
	b=IGquWqVcRngtiuNWq6fT58Tf9NsooO5dW9agDePXWSsd2W/Vg4AGfUjHuU3SMnhTVttqlZ
	5ih4UnDffR2Cdp4Nz8OW1Y7rT8AzdOtEaOxZngOYEUcNwA72jylvMLAEdJkqQxhqt0li4J
	I+qJWHyyo1GTAH1SzuipjwguY38iqOQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794565440;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HSieFlOlMjp828o7t2yDrBal0B1VDxJlxpte1OL0BeE=;
	b=dHDWs5lPG0J4JcvtvPSJ5aNB/FJ9t59Eb3DwKAjI0qm/m4g8fQ15gwIgLw3W4FUzBnLF2+
	N/WhYZIlUr5nzGAw==
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v13 9/9] selftests/livepatch: Add function test for
 provides/obsoletes
From: Miroslav Benes <mbenes@suse.cz>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: jpoimboe@kernel.org, mbenes@suse.cz, pmladek@suse.com, 
 joe.lawrence@redhat.com, song@kernel.org, live-patching@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261026133651.40061-10-laoar.shao@gmail.com>
References: <20261026133651.40061-1-laoar.shao@gmail.com>
 <20261026133651.40061-10-laoar.shao@gmail.com>
Date: Fri, 13 Nov 2026 11:23:54 +0100
Message-Id: <179456543429.25000.14551010344541751203.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=435; i=mbenes@suse.cz;
 h=from:subject:message-id; bh=n+JFrC5MCem/PMwyOIP3p6x5OWYO9e4pqtr2CN/3b5U=;
 b=owGbwMvMwMHYWJt9x2W1tA7jabUkhqxvT+1uvtl5/grDxrYNiyqUt0z8tWHy9EeOhVfFzCNaT
 Bh9opV4Oxn9WRgYORgsxRRZXu91ljOckmugWf3uLswgViaQKdIiDQxAwMLAl5uYV2qkY6Rnqm2o
 Zwhk6BgxcHEKwFQrNbL/FWFobVt75nZSgPvsCcxHl56+ukr6kmbAVca2a88r1NROV/M9vcwdeyy
 mLHCrTNHfbg83bs2bOuWMjTFvP/w/z+ujGGO2a9K55+devuri8VP54LE0ZfKWkMNGxs90Dx+bLr
 1xU7HTJpYZ/ku3rZk/8cLtb9EdKrPEIm7rcGxI53/tr2/XYDvj5H/uwy7z4h7IczHcOfa9vdk2X
 SNgb8yLllpRz6iXc12sY+Y/XCZ6JjrQpO+MyWb9x2FTHF5fvKtu63DHVvnZnNvmJg3z7XV+5LWf
 ush5W+lcyhzJ9xU/Qs4+nqwZw1g5Sy1JVibLOHzX3aXbnMSm//1083fKs/ZTByfPKY318Ck/zfI
 sTT3cFAA=
X-Developer-Key: i=mbenes@suse.cz; a=openpgp;
 fpr=91BB0699882EF39D46654BB3FF98A38DA80834DA
X-Spamd-Result: default: False [-3.75 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	HFILTER_HELO_5(3.00)[localhost.localdomain];
	BAYES_HAM(-3.00)[100.00%];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ONCE_RECEIVED(1.20)[];
	RDNS_NONE(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-0.997];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.15)[-0.736];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DIRECT_TO_MX(0.00)[b4 0.17-dev];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b2bf:1b::12ef:from];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,localhost.localdomain:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.75
X-Spam-Level: 
X-Rspamd-Queue-Id: 7BBC01F8C2

On Mon, 26 Oct 2026 21:36:51 +0800, Yafang Shao <laoar.shao@gmail.com> wrote:
> Livepatches with different provides ids must not modify the same
> function, unless they share the same provides id or the second
> livepatch obsoletes the first one.
> 
> Add test scenarios that verify this rule on the combination of
> patched functions and provides ids.
> 
> [...]

Acked-by: Miroslav Benes <mbenes@suse.cz>

-- 
Miroslav

