Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE5521FF2A
	for <live-patching@vger.kernel.org>; Tue, 15 Sep 2026 23:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789515481; cv=none; b=boQNsVRQLBtqe+vTLi/N6ZoNIeDEyufeL7oeyNmlOFkPmWamfx0nWexv4FnpuYQXgZv50NXkTHO3uLn0vXsK3pKErqPKA7dkEL5B8n2RumayVKB8uk9q1D4aJpQbOOL5mCA8gTqLAeOurzZ20saGoAM7444M8znByPYaf1H9C4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789515481; c=relaxed/simple;
	bh=lNHMFbs3ekNTFi+lZW1nnZaV8Y1OaF3nX61Z9cWyXVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AsZM4wYkHQWgoULMHIaGWpLdn1kNS3h7Qq4OO9qdSFc6e+WcN4Awn/VbRC1IGHJ+HZBpJct9H241bMKkKj2F0Z272qF7cwcVBoP/Q06sXmT29dVfeKVS+v/6hYCLUQRuQ2vR+mCdzCgno2BtPnomq+G0h1tnURsxJUDO8CrK+bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WWzGWFVj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WWzGWFVj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C71431F000FF;
	Tue, 15 Sep 2026 23:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789515479;
	bh=DsnCtOqOOXiZ4gl1TewM260+vYJkxZbvt9RG8a4ou3w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WWzGWFVjCMRXhvHEBaFsl654VXl+H96eZsb9cJmdOj0w8IkpsOGwp/vA/b0MNPtud
	 l5fK/AEJrOeEgOmqrDx/+QtCcTqehzmiqOMPES4NDDcvEiFYA/YYnWlNbWxcErvqrk
	 wubvaN6aaXIljHuwQmgyGGEsWCvGcWRrfO6jI/941t3KmnjBploqQNCQY45O35jHn0
	 2pS3bag5tGNZsYoD1NY90wrJI0alj21XzLrdlEQCecvSnArzwTOGrp7oAyQNmNjoxB
	 yfFChdzod/ars1Y16clen5FQAr3klge2ffUG9Yyi7V5MntBIefpVoKMGMf2siCDQrs
	 nhoGpCnvdyk4Q==
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
Subject: [PATCH v4 33/58] objtool/klp: Add test for new references to exported symbols
Date: Tue, 15 Sep 2026 16:34:29 -0700
Message-ID: <20260915233454.2405019-34-song@kernel.org>
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
 .../tests/generic/fixtures/new_export_ref.c   | 20 +++++++++++
 .../tests/generic/test-new-export-ref.sh      | 34 +++++++++++++++++++
 2 files changed, 54 insertions(+)
 create mode 100644 tools/objtool/tests/generic/fixtures/new_export_ref.c
 create mode 100755 tools/objtool/tests/generic/test-new-export-ref.sh

diff --git a/tools/objtool/tests/generic/fixtures/new_export_ref.c b/tools/objtool/tests/generic/fixtures/new_export_ref.c
new file mode 100644
index 000000000000..c046b9f87d0b
--- /dev/null
+++ b/tools/objtool/tests/generic/fixtures/new_export_ref.c
@@ -0,0 +1,20 @@
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
+int target(int x)
+{
+#ifdef PATCHED
+	return newly_referenced(x);
+#else
+	return x + 1;
+#endif
+}
diff --git a/tools/objtool/tests/generic/test-new-export-ref.sh b/tools/objtool/tests/generic/test-new-export-ref.sh
new file mode 100755
index 000000000000..ad6fa3979942
--- /dev/null
+++ b/tools/objtool/tests/generic/test-new-export-ref.sh
@@ -0,0 +1,34 @@
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
+pass "new reference allowed to a vmlinux export, rejected for a module export"
-- 
2.53.0-Meta

