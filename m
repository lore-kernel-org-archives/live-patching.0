Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EB0426429
	for <live-patching@vger.kernel.org>; Tue, 15 Sep 2026 23:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789515416; cv=none; b=lB1FGHP/5J7j2oHoIzrMCjGPImOYuhpgSA6xoaaLvDE3cb7/M4MHuo1t0hFbQ9mrpRusUt8gJjFhXoDnCkGJeiYth9oeVLsQVPf43AaIiKI04TpFIEf6XgN/ychuC2g3788d/7OEKUCtUWJjGzxGY6L8XNFKB+oiyy2ZSuB0+68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789515416; c=relaxed/simple;
	bh=8wTVcLx30eXO7S4A2Igmj0Gjyz8HAXZlzTJQhpZ6EaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pafMY5tT86P9uW4oDmUWGi54l+920ETkM1RVIldy7+xXLSAkzVRWr2CmQS8RUSzAjyb4DEOQLUEDcEJFg7Q6KwqixQpUa1u28VGDp6ThHworA91OsOnSGgV1MkGWRvn+GMHjwml67kTO6nNSI3mfJtrMq7Tq2gQRqaj/G8nPHso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=edfKM1D5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="edfKM1D5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DA961F000FF;
	Tue, 15 Sep 2026 23:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789515415;
	bh=3T0EfzRwSX2m193d+Ks4ysPXshEdCV6mslo6m1k1bRs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=edfKM1D5H8AVTDf92Mji7D7rgg+okSJ/mAwN3kiPTI1Fdvl9hQX1e8SQNdgk4Vy9X
	 OcQA9adUhE9Q2xlAhNXhqTNO/zuDgd5bbWzIkwhIsY+1lZvl2SOOiFk874CaXZa+71
	 9WWETbx3i2jWjS57ZQ/onoUlVmHTou79QuwA4xUYYFHAqfhmZNXtow8Lss9x77+hTQ
	 nWOPFj/PwKH/mLPBWfOUpObMM0Ds8u33b7F/RDhmxWlW5rN3iq7p708xfdTh6lQgrN
	 8g/IEDxMtqXGDiHfcccIkcVWyxGAARjNBnh2hdNbVWe4r5mYIEbmd5Uwss/bjwu8Bv
	 GA0ZpnoCKC5EA==
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
Subject: [PATCH v4 21/58] objtool/klp: Add test for rejecting module-owned static call keys
Date: Tue, 15 Sep 2026 16:34:17 -0700
Message-ID: <20260915233454.2405019-22-song@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915233454.2405019-1-song@kernel.org>
References: <20260915233454.2405019-1-song@kernel.org>
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
 .../tests/generic/fixtures/static_call.c      | 59 +++++++++++++++++++
 .../generic/test-static-call-module-key.sh    | 36 +++++++++++
 2 files changed, 95 insertions(+)
 create mode 100644 tools/objtool/tests/generic/fixtures/static_call.c
 create mode 100755 tools/objtool/tests/generic/test-static-call-module-key.sh

diff --git a/tools/objtool/tests/generic/fixtures/static_call.c b/tools/objtool/tests/generic/fixtures/static_call.c
new file mode 100644
index 000000000000..4a0c4c25321e
--- /dev/null
+++ b/tools/objtool/tests/generic/fixtures/static_call.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Static call site in a patched function, laid out by hand as for
+ * jump_label.c.  MODNAME selects whether the key belongs to vmlinux or a
+ * module.
+ *
+ * objtool's check pass would emit the site, and klp-write-tests.txt says to
+ * let it.  Not here: it does not emit the ANNOTATE_DATA_SPECIAL describing
+ * the entry boundaries -- in the kernel that comes from the static_call
+ * macros -- and NO_ANNOTATE below has to be able to take it away.  A fixture
+ * which varies the annotation has to write the entry that goes with it.
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
index 000000000000..260c4af72e05
--- /dev/null
+++ b/tools/objtool/tests/generic/test-static-call-module-key.sh
@@ -0,0 +1,36 @@
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
+# The accepted half has to show the entry was carried, not just that the
+# function was: dropping the section silently would leave the patched call
+# unregistered, and "target was cloned" cannot tell the two apart.
+assert_section .static_call_sites
+assert_reloc_sym .static_call_sites target
+
+rm -f "$workdir/out.o"
+build_pair static_call.c -DMODNAME='"klp_testmod"'
+run_diff 255
+
+diff_log | grep -q 'unsupported static call key __SCK__klp_test_call' ||
+	fail "expected rejection, got: $(diff_log | tail -1)"
+
+# A rejection has to leave nothing behind.  out.o was removed above, so
+# anything here was written by the run which was supposed to refuse.
+[ -e "$workdir/out.o" ] &&
+	fail "output object produced for a rejected input"
+
+pass "module-owned static call key rejected, vmlinux-owned accepted"
-- 
2.53.0-Meta

