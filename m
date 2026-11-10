Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794307817;
	b=eiIecWVbd1GDxrcceBNbkvcczPHb7Yre8iLRTU/Jv8UMycJ4zjpb4BjfXkXTPDS2mxQe
	 j7pea6E51WHkkRKPd1R086xYkj3Oin3Fq7c5WcJRTXsiWzznEVYF5dfBXSn2nYWAjIUbC
	 8Tv+qAcGAEbBFq8nrmrKKkCYP77SA3Nqbjn+XTl2Yirp6On2M+w0cSDoFUlmYA1Kl/X/Y
	 b69V89HXm4qgeRJX+weT4Llmv7+zsmh1paygg8zctkUGemX6ec24r91Mjq2A1LNfEgRoC
	 AM6s9t2b2SVFKGhXrIPfxoX8vWyudMTRpAn/y/GyH8fG6WwEMnx0h+hQ3wbZmTy9ozQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794307817;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=RVTkGzwp8ckIzdQmxfwAcPBKin5d3z25DmdwwACLOEQ=;
	b=ERE+DdW28YJW7CUYlT8vQ0kb0ifdWWmYOnt0UONPrFFIL/yZJVxSzr/YAgP0vax3A8yn
	 UHZ/Z6BLo5GWkTnUvzFCPunE1MBJ0/u37+h3cDPiZMXyFn8OIkfNWQoRiZL87Wcf0bzbn
	 +rsrpm70jZ0yDcDVsD6vxRjta8GebV6k1WJa/0xl9xP6JdyYdixzkeMo2sE61xlPEP4hq
	 tse8JX3gK67SGyF1slbOkftCljH7slsdT97S0/yh7YOSjNDCFVUTNW0SS8ggC3vqYW6el
	 ZWNZamA4t3QuB37RouohjfYXFmFgeElG4DgtRPVKgONkMwz7i3+poevw0zj2aHPYoKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b="P/jUBQCJ";
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F1760A2603
	for <live-patching@vger.kernel.org>; Tue, 10 Nov 2026 10:50:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8F1760A2603
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=P/jUBQCJ
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a215e64962so21220935e9.1
        for <live-patching@vger.kernel.org>; Tue, 10 Nov 2026 02:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1794307815; x=1794912615; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RVTkGzwp8ckIzdQmxfwAcPBKin5d3z25DmdwwACLOEQ=;
        b=P/jUBQCJoeTzk8ENZY21IS6gDU+Zdyc3XCOAcCfNMmq10lkR8U6IsmhN6Xm3LtJm8c
         57Lsbw3/yyD/WCd7dwlAtYB4m5l5PDLR8WQN55qbEKB3A1ar0X0i4ayXtpEkZSm/eleM
         6n9AJ1zMuI6fPQNhL7pK4RYhwuyzARnCAXY8ukjpWK0dVMLxQkE0hnzi++H5U5WHivPK
         7u53LDz9nSTrMJHmZ7FzqqwECFmbIJQlD68etYr8cZaqjQOw2vAxdFNZrBnmAKEJV3gn
         +8hObpVZccBlXWQdyg7IrVvXM3egRtxOSiTfU5PxSJb7YuQjs8akDrMWE61qu3NyeNvD
         /6jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794307815; x=1794912615;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RVTkGzwp8ckIzdQmxfwAcPBKin5d3z25DmdwwACLOEQ=;
        b=mft9aXjIMhCrvVzVzd+hr3ljSCnkIwhMXCM0dL6nDl6BqURgR/w3u4Z/QDmQx/W8II
         XjtSIiJF/Sq/cxD08LydZu7WgXzkkoplP8KiBEtWFn4ZlL5CkDCJ9gINtIgLwFF+SBAJ
         bjWeRPJx9vjTX5gZxCviaL6qYm92mJVuFfO+RfpFc0/oxIftKcZZxSAawH+fzio3geMy
         IPkg8uNOla/feYVEVoIQEDW6gmXRNwFyIai23M1DEhmXWQ+E/rcNv6Ku1NvMkW6QlUyT
         e8M2pmnKG59xdBOgKci/S6xUtdwll2BWjuv7c1hFRO0kqdTo2hZUwLtUvudXzuJyFh6i
         C8Ew==
X-Forwarded-Encrypted: i=1; AL+hErFfuA5DrJlrgKbefQs3Nb79ITRfnhoc9MSRqYPLPe5w6SQsmnwWZt4wxpmTWUAFaRJapvXlXj3S/heyagM6@vger.kernel.org
X-Gm-Message-State: APuU4Z+JVQxOqjItCoSWaPoeDKflrgopyxcLn+vtr5Zf4XcZAREO0D5H
	FTsphYVa17ycWtmJwAPGPfo3MoGZ1ZvaDRypBjc/+BsUcNHFwGh4zex7vpj6fSFAwh0=
X-Gm-Gg: AYBFou0GDtSPVOdoP9/vfbTzO1GiNDTYIv7ej4rxEooPSt1EHHfDj0VIcj1nlm0hq3L
	VPjFK2kuY9IS00uPQabG4YnRT5L2ULiBMRTtzo9ioK0Knq37DzFjajiO4//MrZ91VMJ/5aIeOnG
	Cawl6KDse2aDJd3Z2ZG/tY8nO+nE65NtfYw456QIxRwUlaGrBFyOdc/bAfGYMtPqLR9fmyQwLuG
	gQtBCZZ+6VJINWvwYyPvnm7QJh0XeKpF8l35NhXOv5Hk3WcJGKgdhL95kEMgflnLDQl6RyVvK91
	AZMdz/hEYeLMbS30DreGjuO09Ur5ViCJz4gsccfudOgFJ0WyOTxbVfk75YUA3fotB+R4QwmSsnx
	L/RydtugKoKRETPyRsI/BGwZgJViZpBp3OG5H3d9qwZl2ljQV4SMaNl+jRU5i7UErndcCNoYez3
	7ysP7I3e7Egy/KNbEXVQN300t3ITbi9ksfSSE+6nlT1IWoGJn80jXZQhi6Prgwdf9xxR4f4rv2r
	6JxlEx9HY+2JrfpCyf+NdROJN0J6R+hqWyWnnLx7Ii/ZLx9q9VTw3L6Ui0mP0yIDzHYKLw+uFlk
	inaxJOxUMS65+26MxTTcGDupUi79JorUPh5F6PHxJuxa7g==
X-Received: by 2002:a05:600c:4e14:b0:4a1:e00b:a10b with SMTP id 5b1f17b1804b1-4ba0233b8b5mr35312615e9.7.1794307814843;
        Tue, 10 Nov 2026 02:50:14 -0800 (PST)
Received: from pathway.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49835c37bdfsm4522648f8f.22.2026.11.10.02.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 02:50:14 -0800 (PST)
Date: Tue, 10 Nov 2026 11:50:12 +0100
From: Petr Mladek <pmladek@suse.com>
To: Sasha Levin <sashal@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
	Joe Lawrence <joe.lawrence@redhat.com>, Song Liu <song@kernel.org>,
	Marcos Paulo de Souza <mpdesouza@suse.com>,
	Eva Kurchatova <eva.kurchatova@virtuozzo.com>,
	Yafang Shao <laoar.shao@gmail.com>, Shuah Khan <shuah@kernel.org>,
	live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] selftests/livepatch: skip based on the test
 modules instead of KDIR
Message-ID: <avL25NFPU_pJ2tXJ@pathway.suse.cz>
References: <20261103222706.1642224-1-sashal@kernel.org>
 <20261103222706.1642224-3-sashal@kernel.org>
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103222706.1642224-3-sashal@kernel.org>

On Tue 2026-11-03 17:27:06, Sasha Levin wrote:
> setup_config() skips every test when there is no kernel build directory
> at $KDIR or /lib/modules/$(uname -r)/build. The test modules are built
> together with the selftests and the scripts load them from
> test_modules/, so nothing needs a build directory at run time. A
> machine running an installed kselftest tree usually has none, and the
> tests are skipped there although the modules were built and installed.
> 
> Check for the modules that __load_mod() loads instead, and remove
> has_kdir(), which has no other users.

This is another a bit cryptic LLM generated commit message.
IMHO, it will be much more strightforard to say that this patch
allows to run livepatch selftests with pre-built test modules
without a need to install kernel devel files.

> Fixes: 54ee3526796f ("selftests: livepatch: Avoid running the tests if kernel-devel is missing")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  tools/testing/selftests/livepatch/functions.sh | 16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
> index 8b26b70f92d8c..14fc9cade4de3 100644
> --- a/tools/testing/selftests/livepatch/functions.sh
> +++ b/tools/testing/selftests/livepatch/functions.sh
> @@ -44,16 +44,10 @@ function is_root() {
>  	fi
>  }
>  
> -# Check if we can compile the modules before loading them
> -function has_kdir() {
> -	if [ -z "$KDIR" ]; then
> -		KDIR="/lib/modules/$(uname -r)/build"
> -	fi
> -
> -	if [ ! -d "$KDIR" ]; then
> -		echo "skip all tests: KDIR ($KDIR) not available to compile modules."
> -		exit $ksft_skip
> -	fi
> +# Check that the test modules were built before loading them
> +function has_test_modules() {
> +	compgen -G "test_modules/*.ko" > /dev/null ||
> +		skip "test modules are not available"

I would prefer to keep also the original tests as a fallback
and report:

		echo "skip all tests: test modules are not available and KDIR ($KDIR) is not available to compile them."

Best Regards,
Petr
