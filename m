Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06B418BC3D;
	Fri,  7 Aug 2026 21:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786139173; cv=none; b=E5Laowm3Q9SaVKhAY0UaW7nlktED2BALinE0D37AJ8QMO3t1WpuJUPl68Wo0jjSNPIRzIUBTsD6cQHTuhZn0wC2fmHXpHGD0M9PAbW0i05Gyn9pD919ZyPJOW8qt0WLuvmqZIbZwcu4qqQuN1+H+GnFxAonL8zXwENDS7f96v4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786139173; c=relaxed/simple;
	bh=Ux2bzGN3fXDbj7PUpucqVZZbKXo4ujYJrQieDB+tBEM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lqlO7QD+OlQ79Ay71jAzJhPICEIr4EfTiB/GF9PEg+avwCiEC4MD1mSCbIidS6qFpJ6kJ2PJAn/GjVdDH/qRJ1k+XHHWl7GfK2wJsSXjinJZuxbHZy64MLvZ6SbZPUBKloN2ki6xecwvpYznH5chLasrWqK6D/f8wyOwAS62lq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xhrmj3qQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xhrmj3qQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E16B51F000E9;
	Fri,  7 Aug 2026 21:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786139172;
	bh=SsikkDiTYkbYMkK0VGhEJiCweUyzsBHicHvHZhQt/rA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Xhrmj3qQdoB2l5/fmbwRIxOtTgsQKFeTTXKLuz4i9PH4z9Hqb59JbB4HC7Oz8BOR+
	 dQH6w5/LhGOA/DrpXhxN1Ho4WTqqeOrKGiWPt3ABeewuB0gsMXP4Pb8egN0FOS6TUK
	 JZF1MFt3Nrw8cjODhg0mhqCANfmYAHFYHCWt3ZKHBWwXEE8C9rcvuJ5bYqx17bxR/6
	 pzIlJ/z50JWHb3xX3Ipn9e2CyqvcEXbYfkVpRY5a4mgvOKsG77V2nKaBqOrYZaM4+2
	 a81PWbyzdZqYEC04hfg0ngbQ2P0PqxpOWeB0/xslUHK2rZjofcnmCS2vckrl/GKBrg
	 ZiB3fg1AMI6lw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 6/9] objtool/klp: Don't match local symbols against
 exports
Reply-To: sashiko-reviews@lists.linux.dev
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org, "Miroslav Benes" <mbenes@suse.cz>, "Joe
 Lawrence" <joe.lawrence@redhat.com>, live-patching@vger.kernel.org, "Petr
 Mladek" <pmladek@suse.com>, "Song Liu" <song@kernel.org>, "Peter Zijlstra" <peterz@infradead.org>
In-Reply-To: <dafc7c017d1f62e2190a20dc84a52fbfc4c70210.1786138493.git.jpoimboe@kernel.org>
References: <cover.1786138493.git.jpoimboe@kernel.org>
 <dafc7c017d1f62e2190a20dc84a52fbfc4c70210.1786138493.git.jpoimboe@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 21:46:11 +0000
Message-Id: <20260807214611.E16B51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unexported global symbols that share a name with an export are inc=
orrectly matched against the global exports list, causing misrouted livepat=
ch relocations.
--

--- Patch [6]: [PATCH v3 6/9] objtool/klp: Don't match local symbols agains=
t exports ---
commit 91941e947fdde72be13c7760463244a153a175ce
Author: Josh Poimboeuf <jpoimboe@kernel.org>

objtool/klp: Don't match local symbols against exports

This commit updates find_export() in klp-diff.c to ignore local symbols.
This addresses an issue where static functions or variables that share a
name with an export are incorrectly treated as export references during
livepatch generation.

> diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
> --- a/tools/objtool/klp-diff.c
> +++ b/tools/objtool/klp-diff.c
> @@ -1101,6 +1101,9 @@ static struct export *find_export(struct symbol *sy=
m)
>  {
>  	struct export *export;
> =20
> +	if (is_local_sym(sym))
> +		return NULL;
> +
>  	hash_for_each_possible(exports, export, hash, str_hash(sym->name)) {
>  		if (!strcmp(export->sym, sym->name))
>  			return export;

[Severity: High]
This is a pre-existing issue, but does this still leave unexported global
symbols vulnerable to incorrect matching?

If a module contains an unexported global symbol that shares its name with
an unrelated exported symbol, it will bypass the is_local_sym() check.

When the module is livepatched and klp-diff processes a relocation to this
internal symbol, find_export() will perform a string match and return the
unrelated export. Would this cause a KLP relocation to incorrectly point to
the external module's export instead of the internal symbol?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1786138493.gi=
t.jpoimboe@kernel.org?part=3D6
