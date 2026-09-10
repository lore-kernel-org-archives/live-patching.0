Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5723E2AD6;
	Thu, 10 Sep 2026 09:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789030927; cv=none; b=gvJZ8qD6DN+GbNwxxcdsvnv4stYg2ub1pn/chczLhkS9KURv5CzfsCLkj+9+HQ+oyp1fkSCv94xEDou6W2ABWu9YQj2Zi3E+KaQmtobD74We0hIEj+LHgq8bDqFEHOzd93Ec0ebXcNzhOxCOSjFM1yyOKuZ+6MEN60S5RvTLwuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789030927; c=relaxed/simple;
	bh=tTO0sXFd7NikgCaPr4XsWVZisfzLKRyEMFPeAgQ1b+Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IZMMKGw7OSeGw6zUKNNETL8PLEaawDEfORg00ZUcjXlOnLgf0Xu1UmQV0pRAijyyrCa/QQAz/ALnKLa0dg4klNIePa4FVWmRtvGf4lXxgEOJXeW/terjx1SMWdTkrzGQBiA/yDIFwiCHJQB9xCGuO3L6Cn2LaRSnO8z+Eb7ecWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VTULSDVV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VTULSDVV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B58EF1F000FF;
	Thu, 10 Sep 2026 09:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789030925;
	bh=6TsKiL1UZUFTwnR9WpEGYg5LcyWynmpFuhrHMT/SdrE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VTULSDVVnrXCELJYoPP8JPIpk+5JiguoC4EDzg5yDBQdd/LccHKLbTdsJ083ci8zM
	 wSHjkDZ0fDr8slWZOK+ctc+0xAPMS64UKb3WRLBnp96uXi3cJC70rRWo4N/mOXVcAt
	 iAcGt7tibUTINtNuAKMZi2wjsPMgqENx6aqPSrRIekbvi7xMMrTz2P54msAnSIvyG7
	 bEGyAtEeq9AepCHofCcz/mLSzCrTOkMTkISjRjmO8wTvwV3uH+szxgk4KMa7fCQ8pD
	 i8tUorHIYfh29/fd3x5Xr3iUeqKOc18rX4ukQZ5auoY+UQ9wdqmMDs7GsaIkSqdqR3
	 X2zwZLEnspX/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] objtool/klp: Fix missed changes to same-named symbol
 references
Reply-To: sashiko-reviews@lists.linux.dev
To: peterz@infradead.org, "Longjun Luo" <luolongjuna@gmail.com>, jpoimboe@kernel.org
Cc: linux-kernel@vger.kernel.org, song@kernel.org, live-patching@vger.kernel.org, pmladek@suse.com, jikos@kernel.org
In-Reply-To: <20260910085218.66565-1-luolongjuna@gmail.com>
References: <20260910085218.66565-1-luolongjuna@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 09:02:04 +0000
Message-Id: <20260910090204.B58EF1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] `__checksum_update_object_symbol()` unintentionally hashes the `=
offset` parameter (the relocation's position in the object) using `sizeof(o=
ffset)`. Since `offset` is an `unsigned long`, this introduces host-depende=
nt hashing (4 bytes on 32-bit hosts, 8 bytes on 64-bit hosts), which breaks=
 reproducible builds when cross-compiling. Furthermore, this behavior is in=
consistent with `__checksum_update_object()` (used for string section reloc=
ations), which only uses the offset for debugging and does not hash it.
--

commit 84526b95607bbfd01a9cb5c2ebf122ffa01327c1
Author: Longjun Luo <luolongjuna@gmail.com>

objtool/klp: Fix missed changes to same-named symbol references

This commit modifies objtool to hash referenced symbols using both the
filename and the demangled name. This aims to prevent false negatives
when a function or data object changes its target to a same-named
static function.

> diff --git a/tools/objtool/include/objtool/checksum.h b/tools/objtool/inc=
lude/objtool/checksum.h
> index d46293f547166..1834d34dfd478 100644
> --- a/tools/objtool/include/objtool/checksum.h
> +++ b/tools/objtool/include/objtool/checksum.h

[ ... ]

> @@ -38,6 +56,15 @@ static inline void __checksum_update_object(struct sym=
bol *sym,
>  	dbg_checksum_object(sym, offset, what, XXH3_64bits_digest(sym->csum.sta=
te));
>  }
> =20
> +static inline void __checksum_update_object_symbol(struct symbol *sym,
> +						   unsigned long offset,
> +						   struct symbol *target)
> +{
> +	__checksum_update(sym, &offset, sizeof(offset));

[Severity: Medium]
Can hashing the offset parameter here introduce host-dependent behavior?

Since offset is an unsigned long, sizeof(offset) is 4 bytes on 32-bit hosts
and 8 bytes on 64-bit hosts. This can cause the generated livepatch checksu=
ms
to vary depending on the build host, which breaks reproducible builds when
cross-compiling.

Before this change, __checksum_update_object() received sym_offset but only
used it for debugging output without hashing it. Should this offset be
excluded from the hash calculation here as well to ensure consistent
checksums across different build hosts?

> +	__checksum_update_symbol_identity(sym, target);
> +	dbg_checksum_object(sym, offset, "reloc name", XXH3_64bits_digest(sym->=
csum.state));
> +}
> +

> diff --git a/tools/objtool/klp-checksum.c b/tools/objtool/klp-checksum.c
> index b8e47f28997e9..3da3fe11bf762 100644
> --- a/tools/objtool/klp-checksum.c
> +++ b/tools/objtool/klp-checksum.c

[ ... ]

> @@ -206,9 +203,7 @@ static void checksum_update_object(struct objtool_fil=
e *file, struct symbol *sym
>  			offset -=3D target->offset;
>  		}
> =20
> -		__checksum_update_object(sym, sym_offset, "reloc name",
> -					 target->demangled_name,
> -					 strlen(target->demangled_name));
> +		__checksum_update_object_symbol(sym, sym_offset, target);
>  		__checksum_update_object(sym, sym_offset, "reloc addend",
>  					 &offset, sizeof(offset));
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910085218.6656=
5-1-luolongjuna@gmail.com?part=3D1
