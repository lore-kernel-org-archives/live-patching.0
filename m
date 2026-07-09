Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0D83F39DF
	for <live-patching@vger.kernel.org>; Thu,  9 Jul 2026 09:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783590174; cv=none; b=nu7aIvhNFNqcRPYQJi6wVXdDIIAQ/H9ltbm0VD+M2rd45jazVNQTAnxsHPBpPtPpRfcMi7NMEJ+LDd/+YrM6ytISBAmWtOaqPgJdjKK+3Ke94KBO/s6Gz/yBuvcO7R1EMB+Nw58MW0ArXauviLJOMWC3JCAX3hBp4sHqEfM6vqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783590174; c=relaxed/simple;
	bh=qT5BDaXPn1ONcLA/bARRkjnpTvkOFKvXSWfoM5gw4cI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pnILttXnZeb+FEDNMP4NbH8pfwAuJ0OS8zAnPK3LGOmU/e6pHGOurvSoQ443DPbmaLsd9v6ZPTambwOIgvKL3I4eWH88eb4HgL8iSZ8wsa8A+mRedLJLf8ykYRcE9A/lVjy4BD5Q+By90Wls4wxWLxqZSHHI+r0xKh6ucVYJO4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U4vhMsuL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U4vhMsuL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A91C1F01558
	for <live-patching@vger.kernel.org>; Thu,  9 Jul 2026 09:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783590173;
	bh=ayx7l7YqCvr1Xl2Dcnlb0jt6sFQfGazJlldsyxYrWG0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=U4vhMsuLCq0VJ6p4+Pxf1pUedzt+RbkNX+LlvgsHhdcA+IUa59Ci6kFR8k6K7ZNY0
	 4gL+5zifsZck7/4nrjnlBkjBAyxHBQ+1t9aMOzT8LD4CzfEl2BWRruovVnzptDS8rH
	 XNW10uL10Reoa/c19pxCpofDGHXdl1hIrXXOsHzgrgj4pwUriDicFAm1Ms8VMPU4fK
	 uI83C+fHdXDVEJnAHoKieQAbC6Dwb7CKWUL8GUMh8HL4jRZdRJS/rLYDLjteBAcPiY
	 sfD3D2hDXONoq6yKI3NP5ht5ZOVvLVznefSUcVK8K8f0y8DiCmaMcqvJpSGENV7BwZ
	 TB1WmCJ967k5g==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-698bf7a1a2dso2249834a12.0
        for <live-patching@vger.kernel.org>; Thu, 09 Jul 2026 02:42:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqCI2grw4D4qe4h1kJZD9HKt/FrSAMCA6R3xrUUrXbXAZ8uol9MggbKqSG/GpRar+lCqYX886AgM4Phvi2q@vger.kernel.org
X-Gm-Message-State: AOJu0YzJyX8FOA/KUosmQwSuQtnI/3LuNNQRf4rA/EbIrmLGyk5JLYFX
	d2xiLotn0xCu0r70zO+gg3PQUL035nerBH4Npa66m2ZXm4nbPPzXmpt0bUcMmVeC8gWSi6jCYfn
	sYdLr7MpLpekRmBf0xq7TQXEUmoFVBCw=
X-Received: by 2002:a05:6402:4348:b0:698:aa88:56d1 with SMTP id
 4fb4d7f45d1cf-69ab44a1fcfmr2562569a12.25.1783590171440; Thu, 09 Jul 2026
 02:42:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707072031.231066-1-dongtai.guo@linux.dev>
In-Reply-To: <20260707072031.231066-1-dongtai.guo@linux.dev>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 9 Jul 2026 17:43:17 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4cr9xBkM-SEUHXm9t0yQ=r3B9pkNdmUDftP00hvVsZrQ@mail.gmail.com>
X-Gm-Features: AUfX_mzzGMlpt_hQFMS3WXIM7ZWh8ao7409y42aJ59WbwsixnrrcDfoeDPCPPHY
Message-ID: <CAAhV-H4cr9xBkM-SEUHXm9t0yQ=r3B9pkNdmUDftP00hvVsZrQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/12] LoongArch: Add livepatch build (KLP) support
To: George Guo <dongtai.guo@linux.dev>
Cc: jpoimboe@kernel.org, peterz@infradead.org, jikos@kernel.org, 
	mbenes@suse.cz, pmladek@suse.com, kernel@xen0n.name, joe.lawrence@redhat.com, 
	rostedt@goodmis.org, ardb@kernel.org, nathan@kernel.org, 
	nick.desaulniers+lkml@gmail.com, yangtiezhu@loongson.cn, 
	jiaxun.yang@flygoat.com, liukexin@kylinos.cn, guodongtai@kylinos.cn, 
	xry111@xry111.site, wangyuli@aosc.io, loongarch@lists.linux.dev, 
	live-patching@vger.kernel.org, llvm@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,George,

On Tue, Jul 7, 2026 at 3:21=E2=80=AFPM George Guo <dongtai.guo@linux.dev> w=
rote:
>
> This series adds LoongArch support for the klp-build livepatch tooling,
> enabling automated livepatch module generation using objtool on
> LoongArch.
>
> It is based on Josh Poimboeuf's klp-build series [1] (see base-commit
> below, unchanged from v1/v2) and extends it with the LoongArch-specific
> objtool and build pieces, plus toolchain/relocation fixes required to
> make livepatch modules load, generate, and run correctly under both GCC
> and Clang.
1. Wang Yuli released his version first; re-releasing it without any
prior communication is simply rude.
https://lore.kernel.org/loongarch/20251203091039.125259-1-wangyuli@aosc.io/

2. Perhaps you were genuinely unaware about his earlier patches, but
Wang Yuli had already alerted you in your v1. At that point, you had
two options: a) abandon your own patches and let Wang Yuli continue
his development, or b) thank Wang Yuli for the reminder and
assistance, then seek to collaborate on development. However, you did
neither; instead, you released new versions on your own again and
again. This is highly unethical.

3. You might argue that Wang Yuli=E2=80=99s version is incomplete, but is
yours complete? Since you=E2=80=99re releasing v3, it=E2=80=99s clear that =
 your v1
and v2 were also incomplete. If you can simply take over someone
else=E2=80=99s project just because their version is incomplete, does that
mean Wang Yuli can now throw yours in the trash when he releases his
v2?


Huacai

>
> Overview:
>
>  - Patches 1-8 are unchanged from v2 [3]: the LoongArch objtool hooks,
>    special-section marking, the -fPIC/-mdirect-extern-access fixes,
>    EFI linking, KLP_SYSCALL_DEFINEx() support, and finally wiring up
>    LoongArch klp-build (kept last so the series stays bisectable).
>  - Patches 9-12 are new in v3, fixing issues Joe Lawrence found across
>    two rounds of review by actually running the full klp-build flow
>    (see Changes since v2 below for details).
>
> All new patches (9-12) fix bugs in objtool/klp-diff.c and the LoongArch
> Kconfig; none of them touch other architectures.
>
> Testing:
>
> GCC on LoongArch hardware: livepatch modules generated, loaded, and
> exercised (unchanged from v2).
>
> Clang 21.1.8 on LoongArch hardware, reproduced end to end with Joe's
> exact test case (test-joe.patch below), since it happens to exercise
> patches 10-12 together: netif_rx_internal() has __ex_table entries,
> a __bug_table entry, and three __jump_table static keys, one of which
> (a tracepoint's key) is unexported and not defined in the same
> translation unit -- exactly the case patch 12 fixes.
>
>   $ cat test-joe.patch
>   diff --git a/net/core/dev.c b/net/core/dev.c
>   index 06c195906231..14fd3d5f351a 100644
>   --- a/net/core/dev.c
>   +++ b/net/core/dev.c
>   @@ -5717,6 +5717,7 @@ static int netif_rx_internal(struct sk_buff *skb)
>                   unsigned int qtail;
>
>                   ret =3D enqueue_to_backlog(skb, smp_processor_id(), &qt=
ail);
>   +               pr_info("test");
>           }
>           return ret;
>    }
>
>   $ LLVM=3D/path/to/clang-21/bin/ ./scripts/livepatch/klp-build -T test-j=
oe.patch
>   ...
>   $ ls livepatch-test-joe.ko
>
> klp-build completes cleanly: no "duplicate reloc" (patch 12), no
> "Cannot find symbol for section" (patch 9), and the __ex_table/
> __jump_table entries for netif_rx_internal are present in the output
> module (patches 10-11).  The module was then loaded into a VM running
> a matching Clang-built kernel:
>
>   # insmod livepatch-test-joe.ko
>   [  105.584252] livepatch: enabling patch 'livepatch_test_joe'
>   [  105.586141] livepatch: 'livepatch_test_joe': starting patching trans=
ition
>   [  106.824310] livepatch: 'livepatch_test_joe': patching complete
>   [  120.036530] test
>
>   # cat /sys/kernel/livepatch/livepatch_test_joe/{enabled,transition}
>   1
>   0
>
> Toggling the netif_rx tracepoint exercises the jump-table relocation
> patch 12 folds for the unexported __tracepoint_netif_rx key, and lets
> us cross-check the patch's own pr_info() against independent evidence
> that the static branch actually flipped:
>
>   # echo 1 > /sys/kernel/debug/tracing/events/net/netif_rx/enable
>   # ping -c2 127.0.0.1
>   # cat /sys/kernel/debug/tracing/trace | tail -4
>               ping-1267    [001] b....   472.753651: netif_rx: dev=3Dlo s=
kbaddr=3D... len=3D84
>               ping-1267    [001] b.s2.   472.753671: netif_rx: dev=3Dlo s=
kbaddr=3D... len=3D84
>               ping-1267    [001] b....   473.762993: netif_rx: dev=3Dlo s=
kbaddr=3D... len=3D84
>               ping-1267    [001] b.s2.   473.763096: netif_rx: dev=3Dlo s=
kbaddr=3D... len=3D84
>   # dmesg | tail -4
>   [  472.753653] test
>   [  472.753671] test
>   [  473.762994] test
>   [  473.763096] test
>
> Each traced packet has a matching "test" line at the same timestamp
> (microsecond-aligned), confirming the tracepoint's static-key
> relocation and the patch's own code path are both live at once.
> Disabling and unloading works cleanly:
>
>   # echo 0 > /sys/kernel/livepatch/livepatch_test_joe/enabled
>   [  557.922932] livepatch: 'livepatch_test_joe': starting unpatching tra=
nsition
>   [  558.905248] livepatch: 'livepatch_test_joe': unpatching complete
>   # rmmod livepatch_test_joe
>
> Changes since v2 [3]:
>  - Patches 1-8 are unchanged.
>  - New patch 9: select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY.
>    arch/loongarch/Makefile already builds with
>    -fpatchable-function-entry=3D2, but nothing selected this, so kbuild
>    ran a pointless recordmcount pass on every object.  Harmless under
>    GCC (GAS always emits a section symbol for recordmcount to anchor
>    on), but it fails under Clang with -ffunction-sections (as klp-build
>    uses) for any __weak function that ends up alone in its section,
>    e.g. sched_clock.  (Joe Lawrence)
>  - New patch 10: convert local-label references in special sections.
>    GCC/GAS on LoongArch reference __ex_table/__bug_table/__jump_table
>    entries via a local text label instead of the usual "section symbol
>    + offset" that objtool's klp-diff.c assumes; the label is never
>    cloned into the livepatch module, so such entries were silently
>    dropped from GCC-built modules with no error at build or load time.
>    (Joe Lawrence)
>  - New patch 11: fix ANNOTATE_DATA_SPECIAL parsing for the same local
>    label references.  create_fake_symbols() computed each annotated
>    entry's offset from the relocation's addend alone, which is only
>    correct for the section-symbol form; with local labels, every entry
>    in a special section got offset 0, producing a single fake symbol
>    that covered (and pulled into the output module) the section's
>    entire contents instead of just the patched function's entries.
>    Found while verifying patch 10 with a real special-section entry.
>  - New patch 12: fold LoongArch's paired ADD/SUB relocations into a
>    single PC-relative one.  The "key - ." field of a __jump_table entry
>    can come out as two relocations at the same offset (R_LARCH_ADD64 +
>    R_LARCH_SUB64) when Clang's integrated assembler encounters a key
>    that isn't defined in the same translation unit (e.g. a tracepoint's
>    static key); objtool only allows one relocation per offset, so
>    cloning such an entry failed with "duplicate reloc".  (Joe Lawrence)
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git/lo=
g/?h=3Dklp-build-arm64
> [2] https://lore.kernel.org/all/20260604065317.219777-1-dongtai.guo@linux=
.dev/
> [3] https://lore.kernel.org/all/20260608100852.325413-1-dongtai.guo@linux=
.dev/
>
> George Guo (12):
>   objtool/LoongArch: Add arch_adjusted_addend() for KLP support
>   LoongArch: Mark special sections for KLP support
>   livepatch/klp-build: disable direct-extern-access for LoongArch to fix
>     kernel panic
>   livepatch/klp-build: build LoongArch with -fPIC to keep GOT-indirect
>     symbol references
>   LoongArch: Fix EFI linking with -fdata-sections
>   objtool/klp: Add LoongArch jump opcode bytes support
>   klp-build: Add LoongArch syscall patching macro
>   LoongArch: Add livepatch build (KLP) support
>   LoongArch: Select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY
>   objtool/klp: Convert local label references in special sections
>   objtool/klp: Fix ANNOTATE_DATA_SPECIAL parsing for local label
>     references
>   objtool/klp: Fold LoongArch paired ADD/SUB relocations into PCREL
>
>  arch/loongarch/Kconfig                        |   2 +
>  arch/loongarch/include/asm/alternative-asm.h  |   5 +-
>  arch/loongarch/include/asm/alternative.h      |   6 +-
>  arch/loongarch/include/asm/asm-extable.h      |  10 +-
>  arch/loongarch/include/asm/bug.h              |   1 +
>  arch/loongarch/include/asm/jump_label.h       |   2 +
>  arch/loongarch/kernel/asm-offsets.c           |  20 ++++
>  arch/loongarch/kernel/vmlinux.lds.S           |   2 +-
>  include/linux/livepatch_helpers.h             |  22 ++++
>  scripts/livepatch/klp-build                   |  36 +++++-
>  tools/objtool/Makefile                        |   3 +-
>  tools/objtool/arch/loongarch/decode.c         | 108 ++++++++++++++++++
>  .../objtool/arch/loongarch/include/arch/elf.h |  18 +++
>  tools/objtool/klp-diff.c                      |  57 ++++++++-
>  14 files changed, 280 insertions(+), 12 deletions(-)
>
>
> base-commit: 85afaba140a4b9f20fe8c8a64b24fc85f022d981
> --
> 2.25.1
>
>
