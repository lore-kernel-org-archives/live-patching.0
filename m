Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EEE423EB7
	for <live-patching@vger.kernel.org>; Thu,  3 Sep 2026 07:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788420625; cv=none; b=LTh01vrP7GA5zyNKI/1KBA6I978Pm1LXGBkjFxfH4IlJ1yrso3j5+CQ8nJ39/IipoKVx1WpEK7TTiN5evMzPEkHy4mIo5oer4ueDYHs+zgWYrW9uVV+RomcfAfeagzHYUdmFor86My2XIWBtxa95+GIoH8tNjGgLxZX4gud7D4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788420625; c=relaxed/simple;
	bh=2nrqvrQ/NYzEeIYa7fbWNoPrAdM3T5KYXbQtL3KEWkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h4jebnKHt6YB0EVzqbSyMYy4AzT/6ynIfFXfnrnRZPIELZimKQ1K1XZK2ulA+kHtx7A6zWeB7SR9JFVloSGD3fxKliyOAfK0jir3OVfZ32ovMPzjG8phOXyoqRLpADF+neZlgDb1AgD5V1RZ1UjV9t5oN2CowbAdrxrfibtan4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ckLYXxNH; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ckLYXxNH"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49b96837ca3so14148045e9.3
        for <live-patching@vger.kernel.org>; Thu, 03 Sep 2026 00:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1788420608; x=1789025408; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tw/7Pm6zA0Mzoef4R2syw+evCZTvzXDxRbaoH9jxbo0=;
        b=ckLYXxNHpwcThomu7jQKht0JLJT8GAaQMTmsgqjtS21X4CnPiLQ1KbeWJQpfiQpMiS
         XvqWoHkaNCOLp4riIEqW7MOVBMj52Wichj+keQpFbcndm44bz7GArZjCwaqCsCLH5ARL
         KQHgyPLiiNVkPGxz19KMt53LijYaqt2vJwm7PmkN+eS84Yy0lV5rbEUj8t9NZ4zFPo4W
         Mxu70mTR82NYvkyj/cRUSa5XUIDg38luCNyjeNNjHy/IgTMTEktIOkeZa/Qv49FcdEFx
         SSf6/nG0kiZdsUurtkgVnVl6CnKzAIaDEHrO4db5JGnPdZvHJApNSkiCaLYkQTKlOLP7
         E2ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788420608; x=1789025408;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tw/7Pm6zA0Mzoef4R2syw+evCZTvzXDxRbaoH9jxbo0=;
        b=GJZPliJUUQq/PrOY73lBwwJKqW25Y3UexvaUXr5OBf45LDi3g/9ZVvr2wQigJt4jYY
         Te9ZwxPoD/s1ONaWavUO0bJUjYDD6LnXTIr/aPhvFS9br28XKxijxvCECYm2TAz7SaSJ
         9xon9lPtHmWCFVPXVqxsNTgPnvg+qeKZPAr/FASrwv0A+ThXkVAojS2DPnBCLGgN7ca+
         2HbV/5J+bo7sfaffHarq1VnAp2B8euPS43epUFTtRThLziyGrltG8DsiJ08hK3Az60br
         chSMTdplurh/w5mwX5oEbMl89q0Aag/mkUcX+Nf6IO2/0f/aom602EP+ICMC42SNoqgw
         QdsQ==
X-Forwarded-Encrypted: i=1; AKwUvBxYU6BudadFe3TcmswqZzIfYGie8AfhxoAV4Y1LbCVZ5nuviPZBjigUJ0R+HBknChxhLhENb/4sF0BK8Uv5@vger.kernel.org
X-Gm-Message-State: AFuF++lTbelveAYyRl9L/zU8UKDx7Ahkgjo5x4rQ0CjXLLdMw637yiVJ
	AggRMFZnmjR15+6sXEM5GtfjjqWUba3CfSxyryPVnHx+j3tSeo6tYDL4jFFZH2DAWxw=
X-Gm-Gg: AYBFou1Fo3j7irPY+ifIAXZV++IqeWKO4bWYPb5jl2o8snzBoC9BMz/g+jpR2HmY/jG
	mLmJrd4m0hcOXed9RjDyo+ugbQTDQ+Y1VDgPPK1/aN3YP3ygKX9gOH3Ith/eIuyr4kKv4G8vo+j
	lQ0otUqtp/DA6B8vM81uzd+pmy+hzU2pTBckaEOhhIQUrl4YNX+ma9WxZYGVYrYsyJYutC3jEOh
	Y37n5uOKzBLAUCbwbIALqMFLn2fieLQVx+t+nDEZECFcUQTBPsX+nrB/zszhk33kbeuEfCa+e6Z
	da75VMO7m/E7Pv+ygMCXFtkF5KTp75ryNo1N0JlQgc+VDvs/nZ+Ifu6P+pKFN7sUVGhTuUCtJ9P
	GYe19gG1kvf07MO/Lq7gzNnKlbzLbG0JUm3zDR1jNheQfoKbnV5ePlRda+hNfUUqWWEVLhxGe4T
	95D3+tv11LnOS65B+FT93ZnEkHOOchXs0dMdE7Bn7zqh9B4I73yYyvU0isoQIYvCufy8bbrh+cq
	QBt2TAgcmIvS58=
X-Received: by 2002:a05:600c:154c:b0:49b:5521:785d with SMTP id 5b1f17b1804b1-49ce57f4d96mr176231405e9.4.1788420607726;
        Thu, 03 Sep 2026 00:30:07 -0700 (PDT)
Received: from pathway.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee5d476esm56807065e9.1.2026.09.03.00.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 00:30:07 -0700 (PDT)
Date: Thu, 3 Sep 2026 09:30:05 +0200
From: Petr Mladek <pmladek@suse.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz,
	joe.lawrence@redhat.com, song@kernel.org,
	live-patching@vger.kernel.org
Subject: Re: documentation: was: Re: [PATCH v7 for-next 3/8] livepatch:
 Implement replace set for scoped atomic replace
Message-ID: <apkh_fVZ75pm1Jzs@pathway.suse.cz>
References: <20260825114641.80452-1-laoar.shao@gmail.com>
 <20260825114641.80452-4-laoar.shao@gmail.com>
 <apfRgPN7FWsgYSOn@pathway.suse.cz>
 <CALOAHbCh1R0_zxZztvhYgUhtQswi7dzR-jw6AeA0MqF=BThdAQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbCh1R0_zxZztvhYgUhtQswi7dzR-jw6AeA0MqF=BThdAQ@mail.gmail.com>

On Wed 2026-09-02 17:50:28, Yafang Shao wrote:
> On Wed, Sep 2, 2026 at 3:34 PM Petr Mladek <pmladek@suse.com> wrote:
> > On Tue 2026-08-25 19:46:36, Yafang Shao wrote:
> > > - obsoletes: an optional array of unsigned int ids specifying
> > >   additional provides ids to be replaced. This allows a new patch
> > >   to explicitly obsolete patches from different replace sets.
> >
> > We should mention here the special meanting of the "0" id.
> > It enforces the most secure mode when only one livepatch
> > can be enabled at any time.
> >
> > Also it is important to explain here also the compatibility
> > rules. They are important part of the design.
> 
> Ah, if you prefer to make '0' a special case, I will implement it that way.
> This brings up the question you mentioned in another email: should we
> allow loading another ID when livepatch ID 0 is already enabled? It
> seems the answer is to reject the other ID.

We first need to decide about the compatibility rules. Let's continue
the discussion in the other thread "Replace rules...", see
https://lore.kernel.org/all/apfQ6c_3giN615Ll@pathway.suse.cz/

Best Regards,
Petr
