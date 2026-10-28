Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793223985;
	b=XX65v+2m4j1nnBVa4eookcNhEvp8V5rMz6Nk4jIpGDJuaJ7yCQDJXbXgwQjbv7/LRGSh
	 E4XqaCZ6Cx/sbovgHT5P20eBPvHDXWsa7u/MkltRXM0RY5iSZPncpCH63qI4qzvUkLjlR
	 3qYTk2BZEsDnW/6LrQcwsLcUijefp4SJoKq7o0t4rQZrSwu+aymESM0127u8lyP/Qku87
	 852JHsiP8J7wWslqLFKicVrgBYuu1JNmb/LHeZP2vzeXu7whi02kxJ8jTkENXeGYq9fhR
	 BofxkAuT/HAVRy2kMTpFdDcP90UREssUMNJzoTxIz/UNUdaVlp+bfZM1HumZjBk4lRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793223985;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=JnuC8rfNpbb3k3O+S6s6IChaqGFn1QZsoWDEbnwywi0=;
	b=SUQ+2aGwliQiREfN3zThxm9V7IPXrcwq3CkLDKEw/D+JVRrdJcVy3D9n0nClagVdKovB
	 BM8ws/lbhQNXiLjftDr0EpIciHjJoO4Xjhw7qi0k7HrhTtc3VbLZ65JLCsWVLW9zB6dW9
	 nd56VDiUOA4vzwH+dY2DMIc/TPhHIuIpGE88AVn38J4AtWRt/h3XFE5OPe14+jNGiu8lC
	 +UtCOdpTkG/hp8wEATmv4LARpxH+n6Osgdnz2ESNNNoVwjYg4P5Ia4JTJ6uinaL+ZiKY0
	 wlkmiKHawLqsoUDMzTbpI5uPGCQ+ZoyQMl/0m0JKdYVFU82GeT6wW2tA2U3ONyM4nFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S21L2XkX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2ADA606A32A;
	Wed, 28 Oct 2026 21:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S21L2XkX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C3801F01401;
	Wed, 28 Oct 2026 21:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793223984;
	bh=JnuC8rfNpbb3k3O+S6s6IChaqGFn1QZsoWDEbnwywi0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S21L2XkXhOCtn703wH0jwtGxAEfZrb1YMsVyVCgOTUO0HiS37uvzMuc4FCFzFhN1x
	 jkdaOHPlcYNsRiTw0eyWPbxVQ+bgbivIDchfNSA8Uq5BlAJSx5GmXFjHpCwZfjQOqo
	 qQrC3axyTEzWi9P1ywbRP4Zh2bneNbEa280k9KmGO3/vKgpXITQR2/etSuxYpVqvVS
	 wQETlxE75P4ErLyjFy3AOu3501rjkPp4SskWrEkNca96upoESBf9vEIMxiO2yd+Ban
	 QbXYMnSryfPryReqgcxzRY0boHtLvp7huIUlDW8Jt6Ru6KQs66DZ5xYUCPlPeGHHoC
	 KpOOQ4/ZW4TnA==
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
Subject: [PATCH v2 09/12] selftests/livepatch: Test where klp-prepare-patch adds #line directives
Date: Wed, 28 Oct 2026 14:45:31 -0700
Message-ID: <20261028214534.1919398-10-song@kernel.org>
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
index 2818264fb31a..902a62bfca86 100644
--- a/tools/testing/selftests/livepatch/test_klp_build/Makefile
+++ b/tools/testing/selftests/livepatch/test_klp_build/Makefile
@@ -4,7 +4,8 @@ TEST_PROGS := \
 	test-basic.sh \
 	test-independent-patches.sh \
 	test-cancelling-patches.sh \
-	test-new-and-deleted-files.sh
+	test-new-and-deleted-files.sh \
+	test-line-directives.sh
 
 TEST_PROGS_EXTENDED := functions.sh
 
diff --git a/tools/testing/selftests/livepatch/test_klp_build/test-line-directives.sh b/tools/testing/selftests/livepatch/test_klp_build/test-line-directives.sh
new file mode 100755
index 000000000000..9f599e64c330
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
+run_klp_prepare_patch 0001-groups.patch
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
+run_klp_prepare_patch 0001-remove.patch
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
+run_klp_prepare_patch 0001-makefile.patch
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
+run_klp_prepare_patch 0001-tail.patch
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

