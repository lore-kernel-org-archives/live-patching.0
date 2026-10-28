Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793223842;
	b=0jp/1r0Ax6B3oiFTscKoxt/dHqBYrdQkHrIWtX1WBT1x5LROoBJIpC82i1nsLxXE48i2
	 KuQ5l/XFOgd5YmGWzxMS6zYoBcuMKCZv1vdJTTIbQiSklY3bAlx04JCo6IwnAbOaij9Kf
	 UNxbe2mJ7oPhJWzrsMv640FfNTT2kqhhNfCGSf7f/d73ou4fTjK7esZ5jWfUci5nbtw8f
	 yfEp1DO0a/33wclecmJ4xSwR8qpKJheUOp5ObpVR1VfPGq3WP4UCkA2mUVWmk6yXPmQ08
	 BS+x5n+fr5Dp+aJq8L6D4LgoCIxGY03IhnXzRKzGvxuNoboph9yjcBGC4ci6kHMbyxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793223842;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=75mp9zfOiQdzPd/pZTfE9rnp4feuOSyWnL8j0FSv1Hk=;
	b=2ePxCj17zTWX+e3PUAd9l00bKbvOVANLdoFAHDrrpDMQKvYCT9vide0KmEsVigfQ/YQY
	 3QDI1UuiahuMl1SA2+XF/x3OUdGBAPjgDNSGN25NeUSCuhtChOEhNK31RerHRiauLkKMc
	 vNH8cUVxrQTZ6QHcYkwjHDCaWQkXMlUI71gzDZVRQ9kphLHntLJCw4/a48PfnienZFGEF
	 TR/CntEKoOsoxLc9tPoWdVBp5JAnrqoBsD4ZhKAFrSRHHttM/JBByPLTHXb3FaqyrHvt6
	 LQfSZ4S652bbBd+88YhyQy7yIV31t42gC2MmWyGxvKu0L36pO4nPEvwFBqY7UhO84xA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m7L28ldM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D6B606A31E
	for <live-patching@vger.kernel.org>; Wed, 28 Oct 2026 21:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m7L28ldM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 268511F01829
	for <live-patching@vger.kernel.org>; Wed, 28 Oct 2026 21:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793223842;
	bh=75mp9zfOiQdzPd/pZTfE9rnp4feuOSyWnL8j0FSv1Hk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=m7L28ldMVJG0SOofXWBXl1mYdhTrpZFD+XCin/EAjQDKodlrDw4gqa1ZXKJ6aWkoK
	 hyQaGvqChEtQgCcFB3tsf7ZKgcV1r5uBx2fDT8P2O9uA0qLyIZK8u71o3VmSOeVuBJ
	 dNGVudG5dm4SO4+AMAjEQA34c/cV1N6OqYafN5un+qVozZ753Z/4KB3VLr4lHH2vL2
	 3hRlt7+lZD2pezqZpKNigqB5jtzQaSAZO8lePQrSB9ox3zbv/tA4hHoMQdhfoNk0ee
	 /U0CcIcdNDylHFU5Y4PAP2ehoXZTnH+7Dd6GCFg7La9BumE4CZR8FPYF+7DHu13anP
	 9u1oNcj6YMqkw==
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-5365d26ccbdso19523281cf.0
        for <live-patching@vger.kernel.org>; Wed, 28 Oct 2026 14:44:02 -0700 (PDT)
X-Gm-Message-State: AFq9FYLFLG33MjwtQfNdjAwKiaYXYZHyCqdbIFSISHOf602rJbWFtL9b
	zeQUBLsxuabTMPk6aryHC0Urt+5XVRjeceaqQd7cC7rHEONl7wXNdAVkQx3tM+MTHohBOS7Xcgx
	N42AaB1g+Q8Y4VCyXMd8npjxZkst7eBk=
X-Received: by 2002:a05:620a:459f:b0:93e:5060:f929 with SMTP id
 af79cd13be357-94408cf36e2mr560100685a.19.1793223841403; Wed, 28 Oct 2026
 14:44:01 -0700 (PDT)
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261017002441.716615-1-song@kernel.org> <20261017002441.716615-2-song@kernel.org>
 <at_1V3XcGM_D1bY1@jpoimboe>
In-Reply-To: <at_1V3XcGM_D1bY1@jpoimboe>
From: Song Liu <song@kernel.org>
Date: Wed, 28 Oct 2026 14:43:50 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7EqPazLJmRDoB4RUyA6FgB2Ki_oZDzW1KXdMhm+114Rw@mail.gmail.com>
X-Gm-Features: AclHuK-GjaP7ao4nI71C2Y8yIDK34mvBUk0VSFTRP4lxAJhnYpv80j_vMXIPBKQ
Message-ID: <CAPhsuW7EqPazLJmRDoB4RUyA6FgB2Ki_oZDzW1KXdMhm+114Rw@mail.gmail.com>
Subject: Re: [PATCH 01/11] klp-build: Fix dependent patches in a series
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com, joe.lawrence@redhat.com, 
	shuah@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Josh,

Thanks for the thorough review!

All these comments make sense. I will send v2 soon.

Song

On Mon, Oct 26, 2026 at 6:43=E2=80=AFPM Josh Poimboeuf <jpoimboe@kernel.org=
> wrote:
>
> On Fri, Oct 16, 2026 at 05:24:31PM -0700, Song Liu wrote:
> > fix_patches() refreshes each patch on its own against the original
> > source: it applies the patch, copies the patched files, and reverts it.
