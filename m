Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB423330D4C
	for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 06:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789368085; cv=none; b=kgWpYFaKp8eZEtUzqDnbRhQy94SU4b+WqBC3/FESn4qrUaanB7vs1NtbPQ0xbDAdd6TyL/6lmerJsYJ2bv2KimECND30hFjaFfCjW7yICAVdgCQBRdauSFsKV8GzSP8TztJFNjImyvgJom3syPFYDvz8boBn0kWVxprnOqmfhCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789368085; c=relaxed/simple;
	bh=4Z8Rx40YHXUgmitnkE1yKz82cTm0VfZV9I18BNU/vyQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Z4YWzzN3XnDAo+9Xw0hFnoTWjOZ3QFhsw6vdaJgOdRwpDL3McaTVfTfwakNpFWbPHQoHbkIXPRHpNkrwBQzxmAoFyxnYpM4DZyL9BbEEVmrLUfEGzCQ/mfHTOFcymPvcXJd1QaqPKiX/7u/yeFCUeApZfH0vAPk/4JxKYkhBAuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AJg1WX/i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AJg1WX/i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F118C1F000FF;
	Mon, 14 Sep 2026 06:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789368083;
	bh=YdHSthipQUK+5EiL6nV6uZHF6qloL9HsVml3/FuuaHI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AJg1WX/ijiqynC51v/4aun7vhGUUYKkU5M5KBjAmRJGGuIbqsDFHOk70qRumzHkio
	 x3Ta3aO1Al4QpoV051nqOwky+H9cc82/zd8AnA6N5NTqqpRH3DxubIBz1aLlgf2XHp
	 vmAzKHdObZsHvek5/oQbOsNnnNQSchXS4yQvB4oXEknMXT/ukD5+kNW/n2zYJdDtuN
	 qWDWm9fc5sVrxIJDzL2crHap4nItNCpFjA7r7IzPB4zHfJPXVD0V5xsFU2rD9fJ1E4
	 nWJY3TZ99vO4nJ56a5cvv8xHbRtA5xlrci9mmqZFfW6k5Jbqo5W30VsH+hdLvM3x2o
	 n/OqEmrEh2TJQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 05/58] objtool/klp: Build klp test fixtures through
 the harness
Reply-To: sashiko-reviews@lists.linux.dev
To: live-patching@vger.kernel.org, "Song Liu" <song@kernel.org>
Cc: jpoimboe@kernel.org, kernel-team@meta.com, peterz@infradead.org, joe.lawrence@redhat.com, pmladek@suse.com, jikos@kernel.org, mbenes@suse.cz, puranjay@kernel.org
In-Reply-To: <20260914062514.926997-6-song@kernel.org>
References: <20260914062514.926997-1-song@kernel.org>
 <20260914062514.926997-6-song@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 06:41:22 +0000
Message-Id: <20260914064122.F118C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] The global `orig_obj` and `patched_obj` variables are not reset =
by `build_pair()`, causing state leakage between sequential test segments.
- [Medium] `make_vmlinux_pair()` masks malformed test invocations as toolch=
ain deficiencies, resulting in silent test skips.
- [Medium] `run_objtool_check` fails to invalidate the `.checksummed` cache=
 flag after modifying object files in-place.
--

commit 19435afd8ba9b070d7a97986a8ecde2ed711708b
Author: Song Liu <song@kernel.org>
Subject: objtool/klp: Build klp test fixtures through the harness

This commit refactors the objtool livepatch testing harness to standardize
fixture compilation, abstracting build and linking routines. It extracts ob=
ject
creation and checksum generation into helper functions. It also adds logic =
to
handle vmlinux pairs and properly sequence objtool checks.

> diff --git a/tools/objtool/tests/lib.sh b/tools/objtool/tests/lib.sh
> index 7185198253bb7..0a9da178f4dc8 100644
> --- a/tools/objtool/tests/lib.sh
> +++ b/tools/objtool/tests/lib.sh

[ ... ]

> @@ -211,17 +224,64 @@ clang_only()
>  	declared_skip "clang only${1:+: $1}"
>  }
> =20
> +# build_one <fixture.c> <output object> [cflags...]
> +build_one()
> +{

[ ... ]

> +}
> +
>  # build_pair <fixture.c> [cflags...]
>  build_pair()
>  {
> -	local fixture=3D"$FIXTURES_DIR/$1"; shift
> +	local fixture=3D"$1"; shift
> =20
> -	[ -f "$fixture" ] || fail "missing fixture $fixture"
> +	build_one "$fixture" orig.o "$@"
> +	build_one "$fixture" patched.o "$@" -DPATCHED
>  }

[Severity: Medium]
Does this code leave orig_obj pointing to stale data if run after
make_vmlinux_pair()?

If a test sequences its segments so that make_vmlinux_pair() is called first
(which sets the global orig_obj=3Dvmlinux.o), and then build_pair() is call=
ed,
build_pair() does not reset orig_obj to orig.o.=20

Would this cause a subsequent run_diff() to erroneously diff the stale
vmlinux.o instead of the newly built orig.o?

> +# run_objtool_check <objtool arguments...>
> +#
> +# Run objtool's ordinary check pass over the pair, as the kernel build d=
oes.
> +#

[ ... ]

> +run_objtool_check()
> +{
> +	local obj
> +
> +	for obj in "$orig_obj" "$patched_obj"; do
> +		"$OBJTOOL" "$@" "$workdir/$obj" ||
> +			fail "objtool $* failed on $obj"
> +	done
> +}

[Severity: Medium]
Can this function leave a stale checksum cache in place?

Other functions that create or modify objects, like build_one() and
partial_link(), remove the $workdir/.checksummed marker.=20

Since run_objtool_check() executes objtool directly on the test objects, wh=
ich
can append new sections like ORC metadata, should it also remove the
.checksummed file to prevent subsequent run_checksum() calls from skipping
generation and using stale checksum data?

[ ... ]

> +make_vmlinux_pair()
> +{
> +	local orig=3D() patched=3D() seen=3D arg
> +
> +	for arg in "$@"; do
> +		if [ "$arg" =3D -- ]; then seen=3Dy; continue; fi
> +		if [ -n "$seen" ]; then patched+=3D( "$arg" ); else orig+=3D( "$arg" )=
; fi
> +	done
> +
> +	partial_link "$workdir/vmlinux.o" "${orig[@]}" ||
> +		probe_skip "partial link unavailable"

[Severity: Medium]
Will this silently mask test definition bugs as toolchain deficiencies?

If a test author accidentally malforms the arguments by omitting the --
delimiter, the $orig or $patched arrays will be empty. Calling partial_link
with empty input arrays would correctly fail, but capturing that failure he=
re
and executing probe_skip masks it.=20

Doesn't this contradict the commit's design principle that a fixture which =
will
not compile should be a failure rather than a skip?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914062514.9269=
97-1-song@kernel.org?part=3D5
