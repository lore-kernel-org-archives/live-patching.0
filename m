Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D651D38DC46;
	Tue, 11 Aug 2026 15:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786460713; cv=none; b=iiRJMsH9MkxUGZsQXu6Wabz715/kam3UwQvsg/iwh1GsZ1XP54pq7HAS7wReVgurfBV3G7VS1EWHy+lFk6Trx8Wg8Up7QjU2SgN/32PyaDxq4iSjDgidDAbFr3c7DghKyvcVa3Qk4U1lm4f034YTyogTbICv+eqNbKerSsI5VE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786460713; c=relaxed/simple;
	bh=a08XD1xfcfwEI+p0Gujs6p6I77SwYneccGfysZiwM4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pY2zGKSGKrTKknx7DNcOutPdYyH3bmEN+oS7aSY9WMQEKGfguZ6geKByhSclfXBWbcaSWoOeXQr1bq6+9isG7mG6IkzD/0/KBRPVcgohKkB5+sjXCaHG6AS09FbKwsBrfogPGIE1Re+RpIFRggm/mvNiiTqKdbqPERg/VpGp9vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aexcBMYP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aexcBMYP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 865EE1F000E9;
	Tue, 11 Aug 2026 15:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786460712;
	bh=6+MVHdy+Bs9IaPCVFSThr9cXyhAAx94aZeBeve4fRLQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aexcBMYPs2NwyRM5PCi5003jGTLA1csL1Q1uf//32B01jqWI2XjoOADHwCdTew3I2
	 7hfTeCexKCndbVmfFD4ToyqmvwtVRwf4y8I4IrmwF7VZrgQMIj5pQfSnHNs09V4Ae/
	 gW9lk72jPddGe7rdp+/CIaETn6i4naAAquANQ/SF4QRZ2sXbDJ7KOv3tdCfQiOQR5K
	 k09f0znq+e0joWJhDwgswx+puw1LJjunV5p7vETDA4Vy9UW1jCcVAiRvrpPPCbZqy/
	 rdsrmUqselEQ/v6pO/S/VEV0kgUyrVhNQz9x57sHtxOJn3fywC+R6fqilB7mFKYPDm
	 HU4h+nF6CcqbQ==
Date: Tue, 11 Aug 2026 08:05:10 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Will Deacon <will@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	live-patching@vger.kernel.org, Song Liu <song@kernel.org>, Miroslav Benes <mbenes@suse.cz>, 
	Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH] arm64/module: Fix livepatch BTI exceptions with Clang 21+
Message-ID: <zom5vznqvzwksixpwmkfrbj6wjcyanqebiyanbviwa6ckr5s4z@guvkptdunu24>
References: <anmobvJXiBQqWn6S@willie-the-truck>
 <e5q2mvqtf6iw4lco55uny5ffhppw6vlflxguhc4gg5nm3zdvmo@zs6rw7iov5qc>
 <08d6c5cd-9924-4359-9181-a03718161528@app.fastmail.com>
 <kp4rvh4vxo65gipgqz4i4dnw2ueylmus4yys6xfrbngp5nefzn@4a4ekjlzqlph>
 <CAKwvOdmSVjY0TmOTc6WMmDHcLbn=tOV3R3zH_TO4zXZiYEsaBw@mail.gmail.com>
 <anrvDIWMNGIa4WPK@willie-the-truck>
 <4986ac98-d6da-474a-b218-b6468b68cb9f@app.fastmail.com>
 <16e3ed42-1b1f-4ddc-9d8c-5e12ee7dbe3c@app.fastmail.com>
 <answWdRpVQLtIzIj@willie-the-truck>
 <eb01f226-b067-42dc-be86-328a19a20844@app.fastmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <eb01f226-b067-42dc-be86-328a19a20844@app.fastmail.com>

On Tue, Aug 11, 2026 at 04:55:37PM +0200, Ard Biesheuvel wrote:
> 
> On Tue, 11 Aug 2026, at 16:23, Will Deacon wrote:
> 
> > Author: Josh Poimboeuf <jpoimboe@kernel.org>
> > Date:   Tue Aug 11 14:11:44 2026 +0000
> >
> >     arm64: bti: Disable in-kernel BTI with recent versions of Clang
> >    
> >     The following BTI exception was seen when loading a livepatch module:
> >    
> >       Internal error: Oops - BTI: 0000000036000001 [#1]  SMP
> >       pstate: 634004c9 (nZCv daIF +PAN -UAO +TCO +DIT -SSBS BTYPE=jc)
> >       pc : kill_orphaned_pgrp+0x0/0x150
> >       lr : do_exit+0x498/0xaf0 [livepatch_combined]
> >    
> >     The problem is that the patch module's do_exit() is branching to a
> >     static function in vmlinux using a module PLT veneer (indirect branch),
> >     but the target function doesn't have a BTI landing pad.
> >    
> 
> I had missed this bit before, i.e., the fact that the target is a static
> function inside vmlinux.
> 
> The lack of a BTI landing pad suggests that the address of this function
> is never taken either, and so the symbol in question is not exported to
> modules, right?
> 
> Does KLP make any special accommodations to ensure that this is safe? Otherwise,
> BTI is not the only potential issue: the compiler may apply interprocedural
> optimizations, and the function in question may not be AAPCS64 compliant as
> a result.
> 
> It also means treating cross-section jumps as indirect calls in the BTI
> landing pad elision heuristic would not work around the issue here.

Yes, the livepatch module creation process takes interprocedural
optimizations into account.

With kpatch-build and the new in-tree klp-build (x86 only, arm64 coming
soon), it does a binary diff between the old and new kernels, and
extracts the changed functions.  So if the interface between caller and
callee changes, they both get patched.

-- 
Josh
