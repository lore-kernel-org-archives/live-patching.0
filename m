Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A87841D4D0
	for <live-patching@vger.kernel.org>; Fri, 11 Sep 2026 18:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789152745; cv=none; b=ZMRBPRgimNFeJWP1xm7WH4qtn/9R9VBDbR9a5QuGPmIo8KRK6npELctkKnqao9tj17S9dZmbJ+6xXkH0X+3CCmmFlJqTjsEjEfKTouaG9syNkj17w04lwlaogcK1Llj6HIBJjno8AjA2qiBYBcow+0gV+JTe+xU743LvfWNEwbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789152745; c=relaxed/simple;
	bh=cpS3O/hdWdhabstIWmc5lfULduMP9ax/O4HPZ6czKQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fZ2o0+HB6+Z2dGWMIEcF+TBpP/P18qahfg7LaFhrBPH+3Q/AZconC6EpVqNGJ6+FpXUYFk+ZHjAuOTQy7vcaWW43nQovyfeQrQY1fHD03F+fI35ZuPAeMxyYmI3MZvpmM6Vz/8KH5x0JHqQ6kEIN2XhXM04M5fskyN2R/iggMAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hdbWAE+E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hdbWAE+E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 607F61F00893;
	Fri, 11 Sep 2026 18:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789152743;
	bh=m1UuD1cwPKJuY+NgS4Y53i0Ymq07Df585cULuiyeVeU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hdbWAE+EfoiHpsWzMGLquTEbTkuUqWIf3x0k5HHc4B3fRe04oo/5UWaTNyCsKrvMH
	 7Irz29lzDZP0ShgESaaJHQXkgO6j3mFAVWND1TSL1iO/o5yrbBmEc+Vs5ZGCEJyaPN
	 I9ZDAhNdQZLgO+iXmrXTozjntmdsyJNvpmbXaY4DuHkcm3QDEaKnHzZPX8e/bCskWe
	 fRLtR1iQxC4ISVeRXzeRk6nl2ccttpjBqvIiys3rflbPLKSw+xht9gLukNPJHLirSV
	 0O6VBGRYlydIzkRi8r6j+ddguNkwXeZf9EWBq/rcIsaXWJQ0T1V5wnEEab1o6YFFR4
	 uTqLhGbzjJU6Q==
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
Subject: [PATCH 45/58] objtool/klp: Test text annotations on alternative replacements
Date: Fri, 11 Sep 2026 11:50:18 -0700
Message-ID: <20260911185031.1534046-20-song@kernel.org>
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

The kernel annotates instructions inside an ALTERNATIVE's replacement
wherever objtool has to be told something about them -- a retpoline-safe
indirect branch, a deliberately absent ENDBR.  klp diff dropped those
annotations, for two reasons: replacement code has no real symbol, so the
NOTYPE fake symbol objtool invents for it was not recognised as worth
keeping a reference to, and .discard.annotate_insn was processed before
.altinstructions, so the replacement it named had no clone yet.

Nothing fails at build time when the annotation goes missing.  It surfaces
later as objtool warning about, or rejecting, the very code the annotation
was there to explain.

The fixture keeps the replacement label global, as empty_alternative.c
does, so the relocations name it instead of .altinstr_replacement plus an
addend -- which klp diff rejects outright.  The label is still NOTYPE,
which is the property under test.  The test asserts the relocation as well
as the section, since an entry whose relocation was dropped would otherwise
pass.

Verified by reverting commit 62a7a01fde87 ("objtool/klp: Fix extraction of
text annotations for alternatives"): the output has no
.discard.annotate_insn at all and the test fails, under both gcc and clang.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 .../objtool/tests/x86/fixtures/alt_annotate.c | 57 +++++++++++++++++++
 .../objtool/tests/x86/test-alt-annotation.sh  | 38 +++++++++++++
 2 files changed, 95 insertions(+)
 create mode 100644 tools/objtool/tests/x86/fixtures/alt_annotate.c
 create mode 100755 tools/objtool/tests/x86/test-alt-annotation.sh

diff --git a/tools/objtool/tests/x86/fixtures/alt_annotate.c b/tools/objtool/tests/x86/fixtures/alt_annotate.c
new file mode 100644
index 000000000000..af44d320dcb0
--- /dev/null
+++ b/tools/objtool/tests/x86/fixtures/alt_annotate.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * An x86 alternative whose replacement instruction carries a text annotation.
+ *
+ * The kernel does this wherever an ALTERNATIVE contains something objtool has
+ * to be told about -- a retpoline-safe indirect branch, an intentionally
+ * missing ENDBR -- so the .discard.annotate_insn entry references an address
+ * inside .altinstr_replacement rather than inside a function.
+ *
+ * Two things make that awkward for klp diff, and both are why this fixture
+ * exists.  Replacement code has no real symbol: objtool invents a NOTYPE fake
+ * symbol for it, so an annotation pointing there does not reference a FUNC.
+ * And .discard.annotate_insn has to be cloned after .altinstructions, or the
+ * replacement it names has no clone to point at yet.
+ *
+ * struct alt_instr is written out by hand as in empty_alternative.c: s32
+ * instr_offset, s32 repl_offset, u32 ft_flags, u8 instrlen, u8 replacementlen,
+ * with an entsize so klp diff can find the entry boundaries.
+ * .discard.annotate_insn entries are s32 offset, s32 type; type 2 is
+ * ANNOTYPE_RETPOLINE_SAFE.
+ *
+ * The replacement label is global so the relocations name it rather than
+ * .altinstr_replacement plus an addend, which klp diff cannot convert.  It is
+ * still NOTYPE, which is the shape that matters here.
+ */
+
+static const char __modinfo[]
+	__attribute__((section(".modinfo"), used, aligned(1))) = "\0name=vmlinux";
+
+int target(int x)
+{
+	asm volatile(
+		"661:	nop\n\t"
+		".pushsection .altinstr_replacement, \"ax\"\n\t"
+		".globl target_repl\n\t"
+		"target_repl:\n\t"
+		"	nop\n\t"
+		/* The annotation lands inside the replacement. */
+		".pushsection .discard.annotate_insn, \"M\", @progbits, 8\n\t"
+		".long target_repl - .\n\t"
+		".long 2\n\t"
+		".popsection\n\t"
+		"target_repl_end:\n\t"
+		".popsection\n\t"
+		".pushsection .altinstructions, \"aM\", @progbits, 14\n\t"
+		".long 661b - .\n\t"
+		".long target_repl - .\n\t"
+		".long 0\n\t"
+		".byte 1\n\t"
+		".byte target_repl_end - target_repl\n\t"
+		".popsection\n\t");
+#ifdef PATCHED
+	return x + 2;
+#else
+	return x + 1;
+#endif
+}
diff --git a/tools/objtool/tests/x86/test-alt-annotation.sh b/tools/objtool/tests/x86/test-alt-annotation.sh
new file mode 100755
index 000000000000..96760e6df9e5
--- /dev/null
+++ b/tools/objtool/tests/x86/test-alt-annotation.sh
@@ -0,0 +1,38 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# A text annotation on an instruction inside an alternative's replacement must
+# be carried into the patch.
+#
+# The kernel annotates replacement code wherever objtool has to be told
+# something about it -- a retpoline-safe indirect branch, a deliberately absent
+# ENDBR.  Two things made klp diff drop those annotations:
+#
+#   - replacement code has no real symbol, so objtool invents a NOTYPE fake
+#     one, and the extraction only kept references to FUNC symbols;
+#   - .discard.annotate_insn was processed before .altinstructions, so the
+#     replacement it referenced had no clone to point at yet.
+#
+# Nothing fails at build time when the annotation goes missing.  It surfaces
+# later as objtool warning about, or rejecting, the patched code it was there
+# to explain.
+#
+# Fixed by 62a7a01fde87 ("objtool/klp: Fix extraction of text annotations for
+# alternatives").
+
+. "$(dirname "$0")/../lib.sh"
+
+setup
+build_pair alt_annotate.c
+
+assert_input_section .altinstructions
+assert_input_section .discard.annotate_insn
+
+run_diff
+
+# The annotation has to survive, and to still name the replacement.  Checking
+# only the section would pass on an entry whose relocation was dropped.
+assert_section .discard.annotate_insn
+assert_reloc_sym .discard.annotate_insn target_repl
+
+pass "text annotation on an alternative replacement carried into the patch"
-- 
2.53.0-Meta

