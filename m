Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C901A6838
	for <live-patching@vger.kernel.org>; Sun,  9 Aug 2026 09:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786267997; cv=none; b=YKIeMcAoD6+mcK2/58//DI47b/Le9VgH+z4j8KY0j2mIRqyopzf9gUzLlTH3I/xB7GhbQxiXdJC63S83blr0OqCdjeCYTIMpBQFfyQ8XUSFhGX0DnVYySVqMMfgmHIjNmAn1zFgFEE1Fy9EXejAQCDxqJAgD/iifKMu0bXeFSFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786267997; c=relaxed/simple;
	bh=FNVbDHgZbbvD77n/YTsIKfGmk8YA3sU8XyRHuYq27RY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aiBUNmuMgBD4U3kEkDB0l/7ZmgzM5JXNXiHOfoaiSdrIYyLwzLxc6m3tubt7TsORAX7jI8b4sWrs03WWcN5sX83Z7igoee5WdPyyfqXZLh+Mb+8L0syk4Ct+Pq+IOcksjGRGvpRw6R1GSdDpYjLfLj8qJRNb7xPZ87KfgruKD2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fp/DEoZy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fp/DEoZy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 930A41F000E9;
	Sun,  9 Aug 2026 09:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786267996;
	bh=x/xgD9D//52o9x2SOt7Vo75s7deivAWsywvMHqd/1PU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fp/DEoZy85SxaM7O2w8v8GKn9V5a/AlT5EyHjuG970/Y7xgooHfUONtzRignQUWeT
	 iApF8SSeQeUSSaujnHmazYhCtmAuxfRRGNVZic6t4a6h9hq1GnyC1YftRo2pKxD1XM
	 +CsA8p6QgF5m1bQQZ1NftEIljp1EI+yA71m5YeliEDVPWNuhe2cCppecAYP8xZh2vs
	 ZtEthOZ9ZDJjb+l0X4wH/W9mUarka77LKyutBlwE/Z3uOSZBwoTWzhg1svzyQyQAlE
	 zTryFVlK8REUrkF99Ftw2gwTgAqT4blCjtXhXgY8rPe/+wEFsOPTbz8uEYgXJFQZuO
	 vU/7iETo2tYsA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/9] livepatch: Implement replace set for scoped
 atomic replace
Reply-To: sashiko-reviews@lists.linux.dev
To: jpoimboe@kernel.org, pmladek@suse.com, joe.lawrence@redhat.com, song@kernel.org, mbenes@suse.cz, jikos@kernel.org
Cc: "Yafang Shao" <laoar.shao@gmail.com>, live-patching@vger.kernel.org
In-Reply-To: <20260809091954.22930-5-laoar.shao@gmail.com>
References: <20260809091954.22930-1-laoar.shao@gmail.com>
 <20260809091954.22930-5-laoar.shao@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 09 Aug 2026 09:33:14 +0000
Message-Id: <20260809093315.930A41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The `--provides` argument in `klp-build` lacks input validation,=
 allowing shell command injection during the kernel module build process.
--

--- Patch [4]: [PATCH v5 4/9] livepatch: Implement replace set for scoped a=
tomic replace ---
commit 1fb78be5e32d18ecfd4bbeb7fa484d70bf6b9401
Author: Yafang Shao <laoar.shao@gmail.com>

livepatch: Implement replace set for scoped atomic replace

This commit introduces a more flexible model for livepatch replacement by
adding provides and obsoletes fields, allowing multiple independent=20
livepatch sets to coexist on the same system.

> diff --git a/scripts/livepatch/klp-build b/scripts/livepatch/klp-build
> index c4a7acf8edc3f..3600f93d9c1c3 100755
> --- a/scripts/livepatch/klp-build
> +++ b/scripts/livepatch/klp-build

[ ... ]

> @@ -189,9 +190,26 @@ process_args() {
>  				NAME=3D"$(module_name_string "$NAME")"
>  				shift 2
>  				;;
> -			--no-replace)
> -				REPLACE=3D0
> -				shift
> +			-p | --provides)
> +				PROVIDES=3D"$2"

[Severity: Medium]
Is there a missing validation check for the provides argument here?

The obsoletes argument below checks for valid integers, but it appears this
assignment accepts any unvalidated string.

> +				shift 2
> +				;;
> +			-r | --obsoletes)
> +				OBSOLETES=3D"$2"
> +				local obs_val=3D"$2"
> +				[[ "$obs_val" !=3D \[*\] ]] && die "obsoletes must be enclosed in br=
ackets, e.g., '[0,1,2]'"

[ ... ]

> @@ -847,7 +896,17 @@ build_patch_module() {
> =20
>  	cflags=3D("-ffunction-sections")
>  	cflags+=3D("-fdata-sections")
> -	[[ $REPLACE -eq 0 ]] && cflags+=3D("-DKLP_NO_REPLACE")
> +	cflags+=3D("-DKLP_PROVIDES=3D$PROVIDES")

[Severity: Medium]
Because the provides argument lacks validation in process_args(), could
this assignment allow shell command injection during the build process if=20
un-escaped metacharacters are passed to the script?

> +
> +	# Process OBSOLETES: remove brackets and spaces, convert to comma-separ=
ated string
> +	# Input: "[0, 1, 2]" or "[]" or "" -> Output: "0,1,2" or empty
> +	if [[ -n "$OBSOLETES" && "$OBSOLETES" !=3D "[]" ]]; then

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260809091954.2293=
0-1-laoar.shao@gmail.com?part=3D4
