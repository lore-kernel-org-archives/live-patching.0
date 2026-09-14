Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA5A430311
	for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 23:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789427160; cv=none; b=CzW0TQ02eObaOU+CMa6JqSkiSxwWhUTXbXmfD7PTeWUWwbbpwM8TJPkkADf7Yhoy+3VPg30/s6pHO7AIK/SMiNvomOEOvBj3uxBG1CmS21yyk/iiEUHs9xEjQ4xUnC6rUlfHaysKzB0jh0h6zs1D0KQQk6N/V0v+A3CXHfQlEf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789427160; c=relaxed/simple;
	bh=YDSwqqP7cXkrMf+53oUyzV+9tY4sCHuw8jELBcCPP5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t/olMg80NKWct0FeyfwcwLwJy6w+aOXeWZu+5+akg7Whzsz0yiYKgmvoY7CEme9vE+h81gK9ibQ8kjSJb/AO4hcp39uOMfeX5ad7GCeuyqD2dv+eQ4UuRzNkg/YfivnYuvIe2JtSiJ7el8kTRPKrVbgf/o86NJBEgZNrXxgA5Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bFUVBUy9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bFUVBUy9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C7DB1F00898;
	Mon, 14 Sep 2026 23:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789427158;
	bh=DbTItdY5Cxv0po+qgOuXN912tWUbBKAw8xnWKx1/m5Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bFUVBUy9EWI9ORLqCOm8Gq2vpsNmSW4IjB2E7Fb0oZzqKgld5IUVZKPOKcVlOqExJ
	 c/6MjZWxulhmfmd9NRiIEA7DCaQgrNxp3J3nQQSsMBPFdB1rP7noGdj7L7G6599ctt
	 tP7QwKNwe0JL1VyWYW0BrNhkdnwikLXOSX4UpRuBfkoIwzEj7AzNzSjM2fvHofGw9d
	 5hiT84S+S//BLX5bj6QrcDZe2UlWsdSBK4+K+L42ZznzyMvEmjFMw/kJrp5uqu/zHq
	 vLoEMWCyGZN3l8gbEP/EJdPZndN1ytd2ePjx2QdBqfLiEG+lS6nj20194g0F6iavxL
	 2uPsu7OE0oREg==
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
Subject: [PATCH v3 24/58] objtool/klp: Add test for correlation across ThinLTO name mangling
Date: Mon, 14 Sep 2026 16:03:21 -0700
Message-ID: <20260914230355.3422996-25-song@kernel.org>
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

From: Puranjay Mohan <puranjay@kernel.org>

ThinLTO promotes the file-local symbols an imported function touches,
renaming them name.llvm.<hash>.  The hash is content derived, so it changes
whenever the module does:

  original: counter.llvm.13663304415433785070
  patched:  counter.llvm.10543383937958011340

Correlating the two objects therefore requires demangling the suffix;
matching raw names would see two unrelated symbols and treat the variable
as new.

The resulting klp relocation also has to name the original symbol, since
that is the one in the running kernel's kallsyms.  Naming the patched
build's symbol produces a relocation which can never be resolved.

ThinLTO is a clang feature, so the test declares itself clang-only.  It
also needs an lld from the same LLVM release as $CC; a mismatched pair
fails with "Invalid summary version", which reads like a broken test rather
than a broken environment, so probe for a working lld and skip if there is
none.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 .../tests/generic/fixtures/thinlto_local.c    | 39 +++++++++++++++
 .../tests/generic/test-thinlto-local.sh       | 48 +++++++++++++++++++
 2 files changed, 87 insertions(+)
 create mode 100644 tools/objtool/tests/generic/fixtures/thinlto_local.c
 create mode 100755 tools/objtool/tests/generic/test-thinlto-local.sh

diff --git a/tools/objtool/tests/generic/fixtures/thinlto_local.c b/tools/objtool/tests/generic/fixtures/thinlto_local.c
new file mode 100644
index 000000000000..fe9f9e6bf44f
--- /dev/null
+++ b/tools/objtool/tests/generic/fixtures/thinlto_local.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Two translation units (TU_B selects the second) linked with ThinLTO.
+ * Importing bump() promotes the file-local counter, renaming it
+ * counter.llvm.<hash>.  The hash is content derived, so it differs between the
+ * original and patched builds.
+ */
+
+#ifdef TU_B
+
+extern int bump(void);
+
+int other_entry(void)
+{
+	return bump() + bump();
+}
+
+#else
+
+static const char __modinfo[]
+	__attribute__((section(".modinfo"), used, aligned(1))) = "\0name=vmlinux";
+
+static int counter;
+
+int bump(void)
+{
+	return ++counter;
+}
+
+int target(void)
+{
+#ifdef PATCHED
+	return counter + 1;
+#else
+	return counter;
+#endif
+}
+
+#endif
diff --git a/tools/objtool/tests/generic/test-thinlto-local.sh b/tools/objtool/tests/generic/test-thinlto-local.sh
new file mode 100755
index 000000000000..a266263676ed
--- /dev/null
+++ b/tools/objtool/tests/generic/test-thinlto-local.sh
@@ -0,0 +1,48 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Correlating ThinLTO-promoted locals requires demangling the .llvm.<hash>
+# suffix, and the resulting klp relocation must name the original symbol: that
+# is the one in the running kernel's kallsyms.
+
+. "$(dirname "$0")/../lib.sh"
+
+setup
+clang_only "ThinLTO requires clang"
+
+find_thinlto_toolchain ||
+	probe_skip "no matching clang/lld pair for a ThinLTO link; set THIN_LD to one"
+
+build_thinlto()		# $1 output object, $2 extra flags
+{
+	$THIN_CC -flto=thin -O2 -ffunction-sections -fdata-sections $2 \
+		-c "$FIXTURES_DIR/thinlto_local.c" -o "$workdir/tu_a.o" 2>/dev/null || return 1
+	$THIN_CC -flto=thin -O2 -ffunction-sections -fdata-sections $2 -DTU_B \
+		-c "$FIXTURES_DIR/thinlto_local.c" -o "$workdir/tu_b.o" 2>/dev/null || return 1
+	"$THIN_LD" -r "$workdir/tu_a.o" "$workdir/tu_b.o" -o "$1" 2>/dev/null || return 1
+}
+
+build_thinlto "$workdir/orig.o" "" ||
+	probe_skip "ThinLTO build failed ($THIN_CC, $THIN_LD)"
+build_thinlto "$workdir/patched.o" -DPATCHED ||
+	probe_skip "ThinLTO build failed ($THIN_CC, $THIN_LD)"
+
+orig_sym="$(in_symbols orig.o    | grep -o 'counter\.llvm\.[0-9]*' | head -1)"
+new_sym="$( in_symbols patched.o | grep -o 'counter\.llvm\.[0-9]*' | head -1)"
+
+[ -n "$orig_sym" ] && [ -n "$new_sym" ] ||
+	probe_skip "$THIN_CC did not promote the local symbol"
+
+# Equal hashes would make plain name matching work, testing nothing.
+[ "$orig_sym" != "$new_sym" ] ||
+	probe_skip "$THIN_CC gave the same ThinLTO hash for both builds"
+
+run_diff
+assert_patched target
+
+out_symbols | grep -q "\.klp\.sym\.vmlinux\.$orig_sym," ||
+	fail "expected a klp relocation naming $orig_sym"
+out_symbols | grep -q "\.klp\.sym\.vmlinux\.$new_sym," &&
+	fail "klp relocation names $new_sym, which the running kernel does not have"
+
+pass "ThinLTO-mangled local correlated across differing hashes ($THIN_CC, $THIN_LD)"
-- 
2.53.0-Meta

