Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00C23E00B4
	for <live-patching@vger.kernel.org>; Tue,  7 Jul 2026 12:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783426219; cv=none; b=QF5Bd1WEb3MTtYQr9knkBHnEwpfbtWF5KtR9P1r+QBm3vDM/qH4TT7FuFTSR+827Ef5dWU0llLCe1dL7bbGYmBvjL0gMPcAlkN1UPoAIiAyKxY6siWjGrNd1K66LEgbJ0390IYslhd+aUHkxRMGgwDTgtkwLJm9PJHb7yIOBGuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783426219; c=relaxed/simple;
	bh=QBVwa8Ft1AGgMXzNG3GdojzheiVnMyLI2i3p2LMHu7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AsXB+IPpJVxX9E6i6swunTt9rdX3rNxdNAdUdKD+e1WXxc5QiPgCGi6QtJdDR6O4ZYMRdBtxyDVbsP7w5hGUEHrMKoN7vCJaORua32nFDsEOAgpyqWyNW/o3ES1lALLj1ah/bf0sSxDd9Bcma/NyLcW7dy3WCEBqQI8J5IqqdRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cGIhqa+7; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cGIhqa+7"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-493b786d6c0so22215175e9.2
        for <live-patching@vger.kernel.org>; Tue, 07 Jul 2026 05:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783426216; x=1784031016; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5Gog4VR+uyDqdPTQz30iAA295+f27YE55oou1sV/LnU=;
        b=cGIhqa+7ct9uLDutrcIsEbgZ5vVYdcQr5YBet9AjqKzziFpZX5B+9bYG4Wi21xNUxG
         PU1+iyehY7IN5l6UvX94Z5buLxvBoEeMBJ5FubgUNErbu4w4Hn4Drs8DmMYnVMCKOiOc
         0tXBT+64COfIde7Nl0h7lx94YpDXuZ6uwtELEMFxV6qCEcUCSm8OqO9On6guPnIkfwUo
         aQIgBP/bX3Eeuok33nMR48LCvRz4yZ3D8W0z/AZ9/2EMFYQx4TIxF9kvBqdLj3PVyt34
         zW0KNi+TtRQJw7PQoCPS64cNs9aFMRPjbnLabZzJJmw+C2EFdhVI4u285iRWK5is2M3R
         uOxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783426216; x=1784031016;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5Gog4VR+uyDqdPTQz30iAA295+f27YE55oou1sV/LnU=;
        b=Tf0nEjUf70pPKxRmNCdGrEMHZWf1/QmquVqMFxRtPIl7G5N2I04NvXak9dGePT+wZI
         wMh7uv/7cJH1REi7WKSxJVNT7yckMjMtZaUpINiwGio2PYAnvXxI57AkQjcDVr0RbPwO
         6gRoqkUOuOXOiHZWCjJ34wm2gnxUQgz1bydbw0tP7VL42Oxe+fWGk4aUqlWe61hL1R/M
         /xuDD4OLr5FXW923Dj3Do/HNnXd47PHRQdWj0Nz9Ft+KvtE37DrRq8ozHt5VKkDJDFj4
         fiEOOd+zBExtu8n1WiRC6xE58TyjaXZdOum/OU8TXlbs8W3WCidBZoGnGpUHAX8IFD7T
         20eA==
X-Forwarded-Encrypted: i=1; AHgh+RrP3+uJx9FHve5dYv/sJ/IVVeGreRHy+kgdnJ0amf8PUczvVfjGUhVWyBvh1nu6GHhkr6rDHRiyNlARZ8X7@vger.kernel.org
X-Gm-Message-State: AOJu0YxawRxUeA6Ilp3T5f7RBNEJds15fBKqRnQQtOi+cyDw76WwrdiA
	zYX3wdB7REj7t9roUT26gexLGmVmKK3Cm2R+6fs5KcLW00FTihtI2PbkXfnlNFub4gk=
X-Gm-Gg: AfdE7cnsrcQx98xQjc/r8ItiY+epQnFmMoNdfFDsQ5Hna1SdMSJoKIYMwlpxyUGhafa
	oz02Bwmr+I8dydGacpnccjyMkfIxcLWLUf0SFeWmusGk1tp40QU/tCslZVEdQ1hNv3S7MDjq3Kc
	d/2LVgFkmQPWDynZV8WwzrQ+mYoJU0MxO19y7W4evhvXmmDfCbFKHoBRltltD7ZBdoJY1kM8WwJ
	KCh2qsji3HbOc3baqMslY2LTdNfOo2W+7GEaNckQRG4mZe2kjA7D6cUKydtMNbJ+ZV7ntREymMU
	1hKDLGznY7QOH9XPS3BRXadklb8SX4bS/OpprxTIRKUAc9K2BE1nDdlBuk3iCT0IWNHK69cbY7I
	SvQySYwx8R/PuhqQ7UFqqjd6Q9wQu3PGtjx84pLNEDaQxxpnBZxseaPNKuhMb+CjtRtfHTYJy63
	UEFtmZKatxT+L6l/s=
X-Received: by 2002:a05:600c:8b62:b0:493:bacb:1341 with SMTP id 5b1f17b1804b1-493df06699dmr54032755e9.4.1783426216116;
        Tue, 07 Jul 2026 05:10:16 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0f21543sm31884081f8f.35.2026.07.07.05.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 05:10:15 -0700 (PDT)
Date: Tue, 7 Jul 2026 14:10:13 +0200
From: Petr Mladek <pmladek@suse.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: mbenes@suse.cz, jikos@kernel.org, joe.lawrence@redhat.com,
	jpoimboe@kernel.org, live-patching@vger.kernel.org,
	sashiko-bot@kernel.org, song@kernel.org
Subject: Re: [PATCH v2] livepatch: Fix NULL pointer dereference in
 klp_find_func()
Message-ID: <akzspX63bvi_OobU@pathway.suse.cz>
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

JFYI, the patch has been committed into livepatching.git,
branch for-7.3/trivial.

Best Regards,
Petr
