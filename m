Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793800516;
	b=AQvQZYEC3R5HcECcVuqE/JqEHngxu2vxicx95qGB4mP+hQUY/rOfkmGiYtzRyxBb7Q8/
	 dBqAept/EJADsnX9X8OXI/h2P7brgqprT1WZi/BI/WE703NcEDahk4qK15jQ1JHZPATCN
	 33YvZy+KfR2O+0HmfMPLEl9adkjOOJLa6Fm6go6Kqa7Un7QpJ9DTRDFGiJMLkM9QNKcck
	 mx4GMgPqBQizc8RNUEjVZJrSOHCF8zUeaD0SiShW4jy4kfXKlMYSxIJ5rYtMNaLkSl7jR
	 A3de6K0t/ePlJcyu4DQasI/ZqZ+8XRb5+68oltN1IHlKGkr5LT2+FNoInlJxT7Ul9NQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793800516;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=20ZQyqg/PjUDOuZoHALQc9KMUO2EJKSJHGlP6xutn7U=;
	b=Mng6FBpE/NujmWDifRsyeEIcos5bRfqG/zmaKWAnXdRY0kItaw3GZhbZO/70qBlhgn2A
	 3tVrp6vgTItja/JZF6NkQF2PPsvwFLzmv2AkUto1gDAEijdtVOmNeo7+WYPdTdEQgHw67
	 YQmMBRqNgiSys7I3HMLUGsGq7L6UnXWsEQvbanyJf9vSUjASn34h5Ky62a3TduevSygdA
	 Snh7PZkuSIrQcPA555S+VK93bfnLAJZAjHXSyIz4JhQwb4pBNdXvJfrzcj2QswVzLM8qg
	 2fQhkCEu9gtUC4MT4FBHZRjbHfaxMJ3iHGWbx0HdCHbLpylZiNflrlM4frrdFq1rp6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PXTlsuZv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EC2606A32E
	for <live-patching@vger.kernel.org>; Wed,  4 Nov 2026 13:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PXTlsuZv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 660A41F0093A;
	Wed,  4 Nov 2026 13:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793800516;
	bh=20ZQyqg/PjUDOuZoHALQc9KMUO2EJKSJHGlP6xutn7U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PXTlsuZvlmU7UcqimM5Pp5a/BdbOTYaYqUvJjMkPqeWgU18mwm3REl8ep/fPq8aLW
	 K7hMbh30sRFZV8RujnDGCZEJAmRIEMcJy9rhnrAoENXThOx5+PPrennhoMs8qWvsIR
	 JgCSTv0SWKzdAx35oMLVon7qM9mpzOraHFi7qNRRJIgPaZJohvBKxduimp8b9J7Sdm
	 Q2P2dJZ44q4oNnrvXMJJh0AR0cCboCtxO5RDDiaNP7V0ZD3r3eorQ/nLVqkBbmizfD
	 l/x7RAFiVFVMS5yDUrc8psmgqiy4WGO62huwIJL8ZMzW9aJcXlCnJCT7ASSjhxenlB
	 XF12NpuSA+BDQ==
Message-ID: <sashiko-outbox-197362@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 02/11] objtool/klp: Hash compound literals by
 content
Reply-To: sashiko-reviews@lists.linux.dev
To: "Longjun Luo" <luolongjuna@gmail.com>, jpoimboe@kernel.org, peterz@infradead.org
Cc: mbenes@suse.cz, pmladek@suse.com, joe.lawrence@redhat.com, song@kernel.org, puranjay@kernel.org, nathan@kernel.org, ndesaulniers@google.com, morbo@google.com, justinstitt@google.com, live-patching@vger.kernel.org
In-Reply-To: <20261104133158.3187525-3-luolongjuna@gmail.com>
References: <20261104133158.3187525-1-luolongjuna@gmail.com>
 <20261104133158.3187525-3-luolongjuna@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 13:55:14 +0000
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] objtool/klp: non-inclusive symbol lookup in checksum_update_obje=
ct()
- [Medium] objtool/klp: out-of-bounds .rodata.cst read in checksum_update_o=
bject()
--

commit 6efbe1fe552ea13b0bd2f7a21edd04896b97dc17
Author: Longjun Luo <luolongjuna@gmail.com>

objtool/klp: Hash compound literals by content

This commit updates klp checksum generation to recursively hash the contents
and relocations of compiler-generated compound literal symbols instead of
hashing their generated symbol names.

> diff --git a/tools/objtool/klp-checksum.c b/tools/objtool/klp-checksum.c
> index efaf083c03a11..2a515c7e2bf60 100644
> --- a/tools/objtool/klp-checksum.c
> +++ b/tools/objtool/klp-checksum.c
[ ... ]
> @@ -134,10 +146,9 @@ static int checksum_update_insn(struct objtool_file =
*file, struct symbol *func,
>  	sym =3D reloc->sym;
>  	offset =3D arch_insn_adjusted_addend(insn, reloc);
> =20
> -	if (is_string_sec(sym->sec)) {
> -		ssize_t size =3D elf_string_len(sym->sec, sym->offset + offset);
> -		const void *data;
> -
> +	if (is_const_reference(sym)) {
> +		size =3D is_string_sec(sym->sec) ? elf_string_len(sym->sec, sym->offse=
t + offset) :
> +					      sym->sec->sh.sh_entsize;
>  		if (size < 0)
>  			return -1;
>  		data =3D sym->sec->data->d_buf + sym->offset + offset;
>  		__checksum_update_insn(func, insn, data, size);
>  		goto alts;
>  	}
> =20
> -	if (is_anonymous_const_data(sym)) {
> -		void *cst;
> -
> -		cst =3D sym->sec->data->d_buf + sym->offset + offset;
> -		__checksum_update_insn(func, insn, cst, sym->sec->sh.sh_entsize);
> -		goto alts;
> -	}
> -
>  	if (is_sec_sym(sym)) {
>  		sym =3D find_symbol_containing(reloc->sym->sec, offset);
>  		if (!sym)
>  			goto alts;
> =20
>  		offset -=3D sym->offset;
>  	}
> =20
> -	__checksum_update_insn(func, insn, sym->demangled_name,
> -			       strlen(sym->demangled_name));
> +	if (is_compound_constant(sym)) {
> +		if (checksum_object(file, sym, 1))
> +			return -1;
> +		__checksum_update_insn(func, insn, &sym->csum.checksum,
> +				       sizeof(sym->csum.checksum));
> +	} else {
> +		__checksum_update_insn(func, insn, sym->demangled_name,
> +				       strlen(sym->demangled_name));
> +	}
>  	__checksum_update_insn(func, insn, &offset, sizeof(offset));
> =20
>  alts:
> @@ -198,7 +208,8 @@ static int checksum_update_insn(struct objtool_file *=
file, struct symbol *func,
>  	return 0;
>  }
> =20
> -static int checksum_update_object(struct objtool_file *file, struct symb=
ol *sym)
> +static int checksum_update_object(struct objtool_file *file, struct symb=
ol *sym,
> +				  unsigned int depth)
>  {
>  	struct reloc *reloc;
> =20
> @@ -212,38 +223,79 @@ static int checksum_update_object(struct objtool_fi=
le *file, struct symbol *sym)
>  	sym_for_each_reloc(file->elf, sym, reloc) {
>  		unsigned long sym_offset =3D reloc_offset(reloc) - sym->offset;
>  		struct symbol *target =3D reloc->sym;
> +		unsigned int type =3D reloc_type(reloc);
> +		const void *data;
> +		ssize_t size;
>  		s64 offset;
> =20
>  		offset =3D reloc_addend(reloc);
> =20
> -		if (is_string_sec(target->sec)) {
> -			ssize_t size =3D elf_string_len(target->sec, target->offset + offset);
> -			const void *data;
> +		__checksum_update_object(sym, sym_offset, "reloc type",
> +					 &type, sizeof(type));
> =20
> +		if (is_const_reference(target)) {
> +			size =3D is_string_sec(target->sec) ?
> +				elf_string_len(target->sec, target->offset + offset) :
> +				target->sec->sh.sh_entsize;
>  			if (size < 0)
>  				return -1;
>  			data =3D target->sec->data->d_buf + target->offset + offset;
> -			__checksum_update_object(sym, sym_offset, "reloc string", data, size);
> +			__checksum_update_object(sym, sym_offset, "reloc constant", data, siz=
e);
>  			continue;
>  		}

[Severity: Medium]
Can this read past the end of target->sec->data->d_buf or corrupt the
checksum when a relocation into a .rodata.cst section has a non-zero
intra-entry offset?

When Clang compiles a small constant compound literal array or struct (such
as the 32-byte const unsigned int[8] array in compound.c), it places the
object into a mergeable .rodata.cst section with sh_entsize set to the entry
size and emits relocations against the section symbol.

If a compound literal, static initializer, or instruction references a
non-zero offset within that constant (for example, &arr[1] at offset +4, a
struct member at a non-zero offset, or a one-past-the-end pointer at offset
+sh_entsize), both checksum_update_object() and checksum_update_insn() match
is_const_reference(), set size to sh_entsize, and read a full sh_entsize
bytes starting from d_buf + target->offset + offset without checking section
bounds or aligning to the entry start.

If the referenced constant is the last (or only) entry in the .rodata.cst
section, reading sh_entsize bytes from a non-zero intra-entry offset reads
past the end of d_buf. If another entry follows in the section, the hash
mixes in trailing bytes from the adjacent constant entry while skipping the
leading bytes of the referenced entry, and because this branch returns early
before hashing offset, the intra-entry offset itself is omitted from the
checksum.

> =20
>  		if (is_sec_sym(target)) {
>  			target =3D find_symbol_containing(reloc->sym->sec, offset);
> -			if (!target)
> +			if (!target) {
> +				if (is_compound_constant(sym)) {
> +					ERROR("%s+%#lx: unresolved compound constant reference",
> +					      sym->name, sym_offset);\
> +					return -1;
> +				}
>  				continue;
> +			}
> =20
>  			offset -=3D target->offset;
>  		}

[Severity: Medium]
What happens here when a relocation against a section symbol uses a
one-past-the-end pointer (where offset equals target->offset + target->len),
targets a zero-length local symbol, or references anonymous .rodata?

Unlike convert_reloc_secsym_to_sym() in tools/objtool/klp-diff.c, which
checks find_symbol_by_offset(sec, 0) for dedicated sections, falls back to
find_symbol_containing_inclusive(), and allows anonymous .rodata references,
checksum_update_object() and checksum_update_insn() only call
find_symbol_containing(reloc->sym->sec, offset), which strictly requires
offset to be in [sym->offset, sym->offset + sym->len - 1] and skips
zero-length symbols.

Doesn't that cause two regressions when calculate_checksums() runs:

1. If a compound literal contains a one-past-the-end pointer (even to an
   object in a dedicated -fdata-sections section), a reference to a
   zero-length local symbol, or an anonymous .rodata reference,
   find_symbol_containing() returns NULL and checksum_update_object() aborts
   the build with an unresolved compound constant reference error.

2. If an instruction in checksum_update_insn() or a named object in
   checksum_update_object() references the one-past-the-end address of a
   compound literal (for example, as a loop bound over a compound literal
   array), find_symbol_containing() returns NULL and the compound literal is
   silently omitted from the checksum?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104133158.3187=
525-1-luolongjuna@gmail.com?part=3D2
