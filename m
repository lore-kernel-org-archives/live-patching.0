Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794328514;
	b=D8ig5Q18dqPTQMuYEaLf6kk6PKMLW8imKjIeLxpiW8K0v22ojW2dUfrPO2HnKXQEXTZT
	 qUq/yeUr7Pe7WnGa6eYOTnWMe58qu80ipNX053Yi7U3mzSGpVCifHMK+eVqN0qNBH25+/
	 2n/WqklDOz0d/YZ/wUxRxN/Je/DKCmGsYjb5nhJreJ35f5kWEk07/MDrPkYlbpm3YlMEu
	 EBnJwRpKyH4uC0uDcSNnfQo9KlLOT5MQkJgwj2BuOY9z/Kv17Mbv6AivKBAaYsvfHMgp9
	 a/fLIyAARuCjNs9qWBEnwyhvxpks2Vtwt6r5M1XQwWcijJPLWh0qJ+k9DZPBshtj5bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794328514;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=QwunAeyQcIIUis+s7GEtmUpT6+XX7BrzAJJ3ZXD35YE=;
	b=TUBwjTX0Exx8Umiv4Qn9u4MttuimQVE8oNgM8waRut8lyzntUFEu5Tq08UQE6RO7uQk4
	 xmKWcH0+cBZEJ98PTQ1KVP+tSEKZ1SZMTCsOs3v4F/PjW//I324DHOGUoN1Yfwen6VToc
	 SnaJD6PtrE3VkNF2H54my5fRMgyxa35I4F5YAeQiSzilTpiN5dSt2GkvIEZnddkDgYE91
	 iciqpAga9b1GNOQaI8E5OVQ1Y8OwoC3qOmklsvUDQ3Fg98ZJvjgRehyNh5g8neLaqsP5/
	 0G7J3+O5/xces16HwV83cVJPw/GVIzEb5bePVvL65wXz3J7DVB/+gnNquy9jJYNqfbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=boIp9VuJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB376606A228
	for <live-patching@vger.kernel.org>; Tue, 10 Nov 2026 16:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=boIp9VuJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0CDE1F0089F;
	Tue, 10 Nov 2026 16:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794328513;
	bh=QwunAeyQcIIUis+s7GEtmUpT6+XX7BrzAJJ3ZXD35YE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=boIp9VuJ0lJhm/HYzZUQdkGgkP9YO24yCYkNQV+mZRCku83RECbUCw1/6ZqAW7H0e
	 9wZNo+rw1437nNsIZg4kVxxV0l1PBe/HJR0W6NOXjQOeAUnF5EbTdtCCkGRVNk/nTq
	 x9Z0Suo4X1ht5qJiqY8v2FgRHjHLq8zFBmqGPqTkG2cIrd40Ihv8BaMzO+A97LFW5V
	 QwPm3CermDinSWNKi6QY7sx1eQlwwEzqcFnbHb07xUs69EzJU4KmmCqB2SPE6wmMV7
	 +FK8bzrdGYnhEGLqQ8zlLnWER/eN6ylkw4zSNJ5FdZc28iwYtxxZsUuIbZHFb8gKEx
	 /z5fbAXiJQ1Cg==
Message-ID: <sashiko-outbox-207388@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/4] selftests/livepatch: clean the test modules
 without a kernel build directory
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>, "Josh Poimboeuf" <jpoimboe@kernel.org>, "Miroslav
 Benes" <mbenes@suse.cz>, "Petr Mladek" <pmladek@suse.com>, "Joe Lawrence" <joe.lawrence@redhat.com>
Cc: "Song Liu" <song@kernel.org>, "Marcos Paulo de Souza" <mpdesouza@suse.com>, "Eva
 Kurchatova" <eva.kurchatova@virtuozzo.com>, "Yafang Shao" <laoar.shao@gmail.com>, "Shuah
 Khan" <shuah@kernel.org>, live-patching@vger.kernel.org
In-Reply-To: <20261110161050.2451750-3-sashal@kernel.org>
References: <20261110161050.2451750-1-sashal@kernel.org>
 <20261110161050.2451750-3-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 16:35:12 +0000
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] selftests/livepatch: missing Fixes: trailer in commit message
--

commit d55e0dca037d90570993238825fe598e3b4846aa
Author: Sasha Levin <sashal@kernel.org>

> selftests/livepatch: clean the test modules without a kernel build direct=
ory
>
> "make clean" removes the test modules only when KDIR exists, and KDIR
> defaults to the build directory of the running kernel. Modules built
> for another kernel are therefore left in the source tree by a plain
> "make clean" on a machine without the running kernel's devel files,
> for example after building them as KernelCI does:
>
>   make -C tools/testing/selftests O=3D<kernel> KDIR=3D<kernel> TARGETS=3D=
livepatch
>   make -C tools/testing/selftests TARGETS=3Dlivepatch clean
>
> Removing external modules does not need a configured kernel. Clean
> them through the kernel source tree that contains the selftests, and
> do not pass on O=3D or KBUILD_OUTPUT, which the kernel Makefile would
> take as its build directory.
>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

[Severity: Low]
This fixes the KDIR check on the clean target.  Should it include:

  Fixes: 54ee3526796f ("selftests: livepatch: Avoid running the tests if ke=
rnel-devel is missing")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110161050.2451=
750-1-sashal@kernel.org?part=3D2
