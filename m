Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F681A6838
	for <live-patching@vger.kernel.org>; Sun,  9 Aug 2026 09:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786268003; cv=none; b=nVKBOuvlcIdt9LdT59SAqhRxkJrVkdK5Hr5k3XBWs0yoRlpv0rb4evu29rrmu5qRERSroyl0KOwkqUc7J/oiskHDHi4cAwSCfaW8LsISOO9u7l6Ranp1q5v/NTHz7YoL2khS7i0tynHYgnz/t6/LLg8D9ZOec2efJSMBmfkEjBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786268003; c=relaxed/simple;
	bh=81Lg+/MtdhG7eOmqEuTaQEipMByAlH2xo3VM2FHbejc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=u3JJ9GLkG5y9o0+ZiJGaE8CBxnyLCYPIim7CyVlVIO7nKKy78uNHNUn/Q6XBZjQBgDWe4RiirXvOdp6dYeBiAME9HvvcXyMBigoRm03TY5LMgPrKLNZVtyne7UQwUTY1RL4phHnOPRzuE7UxMZNYmUDAaIl40vN27vdiG6Lgeyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iEuYXt36; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iEuYXt36"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D25BB1F000E9;
	Sun,  9 Aug 2026 09:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786268002;
	bh=JZUgjSEugUHMqIpnYJnXU9R2Fk8EEUT7+hOh0Uv6cTk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iEuYXt369PtHbtG27zuS8KEm2aWQqwvEsr5VjimC4W9e/8s4PdUhCOQGrONOw5GgO
	 DulZGq1tA7n7BDMUGvqD4C58qKmzSu9VMQ/KlGtWXcx14qBukbo02tqk/gtlaHxEdZ
	 dhF4pfCUI67XUeQ+360YpLBjvX4weGcbvJ3F6k0Anf54LUnVc8zqWON6squnL/75Yu
	 Vt0na2v49oe8glwrInMFrsx6tFF7VbBrOTn5Vnd2WTOUSqgHlcAD+ajcCDf/1GloYv
	 IOyAk5FDnRJp8kGJ+kHcvkayPTDx3PiHOnXeNbkJFGpRj95sWITb2DxhsB3hOF6DoQ
	 pDiDX7XIqouEw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 6/9] selftests: livepatch: Adapt atomic replace tests
 to provides/obsoletes
Reply-To: sashiko-reviews@lists.linux.dev
To: jpoimboe@kernel.org, pmladek@suse.com, mbenes@suse.cz, song@kernel.org, jikos@kernel.org, joe.lawrence@redhat.com
Cc: live-patching@vger.kernel.org, "Yafang Shao" <laoar.shao@gmail.com>
In-Reply-To: <20260809091954.22930-7-laoar.shao@gmail.com>
References: <20260809091954.22930-1-laoar.shao@gmail.com>
 <20260809091954.22930-7-laoar.shao@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 09 Aug 2026 09:33:21 +0000
Message-Id: <20260809093321.D25BB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The 'replace' feature detection in test_modules/Makefile fails f=
or out-of-tree (O=3D) kernel builds, breaking tests on older kernels.
--

--- Patch [6]: [PATCH v5 6/9] selftests: livepatch: Adapt atomic replace te=
sts to provides/obsoletes ---
commit e4d15e9f2792340ea543b405f9d074e729665c9b
Author: Yafang Shao <laoar.shao@gmail.com>

selftests: livepatch: Adapt atomic replace tests to provides/obsoletes

The legacy "replace" field in struct klp_patch was replaced by the
provides/obsoletes mechanism. This commit adapts selftests to build and
run on both old and new kernels by detecting the presence of the
"replace" field.

> diff --git a/tools/testing/selftests/livepatch/test_modules/Makefile b/to=
ols/testing/selftests/livepatch/test_modules/Makefile
> index a13d398585dcb..29c55df360467 100644
> --- a/tools/testing/selftests/livepatch/test_modules/Makefile
> +++ b/tools/testing/selftests/livepatch/test_modules/Makefile
> @@ -16,6 +16,16 @@ obj-m +=3D test_klp_atomic_replace.o \
>  	test_klp_state3.o \
>  	test_klp_syscall.o
> =20
> +# The legacy "replace" field was replaced by provides/obsoletes. When the
> +# kernel (KDIR) still supports "replace", pass KLP_HAS_REPLACE to the
> +# modules so that they can #ifdef the legacy "replace" code. Otherwise
> +# the modules are built with the provides/obsoletes based code (to be
> +# added later).
> +KLP_HAS_REPLACE :=3D $(shell grep -q 'bool replace' $(KDIR)/include/linu=
x/livepatch.h 2>/dev/null && echo y)

[Severity: Medium]
Will this grep fail for out-of-tree (O=3D...) kernel builds?

If $(KDIR) points to the build directory rather than the source directory,
$(KDIR)/include/linux/livepatch.h might not exist.

When tests are run, detect_replace_attr() will still correctly identify the
replace sysfs attribute on the running kernel and set HAS_REPLACE_ATTR=3D1.

However, since the module would be compiled without KLP_HAS_REPLACE, it lac=
ks
the replace module parameter. When the test scripts attempt to load the mod=
ule
with replace=3D1, insmod will fail, causing the test suite to abort.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260809091954.2293=
0-1-laoar.shao@gmail.com?part=3D6
