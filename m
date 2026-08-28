Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D583F1DF27F;
	Fri, 28 Aug 2026 09:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787909186; cv=none; b=gQrRtVEcKLJQjRIQQLDFz35vOrXZmySjFypxtrMd1kE0a9ozcAJ8w1wmGGd+ajEnP1qwul+oVl32RbAPhO/uQ9QXVsc29Q6/tneC3sq4GPs+QfGQaJZjkFCm7R1YWnO7eSGLoOVwYJ9oGVPCd68MrHBVSdtqWbXHXsZaxx5aulE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787909186; c=relaxed/simple;
	bh=wNXgYJzwzhjutqPG3YG+6h3Jchdd87ACFU5BjlUnoLM=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=YcuazaeAR2IyuPT9bu2Mjh7IccB3qlYdlLOtp7mns9OxJq1EphY+4HsDWGN+25pBExXXDNVx3XABkkGP1+n94rJAT4mE8JaIqyYbMmAiv1O1Cg2VWIVi9nKkwVhwEMYia4DtyfW2oqVxiWrfm9PNazVGlwlel2tok9JzgtBXH5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=R8PqxfqQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JJT+bBJN; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=B3rXhQB2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5p9ZdV6N; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="R8PqxfqQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JJT+bBJN";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="B3rXhQB2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5p9ZdV6N"
Received: from localhost.localdomain (unknown [IPv6:2a07:de40:b2bf:1b::12ef])
	by smtp-out2.suse.de (Postfix) with ESMTP id D82971F839;
	Fri, 28 Aug 2026 09:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1787909113; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lpmPCNsWLXh5FftYlzy/1pjHp63dvSXhlePVbCGiGao=;
	b=R8PqxfqQ+U882KKzxpSv6PsP6IuoJgzugBq4XdbSFttzIVOm9KDZZVLeGLBDmJ0kcMBANs
	EAJZk3L1KJ3HeJnYHcp3s5Rl1ojHOQ6V7qczesuCCwqtir29KNcWqkvorrdrb+GOkhx/Kq
	3L+TIiQONKTdjHi+Dom6waDiw/0ywJ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1787909113;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lpmPCNsWLXh5FftYlzy/1pjHp63dvSXhlePVbCGiGao=;
	b=JJT+bBJNYfclk6TE26ECsU2NlE7jzMCVGKgaS9AEFMw4GshklJU+5f/MSt72y34dDdPntC
	zQQ5/7lNlEAuOXBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=B3rXhQB2;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=5p9ZdV6N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1787909108; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lpmPCNsWLXh5FftYlzy/1pjHp63dvSXhlePVbCGiGao=;
	b=B3rXhQB29alt7bSGBF/zd9scbu0Y3yJCYIEGn2WYJCcuO0KIeUbwbiStDBmhscmmaWDi6G
	j/g1EIzUw5aLqc/W/dw5hIAVwMGbgNH8h9EkmvrUSpAsF4NGTPGb4GcoBebAU1lHG+fqY7
	rbNsAf9f6xrrwAkXYVBCOOLkQQ3AUYM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1787909108;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lpmPCNsWLXh5FftYlzy/1pjHp63dvSXhlePVbCGiGao=;
	b=5p9ZdV6NoMbb6v4CJu7hReP0tN84NR3MZuxGuTEtAAqLwOYb0NkjUoLX7s4eFns8G7ndlB
	bxF/Aa/yTcdYVIAw==
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] livepatch: Reject livepatches with aliased old_func
From: Miroslav Benes <mbenes@suse.cz>
To: Harry Hsu <x90613@gmail.com>
Cc: pmladek@suse.com, jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, 
 joe.lawrence@redhat.com, live-patching@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260823060734.58443-1-x90613@gmail.com>
References: <20260823060734.58443-1-x90613@gmail.com>
Date: Fri, 28 Aug 2026 11:25:04 +0200
Message-Id: <178790910495.159175.9840885229545488689.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2955; i=mbenes@suse.cz;
 h=from:subject:message-id; bh=wNXgYJzwzhjutqPG3YG+6h3Jchdd87ACFU5BjlUnoLM=;
 b=owGbwMvMwMHYWJt9x2W1tA7jabUkhqyJwR/Fvi/d8edg+v9S9cq/bm8rb535soltIz+z4T3nz
 FPKPWbKnYz+LAyMHAyWYoosr/c6yxlOyTXQrH53F2YQKxPIFGmRBgYgYGHgy03MKzXSMdIz1TbU
 MwQydIwYuDgFYKqD/DkYFpw4mNx5Ysebk3ObrIWNd2ps3jZ98tc3h55PfndOfMJvPa1HPd9f3/Q
 yF/kc4jNDbWJOwonYn90Hezp+8a+5fFzQUm1WJfdDEV2Nmtx9MmV7mnxDTLk4Z5YnL+8MepTi7b
 NiVYbH641uC7l5fVQ0M/ZEO+YoKHSUKe0Jf6ByfdOut8vq4nP4pNZdMba9/NFr4s655X+sLgcse
 6UU337CZP8302BfwaPCLSz3VaZ+/2MXsvpglPZqnhWS+x3fTojW02MNasn72Cxs/GXHyz6raTNn
 nLjic2aeWn+tdr1lks2RckeD4jSx+sNLzD8/dxWdFV/1lMMvYEKJ/9Upi26GnXZhNVl/p3dBMHf
 JtdA+AA==
X-Developer-Key: i=mbenes@suse.cz; a=openpgp;
 fpr=91BB0699882EF39D46654BB3FF98A38DA80834DA
X-Spam-Level: ***************
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: add header
X-Rspamd-Queue-Id: D82971F839
X-Spamd-Result: default: False [15.38 / 50.00];
	SPAM_FLAG(5.00)[];
	NEURAL_SPAM_LONG(3.50)[1.000];
	HFILTER_HELO_5(3.00)[localhost.localdomain];
	BAYES_HAM(-3.00)[100.00%];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	RDNS_NONE(2.00)[];
	ONCE_RECEIVED(1.20)[];
	NEURAL_SPAM_SHORT(0.99)[0.330];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b2bf:1b::12ef:from];
	MIME_TRACE(0.00)[0:+];
	DIRECT_TO_MX(0.00)[b4 0.17-dev];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DNSWL_BLOCKED(0.00)[2a07:de40:b2bf:1b::12ef:from];
	RCVD_COUNT_ZERO(0.00)[0];
	RCPT_COUNT_SEVEN(0.00)[8];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,localhost.localdomain:helo,suse.cz:dkim,suse.cz:email]
X-Spamd-Bar: +++++++++++++++
X-Spam-Flag: YES
X-Spam-Score: 15.38
X-Spam: Yes

> Several symbols can share one address:
> 
>   ffffffff8ed7fef0 t __do_sys_fork
>   ffffffff8ed7fef0 T __ia32_sys_fork
>   ffffffff8ed7fef0 T __x64_sys_fork
> 
> klp_find_ops() looks the ops up by func->old_func, i.e. by address, so
> two klp_funcs of the same livepatch naming two of these symbols resolve
> to the same klp_ops and are both pushed onto one ops->func_stack.
> 
> This breaks the assumption that a single livepatch contributes at most
> one entry to any func_stack.  klp_ftrace_handler() picks the entry at
> the top of the stack, but when both entries belong to the same livepatch
> there is nothing that says which of them should be used in the PATCHED
> state, and the UNPATCHED state has to end up at the original function
> either way.  klp_check_stack_func() cannot tell them apart either: it
> asks whether the preceding entry is the original function or another
> livepatch's replacement, and an aliased sibling is neither.
> 
> Patching two aliases of one function from a single livepatch was never
> meaningful, so reject it while the object is being initialized rather
> than leave the redirection undefined.  Compare the resolved old_func of
> each klp_func against the ones already resolved for the same klp_object
> and return -EINVAL on a match, naming both symbols so that the offending
> pair can be found in the livepatch source.
> 
> Fixes: 3c33f5b99d68 ("livepatch: support for repatching a function")
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Harry Hsu <x90613@gmail.com>
>
> diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
> index 28d15ba58a26..c35cf08c27c8 100644
> --- a/kernel/livepatch/core.c
> +++ b/kernel/livepatch/core.c
> @@ -866,7 +866,7 @@ static void klp_clear_object_relocs(struct klp_patch *patch,
>  static int klp_init_object_loaded(struct klp_patch *patch,
>  				  struct klp_object *obj)
>  {
> -	struct klp_func *func;
> +	struct klp_func *func, *prev_func;
>  	int ret;
>  
>  	if (klp_is_module(obj)) {
> @@ -888,6 +888,21 @@ static int klp_init_object_loaded(struct klp_patch *patch,
>  		if (ret)
>  			return ret;
>  
> +		/*
> +		 * Aliased symbols share one address, so they would resolve to
> +		 * the same klp_ops and stack up on a single ops->func_stack,
> +		 * leaving the redirection ambiguous.  Reject the livepatch.
> +		 */

The comment is imprecise because you reject the live patch only in
klp_enable_patch()->klp_init_object() path. However,
klp_init_object_loaded() is also called in klp_module_coming() under
load_module() for just loaded modules. In this case, the loaded module
is rejected and not loaded if there is an error in the live patch
application.

The change still makes sense but your patch is not a live patch
validation. The comment should be fixed and perhaps the changelog as
well.

With that

Acked-by: Miroslav Benes <mbenes@suse.cz>

-- 
Miroslav

