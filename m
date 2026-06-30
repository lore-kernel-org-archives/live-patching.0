Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B136246AF04
	for <live-patching@vger.kernel.org>; Tue, 30 Jun 2026 15:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782834631; cv=none; b=cS6H4R2JeMLlWcplk4bYnlj6Pfzk5cxyPEgddYoD1qpBW+CeOJ0/+RzWjApQjTy9+4BV++y428Js+d0BQfCDLMMpqkc5DUcyaHNIjI7orukHNtRVuIRwluqap0CZNqkidhX27Saywof8X6ocxCeMKnya3RmKRZlik3zc/Ldog+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782834631; c=relaxed/simple;
	bh=GASFMuSyqBEomYxsYzzKwkssdq8Udhe/rySbhzldBlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fa8GLVLCETavgYlzZwDI6dM9L2GL14lISqvUOA5tMU1AGO88ibtU9NmAFxuV6rbUlnYIpyxHsZSl+4TbFKY3fk+tdBZGaSNeVoB3LcoaQ5IpwKCfaOKEMUPC6/bU34oTBeLKPf5d36rcHDQzt9NApW6uUfn1Qx4q+8PMZGwakIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Xtq/mP23; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Xtq/mP23"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-493bab44440so4457015e9.0
        for <live-patching@vger.kernel.org>; Tue, 30 Jun 2026 08:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1782834624; x=1783439424; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hh1Imbo11NbS1trDmqJGaPzMRBFOz/hiAsgxNUobzSM=;
        b=Xtq/mP23C9L0zIPNOM/ZCRuc3KMq2Pl+YMWkf6N9mxQCinNgBz7ZVb8PdziXe2Qkms
         NS6F+Z72q184ptdR7AM3smlu0on9ILnzrkXtLCxTnsx0NRji2qCfjW/ABMqmflr20ggC
         SFdbKWdCMBufr3ROTn5318Iei+oqcNKrtKSirEDWzL3owm2RxcUyS2n7yp5MreBhyt3q
         Ur4s7f/rKtB+CG74uFXFyjt3aP1ZDxuFcg31RYuG18EN0qS+mptwMgHuaAoVk79I9D0D
         LChxPCFrZwm3HZb31a3vNfsR80sPr3Cy3EmztJ0axGQD0JrBe0WoGD+hrc7kxy9L/O1f
         dbgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782834624; x=1783439424;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hh1Imbo11NbS1trDmqJGaPzMRBFOz/hiAsgxNUobzSM=;
        b=Lh0CpOyPjZGWa8YqnaeHsdlzr3H3xtUAmD8n1iR2qJLwbCOvAHHQXK2cIRCk52hrei
         ukgJFZsJcsgGH9Q1gxpstImImb5KNid8F0th8kr70N23ESNNSHJL/ZIcuFbPyHpMtyxY
         SOfbDQXpp/wNhn1d+fZXH/TDRMSGUMXaN7jGD0DxB58OCgSaG+zib8qQbPeIeU/86f7Q
         ZokUhMm52PozIl504dYm+FAe+yvkU9n/+UFmvv+vE6FGbQPDZTD34xJKzvVpqlHFJQ7A
         a41D4D9MM9+FPPxNISLGiStyFXily4itdGzZ2UJ3u8615ufiX9w6yomdTCtiHLCSfmt2
         fVlw==
X-Forwarded-Encrypted: i=1; AFNElJ8o7crHDuO3q5cFXBclpxwmzhtYShvisFqBxvBCTQdolk8EF17Pg+AFb1DhsuFCGM+Kk+Ybz2fkLmk4sZQ7@vger.kernel.org
X-Gm-Message-State: AOJu0YweJcmJI09YArRqRvj0L0CEMTcUa6cRbvMmw6HvhtPggyJhxkD8
	s+dmXLF7bV0+yVfhjAujwuVR3qOEbJO95omuuspTVe5VUTXNRCwLSc9zbX1YbisV1ac=
X-Gm-Gg: AfdE7cn7K88G6mYRp6OBirsX2KpZAMNCM38eKXD5F8wagsXzU3QghtqaBMTZ4lOjvr9
	Aee571aoRK5YgTtQp6hoaH86L41JyLnulwWZ4XO/i0YnPmBOn576XfTeqTdNh/S+gIkXDy+xTBr
	MfizFUqwGwIP1o4Vl2tkTRN5Fi0yMkh0WOCZC/eLzvTuQZfRrc2j/st67xDZdfL8RwyMckfrRtw
	PMeG2/p2yiXMEJQM+v61aBtCFlNiWd4KBCBP/j1yqTekx9rlGV+gSzPuoP8TZNsQVXqhA2mQsV/
	w/ml/Rs49uPSxNGswMroSOOU+u16Hz23C5ThZGMcckdQZYlGFkPl82fHewgGQmwCzci97V3soqC
	wYVc4wSEKA5kI2FRTFl+6Qfonwmn0G5QXXf5qi2lfg8GIEp96SjB+dYRMCBfTmrt+T14qmO3bZh
	u4SsU2i8692hZClbe+zPPpXsz2+A==
X-Received: by 2002:a05:600c:a216:b0:492:582b:f21a with SMTP id 5b1f17b1804b1-493bc209353mr25278305e9.4.1782834623873;
        Tue, 30 Jun 2026 08:50:23 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-475643cd85dsm8370960f8f.15.2026.06.30.08.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 08:50:23 -0700 (PDT)
Date: Tue, 30 Jun 2026 17:50:21 +0200
From: Petr Mladek <pmladek@suse.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: mbenes@suse.cz, jikos@kernel.org, joe.lawrence@redhat.com,
	jpoimboe@kernel.org, live-patching@vger.kernel.org,
	sashiko-bot@kernel.org, song@kernel.org
Subject: Re: [PATCH v2] livepatch: Fix NULL pointer dereference in
 klp_find_func()
Message-ID: <akPlvWVbZlI-TqUS@pathway.suse.cz>
References: <alpine.LSU.2.21.2606251523310.18862@pobox.suse.cz>
 <20260628114635.33572-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260628114635.33572-1-laoar.shao@gmail.com>

On Sun 2026-06-28 19:46:35, Yafang Shao wrote:
> A NULL old_name in a newly loaded livepatch's function entry causes a
> NULL pointer dereference in strcmp():
> 
>   klp_init_patch()
>     klp_add_nops()
>       klp_find_func()
>         strcmp(old_func->old_name, func->old_name)
> 
> Add klp_check_patch() at the beginning of klp_enable_patch() to reject
> patches with NULL old_name before they reach this code path.
> 
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/live-patching/20260529040130.95A9C1F00893@smtp.kernel.org/
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Suggested-by: Miroslav Benes <mbenes@suse.cz>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Acked-by: Miroslav Benes <mbenes@suse.cz>

Looks good to me:

Reviewed-by: Petr Mladek <pmladek@suse.com>
Tested-by: Petr Mladek <pmladek@suse.com>

I think whether to rush this into 7.2-rcX or wait for 7.3.
On one hand, it is a possible security fix. On the other hand,
broken module could never get loaded and pass even a minimal QA.

I tend to push it for 7.2-rcX just to avoid questions from people
who ignore the real life vulnerabilty aspect.

Also see a nit below.

> --- a/kernel/livepatch/core.c
> +++ b/kernel/livepatch/core.c
> @@ -1092,6 +1089,25 @@ static int __klp_enable_patch(struct klp_patch *patch)
>  	return ret;
>  }
>  
> +static int klp_check_patch(struct klp_patch *patch)
> +{
> +	struct klp_object *obj;
> +	struct klp_func *func;
> +
> +	if (!patch || !patch->mod || !patch->objs)
> +		return -EINVAL;
> +
> +	klp_for_each_object_static(patch, obj) {
> +		if (!obj->funcs)
> +			return -EINVAL;

Nit: I would add an empty line here to make it better readable.
     Of course, this is a personal preference. But it seems that
     most contributors to this code prefer visual separators
     between misc code sections as well.

     No need for v3. I could add the empty line when pushing
     the change.

> +		klp_for_each_func_static(obj, func) {
> +			if (!func->old_name)
> +				return -EINVAL;
> +		}
> +	}
> +	return 0;
> +}
> +
>  /**
>   * klp_enable_patch() - enable the livepatch
>   * @patch:	patch to be enabled

Best Regards,
Petr
