Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D9F22A7F6
	for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 06:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789368073; cv=none; b=L9XlscBhjI0bzznobjSBGMZ7crHkHTpnGkLgaN6VapEbA1xHwzNdEdk4ni8OeM0JPrqJ5Ett23T5yj2Qyq0OLe7IKhnlo9NeWqU05ZWqtiiV5v6p2jakq2FTIUt3Xj4OoUe7sSDCB5ZEGpr3ebIf6u6psEOGt9Z5Je1rS+GfneI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789368073; c=relaxed/simple;
	bh=Fc2lcXZMvc+GZHmP6erPJZw3p+nbtX4bRV+uGoMIiDs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NKXHlk+pCWI0tmn+3lboNZoFFOeNPA3jGD2NxHWVoyfsF2M/pDxA/UxFOgaBD6/juJiGyiEU2o27YT9qlsHoiCHPiSmfpfCncOEz/jKm45GMf3hlq6mmYJnwdCP62GZ19M6YBOPcWKSynb0C/KPOYGaCaMlrW/pq7IT1Ls7dBzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a4qX5uLK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a4qX5uLK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D54991F000FF;
	Mon, 14 Sep 2026 06:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789368067;
	bh=Y82tyhRExQzxrYn/44Rddz95kBb3wXDgDqvoBZ3eFbg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a4qX5uLKIY8U7ZIzxdx4j7pEUw760ozW+XCySgogdBjVq9YKgIZp/VwJMfuS6kGrr
	 tMbw3Aw/1uM4WFk2UaGOSSK5IwingsfHZsJsraDfEn3VO3leb0KmT+TbpVt5lQuwCU
	 kUqmgugMNV6Tdc6ZgdYOk3C/VHaQvFfeBkfyQmPgAL0C1kA7Xzr6TLGhDSWKpz09ip
	 /c98GhqN6hhKdz5RLFwd24A13p9KRXrp8dToMXohwd2ItzqMrDu5y5Ffx00eNmyHDe
	 RiEmgkFO82CG5clcy/14Qrd+3ahI+CsbOoYUOE79hnwqi4Ap65mDxnJ3x3fA+hn8I8
	 og8Dvqgyv1xuQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 06/58] objtool/klp: Grow the klp test harness
 vocabulary
Reply-To: sashiko-reviews@lists.linux.dev
To: "Song Liu" <song@kernel.org>, live-patching@vger.kernel.org
Cc: joe.lawrence@redhat.com, kernel-team@meta.com, jpoimboe@kernel.org, jikos@kernel.org, puranjay@kernel.org, peterz@infradead.org, mbenes@suse.cz, pmladek@suse.com
In-Reply-To: <20260914062514.926997-7-song@kernel.org>
References: <20260914062514.926997-1-song@kernel.org>
 <20260914062514.926997-7-song@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 06:41:06 +0000
Message-Id: <20260914064106.D54991F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Regex boundary matching using `grep -qw` fails to enforce exact =
symbol name matches because GNU grep treats characters like `.` and `,` as =
non-word boundaries.
--

commit cfe07e1e9cf1d7d13ada28e3a4fcdc25e8dd8672
Author: Song Liu <song@kernel.org>

objtool/klp: Grow the klp test harness vocabulary

This commit expands the objtool livepatch test harness vocabulary by adding
assertions for both input and output objects. It validates properties like
relocations, symbols, sections, and checksums produced by klp diff.

> diff --git a/tools/objtool/tests/lib.sh b/tools/objtool/tests/lib.sh
> index 0a9da178f4dc8..40fe740821582 100644
> --- a/tools/objtool/tests/lib.sh
> +++ b/tools/objtool/tests/lib.sh
[ ... ]
> +count_input_symbols()
> +{
> +	in_symbols "$1" | awk -v n=3D"$2" '$4 =3D=3D "OBJECT" && $8 =3D=3D n' |=
 wc -l
> +}
> +
> +# re_quote <string>
> +#
> +# A string as a literal basic regular expression.  Nearly every name the=
se
> +# assertions match on contains a dot -- .text.target, .klp.rela.vmlinux =
-- and
> +# an unescaped dot matches any character, so an assertion for one sectio=
n can be
> +# satisfied by a different one whose name merely lines up.
> +re_quote() { printf '%s' "$1" | sed 's/[].[^$*\\/]/\\&/g'; }
> +
> +has_input_section() { in_sections "$1" | grep -q "[[:space:]]$(re_quote =
"$2")[[:space:]]"; }
> +has_input_symbol()  { in_symbols "$1" | grep -qw -- "$(re_quote "$2")"; }

[Severity: Medium]
Since GNU grep treats characters like dots as non-word boundaries (as accur=
ately
noted in the comment for count_input_symbols() above), won't this allow fal=
se
positive matches?=20

If a test checks for the symbol "target", couldn't this falsely match a sym=
bol
named ".text.target" or ".klp.tombstone.target"?

[ ... ]
> +assert_reloc_sym()
> +{
> +	section_relocs "$1" | grep -qw -- "$(re_quote "$2")" ||
> +		fail "expected a relocation to '$2' in '$1'"
> +}

[Severity: Medium]
Will this assertion mistakenly match base sections like ".text.unlikely" if=
 $2
is ".text", because grep -qw relies on word boundaries that do not stop at =
dots?

> +
> +assert_no_reloc_sym()
> +{
> +	section_relocs "$1" | grep -qw -- "$(re_quote "$2")" &&
> +		fail "unexpected relocation to '$2' in '$1'"
> +	return 0
> +}

[Severity: Medium]
Could this negative assertion falsely fail if a similarly-named dotted symb=
ol
is present? For example, failing to verify the absence of "foo" because
"foo.isra.0" is present.

[ ... ]
> +assert_symbol()
> +{
> +	out_symbols | grep -qw -- "$(re_quote "$1")" ||
> +		fail "expected symbol '$1' in output"
> +}

[Severity: Medium]
Can this check pass falsely if only a tombstone or section symbol like
".klp.tombstone.foo" exists when verifying the presence of "foo"?

> +
> +assert_no_symbol()
> +{
> +	out_symbols | grep -qw -- "$(re_quote "$1")" &&
> +		fail "unexpected symbol '$1' in output"
> +	return 0
> +}

[Severity: Medium]
Similar to assert_no_reloc_sym(), will this incorrectly fail if a cloned
function like "foo.isra.0" exists when asserting the removal of "foo"?

[ ... ]
> +assert_livepatch_sym()
> +{
> +	out_symbols | grep -E 'OS ?\[0xff20\]' | grep -qw -- "$(re_quote "$1")"=
 ||
> +		fail "expected '$1' to be an SHN_LIVEPATCH symbol"
> +}

[Severity: Medium]
Is this also prone to the same grep -qw boundary matching issue, potentially
causing false passes on substring matches bounded by dots or other non-word
characters?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914062514.9269=
97-1-song@kernel.org?part=3D6
