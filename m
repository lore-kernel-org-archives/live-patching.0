Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C91D3749EF
	for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 23:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789427104; cv=none; b=O3cxGyYyRMEDZNRfoOsIAE/RLZtlaFQRzxkMnHmE8Rhk50+uh5Jpic+F/Nile4tG93gTbhGfFs0jXm7nZaO7jhj9HE5vtN17qahYBDiaPGcnfpy08HRhAkr2ZihCDVbxA04KTc5+d53ZMzSy3eh3UezejJFeZqDCtad1vKRuYAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789427104; c=relaxed/simple;
	bh=9ytSFPk/zV9LwXcHFqEhXVMHSlmttVilC2p+rWqLvA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z1IKuB6etBI9wQ4D/k9X4Of/C0Z1y/GwAc/YiILVc3OCXbvSy3peHHE7aX+/hQ00LA2NTP4WdSb9kRR2jBCjk+3/EABMYz19RryLm9Hxrv4quFPQ6o6xaLqn3ckgTesHbx2QeZVDx4cIkdOvewU2VJ37XZl+Q4FVnxKQXGOBBp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=otSserGw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="otSserGw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A1EC1F000FF;
	Mon, 14 Sep 2026 23:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789427103;
	bh=9ryHY9krSPc36qEqiezpF3xvGthQaxlMavUa3P1vP7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=otSserGwSJffv5qZj0YAxzxHWJERJ0+0Y8eg6wh2/pGsdU5UjY8xTTwnbSs0UxA9a
	 lnLkPvO78IBPZEnvPGM0R2dNwaCKjCAyIeN/7M7dKLZAdFGy8GFWbUxz3NsZFzQtlu
	 MYVALuVyOJQSj/RIKMTUUfG4b33zHsneDGd0+1oV+e77lmnxj9g7qY6HX9Zee4ppPa
	 tAxj/taE8v4WPFysyLY94Z8MwlbQIVM+HQoHhUT4hf60ZRudUORb43bBOjz/6q6oAu
	 3KM0DrxOZ3VBJhIyD7xSdPQ8J9Suv0Ar2kUOncbMighA6/mxcvh8Pz8rW8AjJw1WXt
	 uOaTdTx1/N7Xw==
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
Subject: [PATCH v3 13/58] objtool/klp: Add test for newly introduced data
Date: Mon, 14 Sep 2026 16:03:10 -0700
Message-ID: <20260914230355.3422996-14-song@kernel.org>
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

