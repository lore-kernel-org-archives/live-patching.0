Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F163DF019
	for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 06:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789367301; cv=none; b=jLNsZtwoWBftuswW2u3U4DgudTjeUP4wRZ+xwKgCBHk+q94uL35IBNWE6pcwNCfLjDjLf3debXKlGVMD6j/ZbNj3FV7P1syQ9c1U1JrtaAP9IfMI20iD6bACsNRCCiYto6eGnlFcKny1GrXijyRSRZygdCQ3XYOlSp+AcU8zIIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789367301; c=relaxed/simple;
	bh=ZJlNYE78YUyYBA81neyi6PybAvQlPxTktlC1H50zVjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OsI/zkWdmgHR5K/6LCkLEfYiE61QcNGFzrm8JvzUR31zx4KIrCcXuPkx0mLWiRudIsC3H1Z4jrRRM5/oVO8Lq2Bzn/Q9fvs+2DiwzOyq5dt3Xjd8r6mAz0yBP1WkaOz7OSY8l3V2oarJnJ8BDl7A/dfJzU8fdjHcU2ma+GzuQXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MLwgDjli; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MLwgDjli"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8081E1F000FF;
	Mon, 14 Sep 2026 06:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789367299;
	bh=T4r5Q2Uw0iqH/ZNLT9WH141ADhPLNf3WWVgjdSucyS8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MLwgDjliniN73mNQwZK1bDR+QuTi5zjhkx3SJISIDVVgs85sDc9ZJkc2yuPPDcdwY
	 UGvNjNPFA1BZK2Z3iaFIDhJI+GcOgFBaz4bVlPjSoj1EJSXbDGOMPoJQ//w9zJen0m
	 bT/p7GKAKoKtFA1aaQKiV5FE0D3D7FAoXqUrrTpsPckcm9v1eDAIZQxLmf5qeYXDg5
	 yvI+HH8A15LWH2xaPSLMMlSeWcaUuTOf4gN7kGwERSVDbXJtqcZYv/S5AmEX9oCwug
	 ua2fLEpz9OUtD3ZnUroF96McPW3Ob41HWaIYAEnOmuk0zC7FuQuZJcf1clBKruj9jm
	 sGFG3GzJGa/8Q==
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
Subject: [PATCH v2 32/58] objtool/klp: Add test for EXPORT_SYMBOL_FOR_MODULES references
Date: Sun, 13 Sep 2026 23:24:48 -0700
Message-ID: <20260914062514.926997-33-song@kernel.org>
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

