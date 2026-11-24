Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795518265;
	b=NgW3VKAVD9K1LVf7fHNAIOIEfFSllay8R96/R11VuJCalLtMKDwPAgg7P+trGehFaerU
	 TFNMK/9HyRsH4FucDGA8X99SFRWVXTYPXnv5eqpdMP3OX3TIGf6vNU3gkdlgFnK8paiO6
	 2Dt1bysVcAoTlHoGSfly0fl/70xTWRkdlaDUgQqmTKp+Q+eqGxCUK+8Tv37xptsmTtj56
	 MGFVO+PlVEovXHDCS4ke3Fab1VO/TKqGnmCqujlzN8bLCvvQoUBc9kAiSFWCjH1uAaD6D
	 VN6zT1sarLoVFojUjqomAANqMY0fr/TZg29s+tMl87TzRq45K0f8DVObg2KoNGjdXkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795518265;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=EuBOUwwiL3IP1HDk4+dxaacGJaiYkefTCK8JBEZyKe4=;
	b=o5z+O2zpLrWnBL9C+3ylkdlihTVPf+/JT5Lb60RwVgq+b355F9Od1eIaudOYRWAbVEVK
	 J+2Eaj8OLOT3ymopwkp5fXO7tbVa/FDvxkhjM0P8sangnqn+EgBEAdKlUU0/h6zMIUkaQ
	 zuXI2Bk88S6Bt06S+2nDmIvsvUhhdMEEca8nQvcLsmZchVv9VUI7VTmU4oUTRI00lyCmY
	 2cO2ObLf1FOQlWBR+8NLQnkKuu45j1v98/1VF4zp3+Trq9zG/NmSxil9pVtVAFlACYhL5
	 rosBlYiIPExknmUTxTKPrz6nXulZVgBle0atkoBLGbb92g0nSCjYDI4GFQtjrJSuCqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=DGCTDoFb;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE3F606A681
	for <live-patching@vger.kernel.org>; Tue, 24 Nov 2026 11:04:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDE3F606A681
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=DGCTDoFb
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-491846221ffso3698355f8f.3
        for <live-patching@vger.kernel.org>; Tue, 24 Nov 2026 03:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1795518263; x=1796123063; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EuBOUwwiL3IP1HDk4+dxaacGJaiYkefTCK8JBEZyKe4=;
        b=DGCTDoFbikauyFIMqdrHOrgjM62cX402e4khRkckTqUWicey3hvdiitxOdhi/LnQPX
         aTSOrLQRZq2jH9Y9HZ72TUNBL+mjYSlxq3wKIKY+J08+lRpR5XH6w6BPHngOnvO6QvYy
         K9rCe6e8DtXTP61QTMxyUUJudVvqxpDN/1U8QuRhNNn9bEMn0RR3myK/dJcgxSJrZubd
         CKXN9aoTK9JF5tX0QeeMKR1TS/4kkIzzvAKHJTVkPuh99aZY/qVa33Q89BL0SheCGNn2
         52/MjgbVpwEywoE7zhkDzXASJFbSKeX+OlotoymZqP3SalM6HZM5s77bBz1an88vPSsa
         JHtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795518263; x=1796123063;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EuBOUwwiL3IP1HDk4+dxaacGJaiYkefTCK8JBEZyKe4=;
        b=cVxWvmPBJMwoBLjvVyqzMwdRn1CtTOXJmYr/EbJvGQPb3ZNUcOAUwAsxYQjoOFu0PD
         XaRBAzguqCnzUysMtviJcJ6PlbLUXJZPMF6lFBBmyjykYHmz9SOlPmimIzYJqiwVDbZD
         /ynqQLlsZtmVWgmaI5yCWDyp6AAsVXdBZxf7h7vKFqt3DO3qGpeyI3egoZQ9q3ecIaIc
         SP7yxWc15Rn6f8TqOyztawXDkzKVq0icuU9Eu1gUq20/N/QzYPs5+UVlr0NWtD73wUG5
         4fNuIl06GIAQkQdViTsFwh15TwEHJDst71EnHllL0dyIXCAF7xeW8LeyRvov/BW9/kxq
         3Gbw==
X-Forwarded-Encrypted: i=1; AL+hErEN6k8Bq71vbtkR1sDOo1ab4rgiliMY2ToD08RhWAzEFqZ/HsjAMlzKutevpUR+Dnvm3mvm1SAPuYxBUllP@vger.kernel.org
X-Gm-Message-State: APuU4Z+TsLrYxhJHBFtR8BiKooJ5KFSIEXjPkKCwj1yKK/LX7ogi7uy3
	JQm8hdGP5JavUxH7FTubsi5EX4yL9TqepkYEueoG29jW8ZUM630b2Z0uD1lvWpRuyuQ=
X-Gm-Gg: AZFdTZdqKTIwYnHl+DxBbOuBn49j0OtE5zQO1Cbta3OWevtCF+qc2h/VCmnuZ6z+1Ms
	MdUYdyjrY59yPw/bSNC40s/N35v7kYB6RKG4ozPi8+FxYyHFrmLdiHMbTzp+zqUkMUsdBYkAD/b
	LHruBi34s8CWF46dA7Q1hv556d/VErH64/tB68e8yXorR6FzXwSB+EOho1suvhAyVm9udJrJj/A
	dGOcXMR2eY7Fq988PZhDkGqsiaPKdVzBLvKIFVvgZNb7UHoczNHZ5mH5ighRP2TVJj4Qq5OC5n7
	Wr3WKJ+K8VnztJyqHgwHWZ9ysS5QmakTjBuQwcqDIt8wDDZVaQsZgHOkKX0ZFEbgDT/g1qzL1uF
	g57Eg4big/p9q6ZJMLujyXVinjWcPoVsskszcpdyOZm7kzTABgq6+x01R5AVFD3w8lwTXyDi7Sh
	hp0bCgGZ5G0SmXK917t5NF/h5fDTtzWRA2kD9F23/cOLn7aoiHB7yyNVCfN2atKFQp/DBxhpcCm
	+7SCf6kNTL7V0uvkLEX+iRpYIlr/QfW0rJZ86Acmjbu3wp8X2BgmprYHX+KR5AxqZd7CnlEz01A
	yQ/z0pWaVcenqlxT8AR+dZh6AGSIIjE=
X-Received: by 2002:a05:600c:e41a:b0:4bb:9959:54b8 with SMTP id 5b1f17b1804b1-4bb9959552emr100442045e9.32.1795518263196;
        Tue, 24 Nov 2026 03:04:23 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884865b1sm422020975e9.5.2026.11.24.03.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 03:04:22 -0800 (PST)
Date: Tue, 24 Nov 2026 12:04:20 +0100
From: Petr Mladek <pmladek@suse.com>
To: Sasha Levin <sashal@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
	Joe Lawrence <joe.lawrence@redhat.com>, Song Liu <song@kernel.org>,
	Marcos Paulo de Souza <mpdesouza@suse.com>,
	Eva Kurchatova <eva.kurchatova@virtuozzo.com>,
	Yafang Shao <laoar.shao@gmail.com>, Shuah Khan <shuah@kernel.org>,
	live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/4] selftests/livepatch: clean the test modules
 without a kernel build directory
Message-ID: <awVvNNnQPGyNWb96@pathway.suse.cz>
References: <20261110161050.2451750-1-sashal@kernel.org>
 <20261110161050.2451750-3-sashal@kernel.org>
 <awQUD16CDFpCTxaQ@pathway.suse.cz>
 <20261123154433.1188237-1-sashal@kernel.org>
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
In-Reply-To: <20261123154433.1188237-1-sashal@kernel.org>

On Mon 2026-11-23 10:44:33, Sasha Levin wrote:
> On Mon, Nov 23, 2026 at 11:23:11AM +0100, Petr Mladek wrote:
> > The two parameters "O=<kernel> KDIR=<kernel>" do not make much sense
> > to me. The command starts compiling other selftests. I get:
> >
> > $> make -C tools/testing/selftests  O=<kernel> KDIR=<kernel> TARGETS=livepatch
> > Makefile:4: *** Package alsa not found, please install alsa development package or add directory containing `alsa.pc` in PKG_CONFIG_PATH.  Stop.
> 
> Sorry, <kernel> was a placeholder for the kernel build directory. Pasted
> as is, the shell takes "<kernel>" as redirections, so make gets an empty
> O= and no TARGETS at all, and its output goes to a file named
> "TARGETS=livepatch". If that's what happened, that file and an empty
> "KDIR=" are now at the top of your tree.

I see. I have never used these parameters so I could not imagine
what the value would be :-)

> > Are these parameters really used by the KernelCI?
> > Could you please provide link to a build log?
> 
> Yes. This is from Saturday's x86_64 build of mainline:
> 
>   make --silent --keep-going --jobs=8 O=/tmp/kci/kernel_build \
>        INSTALL_PATH=/tmp/kci/kernel_build/kselftest_install \
>        KDIR=/tmp/kci/kernel_build ARCH=x86_64 SRCARCH=x86 \
>        CROSS_COMPILE=x86_64-linux-gnu- -C tools/testing/selftests all
> 
>   https://files.kernelci.org/kbuild-gcc-14-x86-kselftest-6b01150f99c74e1a99a2a261/build.log.gz
> 
> > So, maybe just the sample command in the commit message is wrong.
> 
> Yes, it should have used a real path:
> 
>   make -C tools/testing/selftests O=/tmp/build KDIR=/tmp/build TARGETS=livepatch

This works for me.

> Please keep O= and KDIR= in it, though. The paragraph is about modules
> built for a kernel other than the running one, and that's how they get
> built without this series.

OK. I'll use the variant with the real paths.

Best Regards,
Petr
