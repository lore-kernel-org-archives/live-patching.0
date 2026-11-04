Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793801168;
	b=py63xgaJ9d0jFOwNdQszN9juZgrQeNnpn/btj5HfnjwXFOkvWcBp0UlB+tsH3EyAxruY
	 XOMAphbXysX/CbuORTeGJ+OvV29zykqmW5GCBimGnHQUtFts6BHv5E6D6Nhg0Cht37R7i
	 FoqfhyuGxUyvl6GbyunUM9QbS8bvfWmWjl/iyReoh64d7lwc9u/aXDaMSLwYQMlSrIWEp
	 GM++COrzHa4mu9Tvv61ardD+M/KcFcbxkXMGNJN0KiFqya7i7TGbs6JvHcT2ivJpRBqO4
	 0yoEs5xFWqIavjpxIyww4dOBXv9XI0nFac55WhIDWk16gU6PB1euu0Xf8ku7ZqpdJ/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793801168;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=u0Gcm7yp9aJ9mBA1OJ6UR0SylH3ncPNW2dEKFLiYpJc=;
	b=0D2pQ6j3ZATMCqY34lC3r7JywxZJenj5F1WlD2ZzEs8xGHDabRq/PSuQU0A8R/PVP1xh
	 DUFaCctFKU8IHqIWTlfHnLVMCAyvm3GWDxVpnZwflzrFLDH3c2Hxc+7af/xsZMsnEC39l
	 sdIZp3k8BBDXL8jpi+Ex0xjcbhxj2jVO2Ty8WE9Vhc7bN2Shapq2gSsyJ++y/2+ElNpZj
	 xAuLNV2DhVkVXUOjBPdD2uLoYI11Kf5n6gUuDxho7iGuuNs3Kq/jNJ1X2QZYTUNEqgPN/
	 xfaGgEyQ8zpKI+4Q8hb2HL7v5Ls8rE1kqWLj0hK0IhthyhdfuNJ+SOpIWAVJLAeteFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=os+G7gk5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933F4606A31B
	for <live-patching@vger.kernel.org>; Wed,  4 Nov 2026 14:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=os+G7gk5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0AD71F000C1;
	Wed,  4 Nov 2026 14:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793801168;
	bh=u0Gcm7yp9aJ9mBA1OJ6UR0SylH3ncPNW2dEKFLiYpJc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=os+G7gk5OD1q/eb4N/j0npzY4Uhtpz95VZL8lNWs/+VQwYazAtaNFjevlIo/bDUt0
	 CPJfGj/qRFtx+r3XlZCvtz63qBfePFsd7prDHPZc7IpA/lF/6ofnunqOgsUM+tBw/O
	 XbsHL+zZ9I5Kv37+aS10aR0ebVpw+KbrjBys1OobZVZ8KqUMg469AUP+vwtKckYL4U
	 v+P/qeBQa9qSRBqTMw/6pB4LX9KJGSapcrE5ZcwzekmbAQREJ4qyScdVApew0l4j1z
	 5Y3f4aXOtkxEjWMVNuhGjM3NEtoG7wzZrLPtj0fGO/5Q3at47ir8Nz4raCQjHfhu/9
	 hwTLE7hOTCDpQ==
Message-ID: <sashiko-outbox-197391@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 08/11] objtool/klp: Include symbol identities in
 reference checksums
Reply-To: sashiko-reviews@lists.linux.dev
To: "Longjun Luo" <luolongjuna@gmail.com>, jpoimboe@kernel.org, peterz@infradead.org
Cc: mbenes@suse.cz, pmladek@suse.com, joe.lawrence@redhat.com, song@kernel.org, puranjay@kernel.org, nathan@kernel.org, ndesaulniers@google.com, morbo@google.com, justinstitt@google.com, live-patching@vger.kernel.org
In-Reply-To: <20261104133158.3187525-9-luolongjuna@gmail.com>
References: <20261104133158.3187525-1-luolongjuna@gmail.com>
 <20261104133158.3187525-9-luolongjuna@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 14:06:07 +0000
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
- [Medium] objtool/klp: incomplete .lto_priv suffix handling in checksum_na=
me()
- [Medium] objtool/klp: alias checksum mismatch in checksum_object() and kl=
p-diff
- [Medium] objtool/klp: broken .rodata and cross-CU matching in fallback_by=
_name()
- [Medium] objtool/klp: missing alias and TU checks in check_linkage_change=
s()
--

commit 4c8f17799f11215eb7f986c3b3afec4af75ec543
Author: Longjun Luo <luolongjuna@gmail.com>

objtool/klp: Include symbol identities in reference checksums

This commit updates livepatch checksum calculation to prepare DWARF
identities and hash symbol identity paths for named references instead of
relying solely on suffix-stripped ELF names.

> diff --git a/tools/objtool/klp-checksum.c b/tools/objtool/klp-checksum.c
> index 1a5f2fa89baa5..44c0eb784e570 100644
> --- a/tools/objtool/klp-checksum.c
> +++ b/tools/objtool/klp-checksum.c
> @@ -77,6 +77,12 @@ static bool is_const_reference(struct symbol *sym)
>  static int checksum_object(struct objtool_file *file, struct symbol *sym,
>  			   unsigned int depth);
> =20
> +/* Use suffix-stripped ELF names for references without DWARF identities=
. */
> +static const char *checksum_name(struct symbol *sym)
> +{
> +	return sym->identity.path ?: sym->identity.demangled_name;
> +}

[Severity: Medium]
When building with GCC LTO, GCC appends .lto_priv.<num> suffixes to
privatized symbols. In tools/objtool/klp-diff.c, same_compiler_name() calls
skip_lto_priv() so that symbols whose .lto_priv.<num> suffix is added or
removed between original and patched builds can still correlate:

tools/objtool/klp-diff.c:skip_lto_priv() {
	if (!strstarts(name, ".lto_priv.") || !isdigit((unsigned char)name[10]))
		return name;
	name +=3D 10;
	while (isdigit((unsigned char)*name))
		name++;
	return name;
}

However, demangled_name_len() in tools/objtool/elf.c only strips .llvm.<has=
h>
and trailing .<digits> suffixes:

tools/objtool/elf.c:demangled_name_len() {
	...
	while (len && isdigit(name[len - 1])) {
		p =3D name + len - 1;
		while (p > name && isdigit(*p))
			p--;

		if (p =3D=3D name || *p !=3D '.')
			break;
		len =3D p - name;
	}
	return len;
}

As a result, a symbol like foo.lto_priv.0 has sym->identity.demangled_name
truncated to foo.lto_priv instead of foo, which also leaves .lto_priv in
sym->identity.path. In addition, matches_name() in tools/objtool/klp-dwarf.c
only skips .llvm. and .<digits>, rejecting .lto_priv.<num> when matching ELF
names against DWARF DW_AT_name, and find_twin() in tools/objtool/klp-diff.c
keys hash lookups and same_identity() on sym->identity.demangled_name before
calling is_twin_candidate() -> compatible_symbol_name() ->
same_compiler_name() -> skip_lto_priv().

If a referenced symbol gains or loses a .lto_priv.<num> suffix between
builds, won't checksum_name() hash different strings and cause false checks=
um
mismatches as well as failed symbol correlation?

> @@ -170,8 +176,8 @@ static int checksum_update_insn(struct objtool_file *=
file, struct symbol *func,
>  		__checksum_update_insn(func, insn, &sym->csum.checksum,
>  				       sizeof(sym->csum.checksum));
>  	} else {
> -		__checksum_update_insn(func, insn, sym->identity.demangled_name,
> -				       strlen(sym->identity.demangled_name));
> +		__checksum_update_insn(func, insn, checksum_name(sym),
> +				       strlen(checksum_name(sym)));
>  	}
>  	__checksum_update_insn(func, insn, &offset, sizeof(offset));

[Severity: Medium]
In calculate_checksums(), symbols where is_alias_sym(sym) is true are skipp=
ed
so that only the representative symbol sym->alias gets a checksum in
.discard.sym_checksum.

However, in checksum_update_insn() and checksum_update_object(), compound
constants are hashed by calling checksum_object() directly on sym without
resolving sym->alias or checking whether the checksum was already computed:

tools/objtool/klp-checksum.c:checksum_update_insn() {
	...
	if (is_compound_constant(sym)) {
		if (checksum_object(file, sym, 1))
			return -1;
		__checksum_update_insn(func, insn, &sym->csum.checksum,
				       sizeof(sym->csum.checksum));
	}
}

And on the diff side in tools/objtool/klp-diff.c, read_sym_checksums() only
populates csum.checksum on sym->alias (leaving sym->csum.checksum =3D=3D 0 =
on
aliases), whereas correlate_by_identity() pairs aliased static objects
directly via orig_sym->twin =3D patched_sym, and mark_changed_functions() a=
nd
find_twin_by_identity_and_checksum() inspect sym->csum.checksum directly
rather than sym->alias->csum.checksum:

tools/objtool/klp-diff.c:mark_changed_functions() {
	...
		if (orig_sym->csum.checksum !=3D patched_sym->csum.checksum) {
			if (!is_func_sym(orig_sym)) {
				ERROR("changed data: %s", orig_sym->name);
				return -1;
			}
}

Doesn't this emit duplicate .discard.sym_checksum entries for compound
constant aliases, and cause mark_changed_functions() to falsely report
changed data when constant merging or symbol table ordering changes which
symbol is the representative alias?

> @@ -411,6 +418,12 @@ int cmd_klp_checksum(int argc, const char **argv)
>  	if (ret)
>  		goto out;
> =20
> +	for_each_sym(file->elf, sym)
> +		sym->dont_correlate =3D dont_correlate(sym);
> +	ret =3D prepare_identities(file->elf);
> +	if (ret)
> +		goto out;
> +
>  	ret =3D calculate_checksums(file);
>  	if (ret)
>  		goto out;

[Severity: Medium]
Now that cmd_klp_checksum() calls prepare_identities(),
get_identity_for_symbol() invokes fallback_by_name() in
tools/objtool/klp-dwarf.c when no matching address DIE is found:

tools/objtool/klp-dwarf.c:fallback_by_name() {
	const char *name =3D sym->pfunc->identity.demangled_name;
	const char *file =3D sym->file ? basename(sym->file->name) : NULL;
	...
	elf_hash_for_each_possible(elf, dwarf_name, entry, name_hash, str_hash(nam=
e)) {
		if (entry->type !=3D sym->type || strcmp(name, entry->name))
			continue;
		...
		if (!entry->cu->assembly && !candidate.external && file &&
		    strcmp(file, basename(candidate.source)) &&
		    !known_file_name_mismatch(file, basename(candidate.source)))
			continue;
}

Could this fail in two cases for .rodata symbols?

First, under Clang, function-local static const objects in .rodata have ELF
names of the form <func>.<var>[.<suffix>], so
sym->pfunc->identity.demangled_name is <func>.<var>, whereas dwarf_name is
indexed by DW_AT_name (<var>), so strcmp(name, entry->name) never matches.

Second, for top-level .rodata symbols in multi-TU objects where two CUs sha=
re
the same basename, fallback_by_name() does not exclude DIEs that already ha=
ve
concrete addresses (entry->nr_addresses > 0), skips the file check when
candidate.external is true, and only compares basename(sym->file->name)
against basename(candidate.source) rather than checking
sym->file->identity.source. Can a .rodata symbol without a location attribu=
te
in one CU match a same-named DIE in another CU and cause
complete_file_source() to fail with conflicting DWARF sources?

[Severity: Medium]
Also related to identity handling in tools/objtool/klp-diff.c,
check_linkage_changes() checks orig_sym->twin and patched_sym->twin directly
when scanning for linkage changes across symbols with the same demangled
name:

tools/objtool/klp-diff.c:check_linkage_changes() {
	for_each_sym(e->orig, orig_sym) {
		if (orig_sym->twin || orig_sym->dont_correlate ||
		    !has_dwarf_identity(orig_sym) || is_undef_sym(orig_sym) || !orig_sym-=
>len)
			continue;

		for_each_sym_by_demangled_name(e->patched, orig_sym->identity.demangled_n=
ame,
					       patched_sym) {
			if (patched_sym->twin || patched_sym->dont_correlate ||
			    !has_dwarf_identity(patched_sym) ||
			    is_undef_sym(patched_sym) || !patched_sym->len)
				continue;

			if (orig_sym->type !=3D patched_sym->type ||
			    strcmp(orig_sym->identity.scope, patched_sym->identity.scope) ||
			    orig_sym->identity.external =3D=3D patched_sym->identity.external)
				continue;

			ERROR("unsupported linkage change for %s",
			      orig_sym->identity.demangled_name);
			return -1;
		}
	}
}

Unlike correlate_symbols() and validate_symbol_twins(), which use
reference_twin(sym) so data aliases whose representative symbol is correlat=
ed
are treated as correlated, check_linkage_changes() checks sym->twin directly
and does not check whether orig_sym and patched_sym belong to the same
translation unit.

In a multi-TU object or an object with correlated data aliases, won't an
uncorrelated static symbol in one TU matching the demangled name of an
uncorrelated global symbol in a different TU (or an uncorrelated alias of a
correlated symbol) trigger a false "unsupported linkage change" error?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104133158.3187=
525-1-luolongjuna@gmail.com?part=3D8
