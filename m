Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794329583;
	b=SOnBr5wM3aUx12mz2DMimNB2uSeCzoxLfiPaiKF4Zwf6NyVUQz1tDzkEEPGyye/YhF+I
	 gBawcy6mysnm6wiQsMBzX3DQmsVS2pYV5fAmienyje79vdKa7RHKsNX/Oa+wC5A+5K0cF
	 DuLa9DVPzHEKTyYrn6ejcXjNQx1RuGGPhC0hn1X35JEtm3dgPdyjwgfA3kfEDaeYFj5Fz
	 jl8Ltvk6hiulPssEGsOJjA1g6DMHgmClkvmeLFMP1lxObcon2R+ldeofiErTHlD6O0HR7
	 EOxGRLdFkACsi7pXL8JCXb9hS8yE4UceFY8i63/nDvB+qJydq9lSmPfwZZI7SMPytzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794329583;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=VVd+3LYfzRastybXiLRAKVd20lXieOqmFqHMCv/4VNk=;
	b=4krPoDMDBGdGwzGM/XYXRz/tb6dxbB11C4qTDAl7KxQEdy0b/lP8kaCu4iBokizCzUl8
	 o0PjXSYNtJ+EuskvJ9UslLe1Wznlm19jxTXLsTX8WWz/gtITG8Z3ffi+b4aYbxon7WEeH
	 yAjsYw6WdWC1ezg0R4p2woitp63T9n+9gQoC59j/97CjtpWxu7i9d/PQaH8WJA3atVKhV
	 HEiVvrdj5XssEq42+7TmZMbH4GIb9XsEoKTQSMdPmj9cyK4zisDf9lEspq62YqsXMR5fr
	 mLA4jFqTkNAICMCYnSD/EqmVKItBOUmI36hEek/TzhYp7ynSoQMwi4rq6ZJewgNK4gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=STMGcXPc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD30E606A336
	for <live-patching@vger.kernel.org>; Tue, 10 Nov 2026 16:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=STMGcXPc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F3A71F0089F;
	Tue, 10 Nov 2026 16:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794329582;
	bh=VVd+3LYfzRastybXiLRAKVd20lXieOqmFqHMCv/4VNk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=STMGcXPcf/F5ycE0ZdOUHYFg3wfGDX5TntkLNue1DuBgA94NJx/nH00JmOYrpwnsd
	 DV5o6JXaIc/we9YxAviGE91vV+UUweLionMs58mnAOmStrVBx3AYURbpGbNUQjTSpp
	 UheunHv2W7qa3/MRXev4FFi4/i8o8W8WUcfVhjnH6sOm8Z5FVC7JUJQH/ionfUMwdF
	 HbCylB0bI8vrnWLwWwaZL8F6rtzpWqHDQE5+YLdhd6+n2ZHEDJO8sltkfIZNfHoS9q
	 rxqPI8TgrS2ni/Dwp/WFasHyTxi0JagaQ9lp9Fi7heHbJm5s9UHCT9os69RccICZ5e
	 iVjXoMuLOEVLg==
Message-ID: <sashiko-outbox-207425@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/4] selftests/livepatch: build the test modules
 against the kernel in O=
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>, "Josh Poimboeuf" <jpoimboe@kernel.org>, "Miroslav
 Benes" <mbenes@suse.cz>, "Petr Mladek" <pmladek@suse.com>, "Joe Lawrence" <joe.lawrence@redhat.com>
Cc: "Song Liu" <song@kernel.org>, "Marcos Paulo de Souza" <mpdesouza@suse.com>, "Eva
 Kurchatova" <eva.kurchatova@virtuozzo.com>, "Yafang Shao" <laoar.shao@gmail.com>, "Shuah
 Khan" <shuah@kernel.org>, live-patching@vger.kernel.org
In-Reply-To: <20261110161050.2451750-4-sashal@kernel.org>
References: <20261110161050.2451750-1-sashal@kernel.org>
 <20261110161050.2451750-4-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 16:53:01 +0000
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
- [Medium] selftests/livepatch: KDIR fallback ignores builds without
  Module.symvers
--

commit 62f70537bbca33262ec62f1273becbdf534f58fc
Author: Sasha Levin <sashal@kernel.org>

selftests/livepatch: build the test modules against the kernel in O=3D

This commit selects KDIR from O=3D or KBUILD_OUTPUT (or the kernel source
tree) before falling back to the running kernel's build directory, and
strips O=3D and KBUILD_OUTPUT when invoking the kernel Makefile for the
livepatch test modules.

> diff --git a/tools/testing/selftests/livepatch/Makefile b/tools/testing/s=
elftests/livepatch/Makefile
> index a080eb54a215d..97478ef90945c 100644
> --- a/tools/testing/selftests/livepatch/Makefile
> +++ b/tools/testing/selftests/livepatch/Makefile
> @@ -1,5 +1,31 @@
>  # SPDX-License-Identifier: GPL-2.0
> =20
> +# The test modules are built against the kernel in KDIR. When KDIR is not
> +# set, use the output directory given with O=3D or KBUILD_OUTPUT if a ke=
rnel
> +# was built there, as with
> +#   make O=3D/tmp/kselftest TARGETS=3Dlivepatch kselftest
> +# otherwise the kernel source tree if the kernel was built in it, as with
> +#   cd tools/testing/selftests/livepatch; make
> +# and otherwise the build directory of the running kernel, which its
> +# devel files provide. A kernel was built in a directory if it has a
> +# Module.symvers.
> +ifndef KDIR
> +KBUILD_DIR :=3D $(firstword $(O) $(KBUILD_OUTPUT))
> +ifneq ($(and $(KBUILD_DIR),$(wildcard $(KBUILD_DIR)/Module.symvers)),)
> +KDIR :=3D $(KBUILD_DIR)
> +else ifneq ($(wildcard ../../../../Module.symvers),)
> +KDIR :=3D ../../../..
> +else
> +KDIR :=3D /lib/modules/$(shell uname -r)/build
> +endif
> +endif

[Severity: Medium]
Does checking only for Module.symvers cause KDIR to fall back to the host's
/lib/modules/$(uname -r)/build when the target kernel in O=3D or the source
tree was built with CONFIG_MODULES=3Dn or an image-only target (which
produces vmlinux.symvers instead of Module.symvers)?

When that happens and the host has kernel headers with CONFIG_LIVEPATCH=3Dy,
test_modules/Makefile reads the host's include/config/auto.conf and builds
the test modules against the running host kernel instead of skipping them
for the target kernel, which breaks cross-compiled builds or builds where
the in-tree test modules use newer kernel APIs than the host.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110161050.2451=
750-1-sashal@kernel.org?part=3D3
