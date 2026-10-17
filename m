Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3702DEA75;
	Sat, 17 Oct 2026 00:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792196746; cv=none; b=UkTumb731n9OFboi+5zOiwpaTrUr2rEyKqIalPQ3dB/squoekRWmTao/yp6zLhYxn6Y60kj0WP9chD78pFFc2kKKg8dQjXKaWFBwiEBPGMB0ELy3wzgUYlbwFB4DxCChnVe5sJmv2xHKOeJHj1kKPO/Js0oxurFcFAjTyPTtnLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792196746; c=relaxed/simple;
	bh=7OkCEfMUgIP/r05qDway2PJS1oUkU4xQlnFG7n6veDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F9vHzyKZ4UyrFpYOLCFupS+DytqfYhk00FB7OyFPt8wqoRy359I6urtbArYpGHYH2HqU8gXcwuChiL9lu3I6a9zcIbf8/3HRbzNHTC48OD9g3gAgZRqihcDaJozjWKerNunC8cxm2sf1cO6i6tSGewC0Tongu9ZTSF/CFU3/sJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WelF/W7r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WelF/W7r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6A171F000C4;
	Sat, 17 Oct 2026 00:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792196745;
	bh=sGOQhpgQqfc3hEom0zrrJ8milYtvPTtrw/6NfeHnfXA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WelF/W7rF/CGq/puWy1WjNVH6XewFRM72m5Oit2ZhE4ODcEgCEuRB6V6yqRhZlZrt
	 pMUaO0x80DJrtxPugFqn1MJVPfq5bhmoUTkRa56igJoesimx2kOe0340J4z6Z5gb1O
	 9opsZixXksKjdquT7YH2rXM8siO8DRmEstaDOcZhUIGXYmW9LY3AGoqqjAmCJ055dF
	 ygPfe4vqAVPxGq4wpZtW9DAH7jaUMRap8+4sYlJQaoXST/q4no3IZFeXUq5LZDf1Ry
	 YyhStRPtVToPoHWlQblfi0k9xXI6MPygpDu5oHvHbHiyJWM+QXnkUbGUppiZ+OrMDW
	 370Hp5yLqT8IA==
From: Song Liu <song@kernel.org>
To: live-patching@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	Song Liu <song@kernel.org>
Subject: [PATCH 11/11] selftests/livepatch: Test klp-build with patches which need offset or fuzz
Date: Fri, 16 Oct 2026 17:24:41 -0700
Message-ID: <20261017002441.716615-12-song@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261017002441.716615-1-song@kernel.org>
References: <20261017002441.716615-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

klp-build accepts patches which apply with an offset or fuzz, and warns
about them.  Add a test that both are accepted with a warning, and that
the fixed patch has the line numbers and context of the real source, so
the #line directives refer to the right lines.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 .../livepatch/test_klp_build/Makefile         |   3 +-
 .../test_klp_build/test-offset-and-fuzz.sh    | 120 ++++++++++++++++++
 2 files changed, 122 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/livepatch/test_klp_build/test-offset-and-fuzz.sh

diff --git a/tools/testing/selftests/livepatch/test_klp_build/Makefile b/tools/testing/selftests/livepatch/test_klp_build/Makefile
index 2513105b3e1c..a62ae5340fa4 100644
--- a/tools/testing/selftests/livepatch/test_klp_build/Makefile
+++ b/tools/testing/selftests/livepatch/test_klp_build/Makefile
@@ -8,7 +8,8 @@ TEST_PROGS := \
 	test-new-and-deleted-files.sh \
 	test-line-directives.sh \
 	test-unsupported-files.sh \
-	test-patch-not-applying.sh
+	test-patch-not-applying.sh \
+	test-offset-and-fuzz.sh
 
 TEST_PROGS_EXTENDED := functions.sh
 
diff --git a/tools/testing/selftests/livepatch/test_klp_build/test-offset-and-fuzz.sh b/tools/testing/selftests/livepatch/test_klp_build/test-offset-and-fuzz.sh
new file mode 100755
index 000000000000..413b39b83431
--- /dev/null
+++ b/tools/testing/selftests/livepatch/test_klp_build/test-offset-and-fuzz.sh
@@ -0,0 +1,120 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. "$(dirname "$0")/functions.sh"
+
+# expect_warning(msg) - check that klp-build warned, and drop the warning so
+# expect_patch() doesn't complain about it
+#	msg - the warning, without the "warning: klp-build: " prefix
+function expect_warning() {
+	local line="warning: klp-build: $1"
+
+	grep -qxF "$line" "$WORK_DIR/stderr" ||
+		not_ok "klp-build didn't warn \"$1\":" "$WORK_DIR/stderr"
+
+	grep -vxF "$line" "$WORK_DIR/stderr" > "$WORK_DIR/stderr.rest"
+	mv "$WORK_DIR/stderr.rest" "$WORK_DIR/stderr"
+}
+
+setup_tree
+
+add_file drivers/foo/foo.c <<'EOT'
+int foo(int x)
+{
+	if (x < 0)
+		return -1;
+	return x;
+}
+
+int bar(void)
+{
+	return __LINE__;
+}
+
+int baz(int x)
+{
+	if (x > 100)
+		return 100;
+	return x;
+}
+EOT
+
+# - a patch made against a source with fewer lines applies at an offset, and
+#   the fixed patch has the real line numbers
+
+start_test "patch with an offset"
+
+add_patch 0001-offset.patch <<'EOT'
+--- a/drivers/foo/foo.c
++++ b/drivers/foo/foo.c
+@@ -9,7 +9,7 @@
+
+ int baz(int x)
+ {
+-	if (x > 100)
+-		return 100;
++	if (x > 1000)
++		return 1000;
+ 	return x;
+ }
+EOT
+
+run_klp_build 0001-offset.patch
+
+expect_warning "$PATCH_DIR/0001-offset.patch applied with fuzz"
+expect_patch <<'EOT'
+--- a/drivers/foo/foo.c
++++ b/drivers/foo/foo.c
+@@ -12,7 +12,8 @@ int bar(void)
+
+ int baz(int x)
+ {
+-	if (x > 100)
+-		return 100;
++	if (x > 1000)
++		return 1000;
++#line 17
+ 	return x;
+ }
+EOT
+
+# - a patch whose context differs from the source applies with fuzz, and the
+#   fixed patch has the real context
+
+start_test "patch with fuzz"
+
+add_patch 0001-fuzz.patch <<'EOT'
+--- a/drivers/foo/foo.c
++++ b/drivers/foo/foo.c
+@@ -12,7 +12,7 @@
+ /* clamp x */
+ int baz(int x)
+ {
+-	if (x > 100)
+-		return 100;
++	if (x > 1000)
++		return 1000;
+ 	return x;
+ }
+EOT
+
+run_klp_build 0001-fuzz.patch
+
+expect_warning "$PATCH_DIR/0001-fuzz.patch applied with fuzz"
+expect_patch <<'EOT'
+--- a/drivers/foo/foo.c
++++ b/drivers/foo/foo.c
+@@ -12,7 +12,8 @@ int bar(void)
+
+ int baz(int x)
+ {
+-	if (x > 100)
+-		return 100;
++	if (x > 1000)
++		return 1000;
++#line 17
+ 	return x;
+ }
+EOT
+
+exit 0
-- 
2.53.0-Meta

