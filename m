Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094B24A015B
	for <live-patching@vger.kernel.org>; Wed,  2 Sep 2026 15:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788362724; cv=none; b=QOonsCV87gmkPLGIjsr/1nonMULzt8O4om8WKG8GV2Kt0809i07ymZuvSx2vDiB8McjaKTVXMGNvCTCPfqKpW3Ky3hBGgBqLfKitFWBQEwkfw+vKNID1k297+k3i4jJqM5BwMy2gCPa1dSvystapJj4uWvegPjZbk2U0dzkwumw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788362724; c=relaxed/simple;
	bh=1aeRzc11bJDJ8pNJOXtnphNsSNMuS01DSonPqEUmGdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fMk5/7q3NNdHU0xRwfUzzRiHQRz4lxRKfdhhr/X5k7VJBOMaGTjX4BFbFdcm20SmNlWahL5ubjvvNywqFQkBAPbFyGki7Or0PTMlYAvr9/Kq3BnPbzvsIMhxSHEU8pGNx/xiHOjeOOyPzuMw64yfAriGkkAWyx2gkuXWRuASuqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZZq3k4Yc; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZZq3k4Yc"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48436251906so1289637f8f.0
        for <live-patching@vger.kernel.org>; Wed, 02 Sep 2026 08:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1788362720; x=1788967520; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sdhzmBXpmtMhpS6s2/5HqSQct6jkhEH2fcJ9LMJH4Ys=;
        b=ZZq3k4Ycre4mFyET7mVyLMpLRvY4JwDy5ftq4TLK+0sS81njvfeH+UisZFQ48WZs9l
         +4wl6lirj0x55DUG2hAFfY6Ff08x40Xpi66fIKP0ksSAZ1K/vR+lo/VTYN15NsyoxKAW
         RJaoqlJDliI7UoKbU1xqMwKWRmgJjtHGAHwjGPj06fyLFRx6KYLsXqbdZ53cwBhCy9cy
         Q0HjrcRT/LrcjmfrxSdb6mhW8z1zbl3HmZKnNBcPavX3JDnpT5iHa52fybSUeskd3nDm
         /PabnFoL6dib4jjfTLVvzVqzT1BI+xD1iOQPW+ZfhohRQeSp7iQBNqYJNoJynaMeZWE6
         zr4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788362720; x=1788967520;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sdhzmBXpmtMhpS6s2/5HqSQct6jkhEH2fcJ9LMJH4Ys=;
        b=nHr2jRZM0jooI7NzKmnbRqh+dXfRRB0UeR8mmo0FRvexNF7RPOi7Wfsry88YvdSp8U
         EyS6R4pxhWVLuMZSoTFsWy2xiqV8sIDtxB055x16mBGyCm/kBuYqEE5ijpPx+gLP+3lm
         USpJXgYtPQTEjG4ENRU0Xj+C73EUXMBq1w0EX3HYpLzfgercdT+LD01TsbJgQ7R3ChVY
         qlUQUiapisff4KUEHl7mHSG4LFqZhbdPixF83e5tK8ZyWrD64IvsEylhdrQKTGyN5eQK
         rzh7qzaQBZUvuAx6Va36cwp1zlyev4L5CDi7/hhLHK5luNoTFHs3gWCy99XwUu3s32bs
         BbCQ==
X-Forwarded-Encrypted: i=1; AKwUvBzqsOmJZsfJyC7wn2U1M8d1toD83uAzoX655FSjjaRoJjFf9MUNpr/GmxXX65X5vcWrJf2mAvycBM8WK775@vger.kernel.org
X-Gm-Message-State: AFuF++lObGKd/r2BeFcDabVBQbXi3R90QIC6PbmTbd0GyMfKnCcvm8jG
	s29Z4ujUL4MEHN2H5F1ShgEOL3ahRJT9lJkwfOQ8xrDTttiS4qch5cJmx4t9JFCjgFc=
X-Gm-Gg: AYBFou19Ks5xfkBNSmw8aJNMMKoOy2y/H+t7SOMZP/nx0BctP+q3GSE/celU7rsieW6
	LJN1vTZw5NWMvROyDSdC8LuEnOXNMl4FjYHkqWe+Cux+X35vHVJRNvkH3B0PWWMEly/54zM770L
	eWgGdLAR9uWuexE8x1ySVCGJVUYt9Qhv3JN3gk84GzKxOOP06ab+AGHkZ8d+7sJnTeISfkFjsPW
	PZ5RaT6RVBvr2s5whBI5C/7hLwNXGbSg02PsgLUSVMh5oOJYGykZX1PkYuWE5ud7ClMz/7/MvhG
	QSwgSg90Ydwr2jfaBvyY1Chcp064e/3Q3fG5fLgpFAmgaXFeBmAHYQtJChgMgwUDb5q6YQrPMRZ
	OyxKlkGKcGjL8/pgS3OO9s8zdcfIPdn8MCN0MHLc49azkS8WoX30RHQTnUyfCVVN08gc0qR8ofS
	6QkfYI0dohzVghRFwwVJRFOtyHyNfyVHfRRLPoz+hlvhb4zA4jAW700xyDP85h5A==
X-Received: by 2002:a05:6000:29c9:b0:485:4275:f207 with SMTP id ffacd0b85a97d-4854275f547mr8300848f8f.24.1788362719954;
        Wed, 02 Sep 2026 08:25:19 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448e80388sm8397397f8f.14.2026.09.02.08.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 08:25:19 -0700 (PDT)
Date: Wed, 2 Sep 2026 17:25:17 +0200
From: Petr Mladek <pmladek@suse.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz,
	joe.lawrence@redhat.com, song@kernel.org,
	live-patching@vger.kernel.org
Subject: Re: [PATCH v7 for-next 7/8] selftests/livepatch: Add test for state
 ID conflict across provides
Message-ID: <apg_3dLUGBeCjKoM@pathway.suse.cz>
References: <20260825114641.80452-1-laoar.shao@gmail.com>
 <20260825114641.80452-8-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825114641.80452-8-laoar.shao@gmail.com>

On Tue 2026-08-25 19:46:40, Yafang Shao wrote:
> Livepatches with different provides ids must not share the same state
> id. If a second livepatch attempts to reuse a state id already
> registered by a livepatch with a different provides id, the loading
> will fail. However, if the second livepatch's obsoletes list includes
> the first livepatch's provides id, the second livepatch replaces the
> first one and may reuse the same state id.
> 
> Add provides and obsoletes module parameters to test_klp_state.c and
> test_klp_state2.c (guarded by #ifndef KLP_HAS_REPLACE) so that they
> can be loaded with different provides ids and obsoletes ids.
> 
> Add a "state id conflict across provides" test scenario to
> test-provides.sh:
> 
>   - Load test_klp_state with provides=1, which registers state ID 1.
>   - Attempt to load test_klp_state2 with provides=2, which reuses the
>     same state ID 1. The second livepatch is rejected because
>     livepatches with different provides ids must not share the same
>     state id.
>   - Disable and unload the remaining livepatch.
> 
> Add a "taking over system state via obsoletes" test scenario to
> test-state.sh:
> 
>   - Load test_klp_state with provides=10, which registers state ID 1.
>   - Load test_klp_state2 with provides=20 obsoletes=10, which reuses the
>     same state ID 1. Although the provides ids differ, the second livepatch
>     replaces the first one because its obsoletes list includes the first
>     livepatch's provides id (10). The state is taken over successfully.
>   - Unload the replaced livepatch, then disable and unload the second
>     livepatch.
> 
> Assisted-by: Comagic:DeepSeek-V4-Flash
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  .../livepatch/test-provides-obsoletes.sh      | 86 +++++++++++++++++++
>  .../livepatch/test_modules/test_klp_state.c   |  9 ++
>  .../livepatch/test_modules/test_klp_state2.c  | 19 ++++
>  3 files changed, 114 insertions(+)
> 
> diff --git a/tools/testing/selftests/livepatch/test-provides-obsoletes.sh b/tools/testing/selftests/livepatch/test-provides-obsoletes.sh
> index 2707457b9133..f9a9f9b28490 100755
> --- a/tools/testing/selftests/livepatch/test-provides-obsoletes.sh
> +++ b/tools/testing/selftests/livepatch/test-provides-obsoletes.sh
> @@ -6,6 +6,8 @@
>  
>  MOD_ATOMIC=test_klp_atomic_replace
>  MOD_LIVEPATCH=test_klp_livepatch
> +MOD_STATE=test_klp_state
> +MOD_STATE2=test_klp_state2
>  
>  setup_config
>  
> @@ -171,4 +173,88 @@ livepatch: '$MOD_ATOMIC': completing unpatching transition
>  livepatch: '$MOD_ATOMIC': unpatching complete
>  % rmmod $MOD_ATOMIC"
>  
> +# - load a livepatch with provides=1 that registers state ID 1
> +# - try to load another livepatch with provides=2 that reuses the same
> +#   state ID. The second one must be rejected because livepatches with
> +#   different provides ids must not share the same state id.
> +# - disable and unload the remaining livepatch
> +
> +start_test "state id conflict across provides"
> +
> +load_lp $MOD_STATE provides=1
> +load_failing_mod $MOD_STATE2 provides=2

It is not obvious why it should fail because we do not know the used
state id. It might be better to define it via a parameter. It would
even allow to test more variants:

# same state, same provides
load_lp $MOD_STATE_LP1 state=1 provides=1
load_lp $MOD_STATE_LP2 state=1 provides=1

# same state, misc provides
load_lp $MOD_STATE_LP1 state=1 provides=1
load_failing_mod $MOD_STATE_LP2 state=1 provides=2

# same states, replaced by obsoletes
load_lp $MOD_STATE_LP1 state=1 provides=1
load_lp $MOD_STATE_LP2 state=1 provides=2 obsoletes=1

# misc states, same provides
load_lp $MOD_STATE_LP1 state=1 provides=1
load_failing_mod $MOD_STATE_LP2 state=2 provides=1

# misc states, misc provides
load_lp $MOD_STATE_LP1 state=1 provides=1
load_lp $MOD_STATE_LP2 state=2 provides=2

Best Regards,
Petr
