Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B560289E13;
	Sat, 17 Oct 2026 00:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792196725; cv=none; b=kegqo5w3R+jxC1PKOaOD5XhUyH9iwxMY1eTDvPxzizdr0IXC4GgLijeqYlBZiOjd+slXsd6TPZrse6wPLgcL5cnlNJWiYokTn3JQqvdGU6Uynz856hzLwYcJJbORv1HuDeZgKcpYPN6FHRZL9x7/YAjZ5XsRKflRDCubrg/ZHhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792196725; c=relaxed/simple;
	bh=S+8eOw0YTNs/safo/xEp2V2ePb/k/c3ywOakyAngXKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DPzS0Gt9ANCVlmm60/A//Wrn3a4EpXyn6yfes/YZulkiMeUNipY5Mf4nNbICzXKpCjcie67qdQdivVyW/xaQMWTyVmxd/NkTh7rx0MynuPcgM0K+wm3mQvQJGyaXiQbhFZQ1323hLcdSQ3ZwWyDzAaW03BwJLtajpY4jUf9TJ5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JRgHzEK7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JRgHzEK7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCDF21F000C4;
	Sat, 17 Oct 2026 00:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792196723;
	bh=pgbuiITUPSgXIWHbQuc2MOtnphd+4tUohA9MO35QATM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JRgHzEK7dsDK1PeUEebRpf7aKENjTK6ikCb8Zr30Q89Q9sXSBCphEr3YHazC8Zukd
	 Wkk+bj0xVFJBHunbi8ncjxVOuElDV1sbCaEtHEsneZro3EoO/tj7o8LbjV69FiY2Qj
	 35/QsB9GNS2I8hxHbpDp/VGiTgz1/ZaCnNnjx6xSG4ofgEJW8Gg4GK5McUdrinoOmA
	 zN3uk9neFnxDuE9W7WYZOLnPJvGnz5tIOTvAVhrBtNgDWmGlYx/Fg8CMNMj+ldIk09
	 fYJJ5MQf23p3mD7dyqFZR85c0fMOXoL0wpI8zA6yKjG1G1Qj4vt1BS1AsgNtNtXPgt
	 sHGOpfL1Uc90A==
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
Subject: [PATCH 07/11] selftests/livepatch: Test klp-build with created and deleted files
Date: Fri, 16 Oct 2026 17:24:37 -0700
Message-ID: <20261017002441.716615-8-song@kernel.org>
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

Add a test of patches which create and delete files.  Both are diffed
against /dev/null, and the created file gets no #line directive, as it
has no original line numbers to preserve.  A file created by one patch
and changed by the next is a new file in the combined patch.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 .../livepatch/test_klp_build/Makefile         |  3 +-
 .../test-new-and-deleted-files.sh             | 94 +++++++++++++++++++
 2 files changed, 96 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/livepatch/test_klp_build/test-new-and-deleted-files.sh

diff --git a/tools/testing/selftests/livepatch/test_klp_build/Makefile b/tools/testing/selftests/livepatch/test_klp_build/Makefile
index b3191b5c1925..96144f99b1aa 100644
--- a/tools/testing/selftests/livepatch/test_klp_build/Makefile
+++ b/tools/testing/selftests/livepatch/test_klp_build/Makefile
@@ -4,7 +4,8 @@ TEST_PROGS := \
 	test-basic.sh \
 	test-dependent-patches.sh \
 	test-independent-patches.sh \
-	test-cancelling-patches.sh
+	test-cancelling-patches.sh \
+	test-new-and-deleted-files.sh
 
 TEST_PROGS_EXTENDED := functions.sh
 
diff --git a/tools/testing/selftests/livepatch/test_klp_build/test-new-and-deleted-files.sh b/tools/testing/selftests/livepatch/test_klp_build/test-new-and-deleted-files.sh
new file mode 100755
index 000000000000..2acec2df98ff
--- /dev/null
+++ b/tools/testing/selftests/livepatch/test_klp_build/test-new-and-deleted-files.sh
@@ -0,0 +1,94 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. "$(dirname "$0")/functions.sh"
+
+setup_tree
+
+add_file drivers/foo/old.c <<'EOT'
+int old(void)
+{
+	return 0;
+}
+EOT
+
+# - created and deleted files are diffed against /dev/null, and a created
+#   file gets no #line directive since it has no original line numbers
+
+start_test "created and deleted files"
+
+add_patch 0001-new-and-old.patch <<'EOT'
+--- /dev/null
++++ b/drivers/foo/new.c
+@@ -0,0 +1,4 @@
++int new(void)
++{
++	return 1;
++}
+--- a/drivers/foo/old.c
++++ /dev/null
+@@ -1,4 +0,0 @@
+-int old(void)
+-{
+-	return 0;
+-}
+EOT
+
+run_klp_build 0001-new-and-old.patch
+
+expect_patch <<'EOT'
+--- /dev/null
++++ b/drivers/foo/new.c
+@@ -0,0 +1,4 @@
++int new(void)
++{
++	return 1;
++}
+--- a/drivers/foo/old.c
++++ /dev/null
+@@ -1,4 +0,0 @@
+-int old(void)
+-{
+-	return 0;
+-}
+EOT
+
+# - a file created by one patch and changed by the next is a new file in the
+#   combined patch
+
+start_test "created file changed by a later patch"
+
+add_patch 0001-new.patch <<'EOT'
+--- /dev/null
++++ b/drivers/foo/new.c
+@@ -0,0 +1,4 @@
++int new(void)
++{
++	return 1;
++}
+EOT
+
+add_patch 0002-new-again.patch <<'EOT'
+--- a/drivers/foo/new.c
++++ b/drivers/foo/new.c
+@@ -1,4 +1,4 @@
+ int new(void)
+ {
+-	return 1;
++	return 2;
+ }
+EOT
+
+run_klp_build 0001-new.patch 0002-new-again.patch
+
+expect_patch <<'EOT'
+--- /dev/null
++++ b/drivers/foo/new.c
+@@ -0,0 +1,4 @@
++int new(void)
++{
++	return 2;
++}
+EOT
+
+exit 0
-- 
2.53.0-Meta

