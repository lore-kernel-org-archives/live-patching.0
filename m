Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E50B2C158A
	for <live-patching@vger.kernel.org>; Tue,  9 Jun 2026 13:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781011644; cv=none; b=rJwUkLil4S09mhm9Oz2I6Nk4JhgUcB4zSTu7uz6Lt++UZMmqe2g0vQLtUcfAPXazzgQV8kKFX/V+5Y7+aM3Qfg6cIhuyICX+tt2jzFo4DSOudy2WChN9Ycf4YHKtdHMrQ6MmMRSUpSTmTTrXcA8JTFPDO71ZKSwndkJWlDJgBuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781011644; c=relaxed/simple;
	bh=nJgWcRE97u14s+WKZRamoSh/cs1PiaNvY3c+P2DrIiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Csgjmj7IRyuQWOV9u9YD9UpPKXajRh9jUVtIVE1ASO7koY/MpplVf+muhEJqhNAnMIls7WRNN72tNqKYmLwU9k28uuqgUVDe+rUr62oaYsTcXFHjgQYAXDOD3/bTiBJDA353ywcBlGYmmtorcxr4eOKr6Y93SqzN0u8l1Y51s3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GijhAwgZ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GijhAwgZ"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-490b12270b3so33324595e9.1
        for <live-patching@vger.kernel.org>; Tue, 09 Jun 2026 06:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781011642; x=1781616442; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VLR5C989rsq7aqE0N8rtbTSwNBg8Hw6/hQKjcsjJgzM=;
        b=GijhAwgZBSUlJ+EvjxGehHLBXB49AQpThaMrEASHnJ7fBhCygvsBrrw2KjQ7H9KZZD
         qqLKiAhlu/TwI9F8drNGmGEcb3VcjxlF7GewszVJoXbCIn8vAS7dYr6btH7FgNoVbAJR
         Ebk9ntSTPWAaTAYNfLmByvZ10WhUOzbBWB/We2/o4T+JGmBqPXIQPX+QrRiOyVm1n0VJ
         nX9W8DILk5P28v9Zt7vWwGI59N//YIjc7FaMvqnRvQDg06xP0qRJMKT/n2FAEVtZ1L3q
         5WbePHZCMa9KzmjBBWt5lkIWhAGNM16KgLZWRRvhl+NNglkf80Ib+IMnU7vrXTZhGyHl
         vu5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781011642; x=1781616442;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VLR5C989rsq7aqE0N8rtbTSwNBg8Hw6/hQKjcsjJgzM=;
        b=kgABs0yjV/bgQBL7MG0jwnY7WgIjQ2cVi+bpqxN+6SwKsqhNzJca+PF+1WuxCVP/E3
         Tt/nFaOHz9x1sbwuGRYHzXEphDPlJuce+RImNswOo7yRm1y8Ure8bolgQVuWKo+zuJSE
         P8FGpH3dd3MJbZ5P2zAgUu4T+cbw8T/OX3isN3kkxFe/n0vp9Su0igU7FTChRZegoAIM
         W9u3EgYmiaaSDzJuZE1zZ1cdQML+ZOYhc1ZVXsGS1GzmsBDYpBPGl1+2J/rP2mZphWtB
         Of0TLr32LvE+/b3l7WW5jQORnRhGuaUXHOIHPPE2b1flM+KeM9n+5WIxfH3qmzvyRQef
         4Ixg==
X-Forwarded-Encrypted: i=1; AFNElJ8AnuqdBELjSqYt7JpuUXtSdXubLLeqAo/PuOHeeJrLt+ikTILZqG5bbcaFR+Fq6HgwYhdx1OEpRb9Sp7X+@vger.kernel.org
X-Gm-Message-State: AOJu0YzE1Ktrx5U3YGowRT61TMOBjuQtFlwIPQH2Nx9oJBE3oJRVobW8
	c+PGngShLeVFhnZrZQv8RW1qjqsvK1Z8JDda6d9kvxAIIM7dxJPOpW+BQN4UjlJriao=
X-Gm-Gg: Acq92OEhEz4k52yGxbeYSK5Rr/RAxOgLWFppGIbEtGkkMiyfVM2qTpvZMEyXo5iVCKb
	cr8WDqMj/N4oi31scL13By16VwhuU80LvpjSJzoOmes4IYGQJFXGtxFU9+oncc5wjM0Xi9kdeie
	c1gDWJVTmOy2ZDfVyHzP1MfYtCoSsj8U7Y1Mr5AYI656H0rhYJ7Ax8OD6kitNlDG/bbnP+6UJE5
	GexUIteclsh3mHRNu3eC8tIXu24KzmbcLesGBwj2hpYKlMvnpyJc8I7aDivWJCOPVerOEaE6ORc
	36bdNx9UxKQsPL93XR2h7+9FM3iwUqgbPx5z3R09ATaCvdZfl6xFD3c0FsCmvoXdwwYw1wcrTys
	eH4kLYbc2NK6Ek36vSIEt8wU+SowvG75gBVLR3/wWMvKlS9QihqKqcXRzBAc9sWh1aqTCqSOhy7
	t20aXHPLGyC9IpeIgAF7js1l/FM1B6TDDo/8bg
X-Received: by 2002:a05:600c:4ec6:b0:490:9d1b:201f with SMTP id 5b1f17b1804b1-490c2629be6mr317570205e9.32.1781011641653;
        Tue, 09 Jun 2026 06:27:21 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3918fcsm551707115e9.3.2026.06.09.06.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 06:27:20 -0700 (PDT)
Date: Tue, 9 Jun 2026 15:27:18 +0200
From: Petr Mladek <pmladek@suse.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz,
	joe.lawrence@redhat.com, song@kernel.org,
	live-patching@vger.kernel.org, sashiko-bot <sashiko-bot@kernel.org>
Subject: Re: [PATCH v3 1/7] livepatch: Fix NULL pointer dereference in
 klp_find_func()
Message-ID: <aigUttsudeR9ps0p@pathway.suse.cz>
References: <20260607131659.29281-1-laoar.shao@gmail.com>
 <20260607131659.29281-2-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260607131659.29281-2-laoar.shao@gmail.com>

On Sun 2026-06-07 21:16:53, Yafang Shao wrote:
> If a newly loaded livepatch provides a function entry with a NULL old_name,
> func->old_name will be NULL when evaluated in strcmp():
> 
> klp_init_patch()
>     klp_add_nops()
>         klp_find_func()
>             strcmp(old_func->old_name, func->old_name)
> 
> --- a/kernel/livepatch/core.c
> +++ b/kernel/livepatch/core.c
> @@ -92,7 +92,7 @@ static struct klp_func *klp_find_func(struct klp_object *obj,
>  		 * Besides identical old_sympos, also consider old_sympos
>  		 * of 0 and 1 are identical.
>  		 */
> -		if ((strcmp(old_func->old_name, func->old_name) == 0) &&
> +		if ((func->old_name && strcmp(old_func->old_name, func->old_name) == 0) &&

I do not have a good feeling about this solution because it quietly
ignores a problem. As a result, klp_add_object_nops() would
call klp_alloc_func_nop() even though it does not make much sense.

A livepatch where any func->oldname is not defined should get
rejected. It will actually happen but _later_ in:

  + klp_init_patch()
    + klp_init_object()
      + klp_init_func()

I see three better possibilities.

1. We could move/add the sanity checks into klp_init_patch_early()
   and return broken livepatches earlier.

2. We could move/add the sanity check into a new klp_check_patch()
   which will be called even before klp_init_patch_early().

3. We could allow klp_find_func() to return ERR_PTR(-EINVAL).
   klp_add_object_nops() should then return the error as well.

My preference:

I would do the 3rd variant because it is much easier than
adding/moving all consistency checks between klp_init_*() and
klp_init_*_early() or klp_check_*() functions.


>  		    ((old_func->old_sympos == func->old_sympos) ||
>  		     (old_func->old_sympos == 0 && func->old_sympos == 1) ||
>  		     (old_func->old_sympos == 1 && func->old_sympos == 0))) {

Best Regards,
Petr
