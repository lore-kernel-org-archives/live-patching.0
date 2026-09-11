Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4128C4BD0EB
	for <live-patching@vger.kernel.org>; Fri, 11 Sep 2026 18:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789152299; cv=none; b=O4hB2VSWq0HoGOXHuGI5C7kMyYtHj1xhjL+CkSSO++wOf9VqepkD7Iu1CbxjqwMonlKx8mC2MDEdtp4wsKS+l10oN/UiyS3Q0Ovn7F0+OKyo113wkX5nCaBOaIMCSjvxXvKo76JKzdeXNw7zcnxRqNvjnQjrjzitHNw4es3hwQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789152299; c=relaxed/simple;
	bh=6hioUzqtMI9Vfk9gwkqBKG+i+lTIAx2j0f049KbxUFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DE4RL7vzn+3sj+fPTnLJ5j1JBVGQe4/ydALnVmlMe9rH51RUdFzrCnjfgMSG5aAlBwtblTjLaFMnj3mV0WjxKzOr1KpfWkuqLahEMRisK3THyMnbklp97Y0/MnFSdOEk0Ce5vLKovSLcFt2ZRrcQeTWKqi63ER2FaS3xZy0kbD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ctBljwA3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ctBljwA3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BED451F000FF;
	Fri, 11 Sep 2026 18:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789152297;
	bh=aI0MVYF+v3t60CwIGIJD/9NLNoVLT6/wV9dtoglflZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ctBljwA3lMXOKG1Q8ZJJXbYpY1ivOPB7j4JduG+WxPHA8551F6mkcbaPKJq1lxhSN
	 jq/4dYvMSLNy2d0CV1Lj8p40btXKA8gEdk+5KLcRQPAKshLZ+OVBSyziKJ8pgARSOR
	 svrVWNh8/se4pMIXrNoaDJ3uJOe5gcnQ6YEc78fs9eKjlME13p+nnB+ucULSIbQuYx
	 9jcsan9qfXNcO1EktPGvR27m9X0JjoCuPcYBWUf8BVqa5MmkTeqxXP9byrinxKrTs9
	 TURKVq0izea46dB49YTXu0Lc/ac6UBHKYAzFqQ2XkzvMGI0njqpMBRjUB9+qwJp6gE
	 VwnQSWXuJdSOA==
From: Song Liu <song@kernel.org>
To: live-patching@vger.kernel.org
Cc: jpoimboe@kernel.org,
	peterz@infradead.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	puranjay@kernel.org,
	kernel-team@meta.com,
	Song Liu <song@kernel.org>
Subject: [PATCH 16/58] objtool/klp: Add test for cold function halves
Date: Fri, 11 Sep 2026 11:42:23 -0700
Message-ID: <20260911184305.1457308-17-song@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911184305.1457308-1-song@kernel.org>
References: <20260911184305.1457308-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Puranjay Mohan <puranjay@kernel.org>

The compiler splits unlikely code into a separate foo.cold symbol.  Both
halves are the same function and both belong in the livepatch: carrying
only the hot part leaves the cold path branching into unpatched code.

GCC needs -freorder-blocks-and-partition to split reliably.  The flag is
probed rather than assumed, and the test skips when the compiler declines
to split at all.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 .../tests/generic/fixtures/cold_function.c    | 21 +++++++++++++
 .../tests/generic/test-cold-function.sh       | 30 +++++++++++++++++++
 2 files changed, 51 insertions(+)
 create mode 100644 tools/objtool/tests/generic/fixtures/cold_function.c
 create mode 100755 tools/objtool/tests/generic/test-cold-function.sh

diff --git a/tools/objtool/tests/generic/fixtures/cold_function.c b/tools/objtool/tests/generic/fixtures/cold_function.c
new file mode 100644
index 000000000000..f6d410983ce2
--- /dev/null
+++ b/tools/objtool/tests/generic/fixtures/cold_function.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Function the compiler may split into a hot part and a foo.cold part. */
+
+static const char __modinfo[]
+	__attribute__((section(".modinfo"), used, aligned(1))) = "\0name=vmlinux";
+
+static void __attribute__((cold, noinline)) slow_path(int x)
+{
+	__asm__ volatile("" :: "r"(x));
+}
+
+int target(int x)
+{
+	if (__builtin_expect(x < 0, 0))
+		slow_path(x);
+#ifdef PATCHED
+	return x + 2;
+#else
+	return x + 1;
+#endif
+}
diff --git a/tools/objtool/tests/generic/test-cold-function.sh b/tools/objtool/tests/generic/test-cold-function.sh
new file mode 100755
index 000000000000..315f407d9ad7
--- /dev/null
+++ b/tools/objtool/tests/generic/test-cold-function.sh
@@ -0,0 +1,30 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Both halves of a split function belong to the patch; carrying only the hot
+# part leaves the cold path branching into unpatched code.
+
+. "$(dirname "$0")/../lib.sh"
+
+# Clang does not split functions into a cold part at all, so there is nothing
+# for this test to look at there.  A given gcc may or may not split, which is a
+# version property rather than a compiler choice -- that stays a probe below.
+gcc_only "clang does not split functions into a cold part"
+
+setup
+
+split_flag=-freorder-blocks-and-partition
+cc_supports "$split_flag" || split_flag=
+
+build_pair cold_function.c $split_flag
+
+in_symbols orig.o | grep -qE 'target\.cold' ||
+	probe_skip "compiler did not split the function into a cold part"
+
+run_diff
+
+assert_patched target
+out_symbols | grep -qE 'target\.cold' ||
+	fail "cold half was not carried into the patch"
+
+pass "cold half carried into the patch with its parent"
-- 
2.53.0-Meta

