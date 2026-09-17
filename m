Received: from mail-ed2-f19.google.com (mail-ed2-f19.google.com [74.125.228.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A095A514B
	for <live-patching@vger.kernel.org>; Thu, 17 Sep 2026 14:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789657111; cv=none; b=S9tNU0ZhTsX9cw87y3UMGz1GCkYt0h5j74HhcYr3SgpoUbL8+EcnMwfsEU9waBtKZfiBTa4eU4hbTdgA4x4ApvqJJUi80LVt6SgwCiiPO+aYI9JLPbK4I5N38vJewd3r9wk6gtmeINNDz0MwnbScgF/DQxJPkCLKjl07AQeXjOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789657111; c=relaxed/simple;
	bh=BNu7UFYzbciMQngWNhdXe84afMXc5n9xBvAZ7otGnEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gurOBuHfeQw0SVoTrAPXLbiENZkM1pAGiZsAam75+nc+hfQVyWtM+Sj20L3r7Ii8GClcdDwpXF+kgZrGvqQDW0/E2eioziaDHIZJm3P0MhmJnLXxxNZf5CHojBnuzXOtb7BXx/pFqkv9lsbgGU/oiPP/upvJLHaMRaIgsS2ndhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cF73D2rO; arc=none smtp.client-ip=74.125.228.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cF73D2rO"
Received: by mail-ed2-f19.google.com with SMTP id 4fb4d7f45d1cf-6a60591ae52so1741948a12.0
        for <live-patching@vger.kernel.org>; Thu, 17 Sep 2026 07:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1789657085; x=1790261885; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8geJb//unxMG5/ocZH8skdaBQsZ6P2d8sWowZAb/n3M=;
        b=cF73D2rOi5i34tkeka6aSz9cmZ7LPJIO3qKG9N/hnmQqcducWbXZwftdJmQOqkNTPE
         jIkUjP0yYtFaNjeKS4voiC9qCH+YDtwg+v4+0Ffke3+v596rudYlZrhwbRrF4OgKBtyP
         ATzrLYMj2/btDpIxJylysj5os82ztyepvdN+SJDP/l7F5tIKqIUyjQZZB3YgJlisYBT3
         ksnGRPEf4hlT/xH/jbDCdJHhSrkbAGJT7bPi96F/qUBkLtvDY36421TJz3nyCCsI9Hvv
         b3EbtBq3d0FZLqEdQDnx6QL2Z+8zfsMBIUrZG+GyI2tg+kLvqBVzPdIPeDO9lnkQchTh
         FZOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789657085; x=1790261885;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8geJb//unxMG5/ocZH8skdaBQsZ6P2d8sWowZAb/n3M=;
        b=YR+7pZn4KcadnYqkGyXAAwBNL0SH46OF92ACpxS6Yvx5/zWXnxIjegkslNCvgL+K1Q
         PuYBYqf4E41sjc5FEoK2QJWeE2mno8HUez25L0JT8GyztMgxBw1cNbLO0S+gk80Niy22
         cWzIM1NqWXtvWnSScjvKi5IYGzt1HKtdcboMk+s1vKho5MdFQuBs7+kaAKi5y9M9pO8p
         exVpAXvnO4h0ItYGz0Q9LsXOxApLCvOHFlRYltZt42Bjs/XOnkgfgVlL/+38RzwpANGW
         o4pmlwFeGkeJF47E477+qZHj/Txmx1VVhzX9x7Ou9wRePBDa5xh46EKxkc1vx2j+hW9l
         hR1g==
X-Forwarded-Encrypted: i=1; AKwUvByFsfDMh1y9PzEXnCWb/Kg8QWIkY9/H3iQzRPIZXOcpBq7iN7ZzqpVO7q8laT79tvNugb2FnUYzhzvqnHd5@vger.kernel.org
X-Gm-Message-State: AFuF++nVgQihd29RjSSpz/sZKjBPeKQQO4QVhBsO82yN2wnaVWgiO0jr
	z+qUxzVuHfSLAL3xob8egWKaj2P9hbpYbaYkq9vpoGPp7JzQyvLh9sHubuPtYVH15K0md8nXk1w
	odCfmeGg=
X-Gm-Gg: AYBFou04Hx1baYHJiSW1l3DAsg1m/S5cIO77JpZvwm3/nuOJR7L2r7VX429bXsXwiTE
	/g+JDBEyNLmWq/x9947WsdL/I1kRiTsGQ1G2GM8tPllBLZfS/HkPcxV7GKNeqS1pg9eMdZIu/DE
	8ijfkHtj5i9pXKmif3tzINck+J/e5v9QxQH4a6Jen8iEMOwGF+bq8il6HWG1kC08kGLR9w11mk2
	QoBUqQhXtEYoudlNsHKXs2+KptopOwtMjq1GbTuUcpdKtGpIYy/0DKaJDzPy5+tOSNYcz6MaYUd
	N8JJH3vD9x9DRj2Y0aXDRUXd2K44QHL5PBYR+yC4r9lhdakFRt9aZFjiMyZl+jduRoyzWGcCgPN
	ue0zqQF9Q7ViLI8Q9qtz9TKyUknTUae2FKA06SYoG+okeeBue2heSanaAiBJkGng+cozwr8Z3Kc
	PuQOCNaPp42TnsCgNHu8jYR9cyLCmctq4DYsFtTHXkc+VqFn0YARgW+UokAr1Vw6K3UL/TE2Zh
X-Received: by 2002:a05:6402:a0cf:b0:6a9:cd42:eeae with SMTP id 4fb4d7f45d1cf-6aa224192damr9562008a12.15.1789657084575;
        Thu, 17 Sep 2026 07:58:04 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aa1d228edfsm3954435a12.10.2026.09.17.07.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 07:58:04 -0700 (PDT)
Date: Thu, 17 Sep 2026 16:58:02 +0200
From: Petr Mladek <pmladek@suse.com>
To: Eva Kurchatova <eva.kurchatova@virtuozzo.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Marcos Paulo de Souza <mpdesouza@suse.com>,
	linux-kernel@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests: livepatch: do not require a kernel build tree
 to run
Message-ID: <aqv_-n4pNKH1CoZ4@pathway.suse.cz>
References: <20260906204932.2343013-1-eva.kurchatova@virtuozzo.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260906204932.2343013-1-eva.kurchatova@virtuozzo.com>

On Sun 2026-09-06 23:49:28, Eva Kurchatova wrote:
> setup_config() calls has_kdir(), which skips every livepatch test when
> /lib/modules/$(uname -r)/build is missing.

Yes.

> The tests do not compile
> anything though,

How do you run the tests please? I personally do

   $> cd <kernel_source>/tools/tests/selftests/livepatch
   $> make run_test

And it does compile the test modules when they are not available
or when they are older than the timestamps of the related source
files.

I tried

   make TARGETS="livepatch" kselftest

and it does the same.

> they insmod the pre-built modules from test_modules/,
> so the check tests a proxy rather than the thing it cares about.

What do you mean by proxy, please?
What is the thing that is cares about, please?

> That proxy holds only for a source tree or a machine with kernel-devel
> installed. A packaged testsuite ships the modules pre-built and runs on
> machines with no kernel build tree at all, and there every single test
> reports "ok ... # SKIP". A harness that looks for "not ok" then reports
> the suite as passed, so the whole suite silently tests nothing.

Could you please paste the real output here?

I agree that the string "ok ... # SKIP" is weird. It should
either be "ok" or "skipped". But I do not see any related
change in this patch. It keeps:

		exit $ksft_skip

So, the behavior on failure is likely the same. It would be nice
to fix it but I guess that this is a generic problem in
the selftests framework.

> Test for the modules instead. Missing modules still skip rather than
> fail, which is what the KDIR check was there for, and the tests now run
> wherever the modules are.

This sounds strange as well. I guess that it is a problem with
translation. I am not a native speaker but the following would
make more sense to me:

<proposal>
Test for the modules instead. The tests will still be skipped when
the modules are missing. But the tests will run when pre-built
modules are there.
</proposal>

> --- a/tools/testing/selftests/livepatch/functions.sh
> +++ b/tools/testing/selftests/livepatch/functions.sh
> @@ -44,14 +44,12 @@ function is_root() {
>  	fi
>  }
>  
> -# Check if we can compile the modules before loading them
> -function has_kdir() {
> -	if [ -z "$KDIR" ]; then
> -		KDIR="/lib/modules/$(uname -r)/build"
> -	fi
> +# Check that the test modules are there before loading them
> +function has_test_modules() {
> +	local mods=(test_modules/*.ko)
>  
> -	if [ ! -d "$KDIR" ]; then
> -		echo "skip all tests: KDIR ($KDIR) not available to compile modules."
> +	if [ ! -e "${mods[0]}" ]; then
> +		echo "skip all tests: test modules are not built, run make first" >&2

IMHO, "make" won't help when "$KDIR" is missing. I would prefer to keep
the KDIR test as well. I mean something like:

	if [ ! -e "${mods[0]}" ] && [ ! -d "$KDIR" ]; then
		echo "skip all tests: KDIR ($KDIR) not available to compile modules."

>  		exit $ksft_skip
>  	fi
>  }

Best Regards,
Petr

PS: I am sorry for the late reply. We are overloaded. AI helps people
    to write patches. But it is not good enough to help with review.

    Sashiko AI was happy with this patch, see
    https://sashiko.dev/#/patchset/20260906204932.2343013-1-eva.kurchatova%40virtuozzo.com

    But I see it differently.
