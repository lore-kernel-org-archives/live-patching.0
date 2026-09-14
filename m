Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872333E0C75
	for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 06:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789367295; cv=none; b=fsATpZXTqtRIk80tHhQC9k4DuTmyD6vHZuR1WIJyTBj/dSiUXL1QjFE3clTljwbCay2cZ27O9b7TDa7n+Fs6N71IwJlU/Vt5yBaQyXOAJuC80W+0dXLRaAn5F/c5b+b95WoBSdoILOCjcJo48mSndJOVIIXWq/bMTU7zfD56SuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789367295; c=relaxed/simple;
	bh=n7WVRwfT8KB6KbQV67XYBT/y+bUh1Nv5RGm5QzTz6co=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MMETUIE8UlpOx6orx4hSSv05s0HCllchHkG9blMHViuRlOuSsmO1odbrF780Yqn77rQmd6xaiVGR0fh7B8J6lrnetD5YFp/6aE8CQ9DW6XHWgJTURIXNSEcT+SdnEVM/qz5ur+pImBVElRmchrgvxtdGn8txGPV7K2s3JMZ/670=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c/RtQoo4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c/RtQoo4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C0431F000FF;
	Mon, 14 Sep 2026 06:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789367294;
	bh=M1JB/yRh/wPtStJHhjJW7qswY2A/P7sViKF3tegwlrY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c/RtQoo4uYx6dsCeqyhabcu0KkT99Gve7EIeMHvkbHxTtMtZujN02lbS3k7u+0DO2
	 uahN7cKsai0anzZUzetlmpBAjdbSE69GVjO8Euzs4K2Eh+k27l7SPO1akzxcZuwelL
	 rPr/LZpbgCJQv8+bIQBJQdGl7CvfpP7lQGBp6YVaPiMl/yVfSAFnMD6yzPqURxuOfj
	 12iJAUer7MRz28fp5DhvAILMjKDmcc7Gd6wOSRksic9N3axM6veLZ4fQN2zqiCeELm
	 gfyxzdpxjiIOWU4pJ43emxqJRaZKdRLiOUweutojsTV/tEmQiPT+N+nx4/7uZ1GWAJ
	 u+BbcYpMucBzA==
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
Subject: [PATCH v2 31/58] objtool/klp: Add test for the contents of the klp_funcs list
Date: Sun, 13 Sep 2026 23:24:47 -0700
Message-ID: <20260914062514.926997-32-song@kernel.org>
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

The patch list is what livepatch acts on, and asserting only that it exists
does not say it is right.  A function that should have been patched and is
missing leaves the bug in place; one that should not be there patches code
nobody changed.

The fixture changes two of three functions and asserts on all three: the
two by name, and the third by its absence.  It checks the strings in
.rodata.klp.str1.1 as well as the relocations, since the names the kernel
matches on are real strings.

Assisted-by: Claude:claude-opus-4
Based-on-test-by: Joe Lawrence <joe.lawrence@redhat.com>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 .../tests/generic/fixtures/klp_funcs.c        | 31 +++++++++++++
 .../tests/generic/test-klp-funcs-content.sh   | 44 +++++++++++++++++++
 2 files changed, 75 insertions(+)
 create mode 100644 tools/objtool/tests/generic/fixtures/klp_funcs.c
 create mode 100755 tools/objtool/tests/generic/test-klp-funcs-content.sh

diff --git a/tools/objtool/tests/generic/fixtures/klp_funcs.c b/tools/objtool/tests/generic/fixtures/klp_funcs.c
new file mode 100644
index 000000000000..3f0d3e206cef
--- /dev/null
+++ b/tools/objtool/tests/generic/fixtures/klp_funcs.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Two changed functions and one untouched, so the patch's function list has a
+ * length worth checking and something that must not appear in it.
+ */
+
+static const char __modinfo[]
+	__attribute__((section(".modinfo"), used, aligned(1))) = "\0name=vmlinux";
+
+int first(int x)
+{
+#ifdef PATCHED
+	return x + 11;
+#else
+	return x + 1;
+#endif
+}
+
+int second(int x)
+{
+#ifdef PATCHED
+	return x + 22;
+#else
+	return x + 2;
+#endif
+}
+
+int third(int x)
+{
+	return x + 3;
+}
diff --git a/tools/objtool/tests/generic/test-klp-funcs-content.sh b/tools/objtool/tests/generic/test-klp-funcs-content.sh
new file mode 100755
index 000000000000..c4ec7098d948
--- /dev/null
+++ b/tools/objtool/tests/generic/test-klp-funcs-content.sh
@@ -0,0 +1,44 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# .init.klp_funcs is the list the kernel walks to decide what to patch, and
+# .init.klp_objects points at it.  Existing tests assert only that the sections
+# exist, which they do whether the list names the right functions, the wrong
+# ones, or none at all -- and a patch module with an empty function list loads
+# perfectly happily and patches nothing.
+#
+# Each entry pairs a name string in .rodata.klp.str1.1 with a relocation to the
+# new function, so both halves are checkable.
+
+. "$(dirname "$0")/../lib.sh"
+
+setup
+build_pair klp_funcs.c
+run_diff
+
+assert_section .init.klp_funcs
+assert_section .init.klp_objects
+
+# Two functions changed, so two entries, each contributing a name relocation
+# and a function relocation.
+assert_reloc_count .init.klp_funcs 4
+
+# The functions that changed are named ...
+assert_reloc_sym .init.klp_funcs first
+assert_reloc_sym .init.klp_funcs second
+# ... and the one that did not is absent, from the list and from the patch.
+assert_no_reloc_sym .init.klp_funcs third
+assert_not_patched third
+
+# The names the kernel matches on are real strings, not just relocations.
+out_strings .rodata.klp.str1.1 |
+	grep -q '\bfirst\b' ||
+	fail "no 'first' string in .rodata.klp.str1.1"
+out_strings .rodata.klp.str1.1 |
+	grep -q '\bsecond\b' ||
+	fail "no 'second' string in .rodata.klp.str1.1"
+
+# The object list has to reach the function list, or nothing is walked.
+assert_reloc_sym .init.klp_objects .init.klp_funcs
+
+pass "klp_funcs lists exactly the changed functions, by name and relocation"
-- 
2.53.0-Meta

