Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794881218;
	b=dVcOO9wC99geHrtO+qsQaKfpYe+edDWsjKaeFgWiS/YUr1Eau4wGi1G1uJ2j77xLtmdr
	 kxckni/A+dgJXRws5RH04UTkEaimljZ9+jAnCQpjzfv3Vz3x7DDANudViciBISg1wdKBn
	 AvTuhL7pSPo9cCTLY2v67CRklWwOQ10Epb31e+XmL2zOdb+rh7f6uSIYmUIStXjIoXuVM
	 v1ZWaXKjGcijAGEDGU857Cj/WXi3esd44foedipWThEnsbWfnM3LGXSpw4ulVv7Dy0x2t
	 QVbkC7Dt7cR+bED+CcDNianfYe7S0ipKZ4zZdC9lZeZ3LTZE9L9zJyHjVxhM2v3p6gQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794881218;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=2wsQrrlhB0v7sTQLhfx5fhENxJu9/JJiYMMkbrhfnx8=;
	b=3VenPtYQEkq3lr53z67skRwQJVl51lWM7ye5jwm1GxeiBJQF3Y69cLzqWXeGEozPbEgW
	 EpupGIjfavbKmEpFPIbhN5lm3PjH5u4NxHpInKpUBvsUE/K1dlJ47Oay5jYxQiMl1XvBA
	 hLWmAcBwvaxE8mCwPnUrySWmfyIKIQrny13pS+EvkHiAPHB/2WvcPv8SY1qVxwPjhKTrP
	 9esFHZ98aG7Vqf3cH97KZ3FCHtlIfkp3ccIwlJcWphAUAMPXV5uXwrFsuQXHicZMsN1ZL
	 aznzoKKIG7wMluRLffZDFFdB6kEzIl8p/90XcFsKr+uC3a8tqiB2qPnlYYmOyf7amtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dylanbhatch.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=e3HNNm+F;
	arc=none smtp.remote-ip=209.85.215.199
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3026606A329
	for <live-patching@vger.kernel.org>; Tue, 17 Nov 2026 02:06:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3026606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dylanbhatch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=e3HNNm+F
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cd5ca3840c5so1821865a12.2
        for <live-patching@vger.kernel.org>; Mon, 16 Nov 2026 18:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794881216; x=1795486016; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2wsQrrlhB0v7sTQLhfx5fhENxJu9/JJiYMMkbrhfnx8=;
        b=e3HNNm+Fth6ejwfb9Q62xs0SxI7y7ovPc8e+vaDJACOiBROb6IJ9oioolv0MH/wQnD
         9SOTJ+KIwlZw325kYG8outeVFS7qWh/DXFC/nhfMIIqIRGcf0jrNV3NJX8eECJj5oDQN
         vXYi1DxSjbUcp3PLiOfp9AklwrYiac6LNwdiuQfnhjdz9pMd4R2c+zL7fECGjebjE9UG
         cMj/XOIjOAg2bprem5v7Us3Z4VfgXOS2t2jRxxcixX1rkSs6r7Gz2b31a7NxVh4iCGE6
         JbjJoEChh4byHQlaWFSD8jEPP20ucL5IRAE8VYM7Jf1JKVNER2IobfziS+ZHGGtwS7gd
         efxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794881216; x=1795486016;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2wsQrrlhB0v7sTQLhfx5fhENxJu9/JJiYMMkbrhfnx8=;
        b=EOmmLTSp+j/G4O/t1J8ZeGCUMvkt0oYbA3mBGjSLAn4hyNFNZ5srgCKzByxqmZEEC/
         BLZVcSYLFPztwePH6rJRdLVUnKtMcUVKfR4Y/mWAnXm3VmWXzS+Xllh8d+2OwADqwDjJ
         BMQRF2jkkK54ZgSpquZMW48BBPBBBR59OhF4BATF9GcRC8xG+GyVhI5T3nV3MjVpTt4f
         /SvLHvxQgIWqwyg/PXqDGKDR0EynteTSmeyvpG9gmoC9nwHG1cnTpfMJApO3usDbixm8
         lEmcukiWR+XVAE8k72pcyeCYK1lWfjTPiQkHkquysTKbaGKbmE3gKo85zOyHYeU99tVA
         vrgA==
X-Forwarded-Encrypted: i=1; AL+hErFlvocHPq6k3txEzTKonsWWFUPPAghqkYtE1NgeHhGfb+oCBXDPUHQBg/3oaUVFdfdRewKjdyvnyMObKIIO@vger.kernel.org
X-Gm-Message-State: APuU4Z+gbdGuYSQD8sZ2iv10+xbrqS8QtWi5UiIwyecNLcwDghwRcAxl
	8PlJYKZB+hGGwi5RxKOwfy+wbp7FP03Z373rjYrfwXVV6iG5UGu+Lth1655+CfiSDrJVQxjaYd5
	sbplz2u3THu6kSvKNZMSATdq3xw==
X-Received: from pjor10.prod.google.com ([2002:a17:90a:940a:b0:3b0:944b:61fe])
 (user=dylanbhatch job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1c07:b0:3a4:ad5c:d48a with SMTP id 98e67ed59e1d1-3b1b0dd0b7emr11996032a91.67.1794881215620;
 Mon, 16 Nov 2026 18:06:55 -0800 (PST)
Date: Tue, 17 Nov 2026 02:06:39 +0000
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
Message-ID: <20261117020648.323464-3-dylanbhatch@google.com>
Subject: [PATCH v9 02/11] arm64/sframe: Read vmlinux .sframe header
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

From: Josh Poimboeuf <jpoimboe@kernel.org>

In preparation for unwinding kernel space stacks with sframe, add basic
sframe compile infrastructure and support for reading the .sframe
section header. Add init_sframe_table() to read the vmlinux .sframe
header at boot.

[ Jens Remus: Add support for SFrame V3.  Add support for PC-relative
FDE function start offset.  Cleanup includes and indentation. ]

[ Dylan Hatch: Repurpose patch for arm64 vmlinux. ]

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Reviewed-by: Indu Bhagat <ibhagatgnu@gmail.com>
Co-developed-by: Jens Remus <jremus@linux.ibm.com>
Signed-off-by: Jens Remus <jremus@linux.ibm.com>
Co-developed-by: Dylan Hatch <dylanbhatch@google.com>
Signed-off-by: Dylan Hatch <dylanbhatch@google.com>

---

Changes since v8:
 - (sashiko) Use check_add_overflow() and check_mul_overflow() in
   sframe_read_header() to prevent integer overflow on section bounds.
---
 MAINTAINERS               |  1 +
 arch/arm64/kernel/setup.c |  2 +
 include/linux/sframe.h    | 32 ++++++++++++++++
 kernel/unwind/Makefile    |  9 ++++-
 kernel/unwind/sframe.c    | 80 +++++++++++++++++++++++++++++++++++++++
 kernel/unwind/sframe.h    | 78 ++++++++++++++++++++++++++++++++++++++
 6 files changed, 201 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/sframe.h
 create mode 100644 kernel/unwind/sframe.c
 create mode 100644 kernel/unwind/sframe.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 92e13caa85d07..16e7ab1aea164 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26643,6 +26643,7 @@ STACK UNWINDING
 M:	Josh Poimboeuf <jpoimboe@kernel.org>
 M:	Steven Rostedt <rostedt@goodmis.org>
 S:	Maintained
+F:	include/linux/sframe.h
 F:	include/linux/unwind*.h
 F:	kernel/unwind/
 
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index a707deba6ae70..0e460c020e361 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -33,6 +33,7 @@
 #include <linux/sched/task.h>
 #include <linux/scs.h>
 #include <linux/mm.h>
+#include <linux/sframe.h>
 
 #include <asm/acpi.h>
 #include <asm/fixmap.h>
@@ -373,6 +374,7 @@ void __init __no_sanitize_address setup_arch(char **cmdline_p)
 			"This indicates a broken bootloader or old kernel\n",
 			boot_args[1], boot_args[2], boot_args[3]);
 	}
+	init_sframe_table();
 }
 
 static inline bool cpu_can_disable(unsigned int cpu)
diff --git a/include/linux/sframe.h b/include/linux/sframe.h
new file mode 100644
index 0000000000000..54e5cb76cb92c
--- /dev/null
+++ b/include/linux/sframe.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_SFRAME_H
+#define _LINUX_SFRAME_H
+
+#include <linux/init.h>
+
+#ifdef CONFIG_UNWIND_SFRAME_LOOKUP
+
+struct sframe_section {
+	unsigned long	sframe_start;
+	unsigned long	sframe_end;
+
+	unsigned long	fdes_start;
+	unsigned long	fres_start;
+	unsigned long	fres_end;
+	unsigned int	num_fdes;
+
+	signed char	ra_off;
+	signed char	fp_off;
+};
+
+extern struct sframe_section kernel_sfsec __ro_after_init;
+
+void __init init_sframe_table(void);
+
+#else /* !CONFIG_UNWIND_SFRAME_LOOKUP */
+
+static inline void __init init_sframe_table(void) {}
+
+#endif /* CONFIG_UNWIND_SFRAME_LOOKUP */
+
+#endif /* _LINUX_SFRAME_H */
diff --git a/kernel/unwind/Makefile b/kernel/unwind/Makefile
index eae37bea54fdb..c5d953e48fe82 100644
--- a/kernel/unwind/Makefile
+++ b/kernel/unwind/Makefile
@@ -1 +1,8 @@
- obj-$(CONFIG_UNWIND_USER)	+= user.o deferred.o
+ obj-$(CONFIG_UNWIND_USER)		+= user.o deferred.o
+
+ KCOV_INSTRUMENT_sframe.o	:= n
+ KASAN_SANITIZE_sframe.o	:= n
+ KCSAN_SANITIZE_sframe.o	:= n
+
+ CFLAGS_REMOVE_sframe.o = $(CC_FLAGS_FTRACE)
+ obj-$(CONFIG_UNWIND_SFRAME_LOOKUP)	+= sframe.o
diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
new file mode 100644
index 0000000000000..10f979cd1af40
--- /dev/null
+++ b/kernel/unwind/sframe.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Kernel sframe access functions
+ */
+
+#define pr_fmt(fmt)	"sframe: " fmt
+
+#include <linux/mm.h>
+#include <linux/overflow.h>
+#include <linux/string_helpers.h>
+#include <linux/sframe.h>
+#include <asm/sections.h>
+
+#include "sframe.h"
+
+static bool sframe_init __ro_after_init;
+struct sframe_section kernel_sfsec __ro_after_init;
+
+static int sframe_read_header(struct sframe_section *sec)
+{
+	unsigned long header_end, fdes_start, fdes_end, fdes_size, fres_start, fres_end;
+	struct sframe_header *shdr;
+	unsigned int num_fdes;
+
+	if (check_add_overflow(sec->sframe_start, sizeof(struct sframe_header), &header_end) ||
+	    header_end >= sec->sframe_end) {
+		pr_debug("header struct doesn't fit in section\n");
+		return -EINVAL;
+	}
+
+	shdr = (struct sframe_header *)sec->sframe_start;
+
+	if (shdr->preamble.magic != SFRAME_MAGIC ||
+	    shdr->preamble.version != SFRAME_VERSION_3 ||
+	    !(shdr->preamble.flags & SFRAME_F_FDE_SORTED) ||
+	    !(shdr->preamble.flags & SFRAME_F_FDE_FUNC_START_PCREL) ||
+	    shdr->auxhdr_len) {
+		pr_debug("bad/unsupported sframe header\n");
+		return -EINVAL;
+	}
+
+	if (!shdr->num_fdes || !shdr->num_fres) {
+		pr_debug("no fde/fre entries\n");
+		return -EINVAL;
+	}
+
+	num_fdes = shdr->num_fdes;
+	if (check_mul_overflow(num_fdes, sizeof(struct sframe_fde_v3), &fdes_size) ||
+	    check_add_overflow(header_end, shdr->fdes_off, &fdes_start) ||
+	    check_add_overflow(fdes_start, fdes_size, &fdes_end) ||
+	    check_add_overflow(header_end, shdr->fres_off, &fres_start) ||
+	    check_add_overflow(fres_start, shdr->fre_len, &fres_end) ||
+	    fres_start < fdes_end || fres_end > sec->sframe_end) {
+		pr_debug("inconsistent fde/fre offsets\n");
+		return -EINVAL;
+	}
+
+	sec->num_fdes		= num_fdes;
+	sec->fdes_start		= fdes_start;
+	sec->fres_start		= fres_start;
+	sec->fres_end		= fres_end;
+
+	sec->ra_off		= shdr->cfa_fixed_ra_offset;
+	sec->fp_off		= shdr->cfa_fixed_fp_offset;
+
+	return 0;
+}
+
+void __init init_sframe_table(void)
+{
+	kernel_sfsec.sframe_start	= (unsigned long)__start_sframe;
+	kernel_sfsec.sframe_end		= (unsigned long)__end_sframe;
+
+	if (sframe_read_header(&kernel_sfsec)) {
+		pr_warn("invalid vmlinux SFrame header\n");
+		return;
+	}
+
+	sframe_init = true;
+}
diff --git a/kernel/unwind/sframe.h b/kernel/unwind/sframe.h
new file mode 100644
index 0000000000000..bf895107c2070
--- /dev/null
+++ b/kernel/unwind/sframe.h
@@ -0,0 +1,78 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * From https://www.sourceware.org/binutils/docs/sframe-spec.html
+ */
+#ifndef _SFRAME_H
+#define _SFRAME_H
+
+#include <linux/types.h>
+
+#define SFRAME_VERSION_1			1
+#define SFRAME_VERSION_2			2
+#define SFRAME_VERSION_3			3
+#define SFRAME_MAGIC				0xdee2
+
+#define SFRAME_F_FDE_SORTED			0x1
+#define SFRAME_F_FRAME_POINTER			0x2
+#define SFRAME_F_FDE_FUNC_START_PCREL		0x4
+
+#define SFRAME_ABI_AARCH64_ENDIAN_BIG		1
+#define SFRAME_ABI_AARCH64_ENDIAN_LITTLE	2
+#define SFRAME_ABI_AMD64_ENDIAN_LITTLE		3
+
+struct sframe_preamble {
+	u16	magic;
+	u8	version;
+	u8	flags;
+} __packed;
+
+struct sframe_header {
+	struct sframe_preamble preamble;
+	u8	abi_arch;
+	s8	cfa_fixed_fp_offset;
+	s8	cfa_fixed_ra_offset;
+	u8	auxhdr_len;
+	u32	num_fdes;
+	u32	num_fres;
+	u32	fre_len;
+	u32	fdes_off;
+	u32	fres_off;
+} __packed;
+
+struct sframe_fde_v3 {
+	s64	func_start_off;
+	u32	func_size;
+	u32	fres_off;
+} __packed;
+
+struct sframe_fda_v3 {
+	u16	fres_num;
+	u8	info;
+	u8	info2;
+	u8	rep_size;
+} __packed;
+
+#define SFRAME_FDE_PCTYPE_INC			0
+#define SFRAME_FDE_PCTYPE_MASK			1
+
+#define SFRAME_AARCH64_PAUTH_KEY_A		0
+#define SFRAME_AARCH64_PAUTH_KEY_B		1
+
+#define SFRAME_V3_FDE_FRE_TYPE(info)		((info) & 0xf)
+#define SFRAME_V3_FDE_PCTYPE(info)		(((info) >> 4) & 0x1)
+#define SFRAME_V3_AARCH64_FDE_PAUTH_KEY(info)	(((info) >> 5) & 0x1)
+
+#define SFRAME_FDE_TYPE_DEFAULT			0
+
+#define SFRAME_V3_FDE_TYPE_MASK			0x1f
+#define SFRAME_V3_FDE_TYPE(info2)		((info2) & SFRAME_V3_FDE_TYPE_MASK)
+
+#define SFRAME_BASE_REG_FP			0
+#define SFRAME_BASE_REG_SP			1
+
+#define SFRAME_V3_FRE_CFA_BASE_REG_ID(info)		((info) & 0x1)
+#define SFRAME_V3_FRE_DATAWORD_COUNT(info)		(((info) >> 1) & 0xf)
+#define SFRAME_V3_FRE_DATAWORD_SIZE(info)		(((info) >> 5) & 0x3)
+#define SFRAME_V3_AARCH64_FRE_MANGLED_RA_P(info)	(((info) >> 7) & 0x1)
+
+#endif /* _SFRAME_H */
-- 
2.56.0.679.gc527c65306-goog

