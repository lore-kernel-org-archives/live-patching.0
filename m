Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA0A4CDA30
	for <live-patching@vger.kernel.org>; Tue, 15 Sep 2026 23:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789515375; cv=none; b=iH7xpXZBYp9ZbtII3/jXOih7VJ4xRj5z1wBOotsTIsHgr4cDtAAzjuEQUj6QP8VOLRsAAAA051bDVFdUhkteslIIpT1pfpgiUtEe6lfU4CeqJoGaO81eK0fhvRs2EqIsac63/fdvrpz+0oefRC3FZgKhLU7jqoS/evtDnZWT4OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789515375; c=relaxed/simple;
	bh=9ytSFPk/zV9LwXcHFqEhXVMHSlmttVilC2p+rWqLvA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QCoHrqhNZjoXsscRoOme+jA8j/+4qBCceOKcC6oPKaGjRZcLwBzlD//6bj1B65CkPQDOiAiPr26IxVlM8kFx+C3Fy+vjClq42cJFvPZ/c4v+BR8ZjGD1jJFEGdF5c0o62kKAErKsp5IueSBm/feQQpx4WAGi7Gun4x3swtZE8bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N1HNS6/K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N1HNS6/K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 594301F00893;
	Tue, 15 Sep 2026 23:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789515373;
	bh=9ryHY9krSPc36qEqiezpF3xvGthQaxlMavUa3P1vP7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N1HNS6/KhldjXoEW3cRm2ntPZ1oGjITtWlime18Wp8uPoFJ3oGHXBdZRR2gr5HbUS
	 T2goYoujjMNdFmbJeSZxCXGj1V6yFjJ1gB8Tgwxn5x1rWf++yn3pQJ08T0u5exvmWk
	 mHp8nYKrwXQoZS580fYlsUkD21txyzIp/qkvjFvGAAG/IXAJ6+qAE/WGCryEhJrV8h
	 7Q8kqf2wrHCnpZcF3f1IIRyYRUbeLEsJYZcvw9z+YfFGZb7Arhsu8peGw5cd8UsmsY
	 YfM7U4ZXc8O/UQV5TqStjj3yE94LD7HM0FfeHh3LKKzMCH7g1TqqCzuubeYuYbLqaT
	 p5EV9b1xQU0LA==
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
Subject: [PATCH v4 13/58] objtool/klp: Add test for newly introduced data
Date: Tue, 15 Sep 2026 16:34:09 -0700
Message-ID: <20260915233454.2405019-14-song@kernel.org>
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

Adding data differs from changing it: nothing in the running kernel refers
to a new variable, so it is safe and has to travel into the livepatch with
the function using it.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 .../objtool/tests/generic/fixtures/new_data.c | 23 ++++++++++++++++
 tools/objtool/tests/generic/test-new-data.sh  | 27 +++++++++++++++++++
 2 files changed, 50 insertions(+)
 create mode 100644 tools/objtool/tests/generic/fixtures/new_data.c
 create mode 100755 tools/objtool/tests/generic/test-new-data.sh

diff --git a/tools/objtool/tests/generic/fixtures/new_data.c b/tools/objtool/tests/generic/fixtures/new_data.c
new file mode 100644
index 000000000000..ac364622f12a
--- /dev/null
+++ b/tools/objtool/tests/generic/fixtures/new_data.c
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Data introduced by the patch. */
+
+static const char __modinfo[]
+	__attribute__((section(".modinfo"), used, aligned(1))) = "\0name=vmlinux";
+
+#ifdef PATCHED
+/*
+ * Not an arithmetic progression: { 1, 2, 3, 4 } indexed by x & 3 is something
+ * a compiler can compute instead of load, and then target() has no reference
+ * to the array and there is nothing for klp diff to carry.
+ */
+static const int klp_new_data[4] __attribute__((used)) = { 7, 3, 11, 5 };
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
index 000000000000..acb68ff19c99
--- /dev/null
+++ b/tools/objtool/tests/generic/test-new-data.sh
@@ -0,0 +1,27 @@
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
+
+# State the premise on both sides.  The array is new in the patched build and
+# absent from the original; if the compiler folded it into the code instead of
+# emitting it, the assertion below would fail without saying why.
+has_input_symbol "$orig_obj" klp_new_data &&
+	fail "fixture put klp_new_data in the original; nothing new to carry"
+has_input_symbol "$patched_obj" klp_new_data ||
+	fail "compiler did not emit klp_new_data; the fixture tests nothing"
+in_relocs "$patched_obj" | grep -q 'klp_new_data' ||
+	fail "target() does not reference klp_new_data; the fixture tests nothing"
+
+run_diff
+
+assert_patched target
+assert_symbol klp_new_data
+
+pass "new data carried into the patch"
-- 
2.53.0-Meta

