Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C45D2EA15C
	for <live-patching@vger.kernel.org>; Wed, 16 Sep 2026 18:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789584331; cv=none; b=cqXU+Moc/mxTN1YROtohISaumxMN8YicqFB+qe5VQ4HAdI8eyCJ7VP954CtMhjFdQfGOmOzEW96YIoRq/sXF9B6OYfgneepesjqL7splDwR4T2d2FF59+Om7Vo9YH2dfKKjg+MgjXYv3K6wFHr7VvDtKlOznFA/hulwb2+Z61FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789584331; c=relaxed/simple;
	bh=TeBCBQEh9FXoC0p5Qt9WsOkQAp3GypYlwrMHrfvhIu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ffhvQBVmp961DYxwKt5TJ8fdqtdOD/5bG63tPBfijOLzmaWgWNIe/fBYeHxPnHdlhmNFL2KmMvBbvO3SILPBBF4ioPfYqSosuIKd9hEcSVW/ZOAUsqYfzB2/XNvn4KTEXJ9IZIKV6WaotaC1zht5GMdDugYD46H2AuKWMr8dc5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mxP6xSix; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mxP6xSix"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1742F1F0089E;
	Wed, 16 Sep 2026 18:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789584315;
	bh=WqoDPyFRb55TWQgk/KYiqUJmprXSHXdoy54Mayg7czQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mxP6xSixLWFWtuLAqpjFfueS1IJ1N/WOTAmCENofqekA8mjmiATiFqJqAhi91SQyL
	 r+QVUwNcsnHgFbYHIOzqnVs2Kqa4LXr0wm7QfOlY+fDEgf2vl+0KpTGm4f8TjBfdhv
	 W6cI7y2NU+S3e9WCkz7Z9fCh3GBUSUDbihKY96G6XOytSLa28XGdu7TRSpN8G3jNo2
	 1CD+d98FK5dDnVNXgEMReoVG+6EBycIKQKuCstkm5PXECBMtwIk6F1UqcipYNVVMIk
	 uA42stU2zHWyEzSuI94wu3O4mH6MYC/INjp/IsQ6lxThapbJYlmnC9qut5O8tu0I9X
	 JtEZbJCGp33OQ==
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
Subject: [PATCH v5 16/58] objtool/klp: Add test for cold function halves
Date: Wed, 16 Sep 2026 11:43:09 -0700
Message-ID: <20260916184351.2720310-17-song@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916184351.2720310-1-song@kernel.org>
References: <20260916184351.2720310-1-song@kernel.org>
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

