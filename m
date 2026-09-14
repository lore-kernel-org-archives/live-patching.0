Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9BC377A85
	for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 23:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789427257; cv=none; b=RM28kebRLpdcuGTQLXafoi5/nro48p9D9S+VYcSJkLh/ve2d80Mu0jbahQKOB78kvKLW+/g8K4VIr3WpeyWg77k5zp1LeCcaZdebalFQfr0VXeNfPiz93cZreye7BdVHSZ7JnuSDyUJaa2InRktiyT5akbKKEe7nE+ADhRYIQhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789427257; c=relaxed/simple;
	bh=cQIZoefZUwWp6fbnmTG30qZXnyGqIT3SUmsLOqO/kPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cz83JCP126HDrPvXiv5OdcWxRTeZm7bfPnnOHHWBtjdv5tJZbzgQSZ1p+Ttyh4iNpHfhOjtu2XigPNIi89k1HxsJNz8EVBeXIzbwSQ/K3G+LSGRFQZ4J701GAirXqfi1LIYiFTat9aeeOY2VauL/sQ0ZjoL41ZTgB05u/UGR7rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H/lNg5dz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H/lNg5dz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A84441F000FF;
	Mon, 14 Sep 2026 23:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789427256;
	bh=X4yJwjv6WugfmPSFXiMLXGUKtrL2pviNt6swm83doX8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H/lNg5dz8dIbjaScoJQkl27mgXfobXtesJ0OMXZOQN9ZmsBSpjIKLOqgIGvisD6fz
	 jn1FVLs96bPw0YIdBoK6IJ2Pv2A7nqZ+2cCERrPsP8Zi9+2ubmvMelYFUMbvT5k1uc
	 BniBUj9uQci8f874T12zFwQCj8rjvtYPVI9UDwF8xRhKlC/9CGFqhXLh8smAhPKh9n
	 kz9iRUAnN+wqXAltHAwCJ5GlqVyMMBxAW2rCAff4dsNZqJgq9trFRAEkVC1LZsM4bz
	 Uin91W44Qq5lSqaiyep6uylhUAQ8aQPXATJqrRkUj2fogOzqwKMwUf1WdysPIRMXit
	 wbQ4TLpWeReKw==
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
Subject: [PATCH v3 44/58] objtool/klp: Test a hand-built livepatch module's static call keys
Date: Mon, 14 Sep 2026 16:03:41 -0700
Message-ID: <20260914230355.3422996-45-song@kernel.org>
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

__SCK__* static call keys are not exported; modules are given read-only
access at load time.  Livepatch modules built by klp-build do have full
access to theirs, and commit 164c9201e1da ("objtool: Add base objtool
support for livepatch modules") added a check on that basis -- but a
livepatch module can also be written by hand, as everything under
samples/livepatch is, and such a module hits an unexported key as soon as
it does anything expanding to a static call.  With
CONFIG_MEM_ALLOC_PROFILING_DEBUG that includes allocating memory, which is
how livepatch-shadow-fix1 came to fail to build.

Cover it, with the plain module as a control: it takes the same path and
has always been accepted, so a test that built only the livepatch variant
could not tell this fix from the check being deleted.

This is objtool's ordinary check pass rather than a klp subcommand, which
is the first test here to exercise it -- and is the point, since that pass
is what runs over a hand-built livepatch module during a normal kernel
build.

Verified by reverting commit f495054bd12e ("objtool/klp: Fix unexported
static call key access for manually built livepatch modules"): objtool
reports "can't find static_call_key symbol: __SCK__klp_test_call" and the
test fails, under both gcc and clang.

Assisted-by: Claude:claude-opus-4
Based-on-test-by: Joe Lawrence <joe.lawrence@redhat.com>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 .../tests/x86/fixtures/static_call_no_key.c   | 32 +++++++++++++++
 .../tests/x86/test-manual-klp-static-call.sh  | 40 +++++++++++++++++++
 2 files changed, 72 insertions(+)
 create mode 100644 tools/objtool/tests/x86/fixtures/static_call_no_key.c
 create mode 100755 tools/objtool/tests/x86/test-manual-klp-static-call.sh

diff --git a/tools/objtool/tests/x86/fixtures/static_call_no_key.c b/tools/objtool/tests/x86/fixtures/static_call_no_key.c
new file mode 100644
index 000000000000..748ba7c0f86d
--- /dev/null
+++ b/tools/objtool/tests/x86/fixtures/static_call_no_key.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * A static call to a trampoline whose key symbol this object cannot see.
+ *
+ * That is the normal situation for a module: __SCK__* keys are not exported,
+ * and read-only access is granted at load time instead.  objtool's static call
+ * handling has to accept it for any module, including a livepatch module built
+ * by hand rather than by klp-build.
+ *
+ * LIVEPATCH adds the .modinfo tag which makes objtool treat this as a
+ * livepatch module.
+ */
+
+static const char __modinfo[]
+	__attribute__((section(".modinfo"), used, aligned(1))) =
+#ifdef LIVEPATCH
+	"\0livepatch=Y"
+#endif
+	"\0name=klp_testmod";
+
+/*
+ * The trampoline is undefined here, exactly as it is for a module calling a
+ * static call defined in vmlinux.  No __SCK__klp_test_call accompanies it.
+ */
+extern void __SCT__klp_test_call(void);
+
+int target(int x)
+{
+	__asm__ volatile("call __SCT__klp_test_call\n\t" ::: "memory");
+
+	return x + 1;
+}
diff --git a/tools/objtool/tests/x86/test-manual-klp-static-call.sh b/tools/objtool/tests/x86/test-manual-klp-static-call.sh
new file mode 100755
index 000000000000..6c4d275e3549
--- /dev/null
+++ b/tools/objtool/tests/x86/test-manual-klp-static-call.sh
@@ -0,0 +1,40 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# objtool's static call handling must accept a livepatch module which cannot
+# see a static call's key symbol.
+#
+# __SCK__* keys are not exported; modules get read-only access at load time
+# instead.  Livepatch modules built by klp-build do have full access to their
+# keys, and a check was added on the strength of that -- but a livepatch module
+# can also be written by hand, and samples/livepatch is full of them.  One of
+# those needs a key it cannot see as soon as it does anything that expands to a
+# static call, which with CONFIG_MEM_ALLOC_PROFILING_DEBUG includes allocating
+# memory:
+#
+#   samples/livepatch/livepatch-shadow-fix1.o: error: objtool: static_call:
+#     can't find static_call_key symbol: __SCK__WARN_trap
+#
+# The module built without the livepatch tag is the control: it takes the same
+# path and has always been accepted, so a test which only built the livepatch
+# one could not tell this fix from the check being removed altogether.
+#
+# Fixed by f495054bd12e ("objtool/klp: Fix unexported static call key access
+# for manually built livepatch modules").
+
+. "$(dirname "$0")/../lib.sh"
+
+setup
+
+# Not a klp subcommand: this is objtool's ordinary check pass, which is what
+# runs over a hand-built livepatch module during a normal kernel build.
+for tag in "" -DLIVEPATCH; do
+	build_one static_call_no_key.c mod.o $tag
+
+	"$OBJTOOL" --module --static-call "$workdir/mod.o" \
+		> "$workdir/objtool.log" 2>&1 ||
+		fail "objtool rejected a ${tag:+livepatch }module which cannot" \
+		     "see its static call key: $(tail -1 "$workdir/objtool.log")"
+done
+
+pass "livepatch module accepted without access to its static call key"
-- 
2.53.0-Meta

