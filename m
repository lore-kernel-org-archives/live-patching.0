Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C047A4D5992
	for <live-patching@vger.kernel.org>; Wed, 16 Sep 2026 18:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789584457; cv=none; b=U2VH22y1aHzwSvNi6vZxHs96ynUfj1xyeTPkvVOUCeEu24Luh+w+cUL1A7fwSJQw05cQHaKnyk0t8PIXC19Vy8RKf1WAXcwE0MygP0Vow+uZvq2lPoZkRQgW58YFLAwyHxo1gTyoD06gb7/Ji6pb5Yh+wGpGsfnuHEFflOrjVZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789584457; c=relaxed/simple;
	bh=AkzP+h0BdjY863kLvXaknAU9sntXslPv7FPkaNRJ9iU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ein88H5/B3DRas0NnjI7I6utzmvAhviNeBHT1uK1MM2wH/+Cqs7cb1kcByFs8gcqmFiOXNS0XfNgBon7J3bzpVF1UfZMxoa336fofWMPUvdkCSRHnxIYepPftK/aemzG9pjKXKc8SsEAJHzQWtjzN2PcMdWAY60ISf29a1wUREk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LFg3eyw8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LFg3eyw8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7DFF1F00898;
	Wed, 16 Sep 2026 18:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789584439;
	bh=nkHSxgHWfItMOuH08MSuxwA8ZHEaSR7rh/j8fuqlras=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LFg3eyw83GXUXGqN+h9QwPtrualjGA7dx13mYboavhN42hv3sPvp5WD3lp+bw1Qa9
	 jg17MttYbVxMeNW9emIq1WQJvPu0cy9l7lf+JfbS/2p8ro5OPL9yR+9ZcUgmRwiFoU
	 vaS7etPCYhFrx9wWcu1My5MKt1X47I7AUSrFlbQ8FyejOMg/cnxdzUie+hnOKxETYj
	 2LHWChaofCso7q14r4GJT7dkrPheq23klrTAbRtqqqqaRCEgEfFCn/DgG7cmK38l5l
	 pn/NuruR/pEnZvWuE79bzgdJ4wUzge56yhxTj3f0IqfU4MGBKSkO+ySJoTmjXDQkm0
	 4ESfamqvr1aLw==
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
Subject: [PATCH v5 42/58] objtool/klp: Add test for symbols whose linkage the patch changes
Date: Wed, 16 Sep 2026 11:43:35 -0700
Message-ID: <20260916184351.2720310-43-song@kernel.org>
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

A patch can move a symbol between static and global without renaming it:
dropping "static" from a helper so something else can call it, or adding it
to one that is no longer shared.  Correlation keys off more than the name,
so a symbol whose binding moved has to still pair with itself.

Failing to is not a build failure.  The symbol looks new, and a new data
symbol is either rejected or cloned as a second copy -- at which point the
patched code updates its own private variable while the rest of the kernel
keeps reading the original.

The test covers both directions in one fixture, a function going global and
a variable going static, and asserts the outcome rather than the absence of
a warning: each symbol resolves back to the kernel's copy through a klp
symbol, and neither is cloned into the patch.

An earlier version asserted only that no "no correlation" or "changed data"
message appeared, and passed with correlation deliberately broken.  What
the messages say and what the patch contains are not the same question.

Verified to fail with correlation made to require matching symbol bindings.

Assisted-by: Claude:claude-opus-4
Based-on-test-by: Joe Lawrence <joe.lawrence@redhat.com>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 .../tests/generic/fixtures/local_to_global.c  | 34 ++++++++++
 .../generic/test-local-to-global-flip.sh      | 63 +++++++++++++++++++
 2 files changed, 97 insertions(+)
 create mode 100644 tools/objtool/tests/generic/fixtures/local_to_global.c
 create mode 100755 tools/objtool/tests/generic/test-local-to-global-flip.sh

diff --git a/tools/objtool/tests/generic/fixtures/local_to_global.c b/tools/objtool/tests/generic/fixtures/local_to_global.c
new file mode 100644
index 000000000000..3c9eb9200ce5
--- /dev/null
+++ b/tools/objtool/tests/generic/fixtures/local_to_global.c
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * A function which the patch changes from static to non-static, and a variable
+ * that goes the other way.  The names are unchanged; only the binding moves.
+ */
+
+static const char __modinfo[]
+	__attribute__((section(".modinfo"), used, aligned(1))) = "\0name=vmlinux";
+
+/* noinline, or the static one is folded into its caller and has no symbol */
+#ifdef PATCHED
+__attribute__((noinline)) int flipped_up(int x)		/* was static */
+#else
+__attribute__((noinline)) static int flipped_up(int x)
+#endif
+{
+	return x + 1;
+}
+
+#ifdef PATCHED
+static volatile int flipped_down = 5;	/* was global */
+#else
+volatile int flipped_down = 5;
+#endif
+
+int caller(int x)
+{
+	flipped_down += x;
+#ifdef PATCHED
+	return flipped_up(x) + flipped_down + 2;
+#else
+	return flipped_up(x) + flipped_down + 1;
+#endif
+}
diff --git a/tools/objtool/tests/generic/test-local-to-global-flip.sh b/tools/objtool/tests/generic/test-local-to-global-flip.sh
new file mode 100755
index 000000000000..45e92797190b
--- /dev/null
+++ b/tools/objtool/tests/generic/test-local-to-global-flip.sh
@@ -0,0 +1,63 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# A patch can change a symbol's linkage without renaming it: dropping "static"
+# from a helper so something else can call it, or adding it to one that is no
+# longer shared.  Correlation keys off more than the name, so a symbol whose
+# binding moved can fail to pair with itself.
+#
+# Failing to correlate is not a build failure.  The symbol looks new, and a
+# "new" data symbol is either rejected or cloned as a second copy -- at which
+# point the patched code updates its own private variable and the rest of the
+# kernel keeps reading the original.
+
+. "$(dirname "$0")/../lib.sh"
+
+setup
+build_pair local_to_global.c
+
+# Confirm the fixture really moved the bindings, in both directions.
+#
+# Match the binding and the name as fields, not as substrings of the line.
+# -ffunction-sections and -fdata-sections give these symbols sections of their
+# own, and the section symbols -- .text.flipped_up, .data.flipped_down -- are
+# always LOCAL, so "does a LOCAL line mention flipped_up" is answered by the
+# wrong symbol.  GNU readelf 2.35 happens to leave section symbol names blank,
+# but llvm-readelf prints them, and a premise that holds on one readelf and
+# not the other is no premise at all.
+has_binding()   # $1 object, $2 binding, $3 symbol
+{
+	in_symbols "$1" | awk -v b="$2" -v n="$3" '$5 == b && $NF == n' | grep -q .
+}
+
+has_binding orig.o    LOCAL  flipped_up ||
+	fail "flipped_up is not local in the original"
+has_binding patched.o GLOBAL flipped_up ||
+	fail "flipped_up is not global in the patched object"
+has_binding orig.o    GLOBAL flipped_down ||
+	fail "flipped_down is not global in the original"
+has_binding patched.o LOCAL  flipped_down ||
+	fail "flipped_down is not local in the patched object"
+
+run_diff
+
+assert_diff_log 'changed function: caller'
+
+# Correlated means each pairs with its own counterpart in the original, so the
+# patch refers back to the kernel's copy ...
+assert_klp_sym flipped_up vmlinux
+assert_klp_sym flipped_down vmlinux
+
+# ... rather than carrying its own.  A second copy of flipped_down is the bad
+# outcome: patched code would update its private one while the rest of the
+# kernel keeps reading the original.
+assert_not_patched flipped_up
+assert_no_section .data.flipped_down
+assert_no_section .bss.flipped_down
+
+diff_log | grep -q 'no correlation' &&
+	fail "linkage change reported as an uncorrelated symbol"
+diff_log | grep -q 'changed data' &&
+	fail "linkage change reported as changed data"
+
+pass "symbols correlated across a change of linkage"
-- 
2.53.0-Meta

