Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA37D35C6AB;
	Thu,  6 Aug 2026 05:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785993992; cv=none; b=u/TKR/dn8Y5J3XyU35tcOl4jRGe7sSgYcOQ8Hjr2Im3RhXvme+fpIk01EUDUm5mjs9zcSaBuyX7i9LPlKwsrc2LSqogtbbNM9lMSv84e42h2RBP6db/pHI9i6gDDjKuMdEc44YjV9EBw8Q4ShBpcC2smr+KIqWul/Ye1PHufbZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785993992; c=relaxed/simple;
	bh=hOLSIQSn7ZedRjpsrBHobV+XKWyQV8jVDiN8UwsZ2Ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o9oK7B666tb5W7nLuj6r9RW/61GdD301LATyVCWpQHQbWJWi/8fLp1UnzS+kzydI0psf1vUOtwR7HmT82xyqLddE1qzBGJypVuDT4eIw/dXKfIZl3s7HQ7gU7WsEZ4RbsVGJQcAj1XEVIG+fA6Awxo/dKkXIro8u/D+/QxsHvIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mkZZx6Pm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mkZZx6Pm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DB131F000E9;
	Thu,  6 Aug 2026 05:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785993991;
	bh=K99uHo7yfkpBR+PAi6VsUUx9AAvQ/bQhQ/ST9BEY8cU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mkZZx6Pmi2tUMNC9vlam6RWRgIoEbJDl5LJ/v2V5zjenQklALm0fjriQ7HkQbkFbh
	 li+pfmPCZgIyKL7V++1nUFvh4QEmynyxtVFw1N9UHn2cMRwCoigZ9P2Z+OdrltCI8c
	 b+vkgwj7EANjGP09F7mnvFzM0lzjVi2Fvwt2MBX2rR+LVrA/ny4VOof9MsLZd4sB5G
	 ivnrkF74mnfav0fUATj5z403idinYUQV9QqKMkDfs8PzKfCqtKIXRQS60Nn3w3d/9f
	 P2ddqyEizeaO7ZBdMB+fX7rKVvn8kLDBM1JgwkWptMoXE30jqUF86ttxa/Gs1kug4s
	 wKSAKmxWSnuCw==
Date: Wed, 5 Aug 2026 22:26:28 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: sashiko-bot@kernel.org
Cc: x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	live-patching@vger.kernel.org, Joe Lawrence <joe.lawrence@redhat.com>, 
	Miroslav Benes <mbenes@suse.cz>, Song Liu <song@kernel.org>, linux-kernel@vger.kernel.org, 
	Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v2 4/7] objtool/klp: Explicitly disallow patching or
 referencing init code/data
Message-ID: <nfsxjza2oeqaa3vg7yce5n756vlad2oghlw6hgvh57b7wjaioq@xwtuxuv2234h>
References: <cover.1785939903.git.jpoimboe@kernel.org>
 <a8edecfad944523b2b1e294b66c28c22fc50dad3.1785939903.git.jpoimboe@kernel.org>
 <20260805151203.D96FD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260805151203.D96FD1F000E9@smtp.kernel.org>

On Wed, Aug 05, 2026 at 03:12:02PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] The `.init` safety check is bypassed for exported module symbols, allowing livepatches to silently reference freed init memory.
> --
> 
> --- Patch [4]: [PATCH v2 4/7] objtool/klp: Explicitly disallow patching or referencing init code/data ---
> commit fe2fe6cc51b729f1eb6addc3f9e161e818ce482f
> Author: Josh Poimboeuf <jpoimboe@kernel.org>
> 
> objtool/klp: Explicitly disallow patching or referencing init code/data
> 
> This commit explicitly prevents the patching and referencing of init code
> and data to avoid edge cases. It introduces an init check in the sympos
> resolution to handle targets that might have their init section freed.
> 
> > diff --git a/tools/objtool/klp-sympos.c b/tools/objtool/klp-sympos.c
> > index bbfae516d3395..dfca9dd746812 100644
> > --- a/tools/objtool/klp-sympos.c
> > +++ b/tools/objtool/klp-sympos.c
> [ ... ]
> > @@ -376,6 +381,11 @@ unsigned long klp_find_sympos(struct elf *elf, struct symbol *sym)
> >  	bool has_dup = false;
> >  	struct symbol *s;
> >  
> > +	if (is_init_sym(sym)) {
> > +		ERROR("%s: can't patch or reference init code/data", sym->name);
> > +		return ULONG_MAX;
> > +	}
> > +
> 
> [Severity: High]
> Does this check adequately protect against exported module symbols?
> 
> Looking at clone_reloc_klp() in tools/objtool/klp-diff.c, if the symbol
> is exported, the code skips calling klp_find_sympos() entirely:
> 
> tools/objtool/klp-diff.c:clone_reloc_klp() {
>     if (export) {
>         sym_modname = export->mod;
>         sym_orig_name = export->sym;
>         sympos = 0;
>     } else {
>         sym_modname = find_modname(e);
>         if (!sym_modname)
>             return -1;
> 
>         sym_orig_name = patched_sym->twin->name;
>         sympos = klp_find_sympos(e->orig, patched_sym->twin);
>     ...
> }
> 
> If a livepatch object references an exported init symbol from a module,
> would it bypass this new safety check and potentially result in a reference
> to freed init memory once the target module finishes initialization?

An exported init symbol?  That's not a thing :-)

-- 
Josh
