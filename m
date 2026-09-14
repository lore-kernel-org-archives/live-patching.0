Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087AF3E44EE
	for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 06:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789367405; cv=none; b=E0fU4uLDNSax9+kTaW4fucLSFLDLGZe2OTytY5eqdiZWcxQOsXl6PmhrfE4bHAVfmFMQE4kPnJiScVuYNmRGycewIr7dezvDEdKyPBc8L2u58q1o1wTj8uCdopJCFAfJG3mkOvwVjSiZ6IPCtDWGaFgvWERiJGO/eJs6IPeid08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789367405; c=relaxed/simple;
	bh=dI5uUZqHbGwSs1mI4vxdRCet9zQ0S7lXmrnh2r05XEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c5rXIeduChf+oBadKaleus7oXI0yBC4zYZPLZSCvVFH6uGJ/2V8lUJDsc4+/BoXunkP38ugrGjN7t+Iw7yR+Pelxmy+Fn/payI2+4/a4dCanA1h5wgUgHE+N5b2B5UXelA/o8tnZ9FSjVU1CTp1cJV/xfnx25aV0+5VD/3ylG8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rhjma3A0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rhjma3A0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEBC31F000FF;
	Mon, 14 Sep 2026 06:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789367400;
	bh=ZQbD4nGw2pCzCwSux2YDE048GeZVe7JD5zU3hjhzfs8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Rhjma3A0r3woiPZZLJKhy5lz1zBZ6ekY17BINc1ui36cEi1Z7Omsb2Dzul1qeFFpP
	 6K/beBqUdXuQ+PVuH55/7T4roTHeU6X2isKV1qA6/awoREPpqFQrUKnOK9Jym6bRJ1
	 e55yhNJknEQw0uNhLnIIfXifO+ksmnPkcvyXkM7ZXzv4lheop3Cmc5YmgJA46fF8rZ
	 OGE3SnC0AEhr2inzIG4hEx/46676Eyt/UER9p0mfHZSBZsVqr5dV6BgWgZ3UxpnPXI
	 pRX7zC3/b0eAuiMW0axm9LEQneZQ+FdlDR09NnQx8cQ+r2Dlohq7JzeIak0uH+2R2T
	 b9Jn09/XeQJnA==
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
Subject: [PATCH v2 51/58] objtool/klp: Add test for instruction operand checksums
Date: Sun, 13 Sep 2026 23:25:07 -0700
Message-ID: <20260914062514.926997-52-song@kernel.org>
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

checksum_update_insn() hashes an instruction's bytes and then what any
relocation on it refers to: a string section contributes the string's
contents, anything else the target symbol's name and adjusted addend, with
a reference to a static resolved through its section symbol first.

None of that shows up in the bytes.  A rel32 operand is zero in the object
and supplied by the relocation, so calling a different function, editing a
literal the code passes, or reading a different index of an array all leave
the encoded instruction byte-identical.  A checksum stopping at the bytes
reports the function unchanged and the patch silently does not contain the
fix.

test-checksum-position is the other half: what must *not* change the
checksum when a function merely moves.

Each of the four is verified by sabotaging the line it covers.  The static
case needed a writer the compiler cannot see through -- without one it
proves the array is never written, folds every read to zero, and emits no
relocation at all, so the reference under test does not exist and the
variant passes having compared two identical objects.

Assisted-by: Claude:claude-opus-4
Based-on-test-by: Joe Lawrence <joe.lawrence@redhat.com>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 .../tests/generic/fixtures/checksum_insn.c    | 78 +++++++++++++++++++
 .../tests/generic/test-checksum-insn.sh       | 49 ++++++++++++
 2 files changed, 127 insertions(+)
 create mode 100644 tools/objtool/tests/generic/fixtures/checksum_insn.c
 create mode 100755 tools/objtool/tests/generic/test-checksum-insn.sh

diff --git a/tools/objtool/tests/generic/fixtures/checksum_insn.c b/tools/objtool/tests/generic/fixtures/checksum_insn.c
new file mode 100644
index 000000000000..10f70a74a976
--- /dev/null
+++ b/tools/objtool/tests/generic/fixtures/checksum_insn.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Instruction operands whose change must move a function's checksum even
+ * though the instruction bytes themselves do not.
+ *
+ * checksum_update_insn() hashes the raw bytes and then, when the instruction
+ * carries a relocation, what that relocation refers to: a string section
+ * contributes the string's contents, anything else the target symbol's name
+ * and the adjusted addend.  A reference to a static arrives as a section
+ * symbol and has to be resolved back to the object first.
+ *
+ * The bytes are identical in every case below -- a rel32 operand is zero in
+ * the object and supplied by the relocation -- so a checksum that stopped at
+ * the bytes would call all of these unchanged.
+ *
+ * Each variant applies to the patched build only:
+ *
+ *   WHICH_CALL    calls a different function
+ *   STR_CONTENT   passes a literal whose text was edited
+ *   WHICH_SLOT    reads a different index of a global array: addend only
+ *   WHICH_PRIV    the same, for a static, reached through its section symbol
+ */
+
+static const char __modinfo[]
+	__attribute__((section(".modinfo"), used, aligned(1))) = "\0name=vmlinux";
+
+int callee_a(int x);
+int callee_b(int x);
+int sink(const char *s);
+
+int slots[4];
+
+/*
+ * A file-local array, plus a writer the compiler cannot see through.  Without
+ * one it can prove the array is never written, folds every read to zero, and
+ * emits no relocation at all -- so the reference this is here to exercise does
+ * not exist.
+ */
+static int priv_slots[4];
+
+void set_priv(int i, int v);
+void set_priv(int i, int v)
+{
+	priv_slots[i] = v;
+}
+
+#if defined(PATCHED) && defined(STR_CONTENT)
+#define MESSAGE "edited"
+#else
+#define MESSAGE "original"
+#endif
+
+int target(int x)
+{
+	int r;
+
+#if defined(PATCHED) && defined(WHICH_CALL)
+	r = callee_b(x);
+#else
+	r = callee_a(x);
+#endif
+
+	r += sink(MESSAGE);
+
+#if defined(PATCHED) && defined(WHICH_SLOT)
+	r += slots[2];
+#else
+	r += slots[1];
+#endif
+
+#if defined(PATCHED) && defined(WHICH_PRIV)
+	r += priv_slots[3];
+#else
+	r += priv_slots[1];
+#endif
+
+	return r;
+}
diff --git a/tools/objtool/tests/generic/test-checksum-insn.sh b/tools/objtool/tests/generic/test-checksum-insn.sh
new file mode 100755
index 000000000000..e1c04a1f518a
--- /dev/null
+++ b/tools/objtool/tests/generic/test-checksum-insn.sh
@@ -0,0 +1,49 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# What a function's checksum has to cover beyond its instruction bytes.
+#
+# checksum_update_insn() hashes the raw bytes, and then what any relocation on
+# the instruction refers to: a string section contributes the string's
+# contents, anything else the target symbol's name and the adjusted addend,
+# with a reference to a static resolved back through its section symbol first.
+#
+# None of these show up in the bytes.  A rel32 operand is zero in the object
+# and supplied by the relocation, so every change below leaves the encoded
+# instruction byte-identical.  A checksum stopping at the bytes reports the
+# function unchanged, klp diff omits it, and the patch silently does not
+# contain the fix.
+#
+# test-checksum-position is the other half of this: it covers what must *not*
+# change the checksum when a function merely moves.
+#
+# Covers the same ground as corpus/x86_64/checksum-reloc-sym,
+# checksum-pc-relative-addend, checksum-string-reloc and
+# checksum-sec-sym-resolve in Joe Lawrence's klp-build unit test corpus.
+
+. "$(dirname "$0")/../lib.sh"
+
+setup
+
+# check <flag> <what it changes>
+check()
+{
+	build_pair checksum_insn.c "-D$1"
+	run_checksum
+
+	# The premise for all of them: the operand is a relocation, not bytes.
+	assert_checksum_differs target
+}
+
+check WHICH_CALL    # relocation target name
+check STR_CONTENT   # contents of a string the code passes
+check WHICH_SLOT    # addend, same target symbol
+check WHICH_PRIV    # addend via a static's section symbol
+
+# The converse: rebuilding identical source leaves it alone, so the above is
+# not just "any rebuild moves the checksum".
+build_pair checksum_insn.c
+run_checksum
+assert_checksum_matches target
+
+pass "instruction checksums cover reloc targets, addends and string contents"
-- 
2.53.0-Meta

