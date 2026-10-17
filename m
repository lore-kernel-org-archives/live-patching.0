Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE5629B77E;
	Sat, 17 Oct 2026 00:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792196730; cv=none; b=fwqjfC8QRfLhgfrEVsD7QM7neCvU0Vn1knAzBmWjCSk57Fsnz1al3weXe9kSQck4/v4tMX0yAUTHc/zcNzi9Q6FH2dWdPogckYCn5XDhq1e/8nl26yP+R6cqqiEUME5qW1vHFj8mAglPwT4ITRIC4HV0NFX867ixfoBeYfIWbgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792196730; c=relaxed/simple;
	bh=9wxIJYPImz9y5aoiw23ORCtMmkMdpd8C0V895ua6TLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=csdIfpa/U4Cecu2R1uuXw33ohJKtXWSGcFEWeYvZZJJNh1Fr2kh4UCf5RMhaM0/cuoPHSbWZ4TE1IdNBBs8VAaAc5WbIRrNICAjQrQIji3loh+OD+srx8RvlmE6OUtV8NWN+C4eHWqNIdFWTSbkvzjIxH5+0slgyiVTc4EOLmmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WITe972Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WITe972Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3F5A1F000C4;
	Sat, 17 Oct 2026 00:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792196729;
	bh=VHvkmzRSZPxBOj4D3WlqTZqPzoTe/pqrlPa6ezkYA4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WITe972ZUIKSAxuytDo+1Sf/cy+dAouCqUrdgIPZNRzKFCf15gVLlVrhsv+wt12j4
	 ZfXwtXHz03noS6W/80Br1yH9YSx7TY/4tnQEoFnYPw607uzL0jWMsnZdzqtWkk7Bok
	 J5SbxJKWFf/dG0mZXrG/PQ3wXwaGln1u4K/hB1324k50UiD1ozpElhxDiMsNPJ8OU+
	 HWFBULXUzQQZoarCfyb9Ll+39afCNERJ+YqM89x4rtxgKkzIKQciSrYu9UyLLQW0Lk
	 Tbc8k24dqyptMKglhCbqyFrwLxSypmv0vS2O8RkE+Au0woihRIjSMpCwunjDX5d1R8
	 Wfq+gtxULz16w==
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
Subject: [PATCH 08/11] selftests/livepatch: Test where klp-build adds #line directives
Date: Fri, 16 Oct 2026 17:24:38 -0700
Message-ID: <20261017002441.716615-9-song@kernel.org>
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

Add a test of where #line directives go:

- each group of changed lines in a hunk gets its own directive
- after removed lines, the directive skips over them
- files other than C sources and headers get none
- lines added at the end of a file get none, as nothing after them
  needs renumbering

Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 .../livepatch/test_klp_build/Makefile         |   3 +-
 .../test_klp_build/test-line-directives.sh    | 175 ++++++++++++++++++
 2 files changed, 177 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/livepatch/test_klp_build/test-line-directives.sh

diff --git a/tools/testing/selftests/livepatch/test_klp_build/Makefile b/tools/testing/selftests/livepatch/test_klp_build/Makefile
index 96144f99b1aa..83f4e23460ac 100644
--- a/tools/testing/selftests/livepatch/test_klp_build/Makefile
+++ b/tools/testing/selftests/livepatch/test_klp_build/Makefile
@@ -5,7 +5,8 @@ TEST_PROGS := \
 	test-dependent-patches.sh \
 	test-independent-patches.sh \
 	test-cancelling-patches.sh \
-	test-new-and-deleted-files.sh
+	test-new-and-deleted-files.sh \
+	test-line-directives.sh
 
 TEST_PROGS_EXTENDED := functions.sh
 
diff --git a/tools/testing/selftests/livepatch/test_klp_build/test-line-directives.sh b/tools/testing/selftests/livepatch/test_klp_build/test-line-directives.sh
new file mode 100755
index 000000000000..50877393d2c1
--- /dev/null
+++ b/tools/testing/selftests/livepatch/test_klp_build/test-line-directives.sh
@@ -0,0 +1,175 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. "$(dirname "$0")/functions.sh"
+
+setup_tree
+
+# - each group of changed lines in a hunk gets its own #line directive
+
+start_test "two groups of changes in one hunk"
+
+add_file drivers/foo/groups.c <<'EOT'
+int foo(int x)
+{
+	int y = 0;
+
+	if (x < 0)
+		y = -1;
+	if (x > 100)
+		y = 100;
+	return y;
+}
+EOT
+
+add_patch 0001-groups.patch <<'EOT'
+--- a/drivers/foo/groups.c
++++ b/drivers/foo/groups.c
+@@ -1,9 +1,11 @@
+ int foo(int x)
+ {
+-	int y = 0;
++	int y = x;
+
+ 	if (x < 0)
+ 		y = -1;
++	else if (!x)
++		y = 1;
+ 	if (x > 100)
+ 		y = 100;
+ 	return y;
+EOT
+
+run_klp_build 0001-groups.patch
+
+expect_patch <<'EOT'
+--- a/drivers/foo/groups.c
++++ b/drivers/foo/groups.c
+@@ -1,9 +1,13 @@
+ int foo(int x)
+ {
+-	int y = 0;
++	int y = x;
++#line 4
+
+ 	if (x < 0)
+ 		y = -1;
++	else if (!x)
++		y = 1;
++#line 7
+ 	if (x > 100)
+ 		y = 100;
+ 	return y;
+EOT
+
+# - after removed lines, the #line directive skips over them
+
+start_test "removed lines"
+
+add_file drivers/foo/remove.c <<'EOT'
+int foo(int x)
+{
+	if (x < 0)
+		return -1;
+	return x;
+}
+EOT
+
+add_patch 0001-remove.patch <<'EOT'
+--- a/drivers/foo/remove.c
++++ b/drivers/foo/remove.c
+@@ -1,6 +1,4 @@
+ int foo(int x)
+ {
+-	if (x < 0)
+-		return -1;
+ 	return x;
+ }
+EOT
+
+run_klp_build 0001-remove.patch
+
+expect_patch <<'EOT'
+--- a/drivers/foo/remove.c
++++ b/drivers/foo/remove.c
+@@ -1,6 +1,5 @@
+ int foo(int x)
+ {
+-	if (x < 0)
+-		return -1;
++#line 5
+ 	return x;
+ }
+EOT
+
+# - only C sources and headers get #line directives
+
+start_test "change to a Makefile"
+
+add_file drivers/foo/Makefile <<'EOT'
+obj-y += foo.o
+obj-y += groups.o
+EOT
+
+add_patch 0001-makefile.patch <<'EOT'
+--- a/drivers/foo/Makefile
++++ b/drivers/foo/Makefile
+@@ -1,2 +1,3 @@
+ obj-y += foo.o
++obj-y += new.o
+ obj-y += groups.o
+EOT
+
+run_klp_build 0001-makefile.patch
+
+expect_patch <<'EOT'
+--- a/drivers/foo/Makefile
++++ b/drivers/foo/Makefile
+@@ -1,2 +1,3 @@
+ obj-y += foo.o
++obj-y += new.o
+ obj-y += groups.o
+EOT
+
+# - lines added at the end of a file have nothing after them to renumber
+
+start_test "lines added at the end of a file"
+
+add_file drivers/foo/tail.c <<'EOT'
+int foo(void)
+{
+	return 0;
+}
+EOT
+
+add_patch 0001-tail.patch <<'EOT'
+--- a/drivers/foo/tail.c
++++ b/drivers/foo/tail.c
+@@ -2,3 +2,8 @@ int foo(void)
+ {
+ 	return 0;
+ }
++
++int bar(void)
++{
++	return 1;
++}
+EOT
+
+run_klp_build 0001-tail.patch
+
+expect_patch <<'EOT'
+--- a/drivers/foo/tail.c
++++ b/drivers/foo/tail.c
+@@ -2,3 +2,8 @@ int foo(void)
+ {
+ 	return 0;
+ }
++
++int bar(void)
++{
++	return 1;
++}
+EOT
+
+exit 0
-- 
2.53.0-Meta

