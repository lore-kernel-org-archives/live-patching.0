Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C43426429
	for <live-patching@vger.kernel.org>; Tue, 15 Sep 2026 23:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789515395; cv=none; b=tx6acU1iB5XUSBjk85ud95J2FgKPLeOAa7P9ZlXjhTIPyYeD1C/vv18zFXt5GthBvC1oc3fwzgSxhMOiNsdXat4yla42V2ABamoC/5cJZHZy7meSS3yqNh3gBtHfNeNZmh1ua6hAxNK/vj1f/n+sPfe5dTNVH4JTlt/EVSOJe4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789515395; c=relaxed/simple;
	bh=oKIexGl6o6IfAOL4dK7/YEbBhpvrr9QsCqKSbZFVo2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EvVQJoz8qohxxp3KuVZuomlzPf3VVCSSGbZp1ECs+hs/lCdBy4JPvXSc//1DYRKJ1+huGVtyVJBMB6yW3TvJVVmMeCX1iMq2kT29Ma/UpekKCTpV0z8LJDCtBw2rYShkMRs6oZtcpUxGxzKlLvXggBc1JQf+/OYRvJDXYk7Q6u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mC8c5JgE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mC8c5JgE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 511431F000FF;
	Tue, 15 Sep 2026 23:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789515394;
	bh=hNDwDggAztrl0d+M2aMDRMhoGtFrpvA2reEhUA87y1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mC8c5JgETdGP7hf96hM0dMAoizfNEEjiUEKmnksubaKUHtYtmQvUCDMsVx/PgsKeV
	 UYQxeS3pEFXcK+RHqouqYUzc2b7nVHxmO45Fo0Pd3D1o/gUghC7Zm2M7+9VWREYk1A
	 Goxd5Fj0MLA0WF8ztjinW5C3IxkVZXJ5tuFXZoXbTmopH8lXceMqbrIZbc3YOhv3dR
	 rrUORlnjmTbNx89cO8Y6e2vOpOZsAAbFJ0x6vxWXmomDD1cchOnCOK0HmxsP1S3X2l
	 75/yMFPuWzkb++U5iC5bn0efEb30oOigqc24bpOhujLAmXsK4tFnfi/YQqvs5dHbdY
	 EX7RH62SH0sUw==
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
Subject: [PATCH v4 17/58] objtool/klp: Add test for special section extraction
Date: Tue, 15 Sep 2026 16:34:13 -0700
Message-ID: <20260915233454.2405019-18-song@kernel.org>
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

