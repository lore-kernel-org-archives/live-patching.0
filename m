Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DE21E51E0
	for <live-patching@vger.kernel.org>; Fri, 11 Sep 2026 18:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789152289; cv=none; b=gTtpwdWY/Y4NuJ10NUwqfSIV6E4dwU6ZfanCDi7YMfTXag0MHZGgMqPKp6s5YZ9Nh9Q/ky4AzUJVBv/qYtr7fGZWk8VfFoOHUTDvAQHqPZE4LZ03m+iWuTQd4+2cpk/6H5vnJmCREBl9EcYHL6h+4gH12nKSCFH8jTkg30cM9LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789152289; c=relaxed/simple;
	bh=W4NPEt+p3FChPmFxYWiy5VS3n3K5yKeRwrUCLFBckGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gYkzChZobk/agxSYAcJjaeFzhukoaNR3q2pOOR7QyNl+a0BnLWBBIsmWCE7eNrFYuZAnvSKA2kCyDJv5LPpi786AJw1tMp8MM2wFPvK4v7NdE4U9+HRnGfJieGiSOvAK0kWHFLcP5tURU4Cw3eZj/KE8SbzTAf6Qs36F14ZATyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GWkeLpX2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GWkeLpX2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFC631F000FF;
	Fri, 11 Sep 2026 18:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789152283;
	bh=ITzbXOf/L/LSlJ3Dr0Fwq/vEo/fMWwCzLekzKNox5tI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GWkeLpX2W+B84vTei6E5g3wtRDWJ6aeG/HU4SWzd3FGo4ab9kDjZ75cedaKMnH+4L
	 oV64KcqcEZchljlR7BFzmFH6khBYGt6FTmCwcgXiATMG5rPhMFPvQN2O7f+dUJaN3K
	 z8qhzHbhw6cM2Ajt0zkpgkhkRDEqGj/+T3qM/QEQJbrrv8cf8Q8CDB7fOEfdXWtP3X
	 dZhP4LXBTAzAC3lfi2C+Xr5bkuz6dpKoR4YSPLD5RBGuUdNQxCJUebPFiEBTyTl9xV
	 FD4efd7a9+RFzdNVbFN0AGb6NawgIZDH7ful4YcrjqXc3MMvJn0ha3qTD/OrEI+XBA
	 RbQdXfZWX4VIw==
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
Subject: [PATCH 13/58] objtool/klp: Add test for newly introduced data
Date: Fri, 11 Sep 2026 11:42:20 -0700
Message-ID: <20260911184305.1457308-14-song@kernel.org>
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

Adding data differs from changing it: nothing in the running kernel refers
to a new variable, so it is safe and has to travel into the livepatch with
the function using it.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 .../objtool/tests/generic/fixtures/new_data.c  | 18 ++++++++++++++++++
 tools/objtool/tests/generic/test-new-data.sh   | 17 +++++++++++++++++
 2 files changed, 35 insertions(+)
 create mode 100644 tools/objtool/tests/generic/fixtures/new_data.c
 create mode 100755 tools/objtool/tests/generic/test-new-data.sh

diff --git a/tools/objtool/tests/generic/fixtures/new_data.c b/tools/objtool/tests/generic/fixtures/new_data.c
new file mode 100644
index 000000000000..c82770b126fe
--- /dev/null
+++ b/tools/objtool/tests/generic/fixtures/new_data.c
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Data introduced by the patch. */
+
+static const char __modinfo[]
+	__attribute__((section(".modinfo"), used, aligned(1))) = "\0name=vmlinux";
+
+#ifdef PATCHED
+static const int klp_new_data[4] = { 1, 2, 3, 4 };
+#endif
+
+int target(int x)
+{
+#ifdef PATCHED
+	return x + klp_new_data[x & 3];
+#else
+	return x;
+#endif
+}
diff --git a/tools/objtool/tests/generic/test-new-data.sh b/tools/objtool/tests/generic/test-new-data.sh
new file mode 100755
index 000000000000..83b72125b1e9
--- /dev/null
+++ b/tools/objtool/tests/generic/test-new-data.sh
@@ -0,0 +1,17 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Data added by the patch has no counterpart in the running kernel and must be
+# carried into the livepatch.
+
+. "$(dirname "$0")/../lib.sh"
+
+setup
+build_pair new_data.c
+run_diff
+
+assert_patched target
+out_symbols | grep -q 'klp_new_data' ||
+	fail "new data was not carried into the patch"
+
+pass "new data carried into the patch"
-- 
2.53.0-Meta

