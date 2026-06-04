Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9734138DD3
	for <live-patching@vger.kernel.org>; Thu,  4 Jun 2026 06:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780556060; cv=none; b=iaxagv19pLIsF6kplfv+JZVI/OT/KEKJoOEvpEPzGO5KOqsa2Kck7q4/jx36ZqX54axZm6GvxmkHNP/jb28omrcGtt7vOhGt3YW2+j6QHZMH+XUjs+FbtMP8gQd/ptugbfRCdXLe/BiuG1Ny7Ask9oqCH7lz9+Dh4DA5WM8Ye0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780556060; c=relaxed/simple;
	bh=6AHqcwYCF5L2+qu7IvYKRr2qbg2IgwWOMHT7y9nRCGk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eJunlABYoCXtNolp46KwykhM9XUUOcPkN7ySLp8zcBPTqNdY5Tk42+vBlHQyo/V4e+iDXhVRxcqnz0T+tcP/Mk+nGxU8YYmmxXn1MTktiOuhcZg032PvUM9yTgw9e6EjwXn6RQ77wt1lGfDrydudRf2EVvQoBrf7Pt7tjHSn+rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=q72bA5K8; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="q72bA5K8"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780556056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6BfvzU/D7GwIcA44ky0gQkL98xJWZVJ60mGNX9dH9YI=;
	b=q72bA5K8mnAcCXCUujYvH8Xpj4EmBHGxq1/memK/JbJw9irPO4Undui+DGIwYsbCRbO8DI
	/C8dCT9sx3sNGbLqcwB/E5bQ2LbBzhdMSXUr6SeZVPswO4NTENJgCePqcUCkW+bcpDs6cU
	Nn2qhjuQSVOwjRVy07bSSz8UIIv06o4=
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
	xry111@xry111.site,
	liukexin@kylinos.cn,
	loongarch@lists.linux.dev,
	live-patching@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	George Guo <guodongtai@kylinos.cn>
Subject: [PATCH 0/8] LoongArch: Add livepatch build (KLP) support
Date: Thu,  4 Jun 2026 14:53:09 +0800
Message-Id: <20260604065317.219777-1-dongtai.guo@linux.dev>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: George Guo <guodongtai@kylinos.cn>

This series adds LoongArch support for the klp-build livepatch tooling,
enabling automated livepatch module generation using objtool on
LoongArch.

It is based on Josh Poimboeuf's klp-build series [1] (see base-commit
below) and extends it with the LoongArch-specific objtool and build
pieces, plus a few LoongArch toolchain/relocation fixes required to make
livepatch modules load and run correctly.

Overview:

 - Patch 1 wires up LoongArch klp-build (objtool-based livepatch module
   generation).
 - Patches 2-3 add the objtool bits LoongArch needs: arch_adjusted_addend()
   and the special section entry sizes (.altinstructions, __ex_table,
   __bug_table, __jump_table) so objtool can process livepatch modules.
 - Patches 4-5 fix kernel panics seen when loading livepatch modules,
   caused by LoongArch code-generation/relocation assumptions:
     * disable -mdirect-extern-access for klp builds (the module loader
       relies on GOT entries for external symbol references),
     * force -fPIC so same-compilation-unit symbol references relocate
       correctly.
 - Patch 6 fix EFI linking when building with -fdata-sections.
 - Patch 7 implements arch_jump_opcode_bytes() so klp checksums for
   jump/call instructions are position-independent, mirroring x86/arm64.
 - Patch 8 adds KLP_SYSCALL_DEFINEx() support for LoongArch.

Testing:
 - objtool builds cleanly for LoongArch.
 - Livepatch modules were generated and loaded on a LoongArch machine;
   the panics addressed by patches 4-5 no longer reproduce.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git/log/?h=klp-build-arm64

George Guo (8):
  LoongArch: Add livepatch build (KLP) support
  objtool/LoongArch: Add arch_adjusted_addend() for KLP support
  LoongArch: Add special section entry sizes for KLP support
  livepatch/klp-build: disable direct-extern-access for LoongArch to fix
    kernel panic
  LoongArch: fix kernel panic with -fPIC for same-compilation-unit
    symbol references
  LoongArch: Fix EFI linking with -fdata-sections
  objtool/klp: Add LoongArch jump opcode bytes support
  klp-build: Add LoongArch syscall patching macro

 arch/loongarch/Kconfig                       |  1 +
 arch/loongarch/include/asm/alternative-asm.h |  5 ++-
 arch/loongarch/include/asm/alternative.h     |  6 ++-
 arch/loongarch/include/asm/asm-extable.h     | 10 ++++-
 arch/loongarch/include/asm/bug.h             | 15 ++++++-
 arch/loongarch/include/asm/jump_label.h      |  9 +++-
 arch/loongarch/kernel/asm-offsets.c          | 36 +++++++++++++++
 arch/loongarch/kernel/head.S                 |  1 +
 arch/loongarch/kernel/vmlinux.lds.S          |  2 +-
 include/linux/livepatch_helpers.h            | 22 ++++++++++
 scripts/livepatch/klp-build                  | 16 ++++++-
 tools/objtool/Makefile                       |  3 +-
 tools/objtool/arch/loongarch/decode.c        | 46 ++++++++++++++++++++
 13 files changed, 161 insertions(+), 11 deletions(-)


base-commit: 85afaba140a4b9f20fe8c8a64b24fc85f022d981
-- 
2.25.1

