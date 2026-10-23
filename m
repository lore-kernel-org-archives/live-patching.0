Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792767913;
	b=kCtlG+2XXpMa/wc+HOZOd9kkwpcEaaCANcLTivJYXoYqTk/BM4jHfVytVXWn50cF/akE
	 JsGV6Dt+PQSu/AeZaDsP55IPywwRMQMhfwZWur4y5/kpwJ3mYh8No4y3v82XFGVIgy46n
	 c1/Hftz1UJ5L/sunOlSXTpKJLfAXjXcrUEq7JyJ2u4/KmZltZPvEAkimU5D8NfSsVTrYV
	 RWBfUdOGDY8lWYyckeM2/L2en7WsiKk10OIraf2+SKolq4pXdfdCi0oV/+nmrXdK+E4Ia
	 pxX1WkeUTBnMdJMCf8de7o9PQMPbEUuDmz4hcjaDHU7U5X8bk1RYm0XXIxmp2xyZINA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792767913;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=AVt62T+eZv2jUWbbskvSmL3IjPCv9lgdm+h7Tjv1RW4=;
	b=y5eF4Qe/dlOyX7CAWPlIRCVFcr2zswYiKYarlvkozWe2maZatZnKqI1GqrCjMK9SoQbx
	 IxTGOroLawRUfTFRPM9DLi0x7gn3pLQYUAKzvBI61HYNxqWmnhkRTxw5xYhPHBj+6CXel
	 Q4BCT2z9SelHxOrauytsWNFwzrsEPxZWI6W16SPedRWB+uv3y3eOvfwxU9DN42fDhyFHY
	 2/rjPQC/AgwIhWBiR9AAhvz23K8+/sUecXhmaIa5jscSbdGFnG1riG8aGQOftipOI2ZgN
	 9fNDSKBXKanrxcNePas7pBcfPkH/uQNMQXInO8yZGq21enMjzh0qLO2A8FitHj1jejQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=g0nqwTKx;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2596E606A31A
	for <live-patching@vger.kernel.org>; Fri, 23 Oct 2026 15:05:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2596E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=g0nqwTKx
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a1ec92f655so10354215e9.0
        for <live-patching@vger.kernel.org>; Fri, 23 Oct 2026 08:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1792767906; x=1793372706; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AVt62T+eZv2jUWbbskvSmL3IjPCv9lgdm+h7Tjv1RW4=;
        b=g0nqwTKxnPLqnr2peWhk7l1UWp+rmlHPHVaBp8pdyO4L1geV3RHiKaC+RA31xrws51
         CRX5ztHnaP3EWw2i4/3gD+bRJ3JK67pDHYZ6e1xOHq7pSsemgchdIYeL99yhk448Wuh1
         YTlUrXr/DLejeq72jRo6GhmNC4VJUbto7U1Ry3UHE1zR3PA/dOTrnIB9xFEDLnO8Qf4S
         pUyAHe97jgS3DWPFPocLrPWhmpT0ZrM5re07TOedcoByuHBMcNkOQ4MdFiLq5wGY2D6t
         f6ya1XuYSJTi0IhkkHF5nxS3k9DyUoREmctXAxoLAHLHB8b2/ja4LO0OcsLKgfqzt5DN
         /PQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792767906; x=1793372706;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AVt62T+eZv2jUWbbskvSmL3IjPCv9lgdm+h7Tjv1RW4=;
        b=ZuAY2c9KmiJ7tKy+XTeFlLmKzJAi71qNo1sYhoRszmKdwc/MXXyads6hBDBq6AB2By
         0aIHk6AHnYpdnfSMIm0zEFPB1djvUoETkMLIp/aNmW6eke1X8Q4UcTpTOAlHOfHp1e4r
         23SlOYYjldgz671nb74TaD/0eAExEwYzEYk2vm5k8yOn55aBOCkn08a9HFm5AtHsm+JF
         KRSCVkdK8+w3siIYxEGeerCG7aViXqQR4YKDad0Vke+dkaM5/ywCspbX/VmtGM5u0weq
         MCT8Z8FGrHVp2gVz06C80XlM3CyTkHojJAkBvAFLouJ3ItxEFjKBCex3GwHwFUfonazU
         CrrA==
X-Forwarded-Encrypted: i=1; AKwUvBy3ZjuVVurtZxe5H/RMfglQ8IiFO0J666tQQJiyCStg0FPybFHEKWJDfdOrlC2Kz/Gd/M10WHMBjM28/f25@vger.kernel.org
X-Gm-Message-State: AFq9FYLI3zW6NilNBfm/Q3L8yqP5MuGGcG3VCPRhuMz6s8P5Hz50n3Xm
	4odInhD+oBVIBTU9kU5ZBiBNa59kDZYtZ8nbRonBdfOJDd/oBG0jypzQVazu0N4iPWUe8xmjpm+
	j0qo4F5M=
X-Gm-Gg: AYBFou3AknwRyM4TuR55no8txz/zPUG6mgpa0Gw4CifjSTbMCzN2hYXRLBFQr7IOWWA
	BAibrhGdPOqBDQDl1drDp5bcq57KsaS5uMyosZo4xtbAVTiFDvmkRPdjatZjkhtWzHDQCSobGuL
	G6gPthA+HqTB5JxvI9UD3/tXXvBFFR/T+tzj+OgjRLxlQ84vWAeg9OjZikAZu3gXPYHNrEsr6RT
	mVnFFkOYUmSLmauANi9jpp4jdXcpCvrjmDmFf/FytzsXOxtdOCBxuztrPozW/7WqLe6Fy150IQ9
	eC0MVKoJacVgog8IGPkpzgxx3qBB0+QtXESUD/AhxnSPngj5a9u5w8aZRuC9ZP8o7vXGsmKNOw1
	rb6QfVXXYbG8w+s9gZ+yHkVCqh24cwbht0wfjnI13B1UYbLyc3OdfVS7lqhRaCG/knL1JUdUIiC
	kUzP+R8zK+6/ykggni8Dgyktah3RiJnY21rYnAYW/TMmmimX3vK4KWYPU8uC1/D9P1w/wZobm+O
	UtVMfHAuMSInYoO8QefouGfOH0tnPlOBSYtcZLUS0tpXk699j1N20FulA2G850mEkKbMZUHAahN
	3Kg=
X-Received: by 2002:a05:600d:8652:10b0:4a2:526b:d40f with SMTP id 5b1f17b1804b1-4a2526bd7e6mr10768065e9.0.1792767906491;
        Fri, 23 Oct 2026 08:05:06 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a2b064ef6esm10175585e9.10.2026.10.23.08.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 08:05:06 -0700 (PDT)
Date: Fri, 23 Oct 2026 17:05:04 +0200
From: Petr Mladek <pmladek@suse.com>
To: Miroslav Benes <mbenes@suse.cz>
Cc: Harry Hsu <x90613@gmail.com>, jpoimboe@kernel.org,
	joe.lawrence@redhat.com, jikos@kernel.org,
	live-patching@vger.kernel.org, shuah@kernel.org, song@kernel.org,
	linux-kernel@vger.kernel.org, sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/5] livepatch: Clear relocations when
 klp_apply_object_relocs() fails
Message-ID: <att3oHvCpVDjDt-h@pathway.suse.cz>
References: <20260908120325.299649-1-pmladek@suse.com>
 <20260908120325.299649-5-pmladek@suse.com>
 <alpine.LSU.2.21.2609181554590.21788@pobox.suse.cz>
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
In-Reply-To: <alpine.LSU.2.21.2609181554590.21788@pobox.suse.cz>

On Fri 2026-09-18 15:59:59, Miroslav Benes wrote:
> On Tue, 8 Sep 2026, Petr Mladek wrote:
> 
> > When a module is loaded, klp_module_coming() updates all enabled
> > livepatches. If an error occurs, it delegates cleanup to
> > klp_cleanup_module_patches_limited(). However, this cleanup loop skips
> > the partially updated patch, leaving any changes made prior to failure
> > unreverted.
> > 
> > One unhandled failure path occurs inside klp_apply_object_relocs(). On
> > architectures like x86_64, apply_relocate_add() performs a verification
> > step using memcmp() to check that memory contains the expected relocated
> > or zeroed value. If relocations left behind by a failed patch are not
> > cleared, subsequent patch operations or reloads can fail this validation.
> > 
> > Introduce klp_write_object_relocs_limited() to unwind and clear only the
> > relocations that were successfully applied before klp_write_object_relocs()
> > encountered an error.
> > 
> > There is no need to clear relocations for other objects in the failing
> > patch because klp_module_coming() operates strictly on the specific
> > module being loaded.
> 
> Hm, I spent some quite time on that and I am not sure if I deciphered 
> everything correctly.
> 
> It seems to me that all error handling in those paths you are mentioning 
> above is correct and the only problematic thing is that 
> klp_apply_object_relocs() in klp_init_object_loaded() returns ret 
> immediately which leaves partially applied relocations in case of an 
> error. Following calls in klp_init_object_loaded() go through err: label 
> where klp_free_object_loaded() is called which should be fine.
> 
> Is it correct?
> 
> Wouldn't be better to be somehow consistent and clean up right in the 
> error path of klp_apply_object_relocs() call in klp_init_object_loaded() 
> similarly to what is already there. After all we want to clean the object.

In fact, this is exactly what klp_write_object_relocs_limited() does.
The new _limited() variant of the function is used just in two
locations:

   1. It implements the original klp_write_object_relocs() where
      it is called "unlimited".

   2. It is used recursively in its own error path.

I did this trick to avoid code duplication in the error path.

I agree that is is not obvious. I should mention it in the commit
message. And probably even add a comment into the code.

Or would you prefer another solution, please?

Best Regards,
Petr
