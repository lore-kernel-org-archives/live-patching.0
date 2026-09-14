Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433D43E1701
	for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 06:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789367239; cv=none; b=Ie9zHzQneRpsdlAJI5HGOviBvTicEnSv6Y0xTUjRF/omIPvzQjrarSFItt9SdMbAvap1ID6Er9cpm4USeypaWOq5FXiGTWtcYHqmZLWTWHe4ItCqal14w7KaNrnleW3q1notqZwRpAr25nSuP3TVbBhzeJI/HqwPIAAUWUW0jT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789367239; c=relaxed/simple;
	bh=P28h7MNDgtZWqr4WDmOYefcYtepbUq0byuLDapd/1iM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WOf0flIlJ0bqUzTRYgZ9spMpkcKRGr451PpS+s3d9+r0/qmOserXnLllcknc6T7XnJXrpLX2q7NDEwaoAYWygGcH/bHdMU6AHNJ9N2RMGScZVCSjDTNqsJQN/oAQQ8TYF/QZbMwfLNRQZfvV/vckmlT7wIzj/BzcDD6c0/TUHj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lXKfSUu0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lXKfSUu0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC2CD1F00893;
	Mon, 14 Sep 2026 06:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789367231;
	bh=cAZwMrBw6GHczvYXPp4WPmfpviRDbyVvXFUzyS29Q8Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lXKfSUu0l+wuURtmrONdsQMAlDJ2j97O+gQyGa3v8KM9GAdDZ0DaXIc+b6IojkEfk
	 T3FRsgGD6Js8FSZDxQBMciifHxnB7+R7D0WpgCCWbfINmF/+7j7DBOaZQCwNcqIakR
	 /JNRlqVp9VznCQ+OA+Zoz8rprKPsiChyxbCEshoVaqzu620IJfYaBArL7+jKMVcecw
	 bDw3+2X0OJ6lnimuy4xZCyRtlQGBJOTSfmvog3NywYUPXMmatx9PyiM+rHNs+z5OvJ
	 Cs7t+p01NjKfQA+pkGCGcWHQ3xnJHgWmoosTWKEOlc/aHq1cImC19289Pb0WFk45Fu
	 b6qUMdnr45KnA==
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
Subject: [PATCH v2 19/58] objtool/klp: Add test for jump table key relocations
Date: Sun, 13 Sep 2026 23:24:35 -0700
Message-ID: <20260914062514.926997-20-song@kernel.org>
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

From: Puranjay Mohan <puranjay@kernel.org>

A cloned __jump_table entry must keep a relocation in its key slot.
objtool parses the table again after klp diff to convert the static
branch's scaffold instruction, and an empty slot leaves it unable to do so.
The scaffold then stays as emitted and the module trips BUG() in
__jump_label_patch() once the key's state differs from its compile-time
default.

Check both halves for a vmlinux-owned key: unexported gives a tombstone
plus a klp relocation, exported gives an ordinary relocation and no klp
machinery.

The fixture defines the key as an STT_OBJECT, which is what the kernel
emits. validate_special_section_klp_reloc() ignores anything else, so a
fixture using an undefined extern would skip the interesting paths.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 .../tests/generic/fixtures/jump_label.c       | 76 +++++++++++++++++++
 .../tests/generic/test-jump-label-key.sh      | 44 +++++++++++
 2 files changed, 120 insertions(+)
 create mode 100644 tools/objtool/tests/generic/fixtures/jump_label.c
 create mode 100755 tools/objtool/tests/generic/test-jump-label-key.sh

diff --git a/tools/objtool/tests/generic/fixtures/jump_label.c b/tools/objtool/tests/generic/fixtures/jump_label.c
new file mode 100644
index 000000000000..ecd3c06912af
--- /dev/null
+++ b/tools/objtool/tests/generic/fixtures/jump_label.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Static branch in a patched function.  The jump table entry is written out by
+ * hand, mirroring JUMP_TABLE_ENTRY(), so the fixture builds without kernel
+ * headers.  The key is an STT_OBJECT; anything else is ignored by
+ * validate_special_section_klp_reloc().
+ *
+ * MODNAME selects whether the key is taken to belong to vmlinux or a module.
+ *
+ * NEW_KEY puts the whole static branch behind PATCHED, so the patch introduces
+ * one where the original had none -- a different question from patching code
+ * that already has a key, because the __jump_table entry itself is new.
+ *
+ * KEY_NAME renames the key.  Two names are special to
+ * validate_special_section_klp_reloc(): a __tracepoint_* key and the
+ * __UNIQUE_ID_ddebug_* one pr_debug() generates are both unsupported in a
+ * module, but are disabled with a warning rather than rejected, because the
+ * kernel is full of them and refusing outright would make ordinary functions
+ * unpatchable.
+ *
+ * STATIC_KEY makes the key file-local.  That changes the shape of the
+ * relocation rather than the meaning of the code: a reference to a static lands
+ * on the section symbol plus an addend, so the key has to be resolved from the
+ * section before it can be recognised as a key at all.
+ */
+
+#ifndef MODNAME
+#define MODNAME "vmlinux"
+#endif
+
+#ifndef KEY_NAME
+#define KEY_NAME klp_test_key
+#endif
+
+static const char __modinfo[]
+	__attribute__((section(".modinfo"), used, aligned(1))) = "\0name=" MODNAME;
+
+#ifdef STATIC_KEY
+static long KEY_NAME;
+#else
+long KEY_NAME;
+#endif
+
+int target(int x)
+{
+	int r = x;
+
+#if defined(NEW_KEY) && !defined(PATCHED)
+	/* The original has no static branch at all. */
+	return r + 1;
+#else
+	asm goto(
+		"1:	nop\n\t"
+		".pushsection	__jump_table, \"aw\"\n\t"
+		".balign	8\n\t"
+		"912:\n\t"
+		".pushsection	.discard.annotate_data, \"M\", @progbits, 8\n\t"
+		".long		912b - ., 1\n\t"
+		".popsection\n\t"
+		".long		1b - ., %l[l_yes] - .\n\t"
+		".quad		%c0 - .\n\t"
+		".popsection\n\t"
+		: : "i" (&KEY_NAME) : : l_yes);
+
+	r += 1;
+	goto out;
+l_yes:
+	r += 2;
+out:
+#endif
+#ifdef PATCHED
+	return r + 100;
+#else
+	return r;
+#endif
+}
diff --git a/tools/objtool/tests/generic/test-jump-label-key.sh b/tools/objtool/tests/generic/test-jump-label-key.sh
new file mode 100755
index 000000000000..142f94bd38ec
--- /dev/null
+++ b/tools/objtool/tests/generic/test-jump-label-key.sh
@@ -0,0 +1,44 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# A cloned __jump_table entry must keep a relocation in its key slot, whether
+# the key needs a klp relocation or not.
+
+. "$(dirname "$0")/../lib.sh"
+
+key=klp_test_key
+
+setup
+build_pair jump_label.c
+
+has_input_section orig.o __jump_table ||
+	probe_skip "fixture produced no __jump_table on this arch"
+
+key_slot_relocs()
+{
+	out_relocs | awk '/rela__jump_table/,/^$/' | grep -c "^0*8[[:space:]]"
+}
+
+# Unexported: klp relocation, key slot holds a tombstone.
+export_syms
+run_diff
+
+[ "$(key_slot_relocs)" = 1 ] ||
+	fail "unexported key: key slot has no relocation"
+out_relocs | awk '/rela__jump_table/,/^$/' | grep -q "\.klp\.tombstone\.$key" ||
+	fail "unexported key: expected a .klp.tombstone.$key relocation"
+out_symbols | grep -q "\.klp\.sym\..*\.$key," ||
+	fail "unexported key: no .klp.sym reference for the real relocation"
+
+# Exported: ordinary relocation, no klp machinery.
+export_syms "$key"
+run_diff
+
+[ "$(key_slot_relocs)" = 1 ] ||
+	fail "exported key: key slot has no relocation"
+out_relocs | awk '/rela__jump_table/,/^$/' | grep -q "[[:space:]]$key[[:space:]]*+" ||
+	fail "exported key: expected a direct relocation to $key"
+out_symbols | grep -q '\.klp\.tombstone\.' &&
+	fail "exported key: tombstone emitted for an exported symbol"
+
+pass "key slot populated for exported and unexported vmlinux keys"
-- 
2.53.0-Meta

