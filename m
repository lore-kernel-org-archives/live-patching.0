Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A2447DFB1
	for <live-patching@vger.kernel.org>; Tue,  9 Jun 2026 15:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781018933; cv=none; b=HeSmcJoHXjTl5P06RpKY4Ms8FjtL8G2rKskqPLdW68FDH/ErD6i9Cc00r6nl8ZKSLTx4itn6fwAKaeQbGlXdYf4MvYjV3h/PV4E9YkoZ7s9zuA1UvT27izrKgbjDyxzJ64MRHDs/5QN62h8ziopAviWi7OMS6oV6fwS6BSAVKws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781018933; c=relaxed/simple;
	bh=kuXfQqs4b2oIGzrMrRN+9NXnualCAir2vJGhe9CniH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pRoPIO7QD6NWvNOMYrwcmtwXsXuH2UKFO6SdpmNjPlLEHVoxrx1Ip65YBqmz2o+BoQfyMdmNTDezQGX6FaWbcXsyBVQFoTAllLH/T4pGdLG1WO7B8wI4TDkM1uzj0SCxO52nRmH+96UFB5V2mgxHN6lgJEu4RcizJkZ+vXh21VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SWGrDuIW; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SWGrDuIW"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-45ef5146b56so4260395f8f.0
        for <live-patching@vger.kernel.org>; Tue, 09 Jun 2026 08:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781018930; x=1781623730; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GfPAQQD8KsPMrENU7N3gfz/A70JMxK71C95rI/qe550=;
        b=SWGrDuIWefbP6ZjjQJQU2EhOZDufqNEeG99Yn7RnAKz4KV6l4yUDlCKN3OhlnvA4CA
         3P3LoOH8CzLOj9mtfNPpP2Gjg4vU8zqO+VQqX4s5nR1PRwSI5kF8M9NNefpdPvnloYuj
         Mdz6sEN7JvEC9k7E6VfTGFTCNY7pZ1sEefxjkuSBWqPCnLr7/r3BsJm7bbc7Iz7qPZfV
         EfiH5/D/+CxIYdmzph9rbgbnIKC1uEPfTyZUTzzopfKoeiimspQqkDt1b8R1JzNmrgFH
         DAnwoxF/G50jm0FH46gLYf+EobcSToya5XF5lVpXe+jGOSs1m+lujAa2Sb9kL0Wcd6GP
         hqKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781018930; x=1781623730;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GfPAQQD8KsPMrENU7N3gfz/A70JMxK71C95rI/qe550=;
        b=I7LkwTiu6TZaxPEUOnDF1/nRkqZbNC6DdOK6E0W3ulc/ixZ8ov5t3zWdn55v+weomb
         g6iQ7HKJ7d5JoqzjthPCpFGodPYD/Z+13ujEEd+QHUugpIZ7AZw/MaG8aIMVbPsbCE25
         F086HZ4o2RXFWCzRYjr3sit6ssRpidPXMHl8rhlfb4g5XJ6dYDyH3Z8u0ejyG9XipOs2
         VzRCebtUKWArNNfhNlzR34F4FmotMbD7nVCoLFAnhv6aT0SJ6lDS2qR54O+toAuZjUo1
         zd1tNf21Mw3VkM9Miu+1c4bbCh0G8cIIyBWCnBQ5AElqqTpCojOQ55fTY3XbkbTVSEwa
         u4YA==
X-Forwarded-Encrypted: i=1; AFNElJ8Utn4pPNlrM5UURdiBsD/PXOWuWAlnyQpHl9KJixi/EDHNz0p9dipooo4pOFgwJpxtxy/4vPJDZrpziTrf@vger.kernel.org
X-Gm-Message-State: AOJu0YxiqJ8UNoZ3rWGyhD7fE5jXJK0eyzncRGy0hidofdEJKjs2Hh94
	oql/tG3zkeiCeX1hij7qZ0i4zvSqbNLCMgr2gRtpeCLVdjk/xTBkrarxkHlORsbGxZXC/7Q67Ez
	EpRWg
X-Gm-Gg: Acq92OGRXY4R9J4kNo0WDIQGIbox43dVT4ai9+k2hs8/AJz3lOAh8rHOftLqWQf6ex/
	8E7TRoGCifJfglIq5VpvgL48utE/mrbNkWsF3V6QlzDQVjyK9yLvH81je1oiPPcj9mYH9IQjFn4
	+gg/4qgubPnuZijchNqB85oaRjBMGszLFWshW/pDt0eaxch8+4Zx2W8jYWG4sbe03kXD/sw4Hhu
	vGtjOAGFbG90l/8FJixZnd28VHl7513WaNOYNYUmqGpPjNfcksrjQWvd1YGfcH6rpzerWrXyeQX
	h8jVVA42Y+F1pZ50M6d06O1OdeVAmeyWP2Et8ei5rPEXMEGcZPBa/KwxLB682xX61fWPdD1qOYn
	4CIpMOlMJdXDFR0ffPvWFDMHX2cY7gBliB83+PoDH5fjQnXNiYtDMKaIIrPsUErcj7kQxqxe0fm
	gs6bLzA/DK1x0E3iS8ejrcei6ANMMkF8e9t1T3
X-Received: by 2002:a05:6000:478a:b0:460:2e53:a6f6 with SMTP id ffacd0b85a97d-46032da275cmr16377084f8f.12.1781018930347;
        Tue, 09 Jun 2026 08:28:50 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2e4b18sm49632819f8f.10.2026.06.09.08.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 08:28:49 -0700 (PDT)
Date: Tue, 9 Jun 2026 17:28:47 +0200
From: Petr Mladek <pmladek@suse.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz,
	joe.lawrence@redhat.com, song@kernel.org,
	live-patching@vger.kernel.org
Subject: Re: [PATCH v3 2/7] livepatch: Move klp_find_func() into core.h
Message-ID: <aigxL-BRGq_Qn9Dq@pathway.suse.cz>
References: <20260607131659.29281-1-laoar.shao@gmail.com>
 <20260607131659.29281-3-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260607131659.29281-3-laoar.shao@gmail.com>

On Sun 2026-06-07 21:16:54, Yafang Shao wrote:
> This function will be used in other source file in the following patch.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  kernel/livepatch/core.c | 21 ---------------------
>  kernel/livepatch/core.h | 21 +++++++++++++++++++++
>  2 files changed, 21 insertions(+), 21 deletions(-)
> 
> diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
> index 95117f7a5b00..6e15ae96a0a7 100644
> --- a/kernel/livepatch/core.c
> +++ b/kernel/livepatch/core.c
> @@ -82,27 +82,6 @@ static bool klp_initialized(void)
>  	return !!klp_root_kobj;
>  }
>  
> -static struct klp_func *klp_find_func(struct klp_object *obj,
> -				      struct klp_func *old_func)
> -{
> -	struct klp_func *func;
> -
> -	klp_for_each_func(obj, func) {
> -		/*
> -		 * Besides identical old_sympos, also consider old_sympos
> -		 * of 0 and 1 are identical.
> -		 */
> -		if ((func->old_name && strcmp(old_func->old_name, func->old_name) == 0) &&
> -		    ((old_func->old_sympos == func->old_sympos) ||
> -		     (old_func->old_sympos == 0 && func->old_sympos == 1) ||
> -		     (old_func->old_sympos == 1 && func->old_sympos == 0))) {
> -			return func;
> -		}
> -	}
> -
> -	return NULL;
> -}
> -
>  static struct klp_object *klp_find_object(struct klp_patch *patch,
>  					  struct klp_object *old_obj)
>  {
> diff --git a/kernel/livepatch/core.h b/kernel/livepatch/core.h
> index 38209c7361b6..8f01eae875eb 100644
> --- a/kernel/livepatch/core.h
> +++ b/kernel/livepatch/core.h
> @@ -56,4 +56,25 @@ static inline void klp_post_unpatch_callback(struct klp_object *obj)
>  	obj->callbacks.post_unpatch_enabled = false;
>  }
>  
> +static inline struct klp_func *klp_find_func(struct klp_object *obj,
> +					     struct klp_func *old_func)
> +{
> +	struct klp_func *func;
> +
> +	klp_for_each_func(obj, func) {
> +		/*
> +		 * Besides identical old_sympos, also consider old_sympos
> +		 * of 0 and 1 are identical.
> +		 */
> +		if ((func->old_name && strcmp(old_func->old_name, func->old_name) == 0) &&
> +		    ((old_func->old_sympos == func->old_sympos) ||
> +		     (old_func->old_sympos == 0 && func->old_sympos == 1) ||
> +		     (old_func->old_sympos == 1 && func->old_sympos == 0))) {
> +			return func;
> +		}
> +	}
> +
> +	return NULL;
> +}

This is too big for in-lining to my taste. I would prefer to just
remove the static and declare it in the header file.

Also it would be nice to add a description of the function when we are
going to use it on more locations. Especially, if we allow to pass
errors via ERR_PTR.

Best Regards,
Petr
