Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B699735DA6E
	for <live-patching@vger.kernel.org>; Tue, 11 Aug 2026 20:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786480587; cv=none; b=Qdg/pl+xz/Ydo5Mgf/z1ZT58npNnXgm8vvfRaZfVuAZQbJpooUCrE7GbGYabNdLqD1TPxY5LDVXY0D2M9kd42Z0ObUt8ffj1fvFKkNx/opyIa+XrjrNZESPE6kSkswoCzUdfdjkpFikCzRJUNerhHKQ7j5dY0ptgKDoozdvD278=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786480587; c=relaxed/simple;
	bh=si4E3FpnWMCL6KtjUNmeu+wca1502TXP9RfPHaajHlA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tqX6Cwk9iHbqxPZtPxOjAyUbSW2H53QB6flcT7Rm8HpoH6bKpDvdPFRz3JVDXW3t/yG31lVMWMD6LdPbLCGWZdtkX5RfNM/JMKOU2T+JsK3zYoresuDIBhJfiD7Kq2h88RCLlbs4Xb4SPj/giImN4aJOa1TZSIctTJ6YABy8AeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EAHKBNJ6; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=VY5PRHMD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EAHKBNJ6";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="VY5PRHMD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786480584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+UIxMzhyPyaNmCtNkXl8JJ8tSwnCDMaAh+5CAp4EXJA=;
	b=EAHKBNJ6Y40tdlipMDMdzQUEngUqUrXUzbBtODwPUjVEetWuY6Rlij1yTPCw8HQEoo9zO5
	u4cZX59NHjQJxkgyzEZJJgh5TIowpFqEhbKDRF7engKa4y+slu/ln96usVeAnYkXSwoZ5m
	yJ4nh/XDV3WgkdkCrRaUH3CpjQPP/1k=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-uCP3KXorPuO4qLTYZaSZ-w-1; Tue, 11 Aug 2026 16:36:23 -0400
X-MC-Unique: uCP3KXorPuO4qLTYZaSZ-w-1
X-Mimecast-MFC-AGG-ID: uCP3KXorPuO4qLTYZaSZ-w_1786480583
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5283df62d68so713021cf.0
        for <live-patching@vger.kernel.org>; Tue, 11 Aug 2026 13:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786480583; x=1787085383; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+UIxMzhyPyaNmCtNkXl8JJ8tSwnCDMaAh+5CAp4EXJA=;
        b=VY5PRHMDuHGhw2eX2gnRaos8vFv8H7KbKDvxLfiHYLvcs5BzGxBApI7TETK+UmG8Ci
         G8tJ9fU9IMzsdO43i666Yy0xPt9b39/bsn4WzWClPc2aTwPXyc4qX60RS5OtaGDvIuBX
         NHxBMkQlRdGf/1kp8/a+Tdw93O2RfFeibdP7+/VzX145jUhbUsJkyzawlhPQoFRABGo7
         33fcsCQjFp/F77SNk0F7Ry6xGWo8q5swdYl+/O+oqSsgjIhNe7J6mLBusFJNrjOx8EXZ
         nkpjknpzWJEqBDddw4mydWPmE91EyHS3GspkMMbO8WLUKr1sdg8dW6p5y3+3DyD0nXeK
         yWMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786480583; x=1787085383;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+UIxMzhyPyaNmCtNkXl8JJ8tSwnCDMaAh+5CAp4EXJA=;
        b=tWsMmnN0FmX5x3COJFAG9GTZ19NIzoC+IgJycFX7ojbe6c67g6dvhnd9abIWO3Tzi3
         rQJnr4UtEccVHDhx3bvTqf3g0b4AAXi/a+hk3o3z1Vq3dtFXpo+/ogVY9zqENYjYtEMy
         tHS8nMX180S/ZT8nemRzd3X+MtOrVVAAvfTdvlAqaVtTdob6SxVy9OqvhTmIc0sPJP4s
         NBn6N9/5bE0f/vKmGduORt6ZyllpbJw/DDcLY3zpnLBixIicwu+tKDB1P6pBmXQo84Tw
         d1NiUPXUfDgjm0vpjYftzk0BFfuj9wZJROa1KpX+S9OjvEFnUtqVoKQdpyWnLlzqm2ae
         kFiA==
X-Forwarded-Encrypted: i=1; AHgh+Rr2JzLM5b6TllymGXjvmKYcRzE3qVi0WF5m2RDgJMDyEL1xPeq8/urc74uOlkZ5ikYcVXNgLYV98CllKd8Z@vger.kernel.org
X-Gm-Message-State: AOJu0YwMv0PcJmB3RCGvKLTqriTTGqxanfsXkAwEoT7n22zAvWnPQ+FO
	Yz+OFkMJU0gh+PyX6Q+f8ytsh12trF4ngqWyk+Oz0eeX5RgrkVuLNIsEGeT/0NLypVuht8LzFvV
	zajsjnH6QWCX857IswrId6vU/wbAOz+JARXJg82q29obsGuboD/qsDcAh8c5FXmJwxCY=
X-Gm-Gg: AR+sD12jbwWVxl7tzaTQbhh6B9XniPe2ksICJYPc89Oajj/0UeUJzuv5lXvj7S4Io7N
	RufrnOUmscrIfF/zpH3QUjn86yKnxBRyYuKCiFE5n+aGIvn4r3yoJZVJJZ3xDrJm9KO8TCIPouQ
	bH8vtX0ukEmZP7lnIQZDQ+ehVdgB4uYPGuJSOyW/IrQxaRDG1MqJeWXJkd/Yquso/O7gafpFM60
	1Z0ccGBCnOAqG7FRS5WaD8wGFYqTHm+rKueb5VetXOED9pnAkrBlN75IED2D8kJj+3HHoojXgNP
	So9t5JdZ0JuBx1nZ/w/cRvPJ4tdTVAFZLsTQSDL9XVs/uVxQXxXXHVx/eaNGSWcmLEbbUQnerPF
	uskM3Oc0YVYacx3FArStCSkXVjh+6W4oKCAq/6dbXcive9JmWSACkAJiv
X-Received: by 2002:a05:622a:411a:b0:51a:89c1:1eef with SMTP id d75a77b69052e-52d646fa27fmr66781cf.14.1786480582642;
        Tue, 11 Aug 2026 13:36:22 -0700 (PDT)
X-Received: by 2002:a05:622a:411a:b0:51a:89c1:1eef with SMTP id d75a77b69052e-52d646fa27fmr66351cf.14.1786480582172;
        Tue, 11 Aug 2026 13:36:22 -0700 (PDT)
Received: from [192.168.1.26] (pool-68-160-160-85.bstnma.fios.verizon.net. [68.160.160.85])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90a6c26e595sm7218106d6.1.2026.08.11.13.36.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2026 13:36:21 -0700 (PDT)
Message-ID: <e4d44ac2-e719-4fe7-b68a-e15a03bb8ced@redhat.com>
Date: Tue, 11 Aug 2026 16:36:20 -0400
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/9] objtool/klp: sympos/module/alternative/etc fixes
To: Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Miroslav Benes <mbenes@suse.cz>,
 Petr Mladek <pmladek@suse.com>, Song Liu <song@kernel.org>
References: <cover.1786138493.git.jpoimboe@kernel.org>
Content-Language: en-US
From: Joe Lawrence <joe.lawrence@redhat.com>
Autocrypt: addr=joe.lawrence@redhat.com; keydata=
 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
 pNzsRQ==
In-Reply-To: <cover.1786138493.git.jpoimboe@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/7/26 5:37 PM, Josh Poimboeuf wrote:
> v3:
> - remove "size = 0" and add comments to create_fake_symbols()
> - add patches 8 & 9
> 
> v2: https://lore.kernel.org/cover.1785939903.git.jpoimboe@kernel.org
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
> Joe Lawrence (1):
>   objtool/klp: Allow new references to module exports
> 
> Josh Poimboeuf (8):
>   objtool/klp: Fix vmlinux .klp.symid link error for .no_trim_symbol
>     symbols
>   objtool/klp: Fix size of empty special section entries
>   objtool/klp: Ignore replacement offset of empty x86 alternatives
>   objtool/klp: Explicitly disallow patching or referencing init
>     code/data
>   objtool/klp: Fix cross-module klp relocation section naming
>   objtool/klp: Don't match local symbols against exports
>   objtool/klp: Fix relocations for EXPORT_SYMBOL_FOR_MODULES() symbols
>   objtool/klp: Fix line numbers in Module.symvers parse errors
> 
>  tools/objtool/arch/x86/special.c        |  27 ++++++
>  tools/objtool/include/objtool/klp.h     |  10 ++-
>  tools/objtool/include/objtool/special.h |   7 ++
>  tools/objtool/klp-diff.c                | 106 ++++++++++++++++++++----
>  tools/objtool/klp-post-link.c           |  53 +++++++-----
>  tools/objtool/klp-symid.c               |   1 +
>  tools/objtool/klp-sympos.c              |  10 +++
>  7 files changed, 175 insertions(+), 39 deletions(-)
> 

For the series:
Acked-by: Joe Lawrence <joe.lawrence@redhat.com>

Previous test cases from the earlier parent patchsets and reports run
positive now.

Thanks,
-- 
Joe

