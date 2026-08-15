Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF522ED843;
	Sat, 15 Aug 2026 04:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786769162; cv=none; b=ipL8FImTPOY8LhHMxZNCfUlHp1ZBB5eFcVjY8NQ1aBoElxrvNhlEVf3OdqV6TAGHwRnE4QAqV7oHK3puS/wvUvpnKPOkZ1ewkgWKCcvFoW/VDmYGppjA2Tl8qcDiblCyq/6RVFN5xA6mUkIh8635y/EXm2OPkfvq2lxbJy8UGqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786769162; c=relaxed/simple;
	bh=lKwrcvDZGGHaPIdjQ94SaFakMaUXJBQwBrEFizBKbjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aMeMtxwaw62TTtOaoktUQO0pN2zySyejZoT6+EGyGSFhnVDhZVGfL6ZftBl/HGRl2b8euHSkIPhgl68H669JGQfABvsWT+p8uRqDoH5g2U4nbaoZ2KuwFAIo9S+S0kAQ8tGbjXTtp1N1WiaAd6VB5PjTlJdw/Acfksv22PdK0jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EWSVAKHk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EWSVAKHk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE7001F00A3F;
	Sat, 15 Aug 2026 04:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786769150;
	bh=MPvOEc+5lf8H/6sumQoxrEWGP3CaWe5SGGeAIoQ2JNA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EWSVAKHkynKQFLG14e1B38tQtZLc06S4HFXzg5dSPwZvmr7ljXSJsg++F9olxojRK
	 jNv/cLfF72Mi2740XqAg82Yk4PFoiZx2n6avnLb8vTsAhoorDpgyABHPztmOco/mG4
	 FBntnAwwbAZkf7O1ngyOM4m+OPqaHSt2LRHzkIHC8YYMIfzPboYMIUySCHMASxrpVV
	 aP7UXvZO4OGscRC3xcjpaOlLsi7TfaQfqwZlJa4SRP7GZ8q/5VJQzL9Hu+OIS/FcF5
	 aE8UnGVd3ZVd2vhetg5nNEvv1AU3qJY9O1frMp44QsAgVLfeRpTgWbwFL6iFIGQauu
	 kNjRnpjiedOMg==
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
Subject: [PATCH 10/12] efi/libstub: Remove obsolete .note.gnu.property workaround
Date: Fri, 14 Aug 2026 21:45:27 -0700
Message-ID: <e5c957d816240e749a92588d4a9bb44da791f8e3.1786768375.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1786768375.git.jpoimboe@kernel.org>
References: <cover.1786768375.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit e2179a09ab08 ("efi/libstub: Disable -mbranch-protection") added
--remove-section=.note.gnu.property to the stub objcopy invocation to
work around a Clang bug where the note was emitted for code-less object
files even with -mbranch-protection=none.

That was fixed by LLVM commit a48f6079f288 ("[AArch64] Generate
.note.gnu.property based on module flags") which was released with
Clang 12.  The minimum Clang version is now Clang 17, so this workaround
is no longer needed.

On arm64, the stub also no longer builds with -mbranch-protection=none,
as it has inherited the kernel's flags since commit 8358098b9787
("arm64: efi: Enable BTI codegen and add PE/COFF annotation").

Remove the workaround.  This fixes BTI on arm64, and is a no-op on
RISC-V and LoongArch where the vmlinux generic NOTES macro discards it,
and the x86 and ARM decompressors discard .note.* explicitly.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 drivers/firmware/efi/libstub/Makefile | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index b1c95f69e807d..e18e124a89acf 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -106,12 +106,6 @@ lib-$(CONFIG_UNACCEPTED_MEMORY) += unaccepted_memory.o bitmap.o find.o
 targets				:= $(lib-y)
 lib-y				:= $(patsubst %.o,%.stub.o,$(lib-y))
 
-# Even when -mbranch-protection=none is set, Clang will generate a
-# .note.gnu.property for code-less object files (like lib/ctype.c),
-# so work around this by explicitly removing the unwanted section.
-# https://llvm.org/pr46480
-STUBCOPY_FLAGS-y		+= --remove-section=.note.gnu.property
-
 STUBCOPY_RELOC-$(CONFIG_X86_32)	:= R_386_32
 STUBCOPY_RELOC-$(CONFIG_X86_64)	:= R_X86_64_64
 
-- 
2.55.0

