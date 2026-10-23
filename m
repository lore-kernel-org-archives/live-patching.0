Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792765027;
	b=d45O/s9iA8Y0FYKSrrEYMkI9lRTjv1PsXI6haZ9iOpPAggJJliCTSGi5CPaYoF9SCEcb
	 rz6H+iFDHJtv/tNCl5gsUnm1tIoeT0zugOYJ1rSrMIhiDq3plQmX5uPtN2UfPdgh9BShe
	 LDAG5k2Nfe1dZJHrm1y06P1gLzO3QnbTXT0XUVO2YsZiv7vH9xTNAXTTNK+yC9byi7Hvg
	 RB4yMqdEoJfF4cKOviinDpG6Vt1m2ZraLYA9PKckgGmHNyHgeAlinHs6OLEyyvkFmau4g
	 ci0M22MZP2jHh9cJJHNyRz88oXHuHxswLee53Ucajvap8X9XypX8jBFYmRABUGLKyFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792765027;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=hspaebYZC3S45MqYVptIGDURC4EwLbHzPpd9+9VEq8s=;
	b=IijewZq87cvQ9ZjM1IxaEogJF8EecJwxri2C6CfktTIGBEz+SLiKgwu8vnTz5J8A04k4
	 fRBTVgIoKWTdG7jpuGVokmISyebVm+4NkasM9anGemIBwN6MEkVaVDpN3pa4aLhcpUmoi
	 mfjGt0WkcrlgUbFog3pUxWcyeVqqPK5sCLIvTAZjJb9gN/rvZxAO9Vs9+Qx94SvhMYLky
	 4sSazutTdb9OHWBjlU/nifH6L7S1E31dz3tKHuuXQOsGiOgRk6f4tlhpIqSA84kB4U7Vh
	 gsTs1wOfZTnz3UOdLKUKhsdGMzQajjRklNmGHfvZON+3h7SrtKBfVzZDfQSkOpHrA2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=O68aBwKw;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4264606A31B
	for <live-patching@vger.kernel.org>; Fri, 23 Oct 2026 14:17:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4264606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=O68aBwKw
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a2000d5fb1so5357255e9.1
        for <live-patching@vger.kernel.org>; Fri, 23 Oct 2026 07:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1792765025; x=1793369825; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hspaebYZC3S45MqYVptIGDURC4EwLbHzPpd9+9VEq8s=;
        b=O68aBwKwT4lmSyisPMObTM69j1fCC10H9lf1gp8FzavVlLDBGrwAtP2dm1dy738mSS
         /piszHGbCguwnsaFiKxLKphNNtLhcyh0o8nVHibATSN9Sm5l/PROsz5GF1r/PQv5FPqq
         0wXisOrad5tX/CxWCEBrFKvdWetL5Y3hOhFe3Q/Mc/zIF2Ff/xpMv6dXutB/2JkvK79a
         RPbpcI0fZ8yuB14pKOmDG5f2F3llA1rK5FfFC3/P5E4dPJiXoWRHoBy8Uph5rGHVYs86
         3xWy7JT5hS9HHBTSV6qiSOgDefye1N4awpId7VsNKvY/9pjG0Qkw1dBb0+95/DwFlwh3
         HNFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792765025; x=1793369825;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hspaebYZC3S45MqYVptIGDURC4EwLbHzPpd9+9VEq8s=;
        b=P2APquPjLaqxIO2Mppj0lPE8gTeChYj0igJ384IGy011dZ7qzDyKv9UKurdmpPVC0B
         zxCXcLlfODt/lnXR9Os6HqRXMiO3sCfkeVc1mOllk+UAjQqqVIOse4N41Bgj0zsZOKUY
         89uszuzIlY9v2ij2XBejDIoY6dvVz7rCicfyyiYMn5DbAP5L/zOhBfJPKCvXqqBkSPrP
         vYPP87PkJgJkR9l/jRH7j/qrpZpQCVAUEZt4wv30twVmd86XlX0Ocnfl27rSRKiO8RL3
         c0fsHdBSXQ5ru2+ie53ErEuXofnmiHM9le+JXVKKeAwBaqQqBW9ri3Qy9D6GDMssk1f/
         D1jQ==
X-Forwarded-Encrypted: i=1; AKwUvBw95rfNdfscx5F4zgnOPuhq15CPxU6BxdS3o7TfF8007hRQluII4UsHFgWav3rVAmFdAblys5o384KLWE34@vger.kernel.org
X-Gm-Message-State: AFq9FYJGby1jW/h+HwPu9D6Cl1hXSaju7XmC/IAAtxfI5ggelQ+d3UUC
	U3YX1Z02E7xHRSvevqilI5hQ50udlr3LfiV0P/oqP6kyAGf5iY//w29DF5XeOxozmIg=
X-Gm-Gg: AYBFou0JdsGLC1yjJPxOfHGb79SuDpmHD3/2ihivWk76YKPSAbU3KU1TCKSPL43GkbK
	GnIy7oW68j3Fy17vUpIRL/ld28YTtTd+XZA0QPxTZXx2YXUdlPCxefHu+w+t+otUE3UXR3fhYAf
	41FZu8pt7JHaSQdfuqk8gNwOE5FERjlFuOtgWx1YADj2x+erZvIHgbC9JIiWWl8KL84dPAlX85t
	xgQHXLTHwGGiYqj7KhrwryZYw0exWGr9qhhz9T+1b2SHTkow6AJxiJ0/R8OaVVRMjg4yaZelRQf
	HLfT3KnWWb8vGanSXzaqEB7/fpgeAYcsuvaZTlVboZI8RWtP7/bvJp8rSkxr7o3SlCRZzv4eoqT
	ADSrlwznGNjvTqycivSNRefYM+9S+0yknw1NfrwaOzh5eJdnbkpdGw7CmyAaZpEP7HAPV7D1hvA
	Tbn+l+92bW8PTesFOv1OIGazBom1P7ltCLkqbSo/VAMf90Do3nH8peQzuSXsfLWcAKVegzzdUeW
	KAFFcuPtyqqc8vzgizVqBnQUsllbr6tC+WjsZo8bvXfCgvZ1G0BxydOgA==
X-Received: by 2002:a05:600c:1d0a:b0:4a1:e00b:a0ea with SMTP id 5b1f17b1804b1-4a211c7fbcamr41795835e9.1.1792765024225;
        Fri, 23 Oct 2026 07:17:04 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a29cda986dsm7997135e9.7.2026.10.23.07.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 07:17:03 -0700 (PDT)
Date: Fri, 23 Oct 2026 16:17:01 +0200
From: Petr Mladek <pmladek@suse.com>
To: Harry Hsu <x90613@gmail.com>
Cc: mbenes@suse.cz, jikos@kernel.org, joe.lawrence@redhat.com,
	jpoimboe@kernel.org, linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org, sashiko-reviews@lists.linux.dev,
	shuah@kernel.org, song@kernel.org
Subject: Re: [PATCH v4 1/5] livepatch: Fail object initialization on
 duplicate patched function
Message-ID: <attsXfOPYrprACJw@pathway.suse.cz>
References: <alpine.LSU.2.21.2609181452160.21788@pobox.suse.cz>
 <20261001043228.74946-1-x90613@gmail.com>
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
In-Reply-To: <20261001043228.74946-1-x90613@gmail.com>

On Thu 2026-10-01 12:32:28, Harry Hsu wrote:
> On Fri, 18 Sep 2026, Miroslav Benes wrote:
> 
> > Could we also check prev_func/func->nop in the check in
> > klp_init_object_loaded() and have a pass if true?
> 
> Thanks for the suggestion.
> 
> Yes, I've updated the check to skip the pair when both klp_funcs are
> nops. Two nops added by klp_add_nops() for replaced aliases are
> interchangeable, so an atomic replace patch that inherits nops for
> __do_sys_fork and __x64_sys_fork from two previous patches now loads
> fine. A non-nop func colliding with a nop (or another non-nop func)
> is still rejected, since the nop would land on top of the real
> replacement on ops->func_stack and silently disable it.
> 
> The incremental change on top of v4 1/5 is:
> 
> --- a/kernel/livepatch/core.c
> +++ b/kernel/livepatch/core.c
> @@ -894,6 +894,8 @@ static int klp_init_object_loaded(struct klp_patch *patch,
>  			if (prev_func == func)
>  				break;
>  			if (prev_func->old_func == func->old_func) {
> +				if (prev_func->nop && func->nop)
> +					continue;
>  				pr_err("'%s' and '%s' resolve to the same address, aliased symbols are not supported\n",
>  				       prev_func->old_name, func->old_name);
>  				return -EINVAL;
> 
> If this direction looks good, I'll resend the series. Petr, should I
> just bundle everything into a v5, or do you have changes on your side
> that I should wait for?

I am afraid that this is still not enough.

Problem:

It would work when the livepatch gets applied the nops are removed.

But it might cause problems when the transition gets reverted
in the middle. All processes should go back to use the previous
implementations (original code or previous livepatch).
But the ftrace handler would just go back from one nop to the other.


Solutions:

1. A solution would be to create only one not in the first place.

2. It seems that we are close to the scoped atomic replace feature.
   It will prevent loading conflicting livepatches in parallel.
   Well, it currently checks only the function names. We should
   add another another check which would detect the conflict
   also by the alias.


Best Regards,
Petr

PS: I am sorry for the late reply. This patchset is far from trivial
    because it handles several levels of "what will happen if"
    and makes my head spin. And it has lower priority because
    it handles corner cases.

    Also I always forget all the details before I get an answer.
    It seems that we are all in the same trap. ;-)
