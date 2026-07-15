Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7A2481649
	for <live-patching@vger.kernel.org>; Wed, 15 Jul 2026 15:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784130723; cv=none; b=bzi23rHlGmzIbg6aNG4tuoHxK88Mq69eNO8SYXgFreoPdtapDxhDPqVmEs1VpDSUIwnDW47L9CctK2dYDVKeQx1y5YO5L+nbSfWljRGxtUblR9t/Rx9QTI1nrhA7ifE2W/sv24BrJeYhZQFh5qBecdZ+ftmi64vTE7LDm7MuRwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784130723; c=relaxed/simple;
	bh=lc0XcZJ5Xbssm88UqlUjvpD4P7PxmB/UIKWFZoj0DrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ic8Gxf0IvQvg7qOiz1KPwAvOjrlszBdm7bzWrF4BIYvuvW4u+i+VbxwZ9hyNQ9lZ7XIfcA3t5IV8LSeH+dZtypNxO+dSULage8bY+F9/Eqbj2slyxGW4iW8fDZY9D5bib+cipeF1BqB9q+BcknwEuTJR/GetnicngGbeKl0Wy1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oHFiOZXE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oHFiOZXE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 964A31F000E9;
	Wed, 15 Jul 2026 15:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784130722;
	bh=uyZqEwi++UYwEA0gmvOfFu5Ce1CS0qLxQ3gMVGc0Lug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oHFiOZXEjomhNPvSbrHLtmAVp43wj2V7CkEaQC5k9S6+xkdP+8oUeVpZvK2rtrdlS
	 c7aAXAgvVAm+CAck8mUr+GLREE91N67aFo+ExosE4YnbzJU1jN1MjjLG6HGiKoj2E2
	 ds8SfzI+A6BsBqzRj/qIqekgrX4W/uOSoKkBl9/D5YScIdWYoxrxhUjrncbvfpSKCH
	 jYzF+HoRmxrs8an7IOf1oFrr5XyxvgsiJdW+oO64OIMuFmlmucmlsVDN5R33yF0DZw
	 sPxSwWySpW+rgOhEOPvEXNC3JJOUEoxoiYFFccJMBFO25bKHTPdfuaKTsFDaw2+KqT
	 QViY7VfBKWpFA==
Date: Wed, 15 Jul 2026 08:52:00 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Joe Lawrence <joe.lawrence@redhat.com>
Cc: live-patching@vger.kernel.org, Ben Procknow <bprockno@redhat.com>, 
	Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, 
	Song Liu <song@kernel.org>
Subject: Re: [PATCH 1/1] objtool/klp-diff: normalize Module.symvers paths to
 module names
Message-ID: <z5gsf64vdad2tr42c53g4umz2hmqiu4ith5b6ezjfvoidfdzfy@34mvdcndk7ro>
References: <20260713213128.3529250-1-joe.lawrence@redhat.com>
 <20260713213128.3529250-2-joe.lawrence@redhat.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260713213128.3529250-2-joe.lawrence@redhat.com>

On Mon, Jul 13, 2026 at 05:31:28PM -0400, Joe Lawrence wrote:
> Module.symvers contains build-tree object paths as module identifiers
> (e.g., "arch/x86/kvm/kvm") rather than runtime module names ("kvm").
> Objtool's clone_reloc_klp() uses this field directly for exported
> symbols, while unexported symbols correctly go through __find_modname().
> 
> This means that exported symbol relocations may land in a .klp.rela
> section named with the build path rather than the module name.  That is
> a crash waiting to happen: the kernel's livepatch loader silently skips
> this relocation because it doesn't match the expected klp_object name.
> The unresolved relocation sits in the newly activated code, crashing
> when executed.
> 
> Normalize export->mod at Module.symvers read time using the same logic
> as __find_modname() (refactored into a shared normalize_modname()
> helper).
> 
> Fixes: dd590d4d57eb ("objtool/klp: Introduce klp diff subcommand for diffing object files")
> Reported-by: Ben Procknow <bprockno@redhat.com>
> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>

Looks good, thanks!  I'll queue it up.

-- 
Josh
