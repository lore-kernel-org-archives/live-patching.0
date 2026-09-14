Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559FD3D9DBB
	for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 06:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789367221; cv=none; b=gYpL8ZF7ALe/6vgjKwqcYbzVwfSR6trFYvqxw+Y2FIzOPU3q1jSy3MCQDGuXRGdfARezV4cK60oQ+q2kp+SxIgYVw+C9LvaP05sED6W28SaR+pZKxP1xtNbKfpVTVm55zb5ZOpJTS3YPZ2UM5BDmALJ2y64zWNyqQTGN1Oyy0sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789367221; c=relaxed/simple;
	bh=jcR8/8HKeHYyzaDfMvQrS9axGwk7wR4Y6O+9FGsvleE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dHBX7NWLFxURPZ6pAp735iRGamXR+TQ00F9lVIt0McsjGysB3MnojeruZ+fLjajq5Z4sBXGg6yju4tSCwh34/w4rf0G94ZTtR6lJLzHQ05+Zf3RFzenYdXnu8bHAFTJFKP2dvaqsKPseP6haaqitjWvKBO4X0JkjV1/pdVUVp4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YUxj8Amt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YUxj8Amt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 393A71F000FF;
	Mon, 14 Sep 2026 06:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789367215;
	bh=pvxTvD4V+/5uvWVDuum6FbRw2I6Utf/mI+Eqsh/c8p4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YUxj8AmtxVvClzW7jvSfNmcMrgnkBqmfsfoJ7XRvNNtefBXW1FHhkovHdpnNwqHhG
	 FLSNncV2noEd2xxhXOO+xf4BBZsZ5bOJ5MuQcW/kDUACdjMwdIsRciTHN2z8f7ajf7
	 WXMgYW3IRRiyYCJFiiggK62OgGCZs+rqcMv2/XKdO/xKx8/8wWWdGphh+/pxwuFQaT
	 utJ/izpztOcppYaEiqx3itZrmqM9djrddwtyxvD7Ry7pEi9zt8X9sbzTahHHtVZRWn
	 NsDvHWm9X+Oq3EBDORKS7SpB3XLxpdRzoLYuzxMcWk+X2WD2U/HxIiBpSZfSwdhUtu
	 A2KSlaqNRqmnQ==
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
Subject: [PATCH v2 16/58] objtool/klp: Add test for cold function halves
Date: Sun, 13 Sep 2026 23:24:32 -0700
Message-ID: <20260914062514.926997-17-song@kernel.org>
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

The compiler splits unlikely code into a separate foo.cold symbol.  Both
halves are the same function and both belong in the livepatch: carrying
only the hot part leaves the cold path branching into unpatched code.

GCC needs -freorder-blocks-and-partition to split reliably.  The flag is
probed rather than assumed, and the test skips when the compiler declines
to split at all.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 .../tests/generic/fixtures/cold_function.c    | 21 ++++++++++++
 .../tests/generic/test-cold-function.sh       | 34 +++++++++++++++++++
 2 files changed, 55 insertions(+)
 create mode 100644 tools/objtool/tests/generic/fixtures/cold_function.c
 create mode 100755 tools/objtool/tests/generic/test-cold-function.sh

diff --git a/tools/objtool/tests/generic/fixtures/cold_function.c b/tools/objtool/tests/generic/fixtures/cold_function.c
new file mode 100644
index 000000000000..f6d410983ce2
--- /dev/null
+++ b/tools/objtool/tests/generic/fixtures/cold_function.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Function the compiler may split into a hot part and a foo.cold part. */
+
+static const char __modinfo[]
+	__attribute__((section(".modinfo"), used, aligned(1))) = "\0name=vmlinux";
+
+static void __attribute__((cold, noinline)) slow_path(int x)
+{
+	__asm__ volatile("" :: "r"(x));
+}
+
+int target(int x)
+{
+	if (__builtin_expect(x < 0, 0))
+		slow_path(x);
+#ifdef PATCHED
+	return x + 2;
+#else
+	return x + 1;
+#endif
+}
diff --git a/tools/objtool/tests/generic/test-cold-function.sh b/tools/objtool/tests/generic/test-cold-function.sh
new file mode 100755
index 000000000000..dd4a7297af04
--- /dev/null
+++ b/tools/objtool/tests/generic/test-cold-function.sh
@@ -0,0 +1,34 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Both halves of a split function belong to the patch; carrying only the hot
+# part leaves the cold path branching into unpatched code.
+
+. "$(dirname "$0")/../lib.sh"
+
+# Clang does not split functions into a cold part at all, so there is nothing
+# for this test to look at there.  A given gcc may or may not split, which is a
+# version property rather than a compiler choice -- that stays a probe below.
+gcc_only "clang does not split functions into a cold part"
+
+setup
+
+split_flag=-freorder-blocks-and-partition
+cc_supports "$split_flag" || split_flag=
+
+build_pair cold_function.c $split_flag
+
+in_symbols orig.o | grep -qE 'target\.cold' ||
+	probe_skip "compiler did not split the function into a cold part"
+
+run_diff
+
+assert_patched target
+# Not a bare name match: had the cold half been left behind, the branch to
+# it would appear as an undefined .klp.sym.vmlinux.target.cold, whose name
+# contains the one being looked for.  Require a defined symbol.
+out_symbols | awk '$7 != "UND" && $8 ~ /target\.cold/ { found = 1 }
+	END { exit !found }' ||
+	fail "cold half was not carried into the patch"
+
+pass "cold half carried into the patch with its parent"
-- 
2.53.0-Meta

