Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CC549A3A6
	for <live-patching@vger.kernel.org>; Wed, 16 Sep 2026 18:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789584317; cv=none; b=XOqwntq4m5HoN6bovRbZ+6bG96tuqksOqiHGUxcqsHgDPExR3ActAoh64AWv7KIfVoUOid+z8FtfUMWD1IDo/qSoRVnP3/wRSu0v9R4sr610OrZ7TKLdYDWHBWy1up6MdDvyTIhoDwsc69OKMs4DrMg1Lelv5z4SFLW5Ja4I94g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789584317; c=relaxed/simple;
	bh=3t9WRMZC3WtGbhP1JpjLx0i5Vd0KR//kh+dHPQzlWkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BMWA2zUcfPjyByGRNUuowZSIf6xWy3y+w4Zb4Jy6ajsC0PYtrOJXcWyTnJ1thbf1C3v1vLtGan4gI72cjyyudlCKkppzxSVPSLodAAvfHl4AdOHO1APE/i6LixsRNqq69nQhCWXMQOC/y3Hw2+CcPYtnq1FEzJuO0M+po6nvPpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oiKa87TE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oiKa87TE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D42FE1F000FF;
	Wed, 16 Sep 2026 18:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789584295;
	bh=rdkE/piEpaHExysLLETiJwi4o//fS58XpKis/FlZSq8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oiKa87TEwLBe4JmhUC/FZwwAOkp33NtNhm8hdIhUV0moWIy78A2RWB9tVvMyu09rX
	 PFFNtXieOjHOYEXVGQA0aIiEe7anGEuUInh0z3AXO3f6As2I4A8EkvAvX/3JUK7uhz
	 TXB838fxMKdumSqT+7SjFn2ruhFL9chExDEyN+0257fxgm7ZkjUjCfNCZWsojUnZbO
	 GlnK6A91MAD5Xvyv1ZnLLcKr2cd03wb/jNoxsAeQxq9pnQYC4FpPAlrbnBwSo/p9zT
	 kC1MGFZyB486UnJ0SKS1rY0ylP+jnLu8G1xQXpU8Ruyy/bHvdLQ2lIVn/wusy1Vgr5
	 gQTcROo7WSYkQ==
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
Subject: [PATCH v5 12/58] objtool/klp: Add test for rejecting changed data
Date: Wed, 16 Sep 2026 11:43:05 -0700
Message-ID: <20260916184351.2720310-13-song@kernel.org>
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

