Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D521C75F9
	for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 06:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789368538; cv=none; b=CPO1PpnuhkW+Mk9B/eUA9zJ5SS4wWtb5ZcSXzejLP0mKXBlpyi6NgQq7CAcN6nzna5fuJM7mhS8xOiVwn+1G5kzsHN4IqPZXPXPiSDMorfBOCnnVmcWTRalyvBNB+UaOvVAVSgxDYOVy5D/0Wmv38KQX9FaG5jkRrKTzlBTWoCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789368538; c=relaxed/simple;
	bh=I/nw9VNrLtATpyOhZmwORNLrpBl7bGFmc4qu8T05wO0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mpHWBj448unWhhTtX8k8pn00ryLAIAn2avHuskpaYwPYHBW3gfFo99Lek79OAztFgz6CaOllFcdam7/bolw+tdAkXA2kWeAcgHInJBczssiIkAaYlKzmmlAkk2697TpZU5d/lzBYLABv+nlGs38DvK290s+xdmVybAZXjRzT6LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/QF5x40; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/QF5x40"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E15421F000FF;
	Mon, 14 Sep 2026 06:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789368537;
	bh=/NE0pz9WDSgCrJ9mPf+3jPqHwsJwqB8Qw1I9p/UlM6s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h/QF5x40jl9WcSVPDGBYPWQi2i1NYU950bP5jfhXRHNpVqvPdEM4+0XEKSgTDGqT7
	 A9nScMbU8/sGQtW14xjZRWmBAc/cCYRqOsPnYs6aIYgLZLqsW66dovHVtyuKktmgFz
	 chSxWrYU6IZDv1jN7l9PBWp/kpEzVTKvQ48zznATV7FJNv90dhzJavHsTo7h8p5qsG
	 XshGYIWeiKPUkQBE7D2IqV2j9t0CQ2v8+sAGWw1EduC48F6z0cQuxMXBJRtAbLPv2K
	 pduAQMf0Jdw03emV3qaJJWNzFqNs8Pu8u4D3E1s8Py0AexoBXDw6nE0s+btIPg0O1z
	 jSApOzbqRTfFQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 47/58] objtool/klp: Add test for symbols with no
 checksum entry of their own
Reply-To: sashiko-reviews@lists.linux.dev
To: "Song Liu" <song@kernel.org>, live-patching@vger.kernel.org
Cc: mbenes@suse.cz, jikos@kernel.org, peterz@infradead.org, jpoimboe@kernel.org, joe.lawrence@redhat.com, pmladek@suse.com, kernel-team@meta.com, puranjay@kernel.org
In-Reply-To: <20260914062514.926997-48-song@kernel.org>
References: <20260914062514.926997-1-song@kernel.org>
 <20260914062514.926997-48-song@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 06:48:56 +0000
Message-Id: <20260914064856.E15421F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The generic check for duplicate addresses in the test script uses s=
ymbol names instead of actual addresses (symbol value + addend).
--

commit 8da269007d7ca99a4b81784ec070f665fec2ad95
Author: Song Liu <song@kernel.org>

objtool/klp: Add test for symbols with no checksum entry of their own

This commit adds a test script and a C fixture to verify that objtool
correctly skips checksum entries for zero-length, alias, and cold-part
symbols. It ensures that the invariant of one entry per address in
.discard.sym_checksum is maintained.

> diff --git a/tools/objtool/tests/generic/test-checksum-skip.sh b/tools/ob=
jtool/tests/generic/test-checksum-skip.sh
> new file mode 100755
> index 0000000000000..6e3e7055d31c3
> --- /dev/null
> +++ b/tools/objtool/tests/generic/test-checksum-skip.sh
> @@ -0,0 +1,72 @@
[ ... ]
> +
> +# entries_for <object>
> +#
> +# The symbol names .discard.sym_checksum has an entry for, one per line.
> +entries_for()
> +{
> +	in_relocs "$1" | awk '/rela\.discard\.sym_checksum/,/^$/ {
> +		if ($1 ~ /^[0-9a-f]{8,}/) print $5
> +	}'
> +}
> +
> +entries=3D"$(entries_for orig.o)"
> +
[ ... ]
> +
> +# One entry per address, which is what the skipping is for.
> +dupes=3D"$(entries_for orig.o | sort | uniq -d)"
> +[ -z "$dupes" ] ||
> +	fail "two checksum entries for one address: $dupes"

[Severity: Low]
Does this generic uniqueness check correctly identify duplicate addresses?

Since entries_for() extracts only the symbol name (column 5 of the readelf
output), this check doesn't seem to evaluate the actual resolved address
(symbol value + addend).

Wouldn't it fail to detect two different symbols mapping to the same addres=
s,
or potentially fail spuriously if multiple static functions share a section
symbol with different addends?

Since this is a test script with a tightly controlled C fixture (without
static functions) and the alias case is explicitly tested beforehand, it
doesn't break this specific test case. However, should the check be updated
to use actual resolved addresses instead of just symbol names?

> +
> +pass "zero-length symbols and aliases get no checksum entry of their own"

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914062514.9269=
97-1-song@kernel.org?part=3D47
