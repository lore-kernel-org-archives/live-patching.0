Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEB23F484C
	for <live-patching@vger.kernel.org>; Fri, 11 Sep 2026 19:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789153676; cv=none; b=Z66ee/C8PHzf891RzhzEKYKWP8OyXBkFiWUFhhRsvxP2Mev1nw3wPwrQAPgFpkhTAhtoVe2rz7k0O5QvfKmcNwxCoWCanAl6KAZ73phVZoBVM7ZZxHvKv4w5x57KRs49iBXrr+SPwcKX/yVCoGUHXLfAEr0BtHVeY2/uJ3ZyWIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789153676; c=relaxed/simple;
	bh=ryrqleeKzmdpR4Njgncc4cpudNSMCwqkaSV/QDPm1l8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=L56Y9lF7kDt7EpE/cVHxjGxPkANJOmWlwjonhBFKRjBIARNUEKv7C839WcyeN7I7HvZGGgfoJDKXQNmRI20n5j8PGVLbWI4OkTd91ZFaO3ZIbnAoDZqYxOCL/NuGs+RgmcjhF0qFE4O7ReWH7Vtj6dcW3Nuc6L/v0u3J4VP4g1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F7xkuIXN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F7xkuIXN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B47E1F000FF;
	Fri, 11 Sep 2026 19:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789153667;
	bh=IK694Er5xJuBvd8Cxv2kaAMCmXGDDDA4snVCPLgg0AI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F7xkuIXN4+j6vT/Oggi4trRBT8Qb3mOPIyPyuVjOGv4D33UjX0Krn+y+dLr3Jh20t
	 dkx+s4h/7jdLAz6uzgtvZ/csBmlbPBH6rHD+OYfXecLAGd/s6SipXEEHHWlOdXUkFo
	 1CQGxJEqgsOyaJL/EwsS4/h75k2ixm5Fmz0aCDtF3hOrhWZ2jbr3md0nAbbezj1oqy
	 h0jfbJadxe9kcuNSmYwN47tBn49LZh8UeUY1F7t/j072ud1na821AH9eZjDPJ008so
	 SZEBrbbATYzMJmj3CDdauOwnlrKrNMv3ufA3BpvtVC1fAP1ZXinzA+S4Y3IjucOcsH
	 h6jkuKdLBrnMQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 13/58] objtool/klp: Add test for newly introduced data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Song Liu" <song@kernel.org>, live-patching@vger.kernel.org
Cc: peterz@infradead.org, jikos@kernel.org, puranjay@kernel.org, kernel-team@meta.com, pmladek@suse.com, joe.lawrence@redhat.com, jpoimboe@kernel.org, mbenes@suse.cz
In-Reply-To: <20260911184305.1457308-14-song@kernel.org>
References: <20260911184305.1457308-1-song@kernel.org>
 <20260911184305.1457308-14-song@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 19:07:46 +0000
Message-Id: <20260911190747.4B47E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Test fixture 'new_data.c' defines a 'static const' array without=
 preventing compiler optimization, which can lead to spurious test failures=
 if folded. Additionally, 'test-new-data.sh' fails to assert the input prem=
ise.
--

commit 6effea04700600e9c40a587a9beb3f3d63a133a2
Author: Puranjay Mohan <puranjay@kernel.org>

objtool/klp: Add test for newly introduced data

Adding data differs from changing it: nothing in the running kernel refers
to a new variable, so it is safe and has to travel into the livepatch with
the function using it.

> diff --git a/tools/objtool/tests/generic/fixtures/new_data.c b/tools/objt=
ool/tests/generic/fixtures/new_data.c
> new file mode 100644
> index 0000000000000..c82770b126fe6
> --- /dev/null
> +++ b/tools/objtool/tests/generic/fixtures/new_data.c
> @@ -0,0 +1,18 @@
[ ... ]
> +static const char __modinfo[]
> +	__attribute__((section(".modinfo"), used, aligned(1))) =3D "\0name=3Dvm=
linux";
> +
> +#ifdef PATCHED
> +static const int klp_new_data[4] =3D { 1, 2, 3, 4 };

[Severity: Medium]
Will this small array be optimized away by the compiler?

If the compiler folds the array lookup into a select statement or arithmeti=
c,
the symbol might not be emitted into the patched object file, leading to
spurious test suite failures.

Could this use __attribute__((used)) or an inline assembly barrier to
prevent read folding?

> +#endif
> +
> +int target(int x)
> +{
[ ... ]
> diff --git a/tools/objtool/tests/generic/test-new-data.sh b/tools/objtool=
/tests/generic/test-new-data.sh
> new file mode 100755
> index 0000000000000..83b72125b1e96
> --- /dev/null
> +++ b/tools/objtool/tests/generic/test-new-data.sh
> @@ -0,0 +1,17 @@
[ ... ]
> +assert_patched target
> +out_symbols | grep -q 'klp_new_data' ||
> +	fail "new data was not carried into the patch"

[Severity: Medium]
Could this assertion fail incorrectly if the compiler optimized the symbol
away?

Should there be a preceding assert_input_symbol klp_new_data to ensure the
symbol was actually emitted in patched.o, avoiding violations of the objtool
test writing guidelines?

> +
> +pass "new data carried into the patch"

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911185031.1534=
046-1-song@kernel.org?part=3D13
