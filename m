Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254A01C75F9
	for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 06:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789368414; cv=none; b=HnZuURlCQMNINCxkc9FXWYa7XgXn+0uQihUy2m/PU4dDi+u3EljCo9REEJdUbh4red7oxvUqXkLBVDPJUEsWzdCAyvxU6O+QVzyhLJNNQ/9fzKVxt3VNfbNN5luolyvygBrz5UT/q0TuoUr6Xe+lmqqfx20vXN8e7glQSFw/kAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789368414; c=relaxed/simple;
	bh=eSQlDBFPtrQb62Z/Q0UAgRqNcwPyr9BubZ4Onx/sTGs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Q1qB5PMIfyy4/ne523+m45veMrASApjKG/TEhRWm+M6zsq0zZGeAO/vyng5PGKkcQQlCMkek94SrYfSGEyNbJUOuTuaJjgHmTtqVzcTi0o/VMiWhsgjGpi/dY4rqH4jXfIvmDorPLYwdkB8fLuZfvjuwZAC9//Hp2P9vp4P+qlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=krtzwufM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="krtzwufM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D9591F000FF;
	Mon, 14 Sep 2026 06:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789368412;
	bh=LEOK/NsKrnk4Eyo0VEIWUpYDjKxqj2uB6tWxgFB3Tyg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=krtzwufM9Jx9RSYlDahLK6nZSuARlGlwankrK85LcU+qm95pzF/RJ4o3OcMSQtGSL
	 vIuaSIPPt8LwqJ7UWhwisPulKgE64F05g84mXGjGsjFi/xzORBZ4rKuB5LXfC57uEq
	 eWdtywZQ9M6MVvV5SnwzIRjyM/qqyHgQT8DS6LM67SH71C6tosGpUhdmkhbpa3W3Cq
	 E/NcLTzdyNW0OmMIXfHR5VNJ7YeLBUKZQHxEr57fIEcIAOH2+DnziTAAnurH/dUFf3
	 pfiJgxXEiHfjLrnMdAQLdHXnQ4NZbhvEiLp/Ab4PPfr7eHoTFVjCYPxlBpgYt4eE74
	 8CG0QwcI5IhfQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 36/58] objtool/klp: Add test for position-independent
 checksums
Reply-To: sashiko-reviews@lists.linux.dev
To: live-patching@vger.kernel.org, "Song Liu" <song@kernel.org>
Cc: jpoimboe@kernel.org, pmladek@suse.com, joe.lawrence@redhat.com, mbenes@suse.cz, peterz@infradead.org, jikos@kernel.org, kernel-team@meta.com, puranjay@kernel.org
In-Reply-To: <20260914062514.926997-37-song@kernel.org>
References: <20260914062514.926997-1-song@kernel.org>
 <20260914062514.926997-37-song@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 06:46:51 +0000
Message-Id: <20260914064652.3D9591F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The test script incorrectly assumes that if target() moves relat=
ive to the section start, its relative displacement to callee() must have c=
hanged. This allows the test to falsely pass if the compiler shifts both fu=
nctions by the same amount.
--

commit 3328da26fa650b64515b357106fb0c92f158e5b7
Author: Song Liu <song@kernel.org>

objtool/klp: Add test for position-independent checksums
   =20
A function that only moves has not changed, and its checksum must not move
with it. This commit adds a test to verify position-independent checksums f=
or
non-relocated jumps/calls.

> diff --git a/tools/objtool/tests/generic/test-checksum-position.sh b/tool=
s/objtool/tests/generic/test-checksum-position.sh
> new file mode 100755
> index 0000000000000..459a718d75e7e
> --- /dev/null
> +++ b/tools/objtool/tests/generic/test-checksum-position.sh

[ ... ]

> +orig_off=3D"$(in_symbols orig.o    | awk '$8 =3D=3D "target" { print $2 =
}')"
> +new_off=3D"$( in_symbols patched.o | awk '$8 =3D=3D "target" { print $2 =
}')"
> +[ -n "$orig_off" ] && [ -n "$new_off" ] ||
> +	fail "target symbol not found in both objects"
> +[ "$orig_off" !=3D "$new_off" ] ||
> +	probe_skip "compiler did not move target() between builds"

[Severity: Medium]
Does this check guarantee the relative displacement between target() and
callee() actually changed?

Since the test is built with -O2 (which enables -ftoplevel-reorder) and=20
-fno-function-sections, the compiler could group globals and statics,
emitting padding() before both target() and callee(). In this case, target()
and callee() would both shift by the exact size of padding().

The script checks if target() moved relative to the section start:

    [ "$orig_off" !=3D "$new_off" ]

This would evaluate to true since target() did move, allowing the test to
proceed. However, because the relative displacement between target() and
callee() is unchanged, the encoded call displacement bytes within target()
will be identical in both builds. The checksum will trivially match without
exercising objtool's displacement-masking logic.

> +
> +assert_checksum_matches target
> +
> +pass "checksum unchanged when the function only moves"

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914062514.9269=
97-1-song@kernel.org?part=3D36
