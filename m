Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC94383C86;
	Wed,  5 Aug 2026 15:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785942726; cv=none; b=XZDsuWGCtMEudH++miMMHBHAu+gzDdZWqNnGjspPQ4DVUbbOfX9CEDKhzP7HCMmqVceztb5ucDruEZcIG8ANYi6rA04ZPTQ+h5itY061SQzr7z11UpFnQ3urDjdFyHAxlk6Ft7IfVNt8hVpYnk+7jsYtW09eNuFfqrLWAV41fJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785942726; c=relaxed/simple;
	bh=wNFUBLJJ8r/qrWBcS+5C8XpJIjURR8dPaq9q6cUJ3BI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bC8BZmOaz/kZntS6kNDc2NyfBSm4eCVxZMtvKUGyfsAFdEJn/HoVItTZpKQ92KOxYBmKXbJk2HRHeqrMvu1WQITBwp1/tF8JeW8YVrOWG0zHZ9tyCsgjGdb4FrDZf0UOfGr6+gi325yuHqBI9PYP8VQPvhhOfxmi02s8UkfjMPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lpxx8wwQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lpxx8wwQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D96FD1F000E9;
	Wed,  5 Aug 2026 15:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785942724;
	bh=q0kFLZzYoDj1pSd+Y7o6+oYZmQ9tZ57SLih/J4fMj0U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Lpxx8wwQHWiOtisFcrdXrWMJ0WwMbi8xTFb8UkcAoO669kUPLrQgHownIu9DlUlft
	 TLWqm2FbI04L/z081m+s1Wvs/1GlsF+zM6Ddy6vi7zpDZmYKZ+T9+rAPc/B7qXOzQ4
	 yaSfdeOk8+ET3Jn4mdQhaPiBnIUHg0vKtUNENXrofEe5uYNGYsMv+iPqmcxUtmsDgX
	 oqJqH7V2Y2XAmB8Cl2LXj9C+Fhm493F9IDCQYcbFSinhknsmd//A79neJxHR1tB6/8
	 hpAgNKG+9qcx+f8H1fDyJypk6vjHV90TDGZdc9EukPS7p/USreBl6RxIfCorhJw6ty
	 jff5w2Z2KErlw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/7] objtool/klp: Explicitly disallow patching or
 referencing init code/data
Reply-To: sashiko-reviews@lists.linux.dev
To: x86@kernel.org
Cc: "Peter Zijlstra" <peterz@infradead.org>, live-patching@vger.kernel.org, "Joe
 Lawrence" <joe.lawrence@redhat.com>, "Miroslav Benes" <mbenes@suse.cz>, "Song
 Liu" <song@kernel.org>, linux-kernel@vger.kernel.org, "Petr Mladek" <pmladek@suse.com>
In-Reply-To: <a8edecfad944523b2b1e294b66c28c22fc50dad3.1785939903.git.jpoimboe@kernel.org>
References: <cover.1785939903.git.jpoimboe@kernel.org>
 <a8edecfad944523b2b1e294b66c28c22fc50dad3.1785939903.git.jpoimboe@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 15:12:02 +0000
Message-Id: <20260805151203.D96FD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The `.init` safety check is bypassed for exported module symbols, =
allowing livepatches to silently reference freed init memory.
--

--- Patch [4]: [PATCH v2 4/7] objtool/klp: Explicitly disallow patching or =
referencing init code/data ---
commit fe2fe6cc51b729f1eb6addc3f9e161e818ce482f
Author: Josh Poimboeuf <jpoimboe@kernel.org>

objtool/klp: Explicitly disallow patching or referencing init code/data

This commit explicitly prevents the patching and referencing of init code
and data to avoid edge cases. It introduces an init check in the sympos
resolution to handle targets that might have their init section freed.

> diff --git a/tools/objtool/klp-sympos.c b/tools/objtool/klp-sympos.c
> index bbfae516d3395..dfca9dd746812 100644
> --- a/tools/objtool/klp-sympos.c
> +++ b/tools/objtool/klp-sympos.c
[ ... ]
> @@ -376,6 +381,11 @@ unsigned long klp_find_sympos(struct elf *elf, struc=
t symbol *sym)
>  	bool has_dup =3D false;
>  	struct symbol *s;
> =20
> +	if (is_init_sym(sym)) {
> +		ERROR("%s: can't patch or reference init code/data", sym->name);
> +		return ULONG_MAX;
> +	}
> +

[Severity: High]
Does this check adequately protect against exported module symbols?

Looking at clone_reloc_klp() in tools/objtool/klp-diff.c, if the symbol
is exported, the code skips calling klp_find_sympos() entirely:

tools/objtool/klp-diff.c:clone_reloc_klp() {
    if (export) {
        sym_modname =3D export->mod;
        sym_orig_name =3D export->sym;
        sympos =3D 0;
    } else {
        sym_modname =3D find_modname(e);
        if (!sym_modname)
            return -1;

        sym_orig_name =3D patched_sym->twin->name;
        sympos =3D klp_find_sympos(e->orig, patched_sym->twin);
    ...
}

If a livepatch object references an exported init symbol from a module,
would it bypass this new safety check and potentially result in a reference
to freed init memory once the target module finishes initialization?

>  	if (sym->bind !=3D STB_LOCAL)
>  		return 0;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1785939903.gi=
t.jpoimboe@kernel.org?part=3D4
