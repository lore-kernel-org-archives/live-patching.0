Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793801365;
	b=i78nClutAKlJtG/JjDB//3I7w1S7//CsQ6N0kQl+mCk9lKm3g62r9AekkSOg+qqehagr
	 dRGMiDqKmVlgdJYomZ8VH4RO7/kGBT+UqQVJzZxQiclV07tOl1ezX9/FGqUTipI9X6fro
	 yR+XriVmC2liZzDJS2zBjmCg4hgHjqumKJHLZclnHVIB0rYgLIdxoptTiOUOQqdqbKEv/
	 pAQ5cHir/7zFnqZMjPQW/zQ6PNjT7NwJNiNK5Ijq8oycTAgjZ1sjCKJQshRNwZHjQlbPN
	 ijmU7fwdJK2jKzW63cuIhgIhNofRJc8vtUzJsefmGuwIwJG5HWDYxYz/+yJatAVP/qQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793801365;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=kul4V9pUPI9bTEaqBq4LElrD7F+y2J5WQ3dZT62h6Qs=;
	b=fs6+qt8YuDA/4tq4X/mpmDpxbPhr0JVBiypnJ7GLnk3H7PbGnwZHGMOgASWsSKQdwUdm
	 QRVi7ZCirKYMgR0Pl3JtvzLm6fPMLf9VQPM/KlscyGcJL0G+R6lLAzkDgKrVjCx/gqj/b
	 JNYAlcQixp+I5jpnNY/V3ie6qH9Se8PycV7Cfd+rE+hudkL3UeJ7BaXUvVZXECvNRV00A
	 XR6ZTt+82jl1U7x+GSXInvwIh/9MVMOKl01xaOLAYMWmegIFl7b10BzIQhvVSafMOjjIp
	 OrzhrzV2X4mfrgJj2OVcmclMhccvoMzvPoomtGe6YvGW71UpgZzq+dWQUQSKdlN2Atg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fnJPQbWn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5BD606A326
	for <live-patching@vger.kernel.org>; Wed,  4 Nov 2026 14:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fnJPQbWn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 442001F000C1;
	Wed,  4 Nov 2026 14:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793801364;
	bh=kul4V9pUPI9bTEaqBq4LElrD7F+y2J5WQ3dZT62h6Qs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fnJPQbWnSHX0btAHWIeVmwLtYIJ6V/ez6ieV9NWDRq3SEUCG/5fRUnwO5b2t47lJM
	 oemdFoto9rrgbtDn6rvg/pGYZpaSMB7Amt3re6kQm4c9ge+JCdIle/6Ei8FO7wQDyb
	 lGHZsD7xXGoCy9NSgqrwALHgWtZ1ShFcFU8u9YiVe9iHNoLBxNi8pVeBoNBqqlSsUm
	 q5FtQIxqDMHTBUbobrN8Aszb9qvFAO4TQQ1xKON339C5NMyjcX/GvO9U3k7j2nGuZb
	 OdOaSot3OC0WILRJJr8bY08ezGlgKpl68I8V50czmfIoY9M0o94sHG8iz63S4Bbm9k
	 keDs8H79TVhIw==
Message-ID: <sashiko-outbox-197397@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 07/11] objtool/klp: Correlate symbols using DWARF
 identities
Reply-To: sashiko-reviews@lists.linux.dev
To: "Longjun Luo" <luolongjuna@gmail.com>, jpoimboe@kernel.org, peterz@infradead.org
Cc: mbenes@suse.cz, pmladek@suse.com, joe.lawrence@redhat.com, song@kernel.org, puranjay@kernel.org, nathan@kernel.org, ndesaulniers@google.com, morbo@google.com, justinstitt@google.com, live-patching@vger.kernel.org
In-Reply-To: <20261104133158.3187525-8-luolongjuna@gmail.com>
References: <20261104133158.3187525-1-luolongjuna@gmail.com>
 <20261104133158.3187525-8-luolongjuna@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 14:09:23 +0000
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 9 potential issue(=
s) to consider:
- [High] objtool/klp: broken checksum and twin resolution for aliased symbo=
ls
- [High] objtool/klp: mark_changed_functions() treats ambiguous functions a=
s new
- [Medium] objtool/klp: build_symtab_hash() uses sym->file->name instead of=
 DWARF source
- [Medium] objtool/klp: check_linkage_changes() matches unrelated symbols a=
cross TUs
- [Medium] objtool/klp: __LINE__ shifts break __UNIQUE_ID_ddebug_* correlat=
ion
- [Medium] objtool/klp: unreachable .lto_priv matching in skip_lto_priv()
- [Medium] objtool/klp: broken .llvm and counter matching in compatible_sym=
bol_name()
- [Medium] objtool/klp: zero-length symbols skipped by correlation are clon=
ed as new
- [Medium] objtool/klp: adding -g breaks sympos, linkage-flip, and multi-TU=
 tests
--

commit 4e3aabc6f0126e260b43d87b5c01364b588687eb
Author: Longjun Luo <luolongjuna@gmail.com>

objtool/klp: Correlate symbols using DWARF identities

This commit replaces positional and suffix-based symbol correlation in
objtool klp diff with DWARF identity matching, checksum disambiguation, and
a restricted FILE/name fallback.

> diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
> index cd5e683d6468b..468b8654b6871 100644
> --- a/tools/objtool/klp-diff.c
> +++ b/tools/objtool/klp-diff.c

[ ... ]

> @@ -486,361 +473,357 @@ static bool dont_correlate(struct symbol *sym)
>  	       is_anonymous_rodata(sym) ||
>  	       is_initcall_sym(sym) ||
>  	       is_addressable_sym(sym) ||
> +	       is_metadata_section(sym->sec) ||
>  	       is_special_section(sym->sec) ||
>  	       is_special_section_aux(sym->sec);
>  }
> =20
> -static const char *llvm_suffix(const char *name)
> +static size_t llvm_name_len(const char *name)
>  {
> -	return strstr(name, ".llvm.");
> +	const char *suffix =3D strstr(name, ".llvm."), *p;
> +
> +	if (!suffix || !isdigit((unsigned char)suffix[6]))
> +		return strlen(name);
> +	for (p =3D suffix + 6; isdigit((unsigned char)*p); p++)
> +		;
> +	return *p ? strlen(name) : (size_t)(suffix - name);
>  }
> =20
> -static bool is_llvm_sym(struct symbol *sym)
> +/* Keep object-fragment numbers, e.g. amd_northbridges.0. */
> +static bool same_llvm_name(const char *a, const char *b)
>  {
> -	return llvm_suffix(sym->name);
> +	size_t a_len =3D llvm_name_len(a), b_len =3D llvm_name_len(b);
> +
> +	return a_len =3D=3D b_len && !strncmp(a, b, a_len);
>  }
> =20
> -/*
> - * Determine if two symbols have compatible source file origins:
> - *
> - *   - If both symbols are local, only return true if they belong to the=
 same
> - *     ELF file symbol.
> - *
> - *   - If both symbols are global, always return true, as globals don't =
have
> - *     file associations.
> - *
> - *   - If they have different scopes, also return true, as the patch mig=
ht have
> - *     changed the symbol's scope.
> - *
> - * Works for both same-ELF (direct pointer compare) and cross-ELF
> - * (compare via file->twin) cases.
> - */
> -static bool maybe_same_file(struct symbol *sym1, struct symbol *sym2)
> +static const char *skip_lto_priv(const char *name)
>  {
> -	if (!sym1->file || !sym2->file)
> -		return true;
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
> - * Similar to maybe_same_file(), but strict: no scope changes allowed.
> - *
> - * Works for both same-ELF (direct pointer compare) and cross-ELF
> - * (compare via file->twin) cases.
> - */
> -static bool same_file(struct symbol *sym1, struct symbol *sym2)
> +static bool is_numeric_suffix(const char *name)
>  {
> -	if (llvm_suffix(sym1->name) && llvm_suffix(sym2->name))
> -		return true;
> -	if (!sym1->file && !sym2->file)
> -		return true;
> -	if (!sym1->file || !sym2->file)
> +	if (*name++ !=3D '.' || !isdigit((unsigned char)*name))
>  		return false;
> -	if (sym1->file =3D=3D sym2->file)
> +	while (isdigit((unsigned char)*name))
> +		name++;
> +	return !*name;
> +}
> +
> +/* Allow compiler counters and GCC partition renames to change. */
> +static bool same_compiler_name(const char *a, const char *b)
> +{
> +	for (;;) {
> +		const char *next_a =3D skip_lto_priv(a), *next_b =3D skip_lto_priv(b);
> +
> +		if (next_a !=3D a || next_b !=3D b) {
> +			a =3D next_a;
> +			b =3D next_b;
> +			continue;
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
> +	}
> +
> +	/* A trailing counter may be absent on one side. */
> +	return (!*a && is_numeric_suffix(b)) || (!*b && is_numeric_suffix(a));
> +}

[Severity: Medium]
Can skip_lto_priv() in same_compiler_name() ever match when .lto_priv.<N> is
added or removed on one side, or when an internal counter changes before
another suffix?

In tools/objtool/elf.c, demangled_name_len() only strips .llvm.<hash> and
trailing .<digits> suffixes, stopping at .lto_priv because 'v' is not a
digit:

tools/objtool/elf.c:demangled_name_len() {
    ...
    while (p > name) {
        while (p > name && isdigit((unsigned char)p[-1]))
            p--;
        if (p =3D=3D name || p[-1] !=3D '.')
            break;
        p--;
    }
    ...
}

So demangle_name() produces "foo" for "foo", "foo.lto_priv" for
"foo.lto_priv.0", "foo.lto_priv.0.part" for "foo.lto_priv.0.part.0", and
"var.0.lto_priv" for "var.0.lto_priv.0".

Because find_twin() and find_twin_by_identity_and_checksum() look up
candidates via identity_hash(&sym1->identity) (which hashes
identity.demangled_name) and is_twin_candidate() checks
same_identity(&sym1->identity, &sym2->identity) before calling
compatible_symbol_name(), any pair where .lto_priv.<N> is present on only
one side or where an internal .lto_priv.<N> or .<N> changes before another
suffix will have different demangled_name strings and be rejected before
same_compiler_name() is reached.

> +
> +/* Keep clone tags such as .cold, .isra and .part distinct. */
> +static bool compatible_symbol_name(const char *a, const char *b)
> +{
> +	if (same_llvm_name(a, b))
>  		return true;
> -	return sym1->file->twin =3D=3D sym2->file;
> +	if (strchr(a, '@') || strchr(b, '@') || strstr(a, ".str1."))
> +		return !strcmp(a, b);
> +	return same_compiler_name(a, b);
>  }

[Severity: Medium]
What happens in compatible_symbol_name() when a symbol has both a
.llvm.<digits> suffix (or .lto_priv.<digits> suffix) and a compiler counter
suffix that was added or changed?

First, same_llvm_name(a, b) strips .llvm.<digits> via llvm_name_len(), but
requires the remaining prefixes to be byte-for-byte identical. When a
counter suffix was added or changed (for example, target.done.llvm.111 vs
target.done.1.llvm.222, or target.done vs target.done.1.llvm.222 when
ThinLTO promotion changes), same_llvm_name() returns false and
compatible_symbol_name() falls through to same_compiler_name(a, b) with the
unstripped strings.

Because same_compiler_name() does not strip or skip .llvm.<digits>, it
compares ".llvm.111" against ".1.llvm.222" (or "" against ".1.llvm.222")
and returns false. Similarly, for a pair like foo.lto_priv.0 vs
foo.0.lto_priv.0, skip_lto_priv() consumes .lto_priv.0 on the first string,
breaks out of the loop at the '.' of .0.lto_priv.0, and calls
is_numeric_suffix(".0.lto_priv.0"), which returns false because
is_numeric_suffix() does not skip .lto_priv.<digits>.

Second, same_llvm_name() has the comment "Keep object-fragment numbers, e.g.
amd_northbridges.0.", but when same_llvm_name() returns false for two
different fragment numbers (such as amd_northbridges.0 vs
amd_northbridges.1), compatible_symbol_name() falls through to
same_compiler_name(a, b), which treats .0 and .1 as matching compiler
counters unless one side has a .llvm.<digits> suffix.

Should .llvm.<digits> be stripped before comparing prefixes in
same_compiler_name(), or how are object-fragment numbers meant to be
distinguished from compiler counters?

> =20
> -/*
> - * Is it a local symbol, or at least was it local in the translation unit
> - * before LLVM promoted it?
> - */
> -static bool is_tu_local_sym(struct symbol *sym)
> +static bool is_twin_candidate(struct symbol *sym1, struct symbol *sym2)
>  {
> -	return is_local_sym(sym) || is_llvm_sym(sym);
> +	if (sym1->type !=3D sym2->type)
> +		return false;
> +	/* Relocations can also reach targets without DWARF identities. */
> +	if (has_dwarf_identity(sym1) && has_dwarf_identity(sym2) &&
> +	    !same_identity(&sym1->identity, &sym2->identity))
> +		return false;
> +	/* Don't match zero-length labels with sized symbols. */
> +	if (!is_undef_sym(sym1) && !is_undef_sym(sym2) &&
> +	    (!sym1->len !=3D !sym2->len))
> +		return false;
> +	/* __UNIQUE_ID counters shift when an earlier macro is added. */
> +	if (is_object_sym(sym1) &&
> +	    (strstarts(sym1->name, "__UNIQUE_ID_") || strstr(sym1->name, ".__UN=
IQUE_ID_")) &&
> +	    (strstarts(sym2->name, "__UNIQUE_ID_") || strstr(sym2->name, ".__UN=
IQUE_ID_")))
> +		return !strcmp(sym1->identity.demangled_name, sym2->identity.demangled=
_name);
> +	return compatible_symbol_name(sym1->name, sym2->name);
>  }

[Severity: Medium]
Does matching __UNIQUE_ID_ddebug_* symbols here work when a patch adds or
removes lines earlier in the source file?

Both DEFINE_DYNAMIC_DEBUG_METADATA_CLS() in include/linux/dynamic_debug.h
(.lineno =3D __LINE__) and DEBUG_CALL() in
tools/objtool/tests/generic/fixtures/identity/unique_id.c embed __LINE__ in
each static descriptor in section __dyndbg, and checksum_update_object() in
tools/objtool/klp-checksum.c hashes the raw object bytes including that line
number field.

In unique_id.c, the #ifdef PATCHED and #else branches have the same number
of lines, so __LINE__ stays identical. However, if a patch inserts or
deletes lines above a function containing pr_debug():

1. When a function has a single pr_debug() descriptor,
   correlate_by_identity() pairs the original and patched
   __UNIQUE_ID_ddebug_* symbols by their unique DWARF identity, and
   mark_changed_functions() then sees orig_sym->csum.checksum !=3D
   patched_sym->csum.checksum (due to the changed line number) and aborts
   with ERROR("changed data: __UNIQUE_ID_ddebug_...") even if the function
   containing pr_debug() was not modified.

2. When a changed function has multiple pr_debug() descriptors (which share
   the same scope and demangled name __UNIQUE_ID_ddebug),
   correlate_by_identity() defers to extend_same_twins_by_checksum() ->
   find_twin_by_identity_and_checksum(), which requires
   sym1->csum.checksum =3D=3D sym2->csum.checksum and fails to correlate any
   descriptor whose __LINE__ shifted.

> =20
> -/*
> - * Try to find sym1's twin in patched using deterministic matching.
> - *
> - * Multiple symbols can share a demangled name (e.g., static functions in
> - * different TUs).  This function counts same-named candidates through a
> - * funnel of progressively tighter filters.  Each level is a strict subs=
et
> - * of the previous one.
> - *
> - * The widest level that yields a 1:1 match wins.  Narrower levels are o=
nly
> - * needed when the wider level is ambiguous (count > 1).
> - *
> - * Candidates are pre-filtered by maybe_same_file(), which narrows most
> - * local symbols to their own TU.  For example, 19 different static
> - * type_show() functions across vmlinux.o each see only one candidate af=
ter
> - * pre-filtering, so they match immediately at Level 1.
> - *
> - * Level 1 (name): Works when the demangled name is unique after
> - * pre-filtering.  Handles most symbols: unique globals like copy_signal=
(),
> - * or per-TU locals like pcspkr_probe().
> - *
> - * Level 2 (scope): Filters by local-vs-global (TU-local-vs-not).  Examp=
le:
> - * parse_header() exists as both a static and a global function.  Level 1
> - * sees both (same demangled name), but Level 2 separates them by scope.
> - *
> - * Level 3 (file): Strict file matching via same_file(), which rejects s=
cope
> - * changes.  Example: LLVM-promoted foo.llvm.12345 (global, no FILE symb=
ol)
> - * vs genuine local foo (has FILE symbol).  Both are TU-local so Level 2
> - * can't distinguish them, but same_file() rejects the pair because one =
has
> - * a file association and the other doesn't.
> - *
> - * Level 4 (checksum): Distinguishes by function checksum.  Example:
> - * usb_devnode.llvm.AAA and usb_devnode.llvm.BBB are two LLVM-promoted
> - * functions from different TUs with the same demangled name.  After a TU
> - * change, the .llvm. hashes change but the functions themselves may be
> - * unchanged.  Level 4 matches each to the patched candidate with the
> - * same checksum.
> - */
> -static struct symbol *find_twin(struct elfs *e, struct symbol *sym1)
> +static struct symbol *find_twin(struct elf *elf, struct symbol *sym1)
>  {
> -	struct symbol *name_last =3D NULL, *scope_last =3D NULL,
> -		      *file_last =3D NULL, *csum_last =3D NULL;
> -	unsigned int name_orig =3D 0, name_patched =3D 0;
> -	unsigned int scope_orig =3D 0, scope_patched =3D 0;
> -	unsigned int file_orig =3D 0, file_patched =3D 0;
> -	unsigned int csum_orig =3D 0, csum_patched =3D 0;
>  	struct symbol *sym2, *match =3D NULL;
> +	unsigned int candidates =3D 0;
> +	u32 key;
> =20
> -	/* Count orig candidates */
> -	for_each_sym_by_demangled_name(e->orig, sym1->identity.demangled_name, =
sym2) {
> -		if (sym2->twin || sym1->type !=3D sym2->type || sym2->dont_correlate ||
> -		    (!maybe_same_file(sym1, sym2)))
> +	if (!has_dwarf_identity(sym1))
> +		return NULL;
> +	key =3D identity_hash(&sym1->identity);
> +
> +	elf_hash_for_each_possible(elf, symbol_identity, sym2, identity_hash, k=
ey) {
> +		if (sym2->twin || !is_twin_candidate(sym1, sym2))
>  			continue;
> +		match =3D sym2;
> +		candidates++;
> +	}
> =20
> -		/* Level 1: name match (widest filter)  */
> -		name_orig++;
> +	return candidates =3D=3D 1 ? match : NULL;
> +}
> =20
> -		/* Level 2: scope (scope changes allowed) */
> -		if (is_tu_local_sym(sym1) !=3D is_tu_local_sym(sym2))
> -			continue;
> -		scope_orig++;
> +/* Checksums can disambiguate only unchanged symbols. */
> +static struct symbol *find_twin_by_identity_and_checksum(struct elf *elf=
, struct symbol *sym1)
> +{
> +	struct symbol *sym2, *match =3D NULL;
> +	unsigned int candidates =3D 0;
> +	u32 key;
> =20
> -		/* Level 3: file (scope changes disallowed) */
> -		if (!same_file(sym1, sym2))
> -			continue;
> -		file_orig++;
> +	if (!has_dwarf_identity(sym1) || !sym1->csum.checksum)
> +		return NULL;
> +	key =3D identity_hash(&sym1->identity);
> =20
> -		/* Level 4: checksum (unchanged symbols) */
> -		if (sym1->len !=3D sym2->len || !sym1->csum.checksum ||
> +	elf_hash_for_each_possible(elf, symbol_identity, sym2, identity_hash, k=
ey) {
> +		if (!is_twin_candidate(sym1, sym2))
> +			continue;
> +		if (sym2->twin || sym1->len !=3D sym2->len ||
>  		    sym1->csum.checksum !=3D sym2->csum.checksum)
>  			continue;
> -		csum_orig++;
> +		match =3D sym2;
> +		candidates++;
>  	}
> =20
> -	/* Count patched candidates */
> -	for_each_sym_by_demangled_name(e->patched, sym1->identity.demangled_nam=
e, sym2) {
> -		if (sym2->twin || sym1->type !=3D sym2->type || sym2->dont_correlate ||
> -		    !maybe_same_file(sym1, sym2))
> -			continue;
> -
> -		/* Level 1 */
> -		name_patched++;
> -		name_last =3D sym2;
> +	return candidates =3D=3D 1 ? match : NULL;
> +}
> =20
> -		/* Level 2 */
> -		if (is_tu_local_sym(sym1) !=3D is_tu_local_sym(sym2))
> -			continue;
> -		scope_patched++;
> -		scope_last =3D sym2;
> +static int correlate_by_identity(struct elfs *e)
> +{
> +	struct symbol *sym, *match;
> =20
> -		/* Level 3 */
> -		if (!same_file(sym1, sym2))
> +	for_each_sym(e->orig, sym) {
> +		/* Compound literal names are compiler counters, not stable identities=
. */
> +		if (sym->twin || sym->dont_correlate || is_compound_constant(sym))
>  			continue;
> -		file_patched++;
> -		file_last =3D sym2;
> -
> -		/* Level 4 */
> -		if (sym1->len !=3D sym2->len || !sym1->csum.checksum ||
> -		    sym1->csum.checksum !=3D sym2->csum.checksum)
> +		match =3D find_twin(e->patched, sym);
> +		/* Two originals can share the same sole patched candidate. */
> +		if (!match || find_twin(e->orig, match) !=3D sym)
>  			continue;
> -		csum_patched++;
> -		csum_last =3D sym2;
> +		sym->twin =3D match;
> +		match->twin =3D sym;
> +		dbg_correlate("%s(): %s -> %s", __func__, sym->name, match->name);
>  	}
> +	return 0;
> +}
> =20
> -	/* Return the widest level that yields a unique (1:1) match */
> -	if (name_orig =3D=3D 1 && name_patched =3D=3D 1)
> -		match =3D name_last;
> -	else if (scope_orig =3D=3D 1 && scope_patched =3D=3D 1)
> -		match =3D scope_last;
> -	else if (file_orig =3D=3D 1 && file_patched =3D=3D 1)
> -		match =3D file_last;
> -	else if (csum_orig =3D=3D 1 && csum_patched =3D=3D 1)
> -		match =3D csum_last;
> -
> -	if (!match)
> -		return NULL;
> +static int extend_same_twins_by_checksum(struct elfs *e)
> +{
> +	struct symbol *sym, *match;
> =20
> -	if (name_orig !=3D 1 || name_patched !=3D 1)
> -		dbg_correlate("find_twin(): %s%s -> %s%s",
> -			      sym1->name, is_func_sym(sym1) ? "()" : "",
> -			      match->name, is_func_sym(match) ? "()" : "");
> +	for_each_sym(e->orig, sym) {
> +		if (sym->twin || sym->dont_correlate)
> +			continue;
> +		match =3D find_twin_by_identity_and_checksum(e->patched, sym);
> +		/* Two originals can share the same sole patched candidate. */
> +		if (!match || find_twin_by_identity_and_checksum(e->orig, match) !=3D =
sym)
> +			continue;
> +		sym->twin =3D match;
> +		match->twin =3D sym;
> +		dbg_correlate("%s(): %s -> %s", __func__, sym->name, match->name);
> +	}
> +	return 0;
> +}
> =20
> -	return match;
> +/* Data aliases can reuse the representative's storage without another t=
win. */
> +static struct symbol *reference_twin(struct symbol *sym)
> +{
> +	if (!sym->twin && is_object_sym(sym))
> +		return sym->alias->twin;
> +	return sym->twin;
>  }

[Severity: High]
How does alias handling work across find_twin_by_identity_and_checksum(),
reference_twin(), check_linkage_changes(), and mark_changed_functions() when
non-representative alias symbols are present?

In tools/objtool/elf.c (elf_add_symbol()), when multiple symbols share the
same section, offset, type, and non-zero length, each earlier symbol has
sym->alias set to the last symbol at that offset (the representative symbol,
where sym->alias =3D=3D sym). In tools/objtool/klp-checksum.c
(calculate_checksums()), symbols with is_alias_sym(sym) (sym->alias !=3D sy=
m)
are skipped, so read_sym_checksums() populates sym->csum.checksum only on
the representative symbol and leaves sym->csum.checksum as 0 on all other
aliases at that address.

However, correlate_by_identity() correlates symbols regardless of
is_alias_sym(sym), which appears to cause several issues:

1. In mark_changed_functions(), orig_sym->csum.checksum !=3D
   patched_sym->csum.checksum is compared directly instead of via
   orig_sym->alias->csum.checksum and patched_sym->alias->csum.checksum. If
   constant merging or symbol ordering changes whether a correlated symbol
   is the representative (checksum !=3D 0) versus a non-representative alias
   (checksum =3D=3D 0) between orig and patched, mark_changed_functions()
   compares a non-zero checksum against 0 and aborts with
   ERROR("changed data: %s") on unchanged data (or falsely marks an
   unchanged function as changed). Conversely, if both sides of a correlated
   pair are non-representative aliases (checksum =3D=3D 0 on both sides) wh=
ile
   the representative symbol is uncorrelated, mark_changed_functions()
   compares 0 !=3D 0 and misses actual data modifications.

2. In find_twin_by_identity_and_checksum(), sym1->csum.checksum and
   sym2->csum.checksum are checked directly instead of
   sym1->alias->csum.checksum and sym2->alias->csum.checksum, so
   non-representative aliases always have checksum =3D=3D 0 and cannot be
   disambiguated by checksum.

3. In reference_twin(), sym->alias only points one-way from earlier symbols
   to the representative symbol. If an earlier non-representative alias at
   the same address was correlated while the representative symbol itself
   was not correlated, calling reference_twin() on the representative symbol
   evaluates sym->alias->twin (which is sym->twin =3D=3D NULL) and fails to=
 find
   the correlated alias's twin.

4. In check_linkage_changes(), orig_sym->twin and patched_sym->twin are
   checked directly rather than reference_twin(orig_sym) and
   reference_twin(patched_sym).

> =20
> -struct llvm_suffix_pair {
> +struct symtab_entry {
>  	struct hlist_node hash;
> -	const char *orig;
> -	const char *patched;
> +	const char *file, *name;
> +	struct symbol *sym;
> +	bool is_unique;
> +};
> +
> +struct symtab_hash {
> +	DECLARE_HASHTABLE(entries, 12);
>  };
> =20
> -static DECLARE_HASHTABLE(suffix_map, 7);
> +static struct symtab_entry *find_symtab_entry(struct symtab_hash *table,=
 struct symbol *sym)
> +{
> +	const char *file =3D sym->file ? sym->file->name : "";
> +	const char *name =3D sym->identity.demangled_name;
> +	u32 key =3D jhash_2words(str_hash(file), str_hash(name), 0);
> +	struct symtab_entry *entry;
> =20
> -/*
> - * Build a mapping of known orig-to-patched LLVM suffixes based on
> - * already-correlated symbol pairs.  All promoted symbols from the same =
TU
> - * share the same .llvm.<hash> suffix, so one correlated pair seeds the =
map
> - * for the entire TU.
> - */
> -static int update_suffix_map(struct elf *elf)
> +	hash_for_each_possible(table->entries, entry, hash, key) {
> +		if (!strcmp(entry->file, file) && !strcmp(entry->name, name))
> +			return entry;
> +	}
> +	return NULL;
> +}
> +
> +static int build_symtab_hash(struct elf *elf, struct symtab_hash *table)
>  {
> -	struct llvm_suffix_pair *entry;
> +	struct symtab_entry *entry;
>  	struct symbol *sym;
> +	u32 key;
> =20
> +	hash_init(table->entries);
>  	for_each_sym(elf, sym) {
> -		const char *s1, *s2;
> -		bool found;
> -
> -		if (!sym->twin)
> +		if (!sym->len || is_undef_sym(sym) || sym->dont_correlate ||
> +		    is_compound_constant(sym))
>  			continue;
> -
> -		s1 =3D llvm_suffix(sym->name);
> -		s2 =3D llvm_suffix(sym->twin->name);
> -
> -		if (!s1 || !s2)
> +		/* Already matched symbols still count against uniqueness. */
> +		entry =3D find_symtab_entry(table, sym);
> +		if (entry) {
> +			entry->is_unique =3D false;
>  			continue;
> -
> -		found =3D false;
> -		hash_for_each_possible(suffix_map, entry, hash, str_hash(s1)) {
> -			if (!strcmp(entry->orig, s1)) {
> -				found =3D true;
> -				break;
> -			}
>  		}
> -		if (found)
> -			continue;
> -
> -		entry =3D calloc(1, sizeof(*entry));
> +		entry =3D malloc(sizeof(*entry));
>  		if (!entry) {
> -			ERROR_GLIBC("calloc");
> +			ERROR_GLIBC("malloc symtab entry");
>  			return -1;
>  		}
> -
> -		entry->orig =3D s1;
> -		entry->patched =3D s2;
> -		hash_add(suffix_map, &entry->hash, str_hash(s1));
> +		/* Assembly may inherit FILE from the preceding input. */
> +		entry->file =3D sym->file ? sym->file->name : "";
> +		entry->name =3D sym->identity.demangled_name;
> +		entry->sym =3D sym;
> +		entry->is_unique =3D true;
> +		key =3D jhash_2words(str_hash(entry->file), str_hash(entry->name), 0);
> +		hash_add(table->entries, &entry->hash, key);
>  	}
> -
>  	return 0;
>  }

[Severity: Medium]
Should find_symtab_entry() and build_symtab_hash() use
sym->file->identity.source instead of sym->file->name?

In tools/objtool/klp-identity.c (prepare_identities()), STT_FILE symbols
have sym->identity.source initialized to sym->name and then updated by
complete_file_source() in tools/objtool/klp-dwarf.c with the full normalized
DWARF CU path.

By reading sym->file->name here instead of sym->file->identity.source,
sym->file->identity.source is never read after complete_file_source(), and
in multi-TU objects such as vmlinux.o where different directories share an
STT_FILE basename (for example, drivers/base/core.c and net/core/core.c),
symbols from different translation units collide in symtab_hash under the
same basename.

[ ... ]

> @@ -744,102 +731,67 @@ static struct symbol *find_twin_positional(struct =
elfs *e, struct symbol *sym1)
>  {
> -	unsigned int idx_orig =3D 0, idx_patched =3D 0;
> -	unsigned int sym1_pos =3D 0;
> -	struct symbol *sym2, *match =3D NULL;
> +	struct symtab_hash orig_table =3D {}, patched_table =3D {};
> +	struct symtab_entry *orig_entry, *patched_entry;
> +	struct symbol *orig_sym, *patched_sym;
> +	int ret =3D -1;
> =20
> -	for_each_sym_by_demangled_name(e->orig, sym1->identity.demangled_name, =
sym2) {
> -		if (sym2->twin || sym1->type !=3D sym2->type || sym2->dont_correlate ||
> -		    !maybe_same_file(sym1, sym2))
> +	if (build_symtab_hash(e->orig, &orig_table) ||
> +	    build_symtab_hash(e->patched, &patched_table))
> +		goto out;
> +
> +	for_each_sym(e->patched, patched_sym) {
> +		if (!patched_sym->len || is_undef_sym(patched_sym) ||
> +		    patched_sym->dont_correlate || reference_twin(patched_sym))
>  			continue;

[Severity: Medium]
What happens to defined zero-length symbols (where sym->len =3D=3D 0, such =
as
assembly SYM_INNER_LABEL or SYM_DATA_END_LABEL markers like __bhi_args_end,
hv_crash_asm_end, ftrace_caller_end, or empty C arrays) when they are
referenced by a changed function?

Previously, find_twin() correlated defined zero-length symbols by name,
scope, and file because only Level 4 (checksum) required sym->len > 0. With
this commit, is_dwarf_identity_candidate() in tools/objtool/klp-identity.c
requires sym->len, and both build_symtab_hash() and validate_symbol_twins()
skip !sym->len. (In the follow-up commits "objtool/klp: Extend twins through
unchanged function references" and "objtool/klp: Check unmatched data
references", extend_twins_by_relocations() only walks relocations in
unchanged functions and check_unmatched_reference() also skips
!patched_sym->len.)

If a changed function references an existing unexported or local defined
zero-length symbol that is not referenced by an unchanged function in the
object, reference_twin(patched_sym) remains NULL, klp_reloc_needed() returns
false, and clone_reloc() clones a new 0-byte symbol into the livepatch
module instead of emitting a KLP relocation to the original symbol.

> -		if (is_tu_local_sym(sym1) !=3D is_tu_local_sym(sym2) ||
> -		    is_llvm_sym(sym1) !=3D is_llvm_sym(sym2))
> +		patched_entry =3D find_symtab_entry(&patched_table, patched_sym);
> +		if (!patched_entry || !patched_entry->is_unique)
>  			continue;
> -		if (sym1 =3D=3D sym2)
> -			sym1_pos =3D idx_orig;
> -		idx_orig++;
> -	}
> -
> -	for_each_sym_by_demangled_name(e->patched, sym1->identity.demangled_nam=
e, sym2) {
> -		if (sym2->twin || sym1->type !=3D sym2->type || sym2->dont_correlate ||
> -		    !maybe_same_file(sym1, sym2))
> +		orig_entry =3D find_symtab_entry(&orig_table, patched_sym);
> +		if (!orig_entry || !orig_entry->is_unique)
>  			continue;
> -		if (is_tu_local_sym(sym1) !=3D is_tu_local_sym(sym2) ||
> -		    is_llvm_sym(sym1) !=3D is_llvm_sym(sym2))
> +		orig_sym =3D orig_entry->sym;
> +		if (reference_twin(orig_sym))
>  			continue;
> -		if (idx_patched =3D=3D sym1_pos)
> -			match =3D sym2;
> -		idx_patched++;
> -	}
> -
> -	if (idx_orig !=3D idx_patched)
> -		return NULL;
> -
> -	dbg_correlate("find_twin_positional(): %s%s -> %s%s",
> -	    sym1->name, is_func_sym(sym1) ? "()" : "",
> -	    match->name, is_func_sym(match) ? "()" : "");
> -
> -	return match;
> +		if (strcmp(orig_sym->name, patched_sym->name) ||
> +		    orig_sym->bind !=3D patched_sym->bind ||
> +		    !is_twin_candidate(orig_sym, patched_sym))
> +			continue;
> +		if (has_dwarf_identity(orig_sym) !=3D has_dwarf_identity(patched_sym))=
 {
> +			WARN("unmatched symbol %s (FILE %s): DWARF identity is missing on the=
 %s side",
> +			     patched_sym->name,
> +			     *patched_entry->file ? patched_entry->file : "<none>",
> +			     has_dwarf_identity(orig_sym) ? "patched" : "original");
> +			continue;
> +		}
> +		if (!known_symtab_fallback(orig_sym) || !known_symtab_fallback(patched=
_sym))
> +			WARN("ELF FILE/name fallback outside known rules: %s (FILE %s, bindin=
g %u, DWARF %s), orig[%u] -> patched[%u]",
> +			     patched_sym->name,
> +			     *patched_entry->file ? patched_entry->file : "<none>",
> +			     patched_sym->bind, has_dwarf_identity(patched_sym) ? "yes" : "no=
",
> +			     orig_sym->idx, patched_sym->idx);
> +		orig_sym->twin =3D patched_sym;
> +		patched_sym->twin =3D orig_sym;
> +		dbg_correlate("%s(): %s (FILE %s)", __func__,
> +			      patched_sym->name, patched_entry->file);
> +	}
> +	ret =3D 0;
> +out:
> +	free_symtab_hash(&orig_table);
> +	free_symtab_hash(&patched_table);
> +	return ret;
>  }
> =20
>  /*
> @@ -850,96 +833,61 @@ static struct symbol *find_twin_positional(struct e=
lfs *e, struct symbol *sym1)
>   */
>  static int correlate_symbols(struct elfs *e)
>  {
> -	struct symbol *file1_sym, *file2_sym;
> -	struct symbol *sym1, *sym2;
> -	bool progress;
> -
> -	for_each_sym(e->orig, sym1)
> -		sym1->dont_correlate =3D dont_correlate(sym1);
> -	for_each_sym(e->patched, sym2)
> -		sym2->dont_correlate =3D dont_correlate(sym2);
> -
> -	/* Correlate FILE symbols */
> -	file1_sym =3D first_file_symbol(e->orig);
> -	file2_sym =3D first_file_symbol(e->patched);
> -
> -	for (; ; file1_sym =3D next_file_symbol(e->orig, file1_sym),
> -		 file2_sym =3D next_file_symbol(e->patched, file2_sym)) {
> -
> -		if (!file1_sym && file2_sym) {
> -			ERROR("FILE symbol mismatch: NULL !=3D %s", file2_sym->name);
> -			return -1;
> -		}
> +	struct symbol *sym;
> =20
> -		if (file1_sym && !file2_sym) {
> -			ERROR("FILE symbol mismatch: %s !=3D NULL", file1_sym->name);
> -			return -1;
> -		}
> +	for_each_sym(e->orig, sym)
> +		sym->dont_correlate =3D dont_correlate(sym);
> +	for_each_sym(e->patched, sym)
> +		sym->dont_correlate =3D dont_correlate(sym);
> =20
> -		if (!file1_sym)
> -			break;
> +	if (prepare_identities(e->orig) || prepare_identities(e->patched))
> +		return -1;
> =20
> -		if (strcmp(file1_sym->name, file2_sym->name)) {
> -			ERROR("FILE symbol mismatch: %s !=3D %s", file1_sym->name, file2_sym-=
>name);
> -			return -1;
> -		}
> +	if (correlate_by_identity(e) ||
> +	    extend_same_twins_by_checksum(e) ||
> +	    validate_symbol_twins(e))
> +		return -1;
> =20
> -		file1_sym->twin =3D file2_sym;
> -		file2_sym->twin =3D file1_sym;
> +	for_each_sym(e->orig, sym) {
> +		if (!sym->len || is_compound_constant(sym))
> +			continue;
> +		if (!reference_twin(sym) && !sym->dont_correlate)
> +			WARN("no correlation: %s", sym->name);
>  	}
> =20
> +	return 0;
> +}
> =20
> -	/*
> -	 * Correlate in two phases: loop deterministic levels until no more
> -	 * progress, then use positional fallback for the rest.  This prevents
> -	 * the nondeterministic positional matching from stealing symbols that
> -	 * have deterministic matches.
> -	 */
> -	hash_init(suffix_map);
> -	do {
> -		progress =3D false;
> -		for_each_sym(e->orig, sym1) {
> -			if (sym1->twin || sym1->dont_correlate)
> -				continue;
> -			sym2 =3D find_twin(e, sym1);
> -			if (!sym2)
> -				continue;
> -			sym1->twin =3D sym2;
> -			sym2->twin =3D sym1;
> -			progress =3D true;
> -		}
> +static int check_linkage_changes(struct elfs *e)
> +{
> +	struct symbol *orig_sym, *patched_sym;
> =20
> -		if (update_suffix_map(e->orig))
> -			return -1;
> +	for_each_sym(e->orig, orig_sym) {
> +		if (orig_sym->twin || orig_sym->dont_correlate ||
> +		    !has_dwarf_identity(orig_sym) || is_undef_sym(orig_sym) || !orig_s=
ym->len)
> +			continue;
> =20
> -		for_each_sym(e->orig, sym1) {
> -			if (sym1->twin || sym1->dont_correlate)
> +		/*
> +		 * Identities distinguish linkage changes, but later name-based
> +		 * resolution can bind references to the wrong state. Reject them.
> +		 */
> +		for_each_sym_by_demangled_name(e->patched, orig_sym->identity.demangle=
d_name,
> +					       patched_sym) {
> +			if (patched_sym->twin || patched_sym->dont_correlate ||
> +			    !has_dwarf_identity(patched_sym) ||
> +			    is_undef_sym(patched_sym) || !patched_sym->len)
>  				continue;
> -			sym2 =3D find_twin_suffixed(e->patched, sym1);
> -			if (!sym2)
> +			if (orig_sym->type !=3D patched_sym->type ||
> +			    strcmp(orig_sym->identity.scope, patched_sym->identity.scope) ||
> +			    orig_sym->identity.external =3D=3D patched_sym->identity.external)
>  				continue;
> -			sym1->twin =3D sym2;
> -			sym2->twin =3D sym1;
> -			progress =3D true;
> +			ERROR("unsupported linkage change (%s, %s): original %s symtab[%u] (e=
xternal=3D%d), patched %s symtab[%u] (external=3D%d)",
> +			      orig_sym->identity.scope, orig_sym->identity.demangled_name,
> +			      orig_sym->name, orig_sym->idx, orig_sym->identity.external,
> +			      patched_sym->name, patched_sym->idx, patched_sym->identity.exte=
rnal);
> +			return -1;
>  		}
> -	} while (progress);

[Severity: Medium]
Does check_linkage_changes() need to verify that orig_sym and patched_sym
come from the same translation unit before reporting an unsupported linkage
change?

In tools/objtool/klp-dwarf.c (get_die_identity() and
needs_identity_source()), global and weak external definitions have
identity.source set to "" and identity.scope set to "/". File-scope static
definitions also have identity.scope set to "/" (with
identity.external =3D=3D false).

In multi-TU objects such as vmlinux.o or multi-file modules, if one
translation unit has an uncorrelated file-scope static symbol (for example,
a static helper that was inlined or removed by the patch) and a different
translation unit has an uncorrelated global symbol with the same demangled
name and type (for example, a newly added global function), both have
identity.scope =3D=3D "/" with opposite identity.external values, causing
check_linkage_changes() to abort with an unsupported linkage change error
across unrelated translation units.

> @@ -1110,7 +1058,8 @@ static int mark_changed_functions(struct elfs *e)
> =20
>  	/* Find added functions and print them */
>  	for_each_sym(e->patched, patched_sym) {
> -		if (!is_func_sym(patched_sym) || patched_sym->dont_correlate)
> +		if (!is_func_sym(patched_sym) || patched_sym->dont_correlate ||
> +		    is_undef_sym(patched_sym))
>  			continue;
> =20
>  		if (!patched_sym->twin) {

[Severity: High]
When an existing function remains uncorrelated (patched_sym->twin =3D=3D NU=
LL)
because of ambiguity or a missing DWARF identity on one side, doesn't
mark_changed_functions() misclassify it as a newly added function?

For STT_FUNC symbols, multiple compiler clones of the same function in a
translation unit (such as foo.isra.0 and foo.isra.1, or foo.part.0 and
foo.part.1) have distinct ELF symbol names (so validate_dwarf_identity()
permits them) but share the same DWARF identity and match
compatible_symbol_name(). Likewise, functions missing a DWARF identity on
one side are skipped with only a warning in validate_symbol_twins().

When such a function is modified (or when two clones have identical
checksums and are not disambiguated by an unchanged caller),
patched_sym->twin remains NULL. In mark_changed_functions(), the loop over
e->patched treats any !patched_sym->twin function as a newly added function
(setting included =3D 1 while leaving changed =3D 0), so create_klp_section=
s()
does not emit a klp_func_ext livepatch entry for the modified function and
the original function in the running kernel remains unpatched. (The
follow-up commit "objtool/klp: Check unmatched data references" only checks
is_object_sym(patched_sym) in check_unmatched_reference() and does not check
uncorrelated STT_FUNC symbols.)

> diff --git a/tools/objtool/tests/generic/test-thinlto-ambiguity.sh b/tool=
s/objtool/tests/generic/test-thinlto-ambiguity.sh
> index 34f4f3a58e201..4e0e49a9fc567 100755
> --- a/tools/objtool/tests/generic/test-thinlto-ambiguity.sh
> +++ b/tools/objtool/tests/generic/test-thinlto-ambiguity.sh
> @@ -38,7 +38,7 @@ build_thinlto()		# $1 output object, $2 extra flags
>  {
>  	local t
>  	for t in "" -DTU_B -DTU_C; do
> -		$THIN_CC -flto=3Dthin -O2 -ffunction-sections -fdata-sections \
> +		$THIN_CC -flto=3Dthin -O2 -g -ffunction-sections -fdata-sections \
>  			$2 $t -c "$FIXTURES_DIR/thinlto_ambiguity.c" \
>  			-o "$workdir/tu$t.o" 2>/dev/null || return 1
>  	done
> diff --git a/tools/objtool/tests/lib.sh b/tools/objtool/tests/lib.sh
> index 8e1aa7614dc68..44ce670c4a6c3 100644
> --- a/tools/objtool/tests/lib.sh
> +++ b/tools/objtool/tests/lib.sh

[ ... ]

> @@ -150,7 +151,7 @@ EOF
>  #					checksum
>  #
>  # A test overrides it; see tools/objtool/Documentation/klp-write-tests.t=
xt.
> -FIXTURE_CFLAGS=3D"-O2 -ffunction-sections -fdata-sections -fno-common \
> +FIXTURE_CFLAGS=3D"-O2 -g -ffunction-sections -fdata-sections -fno-common=
 \
>  		-fno-asynchronous-unwind-tables"
> =20
>  test_name=3D"$(basename "$0" .sh)"

[Severity: Medium]
As noted in the commit message, test-local-to-global-flip.sh,
test-sympos.sh, and test-sympos-vmlinux.sh now fail when running the objtool
test suite.

For test-sympos.sh and test-sympos-vmlinux.sh, those tests exercise
klp_find_sympos() and .klp.symid disambiguation for duplicate local symbols
across translation units (which is still used in clone_reloc_klp() and
create_klp_sections()), and only fail because the test scripts simulate two
translation units by compiling the same fixture .c file twice with -g,
giving both objects the same DWARF CU path. Similarly,
test-thinlto-ambiguity.sh compiles thinlto_ambiguity.c three times with -g,
giving both promoted helper.llvm.<hash> functions the same DWARF CU path
instead of distinct per-TU paths, so at this commit the changed helper fails
correlation and is emitted as a new function with no klp_func_ext entry.

Should the multi-TU test scripts compile distinct source paths (or override
-fdebug-prefix-map) so sympos and ThinLTO multi-TU disambiguation remain
tested, and should test-local-to-global-flip.sh be updated to test the new
linkage-change rejection so the test suite passes cleanly?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104133158.3187=
525-1-luolongjuna@gmail.com?part=3D7
