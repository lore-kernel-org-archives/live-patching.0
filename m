Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45F0327204;
	Sat,  8 Aug 2026 22:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786228037; cv=none; b=tGpAbIeX4bw0IUNtsyjA1ktnLke5O1YnZkLEmi5cxyJA1VzlVrwynx0jPcAV8rINcSXWo/gEQcz+Lulzp28KUM+LPxm1Yiem8WzUCVjO3RKIupnNv1V/tZxlyBEcAZZ3vEeNEtqvlZLP1AEYYpY24MBMBvUJi5G4oRfDNC5w9Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786228037; c=relaxed/simple;
	bh=VCHbWIQNPNsknUBASEXLbVK/RdfFCUbZsEhj6/lSOiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hE52QTrnBlX5d5D6o0wXhFH0U7DWfKUdwAiZsIOd7FIWTtXj25trYB7Qp1CCDunG87RNf06uwGZSFyrY5VwleoUv1zeumHTgpCKl1nMGaZ2XCA9i1y5YO1XI9yREbXMmfo/Kbfaa40PoevUiTjIH0AuHolp35zMVBwiyGgfP36I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eVTxXU8c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eVTxXU8c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 056A61F000E9;
	Sat,  8 Aug 2026 22:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786228035;
	bh=edQQ0s8Iknkp6crosDQqRTNAVdzOELr128WmL/UzFSA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eVTxXU8cAgGUK+1+wbSDRE8Z6mAxe00Dmy5dBTTTc7L91mynRVi69om+yQ12ibndp
	 T8yizAbXLbaw+fFrLPsJNj/fO4LaesSjSS81kchEroq1CSVHdctgWPfgXIB2jx/pMN
	 hbIx/J4Os05npCOK6HQJ7NY1QiM/0MkxD00eFcCvmyOlqMt3Sglc5f4wIBAbOTjmOP
	 TLbPWqv7vAFQfpI4r6bOesxhZ3YyEug/a4HihJXBB7kFRhsgv9x1/1DuTbM45pK1bn
	 oOXkGPA0aWZVanPqq7LXpTvX80SxDSQzc30kYUfN1u5zguSTFtI2M3eFNlrYfeXE73
	 2fRO4kcAn5pkQ==
Date: Sat, 8 Aug 2026 15:27:12 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: sashiko-bot@kernel.org
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	Miroslav Benes <mbenes@suse.cz>, Joe Lawrence <joe.lawrence@redhat.com>, 
	live-patching@vger.kernel.org, Petr Mladek <pmladek@suse.com>, Song Liu <song@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 6/9] objtool/klp: Don't match local symbols against
 exports
Message-ID: <cszcq3rnuqjsjfokfqrs7gnppvgmb54w6hstlfr5zlvge4di4n@37rbb7257e7y>
References: <cover.1786138493.git.jpoimboe@kernel.org>
 <dafc7c017d1f62e2190a20dc84a52fbfc4c70210.1786138493.git.jpoimboe@kernel.org>
 <20260807214611.E16B51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260807214611.E16B51F000E9@smtp.kernel.org>

On Fri, Aug 07, 2026 at 09:46:11PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Unexported global symbols that share a name with an export are incorrectly matched against the global exports list, causing misrouted livepatch relocations.
> --
> 
> --- Patch [6]: [PATCH v3 6/9] objtool/klp: Don't match local symbols against exports ---
> commit 91941e947fdde72be13c7760463244a153a175ce
> Author: Josh Poimboeuf <jpoimboe@kernel.org>
> 
> objtool/klp: Don't match local symbols against exports
> 
> This commit updates find_export() in klp-diff.c to ignore local symbols.
> This addresses an issue where static functions or variables that share a
> name with an export are incorrectly treated as export references during
> livepatch generation.
> 
> > diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
> > --- a/tools/objtool/klp-diff.c
> > +++ b/tools/objtool/klp-diff.c
> > @@ -1101,6 +1101,9 @@ static struct export *find_export(struct symbol *sym)
> >  {
> >  	struct export *export;
> >  
> > +	if (is_local_sym(sym))
> > +		return NULL;
> > +
> >  	hash_for_each_possible(exports, export, hash, str_hash(sym->name)) {
> >  		if (!strcmp(export->sym, sym->name))
> >  			return export;
> 
> [Severity: High]
> This is a pre-existing issue, but does this still leave unexported global
> symbols vulnerable to incorrect matching?
> 
> If a module contains an unexported global symbol that shares its name with
> an unrelated exported symbol, it will bypass the is_local_sym() check.
> 
> When the module is livepatched and klp-diff processes a relocation to this
> internal symbol, find_export() will perform a string match and return the
> unrelated export. Would this cause a KLP relocation to incorrectly point to
> the external module's export instead of the internal symbol?

I'm not convinced this is a realistic scenario (module having a global
symbol with the same name as an exported symbol), but as mentioned it's
a preexisting issue that can be fixed in a followup.

-- 
Josh
