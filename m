Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E3E363C53
	for <live-patching@vger.kernel.org>; Thu,  2 Jul 2026 08:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782982432; cv=none; b=dkM9XKH6tmnOgH8ZAVRBb2w1NM+P/wtJVk3CTcJaNPFiiWb1LHEDCoytXGbnGL1+EpfR7DEUYwyI0DNhX8GzohD7mlbEnr8eHY853SCwfn3PaGA1t4MKaWVEwWJ9NlhkAY05a7k+H58/CBZgBE7ZSW+P9AUdy/7QsznLkbXgd6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782982432; c=relaxed/simple;
	bh=rov0SKtp0WCrSeUtguI5KKAUut3DCO+J4TuhaZONMYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gYB++u4dD/YRwyU2l89+CZ9vDL7htfmZWbqg86h2eD8VPFNB5g0dVHZ7HFPXz2BYBpC6tjB7hhsFAeMgE944V8sPd1f0jyj6t/TBrqigEzbBjXM/AtMuCNTOwhzvZXGh3daFm2eh/1vqqxPLT8vdOx1UYVUhIzfYQLrE7V9nFdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gppB/Qzm; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gppB/Qzm"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-493b7612475so12271595e9.3
        for <live-patching@vger.kernel.org>; Thu, 02 Jul 2026 01:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1782982429; x=1783587229; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IHxRFl9zIjTGoNOfS7dr/1CZ2RxtO6RDzq3aysrtq3Y=;
        b=gppB/Qzmvyh1Nk7lomYLKEOuEiYURBgPcFpcWMmKLBjiJJRQhYjp9JcANCHaL9SvST
         /j0zhTM6vaNIiUhWp21k6FPE5DMEUroPT76pBWXxflV8Eld364G4RYnRvbQeNUc5TZat
         iYUGgrPHuzLDTyQgPTMTOFt/T1yJ47baEfYcjLQ9uNXKBtJfMlqcoKSCNvmD0nRc7eon
         +5SZZzI9QugAYAPl+YIDCiAmIBk0tHmNpVhZeLOBNqWieWk9j2T1n6MHg+LobrEzacmF
         4Te548C7p0coBytfn6V7rwq37AEbflG1HcZoX1NkJkR6LPqDpyd76y/bpHLBPWXRu/dQ
         n1UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782982429; x=1783587229;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IHxRFl9zIjTGoNOfS7dr/1CZ2RxtO6RDzq3aysrtq3Y=;
        b=QTPNN1Mn2++zOisB9YlDGrLImX/ysgl6s5lkV1kyTsUiMjXjQfzDs625n6LYooNiCD
         XO1Uel9QVkcCVlua7FPqCbqK36GKce3FFquBcFtfHkR9FxxlYN+hwffiP7gwPRWbWXR4
         yGP3wnQjwliI9y0Uj/uU0gNwI1ulb+KyGtegSlqUEHL5yEfAxXbjY0apAItdMozWxde+
         w5leIpDgBMV5WIiH/8bff5poEXzEV6VNwACIA+zOPMvSyCTiHZmJqG39mMiu/yQ1Cqzq
         fcpVka3pN4ULWAoPd5r+1l+21vdRAbEX01ql0ZdEP1bzd9I3xvm53Vv4Tr4TcKvSXwOI
         nOyA==
X-Forwarded-Encrypted: i=1; AFNElJ9QUcc8EUkf56l7802rK0BIjIxU4AmcogdYWej5KdDUx8t1oCWug0e0Mo6nFw5iMK7QEbxHgZDeGb3snqw6@vger.kernel.org
X-Gm-Message-State: AOJu0YxA4PmMVnomRv0jssDhuywl1nGq2BQR+/CRznSmbcRfi0IbOcCg
	Yjor/jQzsdUdoSz5i2b2VRW6AU/MiXRBOVS9G6mudbYr0JVziKUGXK3VFoED7Z67BIw=
X-Gm-Gg: AfdE7ckD8CMwjrkGtg2ODDXE+LcLPZNWRrGfke0tZleJMrXylJUWpkpQZ/QwWqBnWD2
	hQ7XA4W/6Y6yuKu9s8h9tRPFcHmRw52ZTFE9kpAgTIJyXO/3pCGVGO/epRj+iDlO7vwLM+nOOHw
	7WzBt5o5PkK66YfE1S4am15dIdL44NAeX/HkFalEe1zzyYQ3xW3FjBgxEWDGMclr4OFbZJTUAuq
	PGHVwwWbmex0BL/CUUKtMHAfeNV9mFUHHPtgEtdxQUk8AvSEywoOXF2ySgzmeKnbMrJVzBIR5JB
	/y4uFj4Mp99cmQ/F15q7MI//xPBBVB8/lurnHHz3cY7qEhPvWl/vaE602wSPUJej/gUSYYcC+D+
	yvvERVA63i2Pr4baEbxEj0i4ssEXSm4KxIH8gsTvydLhNTiMyVzgpkmBjfigTVZTmC7ILky5sL4
	h5ZZ4UMKi8ORb33xE=
X-Received: by 2002:a05:600c:c3cc:20b0:493:bd03:c0d9 with SMTP id 5b1f17b1804b1-493c2b38ea9mr55340275e9.7.1782982428873;
        Thu, 02 Jul 2026 01:53:48 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c636ec8asm26652265e9.1.2026.07.02.01.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 01:53:48 -0700 (PDT)
Date: Thu, 2 Jul 2026 10:53:46 +0200
From: Petr Mladek <pmladek@suse.com>
To: Shihao Ren <rsh15355756202@163.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz,
	joe.lawrence@redhat.com, live-patching@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] livepatch/klp-build: Fix wrong index in error cleanup
 loop
Message-ID: <akYnGv_tDPouw8nM@pathway.suse.cz>
References: <20260701060655.2343093-1-rsh15355756202@163.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701060655.2343093-1-rsh15355756202@163.com>

On Wed 2026-07-01 14:06:55, Shihao Ren wrote:
> In the funcs allocation failure path, the cleanup loop iterates with
> 'j' but frees objs[i].funcs, which uses the outer loop index 'i'
> instead of the loop variable 'j'. As a result the just-failed (NULL)
> entry is freed repeatedly, while the funcs buffers already allocated
> for objs[0..i-1] are leaked.
> 
> Use objs[j].funcs so the previously allocated entries are correctly
> released.
> 
> Fixes: 59adee07b568 ("livepatch/klp-build: Add stub init code for livepatch modules")
> Signed-off-by: Shihao Ren <rsh15355756202@163.com>

Great catch!

Reviewed-by: Petr Mladek <pmladek@suse.com>

I assume that Josh would take this together with other klp-build
related changes.

Best Regards,
Petr
