Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A8C3D647A
	for <live-patching@vger.kernel.org>; Fri, 11 Sep 2026 18:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789152797; cv=none; b=pJcQtwgrpOCwCTFQ/I7vbpeF2hKT32gqUuKCrf4ND0coaoYUyHCeuj6yUO5CYIBp+NZg1oE1c8BqtBPM4AEKnhfiokO41Qg2y4rurnmVuxd7f/agEAtEYA4tv+3Dx7fBPnfpF6lfz93o/4r8NdpLSv4dLrlgeTmOdFLIorSiL7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789152797; c=relaxed/simple;
	bh=b5KyROuZxh+WwoTgI3HxMj54P9MfUkbHbg/duW+jiB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lWak44ItwinlSfuwKQTsyvYgumiVb3hMACQHLJW8izwCzWee06U7ErHiPXs5Z4Ur+K+skNc0OUQdTXmUv0ces+ABfxwBeAm7A4B42fo9MhKKM6hp8xHbnNasTVGpCxNPkjk64+Bv9bT8P4H17TYmQyyIsNnv34SjApzpBmKBa4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NH7sULcp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NH7sULcp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0A821F000FF;
	Fri, 11 Sep 2026 18:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789152792;
	bh=aUp49JyynfN8hjkRFq4mGHCtvKsDixFfpxlinBJVmTo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NH7sULcptfF5xeAb1h8Q+iCycFhhBazqLgFvWavHR0/fXUaWIUM50gdr7mUKZ1fBY
	 DjYzbv8KNTVZKzh2IYR3Zu1FZpk3hY4zyFvURK5Ro+tMXA3RjS8Udc1GyKx6LxocrK
	 dygpROozSZ5mKNLM5eoi+pt2Ge2C2xnBhgZrxHy0IdzsO2Btsrtoblm18MpsH8gsiB
	 d0LTFgxVQ/PRaV8p5Anr4k/HqiqN8YoVwgQauFuyKl22Up5VoOX15lKqvBJ+UZhF6+
	 Bbb2VCbVs2iwjoiWrAGz/3RasrD+fsyPOG6xpaxNwMQlfFUr1bzr1rABFEBxtwiyW2
	 ASJteNWJfVuZw==
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
Subject: [PATCH 55/58] objtool/klp: Add test for absolute and __ADDRESSABLE symbols
Date: Fri, 11 Sep 2026 11:50:28 -0700
Message-ID: <20260911185031.1534046-30-song@kernel.org>
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

A SHN_ABS symbol has no section, so any walk of sym->sec which does not
check dereferences NULL, and the kernel has plenty of them -- from linker
scripts and from .set in assembly.  __ADDRESSABLE() emits a pointer into
.discard.addressable purely to keep a symbol referenced; it means nothing
to a livepatch and is discarded at link time, but it is a relocation like
any other and gets looked at.

Neither is what the patch changes.  What this guards against is not a wrong
answer but a crash or an error on input the kernel produces routinely,
which would make every function near one unpatchable.

Not isolated to a single line, and the test says so: the absolute symbol
here has zero length, so it is excluded before the section check is reached
and removing that check alone changes nothing observable.

Assisted-by: Claude:claude-opus-4
Based-on-test-by: Joe Lawrence <joe.lawrence@redhat.com>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 .../generic/fixtures/abs_and_addressable.c    | 44 ++++++++++++++++
 .../tests/generic/test-abs-and-addressable.sh | 50 +++++++++++++++++++
 2 files changed, 94 insertions(+)
 create mode 100644 tools/objtool/tests/generic/fixtures/abs_and_addressable.c
 create mode 100755 tools/objtool/tests/generic/test-abs-and-addressable.sh

diff --git a/tools/objtool/tests/generic/fixtures/abs_and_addressable.c b/tools/objtool/tests/generic/fixtures/abs_and_addressable.c
new file mode 100644
index 000000000000..6392ff99af42
--- /dev/null
+++ b/tools/objtool/tests/generic/fixtures/abs_and_addressable.c
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Two constructs which appear all over the kernel and must not upset klp
+ * checksum or klp diff.
+ *
+ * An absolute symbol (SHN_ABS) has no section, so anything walking sym->sec
+ * without checking dereferences NULL.  The kernel makes them with linker
+ * scripts and with .set in asm; VDSO and the fixed-address per-cpu bases are
+ * the usual sources.
+ *
+ * __ADDRESSABLE() emits a pointer into .discard.addressable purely to keep a
+ * symbol referenced.  It is discarded at link time and means nothing to a
+ * livepatch, but the pointer is a relocation like any other and has to survive
+ * being looked at.
+ *
+ * Neither is the subject of the patch; the point is that their presence does
+ * not disturb the function that is.
+ */
+
+static const char __modinfo[]
+	__attribute__((section(".modinfo"), used, aligned(1))) = "\0name=vmlinux";
+
+/* SHN_ABS, referenced from code. */
+extern char abs_sym[];
+__asm__(".globl abs_sym\n"
+	".set abs_sym, 0x1234\n");
+
+int helper(int x);
+int helper(int x) { return x + 1; }
+
+/* The shape of __ADDRESSABLE(helper). */
+__asm__(".pushsection .discard.addressable, \"aw\"\n"
+	".balign 8\n"
+	".quad helper\n"
+	".popsection\n");
+
+int target(int x)
+{
+#ifdef PATCHED
+	return helper(x) + (int)(long)abs_sym + 1;
+#else
+	return helper(x) + (int)(long)abs_sym;
+#endif
+}
diff --git a/tools/objtool/tests/generic/test-abs-and-addressable.sh b/tools/objtool/tests/generic/test-abs-and-addressable.sh
new file mode 100755
index 000000000000..6adb23ed4b88
--- /dev/null
+++ b/tools/objtool/tests/generic/test-abs-and-addressable.sh
@@ -0,0 +1,50 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# An absolute symbol and an __ADDRESSABLE() pointer must not disturb the
+# function being patched.
+#
+# A SHN_ABS symbol has no section, so any walk of sym->sec which does not check
+# dereferences NULL -- and the kernel has plenty, from linker scripts and from
+# .set in assembly.  __ADDRESSABLE() emits a pointer into .discard.addressable
+# to keep a symbol referenced; it means nothing to a livepatch and is discarded
+# at link time, but it is a relocation like any other and gets looked at.
+#
+# Neither is what the patch changes.  The failure this guards against is not a
+# wrong answer but a crash or an error on input the kernel produces routinely,
+# which would make any function near one unpatchable.
+#
+# Not isolated to a single guard: the absolute symbol here has zero length, so
+# it is excluded before the section check is reached and removing that check
+# alone changes nothing observable.  This stands as a check on the behaviour
+# rather than on the line which produces it.
+#
+# Covers the same ground as corpus/x86_64/checksum-abs-sym-skip and
+# addressable-symbols in Joe Lawrence's klp-build unit test corpus.
+
+. "$(dirname "$0")/../lib.sh"
+
+setup
+build_pair abs_and_addressable.c
+
+# The premise: the fixture really did produce both.
+in_symbols orig.o | grep -q 'ABS.*abs_sym' ||
+	probe_skip "assembler did not make abs_sym absolute here"
+assert_input_section .discard.addressable
+
+# Checksumming has to survive them, and still see the function that changed.
+run_checksum
+assert_checksum_differs target
+assert_checksum_matches helper
+
+# So does the diff.
+run_diff
+assert_patched target
+assert_not_patched helper
+
+# An absolute symbol has no address to record a checksum against, so it gets
+# no entry -- the reference to it is what mattered, not the symbol itself.
+in_relocs orig.o | awk '/rela\.discard\.sym_checksum/,/^$/' | grep -qw abs_sym &&
+	fail "absolute symbol got a checksum entry"
+
+pass "absolute and __ADDRESSABLE symbols do not disturb the patched function"
-- 
2.53.0-Meta

