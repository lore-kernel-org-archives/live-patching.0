Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4ABC4D9562
	for <live-patching@vger.kernel.org>; Wed, 16 Sep 2026 18:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789584413; cv=none; b=eVMFEFIVpRQ2VS9uKn8t9kCfkVvIzyuC8FJXL1cSS2LEWq2wSRAY49B+1h8G/O3QszxPy2Zl2ilTVGAt6rA8Td3Re2pefRyMyc0zOeWnnJqHLRnP5LRntEfetDRbCZdZ6uVvTA3xhOM3XzyLqMMU8bXPw0Kb07wxFSSd5gBzPV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789584413; c=relaxed/simple;
	bh=CZKgwqk9IP0dbPm4wrnyEqHqRMSzdE4UEFdYVwV9Ilk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mqvdeI2z70SxTfHJN0KLa3FGWddDpyQ3ae0C6T8MOUR24BsA7kOMyTQOozzbDy/PS1HeRZe4AcM1rGESaWnR0ke6KXEwqt9s7AYCqczj+c2hF0m/Su8aDW+cy62vGJsLSYtOdJ05cW8KAwgzfNffKopsSfG+kWnM9T5IROFJD1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HcgtSXwN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HcgtSXwN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B58F1F00899;
	Wed, 16 Sep 2026 18:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789584396;
	bh=YhHf8sl2v1hR4TqlYeletTYec+N0HGBNznOxWT4HRf4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HcgtSXwN7vSU5tJ4thfJXf4P+lJcMChoDZ7IgXdg/c2GPpL/cH013ZbOK3qFnN/K2
	 iVTxJxGYGhRIp6H+pSdybPnKzwImfAInO5+KEd6O+DqCPHv1+m3a52iwFh9OctQ/m/
	 W3NZq/jO0rrL8J7+eF8DR5C4yAd7HSUwMXczhwyN/swU0pZB7HkIE2iMZHyNVLVGOM
	 a1R1dnuM3zeU48vBxN2RiMTU0nIq9zehvQit+h/WZSKgi7pJ3ODWFW87Bbc6VtGGUa
	 I/tdW4q0mLRjwV4UKov8xW10FCPzINGpD5cueVAF52KT0yXDUMKWXrMs5ZXzp0AZw4
	 rj/nNaQGf0T9g==
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
Subject: [PATCH v5 33/58] objtool/klp: Add test for new references to exported symbols
Date: Wed, 16 Sep 2026 11:43:26 -0700
Message-ID: <20260916184351.2720310-34-song@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916184351.2720310-1-song@kernel.org>
References: <20260916184351.2720310-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A patch may introduce a reference the original object did not have.  That
is fine when the export belongs to vmlinux, and not fine when it belongs to
a module: the livepatch would gain a module dependency nobody declared, and
late module patching lets the patch load first.

This tests the behavior of commit 72d76d0c18eb ("objtool/klp: Allow new
references to module exports").

Assisted-by: Claude:claude-opus-4
Based-on-test-by: Joe Lawrence <joe.lawrence@redhat.com>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 .../tests/generic/fixtures/new_export_ref.c   | 35 ++++++++++++++
 .../tests/generic/test-new-export-ref.sh      | 46 +++++++++++++++++++
 2 files changed, 81 insertions(+)
 create mode 100644 tools/objtool/tests/generic/fixtures/new_export_ref.c
 create mode 100755 tools/objtool/tests/generic/test-new-export-ref.sh

diff --git a/tools/objtool/tests/generic/fixtures/new_export_ref.c b/tools/objtool/tests/generic/fixtures/new_export_ref.c
new file mode 100644
index 000000000000..73210aacb4ae
--- /dev/null
+++ b/tools/objtool/tests/generic/fixtures/new_export_ref.c
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * A reference which only exists in the patched build.  The symbol has no twin
+ * in the original object, so what klp diff may do with it depends entirely on
+ * whether Module.symvers says it is exported, and by what.
+ */
+
+static const char __modinfo[]
+	__attribute__((section(".modinfo"), used, aligned(1))) = "\0name=vmlinux";
+
+extern int newly_referenced(int x);
+
+/*
+ * A reference both builds have.  When Module.symvers says a module exports
+ * this one, the original already depends on that module, which is what makes
+ * a new reference to it safe -- the loader will not let the patched module
+ * load without it.  EXISTING_DEP leaves it out, for the case where there is
+ * no such dependency to inherit.
+ */
+extern int existing_dep(int x);
+
+int target(int x)
+{
+#ifdef EXISTING_DEP
+	int base = existing_dep(x);
+#else
+	int base = x;
+#endif
+
+#ifdef PATCHED
+	return newly_referenced(base);
+#else
+	return base + 1;
+#endif
+}
diff --git a/tools/objtool/tests/generic/test-new-export-ref.sh b/tools/objtool/tests/generic/test-new-export-ref.sh
new file mode 100755
index 000000000000..f0be2cf87fe3
--- /dev/null
+++ b/tools/objtool/tests/generic/test-new-export-ref.sh
@@ -0,0 +1,46 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# A reference the patch adds has no counterpart in the original object.  klp
+# diff used to reject any such reference needing a klp relocation, which ruled
+# out patches that call something they did not call before -- a common enough
+# thing for a fix to do.
+#
+# Module.symvers is what makes it safe: it says the symbol exists and who owns
+# it.  But that is only sufficient for a vmlinux export.  A new reference to a
+# module's export is a dependency the patch module does not declare, and the
+# relocation would resolve only if that module happened to be loaded, so it
+# stays an error.
+
+. "$(dirname "$0")/../lib.sh"
+
+setup
+build_pair new_export_ref.c
+
+# Exported by vmlinux, in a module: namespace so it needs a klp relocation
+# rather than an ordinary one.  Allowed.
+export_syms
+add_exports_ns vmlinux module:kvm newly_referenced
+run_diff
+assert_klp_sym newly_referenced vmlinux
+
+# Exported by a module the patched object does not depend on.  Rejected, and
+# for that reason rather than some other.
+export_syms
+add_exports other_mod newly_referenced
+run_diff 255
+assert_diff_log 'undeclared module dependency'
+
+# ... unless the original already referenced something that module exports.
+# The loader will not let the patched object load without other_mod, so the
+# klp relocation has something to resolve against, and klp diff allows it.
+# This is the other half of the rule, and it fails in the opposite direction:
+# refusing here would reject a patch which is safe to apply.
+rm -f "$workdir/out.o"
+build_pair new_export_ref.c -DEXISTING_DEP
+export_syms
+add_exports other_mod newly_referenced existing_dep
+run_diff
+assert_klp_sym newly_referenced other_mod
+
+pass "new reference allowed for vmlinux and for a module already depended on"
-- 
2.53.0-Meta

