Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CCB3290AF
	for <live-patching@vger.kernel.org>; Mon, 12 Oct 2026 07:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791790441; cv=none; b=WblZp1xcxELQnFqGJqzgPQDr7dCzu9xu6qJmEEffxR1wIIs8e19eORCPUo9cwVBvhEKLzUHx1dZttvrdWlYkmzxbWhkWAZ7Qm82v8M5OndJ7ADYi3Kn30rvmXMG+5KIV3ErbChino0xAemfTdDTC4nhUEnD4e5yUm66uWUUZZzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791790441; c=relaxed/simple;
	bh=yEMulxomxXCRUHcJyO6tg85OWCzbU/kyWDzp5hqoZX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e8tCLkXUiYNmGrtfXWKHwBje5I+kDyCHZuobd8xHIeMZL+Xj2OB2mBFcmY/SJzHavvn3JHiHCohTICpIhf7dz/mSuIpOvBXQSDaqoqBmtgaz10uZL6u0mtjbuK/l7bqC2Hd7I7Y2YWUrATc9tpCQ5uJCx1XBnUrr7kT+/HJz7fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LjPfisdJ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LjPfisdJ"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a180fbeef5so14068485e9.1
        for <live-patching@vger.kernel.org>; Mon, 12 Oct 2026 00:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1791790438; x=1792395238; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=g1l+z2Tdn//m1GVp5cdQaRa3eKvtV4qEANixuZIAvSE=;
        b=LjPfisdJbxtZp1r9XPTRSTvuYebEaE0duRUM8sKO0mwwuPsqq5gm7g2VLqg5Z6FI7A
         dR5wlUk8DZmYLGqMV4X3moJZDQfWRFc+qB95oJowA5FrzSRjY/fGIUmuwouHfyXOJkcv
         5LLyust4Fwvj4E+HNJc9BCmltWZW6jWiqfWj5NjRE6dM90SKFL62ktxEO0nxafjPWU65
         9u+MzJYZ/Z0KoUKKhhZORouBBZcTr52DxzVsmmb4iYW4bmAdtvvJZBcgZ4hDv/LkhKEW
         peOYgX9x65Sd2uWoRGr1GK/VjaS6cb2ba1TVE2ZVez9BgLZTWKQZSx8Q+CUrzvTocz8Y
         BTLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791790438; x=1792395238;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g1l+z2Tdn//m1GVp5cdQaRa3eKvtV4qEANixuZIAvSE=;
        b=wNxtPcvL8vd1MGqh2VDtprHo6IQdjwx5mDqQX0ww33BD54e4AWXIZbGSxcuU67kucl
         SHhwheZDxEMjxx1RDcpdUq6uYL+4rkip9D67VFDvtLfdnv6+oM644ZQjz0pAYv+Rnp29
         kfHyqM/1r0e95TRKOgNCo5eR4LpKqUzR9wKzHHXumjqPU8BXQMU5oucs/SQ2+49MoA0g
         SXOjZwYTa/y4jZrSU4f65WlKK9asKLWu2sz8hAgHx41FKVHZi3iB/ZswGYQvzAIg7vuc
         2VlXgAD738YhbKybyIT/W8RppOuXKQz/hgdYnB3AlDGvadRmZ+K0vOJqQgLlugWlblNv
         Muhw==
X-Gm-Message-State: AFq9FYLca/rFRPwVDn57SzXEEt7N27Aadle804Ml3cEciIb6GIWdroq2
	liisyFAixkziU+/JSkac+rnAC1f71DrDrmB7JbcbRgXKCGu5rnUiYZMxAD5OL+pBNMY=
X-Gm-Gg: AYBFou0V9cI0piXOtH6hDiO9FOzwnI9ktshbDX1JoRGiU/wsbhIvxaBOKyMOHPgkeek
	ZeQPVXbk3Tya83VyzMOmhxK6kxN6yGkPgid1BN8fYbJ4L+VPJXf1gPFcTGMewIybuBKn35KSwtp
	VCddZ3GHkhUaqXoTB2HPYs7f4kZFRVH32jWqijUz5WhjIWjAkiGXjOF5O1RoYIQKDKA3CcEopwE
	rNEz+9GoPuplrR8oZAv0+FU1r57i+BQVT23fSYciKYPoYxnOa1QWikGEJxzWSgHBOFmMbWenu+U
	J34IMOuzKQke4j3DgIy8Z0CfIAXRZp/wbhlFdmxznYLtCOS2dXKL+fiJKqN9gLwfqqtL295r5SL
	uft2gH3A/GC5XmVajyQ/rAbXhiT95jUpXSJbVCfaW20YueFxg5uI/AzATrS5+WLoPD0pHjPBgE8
	4vQQ+SfzzGFu6v1ZdISH2Gi9oWCP6mfrWPeKtgbsZP9n74Ryshy8DGooWVNU61grfbbeh+UtLOr
	Rdn++OJ2ts=
X-Received: by 2002:a05:600c:1909:b0:4a1:722a:d2a3 with SMTP id 5b1f17b1804b1-4a18e4a3f5amr181831615e9.23.1791790438253;
        Mon, 12 Oct 2026 00:33:58 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1972eaed8sm159437785e9.1.2026.10.12.00.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 00:33:57 -0700 (PDT)
Date: Mon, 12 Oct 2026 09:33:55 +0200
From: Petr Mladek <pmladek@suse.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
	Miroslav Benes <mbenes@suse.cz>,
	Joe Lawrence <joe.lawrence@redhat.com>, Song Liu <song@kernel.org>
Subject: Re: [PATCH] livepatch: Add Joe and Song as maintainers
Message-ID: <asyNYwN_hP36mXT3@pathway.suse.cz>
References: <55b68f507686cadfcb1fa4f8524ae042c7657be8.1791664234.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55b68f507686cadfcb1fa4f8524ae042c7657be8.1791664234.git.jpoimboe@kernel.org>

On Sat 2026-10-10 13:31:49, Josh Poimboeuf wrote:
> Joe and Song have both been key contributors to livepatch for several
> years.  They have graciously agreed to become maintainers; add them.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

JFYI, the patch has been committed into livepatching.git,
branch for-7.4/trivial.

Best Regards,
Petr
