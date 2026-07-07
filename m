Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5023FBB50
	for <live-patching@vger.kernel.org>; Tue,  7 Jul 2026 12:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783426156; cv=none; b=VW8GLyJQVsq+55CyU8flVzdAxXgO3rnk+hBDIaEFgCtTD2H05mDdPGB8U2t1/+dy77SyObFqs/9jkBlV4pVEqOpIlKJc4DJlK+wyxXSif9blDc2KNyOkLYN6wqmSk/RziNm6zxgMb1ABjsp2UZm/1IANe3KP2PIJDklDPgfaxVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783426156; c=relaxed/simple;
	bh=fVfYEpTNglhSvIyOmgIUD5maV4m+lUwPHrhZ1JTHkkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QfcbCiUzB3RoFLnhpdzoDGIhHPRMEXu4tG2ErGvuQOfJFZhP6cx8inZkLhivRnOIc/5FQnBLTZ1GHqAF/Eh0/nGkgkRpcBbkqjA923lifnTBo11qPzbgDApcW90dmk5tlqfn1NdfxubCAbLr8VAQC0wBkCfuraWqbzXFr/oTxG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=d6kAw5Yc; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="d6kAw5Yc"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-493b77b150aso37453135e9.2
        for <live-patching@vger.kernel.org>; Tue, 07 Jul 2026 05:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783426153; x=1784030953; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YgwFvt+gyf1i0Mk0Uq1bpXp9aJg14d/hFwx5zHvGmdg=;
        b=d6kAw5YcvGJqaFrxwr/7gHXtRCf1rVWfqX+Tfe+A+WRA6Aq8Qm2sM3JclgxDn0NFsr
         +sE2HTTjCRD1kLYTa9hZggdGW8QfZy8UrxWTMxcLymKG+/QX8a5K0xCxqEUCM/FVTZX3
         mJ8VzhaR+iREQoNrDbv4EchuG/rB741xMU4d8B0z/fk2TxfHcKRhXVmGLUf7dwnLCOJP
         93H8dhMSxNW2vyfLF1Jv2C+q2iNbTYiOd+LOdLVVzEp1Nt9CtIRAYT4RzVfSwrmso6KM
         gMH8QojV2I6YLUwlTTwAkvvA4JH4Lr/UxI0lkTOOyBIErng7889bGVZhDty8CMGD7UQ6
         wrzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783426153; x=1784030953;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YgwFvt+gyf1i0Mk0Uq1bpXp9aJg14d/hFwx5zHvGmdg=;
        b=PLND+zS0Up+GfRZci41AoYJ17jLUcyI7LWbQT1c14JS1QUHrXn5HlpQy6PAxfnOjhE
         QuxI2bRJDbh5yQ3iFdy16082uB59uHuC2Cdhk4lhbXgbJfvNnUuL/R2qCrtOXojRu33I
         42qUK015BLE/LfD2luEL5cEj+YkAecvbGp07rguSR7YxT9PTCHLiqrGlA9NFA5vWAydt
         jRDFy5O/v8EmwRVG5mhFCW5qdlRhl7c5cplBiuFfC9tFzLrICvjFUU/tmaDNtXTz5WiP
         NQVvGhNbheIPkOdTbkF+3KNtJqGolgdZ0G37nIaTHcl6SrGWDHCkQKYvwCBWJAgf477I
         buYQ==
X-Forwarded-Encrypted: i=1; AHgh+RoVz6LKqnbAfhRGdDQzhXAvQ47F8RpGkmQECM3uxfsPhe9K2kYjSXcQ7woHag1/uW70wcmYCvPHDw4DcOLG@vger.kernel.org
X-Gm-Message-State: AOJu0YyFOPps0bNdiHyqNok1e9cl2BDV47akB+a0V0qHZCt5VbIOPmZy
	OucSdCUMCciFtxws8R6QJ8rz/2hiTxPff+E9eDDoLay7fRlgNmx2Sk/+v5qylWu42Uw=
X-Gm-Gg: AfdE7cn9OJCJ74a3g/bKcreFcY0V3OR2lqqu+OyZ0r1rN3oG4QnJQae4zBk7+FwLe7j
	73ELRerKLYzijpFR8kgSN8DxEj5PIs0bz1IqXrrKS4jwlXMk8sTSyooimFP2S0XqwxkIVZlz7hC
	7Z6AKK/tpkogz2vMhRnEQAtk7E8NmMhz9JM24yc4phNvWslEenWPBB43xR3UGBvqkcAqh4qmEgB
	UayuSYB+2xqFvHdbYVhgvSXgZPRYdDoLXFB9Iz1jyRuVF7GY8dv5DlhKEqpq88KkrldoTHl1QG/
	WmcBfaUK/s1C32AaJX2WG+PvsFDvuIsEN7JRfw0ZogWy6r1vXOneE98J3EM/QWs1b1pXZF4oqFi
	q7Eh4RNnhkoSg1UgRWm0aTkPN0keQ89h0zsSbUFALoFI5FDHw5+jTgOXbUQUFbZkVtFHadz5rwV
	soJxmZWT9oB/WIhuSm6tkkII0GgA==
X-Received: by 2002:a05:600c:3b01:b0:493:c773:c3f4 with SMTP id 5b1f17b1804b1-493df080c43mr49996235e9.22.1783426152919;
        Tue, 07 Jul 2026 05:09:12 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0faed08sm47614505e9.11.2026.07.07.05.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 05:09:12 -0700 (PDT)
Date: Tue, 7 Jul 2026 14:09:10 +0200
From: Petr Mladek <pmladek@suse.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	Miroslav Benes <mbenes@suse.cz>, live-patching@vger.kernel.org,
	shuah@kernel.org, linux-kselftest@vger.kernel.org,
	Zelin Deng <zelin.deng@linux.alibaba.com>
Subject: Re: [PATCH] kbuild: unset sub_make_done before calling kselftest
 build system
Message-ID: <akzsZqEg42GGJ0O2@pathway.suse.cz>
References: <20260703-makefile-unset-submake-done-v1-1-6899248f3d6a@linutronix.de>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260703-makefile-unset-submake-done-v1-1-6899248f3d6a@linutronix.de>

On Fri 2026-07-03 08:04:08, Thomas Weiﬂschuh wrote:
> The kselftest build system may recourse back into kbuild when building
> test modules. In that case kbuild needs to parse the new flags passed
> from the command line, instead of using the ones inherited from the
> kbuild invocation.
> 
> Force that command line reevaluation.
> 
> The same was done for scripts/install.sh in commit 14ccc638b02f9ec
> ("kbuild: cancel sub_make_done for the install target to fix DKMS")
> 
> Reported-by: Zelin Deng <zelin.deng@linux.alibaba.com>
> Closes: https://lore.kernel.org/all/20260525083721.27857-1-zelin.deng@linux.alibaba.com/
> Fixes: c9bb03ac2c66 ("kbuild: reduce output spam when building out of tree")
> Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>

JFYI, the patch has been committed into livepatching.git,
branch for-7.3/trivial.

The problem does not look serious enough to deserve rushing into
an 7.2-rcX. Also it is touching the global Makefile so it should
spent some time in linux-next. Let me know if you would prefer
to get it faster into the mainline.

Best Regards,
Petr
