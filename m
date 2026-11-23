Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795428924;
	b=lqRzLXbFIjRk/ubeHkdCvZsipYRQAtP+2Dg+4dFt367aYG33S+MUup0whiFvKc6kqW5/
	 kfMnSMd5DGTKo47WZjOf/tq3/R5QwpqEjcY6IWF2XCC1WSk5H2j3VY8geUhrEf+DSd9Pv
	 ulKRbvyXN0e323XEMyEBXYUV3EeipEXsybn2VtOLK9a0hFatlI1rTp/WB/ZPp5vVnuHQC
	 gzF5YeOeLbrvee36tK1Mbqx/na+JUSSLys3PTmi1/Ek4HWkgh+wUcf091sUUH7PPIY7M/
	 z50lv9QouUAS0WKgxBop5CB10E4LQ0Bu+JJcj9E9lojsRMR1cpMzvByZ1VofC4pI+2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795428924;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=YEmk1VDoJHLEYSmDRdBwUZmDsqu1t/NGQfUH3rocZOw=;
	b=DyCXSmj6ZTbrKGe9ZJNYcXqfHCSJzUgwtfZ4MHwo3AX5QRHU9avFbeFSt6ptrMe7rMfy
	 C8nQ87yB4b1d9MuO1WyZUlfs8FLOdYkoX3NTiftQcZ61mypvFiCvDYtHH3VHFr+FK40ue
	 3QjZlzHL9T2JILa4m9McsD2bBJ9ed0hbQre78Kn6qwXZH3CIo2Q7XpA20kBt4amMsJp0G
	 yoeapLOCtbcnnsYqFoCaZf5eQ7EZ5C3K0fq24nHDMFtyr7osmjNNYHSZEYZmKijHLd0/L
	 Flv9EQO6aYNGEDjtWUSR+D+fHBG2tZP79iWuxz/MWmla+1YVnMNZGB0dPccSg1vvyWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Tj1tka9c;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EE1606A321
	for <live-patching@vger.kernel.org>; Mon, 23 Nov 2026 10:15:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8EE1606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Tj1tka9c
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-49d05d51553so21635915e9.2
        for <live-patching@vger.kernel.org>; Mon, 23 Nov 2026 02:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1795428922; x=1796033722; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YEmk1VDoJHLEYSmDRdBwUZmDsqu1t/NGQfUH3rocZOw=;
        b=Tj1tka9cwCfSWVyOhNY4eRE05/jjgj461r/WnGC437Cg+uv520KTUAtreYXE4Uq4SQ
         VQPr4yG2Y0WusL/sss7VMDxH1FpnVaj07Df/tNh17yAjcNGkwUdYLutIBsU9wv5Br/Fp
         /3EHSls/7CqlnJcqVnP6DNcbP/cZtabyzOy7yIPtVQ0HUdS0h2pLtqRSxH33sUWzR4Bl
         VeFDHbK2pSt1RXv0nj4zGr0S5c43fOYQ5w6zOWGj4gda05ZvKucxdkX5pEkLO1PMgYGZ
         73Ko2Dj5NxRb64zkKdjz+wIrcy2vFOpvHLmQ+456M/dgvqKUIaFLpDle24Wwoad8e0pO
         MsKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795428922; x=1796033722;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YEmk1VDoJHLEYSmDRdBwUZmDsqu1t/NGQfUH3rocZOw=;
        b=X9B//ztRenNB8TRY2Uzpwpez3hwFmVQ5xpyt1GKjmFIBOLDe/myrOXhnhGDMiuuSrp
         f94Iw0vOxgj089N1RklUTqQHRY947ovrhAglq6ooqqFBSJ9h/GMJ06OtaE4++swoC81g
         Gycs18ovYUa34ZBXTRRjbhm9OpqbYDIrdAi/wwcXvuL3LjR8aUYD5gJaNgR7r7/vB5Y/
         94rP5Q8e81vbYCuW0at8C+ikfC1JWf9ztwVlmu0L0lxXh+Ck2vXsNgoAjlp4SZpJNwhI
         zljhhmbNiAqyb2tWFrHoEKjVx+JWr/Nm/WLp5fQF2guhQ5bhJg83EUX945/KBc2/qoTC
         sGNQ==
X-Forwarded-Encrypted: i=1; AL+hErFavXCiKQM3Y08DFi1oml2RTrEJ02Kv5xif8o1WSZ79hjin0HCNw6WGUanJqwF/ccGySJ4GcmsGQ52GGit8@vger.kernel.org
X-Gm-Message-State: APuU4Z979qZbz7aw9fUWk6KVwb/hltnMS+3v7nAE1+UjpClF01/KSuA7
	2w9zj4n85jJ5WigWR4UTt57Y7ee+XQKZHdMnuONX4qgFZ3iFGwc4s2v1uLWCe+OUYTk=
X-Gm-Gg: AZFdTZeeGf0le/w90mhNo5LeWqjY1tQR+FRA995KaIn9KAKnzlpvwhsB3hwjzBtrfqY
	xiMTZEfdtNzdoicI1cvaSV+ZMVAGmU4BySF6rCQiiUlIbdEnncvTumEtDy11cq//rhxiBN8QIJy
	i8uMsOVWQZFRRu5jx3kKU7I6wDSxo7qHopjpwsz7QftMVXhmtKU15GMHyeU1XplHNTGAjYrKHrb
	CwchLbEzyBtMD+6TIZqE6fSxEu71ZQbB8A2AD90aSPzNJ7II2EhLWsAh0TeAoIej09Ns4bm7H+4
	/ROE9eg/VNl+79ITofcsGaC00RVdaZjmrO8/qnX+iwJobGF8hM3p+MyRkuQavlutpUFg0ekNZTu
	LfYw4xFKgAuqdWT2sLU+2lhrFSf9rTOblroDYRh0bseLZ5QUqBVVK9HZkml+9qyaEZ0NKOjOtSs
	5TSpz6GnKIW0JZ+IgKxmC+eoWxA+ShicDsLk2tLj5ihhFMGvgf251MZxeXttbmbPB9RZelVcGiT
	2GbLLZUzDqUm+i2MhWUz9vcJ0wtiEa5Cjrm1aP2NxzPmdSut4/XooJI4CpqWrVe4dbk2M2SXvam
	bD5HK4gQBbk7xVn6bxowbIZxrTgveR2BKQTpZecUtYdXC0pCexhS
X-Received: by 2002:a05:600c:45d4:b0:4a2:84c:52f3 with SMTP id 5b1f17b1804b1-4bb8880988cmr238927785e9.6.1795428922043;
        Mon, 23 Nov 2026 02:15:22 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853b216esm381534625e9.12.2026.11.23.02.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 02:15:21 -0800 (PST)
Date: Mon, 23 Nov 2026 11:15:18 +0100
From: Petr Mladek <pmladek@suse.com>
To: Sasha Levin <sashal@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
	Joe Lawrence <joe.lawrence@redhat.com>, Song Liu <song@kernel.org>,
	Marcos Paulo de Souza <mpdesouza@suse.com>,
	Eva Kurchatova <eva.kurchatova@virtuozzo.com>,
	Yafang Shao <laoar.shao@gmail.com>, Shuah Khan <shuah@kernel.org>,
	live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] selftests/livepatch: skip the tests on kernels
 without livepatch
Message-ID: <awQSNi8Ex6eOcFOw@pathway.suse.cz>
References: <20261110161050.2451750-1-sashal@kernel.org>
 <20261110161050.2451750-2-sashal@kernel.org>
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
In-Reply-To: <20261110161050.2451750-2-sashal@kernel.org>

On Tue 2026-11-10 11:10:47, Sasha Levin wrote:
> The test modules can only be built against a kernel configured with
> CONFIG_LIVEPATCH, but the selftests try to build them for any kernel.
> 
> KernelCI builds the selftests for many kernel configurations, most of
> which do not enable livepatch. On mainline from November 8, 36 of its
> 69 kselftest builds fail to compile the test modules, for example:
> 
>   test_klp_callbacks_demo2.c:23:16: error: invalid use of undefined type 'struct klp_object'
> 
> These are arm and riscv kernels, which do not support livepatch, and
> x86, arm64, powerpc and loongarch configurations that do not enable it.
> 
> Do not build the test modules when the kernel in KDIR was configured
> without CONFIG_LIVEPATCH, and skip the tests when the running kernel has
> no /sys/kernel/livepatch.
> 
> Fixes: c4bbe83d27c2 ("livepatch: Move tests from lib/livepatch to selftests/livepatch")
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Looks reasonable and seems to work:

Reviewed-by: Petr Mladek <pmladek@suse.com>
Tested-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
