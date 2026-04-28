Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E7E40243B
	for <live-patching@vger.kernel.org>; Tue, 28 Apr 2026 12:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777378365; cv=none; b=is0iLG9XXLWR2DSO62ZeP+mHTzT68pdABTSXjjSNkR3rUemwrLZ0OAQEV8MxC85KfGaoMQmE2KfzoBXw0icXnjXVKRtzcM8EvDk5UgsEzjJjuWoj3JpxXGDbnPJ413P47UtxNaNEXmeuaf5OE61bUEBSGb85GEXyD2xVx2kZnks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777378365; c=relaxed/simple;
	bh=727QTVyHrE5pPN7nD6Inlk0qw0UR5ZG3ybIC9Ta/Lx0=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=JGkl3r2QTi4CzatOaRutXfMMI4ETi5M6gqmez+iJPeeJXF8vwKxGFLL97Y7l8y+xpMPLYrr/DZt+B3m84+vBY2LtcBTxrH+FHiTdRVBzsygCtmImVgA349BTw21YQQKZDvhfiCU/NffTN3xy4PXrcvmlQsdbqFtD9Zx6u7q3iBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YdWyZuxM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hIFEvWpC; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Dxd26sBN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FACeN7JC; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YdWyZuxM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hIFEvWpC";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Dxd26sBN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FACeN7JC"
Received: from localhost.localdomain (unknown [IPv6:2a07:de40:b2bf:1b::12ef])
	by smtp-out2.suse.de (Postfix) with ESMTP id C960F5BD42;
	Tue, 28 Apr 2026 12:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777378360; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GQz/VADMDsxmv79Vgr7p0VThiWzpcFh5mMkbt3V8vIw=;
	b=YdWyZuxMyCvCyIedYzVHsl+s8InbM6FYvaw6livyz7iBmd8LDjlHhsDhuxu0ArvlS7Yk7p
	l4ffeS1WVSJybr0S7qT7KIY5K328g1SjWUaOY/6FYH2dhJQCwG5pEbDDR9cT7QhvNVM5sY
	jl850IRCpxl3GgGxRK5tdSHSKJYgjzw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777378360;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GQz/VADMDsxmv79Vgr7p0VThiWzpcFh5mMkbt3V8vIw=;
	b=hIFEvWpCIk9oG/OAUTkOu2dO5D0C7as++KMsrx7Vvju964zYdB7qr+KnANIM9+jXKscSJF
	EujZH1CDbmtt5UBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Dxd26sBN;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=FACeN7JC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777378359; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GQz/VADMDsxmv79Vgr7p0VThiWzpcFh5mMkbt3V8vIw=;
	b=Dxd26sBNlMs3pzuaWCTRjhupw0kHIJymm4f+xu7CAR3leKxiiiiyu8AbGGNm4DT/v86TuQ
	aoAROh3R5fiEliqiSovQVmCKKgKeNN6p/iqRUnlmOhq9QGVX3JVzCeE7BHgcflPpi78Lfk
	EYK17qlv99pprLuyP18DP0HUqC5T0ig=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777378359;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GQz/VADMDsxmv79Vgr7p0VThiWzpcFh5mMkbt3V8vIw=;
	b=FACeN7JC9kPQqpTrPNzYh4S7rZuajDEp01JVpq6sUaaXsoUZgq30M08n43ZuodFJ1iYZnB
	pXQITwe5e8XmN6Cw==
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 10/48] objtool/klp: Fix --debug-checksum for duplicate
 symbol names
From: Miroslav Benes <mbenes@suse.cz>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
 live-patching@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
 Joe Lawrence <joe.lawrence@redhat.com>, Song Liu <song@kernel.org>, 
 Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
In-Reply-To: <7fd49264db4f5a9c654ad162cca96ce575e77ae4.1776916871.git.jpoimboe@kernel.org>
References: <cover.1776916871.git.jpoimboe@kernel.org>
 <7fd49264db4f5a9c654ad162cca96ce575e77ae4.1776916871.git.jpoimboe@kernel.org>
Date: Tue, 28 Apr 2026 14:12:33 +0200
Message-Id: <177737835356.11371.5834023067101378921.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=466; i=mbenes@suse.cz;
 h=from:subject:message-id; bh=727QTVyHrE5pPN7nD6Inlk0qw0UR5ZG3ybIC9Ta/Lx0=;
 b=owGbwMvMwMHYWJt9x2W1tA7jabUkhswPS8y3St2LleO/xC5XUFn4ZrJeseft1OOuW5deLfYOl
 Co6JijSyejPwsDIwWAppsjyeq+znOGUXAPN6nd3YQaxMoFMkRZpYAACFga+3MS8UiMdIz1TbUM9
 QyBDx4iBi1MApvrmFvb/yQez2Z6sPvJB66Hr0Zl9L7tteyyiK06URt90c/aNNPxu3XSbw/fnIiN
 H8RvHPfsDHuZK9TB3ciVl8XBe/vv+bKL//Xf5twr5eLlOq6gun6rPqvJ5Z3uK2dE+jaSQ5U9K71
 ycs1Jl8UfXDWKNPLHv7okeK+E6vfBEePqa6eaFSxe3T5PSFNfoFOSM0OVQjpCdsMPp4Rvrmscpe
 pc1tyqw7oj0+qNovDVadcOkHtli5aqG1/Ecyxn6Cl66XJQ44N7IcXXF/Ztr/vDoTb+1T9RVmO31
 3FjGtQsL/EWb87SurvxnOP+Pqu4bJRkhz2y3Ml+1c4ZTsvysPX6tv+/20OmurG6BjMLpjQt8Xx9
 dHAMA
X-Developer-Key: i=mbenes@suse.cz; a=openpgp;
 fpr=91BB0699882EF39D46654BB3FF98A38DA80834DA
X-Spamd-Bar: +++++++++++++++++++
X-Rspamd-Queue-Id: C960F5BD42
X-Rspamd-Action: add header
X-Spam-Flag: YES
X-Spam-Score: 19.44
X-Spam-Level: *******************
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [19.44 / 50.00];
	SPAM_FLAG(5.00)[];
	NEURAL_SPAM_LONG(3.50)[1.000];
	HFILTER_HELO_5(3.00)[localhost.localdomain];
	NEURAL_SPAM_SHORT(3.00)[1.000];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	RDNS_NONE(2.00)[];
	ONCE_RECEIVED(1.20)[];
	BAYES_HAM(-0.95)[86.56%];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_ZERO(0.00)[0];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DIRECT_TO_MX(0.00)[b4 0.15.2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b2bf:1b::12ef:from];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	GREYLIST(0.00)[pass,body];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim]
X-Spam: Yes

On Wed, 22 Apr 2026 21:03:38 -0700, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> find_symbol_by_name() only returns the first match, so
> --debug-checksum=<func> silently ignores any subsequent duplicately
> named functions after the first.
> 
> Add a new iterate_sym_by_name() to fix that.

The patch is ok but is it worth it when you remove it again in 39/48
with a better implementation? Can 39/48 be moved here in the series
instead?

-- 
Miroslav

