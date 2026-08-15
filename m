Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E5D344D88;
	Sat, 15 Aug 2026 04:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786769150; cv=none; b=dpjhFY4h/J75pvPc0HsF8iPv9oYaNi6S7+Tx/nCAi0XPofs9Veh0fPvmxKbXFelkF0PW8j9AzgGyYE6osZbG7tpUwAEocZ1w5wJLiBgYPxf9x9T4uDQVp9yJkUYxWYa4pmSS+Nw4U4j0aIfCjdbJs/flCoDAE3W6bWfhMSm242w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786769150; c=relaxed/simple;
	bh=wdRfaGtELZxRn8pMt60oHZSVDjgLL1zcsbH1w6GQ/iw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lse86NfvDbQHves1ASbJBb8RYOl0CUC12ngdnBwhXPCc2T0izpcTUCOFwCRCtoMV6GOqZOKs4eWfRhvIlk2RvBbFN+peeo3M6zgRWNkfQWzfHwE5ZhJeQl5Q0rqg0XL5rswua6wjoYUijNd5hv2908xlwuhP/7yXj+kxwwTraH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lXBtNNCm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lXBtNNCm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A4671F00A3D;
	Sat, 15 Aug 2026 04:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786769147;
	bh=WMsKe5btLXaq16w0tIqve5iamtKug/aatm/4NhSQJFY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lXBtNNCmUIamsfGoa63amsX8TWkAPlX4QFni+73i7Dz/68yfSXGk8cT7h8G1iE/Cd
	 FSYtaRzAbNNSJ4d941Yfev42MF9/CIiVsxEJWpL/nUlFePfWSnI+2Iz2apcIRbIsPQ
	 89egT/aduhm2jT3YCkXb2UpSqcNWkICll7U8NdSIZKtxPFMaB0ycf9IaVBVKFijQ1Y
	 K4K9L47os82FITiBZ27FOcty/U7eHTKWW0YX0c84AppCktJwaWsLyfpxxP5n/gRF1M
	 Mzds1ttWbTJuxmdjZDn/mUUJUj7mRynTszmuJcQSmJ9DtMC7juSk9ro1X40AysDR+6
	 VWyfLaSPawUWQ==
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
Subject: [PATCH 07/12] arm64/bti: Advertise BTI in assembly objects
Date: Fri, 14 Aug 2026 21:45:24 -0700
Message-ID: <5340f3df281bebc81aad3cd9a7471d95061b4b9d.1786768375.git.jpoimboe@kernel.org>
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

On a kernel whose text exceeds the +/-128MB direct branch range, the
linker inserts veneers.  With BTI enabled, the veneers' indirect branch
targets need a BTI landing pad, which not all functions have starting
with Clang 21 (and for all versions of GCC).

In such cases the linker can emit a second veneer close to the target
which has the landing pad along with a direct branch to the target.
However, that's currently not being done, so GCC and Clang 21+ are
broken with BTI on large kernels.

The linker only emits the BTI veneer if *all* input objects have
GNU_PROPERTY_AARCH64_FEATURE_1_BTI, which is not being done for
hand-written asm.

Force-include a property note with the BTI bit into every assembly
translation unit, which is accurate as SYM_FUNC_START*() already emits a
"bti c" landing pad for callable assembly functions.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/arm64/Makefile               |  4 ++++
 arch/arm64/include/asm/bti-note.h | 32 +++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)
 create mode 100644 arch/arm64/include/asm/bti-note.h

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 6b005c8fef706..4eee721c0b278 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -23,6 +23,10 @@ ifeq ($(CONFIG_ARM64_ERRATUM_843419),y)
 LDFLAGS_vmlinux	+= --fix-cortex-a53-843419
 endif
 
+ifeq ($(CONFIG_ARM64_BTI_KERNEL),y)
+KBUILD_AFLAGS	+= -include $(srctree)/arch/arm64/include/asm/bti-note.h
+endif
+
 cc_has_k_constraint := $(call try-run,echo				\
 	'int main(void) {						\
 		asm volatile("and w0, w0, %w0" :: "K" (4294967295));	\
diff --git a/arch/arm64/include/asm/bti-note.h b/arch/arm64/include/asm/bti-note.h
new file mode 100644
index 0000000000000..17ef5692987f7
--- /dev/null
+++ b/arch/arm64/include/asm/bti-note.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Emit a GNU_PROPERTY_AARCH64_FEATURE_1_BTI note.  This is force-included in
+ * every assembly file so the linker emits BTI veneers for >128MB kernels.
+ *
+ * Clang has -mmark-bti-property, but there's no equivalent for GCC/GAS.
+ *
+ * Binutils 2.44+ and LLVM 22+ support a much more compact version:
+ *
+ *   .aeabi_subsection aeabi_feature_and_bits, optional, ULEB128
+ *   .aeabi_attribute Tag_Feature_BTI, 1
+ */
+#ifndef __ASM_BTI_NOTE_H
+#define __ASM_BTI_NOTE_H
+
+	.pushsection .note.gnu.property, "a"
+	.align	3
+	.long	2f - 1f
+	.long	6f - 3f
+	.long	5		/* NT_GNU_PROPERTY_TYPE_0 */
+1:	.string	"GNU"
+2:
+	.align	3
+3:	.long	0xc0000000	/* GNU_PROPERTY_AARCH64_FEATURE_1_AND */
+	.long	5f - 4f
+4:	.long	1		/* GNU_PROPERTY_AARCH64_FEATURE_1_BTI */
+5:
+	.align	3
+6:
+	.popsection
+
+#endif /* __ASM_BTI_NOTE_H */
-- 
2.55.0

