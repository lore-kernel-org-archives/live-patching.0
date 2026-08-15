Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E15E45000;
	Sat, 15 Aug 2026 04:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786769144; cv=none; b=T/eVTjq6aQVl8UH1Sgoq4FnYKh299jAgADjEpJ0Gek22UulWEESUulC184JBDGWCI/zFVZH+CrUFgayAO9Ej5T9je3g5qK8oir1tu63eBsIkytKSrPDtB7Xc3igSTWGIuxPmCsGRjsj6gLus/ROFahDGus+O46xYn35G99VXJVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786769144; c=relaxed/simple;
	bh=uAT0cw010laXi0EU2fspdkcWWdHxCP5sg83zuH9l0Yc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FLfVGqjmJoL4LnJBd/MxNMGC1lvozYCNLudNDpsCyEhoHMaPGNsPRvs31ELa7W/VmhF4/IfB6jmD5nU1ff6+NCYN0vLT8oYxP8QjezNT1R+S/mFjOwD6ixtqidzirZk6EDws/1Uk7VyIE14P/yHoaEJI4qBk6AmSW/P6g3UpsA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gwo5uajh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gwo5uajh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2785B1F000E9;
	Sat, 15 Aug 2026 04:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786769142;
	bh=WjLM+bqBQnxWBLyFD+G6Wb/9zI+E+wNq4T1i/w+3/XI=;
	h=From:To:Cc:Subject:Date;
	b=gwo5uajh9Ku11rgr69W3oWzKqADkXpQw2vTRX6xQ2NxPdST2vVgf9rpAf858Lycbt
	 8zb3t0GfJ6gam9vEy07gold0MjaH5LxGuIubCtzN9ZqYYAE+g4kcD5Wcom8irly069
	 zkbrSnWo02ssjwp3Phn9EjWat+A/R0yCk1EjQUiPMgKUYGlPzXKy/UlLisHM2Ra1Os
	 KxK2ClTVM0n6qxqVyALVKW4uUZhnMS8nXuOe9JdEdMWVny9Lerq98mmk1FnEGK54Yy
	 cmchz3cbDQFmw1FwOoRep3M1UBZXALAL8vQGRDohsmnKbvSTVRmkgbyPenCLBmZwRx
	 pRZ1DjU4ytbeA==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	live-patching@vger.kernel.org,
	Song Liu <song@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Mark Brown <broonie@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Kees Cook <kees@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	linux-toolchains@vger.kernel.org
Subject: [PATCH 00/12] arm64/bti: Fix kernel BTI issues with livepatch, large kernels, toolchains
Date: Fri, 14 Aug 2026 21:45:17 -0700
Message-ID: <cover.1786768375.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These patches are a continuation of the following discussions about some
bugs related to kernel BTI:

  https://lore.kernel.org/ed4fe1f95071897859ec7fbe9176246cbd4962bf.1786138806.git.jpoimboe@kernel.org
  https://lore.kernel.org/20260812162058.612202-4-ardb@kernel.org

This started as a livepatch crash investigation but quickly ballooned
into a rabbit hole of latent bugs and toolchain quirks/crashes.

The most notable patch is probably the last one, which enables BTI on GCC.

I also hit a SIGSEGV in the GNU linker, for which this series has a
workaround.  The binutils bug is here:

  https://sourceware.org/bugzilla/show_bug.cgi?id=34525

Several of these patches probably wouldn't be needed if we had a flag
like -fno-omit-bti-pads or so for both compilers, but that currently
doesn't exist, and this at least fixes things for the existing
toolchains out there.

There is some toolchain discussion about that here:

 https://github.com/llvm/llvm-project/issues/215547

Josh Poimboeuf (12):
  arm64/bti: Add BTI landing pad to __sdei_asm_handler()
  arm64/module: Fix BTI exceptions caused by omitted landing pads in
    Clang 21
  arm64/bti: Fix BTI linker failures with long branches into .idmap.text
  arm64/bti: Work around ld crash caused by linker script aliases
  arm64/bti: Add link error for large kernels with BTI and unsupported
    toolchains
  arm64/bti: Add link error for large kernels with BTI and livepatch
  arm64/bti: Advertise BTI in assembly objects
  arm64/bti: Enable BTI in the pi/ startup code
  efi/libstub: Preserve the GNU property note
  efi/libstub: Remove obsolete .note.gnu.property workaround
  arm64/bti: Force-enable BTI linker veneers
  arm64/bti: Enable kernel BTI for GCC

 arch/arm64/Kconfig                    |   9 +-
 arch/arm64/Makefile                   |   5 +
 arch/arm64/include/asm/bti-note.h     |  32 +++++
 arch/arm64/include/asm/module.h       |   5 +
 arch/arm64/kernel/cpu-reset.S         |   2 +-
 arch/arm64/kernel/entry.S             |   1 +
 arch/arm64/kernel/head.S              |   8 +-
 arch/arm64/kernel/hyp-stub.S          |   1 +
 arch/arm64/kernel/image-vars.h        |  13 +-
 arch/arm64/kernel/module-plts.c       | 186 ++++++++++++++++++++++++++
 arch/arm64/kernel/pi/Makefile         |  11 +-
 arch/arm64/kernel/sleep.S             |   2 +-
 arch/arm64/kernel/vmlinux.lds.S       |  12 ++
 arch/arm64/lib/memcpy.S               |   3 +
 arch/arm64/lib/memset.S               |   2 +
 arch/arm64/mm/cache.S                 |   1 +
 arch/arm64/mm/proc.S                  |   8 +-
 drivers/firmware/efi/libstub/Makefile |  15 ++-
 18 files changed, 282 insertions(+), 34 deletions(-)
 create mode 100644 arch/arm64/include/asm/bti-note.h

-- 
2.55.0

