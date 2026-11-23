Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795443368;
	b=3SoBUEEkGi5eAXRNEA+MiusZ/KyklyRF+BQc7vJdP4jgW0S+zz9Piptn5y7XFDZFl82x
	 YGv6MHQGFi/iREWOA/DwRh4alrgWHy7upOfae8Bke6iEMT03v7cUmFlc+MwFxEvykT7Lw
	 0bQPLZTRXJyRo4mhLqniQ9himYMLzAGDNUIDrweJmWE3dIrv4zG5YSW36cXtCJAAjmoiT
	 1IYobtwNVakX68PmtkRtm0zpZx4lyCqlW4vmjc1ivxFgsa3Evpsroj+ff9DFmY0ks/nRN
	 T/3bwNuTtPgaFU8lITnS5nfGHEScAK5PK61/ykSGP+C9V6e5bEAQ6HHSImv5yrDopZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795443368;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=Zfh0a6qWB7cgYhlh/JVDBYrhyvShnRR27oz/yTBM+wI=;
	b=KpqhXvjXxn+Y5F/IxcC4S2a+IxZosb3bpOrLSmt9rHr+876Y/D3jD6GuHHkmpUNG+ZQj
	 XSpMr8SKS9XChZ9ArLvUVgxm7won5PhZJwMXk5zmbSkBNhBkTdbuGuze6AWievBK6S5Xg
	 x7R5u6jZkbFOcj+rXl3ZiaJtSHlYvhzoth+bE9Tfb3NsmGZ79G1i8b3T+SHSRsiwj5/ie
	 Q7uAjWPkfvj5AN6jxDvmWvrC/4xRlUJO2lAfYa9ePFcAWOZAxYyZRgrViNcaOJcCwReZx
	 2lyPUaIwQyLgs1LjWu8cWroBwHTNksD+HLe1rBkx6VtDjKArVUA022YvHgCX4MxWs/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=MzQ3w9nU;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45883606A31E
	for <live-patching@vger.kernel.org>; Mon, 23 Nov 2026 14:16:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45883606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=MzQ3w9nU
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4ac109a8a12so1903298f8f.3
        for <live-patching@vger.kernel.org>; Mon, 23 Nov 2026 06:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1795443367; x=1796048167; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Zfh0a6qWB7cgYhlh/JVDBYrhyvShnRR27oz/yTBM+wI=;
        b=MzQ3w9nUw2sUyJnn/xbL3lFnkOFDs10fQ939b1r9lh3GObb6YW0PbtbT/rdjeJ4rmx
         WqEZhQyPqHwQC6iJ2D06RqjGMiDjPGz2ndgRMGNbdLktctaNAa+Vyj3hZv6GTYbcMIoL
         9idjx98FhZGu2zcC/Xro2yLz7tAulmBVYILxyScBaaBn4fepRtuAXY3joaRDNfuHXkq3
         Qtle4B4BdgjgO34ulYlM/LfdtfEiRrwIiytmyNcfZMbXLq3flUVQw49XdxkFS44h2lw+
         /idJvNMYlizMxO+MngmekHSGiaLc5am23Jeu+LvaGV//bAcJTBCyb3o6XyKKYbFYqFLx
         pBLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795443367; x=1796048167;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Zfh0a6qWB7cgYhlh/JVDBYrhyvShnRR27oz/yTBM+wI=;
        b=Zgk/EpeVcODMkjruLVZYE9G6azaIPvnMNLxgDY8W9znjsy/aOroUxqtbBgi0hxCw8+
         C9r1KsbJnqrxtcBVhvLainLrG93/+NmSz8F3HGLNAXZ9gIob+OKFOfrPASowEh2htOkl
         96J8m4PKBl8CtpeYZx9WFhijPkFpIjwtV7fXpSQsIn8o/pn6GgMMLkuf725U3Kkt1Zz/
         obMHDVGDgZ/N0V5k7UXYI9DfOdJD3fCVGGEiWn1hQIEr+klk22g1civNoUfmMKzt+Dge
         5qjbD0dJMFRgLGsHa9YsDH2J+wC9sZXHSRVdSKBiCV8KgvYzEy6wX5fTo4ZZmviF8j0a
         Wctw==
X-Forwarded-Encrypted: i=1; AL+hErGMcw2+6C/xpAGJz/gn3xdox4XiEJaF99Zl3W7zgACN44NtebblSTYVEe2NdlB9Og6BJHAVp5ToCXK/R92B@vger.kernel.org
X-Gm-Message-State: APuU4Z/WM9C2yzSnDIIhDEH4Md1LxlsWp4sevpTsoQt2kDZT8xvh2xXF
	xiIpBdTSUu4yEZsg4gzaBmnqWEKKqwcFv+WWk50oU4oN0eeE4h6dXmiJ6RYSLcCEHhHLj8bP6Jf
	2PLCxyU8=
X-Gm-Gg: AZFdTZcnvkYraPd//klyDG0nA40vOQj6vqSZOuf83wYuaFwIfW+AT6waSLxc15VEOEk
	BGnZAN1AZdJSHZvu+V8+NKjP3UlbKHgo1OZTKnn18vJUP7P97IelVNuONDfl/0w5lGhsK8SNHN7
	HEp0CTLpt30b5puB4FdhDZOAw1oIoUxbSWgaM+PhI88ChvPavsabumqe+JjFjnXYkaCI69EujeL
	8pIOruPgHV+Kw9sZW4BfeM/25L9E/tLfevErNvciEhrNYTz7HH3S4Lk9PApJHKjHGtsw2HGeoll
	QG5/NPozfX1FRLNMvOIPscDjY+Q3ymphcWh310LkfYGeagFJTUSAH52gr0y0AIQgzDcj5gFqvwO
	z7410N24HK8BbEi1jUbuH8ANsf07FJ/eiWxML5Hjt289RBQJqPfO/o8nllImc3WtnNjLDK0NSRz
	fTaT+bfuDuNXNxdws492RZq4vEYvUqmNHxwpEmiHu23BF3IafiBfWCEcwfrFQCpEqodhpSSCI6F
	H20vITx+zRtW0jZD/+yMyivn0fNeYJgeqSaxKORN6XjSmetHi1f78ssrLU42JkcmPJDYn0UAba4
	xbpb/tiCXbiKlvsSOfy7RfqdLx2Z/G8=
X-Received: by 2002:a05:6000:298e:20b0:488:7496:15b5 with SMTP id ffacd0b85a97d-4abb4c7ab74mr15920212f8f.47.1795443366598;
        Mon, 23 Nov 2026 06:16:06 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b110d56sm21672571f8f.40.2026.11.23.06.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 06:16:06 -0800 (PST)
Date: Mon, 23 Nov 2026 15:16:03 +0100
From: Petr Mladek <pmladek@suse.com>
To: Sasha Levin <sashal@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
	Joe Lawrence <joe.lawrence@redhat.com>, Song Liu <song@kernel.org>,
	Marcos Paulo de Souza <mpdesouza@suse.com>,
	Eva Kurchatova <eva.kurchatova@virtuozzo.com>,
	Yafang Shao <laoar.shao@gmail.com>, Shuah Khan <shuah@kernel.org>,
	live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/4] selftests/livepatch: build and run the tests
 outside the running kernel
Message-ID: <awRKo4D-H2sHFfwR@pathway.suse.cz>
References: <20261110161050.2451750-1-sashal@kernel.org>
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
In-Reply-To: <20261110161050.2451750-1-sashal@kernel.org>

On Tue 2026-11-10 11:10:46, Sasha Levin wrote:
> The livepatch selftests build their test modules against the running
> kernel and skip every test without its devel files, so they do not
> work when built for one kernel and run on another, as CI systems do.
> In KernelCI, 36 of 69 kselftest builds of mainline fail to compile the
> modules because the kernel lacks CONFIG_LIVEPATCH, and where the
> modules do build, the installed tests skip themselves.
> 
> - Patch 1 skips the modules and tests when livepatch is not enabled.
> - Patch 2 lets "make clean" remove the modules without a kernel build
>   directory.
> - Patch 3 builds the modules against the kernel in O= or KBUILD_OUTPUT.
> - Patch 4 runs the tests with the installed modules, without the devel
>   files.
> 
> Tested on x86_64 against kernels built with O= and in place, a kernel
> without livepatch and the Debian headers. The modules build and clean
> in every case, and the installed tests pass 8/8 in a VM without devel
> files, where they were all skipped before.

My only open problem is the "O=<kernel> KDIR=<kernel>" parameters
mentions in the commit message in the 2nd patch. They do not work
for me.

Otherwise, this patchset looks ready for linux-next.

I am going to push it (with removing the problematic parameters from
the commit message) by the end of this week unless anyone complains
in the meantime.

Best Regards,
Petr
