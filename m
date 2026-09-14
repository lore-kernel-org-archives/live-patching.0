Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90D534750B
	for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 06:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789367915; cv=none; b=SxrFKU3oNSvai4jZaoc8LwXfspYqaSVeXgLL0pI5gBg+BOw6Z0PTrcAcYwWFpGAHVyPLqwqxrbayxltrdJUY0ay1jzLnE/u3kDCtKNaPLV4SMo+4SE6MBmXwEjgzAEKYuchBkBGzjUWAY8nQwbmfoXjtVDLB+TFewBuFeVA+YRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789367915; c=relaxed/simple;
	bh=iOiK9X4rFzCyOCME5EuA80rxZ25cEKxPGlzOspgSbj8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mEN0/c8LiMBp7n4CzKCiMAsnQxb3qCpZFnOdHuTbbxCFYfg+PqQM3w8sg24t4jVHqCdJWnDYdjMMxUWg+brvdK5RTd5rGWeEHCGx58UQGuwj+CDzTncPYvkqVqF0fz8wGDAIZ+cMKpf2Je1rlmNWHpYyxFjQdVYQ+c/Pn2pezVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dowt2oHK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dowt2oHK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F9951F000FF;
	Mon, 14 Sep 2026 06:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789367913;
	bh=4REuwF04CXbp2SfhGwROVmcPgujFwCsx9RC/7kGqaP4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dowt2oHKwl0YYUuFe82SyIJGSNrunm3xTSxBY6yHYawurllajQhmzxFr28JhxnHog
	 pDvLni+6VHVeLHfQbd2xNW0pHAYrnNeRRRviGjeXeSO5yT53k5fNYJhXEakB0WE3/2
	 iylVZG+8fJMjuG8sXQqMIs1nh97v0U+FIZG1KhceziZIvROAbOf/n+TGv+CW1re70I
	 FKmZBcr4lrpVdoM5coXri31iT6ltnJHzAF5lNSMVKXr3N7dCmvF5aNXt//ex6uiQ64
	 2shn4pStR8RR41TVqMEtFayBgxMN1IaBTvn2qloKDopIW1/KgELF7AmN4IpA9hpwl9
	 6SPmeoDvEPRwg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 16/58] objtool/klp: Add test for cold function halves
Reply-To: sashiko-reviews@lists.linux.dev
To: "Song Liu" <song@kernel.org>, live-patching@vger.kernel.org
Cc: puranjay@kernel.org, peterz@infradead.org, joe.lawrence@redhat.com, pmladek@suse.com, mbenes@suse.cz, jikos@kernel.org, kernel-team@meta.com, jpoimboe@kernel.org
In-Reply-To: <20260914062514.926997-17-song@kernel.org>
References: <20260914062514.926997-1-song@kernel.org>
 <20260914062514.926997-17-song@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 06:38:32 +0000
Message-Id: <20260914063833.0F9951F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The test assertion for the carried cold function incorrectly pas=
ses with `llvm-readelf` when the cold half is left behind.
--

commit a04e65cdf7036d7ab3a10a22fc0efb8a0c3873bd
Author: Puranjay Mohan <puranjay@kernel.org>

objtool/klp: Add test for cold function halves

The compiler splits unlikely code into a separate foo.cold symbol. Both
halves are the same function and both belong in the livepatch. This adds
a test to ensure cold paths branching into unpatched code are handled.

> diff --git a/tools/objtool/tests/generic/test-cold-function.sh b/tools/ob=
jtool/tests/generic/test-cold-function.sh
> new file mode 100755
> index 0000000000000..dd4a7297af044
> --- /dev/null
> +++ b/tools/objtool/tests/generic/test-cold-function.sh

[ ... ]

> +assert_patched target
> +# Not a bare name match: had the cold half been left behind, the branch =
to
> +# it would appear as an undefined .klp.sym.vmlinux.target.cold, whose na=
me
> +# contains the one being looked for.  Require a defined symbol.
> +out_symbols | awk '$7 !=3D "UND" && $8 ~ /target\.cold/ { found =3D 1 }
> +	END { exit !found }' ||
> +	fail "cold half was not carried into the patch"

[Severity: Medium]
Will this awk script correctly detect missing cold halves when the test is
run with llvm-readelf?

When the cold half is left behind, klp diff converts unresolved references
into SHN_LIVEPATCH symbols. llvm-readelf formats these as:

OS[0xff20] .klp.sym.vmlinux.target.cold,0

Because there is no space between the section name and the symbol name in
this output format, $7 evaluates to "OS[0xff20]" (which is not "UND") and $8
matches the /target\.cold/ regex.

Does this condition evaluate to true and cause the test to falsely pass when
the cold half is actually left behind?

> +
> +pass "cold half carried into the patch with its parent"

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914062514.9269=
97-1-song@kernel.org?part=3D16
