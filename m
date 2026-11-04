Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793800212;
	b=iz1iUujUNOP/ZL+42HDfDK759zmM+BULMO0OGuFSHjNpt+3BO3eKecONcrCph03q1+dV
	 m9HnIGZtq7TVu2JRnXYXxK3oeSGNHKLFNA6S1bVpvUQ/dHQAY4qwvJx45LtAOVw0f5nyy
	 XYP6uMuW1jh+UylC52O/IGGt7pJDMAm57iSs2udlbg5+RU33eoKHRcZrQGpMNo7P9eBpT
	 ON/haxxlBGT0Prlu0zWi3YqYBHfJVSjsKzNQ9NeJjsHivwmJp3IDbQHOZZ7E9cJpe9Xy5
	 0cpiqD8PeXYS+izsyJOjtyoWS9usJxewlTiSckcLCFl+Axqv3e0h5wlBfYuSW/AzOyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793800212;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=iYzIy77YY+n26ER821CyiokQcB6mDmTUuq8Mgsydrsg=;
	b=RIHmpYA1LIgFNywcXAf5T0U48hELdSS1PNBaC/CKJNjFf8Mvvb3C41YcOsKfLnR0nrWW
	 GxqK83sW2tGynmYkjQjS7uEU+4VSSTGuxbCLRisLDSirZtjq9AyweSF3HixvZRkMRMFaW
	 D8hqOPR5IJVrJpDi2T6fJi1Khau07w8Ez9gA2OR4Sd61yqdXCfRzwOfir4qqEnOtHtGTy
	 vqA41jE9aeqS1AMmOV4hGt9RrvlZDBSc8MKvJWzhkJJxSYhfr6/51FWI7EY69g7w+bo6x
	 E/I+Go6QoiN6f7dLCEEEkd2VbFIdbVvTiY13dBJa6fpZ3VN0w12n9SGLpYBl/R/OaoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n3BOIaA1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02B8606A31B
	for <live-patching@vger.kernel.org>; Wed,  4 Nov 2026 13:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n3BOIaA1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 078B61F000C1;
	Wed,  4 Nov 2026 13:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793800211;
	bh=iYzIy77YY+n26ER821CyiokQcB6mDmTUuq8Mgsydrsg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n3BOIaA1Ph5guNHkb5vwWux7VWxH6q1PDUAkbHxoHDK0Vl2i61xPr+NBpEUJkaIek
	 9KlJSgnrcpqLnaWDDCFX+wQj9gb8mFJd3iDXPkplIDNyuf1kDb21q+9li81jSGedQ4
	 j6x0862yrb+eW7gtxrfE8v9yKe7DhTHAkCbOZoGjl4hajlPwlyGA8Bwty05M6a1Xqh
	 gQTFwo+ZudCHELBXRzVsQukmFgKwpYBX1rFsL0U2+7fcYuXrnhhyykSf15+mOziHpS
	 P2ltyhqvTiHLuomOqUAg0hym0LfvBhs1ByPzOnd/x+1iY4PBmwNkra9VWc8SIkwqyy
	 2g/W2W1miLKaw==
Message-ID: <sashiko-outbox-197357@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 11/11] objtool/klp: Test symbol identity and
 state preservation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Longjun Luo" <luolongjuna@gmail.com>, jpoimboe@kernel.org, peterz@infradead.org
Cc: mbenes@suse.cz, pmladek@suse.com, joe.lawrence@redhat.com, song@kernel.org, puranjay@kernel.org, nathan@kernel.org, ndesaulniers@google.com, morbo@google.com, justinstitt@google.com, live-patching@vger.kernel.org
In-Reply-To: <20261104133158.3187525-12-luolongjuna@gmail.com>
References: <20261104133158.3187525-1-luolongjuna@gmail.com>
 <20261104133158.3187525-12-luolongjuna@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 13:50:10 +0000
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] objtool/klp: test suite left failing and sympos coverage lost
--

commit 81f49775a536febbdc9ffe953af763d00e57323f
Author: Longjun Luo <luolongjuna@gmail.com>

objtool/klp: Test symbol identity and state preservation

This commit adds tests and fixtures to exercise symbol identity and local
state preservation across source changes, inlining, compiler renaming, and
LTO in objtool klp.

>     objtool/klp: Test symbol identity and state preservation
>    =20
>     Exercise local state across source changes, inlining, compiler renami=
ng
>     and LTO. Check that patches reference the original objects and alloca=
te
>     only new state. Cover aliases, assembly, metadata, ICF, DWARF pieces,
>     shrunk storage, reduced information and saved DWP files. Cover separa=
te
>     cold-fragment identities left by weak overrides.
>    =20
>     Check rejection of ambiguous repeated statics, conflicting references
>     and changed data. Complete compound-reference tests and add same-named
>     target switches for the identity-based reference checksum.
>    =20
>     Skip the saved-DWP test when the linked libdw lacks DWP support.
>    =20
>     The full suite has 68 passes with GCC 16.2.1 and 75 with Clang
>     22.1.8. Only local-to-global-flip, sympos and sympos-vmlinux fail,
>     reflecting the linkage and duplicate-identity policies.
>    =20
>     Assisted-by: LLM
>     Signed-off-by: Longjun Luo <luolongjuna@gmail.com>

[Severity: Medium]
Does leaving test-local-to-global-flip.sh, test-sympos.sh, and
test-sympos-vmlinux.sh failing cause the test suite runner in
tools/objtool/tests/run-tests.sh to always exit non-zero, while also losing
all test coverage for sympos calculation?

In tools/objtool/tests/run-tests.sh, the runner exits non-zero whenever any
test fails without xfail:

    [ "$fail" =3D 0 ] && [ "$xpass" =3D 0 ]

In tools/objtool/tests/generic/test-sympos.sh and
tools/objtool/tests/generic/test-sympos-vmlinux.sh, the scripts compile a
single source file twice to produce two translation units with a same-named
static variable (dup_counter):

tools/objtool/tests/generic/test-sympos.sh:
	build_one sympos_dup.c "a$p.o" -DFUNC_NAME=3Duse_a $p
	# shellcheck disable=3DSC2086
	build_one sympos_dup.c "b$p.o" -DFUNC_NAME=3Duse_b -DNO_MODINFO $p

tools/objtool/tests/generic/test-sympos-vmlinux.sh:
build_one sympos_vmlinux.c orig_a.o    -DFUNC_NAME=3Duse_a -DVARSEC=3D'".da=
ta.zzz"'
build_one sympos_vmlinux.c patched_a.o -DFUNC_NAME=3Duse_a -DVARSEC=3D'".da=
ta.zzz"' -DPATCHED
build_one sympos_vmlinux.c b.o         -DFUNC_NAME=3Duse_b -DVARSEC=3D'".da=
ta.aaa"' -DNO_MODINFO

Because both objects are compiled from the exact same source file path,
they share an identical DWARF CU path, causing validate_dwarf_identity() in
tools/objtool/klp-identity.c to abort during klp checksum with a duplicate
symbol identity error before klp diff ever runs. As a result,
klp_find_sympos() and .klp.symid vmlinux address-order resolution are never
reached or tested.

Similarly, in tools/objtool/tests/generic/test-local-to-global-flip.sh:

    run_diff

    assert_diff_log 'changed function: caller'

the test still expects klp diff to succeed and correlate symbols across
linkage changes, whereas check_linkage_changes() in tools/objtool/klp-diff.c
now rejects linkage flips with exit status 255.

Should test-sympos.sh and test-sympos-vmlinux.sh compile separate source
files so their DWARF CU paths are distinct and sympos resolution is still
exercised, and should test-local-to-global-flip.sh be updated to assert the
linkage rejection so the test suite passes cleanly?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104133158.3187=
525-1-luolongjuna@gmail.com?part=3D11
