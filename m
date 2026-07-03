Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53C134388E
	for <live-patching@vger.kernel.org>; Fri,  3 Jul 2026 08:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783067173; cv=none; b=QcgicVIH2C7LFWmy6zQ5iO3bnHA6SKxDwLCyGQFQHeD5c1MaZznqtrR/gMZovfRHJA10yTXu/+ol9Z622o6VoHI8oR+5JrSgJPRRTDCDt8TzWsCL4qFvNYM2VSDnzeBqpRt4C9+A3F8wxWp2mTUcMAjooBS9+J9XNVshzkigLS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783067173; c=relaxed/simple;
	bh=XKI2pAfG7OX1O/DXM04l/YZndOsoqOzA948p9sxcHoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P7fH1gi8QGylGbhKStyjidwKUg/MDTopqD5ExhTkIUyFV9iitLeiByOgZZ4Bdqzdd6h/ekL6ORBHdNl4n/GBJwBVedlQMzkjoMnVvqJjrATTEV3uuTkwR8p8N8jMYf7P7Q2WnMDzdkPe+AAJVGqzigvSaM1lDnJ9uDzmG4CAlng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=S0cPpTDn; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="S0cPpTDn"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-493b61b52b6so1684725e9.1
        for <live-patching@vger.kernel.org>; Fri, 03 Jul 2026 01:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783067170; x=1783671970; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yi3rhvEIY7HPb2+WXJBWNBz8xP5NaPUV+FO6A/JpBpc=;
        b=S0cPpTDnY/bjqdlG6CvI1QWYPk5WPF2FxG4eJR8wwRsoNhViXn0w9GyWuFe//az0sy
         kHFQACYOK8imS6MyX6mTyKsKb9HOOjhnbc+HzOpILUw2F0lL7Wf+Ku/JoJ2oSH1ZPC3Y
         nVdC9E6StrdVwDFyd+MY8wpd993A+N46BN93Rv9TkT2JOa1ug1e1U/jr6Rb7+sayTzaJ
         /gI80KtGV5QxfK9xz9T2W58Yiq1aDV+CzEFVFi5LlWTP8bbEKIWK2iSpXYwueCfMGQBf
         stylJN1XLtC0U9Gy/IRbFfoMkbcKAViwIW0Z8dQkKH670y8b30IcuPIC76bpvn0tEutf
         b5FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783067170; x=1783671970;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=yi3rhvEIY7HPb2+WXJBWNBz8xP5NaPUV+FO6A/JpBpc=;
        b=sQ/OX7WEgGHFSz8nZe9lMzi0SbRncYRZmWtl0eDp94BFVW/vEObNTUj0f+8OTmbJ9/
         IvXNPMde7xNxp803ukUQbYF/laYKGxu/nvLJ/1VsBADfpARDYrWeC+KE2Z2m1kJqIDws
         9fj78i5cLmmgdqA9oHbroWJRyczDRXQEaS5dZy0TjQhJJVhI02SbYppmUwOYWCgoQBj5
         JRlDMNo++JclCukzwIHRpsaEVnfYHMGS2fkeBWcfrz0+eHZaWfUMazOn1AeE1B5Wj/QV
         ZAhFRcnzbxGhG51ZPfnWtcAaGkuUERO2kuzpEYMLmHqmFMG671fCJB9qS+i4IFpQkIFh
         AFZQ==
X-Forwarded-Encrypted: i=1; AFNElJ9JUPglYcvdiSXxCVYV0M1FDyfk3S6bUJ/DeQ8nYHSuBlGw9xOV47OLTBeFCr4sSmvpHRpNtBx0CjGRNuGE@vger.kernel.org
X-Gm-Message-State: AOJu0Yw933+k1If6MnW+PDt7uNhoLSXHAsqLbsq9BY2n0Ao2wEli25js
	pnJbmBDBs2shWE3VRNYZHg061qCzCo3hG7FLgCSKVtL1v6gCymtoO+XskMjYxUBZhBo=
X-Gm-Gg: AfdE7ckAZthYcOhEMEn4pdKJB9OpEMWGLxMeP4vQ/PYCYjzrRRdPQpnXmOFZF/JGvgp
	pZXM8NhyYteT8zwf6bkXYQc5jeSWzbJBiYOv4SOv5yIePZ6Q0MRuet/bGYarz7WmwFQaJJ0GfqQ
	4d/pEt1RW5ZuvZqhbz5cStAr/j0dzn5rJ6A/pEJEoS+YRsjGMDa422hd1C4DAZqPSFpHRIH6617
	oV7QWGUG72pcKIw99TA1xqimZ0AnYV7gqKg7Eytecl+mY8hD1EX41k0WQs8sh1ci7PJ2bNjg+1O
	7s/NDp7H/UEbuJZZqbWtt+nampOJf6oQkhkIrMkIZOIJomlacoZKNi0J5wVsgkHjlevS960D0Tv
	EI/+XY0d4ZBmgtVgJM4HV5dBDqz+0OlIAr+flfEbNHEWmM+icCX8GVWJRf//vTNlBl9EUvYYySV
	KVz9NRcMS6sTKmLXg=
X-Received: by 2002:a05:600c:8718:b0:493:c845:bc20 with SMTP id 5b1f17b1804b1-493c845bc60mr60654815e9.4.1783067170178;
        Fri, 03 Jul 2026 01:26:10 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493cce12c40sm50659555e9.13.2026.07.03.01.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 01:26:09 -0700 (PDT)
Date: Fri, 3 Jul 2026 10:26:07 +0200
From: Petr Mladek <pmladek@suse.com>
To: sashiko-reviews@lists.linux.dev
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
	live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	shuah@kernel.org, Zelin Deng <zelin.deng@linux.alibaba.com>,
	linux-kbuild@vger.kernel.org
Subject: Re: [PATCH] kbuild: unset sub_make_done before calling kselftest
 build system
Message-ID: <akdyH7rRV1WHtBJ3@pathway.suse.cz>
References: <20260703-makefile-unset-submake-done-v1-1-6899248f3d6a@linutronix.de>
 <20260703061449.246801F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260703061449.246801F000E9@smtp.kernel.org>

On Fri 2026-07-03 06:14:48, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Incomplete fix and inconsistent state: The patch correctly unsets `sub_make_done` for the `kselftest` targets to allow Kbuild command-line reevaluation when building external kernel modules. However, it fails to apply the same logic to the `tools/` and `tools/%` targets, introducing a discrepancy between build entry points.
> --
> 
> commit 06c418388d65deb3d8494a6e8e7071c0e709186b
> Author: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> 
> kbuild: unset sub_make_done before calling kselftest build system
> 
> This commit unsets sub_make_done before invoking the kselftest build system to
> ensure Kbuild reevaluates command-line flags when building test modules. It
> mirrors a previous fix done for scripts/install.sh.
> 
> > diff --git a/Makefile b/Makefile
> > index b9c5792c79e01..f717a4dc96d6a 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1591,10 +1591,10 @@ tools/%: FORCE
> >  
> >  PHONY += kselftest
> >  kselftest: headers
> > -	$(Q)$(MAKE) -C $(srctree)/tools/testing/selftests run_tests
> > +	$(Q)unset sub_make_done; $(MAKE) -C $(srctree)/tools/testing/selftests run_tests
> 
> [Severity: Medium]
> Will make tools/selftests still fail after this change?
> 
> The tools/ and tools/% targets in Makefile delegate to the tools build
> system, which can also trigger external kernel module builds (like bpf_testmod).
> 
> Because sub_make_done is not unset for these targets, invoking commands like
> make tools/selftests or make tools/all will skip Kbuild's M= argument parsing.
> 
> Should sub_make_done also be unset in the tools/ and tools/% targets to maintain
> consistency across the build entry points?

This might make sense. I see that the tools: and tools/%: targets are
defined right above the kselftest*: ones. And they are even advertised
in "make help" or "make tools/help".

Well it probably should be done in a separate patch. It would be better
for bisecting potential regressions. Thomas, Zelin, what do you think, please?

Best Regards,
Petr
