Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4544A263D
	for <live-patching@vger.kernel.org>; Tue, 15 Sep 2026 23:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789515380; cv=none; b=HThEJwIKPddhWmrbcFA40766wChkebiKGVLC/IznbeauLpI7hT+qMEb/o71I/vAyYKRQfekhahbVCnuXzHaTNYVyKOoHQl+4yuXcXR7v80HHS1fvfB3CnDdpK4CuBMQIPfmtw7L51HaqNZLNG8B0MrYZeRaJm/YBPOSzk0B8Y0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789515380; c=relaxed/simple;
	bh=ml/f8nqA4ibqKUvQWhl1acFHTRxeReIiAvavsC8IbXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rm9bQ5IFzgR05lRGG6fWgh0xyZPh1k1IEt4HjoeWztYF88+n1brXiCpSjyOCM77u9yRvJE47sIM5f0Lrbchtxz6HxcGmUTRWJ/efoAFMCA4ZmjKOu1VZjaOzYrSTiuDf4xnshJYfwe5prVEQTECU35uDG7XrRxE2k7FQ6yPaCN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GRJ/9+QI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GRJ/9+QI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 962741F000FF;
	Tue, 15 Sep 2026 23:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789515378;
	bh=IQ3ROVN0OQnk/d+FpIVlRkjAL/7xhB0qAcEh2kSHZDA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GRJ/9+QIZRk6sBjS8Y+WmhSLeQxv2tafuHdzFTek2lpHNyWMHUakaKiuaVx/V2Sf6
	 zuiiyy4R/qpqBe8eiPvnCvocfygWRLWsiQpDHs5tXBNq0dA5jgqZ4P1uiyqtsvjkWX
	 FaAPT7jB3i6+KKF6Vd8oQjx8Rb579c0d/DY9KrQ0EiOfnf7gb+kZVwRncO7Ic/K0bk
	 Oapt+OlIBc1a1kiKk/UbApNEW0tC3XtOt0/s0vrl3tElgE2B816j6hr4jV29FQNLMO
	 nxbHRvYvGR5vQMuKnT9M5mIBYodLZLbX9/z9koLb5Jh7d2wmwuqfBfj9B4oi7YKo/a
	 y0+z+NsRZo9vA==
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
Subject: [PATCH v4 14/58] objtool/klp: Add test for newly introduced functions
Date: Tue, 15 Sep 2026 16:34:10 -0700
Message-ID: <20260915233454.2405019-15-song@kernel.org>
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

A function added by the patch has no original to correlate against, and
still has to be carried into the livepatch or the changed caller ends up
referencing something which does not exist.

The helper is noinline so the case survives the optimiser; otherwise the
compiler folds it into its only caller and the test covers nothing.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 .../tests/generic/fixtures/new_function.c     | 21 +++++++++++++++++++
 .../tests/generic/test-new-function.sh        | 16 ++++++++++++++
 2 files changed, 37 insertions(+)
 create mode 100644 tools/objtool/tests/generic/fixtures/new_function.c
 create mode 100755 tools/objtool/tests/generic/test-new-function.sh

diff --git a/tools/objtool/tests/generic/fixtures/new_function.c b/tools/objtool/tests/generic/fixtures/new_function.c
new file mode 100644
index 000000000000..e7886eaaff3e
--- /dev/null
+++ b/tools/objtool/tests/generic/fixtures/new_function.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Function introduced by the patch.  noinline keeps it from being folded. */
+
+static const char __modinfo[]
+	__attribute__((section(".modinfo"), used, aligned(1))) = "\0name=vmlinux";
+
+#ifdef PATCHED
+static __attribute__((noinline)) int klp_new_helper(int x)
+{
+	return x * 7;
+}
+#endif
+
+int target(int x)
+{
+#ifdef PATCHED
+	return klp_new_helper(x);
+#else
+	return x;
+#endif
+}
diff --git a/tools/objtool/tests/generic/test-new-function.sh b/tools/objtool/tests/generic/test-new-function.sh
new file mode 100755
index 000000000000..b0b7f6443110
--- /dev/null
+++ b/tools/objtool/tests/generic/test-new-function.sh
@@ -0,0 +1,16 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# A function added by the patch has no original to correlate against and must
+# still be carried into the livepatch.
+
+. "$(dirname "$0")/../lib.sh"
+
+setup
+build_pair new_function.c
+run_diff
+
+assert_patched target
+assert_symbol klp_new_helper
+
+pass "new function carried into the patch with its caller"
-- 
2.53.0-Meta

