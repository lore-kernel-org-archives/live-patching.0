Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550AD42123A;
	Wed, 12 Aug 2026 11:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786534705; cv=none; b=OyF9J5WUnNyqsVHmSn4BMYEKelQ/71c685xPUaNKT9Tlh4mZoS0WlWFYZdXKr2iOmzy3b9tPp9H5qkf1kwHW6oRRtdpfdfu5n90uvP6xzH+TguO3iekRKbb4+DvE/NYB6XkD4zbVfN+7YqJobwbp7B4q33FqbnCX1DK5E64QbgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786534705; c=relaxed/simple;
	bh=vgqe1h+eYVYOWzbCJjtgWuVo61eMnLX5XXCOk1TxyDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YQ3a0hKcs/lZuOL65cyIjkz5abU0fQdXSqd8WlVc86x+cvpiq0dtXMdvvGVLn9SG/BOKnLrxkUOSk7nok3mK4KUAOtn2S6KwoZdI/rwCr7YLcEvV1Z+V06r5xR0/UXVlA0ObRVQciIZF7WqwPDDuG39idk14qZuI4wTN8PSk+AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mgUQ3KT6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dZglaoYa; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Kk/U+rhz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nhFtDdk7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mgUQ3KT6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dZglaoYa";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Kk/U+rhz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nhFtDdk7"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C89DC821A4;
	Wed, 12 Aug 2026 11:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786534697; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GiRdq+w0PozpCp7HO83flgdAQWcC6RKGzKFbWUYuU3E=;
	b=mgUQ3KT60b/eSylm2RIjYxXbJVeJerENDh65/fx15NNdQGNrJSrv/FY3V8f9Wvn/0iy1Uo
	U1BUm0hKXb5xeGzzLphvef5zYW5ZVUajsHCRKKpq/W7urBCtmJT/aJoCWLg0PekCPeFgXF
	K74gpr36xuCD9mnAQXhPdioJRuTPpOc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786534697;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GiRdq+w0PozpCp7HO83flgdAQWcC6RKGzKFbWUYuU3E=;
	b=dZglaoYaq2kyVKefpeLqXeiXzMS0bZmx4TDi/bEUB5Tu8rviwhYCDQkCsckQQwIDthvXgO
	yYlpO5A099f9SwDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="Kk/U+rhz";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=nhFtDdk7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786534692; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GiRdq+w0PozpCp7HO83flgdAQWcC6RKGzKFbWUYuU3E=;
	b=Kk/U+rhzHj+IBb9/qBxup7dBaOygsfyg5U92JTQELmXqPpD4miUes+npv2xc7/yYQ8ESOo
	7c2qWq/5+f+ahy4+3jOB5DVu/TymUPr/bS1G1ZFksD735mdYxt4wKZnlJ1hsOvJzKsDcGQ
	85IFrROZtOK/d8uJQGS49Sb5OY8d+OI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786534692;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GiRdq+w0PozpCp7HO83flgdAQWcC6RKGzKFbWUYuU3E=;
	b=nhFtDdk7Ok/obk+6RzjbTwEHQvuYZyfzsjSweHBGbvStIt9YiqDd+Scbr1Q57G9krIvm6f
	ibB6x5J2ChhmhkAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1037E779B2;
	Wed, 12 Aug 2026 11:38:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NzmbACJbfGotdwAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Wed, 12 Aug 2026 11:38:10 +0000
Date: Wed, 12 Aug 2026 12:38:08 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Nikunj A Dadhania <nikunj@amd.com>
Cc: rppt@kernel.org, akpm@linux-foundation.org, 
	anton.ivanov@cambridgegreys.com, bp@alien8.de, brendan.higgins@linux.dev, da.gomez@samsung.com, 
	danielt@kernel.org, dave.hansen@linux.intel.com, davidgow@google.com, 
	dianders@chromium.org, hpa@zytor.com, jason.wessel@windriver.com, jikos@kernel.org, 
	joe.lawrence@redhat.com, johannes@sipsolutions.net, jpoimboe@kernel.org, 
	kgdb-bugreport@lists.sourceforge.net, kirill.shutemov@linux.intel.com, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org, linux-um@lists.infradead.org, 
	live-patching@vger.kernel.org, lorenzo.stoakes@oracle.com, luto@kernel.org, 
	mark.rutland@arm.com, mbenes@suse.cz, mcgrof@kernel.org, mhiramat@kernel.org, 
	mingo@redhat.com, peterz@infradead.org, petr.pavlu@suse.com, pmladek@suse.com, 
	richard@nod.at, rmoar@google.com, rostedt@goodmis.org, samitolvanen@google.com, 
	shuah@kernel.org, song@kernel.org, tglx@linutronix.de, x86@kernel.org, 
	bharata@amd.com, ananth.narayan@amd.com
Subject: Re: [PATCH v3 9/9] x86: re-enable EXECMEM_ROX support
Message-ID: <anxa3VjtukAkY4Cl@pedro-suse>
References: <20250126074733.1384926-10-rppt@kernel.org>
 <20260812063316.21371-1-nikunj@amd.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260812063316.21371-1-nikunj@amd.com>
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: C89DC821A4
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[47];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLziudqfrzo6b7hzgpxksh1d9i)];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	URIBL_BLOCKED(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,ubuntu.com:url];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

On Wed, Aug 12, 2026 at 06:33:15AM +0000, Nikunj A Dadhania wrote:
> Hi,
> 
> A kernel BUG in __text_poke() is observed inside a Ubuntu 26.04 guest 
> (v7.0.0.28 and also with upstream v7.2-4c5). Host is running on v7.2-rc5.
> 
> SETUP
> -----
> 
> 512 QEMU Q35 guests (2 vCPUs, 1G RAM each) boot concurrently across 200
> iterations. The crash is seen during module loading in early boot.
> 2-7 guests out of ~100,000 boot attempts crash with the kernel BUG.
> 
> Reproduced on:
>   - AMD EPYC, QEMU Q35 guests
>   - Intel Icelake, QEMU Q35 guests
> 
> Apparently it was seen once in the non-guest Ubuntu 26.04 environment as well
> https://discourse.ubuntu.com/t/failed-boot-one-time-on-ubuntu-unity-26-04-educational-mission/85300
> 
> SYMPTOMS
> --------
> 
> Either of the below two crash signatures is observed:
> 
> Signature 1 — BUG_ON(!pages[0]) in __text_poke():
> 
>   kernel BUG at arch/x86/kernel/alternative.c:2564!
>   Oops: invalid opcode: 0000 [#1] SMP NOPTI
>   CPU: 0 UID: 0 PID: 741 Comm: (udev-worker) Not tainted 7.0.0-28-generic #28-Ubuntu PREEMPT(lazy)
>   Hardware name: QEMU Standard PC (Q35 + ICH9, 2009)
>   RIP: 0010:__text_poke+0x2a4/0x400
>   Call Trace:
>    <TASK>
>    smp_text_poke_batch_finish+0x25f/0x5b0
>    smp_text_poke_single+0x13/0x30
>    __static_call_transform+0x10e/0x210
>    arch_static_call_transform+0x5c/0xc0
>    __static_call_init+0x154/0x300
>    static_call_module_notify+0x144/0x170
>    notifier_call_chain+0x62/0xf0
>    blocking_notifier_call_chain_robust+0x62/0xc0
>    load_module+0x5ef/0x960
>   Modules linked in: ppdev(+) kvm(+) irqbypass ...
> 
> Signature 2 — BUG_ON(memcmp()) in __text_poke():
> 
>   kernel BUG at arch/x86/kernel/alternative.c:2632!
>   Oops: invalid opcode: 0000 [#1] SMP NOPTI
>   CPU: 0 UID: 0 PID: 742 Comm: (udev-worker) Not tainted 7.0.0-28-generic #28-Ubuntu PREEMPT(lazy)
>   Hardware name: QEMU Standard PC (Q35 + ICH9, 2009)
>   RIP: 0010:__text_poke+0x380/0x400
>   Call Trace:
>    <TASK>
>    smp_text_poke_batch_finish+0x323/0x5b0
>    smp_text_poke_single+0x13/0x30
>    __static_call_transform+0x10e/0x210
>    arch_static_call_transform+0x5c/0xc0
>    __static_call_init+0x154/0x300
>    static_call_module_notify+0x144/0x170
>    notifier_call_chain+0x62/0xf0
>    blocking_notifier_call_chain_robust+0x62/0xc0
>    load_module+0x5ef/0x960
>   Modules linked in: kvm(+) irqbypass ...
> 
> INSTRUMENTATION
> ---------------
> 
> The following instrumentation was applied to capture the page table state at
> the moment of failure:
> 
>   In mm/vmalloc.c::vmalloc_to_page()
> 
>     ptep = pte_offset_kernel(pmd, addr);
>     pte = ptep_get(ptep);
>     if (pte_present(pte))
>         page = pte_page(pte);
>     else
>         pr_err("vmalloc_to_page: pte_not_present for addr=%lx "
>                "PGD=%lx P4D=%lx PUD=%lx PMD=%lx PTE=%lx\n",
>                addr, pgd_val(*pgd), p4d_val(*p4d), pud_val(*pud),
>                pmd_val(*pmd), pte_val(pte));
> 
>   In arch/x86/kernel/alternative.c::__text_poke()
> 
>     /* BUG 1: pages[0] NULL */
>     if (!pages[0] || ...) {
>         pr_err("%s: vmalloc_to_page failed for addr=%pK pages[0]=%pK pages[1]=%pK cross=%d\n", ...);
>         BUG();
>     }
> 
>     ...
> 
>     /* BUG 2: memcmp mismatch */
>     if (memcmp(addr, src, len)) {
>         struct page *page_now = vmalloc_to_page(addr);
>         pr_err("%s: memcmp failed at addr=%pK len=%zu\n", __func__, addr, len);
>         pr_err("%s: expected (src): %*ph\n", __func__, (int)len, src);
>         pr_err("%s: found    (dst): %*ph\n", __func__, (int)len, (u8 *)addr);
>         pr_err("%s: pfn at poke time (vmalloc_to_page): %lx\n", __func__, page_to_pfn(pages[0]));
>         pr_err("%s: pfn at readback time (vmalloc_to_page): %lx\n", __func__, page_to_pfn(page_now));
>         text_poke_dump_pagetable((unsigned long)addr); /* reads CR3 */
>         BUG();
>     }
> 
> Signature 1 — vmalloc_to_page() returned NULL:
> 
>   vmalloc_to_page: pte_not_present for addr=ffffffffc0697979 PGD=28242067 P4D=28243067 PUD=28245067 PMD=3be001a1 PTE=0
>   SMP alternatives: __text_poke: vmalloc_to_page failed for addr=ffffffffc0697979 pages[0]=0000000000000000 pages[1]=0000000000000000 cross=0
> 
>   PMD was not a leaf, and the code reached a point to check pte_present() and
>   finds the PTE to be not present. But in the dump in else case, pmd_val(*pmd)
>   shows that it is a PMD leaf (PSE bit set).
> 
> Signature 2 — vmalloc_to_page() returned a wrong page:
> 
>   SMP alternatives: __text_poke: memcmp failed at addr=ffffffffc06fc4bd len=1
>   SMP alternatives: __text_poke: expected (src): cc
>   SMP alternatives: __text_poke: found    (dst): e8
>   SMP alternatives: __text_poke: pfn at poke time (vmalloc_to_page): 3884a
>   SMP alternatives: __text_poke: pfn at readback time (vmalloc_to_page): 52fc
>   SMP alternatives: __text_poke: page table dump for addr:
>     PGD 1ba42067  P4D 1ba43067  PUD 1ba45067  PMD 52001a1
> 
>   vmalloc_to_page() returned pfn=0x3884a when pages[0] was queried. The write
>   of 0xcc landed there. When vmalloc_to_page() was called again during the
>   memcmp readback in the instrumentation code, the vmap mapping resolved through
>   PMD=52001a1 to a different pfn=0x52fc, which contains 0xe8 (existing
>   instruction bytes). This is silent memory corruption — 0xcc was written to
>   the wrong physical page (pfn=0x3884a).
> 
> BISECTION
> ---------
> 
> The following experiments all ran 200 iterations of 512 concurrent guest boots
> with zero crashes.
> 
>   1. Remove "select ARCH_HAS_EXECMEM_ROX" from arch/x86/Kconfig
> 
>   2. Boot with "nohugevmalloc"
> 
>   3. Remove VM_ALLOW_HUGE_VMAP from vm_flags in execmem_cache_populate()
> 
>        - unsigned long vm_flags = VM_ALLOW_HUGE_VMAP;
>        + unsigned long vm_flags = 0;
> 
>   4. Remove CPA_COLLAPSE from set_memory_rox()
> 
>        return change_page_attr_set_clr(&addr, numpages, __pgprot(0), clr, 0,
>   -                                    CPA_COLLAPSE, NULL);
>   +                                    0, NULL);
> 
>      Without CPA_COLLAPSE, set_memory_rox() changes 4K PTE permissions
>      in-place and the PMD stays permanently as a PTE-page pointer after
>      the first split — no re-collapse, no future race window. This
>      confirms that CPA_COLLAPSE is a necessary part of the race sequence.
> 
>   5. Hold pgd_lock around vmalloc_to_page() in __text_poke()
> 
>          if (!core_kernel_text((unsigned long)addr)) {
>      +           spin_lock(&pgd_lock);
>                  pages[0] = vmalloc_to_page(addr);
>                  if (cross_page_boundary)
>                          pages[1] = vmalloc_to_page(addr + PAGE_SIZE);
>      +           spin_unlock(&pgd_lock);
>          } else {
> 
>      __split_large_page() holds pgd_lock while installing the new PMD
>      and populating all 512 4K PTEs. Holding pgd_lock around
>      vmalloc_to_page() prevents CPA from modifying the PMD concurrently
>      with the page table walk. This confirms the race is precisely
>      between vmalloc_to_page() reading the PMD/PTE and
>      __split_large_page() modifying it under pgd_lock.
> 
>      Note: this is a diagnostic experiment, not a production fix.
> 
> The experiments point to a race between vmalloc_to_page() in
> __text_poke() and __split_large_page() modifying the shared PMD under
> pgd_lock. __split_large_page() holds pgd_lock while modifying the
> PMD; vmalloc_to_page() holds no lock and can observe the PMD in an
> intermediate state.
> 
> What would be the correct fix for this issue?
> 
> Happy to test any proposed fix or run further experiments.

https://lore.kernel.org/linux-mm/anCK3eWFMwZqq5ka@pedro-suse/

-- 
Pedro
