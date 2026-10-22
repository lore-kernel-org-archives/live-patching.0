Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792681849;
	b=qDIx5NP23D7ZXrN/MJMf9QEVVvQ5ynDtVBkJ74gn2bGRkqe6UOMlShXur107+g3sRSwX
	 4Do0M6qZb1hirZQt7GHRdtwHjDkjh+vHlu3PGLTfaB28tIxJok9jz+V8TQJjOUKZwqCnW
	 W48vIR1akOF5TIWyxhLw+MhOeM9HEz9cy0cyc1QmgVtvnX/xZVzXIVDXdgGY4yDZkjZZO
	 AgHv7jCOwPK+JS2hspQhizhUWzRfvD9xIDJs6aRdu5owrxUWvl6OL1YJLRG6adnOGKA4t
	 OBa/T8FP/+YgpNAfb2Aaa8xH0/FhMecaUZjyNwLn+3cX+Y6Vdouo+1Vzd6fi3iGwgFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792681849;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=dNOXAmIN/gsFanv3gxuRf/0Ngc/rNLx0yZwCqBumtYc=;
	b=iSzeU17XGjrrNziZlI3yoPwmA2GPHLRjtSoNzs3gysk/pa+mSIy43f/s4wTEaEYC8BT4
	 8zJaIzugZ9SdCCIb/P4Arg4SxS4UJmcfv2m/KFwy6rg5GE5HXmzjnYOffg9WtBbcoEE4S
	 187wczpcTDeusHP/WUcHwpsR8voPmrC/S6HacdYiV6bo/B/+E7FrTXrvBvhCFtGQy563A
	 pyS+G/P0WacCLFlGkQTuo6hL3ElAg7V4xi6lOgQ/0KwZlv5kMb+HH/7yChv/mdLcMPJS7
	 sUuNehuk5dbgw4rr1LXpOua60W5moq6rt6S/UtV4YHoSDRnjH+07/CkOB6cCLvp2I0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Fzpw2DGR;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6C660A5BE7
	for <live-patching@vger.kernel.org>; Thu, 22 Oct 2026 15:10:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC6C660A5BE7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Fzpw2DGR
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a208d93758so8405715e9.3
        for <live-patching@vger.kernel.org>; Thu, 22 Oct 2026 08:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1792681847; x=1793286647; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dNOXAmIN/gsFanv3gxuRf/0Ngc/rNLx0yZwCqBumtYc=;
        b=Fzpw2DGRN/pLyHFBqHLicN+SLG0+NFGPJyVcC12nK0H+CNPh76Y8Vdh7O66m7oD1o2
         eJRLG9OlpYJEqY4wxG0x3eDt7TNzSKSBUfD36Ooc0jdjca4TwQKBLpDEGSSFB3dOdJt4
         PLf5MgjNGxyqdmPjD/US07yrAenxCb631CkIdrWuUdoq/0DdcyVefAUJSBA5BH2UOpSC
         jg+P78sQdmGjJKNN68+S+Wj6w69UmytONTLyzUiRjjVgaYSS3D7Xr9G6T8j/6SgqbzZg
         a1xGT70l3nca4LJZdaUrZ+IpGub/w2Q4CcW4PGMGOiRyaNXkO0A4Yrb1iOvwLDj/h95+
         JoiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792681847; x=1793286647;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dNOXAmIN/gsFanv3gxuRf/0Ngc/rNLx0yZwCqBumtYc=;
        b=revGCnSOvYH0UT0uA6J9OXeOjsN4VKmcS2NrEGSwxPXJ0ViHxZHZ/eYJFCi2j2tZ01
         z+YzA641o36tPXE2/349TMSjvB0RpXnm32oUpb1GRfpc4WU+WqTZ7kAx6rhJ3GWjOhIM
         bW4KH6lR90QSsjgtt/7C5fc+s36HbrwW2TiAVAClUC8Oxe5qLuV+cHPQKZ2kn12UfaDR
         ljdIsG2CPjaGFwH0lx354FgdZGpK70yLlyqTGLVTYiAOE12yW1SzW/6ZNbwCF0ZhQ/Le
         7c18lrSdPVMPIJhEXjVr9aj5TrFxe8pIddqD4umhLa/6H7p0jgW+VRN+qGW1kqqBxwP/
         +cjQ==
X-Forwarded-Encrypted: i=1; AKwUvBxb0ne6fLlXu4yCVxbCzkCzxdEogqF1ZJBJj2EOOAk2m1d4QP9xJKGyFxzN+V4UvOluBmGcCCAbBnHC+yIj@vger.kernel.org
X-Gm-Message-State: AFq9FYJTYMLsZQ3KgNM7IuFUtDNmXgSH8fMEtcmplLxNufkuH3+crjq1
	i0VvoiHlD1s+KRIIdEOnTvsR65WgSUpDmeSILPfG+zBZgIc7fqq7M8lZZW6gzfS/0iE=
X-Gm-Gg: AYBFou2oGab3p+MZAWdwT1aYoTBasx9GrOC4Fg9Nxz9zuSHlVefz1JUrQTSsFAeAPF7
	KOI9M2c5ivK4stlMm8g3dcRT0AbFd05d/zV+THW08kQ47DmE9jTuf1RZ5bKxuOPhOyo9Dcjhy6v
	r8uEnfMiByW8IjmjaGtAXHXVer9veLAWPqO2UIxHZRWSyDKNzKLfanuu581FCUmf0KkTsFZZhv0
	qvAkSfrsJiz8ZTqlzr3DbYUXNgXUCse6uFBn9KH3PVtzTF2rgJqQmK6ALGZPre164LzjvtXyFZy
	8T2MP4fw3p2zvGxI5EGcrWF5TB6KyKyq3qwbHHDYcj0bP+bbblxedTCzb7KcSV5om4wOibLtwkQ
	MKyDnl/vdX5sXJPTYujYy8b6XBKfHuwzfZfDcP37wc0u2Vi5PCIBBcXpD3Xt6WamQwjJuD1Rqp4
	9pRS7H6IlyMXyadrpYqSi+L5U2pw9T0ZLQpkcHtFp+R/pkHcwfkvt/qwhbLTAqWFu/feYGVyHzu
	uBrsvuUMgJfgtei+Aw0Vyuy3+nHOkHi5k+B2WRxQGdarX1XvaoE6NLge4xoNrU9RmrEQAt7
X-Received: by 2002:a05:600c:c166:b0:4a2:1a:a116 with SMTP id 5b1f17b1804b1-4a2001aa2c5mr102960645e9.0.1792681847193;
        Thu, 22 Oct 2026 08:10:47 -0700 (PDT)
Received: from pathway.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a210327422sm2196525e9.14.2026.10.22.08.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 08:10:46 -0700 (PDT)
Date: Thu, 22 Oct 2026 17:10:44 +0200
From: Petr Mladek <pmladek@suse.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz,
	joe.lawrence@redhat.com, song@kernel.org,
	live-patching@vger.kernel.org, Wardenjohn <zhangwarden@gmail.com>
Subject: Re: [PATCH v12 6/9] livepatch: Deprecate stack_order
Message-ID: <atondAEaFnYLNw6O@pathway.suse.cz>
References: <20261016053708.47089-1-laoar.shao@gmail.com>
 <20261016053708.47089-7-laoar.shao@gmail.com>
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
In-Reply-To: <20261016053708.47089-7-laoar.shao@gmail.com>

On Fri 2026-10-16 13:37:05, Yafang Shao wrote:
> The stack_order sysfs attribute was added to determine which active
> livepatch is used for a given function. It is no longer needed because
> recent changes refuse loading another livepatch which would modify
> an already livepatched function unless the new livepatch would replace
> the conflicting one.
> 
> [Commit message authored by Petr.]
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Acked-by: Song Liu <song@kernel.org>
> Acked-by: Miroslav Benes <mbenes@suse.cz>

Looks good and passes selftests:

Reviewed-by: Petr Mladek <pmladek@suse.com>
Tested-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
