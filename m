Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com [74.125.225.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EAE2DB794
	for <live-patching@vger.kernel.org>; Fri,  2 Oct 2026 17:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790960812; cv=none; b=hF19if8BlVvbJ4nBS6FgTdNx/+DUUXVq6s5QJay3lSYlaTrP4wKGV4MNNZc2BCB/oU4uroO37ZE76PVJZW1pIrroh5HYvYW32BdJc/mQHLHmRgBGa/yBrKOFOwK3t2E2WQNeNaXt2y6RaClc38U+1vsFPlA6h1sEHNljc8XP0nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790960812; c=relaxed/simple;
	bh=q9yNxSHr40nHT9E+YPPHnzfQ0Ok2yvbR3ABazBRFRm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PNFv9W/ZsndVX0ne+4t4f/k43aDPVxERM8uqbwbTmp0OWXGdqsn1bGLbUG/WkZ0A3LnXWXpmP6j/KZevC0B79Z04FWGud3suuw8YcaFzmJ6k+IB59y2FB1hB4Er6fXqR6YrKaW4DVTIvrXKG66DrAudszSBvyd8KhLBTIvbMQw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MQ28+psZ; arc=none smtp.client-ip=74.125.225.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MQ28+psZ"
Received: by mail-wr2-f34.google.com with SMTP id ffacd0b85a97d-48b01c41135so98364f8f.0
        for <live-patching@vger.kernel.org>; Fri, 02 Oct 2026 10:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1790960805; x=1791565605; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6pk+dHsqSMT5OqncGzgDuN6Y1/lOrsKrwCoDL7Nt1zc=;
        b=MQ28+psZhfdp16LDuXW/LF/NJqeHKDQHMUDBDRaOAHuFzuTkLXJzSQEiS1/8eYJvZC
         xpbG6LnZQS5Yh2O3QZfWuIy/FF4ZWK7IKwijU9Z2OBkojyUWb0WrDmXFW1uz98qh80u6
         f7fM2pG9wYmJFDZ3eGW+ZlL6mgOdwU7XIPgMP6BxgvsGztquU5bEyO6h1IXdDCloie8x
         vovTAA8YjVjI8L3/p6IKEPX8zzdrPEYBcoJBwmU5a1Yw3wpFawZfn++FlUcX7k2p8B6W
         Gw1KCpSSDhaoVgMDD3gW4EfrMTdSse0yQFYjfKjiY0VQ5ZaqLIDMy1dVqhOZrFedJy+7
         d59Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790960805; x=1791565605;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6pk+dHsqSMT5OqncGzgDuN6Y1/lOrsKrwCoDL7Nt1zc=;
        b=UTs89bDpWVk9K4mU7C6DBSpl0SqL1Q8Upo4j4E6qQNOpL8D/NtCVLAjSZsbv/26pwd
         525hTf90QDPNyMH/uXPI1d4oBXjI4dBxMVRB0QiXnRHeymkG8aSYzwn7fBucbJk9M9XO
         5e430uKHZVOt4Ign/caAdxg5t800+g73/6zYDYWfb286o0BYHz1cDSuVgUlxm1rh3wc7
         /t6LOiMCyS36V5NxyBUOMeOobE/Dx2xK/bN6zmh/uBY679IKxp2zpZBo31Jm2BYF8nz7
         Pbl1Wxb5A1wlBkS8C1lQ1buvD1SoFQD09GexZqQoVfmp+7HZQTMgUkLqYPAKn5dLFTYY
         J2+Q==
X-Forwarded-Encrypted: i=1; AKwUvBzzcLfib3cmP7QGZFIFoVe+oKOg/HP11ZzwLIky5GSG6s6nzy7Yq79xJ1QCDSx9zRU5Pd+nI2zTSAJsPJOm@vger.kernel.org
X-Gm-Message-State: AFuF++mqI7oF1naeCEz3AN6hEBlwSJIJc5N/9fDWEmIOkf3Ixk01CuFe
	C/psqHWVJD1Iz9t4fPMYrSjwS3X1vPL7+UzMEIddZfGeVgRES+Dz1sXayMPcPbACDl0=
X-Gm-Gg: AYBFou2Vv4OjiOzZ9DTLWSpxvKYKP1MZZTy32Khy8di/qus4rf3IfPg0w+EI4eKLXmQ
	W8rsk7kgyw7nAYh/cwavPVUeanEGxbIbTfZ38H87R3OAXLiYaodmzhI1s9R/1XSAH3N4kmG9CqJ
	Try7ys67e6yQBrNsT3kraeui8H5umVtQ1q7AwJrKYhIQZIwC+52LtWWZSlYpteQCxueX3bvWWZw
	FLH7SJpvRAgiobXVjbjPE/TCOkV8RoI/nVBNF4KpDyWHtjA0/GA82s3Fi6KH5lECqePTKiUnqix
	bJ6PmY17gJ1UqISoUCwrGSRmjOXEpuI6akwMPzxRLWFN2Bo+kACYXwtB6ryrs+6ZOrBPNK60CTP
	IoodRGJkDZTUlVys9LMu6P6VXyyaqG3Dq6ZzA/2Cm9DMGbQLKTYUcUhc5F3kzTKrl8/WsTAYs7C
	ZeQVrhWwqMkTmqOfsjZxwRrh3qm3gjgNb5HB2+nIvvSAnQIcvZNdYtBGg0iyd2sGlOy89yJSOb2
	qNenLDeeak=
X-Received: by 2002:a05:600c:c084:b0:4a0:2835:6fd3 with SMTP id 5b1f17b1804b1-4a028357000mr44542635e9.17.1790960804726;
        Fri, 02 Oct 2026 10:06:44 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0316b2524sm116356405e9.1.2026.10.02.10.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 10:06:44 -0700 (PDT)
Date: Fri, 2 Oct 2026 19:06:42 +0200
From: Petr Mladek <pmladek@suse.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz,
	joe.lawrence@redhat.com, song@kernel.org,
	live-patching@vger.kernel.org
Subject: Re: [PATCH v10 5/9] livepatch: Implement provides and obsoletes for
 scoped atomic replace
Message-ID: <ar_kouwlAGcnnUYQ@pathway.suse.cz>
References: <20260930030323.14396-1-laoar.shao@gmail.com>
 <20260930030323.14396-6-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930030323.14396-6-laoar.shao@gmail.com>

On Wed 2026-09-30 11:03:19, Yafang Shao wrote:
> The current bool replace flag is too coarse: it is either all or
> nothing. A livepatch with .replace=true replaces ALL existing
> livepatches, which is safe but inflexible. There is no way to have
> multiple independent livepatch sets coexist on the same system.
> 
> Replace it with a more flexible model using two new fields in
> struct klp_patch:
> 
> - provides: an unsigned int id identifying the changes made by
>   the related livepatch. Where the changes are a set
>   of modified objects, functions, and used callbacks,
>   shadow variable ids, and state ids.
> 
> - obsoletes: an optional array of unsigned int ids specifying
>   additional provides ids to be replaced. This allows a new patch
>   to explicitly obsolete patches from different scopes.
> 
> A new livepatch atomically replaces any existing livepatch that
> meets any of the following conditions:
> 1. It has the same provides id as the new patch,
> 2. Its provides id is listed in the new patch's obsoletes list, or
> 3. The new patch's provides id is listed in its obsoletes list
>    (the obsoletes relationship is symmetric).
> 
> The obsoletes relationship is symmetric: two livepatches that
> obsolete each other are mutually exclusive. Loading either one
> atomically removes the other, so they can never be enabled at the
> same time. This allows swapping between two independently prepared
> livepatches that cover the same scope, in either direction.

Honestly, I am confused by the 3rd rule and by the last paragraph.
It is not compatible with my understanding of the provides/obsoletes
semantic.

In my mental model, the provides and obsoletes define which
way is supported. Let me show an example, let's have:

 Livepatch A:
   + provides: 1
   + obsoletes:

 Livepatch B:
   + provides: 2
   + obsoletes: 1

 Livepatch C:
   + provides: 3
   + obsoletes: 1,2

 Livepatch D:
   + provides: 2
   + obsoletes: 1,3

How is this supposed to work, please?

In my mental model:

  Livepatch A:
     + can be replaced by B, C, or D because they all obsolete 1
     + can _not_ replace B, C, D because A does not obsolete 2 and/or 3.

  Livepatch B:
    + can be replaced by C because C obsoletes both 1 and 2
    + can be replaced by D beause D provides 2 and obsoletes 1
    + can't replace C or D because B neither provides not obsoletes 3.

  Livepatch C:
    + can be replaced by D because D provides and obsoletes
       all ids which are proviced and obsoleted by D

    + can replace D from the same reasons.


OK, I understand that it might be practical to allow replacing
the patches just because they are "conflicting". As a kind
of revert/downgrade.

It might help to rename "obsoletes" to "conflicts". And just
say that the livepatch replaces livepatch with the same id
in provides and also all conflicting patches.

But then I see another problem. We have three types of conflicts:

  1. same id in provides/obsoletes/conflicts
  2. same livepatches function
  3. same livepatch state id

It is weird that we would silently replace livepatches with 1st
type conflict. But we would refuse to load the livepatch with
the 2nd and/or 3rd type conflict.

Note that the inconsistent handling of conflicts exists in
this patch even when the array is called "obsoletes". My proposal
to rename it to "conflicts" just helped me to see this
inconsistence.

Any option/idea? Yet another naming?

One more thing, the commit message does not describe that
the livepatches might conflict when livepatching the same
function or using the same state id. It is important part
of the semantic and must be documented.

Best Regards,
Petr

PS: I am sorry but I won't be able to finish the review before
    the Plumbers conference. But I am happy that I have found
    the above problem. We could discuss it at the conference
    and come up with some sane naming and semantic.
