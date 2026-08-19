Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4803CB2FD
	for <live-patching@vger.kernel.org>; Wed, 19 Aug 2026 10:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787135077; cv=none; b=skN6TOBs63xFGQCgrqwTsuBgDvPJy3AYpVTlDixLMdwyUTVWUtvNUrsL1+hoOIyzF4MmIYrSMnT+Ze4NW7vSDpfGnpHeXw+xTEWUW7aVD0ByVxfKi/AYQ4t8uXcNuixudasM+a6yqq6zMAjxney5vIdwk9CTgl2we49o15oKADY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787135077; c=relaxed/simple;
	bh=TukymSJmxdS1Cp6mHU/RPK2LUTXOMoZuZnfEPfSZvkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NQIU1n77fZZnVQMA0nHssXXjPFa5kZsumfarXtabfQ5QLEt1UWGk7h+dLKejoG1Ew1JZtUGBQWMxJpaDjfSXilGu0Z9eLtTcco0643/+QpGa9s2FQDpqSCUmzsShethc+cNk+NHCg78HLI0bbjWZg+SByBPx4JlS+8tqgdzL8XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DMhd/ulL; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DMhd/ulL"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-480033bdcf4so446621f8f.2
        for <live-patching@vger.kernel.org>; Wed, 19 Aug 2026 03:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1787135074; x=1787739874; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=njUfhzol9oLitp3QSbzFaJrirZK9my2nXyDl+6ljt04=;
        b=DMhd/ulLHZghKF16WRBRifaRW5bFC+ZEOgWRVhCwxDvRnE+42e/dLJrJJqH3ivtEkp
         z9qaqXTufbX9tJtqFBsrgSewyi5jNTuxautZ/45XbrA2I47vM5MW4inOJxF0CfUbvYxz
         PGX48fLP3LHgxcPSVXVO6ZXjM3AEgqKnm22UL8QdRiwI0tCh+P3b94/eK22RoZzN1pbm
         ijA+G2txhUq23KwCPkpoVM/xzsddUmAPuwQJrgJxYbyVqMlCwumLBpjjD9BEyk0mSW1l
         VxWNjZycbQOZKWVbkAuVSNqAQQVrZBs8f9yDfbKIbQ6GGFtofnLgr9tZmIVp9SkOAPrl
         PuNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787135074; x=1787739874;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=njUfhzol9oLitp3QSbzFaJrirZK9my2nXyDl+6ljt04=;
        b=QQ1FklPs34nHvxTSA8NQgvRHVfnqGgUTKNPhq1DwQF1MnJ5XQeVitYKfQE9HWRRfmt
         Z/Q2OI2MK6pBvJ52UFnt9IL5m2LvxeReXDzMZxIiYwuitNr6PTK1osZLsai55/fREYpv
         rQfvVD7ga0LtqPITzpKy2bkUL7B39mrn3cnbIGZ6MfGHEUnh6UtyQYisLVBCHK+OBQv+
         akDthoFvdluobglwm6V26bGDlGdtQfIKZ674Up3NAIKnVqJmujR9HhrGsl9hCZ7bAngC
         K9C8NhU+Ldxlxvn7LsxP+rii1Rab2YUwV0zlI5buDv0qfMobZFCFuJnYpLbx79WEBXc7
         xH5g==
X-Forwarded-Encrypted: i=1; AHgh+RohGFDx834qJkDrHhIE9IUe0xFX/GoFe6x6yAmBamFm/k+LJAamQGjn32jj6H7K2r7Zk+MdBnnCT0ou8LD2@vger.kernel.org
X-Gm-Message-State: AFuF++kblN8kp/I5yxpwYvCVfURDklQawIRDY4PBE/4kUTQPEV8tw68+
	fS+gsK1KXXP6gxbnkYGlImo9NPYaj7BK/xQ8AKk5oQdrAXUWDNNZUW1dXGMNT6InX/Q=
X-Gm-Gg: AR+sD13MPazjzStbOtEcdaCr3c+WNp/5DKKVI6KV5e9b2o3ApoFsQ8FijrTIGJ51LZ8
	/9cKsJcL+vknG7XmW5PJH+9euI02oMZ8vsSAkjiQ5AV12socPTDgFOFbFeQ1DhwIXSbdgxZX0si
	hDG8CLmPwhYuxlKOEFXGPUZXOi1vUEkvTQVBLh2bEpSu4k6u8B8wkBYM7rFNvdKtU0wQARQTE1s
	ndcJiLFbF64VeaZkhDPGq/fS8X5DWybkL0UHSGWofDjxBPNwqO3wH1/N6d3jm+BCmurlYG3tyKk
	IWosGxxe1aMkJu954w+n758ecsOheDnBvwfzC1fxdWFTaxHiM+cj+//dnf581j0nTsycSHkAqYj
	n0GtC+nIz5KmlntD02SbvovQduMhN3OHxkmdg9+5FlaUrE4CGmJ4gUpNcZPR1tCE9d1dqBXxoDK
	pNWlnEOrfP9Vk8ZO7Qnoqg4ue2LG+E2yXPSb/BrjBtBqCEymELZcQAMqYBUnpUAg==
X-Received: by 2002:a05:6000:98d:b0:47f:95e8:2ebf with SMTP id ffacd0b85a97d-482b1fd7137mr6190609f8f.12.1787135073886;
        Wed, 19 Aug 2026 03:24:33 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b14d9783sm4646255f8f.37.2026.08.19.03.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 03:24:33 -0700 (PDT)
Date: Wed, 19 Aug 2026 12:24:31 +0200
From: Petr Mladek <pmladek@suse.com>
To: jpoimboe@kernel.org
Cc: jikos@kernel.org, mbenes@suse.cz, joe.lawrence@redhat.com,
	song@kernel.org, live-patching@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH v2 0/2] ivepatch: Fix several bugs found during replace
 set implementation
Message-ID: <aoWEX89bxOpo4873@pathway.suse.cz>
References: <20260816090442.18128-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260816090442.18128-1-laoar.shao@gmail.com>

On Sun 2026-08-16 17:04:40, Yafang Shao wrote:
> These fixes were found while implementing the replace set series [0].
> They are independent of that series and can be applied separately.
> 
> Link: https://lore.kernel.org/live-patching/20260809091954.22930-1-laoar.shao@gmail.com [0]
> 
> Changes:
> v1->v2:
> - minor improvements and acked-by (Song)
> - fix issues reported by sashiko
> 
> v1: https://lore.kernel.org/live-patching/20260813030408.9761-1-laoar.shao@gmail.com/
> 
> Yafang Shao (2):
>   livepatch: Fix wrong index in funcs cleanup error path

This patch is against scripts/livepatch/init.c which is part of
klp-build framework. The klp-build-related changes usually
go via the "tip" tree by Josh.

>   livepatch: Fix UAF of unregistered patch kobjects

This patch is against the kernel/livepatch/* code. These changes
usually go via the "livepatching" tree by me.

Honestly, I am not sure how to handle this situation.
Josh?

Anyway, the 1st patch seems to be ready to go.
The 2nd patch might need some more love. I am going to comment on it...

Best Regards,
Petr
