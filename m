Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA1E282F2A
	for <live-patching@vger.kernel.org>; Wed, 14 Oct 2026 20:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792008749; cv=none; b=b3CLpRK0Byswb+2SJaLOnvzjOoQFUy8lAgDzUXh/c7I5FQ1j26fVTMEqzLFz+h3AuX6Q4BvanFXqUrRwzi3RagfscWNIGlLmiCgvIq1fe/4ubhn4q3VeHlK8SWjkLIjqz+Y1DJUXvHGL6+NXm5Ic+EfbRduG1v8STboWzmunHpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792008749; c=relaxed/simple;
	bh=nnNOyF8IhdFdNTFUqeCilz/kS6tNuGT7Ts7Zno9sVrs=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=F502OCqXRm3cekAGbJVv2kc1ySdpvbWLDhtM8wViM8j9QvC0jIDDfhxxDxEc+JN20rCA5Gu535Xl2qDCqakO5Es33m6VDbLaUuDWUZSI44d6ZcbpKtyEepiXh7d+rS3RhcqFNlp9D6ap313iKxTMwxhE+fGXSiqOwB6FYd0OSYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k8906H7G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k8906H7G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F1AB1F000C4;
	Wed, 14 Oct 2026 20:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792008748;
	bh=y9KRkvsqazAjXgLbas7lI0KrqPKqMZDC6l2V8KweZcg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k8906H7GUCEdrvirGAlp6VFSyal8QVz3j4WQ/Gu+wXxzh34wyI/G2eC7PntrqIsaj
	 9SRYAMYO/WTiFH15MxUifgfc8nwaNaPNA5hkTdKFPIAr0eN4DG9s5L4WYHQoWSYUm4
	 QE+zYotPs14ufgIk9zqgrl6VJQ5E9GHYvm8tilbLEE4XA/U2pvafvAyynO7Z5QmloK
	 x3SxPE8piE6zKqxrKVRJ6OeRvDqoS+DndCtRwmq81lahHe1vO5azq392MvOshiGe9C
	 ISteuYnZ9yfiTpHkQOUqwIfkpnlpT/au+K/pos/Sqon4z+VuQp8xOruAxWJMbODpBz
	 nodmqK4kCsmhw==
Message-ID: <sashiko-outbox-171842@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] selftests/livepatch: build test modules against the
 selected kernel
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>, "Josh Poimboeuf" <jpoimboe@kernel.org>, "Miroslav
 Benes" <mbenes@suse.cz>, "Petr Mladek" <pmladek@suse.com>, "Joe Lawrence" <joe.lawrence@redhat.com>
Cc: "Song Liu" <song@kernel.org>, "Marcos Paulo de Souza" <mpdesouza@suse.com>, "Eva
 Kurchatova" <eva.kurchatova@virtuozzo.com>, "Yafang Shao" <laoar.shao@gmail.com>, "Shuah
 Khan" <shuah@kernel.org>, live-patching@vger.kernel.org
In-Reply-To: <20261014200154.1365200-1-sashal@kernel.org>
References: <20261014200154.1365200-1-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 20:12:26 +0000
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] kbuild: target-specific MAKEOVERRIDES assignment is ignored by G=
NU Make
- [Medium] selftests: livepatch: tests falsely skip on target machines with=
out KDIR
--

commit 52a5776aaff15a8419816c34023de1b05a2d6d7f
Author: Sasha Levin <sashal@kernel.org>

selftests/livepatch: build test modules against the selected kernel

This commit attempts to fix building livepatch test modules against an outp=
ut
directory by selecting KDIR from O or KBUILD_OUTPUT. It also aims to stop
forwarding O and KBUILD_OUTPUT to the kernel sub-make so that the build wor=
ks
correctly against distribution headers or output directories.

> diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testi=
ng/selftests/livepatch/functions.sh
> index 429fce1f31431..8b26b70f92d8c 100644
> --- a/tools/testing/selftests/livepatch/functions.sh
> +++ b/tools/testing/selftests/livepatch/functions.sh
> @@ -150,6 +150,7 @@ function cleanup() {
>  #		 the ftrace_enabled sysctl.
>  function setup_config() {
>  	is_root
> +	[[ -d "$SYSFS_KLP_DIR" ]] || skip "livepatch is not available"
>  	has_kdir
>  	push_config

[Severity: Medium]
Is the call to has_kdir inside setup_config still appropriate here?

When running tests via the kselftest_install workflow on a target system
without a kernel build tree, has_kdir fails and unconditionally skips the
tests. This causes the tests to falsely skip on installed target machines,
even if the test modules were already successfully compiled and are availab=
le
to load.

> diff --git a/tools/testing/selftests/livepatch/test_modules/Makefile b/to=
ols/testing/selftests/livepatch/test_modules/Makefile
> index a13d398585dcb..1fbeaac9c2b2c 100644
> --- a/tools/testing/selftests/livepatch/test_modules/Makefile
> +++ b/tools/testing/selftests/livepatch/test_modules/Makefile
> @@ -16,14 +16,16 @@ obj-m +=3D test_klp_atomic_replace.o \
>  	test_klp_state3.o \
>  	test_klp_syscall.o
> =20
> +modules clean: MAKEOVERRIDES :=3D $(filter-out O=3D% KBUILD_OUTPUT=3D%,$=
(MAKEOVERRIDES))

[Severity: Medium]
Will this target-specific assignment of MAKEOVERRIDES be ignored by GNU Mak=
e?

GNU Make does not support target-specific assignments for special variables
like MAKEOVERRIDES and MAKEFLAGS. As a result, the global O=3D and
KBUILD_OUTPUT=3D overrides will still be passed to the sub-make via MAKEFLA=
GS.

Could this leak the un-filtered variables to Kbuild and cause the build to
fail against output directories when make O=3D... is used, defeating the pu=
rpose
of the patch?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014200154.1365=
200-1-sashal@kernel.org?part=3D1
