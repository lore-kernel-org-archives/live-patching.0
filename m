Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85ECE351C0B
	for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 06:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789367337; cv=none; b=jgEeOmd6YTEeis1aZAyLmYdu13Pa5+EQBmA/DsPrzJ6tSWXVi/FHUDsCc068ndJ/dtGVnqEwWsU2xdU660+zl+7ye/Yp2ve/gpWWsygDtelV4p+CVvrMXt88PapxEVxIL5s1PYefzU6i2xP2LNzmO7WCo53bQs7dzygYNu0ylM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789367337; c=relaxed/simple;
	bh=EoxCx+4VJJ1wvZurOZyRLu9Wua64YI2Ei+chMHKiOYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lG5MeANT/MmlmxGwwUCCQyYZIHs904MsagDhOceKyvw9pVmL/v5UZZCSzVbBydfXBkg7Ui9zzlZtzjctwqN9Vwh31zF2DtPJ+z3YxjgnyFPbX7rapHXgkJSoFLlqppVinxMqS5/2C+jetMaS42lNbOPazf64xlaVM/nbwM+OxqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hlopgkLx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hlopgkLx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 343C11F000FF;
	Mon, 14 Sep 2026 06:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789367336;
	bh=wVawEWbnaQ/wDIfjJkNL/zxJxmYU+NPYykFOR1tSOQs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hlopgkLxOytGSjkyX8vdIO1U3Y7srx1uMPfTanpUphpB2RHbuXZuyABRzEbgd7kM7
	 xIRUU/Av5M03KgV25Mnbqh8Cj0KO5ioRxrbgUPJDCSHzq6qbFERnU1M6VWCoM+kvXN
	 OUAXxqaD2mPfBLT3BzCv7D+aqLbA81CzhtXVlJBAasM+rJb1fAgzu7H4sE1N3qyQ0B
	 DNzk5buDj6GzDNtKQYWLxJgiengY55wIXyZFTp513vFeKcJ4CNXfF68eaq+FtLSNDY
	 QrlfDdlVKo/IBoqBco5npHDOpyUws4vfmjBUTh6mzugfMSLYZzK9x4zYmmlNCHhDzu
	 mWShsQidsYIaA==
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
Subject: [PATCH v2 39/58] objtool/klp: Add test for static locals which must not be correlated
Date: Sun, 13 Sep 2026 23:24:55 -0700
Message-ID: <20260914062514.926997-40-song@kernel.org>
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
 .../generic/test-static-local-uncorrelated.sh | 40 ++++++++++++++++++
 2 files changed, 81 insertions(+)
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
index 000000000000..fa4ce88a79b1
--- /dev/null
+++ b/tools/objtool/tests/generic/test-static-local-uncorrelated.sh
@@ -0,0 +1,40 @@
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
+out_sections | grep -qE '\.(bss|data)[^ ]*__key' ||
+	fail "__key was neither correlated nor cloned"
+
+out_symbols | grep -q '\.klp\.sym\..*once_flag' &&
+	fail ".data..once variable was correlated; it must use a fresh copy"
+assert_section '.data..once'
+
+pass "per-instance static locals cloned, ordinary ones correlated"
-- 
2.53.0-Meta

