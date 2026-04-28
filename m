Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1899643DA52
	for <live-patching@vger.kernel.org>; Tue, 28 Apr 2026 12:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777380198; cv=none; b=dYW//pe3j03/6G9CpZTJQYphvZYAezpm78No2xrV/n/2FouYDocAbId/lhgBDPN+Axn6dGenq93uLl/8BU9Ynap5wx5abqfvM4KLGAOANFv20eYIzkwOAMia3qp4mq3cyg8Cc75CK/gChJTI8S1X1niWS1iurImVPChPDJom7Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777380198; c=relaxed/simple;
	bh=tdGVZVy28bfN60nbqJ9Ts6aexbFQJoqxcAN6jgwjTuM=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=mhkd80dMsJ84kxfO9FVOELGn8JJSFGwFLdOP/j4okzY3epk3crYYYXhc3+zLlSH3pnzdSzG+eKtLbPQNG99yseQ9SlpHi2tMSfJiPATGSH1u0atkrcv1FtOg8b+HlJmFDujjmuP654PFS5UKrCVKmfoKkmAjV4OOA73mn362ziA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2fSiSTrh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cfCFzEpr; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2fSiSTrh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cfCFzEpr; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2fSiSTrh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cfCFzEpr";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2fSiSTrh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cfCFzEpr"
Received: from localhost.localdomain (unknown [IPv6:2a07:de40:b2bf:1b::12ef])
	by smtp-out1.suse.de (Postfix) with ESMTP id CC0696A859;
	Tue, 28 Apr 2026 12:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777380178; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cVGUce4XOTCwiCyN0n778P8h1kW2jTFmOtJg5EYZA7Q=;
	b=2fSiSTrhDEJOpWbs9XA+iM+gjbPR8PIaFEvCwLlU3t3J7GqAJIkHF0NzOtDNR+imFjeJWp
	jttKiyw/wF2TgPDMpjaMUBnDeBA6vaxCvJPuRHf06jjDL4ByJHrSoilat7WMrYK7oWAPYM
	k4Kq6DEsFnHhqps8bynZeZiiS5m7aj8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777380178;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cVGUce4XOTCwiCyN0n778P8h1kW2jTFmOtJg5EYZA7Q=;
	b=cfCFzEpr4vLNlN74ScEcwMjbbtTN4c2bf2UcyL5/ltlqpNLR0NxRfwbZX4oE9k9J9IPyhc
	UL4/A471xBfWVVCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=2fSiSTrh;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=cfCFzEpr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777380178; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cVGUce4XOTCwiCyN0n778P8h1kW2jTFmOtJg5EYZA7Q=;
	b=2fSiSTrhDEJOpWbs9XA+iM+gjbPR8PIaFEvCwLlU3t3J7GqAJIkHF0NzOtDNR+imFjeJWp
	jttKiyw/wF2TgPDMpjaMUBnDeBA6vaxCvJPuRHf06jjDL4ByJHrSoilat7WMrYK7oWAPYM
	k4Kq6DEsFnHhqps8bynZeZiiS5m7aj8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777380178;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cVGUce4XOTCwiCyN0n778P8h1kW2jTFmOtJg5EYZA7Q=;
	b=cfCFzEpr4vLNlN74ScEcwMjbbtTN4c2bf2UcyL5/ltlqpNLR0NxRfwbZX4oE9k9J9IPyhc
	UL4/A471xBfWVVCw==
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 13/48] objtool/klp: Fix XXH3 state memory leak
From: Miroslav Benes <mbenes@suse.cz>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
 live-patching@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
 Joe Lawrence <joe.lawrence@redhat.com>, Song Liu <song@kernel.org>, 
 Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
In-Reply-To: <b998db762616ed3c4972b64a3f64759d39bfe674.1776916871.git.jpoimboe@kernel.org>
References: <cover.1776916871.git.jpoimboe@kernel.org>
 <b998db762616ed3c4972b64a3f64759d39bfe674.1776916871.git.jpoimboe@kernel.org>
Date: Tue, 28 Apr 2026 14:42:55 +0200
Message-Id: <177738017546.11371.4925848878154732304.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=243; i=mbenes@suse.cz;
 h=from:subject:message-id; bh=tdGVZVy28bfN60nbqJ9Ts6aexbFQJoqxcAN6jgwjTuM=;
 b=kA0DAAgBgX1r3ESrGywByyZiAGnwq1HINLbcSvDaiGj3p5Sg9Nroeh3RvnbkilbaoR80eag5u
 IkBTwQAAQgAORYhBOu9Qx4xlG0wKXvu3YF9a9xEqxssBQJp8KtRGxSAAAAAAAQADm1hbnUyLDIu
 NSsxLjEyLDIsMgAKCRCBfWvcRKsbLDfBCAC6KXiXjm1S5tY6G1EmGRM8IlQxz0E/aPTK3fNnTY6
 G2N4Xycd7UOzdglWngAgG3TECZfLTkBDyd9GsVmK70ct5IbM7D0sfh+E7DheeV69+uDjQzLkCmR
 wOXs71os7Vy9AkKl1vb34cByNQtozpXrDq4ozEsl1c+PiT2KBpy2IDmxEUZ6Y5aYmsna2AW6HAy
 NOcLV8NYTvnQYogcSTn06GD3KAp2BnymdeGCfahfpvL+45gYiE2RWUAatHqtQH6jjsa7H1ycxHM
 W3VYRQnsMg1Qppe3BBKRzrmJ5Q7u1l4hwq4JflxM8hOGOFNJRoVrI62b0HtWil+DfA9P/zgRicO c
X-Developer-Key: i=mbenes@suse.cz; a=openpgp;
 fpr=91BB0699882EF39D46654BB3FF98A38DA80834DA
X-Spamd-Bar: ++++++++++++++++++++
X-Rspamd-Queue-Id: CC0696A859
X-Rspamd-Action: add header
X-Spam-Flag: YES
X-Spam-Score: 20.70
X-Spam-Level: ********************
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [20.70 / 50.00];
	SPAM_FLAG(5.00)[];
	NEURAL_SPAM_LONG(3.50)[1.000];
	HFILTER_HELO_5(3.00)[localhost.localdomain];
	NEURAL_SPAM_SHORT(3.00)[1.000];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	RDNS_NONE(2.00)[];
	ONCE_RECEIVED(1.20)[];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	MX_GOOD(-0.01)[];
	BAYES_SPAM(0.01)[42.13%];
	DIRECT_TO_MX(0.00)[b4 0.15.2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	GREYLIST(0.00)[pass,meta];
	R_DKIM_ALLOW(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_SEVEN(0.00)[9];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_ZERO(0.00)[0];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email]
X-Spam: Yes

On Wed, 22 Apr 2026 21:03:41 -0700, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> The XXH3 state allocated in checksum_init() is never freed.  Free it in
> checksum_finish().

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

-- 
Miroslav

