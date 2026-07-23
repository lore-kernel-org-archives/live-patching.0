Received: from mail-oi2-f2.google.com (mail-oi2-f2.google.com [74.125.231.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C9D2E542C
	for <live-patching@vger.kernel.org>; Thu, 23 Jul 2026 12:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.194
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784809756; cv=pass; b=rNbmr4GkV68EXVaoD61EZzx5zpE5t5c3TUIkzg2Bq9qkIe5GbKUBo3wJCHtJL61IIHd34/xaZ3+wWOl4dvEc1wdj/kxV58GwyGIyQacmP0oBNWuqwPuheNwapXPwHbouI0SS1CruPKVA6/2hGwq0OcTBB/4GtvZFzjEHI2ES6xk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784809756; c=relaxed/simple;
	bh=ZIDN8CV1SrFjWQOUyz5PXma2ADtIjb6QXnGFDr1fjoo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=NrfGil3FsEjxvoDI4etC+4c2oT+OlDcth+ov/AavaqPmE6QJcrG+ZHcxFZodPdAwdb+AyYbW1LKYZwiMRQ5c7VpRUp9Og/VQpIpo+Qr9YcMCq+3EPZt9an9JlAKUBS4eYtvgELwp+0/U3hYM1Q2TX0GzrvZS9+zTNaiUFzZXw+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZOXoCXmq; arc=pass smtp.client-ip=74.125.231.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZOXoCXmq"
Received: by mail-oi2-f2.google.com with SMTP id 5614622812f47-495d5d27acfso234743b6e.1
        for <live-patching@vger.kernel.org>; Thu, 23 Jul 2026 05:29:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784809753; cv=none;
        d=google.com; s=arc-20260327;
        b=A/WLwkGu+NjpddKhMh7ggRVPZ0pP1BFDXlP+ExzSLzgKzbp4J0vCDSOCtm4Js8ab7A
         xaEF/HQMm3LxrZyFL1jeb+I9VC8DJQCJ+rsgszVvVQQZRkG2iiGQugBl/jPG1bdSAQ00
         WXEg3aPlM/hsG95CcbxsM8isNWgCf5LhzTTGR15mKXpFNDuwxN034lajwlvdb8WXZOqo
         AzFyPYSjSku37MC0vUTo7lqHTPAbzaNluH90np16hk2x2crYSN5SmQEVCiLMdhxLegBF
         MBB2/yVKyQh5lDCSWYnbqlKRPYGPKdCqWLil96K7t6OGWP9Iw0m2+W+LGVyX7E3kktte
         IEmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=ZIDN8CV1SrFjWQOUyz5PXma2ADtIjb6QXnGFDr1fjoo=;
        fh=GaVfQ0ka75cucmszUcedaoe/iet7Nq2MyXjmqokrSnA=;
        b=nkzq4LS9HJxa6FBnN6OjD+BI9lw7bBnb6UT/LRRjc/joboSXmF45KUAHjShtnhcgZz
         CCljT24TiawZ+brfLg9RVkDYU9n90iCsaj9SdYDR83Y3OZKqgV5hY1VaxIz59XDu76UX
         lctF/GdT8JgUIrM533VhkFxqT+IAkWpG1+qTDi4o7rEM1mkAcKP13ykTrtT2+Ci0KgfR
         8Shl0GxNzPXHZ9V6V6h8kEuTFqCnUxPhSzaLWqS8IVdL/lJgCxMYHvmgDT8PZqwqnFVU
         d0NsGb/R9fJ8POQKJ8YCxl5f9KhNFY+C8zNen3NZmKYiUzxDZzc64YbMNC0yji79XoeS
         hJiw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784809753; x=1785414553; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZIDN8CV1SrFjWQOUyz5PXma2ADtIjb6QXnGFDr1fjoo=;
        b=ZOXoCXmqBuqJA1a5SmECXFl5upyJdFqI9u1dP3f3OBNLCc6xF3rP2NiOPFIoRGOA17
         T/urHjf7Uiq2pSUjh0+S/AlpyBoP7/BgugtoTa0hNN8orOyoJtvaJKYtOdpItHLsPvkE
         cJE1plgDFbGHmz+unVckM+N7Kr3Qta40rd7mb/ORq7M/TZFLhefNnGrP2LBpezOH+4OF
         9ov6lPdBZz5H6agEO6WHGerxluM9g0CwzeDlacRLq/5uP4C2oROIcn4x2wImCVHJHaAl
         JFpmYt1OoQaQ5QaqKgMy0vxFGkCJJNf3sD8sYI2EiHMREUPaRIz9btyviTMYtlN/6uZp
         B+1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784809753; x=1785414553;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZIDN8CV1SrFjWQOUyz5PXma2ADtIjb6QXnGFDr1fjoo=;
        b=sdd8tYiGwIGmOJb8/pnd8X3ZvXdht63tnT7OlfZfNVxalEkTFhoxqNem/vj40zRgdO
         vYNBkz4JB5iGD0f/kfGffi5luCvIW+zojvmjBndC84VnzcAYwXvCfCai2UKayyz5A/xt
         JNrlWYilLdn0QNYmI4rQJSmq5Rk2EP1LXXfFdCPKYGx5RYCS4Oxl1eYS/KRM4AUDmFkh
         n1ZqCaoNWMQ1bLs8wiylnrt8X3O3OxtSKnK3cXIc/tsISFGJWf59f5jPbxzDqmcCikPZ
         PdZ83uYiRtzDyj7NHOyfy1ZlD3KzC7bVfTdVRNBbANy4NM7LmCkWP3DIywN6zMEhJNEL
         NUuQ==
X-Gm-Message-State: AOJu0Yxy7+3ZNk6tJjvBGiw5X/jeY04pcxqtAYWA1WkKU3JuZQvz/ZZM
	+k2+w615V2a81c9hTMYfxYpeBUVoD0+IPxNDNo/poDVVzMsfU7S5Np+3Sw8MtMRD91eR/5f7Kz1
	OGf7kIRo+ByDRCnAdnIebLpBDDc5H6bHyHATN02y6Ax/V
X-Gm-Gg: AR+sD13GLl1KRsDvrn34EYOxd1063wPOkPJqVDxeD7WQslAojp62UaSeQHJrOAv8v5i
	8dX73WzrpQSrVVLOxyg4Dg163UiFvGRZrABPCmQE0lBFPP2+FkCXoZ/vE2K0GjQI3CdlIAEMtsT
	93FHCFRAz9MJSxvuvzlDzI2kWSUS0yIG62MwU9rE2vhF0Xuvvwkix3VB53lf228vzyndGB1/JGf
	HJxbSdu9uv0D535zb/D0MM1r8ny0nKJGJ3Jv3go83bKEg4DYxvkDhQDfaBQ5DhMmJct6Gvf
X-Received: by 2002:a05:6808:1523:b0:4a4:ed9a:e790 with SMTP id
 5614622812f47-4ab354921c3mr1449565b6e.29.1784809753275; Thu, 23 Jul 2026
 05:29:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: ahamed <ahamedr0809@gmail.com>
Date: Thu, 23 Jul 2026 17:58:58 +0530
X-Gm-Features: AUfX_mz6kZDPQ9B2YO1kpqkbCIEFYRzK_xKqXGJZOFeUqtWtcImot0XpOnqq2wY
Message-ID: <CAL0stzsJ_hJidg0hyJbaSWKHU=qqhh1G5BhKnJRsWS66PJh3oA@mail.gmail.com>
Subject: Query Regarding Backporting klp-build from Linux 6.19 to 6.12.x
To: jpoimboe@kernel.org
Cc: live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Josh,

I hope you're doing well.

We're currently using Linux kernel versions 6.12.74 and 6.12.90 in our
environment. We have been using kpatch-build for livepatch generation,
but it doesn't work on these kernels because CONFIG_X86_KERNEL_IBT is
enabled.

Since IBT is an important security feature, disabling
CONFIG_X86_KERNEL_IBT is not an option for us.

While looking for alternatives, I came across the new klp-build
infrastructure that was introduced upstream in Linux 6.19. I also
found your patch series:

https://lists.openwall.net/linux-kernel/2025/06/26/1920

From what I understand, this series introduces the new klp-build
workflow along with the required objtool and livepatch infrastructure.

I wanted to ask whether it would be feasible to backport this entire
patch series to Linux 6.12.74/6.12.90.

Specifically:

Would backporting the complete klp-build patch series be sufficient to
make klp-build functional on a 6.12 kernel?
Are there any additional dependencies or upstream changes outside this
patch series that would also need to be backported?
Have you or anyone else attempted such a backport, or would you expect
significant compatibility issues with the 6.12 stable kernel?
In your opinion, is backporting klp-build to 6.12 a practical
approach, or would you recommend another solution?

Any guidance or recommendations would be greatly appreciated.

Thank you for your time and for all the work you've done on the new
livepatch infrastructure.

Best regards,

Ahamed
