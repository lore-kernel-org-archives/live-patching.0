Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1894C21ABD7
	for <live-patching@vger.kernel.org>; Wed, 24 Jun 2026 12:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782302620; cv=none; b=X2MvPkNx3bMouS5lLHG75d30UjYKy0YPug23tAELUyAmU464sDax2pv8nwOCGQNnQJIZWGK/9s4JyPlo28v0h/IKFXMifexY9en+hnD9ev8Jn73ze54udIYUAA1zl2GKzDjZlIVuzu/vpoMJFc2a31o8kR4ZVUrBF9xaYYEVf+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782302620; c=relaxed/simple;
	bh=ahCYj4WtRPpwK+J03vrMNqCtVAI1db2YMfopVb2SkLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aqroMbAD9E2FhVAfN8vBVvBIl+P8zr3qdaxXwZRwS0f7+x5jT02j0iz908kFrfHz3MyLK25VJYHsyDMaDTcXpLrYNO8d4CzzVs8tEiTN7T5+x7t8NhXKc+JEwuYYfrFAC7FyeKrFotAzLpCs8I/ZK7NACNhNO5gzliwzxbhzRlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IL0nGn5U; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IL0nGn5U"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49261a64cf4so3002185e9.2
        for <live-patching@vger.kernel.org>; Wed, 24 Jun 2026 05:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1782302617; x=1782907417; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d/K1OzLPZ89M6llYGDgr0vCo1CeN86/AQqTPrJ8cgy0=;
        b=IL0nGn5UQZLXaLgm3N/nfs4Y+hXneC754thbzWfHtUB6j4C3Uyob2Bh65kXoUNdcdd
         WG5K87c6+FWmkz2jDpmQZGFXMOSxSKbIVMMeauAKFYOzt64fRPMe1/A0jfR2h2cYnuTT
         CPw4H+lyAPPBSpAeOa5DmOfWIJRDgJ70LY1ra1xs7cqpZLEsiiLjybZMrjzefEmGwMt2
         6Ut4MT666X40Z2r4q8aAaHqZjgm+CHW3RxxeBXSEx05I0JDuBSeRIC20e4qvyaKlyuU/
         JSAN1b939wXfpJ/zug+Gc4Nvh1Aun0nOmdWSskSzZ7tAhUWSI80gb4rYYRxWttHDKDTN
         kA3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782302617; x=1782907417;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d/K1OzLPZ89M6llYGDgr0vCo1CeN86/AQqTPrJ8cgy0=;
        b=olZH7I9W/Rr6SkYq6NHwIfZW2dJ/T3k86XmpBZs8R1xxPeLUrbmmNmUp606hsbQCVu
         N4PlCmpFDDwiAaLtH6NW7cvkjWoF2romYfK+g1KU2++/qWYn77L9709cqGdk8iDM8V/S
         BfBQa3GUoMnsOQM1x2WJdUHnhUpGwVi1gbsT3uUKVEOJs/GSzYqnd8tDBboY+7LQS98O
         3Fy++CxIE3nX3bt3/mtKithYiC6gNz6t6TqvHSmGQPqj1dTn7W0hAme75SNM7BToCMsf
         xFTWRnVYSp7xI+dL7dSknBwH7v3G87oIz6qRBsl/xVRE2sHbnVkAAqqIa111F/5+4TXp
         VUQw==
X-Forwarded-Encrypted: i=1; AFNElJ+eMlz9b1mzgqpEZ4xP8Rfn9vXbaC4DaExF8GupCnKqgW/ToK70VQNTemZHQl0D6dKbZBFQDPshxMN5AZMI@vger.kernel.org
X-Gm-Message-State: AOJu0YzoU3QvN6Rza28i1+31C3E4cRJChZjxKc4QQtBXDsBVjYqlDEI3
	XvpiNOAAsfr421jpM0mHPtqhLDmkjy3WAL5hcv044o+uiYK//+cJ8C4U0GAt6/v4P94=
X-Gm-Gg: AfdE7cl4H8IB47epHID9n4yx2TxU0eDOJoT/IaxIfrHC1l/GB4cLg/TibTgaJ2AoOlv
	U1zrUjChayEJW0uUjT5NnUGOQdK6c37oW0z5fE/ciNoDFyuHPk8kwEikZLDAuH9XPFRqtk0JcTj
	DKdfPOwDCt3MfqCfdi4X7XaQgzW2F90TwH1rbIhHxq8ZisggIPo+iZIV3jOT+DPxxINEDG62kwC
	vGUofVb04ecQaWvDuCoBudwmtQlXJ3j0zsA9FwzeLXd+WFWd7p24p82NaS4vB3ZsbB91JCZ/6ng
	s13RIloE6zx5zHP9ILobean3ol6whVKp5sGpfr4yxFj40o4Fc77D09BqpolVegEIFN4NlZy78wg
	l6EEc3Ke+r06IpTFvvxrPJg4n868T2YSDEQYZ5/qjsqCf6e63zJ0GLrGQNr6LfbR4GhFGuxwXMv
	U4IsQ+f3Sy1yHXAag=
X-Received: by 2002:a05:600c:a012:b0:492:2e1c:1d19 with SMTP id 5b1f17b1804b1-49260875bbamr43359765e9.31.1782302617510;
        Wed, 24 Jun 2026 05:03:37 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923fc47720sm792645115e9.0.2026.06.24.05.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 05:03:37 -0700 (PDT)
Date: Wed, 24 Jun 2026 14:03:33 +0200
From: Petr Mladek <pmladek@suse.com>
To: Miroslav Benes <mbenes@suse.cz>
Cc: Yafang Shao <laoar.shao@gmail.com>, jpoimboe@kernel.org,
	jikos@kernel.org, joe.lawrence@redhat.com, song@kernel.org,
	live-patching@vger.kernel.org, sashiko-bot <sashiko-bot@kernel.org>
Subject: Re: [PATCH v3 1/7] livepatch: Fix NULL pointer dereference in
 klp_find_func()
Message-ID: <ajvHlaZN7UUgE0Rm@pathway.suse.cz>
References: <20260607131659.29281-1-laoar.shao@gmail.com>
 <20260607131659.29281-2-laoar.shao@gmail.com>
 <aigUttsudeR9ps0p@pathway.suse.cz>
 <178213807628.22518.1917005991720893454.b4-reply@b4>
 <CALOAHbAVZtmqHUpixhBx2295+cQUFGjW3cD_2o4H4eAvYpdOOw@mail.gmail.com>
 <alpine.LSU.2.21.2606231015110.1711@pobox.suse.cz>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.2606231015110.1711@pobox.suse.cz>

On Tue 2026-06-23 10:20:38, Miroslav Benes wrote:
> > > Anyway, could you send the fix separately since it is an existing issue,
> > > please?
> > 
> > Does the following change look good to you ?
> > 
> > diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
> > index 28d15ba58a26..317a3c866c76 100644
> > --- a/kernel/livepatch/core.c
> > +++ b/kernel/livepatch/core.c
> > @@ -799,9 +799,6 @@ void klp_free_replaced_patches_async(struct
> > klp_patch *new_patch)
> > 
> >  static int klp_init_func(struct klp_object *obj, struct klp_func *func)
> >  {
> > -       if (!func->old_name)
> > -               return -EINVAL;
> > -
> >         /*
> >          * NOPs get the address later. The patched module must be loaded,
> >          * see klp_init_object_loaded().
> > @@ -1107,8 +1104,9 @@ static int __klp_enable_patch(struct klp_patch *patch)
> >   */
> >  int klp_enable_patch(struct klp_patch *patch)
> >  {
> > -       int ret;
> >         struct klp_object *obj;
> > +       struct klp_func *func;
> > +       int ret;
> > 
> >         if (!patch || !patch->mod || !patch->objs)
> >                 return -EINVAL;
> > @@ -1116,9 +1114,12 @@ int klp_enable_patch(struct klp_patch *patch)
> >         klp_for_each_object_static(patch, obj) {
> >                 if (!obj->funcs)
> >                         return -EINVAL;
> > +               klp_for_each_func_static(obj, func) {
> > +                       if (!func->old_name)
> > +                               return -EINVAL;
> > +               }
> >         }
> > 
> > -
> >         if (!is_livepatch_module(patch->mod)) {
> >                 pr_err("module %s is not marked as a livepatch module\n",
> >                        patch->mod->name);
> 
> If you wrap it into klp_check_patch() which Petr proposed alongside 
> with all the checks at the beginning of klp_enable_patch() up to 
> is_livepatch_module(), then yes, I think.

+1

Best Regards,
Petr
