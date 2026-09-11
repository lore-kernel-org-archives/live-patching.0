Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1093EDAAE
	for <live-patching@vger.kernel.org>; Fri, 11 Sep 2026 18:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789152700; cv=none; b=co2PAeqUNOAvuFY8CvuNfkBolnmnko4slwP0pvmI8OIaql2lb2dskGa3TXgrd1YK9ZUDatZiX/xH+xEHJNk5Rtew/wzOh6/5QAFgJOzBTTSiVJNkXkD15YjorQOaGBKVrUZ2qBxeH02TPzYALYU+sWp+h86lHqeKO+0pinPvAUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789152700; c=relaxed/simple;
	bh=UepOUhCYgEuQd62k/Y9nRA7KnNUiNKP6qYpfYb5SBhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hpJFGuU+cFbBO5/604z/Pg2dhUNaxAvEsagV7sV8Q0JIdYQnrFkJwr8rRS/8809Pag+c61ItGi9LUfJphN1j/GRQEZEMIbFxw81VO6r3Pp9uiluvN67GXe1uLLYLieuc9DsHB7QRka/Pw6+pw3YcBb8EMscRzrHEPiJfgkEk2hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EQRBPBi4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EQRBPBi4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDD431F000FF;
	Fri, 11 Sep 2026 18:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789152698;
	bh=4p1Q5yWcAPjokeyjo21Toe0eXJaU26dMNQcuuqVgbO8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EQRBPBi4g71CYPBN9+hLZEcuqXmTB7CMWAD6xEE0c6OXzukuS/SHYFjECIfcfK2Yl
	 1ptwGFz//LfpzMd7LMLn+CyT3N/cVLq1iaC2EbplHiUDb/AzE1823uIW6H31yTtjqU
	 fGtVZkjC7uw24l/jXRST8rFgchbxLt/FgGi8nXF7TCsf/m1YwZh/+c2mjy0xYhv+o7
	 cG8UUx7mXFGa7c3M7Gye0j1jcPODHmYqdwNrdCXwD31AgCQVjIw13YYjySEnEfVtvj
	 9i3UREvSElt0YomR7zKwg7453DVD6R/aVwVGIkSr9z+tQ2HvzRqC96s1CuwMlVHaIY
	 ImMCOJIkdYo0Q==
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
Subject: [PATCH 36/58] objtool/klp: Add test for position-independent checksums
Date: Fri, 11 Sep 2026 11:50:09 -0700
Message-ID: <20260911185031.1534046-11-song@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911185031.1534046-1-song@kernel.org>
References: <20260911184305.1457308-1-song@kernel.org>
 <20260911185031.1534046-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A function that only moves has not changed, and its checksum must not move
with it.  Otherwise every patch reports as changed everything that shifted
because something ahead of it grew.

The fixture is built with -fno-function-sections, overriding the harness
default: with per-function sections every function sits at offset 0 of its
own section and nothing ever moves, so the test would prove nothing.  It
also calls across to another function rather than looping within itself --
a loop branch keeps the same displacement wherever the function goes, so it
is not position-dependent to begin with.

This tests the behavior of commit cca84cb12908 ("objtool/klp: Fix
position-dependent checksums for non-relocated jumps/calls").

Assisted-by: Claude:claude-opus-4
Based-on-test-by: Joe Lawrence <joe.lawrence@redhat.com>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 .../generic/fixtures/checksum_position.c      | 45 +++++++++++++++++++
 .../tests/generic/test-checksum-position.sh   | 35 +++++++++++++++
 2 files changed, 80 insertions(+)
 create mode 100644 tools/objtool/tests/generic/fixtures/checksum_position.c
 create mode 100755 tools/objtool/tests/generic/test-checksum-position.sh

diff --git a/tools/objtool/tests/generic/fixtures/checksum_position.c b/tools/objtool/tests/generic/fixtures/checksum_position.c
new file mode 100644
index 000000000000..e1362e58422b
--- /dev/null
+++ b/tools/objtool/tests/generic/fixtures/checksum_position.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * A function whose position in the section changes between the two builds,
+ * without the function itself changing.
+ *
+ * PATCHED adds a function ahead of it, so target() moves.  It must be built
+ * without -ffunction-sections, or every function sits at offset 0 of its own
+ * section and nothing ever moves -- which is why the test passes
+ * -fno-function-sections.
+ *
+ * target() contains a loop, so it has a relative jump with no relocation.  The
+ * offset encoded in that instruction depends on where the function sits, and
+ * hashing those bytes makes the checksum move when the function does.
+ */
+
+static const char __modinfo[]
+	__attribute__((section(".modinfo"), used, aligned(1))) = "\0name=vmlinux";
+
+__attribute__((noinline)) static int callee(int x)
+{
+	return x * 5 + 1;
+}
+
+/*
+ * Inserted between callee() and target(), so the distance target's call has to
+ * encode changes.  A jump or call within the same section needs no relocation:
+ * the displacement is in the instruction, and it is that displacement which
+ * moves.
+ */
+#ifdef PATCHED
+__attribute__((noinline)) int padding(int x)
+{
+	int i, s = 0;
+
+	for (i = 0; i < x; i++)
+		s += i * 3;
+
+	return s;
+}
+#endif
+
+__attribute__((noinline)) int target(int x)
+{
+	return callee(x) + callee(x + 1);
+}
diff --git a/tools/objtool/tests/generic/test-checksum-position.sh b/tools/objtool/tests/generic/test-checksum-position.sh
new file mode 100755
index 000000000000..459a718d75e7
--- /dev/null
+++ b/tools/objtool/tests/generic/test-checksum-position.sh
@@ -0,0 +1,35 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# A function's checksum must not depend on where the function sits.
+#
+# A jump or call without a relocation encodes its target as an offset from the
+# instruction.  Hashing those bytes makes the checksum change whenever anything
+# ahead of the function changes size -- so an unrelated edit elsewhere in the
+# file reports this function as changed too, and the patch grows to include it
+# and everything it references.  Nothing fails; the livepatch is just larger and
+# riskier than the patch it came from.
+#
+# Here the "patch" adds a function ahead of target() and changes nothing else.
+
+. "$(dirname "$0")/../lib.sh"
+
+setup
+
+# -fno-function-sections, or each function is at offset 0 of its own section
+# and target() never moves.
+build_pair checksum_position.c -fno-function-sections
+
+assert_input_symbol target
+
+# The fixture is only meaningful if target() actually moved.
+orig_off="$(in_symbols orig.o    | awk '$8 == "target" { print $2 }')"
+new_off="$( in_symbols patched.o | awk '$8 == "target" { print $2 }')"
+[ -n "$orig_off" ] && [ -n "$new_off" ] ||
+	fail "target symbol not found in both objects"
+[ "$orig_off" != "$new_off" ] ||
+	probe_skip "compiler did not move target() between builds"
+
+assert_checksum_matches target
+
+pass "checksum unchanged when the function only moves"
-- 
2.53.0-Meta

