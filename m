Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793801118;
	b=MWtkdxustgjPOw2AVXxXpTaWHmed/9tL+ki4IoxvjAjkAf70iCl5qI0LBkMXtoFHMmCj
	 FmV1z30ztkG/Whm/3nwnS19u+vfjyEBQ2ziD6WoBOPfh6lOEcUrOtjY5Q8nvAZAZMY0Q+
	 1IY4rb61FYbN385vNRTBMG442kR/tmiehOy60/nol59DmELNfsSt/QepoT3UjBosVMpyP
	 BlWpJpxvJJiB5xPBCulLVoazGA5pG8ZobOzh6tvKam00J8mdosl6BGERZTI9V0bqjTrQV
	 dFv/axMIsDNiWH7xr3IN/Wh4ju0BGrgLQ3ZiwFWTi1p0d5Cr5BVAB0vw9r2gSzA8tPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793801118;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yKJ4I/Z1LV/dulW0wEEE6+eiC9/VlOV04NXcl9PJm20=;
	b=QwgVkbTawe58T5IUUfiLC2cOBQFjktvIRPPjY6rd+WSjhwtF5sBFs6FsKhi00tkad1uT
	 ZSKDHu1h9GlMQJ9ktdltmeK+V9F4OJsjSTKYC8GChy1XIj7KOTp7mKZ2doaKefwpoTFa4
	 hbmFthYMutef/jn9RPTF54t63CGsQrHtgpOpHZl+d7NCUmOj2GvV2F6aGk4VPDdYKYdWe
	 RmZHE9FySaQZMeeCozooRROx0c/znRJHhPnHiaUUdN1O/7eWM96D5Kh5ZWECGMdOOMn4R
	 wiqyeEUbuidlj6rPQzUAHgmR+NySTW3vrbfHgoLigAYJA1eSypQYhi+QfdFMF2BbuEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="np/DndPn";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99185606A334
	for <live-patching@vger.kernel.org>; Wed,  4 Nov 2026 14:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=np/DndPn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F4851F00919;
	Wed,  4 Nov 2026 14:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793801117;
	bh=yKJ4I/Z1LV/dulW0wEEE6+eiC9/VlOV04NXcl9PJm20=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=np/DndPnzVspgt7a5xc7i1hRek5+ciBOG3+WUAhwDCpT+zrYHNS842hmX15LtAtHz
	 uDnKMk0t8nXtMMh/RVG4MDcOloyMnmDfQ1DSyKJqJjVHtd3RH4Wl0r8EsKKh3U9j2l
	 7/REDzvu6JZbozpvtChOLwUCMfXwGKCR5fXJy8RNG+WYUoIlCNY7mr4zP9kwqqzS7l
	 GXNCcP3LOJfjWPqfwsndjEHtNpgA9P6tjd7A/AaR6IVNM4yVyoSlpjmB/2pWfdST8u
	 5+2+lYXocr8TjFSx2fh4lxK37X1nM7xl0QEp5MyYHdp4fWbDrugu0n55Gvu9dQr3eC
	 ZUV+ns3BakK2g==
Message-ID: <sashiko-outbox-197389@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 09/11] objtool/klp: Extend twins through
 unchanged function references
Reply-To: sashiko-reviews@lists.linux.dev
To: "Longjun Luo" <luolongjuna@gmail.com>, jpoimboe@kernel.org, peterz@infradead.org
Cc: mbenes@suse.cz, pmladek@suse.com, joe.lawrence@redhat.com, song@kernel.org, puranjay@kernel.org, nathan@kernel.org, ndesaulniers@google.com, morbo@google.com, justinstitt@google.com, live-patching@vger.kernel.org
In-Reply-To: <20261104133158.3187525-10-luolongjuna@gmail.com>
References: <20261104133158.3187525-1-luolongjuna@gmail.com>
 <20261104133158.3187525-10-luolongjuna@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 14:05:16 +0000
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [Medium] objtool/klp: single pass in extend_twins_by_relocations() misses=
 functions
- [Medium] objtool/klp: correlate_reloc() pairs SHN_UNDEF symbols without u=
ndef checks
- [Medium] objtool/klp: logical OR guards in correlate_reloc() hide target =
mismatches
- [Medium] objtool/klp: section-symbol lookup mismatch in correlate_reloc()=
 vs checksum
- [Medium] objtool/klp: same_function_checksum() ignores function alias rep=
resentative
- [Medium] objtool/klp: correlate_reloc() does not canonicalize data alias =
symbols
--

commit 1871820aa5fdf039e6c898d41596c9459d2e3e27
Author: Longjun Luo <luolongjuna@gmail.com>

objtool/klp: Extend twins through unchanged function references

This commit extends symbol twin correlation in objtool klp diff by comparing
relocation entries of paired functions that share equal checksums and
correlating their referenced target symbols.

> diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
> index 468b8654b6871..e8252e586260d 100644
> --- a/tools/objtool/klp-diff.c
> +++ b/tools/objtool/klp-diff.c

[ ... ]

> @@ -1294,6 +1297,135 @@ static int convert_reloc_sym(struct elf *elf, str=
uct reloc *reloc)
>  	return convert_reloc_secsym_to_sym(elf, reloc);
>  }
> =20
> +static int correlate_reloc(struct elfs *e, struct symbol *func,
> +			   struct reloc *orig_reloc, struct reloc *patched_reloc)
> +{
> +	struct symbol *orig_sym, *patched_sym;
> +	unsigned long offset =3D reloc_offset(orig_reloc) - func->offset;
> +
> +	if (offset !=3D reloc_offset(patched_reloc) - func->twin->offset ||
> +	    reloc_type(orig_reloc) !=3D reloc_type(patched_reloc)) {
> +		ERROR("%s+%#lx: relocation mismatch in unchanged function", func->name=
, offset);
> +		return -1;
> +	}
> +
> +	if (reloc_type(orig_reloc) =3D=3D R_NONE ||
> +	    is_uncorrelated_section(orig_reloc->sym->sec) ||
> +	    is_uncorrelated_section(patched_reloc->sym->sec))
> +		return 0;
> +
> +	/* Section symbols have no twins; resolve the target symbol first. */
> +	if (convert_reloc_secsym_to_sym(e->orig, orig_reloc) ||
> +	    convert_reloc_secsym_to_sym(e->patched, patched_reloc))
> +		return 0;

[Severity: Medium]
Does convert_reloc_secsym_to_sym() resolve one-past-the-end section-symbol
references differently from checksum_update_insn() in
tools/objtool/klp-checksum.c?

In tools/objtool/klp-checksum.c:checksum_update_insn(), section-symbol
relocations are looked up with find_symbol_containing():

	if (is_sec_sym(sym)) {
		sym =3D find_symbol_containing(reloc->sym->sec, offset);
		if (!sym)
			goto alts;

		offset -=3D sym->offset;
	}

For a one-past-the-end reference such as arr + ARRAY_SIZE(arr) at
sym->offset + sym->len, find_symbol_containing() returns NULL and skips
hashing both the target symbol identity and the offset.

When extend_twins_by_relocations() subsequently treats the function as
unchanged, convert_reloc_secsym_to_sym() resolves sym->offset + sym->len via
find_symbol_by_offset(sec, 0) or find_symbol_containing_inclusive(). If the
referenced array's size or target changed, won't correlate_reloc() abort
patch generation with a reference offset or target mismatch error instead of
treating the function as changed?

> +
> +	orig_sym =3D orig_reloc->sym;
> +	patched_sym =3D patched_reloc->sym;
> +	if (orig_sym->dont_correlate || patched_sym->dont_correlate)
> +		return 0;

[Severity: Medium]
Can these three logical OR guards in correlate_reloc() silently hide
asymmetric relocation targets and conversion errors?

First, if only one side of the relocation pair targets an uncorrelated
section or has dont_correlate set (for example, if a .rodata section-symbol
relocation resolves via find_symbol_containing_inclusive() to a named
STT_OBJECT symbol with dont_correlate =3D=3D false on one side, while remai=
ning
an unresolved .rodata section symbol with dont_correlate =3D=3D true on the=
 other
side), returning 0 skips validation and leaves the correlatable symbol
unpaired.

Second, using || in:

	if (convert_reloc_secsym_to_sym(e->orig, orig_reloc) ||
	    convert_reloc_secsym_to_sym(e->patched, patched_reloc))
		return 0;

short-circuits converting patched_reloc when orig_reloc returns non-zero,
ignores cases where only one side fails to resolve a section symbol, and
turns a -1 error return from convert_reloc_secsym_to_sym() into 0.

[Severity: Medium]
Also in correlate_reloc(), what happens when orig_sym or patched_sym is an
SHN_UNDEF symbol?

Unlike correlate_by_identity(), extend_same_twins_by_checksum(), and
validate_symbol_twins(), correlate_reloc() does not check
is_undef_sym(orig_sym) or is_undef_sym(patched_sym), and dont_correlate is
false for SHN_UNDEF symbols. In addition, is_twin_candidate() does not reje=
ct
SHN_UNDEF symbols or mismatches in is_undef_sym():

	/* Don't match zero-length labels with sized symbols. */
	if (!is_undef_sym(sym1) && !is_undef_sym(sym2) &&
	    (!sym1->len !=3D !sym2->len))
		return false;

If an unchanged function references an external SHN_UNDEF symbol and
correlate_reloc() sets orig_sym->twin =3D patched_sym and
patched_sym->twin =3D orig_sym:

1. In klp_reloc_needed(), reference_twin(patched_sym) becomes non-NULL for =
an
   unexported undefined symbol, causing klp_reloc_needed() to return true as
   if the symbol were defined in e->orig, which then fails in
   clone_reloc_klp() / find_vmlinux_sympos() or emits a bogus KLP relocatio=
n.

2. In clone_reloc_klp(), having orig_sym non-NULL for a weak SHN_UNDEF symb=
ol
   exported by another module skips the !orig_sym check that enforces
   has_module_dep().

3. If a symbol was SHN_UNDEF on one side and defined on the other,
   is_twin_candidate() can pair the undefined symbol (checksum 0) with the
   defined symbol (non-zero checksum), causing mark_changed_functions() to
   report a false changed data error.

Should correlate_reloc() and is_twin_candidate() reject SHN_UNDEF symbols?

> +
> +	if (reloc_addend(orig_reloc) !=3D reloc_addend(patched_reloc)) {
> +		ERROR("%s+%#lx: reference offset mismatch: %s[%u]%+lld and %s[%u]%+lld=
",
> +		      func->name, offset,
> +		      orig_sym->name, orig_sym->idx, (long long)reloc_addend(orig_relo=
c),
> +		      patched_sym->name, patched_sym->idx, (long long)reloc_addend(pat=
ched_reloc));
> +		return -1;
> +	}
> +
> +	if (orig_sym->twin =3D=3D patched_sym && patched_sym->twin =3D=3D orig_=
sym)
> +		return 0;
> +
> +	if (orig_sym->twin || patched_sym->twin) {
> +		ERROR("%s+%#lx: twin conflict: orig %s[%u]->%s[%u], patched %s[%u]->%s=
[%u]",
> +		      func->name, offset,
> +		      orig_sym->name, orig_sym->idx,
> +		      orig_sym->twin ? orig_sym->twin->name : "<none>",
> +		      orig_sym->twin ? orig_sym->twin->idx : 0,
> +		      patched_sym->name, patched_sym->idx,
> +		      patched_sym->twin ? patched_sym->twin->name : "<none>",
> +		      patched_sym->twin ? patched_sym->twin->idx : 0);
> +		return -1;
> +	}
> +
> +	/* Compound target checksums are independent of their defining TU. */
> +	if (is_compound_constant(orig_sym) && is_compound_constant(patched_sym)=
) {
> +		if (!orig_sym->csum.checksum || orig_sym->len !=3D patched_sym->len ||
> +		    orig_sym->csum.checksum !=3D patched_sym->csum.checksum) {
> +			ERROR("%s+%#lx: compound content mismatch in unchanged function",
> +			      func->name, offset);
> +			return -1;
> +		}
> +	} else if (!is_twin_candidate(orig_sym, patched_sym)) {
> +		ERROR("%s+%#lx: incompatible reference targets: %s[%u] and %s[%u]",
> +		      func->name, offset, orig_sym->name, orig_sym->idx,
> +		      patched_sym->name, patched_sym->idx);
> +		return -1;
> +	}
> +
> +	orig_sym->twin =3D patched_sym;
> +	patched_sym->twin =3D orig_sym;

[Severity: Medium]
What happens in correlate_reloc() when a direct symbol relocation targets a
non-representative data alias where is_alias_sym(sym) is true?

In tools/objtool/klp-checksum.c:calculate_checksums(), symbols with
is_alias_sym(sym) are skipped, so only the representative symbol sym->alias
has a non-zero csum.checksum, and reference_twin() expects shared twins for
data objects to be stored on sym->alias:

static struct symbol *reference_twin(struct symbol *sym)
{
	if (!sym->twin && is_object_sym(sym))
		return sym->alias->twin;
	return sym->twin;
}

While convert_reloc_secsym_to_sym() resolves section symbols to sym->alias,=
 it
is a no-op when orig_reloc or patched_reloc is already a direct symbol
relocation to a non-representative alias.

If correlate_reloc() operates on non-representative data aliases directly
without canonicalizing STT_OBJECT symbols to sym->alias:

1. Pairing a non-representative alias (csum.checksum =3D=3D 0) with a
   representative symbol (csum.checksum !=3D 0) causes
   mark_changed_functions() to fail with a false changed data error.

2. Pairing two non-representative aliases leaves twin =3D=3D NULL on both
   representative sym->alias symbols, so reference_twin(sym->alias) returns
   NULL and mark_changed_functions() compares 0 =3D=3D 0 on the aliases ins=
tead
   of checking the data checksum on sym->alias.

3. If another relocation references the representative sym->alias,
   correlate_reloc() will see a false twin conflict.

[ ... ]

> +static bool same_function_checksum(struct symbol *func)
> +{
> +	/* Cold subfunctions have no separate checksum; use their parent's. */
> +	struct symbol *parent =3D func->pfunc;
> +	struct symbol *parent_twin =3D func->twin->pfunc;
> +
> +	return parent->twin =3D=3D parent_twin && parent->csum.checksum &&
> +	       parent->csum.checksum =3D=3D parent_twin->csum.checksum;
> +}

[Severity: Medium]
In same_function_checksum(), can parent->csum.checksum be 0 when a function
has an alias at the same address?

In tools/objtool/elf.c:elf_add_symbol(), when two function symbols share the
same section, offset, type, and length, the earlier symbol has sym->alias s=
et
to the later symbol while sym->pfunc remains sym. Because
calculate_checksums() in tools/objtool/klp-checksum.c skips symbols where
is_alias_sym(sym) is true:

	if (is_cold_func(sym) || is_alias_sym(sym) || !sym->len ||
	    !sym->sec || !sym->sec->data)
		continue;

the checksum is only stored on parent->alias->csum.checksum. Won't
same_function_checksum() always evaluate to false for non-representative
function aliases unless it reads the checksum from parent->alias and
parent_twin->alias?

> +
> +static int extend_twins_by_relocations(struct elfs *e)
> +{
> +	struct symbol *sym;
> +
> +	for_each_sym(e->orig, sym) {
> +		if (!is_func_sym(sym) || sym->dont_correlate || !sym->twin ||
> +		    !same_function_checksum(sym))
> +			continue;
> +		if (extend_twin_by_relocations(e, sym))
> +			return -1;
> +	}
> +	return 0;
> +}

[Severity: Medium]
Can a single linear pass in extend_twins_by_relocations() miss functions and
cold subfunctions whose twins are assigned later in the loop?

In ELF symbol tables, all STB_LOCAL symbols (including static helpers,
compiler clones, and .cold subfunctions, which have csum.checksum =3D=3D 0 =
and
are not paired by extend_same_twins_by_checksum()) appear before STB_GLOBAL
symbols, and static callees often precede their callers.

When for_each_sym(e->orig, sym) visits an unpaired local function or .cold
subfunction first, !sym->twin (or !same_function_checksum(sym) if its parent
was not yet paired) is true and the loop skips it. When a caller at a later
symbol index is processed by extend_twin_by_relocations() ->
correlate_reloc(), orig_sym->twin =3D patched_sym is assigned for that earl=
ier
function or .cold subfunction, but extend_twins_by_relocations() never
revisits it to correlate its relocations or verify its references against i=
ts
checksum.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104133158.3187=
525-1-luolongjuna@gmail.com?part=3D9
