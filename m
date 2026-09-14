Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A894119F4
	for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 23:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789427298; cv=none; b=OFa4d6FmbB1KjMeRuRXQMJbKqFJiqJxQrwtvvwyr4gCc36xpGWqyXpFSazTX75FOclJTSHTwcn5REMBKCVvf30+Fh2HXpjfjWtneQVk/Vhg5Y3Wxpw7sGDMphfvPYwZQTHmYjuzIdnzWBY5bScpaTPPvmaAxwq50DPNclEYRP3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789427298; c=relaxed/simple;
	bh=aDgL9ip/LQzKV88njS8JB5khtySzAVDDZnEmNgrVn7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RnTW+NYwIfl4dPxFJqfeNn56NrTyoN8fx7GsXI5Yx+yPI0Geiob9oHzTPYoirEWeVDXqZtPywQ9rBjopKyWFpKhc65Oj89lzsuUG6NKBCdWYSMG5CHZO1vzp0KtDUC11bn56GNvBarmUknvj5/vbIA19rVi5YbrYnUddj+9/CKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aJbioh6o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aJbioh6o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CF0E1F000FF;
	Mon, 14 Sep 2026 23:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789427295;
	bh=u6vE0eVvK7FUBGuvOlopbyrZkw3W2w6Rl7eFKLjpmS0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aJbioh6oAiOYjquIap2oS01UKDZ3Ir1XMBEkBQHLm1cKyRbdncUMJBo11rsW/Ih+j
	 PuFeEpFQS6elFXYojSMG1L2Z+iLSoAUcNDrb0DnvrNmiGwgYa9uceSOoNBZGZpWygP
	 3rGs5hwW6SyJbkKoxA1aMb1AHwNj5UzzW8iYXBZ/DwUbD2xFgfE+aLQe2+kTtYgXj3
	 xIkGufNLkfs0MVVEYOk59H4cmhaHwJAm6GM2CIDDwL134nqz0QJhKFi9TrHF7DSo7j
	 Fqkz74tWl7FBAIhaSbSaGUEdsUL94fHM0dEIXp1G0kw5JG4BNJT8aG6N92vuoWXZK6
	 QCoO4HPAe/e/Q==
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
Subject: [PATCH v3 52/58] objtool/klp: Add test for alternative replacement code in checksums
Date: Mon, 14 Sep 2026 16:03:49 -0700
Message-ID: <20260914230355.3422996-53-song@kernel.org>
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

checksum_update_insn() walks insn->alts after hashing the instruction
itself: the alternative's type, and where the replacement forms a group,
its feature number and every instruction in it.  A patch which edits only
the replacement -- code that runs on some CPUs and not others -- still has
to move the function's checksum.

When it does not, klp diff calls the function unchanged and leaves it out.
The patch ships the old replacement, and the bug is fixed only on machines
whose CPU takes the other arm.  Which machines those are depends on the
feature bit, so it presents as a machine-specific bug rather than a missing
patch.

insn->alts is built by objtool's check pass, not by the compiler, so the
pair goes through that first.  --mcount is the action used: it is the
cheapest one that does not also need --link.

Two of the three paths are isolated.  Skipping the alts walk and dropping
the feature hash both make this fail, and the second of those only exists
inside the alt_group branch, so reaching it proves the grouped path is
taken.  The alternative's type is hashed but not varied here -- the fixture
emits one kind of alternative -- so that line is covered without being
isolated, as is the in_alt recursion guard, which wants nested
alternatives.

Assisted-by: Claude:claude-opus-4
Based-on-test-by: Joe Lawrence <joe.lawrence@redhat.com>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 .../objtool/tests/x86/fixtures/checksum_alt.c | 66 +++++++++++++++++++
 tools/objtool/tests/x86/test-checksum-alt.sh  | 45 +++++++++++++
 2 files changed, 111 insertions(+)
 create mode 100644 tools/objtool/tests/x86/fixtures/checksum_alt.c
 create mode 100755 tools/objtool/tests/x86/test-checksum-alt.sh

diff --git a/tools/objtool/tests/x86/fixtures/checksum_alt.c b/tools/objtool/tests/x86/fixtures/checksum_alt.c
new file mode 100644
index 000000000000..ed342d94eb9e
--- /dev/null
+++ b/tools/objtool/tests/x86/fixtures/checksum_alt.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * An x86 alternative whose replacement code is part of the patched function's
+ * checksum.
+ *
+ * checksum_update_insn() walks insn->alts after hashing the instruction
+ * itself, hashing the alternative's type and, when the replacement forms a
+ * group, its feature number and every instruction in it.  So editing only the
+ * replacement -- code the CPU may or may not ever run -- has to move the
+ * function's checksum.
+ *
+ * It is reached through objtool's own alternative handling, so the object has
+ * to go through the check pass first: insn->alts is built there, not by the
+ * compiler.
+ *
+ * struct alt_instr is written out by hand as in empty_alternative.c: s32
+ * instr_offset, s32 repl_offset, u32 ft_flags, u8 instrlen, u8 replacementlen.
+ *
+ * Variants, applied to the patched build only:
+ *
+ *   ALT_REPL     the replacement instruction changes; the original does not
+ *   ALT_FEATURE  the feature number changes; no code changes at all
+ */
+
+static const char __modinfo[]
+	__attribute__((section(".modinfo"), used, aligned(1))) = "\0name=vmlinux";
+
+/*
+ * Both spellings are two bytes, because a replacement may not be longer than
+ * the instruction it replaces: "xchg %ax, %ax" is 66 90 and two nops are
+ * 90 90.  The original below is padded to match.
+ */
+#if defined(PATCHED) && defined(ALT_REPL)
+#define REPL_INSN "	nop\n\t	nop\n\t"
+#else
+#define REPL_INSN "	xchg %ax, %ax\n\t"
+#endif
+
+#if defined(PATCHED) && defined(ALT_FEATURE)
+#define FEATURE "7"
+#else
+#define FEATURE "3"
+#endif
+
+int target(int x)
+{
+	asm volatile(
+		"661:	nop\n\t"
+		"	nop\n\t"
+		"662:\n\t"
+		".pushsection .altinstr_replacement, \"ax\"\n\t"
+		".globl target_repl\n\t"
+		"target_repl:\n\t"
+		REPL_INSN
+		"target_repl_end:\n\t"
+		".popsection\n\t"
+		".pushsection .altinstructions, \"aM\", @progbits, 14\n\t"
+		".long 661b - .\n\t"
+		".long target_repl - .\n\t"
+		".long " FEATURE "\n\t"
+		".byte 662b - 661b\n\t"
+		".byte target_repl_end - target_repl\n\t"
+		".popsection\n\t");
+
+	return x + 1;
+}
diff --git a/tools/objtool/tests/x86/test-checksum-alt.sh b/tools/objtool/tests/x86/test-checksum-alt.sh
new file mode 100755
index 000000000000..74ebfca2b3ff
--- /dev/null
+++ b/tools/objtool/tests/x86/test-checksum-alt.sh
@@ -0,0 +1,45 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# An alternative's replacement code counts towards the checksum of the function
+# it belongs to.
+#
+# checksum_update_insn() walks insn->alts after hashing the instruction itself:
+# the alternative's type, and where the replacement forms a group, its feature
+# number and every instruction in it.  So a patch which edits only the
+# replacement -- code that runs on some CPUs and not others -- still has to
+# move the function's checksum.
+#
+# If it does not, klp diff decides the function is unchanged and leaves it out.
+# The patch then ships the old replacement, and the bug is fixed only on
+# machines whose CPU takes the other arm.  Which machines those are depends on
+# the feature bit, so the failure looks like a machine-specific bug rather than
+# a missing patch.
+#
+# insn->alts exists only after objtool's check pass, so the pair goes through
+# that first -- the compiler emits none of this structure itself.
+#
+# Covers the same ground as corpus/x86_64/checksum-alt-group,
+# checksum-alt-no-group and checksum-alt-recursion-guard in Joe Lawrence's
+# klp-build unit test corpus.
+
+. "$(dirname "$0")/../lib.sh"
+
+setup
+
+check()
+{
+	build_pair checksum_alt.c "-D$1"
+	assert_input_section .altinstructions
+	run_objtool_check --mcount
+	run_checksum
+
+	assert_checksum_differs target
+}
+
+# The replacement instruction itself.
+check ALT_REPL
+# The feature number, with no instruction anywhere changed.
+check ALT_FEATURE
+
+pass "alternative replacement code counts towards the checksum"
-- 
2.53.0-Meta

