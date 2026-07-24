Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B1E30149F
	for <live-patching@vger.kernel.org>; Fri, 24 Jul 2026 22:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784932067; cv=none; b=CIz+umjjHAdvH4ovysJjNFtD90m6CJN/eXCo+INubrm1oA39NPq1jodBYLc0sQef/usKfwwANa0TiajflXC8VV2HC3iowcux5eGe3wiPPa5sAgvOunLaco1YYnkWAU20YsZ/h4AdoHMcSx4/uTE3lUTxVOFrry+MKXngHn39Dqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784932067; c=relaxed/simple;
	bh=/mRUD33iXEMV8FYrnXbgVIL6t6ixGZU68MhpQ0yAeF4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YNkkqPhPZeLoimyyXgjV2+NWhi4RAoNR/gsBhy2+Q+VDlhx6fUzFxF8Ic1JovbB854xLs51u+b+ajGPJIxTWoNncg9Dk+5e44AYrRdfhvrsXl5ldB1PSAMV4xYLBqYrxZbiY59jt6quCsCVVUJAUPAp9/xzpU191Fw0G9UIWVgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fH7fnYnn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fH7fnYnn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B8F81F000E9;
	Fri, 24 Jul 2026 22:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784932065;
	bh=WnuLvqV0Qbic5FxnV4WeMIRYOEQ4HxVuiTTkf09OQRQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fH7fnYnnOquqlGoXIxc/rVyKr6AIjCcmYMEjgSAv/KGR3SNr+BRd+GcZeXNCegFpp
	 01YytJJgu/xzAUOFhTiEqkqUJjFlhXtF8JTTYvuDhHz2SQnfdLERvG4DRPXLFrTXoZ
	 8omGLFQI0Z1nQ9nP6UQTp3Eh9W17duaEUExejUzIMCpjgfnkkd77OfAeR8g+M+sYJh
	 U3Haev8Wdg5QikltpmySeObB4l562iVvRiE0r/lFlD41GC0Ak2xgxCfm+W+T8bHZxS
	 0/b3l4A9gAxOoNX97ONn0RRtXdErpqkxm+61NI0LGwkZB9F+CWMBeYfodfMc+6zLP/
	 WeOYtA23jWcEg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/1] objtool/klp: compute sympos during checksum
 phase
Reply-To: sashiko-reviews@lists.linux.dev
To: live-patching@vger.kernel.org
Cc: "Song Liu" <song@kernel.org>, "Ben Procknow" <bprockno@redhat.com>, "Miroslav
 Benes" <mbenes@suse.cz>, "Jiri Kosina" <jikos@kernel.org>, "Josh Poimboeuf" <jpoimboe@kernel.org>, "Petr
 Mladek" <pmladek@suse.com>
In-Reply-To: <20260724221730.3126529-2-joe.lawrence@redhat.com>
References: <20260724221730.3126529-1-joe.lawrence@redhat.com>
 <20260724221730.3126529-2-joe.lawrence@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 22:27:44 +0000
Message-Id: <20260724222745.5B8F81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Identical `sympos` is incorrectly assigned to intra-file duplicate=
 symbols, breaking livepatch target disambiguation.
--

--- Patch [1]: [PATCH v2 1/1] objtool/klp: compute sympos during checksum p=
hase ---
commit 00bcd90f9dc15cdd96632002648171f48c54a2cc
Author: Joe Lawrence <joe.lawrence@redhat.com>

objtool/klp: compute sympos during checksum phase

This commit changes how sympos is computed for livepatch duplicate local=20
symbols. It computes sympos during the checksum phase and writes it to a
.discard.sym_order section, rather than using heuristics in klp-diff.

> diff --git a/tools/objtool/klp-checksum.c b/tools/objtool/klp-checksum.c
> index b8e47f28997e9..d16f00a3bb2a9 100644
> --- a/tools/objtool/klp-checksum.c
> +++ b/tools/objtool/klp-checksum.c

[ ... ]

> @@ -250,6 +256,183 @@ int calculate_checksums(struct objtool_file *file)

[ ... ]

> +	/*
> +	 * For each local symbol with homonyms in the linked binary, determine
> +	 * its sympos: sort the duplicates by address (vmlinux) or symtab
> +	 * index (modules), then find our position by filename.
> +	 */
> +	idx =3D 0;
> +	for_each_sym(file->elf, sym) {

[ ... ]

> +		/* Match our compilation unit's filename against sorted entries */
> +		sym_file_name =3D sym->file ? sym->file->name : NULL;
> +		for (i =3D 0; i < nr; i++) {
> +			bool match;
> +
> +			if (sym_file_name && entries[i].file_name)
> +				match =3D !strcmp(sym_file_name, entries[i].file_name);
> +			else if (!sym_file_name && !entries[i].file_name)
> +				match =3D true;
> +			else
> +				match =3D false;
> +
> +			if (match) {
> +				pos =3D i + 1;
> +				break;
> +			}
> +		}

[Severity: High]
If an object file contains multiple identical local symbols with the same n=
ame
and from the same source file, will they all get assigned the exact same
sympos value?

Because the outer loop processes each symbol independently and the inner
matching loop breaks on the first match without tracking consumed matches,
it appears all identical intra-file duplicates will continually match the f=
irst
available entry in the sorted list and be assigned the same position.

Could this break livepatch target disambiguation if multiple identical=20
symbols in the same compilation unit share the same sympos?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724221730.3126=
529-2-joe.lawrence@redhat.com?part=3D1
