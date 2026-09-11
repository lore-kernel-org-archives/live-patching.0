Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726D4414416
	for <live-patching@vger.kernel.org>; Fri, 11 Sep 2026 19:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789154465; cv=none; b=CmmCg6XyJaQDU2EVPh/GdFLByrKGeZi6NeeNiB5Vm/8hUm6vJ9A4Wu/UtKv1GfqTxcsoehnXSayLiGliFY6NoXvKhDZ61k/DiCkKwNU//WqMlnf7tp+zeashQsA/k1SBsBJOaZiQdPldZ09OTjKC1MOefLLCz0cg+ytWQk4py2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789154465; c=relaxed/simple;
	bh=fnYZZ+uJheCTEC/e8juT4Q1e5IkAYNUvE4jhrI1u+eY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RvUKqmsKaUsn/3txhEjNn3Wq+iLAcdDsVmR0YTWFr1CsnkTXAwYiKTQsK2CV/NlcWmMznkFA1J3hxcTbY2Fbc1iA2Fok0w9G/mv6vJjk2+rSft6XVGKNoZ/qG2ro+qvdqCwNJDg9mP8U7S1qKoPsiUsLN62SLDWD8zJMsvAd2I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EYoqrRrJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EYoqrRrJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B73431F000FF;
	Fri, 11 Sep 2026 19:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789154452;
	bh=m3B/+iqnkqRv5WsaO88VJ903dSXWuPxX/rFyZz1O6HY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EYoqrRrJV1vylT29DywRa8ubr+wGUSF3EfNkhkMDzUBZvilspk/bRDkJUsoIVaxxT
	 SCw0SO+9ZzE++KV1jn5WyZeOQchf9V37m53py6I5nCLj2Cf+QmIEtwxvNiPzdiS1wo
	 mErWN+V0k6WHO1wMkCMxM5ZiAt5usEOkd7g9RVHjQKbcsQwTJyteCk+IdxKiUudG+G
	 C4u+7Nfpc7mg51HGx4L6pmbhXos43+IpEQEJZgMCML3yjt6aAYdRwHEdjI4T0n/qBs
	 pc+0QEFIOauy8rCToJ5C+XsGV+V/FV1BbZzp0Mx2WHcePWBglo4Wfg72RHu6oGvg2m
	 CgU7mwdwTOGxA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 40/58] objtool/klp: Add test for __bug_table, __ex_table
 and __mcount_loc extraction
Reply-To: sashiko-reviews@lists.linux.dev
To: "Song Liu" <song@kernel.org>, live-patching@vger.kernel.org
Cc: joe.lawrence@redhat.com, kernel-team@meta.com, mbenes@suse.cz, pmladek@suse.com, peterz@infradead.org, jikos@kernel.org, puranjay@kernel.org, jpoimboe@kernel.org
In-Reply-To: <20260911185031.1534046-15-song@kernel.org>
References: <20260911184305.1457308-1-song@kernel.org>
 <20260911185031.1534046-1-song@kernel.org>
 <20260911185031.1534046-15-song@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 19:20:51 +0000
Message-Id: <20260911192051.B73431F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Test assertion for filtering unpatched functions evaluates vacuousl=
y because the control function emits no special section entries.
--

commit 0a4615bf68e772413ad07a598da719d764e4517c
Author: Song Liu <song@kernel.org>

objtool/klp: Add test for __bug_table, __ex_table and __mcount_loc extracti=
on
   =20
This commit adds a test suite for extracting entries from three special
sections using klp diff. The test verifies that patched functions retain
their entries while unpatched functions do not.

> diff --git a/tools/objtool/tests/x86/fixtures/special_sections.c b/tools/=
objtool/tests/x86/fixtures/special_sections.c
> index 0000000000000..ad447e679bf82
> --- /dev/null
> +++ b/tools/objtool/tests/x86/fixtures/special_sections.c
[ ... ]
> +static const char __modinfo[]
> +	__attribute__((section(".modinfo"), used, aligned(1))) =3D "\0name=3Dvm=
linux";
> +
> +int other(int x)
> +{
> +	return x + 9;
> +}

[Severity: Low]
Does this control function emit the necessary entries to properly test
filtering?

The other() function in tools/objtool/tests/x86/fixtures/special_sections.c
is used as the unpatched control case, but it lacks the inline assembly to =
emit
a SPECIAL_SEC entry. Consequently, it generates no special section entries =
in
the input object file.

[ ... ]
> diff --git a/tools/objtool/tests/x86/test-special-sections.sh b/tools/obj=
tool/tests/x86/test-special-sections.sh
> index 0000000000000..8dfaa4fc9a360
> --- /dev/null
> +++ b/tools/objtool/tests/x86/test-special-sections.sh
[ ... ]
> +	# Extracted, and pointing at the function that was patched.
> +	assert_section "$sec"
> +	assert_reloc_sym "$sec" target
> +	assert_patched target
> +
> +	# Nothing belonging to the function that was not.
> +	assert_not_patched other
> +	assert_no_reloc_sym "$sec" other

[Severity: Low]
Will this negative test evaluate vacuously?

When running tools/objtool/tests/x86/test-special-sections.sh, the test
executes assert_no_reloc_sym "$sec" other.

Because the unpatched function other() lacks special section entries in the
input object file, there are no input relocations referencing other() for
klp diff to filter out.

This assertion will pass even if the tool's filtering logic is broken and
copies all entries to the output, missing the intended verification.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911185031.1534=
046-1-song@kernel.org?part=3D40
