Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793223975;
	b=1ICdsX2B0TgbxIPtpgslgEGCjuqKck4AQkE9FYEV5DKJwbjDvMhibDl3H90wIfvuiA6L
	 ZKwMkNL2I4uC4AUg4j8wLCJPtaAPE4OakGLrSIb2jqv0S2LHoCTdvu99Li073VSSqgQe3
	 VYhajlLfPXT/5Eqn67cfwkJ3jhPfIzswRUgjwdEsSE3Vyt7cFtwYCJIFOAci/hg9BDL6k
	 U2n8ZzjcirYFafrTBU95cfQs385HziMQ/2ZCXdQVXkuLcT92coZYhr7cX7GHzCV3PonMX
	 o9SGgo7s63Y6blczc/fltvmLY0N2ajgxag3C4VNmcllYqCr2hE2L4bcdCl4a6UScv4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793223975;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=mkNP8VDKFacUQ2R3+P/8bTR8wKAz3oDwsget4lm1gBE=;
	b=155IaWyQYT2L6TDYsxyUkdvvjwxOEVBJlyw79inb2OUY6SVGNq667NOLLOATcg+AtA8f
	 ZbpigOBED6cLHA1Losu4G7Q1iQtos2F6bX94R6HfbP+Q2ICMMgB6F6nKZfZB/2dPHcxUU
	 81aRpHnnfOimCDVWDrzNXFt96qupUa8oscZ2wL7QM0zje6/LvwTNtML5nKEUO67QQIwmO
	 v7VYxRPrkB8UqJJdzA3CbMugrZpvvrao9+bZI2bn7dtvhESDMl33PkRRBMTGX/VaifTW4
	 DGOOJtuDbkhHRUSFqPk8O+V6d12wA9Dgm7eN7EqmIMobrD6drb6saF6qdRHuSDZWY0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aKpVh900;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4255A60A2639;
	Wed, 28 Oct 2026 21:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aKpVh900
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA9F41F031ED;
	Wed, 28 Oct 2026 21:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793223974;
	bh=mkNP8VDKFacUQ2R3+P/8bTR8wKAz3oDwsget4lm1gBE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aKpVh900HR9MatTmQg5/QPokmCH8DEFoCjSHi/3qeuhzFmeOGS4fgz/v3kU+ycHiK
	 +aNUT17NmDQjaHJD0I2DJ3ec2UZaAenwRlXL0c8Pd86WAsSJhIFgvRmzC6vnjd2yY2
	 L9UEN5QPSrUMFC9hIBg0jzAoNHSWNbkKefNETI26xOfGm0L+gsmmJ7Pd/9uBz1JGBy
	 VwhLwJ40DcmStc/QeFw7iCEBtBPnOuYQIHu+6NQkqMxs9pLItqgspTruYfPjCZqxGl
	 EmkS9oeTj6R4FJGLkbeKJuwxGqyD8nM5yRlFUJfkr2Q2m/gUGRO3hPhW+CkhovsEqn
	 JSmh10VlGueaA==
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
Subject: [PATCH v2 07/12] selftests/livepatch: Test klp-prepare-patch with patches which cancel out
Date: Wed, 28 Oct 2026 14:45:29 -0700
Message-ID: <20261028214534.1919398-8-song@kernel.org>
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

Add a test where a patch is followed by its revert.  On their own the
two leave nothing to build, so klp-prepare-patch fails with "no changes
detected", and klp-build stops before building anything.  With another
patch after them, only that patch's change is left in the combined
patch.

Add expect_error() to functions.sh to check for a failure with a given
error message.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 .../livepatch/test_klp_build/Makefile         |   3 +-
 .../livepatch/test_klp_build/functions.sh     |  14 +++
 .../test_klp_build/test-cancelling-patches.sh | 102 ++++++++++++++++++
 3 files changed, 118 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/livepatch/test_klp_build/test-cancelling-patches.sh

diff --git a/tools/testing/selftests/livepatch/test_klp_build/Makefile b/tools/testing/selftests/livepatch/test_klp_build/Makefile
index 50205a047dcd..158a08d8a1b8 100644
--- a/tools/testing/selftests/livepatch/test_klp_build/Makefile
+++ b/tools/testing/selftests/livepatch/test_klp_build/Makefile
@@ -2,7 +2,8 @@
 
 TEST_PROGS := \
 	test-basic.sh \
-	test-independent-patches.sh
+	test-independent-patches.sh \
+	test-cancelling-patches.sh
 
 TEST_PROGS_EXTENDED := functions.sh
 
diff --git a/tools/testing/selftests/livepatch/test_klp_build/functions.sh b/tools/testing/selftests/livepatch/test_klp_build/functions.sh
index 6b2f30d72f99..e28988d07bc9 100644
--- a/tools/testing/selftests/livepatch/test_klp_build/functions.sh
+++ b/tools/testing/selftests/livepatch/test_klp_build/functions.sh
@@ -133,3 +133,17 @@ function expect_patch() {
 
 	echo "ok"
 }
+
+# expect_error(msg) - check that klp-prepare-patch failed with an error message
+#	msg - the message, without the "error: klp-prepare-patch: " prefix
+function expect_error() {
+	[[ $STATUS -ne 0 ]] ||
+		not_ok "klp-prepare-patch succeeded unexpectedly:" "$WORK_DIR/stdout"
+	[[ -s "$WORK_DIR/stdout" ]] &&
+		not_ok "klp-prepare-patch printed a patch:" "$WORK_DIR/stdout"
+
+	grep -qxF "error: klp-prepare-patch: $1" "$WORK_DIR/stderr" ||
+		not_ok "klp-prepare-patch didn't fail with \"$1\":" "$WORK_DIR/stderr"
+
+	echo "ok"
+}
diff --git a/tools/testing/selftests/livepatch/test_klp_build/test-cancelling-patches.sh b/tools/testing/selftests/livepatch/test_klp_build/test-cancelling-patches.sh
new file mode 100755
index 000000000000..da6a12064be9
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
+run_klp_prepare_patch 0001-foo.patch 0002-revert-foo.patch
+
+expect_error "no changes detected"
+
+# - with another patch after them, only that patch's change is left
+
+start_test "patch and its revert, then another patch"
+
+run_klp_prepare_patch 0001-foo.patch 0002-revert-foo.patch 0003-baz.patch
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

