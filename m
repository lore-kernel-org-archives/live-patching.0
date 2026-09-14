Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E37343899
	for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 06:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789367993; cv=none; b=jIMmSvA/8sMpsdRInQnAyO3JIVrs3MuLj5xSIrNeBfQ2lckjshI8FMHIEY/z8y6G+wJKkvlJUXjAlGOhHfzkyEaodLHaW9aSygDy4zgTiLLAklSbIwn9bUKVfPYO5rYUyLPT3CWLcT0xKv2JkVQDtKClsDJHjn3ItNJtAKcWfQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789367993; c=relaxed/simple;
	bh=zf5XTd//YUHQEgsRcrxNDSuOYckdrpV59UA6aKhqAYk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tIURKdHwTv/JgkjNsx29XxmwrlhYSuv5D7gMMUwU8vUTj7/FklIIPdvEBzpdI8+thN0VfGnTOB9qQM22PfYcH15r/rXWr9JN3egGF5Zvu7h4sH8OyHba2vWegFt3FASadTPfayMzHOKyG81WHwK7SiyYKrfDEHBh91xeedGCL2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aITIIYme; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aITIIYme"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE1F21F000FF;
	Mon, 14 Sep 2026 06:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789367991;
	bh=1Adbq3MugSiJ2n66lF+Lv6oSe0zl6VGGTiWbN8hJefM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aITIIYmefFCGzJhM2sGpPT5OT6A6VE4MtxoASEq5aezAGfioqLWrhrbjJyoXIrgrm
	 ZSHWCX8+X7w2TfRYKb4E6B7ItvcBSH5FRcTdC12JSDEVS/UBCzRKAJlnAUEeTARiOJ
	 oMi4grrqPEh4lmPAGTliGOfcWSGxwkQZLmu+M+Qk8v/xPZagz5iijUSRjMGHZsVrop
	 rDb8pUqs1k46vRRM07PmpUbVzESZqzsLfPbbUd4M1aqPaH2KygDKJ6bnCRbQDi9PcA
	 W+xle2VoheXvbE6UpBmlANtd7kwC0udb+H0ydNeFxv2pg/s2wsSRhBUnUID1gXpd/9
	 J70oWdCulUElA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/58] objtool/klp: Classify klp test outcomes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Song Liu" <song@kernel.org>, live-patching@vger.kernel.org
Cc: mbenes@suse.cz, puranjay@kernel.org, joe.lawrence@redhat.com, kernel-team@meta.com, jikos@kernel.org, jpoimboe@kernel.org, peterz@infradead.org, pmladek@suse.com
In-Reply-To: <20260914062514.926997-5-song@kernel.org>
References: <20260914062514.926997-1-song@kernel.org>
 <20260914062514.926997-5-song@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 06:39:50 +0000
Message-Id: <20260914063950.CE1F21F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Literal `$'\n'` string is appended instead of a newline character d=
uring TAP output manipulation.
--

commit df7f112de2ce31cfbac30c00e5d997457d3c2710
Author: Song Liu <song@kernel.org>

objtool/klp: Classify klp test outcomes
   =20
This commit introduces better classification of test outcomes for objtool k=
lp
tests, distinguishing between different types of skips (declared, probe,
undeclared) and TAP directives (xfail, xpass). It modifies the test runner =
to
explicitly handle these cases and improve result reporting.

> diff --git a/tools/objtool/tests/run-tests.sh b/tools/objtool/tests/run-t=
ests.sh
> index 48728a98d9950..6b937fc7f5bda 100755
> --- a/tools/objtool/tests/run-tests.sh
> +++ b/tools/objtool/tests/run-tests.sh
[ ... ]
> @@ -23,31 +61,99 @@ cd "$(dirname "$0")" || exit 1
[ ... ]
> +	case "$result" in
> +	*"# SKIP (declared)"*)	static_skip=3D$((static_skip + 1)) ;;
> +	*"# SKIP (probe)"*)	probe_skip=3D$((probe_skip + 1)) ;;
> +	*"# SKIP"*)
> +		# An undeclared skip: the test gave up for a reason it never
> +		# said it might.  That is a hole, not an expected outcome.
> +		#
> +		# Replace the line rather than adding one.  Every test owes the
> +		# plan exactly one result, and a consumer counting them is
> +		# entitled to say so when the totals disagree.
> +		rest=3D"$rest${rest:+$'\n'}was: $result"

[Severity: Low]
Does this append a literal dollar sign and single quotes instead of a newli=
ne?

When a test fails via an undeclared skip and has already produced other out=
put,
the test runner attempts to append a newline to the rest string. Due to Bas=
h's
double-quoting rules, the $'\n' syntax is not expanded inside double quotes=
 and
is instead appended as literal characters. This can garble the terminal out=
put.

> +		result=3D"not ok - $(basename "$t" .sh): undeclared skip"
> +		result=3D"$result (use gcc_only/clang_only or require_input_*)"
> +		fail=3D$((fail + 1)) ;;
> +	"not ok"*"# TODO"*)	xfail=3D$((xfail + 1)) ;;
> +	"ok"*"# TODO"*)		xpass=3D$((xpass + 1)) ;;
> +	"not ok"*)		fail=3D$((fail + 1)) ;;
> +	"ok"*)			pass=3D$((pass + 1)) ;;
> +	*)
> +		# No result line at all: the test died before reporting.
> +		rest=3D"$rest${rest:+$'\n'}exited $rc without a result line"

[Severity: Low]
Is it possible this will also append literal characters rather than a newli=
ne
when a test dies without outputting a valid TAP result line?

> +		result=3D"not ok - $(basename "$t" .sh): no TAP result"
> +		fail=3D$((fail + 1)) ;;
> +	esac

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914062514.9269=
97-1-song@kernel.org?part=3D4
