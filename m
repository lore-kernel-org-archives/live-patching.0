Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313AA48595D
	for <live-patching@vger.kernel.org>; Fri,  2 Oct 2026 12:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790942541; cv=none; b=VCgKS3OnzwQdvYEpGQKCwfi9CTMdNWGnAuxh3hsMkCGwWlcULakAQMo06mHbaHM8Iq+KPEfg2C0i2NXLXL6Il8dnbwrBlTQ/kmv0Qk5UbvOzqkZ4DUvHbXhuQrpKPD0MeXrCCMzWTFUP78NS5AVWkZkPLHEPk2+LBbjlo4+V5Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790942541; c=relaxed/simple;
	bh=UrTRoPQCcvYvjcZr0ljQTdUrro9KAc12YRqUIh+tXgk=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=KmtyXPW/eEEBT8NA6RmervpTII5CIbzNRbj/IJDltICSyJwyyJJ/xmnlFaVENPLZyfh69pk+koNZtWWNS5nJh9C7grOihxP+opo42OoaxPVH+thJJUuEL8KIPUrGrpkrilqL4vmEfAp3AprQ/c1aJ8lttRvbJmr8vaLWzSrjGVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VaB97C6D; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=66yEN9Yt; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lZVcpVOM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CwjZ8pgU; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VaB97C6D";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="66yEN9Yt";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lZVcpVOM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CwjZ8pgU"
Received: from localhost.localdomain (unknown [IPv6:2a07:de40:b2bf:1b::12ef])
	by smtp-out2.suse.de (Postfix) with ESMTP id E3E641FE49;
	Fri,  2 Oct 2026 12:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790942534; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ut4PuwlIYnulzrlw+HFtMTOpAGVSh1sDlQtjkNjYdW4=;
	b=VaB97C6D7wmPhhMJixVzwt4NGstS/cUUOtJXKCSLKeyy6Xgyi+RjQQpHQwGvJettriL5V/
	BP59ntBWSg3G6BTIh8ESWYmebvw4cRpuBjdrKiEVjYhSFZ0YyJCVeeAglktVTf3U5npT8M
	doOiHvOb/Gzbl+4iV9/UQzt6lwDHFRc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790942534;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ut4PuwlIYnulzrlw+HFtMTOpAGVSh1sDlQtjkNjYdW4=;
	b=66yEN9Yt0PZFacfKI6hfnWj8PtGht1VjYLhIlW+iqi5kAQsC1lBZwOjJpk67CXJl5t8Nsp
	I3DYnGtQQEOrYYDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=lZVcpVOM;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=CwjZ8pgU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790942529; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ut4PuwlIYnulzrlw+HFtMTOpAGVSh1sDlQtjkNjYdW4=;
	b=lZVcpVOMZBHAdluQ9qzPsqf0c3VCVxlhMmE9imL1CCNhalzFyPL6lg6y59N5DIXulU27tV
	G7wwBZt+SW2vs/F9o2ZVxbgRkSnJoQ16ACT809mdPuvf6JW0ybFncRLes+MxDZt9y0RSX1
	UxBd+NkvVjF/xxWfBDzDDEfi5JELz54=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790942529;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ut4PuwlIYnulzrlw+HFtMTOpAGVSh1sDlQtjkNjYdW4=;
	b=CwjZ8pgUe2L5H8I/6+ZyAYcVAQ14zuJoz8LvrwjWsKjOowNHHpC60LkGlcM5XQM2KzJLSq
	Ij6OBzEuBI06y3DA==
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v10 5/9] livepatch: Implement provides and obsoletes
 for scoped atomic replace
From: Miroslav Benes <mbenes@suse.cz>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com, 
 joe.lawrence@redhat.com, song@kernel.org, live-patching@vger.kernel.org
In-Reply-To: <20260930030323.14396-6-laoar.shao@gmail.com>
References: <20260930030323.14396-1-laoar.shao@gmail.com>
 <20260930030323.14396-6-laoar.shao@gmail.com>
Date: Fri, 02 Oct 2026 14:01:58 +0200
Message-Id: <179094251818.135114.13273501464287074608.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=514; i=mbenes@suse.cz;
 h=from:subject:message-id; bh=UrTRoPQCcvYvjcZr0ljQTdUrro9KAc12YRqUIh+tXgk=;
 b=owEBiQF2/pANAwAIAYF9a9xEqxssAcsmYgBqv504YrSB6JADTpknyytGBzDRvzLCTp2dnL648
 JAD3BKwSFiJAU8EAAEIADkWIQTrvUMeMZRtMCl77t2BfWvcRKsbLAUCar+dOBsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQgX1r3ESrGyw6Dwf/UbNnxPPkAFEP2ExNGLwUDsARuvWKuPF
 pl7yZ/fEgR14BNKoJOa2S+LI+7GHdo3q1rPiv4Q+4ZRdO8GCsBFsb3CLAf0SwVHI7O/zT9oI47p
 jxX/l/iw7HAi4KLT5F7RJUHQKADhwWogoPsuW6VeHhtDF0z5kXu1ZfHOdy1Kg89wKJE+HB55HtB
 UIf7DZj03tmMjSMjSufkjhP5GRAyDwl9mNVxUWG5bMYWgBvru76w5UmNYB5z+BMfqrHjdLSlufw
 qRzn88a9q1uMTL7iyS9mE4VFSzfqzZ5nv62r09TU473TcS2EeAmx8SqYcc0Uv8rap8+JKKMZ6mf
 EWS7VTD7log==
X-Developer-Key: i=mbenes@suse.cz; a=openpgp;
 fpr=91BB0699882EF39D46654BB3FF98A38DA80834DA
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [18.30 / 50.00];
	SPAM_FLAG(5.00)[];
	NEURAL_SPAM_LONG(3.50)[1.000];
	HFILTER_HELO_5(3.00)[localhost.localdomain];
	BAYES_HAM(-3.00)[99.99%];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	NEURAL_SPAM_SHORT(2.41)[0.803];
	RDNS_NONE(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ONCE_RECEIVED(1.20)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	GREYLIST(0.00)[pass,meta];
	DIRECT_TO_MX(0.00)[b4 0.17-dev];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b2bf:1b::12ef:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
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
X-Spamd-Bar: ++++++++++++++++++
X-Rspamd-Queue-Id: E3E641FE49
X-Spam-Score: 18.30
X-Spam-Flag: YES
X-Rspamd-Action: add header
X-Spam-Level: ******************
X-Spam: Yes

On Wed, 30 Sep 2026 11:03:19 +0800, Yafang Shao <laoar.shao@gmail.com> wrote:
> The current bool replace flag is too coarse: it is either all or
> nothing. A livepatch with .replace=true replaces ALL existing
> livepatches, which is safe but inflexible. There is no way to have
> multiple independent livepatch sets coexist on the same system.
> 
> Replace it with a more flexible model using two new fields in
> struct klp_patch:
> 
> [...]

Acked-by: Miroslav Benes <mbenes@suse.cz>

-- 
Miroslav

