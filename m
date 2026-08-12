Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CBB2BE034;
	Wed, 12 Aug 2026 00:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786494637; cv=none; b=Pio649EhjjRc18YCVywmL4pE2xBHCYF4qvV853wG4k4dw/A3za2dkhTzQqeMMvzR6UhIagRp1qpSHy98uWeAVpT7gIKLJo3wjzflipig9UMMMFS5Ov9WwazwwQv/YfefNcBMObFvksnZplKo8HL+ZF+9MezBY+NHMcOQfw4Vro0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786494637; c=relaxed/simple;
	bh=0ZrRxQ/PTGWPmEsGfLxU1v1K4gHWZvpy6lbdhrRYhEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G9eblaYBHzUYIu1aUVuSKhNTgIpfybFUQjbzulQiUW8OI02rnpjmZfJgIVVqUwwWzORa2VmfyJI+E9BSKroStgwl6BwBhxRKMaUETTL4DmDFr47cJeKvgaIWE6oXX6tq0eNe0Y5YqMaUvQV3++gl8N75Y/ICTy8gNL8k+LA3dGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CMchk1oU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CMchk1oU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E267D1F000E9;
	Wed, 12 Aug 2026 00:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786494636;
	bh=NvlyJKdE192JAO01xRoJhAr4gdn8qg9JaO5oXNv+qhI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CMchk1oUOFt2K8ezRECQ5ICwvGOQlMvPhdI0E8Jxfl3xTl1lzAoghSQz6l0sseXEQ
	 3FsUz3Egsybpxb71hQaTmSjmIPhEwg1A0axkWuDsEfMAJcFHw+4ryi5XuFdgXlxGuR
	 qTsj0/XXr4v6XLIKEZwxQrc7QEm9UUo4gsvusQcPHJGQ6lbCdptE+jhpQUuRTsyYlB
	 ynJsDHjZBnPvTGGaIbptOUTPYH6HmMyho97FUx1Dh6hShs8snmsgS4/s7v8nyHXxhf
	 rWEbOSxrErnyOGeN7uwFkIlpDo3bQWx0MrW8c+yjmj6K6RClSYosZDguy9BFEgrSK9
	 Qf5vSh93MNq6Q==
Date: Tue, 11 Aug 2026 17:30:34 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Song Liu <song@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	live-patching@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Joe Lawrence <joe.lawrence@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	Mark Rutland <mark.rutland@arm.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nsc@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v4 15/22] objtool: Prevent kCFI hashes from being decoded
 as instructions
Message-ID: <anu-Xbm02J7BgCIb@jpoimboe>
References: <cover.1786230311.git.jpoimboe@kernel.org>
 <11e49187e13d36d4257bc60cd2606e0ff5481dfc.1786230311.git.jpoimboe@kernel.org>
 <CAPhsuW5tzBOHnw42d31r_5k9eS28VrDLGXoUzS=hYkZmAyRbhw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW5tzBOHnw42d31r_5k9eS28VrDLGXoUzS=hYkZmAyRbhw@mail.gmail.com>

On Tue, Aug 11, 2026 at 04:58:05PM -0700, Song Liu wrote:
> On Sat, Aug 8, 2026 at 4:18 PM Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> [...]
> >
> > +/*
> > + * ARM64 mapping symbols ($d, $x, $a, __pi_$d, etc) which mark transitions
> > + * between code and data.
> > + */
> > +static inline bool is_mapping_sym(struct symbol *sym)
> > +{
> > +       return is_notype_sym(sym) && strchr(sym->name, '$');
> > +}
> > +
> > +static inline bool is_data_mapping_sym(struct symbol *sym)
> > +{
> > +       const char *dollar;
> > +
> > +       if (!is_mapping_sym(sym))
> > +               return false;
> > +
> > +       dollar = strchr(sym->name, '$');
> > +       return dollar && dollar[1] == 'd';
> 
> nit: is_data_mapping_sym() calls strchr() twice. Maybe we can
> optimize it by eliminating a strchr()?

I suppose it's a bit funky, but the compiler CSEs it, so it's harmless.

-- 
Josh
