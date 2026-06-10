Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234DA3DDDBD
	for <live-patching@vger.kernel.org>; Wed, 10 Jun 2026 15:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781104287; cv=none; b=PV4PJ1GTjx7Wf/9B/Gk8RKrI+jgh7O3Buh7elh5SbSAcQNXvxGn6q/Rs8cn78k6y/8PP3qmwS6a+Zjnb5snVVJI0PWlCa0Vy4rX1YB4gJrprTjFTEs1hbsXVkOEHrvBFeXJ4dD23WSTksWt68Y8O5Sl2vUPp7CXwBaDwgREmrc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781104287; c=relaxed/simple;
	bh=XtOuG3Pa0/9FGDwOiEwFLcGWjJku5xg5mLLqn9k4Rx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RRW5fbo2IRtFqNg6WwuptulwOnnvme5uCr/h0tKVud6Ph4SxYw4lp7V23w9xalQNXp0EnAufcthDuVNbvHxt13zoHugynKBcJDRaBi2USy+TOhhGjjgm9zHYWZiMGiyH37Aapse7OYhYWohG5IqgFUMMde5avS2/lHDu5u3wtj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=M0sW5Hm/; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="M0sW5Hm/"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-490b2b037d2so60566375e9.3
        for <live-patching@vger.kernel.org>; Wed, 10 Jun 2026 08:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781104283; x=1781709083; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AiqXdnp2dHGKk1jGCgGLz1NGSJJAmrvEAWUBysB25OE=;
        b=M0sW5Hm/DyYtiBr+JGIW7MTqCFyrSBO9XQhaCVL2829eybpiEpDuieP/Ydy+EgMJtQ
         57QzruuanyX2b2NDTRb+BoYC1V4NLf2GwpLp81biofCojrVKubHIfWOexiHkhmUDtxAK
         nXAbw7NNEqsSsu4a+kGvvKqFirCv3M32ko3WQlze1LnGWlYNx4HZ8Skz8aBhnitELlo5
         2lo+E6SvLtX5oXKVmdPioNIrn7Njzi99ZwdWMf0yVWfbv4bpdFJ2+0L4HtDe39Ie4OVT
         +xfhKEd7/miAZaL1n+bfNh8MiIobHpiXZF65/+eu1bWEwF0a0TBlQAbTI4VKO6ZSAt3w
         utkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781104283; x=1781709083;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AiqXdnp2dHGKk1jGCgGLz1NGSJJAmrvEAWUBysB25OE=;
        b=A2BO2PjS69huWwfCqbyb+Fi0nl5cnRGTX/MGGaynjW46ssql10AP+d88Qz4oqoUNyD
         dvpnUpADSwKIodtRIyNhI+vJPGdWDahRwvg7C6C90PBsOHlxti3iYT47g2cuC8+p3/sP
         ehetEVioJIB6Mexxy7RqnGseX4GlpPnE3oq8MZ9xjzoBdpXYndcoAleaZc7TRceiRPq3
         AuYknQc309C9zQs0vGmt5SP0xIA9FRNiZqpEaLS4IJ/LXv5qc9RlL/9Qi3aMf1RC/pMl
         2BeNbB6uiKnRhe4vYXkM1D5OQES2xsOFaMi8ygPxEUZWmdK4WmgqK7GuSOs+5OwYPiR2
         jyXQ==
X-Forwarded-Encrypted: i=1; AFNElJ9nOXZTm/mwPEHjQYvf0I/hrpYXdEce6E4ybVsEJVe6T00/Z2poiu/RoJJAgrIlwGe8D/KHrMX/8mdxIcyh@vger.kernel.org
X-Gm-Message-State: AOJu0YxiXSsZdI1Lc2GKfNIExYc6MM7ZoiuysWQAMC+R9jJ9729ZTigj
	xvZtDJa1v2ar7I7ZE8jSGMncMaLsA/wr2A2ioJqBSyshEqKBzK4o6+mb8xU3xktCdgc=
X-Gm-Gg: Acq92OFWIjpt4DZVv532QgXwdgbkF+wRqvNuhB60mb+c5R/ZwHjVBn3GVmtKFtIpdf0
	86z8WQFPRDe7D8pGET0x4VIGk44fw+zZSbzrUgmeCncXAER94suhrHeX6e5hZeLq7RMlkPumZSI
	1HCEKTVUroq8UBOt55X0hojDZ6jba7pzah3HEFNz/Atm4v5Gr3GVRm4I/N0AofgX6sS/oFNrf2Q
	/L/Hzsn9KR/e5iZUlobCFA8bED7A5surksE+F0CmRC+C2EVO3UBV8gNC/Q76nbP8TlRx4qPcE9a
	Zxf34JF0kfK58K2rlQ3AiK0g9q9IjEP7bavh+YHgZ7XJmfSBRmxiY43FxTbzwY9rX0ETWqW0Q8A
	NLUSUOdOKKjXxa1d93bgQ7zKQ6zn3M442MMDkg3EbgBk5vDCNVhfOKppACoL/c3eIdYCqRyNbtB
	bLBRck/uKTLZoWZ1GVodZu/lRtanHt/U1dluymJ1UTyyOcF/Y=
X-Received: by 2002:a05:600c:c491:b0:490:bb44:3f8b with SMTP id 5b1f17b1804b1-490c2605385mr415074145e9.17.1781104283539;
        Wed, 10 Jun 2026 08:11:23 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3c1149sm503433395e9.4.2026.06.10.08.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 08:11:23 -0700 (PDT)
Date: Wed, 10 Jun 2026 17:11:21 +0200
From: Petr Mladek <pmladek@suse.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz,
	joe.lawrence@redhat.com, song@kernel.org,
	live-patching@vger.kernel.org, Wardenjohn <zhangwarden@gmail.com>
Subject: Re: [PATCH v3 4/7] livepatch: Deprecate stack_order
Message-ID: <ail-mQ77SQR7WkiM@pathway.suse.cz>
References: <20260607131659.29281-1-laoar.shao@gmail.com>
 <20260607131659.29281-5-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260607131659.29281-5-laoar.shao@gmail.com>

On Sun 2026-06-07 21:16:56, Yafang Shao wrote:
> stack_order is no longer needed for atomic-replace livepatches, as a
> single function can only be modified by a unique replace_set.
> To maintain backward compatibility, print a dummy value, as suggested by
> sashiko-bot.

I would personally remove it completely. I believe that there are
only few users around the world. And they will need to update
the tooling/strategy for the new "replace_set" anyway.

> --- /dev/null
> +++ b/Documentation/ABI/removed/sysfs-kernel-livepatch
> @@ -0,0 +1,9 @@
> +What:		/sys/kernel/livepatch/<patch>/stack_order
> +Date:		Jan 2025
> +KernelVersion:	6.14.0
> +Description:
> +		This attribute specifies the sequence in which live patch modules
> +		are applied to the system. If multiple live patches modify the same
> +		function, the implementation with the biggest 'stack_order' number
> +		is used, unless a transition is currently in progress.

I was not aware of this ABI/removed part. We should put here also
the livepatch/replace interface which was removed in the 3rd patch.

> --- a/tools/testing/selftests/livepatch/test-sysfs.sh
> +++ b/tools/testing/selftests/livepatch/test-sysfs.sh
> @@ -21,8 +21,6 @@ check_sysfs_rights "$MOD_LIVEPATCH" "enabled" "-rw-r--r--"
>  check_sysfs_value  "$MOD_LIVEPATCH" "enabled" "1"
>  check_sysfs_rights "$MOD_LIVEPATCH" "force" "--w-------"
>  check_sysfs_rights "$MOD_LIVEPATCH" "replace" "-r--r--r--"
> -check_sysfs_rights "$MOD_LIVEPATCH" "stack_order" "-r--r--r--"
> -check_sysfs_value  "$MOD_LIVEPATCH" "stack_order" "1"
>  check_sysfs_rights "$MOD_LIVEPATCH" "transition" "-r--r--r--"
>  check_sysfs_value  "$MOD_LIVEPATCH" "transition" "0"
>  check_sysfs_rights "$MOD_LIVEPATCH" "vmlinux/patched" "-r--r--r--"
> @@ -135,71 +133,4 @@ livepatch: '$MOD_LIVEPATCH': completing unpatching transition
>  livepatch: '$MOD_LIVEPATCH': unpatching complete
>  % rmmod $MOD_LIVEPATCH"
>  
> -start_test "sysfs test stack_order value"
> -

This is not longer needed in linux-next. Marcos made the test optional,
see
https://lore.kernel.org/all/20260504-lp-tests-old-fixes-v5-6-0be26d94ab9a@suse.com/

The changes are queued for 7.2 merge window which will likely start
next week.

I suggest to wait with v4 until the change is merged. We should wait
for opinion from others (Miroslav, Josh, Joe, Song) anyway. We
need to be sure that the change of the semantic is acceptable
in general.


> -load_lp $MOD_LIVEPATCH
> -
> -check_sysfs_value  "$MOD_LIVEPATCH" "stack_order" "1"
> -
> -load_lp $MOD_LIVEPATCH2
> -
> -check_sysfs_value  "$MOD_LIVEPATCH2" "stack_order" "2"
> -
> -load_lp $MOD_LIVEPATCH3

Nit: It seems that MOD_LIVEPATCH2 and MOD_LIVEPATCH3 are not longer used
     at least in this test-sysfs.sh file. Well, I guess that we will
     keep this test optional for older kernels.

> -check_sysfs_value  "$MOD_LIVEPATCH3" "stack_order" "3"
> -

Best Regards,
Petr
