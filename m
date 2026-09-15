Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894D04CDA34
	for <live-patching@vger.kernel.org>; Tue, 15 Sep 2026 23:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789515437; cv=none; b=YeY3mpu20rIaakrV8dusr2AQUmHBUHYl0N3+3DxqAevkJ5kp5SB1If1ha7qFi/i8ABmG29dEd0EanB8xWFlXz2EKZ6z3rqjLz2lRzhPp6gkVrb418MN8xNJFHbzCHy9YfzsOzp7gr8X9tSZOdWlotnqZnEgCCw/5P8Ftl+Ano6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789515437; c=relaxed/simple;
	bh=fp7uH4g7UVaSHgTTZTyKGs1C4fQ+N2Obxw3D4TSfgEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qCyocyX128SDAXEdHZFz5gED6xV5bx9qClILu93dPZyX/cfmlonUnn9RWWczlE+NWBoraLKHGpsWZ7OIglIsT8EKvbzTy1/y9De3HpDlSgSDL1HJkdp269Hrwy6AhD/x/hf1Vb65BeGq8gun92BxFpJ7iJDvtDGQMmDt1UHz3zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hBXqkEiZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hBXqkEiZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B27C1F000FF;
	Tue, 15 Sep 2026 23:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789515436;
	bh=CT3mBjx9tGaHecf9KO04lllAlSlXs736+0nIt07OCgM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hBXqkEiZmBbjjTEWnXXZvn3bUihLYQhwi/HaBMemlWBAt+g16VcslmScOfMGIKmJ0
	 fQgIaE+dl0ByXJra4p1tGuGOyibavHWpLS8MovEc+lOnVhxXLJBq8+uSBtpJLln3n7
	 jASlyh/dElzCJeRMG7BvBLrQ2RwH4Lc1tgl90c9zNwGaitevlwjOMc2pW6VT3VfBRb
	 5qaSSFzBtu7ayqUMyTr6eqm+ZJZ5VJdIQXE/5UpH8LFj6VT3hQD9WPnqo/2tUDowd1
	 XTk/STSgNE1LsTjOs3ZLJpn33LL5N+f7YgrL7OGhqUuRWd1JxpDP5SleuGR/6rhfEy
	 NBvXQOd3JSMeg==
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
Subject: [PATCH v4 25/58] objtool/klp: Add test for objects without .modinfo
Date: Tue, 15 Sep 2026 16:34:21 -0700
Message-ID: <20260915233454.2405019-26-song@kernel.org>
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

