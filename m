Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DEA3803DC
	for <live-patching@vger.kernel.org>; Fri, 11 Sep 2026 19:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789153400; cv=none; b=OgaLFG1hXCMQHrz1NTd0pYsPGwipalJCvpaWfFrRC/FcaMvmfo1EJXEeNKbBsTV5fu9u3S0brsEde0D2MSTTa0K4TI88bgoqoCA3YdNw7m9qUk4/HJ1xf69hWctb8zbuNUDo03lItVhtel8lz8TiukUen6vvCx1IB72oRA1uYZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789153400; c=relaxed/simple;
	bh=n/34ljLIxDLXl8eu+/ARwl8/bxFDZH3DpEVfTkWRtUw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dTuLAiTNrBLnPhsDinVJrI0Mk5kRqTczvVCAuJ0Cksv8QXu8GzN99f2FyDp3dQRqzDBY2ixvlEDaQGuVj/dg/eu+IyZ4MS2R5bYCIV91AHjgz3+2kTsT1/iwtlECAWzxABYUQ/DBtsI6R3les72UankNekMmLYvcTraXRSNcUA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WJSk6U+C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WJSk6U+C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D96E1F000FF;
	Fri, 11 Sep 2026 19:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789153398;
	bh=+6U/5peUDtgaFaAfpSchGAR4MlkDgbVw4jIB81BQkoY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WJSk6U+CjQkF0ZIi6ENNzTnQs+ak53r/ANhss3vXnoR4V6Fp978pEqp60lPL+Soo5
	 hzPwmROP2jG5rjfASlVcpP+zVDWKmN43/kOiLgq7LxqAVTNzvmraGvOxrM4DYE9IG9
	 ZdKsZPN5QZJZHYvnOXwgw3CZt8qm/X4/oNqTS6AXpS/YbXkbfP+AF+TBwR490KLYso
	 xeDff5CHHRxU43hKqB1suZ9YAaJKKXLYdBRlajimwHikcvZSqWcDFbbApz9hDG0zzE
	 uPhbIQ/yiwTO5HOpSnEQmu0wBTNDL9/Jbb+IPyStLyFMyKVjcGL94h2KCGyYyEsJdt
	 grl367O38fBrA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/58] objtool/klp: Grow the klp test harness vocabulary
Reply-To: sashiko-reviews@lists.linux.dev
To: "Song Liu" <song@kernel.org>, live-patching@vger.kernel.org
Cc: puranjay@kernel.org, joe.lawrence@redhat.com, kernel-team@meta.com, pmladek@suse.com, peterz@infradead.org, jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz
In-Reply-To: <20260911184305.1457308-7-song@kernel.org>
References: <20260911184305.1457308-1-song@kernel.org>
 <20260911184305.1457308-7-song@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 19:03:17 +0000
Message-Id: <20260911190318.1D96E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Symbol names containing dots act as unescaped wildcards in grep =
assertions, contradicting the commit message's goal.
- [Medium] Missing regex boundary anchors in section_relocs and assert_tomb=
stone allow partial substring or prefix matches, leading to false positives.
--

commit f3b84a0b37e33c6da0d81d19f9f2963fe5db6d2e
Author: Song Liu <song@kernel.org>

objtool/klp: Grow the klp test harness vocabulary

Assertions for what klp diff produces, and for what went into it.

The output side covers the things a livepatch is made of: cloned sections
and symbols, klp symbols and their sympos, tombstones, relocations by
section and by count, the converted .klp.rela sections and their
SHF_RELA_LIVEPATCH flag, SHN_LIVEPATCH symbols, recorded checksums, and klp
diff's own diagnostics -- a rejection for the wrong reason is not a pass.

> diff --git a/tools/objtool/tests/lib.sh b/tools/objtool/tests/lib.sh
> index 0a9da178f4dc8..a4d126e6c9cb3 100644
> --- a/tools/objtool/tests/lib.sh
> +++ b/tools/objtool/tests/lib.sh
[ ... ]
> @@ -458,7 +566,251 @@ assert_patched()
> =20
>  assert_not_patched()
>  {
> -	out_sections | grep -q "[[:space:]].text.$1[[:space:]]" &&
> +	out_sections | grep -q "[[:space:]]$(re_quote ".text.$1")[[:space:]]" &&
>  		fail "function '$1' should not have been cloned"
>  	return 0
>  }
> +
> +# section_relocs <section>
> +#
> +# The relocations against one section.  readelf prints every relocation =
section
> +# in turn, so a test asking about ".smp_locks" has to cut its block out =
of the
> +# listing first.
> +section_relocs()
> +{
> +	local sec=3D"${1//./\\.}"
> +
> +	out_relocs | awk "/rela$sec/,/^\$/"

[Severity: Medium]
Will this awk range pattern match more sections than intended?

Without a trailing anchor like '/rela$sec$/', searching for a section like
".text" might match and extract relocation blocks for both ".rela.text" and
".rela.text.unlikely".

This could cause assertions like assert_reloc_count() to inadvertently count
entries across all matched blocks.

> +}
> +
> +assert_reloc_sym()
> +{
> +	section_relocs "$1" | grep -qw -- "$2" ||

[Severity: Medium]
Does this grep command need to use re_quote() for the symbol name ($2)?

Since compilers can generate symbol names with dots (e.g., foo.isra.0), lea=
ving
the dot unescaped could allow grep to treat it as a wildcard character,
matching things like "foo_isra_0".

The commit message mentions names are quoted before reaching grep to avoid
this, but it appears some symbol assertions might be missing this quoting.

> +		fail "expected a relocation to '$2' in '$1'"
> +}
[ ... ]
> +assert_klp_sym()
> +{
> +	out_symbols | grep -q "\.klp\.sym\.${2:-[^.]*}\.$1," ||

[Severity: Medium]
Should the symbol name ($1) be escaped here as well?

An unescaped dot in the symbol name could act as a wildcard in this regular
expression, allowing false positive matches in the test harness.

> +		fail "expected klp symbol for '$1'"
> +}
> +
> +# assert_klp_sympos <symbol> <sympos>
> +#
> +# The number after the comma in .klp.sym.<object>.<symbol>,<sympos> says=
 which
> +# of several same-named symbols livepatch should resolve to, counting fr=
om 1;
> +# 0 means the name is unique and no disambiguation is needed.  Resolving=
 to the
> +# wrong one is not a load failure, it is a patch quietly wired to the wr=
ong
> +# object.
> +assert_klp_sympos()
> +{
> +	out_symbols | grep -qE "\.klp\.sym\.[^.]+\.$1,$2([[:space:]]|\$)" ||

[Severity: Medium]
Is it possible for an unescaped dot in $1 to cause false matches in this
extended regular expression?

> +		fail "expected klp symbol for '$1' with sympos $2, found:$(
> +			out_symbols | grep -o "\.klp\.sym\.[^.]*\.$1,[0-9]*" |
> +			sort -u | tr '\n' ' ')"
> +}
[ ... ]
> +assert_tombstone()
> +{
> +	out_symbols | grep -q "\.klp\.tombstone\.$1" ||

[Severity: Medium]
Could this pattern match partial symbol names?

Without a trailing word boundary or end-of-line anchor, querying for a
tombstone for "foo" might falsely succeed if a tombstone for "foo_bar"
exists.

Additionally, does $1 need to be escaped here so that dots in the symbol na=
me
are treated literally?

> +		fail "expected a tombstone for '$1'"
> +}
> +
> +assert_symbol()
> +{
> +	out_symbols | grep -qw -- "$1" ||

[Severity: Medium]
Does this direct call to grep need to escape the symbol name?

Like the other assertions, if a symbol name contains a dot, it could act
as an unescaped wildcard character here.

> +		fail "expected symbol '$1' in output"
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911185031.1534=
046-1-song@kernel.org?part=3D6
