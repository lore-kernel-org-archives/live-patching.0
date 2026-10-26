Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793013279;
	b=MIcTIt6kXSBwAh78xfaHHhICzo2F+7MNjMTNWPez0292NvYXmgwsX+zDaKXCEp3UsKVZ
	 MuKzC/9QO2wAucNgFxJq78MQZVy7wo0YLn3UE4l8J0YvjOGnI5K2FkIrQ+umKNaIst1Z2
	 D6WbprHtFgnR4WBsv8XRz/64t9NRB20mZeqgwnWrAzqTNRX5XCTRQD5PvGGgC0Zf6YLsb
	 QpsnOfIelu4IYeoti2M1L9+TvqW1fWretAZMGAYsYm9XYmnk2q6/Gt+GvhYLZmBgqTS/N
	 IqRBJVjFSGHlcYBXBjXob7EqPtt8sECx5Nmm5leP9oNHN8rBMyz0d2238TSlxV3k7+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793013279;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ZqBUyjr50q1y5QEw68BoaveIycrCYVf4h1gBeFInfco=;
	b=Zrq4CFS2fZe1VnHxmeHg6rrYkuomgdmH94l++AmqCo2Frt6Qe9RBqiOCbwWQZJOmvnTG
	 mSYAfL6hezj+5zMRksfh7LQtdxoVA8RXdGfX4I1UC9mW6s1lDLn5OuPYy4bVXNB/wDfTJ
	 Ky7NSVFsEc350+SMEOxnbKC5bfIjQ78huoMt90xndtJ0dusmRhqFQzZaCr4BwygxO155U
	 kSgbj/y6T1Whg47vhnZgNoj3MQ8K7TCizU8welFIbhaXtoJd875UcKaGUVb9gNe43OKcr
	 VSsS7DOTlXm3wWaOm/jFq5akXs57wdRC1soSrDqMdJ2mAyWDB4QT9Yzr0EDPZywBGpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KdtHJ8kc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3660A606A925
	for <live-patching@vger.kernel.org>; Mon, 26 Oct 2026 11:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KdtHJ8kc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D6201F031E3;
	Mon, 26 Oct 2026 11:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793013278;
	bh=ZqBUyjr50q1y5QEw68BoaveIycrCYVf4h1gBeFInfco=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KdtHJ8kcTCc28a52rmwBPFF97EXuTV9TJEJBg00t5+uxOtWjtJ4j4Z3E3Kzmj5Q/1
	 NORI+JZohVoyusp3zyypigEmJvSBgUKe10EGdYZgp5O7Lr/RAZPY9sLvX8+Xx2FwHf
	 cBT0cy5Pu/P12gJcedTQezuuVMueE5UI39/elvRFJ1cHpKI9aoMMYzyq+jhv/RmPWt
	 8BdCuBwaMgSitOwG6rugkcUFkVe/a4zAI1D58Lf8+2Q4rZLxyzB8z7ikhtW2BWTZKu
	 H1icFtUPv6MRMlcllPmCKrk+/tfOImucmllp+sIvnlSUCfEM4DJgSzlACkOCXZj+rG
	 lSf2E3atL9eOw==
Message-ID: <sashiko-outbox-185077@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/3] objtool/klp: Correlate symbols using DWARF
 identity
Reply-To: sashiko-reviews@lists.linux.dev
To: "Longjun Luo" <luolongjuna@gmail.com>, jpoimboe@kernel.org, peterz@infradead.org
Cc: mbenes@suse.cz, pmladek@suse.com, joe.lawrence@redhat.com, song@kernel.org, puranjay@kernel.org, nathan@kernel.org, ndesaulniers@google.com, morbo@google.com, justinstitt@google.com, live-patching@vger.kernel.org
In-Reply-To: <20261026101916.3823942-2-luolongjuna@gmail.com>
References: <20261026101916.3823942-1-luolongjuna@gmail.com>
 <20261026101916.3823942-2-luolongjuna@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 11:14:37 +0000
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:
- [High] objtool/klp: missing second find_twin() pass after find_twin_check=
sum()
- [High] objtool/klp: uncorrelated symbols misclassified in mark_changed_fu=
nctions()
- [High] objtool/klp: demangle_name() mismatch with same_compiler_name() an=
d LTO
- [High] objtool/klp: get_identity_for_symbol() mishandles aliases and .dat=
a.rel.ro
- [High] objtool/klp: collect_addresses() poisons target identity on compou=
nd ops
- [High] objtool/klp: check_relocations() fails on SHN_UNDEF debug relocati=
ons
- [High] objtool/klp: local clones of external functions omit defining CU s=
ource
- [Medium] objtool/klp: compatible_symbol_name() collapses object-fragment =
numbers
--

commit 8e5857a74bfb5a2a01cd3d2f06cf4f1ad842d7ed
Author: Longjun Luo <luolongjuna@gmail.com>

objtool/klp: Correlate symbols using DWARF identity

This commit replaces positional and suffix-map symbol correlation with
DWARF-derived (source, scope, name) symbol identities and checksum
disambiguation. It requires libdw for building objtool's klp support and
updates klp-build and the klp test suite to compile objects with -g.

> diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
> index 34da55e456097..957e589b66031 100644
> --- a/tools/objtool/klp-diff.c
> +++ b/tools/objtool/klp-diff.c
[ ... ]
> -static const char *llvm_suffix(const char *name)
> +static size_t llvm_name_len(const char *name)
>  {
> -	return strstr(name, ".llvm.");
> -}
> +	const char *suffix =3D strstr(name, ".llvm."), *p;
> =20
> -static bool is_llvm_sym(struct symbol *sym)
> -{
> -	return llvm_suffix(sym->name);
> +	if (!suffix || !isdigit((unsigned char)suffix[6]))
> +		return strlen(name);
> +	for (p =3D suffix + 6; isdigit((unsigned char)*p); p++)
> +		;
> +	return *p ? strlen(name) : (size_t)(suffix - name);
>  }
> =20
[ ... ]
> +/* Keep object-fragment numbers, e.g. amd_northbridges.0. */
> +static bool same_llvm_name(const char *a, const char *b)
>  {
> -	if (!sym1->file || !sym2->file)
> -		return true;
> -	if (sym1->file =3D=3D sym2->file)
> -		return true;
> -	return sym1->file->twin =3D=3D sym2->file;
> +	size_t a_len =3D llvm_name_len(a), b_len =3D llvm_name_len(b);
> +
> +	return a_len =3D=3D b_len && !strncmp(a, b, a_len);
>  }
> =20
> -/*
> - * Similar to maybe_same_file(), but strict: no scope changes allowed.
> - *
> - * Works for both same-ELF (direct pointer compare) and cross-ELF
> - * (compare via file->twin) cases.
> - */
> -static bool same_file(struct symbol *sym1, struct symbol *sym2)
> +static const char *skip_lto_priv(const char *name)
>  {
> -	if (llvm_suffix(sym1->name) && llvm_suffix(sym2->name))
> -		return true;
> -	if (!sym1->file && !sym2->file)
> -		return true;
> -	if (!sym1->file || !sym2->file)
> -		return false;
> -	if (sym1->file =3D=3D sym2->file)
> -		return true;
> -	return sym1->file->twin =3D=3D sym2->file;
> +	if (!strstarts(name, ".lto_priv.") || !isdigit((unsigned char)name[10]))
> +		return name;
> +	name +=3D 10;
> +	while (isdigit((unsigned char)*name))
> +		name++;
> +	return name;
>  }
> =20
> -/*
> - * Is it a local symbol, or at least was it local in the translation unit
> - * before LLVM promoted it?
> - */
> -static bool is_tu_local_sym(struct symbol *sym)
> +static bool is_numeric_suffix(const char *name)
>  {
> -	return is_local_sym(sym) || is_llvm_sym(sym);
> +	if (*name++ !=3D '.' || !isdigit((unsigned char)*name))
> +		return false;
> +	while (isdigit((unsigned char)*name))
> +		name++;
> +	return !*name;
>  }
> =20
[ ... ]
> +/* Allow compiler counters and GCC partition renames to change. */
> +static bool same_compiler_name(const char *a, const char *b)
>  {
[ ... ]
> +	for (;;) {
> +		const char *next_a =3D skip_lto_priv(a), *next_b =3D skip_lto_priv(b);
> =20
> -		/* Level 3 */
> -		if (!same_file(sym1, sym2))
> +		if (next_a !=3D a || next_b !=3D b) {
> +			a =3D next_a;
> +			b =3D next_b;
>  			continue;
> -		file_patched++;
> -		file_last =3D sym2;
> -
> -		/* Level 4 */
> -		if (sym1->len !=3D sym2->len || !sym1->csum.checksum ||
> -		    sym1->csum.checksum !=3D sym2->csum.checksum)
> -			continue;
> -		csum_patched++;
> -		csum_last =3D sym2;
> +		}
> +		if (*a !=3D *b)
> +			break;
> +		if (!*a)
> +			return true;
> +		if (*a =3D=3D '.' && isdigit((unsigned char)a[1])) {
> +			if (!isdigit((unsigned char)b[1]))
> +				return false;
> +			for (a++; isdigit((unsigned char)*a); a++)
> +				;
> +			for (b++; isdigit((unsigned char)*b); b++)
> +				;
> +		} else {
> +			a++;
> +			b++;
> +		}
>  	}
> =20
[ ... ]
> +	/* A trailing counter may be absent on one side. */
> +	return (!*a && is_numeric_suffix(b)) || (!*b && is_numeric_suffix(a));
>  }
> =20
> +/* Keep clone tags such as .cold, .isra and .part distinct. */
> +static bool compatible_symbol_name(const char *a, const char *b)
>  {
> +	if (same_llvm_name(a, b))
> +		return true;
> +	if (strchr(a, '@') || strchr(b, '@') || strstr(a, ".str1."))
> +		return !strcmp(a, b);
> +	return same_compiler_name(a, b);
>  }

[Severity: Medium]
In compatible_symbol_name(), if same_llvm_name(a, b) returns false for two
SRA-split object fragments with different fragment numbers (such as
amd_northbridges.0 vs amd_northbridges.1, or amd_northbridges.0.llvm.1 vs
amd_northbridges.1.llvm.2), doesn't execution fall through to
same_compiler_name(a, b)?

Because same_compiler_name() treats any .<digits> suffix as a mutable
compiler counter, it returns true for .0 vs .1. Since SRA-split fragments
use multi-op DW_OP_piece DWARF location expressions,
get_identity_for_symbol() returns unavailable and both fragments share the
same fallback identity (demangled_name =3D "amd_northbridges"). Won't
compatible_symbol_name() then treat the distinct fragments as ambiguous
candidates for each other and fail to correlate them?

> +static bool is_twin_candidate(struct symbol *sym1, struct symbol *sym2)
> +{
> +	if (sym1->type !=3D sym2->type || !same_identity(&sym1->identity, &sym2=
->identity))
> +		return false;
> +	/* Don't match zero-length labels with sized symbols. */
> +	if (!is_undef_sym(sym1) && !is_undef_sym(sym2) &&
> +	    (!sym1->len !=3D !sym2->len))
> +		return false;
> +	return compatible_symbol_name(sym1->name, sym2->name);
> +}

[Severity: High]
Can same_compiler_name() ever be reached when .lto_priv.<N> suffixes,
interior clone counters, or one-sided numeric suffixes differ between
original and patched symbols?

In find_twin() and find_twin_checksum(), candidates are looked up in
symbol_identity_hash by identity_hash(&sym1->identity) and checked with
is_twin_candidate() -> same_identity(), which requires exact equality of
identity.demangled_name before calling compatible_symbol_name() ->
same_compiler_name().

However, demangled_name_len() in tools/objtool/elf.c computes
sym->identity.demangled_name by stripping .llvm.* or trailing [0-9._]+
characters:

tools/objtool/elf.c:demangled_name_len() {
	p =3D strstr(name, ".llvm.");
	if (p)
		return p - name;

	if (!strstarts(name, "__UNIQUE_ID_") && !strchr(name, '.'))
		return strlen(name);

	for (idx =3D strlen(name) - 1; idx >=3D 0; idx--) {
		char c =3D name[idx];

		if (!isdigit(c) && c !=3D '.' && c !=3D '_')
			break;
	}
}

As a result:

1. "foo" demangles to "foo", while "foo.lto_priv.0" stops at 'v' and
   demangles to "foo.lto_priv" (and "var.0.lto_priv.0" vs
   "var.1.lto_priv.0" demangle to "var.0.lto_priv" vs "var.1.lto_priv").

2. "foo.lto_priv.0.part.0" vs "foo.lto_priv.1.part.0" demangle to
   "foo.lto_priv.0.part" vs "foo.lto_priv.1.part", and "foo.isra.0.cold"
   vs "foo.isra.1.cold" demangle to "foo.isra.0.cold" vs
   "foo.isra.1.cold".

3. A symbol whose base name ends in digits or _<digits> with a one-sided
   counter (such as "var_1" vs "var_1.0", or "crc32" vs "crc32.0")
   demangles to "var_1" vs "var", or "crc32" vs "crc".

Since identity.demangled_name differs in all of these cases,
identity_hash() places them in different hash buckets and same_identity()
returns false before same_compiler_name() is called. Also, matches_name()
in tools/objtool/klp-dwarf.c only skips .llvm. and .<digits>, so it will
reject .lto_priv.<digits> suffixes when matching ELF names against DWARF
DW_AT_name in folded .rodata sections.

Should demangled_name_len() and matches_name() be updated to normalize
these suffixes consistently with same_compiler_name()?

[ ... ]
>  static int correlate_symbols(struct elfs *e)
>  {
> +	struct symbol *sym;
> =20
> +	for_each_sym(e->orig, sym)
> +		sym->dont_correlate =3D dont_correlate(sym);
> +	for_each_sym(e->patched, sym)
> +		sym->dont_correlate =3D dont_correlate(sym);
> =20
> +	if (prepare_identities(e->orig) || prepare_identities(e->patched))
> +		return -1;
> =20
> +	correlate_pass(e, find_twin);
> +	correlate_pass(e, find_twin_checksum);

[Severity: High]
Does correlate_symbols() need a second correlate_pass(e, find_twin) after
correlate_pass(e, find_twin_checksum)?

Suppose two symbols share the same (source, scope, demangled_name)
identity and compatible symbol names (for example, the two ThinLTO
promoted helper.llvm.<hash> functions in
tools/objtool/tests/generic/test-thinlto-ambiguity.sh, which are both
compiled from thinlto_ambiguity.c), and a patch modifies one of them while
leaving the other unchanged:

1. The first correlate_pass(e, find_twin) sees candidates =3D=3D 2 for both
   symbols and returns NULL.

2. correlate_pass(e, find_twin_checksum) pairs the unchanged symbol by
   checksum, setting sym->twin =3D match and match->twin =3D sym.

3. Even though the modified symbol is now the sole remaining unpaired
   candidate on both sides (and find_twin() skips already-paired symbols
   via sym2->twin), find_twin() is never run again.

Consequently, the modified symbol is left with twin =3D=3D NULL, misclassif=
ied
by mark_changed_functions() as a newly added function rather than a
changed function, and omitted from .init.klp_funcs.

> =20
> +	for_each_sym(e->orig, sym)
> +		if (!sym->twin && !sym->dont_correlate)
> +			WARN("no correlation: %s", sym->name);
> =20
> +	return 0;
> +}
[ ... ]
> @@ -1079,7 +817,8 @@ static int mark_changed_functions(struct elfs *e)
> =20
>  	/* Find added functions and print them */
>  	for_each_sym(e->patched, patched_sym) {
> -		if (!is_func_sym(patched_sym) || patched_sym->dont_correlate)
> +		if (!is_func_sym(patched_sym) || patched_sym->dont_correlate ||
> +		    is_undef_sym(patched_sym))
>  			continue;
> =20
>  		if (!patched_sym->twin) {
> @@ -1206,6 +945,9 @@ static bool klp_reloc_needed(struct reloc *patched_r=
eloc)
>  		 * patch.  The symbol could be defined in this .o or in another
>  		 * .o in the patch module.
>  		 *
> +		 * FIXME: Failed correlation can duplicate existing data, breaking
> +		 * shared state or pointer identity.
> +		 *

[Severity: High]
When ambiguous symbols fail to correlate, correlate_symbols() emits a
warning and returns 0 with twin =3D=3D NULL. However, don't the subsequent
passes in cmd_klp_diff() treat every symbol with twin =3D=3D NULL and
!dont_correlate as a newly added symbol?

Specifically:

1. In mark_changed_functions(), the first loop skips any orig_sym with
   !orig_sym->twin (bypassing the "changed data" error check if an
   uncorrelated data object was modified), and the second loop marks any
   patched_sym with !patched_sym->twin as a "new function" (setting
   included =3D 1, changed =3D 0). In create_klp_sections(), only functions
   with sym->clone->changed get a struct klp_func_ext entry in
   .init.klp_funcs, so an uncorrelated modified function is cloned into
   the output object as dead code without livepatching the target
   function.

2. In klp_reloc_needed() and clone_reloc(), any uncorrelated non-exported
   symbol (!patched_sym->twin) referenced by a patched function returns
   klp_reloc_needed() =3D=3D false and is cloned with its data into the
   livepatch module as a private copy instead of referencing the original
   kernel symbol via a KLP relocation. This also happens for unchanged
   static local variables when a patched function contains two same-named
   static locals in different unnamed lexical blocks with the same size
   and initial value, since resolve_parent_scope() ignores
   DW_TAG_lexical_block.

Should correlation failure for symbols that exist in e->orig (or
ambiguous candidates in e->patched that match an uncorrelated symbol's
identity) abort cmd_klp_diff() instead of silently generating a broken
livepatch module?

> diff --git a/tools/objtool/klp-dwarf.c b/tools/objtool/klp-dwarf.c
> new file mode 100644
> index 0000000000000..eff054f2864b6
> --- /dev/null
> +++ b/tools/objtool/klp-dwarf.c
[ ... ]
> +static int collect_addresses(struct identity_reader *reader, struct iden=
tity_die *entry)
> +{
> +	Dwarf_Die *die =3D &entry->die, type;
> +	Dwarf_Attribute attr, address_attr;
> +	Dwarf_Addr base, start, end, address;
> +	Dwarf_Op *ops;
> +	const char *source, *scope;
> +	size_t count;
> +	ptrdiff_t off =3D 0;
> +	bool external =3D false;
> +	int tag =3D dwarf_tag(die);
> +
> +	if (!entry->definition || (tag !=3D DW_TAG_subprogram && tag !=3D DW_TA=
G_variable))
> +		return 0;
> +	if (dwarf_attr_integrate(die, DW_AT_external, &attr) && dwarf_formflag(=
&attr, &external))
> +		return die_error(die, "invalid external flag");
> +	/*
> +	 * External identities do not need source. DWARF relocations for overri=
dden
> +	 * weak definitions can bind to the selected strong definition, giving =
the
> +	 * same address conflicting source CUs (GDB PR 34741):
> +	 * https://sourceware.org/bugzilla/show_bug.cgi?id=3D34741
> +	 */
> +	source =3D external ? NULL : resolve_definition_source(entry);

[Severity: High]
For an external function (DW_AT_external =3D true), its cold subfunction
(foo.cold) is emitted as a range on foo's DW_TAG_subprogram, and its
compiler clones (such as foo.part.0, foo.isra.0, or foo.constprop.0) have
DW_AT_abstract_origin pointing to foo, inheriting external =3D true via
dwarf_attr_integrate().

Because collect_addresses() sets source =3D NULL whenever external is true,
these STB_LOCAL clone symbols receive identity.external =3D true and
identity.source =3D "".

When vmlinux.o links a translation unit containing a __weak function foo
and another translation unit containing a strong override foo, ld -r
merges the global foo symbol, but retains both translation units'
STB_LOCAL foo.cold (or foo.part.0 / foo.isra.0) symbols in .symtab. With
both local symbols assigned identity ("", "/", "foo.cold") and identical
sym->name, won't validate_dwarf_identity() fail with a "duplicate symbol
identity" error?

> +	if (tag =3D=3D DW_TAG_subprogram) {
[ ... ]
> +	}
> +	if (!dwarf_attr(die, DW_AT_location, &attr))
> +		return 0;
> +	/* Location lists may vary with the PC; index only fixed storage. */
> +	if (dwarf_whatform(&attr) =3D=3D DW_FORM_sec_offset ||
> +	    dwarf_whatform(&attr) =3D=3D DW_FORM_loclistx)
> +		return 0;
> +	if (dwarf_getlocation(&attr, &ops, &count))
> +		return die_error(die, "invalid location expression");
> +	if (!count)
> +		return 0;
> +	if (dwarf_attr_integrate(die, DW_AT_type, &address_attr)) {
> +		if (!dwarf_formref_die(&address_attr, &type))
> +			return die_error(die, "invalid variable type reference");
> +		if (is_empty_type(&type))
> +			return 0;
> +	}
> +	if (resolve_definition_scope(reader, entry, &scope))
> +		return -1;
> +	if (ops[0].atom =3D=3D DW_OP_addr) {
> +		address =3D ops[0].number;
> +	} else if (ops[0].atom =3D=3D DW_OP_addrx || ops[0].atom =3D=3D DW_OP_G=
NU_addr_index) {
> +		if (dwarf_getlocation_attr(&attr, ops, &address_attr) ||
> +		    dwarf_formaddr(&address_attr, &address))
> +			return die_error(die, "invalid location address");
> +	} else {
> +		return 0;
> +	}
> +	return add_address(reader, address + reader->bias, source,
> +			   count =3D=3D 1 ? scope : NULL, entry->name, external);
> +}

[Severity: High]
When a local or static const pointer variable holds the address of another
symbol X (for example, "int *p =3D &counter;" or "fn_t cb =3D helper;"),
compilers at -O2 -g frequently emit a 2-op DW_AT_location expression
[DW_OP_addr(X), DW_OP_stack_value] (or DW_OP_addrx) on p's DIE to describe
p's value when p itself has no storage.

Because collect_addresses() inspects every DW_TAG_variable DIE and records
ops[0] with scope =3D (count =3D=3D 1 ? scope : NULL), won't p's DIE insert=
 an
address_identity entry at X's address with entry->scope =3D=3D NULL?

Then, when get_identity_for_symbol() looks up X, it encounters that
entry->scope =3D=3D NULL record, sets unavailable =3D true, and wipes out X=
's
own valid DWARF identity (resetting identity->source =3D "",
identity->scope =3D NULL, and identity->external =3D false). If a patch adds
or removes such a local pointer variable in a function, X's identity will
change between orig and patched, causing correlation failures or false
"unsupported linkage change" errors.

> +
> +/*
> + * libdwfl permits partial relocation, leaving unapplied entries in plac=
e.
> + * Check only sections read for identities; unused indexes may retain re=
locations.
> + */
> +static int check_relocations(Dwarf *dwarf)
> +{
> +	static const char * const sections[] =3D {
> +		".debug_info", ".debug_types", ".debug_abbrev",
> +		".debug_str", ".debug_line_str", ".debug_str_offsets",
> +		".debug_addr", ".debug_ranges", ".debug_rnglists",
> +	};
> +	Elf *elf =3D dwarf_getelf(dwarf);
> +	Elf_Scn *scn =3D NULL;
> +	GElf_Shdr sh, target;
> +	const char *name;
> +	size_t strings, i;
> +
> +	if (!elf || elf_getshdrstrndx(elf, &strings))
> +		return -1;
> +	while ((scn =3D elf_nextscn(elf, scn))) {
> +		if (!gelf_getshdr(scn, &sh))
> +			return -1;
> +		if (!sh.sh_size || (sh.sh_type !=3D SHT_REL && sh.sh_type !=3D SHT_REL=
A))
> +			continue;
> +		if (!gelf_getshdr(elf_getscn(elf, sh.sh_info), &target))
> +			return -1;
> +		name =3D elf_strptr(elf, strings, target.sh_name);
> +		if (!name)
> +			return -1;
> +		for (i =3D 0; i < ARRAY_SIZE(sections); i++)
> +			if (!strcmp(name, sections[i])) {
> +				ERROR("DWARF identity: unapplied relocations for %s", name);
> +				return -1;
> +			}
> +	}
> +	return 0;
> +}

[Severity: High]
Won't check_relocations() fail on valid ET_REL kernel objects and modules
that reference external (SHN_UNDEF) symbols in .debug_info or .debug_addr?

In elfutils (libdwfl/relocate.c), libdwfl only sets sh_size =3D 0 on a
relocation section when every relocation in that section has been
resolved. If any relocation targets an SHN_UNDEF symbol (such as an
optimized-out pointer initialized to an external symbol via DW_OP_addr /
DW_OP_stack_value, a DW_TAG_call_site target, or a DWARF 5 .debug_addr
entry referenced from .debug_loclists), libdwfl leaves that relocation in
place and keeps sh.sh_size non-zero, causing check_relocations() to abort
with "unapplied relocations for .debug_info" or ".debug_addr".

[ ... ]
> +int get_identity_for_symbol(struct elf *elf, struct symbol *sym)
> +{
> +	struct identity *identity =3D &sym->identity;
> +	struct section *sec =3D sym->sec;
> +	struct address_identity *entry;
> +	unsigned int nr =3D 0, nr_named =3D 0;
> +	bool filter_name =3D false, unavailable =3D false, source_unavailable =
=3D false;
> +	const char *error, *saved_objname =3D objname;
> +
> +	identity->source =3D "";
> +	identity->scope =3D NULL;
> +	identity->external =3D false;
> +	elf_hash_for_each_possible(elf, dwarf_address, entry, hash, sym->offset=
 ^ sec->idx) {
> +		if (entry->section !=3D sec->idx || entry->offset !=3D sym->offset)
> +			continue;
> +		nr++;
> +		if (is_rodata_sec(sec) && matches_dwarf_name(entry, sym->name))
> +			nr_named++;
> +	}
> +	if (!nr)
> +		return 1;
> +
> +	/* Only folded read-only storage needs name-based disambiguation. */
> +	if (nr > 1 && is_rodata_sec(sec)) {
> +		filter_name =3D true;
> +		if (!nr_named)
> +			return 1;
> +		/*
> +		 * ICF/constant merging can leave several definitions after name
> +		 * filtering. FIXME: Folded objects can remain uncorrelated when
> +		 * their checksums change.
> +		 */
> +		if (nr_named > 1 && strstarts(sec->name, ".rodata"))
> +			return 1;
> +	}
> +
> +	objname =3D elf->name;
> +	elf_hash_for_each_possible(elf, dwarf_address, entry, hash, sym->offset=
 ^ sec->idx) {
> +		if (entry->section !=3D sec->idx || entry->offset !=3D sym->offset)
> +			continue;
> +		if (filter_name && !matches_dwarf_name(entry, sym->name))
> +			continue;
> +		/* Scope cannot be resolved from the first address of a compound expre=
ssion. */
> +		if (!entry->scope) {
> +			unavailable =3D true;
> +			/* Keep scanning: later entries may conflict. */
> +			continue;
> +		}
> +		error =3D "conflicting declarations";
> +		if (identity->scope && strcmp(identity->scope, entry->scope))
> +			goto failed;
> +		error =3D "conflicting external declarations";
> +		if (identity->scope && identity->external !=3D entry->external)
> +			goto failed;

[Severity: High]
There seem to be a few issues with how get_identity_for_symbol() and
prepare_identities() handle aliases, .data.rel.ro sections, and fallback
symbols:

1. Because filter_name is only enabled when nr > 1 && is_rodata_sec(sec),
   what happens when a global or weak symbol is an __alias of a static
   function or variable in .text or .data (such as SYSCALL_DEFINE0 stubs
   __x64_sys_* aliasing static __do_sys_*, or static efi_runtime_lock and
   its global alias __efi_uv_runtime_lock)?

   - If only the static target has a DWARF DIE at that address (nr =3D=3D 1=
),
     get_identity_for_symbol() does not check matches_dwarf_name() and
     assigns the static target's identity (external =3D false, source =3D CU
     path) to the global alias symbol.

   - If both the static target (external =3D false) and the global alias or
     an overridden weak COND_SYSCALL DIE (external =3D true) have DWARF DIEs
     at the same address in .text or .data (nr > 1, !is_rodata_sec(sec)),
     filter_name is false and get_identity_for_symbol() aborts at
     "conflicting external declarations".

2. In the nr > 1 && is_rodata_sec(sec) block above, the early return checks
   strstarts(sec->name, ".rodata") rather than is_rodata_sec(sec). Since
   mark_rodata() marks both .rodata* and .data.rel.ro* as rodata, won't
   merged objects in .data.rel.ro* with nr_named > 1 fall through into the
   loop and fail with "conflicting declarations" or "conflicting source
   CUs"?

3. In prepare_identities() in tools/objtool/klp-identity.c, when DWARF is
   unavailable (!identity->scope), identity->external is left as false
   even when the ELF symbol has STB_GLOBAL or STB_WEAK binding, which can
   then trigger false "unsupported linkage change" errors in
   check_linkage_changes().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026101916.3823=
942-1-luolongjuna@gmail.com?part=3D1
