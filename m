Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E246A2BE656;
	Sat, 17 Oct 2026 00:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792196735; cv=none; b=K1y3ga52cibSqu+faL5rQ9raC7om7qpd3RKp7FwKLXuB6jJw0yELI5HeAnuUDQBOZGG4rpBr+exITlirT9+Une0+0dLO4zBRs+qo5rg0A1sELaX0aBUZKmL2qosRL3HwrccT/5gcdCdEho5Emk504Zm7p+SAydu5GJ4/e9M2vpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792196735; c=relaxed/simple;
	bh=sk9nVUBKS3Hb7jg67zkHEdakv+Uuk9Jxj/WaIY3XnWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XTkeXyqPzZlGfimRtkSUMkpiEMkc56sGuk6Em7dG9LwVQ4I66O1dtWDWmT1EjlFkNcIrYOhPRJzDVZEynKLJLKquwTjOax0qWINhAQJMJtD5bBylxPrzwvp7yAkVSqqaO/x6uvtuny/F7Xss3QLHY02NZ0WY8tHl5r5ZzKKDIi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f/NzrEM2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f/NzrEM2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49BC11F000C4;
	Sat, 17 Oct 2026 00:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792196734;
	bh=x4/ZQ17jN03WGA6SD9SM0XETuOIDcqjgHbZY1rvu6I0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=f/NzrEM2BhfQjW605HIfFXZnKgsHUvcjjyPSzGjbS6Z4iPu2hG8x5k42wRYIuPTs+
	 OPAWC0ZhR978paZzlm9eL0+V4JIvwYfv8Q4oM0KInjhJFEQqBcBteYCE7gl7+YLz5k
	 Qy0MV6zG8sy45ZxSkSiNHSSafIFbkENJmk2K2w8mDJOUHtDAhH/JHMUM1PzJEVuoRT
	 h1F5Aask+P84sGniFyjAEafpPLVwKFg29H1yCduTwf4qZsxXiG6miVGr2yOgspXjYy
	 3fydx+y7BmTMeJvVlJIC/f1eAavDZb9fPSjzlxIyGKpWu5mjXsgWdEOK1tr7iTP8cz
	 QeR1cF67hzvQQ==
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
Subject: [PATCH 09/11] selftests/livepatch: Test klp-build's rejection of unsupported files
Date: Fri, 16 Oct 2026 17:24:39 -0700
Message-ID: <20261017002441.716615-10-song@kernel.org>
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

Add a test that klp-build rejects patches to lib/, the vDSO, real mode
code and assembly files, which it can't build a livepatch for.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 .../livepatch/test_klp_build/Makefile         |  3 +-
 .../test_klp_build/test-unsupported-files.sh  | 30 +++++++++++++++++++
 2 files changed, 32 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/livepatch/test_klp_build/test-unsupported-files.sh

diff --git a/tools/testing/selftests/livepatch/test_klp_build/Makefile b/tools/testing/selftests/livepatch/test_klp_build/Makefile
index 83f4e23460ac..af8f350226c2 100644
--- a/tools/testing/selftests/livepatch/test_klp_build/Makefile
+++ b/tools/testing/selftests/livepatch/test_klp_build/Makefile
@@ -6,7 +6,8 @@ TEST_PROGS := \
 	test-independent-patches.sh \
 	test-cancelling-patches.sh \
 	test-new-and-deleted-files.sh \
-	test-line-directives.sh
+	test-line-directives.sh \
+	test-unsupported-files.sh
 
 TEST_PROGS_EXTENDED := functions.sh
 
diff --git a/tools/testing/selftests/livepatch/test_klp_build/test-unsupported-files.sh b/tools/testing/selftests/livepatch/test_klp_build/test-unsupported-files.sh
new file mode 100755
index 000000000000..968ae80f7128
--- /dev/null
+++ b/tools/testing/selftests/livepatch/test_klp_build/test-unsupported-files.sh
@@ -0,0 +1,30 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. "$(dirname "$0")/functions.sh"
+
+setup_tree
+
+# - patches to lib/, the vDSO, real mode code and assembly are rejected
+
+for file in lib/string.c \
+	    arch/x86/entry/vdso/vma.c \
+	    arch/x86/realmode/rm/video-mode.c \
+	    arch/x86/kernel/head_64.S; do
+
+	start_test "patch to $file"
+
+	add_patch unsupported.patch <<EOT
+--- a/$file
++++ b/$file
+@@ -1 +1 @@
+-int x;
++int y;
+EOT
+
+	run_klp_build unsupported.patch
+
+	expect_error "$PATCH_DIR/unsupported.patch: unsupported patch to $file"
+done
+
+exit 0
-- 
2.53.0-Meta

