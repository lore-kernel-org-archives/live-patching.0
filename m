Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B646C1DA62E;
	Wed, 12 Aug 2026 20:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786566463; cv=none; b=jGh6JLmYTPCjhp8SWbsj2hD570LaEgt2ee6A/VnizY9+JzGSI3G9u7+WObt9tAMPJ8TSlcX0QdBLvwQpY0e/Be3g3gOyMVbnw2wGdiM4iUasR05SSAwqLrCBSNbBKOq+0jNaZEhNuSTL0j9h5diiObVZKoxzCX2rS9APHGUFCyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786566463; c=relaxed/simple;
	bh=7DuCacVKQQB7KD8aUX2UUjEwejCZecvQiKbZ9VyEQMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZEHB2KTpI0SC7ZdRRmXB2MkGVwayHDYflJifVV/ycsHN4k85YuItEVp9uyyQfVnSOrpLXCRNUKBeaLmLemCJG8Uf7tlOqs9M1ae6f2kS5zCR59WL8Di+9mJsYAPrHVxVeSR/9y2zcvE+e7l3fxAaSwlTom3dtCcRwIBZZ4MU5eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AbtACFxg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AbtACFxg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 499831F00A3A;
	Wed, 12 Aug 2026 20:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786566462;
	bh=OpCepermQq//YeiElvQ/2E+EV95N4EOJ9TwA7uU933Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AbtACFxgn9FtrEh2CFo6/aN3NRnwzO2QT86FN8/9CCr+tkOgCwRyk+K0XvujUiMeH
	 tl+PLDOiI51wv8at2vduXlu7EybL9+19YBKmZ9qVh51RqJVHbCajEDSWQnAK/WN59U
	 6QWuvIL98D0FAvI33+ukoNlSgVTirnqEPNSSgllDqtBE950zaBokLEqk01GvjS3DR7
	 gtB9m9BfLZcdaKW5K3Wb6yJGnChr8kRBcdHH/83rXj51SPYOlbd8hrbe0tqrx4oLBW
	 CKtHVsrOAAJF1xCvtYQ011vTKnMXZo+1z9vSbY7Xnx2WRYWIK4Q/OpAl0MmYLMnUnr
	 f0AkhvYE/+rjw==
Date: Wed, 12 Aug 2026 13:27:39 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	live-patching@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Joe Lawrence <joe.lawrence@redhat.com>, Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, 
	Song Liu <song@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, linux-modules@vger.kernel.org, 
	Ben Procknow <bprockno@redhat.com>, Dylan Hatch <dylanbhatch@google.com>
Subject: Re: [PATCH 03/14] objtool/klp: Fix false module dependencies caused
 by dead relocs
Message-ID: <anzW_H5OlQ-MqWjf@jpoimboe>
References: <cover.1785727106.git.jpoimboe@kernel.org>
 <9548393f4d89ec3b498f4f69aa6ef6b9bb7150fe.1785727106.git.jpoimboe@kernel.org>
 <anyufyGq2d-7AC_H@google.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <anyufyGq2d-7AC_H@google.com>

On Wed, Aug 12, 2026 at 10:33:51AM -0700, Sean Christopherson wrote:
> +Dylan
> 
> On Sun, Aug 02, 2026, Josh Poimboeuf wrote:
> > When creating a klp reloc, klp-diff keeps the original relocation but
> > converts the referenced symbol to an UNDEF/WEAK placeholder tombstone
> > symbol, which gets fully disabled later by klp post-link.  The tombstone
> > symbol is only needed to avoid confusing objtool when it does the final
> > run on the patch module.
> > 
> > However, for references to exported symbols, modpost sees the reference
> > to the tombstone symbol as a real reference to an exported symbol,
> > resulting in a false module dependency getting created.
> > 
> > Further, for a reference to a tombstone symbol which is exported into a
> > module namespace, e.g. via EXPORT_SYMBOL_FOR_KVM_INTERNAL(), modpost
> > can't satisfy the dependency, resulting in a warning like the following:
> > 
> >   module ... uses symbol kvm_flush_remote_tlbs from namespace
> >   module:kvm-amd,kvm-intel, but does not import it.
> > 
> > Rename the placeholder tombstone symbols to ".klp.tombstone.<name>" so
> > modpost no longer recognizes them.
> > 
> > Fixes: dd590d4d57eb ("objtool/klp: Introduce klp diff subcommand for diffing object files")
> > Reported-by: Ben Procknow <bprockno@redhat.com>
> > Reported-by: Joe Lawrence <joe.lawrence@redhat.com>
> > Link: https://lore.kernel.org/20260720145658.1103243-5-joe.lawrence@redhat.com
> > Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> > ---
> >  tools/objtool/elf.c                 | 13 +++++++++++++
> >  tools/objtool/include/objtool/klp.h |  2 ++
> >  tools/objtool/klp-diff.c            | 16 ++++++++++++----
> >  3 files changed, 27 insertions(+), 4 deletions(-)
> 
> Naive question(s) incoming...
> 
> How does livepatching deal with the kernel's restrictions around module-specific
> namespaces/exports?  AIUI, klp builds a livepatch module, and then loading the
> resulting livepatch.ko (or whatever its called) performs the actual patching of
> the kernel.  If a patched function in livepatch.ko references an module-specific
> exported symbol, how does it actually resolve that symbol?
> 
> AFAICT, livepatch.ko would need to explicitly import the module namespace, but
> then it would run afoul of setup_modinfo()'s checks that a module isn't explicitly
> importing a module namespace.
> 
> E.g. if (not-so-hypothetically) one were to try to livepatch
> nested_vmx_enter_non_root_mode(), how would livepatch.ko get at things like
> kvm_service_local_tlb_flush_requests() and kvm_spurious_fault() without also
> creating copies of those functions?  Wouldn't the kernel need something like the
> below to exempt livepatch modules from the restriction?

Indeed, though we approached it from the tooling side, see this (not yet
merged) patched:

  https://lore.kernel.org/fe5a00818e06ec613344d41d5944de054fcd8832.1786138493.git.jpoimboe@kernel.org

-- 
Josh
