Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2952426429
	for <live-patching@vger.kernel.org>; Tue, 15 Sep 2026 23:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789515390; cv=none; b=k0DJEQMG1qWirK/3mubNYLK37bKVMZmkg112XyngTywrjjkm+mzWsWB3WFRgn2Rr6/o/OtwdNtELYWt79Re/YZIColCTslaJa6NZGbcgZpdVEu89EQi/ytq/rf+HWskjgf8fLl6X8/zaKVSOrpKvMGn8by7URPuEEr9WDcNKHGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789515390; c=relaxed/simple;
	bh=TeBCBQEh9FXoC0p5Qt9WsOkQAp3GypYlwrMHrfvhIu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uqe1BrsA39wRyhTL4uyvMar8SsXitRoBRJEM1d+ebpz6q4OFnpU8jL5rA186/AylR4u6qrpytTobTznZWtdTSV+41UeUEL1w2LGCKlR5V1L9rxAW2H6Ag8iz4vED0p7jgPE4PiEIXo8e3367/3mGXBo8B6dMzXmPguKQHDdLX5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q7RW82Au; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q7RW82Au"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2795F1F000FF;
	Tue, 15 Sep 2026 23:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789515389;
	bh=WqoDPyFRb55TWQgk/KYiqUJmprXSHXdoy54Mayg7czQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q7RW82Aup+WhMjXwZ3BOJ7lfRwT83iYeOJz5JaUnlWl/XuTy6OOQk2RkAKtMYAtGP
	 HSfMfFqx+GiB42kAu9SWto5r5Rr/mu+W/qMyCLvS15Nq2f0Bi1yFobSyFLsgYtF1Kk
	 Fb01zRlh21OyExx1c0wU7uFX9WEzH9WZYU5tC0EYNluZH162zCjjPeo+ZOUVjXWn8Y
	 yvWoNzUqYvgHkBwxwarq2/T0UJJQ24GJv2i9IJz/q9WNCuIoyXYRI+vHbd7JGeVUf0
	 tSitxn48xZ0dl7VqVZfXSHlmAN+zKrIBqX04tdNVfiDar6yHkJd5Xn/feghutyWROQ
	 8CNp+4cxfTauw==
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
Subject: [PATCH v4 16/58] objtool/klp: Add test for cold function halves
Date: Tue, 15 Sep 2026 16:34:12 -0700
Message-ID: <20260915233454.2405019-17-song@kernel.org>
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

