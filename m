Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02D0247291
	for <live-patching@vger.kernel.org>; Fri,  5 Jun 2026 13:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780667991; cv=none; b=ePW5230j5Xa2aVL+HjfIbR5w+ayVXOI7eYA+Rcc9iKl7DRPM3nSTTHRZnWoEDsaQpl1UNOrz9xNtbwov/lKhoBnBfrlR0CodZzosA5mtIfW56RN/sd9QenptgW/+c6ec9kWYodu+NwY8YTYZuBDfuo5j/qxFN7i7st0GbFGAjkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780667991; c=relaxed/simple;
	bh=FvoFCIqZRxItcEHWAa+mPCmgEQlnhbsWRiHHI1hX2Hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g1WIERJq3C82XrXzt4Fv0c/wsvkVk4FEhSvnAp3R09W8uGMu/bdNoXtVbBQwWUhZ/o6A3viTLxJflq9dAmJAREF8WyNA2iVY31M8lzzwibSvPMHHKJBkFjvhgRUfcszNBNuMOUP8fgPh8VC64xTd1K70oSFQuDrs56vmsC390rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=X3Az9MGS; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="X3Az9MGS"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-490b8a97b11so21559315e9.0
        for <live-patching@vger.kernel.org>; Fri, 05 Jun 2026 06:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1780667987; x=1781272787; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zKeoGgoFqoqVN9IAaz33U76m0XnnvCdu/CrM2G6zgzQ=;
        b=X3Az9MGSAAWkjX/nMKd7Styc942oh9KFKMSkpZODmT/LSe/r2SaTOgPgO6obFKW+B/
         s+e15xsQinPbnjXm0OKGk9Q85X7HGfBH3mrBgg8h2NUxyWME/viksKuzTuNBK02nwp8+
         dwFwMJbQ2BNq1eeVP1CGkohdIrEpqJfbQI29/UHrSKQ+OSaZg/1vA6NgcWpH/Mq3X2j4
         1IXGdCXOhBWLp1R07rEy7GWGtn1XLUvKCVtqUodqwDqkE7Wh4uRKatEnSaFFYE27Qn75
         +5OWVIjunKd4PApyeBfr7hIopRs0WZkVoQaVdbutN8vI3L2E1ZMD3zJqCqgsz6683qK6
         oTpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780667987; x=1781272787;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zKeoGgoFqoqVN9IAaz33U76m0XnnvCdu/CrM2G6zgzQ=;
        b=X7DipS7UnIz4Av176g36e3lF2fNcN8OeOcpC8Llu66+KLHrUi7h0eo9NNA2e0eknT+
         xoYlgzPt6FBrOJ0SO0u2MqXo+3+3oRp+eCZ+KPn38UoNuV1HsxGLl2ZHl4rXROP3kDtl
         WAprSQ/Q1bzzYqPZa5H1DKU5Ce+V0MTCeRttEMEMUDNfVkdt3kbIwLFBCbqI5tyuSl0Y
         nhM/DYDoTBSJ6Swz+s+6uXDFKeCMm9WGCZrUpNHlAnMeQAfhLcE+0wfPDtlZbo6EahW9
         /QEpxn5SBTANzMidazTSS3vDCIP6szrDtLOqzxrbxcCibhU0CUs3es2XVEmppjfbK5qi
         axzw==
X-Forwarded-Encrypted: i=1; AFNElJ+v5o8PL0lgi4p+40wLOuNXcBAMFDtmbLjDtPgJCSSvRKiUJgxWbET3B5hNJ0wO9A8f2QmgTJLFzyYhiSzz@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt9dEzA3OP+eBrVwthENU2xWG4TR/s05S3AcxTefmhs4rdfzCZ
	Uv9fmbn8u6eRqpDoNGNjFks0hCed1cdu3eMZRS5IjQE9wd5FD9bC4z0mEv/7QPZhAdo=
X-Gm-Gg: Acq92OHU+9y3HcqWcSZ9qc52B4QBOGm+k0qGI6+MgJ9wmRHl3TL0I5/RBAobEH9EA6z
	N9Z8lIsF1rmylp5EptOLByAWfADuamcLcDlyFyCAGKQP3nCPb9HFKzYqSJX0qqK3yDIu1O3t2A/
	LUclxL9gmLKTg47KTl+ddUC8yaxwEeHF3a53tBwA/f+PD5uObJpD1GAigMcDDI0d14Yuoj5eoYj
	JDtCRrM/3MnKMORZ67ciVQ7kDaB3zYTrs7NIFahbraa5Q/jIY3btFzrBAvf8cc8P3lk2NL4Y7mE
	sjiFvmPAj4928i9QpAfG4AYp48R9BsszUi0qjVzpXSz9Kfap2p2q4Ma/m84EEjw3EPYlHcNqADW
	muMEd833i9BVS6RFYb379acpzzgfJnbFnsfCpEP2ACu/XngPpo/7rVPLKBAuOtU+aS3NsIbiWc+
	tNlCtcSKM5DpiVP/grz5znbFHQ6DWbV1IrWnh4
X-Received: by 2002:a05:600c:3e0c:b0:490:3fdd:d353 with SMTP id 5b1f17b1804b1-490c259e7f2mr62846325e9.8.1780667987383;
        Fri, 05 Jun 2026 06:59:47 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc39e024sm206514795e9.4.2026.06.05.06.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 06:59:46 -0700 (PDT)
Date: Fri, 5 Jun 2026 15:59:44 +0200
From: Petr Mladek <pmladek@suse.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Shuah Khan <shuah@kernel.org>, live-patching@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	marcos@mpdesouza.com
Subject: Re: [PATCH 2/4] selftests: livepatch: Remove leftover modules when a
 testcase fails
Message-ID: <aiLWUHAGtF8qaE_R@pathway.suse.cz>
References: <20260524-livepatch-unload-on-fail-v1-0-7465de7f741d@suse.com>
 <20260524-livepatch-unload-on-fail-v1-2-7465de7f741d@suse.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260524-livepatch-unload-on-fail-v1-2-7465de7f741d@suse.com>

On Sun 2026-05-24 20:50:31, Marcos Paulo de Souza wrote:
> The current livepatch selftest scripts load modules, run tests and
> unloads them. If the test fails, it can leave loaded modules behind, and
> in some cases making it impossible to run the next tests.
> 
> This approach tracks down the loaded modules, and in case of a test
> failure, or premature exit of the script, the cleanup function will
> be called by the trap installed on setup_config function.
> 
> The cleanup function iterates over the list of leftover loaded modules,
> unloading them. The function also checks if the given module is a
> livepatch, properly disabling it before unloading.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
>  tools/testing/selftests/livepatch/functions.sh | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
> index 3ec0b7962fc5..25f137003865 100644
> --- a/tools/testing/selftests/livepatch/functions.sh
> +++ b/tools/testing/selftests/livepatch/functions.sh
> @@ -15,6 +15,8 @@ if [[ -e /sys/kernel/tracing/trace ]]; then
>  else
>  	SYSFS_TRACING_DIR="$SYSFS_DEBUG_DIR/tracing"
>  fi
> +# List of loaded modules used in tests
> +TEST_MODS=()
>  
>  # Kselftest framework requirement - SKIP code is 4
>  ksft_skip=4
> @@ -125,6 +127,14 @@ function set_ftrace_enabled() {
>  }
>  
>  function cleanup() {
> +	# Remove leftover modules in reverse order to handle dependencies
> +	for mod_item in "${TEST_MODS[@]}"; do

It would make sense to check here that the module is loaded.
I would add a helper function is_mod_loaded which
would check whether /sys/module/$mod exists.


> +		if is_livepatch_mod "$mod_item"; then

It might make sense to 1st check here whether the livepatch is
enabled. Again, I would add a helper function for this.

> +			disable_lp "$mod_item"
> +		fi
> +		_remove_mod "$mod_item"
> +	done

I would put this into a helper function, for example,
called remove_test_mods().

> +
>  	pop_config
>  }
>  
> @@ -181,6 +191,9 @@ function __load_mod() {
>  	# Wait for module in sysfs ...
>  	loop_until '[[ -e "/sys/module/$mod" ]]' ||
>  		die "failed to load module $mod"
> +
> +	# Store the module in the modules list
> +	TEST_MODS+=("$mod")

I would put this into a helper function, for example,
called track_test_mod().

>  }
>  
>  
> @@ -262,12 +275,20 @@ function _remove_mod() {
>  		die "failed to unload module $mod (/sys/module)"
>  }
>  
> -# unload_mod(modname) - unload a kernel module
> +# unload_mod(modname) - unload a kernel module and remove it from TEST_MODS
>  #	modname - module name to unload
>  function unload_mod() {
>  	local mod="$1"
>  
>  	_remove_mod "$mod"
> +
> +	# Remove from TEST_MODS array
> +	for i in "${!TEST_MODS[@]}"; do
> +		if [[ "${TEST_MODS[$i]}" == "$mod" ]]; then
> +			unset 'TEST_MODS[$i]'
> +			break
> +		fi
> +	done

And this into a helper called, for example, untrack_test_mod().

>  }
>  
>  # unload_lp(modname) - unload a kernel module with a livepatch

Best Regards,
Petr
