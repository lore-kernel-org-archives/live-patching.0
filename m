Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E615A3FFFB5
	for <live-patching@vger.kernel.org>; Fri,  5 Jun 2026 15:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780672487; cv=none; b=XAR0n1oQQ8FxaUUUcLQamhDsVb8Dg6PgsxR0gjesvG32wrAFweWmZrESOI0TuUQ+bAZd9JvZAfmFYWIxyt2BPW+wfKq7cRBPGvzfuzbCHDhs7RWOvn42RQ4m3RlEeb3AhhMTbaZDRLl1z5Y4TXUozZ50P87YSkfuVIhtj47BZQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780672487; c=relaxed/simple;
	bh=pVXqDCGJxcTY09vnClQDvcttv3WvWGsjeGCHpdDkg7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u6xsWAn1jZcjIXL+R9VJbdWmf3cl8Y4SyOpPuNnqfwtnDzoVKmhDn6Kj8KzrWTDQeIaCG1ID0v/zUkwnAF1ZoyTmMdoEyXezVKBj3aXsszU6OOGbhcdSxoaCubIJjrWYCNh/IJ8PdESTMJ5nSsHMzz/ea8RfgXPfUPMwwobBHNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bb49GgEP; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bb49GgEP"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4908b92904fso23620465e9.0
        for <live-patching@vger.kernel.org>; Fri, 05 Jun 2026 08:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1780672484; x=1781277284; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w5Us6LXX/m1CkmS8+PwnhcahCPKlGB8k4LedTlqb3Mg=;
        b=bb49GgEPsSlce8cSGzzCUBfT7ydA151ASBn0zm/lNlFs/1W/JntJ5PRkvJ2Cv0ynMG
         /QH1sd6ws8dcrekw5fS0MeeEhOHcw1zjjMWy90tcGoKvauDEhumBQmpe3X9A9OKz/5XB
         jg4EzfAopKbU8+iVzsUWHGjE71Fn2nEyYDzFOZ7EQjsf1F9OmZaCEp/7o7EhBnrSKFEM
         Ybr2a9oLVCRVwe4P6mMF7d/pHHGO+bR8pUsyXEkF2jcU5dNWJC3TMuc7kakQZDUn/q4T
         iUet2MHtZO0o0eIKzRc7RoHFd7gTA0T3PpXXPBAGcMT3RLQJ/zcLBT678p3yABzZ4jnm
         gmXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780672484; x=1781277284;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w5Us6LXX/m1CkmS8+PwnhcahCPKlGB8k4LedTlqb3Mg=;
        b=RhHSq3LLRhFQzbYUYm1iJn9UTdgc3EjT1DDHr/9zuM9/goGLZcwts9+l+b/MfHF4wT
         oUltXz/Val1r0xGd97IgWbVB2WuRvYzKnMvpOroz7BXpve2I6O5EYFasxUvAjL/J/4rx
         INHYoxyL+tcWYHnUDJaKjCYO4eCHurqy4PEfD4EcJ4lHWyNuCehMifAenQI6USb3tj9y
         lrC1NAXnJVCZYbsnZXGJJXoa14ZmanurWCCDHYVwDKfMea1LoQwTbiYexuUsb+Nv4NWc
         AHbM8sns3/Ut/wR35JSSgFe0K3pMX+S8Z+u5CdyHoDT+/3hhAPJqpp58yEn7/qDxXxzW
         Warw==
X-Forwarded-Encrypted: i=1; AFNElJ+e/+EN/GJjt7LvEFStmYMuiaUr6rSD8LkrVOFcIGKy+WvK2z993LK/wG+xuaKAJWrO+hA+MdpCS60OG+pa@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlx8045F4JTZpgqav+MdLXOowA4WZPIGbUhBFLuhKeuOFX5zDF
	hfghJ0gg8LSuDAyJhLKw6XS/qduR439CouLq8hsGFEyCxX7gYHpNh0CHxomuYq7pqnY=
X-Gm-Gg: Acq92OE5m1NleseVJSJHDBaUEk3V/dsL6g5vGOrm8YqjhNvByDeYT3QCguVU0B6bqa/
	tRbQZTdTIjG1McoTMYne7fOYt6r+jbAGSvBMINsUqHzXOHdc/jlkYDIwz4Mfvh2qbSF+nIL20Rd
	JCLgLqycmmKaP7lWJNXwtQWYEYcTUCSVociFbA//84uOPOszWe4PtVLtoKISj0QCGLZt7SxL2Ny
	qj9Y4bAK0ev8NIVUZoTecWNe9Qs0ia1tAtJWDYNMlCHN8mkUtJYUQ1ms4N7RM1ZEI56omhuEcIc
	H/qmhT5RzLMDPjjILfTLK7vUXjIYSamokioNHtZ+i4O9Ze4DZMBVfVKez83NvccBV/EtKXGSHPB
	h2cyD8H59Z87L9EnKm8VoTcdFmVtLcHn/6l4KCNyEHbV/HS19Lq3d3rNvoC9OgRwIYGrr65dOIB
	lMS9qFl6dnWYAjTQizp8RMYzkuH4fYqvFF8UBN
X-Received: by 2002:a05:600c:310e:b0:490:b58b:a8cb with SMTP id 5b1f17b1804b1-490c263a615mr63235475e9.26.1780672484398;
        Fri, 05 Jun 2026 08:14:44 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f0a43e9sm26721601f8f.0.2026.06.05.08.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 08:14:44 -0700 (PDT)
Date: Fri, 5 Jun 2026 17:14:42 +0200
From: Petr Mladek <pmladek@suse.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Shuah Khan <shuah@kernel.org>, live-patching@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	marcos@mpdesouza.com
Subject: Re: [PATCH 4/4] selftests: livepatch: Add information about minimum
 kernel support
Message-ID: <aiLn4slwOcpXhDhn@pathway.suse.cz>
References: <20260524-livepatch-unload-on-fail-v1-0-7465de7f741d@suse.com>
 <20260524-livepatch-unload-on-fail-v1-4-7465de7f741d@suse.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260524-livepatch-unload-on-fail-v1-4-7465de7f741d@suse.com>

On Sun 2026-05-24 20:50:33, Marcos Paulo de Souza wrote:
> The current livepatch selftests are compatible with kernel 4.12, so add
> a note about it for future developers willing to contribute with new
> tests.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
>  tools/testing/selftests/livepatch/README | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/testing/selftests/livepatch/README b/tools/testing/selftests/livepatch/README
> index d2035dd64a2b..293f4730b927 100644
> --- a/tools/testing/selftests/livepatch/README
> +++ b/tools/testing/selftests/livepatch/README
> @@ -54,3 +54,6 @@ check_result().  The latter function greps the kernel's ring buffer for
>  those strings for result comparison.  Other utility functions include
>  general module loading and livepatch loading helpers (waiting for patch
>  transitions, sysfs entries, etc.)
> +
> +All new tests and test modules MUST be compatible with kernel version 4.12 and
> +later, including current upstream kernels.

I do not have a good feeling about this. One thing is to accept fixes/workarounds
for the backward compatibility. But forcing contributors to keep the
compatibility might be too demanding.

I might be wrong. But I think that you would need a pretty old
userspace to run 4.12 kernel. And most people could not get it easily.

Honestly, I though more about this effort and I am not sure how
complicated it would be in the long term.

I know about two pending patchsets which are breaking the backward
compatibility:

  + Better integration of callbacks and shadow variables with the states API [1]
  + Introduce replace set support [2]

Especially the 1st one is a pain. It is 19th patches and most of them
are fixing/reworking the selftests. I think that it was the reason
why nobody reviewed it yet. And it might be even worse if we wanted
to make it backward compatible.

[1] https://lore.kernel.org/all/20250115082431.5550-1-pmladek@suse.com/
[2] https://lore.kernel.org/all/20260529034542.68766-1-laoar.shao@gmail.com/

Best Regards,
Petr
