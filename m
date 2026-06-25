Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390073749F0
	for <live-patching@vger.kernel.org>; Thu, 25 Jun 2026 09:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782378642; cv=none; b=kiJDSRn0H4e5AO1bOCWr6M5KVpEmBSYUfDr7SSwg4BUOHLKHMWDq53n6jAkngXfU9ED15ZJUpuuC1/b2QP66eemeBwu2kBTUg1pbOpzppup6g7KibsJFcW7dZN9A4lFvxRQ+x4T+7zHM48Kwnt6/VqKE3CoGBLVlZaiFDDhiwLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782378642; c=relaxed/simple;
	bh=G0vBagMm0ieFzup4YLfopFJNtJUW4rndd7e+AydHtO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qZfa01actQwKH/RqKG7KgW1Y+VcYpgueziEL2/hYqrIukHfQoUasmY5/ywuM/AJCivFdrvBdRBYqoL2RjgiVe3K0a+otLuKgVfv3vQ64RPSgiEcUOWG9/j0ZCZAD1y2iD9cg/3OCoSa0xxogK29f5XsqhwENTUbznCven+2uauA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JBh67hq8; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JBh67hq8"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-46daae24c79so393991f8f.0
        for <live-patching@vger.kernel.org>; Thu, 25 Jun 2026 02:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1782378640; x=1782983440; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MiLqXmBDb7ZWVjHCd2a5Lz+vJUTtAmbRgJLuU9Ruhcw=;
        b=JBh67hq8mddQ6mcUJpzD092VVC/3s+opTmR7Wg/gX8+s5w/MzKgD9dRFiDY7xEGhD7
         Z4y28HERPHI+r/znUsUscQuQRifPXxiY9jCR0wqQn8YSP++rh47wTQUUCI2iijLa241e
         aanltwTDq4Lg96AbuCbCsEBfIPnDqr5JRsX29CVPQQTOGkY+FopCZZ7wVKDksrwz1/hK
         lcrivgyInDpjX++AbETUUJ87rQlgDVRMZlSWQgigrrFZiWPtfnMoL5raoEB2Sb/2xOdw
         HS3wHf3An0ns2EsNUbrW/S8wwGhw8HAVk9komOG2axmmgK52XjGqSY/1iAJufRz/DsLd
         rdOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782378640; x=1782983440;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MiLqXmBDb7ZWVjHCd2a5Lz+vJUTtAmbRgJLuU9Ruhcw=;
        b=iLXCDFRf7ZEzaOGKTiY90LxHjnLyZxWBi/+7rZKEJdWbQxHPfzBk9MHQenxhujT5k5
         j+hPggSLYRG1TzVupfbSm74RJ38W8MHm5XKeINiBYCONaYncctF7mSKbvXzqUKbEho5h
         uFUpduuLPcvP39QVX03l8ItFUynYiAJ2/1gIXoT+XO7ki+TCIO+WCiEgCHQlPclwjHG9
         Hxygb/UN7vwqy+26X3OWUVW6NNk77aHrsih3J59QjdOt7uV0YFiTByqSTi/4NSbhhzqu
         5s1JlZMHqeCqhyWJbgIb7I0wq0/V8EC8iCbRkU2gwf+2zHBkox3dmxFh5Qz7LwuLrxZJ
         spSQ==
X-Forwarded-Encrypted: i=1; AHgh+RoghJ51C33YOTtXLvelvtD9TdbjCuGbNX8ctHFlmjWmboXL2k9rw/WZLOUIkArWYpVXb9hGaqpwiNZCOmMb@vger.kernel.org
X-Gm-Message-State: AOJu0YxipoJLuD3BP5zjEQRmLHVZRd/9Af6uyLuXrfQEZLlxc8Mz9B3w
	Q1ZNfCK509ulpPcEXdofd75gtrweX43BM4I1haYsvpsmu0koA2aOj7ddav0/FpCpuE4=
X-Gm-Gg: AfdE7clDWHrL3hhrKZkCjjnH+ateROouCuGADo8XxbTLwt9f2rPeEATTqCBD+eCN6d1
	SnAm8tKMIQh+g1HXyaNM3se4GYjPgy8PSkc8UQ3w9WkYCqYaC0YbbCeHUrAzKhGsB6jJlAbpkd9
	bgiA1w741iW87NxepC9SOnJ3MYOvvuWYnF5lmErsOHImXjuDvm98bZfF8LfN4wnjEYC2lPqgkR4
	YPr46+bd7Il82RncKURL4cJM/uE2QsLVClEfF4zAYuKqCCCoH1/SPT9XSCcBYiuOP8pAwPxzBz8
	cQr6HiII9rUBwz/8vzLpgG48Ywb/MSSJcgTOVTCf1KPhgbmuUFFHz37fhoY23SwFheR8WGZNrex
	x7O0+2iBOTNIdkhaJxR/QdAIkrbUBh4xsXVFCDoYAg1N/61O0PXXBxft00pVmpA8ed/9pT2Q8hi
	GfHOdlhR/XMVlYZ4o=
X-Received: by 2002:a05:6000:25f1:b0:460:64e8:2553 with SMTP id ffacd0b85a97d-46dbf303509mr2291377f8f.4.1782378639570;
        Thu, 25 Jun 2026 02:10:39 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c221d9405sm15939403f8f.22.2026.06.25.02.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 02:10:38 -0700 (PDT)
Date: Thu, 25 Jun 2026 11:10:36 +0200
From: Petr Mladek <pmladek@suse.com>
To: Joe Lawrence <joe.lawrence@redhat.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org
Subject: Re: [PATCH] perf symbols: ignore livepatch symbols
Message-ID: <ajzwjNncrI3Bob_o@pathway.suse.cz>
References: <20260624201254.472576-1-joe.lawrence@redhat.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624201254.472576-1-joe.lawrence@redhat.com>

On Wed 2026-06-24 16:12:54, Joe Lawrence wrote:
> Livepatch modules contain special symbols (prefixed by ".klp.sym.") that
> act as relocation placeholders.  Once resolved, they point to the same
> addresses as the original kernel symbols they reference. [1]
> 
> These special symbols confuse the 'vmlinux symtab matches kallsyms' perf
> test as kallsyms may report multiple symbols sharing a single kernel
> address.  For example:
> 
>   kallsyms (without livepatch)
>   ----------------------------
>   ffffffff81a41110 T __pfx_arch_release_task_struct
> > ffffffff81a41120 T arch_release_task_struct
>   ffffffff81a41140 T __pfx_exit_thread
>   ffffffff81a41150 T exit_thread
> 
>   kallsyms (with livepatch loaded)
>   ---------------------------------
>   ffffffff81a41110 T __pfx_arch_release_task_struct
> > ffffffff81a41120 T arch_release_task_struct
>   ffffffff81a41140 T __pfx_exit_thread
>   ffffffff81a41150 T exit_thread
> > ffffffff81a41120 w .klp.sym.vmlinux.arch_release_task_struct,0  [kpatch_5_14_0_570_94_1_1_3]
> 
> When perf loads kallsyms, both symbols are inserted into the
> symbol table at the same address, corrupting symbol end-address
> calculations and causing test failures.
> 
> Filter out symbols prefixed with ".klp.sym." when loading kallsyms, as
> they alias existing kernel symbols.
> 
> Link: https://docs.kernel.org/livepatch/module-elf-format.html#livepatch-symbols [1]
> Reported-and-tested-by: Ben Procknow <bprockno@redhat.com>
> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
> ---
>  tools/perf/util/symbol.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> >From Ben's tests:
> 
>   Without patch:
>   ./tools/perf/perf test 1
>    1: vmlinux symtab matches kallsyms                                 : FAILED!
> 
>   With patch:
>   ./tools/perf/perf test 1
>    1: vmlinux symtab matches kallsyms                                 : Ok
> 
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index fcaeeddbbb6b..eeaed3f5cf50 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -774,6 +774,10 @@ static int map__process_kallsym_symbol(void *arg, const char *name,
>  	if (name[0] == '$')
>  		return 0;

It seems that the above checks has been moved into is_ignored_kernel_symbol(),
in the current Linus' tree, see
https://lore.kernel.org/lkml/20260522082604.89447-2-qirui.001@bytedance.com/

> +	/* Ignore livepatch symbols */
> +	if (strstarts(name, ".klp.sym."))
> +		return 0;

I guess that this check should be moved there as well.

Nit: It might be possible to include <linux/livepatch_external.h>
     and use KLP_SYM_PREFIX instead of ".klp.sym."

> +
>  	/*
>  	 * module symbols are not sorted so we add all
>  	 * symbols, setting length to 0, and rely on

Best Regards,
Petr
