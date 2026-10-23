Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792749538;
	b=qnhFJkLRWFNxaJ/xnYklPr7bMI76+YrBFRH3PC1cNRGn0++stja2f1iblS/DxKi4fg5+
	 8erR8hDrYBf/PQ/bQhZf7YQ5QG3zZRGKAfGMHa2igN9nv3SZNAL9L+ozK0ZFCvSm2mQuY
	 /nx8LhD2/1PptSBxDx4XOR4leAyqNYpen16ZAXHqGwfIYTv5WYG9BCG0hDZmoRbG1ZtEJ
	 YsCzg/Qkv5usoirxs2iJYlcyN1idb1Q1m7eJhPGX/IEksjcmdLPUF4ac+fnd5A2RZTM30
	 ctGVR2Rnm7INq8Z6P/oLBiT0BbNm1iyknAe+LdQBhqYLD7SgFNba6uJKuH8bzfEQ3EA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792749538;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=8o1fTvyEh688jtdQDHJw4W3pHAyAJ2dbda4L0Sg0PSs=;
	b=VE2t+9EUp4KBCOENq9nSeL66EEIflcLUoXTUnM1GOl9BVL2cKZPQVy3k5BiEKNxQeYkH
	 0yXTbHxLmoXYNA++c6JQRtXqdzBpO6vZ+T5rbgFiE4N3W71nv0XYWgCoN11ZGRcDg0fdp
	 Lgn5/zi4JOA2bR5s9Sb/RrOCr3zGsMgqyDrHRbUZpOY+2fsmJ5d+78v3ccmOlxbIgnpWx
	 tht5bUCqdms3SubXZymLPCqBorBYPHSgGE86aM8mJYVr77AXoPJE726r5+j1mJVZczE4J
	 HYUem0dJvAwVEI5W9wnzdz/LdUEhwawB4urbiS3ufA9rY+XrnaPfM0T42pssCVHWUhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=EQJrYD6x;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6A6606A31D
	for <live-patching@vger.kernel.org>; Fri, 23 Oct 2026 09:58:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B6A6606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=EQJrYD6x
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a207b02a2cso4441925e9.1
        for <live-patching@vger.kernel.org>; Fri, 23 Oct 2026 02:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1792749537; x=1793354337; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8o1fTvyEh688jtdQDHJw4W3pHAyAJ2dbda4L0Sg0PSs=;
        b=EQJrYD6x/KPqAjsGA9s2AcvYUB2mEKk5+BNieS0JgZlnpp2VWiZLG+Sn1dEOYwUa2P
         bVEiLlYESOJoVcSsF/l2omBoxkJ0/GbGzG1CCn/Np+EUg1+viZraefodQrU0RCOOroSr
         QbvSTmje36kZuoJ7Gs0H47d50SNjpYNO5wBx0SrIfflA1HQkOjIHiOPKEizQd33HVBRp
         MunNm9aBKK9/0Uvse/HPJvV6Udo/O0V7JZW75M2mTzQtyV3Uyc+NYXMqI8MnosvkGBtm
         yUcgdhBmPtYHsTp/lgG31A7QmdFoWnxD/pJJriCxJxFxotKQPBHF1OCVUTVQUdsTRru1
         90vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792749537; x=1793354337;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8o1fTvyEh688jtdQDHJw4W3pHAyAJ2dbda4L0Sg0PSs=;
        b=OcXQ8y4zFLn3tckJIX1CTJUFjVl7B34C4Uuihy24TeF3w3CybM/EkfDcVMRNh/HI5R
         KSFAWJcb8zZsYGyacUr5sizw9V4elKyPRFRuRgIyLTVbFYxyfNwL1PGm+0Ib/KyRarGz
         WXiV7MUWTmvqhE8RBtrvrjhWmJif+Meoc7UDVx1TDfgHngZlrwfOv2nfZKPqq8csjVpX
         3/RarielEKk1zAq8WYfvJ8iUlQBf9x3nwKeybvg9oL3CrbBiGukv6njfeclHu2i0U5c/
         9wIpAH4qX2wVI48l0C+hLlXoezQK10Bqh4cVVxA8QMCsIx7rYjFpB5ffP+OycsvAGqg4
         ZR5w==
X-Forwarded-Encrypted: i=1; AKwUvBzVfYSV3MKrBUjHaEQIStqdeDMzUuCec+AjsfndJj8FCWy8MBLTfBizHPljkjKlmqv9vgKwb/I5O3NQnZi7@vger.kernel.org
X-Gm-Message-State: AFq9FYJqUo5QPT7Q3Hi8veAI8ymM6QTGX60zhBl1PM06Vy2o86FUVEcM
	ERZ3ENehfZbVsOccJYOkqDDt5HIx3UYIqNbuZq2WJoTSTkzc8VUu+LzpsEwEz+m5Hwg=
X-Gm-Gg: AYBFou1BtBE50jxn8mt7gSEt5N32pg0xpNjY02MjDOeFS7GusC+7IzzF0WHt6g1Adl4
	KHyzYIdT1/jTVNkyQCL2jiqduC8vgCSUr5zNubXVes6N3CK0C5hT+SVFokiaDGwaYVKrxiWQUCj
	NlalTGKXtTRXo46JGH7KjDc1jBGK9HzOsisW3N1xtdhV1ieWJV6DUbdiUDYaf/9LaD+PvdaB4Zw
	rZmOCj4jJ0iHFY/kavswo4gpTD/2HZNrB1a8L8yfWyVR7+BBTjIR9bJWVSgkzUcK8+Yqx8eeF8q
	Smj9dt3gFSjWPK5mRjlbBKkRP5V/omAlFhNZjKXTdyJsjQawidkSb409XBnzIr9pDdlEfWczg3G
	FYT18tlWilJlxjKD+ZRNZ++by5oQv7mSMMj6X8YaSU7yRYwFMfVkTKVHjRacdFa5/7Ss+Nl0Fbi
	pvzhci5CnR7rTajZLDMiGlmle5uUGGWBJ7w6LuLrAgU2wke6kQ+nsPFpmKWt571EAF0Nfzyq+wb
	9TRV9a+vZxPWTYFetHA3VzQp2dR3YmRsyZR+XdVLgwfYUB07VHFmXiMUw==
X-Received: by 2002:a05:600c:4e8e:b0:4a1:d248:25c4 with SMTP id 5b1f17b1804b1-4a211c9e7dbmr28672265e9.13.1792749536716;
        Fri, 23 Oct 2026 02:58:56 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a211b89beasm56990205e9.5.2026.10.23.02.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 02:58:56 -0700 (PDT)
Date: Fri, 23 Oct 2026 11:58:54 +0200
From: Petr Mladek <pmladek@suse.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz,
	joe.lawrence@redhat.com, song@kernel.org,
	live-patching@vger.kernel.org
Subject: Re: [PATCH v12 8/9] selftests/livepatch: Add state test for
 provides/obsoletes
Message-ID: <atsv3jxebDGoP0hw@pathway.suse.cz>
References: <20261016053708.47089-1-laoar.shao@gmail.com>
 <20261016053708.47089-9-laoar.shao@gmail.com>
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016053708.47089-9-laoar.shao@gmail.com>

On Fri 2026-10-16 13:37:07, Yafang Shao wrote:
> Livepatches with different provides ids must not share the same state
> id, unless the second livepatch replaces the first one via obsoletes.
> 
> Add provides/obsoletes module parameters to test_klp_state and
> test_klp_state2, and cover both cases: reusing a state id across
> different provides ids is rejected, while it is allowed when the new
> livepatch obsoletes the old one.
> 
> --- a/tools/testing/selftests/livepatch/test_modules/test_klp_state.c
> +++ b/tools/testing/selftests/livepatch/test_modules/test_klp_state.c
> @@ -151,6 +165,16 @@ static struct klp_patch patch = {
>  
>  static int test_klp_callbacks_demo_init(void)
>  {
> +#ifdef CONFIG_KLP_HAS_PROVIDES
> +	patch.provides = provides;
> +	if (nr_obsoletes > 0) {
> +		patch.obsoletes = obsoletes;
> +		patch.nr_obsoletes = nr_obsoletes;
> +	}
> +#else
> +	patch.replace = true;

This changes the behavior. The original patch did not replace
others.

I believe that it would break the last test in test-sysfs.sh.
It passes with this patchset because the problematic test
is skipped. But it would break the test when it is used
for older kernels.

I guess that it is a cut-&-paste mistake ;-)

> +#endif
> +	states[0].id = state;
>  	return klp_enable_patch(&patch);
>  }
>  
> diff --git a/tools/testing/selftests/livepatch/test_modules/test_klp_state2.c b/tools/testing/selftests/livepatch/test_modules/test_klp_state2.c
> index 5f07fe1be2b9..aeb911b87d37 100644
> --- a/tools/testing/selftests/livepatch/test_modules/test_klp_state2.c
> +++ b/tools/testing/selftests/livepatch/test_modules/test_klp_state2.c
> @@ -180,6 +194,16 @@ static struct klp_patch patch = {
>  
>  static int test_klp_callbacks_demo_init(void)
>  {
> +#ifdef CONFIG_KLP_HAS_PROVIDES
> +	patch.provides = provides;
> +	if (nr_obsoletes > 0) {
> +		patch.obsoletes = obsoletes;
> +		patch.nr_obsoletes = nr_obsoletes;
> +	}
> +#else
> +	patch.replace = true;

Same here:

> +#endif
> +	states[0].id = state;
>  	return klp_enable_patch(&patch);
>  }

Otherwise, it looks good to me and passes the test.

With the "patch.replace = true;" lines removed:

Reviewed-by: Petr Mladek <pmladek@suse.com>
Tested-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
