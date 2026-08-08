Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB992D7BF;
	Sat,  8 Aug 2026 23:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786231097; cv=none; b=Yndndft38Ch5gckQLPaMaArCeFKHTeqGrqXGRf6mRxLM/I4uEWV4z50UbOTDec/8Eied+iKjNOZtq0ieQvyPYDud+NiTjArRGF56xpS6KNm0uZM/GAe6efKeM5Kl3YvirdJOhzeJptVq0NphFGrFl1oDxzzE8a80sPIhxwDI/Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786231097; c=relaxed/simple;
	bh=DeWbRgZBKnA4sf0nVK37g2Jy0opIVg9VuuInfL8PCEU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E35P4nLs0PQvORyDxlCNCxOx0i8d010845SRBlbQUkyoAfdVLgbqJfxfb7hE6t6olFdOwKIY7gM6YN9TQHmFSNWISvAFl5ucgWP7KziIrClji2xdli/EZC6BqIDnajkdJgedTRadn1WI+u43BIx35UmnhiAU807SB7lBBmNn074=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TWIBztWa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TWIBztWa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07F841F000E9;
	Sat,  8 Aug 2026 23:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786231095;
	bh=LG5x7pYEt93Jfnp3xRtm3lDEif7tHGtyxh7/VUnQcBY=;
	h=From:To:Cc:Subject:Date;
	b=TWIBztWaXyiqlEd+EuDVD9lZMGZuy2NZSKjJWWmEOHKtl2vqcgorIxtNVilKnWWX6
	 tLmFqwaW3XsoAxGSpn+9IdytZEuX71LS9TNR8rfIeqjh1w5clwMiVhk/au7sHw6ZhO
	 XcQFCKeSkmSpYFqM6W1iAZT1adCkxEYcngc7v9FUEjHh2ujdhDazCSo0gIn1++TQ37
	 heaDMzEUza7sp575H+21C9kIHUJEDTXWZLEBiu0DSmrwf+FMHN0TKx4YQ6IeP8orK3
	 4alrinuQLckea9KUwW1ohmhesstftZfwt0x0YDeSiUMiOsVkeE60CyjVaRA2Rvqdcj
	 7f7U/8qm3WIMw==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Song Liu <song@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH v4 00/22] objtool/arm64: Port klp-build to arm64
Date: Sat,  8 Aug 2026 16:17:04 -0700
Message-ID: <cover.1786230311.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Based on tip/objtool/core + the following fixes:

- https://lore.kernel.org/cover.1786138493.git.jpoimboe@kernel.org
- https://lore.kernel.org/ed4fe1f95071897859ec7fbe9176246cbd4962bf.1786138806.git.jpoimboe@kernel.org
- https://lore.kernel.org/1b5ccfa8095bdb1277f84af1c2c2e2205aca03ae.1785992188.git.jpoimboe@kernel.org

The full set (including the above fixes) can be found on the following branch:

  git://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git klp-build-arm64

v4:
- Replace "objtool: Allow empty alternatives" with "arm64: Remove unnecessary empty alternatives" [Peter]
- Add "objtool/klp: Fix .kcfi_traps special section extraction" [Joe]
- Fix vmlinux.o objtool options leaking in from Makefile.lib [Sashiko]
- Tighten jump-to-end-of-function check [Sashiko]
- Drop unneeded linux/kconfig.h include [Sashiko]
- Fix bisectability issue with is_mapping_sym()/is_data_mapping_sym() [Sashiko]
- Add missing ALLOW_ERROR_INJECTION() to arm64 syscall macro [Sashiko]

v3: https://lore.kernel.org/cover.1778642120.git.jpoimboe@kernel.org
- Too many changes to list.  Did a lot of testing and fixed a bunch of
  issues (many of which have already been merged in tip/objtool/core).

v2: https://lore.kernel.org/cover.1773787568.git.jpoimboe@kernel.org
- patches 1-2 were merged, rebase on tip/master
- improve commit message for "objtool: Extricate checksum calculation from validate_branch()"
- add review tags

v1: https://lore.kernel.org/cover.1772681234.git.jpoimboe@kernel.org

Port objtool and the klp-build tooling (for building livepatch modules)
to arm64.

Note this doesn't bring all the objtool bells and whistles to arm64, nor
any of the CFG reverse engineering.  This only adds the bare minimum
needed for 'objtool --checksum'.

And note that objtool still doesn't get enabled at all for normal arm64
kernel builds, so this doesn't affect any users other than those running
klp-build directly.

Josh Poimboeuf (22):
  objtool/klp: Fix .kcfi_traps special section extraction
  klp-build: Reject patches to init/*.c
  arm64: Annotate intra-function calls
  arm64: Fix EFI linking with -fdata-sections
  arm64: Rename TRAMP_VALIAS -> TRAMP_VALIAS_ASM in asm-offsets
  arm64: vdso: Discard .discard.* sections
  arm64: Annotate special section entries
  arm64: Remove unnecessary empty alternatives
  crypto: arm64: Move data to .rodata
  objtool: Allow setting --mnop without --mcount
  kbuild: Only run objtool if there is at least one command
  objtool: Ignore jumps to the end of the function for checksum runs
  objtool: Refactor elf_add_data() to use a growable data buffer
  objtool: Reuse string references
  objtool: Prevent kCFI hashes from being decoded as instructions
  objtool/klp: Add arm64 support for prefix/PFE detection
  objtool/klp: Filter arm64 mapping symbols in find_symbol_by_offset()
  objtool/klp: Don't correlate arm64 mapping symbols
  objtool/klp: Clone inline alternative replacements
  objtool/klp: Introduce objtool for arm64
  klp-build: Support cross-compilation
  klp-build: Add arm64 syscall patching macro

 arch/arm64/Kconfig                            |   2 +
 arch/arm64/include/asm/alternative-macros.h   |  27 +-
 arch/arm64/include/asm/asm-bug.h              |   2 +
 arch/arm64/include/asm/asm-extable.h          |  21 +-
 arch/arm64/include/asm/assembler.h            |   4 +-
 arch/arm64/include/asm/jump_label.h           |   2 +
 arch/arm64/kernel/asm-offsets.c               |   7 +-
 arch/arm64/kernel/entry.S                     |  10 +-
 arch/arm64/kernel/proton-pack.c               |  12 +-
 arch/arm64/kernel/vdso/vdso.lds.S             |   1 +
 arch/arm64/kernel/vmlinux.lds.S               |   2 +-
 arch/x86/boot/startup/Makefile                |   2 +-
 include/linux/annotate.h                      |  14 +-
 include/linux/livepatch_helpers.h             |  20 ++
 include/linux/objtool_types.h                 |   1 +
 lib/crypto/arm64/sha2-armv8.pl                |  18 +-
 scripts/Makefile.build                        |   4 +-
 scripts/Makefile.lib                          |  52 ++--
 scripts/Makefile.vmlinux_o                    |  18 +-
 scripts/livepatch/klp-build                   |  24 +-
 tools/include/linux/objtool_types.h           |   1 +
 tools/objtool/Makefile                        |   4 +
 tools/objtool/arch/arm64/Build                |   2 +
 tools/objtool/arch/arm64/decode.c             | 177 ++++++++++++
 .../arch/arm64/include/arch/cfi_regs.h        |  11 +
 tools/objtool/arch/arm64/include/arch/elf.h   |  15 ++
 .../objtool/arch/arm64/include/arch/special.h |  21 ++
 tools/objtool/arch/arm64/special.c            |  30 +++
 tools/objtool/arch/x86/include/arch/elf.h     |   2 +
 tools/objtool/builtin-check.c                 |   5 -
 tools/objtool/check.c                         |  52 ++--
 tools/objtool/elf.c                           | 170 +++++++-----
 tools/objtool/include/objtool/elf.h           |  48 +++-
 tools/objtool/klp-diff.c                      | 254 ++++++++++++++++--
 tools/objtool/klp-symid.c                     |   2 +-
 35 files changed, 843 insertions(+), 194 deletions(-)
 create mode 100644 tools/objtool/arch/arm64/Build
 create mode 100644 tools/objtool/arch/arm64/decode.c
 create mode 100644 tools/objtool/arch/arm64/include/arch/cfi_regs.h
 create mode 100644 tools/objtool/arch/arm64/include/arch/elf.h
 create mode 100644 tools/objtool/arch/arm64/include/arch/special.h
 create mode 100644 tools/objtool/arch/arm64/special.c

-- 
2.54.0

