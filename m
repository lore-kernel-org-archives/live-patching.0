Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356E23F9F41
	for <live-patching@vger.kernel.org>; Tue,  9 Jun 2026 11:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781003063; cv=none; b=ep3zX+0KrQL8PfR6X/wAu8bOHsupL014ABnEa9ZHMa2Ud4n53GZmUbD2d9KutI1Gx56ehYqoeCIjheoAaT2SORNTwCXpZDSual+1a7VAeJLGddB03WvWz+7DZokHkV/I34DfP7K1Qe+MOOX3wn1YJ0FOad7kGTu8DC655AKSwGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781003063; c=relaxed/simple;
	bh=m7GUmmN6TsaD2WekpATDGc8I7GOU+6aD4TPHY8OsMko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g2YSmUYgDt1zTad2H30gkjmcEVNOdAvmBOvntSGA2e576Uth6JkvV4NOKuJSbbio5HMu3SMsSgcG5x9mmPR5170nB7ZO6A5SA+nUgbejwdmbyHDR5EHJWnu2DJCmHj7qLwiaO1/0sdcLaP8+S3hQUwX5AsPhfsHpuwXRUMX7M1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=N11oh+hB; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="N11oh+hB"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-490ace40f4bso62491855e9.3
        for <live-patching@vger.kernel.org>; Tue, 09 Jun 2026 04:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781003060; x=1781607860; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qMZ+ugQTvKt1SoEeguI61AFpJPgRZUBObKRt06EYOjg=;
        b=N11oh+hBS5EsiVPwSqkrRDOFeko6YqsbNH5XFlOxPFLNHbgGVZ/lSdVzEp52EOftQR
         pMyFQznlPMRdYMo7o+VA18mlonJOwjlqjV7t+1QrHTIRfn6lIitnamEBZiHOJaV2uNts
         CJuXIfmXPwV7rZmFM69yztpk9dhMca6AlIEZs/sjOjLiO+Re9X9+fiMrLfYoAwpGMgW4
         WYuRxjMM0hcs37v8cPOo3ZLh1s9yBvMSRRDnnv7PyXR6NJCKhiDWNumEm9ZLGpy512G6
         kzBqEFkwnhUK9xy/BOx17kcP9QU17JDRDoHzj1Xgx2Kr1kfs50ACGUvP27lxB4tktBs5
         4rBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781003060; x=1781607860;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qMZ+ugQTvKt1SoEeguI61AFpJPgRZUBObKRt06EYOjg=;
        b=MZH5FbVJt4dH7zLLajUVCr2zupIV+AhNKRjLOHPxFE9sfr3pysX+Evp5y175VKPQLY
         uz7/Z7yYU/0zVBUhmVA48c/7aV48w820Lzap1Q85JlV81uqeA5ur7PwonB2D9ueI6+je
         5NeBh28aAD3AvjxRixST08ACdJ4ltPplVL9GRVCKnzuMf/hcwjEyBIWC9fp/dTGgWAux
         h6E9/Z/+m6SCXGkF46lh2EBu8AvHH2RSBxJ3woLiz+lFwUMKTjwEXCwfOk00N/JS1tkG
         hrasQCA1ZYPqd2PaPca74UNj5PB0BU0n/5Zfxz7t60DxgkulcNtE2+sqaBEmzVMnc3uW
         Tcwg==
X-Forwarded-Encrypted: i=1; AFNElJ/y7/ib75yPTaiLftvZXP9qCPLOcvbqG/WgrWJhKJwzCXA5Yq/y2GDaFgGzH/TwO2dQMwxFp+oXSVtUoHVV@vger.kernel.org
X-Gm-Message-State: AOJu0YytWp7V3HL4ZMiUIP3W8Fqwz3HZWkZM63hHdX/vRg8IqWIq2LCq
	6xcNaC4z5sAvWJXvpazJlsZkMNvdNtxOXnfkaAO0VOcuypUMNxLXt/KXsnNLimKq9OQ=
X-Gm-Gg: Acq92OEuDyl37QV0NCIQWDji7xVV0joz25yNv4tofwCuZwxDl0t36Q+8dRrqLcC4GvZ
	52FQTwEBKi0/fRO9EiuQ2emRPDkdEQbt2ua2NXgCYfD+w+KUDJbWVn01akRl/Na3zjxCp6DF6e5
	m6I48RfsS9PYLD+1vrqHqUumxC706wXp655j3Gq72VjxobeN7eN7rT+puaT4iofXr/dI7CTzqae
	Ig5AXoEW5Bg7Mhe5aVClhtbYCzqinp3J1zKClNLtRoSYjWvRMcUZPdDi/6FZQA5+/ya+DCjtZU3
	tagpdVgybPvJMk0ODWQqbGOpxFnHN938BuzyKb48ukAKWYPI7dM+PQmo8zfQ2JL4UxmN9h5IRs0
	pZEp2uvJ0MCWmFhbPkPS412AIH/gLL1uKkLdzs7JD4x7TtA+IO5n77PH5cFx2v8ulbMaIFul/K/
	ODWQamWedbv74l+aF1oaHda9uHziPnzSW+Qv0h
X-Received: by 2002:a05:600c:1d27:b0:490:add9:7f88 with SMTP id 5b1f17b1804b1-490c25dd709mr343342815e9.21.1781003060505;
        Tue, 09 Jun 2026 04:04:20 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3d66c8sm451185945e9.10.2026.06.09.04.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 04:04:20 -0700 (PDT)
Date: Tue, 9 Jun 2026 13:04:17 +0200
From: Petr Mladek <pmladek@suse.com>
To: Rui Qi <qirui.001@bytedance.com>
Cc: mbenes@suse.cz, jpoimboe@kernel.org, jikos@kernel.org,
	joe.lawrence@redhat.com, shuah@kernel.org,
	live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests/livepatch: fix resource leak in
 test_klp_syscall init error path
Message-ID: <aifzMRdL0zPttD0w@pathway.suse.cz>
References: <20260602124509.365996-1-qirui.001@bytedance.com>
 <20260604083208.1071428-1-qirui.001@bytedance.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604083208.1071428-1-qirui.001@bytedance.com>

On Thu 2026-06-04 16:32:08, Rui Qi wrote:
> In livepatch_init(), if klp_enable_patch() fails, the previously
> created kobject and sysfs file are never cleaned up, causing a
> resource leak. Capture the return value and add proper cleanup
> on the error path.
> 
> Signed-off-by: Rui Qi <qirui.001@bytedance.com>

JFYI, the patch has been committed into livepatching.git,
branch for-7.2-selftests.

Best Regards,
Petr
