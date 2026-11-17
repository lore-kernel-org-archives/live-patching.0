Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794881224;
	b=UfKASEhkP5UGaN6nb3lIgedHI4BRAdka0rNH364HlCVftcWLYZCzTNY9YnA4zSW9zMzW
	 f15Lgq5nPb3jMjgDgwT1Ravn7+/r8gkiKMh9nDhwPysO7hbzPE7cQmColLa3wTkJO85wd
	 wUaiTk6aLE6Tg5ScnC+8OKD02AHkjZvXfqPFq6GDmdz7zuA5SgPtmPsbldo3Nexmu/vmR
	 F5vMjr6NtrIy1jL0D4ZMZ8k0gAM6iCrqRZ3PI8pTuUcsg0Zj9+opyyovSlpVRbRTG6etP
	 j+mqWVqIcWdNRO7cnEaXz2ufVaWUbJbg2EmRimAclSy41wvVh0dVTRjAWv6B+UdZdEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794881224;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=KHqN+mR+uG5QpfV5UPkyJt+kNZKbMTcKRifAgMfeoZA=;
	b=Q2YT/nX+f8j98fFmBLmn/D6a6slQLivTuI5QPLmBsIXJhxb+jZkF74xn+UFihhtcDmQ4
	 U+AsFG6WBA4kS+tx2gz946BsRe4ji414M6lRngf4+FL4lvHGgpZCzfvpxGLR9PtmpSNHa
	 Ol/LNZRqAkCnemqZBZuVq/F83tfJ30VU3iGbaeflTY72sDAbpYJDuoF5enqomcCBq9QOT
	 nCbxFufOEDnLNcABD+eVfOEjAMT3wSVSj9QZxAQwdIdC9ck0aMfyRBeHmZiKDUJDkhTs2
	 HXjCpGkljVl7evlj9p71lj6aT63Re7Y3c16+Vppzv35MeUO4mLLvrNmlBgAmlXeejrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dylanbhatch.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=N6LkZ8AL;
	arc=none smtp.remote-ip=209.85.214.200
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511C7606A886
	for <live-patching@vger.kernel.org>; Tue, 17 Nov 2026 02:07:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 511C7606A886
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dylanbhatch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=N6LkZ8AL
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ed276af91dso63570885ad.3
        for <live-patching@vger.kernel.org>; Mon, 16 Nov 2026 18:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794881224; x=1795486024; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KHqN+mR+uG5QpfV5UPkyJt+kNZKbMTcKRifAgMfeoZA=;
        b=N6LkZ8ALt9kSDVqUkP38mAQiwV6aOsj7BKtCf8sgSPXs8j/LmnW65lpjo09iLIcLSf
         2WDFz7Q7sZ9EwyeKh690g/XicCoBn5FRmsZdAWGiJOIrgerNcBFeJmS7VlBvayYyyrX0
         8CPAsxtbGQo4nHF2qybZTmTR2uIW8QoXSS9+ZB74cg5SHd4vnigzKKjZZNlGU1zRZNnE
         fmhS3g08YAEmfr1jCTznLMBwA9hWaV0F6egO/2eY/o8nG89X1/0MN79LwkUHNstSK/7h
         nydY87AtEpVFiupAnrX8BCcCPVodNsc0Yp/0vOHWlO4ffvp24IJXszUT5JqR1XZYlA1m
         eM7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794881224; x=1795486024;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KHqN+mR+uG5QpfV5UPkyJt+kNZKbMTcKRifAgMfeoZA=;
        b=l93+OysevZltYT1+RnEtVgANG2zA/lFh5E1ukg6WY+0TEqrGgu4/7Y+XI2HGwVs6Q+
         y09QeCPZZEwzjnoZ7RM9r0Fn0iy7F3TO4uh202d2efaoo55CD7j0FvwR98aR28ghaOgV
         x1utLRc0JnYZzrKOksBl4di73lUXXBSqC7RD1pNbUvyucSaM/HfBmD2sqyPKA5zwW6bp
         qq7Aztl2kuNgrs4Yo1byLT2I15l3bFUGG2b/HvnEOHahfk7eOZootWil84CpXCR5ys5l
         Rp89FOSPgTr9xBWJQwGXFNbdgf4bBHqDQBzPALW/fT7vN7Hk4TLf5Px+hnCMRyNArG3x
         GNZw==
X-Forwarded-Encrypted: i=1; AL+hErH/DCdcKhhchvIZyOkuruxKO9TNd2Nq21Pxn2CBKNjSdecwOiUFbPpVeMlVgeiFszm7N3DGkZr3Trbiaj6K@vger.kernel.org
X-Gm-Message-State: APuU4Z+/688BmOEuDiWUnwZbu8SyeoH7RwBsekGSnIddcZK2YkcEK4f0
	SNvd4cfQjvmEDdwRBfbNRqGWc2NNUTcLKb9KjLKP84gJz3xa3dXL20jDX/k6VIjC8/vonoWYN0L
	a25V3K+VaUh1gxgOpPnOuY3hiuw==
X-Received: from plse6.prod.google.com ([2002:a17:902:b786:b0:2ef:d8b5:15f5])
 (user=dylanbhatch job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e88d:b0:2ed:99b9:7fd8 with SMTP id d9443c01a7336-2ee0dad0713mr139046645ad.30.1794881223257;
 Mon, 16 Nov 2026 18:07:03 -0800 (PST)
Date: Tue, 17 Nov 2026 02:06:44 +0000
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
Message-ID: <20261117020648.323464-8-dylanbhatch@google.com>
Subject: [PATCH v9 07/11] sframe: Add debug helpers with object name
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

Include the object name for kernel .sframe sections, indicated with the
format "(<module-name>)" or "(vmlinux)".

Suggested-by: Jens Remus <jremus@linux.ibm.com>
Reviewed-by: Jens Remus <jremus@linux.ibm.com>
Signed-off-by: Dylan Hatch <dylanbhatch@google.com>

---

Changes since v8:
 - (sashiko) Include <linux/container_of.h>, <linux/module.h>,
   <linux/printk.h>, and <linux/stddef.h> in sframe_debug.h.
---
 kernel/unwind/sframe.c       | 11 +++++++----
 kernel/unwind/sframe_debug.h | 38 ++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 4 deletions(-)
 create mode 100644 kernel/unwind/sframe_debug.h

diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
index d5c1c8148dadd..4d804f2ad9dde 100644
--- a/kernel/unwind/sframe.c
+++ b/kernel/unwind/sframe.c
@@ -19,6 +19,7 @@
 #include <asm/unwind_sframe.h>
 
 #include "sframe.h"
+#include "sframe_debug.h"
 
 static bool sframe_init __ro_after_init;
 struct sframe_section kernel_sfsec __ro_after_init;
@@ -516,7 +517,7 @@ static int sframe_read_header(struct sframe_section *sec)
 
 	if (check_add_overflow(sec->sframe_start, sizeof(struct sframe_header), &header_end) ||
 	    header_end >= sec->sframe_end) {
-		pr_debug("header struct doesn't fit in section\n");
+		dbg_sec(sec, "header struct doesn't fit in section\n");
 		return -EINVAL;
 	}
 
@@ -526,12 +527,12 @@ static int sframe_read_header(struct sframe_section *sec)
 	    shdr->preamble.version != SFRAME_VERSION_3 ||
 	    !(shdr->preamble.flags & SFRAME_F_FDE_FUNC_START_PCREL) ||
 	    shdr->auxhdr_len) {
-		pr_debug("bad/unsupported sframe header\n");
+		dbg_sec(sec, "bad/unsupported sframe header\n");
 		return -EINVAL;
 	}
 
 	if (!shdr->num_fdes || !shdr->num_fres) {
-		pr_debug("no fde/fre entries\n");
+		dbg_sec(sec, "no fde/fre entries\n");
 		return -EINVAL;
 	}
 
@@ -542,7 +543,7 @@ static int sframe_read_header(struct sframe_section *sec)
 	    check_add_overflow(header_end, shdr->fres_off, &fres_start) ||
 	    check_add_overflow(fres_start, shdr->fre_len, &fres_end) ||
 	    fres_start < fdes_end || fres_end > sec->sframe_end) {
-		pr_debug("inconsistent fde/fre offsets\n");
+		dbg_sec(sec, "inconsistent fde/fre offsets\n");
 		return -EINVAL;
 	}
 
@@ -569,6 +570,7 @@ void __init init_sframe_table(void)
 	}
 
 	sframe_init = true;
+	dbg_print_header(&kernel_sfsec);
 }
 
 #ifdef CONFIG_MODULES
@@ -629,6 +631,7 @@ void sframe_module_init(struct module *mod, void *addr, unsigned int size)
 
 	/* Ensure SFrame is initialized when sframe_find() happens */
 	smp_store_release(&mod->sframe_init, true);
+	dbg_print_header(sec);
 }
 
 #endif
diff --git a/kernel/unwind/sframe_debug.h b/kernel/unwind/sframe_debug.h
new file mode 100644
index 0000000000000..748d69ff6c103
--- /dev/null
+++ b/kernel/unwind/sframe_debug.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _SFRAME_DEBUG_H
+#define _SFRAME_DEBUG_H
+
+#include <linux/container_of.h>
+#include <linux/module.h>
+#include <linux/printk.h>
+#include <linux/sframe.h>
+#include <linux/stddef.h>
+#include "sframe.h"
+
+#ifdef CONFIG_MODULES
+
+#define objname(sec) ((sec) == &kernel_sfsec					\
+		     ? "vmlinux"						\
+		     : container_of((sec), struct module, sframe_sec)->name)
+
+#else
+
+#define objname(...) "vmlinux"
+
+#endif
+
+#define dbg_sec(sec, fmt, ...)						\
+	pr_debug("(%s): " fmt, objname(sec), ##__VA_ARGS__)
+
+static __always_inline void dbg_print_header(struct sframe_section *sec)
+{
+	unsigned long fdes_end;
+
+	fdes_end = sec->fdes_start + (sec->num_fdes * sizeof(struct sframe_fde_v3));
+
+	dbg_sec(sec, "SEC:0x%lx-0x%lx fdes:0x%lx-0x%lx fres:0x%lx-0x%lx ra_off:%d fp_off:%d\n",
+		sec->sframe_start, sec->sframe_end, sec->fdes_start, fdes_end, sec->fres_start,
+		sec->fres_end, sec->ra_off, sec->fp_off);
+}
+
+#endif /* _SFRAME_DEBUG_H */
-- 
2.56.0.679.gc527c65306-goog

