Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681C439902B
	for <live-patching@vger.kernel.org>; Fri,  5 Jun 2026 14:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780670219; cv=none; b=cyI+HGc1NNuFNeVeamzTAi+P8oxa2rQH4TPEl+3/DzMPxCQg6h+H3S/9a9ZXa3tfMH029+bj1W89YtBq4dXKU5afiNIMLq1qljRcgAKiINvSvXxFrak/N6oaS2EMw/EvozYF1pXUb3UjihM92+2HzjHE4HhJIs/bDGLiD/m8y8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780670219; c=relaxed/simple;
	bh=2/okv5R7nw3nettmT+HkbGVvZOenFtZVq77Gbvi5thY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DQMg1sXZh7ierHdFIohrmK7FZpCdXwUTYeKrU1upsOOaKTr3RSpYK/b5uzownVan2kUSVhdZ4iD5GiI2cncZIEDuwV2BKgFVPYaX6cdsF2bZRcqOpB3fFbTMHseQCqc8/OT0hWKIDmYUpiOmEAA8dU0Nkin6/ygTqkPjtvz1bvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=L+Dxbpx1; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="L+Dxbpx1"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4908b92904fso23113765e9.0
        for <live-patching@vger.kernel.org>; Fri, 05 Jun 2026 07:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1780670210; x=1781275010; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jKrctiRdzG2v5+tRw+/itTjUFXwqDjxnSAqBHxkkoBk=;
        b=L+Dxbpx1C/7UkK5fDhN+5jQ4QNrxDKtZNbnbb+Ne2H//MvibxOqOs56WXzy180OLic
         gTg1pB0lA7qYohmjGREO1lU2RLV30jbmKTe8wMhs3bZMDjI7uVgnN+CF6oSnQNCcKkrC
         4NWNRhIcEYigromtdSXJ3gHuzghwJ3aGRWWtqdMbSFSx8BbboeybQmm/c0c1RL7UhWLI
         tt3p5yQ7h/yqAy2Qcr94Taj1zvhBQ+DmRdhK6h6gskBe5VFzUITcgwWfQsEeSsu5o4Om
         g1ocRMkAonnnZjIKZHs/ZTBLmM2GtSIqfOZEI/zZ1oqXbxaNAcHXZsM1uhz7Rkuaru+3
         3ahw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780670210; x=1781275010;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jKrctiRdzG2v5+tRw+/itTjUFXwqDjxnSAqBHxkkoBk=;
        b=h/0f9K2cNuK5DeLkaEZXfm+vpdG4Mw6UJsQl3tstU8DkRXjb3eiULC9BWxYhSFkE0l
         W0kj2QdM1fSOxO7+Vt0fd0p1NXzWy6635T5XAroZYYBrYBajJMBjka3utalLhHGcU7gK
         NHgyFFj562mgwDhsugX/m4LJhPnhKU/YvUmFFY4C5C4ljXmW4fEZ6NQfQ/InCYP4gIUk
         6eYs74kF4cU8FJX3mUt7qeftzYMHBj5+69/hEQjxgFENNj4zl/StGQItiFGHoYusbKod
         QlMKeJfKjWqfkedsS5UkJtSGpgRku6Q6+YKpo6DMClBxinifbdVPG6WUY68Jwe40yi5i
         bAGQ==
X-Forwarded-Encrypted: i=1; AFNElJ/MqkHkILtZz3iD+QaGqh2Ts+5bCAhNMiS++alyRBLDHbyV7DbVi4Ui78fIcY2dTBGCOhOtBllKcB02b2ie@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqmy84ojKlt9X2AzeOnDLXyBwY+cEXsWt/SDWDcxhPFA25o4a/
	bXW6I7aspl5IzSxn8e04YkaXh9rJTMDF6PdIqDJd6mSXo9FrHEquLJvufoh3L6ncFto=
X-Gm-Gg: Acq92OEQPxLe0jqMpa8BUGLwVa4ljxQZ4VnLnOyKxJlVmoo0T8VuGjRYOHN+3Gkie5a
	Gkd3Wj/M0PMq3hpzvuDoD9TbZ9A+O9yoVJSBxCRQ3y1B7YMQJT2xaaLZBKdOzpTDCm0prqR3Vzq
	PGBCx6+CRKPQxmSxmvxx12NRgdOdK6zfcED0cQsZfFCekieHSWxUUETNuNjse1LDio668w2LlcI
	ESvhJgavG9XcSgkrq507PsnBcxGuuqO0vrZQaah7Yu49z6SiPTTkjlCnxUhROwuJsMJpMIUxHrg
	b0PVyFHO1K83/bnbw3YG3Ur6u2IOk5D0I9FJgMlTosNLQCIvIBHGswr/7gSLWQx2swjABmcAmHj
	dPmG+fmoZPTwG/DEmRR9va/2YXqTlRMftRzHCOxfiPEfnSZaR5u6v8JWmarIk4WzlnLHE09FCZm
	3PM+fImZQjC5+XD4cI/WlMoWNR7dRB7lKrN2MvSGW+F8XION4=
X-Received: by 2002:a05:600c:524f:b0:48a:9428:5522 with SMTP id 5b1f17b1804b1-490c2622ad9mr69963445e9.16.1780670209676;
        Fri, 05 Jun 2026 07:36:49 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3fcf5bsm184239235e9.9.2026.06.05.07.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 07:36:49 -0700 (PDT)
Date: Fri, 5 Jun 2026 16:36:47 +0200
From: Petr Mladek <pmladek@suse.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Shuah Khan <shuah@kernel.org>, live-patching@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	marcos@mpdesouza.com
Subject: Re: [PATCH 3/4] selftests: livepatch: Adapt mod_target module to
 pass on 4.12 kernels
Message-ID: <aiLe_3T3rHd2-Ryb@pathway.suse.cz>
References: <20260524-livepatch-unload-on-fail-v1-0-7465de7f741d@suse.com>
 <20260524-livepatch-unload-on-fail-v1-3-7465de7f741d@suse.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260524-livepatch-unload-on-fail-v1-3-7465de7f741d@suse.com>

On Sun 2026-05-24 20:50:32, Marcos Paulo de Souza wrote:
> Use the stable module_param_cb API instead of proc_fs for exposing module
> state. This approach is compatible with kernel 4.12 and later. The end
> result is the same: the module has a function that shows a string, which
> is later livepatched to show a different string. The only difference is
> that the file being checked is now a module parameter instead of a
> procfs entry.
> 
> --- a/tools/testing/selftests/livepatch/test-livepatch.sh
> +++ b/tools/testing/selftests/livepatch/test-livepatch.sh
> @@ -198,26 +198,25 @@ livepatch: '$MOD_REPLACE': unpatching complete
>  % rmmod $MOD_REPLACE"
>  
>  
> -# - load a target module that provides /proc/test_klp_mod_target with
> -#   original output
> -# - load a livepatch that patches the target module's show function
> -# - verify the proc entry returns livepatched output
> +# - load a target module with module_param_cb get data with original output
> +# - load a livepatch that patches the target module's get function
> +# - verify the parameter get function returns the livepatched output
>  # - disable and unload the livepatch
> -# - verify the proc entry returns original output again
> +# - verify the parameter get function returns the original output again
>  # - unload the target module
>  
>  start_test "module function patching"
>  
>  load_mod $MOD_TARGET
>  
> -if [[ "$(cat /proc/$MOD_TARGET)" != "$MOD_TARGET: original output" ]] ; then
> +if [[ "$(cat $SYSFS_MODULE_DIR/$MOD_TARGET/parameters/klp_mod_arg)" != "$MOD_TARGET: original output" ]] ; then

I would personally call the parameter "test" or something simple.

A better descriptive name was needed in the top-level /proc directory
to prevent conflicts. But the module-specific parameter is
checked module-specific directory...

>  	echo -e "FAIL\n\n"
>  	die "livepatch kselftest(s) failed"
>  fi
>  
> --- a/tools/testing/selftests/livepatch/test_modules/test_klp_mod_patch.c
> +++ b/tools/testing/selftests/livepatch/test_modules/test_klp_mod_patch.c
> @@ -8,17 +8,16 @@
>  #include <linux/livepatch.h>
>  #include <linux/seq_file.h>
>  
> -static int livepatch_mod_target_show(struct seq_file *m, void *v)
> +static int livepatch_mod_target_get(char *buffer, const struct kernel_param *kp)
>  {
> -	seq_printf(m, "%s: %s\n", THIS_MODULE->name,
> -		   "this has been live patched");
> -	return 0;
> +	return sprintf(buffer, "%s: %s\n", THIS_MODULE->name,
> +		       "this has been live patched");

Please, use sysfs_emit() instead of sprintf(). It is a specifically
designed API for sysfs output. It prevents a potential buffer overflow.

It is less important here. But we should show good examples...

>  }
>  
>  static struct klp_func funcs[] = {
>  	{
> -		.old_name = "test_klp_mod_target_show",
> -		.new_func = livepatch_mod_target_show,
> +		.old_name = "test_klp_mod_target_get",
> +		.new_func = livepatch_mod_target_get,
>  	},
>  	{},
>  };

Otherwise the change looks good to me.

Best Regards,
Petr
