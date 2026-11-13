Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794565443;
	b=t/VLrs4ZxXR0TBJYO95KCX4Q9LnXx7uGIuqJV7acBfF5SggA2AYUtkQEN2LrAwoeUKH9
	 ezRW8iuMzODw7tOf5zg8hsA8vroziiVI321UuGpX1pQUEGnIHVWs8oo5KHgUFQx56cP/0
	 RLJ1omLm/nTL00c8dRnHANF/IrYDCGgaQ4IN658FUPTwBhJ3LbZPxIMMffr0p4awJlQI9
	 tEjDhTud8xfPe+sXYXS6R400LPQGpliLCgaryoiTO4lO0NTY5VD59BJIoAwE6wVY2rPWd
	 EfujxK6pZHUYHtIo7m+unbVAW5lBw6xQbJ6xwXiRDf9DuU2AY2uTBBoXOChAx01kyhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794565443;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Subject:From:To:Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Rspamd-Queue-Id:X-Spam-Level:
	 X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:X-Spamd-Result:
	 X-Spam-Score;
	bh=N3/94cOISzkHPsJruF6FUPYJeaewRIEjrk2ezTPCnPw=;
	b=vaJpiXj1orhTif/hhnL3tHQcJLJJSbhkawSJ6E+A8nauyB4vASXiuThLhTFG4qcLhwLP
	 zrSmWRH9IkPFpJGb57O+peQ6DC9ZI6JNoGBXfo7XKykQK+LnPNzp6cfqhp2IYLviDLaH+
	 mo8cOcq+TktjP/H4LZSe0WRvUZ+UyFvuC68lfjDK87VN+yLYUS1tM9lX4cb6oNZtgCY/v
	 U2et2apsgSb/ZXbU1xDlc8/0Xapmls55PBV5gCnGNozpl7tHAUAhIHxSlKxNpvKPTmLDl
	 SU8UOH2GTy/egvjDDomWV9r7N7XbJhICe0+R/jjf08TGnk+iG7QEQyXqRLu3mnFep/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=sY6roTin;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=LeE0CA0s;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=ZDO43cYX;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=RRIoyPyh;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0F3606A31C;
	Fri, 13 Nov 2026 10:24:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D0F3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=sY6roTin;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=LeE0CA0s;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=ZDO43cYX;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=RRIoyPyh
Received: from localhost.localdomain (unknown [IPv6:2a07:de40:b2bf:1b::12ef])
	by smtp-out2.suse.de (Postfix) with ESMTP id 06CCC1FCFD;
	Fri, 13 Nov 2026 10:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794565440; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N3/94cOISzkHPsJruF6FUPYJeaewRIEjrk2ezTPCnPw=;
	b=sY6roTin1EUAXOoWeV/I6dYTeNBBfAEsC7OKqYRCfWNnLR174HL+NT1f/MvhLYxs3fpVMX
	ptKigfbiV3AS37R8uon7PpkLlfkYdf5GLlt11FC0pYmgQnbRkwrtSOojxpYSWBXUxfSAcd
	vopg6qLxAXMm+F2axv30wcJnIez3Go8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794565440;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N3/94cOISzkHPsJruF6FUPYJeaewRIEjrk2ezTPCnPw=;
	b=LeE0CA0sQtC5nCaCj8TAU7bKtLu54wJnXNfJSSF+ZDQsix4BUCN1JK8MJQjeVwwk/PS9DC
	GcUAR3qYJtuTAhBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ZDO43cYX;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=RRIoyPyh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794565439; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N3/94cOISzkHPsJruF6FUPYJeaewRIEjrk2ezTPCnPw=;
	b=ZDO43cYX1lEEzye+91fnRSeXXhvaAeCMZ6UKUzwZ07AE83AGxBHidN2xNf3rC+JKAYsN1D
	WdVDv9FnFShEz2VomRys1za17ghSdqvaQWT9gdSAYY0r6d57FHSi5JryRlrutwnKItBw3V
	5Pb0M1qFZWq0yWuwVwsBNJCI45Asi4M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794565439;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N3/94cOISzkHPsJruF6FUPYJeaewRIEjrk2ezTPCnPw=;
	b=RRIoyPyhpwOOQUeh65lY+MQ2Qs1ZPbYJAeNfnxA93zDELBuruBCOrg/GA6u2ReHMiNUEtP
	QI1E1axWsV2n49Cg==
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
Subject: Re: [PATCH v13 8/9] selftests/livepatch: Add state test for
 provides/obsoletes
From: Miroslav Benes <mbenes@suse.cz>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: jpoimboe@kernel.org, mbenes@suse.cz, pmladek@suse.com, 
 joe.lawrence@redhat.com, song@kernel.org, live-patching@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261026133651.40061-9-laoar.shao@gmail.com>
References: <20261026133651.40061-1-laoar.shao@gmail.com>
 <20261026133651.40061-9-laoar.shao@gmail.com>
Date: Fri, 13 Nov 2026 11:23:54 +0100
Message-Id: <179456543428.25000.7614179721315186305.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=546; i=mbenes@suse.cz;
 h=from:subject:message-id; bh=CCuI8/SwNh6r9BF9eS2SDbHqYeTlzZsmDjcrUt6eo0I=;
 b=owEBiQF2/pANAwAIAYF9a9xEqxssAcsmYgBq9uU7VOx1qLbAnMAV0t5/3e+sV3QvVpMeZPSGQ
 O4rm3DQngeJAU8EAAEIADkWIQTrvUMeMZRtMCl77t2BfWvcRKsbLAUCavblOxsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQgX1r3ESrGyyOyAgAt9miSLEFEifqdX5C9Mv7hrzL/pUt+Sv
 7LUxV0K1CseN+UtxsKGbzsmVg3m1hqKqqZnQHy7C/JkWvU4wCujP9+RufJIlADYL2Z4HOjs9rUg
 aeaeBE3TzfTMWMuX2xvly0sgzoaBTQAl3f4DJxXx7u1DfhP1qr4wUX8dBaITJTBieHYF7Xjv6y6
 mnUf43pOHvPIPOCwqnkGpDQyH77SIjVlaJhXxzGM7Hty6T65LYXJ1ukbZkfYZbrqfuNaMk3ah63
 2RhZZG52/uZlx7Bs7Mm4RLWfwYUOXOodEBMWp2Mfjnr4XI13rbgnwxU81vDYVi936oW4uRB5nOF
 XvSjjSPGqyw==
X-Developer-Key: i=mbenes@suse.cz; a=openpgp;
 fpr=91BB0699882EF39D46654BB3FF98A38DA80834DA
X-Rspamd-Queue-Id: 06CCC1FCFD
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.75 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	HFILTER_HELO_5(3.00)[localhost.localdomain];
	BAYES_HAM(-3.00)[99.99%];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ONCE_RECEIVED(1.20)[];
	RDNS_NONE(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-0.997];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.15)[-0.738];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,localhost.localdomain:helo]
X-Spam-Score: -3.75

On Mon, 26 Oct 2026 21:36:50 +0800, Yafang Shao <laoar.shao@gmail.com> wrote:
> Livepatches with different provides ids must not share the same state
> id, unless the second livepatch replaces the first one via obsoletes.
> 
> Add provides/obsoletes module parameters to test_klp_state and
> test_klp_state2, and cover both cases: reusing a state id across
> different provides ids is rejected, while it is allowed when the new
> livepatch obsoletes the old one.
> 
> [...]

Acked-by: Miroslav Benes <mbenes@suse.cz>

-- 
Miroslav

