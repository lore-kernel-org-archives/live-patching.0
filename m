Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E391E1DF0
	for <live-patching@vger.kernel.org>; Fri, 12 Jun 2026 08:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781254558; cv=none; b=khAKKrieefKIufU2/CyFXDG6NrzhLL9LUgQtnbb9xEHffyEYx3qLps0T8b29MFTYiT46Z3cYWD8o1CnohIJo13gaWrhFjHnLfOes/g31YXLutWWZNDs8OhXxZMAn8NWXZ8Mx1qRmqQ7+a5MCYSYIDvDgdyXCZJGEuuPfZT7mWyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781254558; c=relaxed/simple;
	bh=VVyQq4GCj6OjOILfLUDbFd1m9WWzqHeNnmJQ1iuKhF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e+mKsZwA8hnr0VIYZLLrMVZfvGT9GZUsixWKBMwYH4HAjr4D+l+awOBYHwCKp9bPbuFIzdG93r53H8PWkGFufWyxgdOuYSHiZKh8mybHxrBAMHgBahXlGVdVJnp5mrZT+9N9x8jpsLqABjP1bXMES+T6IG/DP+tIj23vqt1/pYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=c0uOjLOq; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="c0uOjLOq"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-45eeea039ebso373293f8f.1
        for <live-patching@vger.kernel.org>; Fri, 12 Jun 2026 01:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781254556; x=1781859356; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jxD1TvZ+1cChI6cLvZWMXQy1tRQBQL7mSDCIMEtY6lc=;
        b=c0uOjLOqHtMxk3EujWAlA7fATYd56eSXHtHTuFZ7k2acYMA4TqT72vUx18XXMjgpVf
         +UkzpIQNkoJrmbt4OSx/jmWiqB8oER9bnOmWFgqA6H7a6Ue+dXY7DlaZEL8p3KJtyig4
         jcvcISiZMVd6GWU0Emy38d0T+vugDf7jqMoQgNyFHZMQmvyZI9WRbCbQGAPxUClnnsr+
         belN3gIwR6JLtPDTOLFWP+oADPEKkI23jcGi2BQ+1xumOz4w4UNTL2NjEgAeI2UbKhUr
         a/5D03OyqcSvfuULbXyRfGE4klVV5Ll4ZmHDr/GxVmxfpMe/HD/+2VBYHzE6XLpjFpNK
         a/Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781254556; x=1781859356;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jxD1TvZ+1cChI6cLvZWMXQy1tRQBQL7mSDCIMEtY6lc=;
        b=RKJDZWFAf5O6Di+VyLJ6nX7c4+vzPNA7Hh5o/VOEZw9C979J+iJJzv0F+R/z0faQ4O
         e7C33nIzHaqjqAcfnN/EJST54sAvpB1qBK6dRQ3jGe8G3kCKLUrDqmz5Ug7s0OnZlJp4
         Xw+xEGZ7k0/KKINvXhbkItdli+p418fb9TkdeTPU8SSHuUlI7htb6ABM4qsRoaqlaqJk
         m19MmHv7qwxIzud3l7m76LLnjonEsHbMywF/3v6aYQu2Yp702h+VUuRNgoMHEi4mz5cZ
         OeB8YyN1Dv/AuCSP72fYpqcjikMqQ5PLD7ZyBtfuzz+rS1Q/vEL3u8D+ObaYMXw5VaCp
         j5cQ==
X-Forwarded-Encrypted: i=1; AFNElJ/wBFtSLXTQ2R/KTK8G7pM4gQHXJUGlxWkAIwpTkhLvviAOSLo6b7/3MLEZ9MKR66x2pdLf+o58eNQ//KfP@vger.kernel.org
X-Gm-Message-State: AOJu0YymMOL1TKJQmuUxnh+lnOCx2V3OOHxYyx+y0Ixz+RdBM3XzqLVh
	ZpWcA0sqTuYVxhzQG9It1B4DwfenkxmiV9Hb+Cw1vddGNlvtbgktbuo5h0qbi0gWSdw=
X-Gm-Gg: Acq92OGNAYSX9HlboVudMye+W5g3lJYY/+mpUNvxEN82Zlj3hly6JxVDpez4pFTUHvl
	5aKi//n7qiz+YsTy4OKzkzzXu84Fd/jv4nM/DlS716khOeBMKOmSHc4tlPaC45rRrS1eZC5pGFH
	nSSCWdr2hUt+Qknt/qomWkGn7M+ywA+yFQ6OzvKZUW+MFq+6xFRAlgLP/WZqnxCffyJsLooEFW8
	3SObdruKIXHLCRpuTByWPoMgulqNkL92DmAxd2XbPPWU1wb2RDZKAAKq6Z57GvU0AXX7g/wcpay
	Opd4SMfq3pgGFS1aT/PZTybr00Su6xz8Hm02pmN86uMoEFOt1Qdeiere6aS82FCgcvfpDqtMeJc
	fyM9vIudjOpQohRHhx9kQsLhklekxb3L+yz9m2p0GmxdIvMFUo/jPbtXHUJT9jZ1amCwuYYqvPQ
	A/d4kzysUiWSH6JcuQHIu3UK4ZeQ==
X-Received: by 2002:a05:600c:4fc8:b0:490:b724:5085 with SMTP id 5b1f17b1804b1-490ec5058d3mr21806015e9.33.1781254555819;
        Fri, 12 Jun 2026 01:55:55 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490ea963cf8sm32515875e9.2.2026.06.12.01.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 01:55:55 -0700 (PDT)
Date: Fri, 12 Jun 2026 10:55:53 +0200
From: Petr Mladek <pmladek@suse.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz,
	joe.lawrence@redhat.com, song@kernel.org,
	live-patching@vger.kernel.org
Subject: Re: [PATCH v3 6/7] selftests/livepatch: Add test for state ID
 conflict across replace_sets
Message-ID: <aivJmcLWkpdWGkzO@pathway.suse.cz>
References: <20260607131659.29281-1-laoar.shao@gmail.com>
 <20260607131659.29281-7-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260607131659.29281-7-laoar.shao@gmail.com>

Hi,

I am sorry I am getting busy with some other tasks so I won't review
the new selftests carefully. They might change in v4 anyway.
Just one note, see below.

On Sun 2026-06-07 21:16:58, Yafang Shao wrote:
> Livepatches with different replace_sets must not share the same state
> ID. If a second livepatch attempts to reuse a state ID already
> registered by a livepatch with a different replace_set, the loading
> will fail.
> 
> Add a test case to verify this behavior. The test result is as follows:
> 
> $ ./test-state.sh
> TEST: system state modification ... ok
> TEST: taking over system state modification ... ok
> TEST: compatible cumulative livepatches ... ok
> TEST: incompatible cumulative livepatches ... ok
> TEST: livepatches state compatibility  ... ok    <<<< This case
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  .../testing/selftests/livepatch/test-state.sh |  34 ++++
>  .../selftests/livepatch/test_modules/Makefile |   1 +
>  .../livepatch/test_modules/test_klp_state.c   |   2 +-
>  .../livepatch/test_modules/test_klp_state2.c  |   2 +-
>  .../livepatch/test_modules/test_klp_state4.c  | 163 ++++++++++++++++++
>  5 files changed, 200 insertions(+), 2 deletions(-)
>  create mode 100644 tools/testing/selftests/livepatch/test_modules/test_klp_state4.c
> 
> --- /dev/null
> +++ b/tools/testing/selftests/livepatch/test_modules/test_klp_state4.c
> @@ -0,0 +1,163 @@
          ^^^^^^^^^

> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * This test is identical to test_klp_state4.c, except that replace_set is
> + * set to 4 instead of 0.
> + */

This seems to be copy&paste of another test module. I suggest to solve
this by defining a variable in using #include, for example,
look for tools/testing/selftests/livepatch/test_modules/test_klp_speaker2.c
at
https://lore.kernel.org/all/20250115082431.5550-10-pmladek@suse.com/

Best Regards,
Petr
