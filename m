Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EBC2BEFEB;
	Sat, 17 Oct 2026 00:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792196720; cv=none; b=lgobufq7EukNt1hCmNAB64Lm7WGXICx7LwSGuiVzTdd+AjUxh9IUwJXo2AT56glyvwHxqRefK7UxzRits8GfHsI15wk6zZ3+duvpVP/J8mEww0Y0TLsjQoEW5fBmLm5YldgwLFXqJvspKkokqx0pAdJfAdTPub/QuIbpmIetm6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792196720; c=relaxed/simple;
	bh=Wm5tPNkQjS8n3J+TyOyPiDGTtpA2kzvvNHV0ni/9gaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sR3dFPwrVyd1jT6V1wqqKmmSh1e0ruGVu45hR2EKjks3Ad7zqoVLUrkPdkCkH8fbVjDIo+WIdXgTrP4UG2/IpdNOBXA8eXCQJSxjmtqImrYxEUNNwhxaZiI59IRxSYCcL6qcGGj8jW4AompP5C5paygqRNf6pWHw+/bav5VUT1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eEFlqq94; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eEFlqq94"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94A8B1F000C4;
	Sat, 17 Oct 2026 00:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792196718;
	bh=+0j/TeknGUIqQYVobW261ici6uYcivAPyx0oktYlXEQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eEFlqq94dksvBhlhAHm6N+iFBVpGOkEMoBHVjSBqpLStCDiR66jZMer1w1ARZdW9u
	 IuacI/MF8tNay0vjtJeWmKD9fVAx2NoICAxkEe3P6lGZ5+Sufz9QZris2QBnz6j8Mh
	 07y1GtONm5sb7ROSqNEVZ7qwscbuoAu4OtCYrlVZJvSIwTnNp89tbPO98oTlVZuSN7
	 9LzD2zQDElHheZoN1lNabtklswp3Mw9GjumOaWmq8/SiK1O91dNf/GwKf1FeGPt1Xk
	 n+bSKVEN2bYm0wGHvzaK3bGvVbQBCvGn6QD5Hh2ci0QO1bfjmejFWoZYUUsrAuFFZy
	 NDpwk4Q9us2rQ==
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
Subject: [PATCH 06/11] selftests/livepatch: Test klp-build with patches which cancel out
Date: Fri, 16 Oct 2026 17:24:36 -0700
Message-ID: <20261017002441.716615-7-song@kernel.org>
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

Add a test where a patch is followed by its revert.  On their own the
two leave nothing to build, so klp-build fails with "no changes
detected" before building anything.  With another patch after them,
only that patch's change is left in the combined patch.

Add expect_error() to functions.sh to check for a failure with a given
error message.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 .../livepatch/test_klp_build/Makefile         |   3 +-
 .../livepatch/test_klp_build/functions.sh     |  12 +++
 .../test_klp_build/test-cancelling-patches.sh | 102 ++++++++++++++++++
 3 files changed, 116 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/livepatch/test_klp_build/test-cancelling-patches.sh

diff --git a/tools/testing/selftests/livepatch/test_klp_build/Makefile b/tools/testing/selftests/livepatch/test_klp_build/Makefile
index 536b27767435..b3191b5c1925 100644
--- a/tools/testing/selftests/livepatch/test_klp_build/Makefile
+++ b/tools/testing/selftests/livepatch/test_klp_build/Makefile
@@ -3,7 +3,8 @@
 TEST_PROGS := \
 	test-basic.sh \
 	test-dependent-patches.sh \
-	test-independent-patches.sh
+	test-independent-patches.sh \
+	test-cancelling-patches.sh
 
 TEST_PROGS_EXTENDED := functions.sh
 
diff --git a/tools/testing/selftests/livepatch/test_klp_build/functions.sh b/tools/testing/selftests/livepatch/test_klp_build/functions.sh
index 4e9d4ccfe300..04538efbee5d 100644
--- a/tools/testing/selftests/livepatch/test_klp_build/functions.sh
+++ b/tools/testing/selftests/livepatch/test_klp_build/functions.sh
@@ -136,3 +136,15 @@ function expect_patch() {
 
 	echo "ok"
 }
+
+# expect_error(msg) - check that klp-build failed with an error message
+#	msg - the message, without the "error: klp-build: " prefix
+function expect_error() {
+	[[ $STATUS -ne 0 ]] || not_ok "klp-build succeeded unexpectedly:" "$WORK_DIR/stdout"
+	[[ -s "$WORK_DIR/stdout" ]] && not_ok "klp-build printed a patch:" "$WORK_DIR/stdout"
+
+	grep -qxF "error: klp-build: $1" "$WORK_DIR/stderr" ||
+		not_ok "klp-build didn't fail with \"$1\":" "$WORK_DIR/stderr"
+
+	echo "ok"
+}
diff --git a/tools/testing/selftests/livepatch/test_klp_build/test-cancelling-patches.sh b/tools/testing/selftests/livepatch/test_klp_build/test-cancelling-patches.sh
new file mode 100755
index 000000000000..270ec8dd892f
--- /dev/null
+++ b/tools/testing/selftests/livepatch/test_klp_build/test-cancelling-patches.sh
@@ -0,0 +1,102 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. "$(dirname "$0")/functions.sh"
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
+add_patch 0001-foo.patch <<'EOT'
+--- a/drivers/foo/foo.c
++++ b/drivers/foo/foo.c
+@@ -1,6 +1,8 @@
+ int foo(int x)
+ {
++	if (!x)
++		return 0;
+ 	if (x < 0)
+ 		return -1;
+ 	return x;
+ }
+EOT
+
+add_patch 0002-revert-foo.patch <<'EOT'
+--- a/drivers/foo/foo.c
++++ b/drivers/foo/foo.c
+@@ -1,8 +1,6 @@
+ int foo(int x)
+ {
+-	if (!x)
+-		return 0;
+ 	if (x < 0)
+ 		return -1;
+ 	return x;
+ }
+EOT
+
+add_patch 0003-baz.patch <<'EOT'
+--- a/drivers/foo/foo.c
++++ b/drivers/foo/foo.c
+@@ -12,7 +12,7 @@ int bar(void)
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
+# - a patch and its revert leave nothing to build
+
+start_test "patch and its revert"
+
+run_klp_build 0001-foo.patch 0002-revert-foo.patch
+
+expect_error "no changes detected"
+
+# - with another patch after them, only that patch's change is left
+
+start_test "patch and its revert, then another patch"
+
+run_klp_build 0001-foo.patch 0002-revert-foo.patch 0003-baz.patch
+
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

