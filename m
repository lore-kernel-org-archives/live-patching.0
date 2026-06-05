Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB19B372057
	for <live-patching@vger.kernel.org>; Fri,  5 Jun 2026 14:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780668918; cv=none; b=JdwH3XgyeNRnhfvkQktfn2mG99477/P2dHS8f1DQj9rSgCoATqWP5aQqSnaKUjLrIKbcx6eWRsJTgAk049OQAQOSAvBeDDD1FtsbVWK5aAXZg9TxoJxcQHGSOXWvZPv8OOxsA/BAo4EWZGQf7IKAW5e2SZMeGbqdYgQYaAjgdq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780668918; c=relaxed/simple;
	bh=ar7PNNwubFmz/KFNVROu+Mptdoo1p3LJaovsqO4uKIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D6uX03qzJfIZzsBXk9o6eRpDHdV6R21N8nKp1COraais36sqIOYBicMwnUI/Ym/mkJaZzqdEgrMhqFo2qY6W0GOiuCFIzzniBSACW0xfm4Ao7JQng1Whgt6Gn3spacx6woA27bsNIfR+ecqE90d11YoMueBuTiVlxF3pWH+oroc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ObFdUo8H; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ObFdUo8H"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-45ef189aa1cso1414025f8f.0
        for <live-patching@vger.kernel.org>; Fri, 05 Jun 2026 07:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1780668912; x=1781273712; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k14EL7aYp7IEaeb25debKuZ2KvULiegeh2pxlfcnkdQ=;
        b=ObFdUo8H5NyEpcNT/UDQugmzuiQFtvLTADV6X2GmhUUj7oG307GSPePwmdqffW+ly0
         qnvx18mvY5WmEJADv6mjD/6hLuNDcz2ZC5ke5EYW3xclfKUdVmXa959KSwepRxTMB4pE
         tRM76jTgmHcIS/cpuQBpVLEhIWqkoVihFApqWSHsZaIl/iDm5AGeIAY1nQddmSp7ccny
         vukbWW7D9XhNm3R+Msu52RzX3f9dyqVU02btey9JggYMUiSYMFWe/aaoO3FOW/1UbwoF
         M72SzY+aKy/d3UNWaJ3kxoSaL+bcp2Ns5FO73QTRkLrA3/MIL4zL0AqkmZojZCXjVzn2
         x9kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780668912; x=1781273712;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k14EL7aYp7IEaeb25debKuZ2KvULiegeh2pxlfcnkdQ=;
        b=CiiLAFsiazY1c/29Oq9O3oQCiZXQmwJLsnh+2mmlo+t5z1+AhxEgB5bnHFsszmhXxW
         0rBu+VzdUdyKLnOAqsp1mfurDkifvMJn2gCWuj2zxsVGcbHWz5XWD7jZBr0DCPZpf+j6
         T0Kvd8Lb69y+7twQeftflHSWf6XOiNym+yM0Q4MTtPRkksqSMn+IVRBpEc2MU5HYtfgU
         Fz55fPNAUBqdwcHtockebXsa+71hKn4cTV5T1tmZP6Idu/XLwc47KeO9YvMhROw9w6rY
         MP3tzOzV3OsBb4gy3jFn8cVc/+cbPoHqurzPfU/2L6DtnS1PwYkFnmlwi0n5/U1ZOEY9
         BkFg==
X-Forwarded-Encrypted: i=1; AFNElJ9FB4JTrQs7r7RhpcOAHGFunn/FZ5aQGcPEGl/lhAwEINE11/McNwhuYLh0zjGf8NFWt8fBGXKXBang692W@vger.kernel.org
X-Gm-Message-State: AOJu0YzES8Wtl8sVnAIGlzr9IaZvF3H7+yqwpCnWxUrn4fHub3Ce6SeK
	GHhY350MKylFBkA4kA6urUDNaDDw65vocKeHIO1b6q5QIcaAv1KFoVeZnIQRCkASHtU=
X-Gm-Gg: Acq92OFAeGETRJA2pQRLEK97942oUWSozLFNcu6b+jrue9Gd7SyP1FS8OUL3vhfZusl
	MgjN6zmQhrhsNBKZKufZCdELtgAvbUW3jcT6lMykmIPEyZ1TuOsCnsRkvulwET1dfYgf/o0xvyd
	w6muWjuDibz87H/tFvs3Zvhpj869FuXFVxlq7Hz++B+70if/oIKvrwm6d+FNvS9hxzZXDt7RfAm
	zcrCHFRUO+GNPm9/ad2hUwYNg4zF7m2c4l9RwhrE3Br2t0LtNMLcMlEQ8J7uJhF6V9NK4glfDeR
	L+vipFalJJUya88cV8Oaaj+LDjEwWGGoeVRsqCkG2shNJWL6XIVBy0xbHAGJ9a31pr3U+NCMBe7
	/r87J5age1WL90jLMQFAlAlqqUsrzZ4CN9VbzGYtQvZYJWQo0F9pLKtLsHY6g44rqSNHYj+5TcF
	vNz9zwQEjAM/ZPVf22ccq228nLtTvNr5TIs4Wk
X-Received: by 2002:a5d:44c8:0:b0:45d:41e0:467b with SMTP id ffacd0b85a97d-460304edd03mr4778392f8f.3.1780668911802;
        Fri, 05 Jun 2026 07:15:11 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f368e9fsm25521409f8f.37.2026.06.05.07.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 07:15:11 -0700 (PDT)
Date: Fri, 5 Jun 2026 16:15:08 +0200
From: Petr Mladek <pmladek@suse.com>
To: sashiko-reviews@lists.linux.dev
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
	Shuah Khan <shuah@kernel.org>,
	Marcos Paulo de Souza <mpdesouza@suse.com>,
	linux-kselftest@vger.kernel.org, marcos@mpdesouza.com,
	live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] selftests: livepatch: Remove leftover modules when a
 testcase fails
Message-ID: <aiLZ7BjO6mu7eydP@pathway.suse.cz>
References: <20260524-livepatch-unload-on-fail-v1-2-7465de7f741d@suse.com>
 <20260525000622.3D4551F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525000622.3D4551F000E9@smtp.kernel.org>

On Mon 2026-05-25 00:06:21, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] The cleanup loop iterates over the TEST_MODS array in forward order, violating dependency requirements and causing rmmod to fail.
> - [Medium] Functions invoked during cleanup call die() on failure, prematurely aborting the EXIT trap and skipping pop_config().
> --
> 
> commit aafb48b2a54fe2209742378f31fb96583598557a
> Author: Marcos Paulo de Souza <mpdesouza@suse.com>
> 
> selftests: livepatch: Remove leftover modules when a testcase fails
> 
> This commit introduces a cleanup mechanism for livepatch selftests that
> tracks loaded modules and attempts to remove them if a test fails or exits
> prematurely. It uses a TEST_MODS array to keep track of dependencies and
> unloads the remaining modules during an EXIT trap.
> 
> > diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
> > index 3ec0b7962fc5c..25f1370038654 100644
> > --- a/tools/testing/selftests/livepatch/functions.sh
> > +++ b/tools/testing/selftests/livepatch/functions.sh
> [ ... ]
> > @@ -125,6 +127,14 @@ function set_ftrace_enabled() {
> >  }
> >  
> >  function cleanup() {
> > +	# Remove leftover modules in reverse order to handle dependencies
> > +	for mod_item in "${TEST_MODS[@]}"; do
> 
> [Severity: Medium]
> Does this loop actually iterate in reverse order?
> 
> The comment states the modules will be removed in reverse order to handle
> dependencies, but ${TEST_MODS[@]} expands the array in ascending index
> order.
> 
> Because dependent modules (like livepatches) are loaded after their base
> modules, iterating in forward order will attempt to unload the base modules
> first. This would likely cause rmmod to fail with a module in use error.

The ordering should not be important. It does not matter whether the
livepatch or livepatched module is removed first. And only one
livepatch is enabled when atomic replace is used.

I believe that the ordering does not matter even when more livepatches
are enabled and the atomic replace is not used. Anyway, there is
an idea to make the no-replace livepatches trully independent,
see
https://lore.kernel.org/r/20260529034542.68766-1-laoar.shao@gmail.com

I would personally ignore the ordering here.

Best Regards,
Petr
