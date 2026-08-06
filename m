Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FA847F2EB
	for <live-patching@vger.kernel.org>; Thu,  6 Aug 2026 15:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786031896; cv=none; b=XNP9ZbytdMe0e992gVtzwXIc+eoDh6XYHrCvMVLplebrfBQIT1rzQlh5dCeFPjHPTWfZJvBrhbMkRfs/RLOM9W13Rp7Ymgnysp+Jo33ZUZTYn1QUQCn0h9LE3CG+H7EoscjfGBCAEKHddNngLmv3Xw6dPtEq9AY6LMk0NcxvDno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786031896; c=relaxed/simple;
	bh=YjAJYGsMEG8J0bvWFQuJc8/rvIWCLn/bHxRIHUpvxdE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n+j9A8xSojB0d02nLF06HHKFGhRyFtNiKZCgFxuVkFsjCgBQZTE8YYc+1+SnZ/3UyHMSJSXVHCYqiPKqFJ9ErjWOzBmb3R+zh4cBQJoYLbnmsp91qUbdaVuThj/ARbTw2uWzDU/T1ze1kDi/Mtkq+7tL8Yt81gGdTUojFFYBEBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AW6IN9hm; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=WjjsFlAn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AW6IN9hm";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="WjjsFlAn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786031888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TpgrFCVNVdoS5oc3yO5w/szZoVoVW3+bvH29IbpSiQ4=;
	b=AW6IN9hmf3+Sm3t+IyspnF4lYYM61U8+tXciXDMePcAFx0aNg6zCeEf0iBgEq3eWsy3LRY
	TXwrcKNZm6jSlHCU5gC0dUxr+EDRfRoNNuGW38g0TFASRYURuLfKOnfjdwhB3bRCUxxzlO
	kOtkB9f0Vafy/gvaYdhXdvtwdkniNgg=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-6wOR9cbHN5e8rew5Nlcpqg-1; Thu, 06 Aug 2026 11:58:02 -0400
X-MC-Unique: 6wOR9cbHN5e8rew5Nlcpqg-1
X-Mimecast-MFC-AGG-ID: 6wOR9cbHN5e8rew5Nlcpqg_1786031880
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-5b29e7e8ab6so528901e87.0
        for <live-patching@vger.kernel.org>; Thu, 06 Aug 2026 08:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786031880; x=1786636680; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TpgrFCVNVdoS5oc3yO5w/szZoVoVW3+bvH29IbpSiQ4=;
        b=WjjsFlAnJ6dJ44fj41SuLSUtH9ilJZrbx2zSEcJHfMKXxuOXUHMjJVlRSObb/iGWeH
         M8qsOzCgGaVLoGg5Q4YaOTcKspgv952rwEy2ohFPhPeMlRcSm8x6VIIG7bPfOavXprXM
         k1/TCMQHwH74MH0RHXAPkNfKbWYqnXVg8QKxlpfWY5yxU+7ePs6kHESqR/ub4OY9I7yy
         VNio+gnCIRPxSc9q4kH7yv1TPKMNUkvr6IFvlRw7StK1MjrIeNxuS5iCbRa4VmDH1gZx
         LAqB2eZojlFLXYuUWigN0cmso8G3qJYHr4r0+H7nOwSm2wrvozSPDcuLiDDnlFQLTozd
         NeMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786031880; x=1786636680;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TpgrFCVNVdoS5oc3yO5w/szZoVoVW3+bvH29IbpSiQ4=;
        b=PwrLpNQvEwfujH/z00I43kNhnMWi47v5azVxwrIMBP8//c8SHF48EXCkJLgo73h1r+
         sZxhBn02P/VZgDEm4/Ovb772WO71ou/HyprdgTgXXBKnBtIbYMD7rGH0e0QRwgY2WPs+
         T21MTceqHor7AO3csk7EUxzetUig8V6L23pfjq8CMmwah7JkI0/wDiSMnwY64GgPVhiP
         2t0pJM2o2EMDCN5JTbp24xvPqc5vc5VJAIqHTRLyWgqB+M5UO9kJhUvrnuFW+wfvzCxq
         dQm5+KkwwUEj5wpAAyiCZlqA3bWj+7pETKydVRM5CYVV9wu0Ogy1QR0LkepmpspubT+N
         reiQ==
X-Forwarded-Encrypted: i=1; AHgh+RqahpyEtvfiwDLUfdaFsrn6T2TSKUdG2nUa0K2yAj43LrVXye0120nYuf4XTPlc7swiutGu6ilYy40T/I/A@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjw6eUfBFOPow/6AiJb0MFFLcsyFRWQNH+t8pZPIVfSkOoa81S
	Umggn/JI/ENbN45mXSDQyIFuPQLZzWFjG2y/Q01vNAUgKdYS7cd8iYhQbRWTiRL4zRDvADl6Mcx
	e1+5psdfPz/kX6VSK5E9EbKvg8lkYU3xYHXSyckyAntNaOQXN0JHI9eH/aSM4itKciWs=
X-Gm-Gg: AR+sD13zno7H62WdQkgAe7ZXubR7LJLO9/cN3MbxmWgT0aj3NFKoa5nnIWAQCT5B+M1
	VW0yzzlbx2RfsGpzRSI/BGDHikeGU/dJfYDaGT09aZB1mMHgdKDp+pIAGYNpcpVz2Tk5jub9Bzs
	R1D+8maiFOqaC62ToYmS4nAGkPofLsx1WtXHyGFKgQg6f4TaRXAGK5s6cw1LJ6QVIPUlMUj2evt
	xceodmfb/GkQsAAkxTyVBmCkM6bYlOt2qQILcrBvBCQsmn/hPhYRWXd3Y5zVSa3F9lP09d4PdFp
	kaiUBDK5mSpvFBcRJhwGq0eC/hI+ttdGRtJsOKcUqt9Ga4DAPfvNkV8tL9g7VABzu6mGLiZhPNh
	5OZUFNFHkgotzvQGLUZ4nie0Kuql1PEgTht2G3yaUGqwy0sI33tkXMJe4
X-Received: by 2002:a05:6512:1083:b0:5b2:a3a2:1395 with SMTP id 2adb3069b0e04-5b2fe39ca69mr1532517e87.3.1786031880367;
        Thu, 06 Aug 2026 08:58:00 -0700 (PDT)
X-Received: by 2002:a05:6512:1083:b0:5b2:a3a2:1395 with SMTP id 2adb3069b0e04-5b2fe39ca69mr1532500e87.3.1786031879886;
        Thu, 06 Aug 2026 08:57:59 -0700 (PDT)
Received: from [192.168.1.26] (pool-68-160-160-85.bstnma.fios.verizon.net. [68.160.160.85])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b2f62363fasm830971e87.10.2026.08.06.08.57.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 08:57:59 -0700 (PDT)
Message-ID: <6a6608f4-0a05-4d75-8b7f-edddfac9c5d4@redhat.com>
Date: Thu, 6 Aug 2026 11:57:55 -0400
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] objtool/klp: sympos/module/alternative/etc fixes
To: Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Miroslav Benes <mbenes@suse.cz>,
 Petr Mladek <pmladek@suse.com>, Song Liu <song@kernel.org>
References: <cover.1785939903.git.jpoimboe@kernel.org>
Content-Language: en-US
From: Joe Lawrence <joe.lawrence@redhat.com>
Autocrypt: addr=joe.lawrence@redhat.com; keydata=
 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
 pNzsRQ==
In-Reply-To: <cover.1785939903.git.jpoimboe@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/5/26 10:29 AM, Josh Poimboeuf wrote:
> v2: 
> - rebased on tip/master (first 6 patches were merged)
> - dropped original patches 7-8 (will post followup)
> - added .klp.symid fix
> 
> v1: https://lore.kernel.org/cover.1785727106.git.jpoimboe@kernel.org
> 
> This consolidates fixes for the klp-build issues reported by Joe over
> the last several weeks, plus some more things I found while
> testing/reviewing.
> 
> Fun stuff like symbol resolution, module dependencies, alternatives.
> 
> Joe Lawrence (1):
>   objtool/klp: Allow new references to module exports
> 
> Josh Poimboeuf (6):
>   objtool/klp: Fix vmlinux .klp.symid link error for .no_trim_symbol
>     symbols
>   objtool/klp: Fix size of empty special section entries
>   objtool/klp: Ignore replacement offset of empty x86 alternatives
>   objtool/klp: Explicitly disallow patching or referencing init
>     code/data
>   objtool/klp: Fix cross-module klp relocation section naming
>   objtool/klp: Don't match local symbols against exports
> 
>  tools/objtool/arch/x86/special.c        | 27 ++++++++++
>  tools/objtool/include/objtool/klp.h     | 10 ++--
>  tools/objtool/include/objtool/special.h |  7 +++
>  tools/objtool/klp-diff.c                | 65 ++++++++++++++++++++++---
>  tools/objtool/klp-post-link.c           | 53 +++++++++++---------
>  tools/objtool/klp-symid.c               |  1 +
>  tools/objtool/klp-sympos.c              | 10 ++++
>  7 files changed, 141 insertions(+), 32 deletions(-)
> 

These changes (and follow-up comments) look pretty good (lightly
tested).  Could "objtool/klp: Fix vmlinux .klp.symid link error for
.no_trim_symbol symbols" peel off and merge sooner since it fixes a
commit just recently merged?

Though I think there is a still gap for EXPORT_SYMBOL_FOR_MODULES
symbols: those exported that way from vmlinux would presumably need a
klp-relocation, but klp_reloc_needed() always returns false for all
vmlinux exports.  Maybe we need to parse the namespace column from
Module.symvers to special case those?  (At least, that is how I read the
code, I don't have full repro test cases handy.)

This wouldn't block any of these patches, but if you are spinning a v3,
we could consider tacking that on while we're here.

-- 
Joe

