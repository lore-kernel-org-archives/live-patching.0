Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B34390C85
	for <live-patching@vger.kernel.org>; Tue,  5 May 2026 11:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777980758; cv=none; b=G/13JzC7gUJjUNF8sxiQDm8S7pekObm5k8Bz8diJXbGsoY1l/+YNoGGghQ1jJDQSO6Hf7uszTxyY1L8GA4sTX/1dsHTcYzq07IqqCQdmui2MLVGBTwSzyQEGxgR12kB8RGROzKMxkk7eLIIPElPVqCEk6gX2jzRqJ0Sr830CzWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777980758; c=relaxed/simple;
	bh=t+RUNsLt4O8/IODB75AJeDzf8xYVVCbtAZdVpH/6ykM=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=e4qyDguEaDazUW1Dk5O2scUEC7sFgLFdjPHjVqxVCtgIoefC4+iOG8AiWPHc4SjfyJg7rijFEy7LKdk/htfqsonFzw1HH7no6EF9+XoYpqFyLbp9iq34R1qCVJnkcoL84DN+/U8+EgHHOsKxDZ5SCD7U4LJOgxVbk+4BF+Zj8Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cMvhZcc1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nvRh5dh0; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cMvhZcc1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nvRh5dh0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cMvhZcc1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nvRh5dh0";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cMvhZcc1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nvRh5dh0"
Received: from localhost.localdomain (unknown [IPv6:2a07:de40:b2bf:1b::12ef])
	by smtp-out2.suse.de (Postfix) with ESMTP id 1FECB5C26B;
	Tue,  5 May 2026 11:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777980710; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VZ8aWwmDX0Wn4EsMZrxw5y5WPpJ8A33SSmqOnTQTvek=;
	b=cMvhZcc1aS1eghCFnd34Rfb++hmqod9wYKhnSoQC53OEb2+5OngaUVSXI2G1LZOtS6kKuy
	yxxjRLdmM5KUpWR3tGa1YaRo4NWIOz+xqUy+/JwV8P3QSTwPtXrqE5zfJ+AXhqCcsOodud
	VqIUknBbKOy8lZSt+/3d66WswN6U92A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777980710;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VZ8aWwmDX0Wn4EsMZrxw5y5WPpJ8A33SSmqOnTQTvek=;
	b=nvRh5dh0glRCH5rtaXu8MrBqsPNchuP8Flez93xkTRJP0gqrYYRKrIBD342fEdWTDZPK3r
	Uon6cEvjpFGi3oCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=cMvhZcc1;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=nvRh5dh0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777980710; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VZ8aWwmDX0Wn4EsMZrxw5y5WPpJ8A33SSmqOnTQTvek=;
	b=cMvhZcc1aS1eghCFnd34Rfb++hmqod9wYKhnSoQC53OEb2+5OngaUVSXI2G1LZOtS6kKuy
	yxxjRLdmM5KUpWR3tGa1YaRo4NWIOz+xqUy+/JwV8P3QSTwPtXrqE5zfJ+AXhqCcsOodud
	VqIUknBbKOy8lZSt+/3d66WswN6U92A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777980710;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VZ8aWwmDX0Wn4EsMZrxw5y5WPpJ8A33SSmqOnTQTvek=;
	b=nvRh5dh0glRCH5rtaXu8MrBqsPNchuP8Flez93xkTRJP0gqrYYRKrIBD342fEdWTDZPK3r
	Uon6cEvjpFGi3oCw==
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 37/53] objtool: Add is_alias_sym() helper
From: Miroslav Benes <mbenes@suse.cz>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
 live-patching@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
 Joe Lawrence <joe.lawrence@redhat.com>, Song Liu <song@kernel.org>, 
 Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
In-Reply-To: <87cfee570bfffb35961d9b6e5abfbfeae6d903dc.1777575752.git.jpoimboe@kernel.org>
References: <cover.1777575752.git.jpoimboe@kernel.org>
 <87cfee570bfffb35961d9b6e5abfbfeae6d903dc.1777575752.git.jpoimboe@kernel.org>
Date: Tue, 05 May 2026 13:31:45 +0200
Message-Id: <177798070551.9921.14288812611520856905.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=242; i=mbenes@suse.cz;
 h=from:subject:message-id; bh=t+RUNsLt4O8/IODB75AJeDzf8xYVVCbtAZdVpH/6ykM=;
 b=owGbwMvMwMHYWJt9x2W1tA7jabUkhsyfV1V4zx1UiRKd/7ds38e1MfsaZFu/7NwYHC5axBJVJ
 b6d5eHsTkZ/FgZGDgZLMUWW13ud5Qyn5BpoVr+7CzOIlQlkirRIAwMQsDDw5SbmlRrpGOmZahvq
 GQIZOkYMXJwCMNXrLDgYNuj5td3QOWzZEGZx3qbfP1t54QnTp2b/+r64P+ffI3vq3caYqYliHu0
 7ztcyrpn6MO/PxANXBbd6LXs2JbpvScVrGYkJcuL+h+bZffx39mI7Z67HHKnVM7m0VfsDHrBweM
 l6PZXtPcQ9M9bzdpjiNmN/861/FbXy3dZIZKXFbL5nEad0nuuR3PW2wkDJ6VLlKjZRyRF7a372L
 jRmcBCwf9UX1CNpdIXN5//TXzei1Mz4ttstYOrvbKueYnPu3mW79auedWx8t3H3Hqd6KbP/pT8U
 n9zZOTdJL72+k2XLiu7ffwIFI2/Ona2uW9Qy+1pN+xLroG95RamxDzoFjsRcnvz3c/CaXcZPz0f
 E77wAAA==
X-Developer-Key: i=mbenes@suse.cz; a=openpgp;
 fpr=91BB0699882EF39D46654BB3FF98A38DA80834DA
X-Spamd-Result: default: False [19.60 / 50.00];
	SPAM_FLAG(5.00)[];
	NEURAL_SPAM_LONG(3.50)[1.000];
	HFILTER_HELO_5(3.00)[localhost.localdomain];
	NEURAL_SPAM_SHORT(3.00)[0.999];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	RDNS_NONE(2.00)[];
	ONCE_RECEIVED(1.20)[];
	BAYES_HAM(-0.78)[84.55%];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLhhr1kjtirn5oxn4gcky1j98z)];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DIRECT_TO_MX(0.00)[b4 0.15.2];
	GREYLIST(0.00)[pass,meta];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_ZERO(0.00)[0];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	SPAMHAUS_XBL(0.00)[2a07:de40:b2bf:1b::12ef:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,localhost.localdomain:helo]
X-Spamd-Bar: +++++++++++++++++++
X-Rspamd-Queue-Id: 1FECB5C26B
X-Spam-Score: 19.60
X-Spam-Level: *******************
X-Rspamd-Action: add header
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Flag: YES
X-Spam: Yes

On Thu, 30 Apr 2026 21:08:25 -0700, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> Improve readability with a new is_alias_sym() helper.
> 
> No functional changes intended.

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

-- 
Miroslav

