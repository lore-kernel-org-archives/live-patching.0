Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E88D3A5457
	for <live-patching@vger.kernel.org>; Thu,  9 Apr 2026 09:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775728058; cv=none; b=tnnkLwl0D8JzBI/d+DMuHWt48lNx1mWv1pIVCPDYyDD2saGmkylV8XwD4HKrOOHS+nXvc5XesH9h/EpYcLOckND4FtdheJawaTTftgPTWwEaRc+qIi/r6XpH8/UdiM40LZQ+1NObf0eJS7Ox4nJb4D5sBZkG8Lsu4yYkoG+K6Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775728058; c=relaxed/simple;
	bh=2KjB/3mK/KnL4gG/+JGanpaHMh41N1xgWyswFLgn8xE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Bcnvc8suZFOPRPQCVVxdclr+neWL7pc6T58IGuns0L5ES351CCsuswKbITxJ+JMdXvrT/p7ceV6d0H7GSy7/TVK+RUnbSrnSfOvCfTGRs/EH+OgZNRCnPfPifTSXp1EXI1qPsdDVFlzRkuRKCnSwENKoFsgPxOS9rZl5BEwd+W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qGty1Csu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=V4IyF8Xk; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qGty1Csu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=V4IyF8Xk; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qGty1Csu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="V4IyF8Xk";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qGty1Csu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="V4IyF8Xk"
Received: from pobox.suse.cz (unknown [10.128.32.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C6E504EE86;
	Thu,  9 Apr 2026 09:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1775728055; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VPTesRUCHX4NMM4UTkklTPtjujPQJY3bhq7UEGu0/No=;
	b=qGty1Csu8CtH/HBvYVSB97KLSh/Zf0h3sHXB5bRtlel2pwq2y66LizfV3IbLtU6K8q8KpJ
	jg+6cBfC6Fvc2kckjCR9176mdUNldLHs/b/9PBLT3mhAw8Dhyg63YOgImmJQPjsMPt1a02
	e5QpJ6E0AV5XHovqDiSXK0/da9Q34Jw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1775728055;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VPTesRUCHX4NMM4UTkklTPtjujPQJY3bhq7UEGu0/No=;
	b=V4IyF8XkQQ52NdkV3fldKsNVjybo5j4XrfelDSTlXIuXPGU+3a/5TamSYcCWtjXXVUUgjl
	+ZBd7TbKTqlBfXDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1775728055; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VPTesRUCHX4NMM4UTkklTPtjujPQJY3bhq7UEGu0/No=;
	b=qGty1Csu8CtH/HBvYVSB97KLSh/Zf0h3sHXB5bRtlel2pwq2y66LizfV3IbLtU6K8q8KpJ
	jg+6cBfC6Fvc2kckjCR9176mdUNldLHs/b/9PBLT3mhAw8Dhyg63YOgImmJQPjsMPt1a02
	e5QpJ6E0AV5XHovqDiSXK0/da9Q34Jw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1775728055;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VPTesRUCHX4NMM4UTkklTPtjujPQJY3bhq7UEGu0/No=;
	b=V4IyF8XkQQ52NdkV3fldKsNVjybo5j4XrfelDSTlXIuXPGU+3a/5TamSYcCWtjXXVUUgjl
	+ZBd7TbKTqlBfXDw==
Date: Thu, 9 Apr 2026 11:47:35 +0200 (CEST)
From: Miroslav Benes <mbenes@suse.cz>
To: Yafang Shao <laoar.shao@gmail.com>
cc: jpoimboe@kernel.org, jikos@kernel.org, pmladek@suse.com, 
    joe.lawrence@redhat.com, rostedt@goodmis.org, mhiramat@kernel.org, 
    mathieu.desnoyers@efficios.com, kpsingh@kernel.org, 
    mattbobrowski@google.com, song@kernel.org, jolsa@kernel.org, 
    ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
    martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, 
    yonghong.song@linux.dev, live-patching@vger.kernel.org, 
    linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
    bpf@vger.kernel.org
Subject: Re: [RFC PATCH 2/4] trace: Allow kprobes to override livepatched
 functions
In-Reply-To: <20260402092607.96430-3-laoar.shao@gmail.com>
Message-ID: <alpine.LSU.2.21.2604091145340.31526@pobox.suse.cz>
References: <20260402092607.96430-1-laoar.shao@gmail.com> <20260402092607.96430-3-laoar.shao@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_ZERO(0.00)[0];
	TAGGED_RCPT(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,suse.com,redhat.com,goodmis.org,efficios.com,google.com,iogearbox.net,linux.dev,gmail.com,vger.kernel.org];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

Hi,

On Thu, 2 Apr 2026, Yafang Shao wrote:

> Introduce the ability for kprobes to override the return values of
> functions that have been livepatched. This functionality is guarded by the
> CONFIG_KPROBE_OVERRIDE_KLP_FUNC configuration option.

this is imprecise if I read the code correctly. You want to override live 
patch functions, not the original ones which are live patched.

I also think that if nothing else, it needs to be more specific then just 
checking mod->klp. It should check if a function itself in klp module is 
overridable to keep it as limited as possible. Even with that, the 
concerns expressed by the others still apply.

---
Miroslav
