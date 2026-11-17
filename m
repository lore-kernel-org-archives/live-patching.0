Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794881215;
	b=TG/y6jmaHIYRNQWTP3XOF4c6csIfjX81wKBM5jWqrW7v8O7oQIUJ1EAeGlRHnSWQ6Qw5
	 wGrECKcdjVITFy5BjfYtXGnODU+WLK2W4j8gEhhHqEYMKsQzCIgW7EAZZzfFU4MAPMO7i
	 Spiexcmir048dokahvLi6F+dkF8XHrT+Am+uFAisHFyfqiCXZmV1cY6Snq65o6dMDVLJ3
	 B/KU6f5uqxa1arcwcoEt6FW7pZuP6nsxUaufzqYAgRI3AwRPJAsPiDr31ahLKy39JY3Nc
	 M0cGLOlVDKxRUIS6+tfomxI5Yfjoxgwuzt2sOGIOEWvNSg/cakNV5sEShx3i/sFBTZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794881215;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=JfGS+phkEPjk6ifHjVYaGIxggnfxqbL+S+LdZwlSBRs=;
	b=hTrgFG9w7zH0/ApOJEBj/f2PeD5ASA5F5RjO8C7d5C6P7SdowGJ04RB/3JZRIfKmxDzu
	 hf6czLFT1ZAORYcVG6lUn8C7LPYi0yWKdZg/7d7Aqq192EAnkeRa48RgLuDyWq876pgw3
	 /g0zSvZb7/tBAtL+VgAyzh8tOjbMaYZwJVJ8LWBfp9G3mUsuaoYF3/Q8C/t4sstgFBaKr
	 E3NbP7ojtltHCRSGU4MUric/wKPkinKV6rvZ0nS1/DZeDdamUtf5h3yapZbtZs/135nYk
	 bchPww3i8cOf9F4wN75h/VxPPy1tYVELh+vJP6YPsxdSHn7ZeCQ8t59Mcqvv6UxHjbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dylanbhatch.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=FPWNCseQ;
	arc=none smtp.remote-ip=209.85.214.198
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14136606A329
	for <live-patching@vger.kernel.org>; Tue, 17 Nov 2026 02:06:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14136606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dylanbhatch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=FPWNCseQ
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ea71803effso36847215ad.3
        for <live-patching@vger.kernel.org>; Mon, 16 Nov 2026 18:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794881214; x=1795486014; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JfGS+phkEPjk6ifHjVYaGIxggnfxqbL+S+LdZwlSBRs=;
        b=FPWNCseQH51rqjJkropyD/9qPt4PoPnjfhGYTdAb6mZvpLpKGYy7SdM0tr8Uv9GWUN
         dd5dwjaqsaeTLLcxKNGyP2k4vKyP3eLDLrmHBJC4gEevxNE4ey+BfLt+ywXVDcSYIA8R
         S4/E8n7ljXeexzAq4+VghOMRkcV/heNZI8xkfS6A/5aa2faHitA93LVL/6uT9m8HO4nB
         KStwoKueCp6h1SnoQPDl+hfU6E9LSXFpJuTDf/KHb5cpcbf4a4/Vup5l4jYyTDQsnkC9
         /0GYEgVws/JaYwjrnsq6qmIvVqreTqCfoHQ2gIWGwHDP63UdGxzCkofCTs4/CzNoxgjB
         7q1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794881214; x=1795486014;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JfGS+phkEPjk6ifHjVYaGIxggnfxqbL+S+LdZwlSBRs=;
        b=dB1d/qr6QedTo+k9HmdFTpn9pl6rrKwF8B0rNZVybU94tQPa0lYg1h5ibuTlY+8jxX
         9IdgFDZvLh6HwoAVlAnZBt5/wXdO2EA3957SAHOhyaRM+YfP0JA6w8c3/Q9OPSnCwk0D
         3MiKUuhleYNq+mHasscykuS/ilCVaXrPbc9JgkaPEBYE8ZGi+S495M5Xqspyp0JU2bvZ
         nRFTXbDACkn1Mh9AtoA5bUrxgNsjSTGtv6ZrhofKSwQJRBlCzlACS7ntZ70Xa7Qrw2/9
         UwYGt2raYzRig7vr86Nua6Uzo/z2B8c2PfbHv01jdoGrshi6s7yTt1VNr0PoITX2LCER
         l9sw==
X-Forwarded-Encrypted: i=1; AL+hErGyOF0SVmWJZGEp6RGuD28j+b0XdQUh5jUKz1gKahn5sTazGTcSHMg1nILF/MMTbzv5K1XFIlScHRx+DApM@vger.kernel.org
X-Gm-Message-State: APuU4Z8PhfFAAclARvgtiM+nSC5rcbi3IEi/m4QiLWHvvbrmz+JxD8g7
	OSY3LW/5OQ6QFhb7iZzz1yTsrhHxNjH4wGe+5LGmSHWAxhrs77ewd8y/ojOVDhCWEz4BM6jcnHW
	7mT7tY6p5A/MbDC/RQS2jB9LYuA==
X-Received: from plblg7.prod.google.com ([2002:a17:902:fb87:b0:2ef:d34f:e526])
 (user=dylanbhatch job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:22c9:b0:2e9:5ed2:c393 with SMTP id d9443c01a7336-2ee0dd9fb7amr107692525ad.60.1794881213519;
 Mon, 16 Nov 2026 18:06:53 -0800 (PST)
Date: Tue, 17 Nov 2026 02:06:38 +0000
In-Reply-To: <20261117020648.323464-1-dylanbhatch@google.com>
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261117020648.323464-1-dylanbhatch@google.com>
X-Mailer: git-send-email 2.56.0.679.gc527c65306-goog
Message-ID: <20261117020648.323464-2-dylanbhatch@google.com>
Subject: [PATCH v9 01/11] arm64, unwind: build kernel with sframe V3 info
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
	Herbert Xu <herbert@gondor.apana.org.au>, "David S . Miller" <davem@davemloft.net>
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

Changes since v8:
 - (conflict resolution) Resolve v7.4-rc1 merge conflict in Makefile
   around CFLAGS_GCOV moving to scripts/Makefile.gcov.
 - (sashiko) Add 'depends on !RUST' to HAVE_UNWIND_KERNEL_SFRAME and keep
   KBUILD_RUSTFLAGS conditioned only on CONFIG_UNWIND_TABLES.
 - (sashiko) Move STACK UNWINDING entry in MAINTAINERS to alphabetical
   order and defer unwind_sframe.h pattern to the patch introducing it.
 - (sashiko) Filter out $(CC_FLAGS_SFRAME) in efi/libstub, arm64 pi, and
   arm64 kvm/hyp/nvhe Makefiles where unwind tables are disabled.
---
 MAINTAINERS                           | 14 ++++++------
 Makefile                              |  8 +++++++
 arch/Kconfig                          | 32 +++++++++++++++++++++++++++
 arch/arm64/Kconfig                    |  1 +
 arch/arm64/Makefile                   |  8 +++++--
 arch/arm64/include/asm/module.lds.h   |  2 ++
 arch/arm64/kernel/pi/Makefile         |  3 +++
 arch/arm64/kernel/vdso/Makefile       |  2 +-
 arch/arm64/kernel/vmlinux.lds.S       | 12 ++++++++++
 arch/arm64/kvm/hyp/nvhe/Makefile      |  5 +++--
 drivers/firmware/efi/libstub/Makefile |  2 ++
 include/asm-generic/sections.h        |  4 ++++
 include/asm-generic/vmlinux.lds.h     | 15 +++++++++++++
 13 files changed, 96 insertions(+), 12 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 93abbb315065d..92e13caa85d07 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26639,6 +26639,13 @@ L:	stable@vger.kernel.org
 S:	Supported
 F:	Documentation/process/stable-kernel-rules.rst
 
+STACK UNWINDING
+M:	Josh Poimboeuf <jpoimboe@kernel.org>
+M:	Steven Rostedt <rostedt@goodmis.org>
+S:	Maintained
+F:	include/linux/unwind*.h
+F:	kernel/unwind/
+
 STAGING - ATOMISP DRIVER
 M:	Hans de Goede <hansg@kernel.org>
 M:	Mauro Carvalho Chehab <mchehab@kernel.org>
@@ -29242,13 +29249,6 @@ F:	Documentation/driver-api/uio-howto.rst
 F:	drivers/uio/
 F:	include/linux/uio_driver.h
 
-USERSPACE STACK UNWINDING
-M:	Josh Poimboeuf <jpoimboe@kernel.org>
-M:	Steven Rostedt <rostedt@goodmis.org>
-S:	Maintained
-F:	include/linux/unwind*.h
-F:	kernel/unwind/
-
 UTIL-LINUX PACKAGE
 M:	Karel Zak <kzak@redhat.com>
 L:	util-linux@vger.kernel.org
diff --git a/Makefile b/Makefile
index f895752d4b05f..b36245d6b20ea 100644
--- a/Makefile
+++ b/Makefile
@@ -1184,6 +1184,14 @@ endif
 # Ensure compilers do not transform certain loops into calls to wcslen()
 KBUILD_CFLAGS += -fno-builtin-wcslen
 
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
 CFLAGS_PREFIX_MAP := -fmacro-prefix-map=$(srcroot)/=
diff --git a/arch/Kconfig b/arch/Kconfig
index 1163736de1f99..d2fc68e7023db 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -507,6 +507,38 @@ config HAVE_UNWIND_USER_FP
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
+	depends on !RUST
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
index 1075bc6618330..cacd6d71122b0 100644
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
index ed28f94be428e..e99c80780071e 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -58,13 +58,17 @@ KBUILD_CFLAGS	+= $(call cc-option,-mabi=lp64)
 KBUILD_AFLAGS	+= $(call cc-option,-mabi=lp64)
 
 # Avoid generating .eh_frame* sections.
-ifneq ($(CONFIG_UNWIND_TABLES),y)
+ifeq ($(filter y, $(CONFIG_UNWIND_TABLES) $(CONFIG_HAVE_UNWIND_KERNEL_SFRAME)),)
 KBUILD_CFLAGS	+= -fno-asynchronous-unwind-tables -fno-unwind-tables
 KBUILD_AFLAGS	+= -fno-asynchronous-unwind-tables -fno-unwind-tables
-KBUILD_RUSTFLAGS += -Cforce-unwind-tables=n
 else
 KBUILD_CFLAGS	+= -fasynchronous-unwind-tables
 KBUILD_AFLAGS	+= -fasynchronous-unwind-tables
+endif
+
+ifneq ($(CONFIG_UNWIND_TABLES),y)
+KBUILD_RUSTFLAGS += -Cforce-unwind-tables=n
+else
 KBUILD_RUSTFLAGS += -Cforce-unwind-tables=y -Zuse-sync-unwind=n
 # Work around rustc bug on compilers without
 # https://github.com/rust-lang/rust/pull/156973.
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
diff --git a/arch/arm64/kernel/pi/Makefile b/arch/arm64/kernel/pi/Makefile
index a273ab5af805c..1f1b1a59db0bf 100644
--- a/arch/arm64/kernel/pi/Makefile
+++ b/arch/arm64/kernel/pi/Makefile
@@ -18,6 +18,9 @@ CFLAGS_map_range.o += -mstrict-align
 KBUILD_CFLAGS	:= $(filter-out $(CC_FLAGS_SCS), $(KBUILD_CFLAGS))
 # disable LTO
 KBUILD_CFLAGS	:= $(filter-out $(CC_FLAGS_LTO), $(KBUILD_CFLAGS))
+# disable SFrame
+KBUILD_CFLAGS	:= $(filter-out $(CC_FLAGS_SFRAME), $(KBUILD_CFLAGS))
+KBUILD_AFLAGS	:= $(filter-out $(CC_FLAGS_SFRAME), $(KBUILD_AFLAGS))
 
 hostprogs	:= relacheck
 
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
index 1869b44ae1909..3cfa62249d0b4 100644
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
diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
index 56a7e2c05f73a..656bdbd59dd56 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -97,9 +97,10 @@ quiet_cmd_hyprel = HYPREL  $@
 quiet_cmd_hypcopy = HYPCOPY $@
       cmd_hypcopy = $(OBJCOPY) --prefix-symbols=__kvm_nvhe_ $< $@
 
-# Remove ftrace and Shadow Call Stack CFLAGS.
+# Remove ftrace, Shadow Call Stack, and SFrame flags.
 # This is equivalent to the 'notrace' and '__noscs' annotations.
-KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS), $(KBUILD_CFLAGS))
+KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS) $(CC_FLAGS_SFRAME), $(KBUILD_CFLAGS))
+KBUILD_AFLAGS := $(filter-out $(CC_FLAGS_SFRAME), $(KBUILD_AFLAGS))
 # Starting from 13.0.0 llvm emits SHT_REL section '.llvm.call-graph-profile'
 # when profile optimization is applied. gen-hyprel does not support SHT_REL and
 # causes a build failure. Remove profile optimization flags.
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index bbab12b8eb4b2..a5cf7b0841dd2 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -57,6 +57,8 @@ KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_SCS), $(KBUILD_CFLAGS))
 KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_CFI), $(KBUILD_CFLAGS))
 # disable LTO
 KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_LTO), $(KBUILD_CFLAGS))
+# disable SFrame
+KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_SFRAME), $(KBUILD_CFLAGS))
 
 # The .data section would be renamed to .data.efistub, therefore, remove
 # `-fdata-sections` flag from KBUILD_CFLAGS_KERNEL
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
index 3eb732942d699..4294554bd9b14 100644
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
@@ -943,6 +945,19 @@
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
2.56.0.679.gc527c65306-goog

