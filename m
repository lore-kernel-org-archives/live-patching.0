Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AE0346E6D;
	Thu,  6 Aug 2026 05:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785993284; cv=none; b=BVe0++LAmXBOp817o4I5s2UU3v7eQutGn+pQ9R0se60uclgkD+Vw3uCbmHVIgrCxZGFEakYCJ3KblDVWWyR1RZkHIcLmf1usjqtV+esWbdFxI6C5iVtPgMBWzqKSseK+nZEg00OpsVdHhCxc746UFFdf/DN227zRTDpmlzhr+x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785993284; c=relaxed/simple;
	bh=IpD0S00n1aaySDqvumbNJ05Aoy8b2FDDKpepMt7QTJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HEnqzbCmppk3yNMNQ9iZZ/h30cNuHyk0Kq1G1bI933WGxydbHp5uPvSUejRH6J8xeV1d1ZykD8hHxjdNTdS2Qso4v7wN2O3AtHuBUhacFFFgxjJO3hp43rSOYsFnLNUn65VtE36sPgYTJFK7SQ0QwPLx1pjSKiCbqtVLvqA0fzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y474cnY1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y474cnY1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30F611F000E9;
	Thu,  6 Aug 2026 05:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785993283;
	bh=1h/40MnagXrvHFxVAE6cgFk1yZrIzXLLuxRy2OqsWPk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Y474cnY1SJR8UtYO+Ipn0i+BoMPlOJ6aLNgO0caaKofAQ/PyeXu2Qd7O+xU0ASd7P
	 im7lhFPPxEoIqirDJpegIzrALId7tO2oEPKwJCAcBnY28tVz2bDb1WFvz0PEZXLYd8
	 l0O/b3k7mIzgnOWGIQwWhL6TS9H7VmetuARN4dh92xJOlF2FZDeZjbL8E/oagQ7smN
	 mHjRkHRuJUqgqhA6aoE5tOSyEspIU2BTxjYqgOJ054wGZAnTPIoKqT84mH9ts56RfR
	 TbIgBWJAnOsCezqpMvR0cmoDVQ4kM3wa/IrFqhBRYx5JHLTOvIeZw0zi7IoiV3ckDp
	 wHgD+aJMdc/Eg==
Date: Wed, 5 Aug 2026 22:14:40 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Song Liu <song@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	live-patching@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Joe Lawrence <joe.lawrence@redhat.com>, Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v2 3/7] objtool/klp: Ignore replacement offset of empty
 x86 alternatives
Message-ID: <n7vcinh4b6fxiialkkak6zyljtoereczrghqe44rv76uazurct@l2ljwl7rj4pr>
References: <cover.1785939903.git.jpoimboe@kernel.org>
 <9f9c0c444e078869f2bceac7ecc72fe7310e188f.1785939903.git.jpoimboe@kernel.org>
 <CAPhsuW5i95esQj9yT8M5Rv=KyqQDU+NBp=R9t+T=Ngd0JXA3Yg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW5i95esQj9yT8M5Rv=KyqQDU+NBp=R9t+T=Ngd0JXA3Yg@mail.gmail.com>

On Wed, Aug 05, 2026 at 01:51:44PM -0700, Song Liu wrote:
> On Wed, Aug 5, 2026 at 7:30 AM Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> >
> > An x86 alternative with an empty replacement, e.g. the second entry of
> >
> >   ALTERNATIVE_2("orig", "repl", ft1, "", ft2)
> >
> > has a replacementlen of zero.  Its replacement offset still gets a
> > relocation, but the label it points at is the end of the previous
> > replacement, which is also the beginning of the *next* alternative's
> > replacement.  The value is meaningless; get_alt_entry() already ignores
> > it for that reason.
> >
> > klp diff doesn't ignore it.  When such an alternative belongs to a
> > changed function, cloning its relocations drags in the unrelated
> > neighboring replacement, along with everything that replacement
> > references.  On an x86 clang/lto build an empty alternative in
> > meminfo_proc_show() pulled in the replacement of an alternative in
> > proc_kcore_init(), silently emitting a klp relocation against init text
> > which has long since been freed by the time the patch is applied.
> >
> > Add arch_alt_ignore_new_reloc() and skip such relocations when cloning.
> > This has to be arch specific: on arm64 a zero-length replacement instead
> > identifies an alternative callback, whose replacement offset points at
> > the callback function and must be preserved.
> >
> > Fixes: dd590d4d57eb ("objtool/klp: Introduce klp diff subcommand for diffing object files")
> > Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> 
> The patch looks good to me.
> 
> Acked-by: Song Liu <song@kernel.org>
> 
> Maybe we should add a __weak version of arch_alt_ignore_new_reloc(),
> but that can wait until we add arm64 support.
> 
> However, this reminds me the cross compile use case. With current
> arch_* functions, we cannot run klp-build on x86_64 build server for
> an arm64 kernel (right?). What's our plan with the cross-compile use
> cases?

I suspect it will be easy, objtool already works fine being
cross-compiled today.  Feel free to try it ;-)

-- 
Josh
