Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123F749A3DB
	for <live-patching@vger.kernel.org>; Wed, 16 Sep 2026 18:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789584429; cv=none; b=ZGQNULtURttQ7gpX5VJAtGxblpwRpLNihsbyEmCCh/Evj/6uM7oTqFkihaqI2ll1YKYaNf33r4QeTwWghJVjAtv6W396zHGHppb/E6pLdifmvm2LMYw7rHuP6fV+B+Zd+fo0e7blWzbramRKMEuJz3GcBimmOG/fWFf2beQEbiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789584429; c=relaxed/simple;
	bh=4almhLireq5xK1slPrTn2+1zpi8F9pT5YA4BY4mO5zM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MHCATCyG+gnTCyUfriN1kgt6x6ySKZnDlIQ9Kt9s9H5EAFCuwcOwtAkGDpAHz4n09UMGvsPchS+dgv4cLFQ2tes9eQov/zJieDXYJatHoFZ0g28bdVJoZVFtXxxPSdZKLu8XcBHOO/KG9BIPVJUAf4YYL//n4UJTx+l1ywiIQH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dqJPTcHU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dqJPTcHU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76A451F0089E;
	Wed, 16 Sep 2026 18:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789584425;
	bh=jWPO/EvkcH6XbdrysddoNx4BqpGuh5uL2hWcxwNXvCI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dqJPTcHUpjdZb+H+U4utgrRqUnDp5YRC41jXgFfF/OEpqqHQj2kRqyivJVD0y28mA
	 efaF7WPBIZ6dg0xFCBYG610ZK3BoOCgqMm6yaErqpdyLoHIHU9vbrjdxtwOZ9I93L2
	 9sUeKwJ7nrVxvEjHKG6MAYdgr0u/YTxCmM/D6l+Njn14DkMUzue7Bs1dQJ19hV+1Ps
	 so3axpFMbF5j+mlnUMLevT6gaPc1e2m+4eFS5HXbnHYkWZaUTrusIaxcybvqLyiLW1
	 Ew6upR9cfNciUpLWFaCLSMVqx2gnqU+mHEksmGeURRMfzWoet8sQBszizq5AXUuOdG
	 ZVSJvUkSHN/lw==
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
Subject: [PATCH v5 39/58] objtool/klp: Add test for static locals which must not be correlated
Date: Wed, 16 Sep 2026 11:43:32 -0700
Message-ID: <20260916184351.2720310-40-song@kernel.org>
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

Most static locals have to be correlated so the patched code keeps using
the running kernel's copy.  Two kinds must not: anything in .data..once,
the flag behind WARN_ONCE and friends, and the well-known names the kernel
generates for per-instance things (__warned, __key, __func__).

Sharing a .data..once flag means a patch inherits "already warned" from
before it was applied, and the warning it was meant to surface never fires.

The fixture deliberately does not name its .data..once variable __warned:
the name rule would then catch it and the section rule would go untested.
gcc spells these <var>.<id> and Clang <func>.<var>, so both are covered.

This tests the behavior of commit ff529864e738 ("objtool/klp: Fix
.data..once static local non-correlation") and commit 84c304a534b8
("objtool/klp: Fix is_uncorrelated_static_local() for Clang").

Assisted-by: Claude:claude-opus-4
Based-on-test-by: Joe Lawrence <joe.lawrence@redhat.com>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 .../fixtures/static_local_uncorrelated.c      | 41 +++++++++++++++++++
 .../generic/test-static-local-uncorrelated.sh | 41 +++++++++++++++++++
 2 files changed, 82 insertions(+)
 create mode 100644 tools/objtool/tests/generic/fixtures/static_local_uncorrelated.c
 create mode 100755 tools/objtool/tests/generic/test-static-local-uncorrelated.sh

diff --git a/tools/objtool/tests/generic/fixtures/static_local_uncorrelated.c b/tools/objtool/tests/generic/fixtures/static_local_uncorrelated.c
new file mode 100644
index 000000000000..cb4cdd7a496e
--- /dev/null
+++ b/tools/objtool/tests/generic/fixtures/static_local_uncorrelated.c
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Static locals of three kinds, in one patched function.
+ *
+ * Most static locals must be correlated, so the patched code keeps using the
+ * running kernel's copy.  Two kinds must not:
+ *
+ *   - anything in .data..once, the flag behind WARN_ONCE and friends.  Sharing
+ *     it would mean a patch inherits "already warned" from before the patch.
+ *   - the well-known names the kernel generates for such things (__warned,
+ *     __key, __func__, ...), which are per-instance by nature.  gcc names them
+ *     <var>.<id> and Clang <func>.<var>, so both spellings have to be caught.
+ */
+
+static const char __modinfo[]
+	__attribute__((section(".modinfo"), used, aligned(1))) = "\0name=vmlinux";
+
+int target(int x)
+{
+	/*
+	 * A .data..once variable whose name is *not* on the list below, so
+	 * only the section can disqualify it.  Naming it __warned would let
+	 * the name rule catch it and the section rule go untested.
+	 */
+	static int once_flag __attribute__((section(".data..once")));
+	/* a never-correlate name, in an ordinary section */
+	static int __key;
+	/* and one that must be correlated */
+	static int ordinary;
+
+	if (!once_flag)
+		once_flag = 1;
+	__key += x;
+	ordinary += x;
+
+#ifdef PATCHED
+	return __key + ordinary + once_flag + 2;
+#else
+	return __key + ordinary + once_flag + 1;
+#endif
+}
diff --git a/tools/objtool/tests/generic/test-static-local-uncorrelated.sh b/tools/objtool/tests/generic/test-static-local-uncorrelated.sh
new file mode 100755
index 000000000000..d7711587d2d4
--- /dev/null
+++ b/tools/objtool/tests/generic/test-static-local-uncorrelated.sh
@@ -0,0 +1,41 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Some static locals must not be correlated with their counterparts in the
+# running kernel; the patched code has to use a fresh copy instead.
+#
+# .data..once holds the "have we warned yet" flags behind WARN_ONCE.  Correlate
+# one and the patched function inherits the flag from before the patch, so the
+# warning the patch was written to produce never fires.  The same goes for the
+# names the kernel generates for per-instance state -- __warned, __key,
+# __func__ and friends.
+#
+# Both directions matter, so an ordinary static local is here too: a rule that
+# refuses to correlate anything would pass a test that only checks the
+# refusals.
+
+. "$(dirname "$0")/../lib.sh"
+
+setup
+build_pair static_local_uncorrelated.c
+run_diff
+
+# Compilers mangle static locals differently -- gcc gives __key.1, Clang
+# target.__key -- so match on the base name.
+
+# Correlated: referenced through a klp symbol, pointing at the kernel's copy.
+out_symbols | grep -q '\.klp\.sym\..*ordinary' ||
+	fail "ordinary static local was not correlated"
+
+# Not correlated: no klp symbol, and a copy cloned into the patch instead.
+out_symbols | grep -q '\.klp\.sym\..*__key' &&
+	fail "__key was correlated; it must use a fresh copy"
+# .sbss/.sdata on the architectures with a small-data area.
+out_sections | grep -qE '\.s?(bss|data)[^ ]*__key' ||
+	fail "__key was neither correlated nor cloned"
+
+out_symbols | grep -q '\.klp\.sym\..*once_flag' &&
+	fail ".data..once variable was correlated; it must use a fresh copy"
+assert_section '.data..once'
+
+pass "per-instance static locals cloned, ordinary ones correlated"
-- 
2.53.0-Meta

