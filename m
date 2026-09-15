Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C214DB56E
	for <live-patching@vger.kernel.org>; Tue, 15 Sep 2026 23:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789515591; cv=none; b=Xj4iXqYm7yOYLm9waBOaRFILSBRFSZ1smWNWlKxZieO1EqS8Z6nB6B1LtGKsvakGbbBbBDhRUkjL8NoSBTexZ6T9EqIAGBl8uJXweSgT8xIEaNHPkpUVAzUa2sPWdG6qvhnna6ftZC6GY6lA1IaoMmPZrFX5NHZPPyu/FMxPEfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789515591; c=relaxed/simple;
	bh=yXYLWodDoIyhEqj3pNNBqPJ85jvN/ebcd1bgdr+w1k8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k4mkOyxTdl6E3FuLjbB1n/1AR/fYc0zAI4Do5ROIBCqt8lSUEqWGA7VRr5p957JyAsqB8VcQO0+gnQrCqoCBFJXW5qsO7c5C3lJifzXWXF86tqLwv+YSRIuG6QjIfCMiV6QLVD9njL00Vh3WpkTOEarMAHJ3KyG1s+KI2MNX+xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dwt9JQHr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dwt9JQHr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34A8E1F00893;
	Tue, 15 Sep 2026 23:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789515589;
	bh=LJCHKRPsT/HuMK3A6Aox1+L7b80tbGGCcZ+526NEH7g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Dwt9JQHra7024QXzQUUhaXffX9FT6ZKqKvV387a0UmP0KCw6Umnox0pcjIr462/mw
	 tOCjjPY7SMxELPefKfx+JpgN0GilnCcXO2AIJBXhPXq5qBJ1GiRS0EjkDFcBqQB++S
	 D48U75AyRcsRYFwpNzlHY40LHcw/KPsj2eiba4pZO545V2PeUrWMBHFyROOri9HGpv
	 oF44V/OwCgLo1Ty1KWNEP2qIKuzVieFMJONEa6DRtV3DMAJiHwYyxdZJ70tlKycokm
	 +WbJWQqj01k3hhO+O57zvtN11SHwfHdKxTg0g6zJx3zh26wLzX5arYeYACHDfmV/51
	 NpBJYzWYxdeXA==
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
Subject: [PATCH v4 53/58] objtool/klp: Add test for the alignment of cloned data sections
Date: Tue, 15 Sep 2026 16:34:49 -0700
Message-ID: <20260915233454.2405019-54-song@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915233454.2405019-1-song@kernel.org>
References: <20260915233454.2405019-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A cloned data section has to keep its sh_addralign.  Plenty of kernel data
is aligned for correctness rather than speed -- per-CPU variables, anything
touched by an aligned vector move, structures padded to own a cacheline --
and a clone that lands under-aligned either faults on first use or silently
shares a line it was laid out to avoid.  Neither shows up until the patch
is loaded on hardware that cares.

The fixture's data is new in the patched build, so klp diff has to clone it
rather than reference the kernel's copy, and it asserts that premise before
asserting the result.

Commit 2f2600decb30 ("objtool/klp: fix data alignment in __clone_symbol()")
cannot be reverted to check this -- the revert is a no-op against the
current code, which has been rewritten since.  Verified instead by forcing
the clone's alignment to 1, which the test reports as "alignment 1,
expected 64".

Assisted-by: Claude:claude-opus-4
Based-on-test-by: Joe Lawrence <joe.lawrence@redhat.com>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 .../tests/generic/fixtures/data_alignment.c   | 29 ++++++++++++++
 .../tests/generic/test-data-alignment.sh      | 40 +++++++++++++++++++
 2 files changed, 69 insertions(+)
 create mode 100644 tools/objtool/tests/generic/fixtures/data_alignment.c
 create mode 100755 tools/objtool/tests/generic/test-data-alignment.sh

diff --git a/tools/objtool/tests/generic/fixtures/data_alignment.c b/tools/objtool/tests/generic/fixtures/data_alignment.c
new file mode 100644
index 000000000000..900253dfb2cb
--- /dev/null
+++ b/tools/objtool/tests/generic/fixtures/data_alignment.c
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Data with an alignment stricter than its size.
+ *
+ * A cloned data section has to keep its sh_addralign.  The kernel has plenty
+ * of data whose alignment is a correctness property rather than an
+ * optimisation -- per-CPU variables, anything touched by an aligned SSE move,
+ * cacheline-aligned locks -- and a clone that lands under-aligned faults or
+ * silently shares a cacheline it was written to avoid.
+ *
+ * The object is new in the patched build, so klp diff has to clone it rather
+ * than reference the kernel's copy.
+ */
+
+static const char __modinfo[]
+	__attribute__((section(".modinfo"), used, aligned(1))) = "\0name=vmlinux";
+
+#ifdef PATCHED
+int aligned_data[2] __attribute__((aligned(64))) = { 1, 2 };
+#endif
+
+int target(int x)
+{
+#ifdef PATCHED
+	return x + aligned_data[0];
+#else
+	return x;
+#endif
+}
diff --git a/tools/objtool/tests/generic/test-data-alignment.sh b/tools/objtool/tests/generic/test-data-alignment.sh
new file mode 100755
index 000000000000..8e389544a3b1
--- /dev/null
+++ b/tools/objtool/tests/generic/test-data-alignment.sh
@@ -0,0 +1,40 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# A cloned data section keeps its alignment.
+#
+# Plenty of kernel data is aligned for correctness rather than speed: per-CPU
+# variables, anything touched by an aligned vector move, structures padded to
+# own a cacheline. A clone that lands under-aligned either faults on first use
+# or silently shares a line it was laid out to avoid, and neither shows up
+# until the patch is loaded on hardware that cares.
+#
+# Fixed by 2f2600decb30 ("objtool/klp: Fix alignment of cloned data
+# sections").
+#
+# Covers the same ground as corpus/x86_64/cloned-data-alignment in Joe
+# Lawrence's klp-build unit test corpus.
+
+. "$(dirname "$0")/../lib.sh"
+
+setup
+build_pair data_alignment.c
+
+# The premise: the compiler really did over-align it, and the object is new in
+# the patch so it has to be cloned rather than referenced.
+want="$(in_sections patched.o | sed 's/^ *\[[ 0-9]*\] *//' |
+	awk '$1 == ".data.aligned_data" { print $NF }')"
+[ "$want" = 64 ] ||
+	probe_skip "compiler gave .data.aligned_data alignment '$want', not 64"
+has_input_section orig.o .data.aligned_data &&
+	fail "fixture put aligned_data in the original; nothing to clone"
+
+run_diff
+assert_section .data.aligned_data
+
+got="$(out_sections | sed 's/^ *\[[ 0-9]*\] *//' |
+       awk '$1 == ".data.aligned_data" { print $NF }')"
+[ "$got" = "$want" ] ||
+	fail "cloned .data.aligned_data has alignment $got, expected $want"
+
+pass "cloned data section keeps its alignment"
-- 
2.53.0-Meta

