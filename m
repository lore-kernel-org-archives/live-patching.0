Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4118647CC6C
	for <live-patching@vger.kernel.org>; Wed, 26 Aug 2026 20:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787774483; cv=none; b=SVA6tJnSwqGWXXutjSoct+V5vAM9uLUq5lwM3XA3yIEwfZ0JLi7UJuUUofmJtVvSro1tBlMZrVffGj14v1nDjY10a8CVnOdZMs4utvIfFPeIOzVm8OREMA1CqYm/UGfFwp1D7d7pxyjohChHAz5GkQYzpOLuR0uIlh19Q7R/CxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787774483; c=relaxed/simple;
	bh=WanD4CLm8eGp1IGBbzw4qlcB8pKjCU3G5bWpbTzzNXc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Q2/VhGL46HcGTzDJ03JH3BmH/U80HsLuWRxeqcLM6IGlamPlSGhiqHh/gq1HoTWCSud9AHY3vqRyYCHYQofTxB+LzfkHDfFhNrLlnXLdj/m6nSl1Ed53vMw9STstotalRU01PVgrWdV6aByIGzHIayXXICGomhRJl0rZZmqip4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oac/5qh5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oac/5qh5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 486511F000E9;
	Wed, 26 Aug 2026 20:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787774479;
	bh=RykeMumIBaLdBqr3O2lOhJkaYbU1XaHkzp2nSICI9A0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oac/5qh5VOf/IRzi8sNzXeAogLRlE1wl2Ha5uInTVmn8e+VXDlIc6tXe66C+k6yN+
	 FcjpvfWjnfUzEG9OUoDD0LuJt54axf1lvjqe+mJqYqS9V5hdPeMtyseV8MK9cZMkrJ
	 D0kFPIGMcjatoXUPl1qER9kIT8Qv1DWX2SonyT4wgevWSyqbh+0XZrZC1Rvn819yJz
	 VO5q4H8kG2o375dv2iVWGONz0sc14qf80h8eYtcsThmk7GomL+15XxA8bWNFlbexR9
	 4sR+czQsEnR2q07n09yC11/t9a5qWQCZlsSrQTpPqGaz+aMyPa2XoDclOdEbcrDv1D
	 QV2swmCKcUCOQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 6/7] livepatch/klp-build: add pre-built object
 support for advanced OOT workflows
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joe Lawrence" <joe.lawrence@redhat.com>, live-patching@vger.kernel.org
Cc: "Petr Mladek" <pmladek@suse.com>, "Josh Poimboeuf" <jpoimboe@kernel.org>, "Miroslav
 Benes" <mbenes@suse.cz>, "Yafang Shao" <laoar.shao@gmail.com>, "Song Liu" <song@kernel.org>
In-Reply-To: <20260826195000.455905-7-joe.lawrence@redhat.com>
References: <20260826195000.455905-1-joe.lawrence@redhat.com>
 <20260826195000.455905-7-joe.lawrence@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 20:01:18 +0000
Message-Id: <20260826200119.486511F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Medium] The newly introduced `--symvers` option breaks standard and `--o=
ot-dir` builds when provided with a relative path, and it fails to override=
 the `$PWD/Module.symvers` validation check for `--oot-dir` builds.
- [Medium] The `--show-first-changed` (`-f`) option is silently ignored in =
the pre-built object workflow.

Pre-existing issues:
- [High] Arbitrary command execution via maliciously crafted filenames cont=
aining Make functions in pre-built object directories.
--

commit f9d7e858a4afcd50869696d974b4dd56100b6cf0
Author: Joe Lawrence <joe.lawrence@redhat.com>
Subject: livepatch/klp-build: add pre-built object support for advanced OOT=
 workflows

This commit introduces `--orig-dir` and `--patched-dir` options to klp-buil=
d,
allowing users to supply pre-built original and patched objects directly
rather than relying on internal build stages. It performs binary comparison,
symbol extraction, and livepatch module assembly using these pre-built obje=
cts.

> diff --git a/scripts/livepatch/klp-build b/scripts/livepatch/klp-build
> index b60f5a5da31e8..e118f133e923c 100755
> --- a/scripts/livepatch/klp-build
> +++ b/scripts/livepatch/klp-build

[ ... ]

> @@ -456,7 +486,19 @@ validate_patches() {
>  do_init() {
>  	[[ ! "$PWD" -ef "$SCRIPT_DIR/../.." ]] && die "please run from the kern=
el root directory"
> =20
> -	if [[ -n "$OOT_DIR" ]]; then
> +	if [[ -n "$USER_ORIG_DIR" ]]; then
> +		[[ -d "$USER_ORIG_DIR" ]] || die "directory not found: $USER_ORIG_DIR"
> +		[[ -d "$USER_PATCHED_DIR" ]] || die "directory not found: $USER_PATCHE=
D_DIR"
> +		USER_ORIG_DIR=3D"$(realpath "$USER_ORIG_DIR")"
> +		USER_PATCHED_DIR=3D"$(realpath "$USER_PATCHED_DIR")"
> +		if [[ -n "$SYMVERS_PATH" ]]; then
> +			SYMVERS_PATH=3D"$(realpath "$SYMVERS_PATH")"
> +			[[ -f "$SYMVERS_PATH" ]] || die "Module.symvers not found: $SYMVERS_P=
ATH"
> +		else
> +			[[ -f "$PWD/Module.symvers" ]] ||
> +				die "no Module.symvers in $PWD; use --symvers to specify"
> +		fi
> +	elif [[ -n "$OOT_DIR" ]]; then

[Severity: Medium]
Will this leave `SYMVERS_PATH` as an unexpanded relative path when used with
`--oot-dir` or standard builds, since the `realpath` conversion is nested
inside the `--orig-dir` conditional branch?

Also, in the `elif [[ -n "$OOT_DIR" ]];` branch that follows, there is a ch=
eck
for `[[ -f "$PWD/Module.symvers" ]]`.

Does this fail to respect the provided `SYMVERS_PATH` during OOT
initialization and enforce validation on the hardcoded `$PWD/Module.symvers=
`,
preventing alternative paths?

[ ... ]

> @@ -757,7 +804,11 @@ diff_objects() {
>  		cmd+=3D("klp")
>  		cmd+=3D("diff")
>  		(( ${#opts[@]} > 0 )) && cmd+=3D("${opts[@]}")
> -		[[ -n "$OOT_DIR" ]] && cmd+=3D("--symvers" "$PWD/Module.symvers")
> +		if [[ -n "$SYMVERS_PATH" ]]; then
> +			cmd+=3D("--symvers" "$SYMVERS_PATH")

[Severity: Medium]
If `SYMVERS_PATH` remains a relative path from the issue above, will this
command fail when it is executed from the `$ORIG_CSUM_DIR` subshell?

[ ... ]

> @@ -931,11 +982,54 @@ build_patch_module() {
>  }
> =20
> =20
> +setup_oot() {
> +	local files=3D()
> +	local rel
> +
> +	mkdir -p "$ORIG_DIR" "$PATCHED_DIR"
> +
> +	find "$USER_ORIG_DIR" -type f -name "*.o" -printf '%P\n' | mapfile -t f=
iles

[Severity: High]
This is a pre-existing issue, but this pipeline ingests user-supplied
filenames from the pre-built object directories without sanitization.

Later in build_patch_module(), these filenames are written directly into the
generated Kbuild file target list:

    echo -n " $rel_file" >> "$makefile"

Can this allow arbitrary command execution via maliciously crafted filenames
containing Make functions (e.g., `$(shell command).o`) when processing untr=
usted
pre-built objects?

[ ... ]

> +	status "Building patch module: $OUTFILE"
> +	build_patch_module
> +
> +	status "SUCCESS"
> +	exit 0
> +fi
> +

[Severity: Medium]
Because this block executes the pre-built workflow and exits immediately,
doesn't it fully bypass the `diff_checksums` hook?

Will this silently ignore the `--show-first-changed` (`-f`) option in the
pre-built object workflow?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826195000.4559=
05-1-joe.lawrence@redhat.com?part=3D6
