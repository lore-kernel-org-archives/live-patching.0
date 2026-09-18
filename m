Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7C3400996
	for <live-patching@vger.kernel.org>; Fri, 18 Sep 2026 22:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789771338; cv=none; b=NxL/Uc/t0C4YZrcK138zKi1QnQ525lgWZa0pA7qqL2ywoMOlgVzR42iimV+cy29KMCVazJXEjNCginZujP4DNIq4s5wk9LG4yyZZCZM4u9LaYXrcXfD4aVDWfbzsHStU/gpWS2Zhm2LKKsIcOBIgCc0cHJKfR+CQjdpv+SH6/DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789771338; c=relaxed/simple;
	bh=xe00uxz/OaxEdwDDbTPdU8Cbw86hGO72DCSfpzxHGIo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DhQWeM7ioU59OYfgFceT4XdLmZtkPfaBtDrAauXYGle4FWrq4Bx5kopIRgGaEX8ebeTU2Soc4BTeiJYkhCFIBaYUTtf8VyQgVb5l+Hsi/nvrJd3tBF0EdE9PMpUZQ+lV9FuSN7e5KO7InbSuXgMSxWMXYJfUC/IU6cthfxPa95o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dylanbhatch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Aha1QczY; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dylanbhatch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Aha1QczY"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-86261e66700so1279982b3a.3
        for <live-patching@vger.kernel.org>; Fri, 18 Sep 2026 15:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789771336; x=1790376136; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AIMZ/ZUARPPqvZz1xOu4RWFet2sLYJbZYKu9ojsMCnw=;
        b=Aha1QczYO81t2vCVbAPDoPbWtQlUvlm+ZeVKBYfg6P3RagXISNW3nEVc/RTvoLquww
         HLOTAlbas0o2DUWul2SO9mnrRu0EhSTZI4gltr2fQT4wsgVbT1JlPP+bN27WI3V4J+KS
         Ie8irsP6o81pmxyK/awKPXdp/tXCRqWefVjOOZ70Of3EvZ4O4x3cUaRfKqV2qbhXXj/d
         la2AfYtCU57cpT9akMCoAgUoTjorzVnRJDj5dobi5jBc+n3n0h7rUjKZqREq/3x3rHDE
         Q5xe+FN+01pok9M0JkNMzgY6MptREQ4/+rnq4KiXzn3JWucX9FA+Aw4zQhB7WCcJssYS
         QnxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789771336; x=1790376136;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AIMZ/ZUARPPqvZz1xOu4RWFet2sLYJbZYKu9ojsMCnw=;
        b=ok1XlcaUmpjntLnJkx0GCIMpl9BpOdPCA0MuG3gyzIbLpGOs2ev+GRbhp2PvOPkOsO
         37vjKi7N4tk9T/CFhLRZARUa5i23kOZmg6DST125wBZLwcm//w66twSKOakpV1mQRZye
         nQJS/tn1MSp+WzV1C05q4NPlB/JcvhRyT4LlUrt2y24XkHGSq7Zw8wfVfaXVZtJssx9l
         3LLtqKOXCzzNbaFutMCKmpPXg/LeGFque0LsYedqzSRaHnhtmgHKptt+X39z8ELckkeV
         v5vSJ7SlghwWfh9AyVKt4Jfni8pxHP7vULFDx2CEvMza4mpO9/2k7Qmfsu8eL5MwDjaF
         fDPg==
X-Forwarded-Encrypted: i=1; AKwUvBxf8XSzp6aNO49V3ou6vt+RbTm3S9JoC82G6wnAh18ET7LRJGCBXVi7WywzmxkWZ0ADlRpQ4Ctvdsr6mfN8@vger.kernel.org
X-Gm-Message-State: AFuF++liUEJoih15Hf8aBfgowB9vhFKkymowGjjYULoT3ndl9LW6KE+i
	0jmV5cJOG7yX0mJWq1YY1tz0+p/8KZEaFTgIVjHhl6HhO0hoWRdeZyfrwWEy7CJ03y4R9Tog341
	qqGcxAXIkv3HcGuI6wgGjhKljKA==
X-Received: from pfbfv3.prod.google.com ([2002:a05:6a00:6183:b0:86a:d8db:2be])
 (user=dylanbhatch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:4185:b0:86d:3958:6b13 with SMTP id d2e1a72fcca58-874dd5f0ecfmr7385047b3a.19.1789771335997;
 Fri, 18 Sep 2026 15:42:15 -0700 (PDT)
Date: Fri, 18 Sep 2026 22:41:53 +0000
In-Reply-To: <20260918224157.1471085-1-dylanbhatch@google.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260918224157.1471085-1-dylanbhatch@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260918224157.1471085-8-dylanbhatch@google.com>
Subject: [PATCH v7 07/11] sframe: Add debug helpers with object name
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

Include the object name for kernel .sframe sections, indicated by the
format "(<module-name>)".

Suggested-by: Jens Remus <jremus@linux.ibm.com>
Reviewed-by: Jens Remus <jremus@linux.ibm.com>
Signed-off-by: Dylan Hatch <dylanbhatch@google.com>

---

Changes since v6:
 - Compute objname of sec on the fly to avoid allocating/storing an
   extra string in struct sframe_section for the name.
 - Squash dbg_print_header() definition, and add calls from
   init_sframe_table() and sframe_module_init().
---
 kernel/unwind/sframe.c       | 11 +++++++----
 kernel/unwind/sframe_debug.h | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 4 deletions(-)
 create mode 100644 kernel/unwind/sframe_debug.h

diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
index e6542bb678585..c4715befb59b5 100644
--- a/kernel/unwind/sframe.c
+++ b/kernel/unwind/sframe.c
@@ -15,6 +15,7 @@
 #include <asm/sections.h>
 
 #include "sframe.h"
+#include "sframe_debug.h"
 
 static bool sframe_init __ro_after_init;
 struct sframe_section kernel_sfsec __ro_after_init;
@@ -497,7 +498,7 @@ static int sframe_read_header(struct sframe_section *sec)
 
 	header_end = sec->sframe_start + sizeof(struct sframe_header);
 	if (header_end >= sec->sframe_end) {
-		pr_debug("header struct doesn't fit in section\n");
+		dbg_sec(sec, "header struct doesn't fit in section\n");
 		return -EINVAL;
 	}
 
@@ -507,12 +508,12 @@ static int sframe_read_header(struct sframe_section *sec)
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
 
@@ -524,7 +525,7 @@ static int sframe_read_header(struct sframe_section *sec)
 	fres_end   = fres_start + shdr->fre_len;
 
 	if (fres_start < fdes_end || fres_end > sec->sframe_end) {
-		pr_debug("inconsistent fde/fre offsets\n");
+		dbg_sec(sec, "inconsistent fde/fre offsets\n");
 		return -EINVAL;
 	}
 
@@ -551,6 +552,7 @@ void __init init_sframe_table(void)
 	}
 
 	sframe_init = true;
+	dbg_print_header(&kernel_sfsec);
 }
 
 #ifdef CONFIG_MODULES
@@ -611,6 +613,7 @@ void sframe_module_init(struct module *mod, void *sframe, size_t sframe_size)
 
 	/* Ensure SFrame is initialized when sframe_find() happens */
 	WRITE_ONCE(mod->arch.sframe_init, true);
+	dbg_print_header(sec);
 }
 
 #endif
diff --git a/kernel/unwind/sframe_debug.h b/kernel/unwind/sframe_debug.h
new file mode 100644
index 0000000000000..114a4ff4899ef
--- /dev/null
+++ b/kernel/unwind/sframe_debug.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _SFRAME_DEBUG_H
+#define _SFRAME_DEBUG_H
+
+#include <linux/sframe.h>
+#include "sframe.h"
+
+#ifdef CONFIG_MODULES
+
+#define objname(sec) ((sec) == &kernel_sfsec					\
+		     ? "vmlinux"						\
+		     : container_of((sec), struct module, arch.sframe_sec)->name)
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
2.55.0.1082.g2b9226bbc0-goog

