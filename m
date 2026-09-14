Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80B53CAE93
	for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 23:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789429535; cv=none; b=uZcZ6G2Bh8Nes2vBPeb9bUHdw7Y88GX6+HBZw4QtbuPiCPgi5N6U2pOKqMbeRPyBI9W4HruJfw/rcCoE9zkc0RQpLqub9gwtlaw7OzPhEKyzHjzFYD0rf7zJt2n9REih6qQJa5FckeYzpCtjFT09gC/pdofyNkbnuEHmuYraUto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789429535; c=relaxed/simple;
	bh=HCkrcuZd4GoJVU8djKGl7N8UoYDfWseeFYryPvGMiCk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OScwIrK4s726ROp2teEhZwKGnfhyNUB6pCvKRWDGWLSHlQwmRzsdfTJ568HHvFwRR2fcgSuat5bg+dWcjXiWPXjoqCb2QszFloEuSwgT7G3M/7N0N4oc2zOxk1X5lq3MFpc5LJw6j3Vf8FgMB+j6+raxdpPqkf3YbyY2zZ7foUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BC6rK1Iv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BC6rK1Iv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D81AF1F00893;
	Mon, 14 Sep 2026 23:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789429534;
	bh=DvHX45aXVo8BREfCCKvK9TGYgHnfRfKUnUAL3DjPprg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BC6rK1Ivd8KSrwnHuLTi/yVvWw97yz0Rh1355YShzNvkgZ2/Byttht9cC7vAcMXa3
	 m68/4T7zutYsUpBCNTvZxwigNRgcOJtEdV7HJA7H77rqaMUI9rgB/qnXZ9cdCZZDZr
	 LokveUcV9gNFW0c6fX/ADRcZVrDoKVYXSuyp5sElu+0BpjcJ7bn4+LBgzV2faTYZac
	 5iXMjFeFsBf4Mfl7Edo+R+gQI7MZ6f2Rb4d0MWPtlVQO2niVdpYsEN0IYkgZhHbaDY
	 QcM4mBlBTJikrvQU0U9ey/ZDhtNQglnWPbtIJLllyTlgba2VpixnfeGiA0tiuFOkMM
	 PdCyLZouXsdxA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 11/58] objtool: Forward toolchain variables to the
 klp test runner
Reply-To: sashiko-reviews@lists.linux.dev
To: "Song Liu" <song@kernel.org>, live-patching@vger.kernel.org
Cc: joe.lawrence@redhat.com, jpoimboe@kernel.org, mbenes@suse.cz, peterz@infradead.org, pmladek@suse.com, jikos@kernel.org, puranjay@kernel.org, kernel-team@meta.com
In-Reply-To: <20260914230355.3422996-12-song@kernel.org>
References: <20260914230355.3422996-1-song@kernel.org>
 <20260914230355.3422996-12-song@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 23:45:33 +0000
Message-Id: <20260914234533.D81AF1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] objtool: tests target silently falls back to GNU objcopy under L=
LVM=3D1
--

commit 11c79ea0e223d9512f0e164886cfdec6a0e5e3b2
Author: Joe Lawrence <joe.lawrence@redhat.com>

objtool: Forward toolchain variables to the klp test runner

The tests target passes toolchain variables like CC, LD, READELF, and OBJCO=
PY
into the test scripts so that fixtures are built and inspected with the
selected toolchain.

[ ... ]

> diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
> index ed5cf146ef2e2..a3d09a5af7a20 100644
> --- a/tools/objtool/Makefile
> +++ b/tools/objtool/Makefile
> @@ -153,6 +153,8 @@ mrproper: clean
> =20
>  tests: $(OBJTOOL)
>  	$(Q)OBJTOOL=3D$(abspath $(OBJTOOL)) ARCH=3D$(ARCH) CROSS_COMPILE=3D$(CR=
OSS_COMPILE) \
> +		CC=3D'$(CC) $(CLANG_CROSS_FLAGS)' LD=3D'$(LD)' \
> +		READELF=3D'$(READELF)' OBJCOPY=3D'$(OBJCOPY)' \

[Severity: Medium]
Will the tests target silently fall back to GNU objcopy when building with
LLVM=3D1?

It appears that tools/scripts/Makefile.include defines LLVM_OBJCOPY but lea=
ves
OBJCOPY unset for LLVM builds. As a result, $(OBJCOPY) evaluates to an empty
string here in the tests recipe.

When this empty variable is passed to tools/objtool/tests/lib.sh, the fallb=
ack
logic:

OBJCOPY=3D"${OBJCOPY:-${CROSS_COMPILE}objcopy}"

treats the empty OBJCOPY as null due to the :- operator. This substitutes t=
he
default GNU objcopy instead of the intended llvm-objcopy, which defeats the
goal of using the selected LLVM toolchain.

>  		KEEP=3D$(KEEP) $(srctree)/tools/objtool/tests/run-tests.sh
> =20
>  FORCE:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914230355.3422=
996-1-song@kernel.org?part=3D11
