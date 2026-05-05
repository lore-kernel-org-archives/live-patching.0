Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3607D47DD66
	for <live-patching@vger.kernel.org>; Tue,  5 May 2026 13:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777988444; cv=none; b=MHfNdozZJa9WzKU4xH7XnQOg7A/TnXyCF9QWZEhJP6elOXSwXRX2yWdsBExTG5ac6pJ+5xI2YF70T7oR16PACYS5+Tw+xAF3ULYXuUhl2NqbxYklkS3kQxRR6dZBs9AWvLYaHi/Ujeqd+6DizmAuZuumMAoGvdhITts4E67gH8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777988444; c=relaxed/simple;
	bh=b1mMWEcfSohS/0a2ENbZD5wzfTtxDUHd3t5bRZhXzY0=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=c7HXb3Hb8YjZ6RV/F+OfKLYD+qTG9ueoVMjH74ZPXk1Sa49OZC8NEvK5HkHIQkUhSHGPiPLyfnDGxnmL9FcGLfAIs+1Q2J4yCaSyGHpBQ4ovrghDCxWY3rKN0MzbO9dmjVwalOSTbsJKCRkZWbJyPUV/wkxbHXoA9k8/Acq59T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EJzEKRwB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=g/f62F2l; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EJzEKRwB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=g/f62F2l; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EJzEKRwB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="g/f62F2l";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EJzEKRwB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="g/f62F2l"
Received: from localhost.localdomain (unknown [IPv6:2a07:de40:b2bf:1b::12ef])
	by smtp-out1.suse.de (Postfix) with ESMTP id 591516B477;
	Tue,  5 May 2026 13:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777988441; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nrpFSN9+Jb85LpWE/e/tWxnjV9MBYAWH0FvwWETYc8g=;
	b=EJzEKRwBUm1ADDb05ZhzgedS0qyFDSnN96Dp9l2o+GmqFBYZfLznJg8GNZrOmeudpmpeHq
	O4rQE4kng9D11y6toyWGI1WZSE/2rXlzZFwESD6TjGRbap0tAZ1kS8mO1UsKN128fycNjc
	rnS9Et6IwCMdgkJtwXQHv5XI/y1lUmg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777988441;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nrpFSN9+Jb85LpWE/e/tWxnjV9MBYAWH0FvwWETYc8g=;
	b=g/f62F2lu7lwoK/Rnzx/oeAfdhG0rrBC7PjqxHaaigM8sE4WDaTxGpPo+R9ALq2DJCf3oO
	SYWQW1h5Df0DYYDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=EJzEKRwB;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="g/f62F2l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777988441; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nrpFSN9+Jb85LpWE/e/tWxnjV9MBYAWH0FvwWETYc8g=;
	b=EJzEKRwBUm1ADDb05ZhzgedS0qyFDSnN96Dp9l2o+GmqFBYZfLznJg8GNZrOmeudpmpeHq
	O4rQE4kng9D11y6toyWGI1WZSE/2rXlzZFwESD6TjGRbap0tAZ1kS8mO1UsKN128fycNjc
	rnS9Et6IwCMdgkJtwXQHv5XI/y1lUmg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777988441;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nrpFSN9+Jb85LpWE/e/tWxnjV9MBYAWH0FvwWETYc8g=;
	b=g/f62F2lu7lwoK/Rnzx/oeAfdhG0rrBC7PjqxHaaigM8sE4WDaTxGpPo+R9ALq2DJCf3oO
	SYWQW1h5Df0DYYDg==
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 53/53] objtool/klp: Cache dont_correlate() result
From: Miroslav Benes <mbenes@suse.cz>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
 live-patching@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
 Joe Lawrence <joe.lawrence@redhat.com>, Song Liu <song@kernel.org>, 
 Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
In-Reply-To: <b13cf9c9e942563b4a9b19494a83f4abf073b0c5.1777575753.git.jpoimboe@kernel.org>
References: <cover.1777575752.git.jpoimboe@kernel.org>
 <b13cf9c9e942563b4a9b19494a83f4abf073b0c5.1777575753.git.jpoimboe@kernel.org>
Date: Tue, 05 May 2026 15:40:39 +0200
Message-Id: <177798843962.9921.16575622756260651878.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=315; i=mbenes@suse.cz;
 h=from:subject:message-id; bh=b1mMWEcfSohS/0a2ENbZD5wzfTtxDUHd3t5bRZhXzY0=;
 b=owGbwMvMwMHYWJt9x2W1tA7jabUkhsyfnyOldSo+ZNTmajMcujjFyHR+pVjC1D/+ecyHN7ta7
 X9drfGgk9GfhYGRg8FSTJHl9V5nOcMpuQaa1e/uwgxiZQKbItLAAAQsDHy5iXmlRjpGeqbahnqG
 QIaOEQMXpwBMdYMxB8MGv2+bGSa+rpN7dkuhXPKO8qfOpcGrZ6b9y7yRK/G/6riPa0wJv+TJqb0
 iK9kd1rk3c997KXgmJs3nqY3TfJ5Mnq+HpUSV2cRZ3btUvv9Wsyj8dbK52YSH/5Ps0lnZHznM2d
 n1l3x7zvh/ZVdwwZauw21fFq7Y/ap5TdjVPc9rGvQ8JtZP0T2rfbf9Eu8SXbmA1hAVNqU5UbVbV
 wVv59bnCO/Nyd5avKTkU2yMdtVBAQ9j9r6Hb1Xm1jTErmeTPnfyN2Ovgq/PQzmZvCueB574zdhb
 nTPxyfZJj+07HTuPv2XbWXJVvOtLS4gC1/okNaU9F/iKkmyXHJ+bfr5qghrDhfTcHSmX3H/GP2v
 /AQA=
X-Developer-Key: i=mbenes@suse.cz; a=openpgp;
 fpr=91BB0699882EF39D46654BB3FF98A38DA80834DA
X-Spamd-Result: default: False [20.69 / 50.00];
	SPAM_FLAG(5.00)[];
	NEURAL_SPAM_LONG(3.50)[1.000];
	HFILTER_HELO_5(3.00)[localhost.localdomain];
	NEURAL_SPAM_SHORT(3.00)[1.000];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	RDNS_NONE(2.00)[];
	ONCE_RECEIVED(1.20)[];
	MID_RHS_NOT_FQDN(0.50)[];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	BAYES_SPAM(0.00)[22.12%];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	DIRECT_TO_MX(0.00)[b4 0.15.2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b2bf:1b::12ef:from];
	RCVD_COUNT_ZERO(0.00)[0];
	RCPT_COUNT_SEVEN(0.00)[9];
	DKIM_TRACE(0.00)[suse.cz:+];
	GREYLIST(0.00)[pass,meta];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_DKIM_ALLOW(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email]
X-Spamd-Bar: ++++++++++++++++++++
X-Rspamd-Queue-Id: 591516B477
X-Spam-Score: 20.69
X-Spam-Level: ********************
X-Rspamd-Action: add header
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Flag: YES
X-Spam: Yes

On Thu, 30 Apr 2026 21:08:41 -0700, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> Cache the dont_correlate() result once per symbol at the start of
> correlate_symbols().  This reduces klp diff time on an arm64 LTO
> vmlinux.o from 2m51s to 35s.

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

-- 
Miroslav

