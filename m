Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74203DB63A
	for <live-patching@vger.kernel.org>; Wed,  2 Sep 2026 07:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788334322; cv=none; b=DEUfP+uJamjfdwLYDL+dm5lJOBsC0JoXsaz3bQIPPsa4kGcu6omf44O/2BkbiWujTY4wWdIuuOZSHBNIuj1RDwHRuqRLENrS5N4z09w3OYtwAhMZIJzcjHB71z6o4B8lU3FysBX/EmWwNJ7CMb8YTIpcfxNK7Dii42q/7zDYrbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788334322; c=relaxed/simple;
	bh=O2WJPYiOsf2wYn2jzIY8yQgHOl6uh43qlBduJlQ/NFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uSZbV8zLw13zIv1CNgw/lfqL9veDKwnWw8GhzsYZi50hrdNOWl4rnIU64shalBGxNnUdLrtz2/TaULGJVBYdDXW62K/iPbylp+TwIbLEIsB9lXsO1GGxqqdr8DnGXVXIoOyWZErOr9ofWF3w7FXloJQqcvBV2C6U+gd7vM1ZtmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=R0Y1NNH7; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="R0Y1NNH7"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49b0d8bc2aaso6381735e9.0
        for <live-patching@vger.kernel.org>; Wed, 02 Sep 2026 00:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1788334318; x=1788939118; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EAYe6JN4PjoB8uoeAgLw83M5hqMiL5Zd3QrnIu8h9zk=;
        b=R0Y1NNH7Jk5cR3v86TxDDMf04+QBxQpbyGoqafCwBt4yJDikUyb9BPKGr4sSUsBanJ
         9KuJ46jpcP610jBwrrbfreGd7ZcAhh1+FR+/6J7jAIQjHE/UZYVuPXlgwL5gUuuZzvpk
         g818FaOn80/oUmLuCiwZHtkZTW7V1+0zTG9XDW4/T4XY1epwdCB3Y2TRhoAEirnLDzHX
         TwMR5bKQ3duyiEXBn4q07/hZ+iyJhXbua/pvNH8i65ZwAYDic3Kdd6lhFWU8VPgTwYyT
         38L8RXaPADez67j4RqpFDpznYLUdlHuUBhJF3hUCB9GS7N04siseCuA54JxA3YsyWBj9
         0+Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788334318; x=1788939118;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EAYe6JN4PjoB8uoeAgLw83M5hqMiL5Zd3QrnIu8h9zk=;
        b=rWa3ZUvI6ra2Uop3iBWkSKQ7P/Vu9OESwYapOsD+Sh94vgA85GRnOBzC1uhTNMN0ta
         /S+wqSjI/BWUhA07QBFO9U4UkmOQzMCJppjgXPH/kNkjK4lwVwkmSjahicSGrlU3TadQ
         4R76hhD27d0rySNG/mcqVQu48h38IfOK8jA5Xq28bt7uyYWzepattJ5GmfMUxeFvZJ86
         uBCczVqa3CKh67WnA3DNExvX8tbQnjGkss+T2kiE9yeQYA6/ZdfAruFORL2s5YlxgNky
         yJKLcLcTFehSIDrnWX6+stzIodL/1DODD6gHDBxn2phwaIWdvrcEz+A9CF1VrzMaR4f5
         6P3w==
X-Forwarded-Encrypted: i=1; AHgh+RrH2hC12cEXmGZLxGimdkO6kwx5pxiRJ6c8M4ro6VPkDUAWMvTYSKUD4lSvkYHvDblCOohkg+QBSA1dc7VM@vger.kernel.org
X-Gm-Message-State: AFuF++kQfSH6L4ELynFv6uyXD9mnUw4ThvxGMxYvtJZOkZJK0BTnj+G8
	lYfHsfc/mlijWn3EVGuxOiFRhPjqVAvQ1dLNIBbDndSfg85WQKjeFmfyZGFzFk+CTYk=
X-Gm-Gg: AR+sD13TFBe0ctMSxy/6b8DaqNT8uo2Z+kH1CAc5kz3Boe4oaRLlKohVtAB5tfiverR
	CO9QbYRxlYEK+hoYpvAg4ffwpJCF3/bCxv2kjhf8ouM0oFD0TwabDU4ikvVhRp0Gs8yjiSO1tPj
	3jxRyPud9S/fxhvfDC2ZKSupEB4UQv7vJa4Vd+V/JBPWhIGgPhHfM6lnwdrVc6o4GJw2t5i9CYa
	IfPx1btAZ/nDrHsp2TYr6VnfYDVnbQiihfUfcVi2lo4PiRbSAavhIfc2jymAY/NqpBYtGPsjAwc
	f1+0BiT1PeX7iSfomeawJeIQRxfQ0HfCK9LV8hQERVPewTUw23yp1LP33cMnEWNpn4Zfaeid0OH
	LjM3ImgthL29Osm6GRU+l80GkE6o2IuRCIQpvph/xn8j6lhaACg9uzzSSAifKqvnb0Y7SLXFfg8
	y6kIBmPe9kVVpsBPqAnQB+CK6hAnEP8jodrkPoWZJrNwc8ZvoopPZQ7G5HpYbb/A==
X-Received: by 2002:a05:600c:45c4:b0:499:79b9:e220 with SMTP id 5b1f17b1804b1-49ce5816186mr44628535e9.10.1788334317856;
        Wed, 02 Sep 2026 00:31:57 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448e7f8f9sm4597769f8f.9.2026.09.02.00.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 00:31:56 -0700 (PDT)
Date: Wed, 2 Sep 2026 09:31:53 +0200
From: Petr Mladek <pmladek@suse.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz,
	joe.lawrence@redhat.com, song@kernel.org,
	live-patching@vger.kernel.org
Subject: Replace rules: was: Re: [PATCH v7 for-next 3/8] livepatch: Implement
 replace set for scoped atomic replace
Message-ID: <apfQ6c_3giN615Ll@pathway.suse.cz>
References: <20260825114641.80452-1-laoar.shao@gmail.com>
 <20260825114641.80452-4-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825114641.80452-4-laoar.shao@gmail.com>

On Tue 2026-08-25 19:46:36, Yafang Shao wrote:
> The current bool replace flag is too coarse: it is either all or
> nothing. A livepatch with .replace=true replaces ALL existing
> livepatches, which is safe but inflexible. There is no way to have
> multiple independent livepatch sets coexist on the same system.
> 
> Replace it with a more flexible model using two new fields in
> struct klp_patch:
> 
> - provides: an unsigned int id identifying the patch replace set.
>   By default (provides=0), any livepatch replaces any other livepatch.
>
> - obsoletes: an optional array of unsigned int ids specifying
>   additional provides ids to be replaced. This allows a new patch
>   to explicitly obsolete patches from different replace sets.

> --- a/include/linux/livepatch.h
> +++ b/include/linux/livepatch.h
> @@ -123,7 +123,8 @@ struct klp_state {
>   * @mod:	reference to the live patch module
>   * @objs:	object entries for kernel objects to be patched
>   * @states:	system states that can get modified
> - * @replace:	replace all actively used patches
> + * @provides:	only one active livepatch per id
> + * @obsoletes:	replace given livepatch id(s)
>   * @list:	list node for global list of actively used patches
>   * @kobj:	kobject for sysfs resources
>   * @obj_list:	dynamic list of the object entries
> @@ -137,7 +138,9 @@ struct klp_patch {
>  	struct module *mod;
>  	struct klp_object *objs;
>  	struct klp_state *states;
> -	bool replace;
> +	unsigned int provides;
> +	unsigned int *obsoletes;
> +	unsigned int nr_obsoletes;

This is a different sematic in compare with the other arrays.
I guess that you wanted to allow obsoleting livepatch with '0' ID.

But '0' is special. It obsoletes anything. Maybe, we could
make it even more special and say that it can't obsoleted.
Then we would be able to use it as the trailing element
in the array...

I do not have strong opinion about this. It is just an idea.


Another question:

Should we allow to enable a livepatch when its provides id
is obsoleted by a currently enabled livepatch?

For example, let's have:

  + Livepatch A: provides:1
  + Livepatch B: provides:2, obsoletes:1

Now, two scenarios:

  1. Livepatch A can be replaced by livepatch B. This is easy.
  2. Can livepatch B get replaced by livepatch A?

The current code would allow to replace B with A when there is
_no_ real conflict in the livaptched objects, functions, and states.

But does it make sense?

Reasoning: Livepatch B obsoleted the livepatch A for a reason.
	It sounds like they should not be enabled at the same time.


Special case:

Should we allow to install a livepatch with non-zero provides
when a livepatch with zero provides is installed.

For example, let's have:

  + Livepatch A: provides:1
  + Livepatch B: provides:0

Now, two scenarios:

  1. Livepatch A can be replaced by livepatch B. This is easy.
  2. Can livepatch A be installed in parallel with B?

Reasoning: The livepatch B replaces everything because it wants
	to be the only installed livepatch. It sounds weird
	to "break" it by installing A in parallel later again.


Best Regards,
Petr
