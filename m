Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F8C2DCF45
	for <live-patching@vger.kernel.org>; Wed, 16 Sep 2026 18:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789584474; cv=none; b=l0zhbYGUI2Eb1u7pxFcEWDfEMr7W1iAlnYRdEM2VhWwnRk+EM3uQpXNTXCbcczVzxAO09LeXQXY4GBwVhrhsBN9LWByv2nRjWl0c/8bmdYYBOLQRkGT5URuytVmBXr1QVtq2LHbHSAQeu3L7+BvlutC4oSr15ESibXmj3aiJxzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789584474; c=relaxed/simple;
	bh=NuIxpY7fKIS2Fk6KmUCdREL8Y5X1T7gjpV7phrC6Ito=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gNdple5rb/yA6cLa/CtdtnLwiYml+FO+KwaaYieDwBJQGDGcdHb8oHBn8qvE4qy2gj7j/k+lPd6xTFTK6ynX8f1WY5WXSv6KLxpenJZEcv+bZg0BK+rTQPzy/MVbXhFJQL2bFZ3pBbW5obxX+aDVm/LE8R7ZOdWtxVptf/2I9iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e9ykbN4W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e9ykbN4W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E797D1F00898;
	Wed, 16 Sep 2026 18:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789584458;
	bh=5Yi/fQhmPc3N5rSzfQX5f1hnecz8C7hPLt24knCE7PA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e9ykbN4WpJczCymFbVHEo1OVQ60Jz+XngO5QSygyrsXXjEal4PccsC1umCB45Gg9k
	 UVoBOCipk4Cj60ITOnQj1OXiZ9QsmDHQTQxtD3kN0EiS6N1z40MqfC/XevUdOfqnWY
	 YjzAVR7rGkDSSbBpopTd7zkroBPxd1FZBqYJ08qI/oMgNfUMR1Z7oX1sWkOgs5N13v
	 8s7PWilnVnbAJi7Dz+B/ZAuGPtV/FNPNoB1G7Zq4Z4uDmMPH+UyqGjawF6jJ1rihkZ
	 t7rdG1bzPydVanGuXKAXtzeuqWxNrvCO3BG389WVFT8Cyn7Zoa6AirLWBREUJgRUL4
	 DKQuiZRs9g6dA==
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
Subject: [PATCH v5 46/58] objtool/klp: Add test for data object checksums
Date: Wed, 16 Sep 2026 11:43:39 -0700
Message-ID: <20260916184351.2720310-47-song@kernel.org>
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

klp checksum hashes a data symbol's length, its bytes, and every relocation
it carries -- as the target's name and adjusted addend, except a reference
into a string section, which contributes the string's contents instead.
Nothing covered any of it.

Each is load-bearing, and the failure is always the same shape: a checksum
which ignores one calls a changed object unchanged, klp diff leaves it out
of the patch, and the patched code goes on reading the kernel's old copy.
The string case cannot be caught by hashing bytes: the pointer is
identical, same section and same offset, and only the text it refers to
moved.

One fixture, six variants applied to the patched build alone.  Each was
verified by sabotaging the line it covers and watching the test fail:

  raw bytes            initialiser change
  length               a .bss object grows; its bytes are never hashed
  string contents      literal edited in place, pointer untouched
  reloc target name    pointer moved to another function
  reloc addend         same array, different index
  section-symbol path  the same, via a static's section symbol

Two of those needed the fixture rebuilding.  An initialised array does not
isolate the length, because growing one changes the hashed bytes too --
hence .bss, where there are none.  And a named char[] does not reach the
contents-hashing path at all: that keys on SHF_STRINGS, which the compiler
sets on the mergeable section a literal lands in and not on an array given
a section of its own.

Assisted-by: Claude:claude-opus-4
Based-on-test-by: Joe Lawrence <joe.lawrence@redhat.com>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 .../tests/generic/fixtures/checksum_data.c    | 116 ++++++++++++++++++
 .../tests/generic/test-checksum-data.sh       |  61 +++++++++
 2 files changed, 177 insertions(+)
 create mode 100644 tools/objtool/tests/generic/fixtures/checksum_data.c
 create mode 100755 tools/objtool/tests/generic/test-checksum-data.sh

diff --git a/tools/objtool/tests/generic/fixtures/checksum_data.c b/tools/objtool/tests/generic/fixtures/checksum_data.c
new file mode 100644
index 000000000000..6310af5c02d3
--- /dev/null
+++ b/tools/objtool/tests/generic/fixtures/checksum_data.c
@@ -0,0 +1,116 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Data objects whose checksums must move for reasons the raw bytes do not
+ * show.
+ *
+ * checksum_update_object() hashes a data symbol's length and its bytes, and
+ * then walks its relocations: a reference into a string section contributes
+ * the string's *contents*, and any other reference contributes the target
+ * symbol's name and the adjusted addend.  So three changes that leave the
+ * object's own bytes identical still have to change its checksum:
+ *
+ * Each variant is selected by a -D on the patched build only, so the original
+ * is always the baseline:
+ *
+ *   WHICH_FUNC   the function pointer points somewhere else
+ *   WHICH_STR    the string pointer points at a different literal
+ *   STR_CONTENT  the string it points at is edited in place
+ *   WHICH_SLOT   the same array, at a different index: addend only
+ *   WHICH_PRIV   likewise, but a static, reached through its section symbol
+ *
+ * The last is the interesting one.  Nothing in the pointer changes -- same
+ * section, same offset -- so a checksum that hashed only the relocation and
+ * not what it referred to would call the object unchanged, and the patched
+ * kernel would keep the old string.
+ */
+
+static const char __modinfo[]
+	__attribute__((section(".modinfo"), used, aligned(1))) = "\0name=vmlinux";
+
+int callee_a(int x);
+int callee_b(int x);
+int callee_a(int x) { return x + 1; }
+int callee_b(int x) { return x + 2; }
+
+/*
+ * String *literals*, not named arrays.  The contents-hashing path keys on
+ * SHF_STRINGS, which the compiler sets on the mergeable .rodata.str1.1 a
+ * literal lands in and not on a named char[] given a section of its own.  A
+ * fixture using the latter exercises the ordinary name-and-addend path and
+ * reports nothing when the text changes.
+ */
+#if defined(PATCHED) && defined(STR_CONTENT)
+#define MESSAGE "edited"
+#else
+#define MESSAGE "original"
+#endif
+
+/* A plain data object: only its own bytes decide the checksum. */
+#if defined(PATCHED) && defined(PLAIN_VALUE)
+int plain = 43;
+#else
+int plain = 42;
+#endif
+
+/*
+ * A .bss object, where length is the only thing there is to hash: the section
+ * has no data, so the bytes are skipped and only sym->len distinguishes this
+ * from an object of another size.  An initialised array would not isolate it
+ * -- growing one changes the hashed bytes as well.
+ */
+#if defined(PATCHED) && defined(LONGER)
+char sized[4];
+#else
+char sized[2];
+#endif
+
+/*
+ * A reference into the middle of an array: same target symbol, different
+ * addend.  Nothing else in the object changes, so this is the only way to see
+ * whether the addend is hashed at all.
+ */
+int slots[4];
+
+/*
+ * A file-local array.  A reference to a static lands on its section symbol
+ * plus an offset, so the hash has to resolve that back to the underlying
+ * object before it has a name to hash at all -- a different code path from the
+ * global above, and one that silently contributes nothing when it fails.
+ */
+static int priv_slots[4];
+
+struct desc {
+	int (*fn)(int arg);
+	const char *str;
+	int *slot;
+	int *priv;
+};
+
+const struct desc descriptor = {
+#if defined(PATCHED) && defined(WHICH_FUNC)
+	.fn = callee_b,
+#else
+	.fn = callee_a,
+#endif
+#if defined(PATCHED) && defined(WHICH_STR)
+	.str = "a different literal",
+#else
+	.str = MESSAGE,
+#endif
+#if defined(PATCHED) && defined(WHICH_SLOT)
+	.slot = &slots[2],
+#else
+	.slot = &slots[1],
+#endif
+#if defined(PATCHED) && defined(WHICH_PRIV)
+	.priv = &priv_slots[3],
+#else
+	.priv = &priv_slots[1],
+#endif
+};
+
+int target(int x)
+{
+	return descriptor.fn(x) + plain + sized[0] + (int)descriptor.str[0] +
+	       *descriptor.slot + *descriptor.priv;
+}
diff --git a/tools/objtool/tests/generic/test-checksum-data.sh b/tools/objtool/tests/generic/test-checksum-data.sh
new file mode 100755
index 000000000000..e915026b79a7
--- /dev/null
+++ b/tools/objtool/tests/generic/test-checksum-data.sh
@@ -0,0 +1,61 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# What a data object's checksum has to cover.
+#
+# checksum_update_object() hashes the symbol's length, its bytes (when the
+# section has any -- .bss does not), and then
+# every relocation it carries -- as the target's name plus the adjusted addend,
+# except for a reference into a string section, which contributes the string's
+# contents instead.
+#
+# Each of those is load-bearing, and the failure is always the same shape: a
+# checksum that ignores one of them calls a changed object unchanged, klp diff
+# leaves it out of the patch, and the patched code goes on reading the
+# kernel's old copy.  Nothing says so at build time.
+#
+# The string case is the one that cannot be caught by hashing bytes alone.  The
+# pointer is identical -- same section, same offset -- and only the text it
+# refers to moved.
+#
+# Covers the same ground as corpus/x86_64/checksum-data-basic,
+# checksum-data-func-ptr, checksum-data-string-ptr and checksum-string-reloc in
+# Joe Lawrence's klp-build unit test corpus.
+
+. "$(dirname "$0")/../lib.sh"
+
+setup
+
+# check <flag> <symbol> <what changed>
+#
+# Build the pair with one difference and require that symbol's checksum to move.
+check()
+{
+	build_pair checksum_data.c "-D$1"
+	run_checksum
+
+	assert_checksum_differs "$2"
+}
+
+# The object's own bytes.
+check PLAIN_VALUE plain
+# Its length, for a .bss object whose bytes are not hashed at all.
+check LONGER sized
+# A relocation's target: same bytes in the object, different symbol named.
+check WHICH_FUNC descriptor
+check WHICH_STR descriptor
+# The contents of a string the object points at, with the pointer untouched.
+check STR_CONTENT descriptor
+# A relocation's addend: same target symbol, different offset into it.
+check WHICH_SLOT descriptor
+# The same, for a static reached through its section symbol: the reference has
+# to be resolved back to the object before there is a name or offset to hash.
+check WHICH_PRIV descriptor
+
+# Having shown five things that must change it, show one that must not: an
+# unrelated edit elsewhere in the file leaves this object alone.
+build_pair checksum_data.c -DPLAIN_VALUE
+run_checksum
+assert_checksum_matches descriptor
+
+pass "data checksums cover length, bytes, reloc targets and string contents"
-- 
2.53.0-Meta

