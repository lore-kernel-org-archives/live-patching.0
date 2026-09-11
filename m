Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44F64AA57F
	for <live-patching@vger.kernel.org>; Fri, 11 Sep 2026 18:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789152295; cv=none; b=j104aYjKhvKxyhpSAPOA3NKFml5MWOwaoFMKvZAjOQRB8cCanThoxzWDiOepT6HwhWHxGQ8hM4adiog+8NH/+ySoFbfOETqZu7Rf5tyccM4YvSRE7SJgkzHSami+973HLAe5ZdZtGvDo5RE1EvtKvVBbV3ghGo/QsDO91RrqICM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789152295; c=relaxed/simple;
	bh=VH8mQbZhMlsRIH8i/uHY57hR3Y6ISFlBFi6PNBcgoPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dhkq7zIutg5Aq+qz3lNai10htNFw+RJeTx+D2RlJNKpXsII6udhkE+W9kN7itmZxh74FM62yFNbwdWTSAs5l8cxNZ6Y+aQLkcpYZRpCjEDeh/eP7qT4j+Zo3p5MvLyaGb8uFzWoMNcBQGbVnaa5aUHMHSG8lDoyb/8BZNy8M8k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fZ1phPS8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZ1phPS8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D342C1F000FF;
	Fri, 11 Sep 2026 18:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789152292;
	bh=rWgc2i1QV1gDo1iqmZ+uPxBZEuWqLwSrLZlYdimsFn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fZ1phPS8IxWxkGK2cKKyivA5fb2u/kpIPJIuQi+GvgEBhuhuJL7RnwNFoTm0byQkK
	 3cpN4dHJJLEpbOIVWxrBi8xSLxMyc/ugb0Nb2yma95XnUL2qtaAYgVZvvzz85/fj3V
	 yah1EYp/DYRL5sO/BFGrn25EgANCPF0h6bxOI4LZ+WsczYSqal4WONox9N2d8Cx7Cp
	 6vVwQo123nugrF0J3i/2zer5NklAy1RvwApJMTKoEuFrHIAwqDbXDnbIcKSQS5Bkc+
	 Ao8TJgm69EYYdfFRQrChugjEXNvYTfR0zMiKpOKR6P4k1gOaCfURq2k3TIsAL8vB5Z
	 7gvLjcxKNBlzw==
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
Subject: [PATCH 15/58] objtool/klp: Add test for static local correlation
Date: Fri, 11 Sep 2026 11:42:22 -0700
Message-ID: <20260911184305.1457308-16-song@kernel.org>
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

A static local must be correlated with its original rather than duplicated.
The replacement has to reach the existing variable through a klp
relocation; a fresh definition would discard whatever state the running
kernel accumulated.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 .../tests/generic/fixtures/static_local.c     | 17 +++++++++++++
 .../tests/generic/test-static-local.sh        | 24 +++++++++++++++++++
 2 files changed, 41 insertions(+)
 create mode 100644 tools/objtool/tests/generic/fixtures/static_local.c
 create mode 100755 tools/objtool/tests/generic/test-static-local.sh

diff --git a/tools/objtool/tests/generic/fixtures/static_local.c b/tools/objtool/tests/generic/fixtures/static_local.c
new file mode 100644
index 000000000000..f2f025d00a39
--- /dev/null
+++ b/tools/objtool/tests/generic/fixtures/static_local.c
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Static local in a patched function. */
+
+static const char __modinfo[]
+	__attribute__((section(".modinfo"), used, aligned(1))) = "\0name=vmlinux";
+
+int target(int x)
+{
+	static int counter;
+
+	counter += 1;
+#ifdef PATCHED
+	return x + counter + 1;
+#else
+	return x + counter;
+#endif
+}
diff --git a/tools/objtool/tests/generic/test-static-local.sh b/tools/objtool/tests/generic/test-static-local.sh
new file mode 100755
index 000000000000..d57efa64dfd9
--- /dev/null
+++ b/tools/objtool/tests/generic/test-static-local.sh
@@ -0,0 +1,24 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# A static local must be correlated with the original, not duplicated: a second
+# copy would discard the state the running kernel accumulated.
+
+. "$(dirname "$0")/../lib.sh"
+
+setup
+build_pair static_local.c
+
+in_symbols orig.o | grep -q 'counter' ||
+	probe_skip "compiler emitted no distinct static local symbol"
+
+run_diff
+assert_patched target
+
+out_symbols | grep -q '\.klp\.sym\..*\.counter' ||
+	fail "static local not referenced through a klp relocation"
+
+out_symbols | grep 'counter' | grep -qvE 'UND|\.klp\.(sym|tombstone)' &&
+	fail "static local was given a fresh definition"
+
+pass "static local correlated rather than duplicated"
-- 
2.53.0-Meta

