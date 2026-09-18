Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BFF3D3302
	for <live-patching@vger.kernel.org>; Fri, 18 Sep 2026 22:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789771327; cv=none; b=YhvU+/hgyi3bRd2OOwur0Bg4R1Cn1tHNoYnHQqdDpKINjLhgGWxU6kv202WgMkQguIAE8YJKMecz1o9KaH2RMReKKyBABkHsMr404aovHWMHqLdIHbDJToGo9qiW4ZbtJCovWIxnFsO2ZcvP50czHbs92bXf549q4xjOoBePpJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789771327; c=relaxed/simple;
	bh=uG5wNgd52zB4rdORrDugQlxgpJ0NquafonfUEuZpTcs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JrljFXeFA5dYo+zTX8+EZyqPzP8wwczPN2XOZlApj6ZsBDqb66otqXm/tB50rS+cJKYExsjWY3IjO2222midx22Xf7z6YfEINwhLDp5UVpTQ87h9STOF/CGDqAYHc76YIprLx/iJwXldlWDbbHzNSu8352oeupzoAZn7Ng3lAcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dylanbhatch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=naJxmu3N; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dylanbhatch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="naJxmu3N"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-868f443cbd0so1180823b3a.2
        for <live-patching@vger.kernel.org>; Fri, 18 Sep 2026 15:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789771325; x=1790376125; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7zP5Ezz25qs4uZUEMPLAi6N7kWIgKe5zo+xnDkfoqL8=;
        b=naJxmu3NfPPOj9dujpv7t0DFcIxPqohG7a9KuGlU4e1QwZR2NXtiOHmvEnGt/7rZVm
         ZRSgkyBtQ1PA/EohLn0aThEmXIREtYhv1Ak8oa2pR5ctYbvH64yKARiBSSexBDgOHPDu
         c8E1zkAeu6gDAsDNw+tQwWvFb9ofUxWIWHtVzVpPJskBudqDqABg0T+BLBy6VXBGsALP
         uJgrzaIHF5GLc2X7VgkyRQXrrHWWfayd/E3GKnjYE/ayvs9UiranYEozbxZE6IWMFO0C
         CE8ZY0xuhi9toGm47/FS8NMmTtmU4EMm8ITgf5ca1oaJRuQ0C23lE3pR8J2b5ILzUCBG
         g8AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789771325; x=1790376125;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7zP5Ezz25qs4uZUEMPLAi6N7kWIgKe5zo+xnDkfoqL8=;
        b=bozfjRKEUT6bgm9HWioVAVNvywxNI5t6MWek8Ytw2Tqmw5QEJfhn32zUeGLOJuBtfT
         FIlIhDAfHnKVeX3bwhstfrjXptE1k1LTh+2Yy2kwX/4pgZ682D4XSgUpFY2vJH1Jb2A4
         Uk19qZHBJxVPHnWmld0tkESdLp+YwS4lSA4x40IxfwNCG812EeAk4mxwVyVpHSquyKBZ
         h55TFcUguj7CyWgaozABW7zsVorPEAPX7r/Dos1CLywJmL9K4a37tsqr/8uvuJT/z+E1
         bYVYEjBFQo24WzT8V0+63Ilqr+qnIg3CgP0O4qMcXaF3VIY5SATHvHXuI9Hn9d31fDNA
         b78w==
X-Forwarded-Encrypted: i=1; AKwUvByFvK0OSHuaqdlGnrnbkC27zMD9aWFFaLQ0qxCbw/5LjOzt4seIETAYOZQ2qGedpdo55882gECOHptTmSRJ@vger.kernel.org
X-Gm-Message-State: AFuF++mNKE5Q6MoDxrc8wOXe/1H8vbupBPZ+jPqhKND3m/8Uf4o4qwsh
	CtPbitICDpyAb7Y4pw23EdydPSDaXPimuh5CO03wjXYwdLbdNzNZuc12HtmzCbjyCzJcmtm9D1r
	uXojlOPkzc9RoBqQcjp193dgRCQ==
X-Received: from pgbcm17.prod.google.com ([2002:a05:6a02:a11:b0:cc4:c7fa:81b0])
 (user=dylanbhatch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:490d:b0:3cc:eea9:f757 with SMTP id adf61e73a8af0-3dd8c466ef5mr7989373637.16.1789771324995;
 Fri, 18 Sep 2026 15:42:04 -0700 (PDT)
Date: Fri, 18 Sep 2026 22:41:47 +0000
In-Reply-To: <20260918224157.1471085-1-dylanbhatch@google.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260918224157.1471085-1-dylanbhatch@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260918224157.1471085-2-dylanbhatch@google.com>
Subject: [PATCH v7 01/11] arm64, unwind: build kernel with sframe V3 info
From: Dylan Hatch <dylanbhatch@google.com>
To: Roman Gushchin <roman.gushchin@linux.dev>, Weinan Liu <wnliu@google.com>, 
	Will Deacon <will@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Indu Bhagat <ibhagatgnu@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Jiri Kosina <jikos@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Jens Remus <jremus@linux.ibm.com>
Cc: Dylan Hatch <dylanbhatch@google.com>, Prasanna Kumar T S M <ptsm@linux.microsoft.com>, 
	Puranjay Mohan <puranjay@kernel.org>, Song Liu <song@kernel.org>, joe.lawrence@redhat.com, 
	linux-toolchains@vger.kernel.org, linux-kernel@vger.kernel.org, 
	live-patching@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Randy Dunlap <rdunlap@infradead.org>, Mostafa Saleh <smostafa@google.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"

To generate a .sframe section, build with -Wa,--gsframe-3 flags. Also,
add unwind-table options to ensure the necessary CFI directives are
emitted by the compiler, but discard .eh_frame unless
CONFIG_UNWIND_TABLES is explicitly enabled.

This will be used for in-kernel reliable stacktrace in
cases where the frame pointer alone is insufficient.

Currently, the sframe format only supports arm64, x86_64 and s390x
architectures.

Co-developed-by: Weinan Liu <wnliu@google.com>
Signed-off-by: Weinan Liu <wnliu@google.com>
Reviewed-by: Prasanna Kumar T S M <ptsm@linux.microsoft.com>
Reviewed-by: Jens Remus <jremus@linux.ibm.com>
Signed-off-by: Dylan Hatch <dylanbhatch@google.com>

---

Changes since v6:
 - Moved to beginning of series
 - Squashed in AS_SFRAME, AS_SFRAME3, and UNWIND_SFRAME_LOOKUP config
   definitions.
 - Squashed in STACK UNWINDING change in MAINTAINERS file.
 - Dropped SFRAME_REG_SP / SFRAME_REG_FP definitions.
 - Added -fasynchronous-unwind-tables so CFI directives are emitted by
   compiler.
 - Discard .eh_frame sections when CONFIG_UNWIND_TABLES is not set.
---
 MAINTAINERS                         |  3 ++-
 Makefile                            |  8 ++++++++
 arch/Kconfig                        | 31 +++++++++++++++++++++++++++++
 arch/arm64/Kconfig                  |  1 +
 arch/arm64/Makefile                 |  2 +-
 arch/arm64/include/asm/module.lds.h |  2 ++
 arch/arm64/kernel/vdso/Makefile     |  2 +-
 arch/arm64/kernel/vmlinux.lds.S     | 12 +++++++++++
 include/asm-generic/sections.h      |  4 ++++
 include/asm-generic/vmlinux.lds.h   | 15 ++++++++++++++
 10 files changed, 77 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c2414447892c2..6c1c95979e437 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -28514,10 +28514,11 @@ F:	Documentation/driver-api/uio-howto.rst
 F:	drivers/uio/
 F:	include/linux/uio_driver.h
 
-USERSPACE STACK UNWINDING
+STACK UNWINDING
 M:	Josh Poimboeuf <jpoimboe@kernel.org>
 M:	Steven Rostedt <rostedt@goodmis.org>
 S:	Maintained
+F:	arch/*/include/asm/unwind_sframe.h
 F:	include/linux/unwind*.h
 F:	kernel/unwind/
 
diff --git a/Makefile b/Makefile
index 0f1b80100b479..5ed4a59e71aac 100644
--- a/Makefile
+++ b/Makefile
@@ -1197,6 +1197,14 @@ CFLAGS_GCOV	+= $(call try-run,\
 endif
 export CFLAGS_GCOV
 
+# build with sframe table
+ifdef CONFIG_HAVE_UNWIND_KERNEL_SFRAME
+CC_FLAGS_SFRAME := -Wa,--gsframe-3
+KBUILD_CFLAGS	+= $(CC_FLAGS_SFRAME)
+KBUILD_AFLAGS	+= $(CC_FLAGS_SFRAME)
+export CC_FLAGS_SFRAME
+endif
+
 # change __FILE__ to the relative path to the source directory
 ifdef building_out_of_srctree
 KBUILD_CPPFLAGS += -fmacro-prefix-map=$(srcroot)/=
diff --git a/arch/Kconfig b/arch/Kconfig
index 45c6577723623..cc59a5da80915 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -507,6 +507,37 @@ config HAVE_UNWIND_USER_FP
 	bool
 	select UNWIND_USER
 
+config AS_SFRAME
+	bool
+
+config AS_SFRAME3
+	def_bool $(as-instr,.cfi_startproc\n.cfi_endproc,-Wa$(comma)--gsframe-3)
+	select AS_SFRAME
+
+config UNWIND_SFRAME_LOOKUP
+	bool
+
+config ARCH_SUPPORTS_UNWIND_KERNEL_SFRAME
+	bool
+	help
+	  An architecture can select this if it enables the SFrame (Simple
+	  Frame) unwinder for unwinding kernel stack traces. It uses an unwind
+	  table that is directly generated by the toolchain based on DWARF CFI
+	  information.
+
+config HAVE_UNWIND_KERNEL_SFRAME
+	bool "Sframe unwinder"
+	depends on AS_SFRAME3
+	depends on 64BIT
+	depends on ARCH_SUPPORTS_UNWIND_KERNEL_SFRAME
+	select UNWIND_SFRAME_LOOKUP
+	help
+	  This option enables the SFrame (Simple Frame) unwinder for unwinding
+	  kernel stack traces. It uses an unwind table that is directly
+	  generated by the toolchain based on DWARF CFI information. In
+	  practice, this can provide more reliable stacktrace results than
+	  unwinding with frame pointers alone.
+
 config HAVE_PERF_REGS
 	bool
 	help
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index b5a51b0ef9440..041de63a659d1 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -87,6 +87,7 @@ config ARM64
 	select ARCH_SUPPORTS_SCHED_SMT
 	select ARCH_SUPPORTS_SCHED_CLUSTER
 	select ARCH_SUPPORTS_SCHED_MC
+	select ARCH_SUPPORTS_UNWIND_KERNEL_SFRAME
 	select ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
 	select ARCH_WANT_COMPAT_IPC_PARSE_VERSION if COMPAT
 	select ARCH_WANT_DEFAULT_BPF_JIT
diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 6b005c8fef706..ae1c23579ad2f 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -55,7 +55,7 @@ KBUILD_CFLAGS	+= $(call cc-option,-mabi=lp64)
 KBUILD_AFLAGS	+= $(call cc-option,-mabi=lp64)
 
 # Avoid generating .eh_frame* sections.
-ifneq ($(CONFIG_UNWIND_TABLES),y)
+ifeq ($(filter y, $(CONFIG_UNWIND_TABLES) $(CONFIG_HAVE_UNWIND_KERNEL_SFRAME)),)
 KBUILD_CFLAGS	+= -fno-asynchronous-unwind-tables -fno-unwind-tables
 KBUILD_AFLAGS	+= -fno-asynchronous-unwind-tables -fno-unwind-tables
 KBUILD_RUSTFLAGS += -Cforce-unwind-tables=n
diff --git a/arch/arm64/include/asm/module.lds.h b/arch/arm64/include/asm/module.lds.h
index 603f92a8a73ed..034cb635e8bcc 100644
--- a/arch/arm64/include/asm/module.lds.h
+++ b/arch/arm64/include/asm/module.lds.h
@@ -10,5 +10,7 @@ SECTIONS {
 	 * put it into the .init allocation.
 	 */
 	.init.eh_frame 0 : { *(.eh_frame) }
+#elif defined(CONFIG_HAVE_UNWIND_KERNEL_SFRAME)
+	/DISCARD/ : { *(.eh_frame) }
 #endif
 }
diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
index 7dec05dd33b70..c60ef921956fb 100644
--- a/arch/arm64/kernel/vdso/Makefile
+++ b/arch/arm64/kernel/vdso/Makefile
@@ -38,7 +38,7 @@ ccflags-y += -DDISABLE_BRANCH_PROFILING -DBUILD_VDSO
 CC_FLAGS_REMOVE_VDSO := $(CC_FLAGS_FTRACE) -Os $(CC_FLAGS_SCS) \
 			$(RANDSTRUCT_CFLAGS) $(KSTACK_ERASE_CFLAGS) \
 			$(GCC_PLUGINS_CFLAGS) \
-			$(CC_FLAGS_LTO) $(CC_FLAGS_CFI) \
+			$(CC_FLAGS_LTO) $(CC_FLAGS_CFI) $(CC_FLAGS_SFRAME) \
 			-Wmissing-prototypes -Wmissing-declarations
 
 CC_FLAGS_ADD_VDSO := -O2 -mcmodel=tiny -fasynchronous-unwind-tables
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index af1d720209764..eb1f54829503c 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -145,14 +145,25 @@ jiffies = jiffies_64;
 #endif
 
 #ifdef CONFIG_UNWIND_TABLES
+
 #define UNWIND_DATA_SECTIONS				\
 	.eh_frame : {					\
 		__pi___eh_frame_start = .;		\
 		*(.eh_frame)				\
 		__pi___eh_frame_end = .;		\
 	}
+#define SFRAME_DISCARDS
+
+#elif defined(CONFIG_HAVE_UNWIND_KERNEL_SFRAME)
+
+#define UNWIND_DATA_SECTIONS
+#define SFRAME_DISCARDS *(.eh_frame)
+
 #else
+
 #define UNWIND_DATA_SECTIONS
+#define SFRAME_DISCARDS
+
 #endif
 
 /*
@@ -184,6 +195,7 @@ SECTIONS
 		*(.interp .dynamic)
 		*(.dynsym .dynstr .hash .gnu.hash)
 		*(.ARM.attributes)
+		SFRAME_DISCARDS
 	}
 
 	. = KIMAGE_VADDR;
diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.h
index 0755bc39b0d80..336d27011a580 100644
--- a/include/asm-generic/sections.h
+++ b/include/asm-generic/sections.h
@@ -31,6 +31,7 @@
  *	__irqentry_text_start, __irqentry_text_end
  *	__softirqentry_text_start, __softirqentry_text_end
  *	__start_opd, __end_opd
+ *	__start_sframe, __end_sframe
  */
 extern char _text[], _stext[], _etext[];
 extern char _data[], _sdata[], _edata[];
@@ -53,6 +54,9 @@ extern char __ctors_start[], __ctors_end[];
 /* Start and end of .opd section - used for function descriptors. */
 extern char __start_opd[], __end_opd[];
 
+/* Start and end of .sframe section - used for stack unwinding. */
+extern char __start_sframe[], __end_sframe[];
+
 /* Start and end of instrumentation protected text section */
 extern char __noinstr_text_start[], __noinstr_text_end[];
 
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index b2988aa12f664..278f5764d990d 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -491,6 +491,8 @@
 		*(.rodata1)						\
 	}								\
 									\
+	SFRAME								\
+									\
 	/* PCI quirks */						\
 	.pci_fixup        : AT(ADDR(.pci_fixup) - LOAD_OFFSET) {	\
 		BOUNDED_SECTION_PRE_LABEL(.pci_fixup_early,  _pci_fixups_early,  __start, __end) \
@@ -912,6 +914,19 @@
 #define TRACEDATA
 #endif
 
+#ifdef CONFIG_HAVE_UNWIND_KERNEL_SFRAME
+#define SFRAME							\
+	/* sframe */						\
+	.sframe : AT(ADDR(.sframe) - LOAD_OFFSET) {		\
+		__start_sframe = .;			\
+		KEEP(*(.sframe))				\
+		KEEP(*(.init.sframe))				\
+		__end_sframe = .;			\
+	}
+#else
+#define SFRAME
+#endif
+
 #ifdef CONFIG_PRINTK_INDEX
 #define PRINTK_INDEX							\
 	.printk_index : AT(ADDR(.printk_index) - LOAD_OFFSET) {		\
-- 
2.55.0.1082.g2b9226bbc0-goog

