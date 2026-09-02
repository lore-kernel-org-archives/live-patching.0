Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCA21FCFFC
	for <live-patching@vger.kernel.org>; Wed,  2 Sep 2026 13:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788356754; cv=none; b=qC0+n5DsjrF0hhoXFZAnR1/YjmSRlV7sEXLpkjyTJjZShg+t36KByKKfebTzBZV0kOsK8nIsJxqyLs0l87OdvQOsvtf0fSXkAGKU4S0kHHDYYqAl3ojKYPsoUO38eReeS5WcBkj7E4nohEpOpPsKQ+cawyLhbmjX9bPVWxr1t3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788356754; c=relaxed/simple;
	bh=Blk6bkiDNVlzCmR80Tl850pIOGn/qmdrjADbDP28C5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RZWETcnqcvxdcT0o++OhXI4Rd/N/BNJ2AhYsobdw3IbOvFNmIQtdIosp/Pj5H3njqoaASXfEyZIYr4QdVtJVWCITs0eqzn+foXINDe6Lyc8k0pXUuhrTiU+T8UraCGxOyS7q+tMau+TtXylI8ufUIvEMtPW/H2eKOzOO2PowCKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VAvRq5m9; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VAvRq5m9"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48436216a98so707932f8f.0
        for <live-patching@vger.kernel.org>; Wed, 02 Sep 2026 06:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1788356751; x=1788961551; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9WlVJhR5jLZZd5/CTPgiaxmrkubOYMFFIEI4VEKaueA=;
        b=VAvRq5m91whNX9KnJGImEi9mlZtfWY3UPCDgs21W31dterEBn6v0n6PU482DY+9Hyz
         fXMZi3kG3Ss/CQdXnhrOzHiwO7OQGFpTANC1gfV5Y7ldGAg1wBp6MMcIzHPY/z/CDKr4
         UVe7Orj8pNUBX8L+HBlf4ontHoBiuR4ecF+RqSszWwaSkH5Y81hT2tKSA+HpYBXZWMl4
         uxv/y7Ra5uKCzdRKrL67J0IuPCAGh5otD40cMIl+z89HDIZix8MNB273LIC69qZoVV3R
         gUF2On+h8uYHqjJAcObZ5HCr5fHJS16FzFXICja0SrCv8pkNWHbdObsgUsk0WsgYmQ0g
         E4/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788356751; x=1788961551;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9WlVJhR5jLZZd5/CTPgiaxmrkubOYMFFIEI4VEKaueA=;
        b=cgrpJUoPHCmTIFUeQL7SKO5KL1+tTLktw9nCOf3hNZxE0NpWf7RWUI0ixty8WJBre0
         LHx9aAiS0kRg86b1inA42G0inJyFJxz0Zi77pq1MdF3Z63Gh4T2si1pz4ZQ6NK96mb1g
         jbwhsyFQl/XQEU0OBBRfir+8XkKH798FaXYTQDj9Z8Zr86rG06PRHUPfaZnKdW+MgvJh
         6c6bt217SRIUYrLevjtiHgxlrDOL9fztHQPMR8lThJQxZ5KKtsNngbJH1f9VIgfiLN17
         T9gO/6nglA/4GWIwXPCRwOVTb6B9w6HmH6rmHh4eh3GS5ZEJ6V9QwNNE9k9Zg7ptImL0
         wbsw==
X-Forwarded-Encrypted: i=1; AKwUvByZJDWR+a95ESz38mnkYEsVZJlJml119PiRDUSBvjWlz+aiq84DzarDOhVQ0BM2vCY7fs2mQN4PA9HEeOtA@vger.kernel.org
X-Gm-Message-State: AFuF++nLIWuBAxWk8f0PHRYPZJR1Tp9iSM1RG6oZegjR7T/hO0RVRXuF
	hE5xIWwgEUxAqtQvN8yJE4zd/40HTvE3Sri+pHosqwipNRja0Cdmt8R+UGqHze/Ee8Y=
X-Gm-Gg: AYBFou1YoQ54w7UqxgXQR+6PuwMftFCd7a1f9Xu8nv39+9wdyuWyVCkM/s6wYgocLlE
	c0Lk1xvTy7+eeYunpGv19kWgSovmoTQOzszpGZG6/cfE5Nz3Rd//23b3nzkuf7SaghtOmPP2u2A
	+CTrqVxZB8c+Z8fxFG0AWYsxAOgxkzRTZXxW4z9TNASgug8is3gEnv+fD3TSOPJLDO3JgIQvqYQ
	GPrOHibZRsSaYXL1ggx4DAf+2VPJXpd1q+0k2GjLXcPKZaiEGZnpHtB46VQ7bUc+2aukHUe38Pq
	bSLFddjpSOTF2Hhgq/z1NAkrlC05PrqP/u1uEFIlX2Thyflz/E5LYBkZsEkrx2Ww8L1bNIEtnT+
	g5DSe+/PNIB5zLDIC4H48N1oXVaKWBqFEsD7O6LcGTKxisEOJVXhzQaBvmDSW8/PnEjbp978nGA
	H+AjOVRKfg/DTX5dZt08dleV+NXRmh4D6wySE4g8qcYUFGBTrarPZz+VCHUsdQhb/h+7lcPAtK
X-Received: by 2002:a05:6000:4819:b0:484:4537:95ed with SMTP id ffacd0b85a97d-48488efe633mr9507562f8f.5.1788356750605;
        Wed, 02 Sep 2026 06:45:50 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448e736a6sm6339105f8f.5.2026.09.02.06.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 06:45:50 -0700 (PDT)
Date: Wed, 2 Sep 2026 15:45:48 +0200
From: Petr Mladek <pmladek@suse.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz,
	joe.lawrence@redhat.com, song@kernel.org,
	live-patching@vger.kernel.org
Subject: Re: [PATCH v7 for-next 5/8] selftests/livepatch: Adapt atomic
 replace tests to provides/obsoletes
Message-ID: <apgojIqhOoxYOXuK@pathway.suse.cz>
References: <20260825114641.80452-1-laoar.shao@gmail.com>
 <20260825114641.80452-6-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825114641.80452-6-laoar.shao@gmail.com>

On Tue 2026-08-25 19:46:38, Yafang Shao wrote:
> The legacy "replace" field in struct klp_patch was replaced by the
> provides/obsoletes mechanism. As a result, the atomic replace
> selftests fail to build against kernels that only support
> provides/obsoletes.
> 
> Adapt the selftests so that they build and run on both old and new
> kernels:
> 
> - test_modules/Makefile detects whether the kernel header still
>   declares the "replace" field. If so, it passes KLP_HAS_REPLACE to
>   the modules via ccflags-y.
> 
> - test_klp_atomic_replace.c and other source files using .replace guard
>   their replace module parameter and .replace assignment with
>   #ifdef KLP_HAS_REPLACE. The #else branches are left as TODO
>   placeholders for the upcoming provides/obsoletes based tests.
> 
> - functions.sh adds detect_replace_attr(), which loads a temporary
>   livepatch and checks for the /sys/kernel/livepatch/<patch>/replace
>   attribute, setting HAS_REPLACE_ATTR accordingly.
> 
> - test-livepatch.sh and test-callbacks.sh run the tests that depend
>   on multiple livepatches coexisting or on the atomic replace
>   behavior ("multiple livepatches" and "atomic replace") only when
>   HAS_REPLACE_ATTR is set. These scenarios do not apply to the new
>   kernel, where provides=0 replaces any other livepatch by default.
> 
> The provides/obsoletes based selftests will be added later.
> 
> Assisted-by: Comagic:DeepSeek-V4-Flash
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  tools/testing/selftests/livepatch/functions.sh   | 15 +++++++++++++++
>  .../selftests/livepatch/test-callbacks.sh        |  6 ++++++
>  .../selftests/livepatch/test-livepatch.sh        |  6 ++++++
>  .../selftests/livepatch/test_modules/Makefile    | 14 ++++++++++++++
>  .../test_modules/test_klp_atomic_replace.c       | 16 ++++++++++++++++
>  .../test_modules/test_klp_callbacks_demo2.c      | 16 ++++++++++++++++
>  .../livepatch/test_modules/test_klp_state.c      |  7 +++++++
>  .../livepatch/test_modules/test_klp_state2.c     |  7 +++++++
>  8 files changed, 87 insertions(+)
> 
> diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
> index 30dc677b2f45..17810521d069 100644
> --- a/tools/testing/selftests/livepatch/functions.sh
> +++ b/tools/testing/selftests/livepatch/functions.sh
> @@ -351,6 +351,21 @@ function does_sysfs_exist() {
>  	[[ -f "$SYSFS_KLP_DIR/$mod/$attr" ]]
>  }
>  
> +# detect_replace_attr() - detect whether the running kernel still exposes
> +# the legacy "replace" sysfs attribute and set HAS_REPLACE_ATTR
> +# accordingly. The atomic replace tests are only run when the attribute
> +# is present. The provides/obsoletes based tests will be added later.
> +function detect_replace_attr() {
> +	HAS_REPLACE_ATTR=0
> +
> +	load_lp test_klp_livepatch
> +	if does_sysfs_exist test_klp_livepatch "replace"; then
> +		HAS_REPLACE_ATTR=1
> +	fi
> +	disable_lp test_klp_livepatch
> +	unload_lp test_klp_livepatch
> +}
> +
>  # check_sysfs_rights(modname, rel_path, expected_rights) - check sysfs
>  # path permissions
>  #	modname - livepatch module creating the sysfs interface
> --- a/tools/testing/selftests/livepatch/test_modules/Makefile
> +++ b/tools/testing/selftests/livepatch/test_modules/Makefile
> @@ -16,6 +16,20 @@ obj-m += test_klp_atomic_replace.o \
>  	test_klp_state3.o \
>  	test_klp_syscall.o
>  
> +# The legacy "replace" field was replaced by provides/obsoletes. When the
> +# kernel (KDIR) still supports "replace", pass KLP_HAS_REPLACE to the
> +# modules so that they can #ifdef the legacy "replace" code. Otherwise
> +# the modules are built with the provides/obsoletes based code (to be
> +# added later).
> +KLP_SRC := $(if $(wildcard $(srctree)/include/linux/livepatch.h), \
> +		 $(srctree), $(KDIR))
> +KLP_HAS_REPLACE := $(shell grep -q 'bool replace' \
> +		 $(KLP_SRC)/include/linux/livepatch.h 2>/dev/null \
> +		 && echo y)
> +ifeq ($(KLP_HAS_REPLACE),y)
> +ccflags-y += -DKLP_HAS_REPLACE
> +endif
> +
>  # Ensure that KDIR exists, otherwise skip the compilation
>  modules:
>  ifneq ("$(wildcard $(KDIR))", "")

These two ways to detect the feature are dirty hacks. It might be
acceptable in selftests. But I wonder if we could do better.

Alternative solution might be to define:

	HAVE_KLP_PROVIDES as true in kernel/livepatch/Kconfig

We could then use in the Makefile:

	ifeq ($(HAVE_KLP_PROVIDES),y)
	ccflags-y += -DHAVE_KLP_PROVIDES
	endif

And we could zgrep /proc/config.gz in the shell scripts.
For example, see kconfig_has() in
tools/testing/selftests/firmware/fw_lib.sh

Note 1: It will work only when we change the state of HAVE_KLP_PROVIDES
      in the patch when the provides/obsoletes are substituted.

Note 2: We should update the selftests before we change the behavior.
	Otherwise, we would break bisection.


> diff --git a/tools/testing/selftests/livepatch/test-callbacks.sh b/tools/testing/selftests/livepatch/test-callbacks.sh
> index 2a03deb26a12..e9b2dc6ea099 100755
> --- a/tools/testing/selftests/livepatch/test-callbacks.sh
> +++ b/tools/testing/selftests/livepatch/test-callbacks.sh
> @@ -451,6 +453,7 @@ $MOD_TARGET_BUSY: busymod_work_func exit
>  $MOD_TARGET_BUSY: ${MOD_TARGET_BUSY}_exit"
>  
>  
> +if [[ "$HAS_REPLACE_ATTR" == "1" ]]; then
>  # Test loading multiple livepatches.  This test-case is mainly for comparing
>  # with the next test-case.
>  #

Nit: Marcos made several tests conditional and he updated indentation
	after adding the if/fi.

     I could live with both approaches. It just would be nice to be
     consistent.

And I like the idea to explicitly mention that a test has been
skipped because a feature is not available.

Best Regards,
Petr
