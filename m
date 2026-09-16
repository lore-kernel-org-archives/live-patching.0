Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C227A4BD0EF
	for <live-patching@vger.kernel.org>; Wed, 16 Sep 2026 18:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789584328; cv=none; b=Q2sxMmdQYIm2ADFm0FD4UtvXHGur2dTPQ4Bo+M4tZ/+eod+KoXpRQh9ma+pEldcRxcBMi0xUvLusa1OALfG0cU1jvcltsG0O32MRyKQWO3M0lZFEgDNwuTCUbrgvkxSptWOvyVh2sRA5sq0kVpeGQzihDFKdo53MF/2bVkCqg5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789584328; c=relaxed/simple;
	bh=VH8mQbZhMlsRIH8i/uHY57hR3Y6ISFlBFi6PNBcgoPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EmrsapJ93Glc0uqSm7ZiokbteL0D66JXZa2vq4VkcEog5/+OMCxi39TyJ2MrFEepOInNhiX6/QPiSTx3rCnvo4jA24fpP+z/Y/ECADQMn+hVLCKSHWW3/otYHvMBcjLCl3yGImWCqZTQmEkeKucLDoWj1iVAnECCFaazevl7PXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=huA43clf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="huA43clf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42BD41F0089D;
	Wed, 16 Sep 2026 18:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789584310;
	bh=rWgc2i1QV1gDo1iqmZ+uPxBZEuWqLwSrLZlYdimsFn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=huA43clfCXea7yFHnQUZdoDpWDGMNeTdXXBPqK97Gz13jpjSl+fHT+XgzwD64AzQy
	 5fZ/nZ+vfnOfv0m3zlN7VoNNahY42l8GrQeQvpQcKMDpBLEQOrY21r7wBRYLqxLOk4
	 cxdIjZZRBoEla3LzJLGGG3ntZDFzE6w9aA2IeJlFfRmb3NqTUIFuDc4mCYxHVHXgxC
	 c4HB9e0J4xqJWSm0RuABtSwMN4+1sep8EG9CVrCCjryu/nRdCxNovgnDSPEms0DPiD
	 ilcPpN6buXCJXAZiLzc26tsitBEbz0M8KzEfFnZvR52InARHbh1L7sgrve/Skhckf9
	 MZgFQxhrDp2dg==
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
Subject: [PATCH v5 15/58] objtool/klp: Add test for static local correlation
Date: Wed, 16 Sep 2026 11:43:08 -0700
Message-ID: <20260916184351.2720310-16-song@kernel.org>
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

