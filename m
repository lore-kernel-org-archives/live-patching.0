Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687DB27B4F7;
	Fri,  7 Aug 2026 01:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786065917; cv=none; b=G8v6i23XoMYw5jnmEraPfovayaHT46lCso6hqiyVXWco1WKb9NQBMd4E4QZXUZZ+fnAPol2kqq5AC/TAOEIu44IuPziuKD0o8FvBE09GLCR1VSpOZ/LK0czxM3FTJbSCty1vAnQsvcQggnpDHZx2C59TRUV84IrJmWMjyEY4IMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786065917; c=relaxed/simple;
	bh=oBuBFaHEtAcuJz+FU7gAYIP/QpFjRlX8CQrQPuGpAvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QG82/Msyjio5DB0neT3ppwdBtdgWBoOOBCytypm1cRacUjcVadFa9hQjJc5/9nWzaE2SmkqqGT/51xk+fDtaTCbG37JiareoiPJnqiEKuHZaJxgut4w75ayg+TQK8IJJw3fhnW756baTUVhRjW36o5yqzxvP7ct2o/GnM0ctzJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QMhjy5JN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QMhjy5JN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44C461F000E9;
	Fri,  7 Aug 2026 01:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786065916;
	bh=NsLD+xY76wezW2PkwZN43DqUo5rugmA98XWjxd40woo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QMhjy5JNi5KO2VtZgD4XjTORrR4pTwMMHPWyx5+PZMityxzP1p0oc7gkwJVXLy4gD
	 K++Jz/msS7J5ueuR7NrHAk86GAvoMfVfWAqPcVkasHlVK2+upQVZIxIYlPqPpfrO6N
	 6iE5fy+ovrtIEIeJdy3MYJkjAihh7ksbeqYzmY5oJwahVyXsGRFfPDXYzfmgqG8g+R
	 uU3+hDIHEf9dCxdA/wnhLiW6i4a2XqzJ07HKkvf18G3H6Ywk3mcljvkS0xjInNxuCu
	 66qdvwQ3U7CPjYJA3MA6dzqDhrwUWWQgRJJNXezPwNn+H2zvgsfVzGzYoW7u+K9KET
	 Sm5ouGSjQfQNA==
Date: Thu, 6 Aug 2026 18:25:08 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Joe Lawrence <joe.lawrence@redhat.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	live-patching@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, Song Liu <song@kernel.org>
Subject: Re: [PATCH v2 0/7] objtool/klp: sympos/module/alternative/etc fixes
Message-ID: <rpq7jn4r5szyvzoucz6wnqgsh7npjqvcic6esvs7uvpahrvtzf@t6we4se4bllu>
References: <cover.1785939903.git.jpoimboe@kernel.org>
 <6a6608f4-0a05-4d75-8b7f-edddfac9c5d4@redhat.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6a6608f4-0a05-4d75-8b7f-edddfac9c5d4@redhat.com>

On Thu, Aug 06, 2026 at 11:57:55AM -0400, Joe Lawrence wrote:
> On 8/5/26 10:29 AM, Josh Poimboeuf wrote:
> > v2: 
> > - rebased on tip/master (first 6 patches were merged)
> > - dropped original patches 7-8 (will post followup)
> > - added .klp.symid fix
> > 
> > v1: https://lore.kernel.org/cover.1785727106.git.jpoimboe@kernel.org
> > 
> > This consolidates fixes for the klp-build issues reported by Joe over
> > the last several weeks, plus some more things I found while
> > testing/reviewing.
> > 
> > Fun stuff like symbol resolution, module dependencies, alternatives.
> > 
> > Joe Lawrence (1):
> >   objtool/klp: Allow new references to module exports
> > 
> > Josh Poimboeuf (6):
> >   objtool/klp: Fix vmlinux .klp.symid link error for .no_trim_symbol
> >     symbols
> >   objtool/klp: Fix size of empty special section entries
> >   objtool/klp: Ignore replacement offset of empty x86 alternatives
> >   objtool/klp: Explicitly disallow patching or referencing init
> >     code/data
> >   objtool/klp: Fix cross-module klp relocation section naming
> >   objtool/klp: Don't match local symbols against exports
> > 
> >  tools/objtool/arch/x86/special.c        | 27 ++++++++++
> >  tools/objtool/include/objtool/klp.h     | 10 ++--
> >  tools/objtool/include/objtool/special.h |  7 +++
> >  tools/objtool/klp-diff.c                | 65 ++++++++++++++++++++++---
> >  tools/objtool/klp-post-link.c           | 53 +++++++++++---------
> >  tools/objtool/klp-symid.c               |  1 +
> >  tools/objtool/klp-sympos.c              | 10 ++++
> >  7 files changed, 141 insertions(+), 32 deletions(-)
> > 
> 
> These changes (and follow-up comments) look pretty good (lightly
> tested).  Could "objtool/klp: Fix vmlinux .klp.symid link error for
> .no_trim_symbol symbols" peel off and merge sooner since it fixes a
> commit just recently merged?
> 
> Though I think there is a still gap for EXPORT_SYMBOL_FOR_MODULES
> symbols: those exported that way from vmlinux would presumably need a
> klp-relocation, but klp_reloc_needed() always returns false for all
> vmlinux exports.  Maybe we need to parse the namespace column from
> Module.symvers to special case those?  (At least, that is how I read the
> code, I don't have full repro test cases handy.)
> 
> This wouldn't block any of these patches, but if you are spinning a v3,
> we could consider tacking that on while we're here.

Indeed, I will do a followup patch for that one.

-- 
Josh
