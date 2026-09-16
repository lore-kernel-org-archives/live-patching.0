Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16F448FF80
	for <live-patching@vger.kernel.org>; Wed, 16 Sep 2026 18:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789584325; cv=none; b=eDrLCL4MFHnbyywNlJaMs6YZ/3xwWnMp23JTVXuZh6U7B+szmkg5yFPEBB9qxM/EPQIcJj2g7dwBY7BCCQzcyZCFL0qWq9tOx3082ZJSkuCA/wc/fuVO4hIgUWN/1aF2BZUvVRoJnhlFUTmC1iXFNmoUSsZYqV22gmDHnbmL8XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789584325; c=relaxed/simple;
	bh=ml/f8nqA4ibqKUvQWhl1acFHTRxeReIiAvavsC8IbXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uE3Ou2THD9Kn30X14QvIvkm7gm8UWPZlxBFfo4RRWXfVx28qgEae8WjvcRHFSd4PNU0IgnFcfqK4IQH7UgQe9UpR6+W73FzF5X7QW9ZGxY+Feajkzuye/48O7cfRscmFr4Oi0+zj0XnyZa0xsrBPw5D/xj/Ey6qhq+hlcawVEOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H0rxE3zs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H0rxE3zs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 724471F0089C;
	Wed, 16 Sep 2026 18:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789584305;
	bh=IQ3ROVN0OQnk/d+FpIVlRkjAL/7xhB0qAcEh2kSHZDA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H0rxE3zsMR8vp7OgfRIJo+/DAkyRnAHHbzwmuNJ1lB2ECZlVgscPXafjNTdELibrx
	 JEK21ZHJIRz/kBMtFUtZsqOxm+yDeOq1Ymge/OSIqE67kJPAyDU1aePEtMqwwI2Pga
	 afonj1Sy/aAaiKJj8UT+hnzHFasJEuKzkvyZ049nd0TMJ545J8tGG58sOIlwki4n3i
	 QZqyA99moXm1G5AZRSmHmwf2USs8dVGqmrh1glIZobw4JWk6osJ1w7HtRRYG8ME8Rk
	 ZZSJt03YHjtUScLlMRsiVjWFQMYwinzvumLxIlUXbweI2crKXPyDlr+ceeNeWDtac+
	 QYwNSrzrhJCiQ==
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
Subject: [PATCH v5 14/58] objtool/klp: Add test for newly introduced functions
Date: Wed, 16 Sep 2026 11:43:07 -0700
Message-ID: <20260916184351.2720310-15-song@kernel.org>
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

