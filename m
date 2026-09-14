Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8CF343899
	for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 06:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789367883; cv=none; b=SPC5E6GSKx6+aENJgp+MqDY6HTEtwYk9fiqDiTHdrBD5JFAhWldD12caM0NXED0ZAPQ0i1+pcDGqIGqaqUgdSK5Bl6eQV51dAfqT0XYBSZTap4HhBHPkrAoYs2vFBSQ546po6kSyT6Pj4/mz+TwQqX4CPfwl1EfooWDQe65JP5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789367883; c=relaxed/simple;
	bh=mFGf9CwNc6JAxit13oHpifA1RUfuYvMfpyNgsLMWo2k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=A0qjUV+YKz4Yqh/1XTyuvPtViyZX6fp7SH8x44nXq+H1SpDHjnAg3/D3hRRlpQIWSldtcckdREV+LlKuNe5aG0XLl8KQoZeARyTRYWiU0el08g6/PJq17D9m0CFmfOrA7Nu9I629rUf9c5/vzkdO24Q9fQIAWgosAWl+Q49IuKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZquBnCeo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZquBnCeo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDD641F000FF;
	Mon, 14 Sep 2026 06:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789367882;
	bh=q4nQLNTNU5tW6yG38O9FAzXPZjgro8fvYbQ3IJjixnM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZquBnCeo83Iu5KaxgdTurXSvJlYs6ye2ggCGzOfZXrcBteufM/zpXO7yX8vVBt6ph
	 /kbxYv4j+tomiru9H5SSPU1g07f9MxijVsSxO2nXdgnJKfpsKroF9ezHYU0PVt1u5H
	 PEiZ78x7VtFQi/OZwFQGucNWoWt1REeGUnN4xr2n4RdphLwaHksCkufJSuNtD7sAB9
	 atkrjmnFarfHe98Mh49M21bK9nhBH4fzYQEiasapJTekbbzB8Fq0RTjLJfOafXsqah
	 VyYGG1oLfUJaJhNFoR6O1zXZiv4MtNBYkcATlONd4MD6WI3Zb0TmcjyHaRgtaghkqA
	 X0gUzh61MgUUQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 13/58] objtool/klp: Add test for newly introduced
 data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Song Liu" <song@kernel.org>, live-patching@vger.kernel.org
Cc: jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com, peterz@infradead.org, jpoimboe@kernel.org, puranjay@kernel.org, joe.lawrence@redhat.com, kernel-team@meta.com
In-Reply-To: <20260914062514.926997-14-song@kernel.org>
References: <20260914062514.926997-1-song@kernel.org>
 <20260914062514.926997-14-song@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 06:38:01 +0000
Message-Id: <20260914063801.BDD641F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The test uses `grep -q` which incorrectly matches section symbol=
s in newer binutils, bypassing the check for the actual object symbol.
- [Medium] The test fixture uses a predictable, linear `static const int` a=
rray which the compiler can easily optimize away into arithmetic, causing a=
 false test failure.
--

commit 5c5aee1d82edada34865ca44a6b863b5d7f437f3
Author: Puranjay Mohan <puranjay@kernel.org>

objtool/klp: Add test for newly introduced data

Adding data differs from changing it: nothing in the running kernel refers
to a new variable, so it is safe and has to travel into the livepatch with
the function using it.

> diff --git a/tools/objtool/tests/generic/fixtures/new_data.c b/tools/objt=
ool/tests/generic/fixtures/new_data.c
> index 0000000000000..fa861fe813869
> --- /dev/null
> +++ b/tools/objtool/tests/generic/fixtures/new_data.c
> @@ -0,0 +1,18 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Data introduced by the patch. */
> +
> +static const char __modinfo[]
> +	__attribute__((section(".modinfo"), used, aligned(1))) =3D "\0name=3Dvm=
linux";
> +
> +#ifdef PATCHED
> +static const int klp_new_data[4] __attribute__((used)) =3D { 1, 2, 3, 4 =
};
> +#endif
> +
> +int target(int x)
> +{
> +#ifdef PATCHED
> +	return x + klp_new_data[x & 3];

[Severity: Medium]
Can the compiler fold this array lookup into arithmetic? The predictable,
linear sequence of values here makes it a target for array-to-math
optimizations (e.g. GCC at -O2 might compile klp_new_data[x & 3] as
(x & 3) + 1).

If the compiler optimizes this away into scalar arithmetic, it would elimin=
ate
the necessary relocation to klp_new_data in the target() function. Since
objtool klp diff relies on this relocation to pull in the variable,
eliminating it would cause the test to spuriously fail.

> +#else
> +	return x;
> +#endif
> +}
> diff --git a/tools/objtool/tests/generic/test-new-data.sh b/tools/objtool=
/tests/generic/test-new-data.sh
> index 0000000000000..c7336752f09a8
> --- /dev/null
> +++ b/tools/objtool/tests/generic/test-new-data.sh

[ ... ]

> +run_diff
> +
> +assert_patched target
> +out_symbols | grep -q 'klp_new_data' ||
> +	fail "new data was not carried into the patch"

[Severity: Medium]
Will this test falsely pass if the actual object symbol is dropped but the
section is preserved?

This simple grep bypasses the symbol type check (OBJECT) and matches the
section symbol in newer binutils where readelf prints section names. If
grep -q incorrectly matches the section symbol (like .rodata.klp_new_data),
it would mask regressions in objtool's handling of the object symbol itself.

> +
> +pass "new data carried into the patch"

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914062514.9269=
97-1-song@kernel.org?part=3D13
