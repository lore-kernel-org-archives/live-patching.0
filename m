Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EDA3DAAA8
	for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 06:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789367230; cv=none; b=t63HbHHEWkCr6mBdWsmwPB7LAGZjDtWJnEnnim2ybl0hMeR+LtC4KRWOZ/4sFg7KwSPer3ZtU5nNQR+i8nTVQireJmN3DYJBWZipGoRkzSVk6ToL5Bgsvkn5r4CggBf85p1Kt1VIQp4GoOamqPy+MLYjQA9YOtie1daHHYHsSFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789367230; c=relaxed/simple;
	bh=K1Ntqv2jSjrO5YQZcv1dTN/Od8c8VkXztXZpC/gknYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZxqpMR1YkE2QwaXsGWojrTAaAJyyT5/KyD0+yJ3dU3c09ph+72RYFMyB/bMbSBwpTXPaK7W+cSQLux377bZrkFj+H/y+MF4gWE+YbwWcT3LZNfdm9B9ah+BXp/c8Vys52qJcBMGyeKUkTC9cakbNWjf5wTtRJDJVUMuIDDWK4uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nY4fggKL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nY4fggKL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5BC41F000FF;
	Mon, 14 Sep 2026 06:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789367225;
	bh=r+S3kGYa/Hx7o6EOEIdlSdLsyGiYTPYPCIAH7y1XtcA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nY4fggKLOunBfOZVkCIM8T4wYoFrY7p5KV9XfIMmbl0ab5UHhqbJl7d782LCRHQ/c
	 K+yMi6lRl6GlUf9dOmN0MYhDgqza4Kq3fUpvil56tOYYIVhQMygFCtJV5I0ijDaL5y
	 2aWBRebP5ldn6WjekQZ5TJoNnde/U0jNcreMADZ1GzQfp0MKinTinipTXQZg9w3ibT
	 iX6Xf3u8F10GWaGMYaSf5HdPo4Qkw/uJsOGgHpikbH0Cofg5MAE224kUqanZj3G5Wd
	 ZSuGKRkYTUTuVhpirBZK336414QWU+CqZVH6CTHQSWzqcI2n3nWU+a5MNaEJVXS/Zu
	 K6k4JklkqARPQ==
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
Subject: [PATCH v2 18/58] objtool/klp: Add test for selective special section extraction
Date: Sun, 13 Sep 2026 23:24:34 -0700
Message-ID: <20260914062514.926997-19-song@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914062514.926997-1-song@kernel.org>
References: <20260914062514.926997-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Puranjay Mohan <puranjay@kernel.org>

Two functions contribute entries to one special section but only one is
patched.  Cloning the neighbouring entry drags in whatever it points at,
which is how a livepatch ends up holding relocations against unrelated
code.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 .../generic/fixtures/special_section_shared.c | 31 +++++++++++++++++++
 .../generic/test-special-section-shared.sh    | 26 ++++++++++++++++
 2 files changed, 57 insertions(+)
 create mode 100644 tools/objtool/tests/generic/fixtures/special_section_shared.c
 create mode 100755 tools/objtool/tests/generic/test-special-section-shared.sh

diff --git a/tools/objtool/tests/generic/fixtures/special_section_shared.c b/tools/objtool/tests/generic/fixtures/special_section_shared.c
new file mode 100644
index 000000000000..f54e24f862c6
--- /dev/null
+++ b/tools/objtool/tests/generic/fixtures/special_section_shared.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Two functions contribute to one special section; only one is patched. */
+
+static const char __modinfo[]
+	__attribute__((section(".modinfo"), used, aligned(1))) = "\0name=vmlinux";
+
+int other(int x)
+{
+	asm volatile(
+		"2:\n\t"
+		".pushsection	.kcfi_traps, \"a\"\n\t"
+		".balign	4\n\t"
+		".long		2b - .\n\t"
+		".popsection\n\t");
+	return x * 5;
+}
+
+int target(int x)
+{
+	asm volatile(
+		"1:\n\t"
+		".pushsection	.kcfi_traps, \"a\"\n\t"
+		".balign	4\n\t"
+		".long		1b - .\n\t"
+		".popsection\n\t");
+#ifdef PATCHED
+	return x + 2;
+#else
+	return x + 1;
+#endif
+}
diff --git a/tools/objtool/tests/generic/test-special-section-shared.sh b/tools/objtool/tests/generic/test-special-section-shared.sh
new file mode 100755
index 000000000000..05c6110b6aef
--- /dev/null
+++ b/tools/objtool/tests/generic/test-special-section-shared.sh
@@ -0,0 +1,26 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Only the patched function's special section entry may be extracted.
+
+. "$(dirname "$0")/../lib.sh"
+
+setup
+build_pair special_section_shared.c
+
+has_input_section orig.o .kcfi_traps ||
+	probe_skip "fixture produced no .kcfi_traps on this arch"
+
+run_diff
+
+assert_patched     target
+assert_not_patched other
+assert_section     ".kcfi_traps"
+
+entries="$(out_relocs | awk '/rela\.kcfi_traps/,/^$/' | grep -c 'target')"
+[ "$entries" = 1 ] || fail "expected one .kcfi_traps entry, found $entries"
+
+out_relocs | awk '/rela\.kcfi_traps/,/^$/' | grep -q 'other' &&
+	fail "the untouched function's entry was dragged in"
+
+pass "only the patched function's entry extracted"
-- 
2.53.0-Meta

