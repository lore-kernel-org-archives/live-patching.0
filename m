Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023662652B2;
	Fri, 28 Aug 2026 17:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787939159; cv=none; b=XAn57945PZyFy2FZa+J+NcPXZIPE+uUhdxk2fv03PN/H7mA6xKnEJRhJEyCO/iti9FcIJEba4jHtwuKhGjct9hjQXvLgT4IFuH3MnpoT1+r5Xs1pWCSHTyQxwgoEQYy6J+8Uyuz+qoycLJTMUPFAmeIQS8A8DBZnvbZ/cUVeJeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787939159; c=relaxed/simple;
	bh=mV61ozOy/n4WygMpUeVTFlRDzf+ARB6X8ilPsClnNHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fkt37VfwO1G6iyUrdhs2+pYjXrWfibTTex98BgrJy3+Cq7zPP18fEW7Ee70PGM/0SEXFv3DYGk/eTyYk6xGaq+ceh0Xe8WghqzUcO1uyxuL909U6gOSw8XOY8srNSST7+QRHH/8DepEJcK1d75GZ8tovNHzlsUYPiQ2Oaz8udBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OIJbElVV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OIJbElVV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0160A1F000E9;
	Fri, 28 Aug 2026 17:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787939157;
	bh=u0lddIyYJuWXd30vkaI9t34JJeTWHhyb00WwcLObpsI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OIJbElVVrRbJt0RUSRAHr8kmfHY0jSAvPxYGb4hzwd+/HU+idQPzEAZ9aES4YSNHI
	 Xcf9lawvvQgVpVur/bgrmDh4xrA+48HuPC2n0Ziw7s5GL6xCsNOxWKFbyN32G82vR9
	 P9L51OprQ1rtCUf2Ag9sfv1G6J2/bYbsx+mwyGntoo9xVGHm2eEx0a0XWJyWARBgqF
	 m4EmgjVO7CZACKoKZe5ddhuJHXM4a8r782BCAgorkqr+o1nwwW/Sv4zxuex+SSZ049
	 aAMgm1H19vutU/d95bLm0vT1LEwPiJp/S0F3d373cTuCmV6INay0hoV+rFVoc4Bw61
	 4T+/Bbb8mRWcQ==
Date: Fri, 28 Aug 2026 10:45:55 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: sashiko-bot@kernel.org
Cc: x86@kernel.org, Joe Lawrence <joe.lawrence@redhat.com>, 
	Song Liu <song@kernel.org>, Petr Mladek <pmladek@suse.com>, Miroslav Benes <mbenes@suse.cz>, 
	linux-kernel@vger.kernel.org, live-patching@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] objtool/klp: Fix checksums for constant pool references
Message-ID: <apHIUvvJ8qL934vp@jpoimboe>
References: <22a92df358195864e83fb4cd16181c5faa63c489.1787889249.git.jpoimboe@kernel.org>
 <20260828040534.F1B3A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260828040534.F1B3A1F000E9@smtp.kernel.org>

On Fri, Aug 28, 2026 at 04:05:34AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [Critical] Hashing 0 bytes for `.LC` constants in `.rodata` sections due to `sh_entsize == 0`, leading to livepatch false negatives.
> - [High] Out-of-bounds read and false positives when referencing `.LC` constants with a non-zero relocation offset.
> - [Medium] The `.LC*` symbol check is bypassed for section-relative relocations.
> --
> 
> commit fbe33684e2b71a1fc6c9da77412adb627592aa7f
> Author: Josh Poimboeuf <jpoimboe@kernel.org>
> 
> objtool/klp: Fix checksums for constant pool references
> 
> This commit fixes false positive changed functions in livepatching caused by
> changes to .LC* constant names. It does so by adding the underlying data to the
> checksum calculation instead of the symbol name.
> 
> > diff --git a/tools/objtool/klp-checksum.c b/tools/objtool/klp-checksum.c
> > index b8e47f28997e9..359fd27616013 100644
> > --- a/tools/objtool/klp-checksum.c
> > +++ b/tools/objtool/klp-checksum.c
> > @@ -129,6 +129,14 @@ static void checksum_update_insn(struct objtool_file *file, struct symbol *func,
> >  		goto alts;
> >  	}
> >  
> > +	if (strstarts(sym->name, ".LC")) {
>         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> [Severity: Medium]
> Will this bypass the check for section-relative relocations?
> 
> If the compiler emits a section-relative relocation (where `reloc->sym` is a
> section symbol like `.rodata`) with an addend pointing to the `.LC` constant,
> this check will fail because the section name doesn't start with ".LC".
> 
> The code then falls through, resolves the actual `.LC` symbol via
> find_symbol_containing(), and hashes its name instead of its data. Should this
> check be placed after is_sec_sym(sym) is processed?

Doesn't happen... however there is a similar issue where in many cases
Clang uses a section symbol reference instead of creating a symbol.
I'll send a v2.

> 
> > +		void *cst;
> > +
> > +		cst = sym->sec->data->d_buf + sym->offset + offset;
> > +		__checksum_update_insn(func, insn, cst, sym->sec->sh.sh_entsize);
>                                                         ^^^^^^^^^^^^^^^^^^^^^^^
> 
> [Severity: Critical]
> Does this silently hash 0 bytes for non-mergeable sections like standard
> `.rodata`?
> 
> Because standard sections like `.rodata` have an `sh_entsize` of 0, objtool
> now hashes 0 bytes for these constants. This completely excludes the constant
> from the checksum. If a vulnerable constant is fixed, the livepatch checksum
> will not change, and the fix will be silently omitted.

Doesn't happen, these are always in .rodata.cst<num> which always have
entsize.

> [Severity: High]
> Can this cause an out-of-bounds read and false positives when referencing
> `.LC` constants with a non-zero relocation offset?
> 
> If an `.LC` constant in a section with `sh_entsize > 0` (e.g., `.rodata.cst8`)
> is referenced via a relocation with a non-zero addend (`offset > 0`), the start
> pointer `cst` is shifted forward by `offset`, but the length parameter remains
> the full `sh_entsize`.
> 
> By reading `offset` bytes past the end of the constant, objtool hashes
> adjacent, unrelated constants. This falsely binds the function's checksum to
> unrelated data, and if the constant is at the end of the section buffer, it can
> cause an out-of-bounds read past the allocated `d_buf` boundary.

Doesn't happen, the addend is already adjusted to match the symbol
itself, and the middle is never referenced.

-- 
Josh
