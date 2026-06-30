Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E222848AA
	for <live-patching@vger.kernel.org>; Tue, 30 Jun 2026 14:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782829943; cv=none; b=V7AM5bYR0oRgzU/T8BS9iI2p3P/cYUYEamPjwjdxwF+1QPBPbZjz2m5FCYAVh8mChPtJyEHsEhL6qKl+NoZl6KvnD4et8p53rVlIQfxLAF2kQADrU6BUFFvLecuhgS3b8GZ6wmmGU7qccyV3bFsqpAYEPkPu3CtVwP1Na2gM1dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782829943; c=relaxed/simple;
	bh=FO39T618gaKZFOsDIKxtn/AnCl/b10UY/y33rpdMYeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P+C5BuTVuc71oOXUH/V4iLu6I3Rq4eYtaMgQS3vVtwZIlmNRrBcL/PuLeotibFO/JhMR8V09Rn7XBY3OV07E1A/gladQLoGQizLDnAVuKWHl9PoAt6/no/RDFzXzyv00GHSsk+uSgdL8x/RHbuQM6xotE5sTqJEGl5oO7S8Kvnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CzW8yS7w; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CzW8yS7w"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6983f5c1c52so5916090a12.1
        for <live-patching@vger.kernel.org>; Tue, 30 Jun 2026 07:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1782829940; x=1783434740; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kLhtMkzKlXBCIs0wHZ4RXzVDwMqNrV52tXHwDJGZiCs=;
        b=CzW8yS7wBiT4nrRQMu7pNPnANuMYbywu4X9fs/W9/TG7De6bDmXp8yaCQTYiFpkuMQ
         w/lcPDMtKlLbjMM8ayQTGWkFGkgy8GHLuXf6lzeQwozoE0bh+XO2HglLqc4X2YwkD71C
         oUq79XAM4OIL8EVyrj4tkWeLURMeHbnd9kEt6F8CZlotgmwot/tPbUKZxhoAv+wjNByB
         oa4SJP2robSL680cxgm6WGILTEAhhOLi6j/P0TyfLDlj4/wEo/TP07RR7U2/Z+Nkpw11
         Zpcq0petBXBSslsG8dY4UKDr1FQglAnKbTlyAAJlUgiZNgtJ/upAFfOt35HYQkid45FW
         /+qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782829940; x=1783434740;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kLhtMkzKlXBCIs0wHZ4RXzVDwMqNrV52tXHwDJGZiCs=;
        b=e8PcSPu7Nw0crp3uRG/i6YxXg6J3F/95/44coMDk2tkcmYqqry0TJ+Tm0vluw/c9lM
         95xERHa0R9lIEI68G6zvtXJqSjf+CyM1vlnTGYs7bA8leaQc1nGv3+ELlda40XaiA4NF
         +5aMmm+A7eCXDg+e/B+8pNkaln/pV4K/YPLNenZn9eqsbfs5Mn9jEKs4ncQfKyP26OvZ
         mx7+CLhgpz8B/VOYxzEL+G8IzFxyfUMOyELK5/+DixXa87E2QfFWHwYSWFs7X0I7OcgQ
         bpq4x2rcF6KFCHyYvPj2nZMKAz/q5rYF8D8r/xM0DcOFfxkaT7gn50yJG5e9fZe7wHAv
         sXtw==
X-Forwarded-Encrypted: i=1; AHgh+RpuwkdrXg5VHyUH5WdjbO3GzozNdTNnbdUxpik+Lh/V1g1fuq8qd1lMmwqmXIRR4R0ScdpeCrJvY2hzOsqg@vger.kernel.org
X-Gm-Message-State: AOJu0YzR16+PAEO9EJTRtR4q7KcO4BLdaPvVED/HpIkM7YoBvIraZUfV
	TfQkD1YVLcyPHXli537Uzaii9gnMAIquti6XfDKtR/6S3SeddPENkmzC9RIbVS5vUQQ=
X-Gm-Gg: AfdE7cnk+QKBPRBOsNlw9nknkatYOLX1uIPnnXiczbvtkS7/p52C19EbhW1QUNce2tK
	8POViw8Zvg94newkQafYY/UNX6EsrRsOJFkcTX9fJmUFrjvk6VPgyG/CHSeg6Esj3GRspUlbhko
	hZBSGNMzPI2yrDht4dShETuPR9iOl0rK/xlHvEjo+TNiITnNr2UOq54G5PSX3VfLg6RkQjbqHo0
	wUWmwuU++wp6cTF5EtWpeMKC0qA2/D4EouZ6uzmn2+O9yau4suq6EazeRSqTaAktcPuRYpyZfPs
	GuUHbZGM5mk8bZuHEXiu50TkEJeSveMjrH66eEIW0/6KyVB3kopNIs9DhYnp7aFjfdoHh127A0A
	DU/rxYQ9Eqc5wDJoOm4yNyl61L1K0yDR5M81Y1jl1ZP5X42PBevPKf/SSh1mG1WigLOrYIPoomK
	V1r8lD3JkHjc69Bu8=
X-Received: by 2002:a17:906:2b50:b0:c0d:2ab6:806c with SMTP id a640c23a62f3a-c128726756dmr164000166b.33.1782829939666;
        Tue, 30 Jun 2026 07:32:19 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-476792758aasm477614f8f.11.2026.06.30.07.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 07:32:19 -0700 (PDT)
Date: Tue, 30 Jun 2026 16:32:16 +0200
From: Petr Mladek <pmladek@suse.com>
To: Zelin Deng <zelin.deng@linux.alibaba.com>
Cc: Miroslav Benes <mbenes@suse.cz>, shuah@kernel.org,
	linux-kselftest@vger.kernel.org, live-patching@vger.kernel.org,
	mpdesouza@suse.com,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH] selftests: livepatch: unset sub_make_done in case top
 level Makefile be overwritten
Message-ID: <akPTcJjrIAI1ZNyH@pathway.suse.cz>
References: <20260525083721.27857-1-zelin.deng@linux.alibaba.com>
 <alpine.LSU.2.21.2606191638540.26638@pobox.suse.cz>
 <ccfed9b6-9a73-4299-b305-da7b593a52fd@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ccfed9b6-9a73-4299-b305-da7b593a52fd@linux.alibaba.com>

Added some people involved in "filechk_makefile" feature into Cc.

For the new people, see the whole thread at
https://lore.kernel.org/all/20260525083721.27857-1-zelin.deng@linux.alibaba.com/

On Sun 2026-06-21 22:36:24, Zelin Deng wrote:
> 
> 在 2026/6/19 22:42, Miroslav Benes 写道:
> > On Mon, 25 May 2026, Zelin Deng wrote:
> > 
> > > After I did: make kselftest-all in top level of kernel source tree, top
> > > level Makefile was overwritten by auto generated contents by
> > > filechk_makefile:
> > > [root@emr: /home/shiyu.dzl/linux-next]$ cat Makefile
> > > export KBUILD_OUTPUT = .
> > > export KBUILD_EXTMOD = /home/shiyu.dzl/linux-next
> > > export KBUILD_EXTMOD_OUTPUT = /home/shiyu.dzl/linux-next
> > > include /home/shiyu.dzl/linux-next/Makefile
> > > 
> > > Top-level Makefile export sub_make_done=1, leaks into unrelated re-invocations
> > > of the top-level Makefile when recursive descent through selftests -
> > > building test_module of livepatch. That causes KBUILD_EXTMOD setup to be
> > > skipped, which leads to a relative/absolute path mismatch in srcroot vs
> > > CURDIR, falsely setting building_out_of_srctree, and ultimately overwriting
> > > the source tree's Makefile with a generated stub.
> > > 
> > > Clear sub_make_done before re-invoking the kernel Makefile.
> > > 
> > > Fixes: c4bbe83d27c2 ("livepatch: Move tests from lib/livepatch to selftests/livepatch")
> > > Signed-off-by: Zelin Deng <zelin.deng@linux.alibaba.com>
> > Adding Marcos and KLP ML.
> > 
> > I cannot reproduce and I do not understand it much from the changelog (I
> > am by far not a Kbuild expert). Could you share the exact steps to
> > reproduce please? If I just run 'make kselftest-all' in the top level, it
> > passes and livepatch test_modules are not even touched.
> > 
> > Miroslav
> 
> Thank you for replying.
> 
> Per my understanding, to build livepatch test_modules KDIR must be either
> set explicitly when doing 'make kselftest-all
> KDIR=<path-to-kernel-build-dir>' or have the kernel devel package installed.
> Otherwise the compilation could be skipped. (see
> tools/testing/selftests/livepatch/test_modules/Makefile)
> 
> KDIR ?= /lib/modules/$(shell uname -r)/build
> 
> ...
> 
> # Ensure that KDIR exists, otherwise skip the compilation
> modules:
> ifneq ("$(wildcard $(KDIR))", "")
>     $(Q)$(MAKE) -C $(KDIR) modules KBUILD_EXTMOD=$(TESTMODS_DIR)
> endif
> 
> ...
> 
> Here're how I reproduce the issue:
> 
> 1. pull linux-next, reset to HEAD, for example
> 3ce97bd3c4f18608335e709c24d6a40e7036cab8 (tag next-20260619)
> 
> 2. at linux-next tree: make all -j$(nproc) && make modules_install
> headers_install -j$(nproc) && make install && reboot
> 
> 3. at linux-next tree: make kselftest-all
> 
> 4. top level Makefile in linux-next has been overwritten by
> 
>     export KBUILD_OUTPUT = .
>     export KBUILD_EXTMOD = /home/shiyu.dzl/linux-next
>     export KBUILD_EXTMOD_OUTPUT = /home/shiyu.dzl/linux-next
>     include /home/shiyu.dzl/linux-next/Makefile
> 
> it is a stub generated by filechk_makefile.

It seems that "filechk_makefile" has reached mainline in v7.1-rc1,
see the commit c9bb03ac2c66bc5aa81b ("kbuild: reduce output spam when
building out of tree").

The commit message says:

<paste>
    The Makefile is now created even if the build is aborted due to an
    unclean working tree. That should not make a difference in practice.
 </paste>

It seems that is actually makes a difference in the livepatch selftest
case.

Sigh, the Makefile rules are a maze to me. It is possible that
we do something wrong in
tools/testing/selftests/livepatch/test_modules/Makefile. Namely
with:

ifneq ("$(wildcard $(KDIR))", "")
	$(Q)$(MAKE) -C $(KDIR) modules KBUILD_EXTMOD=$(TESTMODS_DIR)
endif

But I see "$(MAKE) -C ..." called in many other makefiles.

Best Regards,
Petr

> I'm not quite sure that it could be related to my toolchain (like make
> version ?), I briefed analysis the root cause on my environment (KDIR
> '/lib/modules/7.1.0-next-20260619/build' which actually a symbol link to my
> kernel source -> '/home/shiyu.dzl/linux-next'):
> 
>   1. sub_make_done leaks via environment. The top-level Makefile sets export
> sub_make_done := 1 after its first-pass initialization.
>   Because it is exported, every child make process inherits it.
>   2. livepatch test_modules re-invokes the top-level Makefile. The call
> chain is: top-level Makefile → kselftest-% pattern rule →
>   tools/testing/selftests/ → livepatch test_modules/Makefile → $(MAKE) -C
> $(KDIR) modules KBUILD_EXTMOD=..., which re-enters the top-level Makefile to
>   build an external module.
>   3. The inherited sub_make_done=1 skips critical initialization. The
> top-level Makefile's first-pass block (ifneq ($(sub_make_done),1)) is
>   skipped entirely. This block is responsible for correctly parsing
> command-line variables and setting up KBUILD_EXTMOD-related paths.
>   4. Path mismatch triggers false out-of-tree detection. With the
> initialization skipped, srcroot and CURDIR end up with mismatched values
> (e.g.,
>   absolute vs. relative). The comparison (ifeq ($(srcroot),$(CURDIR)))
> fails, so building_out_of_srctree is incorrectly set to 1.
>   5. outputmakefile overwrites the source tree's Makefile. Because
> building_out_of_srctree is set, the filechk_makefile rule fires and replaces
> the
>   real top-level Makefile with a generated stub containing KBUILD_OUTPUT,
> KBUILD_EXTMOD, and an include directive.
> 
>   Why make -C tools/testing/selftests/ all is unaffected: it enters the
> selftests directory directly without ever executing the top-level Makefile
>   first, so sub_make_done is never exported into the environment. When
> livepatch test_modules later invokes $(MAKE) -C $(KDIR), the top-level
> Makefile
>   runs its full initialization normally.
> 
> Thanks,
> 
> Zelin
> 
