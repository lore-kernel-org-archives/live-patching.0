Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39974D9F82
	for <live-patching@vger.kernel.org>; Wed, 16 Sep 2026 18:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789584339; cv=none; b=AxvQAu66NAhD3XIMu7GEnVBn/HBGcOYcV6j8EOa+2szIOQe8/OH1Bzctv5/w5IdZH3rNwu5EfQEwT+4rn2XqL1lxV9k7oT7LtHTDZCmx8vXvVT6Ga38ruO7rZ1Mt2jwuosroFzNSAC1CPGoxjrz5dWqm4/XRmjRD6+XJ6AwsbXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789584339; c=relaxed/simple;
	bh=oKIexGl6o6IfAOL4dK7/YEbBhpvrr9QsCqKSbZFVo2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PakyA5W3HtLYha/n5WdT2KLMSFGEamwdNjsJdVDe9H4rY+HmT+SM8fVMHjoEg9+5FWA5jArc6GW9G7jcQCnxgCKUmWM/cNj7hQWmnKy+Tr2ednCRfBnXluVGnzNrXkztIKCO0iK228hdppDyvkCwr7G46wUeSF9QGIZrK6LSzJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nx/jlzuS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nx/jlzuS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA2531F000FF;
	Wed, 16 Sep 2026 18:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789584319;
	bh=hNDwDggAztrl0d+M2aMDRMhoGtFrpvA2reEhUA87y1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Nx/jlzuSs1AB1NZQHbQuVryBBMmC5L4nHAMCZYQfmg/lgvm7asCAf3WWnGj4pdkK3
	 pkoUs2ynFKD4lBPUSUViV33lvCEdE0eNS1SA0gxcMF4Ypw/BcOHJ44vmEcg+rPVTAZ
	 foVY9c8uGpTzWObsqZxqA2qNIKgNkbD5dCw016OIu7QPFBxJWYosdBV2bUYq1oCzkC
	 6TUpck38C4392sA0RjPraPO8warszCpSL2dPvNreksWQ8YQZ0bqftqOtlkea6XuIGf
	 jKY1IQWm9a2jqxOi5hcVM3g2JaiAhcq7o4DB/UpDaBV/u/2DHv1U2lQrHNb1WL3Iy5
	 r8+yyB8SXqtCw==
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
Subject: [PATCH v5 17/58] objtool/klp: Add test for special section extraction
Date: Wed, 16 Sep 2026 11:43:10 -0700
Message-ID: <20260916184351.2720310-18-song@kernel.org>
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

create_fake_symbols() gives each special section entry a symbol so entries
can be extracted individually.  Entries with ANNOTATE_DATA_SPECIAL are
handled first; the rest have their boundaries derived from the entry or
relocation size.

The second pass has to key off whether the first one created symbols, not
off whether the section already has something at offset 0.  Clang puts an
assembler-local label at the start of .kcfi_traps, and treating that as
already handled means nothing is extracted: klp diff still reports the
changed function and succeeds, but the special section is missing from the
module.

The fixture reproduces the shape without needing CFI or x86.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 .../tests/generic/fixtures/special_section.c  | 24 +++++++++++++++++++
 .../tests/generic/test-special-section.sh     | 20 ++++++++++++++++
 2 files changed, 44 insertions(+)
 create mode 100644 tools/objtool/tests/generic/fixtures/special_section.c
 create mode 100755 tools/objtool/tests/generic/test-special-section.sh

diff --git a/tools/objtool/tests/generic/fixtures/special_section.c b/tools/objtool/tests/generic/fixtures/special_section.c
new file mode 100644
index 000000000000..d28c5541e337
--- /dev/null
+++ b/tools/objtool/tests/generic/fixtures/special_section.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Special section entry with no ANNOTATE_DATA_SPECIAL annotation and a local
+ * label at offset 0, the shape Clang produces for .kcfi_traps.
+ */
+
+static const char __modinfo[]
+	__attribute__((section(".modinfo"), used, aligned(1))) = "\0name=vmlinux";
+
+int target(int x)
+{
+	asm volatile(
+		"1:\n\t"
+		".pushsection	.kcfi_traps, \"a\"\n\t"
+		".balign	4\n\t"
+		"trap_marker:\n\t"
+		".long		1b - .\n\t"
+		".popsection\n\t");
+#ifdef PATCHED
+	return x + 2;
+#else
+	return x + 1;
+#endif
+}
diff --git a/tools/objtool/tests/generic/test-special-section.sh b/tools/objtool/tests/generic/test-special-section.sh
new file mode 100755
index 000000000000..b6a9139c0062
--- /dev/null
+++ b/tools/objtool/tests/generic/test-special-section.sh
@@ -0,0 +1,20 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# A .kcfi_traps entry belonging to a patched function must be extracted even
+# without ANNOTATE_DATA_SPECIAL and with a local label already at offset 0.
+
+. "$(dirname "$0")/../lib.sh"
+
+setup
+build_pair special_section.c
+
+in_symbols orig.o | grep -q 'trap_marker' ||
+	probe_skip "fixture produced no .kcfi_traps on this arch"
+
+run_diff
+
+assert_patched target
+assert_section ".kcfi_traps"
+
+pass ".kcfi_traps extracted despite a local label at offset 0"
-- 
2.53.0-Meta

