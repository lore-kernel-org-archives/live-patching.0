Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D420D1624C0;
	Sat,  8 Aug 2026 00:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786149195; cv=none; b=CCJQcIO/9OwHW2Ahe5URnTXUc98vCE3ACFBlczJtONURqb8l8rMrCBX7vdMc9IQyYnlcJX8zYLbu2+gqe/e+L2RcWaAGGm3w3smTvyu7qZHB67t5PedzhEfZ6Prsy9HwqyGMI+Y4UQvQvqPF0Qotifi2e4L2iOf5+ryXG85gmRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786149195; c=relaxed/simple;
	bh=asQa1oKXnGA0+8/0b/cXeIPDOmuuR+q9wUO9RsbOGko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HXE2Jg/17iCwRC3za6PTnRzH5o5t8peWiVahUymYVvVkZ7lxwtYHvTKyL3vCYkGaG3Dfn1DjFoVV3uWSG9vCWS2RXc8inmAA3TTE+nG/vz/tGE6r1M9F50BcYRmAbBHrmRvGL98QyNzULr7Poiz1mZacsQD3frdR5H3a/M8QorI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hNufMEhE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hNufMEhE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A79E1F000E9;
	Sat,  8 Aug 2026 00:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786149194;
	bh=m+Oj3uWkY34NwPpBlXEx8i9PkPfVKPmRlTMGNMOx57g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hNufMEhE7XhvQCVhz80JhxOTPKOpI2ZOt8r5+a8EwxMpWD85d1aYL1Ozk1pzPPgKn
	 F70gamQUqooiGZBr8FrxNJ3sLz6Mcb/DtUIfNZzEGLklNLZcUsk2VkMESRWHcgVD/T
	 pRJOJzWdxolhWn770mWh4vDx66OY0zOWqeutmGKUQljfKVumATE+KBy5Nq+54dZOb5
	 u0K4HVDW1+NjRt/oBe8YcBiVM7UwURl7naEIAuZhCukxxgSjnCLOiLrI6rUhLr+hQF
	 W1WFnTLFhWmuiHrrnjledz8KIkSwN3PwzLCJ8HSZ/A5A0YTnlSaIg7k6s4NcC0NEmX
	 q0SObuLHwO37A==
Date: Fri, 7 Aug 2026 17:33:12 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: sashiko-bot@kernel.org
Cc: x86@kernel.org, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	linux-arm-kernel@lists.infradead.org, live-patching@vger.kernel.org, Petr Mladek <pmladek@suse.com>, 
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Miroslav Benes <mbenes@suse.cz>, Song Liu <song@kernel.org>, 
	Joe Lawrence <joe.lawrence@redhat.com>
Subject: Re: [PATCH v3 14/21] objtool: Prevent kCFI hashes from being decoded
 as instructions
Message-ID: <rvazkws6uosluw7lxjpf3pmxzhmktmxehj6momrjqpe6nuej3z@h6ip4ikjiwfo>
References: <b1d50c9fc9e6b9bca43833cc4ccbd88a31fed84b.1778642120.git.jpoimboe@kernel.org>
 <20260515001652.09947C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260515001652.09947C2BCB3@smtp.kernel.org>

On Fri, May 15, 2026 at 12:16:51AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] Build failure due to undeclared mapping symbol functions.
> - [Low] Unused header inclusion.
> --
> 
> commit 4ad78a24a64cd6a2d10b9a2f9c0d306fba3e6d19
> Author: Josh Poimboeuf <jpoimboe@kernel.org>
> 
> objtool: Prevent kCFI hashes from being decoded as instructions
> 
> On arm64 with CONFIG_CFI=y, Clang places a 4-byte kCFI type hash immediately
> before each address-taken function entry. This commit uses mapping symbols
> to mark such data as NOP in text sections to prevent objtool from decoding
> them.
> 
> > diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> > index e05dc7a93dc1e..2b03a2d6fc952 100644
> > --- a/tools/objtool/check.c
> > +++ b/tools/objtool/check.c
> > @@ -25,6 +25,7 @@
> >  #include <linux/kernel.h>
> >  #include <linux/static_call_types.h>
> >  #include <linux/string.h>
> > +#include <linux/kconfig.h>
> 
> This isn't a bug, but is this include needed? It doesn't appear that any
> Kconfig configuration macros are being used in the modified code.

Fixed.

> 
> [ ... ]
> 
> > @@ -478,6 +483,16 @@ static int decode_instructions(struct objtool_file *file)
> >  
> >  			prev_len = insn->len;
> >  
> > +			/* Use mapping symbols to skip data in text sections */
> > +			sec_for_each_sym_from(sec, map_sym) {
> > +				if (map_sym->offset > offset)
> > +					break;
> > +				if (is_mapping_sym(map_sym))
> > +					is_data = is_data_mapping_sym(map_sym);
> 
> Could this cause a build failure across architectures here? It appears
> is_mapping_sym() and is_data_mapping_sym() are neither declared nor defined
> anywhere in the codebase at this point in the patch series.
> 
> If these functions are only introduced in a subsequent commit, applying
> this patch independently might result in an implicit declaration of function
> error, breaking git bisectability.

Fixes.

-- 
Josh
