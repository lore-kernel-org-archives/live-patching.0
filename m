Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795310376;
	b=V7BUEJdag2SPaX4w15LlF7BVApgYB6YG4qtj1vK+LWOaw0+nGYs3AvxMiU09zrqaAbTb
	 Nnv74NiDywJhrde+PpFk2no0UCl0DHQgQmluVTnGTuBtAbXsAeqmhda1YxLG8AIpZpfZr
	 VNSsBOKSKiQZ8U3yJcQZAx/uI1tlrdR6DKTdpYaKJY0iGp+veOpFRIsDylfUyiqcUIkLL
	 0RmptzIB+oieA1/R1es6csgF9xWWdA9UpH20tmWtGOvqRiLTDri7jvQZGNEV7XUyXqsss
	 Mk3tUrTCBQ/MlvODarD8z33FUtsllAUaBG66VQRpsvHUjrlwqYY1yW0YfVY9W+TmLPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795310376;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=W90DcGRkyt3+2wp7PXRX8KbAZmHuW0scIoqRVWqUO7Q=;
	b=ExoxoD3veYdt2V2Hp7WvMnjs+3gHJWGsbRxmQkqyhEGZZkpQVcK3zAxmbPIX4l0dG6L6
	 QBiH9UvUAc6faClYWB+O7koKrFIGZBf+qkgRXlK5PiadcqnoDsmosDJ8F859dJ6kWZZlB
	 LjC7NSBUOw0Y6mu6LKSh2E9arPDcBcwLLLMzr/hj9VswnqGDiwGI6KI5zPlCen6A1XhS3
	 NKLQFMa8FCC4sb4kpm8aRpoFKqnaA1Ews3ZfpGNYbN8koz5I2fMBMlSuxheuB07C8FSLY
	 vabD0GpUvRv7jG4VxRY9vKn+DSl2AlTBI1QEN3piQM3TUYlmUxsMAXfvc2EN6Y4W+mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JnD4BXXq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B143606A33C;
	Sun, 22 Nov 2026 01:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JnD4BXXq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F9581F000CA;
	Sun, 22 Nov 2026 01:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795310376;
	bh=W90DcGRkyt3+2wp7PXRX8KbAZmHuW0scIoqRVWqUO7Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JnD4BXXqF6hJhzMW3QsPQLV/cRI4lvn4MkT5AAp/434P/q0P94pfXXSL7wjYa2AM9
	 wXd1cL35PgktshKZlPJd1C8KD11uB6N+OIdobDGaCtSN0pPAamDOCZfuKpauSdGr7a
	 5fYRBSFWQT0Cx9Q/Mg7VEbukiOFtF6JTY2dGbikuBF2PUPf0/iMienn35KqlzkdTkj
	 zOdigQM4a8wyhIsFGZU4lMLqkclAtiN4QB88D8+WNCwqphrF1ZwqeYxciRfpsuVDDe
	 p0791PsogerP+ubMy7hx4ArX2GZLPD8f3M+xbfePTzYM1ZYZG6EkHsTWdglC9358vn
	 Qq3cZjOcvj88A==
Date: Sat, 21 Nov 2026 17:19:34 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Wilson Felipe Pereira <wfelipe@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Miroslav Benes <mbenes@suse.cz>, 
	Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>, 
	Song Liu <song@kernel.org>, live-patching@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dylan Hatch <dylanbhatch@google.com>, Yi Zhu <chuyee@google.com>
Subject: Re: [PATCH 1/2] objtool/klp: Disambiguate global symbols colliding
 with local symbols
Message-ID: <awJCWTSXV0J11rqP@jpoimboe>
References: <20261117000835.1992893-1-wfelipe@google.com>
 <20261117000835.1992893-2-wfelipe@google.com>
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261117000835.1992893-2-wfelipe@google.com>

On Tue, Nov 17, 2026 at 12:08:31AM +0000, Wilson Felipe Pereira wrote:
> klp_find_sympos() returns 0 for any non-STB_LOCAL symbol, symid_needed()
> skips non-local symbols when emitting .klp.symid entries for vmlinux.o,
> and clone_reloc_klp() hardcodes sympos = 0 when a relocation targets a
> restricted or module export.
> 
> However, a global symbol in one translation unit can share its name with a
> static (STB_LOCAL) symbol in another translation unit (for example,
> cgroup_storage_lookup in kernel/bpf/local_storage.c vs
> kernel/bpf/bpf_cgrp_storage.c). At runtime, both
> kallsyms_on_each_match_symbol() and module_kallsyms_on_each_symbol() count
> local and global symbols together, so emitting sympos 0 for the global
> symbol fails module load in klp_find_object_symbol() with 'unresolvable
> ambiguity for symbol'.
> 
> Allow defined non-local symbols to receive .klp.symid entries when
> duplicate names exist in vmlinux.o, compute sympos for defined non-local
> symbols in klp_find_sympos() (returning 0 when unique and skipping
> undefined and non-alloc symbols), and resolve sympos via klp_find_sympos()
> in clone_reloc_klp() when the exported target is defined in the patched
> object.
> 
> Signed-off-by: Wilson Felipe Pereira <wfelipe@google.com>
> ---
>  tools/objtool/klp-diff.c   | 11 +++++++++++
>  tools/objtool/klp-symid.c  |  2 +-
>  tools/objtool/klp-sympos.c |  9 ++++++---
>  3 files changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
> index 34da55e45609..37ad315d00af 100644
> --- a/tools/objtool/klp-diff.c
> +++ b/tools/objtool/klp-diff.c
> @@ -1404,9 +1404,20 @@ static int clone_reloc_klp(struct elfs *e, struct reloc *patched_reloc,
>  	 */
>  
>  	if (export) {
> +		const char *modname = find_modname(e);
> +
> +		if (!modname)
> +			return -1;
> +
>  		sym_modname = export->mod;
>  		sym_orig_name = export->sym;
>  		sympos = 0;
> +		if (!strcmp(export->mod, modname) &&
> +		    patched_sym->twin && !is_undef_sym(patched_sym->twin)) {
> +			sympos = klp_find_sympos(e->orig, patched_sym->twin);
> +			if (sympos == ULONG_MAX)
> +				return -1;
> +		}
>  	} else {
>  		sym_modname = find_modname(e);
>  		if (!sym_modname)

This could be simplified a bit?

	if (export) {
		sym_modname = export->mod;
		sym_orig_name = export->sym;
	} else {
		sym_modname = find_modname(e);
		if (!sym_modname)
			return -1;

		sym_orig_name = patched_sym->twin->name;
	}

	sympos = 0;
	if (patched_sym->twin) {
		sympos = klp_find_sympos(e->orig, patched_sym->twin);
		if (sympos == ULONG_MAX)
			return -1;
	}

-- 
Josh
