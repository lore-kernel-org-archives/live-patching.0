Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201081A7264
	for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 06:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789367867; cv=none; b=JlQNQol3Ly/4Z4qaPU3wlf3LEzqx7z2OzNTjhnHv6S382Hy3NRbYrckLTTSqMfkU72oYc8gPJVqKschfx4SK+2ISBnvc+V2W6XqB2IBqzIiNEmg+MTdqp4Cf/u2w6pGgIkCqIrIvQrAY3GGSBRDsIzaaiNegxleqlJ42hqZMLMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789367867; c=relaxed/simple;
	bh=HHVvwGZFfGdAiMUxE8XzlpROy+pU2bXpzBQniVlXdnE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Y+16+Sg8cpnopG4PaSR+58TShiZt9qTXYvu5Gjyqi33OFlNa7tH1+i84SdP6mvn2dLCOs/TkLeE/mVWUFj2zzy3okE08zIcHl+wShJBQDjU7Lm8EMNmf/o8uxzzijTwHdsGFdkTEEAlvw9zLIqaXnfb8lbeLOhCRPxOpIkHtciw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hnx45DZD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hnx45DZD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D8EE1F000FF;
	Mon, 14 Sep 2026 06:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789367866;
	bh=tfFkwtHNt4cdkPe/1dM7T4kto7j+ArQ6ULsC7GidNdo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hnx45DZD4jXu1cpMGn7AMB7O8S2Iym4q8ZnUnPaNcUldm1CvaYY7kZLwFQ7eZkLVi
	 ZZfhvrMzOWQzvp4HFv/J6KeLKEA2GaGCDiVwXzTok08os7PwFgqjml1wnEduLwpMlo
	 q6+n/p1MqHM8zS2jK5IGZ3vLY6Jpuc06Pgd4xAVILIYgf3kDPlJJTcp5E3acjv6V18
	 DqJmhZKvpl6k11zpNtimF0Pu55CRplj5Uy6Mq2//sJSneE/6jDHmROERKX3VPsFhE0
	 cwTP+J/0bPRefkAk3qIE20w+FidcrUZXZV7wTOmRX3ChOzEfrok7GGjvoT2LGwWoKm
	 EWy+I4yLNir8w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 02/58] objtool/klp: Check the klp test environment
 once, before any test
Reply-To: sashiko-reviews@lists.linux.dev
To: live-patching@vger.kernel.org, "Song Liu" <song@kernel.org>
Cc: pmladek@suse.com, kernel-team@meta.com, jikos@kernel.org, jpoimboe@kernel.org, peterz@infradead.org, mbenes@suse.cz, joe.lawrence@redhat.com, puranjay@kernel.org
In-Reply-To: <20260914062514.926997-3-song@kernel.org>
References: <20260914062514.926997-1-song@kernel.org>
 <20260914062514.926997-3-song@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 06:37:45 +0000
Message-Id: <20260914063745.7D8EE1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Tool existence checks for READELF, OBJCOPY, and LD will fail if the=
se variables contain CLI arguments, incorrectly aborting the test suite.
--

commit 2ddfaa45c9b45195802f915e9ca42e1e7b224f4b
Author: Song Liu <song@kernel.org>

objtool/klp: Check the klp test environment once, before any test

This commit adds a preflight check to evaluate the objtool test environment=
=20
once before the test suite runs. It exports the environment answers and fai=
ls=20
the entire run if prerequisites are missing, rather than skipping tests=20
individually.

> diff --git a/tools/objtool/tests/lib.sh b/tools/objtool/tests/lib.sh
> index 714371232fa30..6e4e54b108659 100644
> --- a/tools/objtool/tests/lib.sh
> +++ b/tools/objtool/tests/lib.sh
[ ... ]
> +klp_preflight()
> +{
> +	local tmp tool cc_version host cc_arch
> +
> +	bail() { echo "Bail out! $*" >&2; exit 1; }
[ ... ]
> +	command -v "${CC%% *}" >/dev/null || bail "compiler not found: $CC"
> +
> +	for tool in "$READELF" "$OBJCOPY" "$LD"; do
> +		command -v "$tool" >/dev/null || bail "$tool not found"
> +	done

[Severity: Low]
Will this check fail if the toolchain variables contain CLI arguments?

Unlike the compiler check just above it which correctly uses parameter=20
expansion to strip arguments (`${CC%% *}`), passing the full string to=20
`command -v` when it contains spaces (e.g., if a developer or CI system=20
overrides `OBJCOPY=3D"llvm-objcopy --target=3Darm64"`) will cause `command =
-v`=20
to treat the entire string as a single binary name and fail.=20

Could this incorrectly abort the test suite under valid configurations?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914062514.9269=
97-1-song@kernel.org?part=3D2
