Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A3A48F828
	for <live-patching@vger.kernel.org>; Wed,  7 Oct 2026 11:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791373442; cv=none; b=HVSs2ZJHw02c8swuV2W74k9VMyl/uS3QUhdItWNw5hytG5Nd1FzntZvwRY0HQ8JueeIU8GkEQUzEW1jxOZuq0bOs0AJgbxmhEU4aZZKZ0Sydnu8VwfthtrEs71e6QKPfrUC9tAa3DPFZWtIejeuiCbloR8occG/yQzB9tIOWu0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791373442; c=relaxed/simple;
	bh=rZcO9leuAkIUTCKbPF7FZsWfsm1B9RBvpWkWDnREB8A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eSWp867Hcetmo7MLYgzEpCr/LJnB70aQ90Chjw931Dl0U6g+fOnpzScqge6rMtrhNnucx9PT8YTuFTzXex3laRvyULpgnOvK4mbEWptXZtCo2/LD9+CvRcBwYLbIuq5vODsn4LfaSFA1+CyFw3dnCoVnJmftwwe+eqItmEHkn0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dylanbhatch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dMPXuaF+; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dylanbhatch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dMPXuaF+"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2e2e7425601so19044065ad.0
        for <live-patching@vger.kernel.org>; Wed, 07 Oct 2026 04:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791373427; x=1791978227; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HbXOOT9nl+uysOcJBeZgbpa3FnxAvhWN1MIEa8mVsQA=;
        b=dMPXuaF+UoEPaXeeugWaG5/QJslm0spztP1OQGRcDxU3gg3uunOEN1868WzgUPP87g
         ZQFsm2sA6NXhhxboHm1FPWjombJhO5dZu6Y/fLLefX103kMzzsu1jZRpj3meuzzwaFEI
         z6OKVlIY9Y5V1mPL6IRum826UCtxQxeoIAPgu/eW8tvCMz3hxcJSXhqS6SD/BJ1risCH
         O9o407R8cHhnstKbXJZRrGc7juGnofGxdl8r0mLyc1rSVJ2ivtZNjUs936Zy/+qex3Wv
         AUzdE1Wz2O1fudfhQuucRIQT6wEH52oTASlYYQScmVU4KF3J5iHVTYE9gGZxI34pO81J
         BNhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791373427; x=1791978227;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HbXOOT9nl+uysOcJBeZgbpa3FnxAvhWN1MIEa8mVsQA=;
        b=vqVLr4TN6HIomDGXD6xfgYqqvZjCXExXOWxPWxyJZwxP/PZ9RcRZ0UDkDX1cpqsaoP
         8gYqHxnv44Ax+51MbMeaZuqW3EmOBti0noqrlIRv1JzMeVpLj5LFz3XpCHUW5h6+2Rt6
         mNoNTfsDC9AeVv3XeDumM2IlIESgtt5UVE2+ftUxpauAx/Obg09fI9tK77LpjF988oiy
         BaZc2oNFx2U1nquxo0S7l9uZ4OGYdV7SNiiff/u/UF4Et5YO00SvYe9GKKG+RFbgJ0q4
         U7DdOCXe8QGrWPtaxpJnXobVkUdE361CwaW1MT7RWxMgtKLhCpnJGV5ThAyOfqchmcb/
         Rnhg==
X-Forwarded-Encrypted: i=1; AKwUvBw2SOUzpE44Y5W3N2iWNYQ3Az2hNVXANul9raY42GKnWUx7hvJfSXYYusJemZ/Cfvqz7i+n7acXeFOojNQc@vger.kernel.org
X-Gm-Message-State: AFq9FYJYsmW37Pkew+PD2Z1pIuEN9A6BV/k9TWmlEM+2D16uocNlajiP
	fKAxrncAWhvjcWS6qUV9RMBvkfsaTuay+rFjmPnW949PER5rfHGfNSFUhHOKnwcJYLgBvGS/rs7
	FphOuoi26cHwVT/PDdM0JVMlwrw==
X-Received: from plbjb20.prod.google.com ([2002:a17:903:2594:b0:2e2:f517:75b])
 (user=dylanbhatch job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ced1:b0:2e2:c94f:25f7 with SMTP id d9443c01a7336-2e5c4f13ec9mr34857265ad.5.1791373426997;
 Wed, 07 Oct 2026 04:43:46 -0700 (PDT)
Date: Wed,  7 Oct 2026 11:43:25 +0000
In-Reply-To: <20261007114335.440322-1-dylanbhatch@google.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261007114335.440322-1-dylanbhatch@google.com>
X-Mailer: git-send-email 2.56.0.360.g66cac248cb-goog
Message-ID: <20261007114335.440322-2-dylanbhatch@google.com>
Subject: [PATCH v8 01/11] arm64, unwind: build kernel with sframe V3 info
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
index 65e8a4b5c90b1..36d7ee1f6ea5e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -28537,10 +28537,11 @@ F:	Documentation/driver-api/uio-howto.rst
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
index 7c855e6fe5448..5c2ca98a86786 100644
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
index cab741a695f52..b438d04044486 100644
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
index f6619e1cb2ce7..f6d1f59fb11c3 100644
--- a/arch/arm64/kernel/vdso/Makefile
+++ b/arch/arm64/kernel/vdso/Makefile
@@ -38,7 +38,7 @@ ccflags-y += -DDISABLE_BRANCH_PROFILING -DBUILD_VDSO
 CC_FLAGS_REMOVE_VDSO := $(CC_FLAGS_FTRACE) -Os $(CC_FLAGS_SCS) \
 			$(RANDSTRUCT_CFLAGS) $(KSTACK_ERASE_CFLAGS) \
 			$(GCC_PLUGINS_CFLAGS) \
-			$(CC_FLAGS_LTO) $(CC_FLAGS_CFI) \
+			$(CC_FLAGS_LTO) $(CC_FLAGS_CFI) $(CC_FLAGS_SFRAME) \
 			-Wmissing-prototypes -Wmissing-declarations
 
 CC_FLAGS_ADD_VDSO := -O2 -mcmodel=tiny -fasynchronous-unwind-tables $(CONFIG_CC_OPT_INLINE_MEMSET)
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
2.56.0.360.g66cac248cb-goog

