Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935D615C14F
	for <live-patching@vger.kernel.org>; Sun, 23 Aug 2026 05:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787461235; cv=none; b=h1ctkzWexIstu6O2VYz0WaMaATQr/tCFhKDxNBYgvXp1+Shz7yydShZFtXpLUREIUG29CSpmtZBu1V1XqDZhSj5/ZcZgX9Di2UoGsXXbrltaZmaGHL/oU1IK7u2AYkjEapzzBZ1oJKcSdN9fXmPHW9qmrezdbA2vD+k1vsq/s1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787461235; c=relaxed/simple;
	bh=KBVhPHwGh7gCHrsssphUSdeOdVh3Sr96NStd12N7L0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T1e/U5zXTy2PS6EheI0CKdtskmBjJTjEcp+ZJuC30Fpkir61S2URQ9RVVWQ1SfBn93WZZz9DszWlrJ6dGHJfw8RY5MMz27SmIg31e7pvQVxgAMYPPfxrM3/066oFZtETz6O9GP+1mAhRicY8/CF1E7KaeS32UPx+jgUOIUVJmAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KQ9sZZ98; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQ9sZZ98"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38759bcd877so2773494a91.2
        for <live-patching@vger.kernel.org>; Sat, 22 Aug 2026 22:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787461234; x=1788066034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KBVhPHwGh7gCHrsssphUSdeOdVh3Sr96NStd12N7L0I=;
        b=KQ9sZZ98eIm9D9hR1Gnm/gZW8oC3J9L8jwvKC05kUIPFhNpTRijN8CP6rGGnH27iDF
         7gGep+0BwLhmq5bX+1O9HpWkvXjTcUQ1ixutZ7cp3cWlbvkakq5NCKOSnANGN0UgQ2Cp
         XJD6mh4gj3GW7l+HJaeG+wPMioz9Ubb1y3hzpXsIGzgBLXjlSLcSZO8+kJj+7TaBmPt0
         fY9CdhzcBxmJbwiygGq0SHjHeq+cU4Y7UTcjI01H+LL3qCbgNJzZ+GTLIRmx2xQZSoyu
         tAbvUSJUfAe9JJ4YYMsNaeeT3r9n9XxTNFdHvcpeJpbQRs0iBhT/6V+wFWtIyfCDifhx
         o9Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787461234; x=1788066034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KBVhPHwGh7gCHrsssphUSdeOdVh3Sr96NStd12N7L0I=;
        b=A43TSbqb6i71DP/AUR7EfEoIo8vv4G+tmV0L7Pz3Q38fLubmOg3coIRLxq0Iec7B5K
         pBbK35BkAk57DgYOZ+zOLac2v2thupdVNwbHWQL+dWHQXuTwrIPX2dfqgHdB6mEpdyxf
         fFEdnjtViZ256np7QJjm+HcdQ2RouHPtlyt9po6tTf2IKPpey5ly0VMZLo1K95wWVc2H
         fqBxShNUArGMVmU6x9ChDRAYADOrWVrmztZQRYaAV5U35fdHL0/ftJxdjyFIAlv/dSL7
         DiI46HOw+lr9sQ/KztBOOrQVoX2VPw9r1aS777IuHDSInZPwALehTILDDpzs+hedyusj
         x7OQ==
X-Forwarded-Encrypted: i=1; AHgh+RqGdwqJXfh1H3XODcD7PRpZ8HsmsPi6D4xHIF8JLf5tYGHgdDgpBPmsqzwo6k6KDxxFmgQWMMklKAhghfi6@vger.kernel.org
X-Gm-Message-State: AFuF++nTCdXmNju145RS513HXwVJiQrzth0g2ox7H9d9p+Rgx5ITLoNo
	dsuJFxdn0J0+jW57D58Br93WA0z/KpKS+GhUBo5NfOf+hKrK2L/v3tzA
X-Gm-Gg: AR+sD13zfcUvW3A6m75J9wdTuGkwpBSFsDJuen0SjdYf096vjxTY61EJGrQMg2d4xhG
	J2OO0xktdBRFWPFpvN81Yw4InV3h31uRRJI8NSkoh02sAmooa9eqrXcH0ZyCYNdG59EGghdUjND
	2dYZGgWUsTcm2W9AMNR7Hx0FeYzGHuJvkY9VxA+lrcGP2YhzaoHZOTRbu/lgstT50abH/NO+EWe
	lGcf7CV4AIXOaaMAukbOf+H5dXg+LMtpzKC8Oz8rbxUxRS5TzmrYgpmxT56nBHsNHboCwSZOD1c
	ZtXzbBMG3Ul49dnVDH29CttUrejN+JOY8oZ82IrsAffrg2TUpjmh2bJGGbBmE9fVqv7ZB+qZHxt
	oHB3bfkBfZ/dSToSYWIFnLIFfBAozOzqNewB9Xv4xN/53Tja+SigDRgENYvyuiPknxFIuPbp1Bt
	LKHe889yJy3VfjwyoIFgD3ZaE1uXxbp5xffE8zdtjmWbgL5iloL55LYzFb4BojF4Lyfx864h29W
	1e3hDVdpIM8I8C7S/wmBBjqvK2fB9b8YA==
X-Received: by 2002:a17:90b:1f8d:b0:38c:a59b:5189 with SMTP id 98e67ed59e1d1-395df67778fmr16884913a91.15.1787461233876;
        Sat, 22 Aug 2026 22:00:33 -0700 (PDT)
Received: from Harrys-Laptop.hitronhub.home ([2407:4d00:6c05:13e8:edcf:d188:51c8:54cc])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395e42cc144sm4731547a91.0.2026.08.22.22.00.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 22 Aug 2026 22:00:33 -0700 (PDT)
From: Harry Hsu <x90613@gmail.com>
To: pmladek@suse.com
Cc: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	joe.lawrence@redhat.com,
	live-patching@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] livepatch: Fix stack check for aliased old_func
Date: Sun, 23 Aug 2026 13:00:29 +0800
Message-ID: <20260823050029.35979-1-x90613@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aohuTo9QOhzvCkP2@pathway.suse.cz>
References: <aohuTo9QOhzvCkP2@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri 2026-08-21 17:27:10, Petr Mladek wrote:
> This might fix klp_check_stack_func() for A. But not for B. B won't
> be the last entry so that klp_check_stack_func() would use
> the list_next_entry() and will check for A on stack instead of
> the original function.
>
> Another _big problem_ is in klp_ftrace_handler(). It would use A
> in PATCHED state and B in UNPATCHED. But it is not clear whether
> A or B should be used in the PATCHED state. And it should use
> the original code in UNPATCHED state.
>
> IMHO, we must catch this situation when preparing livepatches
> and when enabling the livepatch. A single livepatch must never
> create two entries on any ops->func_stack.
>
> IMHO, we should catch the duplicate (aliased) entries in
> klp_init_object_loaded() and return -EINVAL when they are found.
>
> I do not see any other solution. We could not decide which
> struct klp_func should be used for the redirection when
> more of them point to the same original function.

You're right, thanks for pointing this out. list_is_last() only
patches over the stack-check symptom for A and still leaves B wrong,
and it does nothing for the klp_ftrace_handler() ambiguity you
describe - there's really no sound way to pick between A and B once
they're both live entries backed by the same old_func.

Rejecting the duplicate at load time is the right fix. I'll send a
v2 that detects aliased old_func addresses within the same klp_object
in klp_init_object_loaded() and returns -EINVAL when found, instead
of touching klp_check_stack_func().

Thanks,
Harry
