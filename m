Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDE027144B
	for <live-patching@vger.kernel.org>; Wed, 26 Aug 2026 07:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787730890; cv=none; b=HnEYyyT+yJykOHKzxPe1EznrXvpRAQ1sTIMr+F0aUeTFR8sxYkZalSmpv/uqqD2InisDv3ngE9YUfkGZVx3pE9sQ1KtwMMJAoCP8s7JN1pbyaDnRzbjsWPnoc3+dxve8EtYVzwgE25oRkV17o6IXmGmdNuu3UQmGcWyLwB12H0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787730890; c=relaxed/simple;
	bh=pyZMGJNOKwZwLp9pVWn0/AOu1yuGKL4YxlNqGOOwfPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qt8O7JBwW8X5owrJ3XlvIjpMKK7YvjKNGRecQLowiY7qbhU6DJdcQkrbNXIFCYCy7vFeBBM/JNlCSkM8vem3I7w7OWHDmyiOMsF4jj0czqEs/r1e7M1uaAwPjOnkDIVFojwKNs8Vo3QH8xCz7S1A28Wy/lcHDTUptwcAPKZvj3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QNShdotx; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QNShdotx"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c15d3cd51b2so84613566b.3
        for <live-patching@vger.kernel.org>; Wed, 26 Aug 2026 00:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1787730888; x=1788335688; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=l0bXcPQZsu18l8qTHgcARXOzo7oI/+3ZG75xwN370jw=;
        b=QNShdotxsBw8XGVM6W929Cn7KiDfHKQneOzuAgfEeZlo1l8JTkK1fMlrjc6o5ZqTRd
         RAKzh4Fg5QdVLehZzk+Ws/H8CjNqwuiyVlWUf9tEsSS2XwRUajhGO6dKfbzwFdMH1mnl
         3rTsHIncx2N33mtHo9mfC2BeqguN+ajKG0427+biR2OSJlX49XRogKUGo3u2Z0PJPsPW
         Fp8uSfgAsQm7ob2aZWROF5QybeB7ZdzLsj5pfl2RmOnEPHG4uTii75/3r55X7zwAG0cz
         pNUPeIgl9xaMt/fMtagCR2RO5keclRFncF50zzSgYC2Fxdtb1kBLpLUQfjZqXNNa3tvB
         mHcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787730888; x=1788335688;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l0bXcPQZsu18l8qTHgcARXOzo7oI/+3ZG75xwN370jw=;
        b=RqidRzXguyYtFKRIgDD8N3Jiq8Rf9mMchVZSF0+flyBbvYewabjCe1lVGdcy030Uzm
         1ADApT/An/seYNmGrpzopghyW9pPm9N/h9Npp75ks6MYct70Et9z8uPh/rze+pDo7/d4
         0/UQnwR4n4+HnswSeqndFbiHKeCE5lD8DS4c570VKRoPB5mBTsR4pYEikZ7GtivxhFVX
         aXI65X2vAKjtku2GzgnnSF0Pt35dlvnHHLSpvl5oNYTc573FHKBcleT3x5kpxtyngM6l
         KShRH+fFtcAHuGHV+2miHrqbH5G1lk9LWCKNkCSrh3w9NySiLCKjHs44ZAV4lTT3RY73
         phag==
X-Forwarded-Encrypted: i=1; AHgh+RpjdDuAe3rPlRVsOBAzoqVcPNpnwun4wZgVAgpxfLVZZ46QzynFFdHgZ4PU7PVnKZG/+0Is8c9gz2urOvCC@vger.kernel.org
X-Gm-Message-State: AFuF++lN0Bg3lhqWvC/F4zyOvxwCL/FNGJIZ1/yqYz9LfZan9xwyBGrZ
	jzZf3EbYDC8SfYtutG1pX1XnTSeqAKNe34GoizhKJmrDNAPPYhIFwbmFIvab8e03ZMQ/45bH3h+
	pvbmBRfY=
X-Gm-Gg: AR+sD13pwHt0U/8Or1ryXzxroWbN+SErd2usViibxvzKTRelA3YghKiiCYdKhFcG2os
	8RwwFjUcqeHvycQawg95p8/nog2jv7w+oSkaX6F7IbZkvMIqF9XSidtqvG3nf4Bab705CSyT0kO
	RAZxlXKyk6/VNmPGuoXsKagDaa/f9GJ+Uk7itXp8IAiY89mHCAQKtUjrFU2/xzZIbLaBXbfUzxI
	hwn4aMZijdNsps+SNRO+t4sdEb0IxmDEvZoAxK8eL33lN9fRU9P2fS2g82R4l5aHY1fg9boD1MY
	AtUFMg8BlQcevTL1W8Hfbfs2bmPpFhjyCjeMuOHPXiF586v+7Xbo/P9yhYvqalzNbhYgS3e4Oxy
	t6rv7so5LV242Bgw0Txoc6MLF34tyboJZGV+rcpxd9qZ8P+2230rJhRU2PVdsTmmidysXoEXq6f
	2Nr58xf7xXqnuu0GxhT4ZQBZOrc9pJf//07riuGUHdBEtGk6NmQfzjw+oW0gIdpA==
X-Received: by 2002:a17:907:5c3:b0:bec:64d4:3872 with SMTP id a640c23a62f3a-c250c3cc2eemr574827966b.24.1787730887706;
        Wed, 26 Aug 2026 00:54:47 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c250a704e55sm343158766b.21.2026.08.26.00.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 00:54:47 -0700 (PDT)
Date: Wed, 26 Aug 2026 09:54:45 +0200
From: Petr Mladek <pmladek@suse.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz,
	joe.lawrence@redhat.com, song@kernel.org,
	live-patching@vger.kernel.org
Subject: Re: [PATCH v3 2/2] selftests/livepatch: filter debug messages in
 check_result()
Message-ID: <ao6bxf5D9O1U-JJ7@pathway.suse.cz>
References: <20260821031648.48195-1-laoar.shao@gmail.com>
 <20260821031648.48195-3-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821031648.48195-3-laoar.shao@gmail.com>

On Fri 2026-08-21 11:16:48, Yafang Shao wrote:
> CONFIG_DEBUG_KOBJECT makes kobject_add_internal(), kobject_uevent_env(),
> fill_kobj_path() and friends emit pr_debug() messages, and
> CONFIG_DEBUG_KOBJECT_RELEASE makes kobject_release() emit a pr_info()
> for every delayed kobject free.  All of these carry the "kobject:" prefix
> via pr_fmt(), e.g.:
> 
>  # --- expected
>  # +++ result
>  # @@ -1,7 +1,13 @@
>  #  % insmod test_modules/test_klp_livepatch.ko
>  # +kobject: 'test_klp_livepatch' (000000009dbf565e): kobject_add_internal: parent: 'module', set: 'module'
>  # +kobject: 'holders' (000000002856f0ae): kobject_add_internal: parent: 'test_klp_livepatch', set: '<NULL>'
>  # +kobject: 'test_klp_livepatch' (00000000dcae1113): kobject_add_internal: parent: 'livepatch', set: '<NULL>'
>  # +kobject: 'vmlinux' (000000007b8837e6): kobject_add_internal: parent: 'test_klp_livepatch', set: '<NULL>'
>  #  livepatch: enabling patch 'test_klp_livepatch'
>  #  livepatch: 'test_klp_livepatch': initializing patching transition
>  #  livepatch: 'test_klp_livepatch': starting patching transition
>  # +kobject: 'test_klp_livepatch' (000000009dbf565e): kobject_uevent_env
>  # +kobject: 'test_klp_livepatch' (000000009dbf565e): fill_kobj_path: path = '/module/test_klp_livepatch'
>  #  livepatch: 'test_klp_livepatch': completing patching transition
>  #  livepatch: 'test_klp_livepatch': patching complete
>  #  % echo 0 > /sys/kernel/livepatch/test_klp_livepatch/enabled
>  # @@ -9,4 +15,17 @@ livepatch: 'test_klp_livepatch': initial
>  #  livepatch: 'test_klp_livepatch': starting unpatching transition
>  #  livepatch: 'test_klp_livepatch': completing unpatching transition
>  #  livepatch: 'test_klp_livepatch': unpatching complete
>  # +kobject: 'test_klp_livepatch' (00000000dcae1113): kobject_release, parent 00000000f8785d63 (delayed 2000)
>  # +kobject: 'test_klp_livepatch' (00000000dcae1113): kobject_cleanup, parent 00000000f8785d63
>  # +kobject: 'test_klp_livepatch' (00000000dcae1113): auto cleanup kobject_del
>  # +kobject: 'test_klp_livepatch' (00000000dcae1113): calling ktype release
>  # +kobject: 'test_klp_livepatch': free name
>  #  % rmmod test_klp_livepatch
>  # +kobject: 'test_klp_livepatch' (000000009dbf565e): kobject_release, parent 0000000052e5c022 (delayed 3000)
>  # +kobject: 'test_klp_livepatch' (000000009dbf565e): kobject_cleanup, parent 0000000052e5c022
>  # +kobject: 'test_klp_livepatch' (000000009dbf565e): auto cleanup kobject_del
>  # +kobject: 'test_klp_livepatch' (000000009dbf565e): auto cleanup 'remove' event
>  # +kobject: 'test_klp_livepatch' (000000009dbf565e): kobject_uevent_env
>  # +kobject: 'test_klp_livepatch' (000000009dbf565e): fill_kobj_path: path = '/module/test_klp_livepatch'
>  # +kobject: 'test_klp_livepatch' (000000009dbf565e): calling ktype release
>  # +kobject: 'test_klp_livepatch': free name
>  #
>  # ERROR: livepatch kselftest(s) failed
>  not ok 1 selftests: livepatch: test-livepatch.sh # exit=1
> 
> The livepatch test modules' kobjects are named "test_klp_*", so these
> lines match the check_result() grep for "test_klp" and leak into the
> result.  The extra lines no longer match the expected output, so the
> selftests fail when either debug config is enabled.
> 
> Filtering out every "kobject:" line also hides real WARN()s, e.g. the
> one kobject_get() emits for an object whose refcount was not
> initialized.  Filtering with "dmesg --level=..." is not enough either,
> since the tests enable livepatch pr_debug() through dynamic_debug/control
> and expect its messages.  Read the log with "dmesg --raw" and drop only
> the debug-level messages without the "livepatch:" prefix, plus the
> specific delayed-release info message.
> 
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

I am not much familiar with awk. But the changes look good
and selftests passed so:

Reviewed-by: Petr Mladek <pmladek@suse.com>
Tested-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
