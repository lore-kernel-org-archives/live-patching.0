Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3446622D4DC
	for <live-patching@vger.kernel.org>; Fri, 11 Sep 2026 19:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789154200; cv=none; b=Wo7v6fGoJvTN1o1+XUmfcXgwAFn78VE+pzVaY1c6V0ZaUs/zYpLIz+wxLdr9f/kLWdGGAWuc92z/JiNfu7T2JiJfYoN2DzbgJdetPFJwjrdyV2PpPxwTT3uWPzYi9xbQD1bCq9gs4tH09i5JgAYr2UiXV7T11213AKUX17slCBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789154200; c=relaxed/simple;
	bh=7LMYiscvny51ATXa+TbVATduq8cQYrANB0gz6ZWIOCE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GnN/LkOTcxF2W+SnOtDWlaIzz5GeJe1hGKp5vYYraSPDRKgEP5kJFa+MAb6JLKqpAAbijp3vPLfIYRvxxoVEJOBugZNpMnmfY0LTJ0BwT2lJVtXrtN+OfpNdEJrwTrD+M3P9GfEkeQBnYAvlv/N6yqMVZaWV0IL5VnDsvTXVXaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vmv6+6I3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vmv6+6I3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67A3B1F000FF;
	Fri, 11 Sep 2026 19:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789154190;
	bh=vg/utw5UACaprgVX4/YZOvQrlEXUsoZyMZBr1WmzATk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Vmv6+6I3Nh+T+QccfWXFFA28qkTb+U6i3oky6tg6BBkkTADIpknpksD8RLd2U92IC
	 nWd2i8/oM18I0p19WJoM0Su9Kvpj06uf1h2vqVZWp0w2dRuSm4Lf7TFzMw8nFGp8+o
	 jz7Vuaac09i7jMBQiXSFPJ2N+R9rGsSAsy47Io0xIdNIAqnHGXpdJSA5bJ5euxWbpC
	 1GjUbqqwhx1SbwlbowSJdV/vHp+D4YyTzUbm8tTG7LAMqV9LrFjkELLAg8YTmSgMWr
	 n6Ge61jYpInKnd8VLBWQl7Bii7ZjtJGom6+rltbXDkNBFr1oeCD7Bmz/5Qceh2eXj8
	 0KEtb3r76e2nQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 36/58] objtool/klp: Add test for position-independent
 checksums
Reply-To: sashiko-reviews@lists.linux.dev
To: "Song Liu" <song@kernel.org>, live-patching@vger.kernel.org
Cc: puranjay@kernel.org, kernel-team@meta.com, peterz@infradead.org, mbenes@suse.cz, jpoimboe@kernel.org, jikos@kernel.org, joe.lawrence@redhat.com, pmladek@suse.com
In-Reply-To: <20260911185031.1534046-11-song@kernel.org>
References: <20260911184305.1457308-1-song@kernel.org>
 <20260911185031.1534046-1-song@kernel.org>
 <20260911185031.1534046-11-song@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 19:16:28 +0000
Message-Id: <20260911191629.67A3B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The file header comment in checksum_position.c incorrectly claims t=
hat target() contains a loop, contradicting the implementation and commit m=
essage.
--

commit 142ca8573cda7b552fbe79f475cedfd122ac600a
Author: Song Liu <song@kernel.org>

objtool/klp: Add test for position-independent checksums

This commit introduces a test fixture and script to verify that a function's
checksum remains consistent when its position shifts due to other code chan=
ges.
The test uses a fixture built without function sections to verify the behav=
ior
of position-dependent checksums for non-relocated calls.

> diff --git a/tools/objtool/tests/generic/fixtures/checksum_position.c b/t=
ools/objtool/tests/generic/fixtures/checksum_position.c
> new file mode 100644
> index 0000000000000..e1362e58422b7
> --- /dev/null
> +++ b/tools/objtool/tests/generic/fixtures/checksum_position.c
> @@ -0,0 +1,45 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * A function whose position in the section changes between the two buil=
ds,
> + * without the function itself changing.
> + *
> + * PATCHED adds a function ahead of it, so target() moves.  It must be b=
uilt
> + * without -ffunction-sections, or every function sits at offset 0 of it=
s own
> + * section and nothing ever moves -- which is why the test passes
> + * -fno-function-sections.
> + *
> + * target() contains a loop, so it has a relative jump with no relocatio=
n.  The
> + * offset encoded in that instruction depends on where the function sits=
, and
> + * hashing those bytes makes the checksum move when the function does.
> + */

[Severity: Low]
Is this file header comment accurate regarding target() containing a loop?

The implementation of target() lower down in this file actually performs
relative calls to callee(), rather than containing a loop. Furthermore, the
commit message explicitly notes that a loop branch would keep the same
displacement wherever the function goes, making it unsuitable for this test.

Could this comment be updated to accurately reflect that target() uses
relative calls across to another function instead of an internal loop?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911185031.1534=
046-1-song@kernel.org?part=3D36
