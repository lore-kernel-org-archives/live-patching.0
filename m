Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4FA32D7FF
	for <live-patching@vger.kernel.org>; Tue,  5 May 2026 11:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777982398; cv=none; b=pTuuqMAnTBQIrPIMXr9ynVf4c2ruUw0ye682JIzMLzjbQaFfNOplj7wFLxfYdQ5+2zrGWUK5X5PMnjBTDYoDddYnLySVAywme7lGV2SY3t0Zb1F+6X8E1CyVy25/6YqukzbocKdeWYYhuBV0eS1kHDO6GLdwmx+9SOPxnX4lKvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777982398; c=relaxed/simple;
	bh=2QvaubpR2f6WCODVa+WNjH2AITYqYSMa495S+luIV9s=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=hJm4FzyysRNH+74PylWnNHAMcrTYOjfth7bgKp/99fkrZiJMqGVT1aoMu9vv8iE8J4aF+hXHeKwXugAqrMEMLNlsUDRLAh+WohEQ5+I+DwhMKFbTLgG1WxOsPtIU+7lXgk15oG/kRs1kNLEz6PDbc9SJWxyVE/KEH8ivkdR6YLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=I7vsW5fx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4xp2oW3M; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=I7vsW5fx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4xp2oW3M; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="I7vsW5fx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4xp2oW3M";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="I7vsW5fx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4xp2oW3M"
Received: from localhost.localdomain (unknown [IPv6:2a07:de40:b2bf:1b::12ef])
	by smtp-out1.suse.de (Postfix) with ESMTP id 5D69C6B12B;
	Tue,  5 May 2026 11:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777982395; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WqGktt/QQFMsgW+qWz0ainKi6WyoFV57rt+q5e+P3Sk=;
	b=I7vsW5fxznMTIWfYJzzVk9f3KmBXTOxzTQswEepfnKJ594b2CKZJptnCVW9/u6+UPgpbRY
	wJh/OvQfCuzgNgj5yb8gud/24DYS0EZ90P1zRG8EZoGSVySulHzS0HILtt7/QPThpqBzw+
	Yb9110SHQTQhBJ0jBkXFdnFIsabyuEc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777982395;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WqGktt/QQFMsgW+qWz0ainKi6WyoFV57rt+q5e+P3Sk=;
	b=4xp2oW3MwJeGu31tgzmFF3UD8loJj9X0XYlkP/t0vZhGYZP4re0PqXIi8dClw9P9YwY8PP
	WXWh4PgnQyD/xuAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=I7vsW5fx;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=4xp2oW3M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777982395; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WqGktt/QQFMsgW+qWz0ainKi6WyoFV57rt+q5e+P3Sk=;
	b=I7vsW5fxznMTIWfYJzzVk9f3KmBXTOxzTQswEepfnKJ594b2CKZJptnCVW9/u6+UPgpbRY
	wJh/OvQfCuzgNgj5yb8gud/24DYS0EZ90P1zRG8EZoGSVySulHzS0HILtt7/QPThpqBzw+
	Yb9110SHQTQhBJ0jBkXFdnFIsabyuEc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777982395;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WqGktt/QQFMsgW+qWz0ainKi6WyoFV57rt+q5e+P3Sk=;
	b=4xp2oW3MwJeGu31tgzmFF3UD8loJj9X0XYlkP/t0vZhGYZP4re0PqXIi8dClw9P9YwY8PP
	WXWh4PgnQyD/xuAQ==
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 43/53] objtool/klp: Remove "objtool --checksum"
From: Miroslav Benes <mbenes@suse.cz>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
 live-patching@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
 Joe Lawrence <joe.lawrence@redhat.com>, Song Liu <song@kernel.org>, 
 Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
In-Reply-To: <9bf05c10e47f711dc2f3b00d728b725618cec5d0.1777575752.git.jpoimboe@kernel.org>
References: <cover.1777575752.git.jpoimboe@kernel.org>
 <9bf05c10e47f711dc2f3b00d728b725618cec5d0.1777575752.git.jpoimboe@kernel.org>
Date: Tue, 05 May 2026 13:59:53 +0200
Message-Id: <177798239395.9921.1859139594989298845.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=395; i=mbenes@suse.cz;
 h=from:subject:message-id; bh=2QvaubpR2f6WCODVa+WNjH2AITYqYSMa495S+luIV9s=;
 b=owGbwMvMwMHYWJt9x2W1tA7jabUkhsyft3ert79LjdU1M/8i/H1vyYt1siW3OiWP9oQKOqsf7
 XmeY7i2k9GfhYGRg8FSTJHl9V5nOcMpuQaa1e/uwgxiZQKZIi3SwAAELAx8uYl5pUY6Rnqm2oZ6
 hkCGjhEDF6cATHXaX/a/AvuXGTDsLZfI4/fcfOOGgc+pq07C0309tTiE6mYFJrr5Vjw2E1t/VmS
 HyswJX758UHVlWjkpZtWemUz7T1bEK/plqE92Ss/S0mFnEfe54fl9xqdD046Wxex6kjjnyA02Do
 OTvOKh/3xf1Z3YtfRsb6v4qjLb5ewz/DYs39Fszrn5ROj9B2s1ZxRXrS2rvTHxq4xxi9E92wyzU
 K2oN+Lfs014572edEvOY7J9b0D75w/n2XXPmN7bVKH0pq/V0uCqPpfKf1P1DlepzUGfS80mv98/
 2+zjauvUmsMXrjm3Oh3+P3HR3rqJsTNuXd66+epLre9HJi404JKTK2b69Tp5+7f9ijqJX6Uuqrv
 J18U+AgA=
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
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	MX_GOOD(-0.01)[];
	BAYES_SPAM(0.00)[33.89%];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b2bf:1b::12ef:from];
	TO_DN_SOME(0.00)[];
	DIRECT_TO_MX(0.00)[b4 0.15.2];
	R_DKIM_ALLOW(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	GREYLIST(0.00)[pass,meta];
	RCPT_COUNT_SEVEN(0.00)[9];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_ZERO(0.00)[0];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[localhost.localdomain:helo,suse.cz:email,suse.cz:dkim]
X-Spamd-Bar: ++++++++++++++++++++
X-Rspamd-Queue-Id: 5D69C6B12B
X-Spam-Flag: YES
X-Spam-Score: 20.69
X-Spam-Level: ********************
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: add header
X-Spam: Yes

On Thu, 30 Apr 2026 21:08:31 -0700, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> The checksum functionality has been moved to "objtool klp checksum"
> which is now used by klp-build.  Remove the now-dead --checksum and
> --debug-checksum options from the default objtool command.

With the Sashiko fixup you sent elsewhere

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

-- 
Miroslav

