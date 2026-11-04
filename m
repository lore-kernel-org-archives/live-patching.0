Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793800308;
	b=2807okP3EPhvuEbt2jnE0V3CnfVP3ibONtfoGZRsL72fI86qeUYaBIp+dsRtDNbUiPgi
	 +vCEVMJ287GNVrYW5DHdTgOr9wPPdYx01CJoBs1tXKqnjxxFD51cRIAxVgjNTXCbz1cFx
	 hTlYn1B+fP1gAEnG4rQWqy41ntdDsyVnQzQCBYk6Zc0GCYC1ughC9EgveLVKizSQTL6fJ
	 isJ399mC+da24Q++ZPffxXAJ1nCLo/XNWNdXNkaWlY6B6lL4X3sqki5L1fmhDXMZydAa0
	 RS0rTVRlOfPWWhlgVgjL4wJUf3JQ1GGlPB9R2ItDSsrCFBgEkcmqrghqYCEzOlM7FSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793800308;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=L2Vksz3aK0QoXbVx4c/e/m1jcX+T0gMiWfGCJruQb/s=;
	b=f97HPcLN9DfRBuqoKj/AtFGe+CZFm+E23Wb1iGWjhindH3FzzL1Cm1Ij6Dh5Wq4c4I1X
	 EvnxCRxw5ekJHnWiaJBM89lOXMDgg+3VWRpz6hMahzfQw8baC737yCSEl0zZ+M5mMFT52
	 8yE8Qi+W74Mga3oNf1hR1OXTToukOIvQMJw897uqcla591fJWGk/I8xea9YUBh792DWB4
	 iY+DhC90H6J5664NPBQzPPl0VGu57ZU9NRKXs/zsIcvcosIWU8hrF0epjXS95yzkkDs/Y
	 73ArQcAyRWm6MHj4m4tOWNZUsg6/zfAobB8EWQ7gDpAcwAlYfhPG/2b6I9RC24V7FnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H9yljXsa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3D7606A31B
	for <live-patching@vger.kernel.org>; Wed,  4 Nov 2026 13:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H9yljXsa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AECB41F00919;
	Wed,  4 Nov 2026 13:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793800308;
	bh=L2Vksz3aK0QoXbVx4c/e/m1jcX+T0gMiWfGCJruQb/s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H9yljXsa230wpPrFPGt3U2oPqfjKc0txpT0IATBulN2dwDEDkKSOy/5T+GvmirJD1
	 5+xzYLzenxArGOUbvPZPWLqRn3gIBsmqfEF5TCrvBbGhm8xIXVfoXTDmUEXEANjr9f
	 1CtVmA74eYfaQKRNhYBBGvRuFwp/sKGdhPKL89quOYdBuNWdcuvAlBgrCxMXuXQDwc
	 9i7f9i4kpJa+hzv1q42jFlsQSyLa5obAEtz5a/Nq3+mi8Rg/vmV6tJr0mY1p/sNt9l
	 49iL2/18EL0MmfIafFblu7eMY5Ps3i2pWn00aftWZzti/n0ibYtFZ0ilqbZzGuewhs
	 PpFLOFxwLYZMw==
Message-ID: <sashiko-outbox-197358@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 04/11] objtool/klp: Read symbol identities from
 DWARF
Reply-To: sashiko-reviews@lists.linux.dev
To: "Longjun Luo" <luolongjuna@gmail.com>, jpoimboe@kernel.org, peterz@infradead.org
Cc: mbenes@suse.cz, pmladek@suse.com, joe.lawrence@redhat.com, song@kernel.org, puranjay@kernel.org, nathan@kernel.org, ndesaulniers@google.com, morbo@google.com, justinstitt@google.com, live-patching@vger.kernel.org
In-Reply-To: <20261104133158.3187525-5-luolongjuna@gmail.com>
References: <20261104133158.3187525-1-luolongjuna@gmail.com>
 <20261104133158.3187525-5-luolongjuna@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 13:51:47 +0000
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Medium] objtool/klp: broken external and source filtering in fallback_by=
_name()
- [Medium] objtool/klp: mishandled .data.rel.ro and aliases in get_identity=
_for_symbol()
- [Medium] objtool/klp: check_relocations() fails on SHN_UNDEF debug reloca=
tions
- [Medium] objtool/klp: missing .lto_priv handling in matches_name() and de=
mangle_name()
--

commit bb3cdda02c19261801a05f1c255cd9e10ae1e2cb
Author: Longjun Luo <luolongjuna@gmail.com>

objtool/klp: Read symbol identities from DWARF

This commit adds a libdw-based DWARF reader to extract defining translation
units and enclosing scope chains for ELF symbols in objtool KLP builds. It
indexes DIE addresses and names, resolves abstract origins and specificatio=
ns,
and validates DWARF symbol identities against STT_FILE symbols.

> diff --git a/tools/objtool/klp-dwarf.c b/tools/objtool/klp-dwarf.c
> new file mode 100644
> index 0000000000000..99b098ee7904f
> --- /dev/null
> +++ b/tools/objtool/klp-dwarf.c
> @@ -0,0 +1,1181 @@

[ ... ]

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

[Severity: Medium]
As reported by Sashiko on RFC [1], won't check_relocations() fail on valid
ET_REL kernel and module objects whose .debug_info or .debug_addr sections
reference external (SHN_UNDEF) symbols?

When build_identities() reports a single offline ET_REL object via
dwfl_report_offline(), libdwfl only sets sh_size to 0 on a relocation secti=
on
when every relocation in that section is resolved.

In ET_REL objects compiled with -O2 -g, .rela.debug_info (DWARF 4) and
.rela.debug_addr (DWARF 5) can contain relocations against SHN_UNDEF symbols
(for example, optimized-out pointers initialized to the address of an exter=
nal
symbol via DW_OP_addr or DW_OP_addrx with DW_OP_stack_value, or
DW_TAG_call_site targets). Because libdwfl leaves those SHN_UNDEF relocatio=
ns
in place with sh.sh_size non-zero, check_relocations() will reject the obje=
ct
with "unapplied relocations for .debug_info" or ".debug_addr" unless it che=
cks
whether the remaining relocations only target SHN_UNDEF symbols.

[ ... ]

> +/* Match DW_AT_name verbatim; accept compiler suffixes only on the ELF n=
ame. */
> +static bool matches_name(const char *name, const char *identifier)
> +{
> +	size_t len =3D strlen(identifier);
> +
> +	if (strncmp(name, identifier, len))
> +		return false;
> +	name +=3D len;
> +	while (*name) {
> +		if (strstarts(name, ".llvm."))
> +			name +=3D 5;
> +		if (*name++ !=3D '.' || !isdigit((unsigned char)*name))
> +			return false;
> +		while (isdigit((unsigned char)*name))
> +			name++;
> +	}
> +	return true;
> +}

[Severity: Medium]
As reported by Sashiko on RFC [2], how are GCC LTO .lto_priv.<N> suffixes
handled in matches_name() and in sym->identity.demangled_name?

In matches_name(), the suffix loop only skips .llvm.<digits> and .<digits>,=
 so
an ELF symbol renamed by GCC LTO with .lto_priv.<N> will fail to match its
DW_AT_name in matches_dwarf_name().

Similarly, demangled_name_len() in tools/objtool/elf.c only strips .llvm.* =
and
trailing .<digits>, so foo demangles to foo while foo.lto_priv.0 demangles =
to
foo.lto_priv, and foo.lto_priv.0.part.0 vs foo.lto_priv.1.part.0 demangle to
foo.lto_priv.0.part vs foo.lto_priv.1.part. Because identity_hash(),
same_identity(), and identity->path in tools/objtool/klp-identity.c use
identity->demangled_name directly, won't symbols whose .lto_priv.<N> suffix=
 is
added, removed, or renumbered before a clone tag end up with mismatched
identities across builds?

[ ... ]

> +static bool needs_identity_source(struct symbol *sym, bool external)
> +{
> +	return !external || (!is_global_sym(sym) && !is_weak_sym(sym));
> +}
> +
> +static void get_die_identity(struct identity_die *entry, struct symbol *=
sym,
> +			     struct identity *identity)
> +{
> +	const char *source =3D entry->source;
> +
> +	identity->scope =3D entry->scope;
> +	identity->external =3D entry->external;
> +	if (entry->cu->assembly) {
> +		source =3D entry->cu->path;
> +		identity->scope =3D "/";
> +		/* Assembly linkage is not subject to LTO promotion/internalization. */
> +		identity->external =3D sym->bind !=3D STB_LOCAL;
> +	}
> +	identity->source =3D needs_identity_source(sym, identity->external) ? s=
ource : "";
> +}

[ ... ]

> +/* GCC may omit address attributes for IPA-ICF wrappers such as msr_even=
t_del. */
> +static int fallback_by_name(struct elf *elf, struct symbol *sym, struct =
identity_cu **matched_cu)
> +{
> +	const char *name =3D sym->pfunc->identity.demangled_name;
> +	const char *file =3D sym->file ? basename(sym->file->name) : NULL;
> +	struct identity_die *entry, *match =3D NULL;
> +	struct identity candidate, matched;
> +
> +	if (!is_func_sym(sym) && !(is_object_sym(sym) && is_rodata_sec(sym->sec=
)))
> +		return 1;
> +	elf_hash_for_each_possible(elf, dwarf_name, entry, name_hash, str_hash(=
name)) {
> +		if (entry->type !=3D sym->type || strcmp(name, entry->name))
> +			continue;
> +		/* Different CUs can have the same FILE basename and function name. */
> +		if (is_func_sym(sym) && !cu_contains_symbol(entry->cu, sym))
> +			continue;
> +		get_die_identity(entry, sym, &candidate);
> +		if (!candidate.source)
> +			return 1;
> +		if (!entry->cu->assembly && !candidate.external && file &&
> +		    strcmp(file, basename(candidate.source)) &&
> +		    !known_file_name_mismatch(file, basename(candidate.source)))
> +			continue;
> +		if (match) {
> +			get_die_identity(match, sym, &matched);
> +			if (strcmp(matched.source, candidate.source) ||
> +			    strcmp(matched.scope, candidate.scope) ||
> +			    matched.external !=3D candidate.external)
> +				return 1;
> +		}
> +		match =3D entry;
> +	}
> +	if (!match)
> +		return 1;
> +	*matched_cu =3D match->cu;
> +	get_die_identity(match, sym, &sym->identity);
> +	return 0;
> +}

[Severity: Medium]
Can the candidate.external and candidate.source checks in fallback_by_name()
cause unrelated DIEs from other translation units to match or collide?

In read_symbols(), sym->file is only populated when sym->bind =3D=3D STB_LO=
CAL.
For an STB_LOCAL symbol, needs_identity_source() always returns true even w=
hen
entry->external is true, so candidate.source is set to entry->source.

However, the STT_FILE comparison in fallback_by_name() is guarded by
!candidate.external:

	if (!entry->cu->assembly && !candidate.external && file &&
	    strcmp(file, basename(candidate.source)) &&
	    !known_file_name_mismatch(file, basename(candidate.source)))
		continue;

Because of this:

1. When looking up an STB_LOCAL symbol (such as a read-only object where
   cu_contains_symbol() is not called, or a local function in a shared
   section), any DW_AT_external DIE with the same name in another CU has
   candidate.external =3D=3D true and bypasses the file check. It will then=
 either
   collide with the local symbol's own DIE at the match comparison (causing
   fallback_by_name() to return 1) or be chosen as the match for the local
   symbol.

2. Conversely, when sym is STB_GLOBAL or STB_WEAK (where file is NULL),
   fallback_by_name() does not filter out non-external (!candidate.external)
   static DIEs from other CUs, allowing a static DIE in another CU to colli=
de
   with the global DIE.

3. In addition, index_identities() adds external DIEs to dwarf_name even wh=
en
   entry->source is NULL. Checking if (!candidate.source) return 1; inside =
the
   loop before filtering out unrelated CUs aborts the entire search on the
   first sourceless external DIE from another CU rather than continuing to
   remaining candidates.

> +
> +int get_identity_for_symbol(struct elf *elf, struct symbol *sym)
> +{
> +	struct identity *identity =3D &sym->identity, candidate;
> +	struct section *sec =3D sym->sec;
> +	struct identity_cu *cu =3D NULL;
> +	struct die_address *address;
> +	struct identity_die *entry;
> +	unsigned int nr =3D 0, nr_both_matched =3D 0;
> +	bool source_unavailable =3D false;
> +	const char *error, *saved_objname =3D objname;
> +
> +	identity->source =3D "";
> +	identity->scope =3D NULL;
> +	identity->external =3D false;
> +	elf_hash_for_each_possible(elf, dwarf_address, address, hash, sym->offs=
et ^ sec->idx) {
> +		if (!address_matches_symbol(address, sym))
> +			continue;
> +		entry =3D address->die;
> +		nr++;
> +		if (matches_dwarf_name(entry, sym->name))
> +			nr_both_matched++;
> +	}
> +	if (!nr) {
> +		int ret =3D fallback_by_name(elf, sym, &cu);
> +
> +		if (ret =3D=3D 1)
> +			ret =3D check_if_assembly(elf, sym, &cu);
> +		if (ret)
> +			return ret;
> +		goto found;
> +	}
> +
> +	/*
> +	 * ICF/constant merging can leave several definitions after name
> +	 * filtering. FIXME: Folded objects can remain uncorrelated when
> +	 * their checksums change.
> +	 */
> +	if (nr_both_matched > 1 && strstarts(sec->name, ".rodata"))
> +		return 1;
> +
> +	/*
> +	 * Prefer address and name. Compiler clones, syscall/weak aliases and
> +	 * objcopy's __pi_ prefix can differ from DW_AT_name. If no name matche=
s,
> +	 * accept address candidates only when their identities agree below.
> +	 */
> +	objname =3D elf->name;
> +	elf_hash_for_each_possible(elf, dwarf_address, address, hash, sym->offs=
et ^ sec->idx) {
> +		if (!address_matches_symbol(address, sym))
> +			continue;
> +		entry =3D address->die;
> +		if (nr_both_matched && !matches_dwarf_name(entry, sym->name))
> +			continue;
> +		get_die_identity(entry, sym, &candidate);
> +		error =3D "conflicting declarations";
> +		if (identity->scope && strcmp(identity->scope, candidate.scope))
> +			goto failed;
> +		error =3D "conflicting external declarations";
> +		if (identity->scope && identity->external !=3D candidate.external)
> +			goto failed;

[Severity: Medium]
As reported by Sashiko on RFC [3], there appear to be two issues in
get_identity_for_symbol() when handling folded read-only objects and aliase=
s:

1. The constant-merging check tests strstarts(sec->name, ".rodata") instead=
 of
   is_rodata_sec(sec) (which fallback_by_name() uses above). Because
   mark_rodata() marks both .rodata* and .data.rel.ro* sections as rodata,
   won't folded static const objects containing relocated pointers in
   .data.rel.ro or .data.rel.ro.local (or __pi_-prefixed merged read-only
   objects where nr > 1 and nr_both_matched =3D=3D 0) fall through into the=
 loop
   and fail with a fatal "conflicting declarations" or "conflicting source
   CUs" error?

2. When an STB_GLOBAL or STB_WEAK symbol is an alias of a static (STB_LOCAL)
   symbol (for example, a __x64_sys_* syscall stub aliasing a static
   __do_sys_* function), the alias itself often has no concrete DWARF DIE at
   that address, leaving only the static target DIE (nr =3D=3D 1,
   nr_both_matched =3D=3D 0). In that case, the loop accepts the static tar=
get's
   DIE and get_die_identity() assigns identity->external =3D false and a
   non-empty CU source path to the global or weak alias symbol (or fails at
   "conflicting external declarations" if both the static target DIE and an
   external alias/weak DIE exist at the same address). Should a global or w=
eak
   symbol matched to a non-external DIE at the same address still be treated
   as external?

[1] https://lore.kernel.org/r/sashiko-outbox-185077@kernel.org
[2] https://lore.kernel.org/r/sashiko-outbox-185077@kernel.org
[3] https://lore.kernel.org/r/sashiko-outbox-185077@kernel.org

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104133158.3187=
525-1-luolongjuna@gmail.com?part=3D4
