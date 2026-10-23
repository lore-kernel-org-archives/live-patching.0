Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792768794;
	b=m7q5/2YH86CS6N2L4AR7hp3QaiB0QhokShWAabYJH63asyh2sBr7RyD+y1H3Q2Rg3Hwl
	 p1/Xa+RZQkwUV1yPtFTHlCRf0T8HLzKO1Wuq3++UIZdNUtbIx1jSP3N4luOK07V+JDMk+
	 TAQxQ8eLUa/aEEnBsOg2ZhYyo+CtoeErs0jCh2hBs3c7Kcdp/SE6G+ILFP3l+/5aqb02I
	 AHJ1iNd7wcE86EhHPVFq29Pwu9wJNF1xoJLrdOtPP0nU6HxgylDFW3LQgD8v7ZlTJAtlf
	 islVxI6NcrMTDLs+/W1VTfemFN0TtT7WnCYcJ2dtAe7erHlCmDDUIL3TL+c+uAeDOcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792768794;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=9dfH3V+3D4OX4P4/gWoBa45sL/E36yNO/1Da2PwG7jY=;
	b=z5JC0ZnvmRQ8G9phN8QNtC+yX2nZIUZAGgqucsC3Yl/A9TjBpGOxBo1G9BFI76QKcwlp
	 Hks1g/hrU+zO+POpw1Yx/0F2xa+a+GORbSfuFRHRHPNYHYU+gRHcGkDZTPj1qH7o6PoX+
	 YOyXYgUYRYmuoCb/wui24rwO/FBGFvjdlwbg3aoNF+1yjwIU4/BMdToLyjjZ2OSTlaBcs
	 SJU/Er00d9dNNcdGt1WvQgzeXBaCZZabOVZ/VtyGKeMvrt4fXwVjDzYbpa2rqcmbQZH44
	 sk12qyYnZr9XoVHm7AycTUkjx7IhKWoqBpxPZnYK1Wq9jVTCoco7ICl/TJQLfcrbWxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FFAYHRaR;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Oi+24bxd;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63AD606A31B
	for <live-patching@vger.kernel.org>; Fri, 23 Oct 2026 15:19:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E63AD606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FFAYHRaR;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Oi+24bxd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792768793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9dfH3V+3D4OX4P4/gWoBa45sL/E36yNO/1Da2PwG7jY=;
	b=FFAYHRaRtfR6esarJgn7mhmfWuiXJzSwZLJjCIJs12NQ6KkQOfRrl6DtjEGcdFakF+rzhu
	j4Vn44dicL0LmmxTJqJl5pT71XcZ2TEQK2xVYyy1/yvXffmsH6Q/rHcOI+iEFgHz9EZ0s+
	Rz8xHHWf4YiqqU4DSFPcxyhS0VDHGn4=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-DSStHGo3OeeAaHlmDef0FQ-1; Fri, 23 Oct 2026 11:19:51 -0400
X-MC-Unique: DSStHGo3OeeAaHlmDef0FQ-1
X-Mimecast-MFC-AGG-ID: DSStHGo3OeeAaHlmDef0FQ_1792768791
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5338c215ed2so16721691cf.0
        for <live-patching@vger.kernel.org>; Fri, 23 Oct 2026 08:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792768791; x=1793373591; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9dfH3V+3D4OX4P4/gWoBa45sL/E36yNO/1Da2PwG7jY=;
        b=Oi+24bxdgCwd8pvHm7fM0SluFfXRsrY9kIlerM3UL9sIcGHnaonvGHFcHun1+F02Mr
         CgVQ7soiC4mGK8lKKNjwBNN93aKKfuAsOiHBwy/CWGOMsEMBgiocy2dyjhZoNVnQeQHq
         lbKYy67nH/A2oBvPLJL5MxHyuZ+9uotrLXesSzLJ58TdqN+bMKz58073NBWI/1fNoX7Z
         nlt9L0kGsMr7Kqm2bjPELtvJFfVfe7Z3kloRf+KuavT+fGUjJt1vJipGETh34Of6aHn/
         rPijtwx8PH26oHKT9+ALYOfLjtJLUzVvS/I8bVt/b8atGATwBVFVSeGR439XeGUValAS
         gzXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792768791; x=1793373591;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9dfH3V+3D4OX4P4/gWoBa45sL/E36yNO/1Da2PwG7jY=;
        b=o0VtyJP25pjC35EVtT52qxSbu25xW3yh7cDwzcPpUav6wzFCoSM8rIJaImIi49bbk7
         Gc9YShlYK132xjgmjfP2xCzZELM0KhAFOupErO5dptJKXV2TMB3Ek4evWmDLxByPcw3a
         ogA3QvbUY5Ft5dKswv7Jboz9n1f8Jz8cvPmMaoFmRQomkyZL7SLtHFbLO33luJLaR06E
         vH1beDKMlQyLWYhS82d8B6IHXvW8EkwCSVR2jsPfhWg5j/WfQAcqnE4oXvlGkGPJxZ2C
         C9nVVZRa6Y38yubIjsLKdoGfoLCGSUqAI3x/8lIsoaq5Qi+IPYAI7tg93EMB7c3KS9Sg
         SZhA==
X-Forwarded-Encrypted: i=1; AKwUvBzozGH3GDCsQVVBTMawMWMy7oEn4liPIacuwpI46Hl2LlvZqe2SRh1nvNb/jjxEcLHTwTjEQtwlT9SVmKjY@vger.kernel.org
X-Gm-Message-State: AFq9FYKyh6PVF2OZVoz1jkF6mTfTg8vx+q5TxYUrXl0/EL9f1guZVqHa
	sTcAtXNQWpIW+uu0qr9J7ymXsUjGNF2Km1K7lGVXpksjxbtynmNMJk7NixS5Z/gAmTj1cKzGHpj
	nnxySWnuEXf47yWhardGrsA1795Doui+lI1U/qKpANEPqc6pcRDNuXVX2dj+aj+BLk+QtqD8/Xo
	o=
X-Gm-Gg: AYBFou3sNtVqbCWxRHzSJUItz/1mMtFFff5tl5OOHPNRBnfGsYjPtBGo57pnMK9bOYJ
	o8/7rSaRrMbQMp9yidANFapFh4FUY2YJ5WjhcYC+KsUV6m5kU7GBIbFlqkC4zpseO4Y1RpfiJRA
	1GsqoYQzPlQPtFZrOrv/G2B8E+WraJw9F/K/b/O0/gNKDEd6+9r4vXdzJkIz8vkfsThZIDn60gL
	jNgv3jMR5wxxPDsLLmmmrf+UY8I5iCsfEg8FGSw3eBY/VWbCgM8uwQ5DZI23AIJicazZteV8c9U
	YoL/5RzCSslQtjJ+32XpFS6UWUuFRnqKdFX0tUUBmx5TDMrQjFvd+hYF9hgGrSm55HbT0ZoohDO
	GG1XR0H6Nlg8xz2NW7fd/oQAH4RViALkbkc4Hz/idqa3jeEkUh7wo0QI=
X-Received: by 2002:a05:622a:5513:b0:531:17a2:4e4a with SMTP id d75a77b69052e-536c26a5685mr34286641cf.47.1792768790804;
        Fri, 23 Oct 2026 08:19:50 -0700 (PDT)
X-Received: by 2002:a05:622a:5513:b0:531:17a2:4e4a with SMTP id d75a77b69052e-536c26a5685mr34286301cf.47.1792768790374;
        Fri, 23 Oct 2026 08:19:50 -0700 (PDT)
Received: from [192.168.1.23] (pool-68-160-160-85.bstnma.fios.verizon.net. [68.160.160.85])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c452c4350sm3841956d6.44.2026.10.23.08.19.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2026 08:19:49 -0700 (PDT)
Message-ID: <db163f77-8a62-47aa-a65a-93d99283ac71@redhat.com>
Date: Fri, 23 Oct 2026 11:19:48 -0400
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] objtool/klp: Reject changed functions without an
 ftrace call site
To: Puranjay Mohan <puranjay@kernel.org>, live-patching@vger.kernel.org
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Song Liu <song@kernel.org>,
 Miroslav Benes <mbenes@suse.cz>
References: <20261022171637.3298443-1-puranjay@kernel.org>
Content-Language: en-US
From: Joe Lawrence <joe.lawrence@redhat.com>
Autocrypt: addr=joe.lawrence@redhat.com; keydata=
 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
 pNzsRQ==
In-Reply-To: <20261022171637.3298443-1-puranjay@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/22/26 1:16 PM, Puranjay Mohan wrote:
> Changelog:
> v1: https://lore.kernel.org/all/20261022122544.125305-1-puranjay@kernel.org/
> Changes in v2:
> - test-special-sections: check __mcount_loc in its own block instead of
>   inside the section loop (Joe)
> - Collected Joe's Acked-by on patches 2 and 3
> 
> A changed function without an ftrace call site makes klp-build produce a
> patch module which fails to load.  The kernel's 'inline' implies notrace,
> so this happens whenever the compiler emits an inline function out of
> line.  Patch 2 makes klp diff reject such functions, patch 3 tests it.
> Patch 1 builds the test fixtures with ftrace, which patch 2 needs.
> 
> Tested on x86_64 with GCC 11 and Clang 22: the objtool klp tests, and
> klp-build with a vng boot, where a patch module built without the check
> fails to load with "failed to find location for function".
> 
> Note for the arm64 klp-build series: arm64 has no __mcount_loc, so on
> top of that series this would reject every changed function.  It needs
> mark_traceable_functions() to also handle __patchable_function_entries,
> using pfe_offset.  I can send that on top of the arm64 series.
> 
> Puranjay Mohan (3):
>   objtool/klp: Build test fixtures with ftrace
>   objtool/klp: Reject changed functions without an ftrace call site
>   objtool/klp: Add test for changed functions without an ftrace call
>     site
> 
>  .../objtool/Documentation/klp-write-tests.txt |  9 ++-
>  tools/objtool/include/objtool/elf.h           |  1 +
>  tools/objtool/klp-diff.c                      | 47 ++++++++++++
>  .../tests/generic/test-thinlto-ambiguity.sh   |  3 +-
>  .../tests/generic/test-thinlto-local.sh       |  5 +-
>  tools/objtool/tests/lib.sh                    | 42 ++++++++++-
>  .../tests/x86/fixtures/notrace_target.c       | 71 ++++++++++++++++++
>  tools/objtool/tests/x86/test-checksum-alt.sh  |  4 -
>  .../objtool/tests/x86/test-notrace-target.sh  | 74 +++++++++++++++++++
>  .../tests/x86/test-special-sections.sh        | 12 ++-
>  10 files changed, 254 insertions(+), 14 deletions(-)
>  create mode 100644 tools/objtool/tests/x86/fixtures/notrace_target.c
>  create mode 100755 tools/objtool/tests/x86/test-notrace-target.sh
> 
> 
> base-commit: 6ecc854643e6fd6a2d07bc8d83015c7c34a951eb

Thanks, Puranjay!

For the set:
Acked-by: Joe Lawrence <joe.lawrence@redhat.com>

-- 
Joe

