Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27473495517
	for <live-patching@vger.kernel.org>; Wed,  7 Oct 2026 11:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791373457; cv=none; b=D6JLjNmqVhxP5WjNh1QPRoFfO5JdYFb66ERRLFNjIkh2Ti1K5NYwWhP03KwUHFuVmvv7K4bG3nj7ca+YsyOIXR+SyX1qRd13Fwnt743mdsQxYWteT02ftXIPEQDgRa8S7X+gA83CAanl8NM6ngSxji560z7+qd8doGYQ1NOpJIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791373457; c=relaxed/simple;
	bh=gyW1ZCiBn2vk3+vROpBaXD3PdP2BT7iVSa2adEwcDhw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PTNivd+oMXlkNclxdjGhNYr53mC+9MyOu6vALiDelJaNX8PU3fG0LwqDZgIL9wxJz0C49ztLtF6w2LtlpblJArPdRXB5E4La9hte78p4IaO3z+LfN7Ir5uDVNG6y0R2uTAX3esyyUY/TXJ0km0Ud5J5SYFHAeZ7N3IxwHEr04mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dylanbhatch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y7bTetHr; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dylanbhatch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y7bTetHr"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-ccca9481fb6so2595108a12.3
        for <live-patching@vger.kernel.org>; Wed, 07 Oct 2026 04:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791373439; x=1791978239; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tEhVH3BFD2TjsLmkDkgiwNlCGTM295XsbmIckPx7jns=;
        b=Y7bTetHr30x5WF/DUo1B6f0Do2zyOh9xk9LpPmHFipsIDF/UFKXqJTMHXvQyJtYPAv
         r5nzFLsChBDpRf0cOnMrOYhthwfqjG4BgZAgt2xVdS2WakDcfSEGc2Zuj14rdGVDZd5x
         Cs+tMw4BwV3ujF+UkjZ9wrU61xc4DEkb28ASrFSK06tQsoy1dB39UJDOcoquiQHxsYP4
         +PapCQ4hmy4DuK+9HkHNqk49Bg3GER1y6wF6zHzN7qUgBR4pNWYkKvTIqx9pRI4No390
         JRuoH7llm7CkFIUmQwaYC5doaR7S6EMCwfmJAuCAuvD+gR/TaqKhyV5u7uBaOeJdIoly
         FwEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791373439; x=1791978239;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tEhVH3BFD2TjsLmkDkgiwNlCGTM295XsbmIckPx7jns=;
        b=gXSLP3UhKNl60eeVbgaqQOflomXg7Cm9z9xxvQxPfWQoGUzqsZzXb6RyiaroO38LV4
         Sn+t1Theavx6yhjH0uvMwPmxK0C4YODrkiyHt/DZmezqHLqx3mPif7lxNuNmZwMRTh+O
         HSq2CMaJrhoVODgIJ9acs3DeAj1cVC8fFv8sJrmKhgUBIuF9nSn4hE5l16klnJN7PKjh
         tZyhzsjKnYEQrsikizP3xHAu4+65j0ers98EKABMzJQ4wdd6yGJ+gr8HrkYZX8GaR1C6
         fj8lUdqrV8/LBtf6ND4Br9Q5Y1gT0u8Wl9F5FfUI23z7vjcZmxG1ji8/Nwt8//nRWubn
         dfbA==
X-Forwarded-Encrypted: i=1; AKwUvBwrUQxFNXFEOgu23K7y4q/RcvCpS5gQJMzLc1YT3Q2ItJKadYIsQwdYaYBrUjebA4Yjum8D6r2kZ5pRkiFR@vger.kernel.org
X-Gm-Message-State: AFq9FYJeKlgAogI/N0fxAfl0C6rb4IsOpOUdF2IpTlHD7IRO27fGTDT/
	wI6t3b16T3EqJwrPy5CCyb34zJt+QbfcKbMfZMi3LfpYP1pUehIdIdpbNjU95xskSv7hw1b8Km1
	ktBlis2QK63fQa2PFnjYKxsHMGQ==
X-Received: from plbmf6.prod.google.com ([2002:a17:902:fc86:b0:2df:9a43:558b])
 (user=dylanbhatch job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ebc6:b0:2d0:cc92:f7a3 with SMTP id d9443c01a7336-2e5ffaa3b53mr18539905ad.2.1791373439065;
 Wed, 07 Oct 2026 04:43:59 -0700 (PDT)
Date: Wed,  7 Oct 2026 11:43:31 +0000
In-Reply-To: <20261007114335.440322-1-dylanbhatch@google.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261007114335.440322-1-dylanbhatch@google.com>
X-Mailer: git-send-email 2.56.0.360.g66cac248cb-goog
Message-ID: <20261007114335.440322-8-dylanbhatch@google.com>
Subject: [PATCH v8 07/11] sframe: Add debug helpers with object name
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

Include the object name for kernel .sframe sections, indicated with the
format "(<module-name>)" or "(vmlinux)".

Suggested-by: Jens Remus <jremus@linux.ibm.com>
Reviewed-by: Jens Remus <jremus@linux.ibm.com>
Signed-off-by: Dylan Hatch <dylanbhatch@google.com>
---
 kernel/unwind/sframe.c       | 11 +++++++----
 kernel/unwind/sframe_debug.h | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 4 deletions(-)
 create mode 100644 kernel/unwind/sframe_debug.h

diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
index c95fcb63e7eaf..2e8ff783de7d8 100644
--- a/kernel/unwind/sframe.c
+++ b/kernel/unwind/sframe.c
@@ -17,6 +17,7 @@
 #include <asm/sections.h>
 
 #include "sframe.h"
+#include "sframe_debug.h"
 
 static bool sframe_init __ro_after_init;
 struct sframe_section kernel_sfsec __ro_after_init;
@@ -510,7 +511,7 @@ static int sframe_read_header(struct sframe_section *sec)
 
 	header_end = sec->sframe_start + sizeof(struct sframe_header);
 	if (header_end >= sec->sframe_end) {
-		pr_debug("header struct doesn't fit in section\n");
+		dbg_sec(sec, "header struct doesn't fit in section\n");
 		return -EINVAL;
 	}
 
@@ -520,12 +521,12 @@ static int sframe_read_header(struct sframe_section *sec)
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
 
@@ -537,7 +538,7 @@ static int sframe_read_header(struct sframe_section *sec)
 	fres_end   = fres_start + shdr->fre_len;
 
 	if (fres_start < fdes_end || fres_end > sec->sframe_end || fres_end < sec->sframe_start) {
-		pr_debug("inconsistent fde/fre offsets\n");
+		dbg_sec(sec, "inconsistent fde/fre offsets\n");
 		return -EINVAL;
 	}
 
@@ -564,6 +565,7 @@ void __init init_sframe_table(void)
 	}
 
 	sframe_init = true;
+	dbg_print_header(&kernel_sfsec);
 }
 
 #ifdef CONFIG_MODULES
@@ -624,6 +626,7 @@ void sframe_module_init(struct module *mod, void *addr, unsigned int size)
 
 	/* Ensure SFrame is initialized when sframe_find() happens */
 	smp_store_release(&mod->sframe_init, true);
+	dbg_print_header(sec);
 }
 
 #endif
diff --git a/kernel/unwind/sframe_debug.h b/kernel/unwind/sframe_debug.h
new file mode 100644
index 0000000000000..f0bc2136eaad0
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
2.56.0.360.g66cac248cb-goog

