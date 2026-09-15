Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E472DECA3
	for <live-patching@vger.kernel.org>; Tue, 15 Sep 2026 00:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789433600; cv=none; b=bAEcYB03GAJ6Tl1Ch7z9V557edgKukzdtw8kY12JJCsZff/L4Nt+6wWxnxJlBORQ4ycKxJpfwp3R56JYJ4il8GAu2lio9mOdnmPeDeMPivaAePchvHhAE1L/zp/7Pegmv1Bh94Pps9ROl2us0fPjiWTTbgo61cMYSOvxaSR6rZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789433600; c=relaxed/simple;
	bh=yhPDQOkOJKrsarlCUosVs2ON8AChCcWy5ZNmUowjCoU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CvC1+DIo4a6lnIwTRpXJUqHXlWFmlobd0O1IvkMOrrNeqgUlGeLu+GA2kJYkJaBl7j51EI72jQt7UFKYZNCfIfR46haBPcCXkoH8MAaUkXrLpKFo/ZjSB52v3zYJ299CLH2OsCLRTM1GjaY04VZ/6aIY7G8SM/5iy755aeb58sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NAya6HSQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NAya6HSQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BAA41F000FF;
	Tue, 15 Sep 2026 00:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789433599;
	bh=0fiKHYic9eyYBMdSr0jLoSFhsloEV4jSRcTORB1q6FM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NAya6HSQzmsPw5KFtfnowgamaH8uDbvBCn4EBTSo3qqntmcrT8Q7rh8Fer+TtojTu
	 aU8oCSl87dPpA/UkYmypWBch0GhFl+XaVVvKtzjZTm97kPPm0ohPoC51itP21U4o41
	 bGUt2blEU9zk37+pj4kTcya3s3vxghNWdy6B9pCtbSVQXdWYbWXwRp+hlYNxgNnz1O
	 wRIA6tg22MdOawl4uNyF/kevCQSsv8fsIU3AeDVF7cD2ICUMqxXjfSiJaoKpIJhjyg
	 0yJzW0b/5U5/4r2WNfdEZlhijc0f85/lQAKEQggChBaLSPefHrJQz4LayPbx8T9JeE
	 yKzC0oD8nEq4A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 55/58] objtool/klp: Add test for absolute and
 __ADDRESSABLE symbols
Reply-To: sashiko-reviews@lists.linux.dev
To: "Song Liu" <song@kernel.org>, live-patching@vger.kernel.org
Cc: mbenes@suse.cz, peterz@infradead.org, joe.lawrence@redhat.com, jikos@kernel.org, pmladek@suse.com, kernel-team@meta.com, puranjay@kernel.org, jpoimboe@kernel.org
In-Reply-To: <20260914230355.3422996-56-song@kernel.org>
References: <20260914230355.3422996-1-song@kernel.org>
 <20260914230355.3422996-56-song@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 00:53:18 +0000
Message-Id: <20260915005318.9BAA41F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] objtool: test suite build failure on 32-bit architectures due to=
 .quad
--

commit 8413836c45f39cb1efbf4a2f69693cc56d13f861
Author: Song Liu <song@kernel.org>

objtool/klp: Add test for absolute and __ADDRESSABLE symbols

This commit adds a test fixture and script to ensure that objtool's
livepatching features correctly handle absolute symbols and __ADDRESSABLE
pointers without failing or crashing. It uses inline assembly to emit
these structures for the test framework.

> diff --git a/tools/objtool/tests/generic/fixtures/abs_and_addressable.c b=
/tools/objtool/tests/generic/fixtures/abs_and_addressable.c
> new file mode 100644
> index 0000000000000..6392ff99af421
> --- /dev/null
> +++ b/tools/objtool/tests/generic/fixtures/abs_and_addressable.c
[ ... ]
> +int helper(int x);
> +int helper(int x) { return x + 1; }
> +
> +/* The shape of __ADDRESSABLE(helper). */
> +__asm__(".pushsection .discard.addressable, \"aw\"\n"
> +	".balign 8\n"
> +	".quad helper\n"

[Severity: Medium]
Does using ".quad" here cause a build failure on 32-bit architectures?

When running the generic klp test suite on a 32-bit host (like 32-bit x86),
the assembler cannot emit a 64-bit absolute relocation for a symbol and fai=
ls
with an error like "cannot represent relocation type BFD_RELOC_64".

Would using a pointer-sized assembly directive instead of hardcoding a 64-b=
it
directive prevent this from causing a hard failure in build_one() when
running `make tests` on 32-bit targets?

> +	".popsection\n");
> +
> +int target(int x)
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914230355.3422=
996-1-song@kernel.org?part=3D55
