Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793223980;
	b=CfX6KwHpOp5mljAY150tox0T3GE9Scby9PjH/U+qRI7bDEN9bJunoxMzaD4y7g7n8Vjl
	 kAInJFIF+ozvTsD/0Iuzg89WRFFV3sAar3ea0X1vM48Lr3Aq8fkzJIr2vAIh+5j9Wa7VR
	 NpvnL2JpBlDjCUpcElEqNxfApIJ/r0TTPqRtRdt8BVtE+ZMMkRKhTpNXEygMnSuTQznTF
	 MbcUmVo+shSkcgHfnpYOlhDFDJ3DiNEY0pjon91AtN0Bb7irgukVOEa/v0VHI+OAimGpf
	 2DOmrhZkkahDEE/NrpOo3y6awH2JU+teLT/IUHvFbJfrvZrmL+D2dfnSWv9w9qg6tow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793223980;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=d6iInwlSY4D+TRZCIldd+Y7Eyxi99pI+00qkm6lzNAk=;
	b=QdYIKloiNFL6jKHWiblREeXBgk5dD+McHefPkLzpNerLsKAchkRqkYGIYlWc22cifa30
	 ge+wwTde0NOiGYUJGTPHV3j2e+ZXc1kRGxnp0utoakkdeQHrzxzFYfAIDPSGDab5e6dVQ
	 aexizRsYpFfTtDQFWp+CneFOlSa5MX7PCrUyuI0phymlreeI15Kjl9yoUJhLitUkVWZ1l
	 pfEvQPHmT/c3lSBTyyjS0BHlu8eOPyABXlVbEVWOK8VLeurG389USpSvtD0LJ0YJU8XeH
	 8Kuhp8cheNB8or3FVPlsXVk/KLLaFO8+0CyGFFtptlC6un9/sLr7pNkBa8TxMsQy+sQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H8IIBRcF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2C560A2616;
	Wed, 28 Oct 2026 21:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H8IIBRcF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCAB31F01403;
	Wed, 28 Oct 2026 21:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793223979;
	bh=d6iInwlSY4D+TRZCIldd+Y7Eyxi99pI+00qkm6lzNAk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H8IIBRcF2vytUTntjQ57Hse+mH8oWCLIx2z0Z2vR28LMLDpHk5vKgo7spC+N821vT
	 VNN/PDhEsM2y66cfbmHN7pjqFtTPuH78/XuVvP6n47KZu6bz9XdWONtcDB2doltwDZ
	 FyxLrGZ9s0QlCQBTdjFAtkDe5hkGcJR4t7J7SKvHaTvxPHi7rh6bwl2hBK9uvmIH6z
	 p2lI6WHPZPMw2cMvEa48miGQyHsmxth4HIkZNDlpstFFGlr7XFoMfiMK6H1gKMEDzk
	 fPq+UOyTZoqB9H3Pl7WX1d+420SaJQ+8ffwxqVI+T0wX3+0KOphiQ98VWxSChbjkX3
	 7aC4ktyaaA4tg==
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
Subject: [PATCH v2 08/12] selftests/livepatch: Test klp-prepare-patch with created and deleted files
Date: Wed, 28 Oct 2026 14:45:30 -0700
Message-ID: <20261028214534.1919398-9-song@kernel.org>
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
index 158a08d8a1b8..2818264fb31a 100644
--- a/tools/testing/selftests/livepatch/test_klp_build/Makefile
+++ b/tools/testing/selftests/livepatch/test_klp_build/Makefile
@@ -3,7 +3,8 @@
 TEST_PROGS := \
 	test-basic.sh \
 	test-independent-patches.sh \
-	test-cancelling-patches.sh
+	test-cancelling-patches.sh \
+	test-new-and-deleted-files.sh
 
 TEST_PROGS_EXTENDED := functions.sh
 
diff --git a/tools/testing/selftests/livepatch/test_klp_build/test-new-and-deleted-files.sh b/tools/testing/selftests/livepatch/test_klp_build/test-new-and-deleted-files.sh
new file mode 100755
index 000000000000..560221854b3e
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
+run_klp_prepare_patch 0001-new-and-old.patch
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
+run_klp_prepare_patch 0001-new.patch 0002-new-again.patch
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

