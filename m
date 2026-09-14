Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4BE3B14D4
	for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 23:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789427320; cv=none; b=RTJKzyhNTddbDz//Uy5CC7fBj2zbgPS9kDGCaB8IY0KzGzNxrum4lcpT+MzSEBEA/clIb2ue5XffV5LMnhs8JiDXMlCCmRo12WoQuUrKjbBRoneEOrWIjzZHxfbB/mSOEImPcG0Ht5uP9DScADQpU93cPd+TPUiKh7ZqdFOsUns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789427320; c=relaxed/simple;
	bh=kaGsqlDt2FGFLrvubpvFyKDDUpUWoZw7fPdurBZJ9j4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OkClsWeeBdGz32JuMlyvoXT1OxE8voEZCkK6HGn2R9szWLAWM4GJtti7T8htOKNqLL6TDxvahHAwA7w3cL3hJBNtBIASam3359GHgV4n25DpuKQi3PMveU6BlJhqbddORkVcCVWXXqPfa8nR16v6V08zMAkitOv7weuqoM+3keM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Efz1X1JF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Efz1X1JF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E502B1F00893;
	Mon, 14 Sep 2026 23:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789427318;
	bh=vk+lGcMau+Se59LLvGTGgNpImzsrOuOQp+Xzn1uNulM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Efz1X1JFF20ySTQsVHW2w13ZVAHoMr9grXjLAQ3zBaHf3vruLv30PArc4FES3mhpW
	 LdCd2xmXcG1u9TNdCK+cgWo6cpB3CBxAj2rthe86r+ETjH0o4DS0zjB769x2ROwrbg
	 l3yc6FMg/yPuIsJ3PQMtf/P6JJazuGxn7QGsSRit/oy2EgE7Yf5WVAigstYkb4jqfs
	 RCJZLusZ2VpvQ8mP7+o6uBh2eufQPA9f1ye9IRCe89E4cYKtD5dlhdaUNtcGwPGdYO
	 gyPIZWy8zqHVH9XIQyvwYcdiNSyqqlyiZUfyBdvF2DkEsr0lOZqWXVlyYle8cJn9v5
	 TL/J1nwoE1p1g==
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
Subject: [PATCH v3 57/58] objtool/klp: Add test for Clang switch jump tables
Date: Mon, 14 Sep 2026 16:03:54 -0700
Message-ID: <20260914230355.3422996-58-song@kernel.org>
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

For a dense enough switch Clang emits the targets as a table in
.rodata..Lswitch.table.<function> -- named after the function but not part
of it.  The patched function indexes into that table, so a clone which does
not bring it along jumps through whatever the kernel's copy holds, which
after a patch that changed the switch is the wrong set of targets.  An
indirect jump to a stale address reports nothing at build or load time.

The fixture asserts its own premise twice over, since both halves depend on
what this Clang chose to do: that a table was built rather than a chain of
comparisons, and that the added case actually changed it.

objtool has no switch-specific code -- the table is carried by the general
mechanism for data a cloned function references -- so this guards that
mechanism reaching an easily-mishandled shape rather than a particular
line, and the test says so.  Making the table uncorrelated, the nearest
available sabotage, does not change the outcome.

Assisted-by: Claude:claude-opus-4
Based-on-test-by: Joe Lawrence <joe.lawrence@redhat.com>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 .../tests/generic/fixtures/switch_rodata.c    | 31 +++++++++++
 .../tests/generic/test-switch-rodata.sh       | 53 +++++++++++++++++++
 2 files changed, 84 insertions(+)
 create mode 100644 tools/objtool/tests/generic/fixtures/switch_rodata.c
 create mode 100755 tools/objtool/tests/generic/test-switch-rodata.sh

diff --git a/tools/objtool/tests/generic/fixtures/switch_rodata.c b/tools/objtool/tests/generic/fixtures/switch_rodata.c
new file mode 100644
index 000000000000..817ddac92d81
--- /dev/null
+++ b/tools/objtool/tests/generic/fixtures/switch_rodata.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * A switch dense enough that Clang builds a jump table for it, in a section of
+ * its own: .rodata..Lswitch.table.<function>.
+ *
+ * The table belongs to the function and has to travel with it.  It is named
+ * after the function but is not part of it, so klp diff has to associate the
+ * two rather than treating the table as unrelated data.
+ *
+ * The patch adds a case, which changes the table's contents and length.
+ */
+
+static const char __modinfo[]
+	__attribute__((section(".modinfo"), used, aligned(1))) = "\0name=vmlinux";
+const char *status_to_string(unsigned int c)
+{
+	switch (c) {
+	case 0: return "idle";
+	case 1: return "running";
+	case 2: return "stopped";
+	case 3: return "error";
+	case 4: return "paused";
+	case 5: return "waiting";
+	case 6: return "starting";
+	case 7: return "stopping";
+#ifdef PATCHED
+	case 8: return "completed";
+#endif
+	}
+	return "unknown";
+}
diff --git a/tools/objtool/tests/generic/test-switch-rodata.sh b/tools/objtool/tests/generic/test-switch-rodata.sh
new file mode 100755
index 000000000000..fb27e96c65f6
--- /dev/null
+++ b/tools/objtool/tests/generic/test-switch-rodata.sh
@@ -0,0 +1,53 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# A Clang switch jump table travels with the function it belongs to.
+#
+# For a dense enough switch Clang emits the targets as a table in
+# .rodata..Lswitch.table.<function>, named after the function but not part of
+# it.  klp diff has to associate the two: the patched function indexes into
+# that table, so a clone which does not bring it along jumps through whatever
+# the kernel's copy holds -- which, when the patch changed the switch, is the
+# wrong set of targets.
+#
+# That is an indirect jump to a stale address, not a missing symbol, so nothing
+# reports it at build or load time.
+#
+# objtool has no switch-specific code: the table is carried by the general
+# mechanism for data a cloned function references.  So this is a regression
+# test on that mechanism reaching a shape it is easy to get wrong, not a guard
+# on a particular line -- making the table uncorrelated, the nearest sabotage,
+# does not change the outcome.
+#
+# Covers the same ground as corpus/x86_64-llvm-switch-rodata/
+# clang-switch-rodata-assoc in Joe Lawrence's klp-build unit test corpus.
+
+. "$(dirname "$0")/../lib.sh"
+
+clang_only "only Clang emits switch jump tables in their own section"
+
+setup
+build_pair switch_rodata.c
+
+# The premise: this Clang really did build a table rather than a chain of
+# comparisons, and the added case really did change it.
+tbl=.rodata..Lswitch.table.status_to_string
+has_input_section orig.o "$tbl" ||
+	probe_skip "this clang built no jump table for the switch"
+# readelf prefixes each line with "[nn]", which splits into one or two fields
+# depending on the index, so strip it before counting columns.
+tbl_size()
+{
+	in_sections "$1" | sed 's/^ *\[[ 0-9]*\] *//' |
+		awk -v s="$tbl" '$1 == s { print $5 }'
+}
+[ "$(tbl_size orig.o)" != "$(tbl_size patched.o)" ] ||
+	fail "fixture's added case did not change the jump table"
+
+run_diff
+
+assert_patched status_to_string
+assert_section "$tbl"
+assert_reloc_sym .text.status_to_string "$tbl"
+
+pass "Clang switch jump table carried with the function it belongs to"
-- 
2.53.0-Meta

