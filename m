Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D844B8277
	for <live-patching@vger.kernel.org>; Wed, 16 Sep 2026 19:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789585297; cv=none; b=Qz7HRQOAAwh3UE2Ti5D+dv3JtvM+fl2MJO9HlAnMcnQw06ruHiImqvjkpggz6kCealS+9aEXd4VbYO3k4zTv4ESE9WAt6BML+Bhe5eS5vy3q0SUSbKDLzh3xBDvqNYxwNe3iGoFg2GBaYfW8QDyW8FPWovVbLLMa0F7xEw7wIYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789585297; c=relaxed/simple;
	bh=frMimxF0Atw1uref8uoEimgrMY2lR/5H2FQn10wRY1E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GGjubsxKZIyZ0KL/C7M+0mGz/DhyX3Jspw0RRmXteda9UTqjs2X1ntQOkC+8zLcFVEocEQvIstC/ajEGlkR6iWGCFKt8GbKOjFVvCU4IrJK8pKpjpunb6LFfgdWWrqgy0KtrPkFJMfEJozp/dU5moIWD1CnigL2e8wBDOyt9c90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H2TPhuyQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H2TPhuyQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E2BB1F000FF;
	Wed, 16 Sep 2026 19:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789585271;
	bh=36irhmr3docr9YeEKATEz7/R+vF1ghB+/zOZwCrt1NU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H2TPhuyQUd8ApCpsKnIMPSLYX3ERR4sY5VY4fQBSlK4X3X797bgv4wrSn5BehFbVp
	 BEQCRkCOY9ctdLyINTzh80zCf+XLiOttZ8BZ5GwQy8S5uMjP+eTfj2q0FEb5/QRv4u
	 a7JWPk73zdGs4/22FfmQdSwqX5+r9TZxVd3p/GBJvJF5MGI6erRPvkZNNh+ciChmPo
	 9ZV9aACsVKXZeWiahYtay/JzZD8H6TMLVavw8T2G3a8TRNuxBF6VraUGiwA9wnBTQF
	 2n+lJCU2PKsT9lkuTUgv3D592PEfP/Mj4v6BgiC6sZfUy08HCejNBB4ESlDq47jFVM
	 sJ4vs4/KP/ifg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 36/58] objtool/klp: Add test for position-independent
 checksums
Reply-To: sashiko-reviews@lists.linux.dev
To: "Song Liu" <song@kernel.org>, live-patching@vger.kernel.org
Cc: puranjay@kernel.org, jikos@kernel.org, kernel-team@meta.com, jpoimboe@kernel.org, mbenes@suse.cz, joe.lawrence@redhat.com, peterz@infradead.org, pmladek@suse.com
In-Reply-To: <20260916184351.2720310-37-song@kernel.org>
References: <20260916184351.2720310-1-song@kernel.org>
 <20260916184351.2720310-37-song@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 19:01:10 +0000
Message-Id: <20260916190111.0E2BB1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] objtool/klp: test script comments mismatch C fixture implementation
--

commit 7722f94b411608f4277261adb44a750295859754
Author: Song Liu <song@kernel.org>
Date:   Wed Sep 16 18:43:29 2026 +0000

    objtool/klp: Add test for position-independent checksums
   =20
    A function that only moves has not changed, and its checksum must not m=
ove
    with it. Otherwise every patch reports as changed everything that shift=
ed
    because something ahead of it grew.

> diff --git a/tools/objtool/tests/generic/test-checksum-position.sh b/tool=
s/objtool/tests/generic/test-checksum-position.sh
> new file mode 100755
> index 0000000000000..d05e28014e1e6
> --- /dev/null
> +++ b/tools/objtool/tests/generic/test-checksum-position.sh
> @@ -0,0 +1,50 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0

[ ... ]

> +# A jump or call without a relocation encodes its target as an offset fr=
om the
> +# instruction.  Hashing those bytes makes the checksum change whenever a=
nything
> +# ahead of the function changes size -- so an unrelated edit elsewhere i=
n the
> +# file reports this function as changed too, and the patch grows to incl=
ude it
> +# and everything it references.  Nothing fails; the livepatch is just la=
rger and
> +# riskier than the patch it came from.
> +#
> +# Here the "patch" adds a function ahead of target() and changes nothing=
 else.

[Severity: Low]
Is this comment accurate given that the C fixture uses __attribute__((align=
ed(64)))
instead of adding a new function?

It appears the C code in checksum_position.c explicitly states that PATCHED
changes the distance by aligning the functions rather than by inserting a
function between them.

> +
> +. "$(dirname "$0")/../lib.sh"
> +
> +setup
> +
> +# -fno-function-sections, or each function is at offset 0 of its own sec=
tion
> +# and target() never moves.
> +build_pair checksum_position.c -fno-function-sections
> +
> +assert_input_symbol target
> +
> +# The fixture is only meaningful if target() actually moved.
> +# What has to change is the displacement target's calls encode, and that=
 is
> +# the distance to callee() -- not target's own offset.  A compiler which=
 put
> +# the added function ahead of both would move target and leave the dista=
nce

[Severity: Low]
Does this explanation still apply?

Like the comment above, this seems to continue explaining the mechanism bas=
ed
on an obsolete added function approach rather than the alignment approach
documented in the C fixture.

> +# alone, and then the bytes are identical and the checksum matches for t=
he
> +# uninteresting reason.  Ask about the distance.
> +sym_off()   # $1 object, $2 symbol
> +{
> +	in_symbols "$1" | awk -v n=3D"$2" '$NF =3D=3D n { print $2; exit }'
> +}
> +
> +orig_t=3D"$(sym_off orig.o target)";    orig_c=3D"$(sym_off orig.o calle=
e)"
> +new_t=3D"$(sym_off patched.o target)";  new_c=3D"$(sym_off patched.o cal=
lee)"
> +
> +[ -n "$orig_t" ] && [ -n "$orig_c" ] && [ -n "$new_t" ] && [ -n "$new_c"=
 ] ||
> +	fail "target or callee missing from one of the objects"
> +
> +orig_gap=3D$(( 16#$orig_t - 16#$orig_c ))
> +new_gap=3D$((  16#$new_t  - 16#$new_c ))
> +[ "$orig_gap" !=3D "$new_gap" ] ||
> +	probe_skip "this compiler moved target() and callee() together;" \

[Severity: Low]
Should this skip message be updated as well?

It implies the functions were moved together by compiler reordering, as in =
the
added function approach, rather than reacting to the alignment directive us=
ed
in the C fixture.

> +		   "the call displacement did not change"
> +
> +assert_checksum_matches target
> +
> +pass "checksum unchanged when the function only moves"

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916184351.2720=
310-1-song@kernel.org?part=3D36
