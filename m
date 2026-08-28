Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E6B1FECBA;
	Fri, 28 Aug 2026 04:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787889937; cv=none; b=HNAYydV5i22Oiml1XSz7vdrCKjVUJvGZ+VjJJjYI2DWm53qGaZ4w+xQ7pp706SKiyYksmBjQlOGVIWmk9enl2ut97CoOqPzYXCkyXVGD/CzEaLi6nXh+inaScbfSKJaJK6eXRGh6/hRu9gbcodXEcFUK+r/5Ik/sxheqMrFaAe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787889937; c=relaxed/simple;
	bh=iNvgRxO5eoN7PpmtyDZH44NgeqjHM8ARD4C9ciAZ4U4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GB0iJdwX5WKtuj/e/RNMXI6RIeCmof6dJ6PiJmsU6wHaqnRRLPXDXWFiGjp7F+jIKLoep+8QKI7AHssRujysgQMrv7836zfgG4y6ttd451Pb9N1g73+q2Dd+Fqr3Aek1dTb4/uQmgbNrg9as3402SKLmntqlzB7/OjYav5IN9yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+b6YlIz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+b6YlIz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1B3A1F000E9;
	Fri, 28 Aug 2026 04:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787889935;
	bh=BjAPMkE9+NOkfJ2kkYOUvrTT3iY+KOV+ffIHMH+8ofY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E+b6YlIzo0ybM14XDhjVvYezR/qxKVvYFMkwvLdQq6smSRzYOmLsDU4NcN7uWEcA8
	 5q+EsjOs8pASjCXKGCNiR8596KKcVh2H9dGLXoed4YVIZGftK98Zsl0Gn79v3fP4Yj
	 pgXZV+gdyr1ZDYnWzcG/9TSxfujvaCoo9NsKVCBzWJos9NnVoNTHyaJn43DhlPSzAx
	 8h6VuR5gmTxum3H3euIHSYN2RqIY6loz0mAAmYKl1G/DojM+eV/eo1s0vgX7iEvqvv
	 gD+/iQkfs/VsXXu4CEtBkiMCz5K7Ip10Cb4DcgHupc+PdaRAUYiwZvEZSWS77da8ya
	 RSbqyS176CWZA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] objtool/klp: Fix checksums for constant pool references
Reply-To: sashiko-reviews@lists.linux.dev
To: "Josh Poimboeuf" <jpoimboe@kernel.org>, x86@kernel.org
Cc: "Joe Lawrence" <joe.lawrence@redhat.com>, "Song Liu" <song@kernel.org>, "Petr
 Mladek" <pmladek@suse.com>, "Miroslav Benes" <mbenes@suse.cz>, linux-kernel@vger.kernel.org, live-patching@vger.kernel.org, "Peter
 Zijlstra" <peterz@infradead.org>
In-Reply-To: <22a92df358195864e83fb4cd16181c5faa63c489.1787889249.git.jpoimboe@kernel.org>
References: <22a92df358195864e83fb4cd16181c5faa63c489.1787889249.git.jpoimboe@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 04:05:34 +0000
Message-Id: <20260828040534.F1B3A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] Hashing 0 bytes for `.LC` constants in `.rodata` sections due =
to `sh_entsize =3D=3D 0`, leading to livepatch false negatives.
- [High] Out-of-bounds read and false positives when referencing `.LC` cons=
tants with a non-zero relocation offset.
- [Medium] The `.LC*` symbol check is bypassed for section-relative relocat=
ions.
--

commit fbe33684e2b71a1fc6c9da77412adb627592aa7f
Author: Josh Poimboeuf <jpoimboe@kernel.org>

objtool/klp: Fix checksums for constant pool references

This commit fixes false positive changed functions in livepatching caused by
changes to .LC* constant names. It does so by adding the underlying data to=
 the
checksum calculation instead of the symbol name.

> diff --git a/tools/objtool/klp-checksum.c b/tools/objtool/klp-checksum.c
> index b8e47f28997e9..359fd27616013 100644
> --- a/tools/objtool/klp-checksum.c
> +++ b/tools/objtool/klp-checksum.c
> @@ -129,6 +129,14 @@ static void checksum_update_insn(struct objtool_file=
 *file, struct symbol *func,
>  		goto alts;
>  	}
> =20
> +	if (strstarts(sym->name, ".LC")) {
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: Medium]
Will this bypass the check for section-relative relocations?

If the compiler emits a section-relative relocation (where `reloc->sym` is a
section symbol like `.rodata`) with an addend pointing to the `.LC` constan=
t,
this check will fail because the section name doesn't start with ".LC".

The code then falls through, resolves the actual `.LC` symbol via
find_symbol_containing(), and hashes its name instead of its data. Should t=
his
check be placed after is_sec_sym(sym) is processed?

> +		void *cst;
> +
> +		cst =3D sym->sec->data->d_buf + sym->offset + offset;
> +		__checksum_update_insn(func, insn, cst, sym->sec->sh.sh_entsize);
                                                        ^^^^^^^^^^^^^^^^^^^=
^^^^

[Severity: Critical]
Does this silently hash 0 bytes for non-mergeable sections like standard
`.rodata`?

Because standard sections like `.rodata` have an `sh_entsize` of 0, objtool
now hashes 0 bytes for these constants. This completely excludes the consta=
nt
from the checksum. If a vulnerable constant is fixed, the livepatch checksum
will not change, and the fix will be silently omitted.

[Severity: High]
Can this cause an out-of-bounds read and false positives when referencing
`.LC` constants with a non-zero relocation offset?

If an `.LC` constant in a section with `sh_entsize > 0` (e.g., `.rodata.cst=
8`)
is referenced via a relocation with a non-zero addend (`offset > 0`), the s=
tart
pointer `cst` is shifted forward by `offset`, but the length parameter rema=
ins
the full `sh_entsize`.

By reading `offset` bytes past the end of the constant, objtool hashes
adjacent, unrelated constants. This falsely binds the function's checksum to
unrelated data, and if the constant is at the end of the section buffer, it=
 can
cause an out-of-bounds read past the allocated `d_buf` boundary.

> +		goto alts;
> +	}
> +
>  	if (is_sec_sym(sym)) {
>  		sym =3D find_symbol_containing(reloc->sym->sec, offset);
>  		if (!sym)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/22a92df358195864e83=
fb4cd16181c5faa63c489.1787889249.git.jpoimboe@kernel.org?part=3D1
