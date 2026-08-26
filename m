Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E223BA236
	for <live-patching@vger.kernel.org>; Wed, 26 Aug 2026 20:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787774442; cv=none; b=LnP8bkF01L6h1tE1ERIIrtc3ovK4yKu5/L9C47poJxd8Yx9HLnVLK+drLC+j5kxUfcxv5mUwDfe52BUCq+SpZrvtb2IVL4RRvAg8JxwtjaRuJ+hcnx24WFcdmrJy9kMKW43LXfFVIinmOl6wG31jyyIJq5zVa5tdq+pLZuKmaZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787774442; c=relaxed/simple;
	bh=AI+4YrNSGTB/eez9siYArfNLrItFtB7RV3CZaR4pjvw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YZpzjSwm+qLBxRIRl+nMCYHySe1K7tBR85eFDK59hGqsaAJS3H59Q/jUKyKl32DrVuSjlauDfdRr11zPQTkUGMXKHTfVMa8JRKzfn+bJo4aK54e4vsv6xt9mjgVtipcQP2a6rzIelDg5ieTNp0SrcAMbwFxj2SV8aleJQT1w2H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jvzTEKt3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvzTEKt3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 618EE1F00A3A;
	Wed, 26 Aug 2026 20:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787774438;
	bh=0Hzwe3qOoGOcMJB/tjc2FSHo6Yos5EfRyq0C/kRM4DU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jvzTEKt3OnsNGf6nSPiD8SBJVjhb60QHGcShtuM6SDCbj+6TwfyQzETfv4jTJOzkp
	 I2lZpN5uGjeSQEPYj/uGHC7Y3T+Y/IMdeNzDXBvLg/Ob5l9lA/D5MGKcLR2GuQdyUP
	 R32OlDo4K0tbDkJ70n43OWVI1ZygIqWno00AlPwSSLgQaCQ2CMN4Dmj28OS24k4WVX
	 9e1Mb6GsXzQmwAcCpGqUA5wEIRRkYnYV5SRPcPOEPkrakLhy6N4Kg58awfCWi6C0zE
	 4uzQq9QJPu/sBtapaFARQ1dpVXga1HT8jd9hgqMmOGmMgaLG0bsnLQi2fDPZ1skbY+
	 0ZEiTNXKWGLXQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 5/7] livepatch/klp-build: add basic out-of-tree
 module support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joe Lawrence" <joe.lawrence@redhat.com>, live-patching@vger.kernel.org
Cc: "Miroslav Benes" <mbenes@suse.cz>, "Yafang Shao" <laoar.shao@gmail.com>, "Josh
 Poimboeuf" <jpoimboe@kernel.org>, "Song Liu" <song@kernel.org>, "Petr
 Mladek" <pmladek@suse.com>
In-Reply-To: <20260826195000.455905-6-joe.lawrence@redhat.com>
References: <20260826195000.455905-1-joe.lawrence@redhat.com>
 <20260826195000.455905-6-joe.lawrence@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 20:00:37 +0000
Message-Id: <20260826200038.618EE1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The `apply_patch` function omits the `-d` directory option during =
the actual patch application, failing to apply patches to out-of-tree modul=
es.
- [Medium] Unconditional requirement for `vmlinux` unnecessarily prevents o=
ut-of-tree module livepatching against standard distro kernel headers.
--

commit aa6b14041f6a905023bf4d110f2171d49e9e8c84
Author: Joe Lawrence <joe.lawrence@redhat.com>

livepatch/klp-build: add basic out-of-tree module support

klp-build is currently limited to patching in-tree kernel modules.
Introduce a --oot-dir option to enable livepatch generation for basic
out-of-tree (OOT) modules.  This requires the associated kernel tree to
be fully built (Module.symvers must exist).

> diff --git a/scripts/livepatch/klp-build b/scripts/livepatch/klp-build
> index b52a8489d9f67..b60f5a5da31e8 100755
> --- a/scripts/livepatch/klp-build
> +++ b/scripts/livepatch/klp-build

[ ... ]

> @@ -377,13 +393,14 @@ apply_patch() {
>  	local patch=3D"$1"
>  	shift
>  	local extra_args=3D("$@")
> +	local patch_target=3D"${OOT_DIR:-$PWD}"
>  	local drift_regex=3D"with fuzz|offset [0-9]+ line"
>  	local output
>  	local status
> =20
>  	[[ ! -f "$patch" ]] && die "$patch doesn't exist"
>  	status=3D0
> -	output=3D$(patch -p1 --dry-run --no-backup-if-mismatch -r /dev/null "${=
extra_args[@]}" < "$patch" 2>&1) || status=3D$?
> +	output=3D$(patch -d "$patch_target" -p1 --dry-run --no-backup-if-mismat=
ch -r /dev/null "${extra_args[@]}" < "$patch" 2>&1) || status=3D$?
>  	if [[ "$status" -ne 0 ]]; then
>  		echo "$output" >&2
>  		die "$patch did not apply"

[Severity: High]
Does this actual patch application omit the -d directory argument?

It looks like the -d "$patch_target" argument was correctly added to the
dry-run here, but not to the real patch application lower down in
apply_patch():

    patch -p1 --no-backup-if-mismatch -r /dev/null "${extra_args[@]}" --sil=
ent < "$patch"

When running klp-build --oot-dir <dir> <patch>, won't this attempt to apply
the patch against the kernel root directory instead of the out-of-tree modu=
le?
This seems like it would cause the patch application to fail, or erroneously
modify identically-named files in the kernel tree.

[ ... ]

> @@ -597,10 +635,11 @@ copy_orig_objects() {
> =20
>  	find_objects | mapfile -t files
> =20
> +	local obj_root=3D"${OOT_DIR:-$PWD}"
>  	xtrace_save "copying original objects"
>  	for _file in "${files[@]}"; do
>  		local rel_file=3D"${_file/.ko/.o}"
> -		local file=3D"$PWD/$rel_file"
> +		local file=3D"$obj_root/$rel_file"
>  		local orig_file=3D"$ORIG_DIR/$rel_file"
>  		local orig_dir=3D"$(dirname "$orig_file")"
> =20

[Severity: Medium]
Will this script crash for valid out-of-tree module builds against standard
distro kernel headers?

Lower down in copy_orig_objects(), there is an unconditional requirement for
vmlinux to be present:

    cp -f "$PWD/vmlinux" "$ORIG_DIR" || die "missing vmlinux"

A primary use case for out-of-tree modules is building against kernel heade=
rs
which provide Module.symvers but do not include vmlinux. Since vmlinux is
unused during the object diffing steps for out-of-tree modules, should this
dependency be skipped when running klp-build --oot-dir <dir> <patch> to avo=
id
unnecessarily preventing livepatching against headers?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826195000.4559=
05-1-joe.lawrence@redhat.com?part=3D5
