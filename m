Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2ED4EC643
	for <live-patching@vger.kernel.org>; Wed, 16 Sep 2026 18:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789584340; cv=none; b=O6dyXDwVjpLQP0xnYFMs9AQhk03/OApjVcw7SaIfnCAs07JpqPWA08GG2C40lZKruWo71sRJ7kQOhgTrDogc5SpygKy3yOH3VijbzGosxSb2QaD2f86Mc2FdwD6sf+xEf6yqdR25JZINhsabpOiH6uNMfVSLJCfgTfkP/Ofb+fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789584340; c=relaxed/simple;
	bh=K1Ntqv2jSjrO5YQZcv1dTN/Od8c8VkXztXZpC/gknYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DgHxIT6ZsU9i6JEvgA7BkAsZM40hgyW6go7Uy3zGhaVo7xIZ+Kfzcn+NHPbKtY5IONdxUfTkkEScE+FmJKgRlrZTHy1JO0z4j/QabC2r20I6PT5jg1Z/YJ7YN28gcBWP0ZeuhWFymHhJhty7XQ6Vmd4gXxKshvkjLpdmSAkf8lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nUIAFG8K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nUIAFG8K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A47D51F00893;
	Wed, 16 Sep 2026 18:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789584324;
	bh=r+S3kGYa/Hx7o6EOEIdlSdLsyGiYTPYPCIAH7y1XtcA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nUIAFG8Kbh4V5a4JtDlOSn5Nekqtpwq/abEfuTj9OPXhggXuYC7fd4Q5qcZPQhLk8
	 PNIFCKr86bSVyDiq9a2JgWnlVFT+re1F/MowuM+9xY+GshXsLZtBquTRRjnJOSeIXV
	 pSxgfHw343OrB8r/Cb1RZdJOqlyBKRJdvnnXHPgDPekkAns3KHco1xEXYzn91ysGrP
	 kHapNdaD1/nLmnHvSXgX3FCdHn9eMrPl9GzVHBWk57fXQwV8z9kYIlQavsryUopGKl
	 JT/oIowf5KfstBxmYFPLlesf2M+kBhNDCE4PVv3Umg1mMh3P+0X/ylzludoLygeCDV
	 FppM/txbx2nKg==
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
Subject: [PATCH v5 18/58] objtool/klp: Add test for selective special section extraction
Date: Wed, 16 Sep 2026 11:43:11 -0700
Message-ID: <20260916184351.2720310-19-song@kernel.org>
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

