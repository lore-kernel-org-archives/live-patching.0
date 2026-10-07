Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610773890E3
	for <live-patching@vger.kernel.org>; Wed,  7 Oct 2026 11:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791373444; cv=none; b=KcvPpnjtRltAX5ElfIVuNys1KLytW6G0BZHtW4bR8ggzKau21e8PIZVv1D9KcW16doxEMlVxlStaBsZ6XhJnl34SlsWr+WtHr+Gq/9KImzREkgIm3CUJzudR4LgKfEgnw6RIoyR6iDjHyotpUyprD8/lQkGI3Ot/c0S7qRjQVRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791373444; c=relaxed/simple;
	bh=EPeeFDfr4o2AentVgVv0xy5a8aIPixkVtOhapcuhFVo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FPJ9vJ6u/c6JCgPS30VWEtwITD6lWQc2vuHjcvf09UHqyA19KrmaHziid/O6lg098PM/VNvHnBJG2sHSo5wlHk1CrS8qvm2AtL1yA257w9fJyve9qkWAUUYhmYgvDc9/0aPyfMkMLD8o80DpE9OJ55hY8n2MUviXE9ocbkArZMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dylanbhatch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ktkqrJ4X; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dylanbhatch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ktkqrJ4X"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8883dcc671eso2975116b3a.0
        for <live-patching@vger.kernel.org>; Wed, 07 Oct 2026 04:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791373429; x=1791978229; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SK2vB3bamyZR/EztfyKDwVCAIo9m6zAn5sAJ8nDYq84=;
        b=ktkqrJ4XNP7G55KTJhNHaBKtmBOxMNCjdgAdn74GA5xtH8ERTqrYAoEvn8e69g0ZzF
         MTOo42Pv9pfeCzBp+A6LZtBC7gQVWVaAmFqWmk8N90m+1IvV/xkyzMvX+llixIvzbV3s
         CMUNuuZQD3h6EiXabONoEX6mXk4Z2Rqj3TuoV+xbzQNLNNVK90Lat903BqQlNxAAHx0S
         1qGC+gI/kTTQ8pmVAshkT3+EFWLDdCASf3cpKN2o1CeSy2ulz0BFFOXiCZbUFS85fA2A
         eS1bVppvPGv484Y4PmF+tva7t9I5bBYKq/2AsSn3Rtv0aW1M7Y2CqGLvry8UdPm5j6g5
         vNwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791373429; x=1791978229;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SK2vB3bamyZR/EztfyKDwVCAIo9m6zAn5sAJ8nDYq84=;
        b=WBKrVy/cc7qb97z1tzI/QGQ7TkGKaqijo5PPW62zU0syLUuvt3k2CBuE/YN6bK1LnC
         CFUuKWlapVDRbyshAq/Nxc66r7CHhH+TIwPG5+QlP1eILjhwWLQq1yAk1WNHP5gaM783
         Ge6vvVzoIE6xTIs7yZE6PERgJEHKMoNCme+qOJgs1jwchDiylSA1Tmp+UauhU3y+GFzI
         SuyCha6JpU231fbsqktoRB31YJXsn4AZV1tfWalzzxcFzjAlss99Z6WOu9tcHHCXnLru
         tEBdQvbZp/iwxrCfSPTt9AmbHNx7FIHmEceQw1ddTmzn++0ySfKQhh9cgh2QkQDvL6Ve
         fDzg==
X-Forwarded-Encrypted: i=1; AKwUvBwTTdAsPvXFVXQCEMDW3EKw0Ohpimx57ZLwxCxoSTxboVR3CHMMAR5CQ7kTKF6A6TdtG6X5NImLeSZfBOod@vger.kernel.org
X-Gm-Message-State: AFuF++mlHsIKdv9EvegBg+uxNz34A5OMsLiV0MIkA4uQmeotowWSNL3D
	ReVn++6+qaIJxRY78iRd1vr311OXFowrjNINHjQIWgVyPKu3Csthq/mdemiu88b6E5dl+SZcNsy
	lDNw1cgUw5EGd+OnYmI1SQMjOgw==
X-Received: from pfei1.prod.google.com ([2002:a05:6a00:c041:b0:888:2e48:6a84])
 (user=dylanbhatch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:3418:b0:3e0:c5f5:6266 with SMTP id adf61e73a8af0-3e134121856mr1644659637.59.1791373429053;
 Wed, 07 Oct 2026 04:43:49 -0700 (PDT)
Date: Wed,  7 Oct 2026 11:43:26 +0000
In-Reply-To: <20261007114335.440322-1-dylanbhatch@google.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261007114335.440322-1-dylanbhatch@google.com>
X-Mailer: git-send-email 2.56.0.360.g66cac248cb-goog
Message-ID: <20261007114335.440322-3-dylanbhatch@google.com>
Subject: [PATCH v8 02/11] arm64/sframe: Read vmlinux .sframe header
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

Changes since v7:
 - (shashiko) remove KCOV, KCSAN, and KASAN instrumentation from
   sframe.o (copying over ORC's shoulder).
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
index 36d7ee1f6ea5e..d2b62b26f5e94 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -28542,6 +28542,7 @@ M:	Josh Poimboeuf <jpoimboe@kernel.org>
 M:	Steven Rostedt <rostedt@goodmis.org>
 S:	Maintained
 F:	arch/*/include/asm/unwind_sframe.h
+F:	include/linux/sframe.h
 F:	include/linux/unwind*.h
 F:	kernel/unwind/
 
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 29c6100f0c50b..84983df605ed5 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -32,6 +32,7 @@
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
index 0000000000000..d43a3b2367fca
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
+	unsigned long header_end, fdes_start, fdes_end, fres_start, fres_end;
+	struct sframe_header *shdr;
+	unsigned int num_fdes;
+
+	header_end = sec->sframe_start + sizeof(struct sframe_header);
+	if (header_end >= sec->sframe_end) {
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
+	num_fdes   = shdr->num_fdes;
+	fdes_start = header_end + shdr->fdes_off;
+	fdes_end   = fdes_start + (num_fdes * sizeof(struct sframe_fde_v3));
+
+	fres_start = header_end + shdr->fres_off;
+	fres_end   = fres_start + shdr->fre_len;
+
+	if (fres_start < fdes_end || fres_end > sec->sframe_end || fres_end < sec->sframe_start) {
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
2.56.0.360.g66cac248cb-goog

