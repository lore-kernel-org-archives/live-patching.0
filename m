Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF78E3BB123
	for <live-patching@vger.kernel.org>; Fri, 26 Jun 2026 21:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782508910; cv=none; b=e3DTW41PyQXeL2G7FFU0nc7eldlB55rFY6bNXuJlSUXsuYeOCzIFwLWMUjr/AEjoKPrJAjzx+5awrZJL1iqPuTPqoqqlyZiYhakpvqvGLIbFYWPyNsWUy/EWrAj7T6J8AGMM30PgehFugrGEMA7JSrUMLJ6NS+PrbHqX1irqUyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782508910; c=relaxed/simple;
	bh=aYldpcIbe2ZKhGw0Zoz+4cxt5dW/oWNaqGsM7A0AK0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=O+hM1KLW+aE110NnjULhxikid3vebqYTpFYqzdiqmSvnfkJWTnXd8bldBz3VhZSUyHMs9EqYIisUx/X/9u62j0eymqipobDpUcUz2QiC5j5cL7Jl2ReFF45wJRHtRKD47UnKhD0dTO1unWPTgNMkUAtCx/xC3vtUV4GI5w179iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jFku8CUN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jFku8CUN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782508907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GYMN+tXHlnWxWuVJ8ktb46H00NTdvAkRR2KqH25M1u4=;
	b=jFku8CUNl2arI/dRDQXFFOl0f7m/jhmbewrtB4iavBWFM7LGE/uviCLKUKbJBPUTm3U4pR
	4tE7CCflMGVuTpVdK+JRovsXC+HwXYxtHqqesyk/z2V81nr0vfc3AlW6brqljOv3MVcOFo
	oFI9Qh0agz8mBR+XzUjzBmOkK8rN0KI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-388-AcZmgXV7N9mSCZhERp9KuQ-1; Fri,
 26 Jun 2026 17:21:44 -0400
X-MC-Unique: AcZmgXV7N9mSCZhERp9KuQ-1
X-Mimecast-MFC-AGG-ID: AcZmgXV7N9mSCZhERp9KuQ_1782508903
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7491E19560BB;
	Fri, 26 Jun 2026 21:21:43 +0000 (UTC)
Received: from jolawren-thinkpadp1gen7.ibmlowe.csb (unknown [10.22.80.46])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9D2AA1774;
	Fri, 26 Jun 2026 21:21:42 +0000 (UTC)
From: Joe Lawrence <joe.lawrence@redhat.com>
To: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org
Cc: Petr Mladek <pmladek@suse.com>
Subject: [PATCH v2 1/2] perf symbols: skip livepatch symbols when loading kallsyms
Date: Fri, 26 Jun 2026 17:21:39 -0400
Message-ID: <20260626212140.1380094-2-joe.lawrence@redhat.com>
In-Reply-To: <20260626212140.1380094-1-joe.lawrence@redhat.com>
References: <20260626212140.1380094-1-joe.lawrence@redhat.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

Livepatch modules contain special symbols (prefixed by ".klp.sym.") that
act as relocation placeholders.  Once resolved, they point to the same
addresses as the original kernel symbols they reference. [1]

These special symbols confuse the 'vmlinux symtab matches kallsyms' perf
test as kallsyms may report multiple symbols sharing a single kernel
address.  For example:

  kallsyms (without livepatch)
  ----------------------------
  ffffffff81a41110 T __pfx_arch_release_task_struct
> ffffffff81a41120 T arch_release_task_struct
  ffffffff81a41140 T __pfx_exit_thread
  ffffffff81a41150 T exit_thread

  kallsyms (with livepatch loaded)
  ---------------------------------
  ffffffff81a41110 T __pfx_arch_release_task_struct
> ffffffff81a41120 T arch_release_task_struct
  ffffffff81a41140 T __pfx_exit_thread
  ffffffff81a41150 T exit_thread
> ffffffff81a41120 w .klp.sym.vmlinux.arch_release_task_struct,0  [kpatch_5_14_0_570_94_1_1_3]

When perf loads kallsyms, both symbols are inserted into the symbol
table at the same address, corrupting symbol end-address calculations
and causing test failures.

Filter out symbols prefixed with ".klp.sym." when loading kallsyms, as
they alias existing kernel symbols.

Link: https://docs.kernel.org/livepatch/module-elf-format.html#livepatch-symbols [1]
Reported-and-tested-by: Ben Procknow <bprockno@redhat.com> [downstream backport]
Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
---
 tools/perf/util/symbol.c |  4 ++--
 tools/perf/util/symbol.h | 12 ++++++++++++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index cd379ced19e5..a562702b4841 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -880,8 +880,8 @@ static int map__process_kallsym_symbol(void *arg, const char *name,
 	if (!symbol_type__filter(type))
 		return 0;
 
-	/* Ignore mapping symbols in kallsyms */
-	if (is_ignored_kernel_symbol(name))
+	/* Ignore mapping and livepatch symbols in kallsyms */
+	if (is_ignored_kernel_symbol(name) || is_livepatch_symbol(name))
 		return 0;
 
 	/*
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index a71525335703..d0bac824c79c 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -8,7 +8,9 @@
 #include <stdint.h>
 #include <stdatomic.h>
 #include <linux/list.h>
+#include <linux/livepatch_external.h>
 #include <linux/rbtree.h>
+#include <linux/string.h>
 #include <stdio.h>
 #include <errno.h>
 #include "addr_location.h"
@@ -45,6 +47,16 @@ static inline bool is_ignored_kernel_symbol(const char *str)
 	return str[0] == '$';
 }
 
+/*
+ * Livepatch symbols (.klp.sym.*) are relocation placeholders whose resolved
+ * addresses alias existing kernel symbols.  They carry a [module] tag which
+ * confuses module boundary tracking and symbol table lookups.
+ */
+static inline bool is_livepatch_symbol(const char *str)
+{
+	return strstarts(str, KLP_SYM_PREFIX);
+}
+
 /*
  * libelf 0.8.x and earlier do not support ELF_C_READ_MMAP;
  * for newer versions we can use mmap to reduce memory usage:
-- 
2.54.0

