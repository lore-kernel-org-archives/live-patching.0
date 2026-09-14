Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1214E3AB26D
	for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 23:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789427210; cv=none; b=mAlIFsH6CcMw9ecl5NQkYWeAYesG35zJXZa/X75KwEmKdE35WmBJvUtli6VOTAtRjsVxkOa7Is7pMUT7VO/Jc/FgO3FYK/NiUmzfQqJMmjmdqZvGpidWCkuvuH8ddTLHdoR7QrAzYep48ohKHEonj19mCbIsUkWg2vm2xauRQy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789427210; c=relaxed/simple;
	bh=2SbUUxGToJEJvGNQaH2J/aVQaEwz2IrFLRGPV9UJmh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dx7wyZJrjgq2WLA1EH7+bUESHLK8VXy0jMGPTiacC1RNPZZcuC1Wqwa/fhDZdi5/3qB0aGB1Dvm63ovhYbN/fUpI29wGPWhStjpdyaWfdppeQL7eSWnO7BgGVbVPmY1S6hH6dA+/9o9Cne0VPDEYRQ76rcc3t38uHG7vlFju6xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jTDhNlqj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jTDhNlqj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB4A21F00893;
	Mon, 14 Sep 2026 23:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789427208;
	bh=qYy3MMZEwe6P1EkjSGHGFbZ3clEseRh7XJE968GpDK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jTDhNlqjfRmbE62RdnP7EWEL/nH5VEYL8mQUTOXoxortzL17/VXbOdh9xbUDsj+2s
	 d3w3RghS9cpa4AgcZ8n9nWWOs4xd3FRhB7aF4++vqdJSgS0HM6vbzMNvAsLm5Y/dx9
	 K1CnijxwJUlL2WD+G+J4x1RIDfDtNY/db+/k5NLAryjGbRYKn4HMsTHcUtQ3S8uT3Z
	 G/tyi1o/Zgy60V0xcj2fRPkApQWoSDYEoeD8yVgZD/ecGGfcmnms7oXIv9ldQz4Jnn
	 IghozVhPoh3mneWRJPikeajCQp3Nsb5LscfS+bsSInorGzVfX9mRGT1sCq3c/sZZep
	 qhU0ruQVtBAtA==
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
Subject: [PATCH v3 34/58] objtool/klp: Add test for empty x86 alternative replacements
Date: Mon, 14 Sep 2026 16:03:31 -0700
Message-ID: <20260914230355.3422996-35-song@kernel.org>
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

ALTERNATIVE_2("orig", "repl", ft1, "", ft2) produces a second entry whose
replacement is empty.  Its replacement offset still carries a relocation,
but the label it points at is the end of the previous replacement -- which
is also where the next one begins.  The value is meaningless and only ever
used with a length of zero, so cloning must not follow it.

The first version of this fixture passed with the fix reverted, because the
empty entry pointed at its own end label rather than at the neighbour's
replacement.  It has to reach into another function's replacement to
distinguish the behaviour.

This tests the behavior of commit 636f230ce21e ("objtool/klp: Ignore
replacement offset of empty x86 alternatives").

Assisted-by: Claude:claude-opus-4
Based-on-test-by: Joe Lawrence <joe.lawrence@redhat.com>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 .../tests/x86/fixtures/empty_alternative.c    | 77 +++++++++++++++++++
 .../tests/x86/test-empty-alternative.sh       | 31 ++++++++
 2 files changed, 108 insertions(+)
 create mode 100644 tools/objtool/tests/x86/fixtures/empty_alternative.c
 create mode 100755 tools/objtool/tests/x86/test-empty-alternative.sh

diff --git a/tools/objtool/tests/x86/fixtures/empty_alternative.c b/tools/objtool/tests/x86/fixtures/empty_alternative.c
new file mode 100644
index 000000000000..9336d74bfa92
--- /dev/null
+++ b/tools/objtool/tests/x86/fixtures/empty_alternative.c
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * An x86 alternative with an empty replacement, as the second entry of
+ * ALTERNATIVE_2("orig", "repl", ft1, "", ft2) produces.  Its replacement
+ * offset still gets a relocation, but the label it points at is the end of the
+ * previous replacement, which is also where the *next* one begins -- here,
+ * neighbor()'s.  The value is meaningless; it is only ever used with a length
+ * of zero.
+ *
+ * struct alt_instr is written out by hand so the fixture builds without kernel
+ * headers: s32 instr_offset, s32 repl_offset, u32 ft_flags, u8 instrlen,
+ * u8 replacementlen.  The section carries an entsize because klp diff needs
+ * either that or an ANNOTATE_DATA_SPECIAL annotation to find entry boundaries.
+ *
+ * The replacement labels are global so the relocations name them rather than
+ * .altinstr_replacement plus an addend.
+ */
+
+static const char __modinfo[]
+	__attribute__((section(".modinfo"), used, aligned(1))) = "\0name=vmlinux";
+
+extern int neighbor_only(int x);
+
+int target(int x)
+{
+	asm volatile(
+		"661:	nop\n\t"
+		".pushsection .altinstr_replacement, \"ax\"\n\t"
+		".globl target_repl\n\t"
+		"target_repl:\n\t"
+		"	nop\n\t"
+		"target_repl_end:\n\t"
+		".popsection\n\t"
+		".pushsection .altinstructions, \"aM\", @progbits, 14\n\t"
+		/* a real replacement */
+		".long 661b - .\n\t"
+		".long target_repl - .\n\t"
+		".long 0\n\t"
+		".byte 1\n\t"
+		".byte target_repl_end - target_repl\n\t"
+		/* an empty one, pointing at neighbor()'s replacement */
+		".long 661b - .\n\t"
+		".long neighbor_repl - .\n\t"
+		".long 0\n\t"
+		".byte 1\n\t"
+		".byte 0\n\t"
+		".popsection\n\t");
+#ifdef PATCHED
+	return x + 2;
+#else
+	return x + 1;
+#endif
+}
+
+/*
+ * Unrelated, unpatched, and referencing a symbol nothing else does, so that
+ * dragging its replacement in is visible.
+ */
+int neighbor(int x)
+{
+	asm volatile(
+		"771:	nop\n\t"
+		".pushsection .altinstr_replacement, \"ax\"\n\t"
+		".globl neighbor_repl\n\t"
+		"neighbor_repl:\n\t"
+		"	call neighbor_only\n\t"
+		"neighbor_repl_end:\n\t"
+		".popsection\n\t"
+		".pushsection .altinstructions, \"aM\", @progbits, 14\n\t"
+		".long 771b - .\n\t"
+		".long neighbor_repl - .\n\t"
+		".long 0\n\t"
+		".byte 1\n\t"
+		".byte neighbor_repl_end - neighbor_repl\n\t"
+		".popsection\n\t");
+	return x;
+}
diff --git a/tools/objtool/tests/x86/test-empty-alternative.sh b/tools/objtool/tests/x86/test-empty-alternative.sh
new file mode 100755
index 000000000000..9d40c3a405af
--- /dev/null
+++ b/tools/objtool/tests/x86/test-empty-alternative.sh
@@ -0,0 +1,31 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# An x86 alternative with an empty replacement still gets a relocation for its
+# replacement offset, but the label it points at is the end of the previous
+# replacement -- which is also the start of the next one.  The value is
+# meaningless, and get_alt_entry() already ignores it.
+#
+# Cloning it drags in an unrelated neighboring replacement and everything that
+# replacement references.  In the reported case an empty alternative in
+# meminfo_proc_show() pulled in one from proc_kcore_init(), emitting a klp
+# relocation against init text which is long freed by the time the patch is
+# applied.
+
+. "$(dirname "$0")/../lib.sh"
+
+setup
+build_pair empty_alternative.c
+
+assert_input_section .altinstructions
+assert_input_section .altinstr_replacement
+
+run_diff
+
+# target's own replacement comes along ...
+assert_symbol target_repl
+# ... neighbor's does not, nor what it references.
+assert_no_symbol neighbor_repl
+assert_no_symbol neighbor_only
+
+pass "empty alternative's replacement offset ignored when cloning"
-- 
2.53.0-Meta

