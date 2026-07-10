Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00304302EE
	for <live-patching@vger.kernel.org>; Fri, 10 Jul 2026 15:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783698042; cv=none; b=lKh8F5bVEK387GQdGhsyYUPzLbSTHpUtK5f/xkUODTQt5ERqotYVpSsiSTbBNg8PUOKNu9wJ69qGAoO1k+y6s9rbFVQu6lmopvzLZ1agkWOLdcWptiMF1JyNFP7ZZXkFWSYZ3iC9d5p7nwgGKaZ2FVr39OBjMFoj/o1x+nV0WQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783698042; c=relaxed/simple;
	bh=OhG8mawE7zN2V84gmP2Jd1sldDXjf7wjd/uhmTHwU7s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OfmvcFSBbAyoZ5x+LlIN6M7kFC11lDWy7dZWCYp1B+lkII14K3zWyBdH2da7m0unair8SXuxmRqpeXjlq0cr+W+wFLjrKXMiqioLU8Hsm7bfnUKlbg0lME8v3T8SP2clvLB6NPSjqiG8/OWAD5uMtKanOUCfQrnv7rFr2iidLA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fYncu20a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fYncu20a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB1A31F00A3D;
	Fri, 10 Jul 2026 15:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783698034;
	bh=3jhejkGBqyjZHIGI8D45BrRMo33Wqeb9/CP1bcAJvhU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fYncu20ar+lslSdUPMZI1UhhDVtCmYTkjplhLKwvWCwRducHKVr0tdyj6bTh44J18
	 g/M6ZJ4ciRi/xDJrO5nImaccrsiepR9sx5zwuJJ08YXN3dQIlWwSmJcMIHNG1SIrGZ
	 f6k2oDSM7w53G1dVo/1YYbhxv21C7h7gqc5S8KifpMwjcqpDonSXNAcGWLzNm7dBHs
	 oVx9zOlRfB2OPktX4ew4hUyH9zXlTjGjPpUwQkTuPSzvhhiQP3GR0SysKbSUr/7hRL
	 WribKCnu/gH4Xf6+Z4UoVj9W8l7iV3iRfUbTgJTWvSazPW26fPblVxgmQl0loGTRwP
	 y/JzOd1XJsNKw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/1] objtool/klp: fix symbol ordering for data symbols
Reply-To: sashiko-reviews@lists.linux.dev
To: live-patching@vger.kernel.org
Cc: "Jiri Kosina" <jikos@kernel.org>, "Josh Poimboeuf" <jpoimboe@kernel.org>, "Song
 Liu" <song@kernel.org>, "Petr Mladek" <pmladek@suse.com>, "Miroslav Benes" <mbenes@suse.cz>, "Ben
 Procknow" <bprockno@redhat.com>
In-Reply-To: <20260710153042.3156788-2-joe.lawrence@redhat.com>
References: <20260710153042.3156788-1-joe.lawrence@redhat.com>
 <20260710153042.3156788-2-joe.lawrence@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 15:40:33 +0000
Message-Id: <20260710154033.AB1A31F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The new multi-pass sympos calculation for data symbols hardcodes a=
n incorrect section ordering that prioritizes `.data..ro_after_init` over `=
.rodata`, and lumps other distinct data sections together, failing to match=
 kallsyms address ordering.

Pre-existing issues:
- [High] Calculating `sympos` for cross-type duplicates (e.g., a function a=
nd a variable sharing the same name) yields contradictory results because t=
he iteration passes diverge based on the queried symbol's type without filt=
ering the counted symbols.
--

--- Patch [1]: [PATCH 1/1] objtool/klp: fix symbol ordering for data symbol=
s ---
commit c98091d5ce8ba2d91968d3bbc6e227ed2bf27934
Author: Joe Lawrence <joe.lawrence@redhat.com>

objtool/klp: fix symbol ordering for data symbols

The find_sympos() function calculates a sympos (symbol position) used by
livepatch to disambiguate duplicate symbol names. This commit extends the
existing section ordering workaround to handle data symbols, counting
.data..ro_after_init first, then other .data, then .bss.

> diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
> index f8787d7d14547..034778885e922 100644
> --- a/tools/objtool/klp-diff.c
> +++ b/tools/objtool/klp-diff.c
> @@ -873,6 +873,8 @@ static unsigned long find_sympos(struct elf *elf, str=
uct symbol *sym)
> =20
>  	if (sym->bind !=3D STB_LOCAL)
>  		return 0;
> =20
>  	if (vmlinux && is_func_sym(sym)) {

[Severity: High]
This is a pre-existing issue, but does this logic cause collisions when a
function and a variable share the same name?

The branches here decide which sections are prioritized during counting bas=
ed
on the queried symbol's type (is_func_sym vs is_object_sym). However, the
inner loops count all duplicates blindly by name without filtering the coun=
ted
symbols by type.

If there is a cross-type duplicate, the function and the variable could each
be found first during their respective queries because the passes iterate
sections in different orders. Would this result in both getting the exact s=
ame
sympos?

Since klp_find_object_symbol doesn't filter by type in the kernel, could a
request to patch the variable erroneously resolve to the function?

[ ... ]

> @@ -905,6 +907,46 @@ static unsigned long find_sympos(struct elf *elf, st=
ruct symbol *sym)
>  					has_dup =3D true;
>  			}
>  		}
> +	} else if (vmlinux && is_object_sym(sym)) {
> +		/*
> +		 * HACK: Similarly, data symbol ordering can differ between
> +		 * vmlinux.o and vmlinux.  The linker script places sections:
> +		 *   .data..ro_after_init (lowest address)
> +		 *   .data* sections
> +		 *   .bss* sections       (highest address)
> +		 * Count in that order.
> +		 */

[Severity: High]
Does this hardcoded section ordering match the actual kallsyms address
ordering?

In the kernel linker script, .rodata is placed before RO_AFTER_INIT_DATA,
meaning .rodata symbols will appear before .data..ro_after_init symbols sin=
ce
kallsyms sorts strictly by address.

If a livepatch contains duplicate static data symbols where one is in .roda=
ta
and another is in .data..ro_after_init, this patch will count
.data..ro_after_init first.

Could this assign sympos=3D1 to the .data..ro_after_init symbol and sympos=
=3D2 to
the .rodata symbol, causing livepatch to patch the wrong variable when it a=
sks
for sympos=3D2?

> +		for_each_sym(elf, s) {
> +			if (strstarts(s->sec->name, ".data..ro_after_init") &&
> +			    !strcmp(s->name, sym->name)) {
> +				nr_matches++;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710153042.3156=
788-1-joe.lawrence@redhat.com?part=3D1
