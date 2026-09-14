Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E5B3B14D4
	for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 23:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789427200; cv=none; b=rNxR9AkQIg4k9uKF69kQBU9APvFcv2bIJ9dU2xm0khq4i5zvNtncSDfP1GWa+ZBZlL4dblQHowQGK9vDIpFZUVONXKHafjaNwUSCffGkpqqP0vDxB8oUX+7v+IYJPDnFWjzWyUiA5qU4AlMcGoBlwRVTPX3LgsNEls3Qd+49YNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789427200; c=relaxed/simple;
	bh=9dZQQjT7gBrV6do+mPpxHHa5isEc/REybxz6A65z0pw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CLv8PF9mpfEGdySSaS7qsbWzQld16j+qVhLiy0rc4GQWVl24mg9zHgnLIfZS6derbnI0wrZri0ohTh7OJpvMFJhxEsOphZk5YkqIsUSN7ZVA7OV1wrFRa0lmI5OdxSsFON4FLcgam0pMwNpmUxkuei0yqkCNO/IehdsGhg0mRoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gRWJlqBI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gRWJlqBI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06F1F1F00893;
	Mon, 14 Sep 2026 23:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789427199;
	bh=eeXxgEIrBCXYrCQ+wb46Uh/LU1ka3wm7l/PqpmW5DRA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gRWJlqBIC5DI3AtdhCX7UY8mr1bjWqzGYdVu/PTqYh5gjytzHpPQSIiDS2zRPYzqU
	 h7SHdIS+fWEpSK9asVbnNAg50M2mti3IEbQvFjK/yV1x6aJ5tVdLOkokYSr46ld7Ym
	 ncG8JIX6nOD6tk1fCFbz7mlHwMp4+O/VH6HGsZN8+5lZ0vEno1b5uVwkSu2hBXkDTa
	 7XvG/4Z7v+4XVse7kTPZvXjzjdBoQA8h7wS7/u5HDR8sqxjrvQJ3Q0gX6jCCXnq8b4
	 nJiHTnzLtNcSWQv/2pvcTJuxL/YnBBBs1Wr+7mgY4pi/5gfBR7141DwRNsTweln20B
	 Vzf8iYTW0vCJQ==
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
Subject: [PATCH v3 32/58] objtool/klp: Add test for EXPORT_SYMBOL_FOR_MODULES references
Date: Mon, 14 Sep 2026 16:03:29 -0700
Message-ID: <20260914230355.3422996-33-song@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914230355.3422996-1-song@kernel.org>
References: <20260914230355.3422996-1-song@kernel.org>
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

