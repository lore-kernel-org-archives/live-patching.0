Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AF9387367
	for <live-patching@vger.kernel.org>; Tue,  5 May 2026 11:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777980418; cv=none; b=hjIg7o70rE7r+9tdkq19BMrG1VvcPyLHZ/B8sUsQFEVyEX/E4SIhNbUfrzk436i32zgL6Ju+XXigPISYo1iByq0uneGTp+E8x/LZiQdZnW8uC25QwwxZDD6ZYWIvffy9hvMz3xypcgfqWw6EI8amgcJXMEhcjBmnhWqKcdixsrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777980418; c=relaxed/simple;
	bh=YOD1kRWGa79JovfiCNYIqOoirWA3LdZZrGDAYUfMFTw=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=MZXjcPMGvwByC7L+JnJHlvzQR7RNwUDsDH82lCa8wKzZ4/hU7zh1q1u3sNWfPXKujgkAXd4YfLPer4A+z8pmT5FugTLZ/mEb5DYAsB6NfOUg/omfsdrndDTymSq6Rj3u870cvQMsjP1DEV8npHWzMXrgZYhvb+VsxWzOUCRZaGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PHq3CVhU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1Wtob/eX; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PHq3CVhU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1Wtob/eX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PHq3CVhU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1Wtob/eX";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PHq3CVhU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1Wtob/eX"
Received: from localhost.localdomain (unknown [IPv6:2a07:de40:b2bf:1b::12ef])
	by smtp-out2.suse.de (Postfix) with ESMTP id 240C35CB75;
	Tue,  5 May 2026 11:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777980397; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nFMlzel4NC5hjgfoy3b0qOi8USUThFRJffPLHE2imLk=;
	b=PHq3CVhUibD/BkOMxTv6wrZ5Q+ZIsGZxQKJGFNAMYjmwRxQDLO5ovEIx7EMZz89wSpAN89
	lfTInA8zESZlvR7ZGMRQM8KhzosmsMCDYgUju38Qg7oxCD38mBG+CeCzpn9ACTodqjnBvy
	hRpADIi3dsK6o+TYybPlYBd+T+69gFA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777980397;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nFMlzel4NC5hjgfoy3b0qOi8USUThFRJffPLHE2imLk=;
	b=1Wtob/eXSvwDneSKqczTQ6RD7b+GA4na34E/d8uOBzByOStImKvo01D+0Aq2SJuB7vDF0I
	PDU60RaLTLTX6yAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=PHq3CVhU;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="1Wtob/eX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777980397; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nFMlzel4NC5hjgfoy3b0qOi8USUThFRJffPLHE2imLk=;
	b=PHq3CVhUibD/BkOMxTv6wrZ5Q+ZIsGZxQKJGFNAMYjmwRxQDLO5ovEIx7EMZz89wSpAN89
	lfTInA8zESZlvR7ZGMRQM8KhzosmsMCDYgUju38Qg7oxCD38mBG+CeCzpn9ACTodqjnBvy
	hRpADIi3dsK6o+TYybPlYBd+T+69gFA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777980397;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nFMlzel4NC5hjgfoy3b0qOi8USUThFRJffPLHE2imLk=;
	b=1Wtob/eXSvwDneSKqczTQ6RD7b+GA4na34E/d8uOBzByOStImKvo01D+0Aq2SJuB7vDF0I
	PDU60RaLTLTX6yAw==
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 38/53] objtool: Add is_cold_func() helper
From: Miroslav Benes <mbenes@suse.cz>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
 live-patching@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
 Joe Lawrence <joe.lawrence@redhat.com>, Song Liu <song@kernel.org>, 
 Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
In-Reply-To: <a84513224f38c7c7ca2cf2a4930f87d43a76908b.1777575752.git.jpoimboe@kernel.org>
References: <cover.1777575752.git.jpoimboe@kernel.org>
 <a84513224f38c7c7ca2cf2a4930f87d43a76908b.1777575752.git.jpoimboe@kernel.org>
Date: Tue, 05 May 2026 13:26:30 +0200
Message-Id: <177798039059.9921.13891493188550666521.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=212; i=mbenes@suse.cz;
 h=from:subject:message-id; bh=YOD1kRWGa79JovfiCNYIqOoirWA3LdZZrGDAYUfMFTw=;
 b=owGbwMvMwMHYWJt9x2W1tA7jabUkhsyfl9/MtW4q8Gp1a9xo+ac399b0c1eDc4MFD31fIX66j
 GWxaEp5J6M/CwMjB4OlmCLL673OcoZTcg00q9/dhRnEygQyRVqkgQEIWBj4chPzSo10jPRMtQ31
 DIEMHSMGLk4BmOpP79j/aebM3fRh/uvLZtHBz59/Ef38SzTs4PmZ5udtjbdfVD7/SnvHFP8pkaJ
 iTxK5jWNqUl1DOxTuRPw/oXGWq/eOW6TZ6ufHGDbWNho03M5JycwLun+U5V/rtN2z11ZwzWnJOm
 O0xvTu1tQfFv+42Otd4jOa/t+17M7TWqqvvdTuw7EvUx53/Hu2wPxTwnuej8+9GzT9+rOyKzLVX
 0iefv7A9f95ne5splsSST4iyi9yqtROb/OMuyvzQi3wrmq3vMBkt4xcHcbrAbmvA3Ts8xt0ZNXP
 dDxoUZ3eZzJbz/9yv7i6oew0x0M+XadCFn9NVNh+eo10pRbz97V2f//lmYhXeNilHPysfFgzarZ
 WpQ0A
X-Developer-Key: i=mbenes@suse.cz; a=openpgp;
 fpr=91BB0699882EF39D46654BB3FF98A38DA80834DA
X-Spamd-Result: default: False [19.10 / 50.00];
	SPAM_FLAG(5.00)[];
	NEURAL_SPAM_LONG(3.50)[1.000];
	HFILTER_HELO_5(3.00)[localhost.localdomain];
	NEURAL_SPAM_SHORT(3.00)[0.999];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	RDNS_NONE(2.00)[];
	BAYES_HAM(-1.28)[89.94%];
	ONCE_RECEIVED(1.20)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FROM_EQ_ENVFROM(0.00)[];
	DIRECT_TO_MX(0.00)[b4 0.15.2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	GREYLIST(0.00)[pass,meta];
	R_RATELIMIT(0.00)[to_ip_from(RLhhr1kjtirn5oxn4gcky1j98z)];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_ZERO(0.00)[0];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email]
X-Spamd-Bar: +++++++++++++++++++
X-Rspamd-Queue-Id: 240C35CB75
X-Spam-Score: 19.10
X-Spam-Level: *******************
X-Rspamd-Action: add header
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Flag: YES
X-Spam: Yes

On Thu, 30 Apr 2026 21:08:26 -0700, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> Add an is_cold_func() helper.  No functional changes intended.

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

-- 
Miroslav

