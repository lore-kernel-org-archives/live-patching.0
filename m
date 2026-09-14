Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CACE3AB26D
	for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 23:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789427219; cv=none; b=A+Y4GAfED/DfB7wBMrbHwavK97yBGYh/iEMEnvji4j3pH79NVrDLaaX5Zpm0cr87YLowbHvSJ7055CUbsVEjJb2IQcHCkLPzUEXJkdpclRtixdB4u5D26ME/OLk+pryGqsAJlyIjrBBaT533cX3CyItZnTeaBBAwQLibNOzGzWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789427219; c=relaxed/simple;
	bh=x23WLfRz/WNl+R8iPHplQ5d4l3VeD68nBcNw7LYT7M4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DrkDNgHmuJtT4Jw7WxJEz5NpTIHpzZKLwr96ch15MIulf1Nv1d2GHoJbroD9rRSY3hxArM8xqndGghof8XKHYrbCkLtMavhx64tB3qI5uyM/OTr8n5DvRj6SvobRcoPonR857k22l1Yn04/0OCD+F+r/Om16LmrjK27tIvBGFP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PBYp81K1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PBYp81K1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48F941F000FF;
	Mon, 14 Sep 2026 23:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789427218;
	bh=aIGNw+u2EyDNP535o9X8wnUBsBv3duJFuIjIcLTg34k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PBYp81K1qKqVwB9uTspB/fYzazaImG9gzAv6+F0eQXCLsdAy3rlgV4AiI46wiNBzo
	 tXnodEGxndyLEWEK37HV2UIrWROxbVuGKdUB5XGQywLZBnt9ciS5/StTcgCW+dC5aX
	 jhbn//XuyvDIHmi7wVmtSc7QEU7iECriTzq4H8pY8Ll+bteO5aAzN0qaC03XKmR8Z1
	 AwX/9a5jCzk/Ldy5buJ8YnDRVHEDdfSRKq0/G0uiVRoT7PnUCaWfpCpO97HNfiISvd
	 NRx58y4kaFEDw7CkqQ9B0uxlLRXnNdCnHY0I+E8pn5V5pQZio96Lkzm0/cq5nAX0g9
	 SPOmlxt4Sj/3A==
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
Subject: [PATCH v3 36/58] objtool/klp: Add test for position-independent checksums
Date: Mon, 14 Sep 2026 16:03:33 -0700
Message-ID: <20260914230355.3422996-37-song@kernel.org>
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
 .../generic/fixtures/checksum_position.c      | 42 ++++++++++++++++
 .../tests/generic/test-checksum-position.sh   | 50 +++++++++++++++++++
 2 files changed, 92 insertions(+)
 create mode 100644 tools/objtool/tests/generic/fixtures/checksum_position.c
 create mode 100755 tools/objtool/tests/generic/test-checksum-position.sh

diff --git a/tools/objtool/tests/generic/fixtures/checksum_position.c b/tools/objtool/tests/generic/fixtures/checksum_position.c
new file mode 100644
index 000000000000..4320bc220592
--- /dev/null
+++ b/tools/objtool/tests/generic/fixtures/checksum_position.c
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * A function whose position in the section changes between the two builds,
+ * without the function itself changing.
+ *
+ * target() calls callee() twice, and a call within the same section needs no
+ * relocation: the displacement is in the instruction.  It is that displacement
+ * which moves, and hashing those bytes makes the checksum move with it.  Both
+ * must therefore share a section, which is why the test passes
+ * -fno-function-sections.
+ *
+ * What has to change is the distance between the two, and PATCHED changes it
+ * by aligning them rather than by inserting a function between them.  Where a
+ * compiler puts an added function is its own business: gcc emits these in
+ * source order, so a function written between callee() and target() separates
+ * them, but clang emits target() immediately before callee() whatever the
+ * source says, and an added function lands ahead of both.  That moves target()
+ * without moving it relative to callee(), the displacement comes out identical
+ * in both builds, and the test passes without having asked anything.
+ *
+ * Alignment moves the functions apart on both, and moves neither function's
+ * own instructions -- which is exactly the distinction under test.
+ */
+
+#ifdef PATCHED
+#define MOVED	__attribute__((aligned(64)))
+#else
+#define MOVED
+#endif
+
+static const char __modinfo[]
+	__attribute__((section(".modinfo"), used, aligned(1))) = "\0name=vmlinux";
+
+__attribute__((noinline)) MOVED static int callee(int x)
+{
+	return x * 5 + 1;
+}
+
+__attribute__((noinline)) MOVED int target(int x)
+{
+	return callee(x) + callee(x + 1);
+}
diff --git a/tools/objtool/tests/generic/test-checksum-position.sh b/tools/objtool/tests/generic/test-checksum-position.sh
new file mode 100755
index 000000000000..d05e28014e1e
--- /dev/null
+++ b/tools/objtool/tests/generic/test-checksum-position.sh
@@ -0,0 +1,50 @@
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
+# What has to change is the displacement target's calls encode, and that is
+# the distance to callee() -- not target's own offset.  A compiler which put
+# the added function ahead of both would move target and leave the distance
+# alone, and then the bytes are identical and the checksum matches for the
+# uninteresting reason.  Ask about the distance.
+sym_off()   # $1 object, $2 symbol
+{
+	in_symbols "$1" | awk -v n="$2" '$NF == n { print $2; exit }'
+}
+
+orig_t="$(sym_off orig.o target)";    orig_c="$(sym_off orig.o callee)"
+new_t="$(sym_off patched.o target)";  new_c="$(sym_off patched.o callee)"
+
+[ -n "$orig_t" ] && [ -n "$orig_c" ] && [ -n "$new_t" ] && [ -n "$new_c" ] ||
+	fail "target or callee missing from one of the objects"
+
+orig_gap=$(( 16#$orig_t - 16#$orig_c ))
+new_gap=$((  16#$new_t  - 16#$new_c ))
+[ "$orig_gap" != "$new_gap" ] ||
+	probe_skip "this compiler moved target() and callee() together;" \
+		   "the call displacement did not change"
+
+assert_checksum_matches target
+
+pass "checksum unchanged when the function only moves"
-- 
2.53.0-Meta

