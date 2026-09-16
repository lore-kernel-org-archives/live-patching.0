Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160EB4D9572
	for <live-patching@vger.kernel.org>; Wed, 16 Sep 2026 18:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789584408; cv=none; b=sH5NNL3hlXXsku8chUTt3WgaHLqMIuzM+F6jHh7r0W8Q4/9Z60Dfr6llwZ/7dMS0RdsGQ9hYpD0b8pflJx64DnRexJ4lKg1VgPHaXRvOZmXnmRcozkNyEZvs2fAFgPUoTjpAxk2c2Xcyia+PraPL5iHgwydajrdblK7XQzktW9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789584408; c=relaxed/simple;
	bh=9dZQQjT7gBrV6do+mPpxHHa5isEc/REybxz6A65z0pw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KPSER1YJxKlySBRzI5d+2VwRzUItKday7efH0b1f6B2TpYen/ZRFvGTgLP4tSbpTr667tTTozmZcZnCjgd1SRRO05vN9pk3espKV/2m6tU+56hIano8W4HU22fQuQtOtvflXwcsKZSoG3ctNa5AVUFin0naHk7xAAyN4ppIpSV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gyDcGW34; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gyDcGW34"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF6001F0089C;
	Wed, 16 Sep 2026 18:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789584391;
	bh=eeXxgEIrBCXYrCQ+wb46Uh/LU1ka3wm7l/PqpmW5DRA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gyDcGW34ole91tiMiRSacWY//WYc5pduMwy6uWGVkcK9U4s6bOxbWRBvOKyCBkivl
	 SZJVxfzp6Lt0gFikfdM6K7yKlTf7voM0IzYIe4iS5Tda3lnzh1ki0EEMGa0a7gTqVZ
	 47PmvrplzYozhA750ezNpB71zB5dKS3j9hfYKJq4wpm3UgcjlCJj8xjFL2RrNbm5mz
	 fXebeOBSputHq3hLkodvDWNuTxnNfCZLXb5CV0GYpzchT9a2D/cKCwn/PNTlqQFLQc
	 h5b9KzJ8ysZUa1GwiHEkEcEiu/IWK6oK4qupun4XiGN8sQ1uNIr/PGFIInCspun20R
	 LtUWWqfvFWKGw==
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
Subject: [PATCH v5 32/58] objtool/klp: Add test for EXPORT_SYMBOL_FOR_MODULES references
Date: Wed, 16 Sep 2026 11:43:25 -0700
Message-ID: <20260916184351.2720310-33-song@kernel.org>
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

A symbol exported with EXPORT_SYMBOL_FOR_MODULES() is reachable only by the
modules named in its namespace, and a livepatch module is never one of
them. So a reference to it cannot be an ordinary relocation resolved by the
module loader; it has to be a klp relocation applied at patch time.

Getting this wrong is silent.  The module links, loads, and reads the wrong
thing, or fails to load for a reason that does not name the cause.

This tests the behavior of commit 4cd3cfb8b54f ("objtool/klp: Fix
relocations for EXPORT_SYMBOL_FOR_MODULES() symbols").  Which object the
resulting relocation is filed under is a separate question, and one this
test cannot ask: the patched object here is vmlinux, so the vmlinux section
is the one produced either way.  That is covered by the module case, in
"objtool/klp: Add test for vmlinux relocs in a patched module".

Assisted-by: Claude:claude-opus-4
Based-on-test-by: Joe Lawrence <joe.lawrence@redhat.com>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 .../generic/test-export-symbol-for-modules.sh | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100755 tools/objtool/tests/generic/test-export-symbol-for-modules.sh

diff --git a/tools/objtool/tests/generic/test-export-symbol-for-modules.sh b/tools/objtool/tests/generic/test-export-symbol-for-modules.sh
new file mode 100755
index 000000000000..7e7bdde6a7ac
--- /dev/null
+++ b/tools/objtool/tests/generic/test-export-symbol-for-modules.sh
@@ -0,0 +1,39 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# EXPORT_SYMBOL_FOR_MODULES() puts a vmlinux symbol in a "module:<names>"
+# namespace, and the module loader grants access by matching the importing
+# module's name against that list.  A livepatch module is never on the list, so
+# referencing such a symbol with a normal relocation fails modpost, and if that
+# is silenced, fails to load with "Unknown symbol".  It needs a klp relocation,
+# the same as an unexported symbol.
+#
+# Ordinary namespaces are not affected: copy_import_ns() propagates the patched
+# object's import tags to the patch module, so a normal relocation works.
+
+. "$(dirname "$0")/../lib.sh"
+
+setup
+build_pair cross_module.c
+
+sym=other_mod_func
+
+# Plain vmlinux export: a normal relocation is what we want.
+export_syms "$sym"
+run_diff
+assert_no_klp_sym "$sym"
+
+# Ordinary namespace: still a normal relocation.
+export_syms
+add_exports_ns vmlinux MY_NS "$sym"
+run_diff
+assert_no_klp_sym "$sym"
+
+# module: namespace: has to become a klp relocation.
+export_syms
+add_exports_ns vmlinux module:kvm "$sym"
+run_diff
+assert_klp_sym "$sym" vmlinux
+assert_section __klp_relocs.vmlinux
+
+pass "EXPORT_SYMBOL_FOR_MODULES symbol referenced with a klp relocation"
-- 
2.53.0-Meta

