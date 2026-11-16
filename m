Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794841345;
	b=ioFqWKjEm6aarWIPB/JBH93+qo3erzEGMfzepmrY+AoH3kXaJPP3sVgEjf6AhJBTqwCC
	 87OYT3RU50diugH3URZ5kUqAreC8J9D3QY016JkqikNyISQ92jHRDTo2peUngwV8hyo0T
	 fC/swdv6tkJk7KXRfrC/rf++ff6yqmIB5peLeWSqPi9pV5AFG6cGNFh5Im8javAHGaNvh
	 tlg6s3HSjjvVdgOdSnEYeA/hMeBFpMkhPqU3shXsiRMsT1LYx3hyA1JvKdnazn9qB2WPL
	 glfhojYqWIe4+ZNOYQhBkH8mVlicOWf1VLtsJXMdjbFxX/u700bciRB6jQCZ+uIkXOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794841345;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=N21p8k+CduSxruihuSfvb91U5CN+g/FwS5B3MC7guXw=;
	b=FjbmyhwgMRH3ynLWQVVom9OJiPdU+A02719ZHY0Laqo6rEwZgHfc7YqQtEsQQWFoDjPs
	 PDps5xmJibU2akVh3SXRw23ynl8Ipqbo4IzqwMUsB2XZfpmzRph1zKHnM7CQKCH2j7zO8
	 H0V4gtCuOpq/sjPHVtUtPctUDovuO1HoLdop1cfUhQV0QsE1mnq7TD4Xq5tBiH4LH1nGh
	 8Ov3rwei2Icw1SvBdfpnYhmIVVhds45rMIajnU6m5+CJhLrbCVZayh38RhiYBBnbox/WV
	 aZD6Ytw6JcH9WHPWiWg+/wU+bSXmUFIO37Q1/xjiWumzkTOy5mjtcM24tRx1nosehAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=AKprLcnW;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF3C606A33B
	for <live-patching@vger.kernel.org>; Mon, 16 Nov 2026 15:02:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BAF3C606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=AKprLcnW
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a1fbd52ab6so28207845e9.0
        for <live-patching@vger.kernel.org>; Mon, 16 Nov 2026 07:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1794841343; x=1795446143; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=N21p8k+CduSxruihuSfvb91U5CN+g/FwS5B3MC7guXw=;
        b=AKprLcnW/Vw0JBEGVtDSBHNkSuYiTwhekWo51MsaelVlg2ca/TKcyY7DbKK+aKmiFN
         ErmJMQmBgQnkFBE1tra+njmU4a8/BTbf4WNlXdtm6cL6/Lnmkhx4XQQENncfvcqgHUgv
         ITk8jT3qdnEHARDwEFOjsIMDDMgOWdOQ279O8cvzGPnJRQLqu9t/Eb3Ob5l1xbpPvHX2
         ahjjxusft8moSBk5iuM/yCBQ2L1rV4DYFUJ+6WiIjFqYttIXx0BnT5RwJ9D5hiPtaBJy
         05Tpt2HichRwP/z33xtKDYIwEupyQtxaZZ6cUtAY8uodN9v4tfv/IybYcFlOzqM8icrO
         lXNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794841343; x=1795446143;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N21p8k+CduSxruihuSfvb91U5CN+g/FwS5B3MC7guXw=;
        b=NjdgUeJKBZrxdvFb8L0WqNp56bWZepf8igwUzY5BjQlga9UDsaqN/Vo5rFXWHpy2+5
         uKTvrvbFaY+/7NVTwO7/mEkhu4p8wc3XkCI2B8pRYcv/3QmKXeX7Ji7Lq/cFE0iL6WYZ
         fH6Me7f12xrrb2V7CvTe9rAVneAEB1DJS37EAfTyfqOH/X5veTOzTDk34wqQRT60iabl
         zuMb8wVoGPqZZ4u/mrbbigJBQJXz+gP4ONUfMKEOBTvngpdnTNO85zaYb32E7VHC8/+V
         Sk+7jC76pVEmpc2Y0KpmuUuIEdpDt5H+KfaxwnMS4BjO4bulUFmxQGyPIgDL9k+50Usj
         7f/g==
X-Forwarded-Encrypted: i=1; AL+hErGeAZ2K4MFM95V3+QrlWI4uqOl53AJ6BLUI9HzxBKZi67BjDrs/VIw39E9iN28K7IKbKegHJSoOCBFeezv1@vger.kernel.org
X-Gm-Message-State: APuU4Z/N5kimoqsswMguG40cjg1eNKJq2BMfGRrO+nEJ7zp+C8xg/aM6
	ip8eRZpLne3WCJV0Yd5ISSuVh+yJ4/h/5SlD6ZgzmMjHbNFGmbakuircCPT3zrqOEyU=
X-Gm-Gg: AYBFou1AVVEe3OSuDFZbDAu2WykIvQGXYRs8fjetQOr4PcYunWttntn1QyvuOgx30aA
	RHFpaW7oLUwQkcIJWWqMINL3rAZ6vEnvlEYeKjR+UkCSuce1D1xrjSEr3Shs2ykeMv8mR3nsOJV
	6PccfQSYihjheFJKE5flW2PJNY/QcSFY0otjiwRWCMNjpbqvWiiJxF8gTKUnuZ0TgHvzWRYAKcz
	W9y2etBOrIbRUAgeHFmwoC7QEsQBz94rTLvq3PntDIty0H7/eeruc+iLo8bWtDqZ+FseruHctmA
	3i9kNVv1zb9taAhpeYHLABkpvn3aHDmHhRsIoHfxIN4CHjvwSDLucLt3693+JwBfaH4aaAwl7zg
	Wa5G3vopD+/kEcPPm4BZgpK1uAtVsRVU9O1U9Y0zWSz8AFTlCV48QZ6/Ud0fzSYgiYZ8+LTqTbg
	ckiOdug49/wld1a6XL7UOt90xDMPB8Qojo/cjvnnSBhHu/L7lPMomF4kPSW6tvtnRQcibsXJ3Vd
	bPrxnDNLHeSXJuQV3HrVCZ16AJjv0lr9bvCNRoUWSUOQ6h05iU4+k4HDH5mmXmScr7pLXV/HrCV
	nfjTa4P+BE6/2zbMqfq/UOsx3wdx6KI=
X-Received: by 2002:a05:600c:8819:b0:4a1:d8fc:8165 with SMTP id 5b1f17b1804b1-4bb55a6ad4emr208585635e9.20.1794841343209;
        Mon, 16 Nov 2026 07:02:23 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e2adf53sm406661285e9.15.2026.11.16.07.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 07:02:22 -0800 (PST)
Date: Mon, 16 Nov 2026 16:02:20 +0100
From: Petr Mladek <pmladek@suse.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: jpoimboe@kernel.org, mbenes@suse.cz, joe.lawrence@redhat.com,
	song@kernel.org, live-patching@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 0/9] livepatch: Add support for scoped atomic replace
Message-ID: <avsa_Fq32BH3pRpW@pathway.suse.cz>
References: <20261026133651.40061-1-laoar.shao@gmail.com>
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
In-Reply-To: <20261026133651.40061-1-laoar.shao@gmail.com>

On Mon 2026-10-26 21:36:42, Yafang Shao wrote:
> Atomic replacement is currently all-or-nothing: a livepatch with
> "replace" set either atomically replaces all previously installed
> livepatches, or - with "replace" disabled - it replaces none. There
> is no way to atomically replace only a selected set of livepatches
> while keeping the rest running untouched.
> 
> We previously proposed a BPF+livepatch method to enable rapid
> experimentation with new kernel features without interrupting production
> workloads:
> 
>   https://lore.kernel.org/live-patching/20260402092607.96430-1-laoar.shao@gmail.com/
> 
> In the resulting discussion, Song and Petr suggested that it should be
> possible to selectively replace or skip individual livepatches.
> 
> This patchset introduces a more flexible model using two new fields in
> struct klp_patch:
> 
> - provides: an unsigned int id identifying the replacement scope of
>   the livepatch. Livepatches that share the same provides id replace
>   each other, so at most one livepatch of each provides id can be
>   enabled at a time. By default (provides=0), every livepatch that
>   does not declare an explicit provides id belongs to the same scope:
>   loading a new provides=0 livepatch atomically replaces the
>   previously enabled one.
> 
> - obsoletes: an optional array of unsigned int ids specifying
>   additional provides ids to be replaced. This allows a new patch
>   to explicitly obsolete patches from different scopes.
> 
> A new livepatch atomically replaces any existing livepatch that
> satisfies either of the following conditions:
> 
>   1. it has the same provides id as the new patch,
>   2. its provides id is listed in the new patch's obsoletes list.
> 
> A new livepatch that does not replace an existing one can coexist
> with it. In this case, the two livepatches must not modify the same
> function, or use the state with the same id. Any attempt to load an
> incompatible livepatch will be rejected by the kernel.
> 
> Previously, setting 'replace' to 0 was the only way to keep
> certain livepatches persistent on the system, forcing developers to
> disable atomic replacement entirely. With the introduction of provides
> and obsoletes, developers now have a selective option to keep specific
> livepatches persistent while maintaining atomic replacement capabilities
> elsewhere.
> 
> IMPORTANT:
> - this design deprecates the traditional non-atomic-replace model.
> - the behavior of replacing all non-atomic-replace livepatches with a
>   single atomic-replace livepatch is also deprecated.
> 
> The new "provides" and "obsoletes" attributes are exposed through
> sysfs and the kselftests cover the replacement and coexistence
> semantics described above.
> 
> At present, KLP state, shadow variables, and callbacks are not
> integrated with the new provides/obsoletes mechanism in this patchset.
> Support for these features is deferred until Petr's klp-state-transfer
> infrastructure is completed and merged:
> 
>   https://github.com/pmladek/linux/tree/klp-state-transfer-v1-iter12
> 
> It is based on livepatching tree's for-next branch.

JFYI, the patchset has been committed into livepatching.git,
branch for-7.5/scoped-atomic-replace.

Note that I have fixed the subject of the 6th patch as
suggested by Josh, see
https://git.kernel.org/pub/scm/linux/kernel/git/livepatching/livepatching.git/log/?h=for-7.5/scoped-atomic-replace

Best Regards,
Petr

