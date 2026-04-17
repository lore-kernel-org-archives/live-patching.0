Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BBE33AD9D
	for <live-patching@vger.kernel.org>; Fri, 17 Apr 2026 08:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776413617; cv=none; b=pZOydXcw5d3dkVC5ULE9gEGEI+NXmQStGcDrc8xIEk3YSiCp31olY/+SGpKKuXhmm4d890pi4exblxD6QE63nhUPdTN+JHUJUN0BVwaJOO3UsYm5w3J4iLhYhDfT2MJG2UxUo6e8G7vKYh+E2hBRktWHiUdf6Q80rN1wmHGY/ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776413617; c=relaxed/simple;
	bh=WIZMCfEdo5EVXILpHoavBd/cCsHFuLHcye+gnRWqtlk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=XWVA3qRoC/esrb+bij9kv5Nr7wro+uteyrOfvIZATUIa42BOLiBZ/wR+mPFwyBbvYj/N6Yr32BhrJAjznHgZ1hScoITs4UtUYfebZ1Jrufe9CdJmm6UKfN4hbZBhLD4YNNvyCxXj2moqIvX6HfwT285qIIMLt7DREB7eJGAKz9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bsyX0P+4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WxZpBaET; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bsyX0P+4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WxZpBaET; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bsyX0P+4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WxZpBaET";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bsyX0P+4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WxZpBaET"
Received: from pobox.suse.cz (unknown [10.128.32.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 706056A985;
	Fri, 17 Apr 2026 08:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776413614; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TgbWk4XqXibZ4hp/e5YWk8D3E7kXbfcnOBDxRNOXiWw=;
	b=bsyX0P+4XR7qNF/IYxj8px/ezJcKUnujfKV44YCNx1JdLCnwQzP8Zo0UOz5HzoBZafKasg
	XRudMX/jh2nHdoEQLtw9+lhP+3fIuhNCNMFMV1Ciih79L9lnZ7ykpqai2PRUWjWes5QTRd
	MYHIOaqYN1KBgqhLOm4zbJKDQkJMovw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776413614;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TgbWk4XqXibZ4hp/e5YWk8D3E7kXbfcnOBDxRNOXiWw=;
	b=WxZpBaETIPfo3K5YBgEYZY2CoT4rnAg+FKWvjRp2vw1CrCdT2Uf22joLnTkU4XV2n1rSrD
	WcMessYFspwrr4DQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776413614; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TgbWk4XqXibZ4hp/e5YWk8D3E7kXbfcnOBDxRNOXiWw=;
	b=bsyX0P+4XR7qNF/IYxj8px/ezJcKUnujfKV44YCNx1JdLCnwQzP8Zo0UOz5HzoBZafKasg
	XRudMX/jh2nHdoEQLtw9+lhP+3fIuhNCNMFMV1Ciih79L9lnZ7ykpqai2PRUWjWes5QTRd
	MYHIOaqYN1KBgqhLOm4zbJKDQkJMovw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776413614;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TgbWk4XqXibZ4hp/e5YWk8D3E7kXbfcnOBDxRNOXiWw=;
	b=WxZpBaETIPfo3K5YBgEYZY2CoT4rnAg+FKWvjRp2vw1CrCdT2Uf22joLnTkU4XV2n1rSrD
	WcMessYFspwrr4DQ==
Date: Fri, 17 Apr 2026 10:13:34 +0200 (CEST)
From: Miroslav Benes <mbenes@suse.cz>
To: Song Liu <song@kernel.org>
cc: live-patching@vger.kernel.org, linux-kernel@vger.kernel.org, 
    jpoimboe@kernel.org, jikos@kernel.org, pmladek@suse.com, 
    joe.lawrence@redhat.com, laoar.shao@gmail.com, kernel-team@meta.com
Subject: Re: [PATCH] samples/livepatch: Add BPF struct_ops integration
 sample
In-Reply-To: <20260416001628.2062468-1-song@kernel.org>
Message-ID: <alpine.LSU.2.21.2604171011570.24300@pobox.suse.cz>
References: <20260416001628.2062468-1-song@kernel.org>
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
	NEURAL_HAM_SHORT(-0.20)[-0.991];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_ZERO(0.00)[0];
	TAGGED_RCPT(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,suse.com,redhat.com,gmail.com,meta.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

Hi,

On Wed, 15 Apr 2026, Song Liu wrote:

> Add a sample module that demonstrates how BPF struct_ops can work
> together with kernel livepatch. The module livepatches
> cmdline_proc_show() and delegates the output to a BPF struct_ops
> callback. When no BPF program is attached, a fallback message is
> shown; when a BPF struct_ops program is attached, it controls the
> /proc/cmdline output via the bpf_klp_seq_write kfunc.
> 
> This builds on the existing livepatch-sample.c pattern but shows how
> livepatch and BPF struct_ops can be combined to make livepatched
> behavior programmable from userspace.
> 
> The module is built when both CONFIG_SAMPLE_LIVEPATCH and
> CONFIG_BPF_JIT are enabled.
> 
> Signed-off-by: Song Liu <song@kernel.org>

Interesting. It does not make me comfortable to be honest. Is this 
something we want to advertise through samples?

Sashiko has comments... 
https://sashiko.dev/#/patchset/20260416001628.2062468-1-song%40kernel.org

Miroslav
