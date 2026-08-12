Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A053D42467E
	for <live-patching@vger.kernel.org>; Wed, 12 Aug 2026 22:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786573898; cv=none; b=Ht6qKe8TkSgukkxitW308RPWgkH3UvF4vjHsHJO19Lg7EqLGQs5sHe/B01oJw5r2cHPeTEKr5dtPUPJ3XdxkWBoX5Oo+OFfwAItQrxu8uSljgHlrWCFxtISDH/lJkVpCltPcLoCsCLY3TSdueS141Fq8x32FasZctEqTurfuDoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786573898; c=relaxed/simple;
	bh=NCgbA1Nl6htv7Ct5XsBTLJDqXai4MIz8g3kzJINWoo4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ULCn3YAQJVQuunHpYFbDetfLckcqqG4FwJJu6nt467Ut1uUSDMtnrRI3F4375d7XkQObIWCZd24I/uEKwcl02I4XpzFqioWe9FSYc5vbreaNWadvv6xXFGA4BVmhy7DvONeEPGd2vOjaOu8wEeA+1VOKuVlRdWWd9s4X6Uv+ULE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZMuj+zvd; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZMuj+zvd"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cb835525b10so129305a12.2
        for <live-patching@vger.kernel.org>; Wed, 12 Aug 2026 15:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786573895; x=1787178695; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rf33RbOQxtUsb9Ne02ZQYE/IyKd30WKKnCFvHNaI21k=;
        b=ZMuj+zvdWHFuqEUv8UnaT88fLTuVIE4fLPr4/t0XHr9yz8QGHsLFggGBrpXsK6tHzv
         eWsDf+zX2DpqZGYsWr8irmPu4D2Ogygt/Ydl7CkEof7YOim4OwdUdbKlq3dzNuom0Y5p
         5Pi/faopmDVsL4/oixGdnBYs5vvlJ8QJAGNFqtXj5tzQrrt0vBRyzuFWfu0ywOe20zUn
         cR3zZmfz8vlvCejXd7yyP3E/QNr/N8i7H6EXUDS51osO0ynfwNpy8TESVlmkrm1ll0OQ
         j17UtM1q9La+kFVLf9NQsr0ORlNuPRSIhdaSwNYltlt9ak1+gf+ecA/XdlDPC/pYihTe
         lo6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786573895; x=1787178695;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rf33RbOQxtUsb9Ne02ZQYE/IyKd30WKKnCFvHNaI21k=;
        b=Wy0S8xwo6U23BYOkmhtjhzRcYJjCHKNwG+ytNdD6YaGwl6KGM4vjm5RBc85je64QVr
         ZUvrmnn3ILPSxOL2lmTXN5Zua35iv8G1tpq6DpTECF4vWEJOnmVoMOciyujeZc4tV3Ni
         pUFw1Du+Iwo7Uw0ggl0quT0lsQ7WpIjNvqmI0tHNEh9+c7YtIOGKfheBpYA4vHkZas2x
         8kL6cGITYFHde/gQudzpnrTCTA3gp3GBZRpiWCYDkbKGVvEg6veg5Sc/at3y64OCiNoS
         5aa/BFafWUGR500Cc/f6J11RfktBYKTWasngc5dcKzJTWxRYX7hFyBekeURLmIQGlk+f
         ZNrw==
X-Forwarded-Encrypted: i=1; AHgh+RrfaVUW1j2gMlQGOwWpKja19TsjUq/s9Okl2/clvbJoC08Oui+qYU/jgvQUL0IBta+YGt2QIMUALI7RKi0l@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx1MVauxnPfme1Cx7QR0SW27hZlekaechHfyR8dtwNl5aya0rB
	X5akVfgQ5+dKrjvxGdPpta73nGbK/iDAZSfSG6CrFtgTKads6DrJZPatCcRsLlD7Q0GywiQRkOw
	/lUvv2g==
X-Received: from pgbfp7.prod.google.com ([2002:a05:6a02:2ce7:b0:c86:5f41:8c94])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:989f:b0:3c1:b9c:4890
 with SMTP id adf61e73a8af0-3cc55244655mr1599108637.22.1786573894658; Wed, 12
 Aug 2026 15:31:34 -0700 (PDT)
Date: Wed, 12 Aug 2026 15:31:33 -0700
In-Reply-To: <anzW_H5OlQ-MqWjf@jpoimboe>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1785727106.git.jpoimboe@kernel.org> <9548393f4d89ec3b498f4f69aa6ef6b9bb7150fe.1785727106.git.jpoimboe@kernel.org>
 <anyufyGq2d-7AC_H@google.com> <anzW_H5OlQ-MqWjf@jpoimboe>
Message-ID: <anz0Rbiytt0qEH0n@google.com>
Subject: Re: [PATCH 03/14] objtool/klp: Fix false module dependencies caused
 by dead relocs
From: Sean Christopherson <seanjc@google.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	live-patching@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Joe Lawrence <joe.lawrence@redhat.com>, Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, 
	Song Liu <song@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	linux-modules@vger.kernel.org, Ben Procknow <bprockno@redhat.com>, 
	Dylan Hatch <dylanbhatch@google.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Aug 12, 2026, Josh Poimboeuf wrote:
> On Wed, Aug 12, 2026 at 10:33:51AM -0700, Sean Christopherson wrote:
> > +Dylan
> > 
> > On Sun, Aug 02, 2026, Josh Poimboeuf wrote:
> > > When creating a klp reloc, klp-diff keeps the original relocation but
> > > converts the referenced symbol to an UNDEF/WEAK placeholder tombstone
> > > symbol, which gets fully disabled later by klp post-link.  The tombstone
> > > symbol is only needed to avoid confusing objtool when it does the final
> > > run on the patch module.
> > > 
> > > However, for references to exported symbols, modpost sees the reference
> > > to the tombstone symbol as a real reference to an exported symbol,
> > > resulting in a false module dependency getting created.
> > > 
> > > Further, for a reference to a tombstone symbol which is exported into a
> > > module namespace, e.g. via EXPORT_SYMBOL_FOR_KVM_INTERNAL(), modpost
> > > can't satisfy the dependency, resulting in a warning like the following:
> > > 
> > >   module ... uses symbol kvm_flush_remote_tlbs from namespace
> > >   module:kvm-amd,kvm-intel, but does not import it.
> > > 
> > > Rename the placeholder tombstone symbols to ".klp.tombstone.<name>" so
> > > modpost no longer recognizes them.
> > > 
> > > Fixes: dd590d4d57eb ("objtool/klp: Introduce klp diff subcommand for diffing object files")
> > > Reported-by: Ben Procknow <bprockno@redhat.com>
> > > Reported-by: Joe Lawrence <joe.lawrence@redhat.com>
> > > Link: https://lore.kernel.org/20260720145658.1103243-5-joe.lawrence@redhat.com
> > > Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> > > ---
> > >  tools/objtool/elf.c                 | 13 +++++++++++++
> > >  tools/objtool/include/objtool/klp.h |  2 ++
> > >  tools/objtool/klp-diff.c            | 16 ++++++++++++----
> > >  3 files changed, 27 insertions(+), 4 deletions(-)
> > 
> > Naive question(s) incoming...
> > 
> > How does livepatching deal with the kernel's restrictions around module-specific
> > namespaces/exports?  AIUI, klp builds a livepatch module, and then loading the
> > resulting livepatch.ko (or whatever its called) performs the actual patching of
> > the kernel.  If a patched function in livepatch.ko references an module-specific
> > exported symbol, how does it actually resolve that symbol?
> > 
> > AFAICT, livepatch.ko would need to explicitly import the module namespace, but
> > then it would run afoul of setup_modinfo()'s checks that a module isn't explicitly
> > importing a module namespace.
> > 
> > E.g. if (not-so-hypothetically) one were to try to livepatch
> > nested_vmx_enter_non_root_mode(), how would livepatch.ko get at things like
> > kvm_service_local_tlb_flush_requests() and kvm_spurious_fault() without also
> > creating copies of those functions?  Wouldn't the kernel need something like the
> > below to exempt livepatch modules from the restriction?
> 
> Indeed, though we approached it from the tooling side, see this (not yet
> merged) patched:
> 
>   https://lore.kernel.org/fe5a00818e06ec613344d41d5944de054fcd8832.1786138493.git.jpoimboe@kernel.org

Thanks much!  After educating myself (a very little bit) on KLP relocs, I think
I even understood all of that!
