Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587983EA963
	for <live-patching@vger.kernel.org>; Fri, 11 Sep 2026 18:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789152680; cv=none; b=VNzEjuKys4T/zBWsCrZAkbOmkY8DV+eyYVLTOUSNaZHoyCD9gc8UbjWxUaQsy8IJgG3lCNpoYatHm3Ed+/0XSgwDQ1i+JAdK0xRBp1eEU9pLwXAb/ghgSxKaBwGIoXRhT1G7m5QfD/1/gmOkRZGXrjygauGEzWSvqz1pnKqUWeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789152680; c=relaxed/simple;
	bh=ZJlNYE78YUyYBA81neyi6PybAvQlPxTktlC1H50zVjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sb6h30vASfg0lb3Svtuqok3kCjyGxy4SldEiUHHsXLlA3ssxZbiYcf2PpyQi4eWnxmhT9GBN71l7eObfdSY3OcEfAyFVx2hLPBAIM3ioFl+dBD0oIoMpYqIIUWjpbpCkQoptPciezy5nLlKqV557NUsJuUQorVWv1mb1+WW68G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KEl7uQ3T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KEl7uQ3T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21D901F000FF;
	Fri, 11 Sep 2026 18:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789152679;
	bh=T4r5Q2Uw0iqH/ZNLT9WH141ADhPLNf3WWVgjdSucyS8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KEl7uQ3TsThltkpheCs+kikgygyh31uz5t/OpnH1/zmRFql1X1+7S2LQG2ZukDTqV
	 2iQrfSzJhqOph2MBXyd6+FMxY5s6JJMuHwzgLEiNVv0IzVr4V9v0o5XiWWR9RlkBSt
	 TBVKPtKn5xU8AZuGWGQ5cjXNJD4xaqf0pzpsQ2syRERk6u6zIgXSffvyUm4DuSbrW/
	 NsWUMurxAoQZ8UYOpVJFUYKwisdusyDh+ZGEdO00tq+xPIUHreug35EolRYCe1uY+p
	 Hq3quUcXLiV4zGgZ6FvlnxVHtTIWmOe+U2JGIAZNfV2d/wmjzbnp4f+gDTB+dylV74
	 PKDkBBtzX35zw==
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
Subject: [PATCH 32/58] objtool/klp: Add test for EXPORT_SYMBOL_FOR_MODULES references
Date: Fri, 11 Sep 2026 11:50:05 -0700
Message-ID: <20260911185031.1534046-7-song@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911185031.1534046-1-song@kernel.org>
References: <20260911184305.1457308-1-song@kernel.org>
 <20260911185031.1534046-1-song@kernel.org>
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
relocations for EXPORT_SYMBOL_FOR_MODULES() symbols") and
commit d8a2860b4a36 ("objtool/klp: Fix vmlinux klp relocations for
EXPORT_SYMBOL_FOR_MODULES()").

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

