Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D96835F602
	for <live-patching@vger.kernel.org>; Wed,  2 Sep 2026 15:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788364313; cv=none; b=pf19m6LIvbFvnbsXt/5O4ncxKU/uhR/Z67AH5rafGQN0kUSp4mfDklVbCNjELEz2tiFXUehA7oxyWVy5loLxgKz7K0gLSTY1cJmbua5AuX+ShJ4koJYbRgoR3ZFMItVHPX9V+EWyuUPr8Qe1e9vPZJgG+GniHhX/hO8KO+6ihU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788364313; c=relaxed/simple;
	bh=oX6VmNOeLoGKzNbviI76ebs9+ZwKWgUcpZoupCBel+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EgcsszhVxZaT4BJPAHjMhS/ppuYgbo9pQ7GVvuJjP3LBpEechnJAbkq1GEGaxOws8TUnh9orEGJTQobu1aGE7LpEAPd4xtZBTkSm37BYYDNIrrYBOu36/K0aUDeVXnI/NHKPzp6LXF4A696Rcao7PO+X02gUz58JgefgRJJM7GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TDTSihZS; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TDTSihZS"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-484362f5c4aso1306771f8f.3
        for <live-patching@vger.kernel.org>; Wed, 02 Sep 2026 08:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1788364308; x=1788969108; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sacVxgJQ8PWHj3dDVzMCQ0MkHfv6urFvQHWpQqm4sas=;
        b=TDTSihZSMqa1HArxRFzUOO3qjOKOoAbZjL+BMsc7D2a5qKJStK8cpRoCKHYV0EJWdp
         3NIpflSov00Fpao1OTgIQQZKF1sijR5trOc5LBbdMbpBacW1T2wds+POnWHKHSAIFuYS
         a2+09pH2s23iNSXor+fh3LQNbkOu3kBNI0YeJ0zDh2I+Zwg+oKLsO57/NfpG59YFSF5j
         auCYYpdwblMkOliNPjhSEwczHXJX0txj8LTXRum5OPunPsULTG6V/VctAeRvIQeeABej
         TG1w4E7U9OUnJu8/jRiZSabX5Y/2bO837xwp7y4HSwj7CM8ccAy6qvz7c0e5PbSy2o0H
         KeYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788364308; x=1788969108;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sacVxgJQ8PWHj3dDVzMCQ0MkHfv6urFvQHWpQqm4sas=;
        b=i4/m8G0oKN9pyR9BJgWYduR5rjXzE5p4zxmQe5nAdCOQ5GcgUHeYrlyw2D0ubdGOto
         Vgs+cbD3IvV9obUtimq+3veeUiKL4hgNgWbkxNWK/dN+kft8vhbCXzj42d0WnkbOUTUV
         mw/ZyC/eOTKr7Rosc0Nq4MMbEYSLRHIJPI8rqhPlqmjIivdhV7Z3jSmoYpZTVjJT1JJy
         ulZwSjxp7Px1K/ED53250cfDEj2ccxAZzRrCOxT/5UPVs7VpXUVC2YzDv+U/GigRL5ze
         tSDZlAB+LEryl2Q+QLKEJl59DD3pS7e5tPS5HZYBmx/kfIXFlzRJZ29QzP92PoiOVsr8
         3i6g==
X-Forwarded-Encrypted: i=1; AHgh+Ro5JFonXSoWBSHaBGS0Mku03PI01FKb13eRnuR2Gf6gsOlKIU5ngLjuGIHIWp9YPqwUH6tJ7yyYaRrAThpp@vger.kernel.org
X-Gm-Message-State: AFuF++kebzlBkgHrYJFRujNBa/dZFnTv7WBGKTu7rjQwP2DM0vwNjhBO
	sFVyK3tybGzRfulWsbSmDphZx15f69J0fszWAFNElPoc9LMfzTJM2M5ezPgtOVS0yDs=
X-Gm-Gg: AR+sD11P6R4+lWgCHu6K75ItDNl71ol6clRSal/10fb908361FHKjix+0ty476d5aI2
	GyPNa6yO9mIN9CsGM4fVfAgfM8Yt646f3LL/DPyahZnw6PrElydyYT17SxQpm4pX9k7CcxfTE9v
	IvA0SmVOZNDL+Ezpugl5YNDI5TioBFv+EbGP42ODt2UcBqz938Jx5rsUFohraXe58tqcDo2vNNp
	4c5Knp9OcI3Kuy4GBU//rUYRo0aLchNOTfoivtsJxEkr/aFO+n/OHEjgEgmkVs34xMRlP91AnkF
	SFInb5ft1UOH0UBSDvr3zwoPgrfyoBVdgf8GZviCqNw27Em9o1sNfXL07dyFa6WtB6yKoJ/g89r
	TtSQqitTfIttpGmER0LSkRPS6Z6IkOQzRHXtRLekQ2PIob+waI+fuKp23HI9hX03Wv+szwN0AX7
	Pj4HIi8ClBFa8qrm4riAV2KgpWwchE0+tDyEWRzGAM31Kqt/mUT+iBESps7Hc/4g==
X-Received: by 2002:a05:600c:1909:b0:499:ae94:be05 with SMTP id 5b1f17b1804b1-49ce55cb36amr89039835e9.0.1788364308374;
        Wed, 02 Sep 2026 08:51:48 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448ed2e9fsm7409043f8f.20.2026.09.02.08.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 08:51:48 -0700 (PDT)
Date: Wed, 2 Sep 2026 17:51:46 +0200
From: Petr Mladek <pmladek@suse.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz,
	joe.lawrence@redhat.com, song@kernel.org,
	live-patching@vger.kernel.org
Subject: Re: [PATCH v7 for-next 8/8] selftests/livepatch: Add test for
 function conflict across provides
Message-ID: <aphGEn8RDWQx_yEA@pathway.suse.cz>
References: <20260825114641.80452-1-laoar.shao@gmail.com>
 <20260825114641.80452-9-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825114641.80452-9-laoar.shao@gmail.com>

On Tue 2026-08-25 19:46:41, Yafang Shao wrote:
> Livepatches with different provides ids must not modify the same
> function. If a second livepatch attempts to modify a function that
> has already been modified by a loaded livepatch with a different
> provides id, the loading will fail. If the second livepatch shares
> the same provides id, or if its obsoletes list contains the first
> livepatch's provides id, it will load successfully and replace the
> first one.
> 
> Add a new test module test_klp_provides.c that patches meminfo_proc_show
> (the same function as test_klp_atomic_replace) so that the two modules
> can be loaded with different provides ids to test the function conflict
> detection.
> 
> Add three test scenarios to test-provides.sh:
> 
> 1. Function conflict across provides: load test_klp_atomic_replace with
>    provides=1, then attempt to load test_klp_provides with provides=2.
>    The second livepatch is rejected because livepatches with different
>    provides ids and no obsoletes must not modify the same function.
> 
> 2. Function replace within same provides: load test_klp_atomic_replace
>    with provides=1, then load test_klp_provides with provides=1. The
>    second livepatch loads successfully and replaces the first one
>    because they share the same provides id.
> 
> 3. Function replace across provides with obsoletes: load
>    test_klp_atomic_replace with provides=1, then load test_klp_provides
>    with provides=2 and obsoletes=[1]. The second livepatch loads
>    successfully and replaces the first one because the obsoletes list
>    allows it to replace a livepatch with a different provides id.
> 
> Assisted-by: Comagic:DeepSeek-V4-Flash
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  .../livepatch/test-provides-obsoletes.sh      | 110 ++++++++++++++++++
>  .../selftests/livepatch/test_modules/Makefile |   1 +
>  .../test_modules/test_klp_provides.c          |  72 ++++++++++++
>  3 files changed, 183 insertions(+)
>  create mode 100644 tools/testing/selftests/livepatch/test_modules/test_klp_provides.c
> 
> diff --git a/tools/testing/selftests/livepatch/test-provides-obsoletes.sh b/tools/testing/selftests/livepatch/test-provides-obsoletes.sh
> index f9a9f9b28490..be54e8d2c889 100755
> --- a/tools/testing/selftests/livepatch/test-provides-obsoletes.sh
> +++ b/tools/testing/selftests/livepatch/test-provides-obsoletes.sh
> @@ -8,6 +8,7 @@ MOD_ATOMIC=test_klp_atomic_replace
>  MOD_LIVEPATCH=test_klp_livepatch
>  MOD_STATE=test_klp_state
>  MOD_STATE2=test_klp_state2
> +MOD_PROVIDES=test_klp_provides

The new module duplicates test_klp_atomic_replace.c. We want to avoid
this. Please, create the copy module by using

    #include <original_module.c>

Also it would really help to use a better naming. As I suggeted in
the review of the 6th patch:

   + test_klp_proc_meminfo_livepatch
   + test_klp_proc_meminfo_livepatch2

or

   + test_klp_meminfo_lp
   + test_klp_meminfo_lp2

Then it will be clear that these are liveapatches and they modify
the same function.

Then it would be more obvious when they should succeed and
when fails:

# same function, replaced by provides
load_lp $MOD_MEMINFO_LP provides=1
load_lp $MOD_MEMINFO_LP2 provides=1

# same function, can't be loaded  in parallel
load_lp $MOD_MEMINFO_LP provides=1
load_failing_mod $MOD_MEMINFO_LP2 provides=2

# different functions, atomic replace works (nops)
load_lp $MOD_MEMINFO_LP provides=1
load_lp $MOD_CMDLINE_LP provides=1

# different functions, install in parallel
load_lp $MOD_MEMINFO_LP provides=1
load_lp $MOD_CMDLINE_LP provides=2

Best Regards,
Petr
