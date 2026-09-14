Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D092B395AE4
	for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 23:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789427119; cv=none; b=p8thKndquoGMMRoj6a/jA5Gi2DyFSg3oWbbXuUvmeGr73fxuiilpo0kZIVAms404e/3NEWO7auRcIKXTmf0iS6VT2BXRsTDo5bz+Ce/uwyW56mcNza7SvmjT4kGLhP4tfbmnIZQtTlz53PMko6wdzKwRV+i0Z0jvLb5SVfNIrYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789427119; c=relaxed/simple;
	bh=TeBCBQEh9FXoC0p5Qt9WsOkQAp3GypYlwrMHrfvhIu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rwiVfxEIfojC+POA9M9Th1G8WFvB8jMrVB97a+WqbPJa5YkwI2iUnssKCSJrOgMsqBftYMGFPrkHVfObSEOah3rC0QQIJKKpykXyi2yAuIc7mM8evrFSUNcjbD2PmjZ8EAtAYDgpcBHledOGp4jmfpMuJqkVUswUY5z2AfkNlbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NFRgAz3V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NFRgAz3V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93C5C1F000FF;
	Mon, 14 Sep 2026 23:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789427117;
	bh=WqoDPyFRb55TWQgk/KYiqUJmprXSHXdoy54Mayg7czQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NFRgAz3Vgez+ykcQ8cUXqDXX99dKZ+joir1JptRMLZGPw9SxzVnk31IGwKJE5saBS
	 lAZyFjfij4Ux8dDaBJFYa5fl/YS7D/AHBjOOLH01Brj0fta7Ot7n7vMa6G2f9E4nbn
	 rZAp4bxfs2uxVrhUPnTMw2yiSw7DakjKKFo2TEhSzYrH17XK4mDqS5tQ7gr5U1oHRC
	 6y0s1D7kk4FXjb9ZQqPtMGyf9ROW9oSXbuHOJXLSCNGY7xiQofEH3dGYY+M6ua1ldW
	 G/gPXktQitP382odceTk/Ap/ZzBXPsSiEBUPuWDOa/dsNxZzV3lYMsKo1nBXkU7KbQ
	 PS2nz8PNw/nuA==
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
Subject: [PATCH v3 16/58] objtool/klp: Add test for cold function halves
Date: Mon, 14 Sep 2026 16:03:13 -0700
Message-ID: <20260914230355.3422996-17-song@kernel.org>
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
 .../tests/generic/fixtures/cold_function.c    | 21 ++++++++++
 .../tests/generic/test-cold-function.sh       | 39 +++++++++++++++++++
 2 files changed, 60 insertions(+)
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
index 000000000000..a02652fe5341
--- /dev/null
+++ b/tools/objtool/tests/generic/test-cold-function.sh
@@ -0,0 +1,39 @@
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
+# Find what the compiler called the cold half -- target.cold, target.cold.0,
+# depending on version -- and name it exactly from here on.
+cold_sym="$(in_symbols orig.o | awk '$NF ~ /^target\.cold/ { print $NF; exit }')"
+[ -n "$cold_sym" ] ||
+	probe_skip "compiler did not split the function into a cold part"
+
+run_diff
+
+assert_patched target
+# Match the name field exactly, and require it to be defined.  Had the cold
+# half been left behind, the branch to it would appear as an undefined
+# .klp.sym.vmlinux.target.cold,0 -- a different name, which happens to contain
+# this one.  Asking about a column instead of the name would not tell them
+# apart: readelf prints SHN_LIVEPATCH as "OS [0xff20]" and llvm-readelf as
+# "OS[0xff20]", so the fields either side of the name shift between the two.
+out_symbols | awk -v n="$cold_sym" '$NF == n && $(NF - 1) != "UND"' | grep -q . ||
+	fail "cold half ($cold_sym) was not carried into the patch"
+
+pass "cold half carried into the patch with its parent"
-- 
2.53.0-Meta

