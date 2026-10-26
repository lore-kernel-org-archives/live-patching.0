Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793014317;
	b=HvUbMhIz7PCNXWYHp/i/3CUgF7Y1SQrCBKq+IMOvjCyN8DpUAaEG/HbmmpFEFx8Pvh5v
	 UggaOiiY5MNU4iL3rI59yJpQyLGs8c3Ih5ghbA3C9kkzEcIEjM+socJGiQsVz1qOje3f4
	 +VRGtsQUdECZxEsCKjswxO+VnFroOrHR2ztulIC0JtuNoJp4Njer13GSzV9Tlj3TmBE72
	 TZkSSezyhcjq9FSbYaAr9u+2hq+vTl49dC6A+EBQ+eUytPXwVcRhU3JfRCO19E/E8lyzh
	 VAzkX9Zix8RG6E317gs/m3ZyFhe1beUU8SISLEBk+5i7SLiwBMQGHeJNywvCaof0dnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793014317;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=V13xYEu/nfqFFkT0hVgUKopLg5/5+Ci/pFGMGjys0vc=;
	b=uJ7+YtoLdvIDqEzYLT7tem/nIXHF2sbbzygjfH9DYT7bXpKw/5xINXU8pEPlw2TWZkc5
	 yTryH1Tr1JBWspxEgLbsOtrQAgJ4nL7YhBwF3eEpVHAgA9Qb7vXNQKcNJRC4b2ZTmeoXe
	 oBISFr3C1zYHtXmW21a+prcrLu8a4+wpUehZk/bR1pwyRLRaMUPnTNNuSa0rPDsEpFHbu
	 UNHiMI8uIeE6fuRTaOEDYT9cX8wORt0lo28rHtJImp/y3aFtZzB3yu1g81hXIzYTpnU4G
	 4GDBdW/bedtRwFIwjMIlgqfBmwVVpfhEQ5etAnkQv9yUONPfIWxxb18AHnCSEX5CCfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="fl/Zt+9g";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50599606A31D
	for <live-patching@vger.kernel.org>; Mon, 26 Oct 2026 11:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fl/Zt+9g
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47F3B1F01825;
	Mon, 26 Oct 2026 11:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793014316;
	bh=V13xYEu/nfqFFkT0hVgUKopLg5/5+Ci/pFGMGjys0vc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fl/Zt+9gi1PuYfCQoc2HwqvKpCwfSo78FS8VNeqh6k3IE9yhRAIDuKP/FxFWmko6Q
	 A1QKJHUZ/dfY7xK9C9VelHNR3eewznI82kWJEde/GRZZOuzJfX/abAW0qwdvNbwZbO
	 IJFs1QKYdd3rvNazh3qcQMMztpd4dtEjHdpbVckhN6zJl1Up9bL+MtWgbgQPcKc2eb
	 Imbpdecvsz64VUonf+ceef5P7TQ/7qLmPa26a5RUlEIvO9rtLYFddjUR/nuiYtly+g
	 cH80G7ZeaQGlXzaRfU0TEWU4Uf6o+KEA2yp/qkI+f6BOy7s+RnmwbApa/DDTDx6gQ6
	 C8epnw/jd4XaA==
Message-ID: <sashiko-outbox-185103@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 2/3] objtool/klp: Include symbol identities in
 reference checksums
Reply-To: sashiko-reviews@lists.linux.dev
To: "Longjun Luo" <luolongjuna@gmail.com>, jpoimboe@kernel.org, peterz@infradead.org
Cc: mbenes@suse.cz, pmladek@suse.com, joe.lawrence@redhat.com, song@kernel.org, puranjay@kernel.org, nathan@kernel.org, ndesaulniers@google.com, morbo@google.com, justinstitt@google.com, live-patching@vger.kernel.org
In-Reply-To: <20261026101916.3823942-3-luolongjuna@gmail.com>
References: <20261026101916.3823942-1-luolongjuna@gmail.com>
 <20261026101916.3823942-3-luolongjuna@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 11:31:55 +0000
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] objtool/klp: unstable checksums for local symbols in prepare_ide=
ntities()
--

commit 547eafe74bd5b34cf5af6c927344337c25025230
Author: Longjun Luo <luolongjuna@gmail.com>

objtool/klp: Include symbol identities in reference checksums

This commit prepares symbol identities during klp checksum and hashes the
target symbol's source/scope/demangled_name path instead of only its
demangled name when computing instruction and data object reference
checksums.

> diff --git a/tools/objtool/klp-identity.c b/tools/objtool/klp-identity.c
> index 627eda694389e..ca8e65d5d3927 100644
> --- a/tools/objtool/klp-identity.c
> +++ b/tools/objtool/klp-identity.c
> @@ -156,12 +156,19 @@ int prepare_identities(struct elf *elf)
> =20
>  	for_each_sym(elf, sym) {
>  		struct identity *identity =3D &sym->identity;
> +		char *path;
> =20
>  		/* Default to STT_FILE and "/" for missing DWARF information. */
>  		if (!identity->external && !*identity->source && sym->file)
>  			identity->source =3D sym->file->identity.source;
>  		if (!identity->scope)
>  			identity->scope =3D "/";
> +		if (asprintf(&path, "%s%s%s", identity->source, identity->scope,
> +			     identity->demangled_name) < 0) {
> +			ERROR_GLIBC("asprintf");
> +			return -1;
> +		}
> +		identity->path =3D path;

[Severity: Medium]
Can baking sym->file->identity.source into identity->path cause unstable
reference checksums for unchanged functions and data objects when a livepat=
ch
adds or removes the only correlated static symbol in a translation unit?

In cmd_klp_checksum(), sym->dont_correlate =3D dont_correlate(sym) is popul=
ated
before calling prepare_identities(file->elf). In prepare_identities(), the
first loop initializes each STT_FILE symbol's identity->source to sym->name
(typically a short basename such as "foo.c") and skips DWARF lookup whenever
is_dwarf_identity_candidate(sym) returns false:

tools/objtool/klp-identity.c:is_dwarf_identity_candidate() {
	return !sym->dont_correlate && sym->len && !is_undef_sym(sym) &&
	       (is_func_sym(sym) || is_object_sym(sym));
}

In the second loop of prepare_identities(), external symbols clear
identity->source to "", and complete_file_source() only upgrades
sym->file->identity.source from the short STT_FILE name to the full
normalized DWARF compilation unit path when the translation unit contains at
least one correlated (!sym->dont_correlate), non-external STB_LOCAL symbol
with DWARF information:

tools/objtool/klp-identity.c:prepare_identities() {
    ...
		if (identity->external)
			identity->source =3D "";
		else if (complete_file_source(sym, identity->source))
			return -1;
    ...
}

In the third loop above, all local symbols without a DWARF identity (includ=
ing
dont_correlate symbols such as .data..once flags from WARN_ONCE/DO_ONCE,
pr_debug descriptors, __func__, lockdep keys, switch tables, anonymous
rodata, and .altinstr_replacement symbols) fall back to
sym->file->identity.source and format it into identity->path, which is then
hashed by checksum_update_insn() and checksum_update_object().

If a translation unit in orig.o has only external symbols (or static symbols
that were all inlined or promoted to STB_GLOBAL by ThinLTO),
sym->file->identity.source remains the short STT_FILE name. If patched.o
then introduces a static helper or static variable in that translation unit
(or removes the last one), sym->file->identity.source flips between the sho=
rt
STT_FILE name and the full DWARF path.

Wouldn't that change identity->path for every fallback and dont_correlate
local symbol in the translation unit, causing unchanged functions referenci=
ng
them to get different checksums and causing unchanged correlated data objec=
ts
referencing them to fail klp diff in mark_changed_functions() with a false
"changed data" error?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026101916.3823=
942-1-luolongjuna@gmail.com?part=3D2
