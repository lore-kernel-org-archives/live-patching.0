Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794292512;
	b=KhLMOa+Vgy5vp7W6r9GKwDLQcx1KBuPjX/Tt1m++9RKVrT0WPKxZJPwDPZZMdr5OChbv
	 s7RYkywcCwzGzjQrMVMBJFVl2Nal0EJZCn5SU9G3HVSLq9Ry26AksXLvWW/7TdhCYs5yW
	 l+VkwD/Hom3d5l8oaXCvy0+/5OISIbs7IvYYZFFjjl7VR6d8duaaqrWVQTeCME8KceFj/
	 XEyMyYMkA4QkyVJjTqwvYyimf/6iGLRWjfxAm61BqJry3lOz8Hve0+bOs3nhDWIs0EOHI
	 L9MvZ3Z6u1WEaAh5pc80W/QuxSu2kNtK2ApmHmnRvFY5HIQSJ6BrhrNswNGJGCHKIJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794292512;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=SrAtUp9emSKSwdDhGVp75ycz8yJkKPQkr0AQDP+R5XY=;
	b=j5yVj9WBNZJCvFq79NzaXvdIEcvnQaYQhkXm42JOAH3+PG4EnTFVlACmtMGbXdFFZPee
	 8MRYhCkvVYCIjf69bV5PzNSvoOgMAkN/YGQHA+kLrBLZlQ2+xOp2cXoM148oFRfDX9wE+
	 8RPsVFW9pziCx3c/3LAS3Jf4H3j7139tOrtuimG1jE0/FHGPLA89u+Tzyk59GU9fazIms
	 9NROMI/RDhFDLdcLZqsulDhDZ1HApx9w8/V5kOlMTJHR+ri2YCWEt6wkNG+ull4iav2H7
	 OEdBBtd8/lgRgaoyfK29vyrJRDooO2amzekJtEDzQ+USeGKtlK9hTno/FM+zdyHUDLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KvZh9KkF;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF78606A32A
	for <live-patching@vger.kernel.org>; Tue, 10 Nov 2026 06:35:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8DF78606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KvZh9KkF
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-492f0a1b685so1093080f8f.0
        for <live-patching@vger.kernel.org>; Mon, 09 Nov 2026 22:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794292511; x=1794897311; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SrAtUp9emSKSwdDhGVp75ycz8yJkKPQkr0AQDP+R5XY=;
        b=KvZh9KkFCB0l/6Bmr8nRlFNiNAYwTuU4bAbREFGDiprWKCca1D9gjGF60eGJA+3F1m
         /bv5d5Tc5eWM5D865wZT1/xR3NEMOOdRqy4g1KkEy4dNN0ai3E7ZEOXBKCO9AA5jrZON
         81noRzABdcThsTx/uPfWP2XKO8tbYcZNnqcldty/UzrmzSJt6LP+9II6IP/t+90m35A4
         cHdS20nAQY6nLpp4JCwaxwmfEkKJkszzwHAQ0RkC24pcwIC8g2itd/wYEPWH0RU5LloK
         +jxZ0egu/5nUvtzeuP+y0T3PHWti68rhJPt30aoXkp9b4h0G+AWEqtc8wek4WNU9qfaJ
         cryg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794292511; x=1794897311;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SrAtUp9emSKSwdDhGVp75ycz8yJkKPQkr0AQDP+R5XY=;
        b=xVigTmd3vzzn2s/KrZuIXFc9VuMjv0U48GpI+9ajDUwXBTFvh5/XaO3ka7jWrGrgF2
         NTPMPh8OaVHaeymh5/vk3dfjaWZTaOdIOq8MiMs88SPSmpGShilJo0sGxCZDP8L56bx8
         QMsjD856jTPN54XPujrCqs7b1oP9uVHVa9wNM1axh1drGu2XSKk5wOEk2SSy2nZI6jps
         j4eTTar1dvuYkmxgdtah4D+pPwJstFjC81XsI0HFv9LABYMedQPL01OaO8t9IZgWqz+C
         lfRaxAWACkY44XpfjGwmR39stQevhFUarIr3cjtjWQ57qa/VH/pcjjMZOPFlUmiB1GWS
         5uXQ==
X-Forwarded-Encrypted: i=1; AL+hErGZvb1KXgVltKmWcIWuGFZekIHL7vuhMFMv+5Uon7Dx/BXSeTy07XYopVddOoJYeIP8KCnclz2rQmEzQ5Dp@vger.kernel.org
X-Gm-Message-State: APuU4Z+5veATDwfCieBKxYHy1dSUd3vEKabrX6lopJF2KIuZ8P1EQt78
	04K/qUBtymvB7i0BRc8NQrqdNSdEJDGz5ldjrUeEBPBtNZ1NvGJcfYkq
X-Gm-Gg: AYBFou2UF4La/gh+4l5MbUbVV0g/xxFogwd8JoqOCCCz+kDP7gW0xe6EZYiEAQu7M6r
	oC0dmuRFQIpxxMg1CW+4rGwCx/+dK+OQL0grTZAqbvm9hwqkLBTuuJKtnEs6fLyxeODJ5Hbm/MH
	aySy/Odu00dlvkgqvE/lawXqyyrxsR3GcvfgjmohRxPR4nLpAYgwE8rKwriiXGdNi8lkR3Cby9w
	251AGOjabl8lz/NurKugsyAd3L92so1h9voSNTJBorqX+yuJwE7LBTlhgGBxpYjoeLYDXXDYoYD
	Ah4CPh8uwzYi2RFhGyzdplry1gIdyLmm+12eD75VclNcAuS0J7tBrpk1czTdB7M5XMjCXh8feMV
	yHbZoJ8W6zDzDuPfIFNVt+UF9AZViV2V7k1nrz44Z0Ct2tSd8sqt+otZOSoctFPPSBo7db8yert
	Q8aZJ4FjfEOshby7bvqJTYHot1kkKrzTQSeq3LyIH7zf3BlhCr5r64DN5F8WcmXtQ15R7spUxRm
	k8kaMUIcDvgjJDu4yFqNCEEEDCVKSeblgyvmmbMycoHDoUzSZsjLCGcMvb49UCgr6e8y7o/ugvd
	cKxi1UBtkC9LSQ9SWIuG3ObvCdPLY45dHYzQsBbT/gSqM2/pJfRUswtZ3A4sRKToPDubhUmW1c/
	A2lma3nhMfZgk87t8DRUp3bFzx37r0GY3IH0pyWpp3oL2wH1dzy8Z7GoouZ1xVJXG/jtkeMZp/P
	7Ws9mFpiXqyp/6lKASmghE8SsNo97TNAE=
X-Received: by 2002:a05:6000:288f:b0:48e:3cec:b852 with SMTP id ffacd0b85a97d-498306d02e3mr2957082f8f.40.1794292510590;
        Mon, 09 Nov 2026 22:35:10 -0800 (PST)
Received: from MacBook-Pro-von-Karl (dynamic-2a02-3100-a0e9-dc01-c402-36c1-c306-953c.310.pool.telefonica.de. [2a02:3100:a0e9:dc01:c402:36c1:c306:953c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-498366c500asm3241156f8f.48.2026.11.09.22.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 22:35:09 -0800 (PST)
Date: Tue, 10 Nov 2026 07:35:07 +0100
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: palmer@dabbelt.com, pjw@kernel.org, aou@eecs.berkeley.edu, 
	alex@ghiti.fr, linux-riscv@lists.infradead.org, oleg@redhat.com, 
	rostedt@goodmis.org, mhiramat@kernel.org, mark.rutland@arm.com, peterz@infradead.org, 
	mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	james.clark@linaro.org, jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, 
	pmladek@suse.com, joe.lawrence@redhat.com, shuah@kernel.org, mpdesouza@suse.com, 
	martin@kaiser.cx, oliver.yang@linux.alibaba.com, zhuo.song@linux.alibaba.com, 
	jkchen@linux.alibaba.com, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v7 00/10] riscv: Add reliable stack unwinding for
 livepatch
Message-ID: <avK6oydgmtsa_Sjg@gmail.com>
References: <20260914092648.51254-1-xueshuai@linux.alibaba.com>
 <20261110013750.36800-1-xueshuai@linux.alibaba.com>
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110013750.36800-1-xueshuai@linux.alibaba.com>

On Tue, Nov 10, 2026 at 09:37:40AM +0100, Shuai Xue wrote:
> Changes since v6:
> 
> * Rebase onto the current riscv/for-next (based on 7.4-rc1).
> 
> * Fold in Karl Mehltretter's two patches [1] as 1/10 and 2/10. Patch
>   1/10 stops arch_stack_walk() from reporting the walker's own frame as
>   the first entry, which corrupts the skip-frame accounting of
>   stack_trace_save() users (page_owner, perf), and adjusts
>   return_address() level accounting accordingly. Patch 2/10 adds a KUnit
>   test for the start frames. Both patches keep their original authorship;
>   I added my Reviewed-by/Tested-by and sign-off. I asked Karl on
>   3 November whether he would like to see his patches folded into this
>   series; he has not replied so far. Since 8/10 reuses the walker
>   extraction from 1/10 for its !CONFIG_FRAME_POINTER fallback, his
>   patches are included here to keep the series self-contained.
> 

Thank you for folding those patches in. I'm fine with that.

Regards,
Karl
