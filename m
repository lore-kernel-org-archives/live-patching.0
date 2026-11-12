Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794507905;
	b=RToUgfXdnvC0SQyMIZ3gTLtbmM4kPnbqC49KpyXbRKx+WQ5QQFmbK+VBtPk7k8upXGiU
	 SlCybvlC1zjbz4d5+GZpfRBK7mXQs4/330Pc8z4/wqBuhsEmU3w81y6kjvK2knTwWZVjx
	 78P6UNthpN11MKF/+MMTTpT2462B3WHac1VrLIFq65EW6rKl4yA5bGY9wyTBKCzN+OawZ
	 FcVkt5hd7iPmZkbBa85RbApW/K3bTz7O88G13qFv7XN7X5MlOwUE4r5Zm0Y2sZH1RotrE
	 G+HtpQViUE9SJwfIWYBTjudiMg2O7lLw6mVAtnHKRuQc3cFjdEyIbJg2J6AOiMBrUDw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794507905;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=tzBmIcpghOYCP+r03HK0N7KGo+wgnlo6db5N340fGPI=;
	b=E/yewTnkteeITJhUGq5NVbIVFnYV0a1ySxkSOz1VzRX90D2UiSPl71TXVAV4+HkGpIQT
	 gAiw0y1qSp3ITXpSLOebPMrcgmr+1O9whhcU68Ig4lojC3FGvzFQlrPybm97NYr9hkzJR
	 K0vR0SKWG290Eyg58rgtcuI30IzzRJw5q2Spq8yDSqiZ3f6mFmIryL/J8awAOldCPO0Mx
	 k9JrzxvhH/v9114etkcqBbcNfIDWepKzeg6be+n2AOuU6r5YvnYHTIVXGIwnKDQgtQCVu
	 zaBDyljoS/bQNKyQlijPYhPyQjZrffAXjqL9PNi7Q7iVDTAwzR4qSg4n4KvUvMdH6LA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BVkx6KPI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.45
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B76606A321
	for <live-patching@vger.kernel.org>; Thu, 12 Nov 2026 18:25:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68B76606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BVkx6KPI
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-98c7798ce74so62547241.1
        for <live-patching@vger.kernel.org>; Thu, 12 Nov 2026 10:25:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794507903; cv=none;
        d=google.com; s=arc-20260327;
        b=c5pAqli/sPHNtO6Y+L4afwl6hxNnu6JEtygFEtiqUUjPTfDhWt+FuC/VmBHCFp7dqj
         7NhQjNtOhI9YV3z6G3byHbLrjnIGJ/OBFyX/0FQYSJC7mFHxOwNoBjSACImO5US9e0Sl
         0Dq6CRbMM576UEQIozkUs2uorludFsU4TlCjLG+hYf5UJYAUcWKmByI3qXqjdVtljute
         aGW7+yczWE3QoKGdJ5AqkM0blj4y0KoQO680AZ16x/BTFVCBupjoVkJ7JfiILrNuVYgB
         me2yyum5FtW86zkhUX93s8xjmMlPIW/ZPvIL2SIqJd4ooMKysMMhhZKQHUbQggMkmn2j
         48Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tzBmIcpghOYCP+r03HK0N7KGo+wgnlo6db5N340fGPI=;
        fh=B35cTsjgz0/XEOecPsvPk5ZbDjQRmro3gxIDSxY2Zlc=;
        b=JbuWC51fn5cLFRZeYcHKmyslFwhdbiYIApQJxnZj/pcVHcVwBH+0T1byeQ40BjuPdx
         ymJkk+BWorl7Gul02rwMO09OcnxgELoyn0YpgCKq/s57cdx3UQ9fyzhXgrbr1NjdwhoR
         3u5s6lF327m+bLOUZBfJZ1dhmk5Gvn/EzHCm+Uptjz7qCqXs8cokIw3+WBfwZXagCRUR
         GYGCspJpQAFKNZJS6FCG5Lmu1vpqxPehXfawCh9xyC6kdEw1IF7H9AneUxzlhz2dMBfm
         HOpkJhksy3dI5v75zkizJANAjs/9x5TJ4oNr+rEsn3TOKmBBU/RDMmsdzupDEQTkfB6u
         dRjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794507903; x=1795112703; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tzBmIcpghOYCP+r03HK0N7KGo+wgnlo6db5N340fGPI=;
        b=BVkx6KPIfOrWlIonj0+rgg5nNJzXHoUbUSp0K8GIDNsrBudiOXyiZ7bRc1/kFjDdKL
         OaV7GFdm9nihZ8tQJ0HBcsVap4KpD8CwkJDhH3YJ7GB5uU0ou2fEc9w2wyVtIwnEZ1ru
         VFQG3ZiARBtjqYTMQCH392by9JNI3/ZSBMjD53m3SigBJ/VXbJ0+Wy3kC48n9W1Rqrrb
         W3D7CxIF7Hx1FDFcTWIAQzyifwjrGKJpVXBJe5chge/PzyPiUIhyA8ncy3uSUbN+7x+d
         8u7pWWY2vN9LN1DuqfxIWRi7aiGCme+FSuLDplzDNWtWDc3uQgZE4uucASTsXC90Dxd1
         Aifw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794507903; x=1795112703;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tzBmIcpghOYCP+r03HK0N7KGo+wgnlo6db5N340fGPI=;
        b=1AAO1UQNR5QkbKz78gpRXrqJ2LoRhjn83PSTg9oLv2+mRifwLp+CCZBepJ9pBYsKIy
         IUmDD+qmk9j9eGIUBTxJ2mYUKELabUO9WDdSf1lqMs5guWIn2+Al5eCen3klIimaJoys
         Uk7s0Rj4icIhF7/vFp89EF7Oi/B8M/xOQQCDR76a6h8eyhr4viH3RuQ3uj5nEUycjDxv
         SdCe2C0Po+DsdjE7gs3nhikdmVEkM6Gq7N6emNfLkAorWzdH93uPelkYp/nGWKhv6hxs
         YDY8t1G8MWVJEdPpQPPxd5BazLCIRWZMIElVMJQQ7H4ehsUqPK1BhVVql9RWtFU2gHJ0
         aVWQ==
X-Forwarded-Encrypted: i=1; AL+hErFTvrZ0Q4lKN0ct9uVxpPy3dCIotqgjPOFljUrXw1q0Yn8mYsbHU0m+ugeTI4GjG5oREYDgra7aO2juQz8W@vger.kernel.org
X-Gm-Message-State: APuU4Z+Apyft8N/bduCPf7Cqt+7a9xj3rBUNnrbGcGMGWJ0BUuFRM68f
	ve+s3xtsqTgmHkVtKebKtXXkfV0Y9gip54bil4WaSpvCDQ6QyrjEZc5muLD3EhfAgafH2kWn12J
	19IfvAkiRbKLYyuSaI0NLZc5BPR51uqYsKfPWqCUS
X-Gm-Gg: AYBFou0MuZvp2w2lKcQWIdNxKJ/HtEP2iTRUFoqvLViRw8VgguTk7e6KIN9HIQqpupx
	Ss1CsLvR/3BVgsBZOwiKCXEdpZe0cKWrwjZt3pv5C8JgVTI8xpPqithq4GiQ/Q1cFXUr7/adj/J
	N/21QWUlOF5RseFh0hoAaHUiMX+r/hWaQNW0u32j1nigihfo3MDGbKX+0hI5o/yBPC3DbdjFpuQ
	1HBgB1YBg4jGIn/mTNrk2d6/roZR6Md2MLBsQmOyy+vXDm2vdc5I6/wf8ehVgNk8EziC6eUFp+I
	hRpUXecptro2LPHDX9A0eBB239oKOnHOrf2QIsbyQP4EqPAVphGAAEEMxusUveQwVJD6UxonKhX
	lYHvK98P18lY/rio8E8tsUCSxXHykN2inGUMAGacX2v163foblfVOs1mwJnJkkseGKw==
X-Received: by 2002:a05:6102:a4d:b0:7cc:828b:41f4 with SMTP id
 ada2fe7eead31-7d64db190fbmr4854137.35.1794507902539; Thu, 12 Nov 2026
 10:25:02 -0800 (PST)
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103233909.1364531-1-dylanbhatch@google.com> <avVYkcbr6ah9IzYX@jpoimboe>
In-Reply-To: <avVYkcbr6ah9IzYX@jpoimboe>
From: Dylan Hatch <dylanbhatch@google.com>
Date: Thu, 12 Nov 2026 10:24:49 -0800
X-Gm-Features: AclHuK-_TAArpRaO2jf5A6e-8RRqPo51or4oUVcum6Bw0xcFyHqgOMVe5Q1IMsE
Message-ID: <CADBMgpzH8Ogwvr6ORx5PebB=0-2gLNXM96U9=jKa5+PwnapjAA@mail.gmail.com>
Subject: Re: [PATCH] klp-build: Allow passing options to make via '--'
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, 
	Joe Lawrence <joe.lawrence@redhat.com>, Song Liu <song@kernel.org>, live-patching@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2026 at 10:14=E2=80=AFPM Josh Poimboeuf <jpoimboe@kernel.or=
g> wrote:
>
> On Tue, Nov 03, 2026 at 11:39:09PM +0000, Dylan Hatch wrote:
> > Livepatch builds rely on reproducing the original kernel build
> > environment. Currently, klp-build invokes bare 'make', which drops any
> > command-line variables or flags used during the original build (such as
> > 'LLVM=3D1', 'CC=3D...', 'KBUILD_BUILD_TIMESTAMP=3D...', or custom wrapp=
er
> > Makefiles via '-f').
> >
> > Refactor the make invocations to use a common MAKE array and allow
> > passing arbitrary make options after '--' on the klp-build command line=
:
> >
> >   klp-build [OPTIONS] PATCH_FILE(s) [-- MAKE_OPTIONS]
> >
> > Signed-off-by: Dylan Hatch <dylanbhatch@google.com>
>
> Does this enable anything that's not already possible via setting those
> variables in the environment (or MAKEFLAGS), e.g.:
>
>   LLVM=3D1 klp-build
>
> ?

Ah, I hadn't tried MAKEFLAGS, thanks for the pointer.

Since Makefiles override env vars by default I had some issues with
our internal Makefile-based build tool, but trying with MAKEFLAGS it
does seem to work. In which case, this patch doesn't really add any
new optionality.

I would argue the [-- MAKE_OPTIONS] still has some value in that it
makes for a slightly more intuitive command line interface, but that
is just my subjective opinion.

Thanks,
Dylan
