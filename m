Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D32374197
	for <live-patching@vger.kernel.org>; Tue, 23 Jun 2026 08:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782204011; cv=none; b=lYOLhkzOYNPvHo4rCtERcJro6MDge30EeEwrMi2VkTSroO0+c7tMP5wqEwbFUW09TroBJjhF7fSCVDTZ3CqLld8ZtHtYeRL8vlmarTb7ga+ph1hvXWvr9OpxGFteKoD90PY1NT7XMGDKtQCqvNJDH4SnFq+68j3WawXgFXgfeHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782204011; c=relaxed/simple;
	bh=hLVmeQh5kmlmOoT4VUbnzdF65iKGp7NWEMjWxs2rky4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=DEMGIJxnPyeHxSrRVSXS5+/3Kk+N3SwImno51O2dRH7ErxrWxwh/rJouHJFEUBjcsrZEkGIAEhFfd1iCQMHo10tduISq3hJqr2seXOtXBmGDAeljsxs5giBeIGr9yCwoKEgcWMw68LwJXz6FXSnMOAxI2CYXsI4qKvf4yzKG/WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oHLtQKdE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TMpBV4zc; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Q28DHE5g; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Nl3PkZ/0; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oHLtQKdE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TMpBV4zc";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Q28DHE5g";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Nl3PkZ/0"
Received: from pobox.suse.cz (unknown [10.128.32.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 92F3970BE1;
	Tue, 23 Jun 2026 08:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1782202842; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2racqlmusxajI8oGWSPBkIeWvjp4Z4AXrnGjOJVMGCA=;
	b=oHLtQKdET0jii1rU33Ev7Qyv5KO2Da2N3GDss1AhC8ujVKQ0nBLlLxDEe8FTgfR2r1cGkN
	tyTQbtvd7dZaVZZUBCM9adMAG/sWD58JWBt7x0QDezVGiYuNRALKoe1ToC4I7zL1yxLTJz
	ooNUUcLdVaGN7bGu5bpam2kIpwDM7p4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1782202842;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2racqlmusxajI8oGWSPBkIeWvjp4Z4AXrnGjOJVMGCA=;
	b=TMpBV4zccrL69Xn/lbNHyYlZbs0S9lDzM1sAsTspHpQFTrCaP6cjEm0i8GTFYg75V9bFzY
	KuuxqrFGab67FzAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1782202838; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2racqlmusxajI8oGWSPBkIeWvjp4Z4AXrnGjOJVMGCA=;
	b=Q28DHE5gFvvL4W6I73T2fnrcbh4ShQngsuyoucClzMx9Xu8h+O11GyTyEmEdNAWjicM2HU
	caMf9WrNnZ1brzMEsuK5UisEnjIzUMfMG/VcpFuOO77VqfmC7xh/16DqVGsLbkvEymCd+p
	eayY2wnZ4shio2xqKX3vFJAT0FFt+30=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1782202838;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2racqlmusxajI8oGWSPBkIeWvjp4Z4AXrnGjOJVMGCA=;
	b=Nl3PkZ/0SpO1yikktR7Gwj/Suj10ZLhWuVreHp7fSz58KgPLRookh52AbLId6exjBzmlxU
	bvqom/CJwxY+GNAQ==
Date: Tue, 23 Jun 2026 10:20:38 +0200 (CEST)
From: Miroslav Benes <mbenes@suse.cz>
To: Yafang Shao <laoar.shao@gmail.com>
cc: Petr Mladek <pmladek@suse.com>, jpoimboe@kernel.org, jikos@kernel.org, 
    joe.lawrence@redhat.com, song@kernel.org, live-patching@vger.kernel.org, 
    sashiko-bot <sashiko-bot@kernel.org>
Subject: Re: [PATCH v3 1/7] livepatch: Fix NULL pointer dereference in
 klp_find_func()
In-Reply-To: <CALOAHbAVZtmqHUpixhBx2295+cQUFGjW3cD_2o4H4eAvYpdOOw@mail.gmail.com>
Message-ID: <alpine.LSU.2.21.2606231015110.1711@pobox.suse.cz>
References: <20260607131659.29281-1-laoar.shao@gmail.com> <20260607131659.29281-2-laoar.shao@gmail.com> <aigUttsudeR9ps0p@pathway.suse.cz> <178213807628.22518.1917005991720893454.b4-reply@b4>
 <CALOAHbAVZtmqHUpixhBx2295+cQUFGjW3cD_2o4H4eAvYpdOOw@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TAGGED_RCPT(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[]
X-Spam-Level: 

> > Anyway, could you send the fix separately since it is an existing issue,
> > please?
> 
> Does the following change look good to you ?
> 
> diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
> index 28d15ba58a26..317a3c866c76 100644
> --- a/kernel/livepatch/core.c
> +++ b/kernel/livepatch/core.c
> @@ -799,9 +799,6 @@ void klp_free_replaced_patches_async(struct
> klp_patch *new_patch)
> 
>  static int klp_init_func(struct klp_object *obj, struct klp_func *func)
>  {
> -       if (!func->old_name)
> -               return -EINVAL;
> -
>         /*
>          * NOPs get the address later. The patched module must be loaded,
>          * see klp_init_object_loaded().
> @@ -1107,8 +1104,9 @@ static int __klp_enable_patch(struct klp_patch *patch)
>   */
>  int klp_enable_patch(struct klp_patch *patch)
>  {
> -       int ret;
>         struct klp_object *obj;
> +       struct klp_func *func;
> +       int ret;
> 
>         if (!patch || !patch->mod || !patch->objs)
>                 return -EINVAL;
> @@ -1116,9 +1114,12 @@ int klp_enable_patch(struct klp_patch *patch)
>         klp_for_each_object_static(patch, obj) {
>                 if (!obj->funcs)
>                         return -EINVAL;
> +               klp_for_each_func_static(obj, func) {
> +                       if (!func->old_name)
> +                               return -EINVAL;
> +               }
>         }
> 
> -
>         if (!is_livepatch_module(patch->mod)) {
>                 pr_err("module %s is not marked as a livepatch module\n",
>                        patch->mod->name);

If you wrap it into klp_check_patch() which Petr proposed alongside 
with all the checks at the beginning of klp_enable_patch() up to 
is_livepatch_module(), then yes, I think.

Miroslav
