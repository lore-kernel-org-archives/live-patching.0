Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64ADF340DA6
	for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 23:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789427123; cv=none; b=ZT2Db55xuH0JxAmRpyYIYIg2p3iDEoWExQdcbwdZ4gL4JMm9GO07alHF93fT9/Jt7QMuGlZr0B4lCaD7NC2oL3CU8nUyvvlMDEcXFLtBu/Fo/+8fQANQ/30ykkk9fyV83O8/c1dUH00SXqmYjzgBpdhOrfXBnrOLkSr+txsjEyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789427123; c=relaxed/simple;
	bh=oKIexGl6o6IfAOL4dK7/YEbBhpvrr9QsCqKSbZFVo2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q/P6/JnCKj5raKN3yEsTPaKDjlDG9XybwBbCIr72SmfKKOxBdDG8R0WBVgFsp0q3grBIVpimkSwyZXYKRuq5xwYxxRu7mZReHfjOw/4lqFCAUSOp3OKc7sDpmf45yW4jirgRZv9VoCntdM06Lbo7Nk7uf8D7f+soIjDCBR/+Xm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AottSkCs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AottSkCs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D0E51F000FF;
	Mon, 14 Sep 2026 23:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789427122;
	bh=hNDwDggAztrl0d+M2aMDRMhoGtFrpvA2reEhUA87y1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AottSkCs7b5H3xHZWPSY0rOxbN09hUeg4eSVXJhlls0kf+YmEWBKxUWM30Tuh7uM+
	 zbvLOIR/XlZvUFIiBInzU/qfWAhMLPjzVEvNoOXvVa2Sp3Ln/XPvqeMxesHwQ5r1T9
	 8xoMcO5zpAXbwbO3w/ekKdhpmGgFbeBrsk8p6PG5IsAuWzjXW8OX4Ar6NvZTG8zsZP
	 OicmIhebRWYLU3wF/wbb26s3jiyp6vYKywPdXZaeORLoplSLMZ8jVZK1X46G4PEJu8
	 gSHrHfyeeMVvzWOukYQh+lr95lzj+cSW61RgoTawfFnHHB3fEok1U3sqD9JNd8c9rF
	 WnJIWxQIEUykQ==
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
Subject: [PATCH v3 17/58] objtool/klp: Add test for special section extraction
Date: Mon, 14 Sep 2026 16:03:14 -0700
Message-ID: <20260914230355.3422996-18-song@kernel.org>
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

