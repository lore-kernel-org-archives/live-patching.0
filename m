Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D50A3F5BF5
	for <live-patching@vger.kernel.org>; Fri, 11 Sep 2026 18:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789152725; cv=none; b=nKsdyA64tKfepvXy/pBystpb5ZJgTKGpb7MruhcixqiN643xHbkCRkb1Jz5mBD/qvBW/6CQCcudLqSEveTyir76+arsHfWr+OfynWV1lfRBsUDgNACRW/FXBg3OEcDBCYYbFWxZyvvWcieXp9EKw+Ri1j484zUyRZ3nq2iNwNe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789152725; c=relaxed/simple;
	bh=CAF8B+i9LzItWYWYQweu33aMAlkC0KRreEnbD0JPxLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MlSChiWj/RaMDv0Q1MH6q14zPRGa5cUitaTIsCuo/+oPA/+2D/HdyK8x0NalBO9Iok609pfUhz4hbiS1U7qrNUn/fUQ1b5l/lWFjb+awhCIE/gzjH5jDfHN+PiSDgFxUxvsuJEPmNMZlUGr9Amj0ZG6QvByofb1x+Ya4k24L6ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NgO7eLVN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NgO7eLVN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 741991F00898;
	Fri, 11 Sep 2026 18:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789152723;
	bh=WCuffaN6++1OAGGp1M/vJtCKF9uBUdLV9RBXXwhLy9c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NgO7eLVNQxM5FrCK1n6yHRq9x6lDCtyCZNi5LbxI9SEpIyaRbNjEEBcWoZcG5na9P
	 GZZDIn6rLddVCK4zshzuiIl2bNaArqn16nAZmBzWjSKAWXvv72ipq2v2eghqm3F8c8
	 ckL9I7sVnb6AzPPoS61v/nBXkqKV2DL6XvsHOyM9Xp53vdRmZHOAOka+3cyFJUEHA1
	 O/gN20BQ6HM1/+XKT1LDMSAv6O3NS1tNGnrP5c7F+OVeXRnLtUGNxDk3GWad8tK6EU
	 AEja70HnD3r6sOGxJq38a3n+1WYfGxqZd+cG/tErAwLHoFqnO2TNFGCIa5HvlwuNMg
	 +RGln09qmcl6w==
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
Subject: [PATCH 41/58] objtool/klp: Add test for kCFI prefix symbols and traps
Date: Fri, 11 Sep 2026 11:50:14 -0700
Message-ID: <20260911185031.1534046-16-song@kernel.org>
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

Two properties, asserted separately because they fail differently:

  - the __cfi_<func> prefix symbol has to be carried with the patched
    function, or the function has no type identity and indirect calls to it
    trap;
  - its .kcfi_traps entry has to be extracted, or the trap is not
    recognised as a CFI failure and a clean report becomes an oops.

test-special-section hand-assembles a .kcfi_traps entry, which is what
makes it catch commit 7df1638df97b ("objtool/klp: Fix .kcfi_traps special
section extraction").  Nothing until now built real kCFI code.

This tests the behavior of commit da4326573ae8 ("objtool/klp: Fix kCFI trap
handling").  Commit f7ceffd21a8a ("objtool/klp: Fix kCFI prefix
finding/cloning") cannot be tested as such, its code having been rewritten
by commit fe6a87e0abac ("objtool: Improve and simplify prefix symbol
detection"); this guards the current implementation's behaviour instead.

Assisted-by: Claude:claude-opus-4
Based-on-test-by: Joe Lawrence <joe.lawrence@redhat.com>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 tools/objtool/tests/x86/fixtures/kcfi.c | 39 +++++++++++++++++++++++++
 tools/objtool/tests/x86/test-kcfi.sh    | 39 +++++++++++++++++++++++++
 2 files changed, 78 insertions(+)
 create mode 100644 tools/objtool/tests/x86/fixtures/kcfi.c
 create mode 100755 tools/objtool/tests/x86/test-kcfi.sh

diff --git a/tools/objtool/tests/x86/fixtures/kcfi.c b/tools/objtool/tests/x86/fixtures/kcfi.c
new file mode 100644
index 000000000000..52cbb0fe6df2
--- /dev/null
+++ b/tools/objtool/tests/x86/fixtures/kcfi.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * An indirect call, which under kCFI is preceded by a type check and a trap.
+ *
+ * Clang emits a __cfi_<func> prefix symbol carrying the type hash ahead of
+ * every address-taken function, and records the trap site in .kcfi_traps.
+ * Both belong to the function and both have to come with it into a patch.
+ *
+ * Needs -fsanitize=kcfi, which only Clang has.
+ */
+
+static const char __modinfo[]
+	__attribute__((section(".modinfo"), used, aligned(1))) = "\0name=vmlinux";
+
+static int impl_a(int x)
+{
+	return x + 1;
+}
+
+static int impl_b(int x)
+{
+	return x * 2;
+}
+
+int (*pick(int x))(int)
+{
+	return (x & 1) ? impl_a : impl_b;
+}
+
+int target(int x)
+{
+	int (*fn)(int arg) = pick(x);
+
+#ifdef PATCHED
+	return fn(x) + 2;
+#else
+	return fn(x) + 1;
+#endif
+}
diff --git a/tools/objtool/tests/x86/test-kcfi.sh b/tools/objtool/tests/x86/test-kcfi.sh
new file mode 100755
index 000000000000..b583ef608747
--- /dev/null
+++ b/tools/objtool/tests/x86/test-kcfi.sh
@@ -0,0 +1,39 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Under kCFI an indirect call checks a type hash before jumping, and traps on a
+# mismatch.  Two things belong to the calling function and must come with it
+# into a patch:
+#
+#   - the __cfi_<func> prefix symbol holding the hash.  Lose it and the patched
+#     function has no type identity, so indirect calls to it trap.
+#   - its .kcfi_traps entry.  Lose that and the trap is not recognised as a
+#     CFI failure, so what should be a clean report becomes an oops.
+#
+# Neither shows up at build time.
+
+. "$(dirname "$0")/../lib.sh"
+
+clang_only "kCFI is a Clang feature"
+
+setup
+
+# Declared above that this is Clang's; a given Clang may still be too old.
+cc_supports -fsanitize=kcfi ||
+	probe_skip "this clang does not support -fsanitize=kcfi"
+
+build_pair kcfi.c -fsanitize=kcfi
+
+assert_input_section .kcfi_traps
+assert_input_symbol __cfi_target
+
+run_diff
+
+assert_patched target
+
+# The prefix symbol comes with its function ...
+assert_symbol __cfi_target
+# ... and so does the trap entry.
+assert_section .kcfi_traps
+
+pass "kCFI prefix symbol and trap entry carried with the patched function"
-- 
2.53.0-Meta

