Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8113D6477
	for <live-patching@vger.kernel.org>; Thu,  1 Oct 2026 15:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790870231; cv=none; b=h0dUN6DrC2FP+M3l5H04AucpPrAk3iCwJVqEImXJnpLiQXBGNtyO3QMWMhrHkigFHZm4mswVUNLEwiRaV5C5blFyMEhqpDE/jVu7qqM50pxPhBbe/f9xwgzC2n24ZrKQn3d4gfq57ek4sL9auqeVlAkeqCL3JVdnr6aPH/SOXEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790870231; c=relaxed/simple;
	bh=RPw6sbpMGCgUY0A+n7NmAcBh9YJNet1wRRFN3AB8Ano=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o0AfM7PMLv594nko3Xg6/rWQFWuBQuLnBRMokL9+5MRehObQCcYPLUcOPKVzAKlT3g+s1oZa0S7geRoDQMxePvk0LxfLtDo8UhrTSbbV4Z0sZPvLQJATRRfHLX+KKtXR6Jmpu/Bi5YWsfacMkpJLxjbJ25vGnDzlWGvsnyFMwO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Y3Ijwr5A; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Y3Ijwr5A"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-4a006bb267eso26008495e9.0
        for <live-patching@vger.kernel.org>; Thu, 01 Oct 2026 08:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1790870226; x=1791475026; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xmyV8heguK2PRwm8w+NQBWmqYPo49iJ9MVV0ZuxdlLU=;
        b=Y3Ijwr5AQDJMPc+EJ+uc3SSDUrj0u3wtjqdO1CxJJE53qQB0LuNV/Ea/jtHnsyDJyv
         715ZNyM+1F8tzRi1Rt6dGvSQ5tJfWXOl02DmIHt5aM/0YD9FVnOQj3sITZc+UjuH7Odq
         /vpho+zRAuwZ2LNbT5HQrZllWXCdCqL9e8IA3cram762vMIMhxd7f8Jh24wSwYRsrG48
         RTxXkU1EDNRpeGoCzYhYxz2nO0FtEFqskSoYCuoNQofSGRqW1SDQRoSx8gRzMO03+m9R
         WvB8MixP0BAvjXDA/zEHxIzhgaM1rUixz8mx6MOXE1j+q8gy0GFNNnTBV4FYjVzVUpUZ
         quOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790870226; x=1791475026;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xmyV8heguK2PRwm8w+NQBWmqYPo49iJ9MVV0ZuxdlLU=;
        b=WBJfCK+xaqEr5KR/EWRCm9yhmWpH7jaEIQufMjTiTEPA2BJ9EUz1AXT6bVb+AtSFre
         p6HPFZYAXIN5Eshln3rfz8C3G42XYw7Q6LE6PA+blO5h/t0cAcCvRZ6BoGsIIZilABR/
         18ViqfZ367tLGxbDvEFYy2FfXtq97lqPQRkuyUgVC4ieEjjfTUg91qRxAIvkk8oc8M4k
         XpBKqURV6cXF2buMsVw78oIqWqcpAnrr8dXzQB8lFW1yj4D0/yQpUST4TSrO1XDZJ6LM
         eDThu1SHMPKcriu7q1rTLblwtTos3DM8BjHHThNFgNtWGs5dr5lICoiYQSJ4KAKZc+s+
         B0Yg==
X-Forwarded-Encrypted: i=1; AKwUvBzH1JMIhQD1tj0H3xkzV6lNeBEEO3j3sUj8XoVucHBnp9eNRbH8B1mO+r96qLvUR/u627+QN/kBrJ8Eikdk@vger.kernel.org
X-Gm-Message-State: AFuF++lk69wSoZqhkukjIFVRrn+gMh8Zla/IZEUdGkiEI+qDw5IidOh+
	I3L7Pnv/ey/soJ4S6JL32yS0sslVEdw3f7+dz/GC896mU71k/MdummiPYvv9B13Nnng=
X-Gm-Gg: AYBFou2JRhaNhrKFqWq8xlbO/wPs7lwMUppFJjuJ0EtGOOosJtdUK04l0UC1sTF2MVk
	LZSYRcEPUZBaixU5N9GwwrFOKv3OLVhu90jKzR2fCwzdXuyEIX2BEs85Hp5/ppFMELEO3l84Zjg
	ReZhgm+W/Mp+h89xv1qYpFk8cOU2PJ8dRCfbkX8HbHItod9QTar71RaNv/gJEyw4ChRc6hx3qh+
	OOi7flbi8f2TT/5dH2uCy+oTbmoLu3RitFeRGA6J6Csernlfq+nDUkqUV0wKEKGuI0T3fJ2UoEH
	3UU3AUxVMPd7eCJV/jG3ByGdenbprYX6pqc+srGQIeVc2r6BXiXoskpLd32XGTvKdolO2vp+Wm3
	yytDeBYsjlc8WX/n2ILAC2SElMum5FYm3h7Y8W3s0jOLocWFX39jlv62kMJhXOZT2v330qssTD3
	DX26SilWkm6LzEHEoLqPSDq/bRRqpM8xQsUfCGiaqoKVD0AIUkLaP4iJwirhArQQI9ca7y6MKj5
	Hn9P99LDA8=
X-Received: by 2002:a05:600c:1908:b0:49f:fc13:18a5 with SMTP id 5b1f17b1804b1-4a0276a1f07mr675475e9.6.1790870226475;
        Thu, 01 Oct 2026 08:57:06 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0276b8476sm956235e9.9.2026.10.01.08.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 08:57:06 -0700 (PDT)
Date: Thu, 1 Oct 2026 17:57:04 +0200
From: Petr Mladek <pmladek@suse.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz,
	joe.lawrence@redhat.com, song@kernel.org,
	live-patching@vger.kernel.org
Subject: Re: [PATCH v10 2/9] selftests/livepatch: Adapt atomic replace tests
 to provides/obsoletes
Message-ID: <ar6C0B2aWg-4ayVU@pathway.suse.cz>
References: <20260930030323.14396-1-laoar.shao@gmail.com>
 <20260930030323.14396-3-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930030323.14396-3-laoar.shao@gmail.com>

On Wed 2026-09-30 11:03:16, Yafang Shao wrote:
> The legacy "replace" field in struct klp_patch will be replaced by the
> provides/obsoletes mechanism. As a result, the atomic replace
> selftests fail to build against kernels that only support
> provides/obsoletes.
> 
> Adapt the selftests so that they build and run on both old and new
> kernels. On kernels without the legacy "replace" support, the
> replace-related test cases are skipped with a SKIP message instead
> of being run.
> 
> Also introduce the CONFIG_KLP_HAS_PROVIDES compile-time marker in
> kernel/livepatch/Kconfig. It defaults to n and will be set to y once
> the provides/obsoletes support is implemented later in this series.
> 
> The provides/obsoletes-based selftests will be added later in this
> series, after the legacy "replace" field has been substituted by the
> new mechanism.
> 
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Acked-by: Song Liu <song@kernel.org>

Looks good and passes selftests. Feel free to use:

Reviewed-by: Petr Mladek <pmladek@suse.com>
Tested-by: Petr Mladek <pmladek@suse.com>

Thouhg, see few nits below:

> --- a/tools/testing/selftests/livepatch/test-callbacks.sh
> +++ b/tools/testing/selftests/livepatch/test-callbacks.sh
> @@ -458,16 +459,17 @@ $MOD_TARGET_BUSY: ${MOD_TARGET_BUSY}_exit"
>  #   execute as each patch progresses through its (un)patching
>  #   transition.
>  
> -start_test "multiple livepatches"
> +function test_multiple_livepatches() {

I really like the approach with bash functions. It separates
the test code from the skip-check.

> +	start_test "multiple livepatches"
>  
> -load_lp $MOD_LIVEPATCH
> -load_lp $MOD_LIVEPATCH2
> -disable_lp $MOD_LIVEPATCH2
> -disable_lp $MOD_LIVEPATCH
> -unload_lp $MOD_LIVEPATCH2
> -unload_lp $MOD_LIVEPATCH
> +	load_lp $MOD_LIVEPATCH
> +	load_lp $MOD_LIVEPATCH2
> +	disable_lp $MOD_LIVEPATCH2
> +	disable_lp $MOD_LIVEPATCH
> +	unload_lp $MOD_LIVEPATCH2
> +	unload_lp $MOD_LIVEPATCH
>  
> -check_result "% insmod test_modules/$MOD_LIVEPATCH.ko
> +	check_result "% insmod test_modules/$MOD_LIVEPATCH.ko
>  livepatch: enabling patch '$MOD_LIVEPATCH'
>  livepatch: '$MOD_LIVEPATCH': initializing patching transition
>  $MOD_LIVEPATCH: pre_patch_callback: vmlinux
> @@ -548,6 +552,15 @@ $MOD_LIVEPATCH2: post_unpatch_callback: vmlinux
>  livepatch: '$MOD_LIVEPATCH2': unpatching complete
>  % rmmod $MOD_LIVEPATCH2
>  % rmmod $MOD_LIVEPATCH"
> +}
> +
>  
> +if [[ "$HAS_PROVIDES_ATTR" != "1" ]]; then
> +	test_multiple_livepatches
> +	test_atomic_replace
> +else
> +	skip "multiple livepatches" "legacy replace attribute not present"
> +	skip "atomic replace" "legacy replace attribute not present"
> +fi

I would revert the logic and ordering:

  + Positive checks are easier to read ;-)
  + It would make sense to have the obsolete checks in the "else" part.
  + It would be the same ordering as in the .c files.

> --- a/tools/testing/selftests/livepatch/test-kprobe.sh
> +++ b/tools/testing/selftests/livepatch/test-kprobe.sh
> @@ -196,6 +200,16 @@ livepatch: '$MOD_REPLACE': starting unpatching transition
>  livepatch: '$MOD_REPLACE': completing unpatching transition
>  livepatch: '$MOD_REPLACE': unpatching complete
>  % rmmod $MOD_REPLACE"
> +}
> +
> +
> +if [[ "$HAS_PROVIDES_ATTR" != "1" ]]; then
> +	test_multiple_livepatches
> +	test_atomic_replace_livepatch
> +else
> +	skip "multiple livepatches" "legacy replace attribute not present"
> +	skip "atomic replace livepatch" "legacy replace attribute not present"
> +fi

Same here.

>  
>  # - load a target module that provides /proc/test_klp_mod_target with
> diff --git a/tools/testing/selftests/livepatch/test_modules/test_klp_callbacks_demo2.c b/tools/testing/selftests/livepatch/test_modules/test_klp_callbacks_demo2.c
> index 5417573e80af..6c46ce575f5c 100644
> --- a/tools/testing/selftests/livepatch/test_modules/test_klp_callbacks_demo2.c
> +++ b/tools/testing/selftests/livepatch/test_modules/test_klp_callbacks_demo2.c
> @@ -7,9 +7,16 @@
>  #include <linux/kernel.h>
>  #include <linux/livepatch.h>
>  
> +#ifdef CONFIG_KLP_HAS_PROVIDES

JFYI, this is the related check in the .c code.

> +/*
> + * TODO: Add provides/obsoletes module parameters for the
> + * provides/obsoletes based tests (to be added later).
> + */
> +#else
>  static int replace;
>  module_param(replace, int, 0644);
>  MODULE_PARM_DESC(replace, "replace (default=0)");
> +#endif
>  
>  static const char *const module_state[] = {
>  	[MODULE_STATE_LIVE]	= "[MODULE_STATE_LIVE] Normal state",

Best Regardss,
Petr
