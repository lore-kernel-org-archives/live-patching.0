Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79574302F2
	for <live-patching@vger.kernel.org>; Tue, 28 Jul 2026 12:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785241095; cv=none; b=refSUqjsDoKu4NaGgxdLNilSKKXEjzSNpMHfl9qTVh/+lZCIb1cVObZelaPFoZWRocrvq/tuihTYiozzIzQY5zj7EbFL6WeRDW022Y862O7lLLjx23JBPRVLYp8Qg0S+1T2pAkUHnmrZgmxOlrnWioVcy9FbQhYsnA0ugBKNDbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785241095; c=relaxed/simple;
	bh=VhNkV4XPm3xUVTc3b7IDiV3MAQuX5l4QKkgbHRgTZ7A=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=PpLyWhzUdgO3tQwPu0/pSV9/YaX5LxWZblZdn439AAVxg+0DLiP4QoFPgTxkxWLa2mmW6FgfE9h/cDV565Fic7WYJmKlMuRcXRxnptTlUZ3usQd2RpbSACDNnipIpdsRzvgIwfRByXIbE5J1by/Pd4e4emB5vZ/vhs0GRrZVOO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HGOVwTop; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Vo/viatn; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YU/2timu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xbvRpKiP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HGOVwTop";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Vo/viatn";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YU/2timu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xbvRpKiP"
Received: from pobox.suse.cz (unknown [10.128.32.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 74A237C26B;
	Tue, 28 Jul 2026 12:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785241087; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CCa5vDTIvNK9Oou/ApkLmK0YQPo38UTLhrXv8nAWuUU=;
	b=HGOVwTopIibaUuJNJruD+OAXh6LXnQ9BH0i+U8/gVQb5+NCRmf8BVL3gDveUDh4+RvbZ2Y
	Gqumlp/rXpkkR9K5S1GBKYG+MSgxeZLCbyXBuhmjX0tdaJaPfdBXXJv+0OCxIhCMA7JHG8
	X0HGJSbJDaVrdd3efGst5PR2wYwOWk8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785241087;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CCa5vDTIvNK9Oou/ApkLmK0YQPo38UTLhrXv8nAWuUU=;
	b=Vo/viatnHXJqmsXQvEb2t0a8+bIluyaTwL+Ak5dRO6Rdhy+6iJyQVqjqeElBkbXNwGCacH
	NITKWk008Ri/lvDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785241083; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CCa5vDTIvNK9Oou/ApkLmK0YQPo38UTLhrXv8nAWuUU=;
	b=YU/2timumP9nBOI7pyrMineZR5jwpDp4lP0EjovuAVlXjNidfOrremx6LTnTX9/VlmGMZ8
	XClNSQWzi8EIRWRRvjgNhUysXJjv+CfBufB+DRzp3WeXxCFNhih2XJqk0sPnjtkvxDlPwH
	NTGHnDlAxfxyxpNs9ADlNllIBZVdWVo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785241083;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CCa5vDTIvNK9Oou/ApkLmK0YQPo38UTLhrXv8nAWuUU=;
	b=xbvRpKiPJYcSFImqCc2mWrldT2gPFWGlAO+ifPJrvKBb71oMeOvwlDfgfb1Hs4X2QZbS6q
	93FitRwsJZno5WCA==
Date: Tue, 28 Jul 2026 14:18:03 +0200 (CEST)
From: Miroslav Benes <mbenes@suse.cz>
To: Josh Poimboeuf <jpoimboe@kernel.org>
cc: Joe Lawrence <joe.lawrence@redhat.com>, live-patching@vger.kernel.org, 
    Ben Procknow <bprockno@redhat.com>, Jiri Kosina <jikos@kernel.org>, 
    Petr Mladek <pmladek@suse.com>, Song Liu <song@kernel.org>
Subject: Re: [PATCH 0/1] Fix exported symbol klp-relocation bug
In-Reply-To: <6kbyujrfzo7on5p24wb5e4iadzomjewpuwkofktgodiit3qlta@3uxl4foryfq6>
Message-ID: <alpine.LSU.2.21.2607281417130.10979@pobox.suse.cz>
References: <20260713213128.3529250-1-joe.lawrence@redhat.com> <alpine.LSU.2.21.2607231109210.6525@pobox.suse.cz> <6kbyujrfzo7on5p24wb5e4iadzomjewpuwkofktgodiit3qlta@3uxl4foryfq6>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.992];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_ZERO(0.00)[0];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	URIBL_BLOCKED(0.00)[pobox.suse.cz:helo,pobox.suse.cz:mid];
	TO_DN_SOME(0.00)[]

On Fri, 24 Jul 2026, Josh Poimboeuf wrote:

> On Thu, Jul 23, 2026 at 11:25:25AM +0200, Miroslav Benes wrote:
> > Hi,
> > 
> > > Next: symbol namespaces
> > > =======================
> > > 
> > > Now a harder question, I think, about symbol namespaces.  In the past,
> > > kpatch-build had supported patching symbols in namespace where
> > > MODULE_IMPORT_NS() is allowed.  Looking at kvm :: mmu.c
> > > ::kvm_flush_remote_tlbs(), that is annotated with
> > > EXPORT_SYMBOL_FOR_KVM_INTERNAL() instead.
> > > 
> > > Should we make an effort to support klp-relocations / patching to this
> > > use-case?
> > > 
> > > If modpost were to let klp-relocation symbols through, I *think*
> > > (untested) that might be enough... but it seems like that may violate
> > > the spirit of what the namespacing effort is trying to achieve.
> > > 
> > > Note that klp-post-link converts these symbols to SHN_LIVEPATCH before
> > > the module is loaded, so the kernel module loader already skips them in
> > > simplify_symbols() (see SHN_LIVEPATCH case).  AFAICT, the namespace
> > > check in modpost is the only enforcement point, and it's checking a
> > > symbol that will never be resolved through the normal module loading
> > > path anyway.
> > 
> > I think we will see more and more EXPORT_SYMBOL_FOR_MODULES() in the 
> > kernel. kvm is probably by far the most interesting one for us as of now.
> > 
> > Tough. All changes in upstream so far, as I remember, around reducing the 
> > possibility to use internal symbols for OOT modules (like kallsyms API but 
> > there are probably more) have been done with KLP usage in mind. Or at 
> > least people tried. However, there is a limit to it. If we introduce a 
> > workaround in upstream for this, people will definitely use it to get 
> > around the enforcement in their OOT modules. We should avoid that in my 
> > opinion.
> > 
> > So I would keep whatever we come up with in downstream.
> 
> klp relocs are already designed to enable accessing those.
> 
> The symbols being warned about by modpost are basically placeholder
> tombstone symbols which are only needed so as not to confuse objtool
> when it runs on the patch module.  They otherwise have no functional
> runtime purpose, as they are replaced by klp symbols/relocs.  So it's
> probably fine to just rename them to avoid triggering modpost:

Ok.
 
> diff --git a/tools/objtool/include/objtool/klp.h b/tools/objtool/include/objtool/klp.h
> index 6f60cf05db86..aab6db42052d 100644
> --- a/tools/objtool/include/objtool/klp.h
> +++ b/tools/objtool/include/objtool/klp.h
> @@ -23,6 +23,8 @@
>  #define KLP_RELOCS_SEC	"__klp_relocs"
>  #define KLP_STRINGS_SEC	".rodata.klp.str1.1"
>  
> +#define KLP_TOMBSTONE_PREFIX	".klp.tombstone."
> +
>  struct klp_reloc {
>  	void *offset;
>  	void *sym;
> diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
> index f7a02c4a2429..505553f9bdc1 100644
> --- a/tools/objtool/klp-diff.c
> +++ b/tools/objtool/klp-diff.c
> @@ -1359,6 +1359,7 @@ static int clone_reloc_klp(struct elfs *e, struct reloc *patched_reloc,
>  	s64 addend = reloc_addend(patched_reloc);
>  	const char *sym_modname, *sym_orig_name;
>  	static struct section *klp_relocs;
> +	char tombstone_name[SYM_NAME_LEN];
>  	struct symbol *sym, *klp_sym;
>  	unsigned long klp_reloc_off;
>  	char sym_name[SYM_NAME_LEN];
> @@ -1373,15 +1374,21 @@ static int clone_reloc_klp(struct elfs *e, struct reloc *patched_reloc,
>  	/*
>  	 * Keep the original reloc intact for now to avoid breaking objtool run
>  	 * which relies on proper relocations for many of its features.  This
> -	 * will be disabled later by "objtool klp post-link".
> +	 * reloc now targets a functionally dead tombstone symbol and will be
> +	 * disabled later by "objtool klp post-link".
>  	 *
> -	 * Convert it to UNDEF (and WEAK to avoid modpost warnings).
> +	 * To avoid modpost warnings, convert the symbol to UNDEF/WEAK and
> +	 * rename to .klp.tombstone.sym_name to prevent modpost from creating a
> +	 * false module dependency or warning about module namespaces.
>  	 */
>  
>  	sym = patched_sym->clone;
>  	if (!sym) {
> -		/* STB_WEAK: avoid modpost undefined symbol warnings */
> -		sym = elf_create_symbol(e->out, patched_sym->name, NULL,
> +		if (snprintf_check(tombstone_name, SYM_NAME_LEN,
> +				   KLP_TOMBSTONE_PREFIX "%s", patched_sym->name))
> +			return -1;
> +
> +		sym = elf_create_symbol(e->out, tombstone_name, NULL,
>  					STB_WEAK, patched_sym->type, 0, 0);
>  		if (!sym)
>  			return -1;

Yup, that looks like an improvement. Thank you.

Miroslav 

