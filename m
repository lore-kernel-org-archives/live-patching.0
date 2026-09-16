Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5233DBD65
	for <live-patching@vger.kernel.org>; Wed, 16 Sep 2026 18:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789584432; cv=none; b=KofUOVi4fsj3UKp2mWkOkxn0P0Xoq89pyI0X5NDbbzlV+vxH/R/Mhrdj5Acjq7GyUC67iGPRPd2Nq140t1MszW87sVgxxqK67b1KWbA4XBl+ZLn67WvK4BjbZ6CP0+HGn1OGrZtGyhSMtIW/OYFzaZlouBocrvtl/WQcdigVfRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789584432; c=relaxed/simple;
	bh=3iVoK4BkPE7Ao2mIIlFXdexW1442xptVOxNVtYYEQ+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rbh1BdhrEg5tXxQ30xMXVp/c6oik2C5+vCQE2WYl3t8PXnoaZ7o+nCGwPncxAYl+FBS4lJMndrhnb/cwnEnLmy39SoC7uQk6S2IWkm0+WlRa07CR7yl6OdvSxUtWgYalO0Hs/p2i/zz0JYyDuv/7uuYNt1c11Puw57NnyKuzBBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f4Z/7iM1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f4Z/7iM1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBED01F00898;
	Wed, 16 Sep 2026 18:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789584415;
	bh=qDD8qst+lNvXm1mMrcNe9/GCFXs/oxrzCZsX6CQt3qQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=f4Z/7iM1H/PB8RuMOXNbKS77YlevMwAuehKXk99K7siw7rCR7tOp7ALMzTEweeqtS
	 pc6DZLvMFen7/bLuWxsGBpbSmom8FcceMlBSJOqRtC4HscHqWeDrBxOL3mMzbopi4Q
	 W+/lkQI4rSvRcAnkknwBivQkFdFglKElbLEaKtvcmWi9qlP5tdjJS4gP2uSn5fgIYV
	 aO0iAIc843YLmiczQ0BynOOGzY8ReZ8l91BZoOTbCqjPjTEon83j6gMwOdQxjozpIB
	 7PJazF9jVDXN8AWRdvPBEz4mbsxpQVPSD8QRmjj5AlnX3KGT/cOnEqgVa5NDd+wMcg
	 4A5XfTwqnAL+Q==
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
Subject: [PATCH v5 37/58] objtool/klp: Add test for sympos in module objects
Date: Wed, 16 Sep 2026 11:43:30 -0700
Message-ID: <20260916184351.2720310-38-song@kernel.org>
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

klp-sympos.c had no coverage at all.  sympos disambiguates same-named
symbols for livepatch, counting from 1, with 0 meaning the name is unique.
Resolving to the wrong one is not a load failure -- it is a patch quietly
wired to the wrong object.

Covers the module path, where the position is a count in symbol table order
and klp diff can work it out from the object alone.

Assisted-by: Claude:claude-opus-4
Based-on-test-by: Joe Lawrence <joe.lawrence@redhat.com>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 .../tests/generic/fixtures/sympos_dup.c       | 32 ++++++++++++
 tools/objtool/tests/generic/test-sympos.sh    | 51 +++++++++++++++++++
 2 files changed, 83 insertions(+)
 create mode 100644 tools/objtool/tests/generic/fixtures/sympos_dup.c
 create mode 100755 tools/objtool/tests/generic/test-sympos.sh

diff --git a/tools/objtool/tests/generic/fixtures/sympos_dup.c b/tools/objtool/tests/generic/fixtures/sympos_dup.c
new file mode 100644
index 000000000000..7eded9b12cfc
--- /dev/null
+++ b/tools/objtool/tests/generic/fixtures/sympos_dup.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * A static whose name recurs in every translation unit that includes it.
+ * Compiled once for a single-copy object and twice, partially linked, for one
+ * with duplicates -- which is the only case where sympos is non-zero.
+ *
+ * FUNC_NAME keeps the referencing functions distinct so both get patched.
+ * Only the first copy carries .modinfo; two would be a second thing to
+ * disambiguate and is not what this fixture is about.
+ */
+
+#ifndef FUNC_NAME
+#define FUNC_NAME use_a
+#endif
+
+#ifndef NO_MODINFO
+static const char __modinfo[]
+	__attribute__((section(".modinfo"), used, aligned(1))) = "\0name=vmlinux";
+#endif
+
+/* volatile so it survives as an STT_OBJECT rather than being folded away */
+static volatile int dup_counter = 1;
+
+int FUNC_NAME(int x)
+{
+	dup_counter += x;
+#ifdef PATCHED
+	return dup_counter + 1;
+#else
+	return dup_counter;
+#endif
+}
diff --git a/tools/objtool/tests/generic/test-sympos.sh b/tools/objtool/tests/generic/test-sympos.sh
new file mode 100755
index 000000000000..b71d4930a22a
--- /dev/null
+++ b/tools/objtool/tests/generic/test-sympos.sh
@@ -0,0 +1,51 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# sympos is what livepatch uses to tell duplicate symbol names apart in the
+# patched object: which "dup_counter" of several the relocation means.  Get it
+# wrong and the patch resolves to the wrong object at load time, silently.
+#
+# klp_find_sympos() reports 0 when a name is unique and a 1-based position when
+# it is not, so both need checking -- always reporting a position, or never,
+# each looks right in one of the two cases.
+#
+# This is the module path, counting symbol table order.  vmlinux is reordered
+# by the final link and goes through .klp.symid instead; that needs a linked
+# vmlinux next to vmlinux.o and is not covered here.
+
+. "$(dirname "$0")/../lib.sh"
+
+setup
+
+# One copy: the name is unique, so there is nothing to disambiguate.
+build_one sympos_dup.c orig.o    -DFUNC_NAME=use_a
+build_one sympos_dup.c patched.o -DFUNC_NAME=use_a -DPATCHED
+run_diff
+
+assert_klp_sympos dup_counter 0
+
+# Two copies: positions, in symbol table order.
+for p in "" "-DPATCHED"; do
+	# shellcheck disable=SC2086
+	build_one sympos_dup.c "a$p.o" -DFUNC_NAME=use_a $p
+	# shellcheck disable=SC2086
+	build_one sympos_dup.c "b$p.o" -DFUNC_NAME=use_b -DNO_MODINFO $p
+done
+partial_link "$workdir/orig.o"    "$workdir/a.o"         "$workdir/b.o" ||
+	probe_skip "partial link unavailable"
+partial_link "$workdir/patched.o" "$workdir/a-DPATCHED.o" "$workdir/b-DPATCHED.o" ||
+	probe_skip "partial link unavailable"
+
+# Without duplicates in the input there is nothing for sympos to number.
+[ "$(count_input_symbols orig.o dup_counter)" = 2 ] ||
+	fail "fixture did not produce two dup_counter symbols"
+
+run_diff
+
+assert_klp_sympos dup_counter 1
+assert_klp_sympos dup_counter 2
+# ... and nothing still claiming the name is unique
+out_symbols | grep -qE '\.klp\.sym\.[^.]+\.dup_counter,0([[:space:]]|$)' &&
+	fail "sympos 0 emitted for a duplicated symbol"
+
+pass "sympos numbers duplicate symbols and stays 0 for unique ones"
-- 
2.53.0-Meta

