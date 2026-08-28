Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04053002CF;
	Fri, 28 Aug 2026 17:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787939977; cv=none; b=aiUifqYsNrzuUw576xwADa5DieEtF00F+Rf9vaySmIZaVmrd5MPSE6aU62pLX3HjWEbck6Gfx0MtGmQWzrwMMzfvND8E1sQeLobsFkH21s7I/9jOm426DzkzEVtzYZ7/3fiZEy0Q+Lgh20v+ZcgAkoBRxdNArM81g5EejIgtOyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787939977; c=relaxed/simple;
	bh=sBlf/r2tDY1L2gNfp4v3msKFHbIQclsfAGyRILUXnZE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GQyVlIVeDLcDRiPZd48QCbH2GSy4vbgKQUBA5jUGhDUwa5LspPqRGdrZIvxMm6k9o6N7REOd7xWp0+eHyY+OSifZB6EG6VmSj6rN6mlRKtPtPimxt+e2zTj+Zxe2skTRGBakCRMBeiW6K46FgV6Q/2tuuVzXsgYGMUdC4nIWcMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cnIdti5b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cnIdti5b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA3E21F000E9;
	Fri, 28 Aug 2026 17:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787939976;
	bh=7g2sCBufoxJWpfFQQB9e8dskcNisUU9O1lsLRvOhvuk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cnIdti5buUQhW6CV8xNw6zdr1QXiKxYYpUteNd2jKun0qry3GAn7Rxw/845m3l7qX
	 ty4ht8Spj3jFNT04ELe93ERNgaYYQzYnjoAfB8FYLnoi76igk1H7/LnK3PVg9J10sx
	 0Dn+L56FHHj/B8hxJpyHZphzoO5+JcTGchCPq7TsMzohPUtlMnWbYx6jPClIyhaPGg
	 Jpd1schNrAwA2lKbsmgd0AibnOn2iRql2fxJrJghYu6X64ZLH4GFIOWe4g9T3g0TBz
	 ux+32e1mfnfDwOkvQsqjwbsINnyYpFc6juyttcX7pzEiutCj0T35FlYpIleMphz+pd
	 ut7fKYP3e2HkA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] objtool/klp: Fix checksums for constant pool
 references
Reply-To: sashiko-reviews@lists.linux.dev
To: x86@kernel.org, "Josh Poimboeuf" <jpoimboe@kernel.org>
Cc: "Petr Mladek" <pmladek@suse.com>, "Joe Lawrence" <joe.lawrence@redhat.com>, linux-kernel@vger.kernel.org, live-patching@vger.kernel.org, "Song
 Liu" <song@kernel.org>, "Miroslav Benes" <mbenes@suse.cz>, "Peter Zijlstra" <peterz@infradead.org>
In-Reply-To: <f3a9e74ceebc6475ce94bcfe985401140857814a.1787939301.git.jpoimboe@kernel.org>
References: <f3a9e74ceebc6475ce94bcfe985401140857814a.1787939301.git.jpoimboe@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 17:59:35 +0000
Message-Id: <20260828175935.AA3E21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The checksum calculation for anonymous constants does not align =
the relocation addend, potentially reading past the end of the constant and=
 out-of-bounds of the section.
--

commit 40a0e3ccdee64d957ccae4cb27dbc7318ac09355
Author: Josh Poimboeuf <jpoimboe@kernel.org>

objtool/klp: Fix checksums for constant pool references

This commit addresses false positive changed functions in livepatches by
including the underlying data of anonymous constant pool references in the
objtool checksum calculation, rather than relying on arbitrary symbol names.

> diff --git a/tools/objtool/klp-checksum.c b/tools/objtool/klp-checksum.c
> index b8e47f28997e9..ebe25f9c5260a 100644
> --- a/tools/objtool/klp-checksum.c
> +++ b/tools/objtool/klp-checksum.c

[ ... ]

> @@ -129,6 +142,14 @@ static void checksum_update_insn(struct objtool_file=
 *file, struct symbol *func,
>  		goto alts;
>  	}
> =20
> +	if (is_anonymous_const_data(sym)) {
> +		void *cst;
> +
> +		cst =3D sym->sec->data->d_buf + sym->offset + offset;
> +		__checksum_update_insn(func, insn, cst, sym->sec->sh.sh_entsize);

[Severity: Medium]
Could this result in an out-of-bounds read if the relocation addend is
unaligned?

In checksum_update_insn(), the code calculates the cst pointer by adding the
potentially unaligned offset to the symbol base, but then unconditionally
hashes a full sym->sec->sh.sh_entsize bytes.

If the compiler emits a relocation to a constant pool section with an
unaligned addend (for example, when an instruction accesses a sub-element of
a 16-byte constant), reading a full sh_entsize bytes from a mid-constant
offset could cross the section buffer boundary if this constant is at the
end of the section.

Can this lead to non-deterministic checksums by incorporating unrelated mem=
ory
into the hash, or potentially cause a segfault during the kernel build?

> +		goto alts;
> +	}
> +
>  	if (is_sec_sym(sym)) {
>  		sym =3D find_symbol_containing(reloc->sym->sec, offset);
>  		if (!sym)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/f3a9e74ceebc6475ce9=
4bcfe985401140857814a.1787939301.git.jpoimboe@kernel.org?part=3D1
