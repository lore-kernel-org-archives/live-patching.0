Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54893C10BA
	for <live-patching@vger.kernel.org>; Tue,  7 Jul 2026 07:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783408906; cv=none; b=P6Ffnvtw1sbl22XFnHzKITnYjwdjELwarXCI6hKBw6FKntaGHFluZyzwFPOBWGMGx4Ko6tdaFAIrU7YZwvV1TJxj1JTeqRX1f8Q5WKxslt5WXZbyUGZaSPnYK8hZD5SQGif3hIQClfDKpqlDj97tHRfPxFTaf6T+FFKCemhADuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783408906; c=relaxed/simple;
	bh=MeQcpc2tDQ5s9leAsYyxZOMA2rT3vEy3DB+XblR7N2w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LAf0EEdL1wT2Hny1EvRvZe98+uo26pgrm8H09GJUrj9p06+cTqDS0fWspBE1X7ePu0TPX+4pL5oXWD4b18t788C1bgnVfm/7I3F3gvzT7bYbhD8jon+8kStBocdzaAaLIxfgaP+5T0aoNwIXp2t5rJyZaUfsPvTQtXAYbZ4agS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qUnewggN; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qUnewggN"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783408884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Bmv7zXhBcj7/STN4MChdYvHH/8l8XAPSnk/Tz1Mkcho=;
	b=qUnewggN+jE8Zis1Z074O4hdxEkeuSABbiV/SKUs1UKRlG2PitGdjzLOLt87yKuoxVe/Nc
	Wtzl0CjBH8xM0KsERViMsgsAqW8uS9XgeOv0OwRKfCOhruQX4LUx4rXATEb5Z66XYCU0so
	fFvAKmzS8/RqZfV3+ynfHR6umHkBFi4=
From: George Guo <dongtai.guo@linux.dev>
To: chenhuacai@kernel.org,
	jpoimboe@kernel.org,
	peterz@infradead.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com
Cc: kernel@xen0n.name,
	joe.lawrence@redhat.com,
	rostedt@goodmis.org,
	ardb@kernel.org,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	yangtiezhu@loongson.cn,
	jiaxun.yang@flygoat.com,
	liukexin@kylinos.cn,
	guodongtai@kylinos.cn,
	xry111@xry111.site,
	wangyuli@aosc.io,
	loongarch@lists.linux.dev,
	live-patching@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 00/12] LoongArch: Add livepatch build (KLP) support
Date: Tue,  7 Jul 2026 15:20:19 +0800
Message-Id: <20260707072031.231066-1-dongtai.guo@linux.dev>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This series adds LoongArch support for the klp-build livepatch tooling,
enabling automated livepatch module generation using objtool on
LoongArch.

It is based on Josh Poimboeuf's klp-build series [1] (see base-commit
below, unchanged from v1/v2) and extends it with the LoongArch-specific
objtool and build pieces, plus toolchain/relocation fixes required to
make livepatch modules load, generate, and run correctly under both GCC
and Clang.

Overview:

 - Patches 1-8 are unchanged from v2 [3]: the LoongArch objtool hooks,
   special-section marking, the -fPIC/-mdirect-extern-access fixes,
   EFI linking, KLP_SYSCALL_DEFINEx() support, and finally wiring up
   LoongArch klp-build (kept last so the series stays bisectable).
 - Patches 9-12 are new in v3, fixing issues Joe Lawrence found across
   two rounds of review by actually running the full klp-build flow
   (see Changes since v2 below for details).

All new patches (9-12) fix bugs in objtool/klp-diff.c and the LoongArch
Kconfig; none of them touch other architectures.

Testing:

GCC on LoongArch hardware: livepatch modules generated, loaded, and
exercised (unchanged from v2).

Clang 21.1.8 on LoongArch hardware, reproduced end to end with Joe's
exact test case (test-joe.patch below), since it happens to exercise
patches 10-12 together: netif_rx_internal() has __ex_table entries,
a __bug_table entry, and three __jump_table static keys, one of which
(a tracepoint's key) is unexported and not defined in the same
translation unit -- exactly the case patch 12 fixes.

  $ cat test-joe.patch
  diff --git a/net/core/dev.c b/net/core/dev.c
  index 06c195906231..14fd3d5f351a 100644
  --- a/net/core/dev.c
  +++ b/net/core/dev.c
  @@ -5717,6 +5717,7 @@ static int netif_rx_internal(struct sk_buff *skb)
                  unsigned int qtail;

                  ret = enqueue_to_backlog(skb, smp_processor_id(), &qtail);
  +               pr_info("test");
          }
          return ret;
   }

  $ LLVM=/path/to/clang-21/bin/ ./scripts/livepatch/klp-build -T test-joe.patch
  ...
  $ ls livepatch-test-joe.ko

klp-build completes cleanly: no "duplicate reloc" (patch 12), no
"Cannot find symbol for section" (patch 9), and the __ex_table/
__jump_table entries for netif_rx_internal are present in the output
module (patches 10-11).  The module was then loaded into a VM running
a matching Clang-built kernel:

  # insmod livepatch-test-joe.ko
  [  105.584252] livepatch: enabling patch 'livepatch_test_joe'
  [  105.586141] livepatch: 'livepatch_test_joe': starting patching transition
  [  106.824310] livepatch: 'livepatch_test_joe': patching complete
  [  120.036530] test

  # cat /sys/kernel/livepatch/livepatch_test_joe/{enabled,transition}
  1
  0

Toggling the netif_rx tracepoint exercises the jump-table relocation
patch 12 folds for the unexported __tracepoint_netif_rx key, and lets
us cross-check the patch's own pr_info() against independent evidence
that the static branch actually flipped:

  # echo 1 > /sys/kernel/debug/tracing/events/net/netif_rx/enable
  # ping -c2 127.0.0.1
  # cat /sys/kernel/debug/tracing/trace | tail -4
              ping-1267    [001] b....   472.753651: netif_rx: dev=lo skbaddr=... len=84
              ping-1267    [001] b.s2.   472.753671: netif_rx: dev=lo skbaddr=... len=84
              ping-1267    [001] b....   473.762993: netif_rx: dev=lo skbaddr=... len=84
              ping-1267    [001] b.s2.   473.763096: netif_rx: dev=lo skbaddr=... len=84
  # dmesg | tail -4
  [  472.753653] test
  [  472.753671] test
  [  473.762994] test
  [  473.763096] test

Each traced packet has a matching "test" line at the same timestamp
(microsecond-aligned), confirming the tracepoint's static-key
relocation and the patch's own code path are both live at once.
Disabling and unloading works cleanly:

  # echo 0 > /sys/kernel/livepatch/livepatch_test_joe/enabled
  [  557.922932] livepatch: 'livepatch_test_joe': starting unpatching transition
  [  558.905248] livepatch: 'livepatch_test_joe': unpatching complete
  # rmmod livepatch_test_joe

Changes since v2 [3]:
 - Patches 1-8 are unchanged.
 - New patch 9: select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY.
   arch/loongarch/Makefile already builds with
   -fpatchable-function-entry=2, but nothing selected this, so kbuild
   ran a pointless recordmcount pass on every object.  Harmless under
   GCC (GAS always emits a section symbol for recordmcount to anchor
   on), but it fails under Clang with -ffunction-sections (as klp-build
   uses) for any __weak function that ends up alone in its section,
   e.g. sched_clock.  (Joe Lawrence)
 - New patch 10: convert local-label references in special sections.
   GCC/GAS on LoongArch reference __ex_table/__bug_table/__jump_table
   entries via a local text label instead of the usual "section symbol
   + offset" that objtool's klp-diff.c assumes; the label is never
   cloned into the livepatch module, so such entries were silently
   dropped from GCC-built modules with no error at build or load time.
   (Joe Lawrence)
 - New patch 11: fix ANNOTATE_DATA_SPECIAL parsing for the same local
   label references.  create_fake_symbols() computed each annotated
   entry's offset from the relocation's addend alone, which is only
   correct for the section-symbol form; with local labels, every entry
   in a special section got offset 0, producing a single fake symbol
   that covered (and pulled into the output module) the section's
   entire contents instead of just the patched function's entries.
   Found while verifying patch 10 with a real special-section entry.
 - New patch 12: fold LoongArch's paired ADD/SUB relocations into a
   single PC-relative one.  The "key - ." field of a __jump_table entry
   can come out as two relocations at the same offset (R_LARCH_ADD64 +
   R_LARCH_SUB64) when Clang's integrated assembler encounters a key
   that isn't defined in the same translation unit (e.g. a tracepoint's
   static key); objtool only allows one relocation per offset, so
   cloning such an entry failed with "duplicate reloc".  (Joe Lawrence)

[1] https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git/log/?h=klp-build-arm64
[2] https://lore.kernel.org/all/20260604065317.219777-1-dongtai.guo@linux.dev/
[3] https://lore.kernel.org/all/20260608100852.325413-1-dongtai.guo@linux.dev/

George Guo (12):
  objtool/LoongArch: Add arch_adjusted_addend() for KLP support
  LoongArch: Mark special sections for KLP support
  livepatch/klp-build: disable direct-extern-access for LoongArch to fix
    kernel panic
  livepatch/klp-build: build LoongArch with -fPIC to keep GOT-indirect
    symbol references
  LoongArch: Fix EFI linking with -fdata-sections
  objtool/klp: Add LoongArch jump opcode bytes support
  klp-build: Add LoongArch syscall patching macro
  LoongArch: Add livepatch build (KLP) support
  LoongArch: Select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY
  objtool/klp: Convert local label references in special sections
  objtool/klp: Fix ANNOTATE_DATA_SPECIAL parsing for local label
    references
  objtool/klp: Fold LoongArch paired ADD/SUB relocations into PCREL

 arch/loongarch/Kconfig                        |   2 +
 arch/loongarch/include/asm/alternative-asm.h  |   5 +-
 arch/loongarch/include/asm/alternative.h      |   6 +-
 arch/loongarch/include/asm/asm-extable.h      |  10 +-
 arch/loongarch/include/asm/bug.h              |   1 +
 arch/loongarch/include/asm/jump_label.h       |   2 +
 arch/loongarch/kernel/asm-offsets.c           |  20 ++++
 arch/loongarch/kernel/vmlinux.lds.S           |   2 +-
 include/linux/livepatch_helpers.h             |  22 ++++
 scripts/livepatch/klp-build                   |  36 +++++-
 tools/objtool/Makefile                        |   3 +-
 tools/objtool/arch/loongarch/decode.c         | 108 ++++++++++++++++++
 .../objtool/arch/loongarch/include/arch/elf.h |  18 +++
 tools/objtool/klp-diff.c                      |  57 ++++++++-
 14 files changed, 280 insertions(+), 12 deletions(-)


base-commit: 85afaba140a4b9f20fe8c8a64b24fc85f022d981
-- 
2.25.1

