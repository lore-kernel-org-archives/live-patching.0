Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E31A343D8A
	for <live-patching@vger.kernel.org>; Mon,  8 Jun 2026 10:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780913354; cv=none; b=hrntKb/U1HhwCJI6P0f0JuQqbIuWmbHADgHKLC1OPlsoCp1BvHtqs6StXNUZyIAq2X337xVrlqgAbDg1MxknCSTPVyLcyV7xG9oOp76d+QqVTYjKT3rP2B8c6pOXrAr2tCi2th/orsH7iSXxIQ8hp7jKo32/hlGdTuqjIvUKSHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780913354; c=relaxed/simple;
	bh=jh3gqHk1HNBvLAhELs2EctotIEZwksYr5TrkobDCakM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lr4vSMXXiRNe8ooxqJgADvDciovJEJB+jMsPdh3ei8LJwXhdX7P5N0eNhZtvTWukewOzxfrwvkcalAKSyEco4Hbz5nP96Uusc7ObTR6ZZXIwGOJ/NrZdudB3MvSg9FoLF3Zy/x64+qqlTRpvGIB02yAFT8dxcL+i8an3dJ59JOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ek9qG2w6; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ek9qG2w6"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780913340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AM0qgBKFGYsFBxyy5qkcaWxD4QqYzP5wt4OhR2froyA=;
	b=ek9qG2w6ER/i4WtvoscCoszUq1Ims10QtriibwdVPyGmsMU8uLBlw5lPjom/Dru8V1CSOA
	zhRjga9tO6uPfngAco0gR2iA7pXrW7MUGIRerAE9lJLT530aTPTInZyBEoiYrD6ephKMTE
	P0av98l+QKoYfFqgLiFbXbwGYOMFSuM=
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
Subject: [PATCH v2 0/8] LoongArch: Add livepatch build (KLP) support
Date: Mon,  8 Jun 2026 18:08:44 +0800
Message-Id: <20260608100852.325413-1-dongtai.guo@linux.dev>
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
below) and extends it with the LoongArch-specific objtool and build
pieces, plus a few LoongArch toolchain/relocation fixes required to make
livepatch modules load and run correctly.

Overview (the feature is wired up last so the series stays bisectable:
objtool's KLP arch hooks are all in place before ARCH_HAS_KLP is turned
on):

 - Patches 1 and 6 add the objtool hooks LoongArch needs:
   arch_adjusted_addend() and arch_jump_opcode_bytes() (the latter makes
   klp checksums for jump/call instructions position-independent,
   mirroring x86/arm64).
 - Patch 2 marks the special sections so objtool can split them into
   per-entry symbols: SHF_MERGE entry sizes for the read-only
   .altinstructions/__ex_table, and ANNOTATE_DATA_SPECIAL for the
   writable __bug_table/__jump_table.
 - Patches 3-4 fix kernel panics seen when loading livepatch modules,
   caused by LoongArch code-generation/relocation assumptions:
     * disable -mdirect-extern-access for klp builds (the module loader
       relies on GOT entries for external symbol references),
     * build with -fPIC so same-compilation-unit symbol references stay
       GOT-indirect and can be relocated into the livepatch module
       (-fPIE is not enough: it emits direct, non-GOT references).
 - Patch 5 fixes EFI linking when building with -fdata-sections.
 - Patch 7 adds KLP_SYSCALL_DEFINEx() support for LoongArch.
 - Patch 8 wires up LoongArch klp-build (selects HAVE_KLP_BUILD and
   enables objtool's KLP support).

Testing:
 - objtool builds cleanly for LoongArch.
 - Livepatch modules were generated and loaded on a LoongArch machine;
   the panics addressed by patches 3-4 no longer reproduce.

Changes since v1 [2]:
 - Mark the writable special sections (__bug_table, __jump_table) with
   ANNOTATE_DATA_SPECIAL instead of SHF_MERGE+entsize, which is invalid
   for writable sections and rejected by Clang; SHF_MERGE is kept only
   for the read-only .altinstructions/__ex_table.  Also dropped a
   redundant asm-offsets.h include in head.S.  (WangYuli)
 - Rewrote the -fPIC commit message: the root cause is GOT indirection,
   not "absolute addressing".  With CONFIG_RELOCATABLE=y the kernel is
   already built -fPIE, yet -fPIE still emits direct, non-GOT references
   for same-compilation-unit symbols, so -fPIC is required.  (Xi Ruoyao)
 - Set the LoongArch CFLAGS in build_kernel(), where the variables are
   actually used; in v1 they were in clean_kernel() and had no effect.
   (WangYuli)
 - Gated the klp-build changes on CONFIG_RELOCATABLE=y and
   CONFIG_AS_HAS_EXPLICIT_RELOCS=y, and only override KBUILD_CFLAGS_KERNEL
   when needed, so other arches/configs are unaffected.
 - Reordered the series so the enabling patch ("Add livepatch build (KLP)
   support") comes last, keeping every commit buildable/bisectable.
   Patch numbers therefore differ from v1.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git/log/?h=klp-build-arm64
[2] https://lore.kernel.org/all/20260604065317.219777-1-dongtai.guo@linux.dev/

George Guo (8):
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

 arch/loongarch/Kconfig                       |  1 +
 arch/loongarch/include/asm/alternative-asm.h |  5 ++-
 arch/loongarch/include/asm/alternative.h     |  6 ++-
 arch/loongarch/include/asm/asm-extable.h     | 10 ++++-
 arch/loongarch/include/asm/bug.h             |  1 +
 arch/loongarch/include/asm/jump_label.h      |  2 +
 arch/loongarch/kernel/asm-offsets.c          | 20 +++++++++
 arch/loongarch/kernel/vmlinux.lds.S          |  2 +-
 include/linux/livepatch_helpers.h            | 22 ++++++++++
 scripts/livepatch/klp-build                  | 36 ++++++++++++++-
 tools/objtool/Makefile                       |  3 +-
 tools/objtool/arch/loongarch/decode.c        | 46 ++++++++++++++++++++
 12 files changed, 145 insertions(+), 9 deletions(-)


base-commit: 85afaba140a4b9f20fe8c8a64b24fc85f022d981
-- 
2.25.1

