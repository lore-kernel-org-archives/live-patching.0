Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA12639B4A5
	for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 23:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789428961; cv=none; b=moT+eVEHE6PSsN3R2M+MsX0qPUsHJ6hEZkAYhVcLKE46VlAVAc2oJmoM2RO+wYqAwNje4N2FXhvWQCAKM8iR0lLlh7p7aqt2L9haX21+E2Du15vgmVytb8PSc/qZ8AJXSpU4sFAcG3PHgiyPCmsRizNgG+PQ0zTyv2yF1Q0Lhjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789428961; c=relaxed/simple;
	bh=BavRyNJlcb8vO6SvzyXyfyjVj6yD7pb3cNZ7lNQ5hDw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VNEcnZkb4J78wsGLJllCbnaXzq4v9dAQ9XlgEVnMq8xH2X3dQ59sdb+cGPiawQDFY27aAUTJkgKpNtxyj8AqdVEALo+cT3E1DMEBFlfY7nkdYqHepqyQdRZkTAYwgwhVgHUaVkOVabgD0kX8zkJM5BX6xVd5ylgmJigYQN6Vm+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KemC9e0G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KemC9e0G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C05F1F000FF;
	Mon, 14 Sep 2026 23:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789428959;
	bh=cTti2NYJoRcO5E4evtWXkiCWTASFQZOFKVg8pyVTDOs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KemC9e0Gx7CimLrO+0HZBuUR3xZqbDAxsKntoTPRwIAyKb1zsGO3oK9NDLyPthnF8
	 ck60f27U9MRDde+gsNJauhXy0YkjOTaje34dzPYGEaTOSJ6EWv/tFbsy7MjeDqPf3P
	 uLV6j0nghrPC5hSRigkKBQ6pm4BA1s1XoNcDsKm9p+70NwuaJsS8wVUIWNmEHZW9Im
	 VpKNGz54Y8lmWWqYFuRY67IgmBWRQfRgFExVC6n2Zmw7HeWE3dV3m79Acch5NjHxe+
	 L0VpRIh601Py1BGX0qgR+9tMoz64UjBLURapWZmiJLNhYl6NYF/wv2LjSb+KfwqJYl
	 zykmd8CjkpcLw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 06/58] objtool/klp: Grow the klp test harness
 vocabulary
Reply-To: sashiko-reviews@lists.linux.dev
To: "Song Liu" <song@kernel.org>, live-patching@vger.kernel.org
Cc: pmladek@suse.com, mbenes@suse.cz, jikos@kernel.org, puranjay@kernel.org, jpoimboe@kernel.org, peterz@infradead.org, joe.lawrence@redhat.com, kernel-team@meta.com
In-Reply-To: <20260914230355.3422996-7-song@kernel.org>
References: <20260914230355.3422996-1-song@kernel.org>
 <20260914230355.3422996-7-song@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 23:35:58 +0000
Message-Id: <20260914233559.2C05F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] objtool/klp: run_checksum failures swallowed in subshells mask t=
est failures
--

commit 3b088080b3fc17cb3c6bcdacd83b5a2febf34918
Author: Song Liu <song@kernel.org>

objtool/klp: Grow the klp test harness vocabulary

Adds assertions for the output produced by klp diff, as well as for the
input objects. Includes helpers to extract and verify checksums recorded
for livepatch symbols.

> diff --git a/tools/objtool/tests/lib.sh b/tools/objtool/tests/lib.sh
> index 35be42758ece8..1b1baff80a712 100644
> --- a/tools/objtool/tests/lib.sh
> +++ b/tools/objtool/tests/lib.sh
[ ... ]
> +checksum_of()
> +{
> +	local obj=3D"$workdir/$1" sym=3D"$2" off
> +
> +	run_checksum
> +
> +	off=3D"$($READELF -rW "$obj" 2>/dev/null |
> +	       awk -v s=3D"$sym" '/rela\.discard\.sym_checksum/,/^$/ {
> +			if ($5 =3D=3D s) { print $1; exit }
> +	       }')"
> +
> +	[ -n "$off" ] || return 1
> +
> +	$OBJCOPY -O binary --only-section=3D.discard.sym_checksum \
> +		"$obj" "$workdir/checksums.bin" 2>/dev/null || return 1
> +
> +	dd if=3D"$workdir/checksums.bin" bs=3D1 skip=3D$((16#$off + 8)) count=
=3D8 \
> +		status=3Dnone | od -An -tx1 | tr -d ' \n'
> +}
> +
> +# assert_checksum_differs <symbol> / assert_checksum_matches <symbol>
> +#
> +# Compare what klp checksum recorded for a symbol in the original agains=
t the
> +# patched object.  This is what decides whether klp diff treats a functi=
on as
> +# changed, so a test asserting only that the right functions were cloned=
 cannot
> +# tell a correct checksum from one which happens to differ.
> +checksum_pair()
> +{
> +	orig_checksum=3D"$(checksum_of "$orig_obj" "$1")"
> +	patched_checksum=3D"$(checksum_of "$patched_obj" "$1")"

[Severity: Medium]
Will run_checksum failures be swallowed by these subshells, potentially
masking test failures?

If objtool klp checksum fails for orig_obj, it triggers the call chain
checksum_pair() -> checksum_of() -> run_checksum() -> fail() in
tools/objtool/tests/lib.sh. Since this occurs within a subshell, fail()
exits only the subshell and its stdout (the "not ok..." string) is
captured into orig_checksum instead of terminating the test. No
.checksummed marker is created.

When checksum_of() runs for patched_obj, run_checksum() attempts to process
orig_obj again and fails identically, capturing the exact same failure
string into patched_checksum.

Both variables will contain the identical "not ok..." error string.

> +
> +	[ -n "$orig_checksum" ] ||
> +		fail "no checksum recorded for '$1' in $orig_obj"
> +	[ -n "$patched_checksum" ] ||
> +		fail "no checksum recorded for '$1' in $patched_obj"
> +}
> +
> +assert_checksum_differs()
> +{
> +	checksum_pair "$1"
> +
> +	[ "$orig_checksum" !=3D "$patched_checksum" ] ||
> +		fail "checksum for '$1' unchanged at $orig_checksum, expected it to di=
ffer"
> +}
> +
> +assert_checksum_matches()
> +{
> +	checksum_pair "$1"
> +
> +	[ "$orig_checksum" =3D "$patched_checksum" ] ||

As a result, assert_checksum_matches() evaluates to true here, and the test
silently passes despite a toolchain failure.

> +		fail "checksum for '$1' changed from $orig_checksum to" \
> +		     "$patched_checksum, expected no change"
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914230355.3422=
996-1-song@kernel.org?part=3D6
