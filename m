Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0FB4D9F70
	for <live-patching@vger.kernel.org>; Wed, 16 Sep 2026 18:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789584513; cv=none; b=irPr46FoBgqmK9MZCqYUDnIbNyZT8xjRepzKpiZlLcKpogk+vWKKaI5AUqu84RhFmTSyYYG8TORyffVweG0QhQqIXXxOfyP+hxvLxIqcl4u9UTQvWht1MUGqtGqAZ1zzlYmlHGxbvgL5fXtb7roCro6R9u/fWzgKUgR1IMldr/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789584513; c=relaxed/simple;
	bh=pBwH2wFu+NiIVySpYgC87486vfd0PCKvK7mTF1mio+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qOt633bF3RnyXtfegjBhB9tyRkY07LYx0CQ2cIqyG10s3rNWOWtTb5QFf3bpt2zjcQtxM62VNkbcetrZ0r63/5IN34iZSPYqzVtLEGQSaLlLxEtKXwJIU/tYlONLRF6Hc5B77gLG9D84iE61vHwqECTVhVKsVKEFAk9ZWLREdGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MfZS7vm4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MfZS7vm4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FC001F00899;
	Wed, 16 Sep 2026 18:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789584507;
	bh=cjyRBCC2Rd1ZtytczYZYuaGhSXzYVtRWny8C4I0AYUQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MfZS7vm4kRKmvNMoBfz7MyWjDszJ0PGUl1oclxb89JH3lSrwRSllikRs9GxByInkf
	 Iefer2bTxa3SnziGTcO3m8BmdzA/6IkdVs1ZygauabC2kPeGzKXuVQYRVvgI8jnqbu
	 BSua1+nLsOg4gs6mheJ72kVD2Hp8s16NyCoVJrabGIMFSvcRZgnEXnCxLBMxSCNnfC
	 6lStZU2bZvSe8xq7jPqoakvBN1lbFHBApV1FLJwgp5c9MyskYaSze1a/EJwa0HI3Ze
	 CyjhlJPKu8ZC8vxUyvrrRQdxdzArFxoDbrx9eK68wkWQ5381XcLzjhjr+g6asieLXB
	 V86lOCA9X6CTA==
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
Subject: [PATCH v5 56/58] objtool/klp: Add test for UBSAN metadata in an unchanged function
Date: Wed, 16 Sep 2026 11:43:49 -0700
Message-ID: <20260916184351.2720310-57-song@kernel.org>
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

Every instrumented operation gets a per-callsite metadata object in an
anonymous data section -- .data..Lubsan_data and .data..Lubsan_type from
GCC, .data..L__unnamed_ from Clang -- whose names are compiler-generated
and mean nothing across a rebuild.  is_uncorrelated_section() exists so klp
diff does not try to pair them up, and nothing tested it.

The failure it prevents is a false positive, which is the direction this
suite has least coverage of.  Metadata belonging to a function nobody
touched compares as different and drags that function into the patch.  That
is not a build failure: it is a larger livepatch than intended, pulling in
dependencies with it, and every extra function is one more that can fail to
correlate or to apply.

The fixture is built with -fsanitize=shift, which both compilers
instrument; neither emits a bounds check for an index it can prove in
range.  One function changes, the other is byte-identical and carries
instrumentation of its own, and the test asserts the second is left alone.

Verified by removing each rule from is_uncorrelated_section() in turn,
which splits neatly by toolchain: dropping the .data..Lubsan rule fails the
test under gcc, dropping .data..L__unnamed_ fails it under clang.  One
test, two code paths, each checked by the compiler that reaches it.

Assisted-by: Claude:claude-opus-4
Based-on-test-by: Joe Lawrence <joe.lawrence@redhat.com>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 .../tests/generic/fixtures/ubsan_noise.c      | 49 +++++++++++++++++++
 .../objtool/tests/generic/test-ubsan-noise.sh | 48 ++++++++++++++++++
 2 files changed, 97 insertions(+)
 create mode 100644 tools/objtool/tests/generic/fixtures/ubsan_noise.c
 create mode 100755 tools/objtool/tests/generic/test-ubsan-noise.sh

diff --git a/tools/objtool/tests/generic/fixtures/ubsan_noise.c b/tools/objtool/tests/generic/fixtures/ubsan_noise.c
new file mode 100644
index 000000000000..bf5999254163
--- /dev/null
+++ b/tools/objtool/tests/generic/fixtures/ubsan_noise.c
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * A translation unit built with UBSAN, where only one of two functions is
+ * patched.
+ *
+ * Every instrumented operation gets a per-callsite metadata object in an
+ * anonymous data section -- .data..Lubsan_data and .data..Lubsan_type from
+ * GCC, .data..L__unnamed_ from Clang -- and a call to a __ubsan_handle_*
+ * routine.  The names are compiler-generated and carry no meaning across a
+ * rebuild, so klp diff has to treat those sections as uncorrelated rather than
+ * pairing them up by name.
+ *
+ * untouched() is byte-identical in both builds and exists to catch the false
+ * positive: if the metadata were correlated by name, its shifts would look
+ * changed and it would be dragged into the patch.
+ *
+ * The shifts are what draw the instrumentation.  A bounds check would do as
+ * well but neither compiler emits one for an index it can prove in range.
+ */
+
+static const char __modinfo[]
+	__attribute__((section(".modinfo"), used, aligned(1))) = "\0name=vmlinux";
+
+int shift_by(int v, int n);
+
+int untouched(int v, int n)
+{
+	int s = 0;
+
+	s += v << (n & 31);
+	s += v << ((n + 1) & 31);
+	s += shift_by(v, n);
+
+	return s;
+}
+
+int touched(int v, int n)
+{
+	int s = 0;
+
+	s += v << (n & 31);
+#ifdef PATCHED
+	s += v << ((n + 3) & 31);
+#else
+	s += v << ((n + 2) & 31);
+#endif
+
+	return s;
+}
diff --git a/tools/objtool/tests/generic/test-ubsan-noise.sh b/tools/objtool/tests/generic/test-ubsan-noise.sh
new file mode 100755
index 000000000000..b415eb16bfd2
--- /dev/null
+++ b/tools/objtool/tests/generic/test-ubsan-noise.sh
@@ -0,0 +1,48 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# UBSAN instrumentation in an unchanged function must not make it look changed.
+#
+# Every instrumented operation gets a per-callsite metadata object in an
+# anonymous data section -- .data..Lubsan_data and .data..Lubsan_type from GCC,
+# .data..L__unnamed_ from Clang -- whose names are compiler-generated and mean
+# nothing across a rebuild.  is_uncorrelated_section() exists so klp diff does
+# not try to pair them up.
+#
+# Without that, the metadata belonging to a function nobody touched compares as
+# different and drags the function into the patch.  A livepatch which replaces
+# functions the patch never changed is not a build failure: it is a larger
+# patch than intended, taking its dependencies with it, and every extra
+# function is one more that can fail to correlate or to apply.
+#
+# Covers the same ground as corpus/x86_64-ubsan/{ubsan-shift-noise,
+# ubsan-metadata-data-section,gcc-ubsan-anonymous-data,ubsan-handler-cloning}
+# and corpus/x86_64-llvm-ubsan/{clang-ubsan-bounds-noise,
+# clang-ubsan-handler-cloning} in Joe Lawrence's klp-build unit test corpus.
+
+. "$(dirname "$0")/../lib.sh"
+
+setup
+build_pair ubsan_noise.c -fsanitize=shift
+
+# The premise: this compiler really did instrument, and left its metadata in an
+# anonymous section.  Without that the test is just test-basic again.
+ubsan_sec="$(in_sections orig.o |
+	grep -oE '\.data\.\.L(ubsan_data|__unnamed_)[A-Za-z0-9_.]*' | head -1)"
+[ -n "$ubsan_sec" ] ||
+	probe_skip "compiler emitted no anonymous UBSAN data section"
+assert_input_symbol untouched
+
+run_diff
+
+# The changed function is patched, and the untouched one is left alone despite
+# carrying instrumentation of its own.
+assert_patched touched
+assert_not_patched untouched
+
+# The handler the patched code calls has to come with it, or the clone calls
+# nothing when its check fires.
+out_symbols | grep -q '__ubsan_handle_' ||
+	fail "no __ubsan_handle_* reference in the patched output"
+
+pass "UBSAN metadata in an unchanged function does not drag it into the patch"
-- 
2.53.0-Meta

