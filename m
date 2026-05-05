Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF51243C059
	for <live-patching@vger.kernel.org>; Tue,  5 May 2026 13:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777986479; cv=none; b=qEJGA+FtiUdXs8xGilpvQnsKfto1P6zscU9ODCDX+dFkMTpnpt/TEUw+Ro5V6DBn/GOjudeovItQqrt8ZODWkTsQ6VoybCuGbHSaMQiebrKRw3Y0mAkGsNdKTTXJZIwtfRNfv+EsWm1nNYf4OEta0/fibJuRRjfLlsodrttDZY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777986479; c=relaxed/simple;
	bh=efkaRGbov+ZAIOv1O6plC6HvEUImbAcoC0DWBtcJd5Y=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=ClcuF5yZa+uS/nKD/IKFcpTwIvzdx4o07QesByaP3eJmUY6dgYcqXYVuOz1p+O4RpcHuOBnlZzGTbYkaIql2+qorinIbKyexPuNWj4rvL2kSMrZJ9Dvi6ccHayxJ7g3zVVr6V4TAoJQ6Kyd4to+8PoMiH14KlWLiFGmT6+lSSsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TBa9tV89; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3k5fnWiK; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=a0f6eQ5f; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Fkfoe2bu; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TBa9tV89";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3k5fnWiK";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="a0f6eQ5f";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Fkfoe2bu"
Received: from localhost.localdomain (unknown [IPv6:2a07:de40:b2bf:1b::12ef])
	by smtp-out2.suse.de (Postfix) with ESMTP id D1C295BEE3;
	Tue,  5 May 2026 13:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777986476; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oe8h0lf9XIAqb4NChPv695HZRUVHzL9qEnfuBV9ZVmc=;
	b=TBa9tV896AFQtHeVOPHBZ2W2Be5W6eNq15IKETJIbHRrz2giwwjqdUPyj57CX+vobYWzc1
	zXDLdiTqxDgCmTo+NnSXbR9YFf4M56RF796HBMEsU6DA2U2t3c+DHiF1Mai9hZ5EFz+2hR
	EhgyZQB3SAPFV9p6RYhFCQLUJIvzHew=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777986476;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oe8h0lf9XIAqb4NChPv695HZRUVHzL9qEnfuBV9ZVmc=;
	b=3k5fnWiK1UVTpOr4UDEvUHXHqvDR26AJz8fcpCG3qE9V/IYaoras+mucAYsV3KneG4gHeG
	O809SsPgGTFIVqDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=a0f6eQ5f;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Fkfoe2bu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777986475; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oe8h0lf9XIAqb4NChPv695HZRUVHzL9qEnfuBV9ZVmc=;
	b=a0f6eQ5fZ4oA5qjaYaN4GTiWbzE5gbEVprp3fXZgrZiPq3fcPBaaav8yZbZiHebktHTesX
	YeHLOUnt7iAvda2QXIv0sMDWYLPbvmqZTSI0I/9rJc8qkuVenA8VsQQuHoxaU+cuuhEnEU
	17ikHWNa2YcT5JjOO0g0ZphbMZ6/8vw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777986475;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oe8h0lf9XIAqb4NChPv695HZRUVHzL9qEnfuBV9ZVmc=;
	b=Fkfoe2burf+DnAdl9l/Z/SSr8HhSzMCHaZzFN/qGnvT43/nAbJlClKiuIZRfKzVH6h1K7p
	ToA9okqpkBZjz/AQ==
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 46/53] objtool/klp: Rewrite symbol correlation
 algorithm
From: Miroslav Benes <mbenes@suse.cz>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
 live-patching@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
 Joe Lawrence <joe.lawrence@redhat.com>, Song Liu <song@kernel.org>, 
 Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
In-Reply-To: <27fcb5a17cc7b6821d8b1c4b9812ebb5b4ee6a5c.1777575752.git.jpoimboe@kernel.org>
References: <cover.1777575752.git.jpoimboe@kernel.org>
 <27fcb5a17cc7b6821d8b1c4b9812ebb5b4ee6a5c.1777575752.git.jpoimboe@kernel.org>
Date: Tue, 05 May 2026 15:07:53 +0200
Message-Id: <177798647393.9921.5655000270119550671.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=480; i=mbenes@suse.cz;
 h=from:subject:message-id; bh=efkaRGbov+ZAIOv1O6plC6HvEUImbAcoC0DWBtcJd5Y=;
 b=owGbwMvMwMHYWJt9x2W1tA7jabUkhsyfr1f/uv3acMbJ41ON9bWrFcO6Nwrld1fUd/9Z3Ctyo
 PM+Y9jpTkZ/FgZGDgZLMUWW13ud5Qyn5BpoVr+7CzOIlQlkirRIAwMQsDDw5SbmlRrpGOmZahvq
 GQIZOkYMXJwCMNU/mtj/lyqml7F9TzpTLfHl5eeIno/rLU9yK9y60P76zpX7VVlWWsd+Wk6f7mN
 1Le6qwKyUiFkPF/moObCkc8Y+T3Wr+rCpJ0nZKOPfutmRymvf7Lgqutr11rzGScGSPez2+o6vr3
 Zd/yaU8/iToTXTrttvSu7dOc3ilv76E7/FS7/mwMBqTxWeQ5c5uL5+b3rZqnrvktb9f9b9RQcYJ
 fNu2ZbsXnpluYDehESdQ5f2pMZeN7uveTrVNk+7fc+X+wK8dpWa1aejoh1/H/p/9tRxO9552a0V
 l2+rqjFOT8/vXL9syqLl7We5XKXCTR4IbAi8k3wqkfmnS/bveau+fDfcprBCedLxiQkHJZLNrK6
 H7Zi0AQA=
X-Developer-Key: i=mbenes@suse.cz; a=openpgp;
 fpr=91BB0699882EF39D46654BB3FF98A38DA80834DA
X-Spamd-Result: default: False [18.66 / 50.00];
	SPAM_FLAG(5.00)[];
	NEURAL_SPAM_LONG(3.50)[1.000];
	HFILTER_HELO_5(3.00)[localhost.localdomain];
	NEURAL_SPAM_SHORT(3.00)[0.999];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	RDNS_NONE(2.00)[];
	BAYES_HAM(-1.73)[93.34%];
	ONCE_RECEIVED(1.20)[];
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
	GREYLIST(0.00)[pass,meta];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email]
X-Spamd-Bar: ++++++++++++++++++
X-Rspamd-Queue-Id: D1C295BEE3
X-Spam-Score: 18.66
X-Spam-Level: ******************
X-Rspamd-Action: add header
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Flag: YES
X-Spam: Yes

On Thu, 30 Apr 2026 21:08:34 -0700, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> [...]
>   same-named candidates, similar to livepatch sympos.  Used for data
>   objects like __quirk variables where no deterministic filter can
>   distinguish the candidates.
> 
> Overall this works much better than the existing algorithm, particularly
> with LTO kernels.

Nice improvement which makes it much clearer.

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

-- 
Miroslav

