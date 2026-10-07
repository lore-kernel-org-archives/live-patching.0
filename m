Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F1448FF9F
	for <live-patching@vger.kernel.org>; Wed,  7 Oct 2026 11:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791373455; cv=none; b=PfNA19vH7NEUzXGU89efjTuUKAGi4aA2l32nfXjpivdd6lMU5sOBSqaOscQnmg+QxIJn1cMCZg9v4Vt34TMtVVBUEqR3fNeoWlKqGzJvqKoUmyAN36mjLYj1dkEHcbnXiklQ0QTlMbce9SX9zlHvPfsjqSuVUoUdJ6NpW0Ero4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791373455; c=relaxed/simple;
	bh=pymQwj9Tgs2JLgJQ9v7/rWgQ1Rdhoi4ayj8qlJCh9qA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ruCZuE8O35DpeC6Ghkva6eulbG5C6sVZXs94QHPqRW69Mwd9MpB+FgPHGpC1E66b32p/byN1W/B9vsnmwPcntzPHzYRTrRV7g8JLXjrje48fdYBQW+c7ketuj1iHsksYh3tYq+SqP/GfUWtvDmvnSob6jpCvfwlwY1qsUQnoUJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dylanbhatch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EgbXgIaE; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dylanbhatch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EgbXgIaE"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3a6d95d6e08so3094063a91.1
        for <live-patching@vger.kernel.org>; Wed, 07 Oct 2026 04:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791373441; x=1791978241; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SUzzgJKkl0P/3X8X9a5rV9yuKwhvvL6DGpxGAltkfZU=;
        b=EgbXgIaEp9EUa8nU/WbgJWPXsl5+8EwzJ7NvUNuk1uSdw9kKj9evaXg+UELVK+lSt7
         +QtT5zZzrw+6sVgzwHuz2R/qnduTL1eLJNxPBtd25oERAX3rNwPQMqbR8MaV+c98+1ga
         3uB0f+wFbOZwHFL1jTUVaBTAV3Fgt4j7Fl/WmgXj1M1RO1jwyinIhaWT6sri7/6KfLIs
         E4JYop4/aTuO78Q3xJdli5BMe11YVatiKzvhXibWKDR/zu+ZuIpXVOykobjM06BOexfB
         0pEU0zqUzDCy1eL/NlwmPMe4PtoZy6OxjZ6Rn0l1zeLGAv0C6PnJwi3CR0HrME4Md2kE
         s45Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791373441; x=1791978241;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SUzzgJKkl0P/3X8X9a5rV9yuKwhvvL6DGpxGAltkfZU=;
        b=lKst5CXLfhud88lT/mQg23RdhkL0BainYzocnuc18yK+PNBOLSvLzzoWYA+kmzcy8M
         sRm1dklSgkS7pW0GzyX7fx4P1+owupRIh2ltbCxbV0B4jku9QgUx3QC/1UEINm+NW1DZ
         lqQna5PpsZWu9P0Iu5XjVsLR29uqXz8uJlW3S96QSvBpRn20v3q1S/+42i4X7Yb12xq8
         kXRbfd2dwg9Fn79F6FxAGHsnKKBOFeDBmPx5vVtKSN52+oiwdbwiyco1XDkl0ieTk5KJ
         tEZ4yvaibQZEmJgGGC9lxIzY50+VYOrNIOzJ6G4yvzbwtyjY591GRA/IX2KXQNxYPyfA
         0kzg==
X-Forwarded-Encrypted: i=1; AKwUvBznGWLRPcKOc0aFM2gn6WyMPi9UusdRcUUDgqJhtT3R27sCToNgfODIWeE295d0bMvG3OhWboBHcrv04s3p@vger.kernel.org
X-Gm-Message-State: AFq9FYIRoq8oSFeZDWcjtmspZvC/betBsTQkbEdKiFkkY9lZA25t6D9J
	xJcZsFozmILU7d2LCI3EoxmyLJJludxoXmOpU42yd4AmpXpMbkS4/U02GtVrmmK8h5wfoASHEtu
	EGRshbHdA+itMolkvZp4V2oQ/NA==
X-Received: from pgbj17-n1.prod.google.com ([2002:a05:6a02:61d1:10b0:cd0:bb2c:3923])
 (user=dylanbhatch job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3c8c:b0:3a4:fe48:d412 with SMTP id 98e67ed59e1d1-3a8a19ba137mr1514102a91.30.1791373441003;
 Wed, 07 Oct 2026 04:44:01 -0700 (PDT)
Date: Wed,  7 Oct 2026 11:43:32 +0000
In-Reply-To: <20261007114335.440322-1-dylanbhatch@google.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261007114335.440322-1-dylanbhatch@google.com>
X-Mailer: git-send-email 2.56.0.360.g66cac248cb-goog
Message-ID: <20261007114335.440322-9-dylanbhatch@google.com>
Subject: [PATCH v8 08/11] sframe: Add .sframe validation option
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
 arch/Kconfig           | 18 ++++++++++
 kernel/unwind/sframe.c | 78 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 96 insertions(+)

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
index 2e8ff783de7d8..62c22ca70614a 100644
--- a/kernel/unwind/sframe.c
+++ b/kernel/unwind/sframe.c
@@ -15,6 +15,7 @@
 #include <linux/kallsyms.h>
 #include <asm/kprobes.h>
 #include <asm/sections.h>
+#include <asm/unwind_sframe.h>
 
 #include "sframe.h"
 #include "sframe_debug.h"
@@ -503,6 +504,73 @@ noinstr int sframe_find(unsigned long ip, struct unwind_frame *frame)
 }
 NOKPROBE_SYMBOL(sframe_find);
 
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
@@ -564,6 +632,11 @@ void __init init_sframe_table(void)
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
@@ -624,6 +697,11 @@ void sframe_module_init(struct module *mod, void *addr, unsigned int size)
 	}
 	sframe_sort_fdes(sec);
 
+	if (sframe_validate_section(sec)) {
+		pr_warn("invalid SFrame section in module %s\n", mod->name);
+		return;
+	}
+
 	/* Ensure SFrame is initialized when sframe_find() happens */
 	smp_store_release(&mod->sframe_init, true);
 	dbg_print_header(sec);
-- 
2.56.0.360.g66cac248cb-goog

