Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC83E396D19
	for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 23:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789427100; cv=none; b=taE9AAaqkedxehZsGOsk2mvjvv5EohVzkxZXmMkMDqO52whdEVd/GXtIvfFMz8eKDKj8gpigXC+Gk+Ke7DAhlm2mlz/48QwP2f+E6S3+/hBPyLzHU0JIpJEyDp64foa6nljaY0WqWZ/kWuRpZFIYhdRH9nFBxJyw/ei6KlJjiQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789427100; c=relaxed/simple;
	bh=3t9WRMZC3WtGbhP1JpjLx0i5Vd0KR//kh+dHPQzlWkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WcY10aGf7zhv49w0j6PzUtP/bp/IOLBRlXvfdI4vJ/LYxJcKrzgvQUsBqblT2tyP5lQsInVyIFSFqZp9xteZ9XgXGMNlIrtyCh6dN6EJlpFbELeyoSKdb0GqnEHzGz+8vgMrbDA2iLmBJLbHwT8iMC+nVZEiopHO7xCPNBN3Tis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+WabVr2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+WabVr2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 604781F000FF;
	Mon, 14 Sep 2026 23:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789427098;
	bh=rdkE/piEpaHExysLLETiJwi4o//fS58XpKis/FlZSq8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c+WabVr22xqZKEsjeCKjwOiBahcA9xgnt6bns8tttl7yFri7H/m7Af49HoAKvqF5W
	 mzJPLYYQdJ08Y7ZxKu/PmZDT0gwxcOru5IExNTSvL4hdV/XAqyEzBBSmE5ycYI+ppf
	 uq9KZzJm6Z4lcY1RurAzQ/jyk2ECEs1QML+kI4rddccLvW0wo7EXpQ43WS8JDxdF0L
	 yWIGKnxfci7H/pbYqga0/Y1koU2Pogm1RQSOnnDeeI/aNOQWk/To4xBSdDTJ6Bux2W
	 x3LBTOCJe6yLXaGKxQfh55wZQW1J4+9Tl8fBD1SSVbJw4e55GxzPp+eSON8f4GM/Q3
	 40qbdEfluwnDg==
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
Subject: [PATCH v3 12/58] objtool/klp: Add test for rejecting changed data
Date: Mon, 14 Sep 2026 16:03:09 -0700
Message-ID: <20260914230355.3422996-13-song@kernel.org>
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

Livepatching replaces functions.  Nothing can swap a variable which live
code already refers to, so a patch which changes one has to be refused
rather than applied with the old value left in place.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 .../tests/generic/fixtures/changed_data.c      | 16 ++++++++++++++++
 .../objtool/tests/generic/test-changed-data.sh | 18 ++++++++++++++++++
 2 files changed, 34 insertions(+)
 create mode 100644 tools/objtool/tests/generic/fixtures/changed_data.c
 create mode 100755 tools/objtool/tests/generic/test-changed-data.sh

diff --git a/tools/objtool/tests/generic/fixtures/changed_data.c b/tools/objtool/tests/generic/fixtures/changed_data.c
new file mode 100644
index 000000000000..b52461835444
--- /dev/null
+++ b/tools/objtool/tests/generic/fixtures/changed_data.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Data whose value differs between the two builds. */
+
+static const char __modinfo[]
+	__attribute__((section(".modinfo"), used, aligned(1))) = "\0name=vmlinux";
+
+#ifdef PATCHED
+int klp_test_data = 2;
+#else
+int klp_test_data = 1;
+#endif
+
+int target(int x)
+{
+	return x + klp_test_data;
+}
diff --git a/tools/objtool/tests/generic/test-changed-data.sh b/tools/objtool/tests/generic/test-changed-data.sh
new file mode 100755
index 000000000000..c5c7381bb409
--- /dev/null
+++ b/tools/objtool/tests/generic/test-changed-data.sh
@@ -0,0 +1,18 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Livepatching replaces functions, not data.  A changed data symbol must be
+# rejected.
+
+. "$(dirname "$0")/../lib.sh"
+
+setup
+build_pair changed_data.c
+run_diff 255
+
+diff_log | grep -q 'changed data: klp_test_data' ||
+	fail "expected rejection, got: $(diff_log | tail -1)"
+[ -e "$workdir/out.o" ] &&
+	fail "output object produced for a rejected input"
+
+pass "changed data symbol rejected"
-- 
2.53.0-Meta

