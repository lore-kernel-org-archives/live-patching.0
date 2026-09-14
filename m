Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27273D9DBB
	for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 06:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789367247; cv=none; b=RSop/25ZEKPffZzzOvwtiWWeVKSZYlPd0/MvmdmyLf0c90Z93BJzaxzRnwhLyLnpNZyK1ObQIfXgDr33HaQ9dva26hpUIClhsB7UvoeyPrtIp0OsUfwTOgIYJ7I/u+40mhHQVMTDX1iZXGBeTcfcCj5j/u7DOSUweqsOa90uXh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789367247; c=relaxed/simple;
	bh=e4l7KWbOUQxBjVTD/ZfdVx3YJQFQOD3qWdFrltUTOds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KZbZlqXHOAWypzDxCnB5lZO4gyx0NdK8T0qNHCEPExC/Ag6n+G3PQIZ0D1xjRiyTHsFJQRNi+MIYRi963k7a7eWp70ZLOHmg4A3eroT0YwgOlznAxsSk07dsK8P38JgV1fird9LdTmvD0R6tKuNpuN3puML9MxKOBzV2X/0zejQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fjMGzYM6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fjMGzYM6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B12B1F00893;
	Mon, 14 Sep 2026 06:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789367241;
	bh=s3JZTHcbrOpT1baGu3slOBpV+j5lKJzt4AJgAhIbfBw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fjMGzYM6G+4OxPPQSqi3N0VwHH/gsdHBf3Os5IsxQWkKuv+H4WokYC/Z55GqCib+t
	 nXndmMLFKt7TUMX736M3fnJXUgnHK6xgQX43gW26ObCrbBgivseJbJMf4Pd8+qMzXy
	 qKGaTfESuM68L/DFz2K0rW9ojiFrnKW7gIqkbVQ71yNb0UZa3IDfdyJ4cjBrdSJxoC
	 9g9A1QbnLQ6Nl2Er3FJUN1/amTjjRGnwAuCk9/znSDcUDu4jZuQJSXlSIuG76uHFCL
	 ikFDRdEN7BYhZDSHgPUq6F4OtvCUhx+bg6N8I3WtJc0J3qMUAdTO4xyAQ88+HhR6K9
	 4AJxNVOTt5sXg==
From: Song Liu <song@kernel.org>
To: live-patching@vger.kernel.org
Cc: jpoimboe@kernel.org,
	peterz@infradead.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	puranjay@kernel.org,
	kernel-team@meta.com,
	Song Liu <song@kernel.org>
Subject: [PATCH v2 21/58] objtool/klp: Add test for rejecting module-owned static call keys
Date: Sun, 13 Sep 2026 23:24:37 -0700
Message-ID: <20260914062514.926997-22-song@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914062514.926997-1-song@kernel.org>
References: <20260914062514.926997-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Puranjay Mohan <puranjay@kernel.org>

Static calls carry the same constraint as static branches.  Check that a
vmlinux-owned key is accepted and a module-owned one is refused.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 .../tests/generic/fixtures/static_call.c      | 53 +++++++++++++++++++
 .../generic/test-static-call-module-key.sh    | 25 +++++++++
 2 files changed, 78 insertions(+)
 create mode 100644 tools/objtool/tests/generic/fixtures/static_call.c
 create mode 100755 tools/objtool/tests/generic/test-static-call-module-key.sh

diff --git a/tools/objtool/tests/generic/fixtures/static_call.c b/tools/objtool/tests/generic/fixtures/static_call.c
new file mode 100644
index 000000000000..5975986c92eb
--- /dev/null
+++ b/tools/objtool/tests/generic/fixtures/static_call.c
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Static call site in a patched function, laid out by hand as for
+ * jump_label.c.  MODNAME selects whether the key belongs to vmlinux or a
+ * module.
+ *
+ * NO_ANNOTATE drops the ANNOTATE_DATA_SPECIAL block from the patched build,
+ * leaving .static_call_sites with no annotation to describe its entry
+ * boundaries.  The section carries no entsize either, so klp diff has to fall
+ * back on the annotations it can still see -- and when the patched object is
+ * the only one that lost them, the two sides disagree about how the section is
+ * divided up.
+ *
+ * NEW_CALL puts the call site behind PATCHED, so the patch introduces one
+ * where the original had none.  The .static_call_sites entry is then new, with
+ * nothing in the original to correlate it against.
+ */
+
+#ifndef MODNAME
+#define MODNAME "vmlinux"
+#endif
+
+static const char __modinfo[]
+	__attribute__((section(".modinfo"), used, aligned(1))) = "\0name=" MODNAME;
+
+long __SCK__klp_test_call;
+
+int target(int x)
+{
+#if defined(NEW_CALL) && !defined(PATCHED)
+	/* The original has no static call at all. */
+	return x + 1;
+#else
+	__asm__ volatile(
+		"1:	nop\n\t"
+		".pushsection	.static_call_sites, \"aw\"\n\t"
+		".balign	8\n\t"
+		"912:\n\t"
+#if !(defined(PATCHED) && defined(NO_ANNOTATE))
+		".pushsection	.discard.annotate_data, \"M\", @progbits, 8\n\t"
+		".long		912b - ., 1\n\t"
+		".popsection\n\t"
+#endif
+		".long		1b - ., %c0 - .\n\t"
+		".popsection\n\t"
+		:: "i" (&__SCK__klp_test_call));
+#endif
+#ifdef PATCHED
+	return x + 2;
+#else
+	return x + 1;
+#endif
+}
diff --git a/tools/objtool/tests/generic/test-static-call-module-key.sh b/tools/objtool/tests/generic/test-static-call-module-key.sh
new file mode 100755
index 000000000000..9ab373e90e10
--- /dev/null
+++ b/tools/objtool/tests/generic/test-static-call-module-key.sh
@@ -0,0 +1,25 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# As for static branches, a static call key owned by a module must be rejected
+# while a vmlinux-owned one is accepted.
+
+. "$(dirname "$0")/../lib.sh"
+
+setup
+build_pair static_call.c
+
+has_input_section orig.o .static_call_sites ||
+	probe_skip "fixture produced no .static_call_sites on this arch"
+
+run_diff
+assert_patched target
+
+rm -f "$workdir/out.o"
+build_pair static_call.c -DMODNAME='"klp_testmod"'
+run_diff 255
+
+diff_log | grep -q 'unsupported static call key __SCK__klp_test_call' ||
+	fail "expected rejection, got: $(diff_log | tail -1)"
+
+pass "module-owned static call key rejected, vmlinux-owned accepted"
-- 
2.53.0-Meta

