Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCE8296BC8;
	Sat, 17 Oct 2026 00:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792196709; cv=none; b=rdbnABjETL7n2rkRwpM6Slxhjtk1ATA3IJcj4FhIeWHXOmyM5YkFdn1i2TNUme3NFP2qpIzxwbM7LK5C2ymvMCOnDhiyVWQGfz2fEOCqsLt1u9BLHt6cdK+r87Q35Cqi3wPwOD1kTn7Yotk7FB+n/7OgvPcz83RgNCeW0UdcQAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792196709; c=relaxed/simple;
	bh=9EcA0MekQM6eRQ4EuyiukT8mX0cy/cGyiF7DhHfTuEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mHTLCUmxIUzzLQdFohI7PL0Xv/JKwlISwR1LChMFrbzrO0drjTEayTFVHHJm5chILbY2nfcvFsMqZl/nwftQy7Vj+y6L6r0BN2IQTdnOmE5S1sSLRJuIvMKGr+B1c1c7dJkfICDCZZm22ykQG1BlieUOb0dVk2xjz6EvuXCpap4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hqWctNEi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hqWctNEi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 507051F000C5;
	Sat, 17 Oct 2026 00:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792196708;
	bh=ssz5xw3Qju+nD43pV2EZtDWdZuhKRwuNrVtfrRQNabE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hqWctNEiKy6Nkthd5GuUjZNutHk6p9dDfFdsN1++NM4b8K+M3xx6iVsJpVy3x/3w/
	 q2Hqihjb3OIWNzZnH4kvMu9hJXCdHZQ8klJH1lW9C5/jCtFgwQZzAAMtJYrl8piZPE
	 qErHOG2jp7kGBSIIEq+mSt7yJHf9GON+PMkXFOWlsBfjuuDyIxur8XzzOHlu2BPWsX
	 Z4aqmavUo94LjPj8wTaAPxYY+BtFrHUHgIukhxJ+J7G6gmD2PNDJ0DZDaWAxo8SH/1
	 xjq58fYVxVxres22Qn1wYL5fkZS4Soo/dZhayYbpvGeNg4lHuEPM5IjmUxxX4f9kkV
	 TDwHKI08UxdcA==
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
Subject: [PATCH 04/11] selftests/livepatch: Test klp-build with dependent patches
Date: Fri, 16 Oct 2026 17:24:34 -0700
Message-ID: <20261017002441.716615-5-song@kernel.org>
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

Add a test where the second patch changes lines added by the first, so
it only applies on top of it.  klp-build has to combine the two into a
single patch against the original source, rather than fixing each one
against the original source on its own.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 .../livepatch/test_klp_build/Makefile         |  3 +-
 .../test_klp_build/test-dependent-patches.sh  | 72 +++++++++++++++++++
 2 files changed, 74 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/livepatch/test_klp_build/test-dependent-patches.sh

diff --git a/tools/testing/selftests/livepatch/test_klp_build/Makefile b/tools/testing/selftests/livepatch/test_klp_build/Makefile
index 6ebcecc828a1..405545c72303 100644
--- a/tools/testing/selftests/livepatch/test_klp_build/Makefile
+++ b/tools/testing/selftests/livepatch/test_klp_build/Makefile
@@ -1,7 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 
 TEST_PROGS := \
-	test-basic.sh
+	test-basic.sh \
+	test-dependent-patches.sh
 
 TEST_PROGS_EXTENDED := functions.sh
 
diff --git a/tools/testing/selftests/livepatch/test_klp_build/test-dependent-patches.sh b/tools/testing/selftests/livepatch/test_klp_build/test-dependent-patches.sh
new file mode 100755
index 000000000000..75b957ac002c
--- /dev/null
+++ b/tools/testing/selftests/livepatch/test_klp_build/test-dependent-patches.sh
@@ -0,0 +1,72 @@
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
+EOT
+
+# - a patch which changes lines added by an earlier patch doesn't apply to the
+#   original source on its own, but the combined patch does
+
+start_test "patch which depends on an earlier one"
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
+add_patch 0002-foo-again.patch <<'EOT'
+--- a/drivers/foo/foo.c
++++ b/drivers/foo/foo.c
+@@ -1,8 +1,8 @@
+ int foo(int x)
+ {
+ 	if (!x)
+-		return 0;
++		return 1;
+ 	if (x < 0)
+ 		return -1;
+ 	return x;
+ }
+EOT
+
+run_klp_build 0001-foo.patch 0002-foo-again.patch
+
+expect_patch <<'EOT'
+--- a/drivers/foo/foo.c
++++ b/drivers/foo/foo.c
+@@ -1,5 +1,8 @@
+ int foo(int x)
+ {
++	if (!x)
++		return 1;
++#line 3
+ 	if (x < 0)
+ 		return -1;
+ 	return x;
+EOT
+
+exit 0
-- 
2.53.0-Meta

