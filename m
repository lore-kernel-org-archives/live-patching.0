Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795330766;
	b=thwzY/rpVhFC70cdjOBt2aypETKlKgsdcOlTF7xHUQodWhATjhi+Tr5EJBjrntdz5Rbm
	 dfS4nxplEtmrerIVOp4QybYSvPHrcnTdzUcIcBplOvMxaOnEKZ0DnRhyteTtFVjeOBtmy
	 AY4ed3g9AXqE41ccLfGOETcb5NnzbfRvDzc2kAREnR4vKIfyE9v1E9aG2+2vrziau/NQ5
	 4Mr0YkmwybZMN6baKMvOQ2rOaX20T9PKpxwCuLC0H/M7Z17+sK0AUGGetA4K+6kxwioZd
	 y8EQGaAjWJZbEpbw3YAptlOF1AIwu+e0d65hFFBRBTKQStq2ud7N8fj+/LcVm5DRbag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795330766;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=c4NckgM/hKf1r0IfgHyxm4hsgrGGjRw4xZB41IbLUPc=;
	b=jx1+EjlXMFQyooIdTi0UPqLcNu6BD4RGx2h5jTPUr2s7eF9T1NiDLBMhD5ptwaKAzg1H
	 J9K6I6rlozjQJQPEaMCfZiWiH+Ow0rmvYcMLKYV+KWprdcBZc+vGzW5kk8Fgbio5XkYIF
	 atEEi0DbwVDuamoXXcxPrQ6ynUNCoQ4IqunbyQyI6U2CVPDGP19aQ4L5tHlv8nic0+ZSQ
	 5xDFl62Yra19SF3Hcx16X6FtWeDSyaXg/n7JQWQ1J/M+j9FkKrBdHut9gSGnUVRNnVQwG
	 PIkUrgUbtZa88UR1OuGnKbqCGvvleuexmkp+fYF/nJ/fIizDb4JPqk8CSxJXTMd8b/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nX+Px6Zc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF0B606A320
	for <live-patching@vger.kernel.org>; Sun, 22 Nov 2026 06:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nX+Px6Zc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91F701F000C4;
	Sun, 22 Nov 2026 06:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795330766;
	bh=c4NckgM/hKf1r0IfgHyxm4hsgrGGjRw4xZB41IbLUPc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nX+Px6ZcDAyF4TLu0lKmHD0Dz3gHL6YA3XUyXfqNxj3yN9MusE89UoAxTO5WP0vhX
	 hUs6Cy/ZPnq5PWh0jqOu90ThrknpCi3oh9Ck2VCNkJCS4zDB6ikwI/B1hJNLxj6HH/
	 hehbhCFJElvVIdSXvrFkPQ3WjpLvaKquVA//3fB8lSYSfP7S+/DryRqjJuzi2ONxjv
	 Z5kd1r+61O4c+V4SxMuA/L92nKL0zwmHB+BdbIqLsNZdZJV54VzkTYf8tzdzBS9B5g
	 thaOHu2rrTOelWaMFCH16gKFoCYuGDNmzexPTacbb8O3W5Jy0bbLMANWeTRht9CIjo
	 BjsZUhGScarKQ==
Date: Sat, 21 Nov 2026 22:59:24 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Song Liu <song@kernel.org>
Cc: live-patching@vger.kernel.org, jikos@kernel.org, mbenes@suse.cz, 
	pmladek@suse.com, joe.lawrence@redhat.com
Subject: Re: [PATCH] objtool/klp: Fix detection of static keys defined in
 other files
Message-ID: <awKSm5V0ay0chjJj@jpoimboe>
References: <20261006071003.291679-1-song@kernel.org>
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261006071003.291679-1-song@kernel.org>

On Tue, Oct 06, 2026 at 12:10:03AM -0700, Song Liu wrote:
> validate_special_section_klp_reloc() finds the key of a __jump_table or
> .static_call_sites entry by looking for a reloc to an STT_OBJECT symbol.
> But a key is STT_OBJECT only in the object file which defines it.  In
> any other object file it is an undefined symbol, which is STT_NOTYPE,
> and the check misses it.  For example, with tracepoint keys:
> 
>   Patched file            Tracepoint          Key defined in       Type
>   ----------------------  ------------------  -------------------  ------
>   vmlinux:
>   kernel/sched/core.c     sched_switch        same file            OBJECT
>   kernel/sched/fair.c     sched_stat_runtime  kernel/sched/core.c  NOTYPE
>   kvm.ko:
>   arch/x86/kvm/x86.c      kvm_msr             same file            OBJECT
>   arch/x86/kvm/lapic.c    kvm_apic_ipi        arch/x86/kvm/x86.c   NOTYPE
>   cachefiles.ko:
>   fs/cachefiles/io.c      netfs_sreq          vmlinux              NOTYPE
>   kvm-intel.ko:
>   arch/x86/kvm/vmx/vmx.c  kvm_exit            kvm.ko               NOTYPE
> 
> Missing a key in vmlinux is harmless, as the check accepts vmlinux keys
> anyway.  Their entries are cloned with a normal reloc to the key if
> vmlinux exports it to all modules, as for netfs_sreq, and with a klp
> reloc otherwise, which the module loader applies before it initializes
> the livepatch module's static branches and static calls.
> 
> But a livepatch can't use a key defined in a module, so klp-diff has to
> disable such tracepoints, as it does for kvm_msr above.  For keys
> defined in another file of the same module, as for kvm_apic_ipi, or in
> another module, as for kvm_exit, it instead clones the entries with klp
> relocs for their keys.
> 
> The resulting patch module crashes the kernel on load.  The livepatch
> module's static calls and static branches get initialized while their key
> fields still wait for the klp relocs.  The static call init rewrites the
> call instruction, so applying its klp reloc fails:
> 
>   module: x86/modules: Invalid relocation target, existing value is nonzero for sec 66, idx 16, type 4, loc ffffffffa04021f3, val ffffffffffffe0f5
> 
> and static_call_del_module() then dereferences the bogus key while
> cleaning up after the failed init:
> 
>   BUG: unable to handle page fault for address: ffffffffa2373994
>   RIP: 0010:static_call_del_module+0x38/0x80
>   Call Trace:
>    static_call_module_notify+0x42/0x1a0
>    notifier_call_chain+0x5f/0xd0
>    blocking_notifier_call_chain+0x41/0x60
>    do_init_module+0x23d/0x2a0
> 
> Also treat undefined symbols as keys.  The other relocs of these entries
> refer to code in the patched object, which is always defined.
> 
> Fixes: dd590d4d57eb ("objtool/klp: Introduce klp diff subcommand for diffing object files")
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Song Liu <song@kernel.org>

Ack, can you add a test?

-- 
Josh
