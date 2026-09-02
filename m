Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879C047DD77
	for <live-patching@vger.kernel.org>; Wed,  2 Sep 2026 12:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788350493; cv=none; b=LL4qS2xou9HN7NyWqxZ6ETq/RWdq1hwBPT9Eifqw/MvoNWZjffQn/lWMcA4h5Ct2DqGnSWSFAQwpSGlYnskpsDaHhQ7KWl65/b+V8k+05oGn27Ibkd0LKhRF9sv4OwyJAqGD6/1Z5lSDKt7KbgGS2TkyW5aOBA7MuSFifDf7iHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788350493; c=relaxed/simple;
	bh=eorjDpdSZIV9KUyZ5qS18R73UcNiksESPwdeSjYl6nM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KDNJVEAm73A5ru58dxi8b5R+YcQB4jxe9SWwMdTif13bOEVx4h8GAqlHYpA2so7OwoLu5Jw1osi5r+hjnUKochBV/ozVf75el4OAPS7MDF0phxwDqwgHiaDH/LRBTsBZrcMkB7kEWTZP5x+IjUIYs92Fra8atZzjrENv0vK0EeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RmvOWiNQ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RmvOWiNQ"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49556f97a9dso7220885e9.1
        for <live-patching@vger.kernel.org>; Wed, 02 Sep 2026 05:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1788350474; x=1788955274; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eorjDpdSZIV9KUyZ5qS18R73UcNiksESPwdeSjYl6nM=;
        b=RmvOWiNQIX4Zd6g1t1r429f8CRr4AzqBAfAa0iLkxWn3MSFmeORloHDb3OZ0+3elRc
         Aol9JIjoYzcb9Q6Y5mBDVQYUAJe6lC04QB8gkJBC8p62XZmJZHoPerKYWO5pE6ePawpp
         y/ePFQkcMV2FcQsAZWitUZCvZxPmgLJsHaFIzSMDNzGGbOAJme4DPsujJd2hKIh9TtQu
         MPvGbE+RPC5LLdxuPeIhH6InLQ6877nxBV/pw8a8HjCSesbnUq89pXKDFK4bPSpsSYjW
         rzlRH3xp5L7TcVEHn1NoFsPNDDdvs4F4w1Gr5mY3QyCprw/L1tC4cZ7cUt6L+IrSPD9/
         vKwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788350474; x=1788955274;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eorjDpdSZIV9KUyZ5qS18R73UcNiksESPwdeSjYl6nM=;
        b=YRnjwZPviIxShgQKnrE5GuJ45zGjAJ4jdHyhWuWm36nfnTkqbxMaZ+B4KWP6FRiQ6s
         ifW8VkelY/GwM6TeiAtv93zkvj6VF0Mc8OLWuG/enBq9cvBtXbMP8dOvp5pbBygLmSlj
         f8SHeW9Oci5WyQwZlNgDgszGebJjD8pCY2RuzAGXwxr7I609XcnKKsR9qTTqM6cNEoDh
         vX25W+Y95hheNII1PV4rsJWcMcz7BECmznhe9S7ebGtibMmXqyPRvxa+wDmAs3EHq0ms
         fWWa9TpelOp51inyqkO8x2akFow5qC7n5yu7HZLfyshJ+LFjlV1EFOKXkgwc5slFy429
         RvDg==
X-Forwarded-Encrypted: i=1; AHgh+RrYVGaihbRu/i698URuInKmlJDUCPnebQvEvBbN4KtXACu4MBSKqSsIjockH6G73xz2hfh/TQmQPc1Txt6g@vger.kernel.org
X-Gm-Message-State: AFuF++meoP8IU1mrmolrACQkW2efbBkOTjfykaVJs+nU4Z/c6s6lY9t5
	KpTsqoEB1W2zQ3gahDwRhv98eab0AIvmBPxGMB/FXxxqBdc8v5GfBTBxxtS52EO7dgU=
X-Gm-Gg: AR+sD12Qa/kw4iIxS6V70dlNXh+fI2VdSPsAWOJbLCf1oylfwru3SHnH2bSKHWBoDvH
	zbIoL9ppH4pz5e6B7EXsbKaWGTTcVhXBxXPc635FysdxpXuGpmGOSsyHJJ4KmS99f3OgAeQ0hj0
	6f3E/gr53l2yw7rygE58B0VxR2aXo5FRhkrvlPWxwFn8PGacOKYprvwM/imo7irbiaw9YdXBmtm
	G4kWutsjIdEOg58koMIhPzGWZrwWDveRVWGRTwDxSfE6q1+jdoKce1UMZFBBmaerDrKcxcaWMko
	lDWbudlPDm9orAVwef/MOBsbhhWDtUcr0fCKMVLW/6zwr1S41g6b4ZKH+oopQhSca0JMMWH9QS/
	tbgJ9clLaTPf/8lrpsaosLu62vwymfazl2F8phq5rY8uEgQuLj6Dvd0KJppsw33su9T+J2pPrK0
	qrxxJvo8yXux/0YEXib2bydWlXigX7w0zZX62zjABALTEfcmvscvVo7GWYmUO8Ew==
X-Received: by 2002:a05:600c:5489:b0:499:4e47:eaf2 with SMTP id 5b1f17b1804b1-49ce58092a6mr62028745e9.6.1788350474220;
        Wed, 02 Sep 2026 05:01:14 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce309e418sm86970215e9.13.2026.09.02.05.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 05:01:13 -0700 (PDT)
Date: Wed, 2 Sep 2026 14:01:11 +0200
From: Petr Mladek <pmladek@suse.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz,
	joe.lawrence@redhat.com, song@kernel.org,
	live-patching@vger.kernel.org, Wardenjohn <zhangwarden@gmail.com>
Subject: Re: [PATCH v7 for-next 4/8] livepatch: Deprecate stack_order
Message-ID: <apgQB-N56NtTBF_C@pathway.suse.cz>
References: <20260825114641.80452-1-laoar.shao@gmail.com>
 <20260825114641.80452-5-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825114641.80452-5-laoar.shao@gmail.com>

On Tue 2026-08-25 19:46:37, Yafang Shao wrote:
> stack_order is no longer needed for atomic-replace livepatches, as a
> single function can only be modified by a unique replace_set.

I would avoid "replace_set". As explained in 3rd patch, the term
"replace set" is ambiguous. And "replace_set" with the underscore
does not exits. I would write something like:

<proposal>
The stack_order sysfs attribute was added to determine which active
livepatch is used for a given function. It is no longer needed because
recent changes refuse loading another livepatch which would modify
an already livepatched function unless the new livepatch would replace
the conflicting one.
</proposal>

> Since this livepatch sysfs interface is mainly intended for kernel
> developers, backward compatibility does not need to be maintained.

Best Regards,
Petr
