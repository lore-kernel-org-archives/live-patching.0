Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6A14AD7F4
	for <live-patching@vger.kernel.org>; Fri, 11 Sep 2026 19:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789154624; cv=none; b=CYiP8HB7KlHKh7kQ1vEt3algHbDe+lzZc+rYIxv7ykFlHd5YT3shFe97QcEIzHvd0TiqV4BoXVgVuSfJqBihrZh63Fmxj6e9rpUtohpMJgltVo4/zGzg3J6tWxt2y6j0gdgCoFlOWd5lM3XxOTNcKBQyQ+/HCVFGw6Ca3A2rKOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789154624; c=relaxed/simple;
	bh=2MDlruoekXLL76kxX0FDHSIMvHscwHTxZZTgMAHZuHc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tWtIXJy6xqwQmsodZCGMK/Z4U0apK2VRhNYW8e/j6kyipsU3cYqrF0dGGz3njnCbTVfB7mbWtJrfuVHbLCYTswfAhzjMrHEEb+wd2HLB2cN31zv7eGXMpA0tJNChEu+OJ22CSbqHXaiThypsi0M6xCMJAQ30UN9w2m8H4gCJjxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K3nnFduI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K3nnFduI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 067C91F000FF;
	Fri, 11 Sep 2026 19:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789154611;
	bh=EqKlftDxGUQQjJ8VR/rJUajIfnFcao+CZYOIYY7UZrM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K3nnFduIeOvXMH4u2JP5SDu/VzVXEXggleZjR5ARB862rSwQL+LEL95GDclHlYTQs
	 8MssRUG7Cg1ygd8z2WYR52aPU6IbrlmSjYEGrZUve9vbkJUnEgPBMqXoXT6/v1VLZF
	 yvwa9VnAYgkxZ4YYBUshImYzWy8gJ9PTjl5tHpH7FQNvV0bfvEPHzI0L174ZGyGteG
	 YojRTB0uTicwzcDiyScWPb0ycuMb80t2R8+5Jqn2p3K/QX/tHJ5JuY5+rw515KpDvX
	 UKDVAT8SZodBNLotpYU/+lGV39+tNHed6P5EgbnzTwYSn4BX1F2aJQAxvNtYlT5xef
	 4J3RttGXzCOGw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 47/58] objtool/klp: Add test for symbols with no
 checksum entry of their own
Reply-To: sashiko-reviews@lists.linux.dev
To: live-patching@vger.kernel.org, "Song Liu" <song@kernel.org>
Cc: joe.lawrence@redhat.com, kernel-team@meta.com, jikos@kernel.org, puranjay@kernel.org, pmladek@suse.com, mbenes@suse.cz, peterz@infradead.org, jpoimboe@kernel.org
In-Reply-To: <20260911185031.1534046-22-song@kernel.org>
References: <20260911184305.1457308-1-song@kernel.org>
 <20260911185031.1534046-1-song@kernel.org>
 <20260911185031.1534046-22-song@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 19:23:30 +0000
Message-Id: <20260911192331.067C91F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The test incorrectly checks for duplicate target addresses in `.=
discard.sym_checksum` by searching for duplicate relocation offsets (`$1`),=
 causing the duplicate check to always silently pass.
--

commit 1616f973328c423b8bf16ffbd15bb9fb6ff8d48a
Author: Song Liu <song@kernel.org>

objtool/klp: Add test for symbols with no checksum entry of their own

This commit adds a test to ensure that symbols without their own checksum
entries, like zero-length symbols or aliases, do not erroneously create
duplicate entries in .discard.sym_checksum.

> diff --git a/tools/objtool/tests/generic/test-checksum-skip.sh b/tools/ob=
jtool/tests/generic/test-checksum-skip.sh
> new file mode 100755
> index 0000000000000..a4ce1889db8f0
> --- /dev/null
> +++ b/tools/objtool/tests/generic/test-checksum-skip.sh

[ ... ]

> +# One entry per address, which is what the skipping is for.
> +dupes=3D"$(in_relocs orig.o | awk '/rela\.discard\.sym_checksum/,/^$/ {
> +		if ($1 ~ /^[0-9a-f]{8,}/) print $1
> +	 }' | sort | uniq -d)"
> +[ -z "$dupes" ] ||
> +	fail "two checksum entries for one address: $dupes"

[Severity: Medium]
Does this logic actually verify the "one entry per address" invariant?

By extracting $1 (the relocation offset) instead of the target symbol or
address, it appears this code only checks for duplicate offsets within the
section.

Since relocation offsets are inherently unique within a section, does this
mean the duplicate check will silently pass even if multiple checksum entri=
es
point to the exact same address?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911185031.1534=
046-1-song@kernel.org?part=3D47
