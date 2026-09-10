Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225FF39AD2A
	for <live-patching@vger.kernel.org>; Thu, 10 Sep 2026 21:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789074323; cv=none; b=Q8GuLeb7v5qrdNqJc8k7eFs0GtzdWUL7vI/dt44lEtaGthcq9i6jbw12UPot1vajoG4SXpjmW8D6QH/04BiuBj6yp3dyO58DgTKJxf9tEO7rhNkc3OPImZOP1/vlgjB33w8p5WEnmjq0rxE/6ehXRqTBCU4A2DqEnH8KClq1y0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789074323; c=relaxed/simple;
	bh=8CAYbrJPxz+s8RC8coWglgAogcKoHYCar7gy9Kwb38c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fynzAq+B7mej7h2q/OcCYWIWYvaDAhuazGDFGweY68WVPeJvhbKARbbEDjcSWIYPrM6Q6vUdRbt9Agn+AtM04D0KBAaQ8E43efVGiuF3/b0Cd4vT6tZhJwvflccATrQ3JAc46lGY+DHqdYfX41VfjaWr33xgC89helHEYcljgBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TFAzyEBZ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CAuUkctm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TFAzyEBZ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="CAuUkctm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789074321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MXKna9dovDvqL7SIQlWbS8xMZO8QuDNAqOqMbSq+Onw=;
	b=TFAzyEBZmsNo37sXYrfMvjmoIbjHeWlF8uSFmr5R5mqjixUZuDY3mGtdIzAgmxTGexc1Ey
	AH1Hc9zy/972BAG5S/0g6eS7NFRCqBg23p+xYrIo1PC8XXcu8huImeoRfOE69kDNQ7V0M0
	tSc/JN8zLV9DNl11inL4fVa4bUDyR+4=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-EhqLDwE6PjikJ_mnCGV4FA-1; Thu, 10 Sep 2026 17:05:20 -0400
X-MC-Unique: EhqLDwE6PjikJ_mnCGV4FA-1
X-Mimecast-MFC-AGG-ID: EhqLDwE6PjikJ_mnCGV4FA_1789074319
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51bf321d786so2655331cf.1
        for <live-patching@vger.kernel.org>; Thu, 10 Sep 2026 14:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789074319; x=1789679119; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MXKna9dovDvqL7SIQlWbS8xMZO8QuDNAqOqMbSq+Onw=;
        b=CAuUkctmpdhpRNLp9OGiIRey3xW2iLspzgh6n0eOqJGqKdOmRAlfT92ojACnqTPC/s
         CC7+qtuVVyjGcyFReX2UlHS1hUZjaF1KRtbSoyINbSv2OZ+mJ27PFU/3m43siq44U0OI
         gUzm0OL/1fBjtbanl8+lbLKQDE0CneEtuPP4pbdb4ju2+KFJ/rzq2G35VN2dcwsxTKX9
         1L3TumRZr+pk7Iiu816aUb74s4fN0yYVu+0c45hc5Lxb8wGipFvPxaDzgzu3DnMjMAar
         2XAWpsAq4CfUexluJO+EAXy5xUK3bJ4pB8blyfRDEYntxmDqz0YUsNPR6LZIaQdzcSiU
         q/dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789074319; x=1789679119;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MXKna9dovDvqL7SIQlWbS8xMZO8QuDNAqOqMbSq+Onw=;
        b=ND95I3Qb7zuEPmoPoU4PkITjbL4w9ZufCp+nfhBN63g0a7Vu2/nCITHD8BYIryo8pF
         c17/zuPcrcT9H/13iwW0uu8d4GJhdClmq31KmHJSiVL2DX5kl+q5j6b4jKDsNKW57UNO
         Y7Ck0Rhfpmw1JDbeF/C5wsk580ub8mjpBaCPqk5IK3rhPBasnEE0F0hGV9WUNlmRhyE+
         hrpA9XHuooLw0zmgKF0g0PbShmMoFSMN9r6x4v7LXzFlz5dJAdDBWHNumZFJIuqnfHQ+
         Kof2jjw7Y7vA0PYy9O71QyjYqeN/DlGJ4SKYvqtvx7UL/Kq8eJZND0SB0PM77Z2h3BVP
         T3zA==
X-Forwarded-Encrypted: i=1; AKwUvBzwIeHONLYj8LvDYc5rkyoB1EmYXnJP0BhhCJ3Afuu3/ECdFxgUrBv5YU18xdH6vPA54tMh5Yp2KlRGQwDv@vger.kernel.org
X-Gm-Message-State: AFuF++nZTqkF7UfMET3jt9eQZHFGMbZp3RmFo41dp027nTM7OhoeigXT
	f7EvmNczo2JrxGqiGzMZ/D6blFZgOhalVbBJpfFKyyCUMlZwswBuLzLUCvvXOl+jAGezZrdeGmU
	6Ega9nvSwiqDB09+0t4LDkKmaJtsIGCYBw5egh3OIP5V4dxukA7I5iHjZu0cPcZQ697M=
X-Gm-Gg: AYBFou0Kjck596y9Ekwy33Fmjo9mPc+J1G7Y+4KhMxhnJBxKgjEucGzQfIfvtJfxGQ0
	7ta+SljszJMPKJ5bHT5kqwVsReAojqJ9sX0qTRSjxCi/ci8Yho3TX9PTsN0lltlZqpwP+ihE0S6
	3ay8o1D/FYrTf+Mwvd1ykYl23c5SA26BOl9JhvsAJ78BXd3rCS77gV0h/SGrXi9SH0NeU5k+o5r
	N6Qv28crhN/7E8xefmqN7xYzbB4ihXTR9CsXfFDHSQr5iFDiE2noYeoT1I1bUUUxMjZ/x2OuVoT
	QgMqr3J/N6CLxTHc3nMNb4UW8zw8FnJhE7pR+ctr+SK6hcrbjQwZ/9eyyVEQ3pmQTqqhJuk/0cK
	miEJp0YoYcmHRj4FzfhJDxSFWoxi8kGUYSsxPuOxAt7kwY7c+DYaj+V+x
X-Received: by 2002:a05:622a:4c8d:b0:530:780e:9613 with SMTP id d75a77b69052e-530c84d450amr22519861cf.8.1789074314438;
        Thu, 10 Sep 2026 14:05:14 -0700 (PDT)
X-Received: by 2002:a05:622a:4c8d:b0:530:780e:9613 with SMTP id d75a77b69052e-530c84d450amr22512641cf.8.1789074309197;
        Thu, 10 Sep 2026 14:05:09 -0700 (PDT)
Received: from [192.168.1.20] (pool-68-160-160-85.bstnma.fios.verizon.net. [68.160.160.85])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530ca45bbd7sm2903821cf.8.2026.09.10.14.05.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2026 14:05:08 -0700 (PDT)
Message-ID: <be81497f-1b88-4337-b577-0f3a2b7828b0@redhat.com>
Date: Thu, 10 Sep 2026 17:05:06 -0400
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] objtool/klp: Fix checksums for constant pool
 references
To: Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Song Liu <song@kernel.org>,
 Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
References: <f3a9e74ceebc6475ce94bcfe985401140857814a.1787939301.git.jpoimboe@kernel.org>
Content-Language: en-US
From: Joe Lawrence <joe.lawrence@redhat.com>
Autocrypt: addr=joe.lawrence@redhat.com; keydata=
 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
 pNzsRQ==
In-Reply-To: <f3a9e74ceebc6475ce94bcfe985401140857814a.1787939301.git.jpoimboe@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/28/26 1:48 PM, Josh Poimboeuf wrote:
> Adding a line of code to __link_shadow_page() with a literal string
> causes a false positive changed function with GCC:
> 
>   arch/x86/kvm/kvm.ko.o: changed function: kvm_tdp_mmu_map_private_pfn
> 
> While the patch only touched __link_shadow_page(), the string addition
> triggered a rename of .LC64 -> .LC65 in kvm_tdp_mmu_map_private_pfn()
> even though the underlying referenced constant data didn't change.
> 
> So for .LC* symbols, the suffix is arbitrary but the data isn't.  Add
> the underlying data to the checksum calculation rather than the symbol
> name.
> 
> Clang also uses .LC* symbols, but also uses anonymous data.  Both
> compilers put this data in .rodata.cst<num> sections.
> 
> Fixes: 0d83da43b1e1 ("objtool/klp: Add --checksum option to generate per-function checksums")
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>  tools/objtool/klp-checksum.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/tools/objtool/klp-checksum.c b/tools/objtool/klp-checksum.c
> index b8e47f28997e9..ebe25f9c5260a 100644
> --- a/tools/objtool/klp-checksum.c
> +++ b/tools/objtool/klp-checksum.c
> @@ -54,6 +54,19 @@ static int checksum_debug_init(struct objtool_file *file)
>  	return 0;
>  }
>  
> +/*
> + * Detect a reference to anonymous constant pool data which the compiler places
> + * in .rodata.cst<num> and which either has an .LC<num> symbol associated with
> + * it or (with Clang) no symbol at all.  These are typically initializers for
> + * local function stack data, so they're considered part of the function rather
> + * than data per se.
> + */
> +static bool is_anonymous_const_data(struct symbol *sym)
> +{
> +	return strstarts(sym->sec->name, ".rodata.cst") &&
> +	       (is_sec_sym(sym) || strstarts(sym->name, ".LC"));
> +}
> +
>  static void checksum_update_insn(struct objtool_file *file, struct symbol *func,
>  				 struct instruction *insn)
>  {
> @@ -129,6 +142,14 @@ static void checksum_update_insn(struct objtool_file *file, struct symbol *func,
>  		goto alts;
>  	}
>  
> +	if (is_anonymous_const_data(sym)) {
> +		void *cst;
> +
> +		cst = sym->sec->data->d_buf + sym->offset + offset;
> +		__checksum_update_insn(func, insn, cst, sym->sec->sh.sh_entsize);
> +		goto alts;
> +	}
> +
>  	if (is_sec_sym(sym)) {
>  		sym = find_symbol_containing(reloc->sym->sec, offset);
>  		if (!sym)

Acked-by: Joe Lawrence <joe.lawrence@redhat.com>

-- 
Joe

