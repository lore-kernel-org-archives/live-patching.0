Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9E33446CA
	for <live-patching@vger.kernel.org>; Fri,  5 Jun 2026 14:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780670389; cv=none; b=jWkne6nhMDarepQMYVz+ghkAMr+GOcCCfgkp0Iy9U9VsOz6VaBtaMgeqyPXnWFZ5wwzN2iwSD7aRzTraFR+dTCZzaQ76JMz2nafmxoAXuOg9BrL/aObx+8O/8q+bY6i/BMCp9kgdxj3EORol4MDJnX3Ek26dtTaBx07M+1qsJxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780670389; c=relaxed/simple;
	bh=CM1vQsdGnWWlTXI4I4TAccxaKDUx7kLliDXk79XSviE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SC2sonQ/ZbhNylL8TK/MtMmPzNDjxGtnRYhat8X7eL8KuEe2qeXPD0mGuLF3AyzM87f5bRfCG5BC0NtClSOwm47e8J2KvzcHp332hb3sAMf2w7KghRcA94M8/j9IEsZ8l0w6oCEkSFliV5sgp8Tq6ghQwtnzx4Y1yVDtbN0hu7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XLbtp4Sj; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XLbtp4Sj"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-490b915ded5so16383665e9.3
        for <live-patching@vger.kernel.org>; Fri, 05 Jun 2026 07:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1780670386; x=1781275186; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pUIZL9i8oUophSbYRoza7KammzJbwhT6WTOvTfjAekM=;
        b=XLbtp4SjwpRkLWFeqglkaSLvhQetXrRPAw1K8NRs86cRsRIhHAoiqBIWX+kYi0H98p
         4gwM2DC2WZgNvA8sM953AHtEBHYiLM3/f/u/UEv7dhIzUWSYKTJy4RU6w8OYEdwlBny1
         39m19wWK1UpABn9goDx3jNvwk4D6PlQNkfNNvDADDL4yqtkEqffLCXcx4x7VpQmyAeU1
         6YbjOUd398vn/D/MqCIvujRfmV36vklqsCFNrJXb4i60Vi2P5bgn8nnAbtv6YTCzr+RO
         OuhCxn9MiSDu7hhT/Bcz1gaditECD/wvUtsPFx69pQktmSWbkCOSeiWTlZRN1ebaUmz/
         /NmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780670386; x=1781275186;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pUIZL9i8oUophSbYRoza7KammzJbwhT6WTOvTfjAekM=;
        b=UzGo6htz4fPPt9/FOE47J9P+iumnNAkxiWLXUlVfreA2UJRwkt5iRDbeg5tvlNV2/N
         c3iDVjyXOFpOWV1Fn8RsyiuB6AlAyiam/uP3huv/oKZhMn+tMi25jklQsq70YuFZVonO
         f6SRR0VLLCXGrfs4I7HIPqes/pvV5UjzdbK2lU47tsT69NJWJr0gZsxh3zE6WUOsemGx
         G1BO0Sz+dgqAg481Tod2nlZQPFqoa4kFrAtmL6pDXGUOg2AWEu4lc1lCU8T+q2RYxRYU
         3D2yCVgwuncTLix+o/toCrZD8HiWw0YYtNkaW7zVvt0Oz3hsOy5eKKatHb/38pNMe8qp
         czvQ==
X-Forwarded-Encrypted: i=1; AFNElJ++gZYGvX3AKkUpvsWWElrixOGVljLezaMfFhzuPRsZCmqIBdoFCeA9toGq59tpqOc8tynJzcaYuhQCAKrs@vger.kernel.org
X-Gm-Message-State: AOJu0YxNM/qZ/6vvOu9VjiQcA2WK09Fi6VE9VSu7kXtjkTmhBEoUyhBO
	wzQ0fbgALhTg50bZRkw0UY4/J0t1nG2GeztfVK8EBDtlh8f/dsb8SAya/FcYSHviMjw=
X-Gm-Gg: Acq92OHuhWHrdQSbY/+q5onEYfpP+bM4Qb0sDa4fELpYMAGzwgpwKcUaDOsIysjbBIh
	5KNFXMY9fvslRZOtx4aJtYav4JfYQMEkicOtGiQYOx/M4Cp9vMJm02fFQO5eVTGBAtZXlmYvmzw
	Y8409gL95sy9j9cZuwALzgCciYbWWzjKs5AaMl9RDKq7w/y5aqEwFuWGnje5IE5IZTixge1iL/H
	NPQ52Vpx/tagV7DmuImIFkB/2MjvGeDLB+7bgrz0MDQ2N5tqqG/Yrt4TWC3vxa988jERAO1fRa4
	74Y5K1E98umnUSDZkL1ZQTDzz0GvxWLazQvoGwrobzObog4wobE2b7oKsQM+/aU8pJm+cg5OKw/
	nSYotjSs1U3uEAI+FgHBsLQiH9xsgZjlQqsUelQ0S+eS9a/zJZXmf7nOPLsEdL4Pdl2a9lsAuim
	ICS2ntISDFMd3YtKRlaCiLfYcOYv5lMk4lcln1ZgvD30j+wSg=
X-Received: by 2002:a05:600d:6444:20b0:490:5466:8591 with SMTP id 5b1f17b1804b1-490c26e1acbmr46976175e9.12.1780670386590;
        Fri, 05 Jun 2026 07:39:46 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3c15cesm168167005e9.5.2026.06.05.07.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 07:39:46 -0700 (PDT)
Date: Fri, 5 Jun 2026 16:39:44 +0200
From: Petr Mladek <pmladek@suse.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: sashiko-reviews@lists.linux.dev, Miroslav Benes <mbenes@suse.cz>,
	Shuah Khan <shuah@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Jiri Kosina <jikos@kernel.org>, live-patching@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] selftests: livepatch: Adapt mod_target module to
 pass on 4.12 kernels
Message-ID: <aiLfsDBUTgAu4x3s@pathway.suse.cz>
References: <20260524-livepatch-unload-on-fail-v1-3-7465de7f741d@suse.com>
 <20260525002416.3B3A41F000E9@smtp.kernel.org>
 <0f269520407c8cfc554059ffcba45ef3220ecfea.camel@suse.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f269520407c8cfc554059ffcba45ef3220ecfea.camel@suse.com>

On Fri 2026-06-05 11:05:32, Marcos Paulo de Souza wrote:
> On Mon, 2026-05-25 at 00:24 +0000, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential
> > issue(s) to consider:
> > - [Medium] The `test_klp_mod_target_ops` structure omits the
> > logically required `.set` callback, exposing the kernel to a NULL
> > pointer dereference during module load.
> > --
> > 
> > commit 532c1b8c7438f534fd4e3440716ede6cf83efe1c
> > Author: Marcos Paulo de Souza <mpdesouza@suse.com>
> > 
> > selftests: livepatch: Adapt mod_target module to pass on 4.12 kernels
> > 
> > Use the stable module_param_cb API instead of proc_fs for exposing
> > module
> > state. This approach is compatible with kernel 4.12 and later.
> > 
> > > diff --git
> > > a/tools/testing/selftests/livepatch/test_modules/test_klp_mod_targe
> > > t.c
> > > b/tools/testing/selftests/livepatch/test_modules/test_klp_mod_targe
> > > t.c
> > > index 9643984d24022..1382a266825fb 100644
> > > ---
> > > a/tools/testing/selftests/livepatch/test_modules/test_klp_mod_targe
> > > t.c
> > > +++
> > > b/tools/testing/selftests/livepatch/test_modules/test_klp_mod_targe
> > > t.c
> > > @@ -5,31 +5,29 @@
> > [ ... ]
> > > +static const struct kernel_param_ops test_klp_mod_target_ops = {
> > > +	.get = test_klp_mod_target_get,
> > > +};
> > > +
> > > +module_param_cb(klp_mod_arg, &test_klp_mod_target_ops, NULL,
> > > 0444);
> > 
> > [Severity: Medium]
> > Does this code need a .set callback in the kernel_param_ops
> > structure?
> > 
> > When a module parameter is passed during module load, the kernel
> > parses the
> > arguments using parse_args(), which invokes parse_one() in
> > kernel/params.c.
> > Because parse_one() unconditionally executes the .set callback
> > without
> > verifying if it is actually defined, omitting it here leaves the
> > callback
> > implicitly initialized to NULL.
> > 
> > Could this lead to a NULL pointer dereference and a kernel panic if
> > someone
> > attempts to set this parameter during module load?
> 
> Indeed! I'll send a v2 addressing the missing argument. Thanks Sachiko
> for spotting it :)

It should be perfectly fine to use NULL for the .set() callback.
It can't be called because of the given permissions 0444.

We should teach Sashiko about this ;-)

Best Regards,
Petr
