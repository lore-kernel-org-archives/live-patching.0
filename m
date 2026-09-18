Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859524052D7
	for <live-patching@vger.kernel.org>; Fri, 18 Sep 2026 22:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789771340; cv=none; b=a4A364boQGvZcTyobGWfaEsa3YNUJBlhQQlkkMhk3JzfreHlaQ1Zau0gWnT3JBiBWz3jUkygzvjlyLbYa0HBZs80N2RizgYIc6+eUwEJH79bp6C+Sxp4z2Q97cpOC+gHRvRLDb6Wfr+TgGNOebOFPoS7jaAUNVOQ0YjsVUriTPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789771340; c=relaxed/simple;
	bh=SdLgNDKenZx4KGlza2yQ7bxm6glSRhasQYxeBNBqqug=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aqHwR+VNDy4yrbhzNiWhyoGkgRDoQw0lhJ+KF9Bfz/etJmMOvPiTJIhgHfD/0pW/twyhulgIhuE/F5fDlPq6KmrV5iJ1EHq8kczAc2UcFjgpWBI2nnrU0+Ps5R/KjBqlbkF1MMSKeg2CdXeB6kGTYx9y1AGMFTz5ZOPszvsNjX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dylanbhatch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XMlKkg35; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dylanbhatch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XMlKkg35"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2dcfed75f77so16141355ad.2
        for <live-patching@vger.kernel.org>; Fri, 18 Sep 2026 15:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789771338; x=1790376138; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KqQQKqdIQDGXjttGyzs/B5OEMm+Ktujoafh1woeid8o=;
        b=XMlKkg35eEwmSwpt1GVf6OzE8uaXZAPNpV+Ar1UXpkT5x1QyQde1zChyFmC+NYD+v2
         oKPw+cSbnTJe2bq6ui1LOgdWLfcgaRqgIrveZfv4eS6QL+szNk6p7dHI/TN1nDkEpHq+
         EGU+qqqltNPdNIqGyfz5S2dOLwxG88IvmxdHgrS3dq/Gth0KrzblLrKmrEWN01yokXOe
         5rM6Et4mnkRyjjV1aQl4wt2GmfsgKO0OiyPx79aGito/akjozFhmtgv7p6Ebgph5gbES
         mkFJayd0Z59txWIMGXApBqOI07S5FrFfvN9Pdkbyvvfhv8BENSdDrFFFpBsv8J84ITYo
         OLZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789771338; x=1790376138;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KqQQKqdIQDGXjttGyzs/B5OEMm+Ktujoafh1woeid8o=;
        b=fyg/4IzOMpwP+w/wCKY+Zn8/2K/GoTghPe9JIBpuMbm0w/57STR5wuH4BKIOvQpbC1
         aveHS7a+gOAPr6foSNyeBuL1EYRrMT5Gc4SQeVbPDpBtCrnMGDwroAGL7SVt1KVdtBPL
         aIbyfq1FDHOv1zSvL3dj92Hu/Tx4hsPsnQ7rn5UyV+nJF8kTo4zRzxdGwsUmGbcQNN4N
         Q6BeaRIrXasay6sEts//c2Rq3Thm5kRs+O+GLlFNJAoK5H+3w5cFu/w2YewoP5wZPeWv
         AJrDE2W9UQr+RRiNJkEQWEenBhJeaOuCrRKF8WvqzJQE+DrVQy8S2/+d458BO68jVVne
         T7Lg==
X-Forwarded-Encrypted: i=1; AKwUvBzs1OWsYChctZT0m4SQk5YfoyYYhzdK/x0ZRxo5bpVQk3Y+edKgYmVfMns655xLKZ5BAq93AkXsAIcMfODD@vger.kernel.org
X-Gm-Message-State: AFuF++l532a7slxyjh6K1IQhE3fiLFvD6H9XdtsIlFYwGf839LLNa2uK
	/zUJCkznq6k8vZhED7cfSXpqxOD/q86CLUu4WjQxM+lAOTXlDgz+9slM37yzkUdESemmRyPwI1e
	VEM90qV92Abk8/GZhet+0pdgD0g==
X-Received: from plyv3.prod.google.com ([2002:a17:902:d683:b0:2dd:4b79:ccc2])
 (user=dylanbhatch job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e946:b0:2dd:c0ff:e72a with SMTP id d9443c01a7336-2ddc0ffe9a0mr12074035ad.60.1789771337748;
 Fri, 18 Sep 2026 15:42:17 -0700 (PDT)
Date: Fri, 18 Sep 2026 22:41:54 +0000
In-Reply-To: <20260918224157.1471085-1-dylanbhatch@google.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260918224157.1471085-1-dylanbhatch@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260918224157.1471085-9-dylanbhatch@google.com>
Subject: [PATCH v7 08/11] sframe: Add .sframe validation option
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

Add a debug feature to validate all .sframe sections when first loading
the file rather than on demand.

[ Jens Remus: Add support for SFrame V3.  Add support for PC-relative
FDE function start offset.  Adjust to rename of struct sframe_fre to
sframe_fre_internal.  Use %#x/%#lx format specifiers. ]

[ Dylan Hatch: Adapt this patch for in-kernel sframe sections. ]

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Reviewed-by: Indu Bhagat <ibhagatgnu@gmail.com>
Co-developed-by: Jens Remus <jremus@linux.ibm.com>
Signed-off-by: Jens Remus <jremus@linux.ibm.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Co-developed-by: Dylan Hatch <dylanbhatch@google.com>
Signed-off-by: Dylan Hatch <dylanbhatch@google.com>

---

Adapted from commit 4b30214c7896 ("unwind_user/sframe: Add .sframe
validation option") from Steven's sframe/core branch, and squashed in v6
patch "sframe: Introduce in-kernel SFRAME_VALIDATION".

Changes include:
 - Squash in __read_fre_datawords() validation, given the patch
   reordering.
 - Drop safe_read_* user-access wrappers.
 - Call sframe_validate_section() when vmlinux/kernel sections load.
---
 arch/Kconfig           | 18 +++++++++
 kernel/unwind/sframe.c | 83 +++++++++++++++++++++++++++++++++++++++---
 2 files changed, 96 insertions(+), 5 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index cc59a5da80915..20aa63c93a0e2 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -538,6 +538,24 @@ config HAVE_UNWIND_KERNEL_SFRAME
 	  practice, this can provide more reliable stacktrace results than
 	  unwinding with frame pointers alone.
 
+config SFRAME_VALIDATION
+	bool "Enable .sframe section debugging"
+	depends on UNWIND_SFRAME_LOOKUP
+	depends on DYNAMIC_DEBUG
+	help
+	  When adding an .sframe section for an object, validate the entire
+	  section immediately rather than on demand.
+
+	  This is a debug feature which is helpful for rooting out .sframe
+	  section issues.  If the .sframe section is corrupt, it will fail to
+	  load immediately, with more information provided in dynamic printks.
+
+	  This has a significant page cache footprint due to its reading of the
+	  entire .sframe section for every loaded module.  Not recommended for
+	  general use.
+
+	  If unsure, say N.
+
 config HAVE_PERF_REGS
 	bool
 	help
diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
index c4715befb59b5..3386af16fc275 100644
--- a/kernel/unwind/sframe.c
+++ b/kernel/unwind/sframe.c
@@ -13,6 +13,7 @@
 #include <linux/unwind_types.h>
 #include <linux/kallsyms.h>
 #include <asm/sections.h>
+#include <asm/unwind_sframe.h>
 
 #include "sframe.h"
 #include "sframe_debug.h"
@@ -294,7 +295,6 @@ static __always_inline int __read_fre(struct sframe_section *sec,
 				      unsigned long fre_addr,
 				      struct sframe_fre_internal *fre)
 {
-	unsigned char fde_type = SFRAME_V3_FDE_TYPE(fde->info2);
 	unsigned char fde_pctype = SFRAME_V3_FDE_PCTYPE(fde->info);
 	unsigned char fre_type = SFRAME_V3_FDE_FRE_TYPE(fde->info);
 	unsigned char dataword_count, dataword_size;
@@ -323,10 +323,6 @@ static __always_inline int __read_fre(struct sframe_section *sec,
 	if (cur + (dataword_count * dataword_size) > sec->fres_end)
 		return -EFAULT;
 
-	/* Flexible FDEs not supported */
-	if (fde_type != SFRAME_FDE_TYPE_DEFAULT)
-		return -EFAULT;
-
 	fre->size	= addr_size + 1 + (dataword_count * dataword_size);
 	fre->ip_off	= ip_off;
 	fre->info	= info;
@@ -490,6 +486,73 @@ int sframe_find(unsigned long ip, struct unwind_frame *frame)
 	return  __sframe_find_module(ip, frame);
 }
 
+#ifdef CONFIG_SFRAME_VALIDATION
+
+static int sframe_validate_section(struct sframe_section *sec)
+{
+	unsigned long prev_ip = 0;
+	unsigned int i;
+
+	for (i = 0; i < sec->num_fdes; i++) {
+		struct sframe_fre_internal *fre, *prev_fre = NULL;
+		unsigned long ip, fre_addr;
+		struct sframe_fde_internal fde;
+		struct sframe_fre_internal fres[2];
+		bool which = false;
+		unsigned int j;
+		int ret;
+
+		ret = __read_fde(sec, i, &fde);
+		if (ret) {
+			dbg_sec(sec, "__read_fde(%u) failed\n", i);
+			return ret;
+		}
+
+		ip = fde.func_addr;
+		if (ip <= prev_ip) {
+			dbg_sec(sec, "FDE %u not sorted\n", i);
+			return -EFAULT;
+		}
+		prev_ip = ip;
+
+		fre_addr = sec->fres_start + fde.fres_off;
+		for (j = 0; j < fde.fres_num; j++) {
+			int ret;
+
+			fre = which ? fres : fres + 1;
+			which = !which;
+
+			ret = __read_fre(sec, &fde, fre_addr, fre);
+			if (ret) {
+				dbg_sec(sec, "FDE %u: __read_fre(%u) failed\n", i, j);
+				return ret;
+			}
+			ret = __read_fre_datawords(sec, &fde, fre);
+			if (ret) {
+				dbg_sec(sec, "FDE %u: __read_fre_datawords(%u) failed\n", i, j);
+				return ret;
+			}
+
+			fre_addr += fre->size;
+
+			if (prev_fre && fre->ip_off <= prev_fre->ip_off) {
+				dbg_sec(sec, "FDE %u: FRE %u not sorted\n", i, j);
+				return -EFAULT;
+			}
+
+			prev_fre = fre;
+		}
+	}
+
+	return 0;
+}
+
+#else /*  !CONFIG_SFRAME_VALIDATION */
+
+static int sframe_validate_section(struct sframe_section *sec) { return 0; }
+
+#endif /* !CONFIG_SFRAME_VALIDATION */
+
 static int sframe_read_header(struct sframe_section *sec)
 {
 	unsigned long header_end, fdes_start, fdes_end, fres_start, fres_end;
@@ -551,6 +614,11 @@ void __init init_sframe_table(void)
 		return;
 	}
 
+	if (sframe_validate_section(&kernel_sfsec)) {
+		pr_warn("invalid vmlinux SFrame section\n");
+		return;
+	}
+
 	sframe_init = true;
 	dbg_print_header(&kernel_sfsec);
 }
@@ -611,6 +679,11 @@ void sframe_module_init(struct module *mod, void *sframe, size_t sframe_size)
 	}
 	sframe_sort_fdes(sec);
 
+	if (sframe_validate_section(sec)) {
+		pr_warn("invalid SFrame section in module %s\n", mod->name);
+		return;
+	}
+
 	/* Ensure SFrame is initialized when sframe_find() happens */
 	WRITE_ONCE(mod->arch.sframe_init, true);
 	dbg_print_header(sec);
-- 
2.55.0.1082.g2b9226bbc0-goog

