Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793223970;
	b=qnUC4zvjJu91G2j1zkLoVOgDrFPekt43dAEs/5LmkChU5q+tkd421Xc0BDmL7m4qypjM
	 XNKjTqNia7shw/gvidfNHXqvCLXoqXpSOQ1IS+J70YUHhtDmOgdcBlEJhjMufeEzhL0+a
	 a4ptSP+M1GxXC6Mseoy3q56E5tJZTVp9Rs2HvIB9s7W8MbXfPSFX469tE2iLoxDCAHD3c
	 Nlez3ewJ3xMSqS4F/lZTpDRwTHemUW3CQ+OAggIzA/4F9XA/22bBCpivgBERY4dYjGRhj
	 ABge8hUZTphdmDPWpECF2P/4HGrXOlcmFaJ71uQC/KTLNhC5KXtmu9DM6arlQItpfqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793223970;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=qRoz2Ud7m1EpM11LAi2xkbUFkqidMBK8XuB84tKw0Wg=;
	b=wBJqdvjB+uFJ/vwawzRUygekytn6bHk8kkuH6BdboapFrPP6Mp2pq8MEdCt2Y+HDBHXn
	 O23oyzJ1TMAyrvLDWrAkSPJ5H+tmFjyOb+EXL9xcrGJKCNh/UF76wJdZigLe3je7YWnOK
	 U3Weg0pOJO8sxp06oZ9x2m3g1xueV3tNISYgxewscA8qtlwflKrdg23OzOvCJO/Ob9oLY
	 +CpqXmekBZJagGDU3QZ8MGBEs3v946Xta0VJ5uVwvAMtQbtvGRuZaKULztm3EWap+ISEW
	 ehLw7Yw7ew8AQ+PBmEx3JLhWrW2RCNpuubFUc26qtx0MV3rxdcZuVwJdee2xXnw0hkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IupLS8WB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A17606A31E;
	Wed, 28 Oct 2026 21:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IupLS8WB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A8141F01829;
	Wed, 28 Oct 2026 21:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793223970;
	bh=qRoz2Ud7m1EpM11LAi2xkbUFkqidMBK8XuB84tKw0Wg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IupLS8WB90KaOoIhpr0AKSNowqdQCsNnN6XvqNK8mr2jMLYyCFsod4L65ODydnudB
	 tsHpl456kMFrTz4nZoCbbpTTTMRXrRRiqfNMvV7sP8vAq8hq81wNCVEOtC0iDcxZjv
	 /AVUiJyTs+aOiidNfpdg3hMjoFLHJ6saDatXVWZMt3c+68WdeEvlyUP4Gw+x3pJeMQ
	 FK86bz4ysSwkLZkgi11ayKZS/dOsNcl8oNLtITWjX68XT4gYbLZB3Oy6T7zyQLhaI7
	 jfJF/PjB3LEI5ZN9r2GVlxUuJOPdimPFWpMXdMQhU9pAXJfJcfmrFIVuBZiHMiHkRZ
	 qTeHKO8rlh4Sg==
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
Subject: [PATCH v2 06/12] selftests/livepatch: Test klp-prepare-patch with independent patches
Date: Wed, 28 Oct 2026 14:45:28 -0700
Message-ID: <20261028214534.1919398-7-song@kernel.org>
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
index 71ae793b0595..50205a047dcd 100644
--- a/tools/testing/selftests/livepatch/test_klp_build/Makefile
+++ b/tools/testing/selftests/livepatch/test_klp_build/Makefile
@@ -1,7 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 
 TEST_PROGS := \
-	test-basic.sh
+	test-basic.sh \
+	test-independent-patches.sh
 
 TEST_PROGS_EXTENDED := functions.sh
 
diff --git a/tools/testing/selftests/livepatch/test_klp_build/test-independent-patches.sh b/tools/testing/selftests/livepatch/test_klp_build/test-independent-patches.sh
new file mode 100755
index 000000000000..eebb075da7ce
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
+run_klp_prepare_patch 0001-foo.patch 0002-baz.patch
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

