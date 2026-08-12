Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68FD36A004;
	Wed, 12 Aug 2026 20:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786566177; cv=none; b=kWEZZwl80Ol5qiShsDDH5LZHVeCftbeCfNiR/voyEBam9PMwoi/raKpIVrKGFkLjJ7RKDo2iFYCgSD4o4dopqIpoDkgBRvT67lHcE+5Bk6G/N83EJkEldsk//SemzZTf4uk3QTaQK7qhYmOQqiVUWSoowuKgJavxITMHrJmTL20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786566177; c=relaxed/simple;
	bh=xdf4pNvcxeTfRKDEWUnjQ8mjljWcz2WN7inGpdCjj48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y/mG4haEXc8Ocj5TZ+M88kU96iouW8txWO8MwylCtWj89yQWC88efX1EjXeWKT57Yc7OhMapODWWzbQyqUxOMwwIlFPPFO89NbqzZ8wih5KieHFfE9AhtmhLUkI737wZdXr03uar25tqbxsY3JNElbuz5jW6YtzG9CJlTbK4X7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+IdGcqL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+IdGcqL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 931351F000E9;
	Wed, 12 Aug 2026 20:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786566175;
	bh=yn464TWMd6Mcu7PeVlB2NcOdEGOLtO5YwEWKvy7tmkw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=E+IdGcqLhqHYlgvyZK1VNjSy4s5vQDDZwbCvS73xK5h1ixXJr1joxjkvjiBTbZZdE
	 c4fdyQ1CYhwEHTPTWn2qvlnL1+YHvty0HcFAi0F+bOAlzVHjyxfkLXwGgQEmP9gLbp
	 IblV42C4Lf4Uc70eUVMwRCUHKNf/CGQvEiGV4IB9PtiThF41wK6lIt3x5CwXeZAiat
	 wzpl32e3jhXBM/z6+MH8eFOID84ACgft/fYP/1q0m+7oqZZ3GgPRz4Gfe3f+fsveEQ
	 lXLi0fd5luE676WoJ1WqAhXjm2YIB+RA+EiFdJP4yQjzcgTPwej1iPIV91EaB4OQ6u
	 VmLDye18Dmiow==
Date: Wed, 12 Aug 2026 13:22:53 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: sashiko-bot@kernel.org, linux-modules@vger.kernel.org, 
	Puranjay Mohan <puranjay12@gmail.com>, live-patching@vger.kernel.org
Subject: Re: [PATCH 05/14] objtool/klp: Add .klp.symid for sympos
 disambiguation
Message-ID: <anzWBbrO2H0ohACw@jpoimboe>
References: <cover.1785727106.git.jpoimboe@kernel.org>
 <64d50f077b569f47883c015cdb7079edb068efe8.1785727106.git.jpoimboe@kernel.org>
 <20260803034116.43C111F000E9@smtp.kernel.org>
 <7avwg6oos7kjtotwlpcxhy5qiviu5gzhwew2ibjcfccu4vbonu@25ayhrgt7b33>
 <m24igzlbxf.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <m24igzlbxf.fsf@kernel.org>

On Wed, Aug 12, 2026 at 02:13:00PM +0100, Puranjay Mohan wrote:
> Applying the patch below fixes it:
> 
> -- >8 --
> 
> From 93c99313870d7375ab07e494c2d0d971758578eb Mon Sep 17 00:00:00 2001
> From: Puranjay Mohan <puranjay@kernel.org>
> Date: Fri, 7 Aug 2026 11:16:29 -0700
> Subject: [PATCH] objtool/klp: Fix vmlinux .klp.symid link error for
>  .exitcall.exit symbols
> 
> Building a kernel via klp-build fails to link:
> 
>   `__exitcall_aes_mod_exit' referenced in section `.klp.symid' of vmlinux.o: defined in discarded section `.exitcall.exit' of vmlinux.o
>   `__exitcall_dax_exit' referenced in section `.klp.symid' of vmlinux.o: defined in discarded section `.exitcall.exit' of vmlinux.o
>   `__exitcall_hid_exit' referenced in section `.klp.symid' of vmlinux.o: defined in discarded section `.exitcall.exit' of vmlinux.o
>   `__exitcall_usb_serial_module_exit' referenced in section `.klp.symid' of vmlinux.o: defined in discarded section `.exitcall.exit' of vmlinux.o
> 
> module_exit() on a built-in emits a static __exitcall_$fn pointer into
> .exitcall.exit, which vmlinux.lds.h discards unconditionally via
> EXIT_CALL.  When two built-in translation units define a module_exit()
> function of the same name, the resulting local symbols collide,
> symid_needed() sees a duplicate and emits a .klp.symid entry for each,
> referencing symbols the linker then throws away.
> 
> Same-named module_exit() functions are not rare:
> 
>   dax_exit                drivers/dax/device.c, drivers/dax/fsdev.c
>   hid_exit                drivers/hid/hid-core.c, drivers/hid/usbhid/hid-core.c
>   aes_mod_exit            arch/arm64/crypto/aes-ce-ccm-glue.c, lib/crypto/aes.c
>   usb_serial_module_exit  module_usb_serial_driver() expands to this fixed
>                           name in each of its ~49 users
> 
> The last one makes the collision structural rather than accidental: any
> kernel with two built-in USB serial drivers has it.  This is not arch
> specific either; it only requires the objects to be built in rather than
> modular, which is why a monolithic config trips it while a typical
> distro config does not.
> 
> Add .exitcall.exit to the discarded section list so its symbols don't get
> symids.
> 
> This is the same failure mode as "objtool/klp: Fix vmlinux .klp.symid
> link error for .no_trim_symbol symbols", for another unconditionally
> discarded allocated section.
> 
> Fixes: 029223d30162 ("objtool/klp: Add .klp.symid for sympos disambiguation")
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>

Indeed, I'll add it to the queue, thanks!

-- 
Josh
