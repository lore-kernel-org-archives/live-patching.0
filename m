Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049F9233134;
	Sat, 17 Oct 2026 00:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792196715; cv=none; b=MU7Ja58miAuUJ+jFjVQbp3yp62x39xMS5dKgaMHEiUNYzznO9cow+Nig/cdLIubEnfeJiaLUKLkUUb7eHNnArdfQ6Y+tzc57SQAjqVuDkVQEA+i2JNlnYlxQRhZI3DHsa1P6C5FO1F3AxzhoM1eWj0uQ2xcEV4M/2mW/2dYZKI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792196715; c=relaxed/simple;
	bh=nVpQk0RHnorNtCP7UZGHz3tt8kTJIxkooyQ0chzD5Kg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t6WgCMVljnvQEME+yYpW3HuvvwYwAd2BOP7hLn4tUGIZuPKUg2xIq+RhgDC4IMIhI3WBTgIoZqmCaJf4yh6BKLuRAITXrCahELmmvsHJ+7Givtox7nG6enbVaWQeCXQV2Hl4xjP4uKHcTWGrEXLg32699R6tuesit9gxfy/4/Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dv26hW6y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dv26hW6y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74A761F000C4;
	Sat, 17 Oct 2026 00:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792196713;
	bh=TEaM/FVJMo/NhxbPb0GgoFoqcHyO9snHz04EZ6xiZv0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dv26hW6yPeO6rHMGhYUAfBbaSafCcBKKyMjGhVS3YVhomPlGQNQFHVaR48LcO44sM
	 zxnpWt9uupEpjgzbG2c7KxCge1fJrs0kvl0PB5eaZBc2FusKnrsPvsUjX7KFQVb4qN
	 cWAbT2TUwCUZ4QPDOKxt73SNnpjrugey1j5WUdo61I5u/FPY4f6NglEie06Bp9bmdt
	 /ZiH1rpr4E7AByhm62Pzm1YW+ubpsHSdAiuWMU6yrWnB+/kvd73Lj4EDMedNTBy/PP
	 T2AKm1HeSJ4GPN3OAzWnuv2vd6lZUi7iSDs4OgEuq8WlHPZ4Na/euyksYkboNJIIC8
	 h08jre2UPljaQ==
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
Subject: [PATCH 05/11] selftests/livepatch: Test klp-build with patches to different functions
Date: Fri, 16 Oct 2026 17:24:35 -0700
Message-ID: <20261017002441.716615-6-song@kernel.org>
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

Add a test where two patches change different functions of the same
file, and the second also changes a header.  The patches are combined
into one patch per file, and the #line directives use line numbers from
the original file, even for the function the first patch moved down.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 .../livepatch/test_klp_build/Makefile         |   3 +-
 .../test-independent-patches.sh               | 124 ++++++++++++++++++
 2 files changed, 126 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/livepatch/test_klp_build/test-independent-patches.sh

diff --git a/tools/testing/selftests/livepatch/test_klp_build/Makefile b/tools/testing/selftests/livepatch/test_klp_build/Makefile
index 405545c72303..536b27767435 100644
--- a/tools/testing/selftests/livepatch/test_klp_build/Makefile
+++ b/tools/testing/selftests/livepatch/test_klp_build/Makefile
@@ -2,7 +2,8 @@
 
 TEST_PROGS := \
 	test-basic.sh \
-	test-dependent-patches.sh
+	test-dependent-patches.sh \
+	test-independent-patches.sh
 
 TEST_PROGS_EXTENDED := functions.sh
 
diff --git a/tools/testing/selftests/livepatch/test_klp_build/test-independent-patches.sh b/tools/testing/selftests/livepatch/test_klp_build/test-independent-patches.sh
new file mode 100755
index 000000000000..f38bad21584b
--- /dev/null
+++ b/tools/testing/selftests/livepatch/test_klp_build/test-independent-patches.sh
@@ -0,0 +1,124 @@
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
+add_file include/linux/foo.h <<'EOT'
+#ifndef _LINUX_FOO_H
+#define _LINUX_FOO_H
+
+int foo(int x);
+int bar(void);
+
+#endif
+EOT
+
+# - patches to different parts of a file are combined into one patch, with
+#   #line numbers from the original file even where an earlier patch moved
+#   the lines down
+
+start_test "patches to different functions of a file"
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
+add_patch 0002-baz.patch <<'EOT'
+--- a/drivers/foo/foo.c
++++ b/drivers/foo/foo.c
+@@ -14,7 +14,7 @@ int bar(void)
+
+ int baz(int x)
+ {
+-	if (x > 100)
+-		return 100;
++	if (x > FOO_MAX)
++		return FOO_MAX;
+ 	return x;
+ }
+--- a/include/linux/foo.h
++++ b/include/linux/foo.h
+@@ -1,6 +1,8 @@
+ #ifndef _LINUX_FOO_H
+ #define _LINUX_FOO_H
+
++#define FOO_MAX 100
++
+ int foo(int x);
+ int bar(void);
+
+EOT
+
+run_klp_build 0001-foo.patch 0002-baz.patch
+
+expect_patch <<'EOT'
+--- a/drivers/foo/foo.c
++++ b/drivers/foo/foo.c
+@@ -1,5 +1,8 @@
+ int foo(int x)
+ {
++	if (!x)
++		return 0;
++#line 3
+ 	if (x < 0)
+ 		return -1;
+ 	return x;
+@@ -12,7 +15,8 @@ int bar(void)
+
+ int baz(int x)
+ {
+-	if (x > 100)
+-		return 100;
++	if (x > FOO_MAX)
++		return FOO_MAX;
++#line 17
+ 	return x;
+ }
+--- a/include/linux/foo.h
++++ b/include/linux/foo.h
+@@ -1,6 +1,9 @@
+ #ifndef _LINUX_FOO_H
+ #define _LINUX_FOO_H
+
++#define FOO_MAX 100
++
++#line 4
+ int foo(int x);
+ int bar(void);
+
+EOT
+
+exit 0
-- 
2.53.0-Meta

