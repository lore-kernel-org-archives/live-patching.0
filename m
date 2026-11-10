Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794314735;
	b=xyC8jzigCHBid0oPIhPt1D7wTpocGjEL7sOz5pyFGU6aewOYfQvFLYW/+eei7/DHEXfz
	 hXbCMufxPuodvO8O1UZpVj6mKQOaPHIdpdEMrw3oFE6vhayVVQ9ROLiEq/4cnRVqcR2++
	 zzu3boI2DSRMaCDJezX1Cqd51h3vd4oQQZY94QZ6VnIPQadLNjKQITC108d+/YWHVP/H8
	 PHXcwfX0p3AJj6ZmoDFsVro9HpnrdKPYPOW9D0GJ+WovXOP0FfJ9x83qvw7Tj66WCET9J
	 RrpylwW2N82XYsjuDXW6IXuVA3hCs/nEb5wfQWhv4/jr0ZOPXSv2lhcBR1y/SSFd1ZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794314735;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=BfINIDbdnp5YQZaOFA3yDq3s0AajpyTCWSTrx1kczfw=;
	b=MO6AG58qVjFDsPFFDUOJrLLBwZ2meSR9h1Alg1HT1BXLCcKtKTzvYa3/zcEQkpJ9Sb0f
	 JzebDZuUOEUefZKRq3mfyTy888qILQ/rxjejuO21Yz4kyoAZns8ev4rSuAUqYOokY2OLu
	 XX1I8ZFMb5WsjdES8J7FAXBQ1527fDoXnhV2wkJqATSnIrTLXj7C1Jmd70nxSLtt7Pao0
	 HmSbYAzDIO+UL1WuWxLGp7Gxw8M+x3EfU1cBk7MHFGoj6FArGfdytlyZSykBIjmhjwxMB
	 76Uh15XaHsBB4I8JglLw9UyI71EGCGDLHT0WbNvpQnVAjFdzpobOQiOcIF4/HrZiKRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=dEcZUNmu;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CE7606A32E
	for <live-patching@vger.kernel.org>; Tue, 10 Nov 2026 12:45:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31CE7606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=dEcZUNmu
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a549cd7fd2so18195135e9.0
        for <live-patching@vger.kernel.org>; Tue, 10 Nov 2026 04:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1794314733; x=1794919533; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BfINIDbdnp5YQZaOFA3yDq3s0AajpyTCWSTrx1kczfw=;
        b=dEcZUNmuEyvW10CwwvMzlj73emtXK/fpU4H7CvDEry6gD8AmS9pMZBCHmGO+rTr/6s
         a1jZcXSIrGxQ4/dzRn/1Oi5yj6+AZa7H3S8HLfDHBQdEeXVaLy5gTLgTxKfPDzwEq+Lo
         MV0NN62fzU+Phg8hUPH89UJplWl6wCql6scAU2ZeKnhmTEcoeGIQNq3BJIwCn/qvG40M
         kL8idh1jg7BqKcTWM+XNKEweNrzQKtqQKHke4sOPAlA84d3EDAAjBHFIUI1vnWn6dAzH
         PHmcCoK9PmgLWAIOXwtUyNVQpLn61o3FhsjUXL50KIAUjEKUaF0BJ/zsdWY5WeJSu+Pi
         wJVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794314733; x=1794919533;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BfINIDbdnp5YQZaOFA3yDq3s0AajpyTCWSTrx1kczfw=;
        b=DQ/Izr+wySH+ZTBIFuredxsaZfLkxvhpnHd7/FlPvxESMA3u2Nnxu0ZKyfa666Y1NH
         YOiajKjc1REphRh0jWwPbPNgEJNahxvgqkQdO/JoBuWrsrVOMTJeo0nYJ3CaytctgBV9
         a33WkZrrThApXXNUScp8zWVBv18M+snlq+SNdvpWkxNPHYXZe8J8tpoPjqDP2UuH1klZ
         XDg9KNthXBG3zPXWiQfPnmGyBAyWEJqtt4KLIRXrdB7aIdywQQdWrhwdFQxavtl3sKOg
         txAlC3sYOhvMcRyiRWwFtLCBfcqIQt3CAZ31JSb6eh+nGXvZALMnA0y+8bDAGyAoP4X4
         f6rQ==
X-Gm-Message-State: APuU4Z+xwM9NUH1NLf0xi37tAVHmxQrPjNKnsZrTHc6bw/wwVgO1E8gm
	nYN4mp3LZyF7SdkgbEd4Ox2ViA9OWSyluA6DbwAOUACMR1VzmLuRe+Uz4cRvv9NkcNM=
X-Gm-Gg: AYBFou0i99HYsf498WfH7qqKvQKmRQIbfZM14ke3kv0RQ4E978lP8GZ0CSC/sEjnFUG
	E9SNB2GxVlKsJVmPTgXk1kmJsLffq1BUL2XmHEG3rbGM/Y6HX7cBdwkfrUl1tP7oELTkxLp3JUs
	FCYms5aeC+lEq9Ez7U7ofIS+qo2BH8mdwEUAKRNVKuR1rpvLPlyeaJKNmOpXqScYE9lxt24RE8+
	LnE+CqRCPTzExezj0Ihfuf8bQF9Ha37Dg1iK9dUHYXSq1o4FbtaI9I+xPstQm8OWda2YCMlDwVt
	h6JLZ4Dmak6Ps1aYl0ovR0ICrSaFU+ZJJaS8USaSiVB9hUxhsAb0jVATWl8EVPs6m3UUcJPbfrX
	Fah3mM31AaMf8nwfR6r5HlMunKrs62twTBPHr5ZbeqzkfYxgRcoPo9fOICLet3boR2PFQGfVKqk
	hKftASeb6/IRpGYmarC1NJPNo+dJfqjIOQKCaZxwzwYWoF3OdNXLPB7+XRFG4S75uFn/dymJZcn
	2QIBtdVL1eseDANMxv0NdMMq9S8EdUeeFKk4TuBc5Ov5AHI6l3O9k1JigWxL15CXet9wCpqlNbN
	zA0uodKCyDx+N7GnLYVnAGeRsJfC3XMerEQ3Cq0UDbdfYw0=
X-Received: by 2002:a05:600c:6087:b0:4b4:a551:681a with SMTP id 5b1f17b1804b1-4ba0233cbbbmr40551245e9.3.1794314733553;
        Tue, 10 Nov 2026 04:45:33 -0800 (PST)
Received: from pathway.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba02005946sm70546095e9.1.2026.11.10.04.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 04:45:33 -0800 (PST)
Date: Tue, 10 Nov 2026 13:45:30 +0100
From: Petr Mladek <pmladek@suse.com>
To: Song Liu <song@kernel.org>
Cc: live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
	jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz,
	joe.lawrence@redhat.com, shuah@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/12] klp-build: Fix dependent patches, add selftests
Message-ID: <avMR6tKwddVBrkpk@pathway.suse.cz>
References: <20261028214534.1919398-1-song@kernel.org>
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
In-Reply-To: <20261028214534.1919398-1-song@kernel.org>

On Wed 2026-10-28 14:45:22, Song Liu wrote:
> klp-build fails when a later patch in the series depends on an earlier
> one, because it fixes each patch against the original source on its
> own.  Patch 1 fixes this by combining the patches into a single patch
> before adding the #line directives.
> 
>  scripts/livepatch/Makefile                    |   3 +-
>  scripts/livepatch/klp-build                   | 137 +--------
>  scripts/livepatch/klp-prepare-patch           | 277 ++++++++++++++++++
>  tools/testing/selftests/Makefile              |   1 +
>  tools/testing/selftests/livepatch/README      |  16 +
>  .../livepatch/test_klp_build/Makefile         |  26 ++
>  .../livepatch/test_klp_build/functions.sh     | 149 ++++++++++
>  .../livepatch/test_klp_build/run-tests.sh     |  68 +++++
>  .../livepatch/test_klp_build/test-basic.sh    |  93 ++++++
>  .../test_klp_build/test-cancelling-patches.sh | 102 +++++++
>  .../test-independent-patches.sh               | 124 ++++++++
>  .../test_klp_build/test-line-directives.sh    | 175 +++++++++++
>  .../test-new-and-deleted-files.sh             |  94 ++++++
>  .../test_klp_build/test-offset-and-fuzz.sh    | 120 ++++++++
>  .../test_klp_build/test-patch-not-applying.sh |  73 +++++
>  .../test_klp_build/test-unsupported-files.sh  |  30 ++
>  16 files changed, 1366 insertions(+), 122 deletions(-)
>  create mode 100755 scripts/livepatch/klp-prepare-patch
>  create mode 100644 tools/testing/selftests/livepatch/test_klp_build/Makefile
>  create mode 100644 tools/testing/selftests/livepatch/test_klp_build/functions.sh
>  create mode 100755 tools/testing/selftests/livepatch/test_klp_build/run-tests.sh
>  create mode 100755 tools/testing/selftests/livepatch/test_klp_build/test-basic.sh
>  create mode 100755 tools/testing/selftests/livepatch/test_klp_build/test-cancelling-patches.sh
>  create mode 100755 tools/testing/selftests/livepatch/test_klp_build/test-independent-patches.sh
>  create mode 100755 tools/testing/selftests/livepatch/test_klp_build/test-line-directives.sh
>  create mode 100755 tools/testing/selftests/livepatch/test_klp_build/test-new-and-deleted-files.sh
>  create mode 100755 tools/testing/selftests/livepatch/test_klp_build/test-offset-and-fuzz.sh
>  create mode 100755 tools/testing/selftests/livepatch/test_klp_build/test-patch-not-applying.sh
>  create mode 100755 tools/testing/selftests/livepatch/test_klp_build/test-unsupported-files.sh

I am sorry, I am overloaded and do not have time for a proper review.

I just see that it adds a lot of new files. And I wonder how much it
shares with the livepatch selftests. Would it make sense to put
it into a separate directory, e.g. tools/testing/selftests/klp-build ?

Best Regards,
Petr
