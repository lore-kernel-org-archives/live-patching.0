Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792596371;
	b=Wf5iBV8YvmLDT+ykhPd1ISRAgX5BQCTO+es7nafRIqUijSNPr3YhZqOQoO8eC/R/5JnY
	 cRkxWfCqYjpW99P6qS2FWQ0uKS/IbXRroaLp3/b+WuzzpOcQ2R6LQRPlipkqlRSueOs2L
	 B/X/KUFxhcuzTk0B6NmxKfcMsOHgUr4DUEQlUqJ154/ctJ5HCeaWSyXwHp6kRJX9uTK1+
	 swMRGy4JXGa0CGW+9X1gQ7cBRaD9ZRXgqEYgP1hpwo0agTe7Lf23uQGG9ZmFr2tfaXQhq
	 wb7mGt5etV4knR8ymtrUNx5vM/uOrj4Otf5edJkDG3+lnVk3IBSIaaXMQ711Hj6RFww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792596371;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=JfPXUB3LKLJOjMsbiq3dL1ZFGNVz42Nzr+GWDHur7d4=;
	b=poP9KQuI2SboR5QXIJ/VFmzDbVG8Q178zdBR38DBJTSUVuHSU6wrMP1yAKccEvQ5zquT
	 gkk4mSnOcgoo+ccdF1nVYh0uAsrv31n8dohlvIeONN200XzirAHnjU2ofnptWbeI9CUc5
	 W+mtn47ZuuAXzWKd83XaDif6m5g73wY0EE1wseydAGePr9CReOchuWOE5goqm2ltp52h+
	 65XVcjttbAJ7+tUwe5EUwTXtJW+VZvzT5ZRAqJHYrRp+53uZSHjMwZ84/VlnheJl00voB
	 G5HK8eqcdXSSf17tOuXechIh+5tJwkl+b7chnoQIrgjpFQ6cXkvmcWv+Y6TN6ILCq2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b="Cnb/Ywfc";
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859C7606A31B
	for <live-patching@vger.kernel.org>; Wed, 21 Oct 2026 15:26:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 859C7606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Cnb/Ywfc
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48e20ed3b9dso886888f8f.2
        for <live-patching@vger.kernel.org>; Wed, 21 Oct 2026 08:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1792596369; x=1793201169; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JfPXUB3LKLJOjMsbiq3dL1ZFGNVz42Nzr+GWDHur7d4=;
        b=Cnb/Ywfcwvx37uRTowOOV/ZHXEEHQwwBWYrQExzhATj8eaPIREgZt/2YakyCWOK/DC
         T2kCurJwCrAvBGngVcSuB4i5XKQ+ND+8B0JtrfJJ51uyoQ1XeVeuFvpqbjGKdfyB/tw7
         BzIYBqv7jG3GQT0D11SrICuU7nDUAD2ajkmoRg7m0+s8a8660ub70Miow56PYJhoDQhf
         4Tt8/eWqXsb+xuLsKlKs7XPAwzTnjo15jOiQ2ZJndwbj9hr3L2xLLvFwVla8C0HlgYob
         sbmnWnFfHXh0mV9DIEChZBTXjOuf/boE6oY81yuX7SpBiJXOPg3AojbqcmDNekn5u/LJ
         Cwpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792596369; x=1793201169;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JfPXUB3LKLJOjMsbiq3dL1ZFGNVz42Nzr+GWDHur7d4=;
        b=tVimb4sE9IqoMwBHXL92hlMDNkqRAs8359lqpww6R8iit3pT8H4GamgBNuBXlW05wi
         qaFwe/YqaPfU9Vp1PjNykvYyAoBgYyToCRGhY5d8zoSZ/NbxHQKJS6clIwa3xMaCeD+w
         oYo7mUZ7OxJ+jHc037+7XA3ZPukC95nDkMB+dkGBbk7DCPwoEAaYxBLyTQFE45fR3gOf
         eEHgEu9ukUC3LMfEyUruqXecOZzqdwXS+cAb8GXb67SjaMrwUkEDdKMcKoJC+HMGrDHx
         rKfWQeseBxBny/AtC9tdlXfxgrjKIyrwb7N0vtw5LTbFm9Y0p9iGrLXmW9HbUi+wW/Y9
         zkEA==
X-Forwarded-Encrypted: i=1; AKwUvBxtbqK2mAa5CBIrAhr63d4PcjkgGBWYCA79hvBEFTyL3w5NOW3O9HreQ62yOAiZDva0/6jdT3HpCcwK5xTk@vger.kernel.org
X-Gm-Message-State: AFq9FYI9YiIRy1gGf3hmsNbCeopvGCNA4xPSOUoF2DPbj7iDdgYQlUpD
	LOqsfectrBFs0Ylk+aTGkLahFsoF6HBc2Z/noRyrcqxR5E+CsCjIBo7XABo/mnfrzgk=
X-Gm-Gg: AYBFou1INPS4PGBo0x/A5Jz3f2/P3S9APmDUUTQpKUMD+4hbY+LIErio2Ay65zvZPDJ
	WlBxf4dYYY5R1aUG3E7NzkBMJuh5WOKN8xtLinAeFRE5hBan87H1L+2CSR3lHyjTqm0OEG4I+Lq
	7CummkpCg0SFNj0o9algIR1p+oEtJHbjDlY98X4o3yl5PRu/IOyL4QfnHGdzNRFPHTlbA1dZ3ZH
	3V7FSSm2UPHJviR9YfcpMWa7yI/Cd+A7RnhdfG00RZGGrDUzR02MD6A3DaIPlO4nDlhnMUdlC6V
	+cchhCmEfmi1QsplmNZBqB1XF8LAeYyiOEv+6adF7tJnXi/eu+XSB6TKW6qYCitx1uyhG+jQasC
	eWEwQHXuNGPYqvHsYeBWLiDtEd0Z1mvGREB3oHJKmdM8RGDttXYM/OLoeTc2ETUyfWNFZbvpvYW
	oToTyzsGgEJkIQfvKGTwrzok6MKF7q+enIoUr4tuswWnaJzymO70n87ZqIG4/GgHmBvSZN6x9TY
	miWUOwmN0Y+o4F8JeSaJn/km62CP1gHjVE2oGUA1q4oXHgKC+oYUT9IiKKqNudEpb7qf+VR
X-Received: by 2002:adf:e014:0:20b0:48d:fd53:828d with SMTP id ffacd0b85a97d-48e264c132bmr3727685f8f.30.1792596368784;
        Wed, 21 Oct 2026 08:26:08 -0700 (PDT)
Received: from pathway.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e25840115sm5940280f8f.48.2026.10.21.08.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 08:26:07 -0700 (PDT)
Date: Wed, 21 Oct 2026 17:26:05 +0200
From: Petr Mladek <pmladek@suse.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz,
	joe.lawrence@redhat.com, song@kernel.org,
	live-patching@vger.kernel.org
Subject: Re: [PATCH v12 5/9] livepatch: Implement provides and obsoletes for
 scoped atomic replace
Message-ID: <atjZjZrMKv5koK53@pathway.suse.cz>
References: <20261016053708.47089-1-laoar.shao@gmail.com>
 <20261016053708.47089-6-laoar.shao@gmail.com>
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
In-Reply-To: <20261016053708.47089-6-laoar.shao@gmail.com>

On Fri 2026-10-16 13:37:04, Yafang Shao wrote:
> The current bool replace flag is too coarse: it is either all or
> nothing. A livepatch with .replace=true replaces ALL existing
> livepatches, which is safe but inflexible. There is no way to have
> multiple independent livepatch sets coexist on the same system.
> 
> Replace it with a more flexible model using two new fields in
> struct klp_patch:
> 
> - provides: an unsigned int id identifying the changes made by
>   the related livepatch. Where the changes are a set
>   of modified objects, functions, and used callbacks,
>   shadow variable ids, and state ids.
> 
> - obsoletes: an optional array of unsigned int ids specifying
>   additional provides ids to be replaced. This allows a new patch
>   to explicitly obsolete patches from different scopes.
> 
> A new livepatch atomically replaces any existing livepatch that
> meets either of the following conditions:
> 
> 1. It has the same provides id as the new patch,
> 2. Its provides id is listed in the new patch's obsoletes list.
> 
> A new livepatch that does not replace an existing one can coexist
> with it. In this case, the two livepatches must not modify the same
> function, or use the state with the same id. Any attempt to load an
> incompatible livepatch will be rejected by the kernel.
> 
> klp-build gains -p/--provides and -r/--obsoletes options.  The two
> parameters are not validated in klp-build, since the compiler and the
> kernel handle invalid values.
> 
> Enable the CONFIG_KLP_HAS_PROVIDES compile-time marker now that the
> provides/obsoletes interface is implemented.
> 
> --- a/Documentation/ABI/testing/sysfs-kernel-livepatch
> +++ b/Documentation/ABI/testing/sysfs-kernel-livepatch
> @@ -47,13 +47,25 @@ Description:
>  		disabled when the feature is used. See
>  		Documentation/livepatch/livepatch.rst for more information.
>  
> -What:		/sys/kernel/livepatch/<patch>/replace
> -Date:		Jun 2024
> -KernelVersion:	6.11.0
> +What:		/sys/kernel/livepatch/<patch>/provides
> +Date:		Jun 2026
> +KernelVersion:	7.4.0
>  Contact:	live-patching@vger.kernel.org
>  Description:
> -		An attribute which indicates whether the patch supports
> -		atomic-replace.
> +		An attribute to show the provides id of this livepatch.
> +		Livepatches with the same provides id replace each other.
> +
> +What:		/sys/kernel/livepatch/<patch>/obsoletes
> +Date:		Jun 2026
> +KernelVersion:	7.4.0
> +Contact:	live-patching@vger.kernel.org
> +Description:
> +		An attribute to show the obsoletes ids of this livepatch.
> +		The obsoletes ids are a comma-separated list of provides
> +		ids that this patch obsoletes. When this livepatch is
> +		loaded, any existing livepatch whose provides id matches
> +		either this patch's provides id or any id in the obsoletes
> +		list will be atomically replaced.

This still describes the behavior in v10 where the obsoletes were
handled symetrically. It should remove patches only with the matching
provides.

>  
>  What:		/sys/kernel/livepatch/<patch>/stack_order
>  Date:		Jan 2025
> diff --git a/Documentation/livepatch/cumulative-patches.rst b/Documentation/livepatch/cumulative-patches.rst
> index 1931f318976a..5ce04424e09d 100644
> --- a/Documentation/livepatch/cumulative-patches.rst
> +++ b/Documentation/livepatch/cumulative-patches.rst
> @@ -2,33 +2,71 @@
>  Atomic Replace & Cumulative Patches
>  ===================================
>  
> -There might be dependencies between livepatches. If multiple patches need
> -to do different changes to the same function(s) then we need to define
> -an order in which the patches will be installed. And function implementations
> -from any newer livepatch must be done on top of the older ones.
> -
> -This might become a maintenance nightmare. Especially when more patches
> -modified the same function in different ways.
> -
> -An elegant solution comes with the feature called "Atomic Replace". It allows
> -creation of so called "Cumulative Patches". They include all wanted changes
> -from all older livepatches and completely replace them in one transition.
> -
> -Usage
> ------
> -
> -The atomic replace can be enabled by setting "replace" flag in struct klp_patch,
> -for example::
> -
> -	static struct klp_patch patch = {
> -		.mod = THIS_MODULE,
> -		.objs = objs,
> -		.replace = true,
> -	};
> -
> -All processes are then migrated to use the code only from the new patch.
> -Once the transition is finished, all older patches are automatically
> -disabled.
> +Livepatches are used to fix kernel bugs. New fixes need to be added over time.
> +The fixes might be independent, but they might also depend on each other. This
> +brings a challenge of how to keep the livepatched system safe and consistent.
> +
> +Part of the solution is the "Atomic Replace" feature, which allows the kernel to
> +atomically replace an existing livepatch with another one. These newer
> +livepatches are designed as "Cumulative Patches". They include all wanted
> +changes from all older livepatches and completely replace them in one
> +transition.
> +
> +The second part of the solution are ``provides`` and ``obsoletes`` fields in
> +``struct klp_patch``, which allow the installation of multiple livepatches in
> +parallel. A livepatch will atomically replace any already installed livepatch
> +whose ``provides`` id matches either the new patch's ``provides`` id or any id
> +in the new patch's ``obsoletes`` list.

Same here.

> This might be used to fix independent
> +problems separately, for example, the livepatches might be prepared by separate
> +teams focusing on particular functionality or a subsystem.

Otherwise, I like the patch. The code and documentation is nice a clean.

Note: We repeate some things several times in the documentation. It makes
      it harder to keep it consistent. But it is an existing problem.
      I think that we could do better but it is beyond the scope of
      this patchset.


With fixing the two outdated pieces of documentation:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

PS: I have to leave now. I hope that I'll be able to finish the review
    by the end of the week. I think that we are getting close to
    get it into linux-next. Well, I would like to put it there
    on top of the merge commit for-7.4. I still have to send
    the pull request...
