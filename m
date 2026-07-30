Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411212CCB9
	for <live-patching@vger.kernel.org>; Thu, 30 Jul 2026 14:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785420073; cv=none; b=VWmMJ8ta3U9HR+ETm304B0p49HdjWuIBbzp/Ot4ctg59xaKWKl1idNAMYEquuBN1+v7TjaM0d9ZP8sviIYf3GKOsxdpC706SX6bLF7JsXCNslqjOMj4dRyHzeKcLOhGB+zq+7WT61XrkEy8yL8XpHO5rKmCKt5zzguPTxhxyz3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785420073; c=relaxed/simple;
	bh=GVvoshJz8DeYcFTX4ZxvCVJBnAqBSqZvfObmJ/r6NW8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=PhlpZrlNqpkQvetv1T7n7fD2uwy5PGyqJcOLMqTDW5cok33vfzsh4vHv1iCy7Ec+B5JgRRN8OLGFbvJ0Kl1wbVB4N0TdQ5yKKdVaOJfUjyq0jRWjRkHFjnnDKTiyhzfsl3lqsbNqvNOfqQ8bH2S4Sg9WEUfLYOkoJspdF+uZ6io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eP2wOIJL; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=L2AU5/Bp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eP2wOIJL";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="L2AU5/Bp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785420071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=XuNRq8s0D8CllcLsbXfxk1lPgB8nE7AyXok8q1wOxzg=;
	b=eP2wOIJLRaX+26jZgS4tPy+HWTrIBUo8MECf/8/wN94oDocR54KRZnB+umxVfHCASIn3Su
	J/gWYsrARcKRQWfMy68jSL81FIQFfi5uRIy9ixVAR5+9kln8pw63ZXkgwWSh8LlwHg3LlB
	YC2rHGWoD2KckoEUApXSDm3k5uO5qxw=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-siihJHUkPqmxY22gPM6RaQ-1; Thu, 30 Jul 2026 10:01:07 -0400
X-MC-Unique: siihJHUkPqmxY22gPM6RaQ-1
X-Mimecast-MFC-AGG-ID: siihJHUkPqmxY22gPM6RaQ_1785420065
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51ebdfceddcso25375021cf.3
        for <live-patching@vger.kernel.org>; Thu, 30 Jul 2026 07:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785420065; x=1786024865; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=XuNRq8s0D8CllcLsbXfxk1lPgB8nE7AyXok8q1wOxzg=;
        b=L2AU5/Bp7Py/7J+QVXWj96OUhUUc9rZYTcz1F01JfohaSPFzO68vqLW91K3HbjISbC
         GuTftBV5WHXpfNLmSTmTM2HMZMriHQVqBdqWe8DtRe8gmF+p1by29EZBLDfWJAVbtW4o
         re+Wmy7p19dkneoWcRwqVil/Srri6wPHFlChpUziIKpSO66KBk/f17qhpXMWpphycGCV
         2m0m7veWKf1cKpDpN3pbrleHibZnP/uFfYqaN0qeT2PsyIyajcO2Jp41fu8P2U1XWFjj
         asOwv0CC66m0PNzGWvb2EOHAZWCzZf4N2p55Q1T94CktBs1IqlkrtQd5SQoiKdZRtUwE
         b2Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785420065; x=1786024865;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XuNRq8s0D8CllcLsbXfxk1lPgB8nE7AyXok8q1wOxzg=;
        b=mgEzGz94BC0COkXN2fdB1SUaUlv3FqBKC42NW04rfx9S7nKXqJbfdFsGpEP4dUb5BM
         gNRzPGsfffBV9BWBFS+9Axzp15VqYTA9U+TR+BQtMK2YFUwtqn6Yvw7LFEqhXrL7yFPF
         uIF7xDZo3xTlJCUAqTYMkESbhh4nMYPV9XdyyH7QApbpqWuHp7D7vdlNMnP+OWFGuJf/
         6WPXQMm1fbseB0JkknT/zG0vhD+BCsaimjg93M3q7cErztcHd1SyrDm0rd0aOlComuM2
         H3TAlrB9qSiwOL/kdxqy2+6+XtpRbRBqeObbDNgVJ194BXzf7UA4XY8ikygizeIcl+9g
         XGgQ==
X-Gm-Message-State: AOJu0YzrSpSrVgz98M/z3ZUrEwsZ/31WJuesLvOUBf7BLTtmVp7mMATF
	nLVzEN1ca0Okx94PVMjS0KROv/N2JV2id1eD23v83mzLtBJgKn+2Ii7ZdfD2X9fQFlsM/Wo3JNQ
	pKxspIgpFt4hjrWffPr64M/w04Cy10ue0TYe+5xETuFWUT0pa4kxM3xYN93iuxfLZ2pDjVOUlku
	w=
X-Gm-Gg: AR+sD12T9GcSTu8RwpvEUe5eejNnzf3+fao7TNcGaME6pI7UJ//h2MAEuamEPM58IuF
	EJK63m6BLrnrKg5Www1kvnYmY1exoy11FC1hnoWtRoAEoqIxSSCn6zGqxqd4A05f5PX4sMB6LS8
	rMvna0Uu1ohonVUAfTIy8g5W6QaBQrfG2Bh8ItGJP4VPfFNpSoqRxSrw1sHsm2iMFQGqvZTxBCJ
	aisF2kmx0d3mOBu74ocxLn9sZg8/MH4Vg7WpHgcKlhKxDXLWBuywvD2rGKc2qNusnEj1R+N82YH
	rRKmT6JgxNd0eAB3ErIMXm1kyzuNUh/gNZQtEBYOM9lZWP/3Gt5WGrFhFEg+ascchCwrGkDpIvN
	SyQ+Bp2j7jITLYmkkFrd5Fd1CngnX3zc5KcVKqK+eNw2Y74cjqWo6/Zh7
X-Received: by 2002:a05:622a:4007:b0:51c:1117:c7c with SMTP id d75a77b69052e-52b384aa604mr29864231cf.25.1785420060372;
        Thu, 30 Jul 2026 07:01:00 -0700 (PDT)
X-Received: by 2002:a05:622a:4007:b0:51c:1117:c7c with SMTP id d75a77b69052e-52b384aa604mr29857991cf.25.1785420054124;
        Thu, 30 Jul 2026 07:00:54 -0700 (PDT)
Received: from [192.168.1.26] (pool-68-160-160-85.bstnma.fios.verizon.net. [68.160.160.85])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-529e3993fadsm41245671cf.29.2026.07.30.07.00.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 07:00:52 -0700 (PDT)
Message-ID: <20591c26-e900-4f1a-8a46-d28eb370f407@redhat.com>
Date: Thu, 30 Jul 2026 10:00:51 -0400
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Query Regarding Backporting klp-build from Linux 6.19 to 6.12.x
From: Joe Lawrence <joe.lawrence@redhat.com>
To: ahamed <ahamedr0809@gmail.com>
Cc: live-patching@vger.kernel.org
References: <CAL0stzsJ_hJidg0hyJbaSWKHU=qqhh1G5BhKnJRsWS66PJh3oA@mail.gmail.com>
 <amIRjXKfDPTGD_0Y@redhat.com>
Content-Language: en-US
Autocrypt: addr=joe.lawrence@redhat.com; keydata=
 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
 pNzsRQ==
In-Reply-To: <amIRjXKfDPTGD_0Y@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/23/26 9:05 AM, Joe Lawrence wrote:
> On Thu, Jul 23, 2026 at 05:58:58PM +0530, ahamed wrote:
>> Hi Josh,
>>
>> I hope you're doing well.
>>
>> We're currently using Linux kernel versions 6.12.74 and 6.12.90 in our
>> environment. We have been using kpatch-build for livepatch generation,
>> but it doesn't work on these kernels because CONFIG_X86_KERNEL_IBT is
>> enabled.
>>
>> Since IBT is an important security feature, disabling
>> CONFIG_X86_KERNEL_IBT is not an option for us.
>>
>> While looking for alternatives, I came across the new klp-build
>> infrastructure that was introduced upstream in Linux 6.19. I also
>> found your patch series:
>>
>> https://lists.openwall.net/linux-kernel/2025/06/26/1920
>>
>> From what I understand, this series introduces the new klp-build
>> workflow along with the required objtool and livepatch infrastructure.
>>
>> I wanted to ask whether it would be feasible to backport this entire
>> patch series to Linux 6.12.74/6.12.90.
>>
>> Specifically:
>>
>> Would backporting the complete klp-build patch series be sufficient to
>> make klp-build functional on a 6.12 kernel?
>> Are there any additional dependencies or upstream changes outside this
>> patch series that would also need to be backported?
>> Have you or anyone else attempted such a backport, or would you expect
>> significant compatibility issues with the 6.12 stable kernel?
>> In your opinion, is backporting klp-build to 6.12 a practical
>> approach, or would you recommend another solution?
>>
>> Any guidance or recommendations would be greatly appreciated.
>>
>> Thank you for your time and for all the work you've done on the new
>> livepatch infrastructure.
>>
> 
> Hello Ahamed,
> 
> I'm replying to your mail here since this one is on the list and the
> info might be helpful to fellow travelers.
> 
> The klp-build tool and support infra should be backport-able to a 6.12
> downstream kernel if you are diligent in tracking all the dependencies.
> I don't think there was a definitive commit list, but you could get a
> massive headstart by looking at the CentOS-Stream-10 kernel [1], which
> is also based on 6.12.
> 
> If my gitlab search foo is correct, these would be the MRs in
> chronological order for cs-10 objtool:
> 
>   objtool: selected fixes for rhel-10.1
>   https://gitlab.com/redhat/centos-stream/src/kernel/centos-stream-10/-/merge_requests/580
> 
>   objtool: rebase to 6.15 with supporting commits
>   https://gitlab.com/redhat/centos-stream/src/kernel/centos-stream-10/-/merge_requests/995
> 
>   objtool: backport v6.17 updates to rhel-10.2
>   https://gitlab.com/redhat/centos-stream/src/kernel/centos-stream-10/-/merge_requests/1737
> 
>   objtool: backport klp-build and late fixes
>   https://gitlab.com/redhat/centos-stream/src/kernel/centos-stream-10/-/merge_requests/1964
> 
>   module.lds: force 0 sh_addr for .text, .data, .bss, and .rodata sections
>   https://gitlab.com/redhat/centos-stream/src/kernel/centos-stream-10/-/merge_requests/2213
> 
>   objtool: backport v7.0 updates to rhel-10.3
>   https://gitlab.com/redhat/centos-stream/src/kernel/centos-stream-10/-/merge_requests/2589
> 
>   objtool: backport v7.1 updates to rhel-10.3
>   https://gitlab.com/redhat/centos-stream/src/kernel/centos-stream-10/-/merge_requests/2793
> 
> Keep in mind those ~200 backports are for the entire objtool and
> supporting patchsets, with some skipped along the way.  And to a
> downstream moving CentOS-Stream franken-kernel.  Stable 6.12.74 and
> 6.12.90 may be more or less work, I don't know.
> 
> Good luck!
> 
> [1] https://gitlab.com/redhat/centos-stream/src/kernel/centos-stream-10
> 
Ahamed asked a follow up that I'll answer here, in case it's helpful to
anyone else backporting klp-build patches:

"If we successfully backport the complete klp-build infrastructure to
Linux 6.12 and use it to build a livepatch module, should that module
be expected to load on other unmodified Linux 6.12.74/6.12.90 systems
running the same kernel version and configuration?"

This is possible, but you will need to be very careful about potential
binary output differences.  For example:

  1735858caa4b ("objtool/x86: Reorder ORC register numbering")

would change constants like ORC_REG_AX, ORC_REG_SP, etc. in the
livepatch.ko and could mismatch the target kernel's values for those.
You will want to evaluate such changes on a per-commit backport basis.

-- 
Joe

