Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858BB38F252
	for <live-patching@vger.kernel.org>; Tue,  5 May 2026 11:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777980717; cv=none; b=n2G45hN9Y6DfJefxuUvSb3C+sq4RiLX3pLpST7OMb83CJFrVDnlVZUq+G/3ZRJvDc/6ULrjO5Q5FOIrRc9o8LsmMGtTyKRbn5gWR1V8VuMk09KdppUXoYym2+rGYGxN9jlOlCdluwJOluuU5rDY3WFc/v6CFPdy8v8VtsjhFF14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777980717; c=relaxed/simple;
	bh=EiQRpB6T9GPGyRMGPER6ZdkwM0lvxzzVaZwhxzu9w4E=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=OMPOuccxU/EFEmU9xfgXha3G8E82Q6ni0G34XBsaRsWHEnHF+T1ijASCchDGJ8e/f3WSSjUghsIoU9Q1wauufiy+QTN4+hpAwrINgppFToZxTgbCN8tyyUqz2iKAa43atGgHKzq7VY0iaqj9/hCAGiQdjtPt9F3Vq7d3jFgs1jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UBzRRs5l; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Wvhle45P; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UBzRRs5l; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Wvhle45P; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UBzRRs5l";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Wvhle45P";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UBzRRs5l";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Wvhle45P"
Received: from localhost.localdomain (unknown [IPv6:2a07:de40:b2bf:1b::12ef])
	by smtp-out2.suse.de (Postfix) with ESMTP id 402225BEC6;
	Tue,  5 May 2026 11:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777980709; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IATmQkoaOovijqJLbnpBI4VQAfSr9NAt610zMZgT63Y=;
	b=UBzRRs5lC70aNLsHfdVyL92vJlD4xTKuI+iZyfxsiodXusH28hDuQ4S8+00SmqirJTNaG2
	XBmPMTcnRxZATJpz6jR2T7B8WgOWOqW9FlrvPTBj7rfHTFfOetRL+gyJBAtcIpYajmXfeT
	lXRQd4B4Gog4nToN3vpm1fFG3TXrYL0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777980709;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IATmQkoaOovijqJLbnpBI4VQAfSr9NAt610zMZgT63Y=;
	b=Wvhle45PEUEw+zNugwKWVhFkEtdFu7WEbnT2uWwuHm4wYKSdNM/CfMGSVQScnp+gPm0mFM
	UVfPbvhpBE0F4oBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=UBzRRs5l;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Wvhle45P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777980709; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IATmQkoaOovijqJLbnpBI4VQAfSr9NAt610zMZgT63Y=;
	b=UBzRRs5lC70aNLsHfdVyL92vJlD4xTKuI+iZyfxsiodXusH28hDuQ4S8+00SmqirJTNaG2
	XBmPMTcnRxZATJpz6jR2T7B8WgOWOqW9FlrvPTBj7rfHTFfOetRL+gyJBAtcIpYajmXfeT
	lXRQd4B4Gog4nToN3vpm1fFG3TXrYL0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777980709;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IATmQkoaOovijqJLbnpBI4VQAfSr9NAt610zMZgT63Y=;
	b=Wvhle45PEUEw+zNugwKWVhFkEtdFu7WEbnT2uWwuHm4wYKSdNM/CfMGSVQScnp+gPm0mFM
	UVfPbvhpBE0F4oBg==
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 29/53] klp-build: Reject patches to vDSO
From: Miroslav Benes <mbenes@suse.cz>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
 live-patching@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
 Joe Lawrence <joe.lawrence@redhat.com>, Song Liu <song@kernel.org>, 
 Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
In-Reply-To: <a22e56b997cb56f2db1e154a847b354cf9b5b074.1777575752.git.jpoimboe@kernel.org>
References: <cover.1777575752.git.jpoimboe@kernel.org>
 <a22e56b997cb56f2db1e154a847b354cf9b5b074.1777575752.git.jpoimboe@kernel.org>
Date: Tue, 05 May 2026 13:31:45 +0200
Message-Id: <177798070548.9921.13541200938561398121.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=351; i=mbenes@suse.cz;
 h=from:subject:message-id; bh=EiQRpB6T9GPGyRMGPER6ZdkwM0lvxzzVaZwhxzu9w4E=;
 b=owGbwMvMwMHYWJt9x2W1tA7jabUkhsyfV5W3TZf6Zr5kRcPS9XP4pBfXrH3/Z8o5J/vU+jMMt
 mczRB+v6GT0Z2Fg5GCwFFNkeb3XWc5wSq6BZvW7uzCDWJlApkiLNDAAAQsDX25iXqmRjpGeqbah
 niGQoWPEwMUpAFOtx8vBMPWJrZgPF8s5tcbQgzdbzBbnyt1dmXLeeLfHBb5uyfTloeyHKxdq3BD
 yyVwmuMSn8HNj1rHCK2XLj+3vOxHToP8w4ebkoC8fPf7eTCw/U8r16n42j39aB0d3yZaqq7dep/
 ztUTgiX2uV/I4jfzsf3+qZHz1Mo7eft29k6utoe/rQ3sDio3/6SUE1hpg/dzY+bV1frLL3QtzNN
 Yamc/TzrFyvuWa+Xv9z9XKnLqkJuyT3W6vuvmZddTh3xcoZP9fu6Nj0OFjkZUMc65x1AXw5KiKb
 Wl1miX43LWFXs1pa5jRt74JDs8KC4n687s9ety6kkImzU+Te6RSf41va5ssv2rP+E6vWifMLDe5
 cLXs9BwA=
X-Developer-Key: i=mbenes@suse.cz; a=openpgp;
 fpr=91BB0699882EF39D46654BB3FF98A38DA80834DA
X-Spamd-Result: default: False [18.80 / 50.00];
	SPAM_FLAG(5.00)[];
	NEURAL_SPAM_LONG(3.50)[1.000];
	HFILTER_HELO_5(3.00)[localhost.localdomain];
	NEURAL_SPAM_SHORT(3.00)[0.999];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	RDNS_NONE(2.00)[];
	BAYES_HAM(-1.59)[92.33%];
	ONCE_RECEIVED(1.20)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_ZERO(0.00)[0];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DIRECT_TO_MX(0.00)[b4 0.15.2];
	GREYLIST(0.00)[pass,meta];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b2bf:1b::12ef:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[localhost.localdomain:helo,suse.cz:dkim,suse.cz:email]
X-Spamd-Bar: ++++++++++++++++++
X-Rspamd-Queue-Id: 402225BEC6
X-Spam-Score: 18.80
X-Spam-Level: ******************
X-Rspamd-Action: add header
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Flag: YES
X-Spam: Yes

On Thu, 30 Apr 2026 21:08:17 -0700, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> vDSO code runs in userspace and can't be livepatched.  Such patches also
> cause spurious "new function" errors due to generated files like
> vdso*-image.c having unstable line numbers across builds.

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

-- 
Miroslav

