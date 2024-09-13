Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57001148FEC;
	Fri, 13 Sep 2024 23:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726268962; cv=none; b=RF5zqOU92HgwLQfacqlVnR8jAvCKrXGkn+yWRzz2WZiWXnsw3Z24EAPlHU8OsZKPPdqWTrZ/xhLTcwCZKiaTBokPX4GZR0FX6EQcA3PxlEITyNavVNpse3FDhefoxoca72v48KXr3DlGqYg4rC7u+C/qgyUV6DI5j13M5XkmWS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726268962; c=relaxed/simple;
	bh=a40GPw9hVMfVgc+BxC4NGI7aXGmLL+ben6nHSfFLSoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C2ewds8WGgJRTiUeHNzHp0dUwYY6duPjiNnXxwuYKZmWwXM6ArcOAQyyp3oUkLEomHhAKM9gA4pXnWKRn9ZjSQi0satoZ8lX/lYf7g2en7IwXTCZj6kIm+TRiV9ESNToRZw9CWMOflzAXwOJfOimxy0+0RMI61Y/LdGM2Kjauxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p9u/01Bn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p9u/01Bn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B162BC4CEC0;
	Fri, 13 Sep 2024 23:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726268961;
	bh=a40GPw9hVMfVgc+BxC4NGI7aXGmLL+ben6nHSfFLSoI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p9u/01Bnjkb5xUnZVZMVo4GAU8z1b3Vhc5uDrMvbGKGwOFNKB1FhNZNnLZw6F6Gn1
	 eBT5Gz51zNNXb/IbmeJhGff5Y4u6ofidWX+4EraCKH8Zga0PhrNrBNLnVE16Y/XAmx
	 pFUMg3sQOFypSOUDml8/+cvTABl9XUmzno7VKlRzua+i2GJ9LqSlzZERZCCNnzJAti
	 5LD0Xj8j31OCjwi1LnTqBgsexLnbE9u5xPu6cYmCYBcvob4AuqoWojlUrELzhr2w9o
	 YbZrVRTZz5BIgzlSEWO9t+pv4PYFPBgsKKl44Drv/7GnU3o3p1iVU//PSwtvYoRzGC
	 JYuomzIlZlFUQ==
Date: Fri, 13 Sep 2024 16:09:15 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Joe Lawrence <joe.lawrence@redhat.com>
Cc: live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org, Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>, Jiri Kosina <jikos@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Marcos Paulo de Souza <mpdesouza@suse.com>,
	Song Liu <song@kernel.org>
Subject: Re: [RFC 00/31] objtool, livepatch: Livepatch module generation
Message-ID: <20240913230915.7pztbotrf7cpjp7a@treble>
References: <cover.1725334260.git.jpoimboe@kernel.org>
 <20240911073942.fem2kekg3f23hzf2@treble>
 <ZuLwJIgt4nsQKvqZ@redhat.com>
 <ZuROlpVFO3OE9o1r@redhat.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZuROlpVFO3OE9o1r@redhat.com>

On Fri, Sep 13, 2024 at 10:39:18AM -0400, Joe Lawrence wrote:
> and now a happy kernel build and boot.

Thanks!

> A klp-build of the usual cmdline.patch succeeds, however it generates
> some strange relocations:
> 
>   Relocation section '.rela.text' at offset 0x238 contains 6 entries:
>       Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
>   0000000000000016  0000004600000004 R_X86_64_PLT32         0000000000000000 __kmalloc_noprof - 4
>   0000000000000035  0000004e00000004 R_X86_64_PLT32         0000000000000000 __fentry__ - 4
>   000000000000003c  0000000000000000 R_X86_64_NONE                             -4
>   
>   Relocation section '.rela.klp.relocs' at offset 0x1168 contains 2 entries:
>       Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
>   0000000000000000  0000000700000001 R_X86_64_64            0000000000000000 .text + 3c
>   0000000000000008  0000000000000001 R_X86_64_64                               -4
>   
>   Relocation section '.klp.rela.h..text' at offset 0x53f18 contains 1 entry: 
>       Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
>   000000000000003c  0000000000000002 R_X86_64_PC32                             -4
> 
> No bueno.  FWIW, Song's 0001-test-klp.patch does seem to build w/o odd
> relocations and it loads fine.

Grr, I'm guessing more toolchain issues.  A lot of tools don't seem to
like klp relocs.

Do you happen to have BTF enabled?  I saw something similar with BTF and
had a fix in mind but I haven't had a chance to do it.

-- 
Josh
