Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001E63E5EEC
	for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 06:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789367281; cv=none; b=Umwm+ekrjTI3C0z7mitYVikh+2eypXSuNLRQC1Kbfm5aBne7xHIknWqF2g/w1/KHqZSCZVD3ytP47l/tyCC7xChKDneKhl/qHs+we9mJAB5AsL4Kf8MXrJOxDKnyYnGBa1etwpVVst/R7yLaKGIqBIHY7Y2TfueIPsrRUMCQiTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789367281; c=relaxed/simple;
	bh=wfj+52iSB3C3wiGnKA41TSQ7NwHzHfDpdKaLos1l/lI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cLrWN1NLvhzvjgivLLp92T499aqhQhvfTW2xQztyUaEuSdowgq4w5/fC28PI/8Zt6nLtdkNYzySfkjMaGrKJah5MYqNsTCMfXtvhK+ZqYGskbLsAfy/QuhdT/i3G26KI7ax0oRaQN7Xe0+EKP9Q7dLHIKW59OVgaTyCkFRQ8nIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TjJYaxRT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TjJYaxRT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66F6E1F000FF;
	Mon, 14 Sep 2026 06:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789367278;
	bh=ur3e/52GQ7ppgxsw2vpr84H7dU0tbH+g0jnj5wFsZQk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TjJYaxRTJYb5Gtkh/Tmr1Zpgq0g05QmBOK4U7GYjqB7cX3Ou4RrhuY1c9AMYk4wus
	 9laiDDM/hFr2s05FABKzCF7Rng/5AT9rGDyPU+uyc3OzqXv//pH1fBdTUpc9QziYGR
	 464JuiIgNxhjFdVcIAPkfBuN7RJOHEzNwloXElhsAcJ3ljhWbsWcGieS/LuvvukKg2
	 uN7PDSlIVVdrP7fXt4T69qaRT6KZw7jtl/tvon7S01LLpr358vIpbkKJOh4BwqnDXQ
	 oBczNvRYOODEMgYl6w16fl2W0gXWRkiBzXRpMXfGES2KFxjFo8uD3QsnOKexBvl1nX
	 qPOw6OnjtcB0g==
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
Subject: [PATCH v2 28/58] objtool/klp: Add test for klp reloc section naming in module objects
Date: Sun, 13 Sep 2026 23:24:44 -0700
Message-ID: <20260914062514.926997-29-song@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914062514.926997-1-song@kernel.org>
References: <20260914062514.926997-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

klp diff names the intermediate __klp_relocs section after the object the
relocation belongs to, and post-link turns that into
.klp.rela.<object>.<sec>. Name it after the wrong object and the kernel
applies the relocation when the wrong module loads, or never.

The fixture is the first here to honour MODNAME: most hardcode
name=vmlinux, so passing -DMODNAME to them silently does nothing and the
test quietly becomes a vmlinux test.

This tests the behavior of commit 07f14d6af9d7 ("objtool/klp: Fix
cross-module klp relocation section naming").

Assisted-by: Claude:claude-opus-4
Based-on-test-by: Joe Lawrence <joe.lawrence@redhat.com>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 .../tests/generic/fixtures/cross_module.c     | 25 +++++++++++++++
 .../tests/generic/test-module-object.sh       | 31 +++++++++++++++++++
 2 files changed, 56 insertions(+)
 create mode 100644 tools/objtool/tests/generic/fixtures/cross_module.c
 create mode 100755 tools/objtool/tests/generic/test-module-object.sh

diff --git a/tools/objtool/tests/generic/fixtures/cross_module.c b/tools/objtool/tests/generic/fixtures/cross_module.c
new file mode 100644
index 000000000000..c170bde0666f
--- /dev/null
+++ b/tools/objtool/tests/generic/fixtures/cross_module.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * A function which calls out to another object.  MODNAME selects which object
+ * this one is, so a test can make the caller a module and the callee's owner
+ * something else.
+ */
+
+#ifndef MODNAME
+#define MODNAME "vmlinux"
+#endif
+
+/* klp diff takes the object's module name from .modinfo */
+static const char __modinfo[]
+	__attribute__((section(".modinfo"), used, aligned(1))) = "\0name=" MODNAME;
+
+extern int other_mod_func(int x);
+
+int target(int x)
+{
+#ifdef PATCHED
+	return other_mod_func(x) + 2;
+#else
+	return other_mod_func(x) + 1;
+#endif
+}
diff --git a/tools/objtool/tests/generic/test-module-object.sh b/tools/objtool/tests/generic/test-module-object.sh
new file mode 100755
index 000000000000..95c8402a523a
--- /dev/null
+++ b/tools/objtool/tests/generic/test-module-object.sh
@@ -0,0 +1,31 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# A klp relocation section is named for the object being patched, not for the
+# object which happens to own the symbol being referenced.  Deriving it from
+# the symbol means a cross-module reference lands in a section for an object
+# the patch may not even touch, so the relocation is never applied and the call
+# goes somewhere arbitrary.
+
+. "$(dirname "$0")/../lib.sh"
+
+setup
+build_module_pair cross_module.c klp_testmod
+
+# The fixture has to have built as a module for any of this to mean anything.
+in_sections orig.o | grep -q '\.modinfo' ||
+	fail "fixture has no .modinfo"
+
+# other_mod_func belongs to a different module than the one being patched.
+add_exports other_mod other_mod_func
+run_diff
+
+# Named for the patched object ...
+assert_section __klp_relocs.klp_testmod
+# ... not for the object owning the symbol.
+assert_no_section __klp_relocs.other_mod
+
+run_post_link
+assert_klp_rela klp_testmod .text.target
+
+pass "klp relocation section named for the patched object"
-- 
2.53.0-Meta

