Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793223999;
	b=fYgiO8ZgkSW6DQXbvVgWJPC8R4eUz/yxpPzu4kQ1JE7ywLQXD7gsr5mtOYa8aCEfcUh3
	 iIfXyE5Wl+nfqgvct2qawwN7DTIEWXIH6Y2nJXSbHHEyYD6bd2CnWoccWcWi6xe/QEou7
	 p1bA38oHsxqk7NjI4v4deIXmyZ/sq/aG8b7JZhD0oZWpJTrdndJQWTwAcGvj90nPnYR2o
	 NjH/YIOD5whsYgon5xXf3iCfYz1PwhdW9fkArgsup8P8e9BlGYrZro2FNnq7qmPGUVl1M
	 EnEUVdlS1ncN9MW243Xkq3iNrMi+Duq/0R9KsCsAjCleJIOSAhpmocJtKQs2KbJeVaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793223999;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=xIFg3wYgKas7rIK7kZFC/3/Xo/xwC7llGHW0bIG23s0=;
	b=tRTP7fgedJgYO8CX1hsKn7DafQLXUVfRRBrgNZZbE2Tth6EfEd6gzSYcPCw77UbFqFFt
	 DUGPcMSvG9BLm+7TxkhPyoU0UUQXoketGMH/QDw50+TetNDoBMwCGa7gRaaURC1cykF2A
	 6xJoDHqpryYnsPdVyW7rtgzeUswJwHu7onGNC9flvjqpG8g1H8VNahtxI0ogGhQrs0j7g
	 FpvvtAxCjLa6qskwKWrL5+QIesKj/ED+3WormdTcya8GDt27YAe18nxwm1HWzboLWTizQ
	 3YFBs6umoPl7s/dZi70AMOvfqCYXA5D9J1apNc8GNQZTwvwB/2ojJE2TV89VPgfPVyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DgdtJzNH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDCA606A31A;
	Wed, 28 Oct 2026 21:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DgdtJzNH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18F481F01401;
	Wed, 28 Oct 2026 21:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793223999;
	bh=xIFg3wYgKas7rIK7kZFC/3/Xo/xwC7llGHW0bIG23s0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DgdtJzNHIcmcwaRBToZVAnnjhboSxO2QRjJ7t3jJniv6RtdjlyXVvGQFJa3pN3vis
	 o6Iqz9ODXSUol77IY0hV8zdiwMNJ8XXSIgZxjRsAokTUQNfuY07TwPt87p2HazXFfq
	 vQS/+KQM/dJrtQavAvdMjYL13W4mPUstMsm8VkWhh6y8yRY7nPBa17jTrTqH1XMhC+
	 J+cAK0+y7q7whd552abwBk1gVEwrH91pKfafDoUA2nFJCYNVEq18LB9E9k16o0Nv3O
	 arZWHOiH+d2QmATNepyz9PhpXrF+Ntjasr8oYrUohL89fO4Zq7369z0r6ByJqKv+Ed
	 rpPvntxcR6Zfg==
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
Subject: [PATCH v2 12/12] selftests/livepatch: Test klp-prepare-patch with offset and fuzz
Date: Wed, 28 Oct 2026 14:45:34 -0700
Message-ID: <20261028214534.1919398-13-song@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028214534.1919398-1-song@kernel.org>
References: <20261028214534.1919398-1-song@kernel.org>
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

klp-prepare-patch accepts patches which apply with an offset or fuzz,
and warns about them.  Add a test that both are accepted with a
warning, and that the combined patch has the line numbers and context of
the real source, so the #line directives refer to the right lines.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 .../livepatch/test_klp_build/Makefile         |   3 +-
 .../test_klp_build/test-offset-and-fuzz.sh    | 120 ++++++++++++++++++
 2 files changed, 122 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/livepatch/test_klp_build/test-offset-and-fuzz.sh

diff --git a/tools/testing/selftests/livepatch/test_klp_build/Makefile b/tools/testing/selftests/livepatch/test_klp_build/Makefile
index 3650de4d6975..0daeea7a7db1 100644
--- a/tools/testing/selftests/livepatch/test_klp_build/Makefile
+++ b/tools/testing/selftests/livepatch/test_klp_build/Makefile
@@ -7,7 +7,8 @@ TEST_PROGS := \
 	test-new-and-deleted-files.sh \
 	test-line-directives.sh \
 	test-unsupported-files.sh \
-	test-patch-not-applying.sh
+	test-patch-not-applying.sh \
+	test-offset-and-fuzz.sh
 
 TEST_PROGS_EXTENDED := functions.sh
 
diff --git a/tools/testing/selftests/livepatch/test_klp_build/test-offset-and-fuzz.sh b/tools/testing/selftests/livepatch/test_klp_build/test-offset-and-fuzz.sh
new file mode 100755
index 000000000000..8e36d5aa026f
--- /dev/null
+++ b/tools/testing/selftests/livepatch/test_klp_build/test-offset-and-fuzz.sh
@@ -0,0 +1,120 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. "$(dirname "$0")/functions.sh"
+
+# expect_warning(msg) - check that klp-prepare-patch warned, and drop the
+# warning so expect_patch() doesn't complain about it
+#	msg - the warning, without the "warning: klp-prepare-patch: " prefix
+function expect_warning() {
+	local line="warning: klp-prepare-patch: $1"
+
+	grep -qxF "$line" "$WORK_DIR/stderr" ||
+		not_ok "klp-prepare-patch didn't warn \"$1\":" "$WORK_DIR/stderr"
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
+#   the combined patch has the real line numbers
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
+run_klp_prepare_patch 0001-offset.patch
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
+#   combined patch has the real context
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
+run_klp_prepare_patch 0001-fuzz.patch
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

