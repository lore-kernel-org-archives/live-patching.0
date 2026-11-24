Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795527340;
	b=OCMJPD4QlvfoV3bq6zuZBxYRPMbKL07zpwLFweahK+iznuPnRxd6S3u6drV1ePmNxBEY
	 0BQbomNjGj1Ew+RU1p48aR9vGOcAjpoWa1GKTL/NJcGV8U/hd1C7w+Zcm6fMDjWyyc1CZ
	 1mIjI/WEt+GcK+Uxwai9WMgBRoqFro1c1GADuWpeUZDuGHZN/Rs7BN2Ak+5B0EZ4i2Jjq
	 PsvDlCAAFotZ28B4wRir6U4TVQDu3hrcn9xTyHYzJmTog3XaP6EZ1CqD+lm/hTwby1bqi
	 tTo9PLQjN8GSz/LCbomDh+1Xny9F7ksUS0kpMd1oXUh04yDd/2jvGfnQTA9bFnBEhdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795527340;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=SlQLX7u1Me0NFtwAym0d5omjRG8dj5NZbOQLq3ePYHI=;
	b=PRsCo3oKWFiTSvYJunW0WlCPyzkNDARd3+C8SgMDBAxB9chXnI1cxLN2lo8zqe87PKas
	 23EoAI67PFGU3jkalLAsWo1deUcmaZMMtPbs4lgDGtXwwWGvhDTX+NzASreTyR13dx0fA
	 mB23mGbMNE14muSISL73ISF7QTJP89qNaZ/0HNSDez4halZ8FfGK/nNjd85UIAsJCx6ng
	 bDi/qtLhWY7XrpztXXAJYegbwKJHPITk2NV65V9Fbmy7rixbAcR56pHmgu3VFuAEOoDex
	 Q3au7FAYqsggy7E0MgThgSfhgEHsHhXS4s35w+J7RS32qx/pE7TR5/hsRhjMktYG9hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b="Mh/AXREb";
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494CE606A31E
	for <live-patching@vger.kernel.org>; Tue, 24 Nov 2026 13:35:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 494CE606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Mh/AXREb
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4ad6219f7d8so3869328f8f.0
        for <live-patching@vger.kernel.org>; Tue, 24 Nov 2026 05:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1795527338; x=1796132138; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SlQLX7u1Me0NFtwAym0d5omjRG8dj5NZbOQLq3ePYHI=;
        b=Mh/AXREbG1U7RIF+6X3VGuSkNAWZhoyGRI07gZPy7T+PtaFYPFMzvkCX2d9BBm/NY6
         +5zEDXBtu+tTmscJ2seQI8rRNJn18AkKAALC/wZH9qNpQgep9Lrot2gCSPLyvwxVMRuL
         jPSPIB+5p05ZUaiMHPT7VHMcSn0gBNilx0/Xr9igXYtRdwREGiBJ2fas7RLaorH2MF4y
         au3npKqc8iSpY9RObbHYwqJfo3PgL6Z61dM6VZBOFkwbeMqlnVLC7q/YYpEjhSYM1ko5
         nfMZumLFfLz2tiAA4H9fgt2oBiXe/vFR0VA835OymKGqCkWAq/0iqDer6XlgfGv2vExX
         O5FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795527338; x=1796132138;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SlQLX7u1Me0NFtwAym0d5omjRG8dj5NZbOQLq3ePYHI=;
        b=w1It0G1ZH1LLatHMYyPeoYbQz54MbXE35gNWyO7XqZTwZO9nALKns6LbW87w5xC5XL
         6K8iV7NOb1KaaQzcLcosGL+M9L+SRj94GfFpAzxNMqeD19ILa3rw2ui7tEzb2LYkLvWL
         YxOg0+1JJ5Y58xwxtfpmJZ74Ye93xllxmxgynrLFqS0a7JdBOJKzyElfZmQKYejnMlaF
         uKb1I148jAJf2fZzakrhVADs38D0yvBiTtHvFA+MRvrCDb3JDOaeRos5fG0P4x+WnklO
         la3xngvfLkeiBb+5MkkqEqwE3ybZc+vE8aut24s4+PRbexu/U3a8dC3QFM4K8p5z+Mom
         6muA==
X-Forwarded-Encrypted: i=1; AL+hErFPHq1iTpl5N37KQq+itiXPS+9TeS6absPcIgx6MnvELe79+DHugx88yX9kCxiWw4oYWo0sabuEucTJtubD@vger.kernel.org
X-Gm-Message-State: APuU4Z/HE5KX9Ts/+abClhbqS9w69RQ6DfkagjJbv0VW1FnMVmyO7HA2
	52jOKc/W/thY1N1R3uDMz1AiJdkue1cf4SaTZi62Q3E23+Bg6C9V1qt6yXRWytSLAFU=
X-Gm-Gg: AZFdTZcLVZsKQMC5qnEQMOW8CtKg1YuHjTzETIav9+AMpsZ1Cd/gfJuV/V5sIhOPyJ+
	o93rkifCWQWVCOAGULPmjIM1ipz3GR16iEbD0+mJZN8w0VRP4jA/5Y8wx9d0KXcuEh9E1ZuDePj
	UzmEsMAJAbMBm0NmOPFWAGYYFJ8H1MmpwMNFco08zTP+bGaTjgP1Fz9Opcnt6tMQZE6VPGWlWK7
	KoZwKNuo2BKRzv6kREfyYKKFvJSh9JGpQQRfGAFuHBQWE5zvJv0C/t4x+o8Wu+rLUU1T4MBhYPo
	rWrvRw68C3lcjNRLkZJzJr03iYgqndmfriLFof3wvd5BDq9U7h3Zkk8zyVwBu917ytJ4WaoLSVx
	8obmxgXIdJFL1JSrjOfKzWoiuorKiuZ7a8g9xt13BC+4r0YHitWrhWEAgLYMs8JOir9NJ6HkCb2
	kWxj6pICTYzmLwY/lMjtV11D+uRv29FdSaY7YdfeNY+oK7O5zoaqc/c+31w06mVb6VrlVjBeK2T
	KvCbT+P+9QLRNeTSuWATlSGeAPAmMn746DxXNPjIA9cEd8UAIZhDQgigKQd/QNALO7NT97n78U1
	9kqCFQESSs900sCpCtzY96B6A+CqviA=
X-Received: by 2002:a05:600c:a15:b0:4b6:267a:dd6e with SMTP id 5b1f17b1804b1-4bb88938a62mr302562135e9.28.1795527337675;
        Tue, 24 Nov 2026 05:35:37 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb9067846esm271922625e9.4.2026.11.24.05.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 05:35:37 -0800 (PST)
Date: Tue, 24 Nov 2026 14:35:35 +0100
From: Petr Mladek <pmladek@suse.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: jpoimboe@kernel.org, mbenes@suse.cz, joe.lawrence@redhat.com,
	song@kernel.org, live-patching@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] livepatch: clear internal flags at init
Message-ID: <awWSp422uOGwQ5Eo@pathway.suse.cz>
References: <20261123024000.15130-1-laoar.shao@gmail.com>
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
In-Reply-To: <20261123024000.15130-1-laoar.shao@gmail.com>

On Mon 2026-11-23 10:40:00, Yafang Shao wrote:
> func->nop and obj->dynamic are internal flags. However, a patch module can
> set them in its static initializer and nothing validates that. The release
> path uses them to decide whether kfree() has to be called, so with such a
> patch the kernel ends up calling kfree() on memory it does not own.
> 
> Explicitly clear these flags during init to avoid that.
> 
> Suggested-by: Miroslav Benes <mbenes@suse.cz>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

It looks a bit ad-hoc to initialize these two internal flags and
not the others, e.g. obj->patched. But maybe the other flags
just get assigned a value later.

I could live with this:

Reviewed-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Petr Mladek <pmladek@suse.com>

I am going to wait few more days for a possible feedback.
I will commit this patch by the end of this week unless
anyone complains.

Best Regards,
Petr
