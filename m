Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120514CC262
	for <live-patching@vger.kernel.org>; Tue, 15 Sep 2026 23:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789515427; cv=none; b=Gv6Lny/rGfkD8zUi657TS7FbsH9HA9ZdZVzEaK+O3B4MzJp+HjjYUpJyuwGocso4ZL2ytNXliAoRQ43lG+0wC7HoFY9DZSwm7CQM9z2eUKbKaV7XEFafQDT05yIv+utRMEoOyKtrz90pj+LyMDHOJMkLVHIvOOdZA87egEp9ADI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789515427; c=relaxed/simple;
	bh=SwzPupEp9+zpuZx/OAS6ikPq63Z85B3/eqWblW563vY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tQQgGMKLbOeODw2PZ2zfHbX5B/gnd2WbANoQQNeUtiZ+bGTpOVtKESkDuyTHoYHuOXeOxzETUBGUkYyL2BazYT4kNjhVFCEtOXDR+925UtRNzkOYRpVoOI1+1i7sLZpv73jgntzukMRw1KH0z/vkiqVyC7PTG4oAZUlSuGKAuOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GkSR8Ng1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GkSR8Ng1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B833B1F000FF;
	Tue, 15 Sep 2026 23:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789515426;
	bh=fhP4l8ajropeTe7r1rXj6++pDBvF6Bh7vYNO16hc7hA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GkSR8Ng1v+yzOEo3h8oMcyXjjbucH27M6pifVmIYyceuUpy4xcmhZtiODcCYbjme0
	 XD57CqkyuU2H5st482Cod0H8cqP4FlypUC2ypCW8ZipnseMtJHI4Hbb4YNoIPteibA
	 aB7U9ljFJpV10FNsgLFKhOjNpVezcdebLVlVBMq/ZpGc2tYL+0w1XNEKpLYXjhXtU6
	 67Dxz567emDOp4HYU8SVKJ/8OklUQAbBrj1M4YDUpgZ+vrDLRMNIe5gmtm8H9ezQZ5
	 N6Bss6m5tmYS5KXeAJygjO72FOmmNNbnzyYNBx1DU9NX1Um00CYqVJkEEjg2L5Eb3y
	 8+0m5d3pnnlIg==
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
Subject: [PATCH v4 23/58] objtool/klp: Add test for rejecting references to init code/data
Date: Tue, 15 Sep 2026 16:34:19 -0700
Message-ID: <20260915233454.2405019-24-song@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915233454.2405019-1-song@kernel.org>
References: <20260915233454.2405019-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Puranjay Mohan <puranjay@kernel.org>

Init code and data are freed once boot finishes, so a klp relocation
against them can never resolve.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 .../tests/generic/fixtures/init_reference.c   | 17 +++++++++++
 .../tests/generic/test-init-reference.sh      | 29 +++++++++++++++++++
 2 files changed, 46 insertions(+)
 create mode 100644 tools/objtool/tests/generic/fixtures/init_reference.c
 create mode 100755 tools/objtool/tests/generic/test-init-reference.sh

diff --git a/tools/objtool/tests/generic/fixtures/init_reference.c b/tools/objtool/tests/generic/fixtures/init_reference.c
new file mode 100644
index 000000000000..9e59bdf708d3
--- /dev/null
+++ b/tools/objtool/tests/generic/fixtures/init_reference.c
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Patched function referencing data in an .init section. */
+
+static const char __modinfo[]
+	__attribute__((section(".modinfo"), used, aligned(1))) = "\0name=vmlinux";
+
+/* volatile so the read cannot be folded into a constant, leaving no reference */
+static volatile int init_only __attribute__((section(".init.data"), used)) = 5;
+
+int target(int x)
+{
+#ifdef PATCHED
+	return x + init_only + 1;
+#else
+	return x + init_only;
+#endif
+}
diff --git a/tools/objtool/tests/generic/test-init-reference.sh b/tools/objtool/tests/generic/test-init-reference.sh
new file mode 100755
index 000000000000..921cf493cd79
--- /dev/null
+++ b/tools/objtool/tests/generic/test-init-reference.sh
@@ -0,0 +1,29 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Init code and data are freed after boot, so a klp relocation against them can
+# never resolve.  Such a patch must be rejected.
+
+. "$(dirname "$0")/../lib.sh"
+
+setup
+build_pair init_reference.c
+
+# The rejection can only happen if the patched build really does reference the
+# init symbol.  The fixture makes init_only volatile so the read cannot be
+# folded away, and this checks that it worked: without a relocation klp diff
+# would succeed, and the failure below would read as a missing check rather
+# than as a fixture which stopped posing the question.
+# Either spelling will do.  A file-local variable is reached through its
+# section symbol -- .init.data -- and a global one by name; which of the two
+# the compiler picks is its business, and the reference is what matters.
+in_relocs "$patched_obj" |
+	awk '$5 == ".init.data" || $5 == "init_only"' | grep -q . ||
+	fail "patched object has no reference into .init.data; the fixture tests nothing"
+
+run_diff 255
+
+diff_log | grep -q "can't patch or reference init code/data" ||
+	fail "expected rejection, got: $(diff_log | tail -1)"
+
+pass "reference to init data rejected"
-- 
2.53.0-Meta

