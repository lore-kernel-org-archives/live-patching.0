Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112C826158C;
	Mon,  3 Aug 2026 06:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785738369; cv=none; b=AQ8lmBlzy+xiuKBSw+i0OMwS9oTbovZaDios2DkCgaiDjbNvxM7WftlMcCA65ieF4CGWCeYDikDBgXGHrLQsuzlxj/r8SKpueSOdT+yrq30DO8s1V6Q5UznAyZZnIkVgvRzx/fdP2r8qr0pXE8dBfg+TUEsgzs0kpo4Pu2MdmxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785738369; c=relaxed/simple;
	bh=nBhrbH1Shm5nmD0pBCOSzKSTRy8JI5PP38ke0vW6Lcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mfw4pOiVar1fL4uLGCOWCusDFIDExV8LhXZoXO5cz2CIEiDmIzDzeMWHdEEz0jTIHABBjWWCiSA81XfpHnvmfK0GRlvJqh8xuzdoJjZ46HXnO6TOzbqvX/RFhch/b7zIMvoxBKvk2uouJx/ZFilATBJ2sFDYTJgv4v1M0zJZ+oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eAbb5/Nj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eAbb5/Nj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FFAA1F000E9;
	Mon,  3 Aug 2026 06:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785738367;
	bh=15veImrRX7sa/UEM5oFIzBfngp0sZOsSMJsNI0b3XMs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eAbb5/NjmJzF1BUdFT50yGUfz7XgLGd9NXuAbbhFT11RU4DDuwFlKiYzJJwVe740r
	 iOfsFRmO7agUhE51EEqbBlxBQdoljUIhOFr6Q9qzXg67/vFVV4z+eXEr+kpLORZz34
	 UXrXxF2Y197ViEFvw6lFezLT1Xhp4efHeQvpyGATl+OL3SxCTcPbMt0QQ5rbAsne/9
	 eu7qiLDUU+C03i09JZKX6fT4JZTfuYa6lqz2ZbPJNYEUNux/pgNIat5URAvWolERhO
	 oe9NhiPF4bDOefaqRG5UsjN/UOM/FJb7M7jcGED0+BTKLaaE3aaYBXJPBxwnYy5q+t
	 nIy1kmRoEy3Gw==
Date: Sun, 2 Aug 2026 23:26:05 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org, live-patching@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Joe Lawrence <joe.lawrence@redhat.com>, 
	Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, Song Liu <song@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	linux-modules@vger.kernel.org
Subject: Re: [PATCH 08/14] objtool/klp,livepatch: Resolve module symbols
 against core kallsyms
Message-ID: <ho6yp23ka6ibblqowzbe3axjlczrsqy23gdd57unsq5zd6urrh@h5if7q7at45r>
References: <cover.1785727106.git.jpoimboe@kernel.org>
 <5f7b6798592b20c6b4accb725ba87849f3224f2c.1785727106.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5f7b6798592b20c6b4accb725ba87849f3224f2c.1785727106.git.jpoimboe@kernel.org>

On Sun, Aug 02, 2026 at 08:24:30PM -0700, Josh Poimboeuf wrote:
> For patching a module, klp_find_sympos() counts every symbol table entry
> whose name matches.  However, the module loader only includes symbols
> matched by is_core_symbol().
> 
> The runtime count is inconsistent as well.  It's done by
> module_kallsyms_on_each_symbol(), which iterates the full init symbol
> table until do_init_module() swaps in the cut-down core table, so the
> same symbol can have different positions depending on whether init
> memory has been freed yet.
> 
> Define a module's sympos as its position in the core symbol table, which
> is what sympos already means for a live module and what users see in
> /proc/kallsyms.  Enforce that on both ends: count with
> module_kallsyms_on_each_core_symbol() at runtime, and mirror the
> is_core_symbol() filter in objtool with a new mod_sym_in_kallsyms()
> helper.
> 
> The init-layout half of the filter is only correct if .exit sections are
> core sections, which requires CONFIG_MODULE_UNLOAD, otherwise .exit code
> is laid out as part of init memory and freed after module init.  Enforce
> CONFIG_MODULE_UNLOAD to ensure that behavior is deterministic.
> 
> Symbols which exist only in init sections are no longer resolvable, but
> they never were once the module went live, and init memory is freed
> after module init anyway.
> 
> Fixes: dd590d4d57eb ("objtool/klp: Introduce klp diff subcommand for diffing object files")
> Fixes: b2b018ef4867 ("livepatch: add old_sympos as disambiguator field to klp_func")
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

NAK - as mentioned for the previous patch, this is a theoretical edge
case which I will fix in a different way.

-- 
Josh
