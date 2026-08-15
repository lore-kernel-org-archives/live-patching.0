Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744193254A9;
	Sat, 15 Aug 2026 04:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786769147; cv=none; b=QdKWztl48UDkfLa2J2eaRpVPyhQDs6LcLAVg699AVDAmC5vRrxpzIwCTuhfnC0IBxJbpKFTOfpFK09BNPkWIuVTUeTaOC5bVyGmRXPcYd9ftRPkF7abuW69tHiY34bGmioiKo9JEK3L80KlSCrAp2mByqr1Zq4uYutJHqp80Zqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786769147; c=relaxed/simple;
	bh=NJZuCdn378zNL5UCofyFBX0P47l0IetFygRwkSK2g/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hPIyr0HjM8nuFsAdm2OciyMeL8Wug+MVom6VTbiFmqkUmBQShhrY8V23dBPmNofeS76xSLf5AQzbUrA/wpQ3xzv0Ag7edj8gkxZ394LE0C3ul7Epjpk7fFSrXFm4R+GSXoCxiA1SIk7Lcuy61tesbk6LeNS7OCkmH3+2AUBiWlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jtzxYTp7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jtzxYTp7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 516991F00A3D;
	Sat, 15 Aug 2026 04:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786769144;
	bh=AdWP5M8fepkFBrH2JRckg07b+cTfpP4Tn08yEnDUFpM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jtzxYTp79rvJ3tknzX5+zQxTKPH9Krwr573PMHQgZmdpOlgg1GNO3F1eDmEWlY6Rr
	 uoFCFPKhT7degHBRC2iEFsXSzeNaWB6mNK5RzFeSxHdY82X7XFH/7P/9XMzziK4nFZ
	 TR4lKjtMB62iLTvWr0SVkW0BrTAvZpw5XZxj5pfAweHVY3J+vXsgyqrBfQN7xnAx27
	 f7AUPu0KQ99r09GW/ASY+Ur9x9d5CXnehRTfU4/dqsdoxII1oPK6ihz9wsABReEs1D
	 gXjdyOT5UeAOSjZAq/P6iZb7frRN7sdRnfZ8ZYoLAIYmvbITLZwsEBgsTXpBcRkVxT
	 P79oyiedVRzeg==
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
Subject: [PATCH 03/12] arm64/bti: Fix BTI linker failures with long branches into .idmap.text
Date: Fri, 14 Aug 2026 21:45:20 -0700
Message-ID: <a9662e64de17882d2ef2401bad0d8172ef48bc4b.1786768375.git.jpoimboe@kernel.org>
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

On a kernel whose text exceeds the +/128MB direct branch range, the
linker inserts veneers.  With BTI enabled, the veneers' indirect branch
targets need a BTI landing pad, which not all functions have starting
with Clang 21 (and for all versions of GCC).

In such cases the linker can emit a second veneer close to the target
which has the landing pad along with a direct branch to the target.  But
a long branch to .idmap.text never gets one because it's missing the
executable section flag.

With the LLVM linker, it's a silent failure, presumably only discovered
by a BTI exception at runtime.  With the GNU linker it's even worse, as
it dereferences the missing stub/veneer group entry and seg faults (this
was how I discovered it).

Make sure the section is executable by adding the "x" flag to all the
creators of the input section.

Also manually add "bti c" to primary_entry() and enter_vhe(), otherwise
the linker-generated veneer page pushes the .idmap.text past its
asserted 4KB size:

  ld.bfd: ID map text too big or misaligned

Link: https://sourceware.org/bugzilla/show_bug.cgi?id=34525
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/arm64/kernel/cpu-reset.S | 2 +-
 arch/arm64/kernel/head.S      | 7 ++++---
 arch/arm64/kernel/hyp-stub.S  | 1 +
 arch/arm64/kernel/sleep.S     | 2 +-
 arch/arm64/mm/proc.S          | 8 ++++----
 5 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kernel/cpu-reset.S b/arch/arm64/kernel/cpu-reset.S
index c87445dde6745..9943a7c70f6b0 100644
--- a/arch/arm64/kernel/cpu-reset.S
+++ b/arch/arm64/kernel/cpu-reset.S
@@ -14,7 +14,7 @@
 #include <asm/virt.h>
 
 .text
-.pushsection    .idmap.text, "a"
+.pushsection    .idmap.text, "ax"
 
 /*
  * cpu_soft_restart(el2_switch, entry, arg0, arg1, arg2)
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 87a822e5c4ca8..541721488bef9 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -71,7 +71,7 @@
 
 	__EFI_PE_HEADER
 
-	.section ".idmap.text","a"
+	.section ".idmap.text","ax"
 
 	/*
 	 * The following callee saved general purpose registers are used on the
@@ -83,6 +83,7 @@
 	 *  x21        primary_entry() .. start_kernel()        FDT pointer passed at boot in x0
 	 */
 SYM_CODE_START(primary_entry)
+	bti	c
 	bl	record_mmu_state
 	bl	preserve_boot_args
 
@@ -251,7 +252,7 @@ SYM_FUNC_END(__primary_switched)
  * end early head section, begin head code that is also used for
  * hotplug and needs to have the same protections as the text region
  */
-	.section ".idmap.text","a"
+	.section ".idmap.text","ax"
 
 /*
  * Starting from EL2 or EL1, configure the CPU to execute at the highest
@@ -455,7 +456,7 @@ SYM_FUNC_END(set_cpu_boot_mode_flag)
  * Checks if the selected granule size is supported by the CPU.
  * If it isn't, park the CPU
  */
-	.section ".idmap.text","a"
+	.section ".idmap.text","ax"
 SYM_FUNC_START(__enable_mmu)
 	mrs	x3, ID_AA64MMFR0_EL1
 	ubfx	x3, x3, #ID_AA64MMFR0_EL1_TGRAN_SHIFT, 4
diff --git a/arch/arm64/kernel/hyp-stub.S b/arch/arm64/kernel/hyp-stub.S
index 37c6976e44a4c..5f9c5ffb4afc1 100644
--- a/arch/arm64/kernel/hyp-stub.S
+++ b/arch/arm64/kernel/hyp-stub.S
@@ -167,6 +167,7 @@ SYM_CODE_END(__finalise_el2)
 	.pushsection	.idmap.text, "ax"
 
 SYM_CODE_START_LOCAL(enter_vhe)
+	bti	c
 	// Invalidate TLBs before enabling the MMU
 	tlbi	vmalle1
 	dsb	nsh
diff --git a/arch/arm64/kernel/sleep.S b/arch/arm64/kernel/sleep.S
index f093cdf71be11..dfb5b8bc8cdb5 100644
--- a/arch/arm64/kernel/sleep.S
+++ b/arch/arm64/kernel/sleep.S
@@ -97,7 +97,7 @@ SYM_FUNC_START(__cpu_suspend_enter)
 	ret
 SYM_FUNC_END(__cpu_suspend_enter)
 
-	.pushsection ".idmap.text", "a"
+	.pushsection ".idmap.text", "ax"
 SYM_CODE_START(cpu_resume)
 	mov	x0, xzr
 	bl	init_kernel_el
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 22866b49be372..b8ff93c748bf1 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -175,7 +175,7 @@ alternative_else_nop_endif
 SYM_FUNC_END(cpu_do_resume)
 #endif
 
-	.pushsection ".idmap.text", "a"
+	.pushsection ".idmap.text", "ax"
 
 .macro	__idmap_cpu_set_reserved_ttbr1, tmp1, tmp2
 	adrp	\tmp1, reserved_pg_dir
@@ -211,7 +211,7 @@ SYM_FUNC_ALIAS(__pi_idmap_cpu_replace_ttbr1, idmap_cpu_replace_ttbr1)
 #define KPTI_NG_PTE_FLAGS	(PTE_ATTRINDX(MT_NORMAL) | PTE_TYPE_PAGE | \
 				 PTE_AF | PTE_SHARED | PTE_UXN | PTE_WRITE)
 
-	.pushsection ".idmap.text", "a"
+	.pushsection ".idmap.text", "ax"
 
 	.macro	pte_to_phys, phys, pte
 	and	\phys, \pte, #PTE_ADDR_LOW
@@ -438,7 +438,7 @@ SYM_FUNC_END(idmap_kpti_install_ng_mappings)
 	.popsection
 #endif
 
-	.pushsection ".idmap.text", "a"
+	.pushsection ".idmap.text", "ax"
 SYM_TYPED_FUNC_START(wait_linear_map_split_to_ptes)
 	/* Must be same registers as in idmap_kpti_install_ng_mappings */
 	swapper_ttb	.req	x3
@@ -479,7 +479,7 @@ SYM_FUNC_END(wait_linear_map_split_to_ptes)
  * Output:
  *	Return in x0 the value of the SCTLR_EL1 register.
  */
-	.pushsection ".idmap.text", "a"
+	.pushsection ".idmap.text", "ax"
 SYM_FUNC_START(__cpu_setup)
 	tlbi	vmalle1				// Invalidate local TLB
 	dsb	nsh
-- 
2.55.0

