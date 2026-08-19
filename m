Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52633A9013
	for <live-patching@vger.kernel.org>; Wed, 19 Aug 2026 13:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787146129; cv=none; b=P5HYBg1L7Zj2RKUQYzGjg+vezNYdUpo5gTs1oeKzwAvLP6MLMPdc42m6Y5VXI5wekRkUCvRTgAbINjKKi9XBA9P2IjjzJuBVQ9OHhZsQckbQKu4/IB6ZQfr5cTh/RITecIM9vsHWrDcuS7T62cyfkCDyjhHJlAAA8YCMSK63WC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787146129; c=relaxed/simple;
	bh=wlapjEqe8kyZhlEQN1QZwk9ra7ALD54v+oHhW67f6/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ek7bgBZNQ0M5P9dfzsVurJ40jyWxMUVyb0oq14iDEZuThk9Zm10uCCrTZQVc2Xw0zQOhV2W2SaKhLUaGHlVtDxjngzkUlKtisSv+zxWFdQhxNRaZRR1+g1291iLp+RG91rJDnTt+ZTINCLYOt997pOr4jV5NPdpc0lcPdnlfM68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RQ0jiBRU; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RQ0jiBRU"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-499ae1c6471so3680065e9.3
        for <live-patching@vger.kernel.org>; Wed, 19 Aug 2026 06:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1787146124; x=1787750924; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=w+5IpqhSGJufIhhJ2XDzDGZAZt6AECsqWAFSahA7Sz0=;
        b=RQ0jiBRUqffm4476BSJas6pvGIGgKPwIVdTC6MfqMSab2n4v4B/RjomokI43bzU63Q
         twXr8o2rzBLzbVu2Gny2lGfUFfe21gT1is39dqnLtzTdqfkXFNsDQmhb8n4g+e2fLiTP
         qg/vPecZKDjCsCNbyOGnvof3hJDsvxcSk/B8nIDeP1h1T+reiRV0P+hCptLObUStnZTj
         M2jYnHW12gLManWsVOHV0Ts1MotSaNzEBs0Qb/trYq8Bo/N8WEMKyiHsJHlW3QUU8Hy8
         +fotjYVyuHTCLIgx/pPYxlO3YiZxuGevaB3pYDUM0JJwxkFqFjtyLIcK+lpY5y5f7dEH
         USQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787146124; x=1787750924;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w+5IpqhSGJufIhhJ2XDzDGZAZt6AECsqWAFSahA7Sz0=;
        b=iixau77LsAVKmNdjaovCXCgMjhLF8BfwsUfbvRt8FwIDYlp+lOdsZ4xSfSbNGgl9Vp
         4aWeBE6VEcmGtHV39rOJM1Cxxhf9K9ccefmfnfm0x/JgUXLvwEOxwMNUlpRem+QESCi9
         LNRcTas3BiFJe12ePeENSjJpOw0O/+mIVjzVHSfnEDidVUu5isMg/bqulvEXu4Qb++7R
         aOyk3JYHMRWzP7CYGvypRMksDs5Az4CFqOKTRjY1hy53LHrGiX4Oj7hDmHvQdpdHjrDC
         vI7AiC2uTKGGS43qswfGWpPMOJP5lMS8G8NfhCsaVF6oTY0Z7P+B+kc2+2S2mYUCh0K3
         vLyQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpvh4huVDbPIM2gu9EbRr7rKN6ZYnjgqpOIm/ARmoeFcJgCex1biSsrMubwPYmfbUDw00p79JncN8rcnUdX@vger.kernel.org
X-Gm-Message-State: AOJu0YxGh8fv+nByh2rvE55Nsh7ZUVViX+Z4JffjyBwpP6TG+SMW0OVP
	aAN+SeeHRTVolkv+VYP3Koi35xPGJqOJJ5KzG+UdyIZhnoNtad3rRmJXw5THYa6wmUQ=
X-Gm-Gg: AR+sD13udvTl/+D2l0NNg/Mv9n/K7Ns20HKBJ0pQ+5yLj6u3b+p0QAFpT4CmnK8P66j
	mwqJ8eG64k0o+8c8G0aqZfzMlhAfkep85nKz8BEWNUIgdslfOa0324SyupV3n2ER8tNRjHhN7D8
	a/KymSmc7mXSGHvdi0c+gukhOBqX0EUlViwpMfJM4VnqFsNwm3F+CpRMs2Z1VHXxaXKOHMlwG/B
	6QSf6C/qkSPbCD7ImFuTLibsccX98Rb8M0+7Hbmia7j07LuqSB8rWrIAz9foSglcB86fobQ2aMN
	CVhodHpNOxYiNGGRKi6NxivXHUfjFXg90PBMw1tXeK4hIPmATivLHbxKvi7qywEHc8oYVy0jass
	SVD3HJFu+baKvlmcbza8MsoA2S0d7wTX1spaPtzrp73lDkANyGa5eFEjiqcRRGn6X9dcIBy8Eot
	PAZK1a49s20AGPgoJECgqEkmmyMNqTurjxg+Zan6TGPn8zdC4iin6nTo39mMErug==
X-Received: by 2002:a05:600c:468d:b0:493:e365:7630 with SMTP id 5b1f17b1804b1-499aa1bbe90mr71693335e9.14.1787146123688;
        Wed, 19 Aug 2026 06:28:43 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499a9aa1594sm56432525e9.0.2026.08.19.06.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 06:28:43 -0700 (PDT)
Date: Wed, 19 Aug 2026 15:28:41 +0200
From: Petr Mladek <pmladek@suse.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz,
	joe.lawrence@redhat.com, song@kernel.org,
	live-patching@vger.kernel.org
Subject: Re: [PATCH] selftests: livepatch: filter kobject debug messages in
 check_result()
Message-ID: <aoWvidB12l4oPIdK@pathway.suse.cz>
References: <20260818054629.69246-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818054629.69246-1-laoar.shao@gmail.com>

On Tue 2026-08-18 13:46:29, Yafang Shao wrote:
> CONFIG_DEBUG_KOBJECT makes kobject_add_internal(), kobject_uevent_env(),
> fill_kobj_path() and friends emit pr_debug() messages, and
> CONFIG_DEBUG_KOBJECT_RELEASE makes kobject_release() emit a pr_info()
> for every delayed kobject free.  All of these carry the "kobject:"
> prefix via pr_fmt(), e.g.:
> 
>   kobject: 'test_klp_livepatch' (ffff...): kobject_release, parent ... (delayed N)

Yeah, this is pr_info() printed only when CONFIG_DEBUG_KOBJECT_RELEASE enabled.

>   kobject: 'test_klp_livepatch' (ffff...): kobject_add_internal: parent: 'module', set: 'module'

This one seems to be printed by pr_debug(). It is printed
with CONFIG_DEBUG_KOBJECT but only when CONFIG_DYNAMIC_DEBUG
is not enabled.

> The livepatch test modules' kobjects are named "test_klp_*", so these
> lines match the check_result() grep for "test_klp" and leak into the
> result.  The extra lines no longer match the expected output, so the
> selftests fail when either debug config is enabled.
> 
> Filter out the "kobject:" lines from the result and note in the README
> that both configs are safe to keep enabled.

Honestly, I do not feel comfortable with this ignore-all-kobject-messages
approach. We might miss real problems reported by the kobject API.

It seems acceptable to ignore the quite specific "kobject: .*parent.*
(delayed" pattern.

But I would prefer to ignore the other debug messages by detecting
the KERN_DEBUG loglevel. It seems that dmesg even allows to filter
the output on its own. It is a bit ugly because we want all
other loglevels but:

   dmesg --level=info,notice,warn,err,crit,alert,emerg

might do the job.

Best Regards,
Petr
