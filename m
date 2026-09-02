Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167B64A8403
	for <live-patching@vger.kernel.org>; Wed,  2 Sep 2026 15:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788362160; cv=none; b=o4Y7intCN0sd7KDGabKl9CAtmCpbCVtOmCq0lm3dtIVi9iKI59D/VEVxaCFsKmS1v6ursXirJzbzdEImUBk/hzLjcL6NFrR3bsfvadAhPJPjYuzemRg0Or9BccXQ0U/cuQm2G8cW17ncpp/Gg1i0p0LtqprFMZ6NdevkDN74sw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788362160; c=relaxed/simple;
	bh=XUZDiaTcOA5+kAYSEqv60/44+6jL9IaX7+m/61ypG9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tk0wMZfFXvJqlsB1+KAK+k1BW1+rCwOLvXPX5SsAM6RVzxfnbhEBHM9mt4rBNyDHDy7OfE2rfypM6lsMRmxm8GO4307ciqUWkWCFBo+hLt++MFTk8Jkl1Ocj/QYG/Mmn7BanUEbFqPr05uJHret8DWRMW0TFkXg9Zc0Nn/QoYcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ciNBUdmw; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ciNBUdmw"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49ccfae359fso8196205e9.3
        for <live-patching@vger.kernel.org>; Wed, 02 Sep 2026 08:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1788362155; x=1788966955; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SKy/ceUWl3j64g/lhknRGefAudI+1+1MndJfHsJ8Tv8=;
        b=ciNBUdmwSnoMPD93JV/uQKKmEaGGLFFeB2iF+s7dsvcMPEkVjwg1+/F05K8s3x6JZu
         2+1m1IgC4DRuvRTlPmvTZZgg2MxidBE74Gsrit6xhwY7yHOJYXFZlhXUVsE+LICP/D1y
         LOrrizoVcTR8DD6z+NO1dGi5kPEo8mvEr0fGOxGSkP/0mzFCSJ+pjU4X4KYzc5ni6Fck
         g2tn2IVVM9joNoG7M7oXELulFOkoXYphYWCKNpC24erwULW8jrDaFx+YaH1JMhfxUpcR
         8dK8yn/v36Wj/WBOPc8zxVPsPLYRQUGi5ESlVQyvUOWpQRpncAvfeMHuo7gkMEa2dctJ
         4Eeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788362155; x=1788966955;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SKy/ceUWl3j64g/lhknRGefAudI+1+1MndJfHsJ8Tv8=;
        b=iTEVEYocgcDMWqo255t31RMm7IkvwiCEj2p9rb3c8r2DarMM7QFGgtJy4un89m2tSV
         XHGPauFEx1/kip75AhGetXiHkOGQ3n3lrRCAeXNI1ZRcVGgVjdRiDTY+mC3YfHNfUGM7
         +IAAV5yd238WKMSCOKcr1MrTWgLnmEglgUtUNcGyxOkhXn0VrW0ENOSqUlWJUrRhU8r3
         8qEs/Zor8SA1ORm2lZteqxECtl/FW5LxdimDDUNA3m3Tihx9p3jCLNyJul0nPpUs3hli
         hnQPE9hLvazewsL9P52k76WD/bsx5Uvji20eFMwhj1MLqveVLN4eotohc52WSG4lmxT6
         gMww==
X-Forwarded-Encrypted: i=1; AHgh+RpTthOlFXcTWN8aQBdoD4R0iwnNX8JURqJk7PTWc2aeO2R5vdrjGSzYoauCEF6/P8C6rfzH5srVAQKp/Qzm@vger.kernel.org
X-Gm-Message-State: AFuF++lNyJqixqR0Bf1Bo4t69ACiTrHWZTVfJQwmlFAfR8kSSkcdwKdB
	fqSfSJPDgKJVSVMkqsLenF4CUvhN5n1IoxuMny6i8RBNvp7nTao+0ed9iMju7ssXwm8=
X-Gm-Gg: AR+sD10xFIamxYoVDK2K2zUJPMUs+a3MSjakvsuAn7wO1VL5qsWZpUczmWlMEZGOYbz
	4bHnfHroWSns1mgHPBltWF869jwUPkKZkJ4h5PN529+qmDqHCdu1dGtTamhnAGhn+831YvE4CtT
	HsUkpujhYOQeRC9OjnILY1n/6VEGH8ugStWfCi6B0U86n+R4ueIKPC6Vvg6TY/CBH5TTnAzvFkX
	sdyV55ypMMZRgl6D8PsP2c/qC3MSd4Kz7QwNRt8SkugOZAQuu0YyA2nqM3TKoSizFAnf+QYQsXw
	zwqnE5c9LBIpZuHet70lOvBmED4ZFHFMha0IRvN2XYWWpyrEnt3bO4nlMbtJio727QwjaR8s7Zk
	dRsKqUxteBipB65vaY7xCodj/I0BgBj3jm79BiqTPFtFn7W0zDGIf8zLc7Tx2wV/MASsNipA32s
	qBB8xJ8egipk7c8t0OFhvVlBVsYQKgfzYkVLnNMbJBMLMXCecKIZfspAl5EfOTXw==
X-Received: by 2002:a05:600c:45c4:b0:499:79b9:e220 with SMTP id 5b1f17b1804b1-49ce5816186mr102318575e9.10.1788362154811;
        Wed, 02 Sep 2026 08:15:54 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cdce4a804sm180755475e9.15.2026.09.02.08.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 08:15:54 -0700 (PDT)
Date: Wed, 2 Sep 2026 17:15:52 +0200
From: Petr Mladek <pmladek@suse.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz,
	joe.lawrence@redhat.com, song@kernel.org,
	live-patching@vger.kernel.org
Subject: Re: [PATCH v7 for-next 6/8] selftests/livepatch: Add
 provides/obsoletes test scenarios
Message-ID: <apg9qFCgDaXbUT6J@pathway.suse.cz>
References: <20260825114641.80452-1-laoar.shao@gmail.com>
 <20260825114641.80452-7-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825114641.80452-7-laoar.shao@gmail.com>

On Tue 2026-08-25 19:46:39, Yafang Shao wrote:
> Now that the legacy "replace" field has been replaced by the
> provides/obsoletes mechanism, add test scenarios to verify the new
> behavior.
> 
> Fill in the #else branches of the test modules that were left as
> TODO placeholders in the previous patch:
> 
> - test_klp_atomic_replace.c gains provides and obsoletes module
>   parameters for the provides/obsoletes based tests.
> 
> - test_klp_callbacks_demo2.c gains a provides module parameter.
> 
> - test_klp_livepatch.c gains a provides module parameter so that it
>   can be loaded with a specific provides id for coexistence tests.
> 
> - test_klp_state.c and test_klp_state2.c add a comment in the #else
>   branch noting that provides=0 (the default) is equivalent to the
>   previous .replace=true behavior.
> 
> Add test-provides.sh with four test scenarios:
> 
> 1. provides=0 replaces provides=0: two livepatches with provides=0
>    that modify different functions; the second replaces the first.
> 
> 2. Same provides replaces: two livepatches with provides=1 that
>    modify different functions; the second replaces the first.
> 
> 3. Obsoletes replaces: a livepatch with provides=2 and obsoletes=[1]
>    replaces a livepatch with provides=1. The provides/obsoletes sysfs
>    values are verified.
> 
> 4. provides=0 coexists with provides=1: two livepatches with
>    different provides ids that modify different functions coexist,
>    verifying that provides=0 does not replace a patch with a
>    different provides id.
> 
> The provides/obsoletes based tests only run on kernels that no longer
> support the legacy "replace" attribute.
> 
> Assisted-by: Comagic:DeepSeek-V4-Flash
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  tools/testing/selftests/livepatch/Makefile    |   3 +-
>  .../livepatch/test-provides-obsoletes.sh      | 174 ++++++++++++++++++
>  .../test_modules/test_klp_atomic_replace.c    |  22 ++-
>  .../test_modules/test_klp_callbacks_demo2.c   |  12 +-
>  .../test_modules/test_klp_livepatch.c         |   9 +
>  .../livepatch/test_modules/test_klp_state.c   |   5 +-
>  .../livepatch/test_modules/test_klp_state2.c  |   5 +-
>  7 files changed, 205 insertions(+), 25 deletions(-)
>  create mode 100755 tools/testing/selftests/livepatch/test-provides-obsoletes.sh
> 
> diff --git a/tools/testing/selftests/livepatch/Makefile b/tools/testing/selftests/livepatch/Makefile
> index a080eb54a215..38f98594d883 100644
> --- a/tools/testing/selftests/livepatch/Makefile
> +++ b/tools/testing/selftests/livepatch/Makefile
> @@ -11,7 +11,8 @@ TEST_PROGS := \
>  	test-ftrace.sh \
>  	test-sysfs.sh \
>  	test-syscall.sh \
> -	test-kprobe.sh
> +	test-kprobe.sh \
> +	test-provides-obsoletes.sh
>  
>  TEST_FILES := settings
>  
> diff --git a/tools/testing/selftests/livepatch/test-provides-obsoletes.sh b/tools/testing/selftests/livepatch/test-provides-obsoletes.sh
> new file mode 100755
> index 000000000000..2707457b9133
> --- /dev/null
> +++ b/tools/testing/selftests/livepatch/test-provides-obsoletes.sh
> @@ -0,0 +1,174 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2026 Yafang Shao <laoar.shao@gmail.com>
> +
> +. $(dirname $0)/functions.sh
> +
> +MOD_ATOMIC=test_klp_atomic_replace
> +MOD_LIVEPATCH=test_klp_livepatch

I always get lost in the various test modules and have to look
what is inside. It might help me if the name better describes
the content, for example, rename:

 + test_klp_atomic_replace -> test_klp_proc_memset_livepatch
 + test_klp_livepatch -> test_klp_proc_cmdline_livepatch

So, it is clear that they "livepatch" a given "proc" interface.
And it is rather clear that they livepatch different functions.

The names are long. The following might still be better than
the current state:

   + test_klp_memset_lp
   + test_klp_cmdline_lp

Best Regards,
Petr
