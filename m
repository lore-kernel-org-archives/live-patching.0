Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E667E3AD538
	for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 23:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789427144; cv=none; b=ezctNu/fd8Nb5d9Db55RVdbShOfLXTBzHA9wacd0Ku7gTLkdTFoPP7r8URhAu0kWoEDdok3m22dOkWoGuyw600s1FQw+vVQm8fwuP9gFlqwaxGRg8wgjCaUj2FsysFC2QIKYLc+rhCJ0vl29paD/+y6ouswA0+IXpd/8qs7r4R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789427144; c=relaxed/simple;
	bh=e4l7KWbOUQxBjVTD/ZfdVx3YJQFQOD3qWdFrltUTOds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PRPKE0KDTAl/V9zgvOrrMRhNgfTTQkUNfru8xftgArgt4QeapiSR6nvr6MuqWd1VJnrOan0ygqjza9WU3AvKkVIek/BSuIegZo7901PYXi3H5YGr3CRgQKP42ik4QQq4acnGPDxyPtQ27GttDH66L9kmzg9m4+ZNI4GoKyaAffo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bR6G9+Mk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bR6G9+Mk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FEEE1F000FF;
	Mon, 14 Sep 2026 23:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789427142;
	bh=s3JZTHcbrOpT1baGu3slOBpV+j5lKJzt4AJgAhIbfBw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bR6G9+MkqLJfKMNM5A4AbzNg3tLLkNVLGT1kO28zMQClc6eeP3Qvefc9tTNo0mo4U
	 Ms9qAtaapkrdMyiNb9vsMiBTft0KX/W3v50rAX6JDqWPLSBEtjsPnWZHjJvLMd/dBC
	 CCOM2WyeZxj2g8qxAsUJh4Q/plM8lIm4F3BAQBZHq3+cK4L7gITmtVPvdQkqhNjebu
	 89WA+2K6jX+t2Xl5oYDnMHXqE5df7ecoIBelbXnXNzVCq5RtIgak5JD+Ms6GrZwhK8
	 isEfsd8Ln/7M1wqyJPMISRZGrjgC/lPQK4dxrb13yxymzFdU42+rBDV4JgWLYoTJal
	 WHmC5gfGMTNzg==
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
Subject: [PATCH v3 21/58] objtool/klp: Add test for rejecting module-owned static call keys
Date: Mon, 14 Sep 2026 16:03:18 -0700
Message-ID: <20260914230355.3422996-22-song@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914230355.3422996-1-song@kernel.org>
References: <20260914230355.3422996-1-song@kernel.org>
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

