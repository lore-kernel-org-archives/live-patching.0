Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DFC369990
	for <live-patching@vger.kernel.org>; Fri, 11 Sep 2026 18:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789152344; cv=none; b=r9FFdJT0eNGRPvcDabPlZeNykYbStagh+/2xrbJI+e1XCbMAxQwk/bwoiXsboJUxutVwift6fEmSIS7xNxDElyxqsJ8TV76D+C+7UQmw0zJn9fk421/9RTHr8rF+WNLZbacjPraQmpNGRyTsFym3D8rqV6oW2txPn+hXwyOI96U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789152344; c=relaxed/simple;
	bh=fp7uH4g7UVaSHgTTZTyKGs1C4fQ+N2Obxw3D4TSfgEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uwa9SIk8O9TzrL0wzXaJGwiOy2R8ZEjERMC3daCMb8RVpH7TMhMu+DguzClCtlSXQzx0i/i4bm8+eUieftfFU7RPJS+KE6pHOD0gcmuntxsGEiptyGhyoKeJ3qkeoFLs2zWY8gzBcnmULDMH1KIxA7gQ9kBTes5LwyuYw8oQbm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L8uoeYXv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L8uoeYXv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A77F91F000FF;
	Fri, 11 Sep 2026 18:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789152342;
	bh=CT3mBjx9tGaHecf9KO04lllAlSlXs736+0nIt07OCgM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L8uoeYXvQQN81Avi7i6bSv98fMNuDL5jp3Wx5DQuXRd0HbbDx95LwWJc3E984laGO
	 IKlE4ZX6g3rB6q3f3vWKOnRCr3ucG9UQysJB6WrkS4StgjIkU7j+IHoCnm6TZLo3rG
	 cuLwg5tGXwNibT8s6Qi+47fJVhZN/D2e5L3wL1/euLlbzX4lVhhapZSuGtgMG8RtXa
	 m9sowsi8QN4tqwf65Qt8+NSp6hLBb6fG1SerPfib6Xkp/pGPgfpQzocPOD1aVsIcSC
	 vs7S8AJwhO2u7lHBCe9dCN66sI+cetfEXQOZtMbEklysW2Kd0fwpZWZQ3L4e0M3L7U
	 rLDbmAiC9qpIg==
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
Subject: [PATCH 25/58] objtool/klp: Add test for objects without .modinfo
Date: Fri, 11 Sep 2026 11:42:32 -0700
Message-ID: <20260911184305.1457308-26-song@kernel.org>
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

