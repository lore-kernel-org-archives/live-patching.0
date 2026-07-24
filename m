Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3333427F9C
	for <live-patching@vger.kernel.org>; Fri, 24 Jul 2026 11:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784893342; cv=none; b=C+Evf4v+AT3sw2ybJ8hGYFtIKCjC+LyXYfmM/A3GTmpKUhTma5gKEmVFRGLuk31ygRz97Jt/H1jTHNWvfciMxdzSyhPNSdvUzHdmSSTrbKksZ6a3RbXw73ScsjpMuxdkW4z7rRokwwwW4LsRjjqkkBExfACdrP1LY08BVRxeRjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784893342; c=relaxed/simple;
	bh=8xbYzc5RMJCnBPzINN2P1qTGFHze4yuG4bEVvarM1V8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k/qJ9Xe5EllpN55RdEV4a5Yo5J+ryiEc15xBdubtWNlb0pZA+j15Nc4sai+suq4JJbs1mOZ4KMoCc0SGy5DYP9hUJSYEKMJQhXEycJh7dT/KZYuDZSGXY3uMJi+IQ6/h83piOjsnwanmPjowcNY0HjmDQFNZpFhnuzRLTMDVq6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=k7YZ6PKT; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="k7YZ6PKT"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784893315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Gp2KyrR+fgVqMkfE2bcxA4KStPUXzd9PQ0cHT+qbmjw=;
	b=k7YZ6PKTUXAyDvO308dgYipElkjMKomj09Wgg5M6K/rlhCHykTjjVFDF/wakEayf8STVMe
	lfhFOo6HF3HTGMAhcWt6Z0pu0D8a4vs20c3WD3VPn0XXgnH9dX1kVKDz5WBwTpLhRqFqn0
	fIICfwn4qKtUMciwpZVV1TzBJB68t/4=
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
	wangrui@loongson.cn,
	liukexin@kylinos.cn,
	guodongtai@kylinos.cn,
	xry111@xry111.site,
	wangyuli@aosc.io,
	loongarch@lists.linux.dev,
	live-patching@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 00/14] LoongArch: Add livepatch build (KLP) support
Date: Fri, 24 Jul 2026 19:41:13 +0800
Message-ID: <20260724114128.31451-1-dongtai.guo@linux.dev>
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
below, unchanged from v1-v3) and extends it with the LoongArch-specific
objtool and build pieces, plus the toolchain and relocation fixes
required to make livepatch modules load, generate, and run correctly
under both GCC and Clang.

Collaboration
=============

Patch 1 ("objtool/LoongArch: Add arch_adjusted_addend() for KLP support")
and patch 7 ("LoongArch: Add livepatch build (KLP) support") overlap with
WangYuli's earlier LoongArch KLP work [2]. Both now carry
Co-developed-by/Signed-off-by: WangYuli.

WangYuli, please check that the attribution is recorded correctly. If you
consider any other patch in this series to overlap your work, point it out
and I will add the tags in the final version.

Overview
========

 - Patches 1-8: the LoongArch objtool hooks, special-section marking
   (including the inline ALTERNATIVE() replacement), the combined
   -fPIC / -mno-direct-extern-access build fix, EFI linking, the syscall
   patching macro, and wiring up LoongArch klp-build.
 - Patches 9-14: objtool/klp-diff fixes found by running the full
   klp-build flow under GCC and Clang.

Testing
=======

The klp-build integration tests were run on LoongArch under both GCC and
Clang: cmdline-string, proc-version, data-new, gcc-static-local-var-6,
syscall, new-globals, new-function, and shadow-newpid. All of them now
generate a livepatch module, load it, and run.

new-function and shadow-newpid did not build under Clang before this
version; the new objtool/klp-diff patches fix the Clang-specific
failures the suite surfaced. Joe Lawrence's test case was also
reproduced end to end on a Clang-built kernel in a VM (patch load,
tracepoint toggle, clean unload).

Changes since v3 [3]
====================

 - Merged the two build-flag patches (-mno-direct-extern-access and
   -fPIC) into one. The combined patch is one complete thought: for
   LoongArch KLP builds, replace the arch's KBUILD_CFLAGS_KERNEL (dropping
   -fPIE and -mdirect-extern-access) and add -fPIC via KCFLAGS. (Joe
   Lawrence)
 - Moved the LoongArch config checks (CONFIG_RELOCATABLE,
   CONFIG_AS_HAS_EXPLICIT_RELOCS) into validate_config(). (Joe Lawrence)
 - Patch 4 (EFI): fixed the changelog wording and added the
   "/* from the EFI stub */" comment on the wildcard, matching arm64 and
   riscv. (Joe Lawrence)
 - Patch 6 (syscall macro): pad the line continuations with tabs. (Joe
   Lawrence)
 - New patch 12: enable inline ALTERNATIVE() cloning. Joe hit
   "can't find new instruction" livepatching a function that contains an
   ALTERNATIVE(). Mark the .subsection 1 replacement with
   ANNOTATE_DATA_SPECIAL (patch 2) and define ARCH_HAS_INLINE_ALTS for
   LoongArch objtool (patch 12), mirroring arm64. (Joe Lawrence)
 - New patch 13: keep the tablejump annotation table entries. klp-diff
   dropped the table-side word of each .discard.tablejump_annotate pair,
   which crashed objtool on the patch module.
 - New patch 14: rewrite PC-relative data references to GOT. File-local
   static data uses a direct pcalau12i/addi.d pair that cannot reach
   vmlinux from the far livepatch module; convert it to a GOT-indirect
   load when the klp relocation is created. This affects GCC and Clang.

On patch 11 (fold paired ADD/SUB relocations): Clang's integrated
assembler emits the ADD64/SUB64 pair for a "sym - ." whose symbol is
undefined in the current object, where GAS with -mthin-add-sub emits a
single R_LARCH_64_PCREL. Reported to LLVM as issue #210052 [4]. The fold
is kept regardless, since shipping Clang emits the pair.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git/log/?h=klp-build-arm64
[2] https://lore.kernel.org/loongarch/20251203091039.125259-1-wangyuli@aosc.io/
[3] https://lore.kernel.org/all/20260707072031.231066-1-dongtai.guo@linux.dev/
[4] https://github.com/llvm/llvm-project/issues/210052

George Guo (14):
  objtool/LoongArch: Add arch_adjusted_addend() for KLP support
  LoongArch: Mark special sections for KLP support
  livepatch/klp-build: use -fPIC and drop direct-extern-access on
    LoongArch
  LoongArch: Fix EFI linking with -fdata-sections
  objtool/klp: Add LoongArch jump opcode bytes support
  klp-build: Add LoongArch syscall patching macro
  LoongArch: Add livepatch build (KLP) support
  LoongArch: Select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY
  objtool/klp: Convert local label references
  objtool/klp: Fix ANNOTATE_DATA_SPECIAL parsing for local label
    references
  objtool/klp: Fold LoongArch paired ADD/SUB relocations into PCREL
  objtool/LoongArch: Enable inline alternative cloning for KLP
  objtool/klp: Keep LoongArch tablejump annotation table entries
  objtool/klp: Rewrite PC-relative data references to GOT on LoongArch

 arch/loongarch/Kconfig                        |   2 +
 arch/loongarch/include/asm/alternative-asm.h  |  10 +-
 arch/loongarch/include/asm/alternative.h      |  11 +-
 arch/loongarch/include/asm/asm-extable.h      |  10 +-
 arch/loongarch/include/asm/bug.h              |   1 +
 arch/loongarch/include/asm/jump_label.h       |   2 +
 arch/loongarch/kernel/asm-offsets.c           |  18 ++
 arch/loongarch/kernel/vmlinux.lds.S           |   2 +-
 include/linux/livepatch_helpers.h             |  22 ++
 scripts/livepatch/klp-build                   |  43 +++-
 tools/arch/loongarch/include/asm/inst.h       |  11 +
 tools/objtool/Makefile                        |   3 +-
 tools/objtool/arch/loongarch/decode.c         | 212 ++++++++++++++++++
 .../objtool/arch/loongarch/include/arch/elf.h |  35 +++
 tools/objtool/klp-diff.c                      | 105 ++++++++-
 15 files changed, 473 insertions(+), 14 deletions(-)


base-commit: 85afaba140a4b9f20fe8c8a64b24fc85f022d981
-- 
2.53.0

