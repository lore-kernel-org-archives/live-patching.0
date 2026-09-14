Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52343AD517
	for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 23:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789427238; cv=none; b=M9+yYuoatFPLobLQaU+ek84XAKi1q0SiAWHuObiOetgNR5Olf7flpbIWCIZVqrulZJy9Lz8yN3BK9V0kbTd9BaS+63kzOR5+hxOyXcQm7FuJyd2Iqc7FVGXDldL3WAI+g1i2+2VUPc3S++NoHupUI2XgzCLBsV3ZUiVRXGndbfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789427238; c=relaxed/simple;
	bh=tUoVne96ehJd+QvGOb0OXpfSfIIbrRKSyXKMvUvdOcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jILXNeCdm6rY+eGXYac2scPg5A72SoxBn8xrEhPcVTY9fbCcJhiEKT6EpT+1yOB8fwYq8YUF5rfWOgcUleNWkhzBnoRRy34FJXwiOy28mmBTBdfCBmlN2iWaKtzTGp3xaVV3MiIra/grqjFE60N2KHTfd1GYf4i1rFQMpN/Bu1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BZV53ZcH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZV53ZcH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90C1D1F000FF;
	Mon, 14 Sep 2026 23:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789427237;
	bh=J5t5oTyOWAgasVDMf8QOuTh0d/t/ywtRowxjFQPFLXk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BZV53ZcHiqxNLXFZiKxmcBp07ok6unq8RoPxu0Cu8l2XaiZhpgoHUzRz7xbXHbhJm
	 ouqBgvmqd3GYmoe+AlqDaPMC1cT15Q2SV6/JzZ3jIkqiPnDvzfuZxBuz7sxbznjx0D
	 lUQvvSJC/7dw4ywsMhrKy6/bZafrOgQsWQNKVZiLryOnBMQFanWumwholTg4WTL5Q6
	 uCLmwrD4a1AwI/LgVS/BU9pw6sL6qCwxZX+ESBKZQbbSoaphdJzKPPL6s9q8dJtNIp
	 nzrAuRbIBLKSCh4x2fANLkTXC9UKiJweQeb7OtyobQby3i811Ksq+iRoPjBXexRpM4
	 HfUhaZ0HHqKcg==
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
Subject: [PATCH v3 40/58] objtool/klp: Add test for __bug_table, __ex_table and __mcount_loc extraction
Date: Mon, 14 Sep 2026 16:03:37 -0700
Message-ID: <20260914230355.3422996-41-song@kernel.org>
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

Three special sections with no coverage.  An entry that is not carried into
the patch is not a build failure: the patched function simply loses its
WARN_ON location, its exception fixup, or its ftrace callsite, and nobody
finds out until one of them is needed.

Assisted-by: Claude:claude-opus-4
Based-on-test-by: Joe Lawrence <joe.lawrence@redhat.com>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 .../tests/x86/fixtures/special_sections.c     | 77 +++++++++++++++++++
 .../tests/x86/test-special-sections.sh        | 42 ++++++++++
 2 files changed, 119 insertions(+)
 create mode 100644 tools/objtool/tests/x86/fixtures/special_sections.c
 create mode 100755 tools/objtool/tests/x86/test-special-sections.sh

diff --git a/tools/objtool/tests/x86/fixtures/special_sections.c b/tools/objtool/tests/x86/fixtures/special_sections.c
new file mode 100644
index 000000000000..d42798848fda
--- /dev/null
+++ b/tools/objtool/tests/x86/fixtures/special_sections.c
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * A special section entry belonging to a patched function.  SPECIAL_SEC picks
+ * which section, since klp diff treats eight of them alike and each needs
+ * extracting for the patched function and no other.
+ *
+ * The entry is written out by hand so the fixture builds without kernel
+ * headers.  Only the leading relocation matters to klp diff; the rest is
+ * padded to the section's real entry size, because the entries have to be the
+ * right length for the boundaries between them to fall in the right places.
+ *
+ * SPECIAL_RELOCS covers __ex_table, whose entries relocate both the faulting
+ * instruction and its fixup; objtool rejects one with only the first.
+ */
+
+#ifndef SPECIAL_SEC
+#define SPECIAL_SEC "__bug_table"
+#endif
+#ifndef SPECIAL_ENTSIZE
+#define SPECIAL_ENTSIZE 12
+#endif
+#ifndef SPECIAL_RELOCS
+#define SPECIAL_RELOCS 1
+#endif
+
+#define STR_(x) #x
+#define STR(x) STR_(x)
+
+static const char __modinfo[]
+	__attribute__((section(".modinfo"), used, aligned(1))) = "\0name=vmlinux";
+
+/*
+ * other() gets an entry of its own, so that "the untouched function's entry
+ * was not dragged in" is a question the section can actually answer.  With
+ * only target() contributing, there is nothing for klp diff to leave behind
+ * and the negative assertion holds however the extraction behaves.
+ */
+int other(int x)
+{
+	asm volatile(
+		"3:	nop\n\t"
+		"4:\n\t"
+		".pushsection " SPECIAL_SEC ", \"aM\", @progbits, "
+			STR(SPECIAL_ENTSIZE) "\n\t"
+		".long 3b - .\n\t"
+#if SPECIAL_RELOCS > 1
+		".long 4b - .\n\t"
+		".fill " STR(SPECIAL_ENTSIZE) " - 8, 1, 0\n\t"
+#else
+		".fill " STR(SPECIAL_ENTSIZE) " - 4, 1, 0\n\t"
+#endif
+		".popsection\n\t");
+
+	return x + 9;
+}
+
+int target(int x)
+{
+	asm volatile(
+		"1:	nop\n\t"
+		"2:\n\t"
+		".pushsection " SPECIAL_SEC ", \"aM\", @progbits, "
+			STR(SPECIAL_ENTSIZE) "\n\t"
+		".long 1b - .\n\t"
+#if SPECIAL_RELOCS > 1
+		".long 2b - .\n\t"
+		".fill " STR(SPECIAL_ENTSIZE) " - 8, 1, 0\n\t"
+#else
+		".fill " STR(SPECIAL_ENTSIZE) " - 4, 1, 0\n\t"
+#endif
+		".popsection\n\t");
+#ifdef PATCHED
+	return x + 2;
+#else
+	return x + 1;
+#endif
+}
diff --git a/tools/objtool/tests/x86/test-special-sections.sh b/tools/objtool/tests/x86/test-special-sections.sh
new file mode 100755
index 000000000000..8dfaa4fc9a36
--- /dev/null
+++ b/tools/objtool/tests/x86/test-special-sections.sh
@@ -0,0 +1,42 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# klp diff extracts entries from eight special sections.  Between them the
+# existing tests reach .kcfi_traps, __jump_table, .static_call_sites and
+# .altinstructions; __bug_table, __ex_table and __mcount_loc are covered by
+# nothing, though the same extraction code serves all of them.
+#
+# Losing an entry is quiet in every case and wrong in a different way for each:
+# a WARN() in patched code that no longer reports where it came from, an
+# exception fixup that is simply not there when the faulting instruction traps,
+# a function ftrace can no longer see.
+
+. "$(dirname "$0")/../lib.sh"
+
+
+# section, entry size, relocations per entry
+for spec in "__bug_table 12 1" "__ex_table 12 2" "__mcount_loc 8 1"; do
+	set -- $spec
+	sec=$1
+
+	# A fresh workdir per section: run_diff caches its checksums.
+	setup
+	build_pair special_sections.c \
+		-DSPECIAL_SEC="\"$1\"" -DSPECIAL_ENTSIZE="$2" -DSPECIAL_RELOCS="$3"
+
+	assert_input_section "$sec"
+	run_diff
+
+	# Extracted, and pointing at the function that was patched.
+	assert_section "$sec"
+	assert_reloc_sym "$sec" target
+	assert_patched target
+
+	# Nothing belonging to the function that was not.
+	assert_not_patched other
+	assert_no_reloc_sym "$sec" other
+
+	cleanup
+done
+
+pass "__bug_table, __ex_table and __mcount_loc entries extracted"
-- 
2.53.0-Meta

