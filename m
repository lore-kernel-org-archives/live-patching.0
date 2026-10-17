Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA26129BDBB;
	Sat, 17 Oct 2026 00:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792196740; cv=none; b=NR24AsIDHOx0RjfxXBClsRRvqtx+rSHq3yt0j+4rG2h+a7Akfy5NrQviE3Jgy+G4gDst8WfIDjfb4vzlDD3Zt8IPZ2GOqzcsDzYsFZ54ZKXOGtBJRAFNqM2kk5rTGpM6LcSRVNVTv1mbTLcqYF5uFYjHc/IKFUiH2go10AKO+Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792196740; c=relaxed/simple;
	bh=8gpfhpqD1a8rz/hHeISdKI/E33ILHh0mcl0+LMWUclM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m0tlHVRmsXc3NiE9jFiJSsIL78Is6Ay/ASN2wtdXM8vZruF+5Rdk0bAhjUsZBc7GBlxkZMQgHaJIalw1wtJhzh/6PtnukOF9Gkx2TNAhH+WID4+7JzbQyseCoMBJBCbn52ex1S6Q2pZydEmeHVZ/EpPNohvwXGUjCiJ9Y9MQSyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TvbFih8L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TvbFih8L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 814E21F000C4;
	Sat, 17 Oct 2026 00:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792196739;
	bh=CiYB4IiIuE8heg9KKynNhd0nlFsf6hC8Bmp0HnuLzsY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TvbFih8LsUyUJDKlvTaqSedSTo+/Bhx3Xvw5j815LLcUpUbAifgBmjfx/AR5+VIHI
	 32tm7/RRsp9ZzW3cQD9z+FwDsYjNt571FlTXU6mq4MFjYGBLhU3jV2VEiFwCzUABji
	 8fIVlbszQNKvHQw/XaOmOc+tSZwi5ap1sRB2LmK8wJ+ruNehb8sDuQmoYy6fwN7Fox
	 Rnes7/1s2iG5jD1tj3dv5okQWvDNdYqeRajaf91KoQ/F2vVzGR9CpV9FyX/Ug0yjvD
	 A/HBqXnH2I3hL+lqsuKL4UwFtL+V5JbyZubMflTAivJ+errArcd2kpTJGJbQJIb8cP
	 Yr+oXHaQDGgew==
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
Subject: [PATCH 10/11] selftests/livepatch: Test klp-build with patches which don't apply
Date: Fri, 16 Oct 2026 17:24:40 -0700
Message-ID: <20261017002441.716615-11-song@kernel.org>
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

Add a test that klp-build rejects a patch which doesn't match the
source, and that when the second patch of a series doesn't apply, the
first one is reverted, leaving the source tree as it was.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 .../livepatch/test_klp_build/Makefile         |  3 +-
 .../test_klp_build/test-patch-not-applying.sh | 73 +++++++++++++++++++
 2 files changed, 75 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/livepatch/test_klp_build/test-patch-not-applying.sh

diff --git a/tools/testing/selftests/livepatch/test_klp_build/Makefile b/tools/testing/selftests/livepatch/test_klp_build/Makefile
index af8f350226c2..2513105b3e1c 100644
--- a/tools/testing/selftests/livepatch/test_klp_build/Makefile
+++ b/tools/testing/selftests/livepatch/test_klp_build/Makefile
@@ -7,7 +7,8 @@ TEST_PROGS := \
 	test-cancelling-patches.sh \
 	test-new-and-deleted-files.sh \
 	test-line-directives.sh \
-	test-unsupported-files.sh
+	test-unsupported-files.sh \
+	test-patch-not-applying.sh
 
 TEST_PROGS_EXTENDED := functions.sh
 
diff --git a/tools/testing/selftests/livepatch/test_klp_build/test-patch-not-applying.sh b/tools/testing/selftests/livepatch/test_klp_build/test-patch-not-applying.sh
new file mode 100755
index 000000000000..40841086288c
--- /dev/null
+++ b/tools/testing/selftests/livepatch/test_klp_build/test-patch-not-applying.sh
@@ -0,0 +1,73 @@
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
+EOT
+
+# - a patch which doesn't match the source is rejected
+
+start_test "patch which doesn't apply"
+
+add_patch 0001-bad.patch <<'EOT'
+--- a/drivers/foo/foo.c
++++ b/drivers/foo/foo.c
+@@ -1,6 +1,6 @@
+ int foo(int x)
+ {
+-	if (x > 0)
++	if (x >= 0)
+ 		return -1;
+ 	return x;
+ }
+EOT
+
+run_klp_build 0001-bad.patch
+
+expect_error "$PATCH_DIR/0001-bad.patch did not apply"
+
+# - when a later patch doesn't apply, the earlier ones are reverted
+
+start_test "series whose second patch doesn't apply"
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
+add_patch 0002-bad.patch <<'EOT'
+--- a/drivers/foo/foo.c
++++ b/drivers/foo/foo.c
+@@ -3,6 +3,6 @@
+ 	if (!x)
+ 		return 0;
+-	if (x > 0)
++	if (x >= 0)
+ 		return -1;
+ 	return x;
+ }
+EOT
+
+run_klp_build 0001-foo.patch 0002-bad.patch
+
+expect_error "$PATCH_DIR/0002-bad.patch did not apply"
+
+exit 0
-- 
2.53.0-Meta

