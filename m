Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA98E3B5842;
	Tue, 28 Apr 2026 15:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777391351; cv=none; b=ngdR9Kqb5uSrgCjmyjJxC9xt8Yh3aRH61qtSpBdWvm4KFIaCvWprMJa5wlIy9T6NqscTIJV1Y6KxJj4fJ80C/XnN+jY/NMq2WwhJTXwKLIIUC6zrSQ0OHo+VNAm9oHWiuRXtqIwevXogOmuRPh9FPaMOvHUNfk5xuquDUPFOK34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777391351; c=relaxed/simple;
	bh=03TQzTheK8TtCLyZuFtbCWzHLPBnN0ETF8SNGTqGX5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oKZxI3uQJxJrPzGZJELPGFpCR+r+GGEqyQWmMBPLzdHA37Ch7s/SvzyRXtqCa7BxnybKmlpAwHI33W/qImVyKsOcuJVp6lPpp1cAu4HA9yNeyZj/i48cAgJw0KvHSDzFHEKEpqt43cEJs+aRYConDMxqOBdcRF2UAr8r8Ds1SBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DvGPpoPB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DvGPpoPB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D458DC2BCAF;
	Tue, 28 Apr 2026 15:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777391351;
	bh=03TQzTheK8TtCLyZuFtbCWzHLPBnN0ETF8SNGTqGX5w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DvGPpoPBvgYKQtMv1c3uPQLB0eFq3r0R536blIySxuzlozsQKH0cDK6EQo/BIei+Q
	 qDDqQJ8NAxsGwg6/bcCbK/XgpuXkW0TVTZow+f0rQlyJ3S8fo72ZHcALyRlT+nGBZ6
	 b/GnvL87eLLAfhEXvZ3O5KPcN7lF8gaxHsTbQBADjBjB7uwm5n7uob8HlaVCqygx8E
	 1FKIDEH8VRcYwxKIcPhnm/TkWRykC8dobCrbSyVF3bp/eFOvCp3B9+limatuj4zQWS
	 PBd/1/20dRaVRgDQVatIeqjjHDZsYfneC5khkb6NTqJU88xp3l0UaVwNRGdQZ0fXaM
	 KSky+vJt0ztkg==
Date: Tue, 28 Apr 2026 08:49:09 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Song Liu <song@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	live-patching@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Joe Lawrence <joe.lawrence@redhat.com>, Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH 11/48] objtool/klp: Fix handling of zero-length
 .altinstr_replacement sections
Message-ID: <5rflm26qqwedlghtf2ef7omsvrdgst63mfugywfmf7n5eflds5@23bqf5thl43u>
References: <cover.1776916871.git.jpoimboe@kernel.org>
 <99099e77dffb352f97c5276298ab344c186a3ee2.1776916871.git.jpoimboe@kernel.org>
 <CAPhsuW53h4mCj8=0bfGy5N8O9JCUMGgCZTpMY8c140wno+UPXQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW53h4mCj8=0bfGy5N8O9JCUMGgCZTpMY8c140wno+UPXQ@mail.gmail.com>

On Fri, Apr 24, 2026 at 02:19:52PM -0700, Song Liu wrote:
> On Wed, Apr 22, 2026 at 9:05 PM Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> >
> > When a section is empty (e.g. only zero-length alternative
> > replacements), there are no symbols to convert a section symbol
> > reference to.  Skip the reloc instead of erroring out.
> >
> > Fixes: dd590d4d57eb ("objtool/klp: Introduce klp diff subcommand for diffing object files")
> > Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> 
> Acked-by: Song Liu <song@kernel.org>
> 
> With a nitpick below:
> 
> [...]
> 
> > @@ -1293,12 +1301,15 @@ static int clone_sym_relocs(struct elfs *e, struct symbol *patched_sym)
> >                     !strcmp(patched_reloc->sym->sec->name, ".altinstr_aux"))
> >                         continue;
> >
> > -               if (convert_reloc_sym(e->patched, patched_reloc)) {
> > +               ret = convert_reloc_sym(e->patched, patched_reloc);
> > +               if (ret < 0) {
> >                         ERROR_FUNC(patched_rsec->base, reloc_offset(patched_reloc),
> >                                    "failed to convert reloc sym '%s' to its proper format",
> >                                    patched_reloc->sym->name);
> >                         return -1;
> >                 }
> > +               if (ret > 0)
> > +                       continue;
> 
> Functions that return -1, 0, 1 are usually more confusing. Shall we add more
> comments for convert_reloc_sym()?

Indeed, thanks.

-- 
Josh
