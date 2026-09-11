Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031D443E069
	for <live-patching@vger.kernel.org>; Fri, 11 Sep 2026 19:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789154675; cv=none; b=o+CSodPkntp1mlpGv7Cn8dYzS54yOOLRMGT1BBXLulBNKlQuzZX/eJ1PbEKpsn+AqG3U8TqbJWv/PZQTCa5y6cFc/z3tS6FfyYWnA15cX1nwqEVP7dp5pbfdrHu/RJZo3tmCPVAK/gnVNLBzspBYdSf2WzOdFQoi29Zi5+ue0Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789154675; c=relaxed/simple;
	bh=Gl5M+oxHVuIRofi8O+Yp8RK6DnRrd9Xu18fzKc8lS5s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Y590w6ItuCbYuS2jHi9qNtgWnNzcHcxyF3u+47FZeQ8uDtVCGtou9cK1UAMaxbuvDgaJSdMDWoKerRuj3ttDLs5FYJaQVI6r0Ap7Ht9LPuPVZ6n94xX97krxShTTVFl/iq70ObZWbgYMNHFs9wlN1iCgFGo8SVSG+dgW9vahW8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tzos5XIc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tzos5XIc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 463E01F000FF;
	Fri, 11 Sep 2026 19:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789154668;
	bh=cIuHe9aFg6kS3KG86xpWOU5mOJIVmE8JRo9BYYVtxZo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Tzos5XIcS3kSSnwFF34wISvTNNB3Ju7B6KMVIfbiZnOE5knId3rPpdQ8I1S4UziWZ
	 6NSNUDL79ZqfWTMds4FOAKFxmScolzCDu+IveecN2Bb/UDtYTRRGbxUdlWlir3lSIz
	 nusfZQbLtMzBV08UVcNj8uKMgZAWEc/LEIERfJDTpN6aIJ3gH3MFjQvVEeRmBY4M4j
	 bwvnE1FhCw7P2d7vfjc23yhLHPEFvYlQGWNzYsESFqAis036nGlwxsWPLwc8ZXKXDk
	 4VOYH9G6OT+j063lGmtI/GDiQ7C5yYb7azd5wbgapbnlMjpQBXI3FYoBB/ynECkyJj
	 3eBJ7R+ehB+sQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 54/58] objtool/klp: Add test for a patch which strips a
 data annotation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Song Liu" <song@kernel.org>, live-patching@vger.kernel.org
Cc: joe.lawrence@redhat.com, mbenes@suse.cz, peterz@infradead.org, jikos@kernel.org, puranjay@kernel.org, kernel-team@meta.com, jpoimboe@kernel.org, pmladek@suse.com
In-Reply-To: <20260911185031.1534046-29-song@kernel.org>
References: <20260911184305.1457308-1-song@kernel.org>
 <20260911185031.1534046-1-song@kernel.org>
 <20260911185031.1534046-29-song@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 19:24:26 +0000
Message-Id: <20260911192427.463E01F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The test script comment references a stale, non-existent commit =
hash instead of the correct one cited in the commit message.
--

commit ebb1db72e2841f055fb71e4dbbeaab8dc57a8d05
Author: Song Liu <song@kernel.org>

objtool/klp: Add test for a patch which strips a data annotation
   =20
klp diff needs entry boundaries for a special section: either an entsize,
or ANNOTATE_DATA_SPECIAL annotations naming where each entry starts.
.static_call_sites has no entsize, so the annotations are all there is --
and a patch can remove the last one in a translation unit while leaving the
section itself in place, so that only the patched side has lost them.

> diff --git a/tools/objtool/tests/generic/test-static-call-annotate-stripp=
ed.sh b/tools/objtool/tests/generic/test-static-call-annotate-stripped.sh
> new file mode 100755
> index 0000000000000..bdbc0a21c669e
> --- /dev/null
> +++ b/tools/objtool/tests/generic/test-static-call-annotate-stripped.sh
> @@ -0,0 +1,41 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# A patch may remove the last ANNOTATE_DATA_SPECIAL in a translation uni=
t while
> +# leaving the special section it described in place.

[ ... ]

> +# The section must still be handled.  Dropping it would leave the patched
> +# function's static call unregistered; misreading its boundaries would a=
ttach
> +# the entry to the wrong code.  Either way nothing is reported at build =
time.
> +#
> +# Fixed by 5c134aadb0d9.

[Severity: Medium]
Does this comment reference a stale commit hash?

The commit message correctly cites 3de711fba73a as the fixing commit, but t=
he
script comment cites 5c134aadb0d9. Should this comment be updated to match
the commit message to ensure accurate historical traceability?

> +#
> +# Covers the same ground as corpus/x86_64/static-call-annotate-stripped =
in Joe
> +# Lawrence's klp-build unit test corpus.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911185031.1534=
046-1-song@kernel.org?part=3D54
