Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793745793;
	b=ddXTGFVMS6b0V9TAmV916hxG1DmeuvArXvciTMtsRAsScq/gpTWZ67NGIxusiE9bAgq1
	 7PR0kaHUQUVYVgiiEAXvZ3TLdxTt1nupfnDYleYSUbeqXG+glvOMrDZnFsQ14H4XVxxFD
	 kUy24/1SqUmJRevkZavPnpzFowbvT0bM8uTutTiCMqQW2IAQJrNgq0ZUF4ki9/zgindfv
	 8wp4ai4ODhuhCJsOdsuhTFJwgvYkgf3jQ0b4ozPE77sItMhzvb9t+0B9wMtzQvrzEGoc1
	 foXWUKx40HXSJ2XtLYFwiKO0IcEoODJiSogRTvAKMU2Xi+GM1zRnffFKg6gOkhAXmKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793745793;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=WNR4+MDWGECO6jbM87hPWX/gV0rkRn2EWh5tdGZ21Hw=;
	b=BEWWhdO7RGAKkVFICezNsiEdqNNURAWl3Eubf+WE358GmPkIDL5GX/EsMGzMoigc/Qbj
	 Raxd5OWSc1gOX7pIKmqbFyNeICoZQ20eUyr5rJ6VYotTDaC2wrIKRjFBBDFMWQy0HVuNe
	 1UBZD54mY1phjZ9/Hp+MiXhT5b0wx3jveIZsimBJ+zdnV7IAOUvtDNkqPxzq2ra3Fqf56
	 lN5jMQN65pAlTsJFjRaEYEPCkDFewZodSqK9ggerk+AwfltrGZ/4n6q8Z1D8ELLLdPtF0
	 2UwiVkgb3hqtDOlm8RIF/j1fAtWlcgOc1AgwgcyNEkZwEjjOGTfhRQhI2RL8yktOrsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HQIA1fa4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247CB606A31B
	for <live-patching@vger.kernel.org>; Tue,  3 Nov 2026 22:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HQIA1fa4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44B8A1F000C1;
	Tue,  3 Nov 2026 22:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793745792;
	bh=WNR4+MDWGECO6jbM87hPWX/gV0rkRn2EWh5tdGZ21Hw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HQIA1fa4OZRNFuz1XkWAvQOg2y9REdcrIE24fopXh+VDpHeOa2iKQLMG7nkEjBc65
	 At02pIIajZPeSQTLbXeedGohWcC9SSKcAmZerz3sgeNsshGoUA5qlyX1riYBVd7hU0
	 JCOfNRgYCYvrvYX0rNmekn6Nk9i7tgeLDhzCGpCuQdAwRhmJJ+fSA9yNFfi21CCHy1
	 HETJ6wTyG7gkpnWOmkZKwWlMwkYsafFDPAy1PXxZPpxW0W665ea2b4eB7igIg8pii9
	 Wp7nEXKSKN9+Rd1Po9yhMC3+PL2fj4bjU3vEY0SlXpiAA9QYphNzu7EppedT8ZkbTr
	 4zDNtdzjxDezg==
Message-ID: <sashiko-outbox-196148@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] selftests/livepatch: build test modules against
 the selected kernel
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>, "Josh Poimboeuf" <jpoimboe@kernel.org>, "Miroslav
 Benes" <mbenes@suse.cz>, "Petr Mladek" <pmladek@suse.com>, "Joe Lawrence" <joe.lawrence@redhat.com>
Cc: "Song Liu" <song@kernel.org>, "Marcos Paulo de Souza" <mpdesouza@suse.com>, "Eva
 Kurchatova" <eva.kurchatova@virtuozzo.com>, "Yafang Shao" <laoar.shao@gmail.com>, "Shuah
 Khan" <shuah@kernel.org>, live-patching@vger.kernel.org
In-Reply-To: <20261103222706.1642224-2-sashal@kernel.org>
References: <20261103222706.1642224-1-sashal@kernel.org>
 <20261103222706.1642224-2-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 22:43:11 +0000
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] selftests/livepatch: KDIR selection ignores .config without Modu=
le.symvers
--

commit ae4848cae1b2b7420ab6ac44f707bd616ad82b5a
Author: Sasha Levin <sashal@kernel.org>

selftests/livepatch: build test modules against the selected kernel

This commit updates the livepatch selftests build and test scripts to select
KDIR from O, KBUILD_OUTPUT, or the source tree before falling back to the
running kernel's build directory, stops forwarding O and KBUILD_OUTPUT to t=
he
external module build, and skips building or running tests when
CONFIG_LIVEPATCH is disabled.

> diff --git a/tools/testing/selftests/livepatch/Makefile b/tools/testing/s=
elftests/livepatch/Makefile
> index a080eb54a215d..5c631812575dc 100644
> --- a/tools/testing/selftests/livepatch/Makefile
> +++ b/tools/testing/selftests/livepatch/Makefile
> @@ -1,7 +1,26 @@
>  # SPDX-License-Identifier: GPL-2.0
> =20
> +ifndef KDIR
> +LIVEPATCH_OBJTREE :=3D $(firstword $(O) $(KBUILD_OUTPUT))
> +ifneq ($(and $(LIVEPATCH_OBJTREE),$(wildcard $(LIVEPATCH_OBJTREE)/Module=
.symvers)),)
> +KDIR :=3D $(LIVEPATCH_OBJTREE)
> +else ifneq ($(wildcard ../../../../Module.symvers),)
> +KDIR :=3D ../../../..
> +else
> +KDIR :=3D /lib/modules/$(shell uname -r)/build
> +endif
> +endif
> +override KDIR :=3D $(abspath $(KDIR))
> +export KDIR
> +MAKEOVERRIDES :=3D $(filter-out KDIR=3D%,$(MAKEOVERRIDES))
> +
> +LIVEPATCH_CONFIG :=3D $(shell if [ -r "$(KDIR)/.config" ]; then \
> +	grep -qx 'CONFIG_LIVEPATCH=3Dy' "$(KDIR)/.config" && echo y || echo n; =
fi)

[Severity: Medium]
When KDIR is not explicitly set, KDIR only selects $(LIVEPATCH_OBJTREE) or
../../../.. if Module.symvers exists in that directory, falling back to
/lib/modules/$(shell uname -r)/build otherwise. Then LIVEPATCH_CONFIG checks
$(KDIR)/.config for CONFIG_LIVEPATCH=3Dy.

If a kernel is configured and built with CONFIG_MODULES=3Dn (so CONFIG_LIVE=
PATCH
is also disabled), the top-level Makefile clears KBUILD_MODULES and
scripts/Makefile.modpost sets output-symdump to vmlinux.symvers instead of
Module.symvers:

scripts/Makefile.modpost:
output-symdump :=3D $(if $(KBUILD_MODULES), Module.symvers, vmlinux.symvers)

Because Module.symvers is never created in that build, or when running make
kselftest-all or building only a kernel image target before modules, .config
exists in $(LIVEPATCH_OBJTREE) or ../../../.. without Module.symvers.

In those cases, wouldn't KDIR ignore the target kernel directory and fall b=
ack
to /lib/modules/$(uname -r)/build, causing LIVEPATCH_CONFIG to read the
running host kernel's .config and attempt to build test_modules against the
host kernel instead of skipping or using the target kernel tree? Conversely,
if O=3D points to an unprepared kernel build tree configured with
CONFIG_LIVEPATCH=3Dy, wouldn't KDIR silently fall back to ../../../.. or
/lib/modules/$(uname -r)/build instead of using O=3D?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103222706.1642=
224-1-sashal@kernel.org?part=3D1
