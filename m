Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794875114;
	b=Xlf0dxOqP2btnQ+PBe72lAWKfCTicBQI6A9SYimkLz9FpX6J1Pxo3P2SGjuf0FgJT8ko
	 4bS37ptCorQ+XXwmSODlXoDO4VrHLCOXStXFEmoogbZx0IwP8H9nGI1J4vhw223AZ6/DJ
	 NVlqMG7cMy8dfq+xu6j/WVuiIOkcXv4z10xmjLWmuRcQbL39j1kXzBLERR+0vVIhTO2IU
	 hskYCCLTFwzX4/QzkW+32bBuHpA9yHOjjZ3zWaSw85xoOLwNpCrzSQ64IWz790s1aN0Jy
	 Ctvp/4QT4DxHtYPmQxCBi5BasyHcVyfGXctW0+jLSZ/+90jr4NA28kS4ui+VqzbLn4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794875114;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=z9szwJn+T4440L5BOEeQX2JznzxlldfozNxENhvLH9Q=;
	b=XP7xpB3CZu5p6vxapXY/QMogJhJ9ebl4ieNbECcOlY3BCrDQIsdnO0prHLaHuoDxlURa
	 +x9j1TMGPwpnnn3124vqfIow9fbPJVyJ0o6usktBaay9b+INBeyDSxnvLTMayjGv7gUp7
	 ycCYfvkVwtgVfOdRb+YnkDEJM5y32CbP2rw3gtHQTV74lL7Elc4rFvLnUXsUsJkaQU+5D
	 PZKGZC8QihH/fJ45Wzih3tTkUfU4LncMZhLUfLdlDH5n6pQtG1uW9UTm/P0oba8y9nSyH
	 v/0msrQQF+mi5Gtqd3Wf4YXzv5IH6TRV4ocIzuIX3dq+5IgKm4iQDqk37C7Eu/Y3HhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O3TwSsdi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54196606A31C
	for <live-patching@vger.kernel.org>; Tue, 17 Nov 2026 00:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O3TwSsdi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 742FB1F000C4;
	Tue, 17 Nov 2026 00:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794875114;
	bh=z9szwJn+T4440L5BOEeQX2JznzxlldfozNxENhvLH9Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O3TwSsdi01ZRrzevcGVHiDrBf+lM8izwX8XrwVXZPlvhFAcjpr4fLGqxR0aNxHsOL
	 B1iE5CzFb4bliWL47f2ks8Wo5fCx9lNZLb7akPTdW1tDmGsRetp61ONmfz3tYWLLwS
	 fNwJqmCASjkKIEFai4ueKsSqbhDgRTDFvT7ZS6KAH7/PWlYeke6n7PMDHOhMZ+i5Z0
	 tuj2ZaWF/7Lm2U0Cntu/WQYqqiRHw+SyDgXKw2UpgDjL3gZpyjUMfEPsRA/wwRPrwH
	 4xbYIICd5gnaIZgmm3OQ51jC10RcNLl2BV4rYiEMWLZASV0LnUOnUFu03BUR4MUveO
	 O2vtyYkJxoxdw==
Message-ID: <sashiko-outbox-217999@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] objtool/klp: Disambiguate global symbols colliding
 with local symbols
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wilson Felipe Pereira" <wfelipe@google.com>, "Josh Poimboeuf" <jpoimboe@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, "Miroslav Benes" <mbenes@suse.cz>, "Petr
 Mladek" <pmladek@suse.com>, "Joe Lawrence" <joe.lawrence@redhat.com>, "Song
 Liu" <song@kernel.org>
Cc: live-patching@vger.kernel.org, "Dylan Hatch" <dylanbhatch@google.com>, "Yi
 Zhu" <chuyee@google.com>
In-Reply-To: <20261117000835.1992893-2-wfelipe@google.com>
References: <20261117000835.1992893-1-wfelipe@google.com>
 <20261117000835.1992893-2-wfelipe@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 00:25:13 +0000
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Medium] objtool/klp: inflated module sympos in klp_find_sympos() [1]
--

commit 26d2979f735e7ba2e445358f238d7b4e6e36d856
Author: Wilson Felipe Pereira <wfelipe@google.com>

objtool/klp: Disambiguate global symbols colliding with local symbols

This commit teaches objtool's livepatch symbol handling to emit .klp.symid
entries and compute symbol positions for defined non-local symbols when
duplicate names exist in the object.

> diff --git a/tools/objtool/klp-sympos.c b/tools/objtool/klp-sympos.c
> index dfca9dd746812..087892ef35934 100644
> --- a/tools/objtool/klp-sympos.c
> +++ b/tools/objtool/klp-sympos.c
> @@ -381,14 +381,14 @@ unsigned long klp_find_sympos(struct elf *elf, stru=
ct symbol *sym)
>  	bool has_dup =3D false;
>  	struct symbol *s;
> =20
> +	if (is_undef_sym(sym))
> +		return 0;
> +
>  	if (is_init_sym(sym)) {
>  		ERROR("%s: can't patch or reference init code/data", sym->name);
>  		return ULONG_MAX;
>  	}
> =20
> -	if (sym->bind !=3D STB_LOCAL)
> -		return 0;
> -
>  	/*
>  	 * vmlinux: the final link reorders symbols relative to vmlinux.o,
>  	 * so the position needs to be derived from the linked orig vmlinux via
> @@ -403,6 +403,9 @@ unsigned long klp_find_sympos(struct elf *elf, struct=
 symbol *sym)
>  	 * module_kallsyms_on_each_symbol().
>  	 */
>  	for_each_sym(elf, s) {
> +		if (is_sec_sym(s) || is_file_sym(s) || is_undef_sym(s) ||
> +		    !(s->sec->sh.sh_flags & SHF_ALLOC))
> +			continue;

[Severity: Medium]
This problem wasn't introduced by this patch, but should this filter also
skip is_init_sym(s) [1]?

The module loader excludes .init symbols when building core_kallsyms, which
module_kallsyms_on_each_symbol() walks at runtime.  If a module has an
.init symbol with the same name as sym, counting it here inflates sympos so
the livepatch either fails to resolve the symbol at load time or binds to
the wrong occurrence.

[1] https://sashiko.dev/#/bug/linux-f8712b9c-c02a-4a37-83a3-92848caee298

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117000835.1992=
893-1-wfelipe@google.com?part=3D1
