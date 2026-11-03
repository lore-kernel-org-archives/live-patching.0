Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793716164;
	b=ifGvFuWgP83xDYOnhgA3uGi8UxVsW3K5ODKa2a3VtYQdpTqBB+cLITPZFDhMyclwwFZS
	 4zOXvo0D/zmnQFs6bqV7O9MymVbQ3wdH6lVjGE9oufduXplCEApESyay+Bubc1WG04iCI
	 iGky3oZqzvXMGlvpxWoih8MN20ojKW+RYNIedvPOC+PHWZJK1rjeqXps243EHzo83YJ8P
	 kfyBeE4DzH4UF9JQg5T92ibb/b6uVLIYm9chnk1dTf0drQNzdToZKliT9ra8l6Ug2mX+S
	 qK+325iv8TbB90Ws6qD4a9kzGQYHQZxLL46Eigku6B+LaemZ2rppJIUS3awfPonLFmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793716164;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=cvUH51l2xN/EdFVoTjzCGujpqqGTkkuXMuHlvakfprU=;
	b=0QR1OHvTMd22j/SkN2a+kPvV3M90jBaGTd0gFi1BRnfIN6a6FbbaCOH2cCtg2xUgjymf
	 w84HQNun7LKdMvehkfU/2/pVTEbSq+dErCOVYjNagxfLrk7MdrsezAviNzz7anqEgIgGk
	 3e49E766iY2zp/5aIYN1HxeTkXjqCHIoZR5+XBf29LsXHl04781lVlGOZWYgeuLXxAAOh
	 TUZsepttuPqljbdKdAWrCXC5TpeAvwaP2R+Trv+cxcCCS/y0Vj6yHdZYZRhBrM/Xwxkwx
	 QHy/tOQ8hf0oRnTPG/tAUPhHIT+uHbeelWui6DmpAyBD6Ovaj30y13jePloYgbPFn4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Q8xH1N/I";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6821E606A324
	for <live-patching@vger.kernel.org>; Tue,  3 Nov 2026 14:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q8xH1N/I
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80E931F000C1;
	Tue,  3 Nov 2026 14:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793716164;
	bh=cvUH51l2xN/EdFVoTjzCGujpqqGTkkuXMuHlvakfprU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q8xH1N/IwQOKOuMRpKMZWMcPkObGVbT8MuujUK+88KhEDeAmFgIEFMWrESLV4XdKM
	 j8YCcQ5NJTfzMcS/ZEdTm9JfASZo6LcctYW7MUxX+RMvB/+G5b+AA93OyPGbPcxp7K
	 BtsjtoHrbNx+zi28ql2Bch4rEMp1Bl6KhoPu4bc/NuZKtVbJIqq3kkQq3jI5Cc60mM
	 e3oC7I37aVCUYG/Ju/XdkTUqQdsIFkzinb8kVYC7EhlWSgChOeK2WZu8R8b7owRhXg
	 5OusJ/qCizQH/aRjQv923gN/DWmRIdIjVvcN2n0fAY+7wxgE+2KDBvWfWqdM2uMG3g
	 jJqBuMVuF/7tg==
Message-ID: <sashiko-outbox-195449@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] selftests/livepatch: build test modules against
 the selected kernel
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>, "Josh Poimboeuf" <jpoimboe@kernel.org>, "Miroslav
 Benes" <mbenes@suse.cz>, "Petr Mladek" <pmladek@suse.com>, "Joe Lawrence" <joe.lawrence@redhat.com>
Cc: "Song Liu" <song@kernel.org>, "Marcos Paulo de Souza" <mpdesouza@suse.com>, "Eva
 Kurchatova" <eva.kurchatova@virtuozzo.com>, "Yafang Shao" <laoar.shao@gmail.com>, "Shuah
 Khan" <shuah@kernel.org>, live-patching@vger.kernel.org
In-Reply-To: <20261103140218.17568-2-sashal@kernel.org>
References: <20261103140218.17568-1-sashal@kernel.org>
 <20261103140218.17568-2-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 14:29:23 +0000
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] selftests/livepatch: clean fails to resolve LIVEPATCH_OBJTREE
- [Medium] selftests/livepatch: relative command-line KDIR not resolved for=
 sub-make
--

commit 02a5cf889b06dba8630406e570f3de0adc2db5d6
Author: Sasha Levin <sashal@kernel.org>

selftests/livepatch: build test modules against the selected kernel

This commit updates the livepatch selftest Makefiles to select KDIR from O,
KBUILD_OUTPUT, or the in-tree build before falling back to the running
kernel's build directory. It also skips building test modules when
CONFIG_LIVEPATCH is disabled in the target .config and stops forwarding O a=
nd
KBUILD_OUTPUT to the external module build.

> diff --git a/tools/testing/selftests/livepatch/Makefile b/tools/testing/s=
elftests/livepatch/Makefile
> index a080eb54a215d..855bbad241235 100644
> --- a/tools/testing/selftests/livepatch/Makefile
> +++ b/tools/testing/selftests/livepatch/Makefile
> @@ -1,7 +1,25 @@
>  # SPDX-License-Identifier: GPL-20
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

[Severity: Medium]
Can this fail to locate the build directory during a clean when a relative
O=3D or KBUILD_OUTPUT=3D path is used, or when the kernel build tree has al=
ready
removed Module.symvers?

During all, run_tests, and install, tools/testing/selftests/Makefile resolv=
es
O and KBUILD_OUTPUT into abs_objtree and passes O=3D$(abs_objtree) to the
target sub-makes, but the clean target does not pass O=3D$(abs_objtree):

tools/testing/selftests/Makefile:
clean:
	@for TARGET in $(TARGETS) $(INSTALL_DEP_TARGETS); do \
		BUILD_TARGET=3D$$BUILD/$$TARGET;	\
		$(MAKE) OUTPUT=3D$$BUILD_TARGET -C $$TARGET clean;\
	done;

When running "make O=3Dbuild kselftest-clean TARGETS=3Dlivepatch" or
"make -C tools/testing/selftests O=3Dbuild TARGETS=3Dlivepatch clean",
LIVEPATCH_OBJTREE in tools/testing/selftests/livepatch/Makefile receives the
unanchored relative path "build" (via MAKEFLAGS or the KBUILD_OUTPUT
environment variable) and checks for tools/testing/selftests/livepatch/buil=
d/Module.symvers
instead of ../../../../build/Module.symvers.

Similarly, if the kernel build directory was cleaned before kselftest-clean,
Module.symvers is already gone even though Kbuild external-module clean does
not require it.

In both cases, KDIR falls back to /lib/modules/$(shell uname -r)/build. On a
host or container where /lib/modules/$(uname -r)/build does not exist,
tools/testing/selftests/livepatch/test_modules/Makefile sees an empty
$(wildcard $(KDIR)) and skips cleaning test_modules/, leaving the built
module artifacts behind.

> +override KDIR :=3D $(abspath $(KDIR))
> +export KDIR

[Severity: Medium]
Does passing a relative KDIR=3D... on the make command line still propagate=
 the
unresolved relative path to test_modules/Makefile?

In GNU Make, "override KDIR :=3D $(abspath $(KDIR))" and "export KDIR" upda=
te
KDIR in the current makefile and exported environment, but the original
command-line assignment remains in MAKEOVERRIDES (forwarded via MAKEFLAGS).

When ../lib.mk (via gen_mods_dir or clean_mods_dir) or clean_livepatch_mods
invokes $(MAKE) -C test_modules, the sub-make in
tools/testing/selftests/livepatch/test_modules/Makefile only filters O=3D% =
and
KBUILD_OUTPUT=3D% out of MAKEOVERRIDES:

tools/testing/selftests/livepatch/test_modules/Makefile:
modules clean: MAKEOVERRIDES :=3D $(filter-out O=3D% KBUILD_OUTPUT=3D%,$(MA=
KEOVERRIDES))

As a result, the child make inherits the raw command-line KDIR=3D<relative_=
path>
from MAKEFLAGS, which takes precedence over the exported environment variab=
le
and is evaluated one directory deeper inside test_modules/ (for example,
"make -C tools/testing/selftests/livepatch KDIR=3D../../../.." resolves KDI=
R to
tools/ inside test_modules/Makefile and fails the build, or silently skips
building if the shifted path does not exist).

Should KDIR=3D% also be filtered out of MAKEOVERRIDES (or passed explicitly=
 as
KDIR=3D$(KDIR) to the test_modules sub-make)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103140218.1756=
8-1-sashal@kernel.org?part=3D1
