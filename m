Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B27438470
	for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 23:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789427165; cv=none; b=L+ncfdMMU+7tJMvtdpIoKWBt1wozK1cDEn1TXIkpTHFIY7N82Pwb+ZMM8v/usw9IpKbGNP2/hlkR9BNyJ4lYLfEDa1DPN5q+GSaOuLgLDSBsWkQfgO7XOvK4w1rI7LXiJOgUxYLTeTy8+vcJUQmOrU/Jcxy+Vv5xsE+rMTPXQLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789427165; c=relaxed/simple;
	bh=fp7uH4g7UVaSHgTTZTyKGs1C4fQ+N2Obxw3D4TSfgEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tGf0ypsH3PmMdb0qJjf2Q3id7VGxYjERkGZlXe86TyOuTPCep2BT5MaGp6REcQDL1Lqpj4xgOvyrS9VRIJJHYJh/jnVh9sC/4XDdBBXOEcdxGj0qC9KHpkhOmMnLOUCUYmt5qbQPpNCrFRDdAVsgd3Yx/KXna+518FpR9zjxqG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GcKG87W/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GcKG87W/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 023141F000FF;
	Mon, 14 Sep 2026 23:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789427164;
	bh=CT3mBjx9tGaHecf9KO04lllAlSlXs736+0nIt07OCgM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GcKG87W/lCLYR3VxOzRGDJU8tflNeKvCvzjXA2DhGAes2YxKRCVOMpGQZDBomKJXu
	 sLdfqWZkoYdb+VXy/FNMiV+6ifRLJYaIJK4Dzf2Db5K23rrhWCXIsse8vK+71a8V4h
	 raqd9QPVMHtQLHhWCHBmq79Xd6lWu51UoU6Do8j9Ey+S1bVl2QwestXhKv4wQDIbN5
	 qoJRHbGxlX+KrwL2yloV4pmqDITw4TybYk9wPMamwrHm3mTvdQjucU2SS6Q5Us4rvH
	 OSRYLKNH83jR409Oyzrb2If47qsZpI7yP6hOr7tMkn+L83enaLj/JXP5wVGw4sR6WI
	 jD12sqF+8Dysg==
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
Subject: [PATCH v3 25/58] objtool/klp: Add test for objects without .modinfo
Date: Mon, 14 Sep 2026 16:03:22 -0700
Message-ID: <20260914230355.3422996-26-song@kernel.org>
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

The module name recorded in .modinfo ends up in the livepatch's klp_object,
and also decides whether a static branch key counts as belonging to vmlinux
or to a module.  An object without one cannot be diffed.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 .../objtool/tests/generic/fixtures/no_modinfo.c  | 11 +++++++++++
 .../tests/generic/test-missing-modinfo.sh        | 16 ++++++++++++++++
 2 files changed, 27 insertions(+)
 create mode 100644 tools/objtool/tests/generic/fixtures/no_modinfo.c
 create mode 100755 tools/objtool/tests/generic/test-missing-modinfo.sh

diff --git a/tools/objtool/tests/generic/fixtures/no_modinfo.c b/tools/objtool/tests/generic/fixtures/no_modinfo.c
new file mode 100644
index 000000000000..e46374702b1a
--- /dev/null
+++ b/tools/objtool/tests/generic/fixtures/no_modinfo.c
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Deliberately has no .modinfo section. */
+
+int target(int x)
+{
+#ifdef PATCHED
+	return x + 2;
+#else
+	return x + 1;
+#endif
+}
diff --git a/tools/objtool/tests/generic/test-missing-modinfo.sh b/tools/objtool/tests/generic/test-missing-modinfo.sh
new file mode 100755
index 000000000000..6f242f7eb756
--- /dev/null
+++ b/tools/objtool/tests/generic/test-missing-modinfo.sh
@@ -0,0 +1,16 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# The module name in .modinfo ends up in the livepatch's klp_object, so an
+# object without one cannot be diffed.
+
+. "$(dirname "$0")/../lib.sh"
+
+setup
+build_pair no_modinfo.c
+run_diff 255
+
+diff_log | grep -q 'modinfo' ||
+	fail "expected a complaint about .modinfo, got: $(diff_log | tail -1)"
+
+pass "object without .modinfo rejected"
-- 
2.53.0-Meta

