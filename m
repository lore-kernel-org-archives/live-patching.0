Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795442917;
	b=Ezc+0OjlY6Y0SAanHkB9g0/R9r8yY4td9AAnrvSEUeHgp+GIeGXwXyUhxDxL5Y9e5DqJ
	 s4mbGlK83r8a07k/WPU+WvPuWauySj+/p0tq/8bireQwaTzFf/inTxHXmngsTHtxsBoTC
	 H6feZ0M9AZ8XJzkhNIUn5Lgp453A5acckenO/9lNHY+onhUU74Vz15eiRKzAjUbeO4bci
	 tTPdhkoiB6OL5cme71MmkVwpWsqbROrhksA+wWQYwv07JjguEDCbnE5faaT5LNykefsPc
	 G3gLE3w8FxF02Bx+jcu0bknYcP+b1IzuZyuQWxwT4PElp3Q3rQabc3+xuyaBgVC6WHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795442917;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=cIjP56CWq1uSih/XHWmZxfycsoSnaUHygNNyREh/BjU=;
	b=VImFqzKpGBjEeT8M+QOsMFhq6pyoyMlw4v2Vhr60nrSZQ4WjqOFyDP35jWrekCZm8J7T
	 uuBCP5BAWNJIlCsFS7YwMdXKLqzVsHHp52E4X0OnQ7wD2pQUxO2EhqBus+8wuMacTXXDo
	 6Z1TK5LDK1k8BkwwDVeKPu7VgHQoU2HftnggGEWe+x8GS3BXxOKNyrVlSrBlxqwRCsUL6
	 Tkoh7orRBG4yk7X76hjvCuBQZV99revjAxx8v4pEOBxMyTEZV9AAfENfZNNTvjnGFk9ES
	 gYhYa+99VKkwT+znhI0wPa7UvaBmAQdKpzBZsmM3l3E3JdcBt30mgK0TfinJIh9UZqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=P49OwYaH;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD7B606A31E
	for <live-patching@vger.kernel.org>; Mon, 23 Nov 2026 14:08:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FD7B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=P49OwYaH
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4bb6adaf0f1so29242435e9.0
        for <live-patching@vger.kernel.org>; Mon, 23 Nov 2026 06:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1795442915; x=1796047715; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cIjP56CWq1uSih/XHWmZxfycsoSnaUHygNNyREh/BjU=;
        b=P49OwYaHRLLk7KNYDU61UIS964Uh2OSviOqQpDqiTrZp2k6SOdhoL+F2K26EIoS3Ph
         SArmyx3r0aK+e20AZ6rtcmL03hdwzJ0FhEiHPebK0zVjak8xzKLJ4kxgAZEcafTE18Su
         l0MB07tQ4xQBPEsTezlzTZ/1WiS4OlWpXvnT+ASayQaWv2A28NRZMnL3j6wgvflUPzSu
         xmi9EgjMsXpxE+i8O0TVwD7Few1FYXX3wpH47CKEDqqCnAEPQ1TpPltEeChOeCPS2Sal
         lMAgCWWgi/xd01JNkU+mr2HrYDETcI73KOf4hXIM+yplg3c/TCKGa1YRX/pxoDeBvfzj
         LGVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795442915; x=1796047715;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cIjP56CWq1uSih/XHWmZxfycsoSnaUHygNNyREh/BjU=;
        b=QpzOqm76BJiFOFp52Ks6CpHyFYIYwK2wRYKAdJ2hszijtvd3dFEWX4xyRmtKO60BkA
         DjtkdyWcI4Jh1aDer1Ky3F89rFWgw7ieoqoOT+d4WGaog18PWPJpfVJRYzVZLKruf5R0
         QqC/cZlIhVSDNKuja8BihTBVGBmy8g3WETHbVD2yVhyn8ceb89iKZsTCI/FRl7mSFRzB
         qGBTQxW8JKTfO3wucLk4I6aEBm9+FGlZPX3n4Re/XUUm+Wjd0OL00eEFXmMIjVwEZUvC
         Jh/J9FFmK9PckqZGSjvPxDtVz5D2F+ktVKiCbPs2W+GW8Z9P757j8NZwUcjkREYEySuR
         wu2Q==
X-Forwarded-Encrypted: i=1; AL+hErG8HXAcw5l5NwfT3jSFex/k21ZX8/l9Vu5LIgANVbfcXaDnLK4mqSDcTdeNJeeX2rk0GEo610/RfkLJ0Yc2@vger.kernel.org
X-Gm-Message-State: APuU4Z+TI/0d7Df/e0Arl+jsef6gAyCsaRXuRQJ88EikIhipTOeGKQLI
	A6mSzmiCBuWCEoxCvtM4iw9Cqnw97ANYTyea6BCsMWN082EYhRm5wqYrErHkSdOBT5c=
X-Gm-Gg: AZFdTZd6ne1lVGf5I9MLMeVOmBfLuKHMTF3vHbBNi4DOJItqJvZ4iga66taQFnX763L
	JQM0tyAQ4ackvrg8k81SEUSmYpJe7pztlTKIhxiVY63GPxPGkXXoKCx5jDpOywWn14q0Hzi7wMv
	wgsZd6yhhACa9ITEGSkuWi9wfKiIpLNWz+jJfnIXoV0mIVOqTQoNaupp71bANZl2Wzrm6doKFXn
	wJU6hipjlMPJ1zCJTFkE8jcNzlFpaSs23no3slMfl7IxzyGN4e4LQMhn4pL3QoSaRZiVwyyRZbC
	OunA1AFmmBaTtvFRteIj2bpEqa4tFWKM1HTAxweFqUq6TkinHSo79TN4Eq5PNbY6v8UnMYMqUzQ
	Z5lVGyJvwTXMf1zhNF7ZJ9gV7MTJU7/MtWPp/3f7Z0ZuC2A3aAf2ADrlkIGkBtw9vrdfO7ac2ej
	DMvBCShliabJUBDmnWC3Dbepr+NXz/8i4dJ2lKKcVzCmexbQZIhnYcdLrxvsfw+XBnHtzrDlMe5
	KmUgIwx5zzzG0mNZZixzU1Wm2NBXs73zqE+2U/r4ziBI95M3Z7OugENOGQuZJho/Eg1jW6s3ZPn
	SJtiyAthU7jt43R1upDY0zD7zyjNFSg=
X-Received: by 2002:a05:600c:1546:b0:4a1:fc98:1cb1 with SMTP id 5b1f17b1804b1-4bb887c2cb0mr263882625e9.2.1795442915456;
        Mon, 23 Nov 2026 06:08:35 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb895eec06sm136102075e9.2.2026.11.23.06.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 06:08:34 -0800 (PST)
Date: Mon, 23 Nov 2026 15:08:32 +0100
From: Petr Mladek <pmladek@suse.com>
To: sashiko-reviews@lists.linux.dev
Cc: Sasha Levin <sashal@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Joe Lawrence <joe.lawrence@redhat.com>, Song Liu <song@kernel.org>,
	Marcos Paulo de Souza <mpdesouza@suse.com>,
	Eva Kurchatova <eva.kurchatova@virtuozzo.com>,
	Yafang Shao <laoar.shao@gmail.com>, Shuah Khan <shuah@kernel.org>,
	live-patching@vger.kernel.org
Subject: Re: [PATCH v4 3/4] selftests/livepatch: build the test modules
 against the kernel in O=
Message-ID: <awRI4PbBHGtnNijI@pathway.suse.cz>
References: <20261110161050.2451750-1-sashal@kernel.org>
 <20261110161050.2451750-4-sashal@kernel.org>
 <sashiko-outbox-207425@kernel.org>
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
In-Reply-To: <sashiko-outbox-207425@kernel.org>

On Tue 2026-11-10 16:53:01, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] selftests/livepatch: KDIR fallback ignores builds without
>   Module.symvers
> --
> 
> commit 62f70537bbca33262ec62f1273becbdf534f58fc
> Author: Sasha Levin <sashal@kernel.org>
> 
> selftests/livepatch: build the test modules against the kernel in O=
> 
> This commit selects KDIR from O= or KBUILD_OUTPUT (or the kernel source
> tree) before falling back to the running kernel's build directory, and
> strips O= and KBUILD_OUTPUT when invoking the kernel Makefile for the
> livepatch test modules.
> 
> > diff --git a/tools/testing/selftests/livepatch/Makefile b/tools/testing/selftests/livepatch/Makefile
> > index a080eb54a215d..97478ef90945c 100644
> > --- a/tools/testing/selftests/livepatch/Makefile
> > +++ b/tools/testing/selftests/livepatch/Makefile
> > @@ -1,5 +1,31 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >  
> > +# The test modules are built against the kernel in KDIR. When KDIR is not
> > +# set, use the output directory given with O= or KBUILD_OUTPUT if a kernel
> > +# was built there, as with
> > +#   make O=/tmp/kselftest TARGETS=livepatch kselftest
> > +# otherwise the kernel source tree if the kernel was built in it, as with
> > +#   cd tools/testing/selftests/livepatch; make
> > +# and otherwise the build directory of the running kernel, which its
> > +# devel files provide. A kernel was built in a directory if it has a
> > +# Module.symvers.
> > +ifndef KDIR
> > +KBUILD_DIR := $(firstword $(O) $(KBUILD_OUTPUT))
> > +ifneq ($(and $(KBUILD_DIR),$(wildcard $(KBUILD_DIR)/Module.symvers)),)
> > +KDIR := $(KBUILD_DIR)
> > +else ifneq ($(wildcard ../../../../Module.symvers),)
> > +KDIR := ../../../..
> > +else
> > +KDIR := /lib/modules/$(shell uname -r)/build
> > +endif
> > +endif
> 
> [Severity: Medium]
> Does checking only for Module.symvers cause KDIR to fall back to the host's
> /lib/modules/$(uname -r)/build when the target kernel in O= or the source
> tree was built with CONFIG_MODULES=n or an image-only target (which
> produces vmlinux.symvers instead of Module.symvers)?
> 
> When that happens and the host has kernel headers with CONFIG_LIVEPATCH=y,
> test_modules/Makefile reads the host's include/config/auto.conf and builds
> the test modules against the running host kernel instead of skipping them
> for the target kernel, which breaks cross-compiled builds or builds where
> the in-tree test modules use newer kernel APIs than the host.

The problem looks real. But I would consider it a corner case.
IMHO, there are only few users using CONFIG_MODULES=n. They
might use SKIP_TARGETS="livepatch".

By other words, we could fix hit later when there is a demand.
You would not block this patch because of this. It fixes
some scenarios and goes in the right direction...

Best Regards,
Petr
