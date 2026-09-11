Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C464B1473
	for <live-patching@vger.kernel.org>; Fri, 11 Sep 2026 18:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789152289; cv=none; b=u2gO+DAzx6uJrmEGqUKAw/X+PerNUJd5hOLCgXThnQs19txnDGH6ERSbqNzpeUEzLcpnF++kuebmWIM3+kq+P/D8dgTht+DpDZohK2TJs976c1HuHQT3H2EytIrPnMMMuFSgxu6LQQCaHuqeIr8xasXUsnQeTTsh/7Jw6kvbgB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789152289; c=relaxed/simple;
	bh=oK8GG7uo6A+2nnzoCoClQnNMbEpNGvpwMLzAJcGDSf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TtCoG+W5Ix2+N0xamAAal9CZLuicwrmD55jiHjJIEogXNu7qfmZZ2BziCcbglW9306LRWfSkSj3QTK25K43Zq9jBOaoC/gJPcG850gxmHW3rWDAeVpxTu3Oc2E+a0jUTGxfWXtTmrB8dp1oBIgs304cIW7m3KQlntVVtjbwRQe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D+lR7aE5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D+lR7aE5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E74001F00893;
	Fri, 11 Sep 2026 18:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789152288;
	bh=yx/wdZQ6aZyXuUMAHgYHnXv7h2ZvkfZRGWGF1btfdQg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D+lR7aE5Hh5/EuNgtAJennjxkSR+Cmmeo9ybIPqahahbC+eSEH4CfEjuHkuIr2v5Y
	 lNDtr9mrszTx5xISWyP7wAF5cY0SSM0bDH6ht9ltN26LzAkGbIVGPlI1HJGiy06GE8
	 BaksrEt75Bt6ZORLBoi7wetenwnYXvyZqJkz/zn+KMSiIPG5Y/nYmlYUOKPgxqvxEN
	 0HmW7J+qqAJYQtDpIPGlmYlT+oxZi2joa7cDWfMQ57+Ijm/LZbKZhRU+ToGGo230E1
	 nOnGJcjuDy+wLoJFG8p7aHWrR7boExwgxt/XfLE86OqXh5rRdlHCsHSSqNKUh026R4
	 3fiEC4dgTP6Iw==
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
Subject: [PATCH 14/58] objtool/klp: Add test for newly introduced functions
Date: Fri, 11 Sep 2026 11:42:21 -0700
Message-ID: <20260911184305.1457308-15-song@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911184305.1457308-1-song@kernel.org>
References: <20260911184305.1457308-1-song@kernel.org>
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
 .../tests/generic/test-new-function.sh        | 17 +++++++++++++++
 2 files changed, 38 insertions(+)
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
index 000000000000..17af18545b7d
--- /dev/null
+++ b/tools/objtool/tests/generic/test-new-function.sh
@@ -0,0 +1,17 @@
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
+out_symbols | grep -q 'klp_new_helper' ||
+	fail "new function was not carried into the patch"
+
+pass "new function carried into the patch with its caller"
-- 
2.53.0-Meta

