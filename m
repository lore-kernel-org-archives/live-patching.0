Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073DD43C079
	for <live-patching@vger.kernel.org>; Wed, 16 Sep 2026 21:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789595032; cv=none; b=pw4MDWCM4/XYf/accg7OW6ZWAwW6dQ8EmKtXQ8AaEQbx/DnjQN2aAKucWbWKV0JGZz9aP1V177hZmRQdk++FrO2vyIcKEcl7FapqnOuDyahuduRRum3KZrzQfugtD51nNtLbbsXbgqJBQwrEfrvfENYnoyIt8yUvhRmGujNK/rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789595032; c=relaxed/simple;
	bh=o4+eywqrJTa0iuIehKK90ddh1dCNUQEeFrWibET8/b0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pMQNX5aFp/PBIOtCwWUR3BDeHSd70gY1XkCt4LIr4+NI7R66ffxa7or5hZAhtvk0EsRU4C6zmpvMztxa1/Ld6nuHHy5XMYSVDjAmgkTNSmnmzkMHCCF8CmoDJL90kQ0XJxpUM5rg3tKS4oE79POExCB9uXPDROL7y4YnQ78sqQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lUXx1E5v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lUXx1E5v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C2611F0089D
	for <live-patching@vger.kernel.org>; Wed, 16 Sep 2026 21:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789595016;
	bh=RpJnpWIk4t1KPGvhvyDwJQvc8NMwgqW6dfWaW75MdMo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=lUXx1E5v7vyUD0QjXsxFJHA6TGOqKfjGC1SrQBn41NfRDnnAwsJ7I3SjJVNdvTxho
	 8F57FqNF+2+h2Skw5+Mxe+Z2eLTlyTIb8e3F277J+eBIe9hnif3hEr5W4NwXePUwo6
	 jRramiBn2xiVOHBiq843egKLWf/RF/C8bwh44Dttcx/CvKhy74IDj30ipvip9Sm8vF
	 mXvFKtKPXDi6NcsA3oyOfg1pBljch0axTKyWLsM7Or+gmK8WU23LtmrIkBTZz3rn1O
	 DzwwqPUOySt7uTT3oX7KgdgNpzgca0oIqQ32CElJL/c3PAfFbI2nKVjt7jkQ1TzVP/
	 WzxVcDuA5wdzA==
Received: by mail-qk2-f41.google.com with SMTP id af79cd13be357-93910ad2273so18504885a.0
        for <live-patching@vger.kernel.org>; Wed, 16 Sep 2026 14:43:36 -0700 (PDT)
X-Gm-Message-State: AFuF++lTZtpx5428yEqbli71eVgPFK2O844jTEyFmxWiVjZlKfQSbSA7
	ua7+4Cvf85L+5pEsuLIo5jXbrqCQiNao6zYLgtMxGFjCI67BIZpOFA+GBa6tvUcFr4nZxyDBImW
	v0lGAFGzoBL0HMTQWkT30b5RK8y2pZkY=
X-Received: by 2002:a05:620a:4722:b0:93a:2e8:5af5 with SMTP id
 af79cd13be357-93bb76c1537mr720903985a.6.1789595015629; Wed, 16 Sep 2026
 14:43:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916184351.2720310-1-song@kernel.org> <20260916184351.2720310-37-song@kernel.org>
 <20260916190111.0E2BB1F000FF@smtp.kernel.org>
In-Reply-To: <20260916190111.0E2BB1F000FF@smtp.kernel.org>
From: Song Liu <song@kernel.org>
Date: Wed, 16 Sep 2026 14:43:23 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4zYr+nP=YMQvxmL7mOjqErZh3u43dJ==QZMNQV99+g9Q@mail.gmail.com>
X-Gm-Features: AcwNN1V-FOiVO06ZstLil1Pbq9ulNPltERwAQx8tcN0eysuLxe5_gIjDs9iIqMA
Message-ID: <CAPhsuW4zYr+nP=YMQvxmL7mOjqErZh3u43dJ==QZMNQV99+g9Q@mail.gmail.com>
Subject: Re: [PATCH v5 36/58] objtool/klp: Add test for position-independent checksums
To: sashiko-reviews@lists.linux.dev, jpoimboe@kernel.org
Cc: live-patching@vger.kernel.org, puranjay@kernel.org, jikos@kernel.org, 
	kernel-team@meta.com, mbenes@suse.cz, joe.lawrence@redhat.com, 
	peterz@infradead.org, pmladek@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 12:01=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Low] objtool/klp: test script comments mismatch C fixture implementati=
on
> --
>
> commit 7722f94b411608f4277261adb44a750295859754
> Author: Song Liu <song@kernel.org>
> Date:   Wed Sep 16 18:43:29 2026 +0000
>
>     objtool/klp: Add test for position-independent checksums
>
>     A function that only moves has not changed, and its checksum must not=
 move
>     with it. Otherwise every patch reports as changed everything that shi=
fted
>     because something ahead of it grew.
>
> > diff --git a/tools/objtool/tests/generic/test-checksum-position.sh b/to=
ols/objtool/tests/generic/test-checksum-position.sh
> > new file mode 100755
> > index 0000000000000..d05e28014e1e6
> > --- /dev/null
> > +++ b/tools/objtool/tests/generic/test-checksum-position.sh
> > @@ -0,0 +1,50 @@
> > +#!/bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
>
> [ ... ]
>
> > +# A jump or call without a relocation encodes its target as an offset =
from the
> > +# instruction.  Hashing those bytes makes the checksum change whenever=
 anything
> > +# ahead of the function changes size -- so an unrelated edit elsewhere=
 in the
> > +# file reports this function as changed too, and the patch grows to in=
clude it
> > +# and everything it references.  Nothing fails; the livepatch is just =
larger and
> > +# riskier than the patch it came from.
> > +#
> > +# Here the "patch" adds a function ahead of target() and changes nothi=
ng else.
>
> [Severity: Low]
> Is this comment accurate given that the C fixture uses __attribute__((ali=
gned(64)))
> instead of adding a new function?
>
> It appears the C code in checksum_position.c explicitly states that PATCH=
ED
> changes the distance by aligning the functions rather than by inserting a
> function between them.
>
> > +
> > +. "$(dirname "$0")/../lib.sh"
> > +
> > +setup
> > +
> > +# -fno-function-sections, or each function is at offset 0 of its own s=
ection
> > +# and target() never moves.
> > +build_pair checksum_position.c -fno-function-sections
> > +
> > +assert_input_symbol target
> > +
> > +# The fixture is only meaningful if target() actually moved.
> > +# What has to change is the displacement target's calls encode, and th=
at is
> > +# the distance to callee() -- not target's own offset.  A compiler whi=
ch put
> > +# the added function ahead of both would move target and leave the dis=
tance
>
> [Severity: Low]
> Does this explanation still apply?
>
> Like the comment above, this seems to continue explaining the mechanism b=
ased
> on an obsolete added function approach rather than the alignment approach
> documented in the C fixture.
>
> > +# alone, and then the bytes are identical and the checksum matches for=
 the
> > +# uninteresting reason.  Ask about the distance.
> > +sym_off()   # $1 object, $2 symbol
> > +{
> > +     in_symbols "$1" | awk -v n=3D"$2" '$NF =3D=3D n { print $2; exit =
}'
> > +}
> > +
> > +orig_t=3D"$(sym_off orig.o target)";    orig_c=3D"$(sym_off orig.o cal=
lee)"
> > +new_t=3D"$(sym_off patched.o target)";  new_c=3D"$(sym_off patched.o c=
allee)"
> > +
> > +[ -n "$orig_t" ] && [ -n "$orig_c" ] && [ -n "$new_t" ] && [ -n "$new_=
c" ] ||
> > +     fail "target or callee missing from one of the objects"
> > +
> > +orig_gap=3D$(( 16#$orig_t - 16#$orig_c ))
> > +new_gap=3D$((  16#$new_t  - 16#$new_c ))
> > +[ "$orig_gap" !=3D "$new_gap" ] ||
> > +     probe_skip "this compiler moved target() and callee() together;" =
\
>
> [Severity: Low]
> Should this skip message be updated as well?
>
> It implies the functions were moved together by compiler reordering, as i=
n the
> added function approach, rather than reacting to the alignment directive =
used
> in the C fixture.

Good catch here. We missed these comments/messages.

Josh,

Would you mind folding the following change in while applying the patches,
so that I don't have to spam the list again?

Thanks,
Song

diff --git c/tools/objtool/tests/generic/test-checksum-position.sh
w/tools/objtool/tests/generic/test-checksum-position.sh
index d05e28014e1e..5ae759e719eb 100755
--- c/tools/objtool/tests/generic/test-checksum-position.sh
+++ w/tools/objtool/tests/generic/test-checksum-position.sh
@@ -10,7 +10,9 @@
 # and everything it references.  Nothing fails; the livepatch is just
larger and
 # riskier than the patch it came from.
 #
-# Here the "patch" adds a function ahead of target() and changes nothing e=
lse.
+# Here the "patch" moves target() away from callee() and changes nothing e=
lse:
+# both are aligned to 64 in the patched build, which shifts them apart wit=
hout
+# touching a byte of either.  See the fixture for why it is done that way.

 . "$(dirname "$0")/../lib.sh"

@@ -22,12 +24,11 @@ build_pair checksum_position.c -fno-function-sections

 assert_input_symbol target

-# The fixture is only meaningful if target() actually moved.
-# What has to change is the displacement target's calls encode, and that i=
s
-# the distance to callee() -- not target's own offset.  A compiler which p=
ut
-# the added function ahead of both would move target and leave the distanc=
e
-# alone, and then the bytes are identical and the checksum matches for the
-# uninteresting reason.  Ask about the distance.
+# The fixture is only meaningful if the displacement target's calls encode
+# actually changed, and that is the distance to callee() -- not target's o=
wn
+# offset.  A compiler which shifted the two by the same amount would move
+# target and leave the distance alone, and then the bytes are identical an=
d
+# the checksum matches for the uninteresting reason.  Ask about the distan=
ce.
 sym_off()   # $1 object, $2 symbol
 {
        in_symbols "$1" | awk -v n=3D"$2" '$NF =3D=3D n { print $2; exit }'
@@ -42,8 +43,8 @@ new_t=3D"$(sym_off patched.o target)";
new_c=3D"$(sym_off patched.o callee)"
 orig_gap=3D$(( 16#$orig_t - 16#$orig_c ))
 new_gap=3D$((  16#$new_t  - 16#$new_c ))
 [ "$orig_gap" !=3D "$new_gap" ] ||
-       probe_skip "this compiler moved target() and callee() together;" \
-                  "the call displacement did not change"
+       probe_skip "this compiler kept target() and callee() the same
distance" \
+                  "apart; the call displacement did not change"

 assert_checksum_matches target
