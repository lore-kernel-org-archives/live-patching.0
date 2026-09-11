Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765663F9F2D
	for <live-patching@vger.kernel.org>; Fri, 11 Sep 2026 19:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789153344; cv=none; b=pEFLO0Y3/qK1tbQmq/XiqudKdisQUl2HYnjaFv22vpSQkiICmLB80zvvZvTFR162wl0DnjcqT65eQooUvAacELbdPB1UAKwzbxFn861ez2RS4jx4ZDh2I0iIyYpyYKuYORIP1SNYmn8F1alG4c/ZPmfBuiNh8FZT9v1McHMg/cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789153344; c=relaxed/simple;
	bh=V/UxlEE4c6G/FrwmbCwaiM1hGD7Wf+YpawlndKyW9Iw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sQTDS+PCZ+ZdhE9mT/cGOtGnygS47bRVI0ypm/merMhfCGojyb85pXJiGo9LaPNVQhf2ubTe+Z2MTatDoZerRt76b3o/KhFW+WQnSq0o1fUmKGO3jdNSwIJv/l21Iiu1SCKF6yhRxynOd4uL37toefm92LkaFoX2Y+Y9T0TpcAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mdHwfGBu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mdHwfGBu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14DC21F00893;
	Fri, 11 Sep 2026 19:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789153336;
	bh=a7UzznaDc05Zp7HAzEz2se6JnwjRgEUxS3ROtbS3PxQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mdHwfGBukNxswGeB9kDG0BU6AKAIHCg+MFWZzAPrLUG1JcqOTpMLd5ju4cfQeJgeF
	 L7TUN9AX20SdizLr2O/Uw2kFAukHO6lb3zdl6AVXm1AX6n1oN5WraZua8yIO+pPbzN
	 tJt1UaRPc7o4LOAhWVdfNFo0D62na3d65TG5TpPRSzmbCb1+wBqIL3AWUkzrFtc/5e
	 isc2/GHj3+8dzT3oSAMfvq6mj+udySHibpeog4+GLoqFkF+yDrRUsYDK9DTpBlAXyf
	 1rm2XpFX5fMOFNaKnWiW4PKO31hdUGiaLaKU89BPrNGxBDbmA1F7ARTK7ZJpv2adw1
	 MZRttnr2FcpiA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/58] objtool/klp: Check the klp test environment once,
 before any test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Song Liu" <song@kernel.org>, live-patching@vger.kernel.org
Cc: kernel-team@meta.com, mbenes@suse.cz, puranjay@kernel.org, jpoimboe@kernel.org, pmladek@suse.com, peterz@infradead.org, jikos@kernel.org, joe.lawrence@redhat.com
In-Reply-To: <20260911184305.1457308-3-song@kernel.org>
References: <20260911184305.1457308-1-song@kernel.org>
 <20260911184305.1457308-3-song@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 19:02:15 +0000
Message-Id: <20260911190216.14DC21F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Meaningful code and commit message mismatch regarding 'preflight=
.sh'
--

commit 61d3f6be171a4f4b4f3dea4ae2f0323ab1631fcd
Author: Song Liu <song@kernel.org>

objtool/klp: Check the klp test environment once, before any test

This commit centralizes the objtool and compiler environment checks for the
klp test suite, running them once upfront rather than in every test. It
aims to fail the entire test suite if the environment is unsuitable,
speeding up runs and avoiding misleading per-test skips.

>     Do it once, before any test, in preflight.sh, and record the answers =
where
>     the tests can read them.  If the suite cannot run the whole run fails=
 and
>     says why; a test which gets as far as running can assume its environm=
ent.
>    =20
>     The recorded file is required, not optional: a test which cannot tell=
 where
>     objtool is or which architecture it is on should say so rather than g=
uess
>     at an empty value.

[Severity: Medium]
Does the implementation match this description?

The commit message explicitly states that the checks are done in preflight.=
sh
and that a recorded file is required. However, the patch implements this lo=
gic
in a bash function instead, and the state is recorded via exported environm=
ent
variables.

> diff --git a/tools/objtool/tests/lib.sh b/tools/objtool/tests/lib.sh
> index 714371232fa30..6e4e54b108659 100644
> --- a/tools/objtool/tests/lib.sh
> +++ b/tools/objtool/tests/lib.sh
[ ... ]
> +# klp_preflight
> +#
> +# Check the environment once, before any test runs, and report what was =
found.
> +#
> +klp_preflight()
> +{
> +	local tmp tool cc_version host cc_arch

Is this a stale commit message from a previous iteration, or is there a mis=
sing
piece of the intended implementation that was supposed to use a file-based
approach?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911185031.1534=
046-1-song@kernel.org?part=3D2
