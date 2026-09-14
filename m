Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FB23AB27B
	for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 23:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789427150; cv=none; b=bvTMm3frynj02Qdj4WePINB8wAz/CrgJjRxE2eg1Tsqc9M8fHKf+W3iDxLWZv0ATeGuJnkOlXBMxkND/FqY+M/MnZgGfYOaoYrWcBzc1T61W4/d8IWqnc6IVcbhfM4LumYSE9wgZcimqLQBd3bVeEKuW7O1nyjaDdtpr4jQdTpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789427150; c=relaxed/simple;
	bh=Hpc8eV9YUuJjcfTtf/++IRXFmsn3zz3LHYhT9H2rXV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eJX93xwHwS+q/ZbcPquCUrWm5x+emUZpAVVbKEhi1EYRCClC46vfFQHE+/IgbiT9r1/CO0savzNqkpkDhC7Qd/+GYjNqimDMbuIhUXOiq6AkvG3iEtSjNzpMdekk//DIA6BlEquhj3iRHqxbdGHCP7uFw1DFI4Af7QC/Ysod2Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aXwm6jMg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aXwm6jMg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E64491F00893;
	Mon, 14 Sep 2026 23:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789427148;
	bh=hA0hZsrt0/jr18TQlcGZGo0x/XtImYu+Pw3jl/+a/3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aXwm6jMgKhQz8aM4lXZk20j1GCWfCIfH3qX9cgkLsSUlUyx2FwCYKSsRU6eRmmJQI
	 hvYRUgPSfCRUCj3S9/24j7T/WBKg7U2O53d/0DYc8VZ6d5Ex22e3DV/yZ26PaLruf+
	 2R3zWL/1p9VjcAPgP1lcLVatL1RPGPZdu+AI7Q41NUb4DbHj3eMFsvJOzpHXP06d1h
	 4HirLJpGXnYflpDUFo6FtNt462h6xJZCZ0kmO7CLSIdJnnPp/Og/L/iWgahDYfxhad
	 L3N4pznVcXAtv9JLDZMa/JW7QOAEWzYIiSZeF28NFmp4K7W6wxWmR0iJlUVVVpFKCv
	 1ztIbiK/YTYxA==
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
Subject: [PATCH v3 22/58] objtool/klp: Add test for symids in discarded sections
Date: Mon, 14 Sep 2026 16:03:19 -0700
Message-ID: <20260914230355.3422996-23-song@kernel.org>
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

From: Puranjay Mohan <puranjay@kernel.org>

.klp.symid records duplicate-named locals so klp diff can work out their
sympos.  Symbols in sections the vmlinux link throws away have to be left
out, or the table references symbols which no longer exist and the link
fails:

  `__exitcall_foo' referenced in section `.klp.symid' of vmlinux.o:
      defined in discarded section `.exitcall.exit' of vmlinux.o

Two translation units are compiled from one fixture and partially linked so
the result has duplicate locals, which symid_needed() requires.  One
duplicate is in a live section and one in .exitcall.exit.

Checking the live duplicate as well keeps the test honest: it would
otherwise pass just as happily if symid generation stopped working
entirely.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 .../tests/generic/fixtures/symid_discarded.c  | 25 +++++++++++
 .../tests/generic/test-symid-discarded.sh     | 44 +++++++++++++++++++
 2 files changed, 69 insertions(+)
 create mode 100644 tools/objtool/tests/generic/fixtures/symid_discarded.c
 create mode 100755 tools/objtool/tests/generic/test-symid-discarded.sh

diff --git a/tools/objtool/tests/generic/fixtures/symid_discarded.c b/tools/objtool/tests/generic/fixtures/symid_discarded.c
new file mode 100644
index 000000000000..573cc2d4474b
--- /dev/null
+++ b/tools/objtool/tests/generic/fixtures/symid_discarded.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Compiled twice and partially linked so the result has duplicate locals,
+ * which is what symid_needed() requires.  dup_normal is in a live section,
+ * dup_discarded in one the vmlinux link throws away.  DISCARDED_SEC selects
+ * which discarded section, since there is more than one and each was its own
+ * bug.
+ */
+
+#ifndef DISCARDED_SEC
+#define DISCARDED_SEC ".exitcall.exit"
+#endif
+
+static const char __modinfo[]
+	__attribute__((section(".modinfo"), used, aligned(1))) = "\0name=vmlinux";
+
+static int dup_normal = 1;
+
+static void *dup_discarded
+	__attribute__((section(DISCARDED_SEC), used)) = &dup_normal;
+
+int FUNC_NAME(void)
+{
+	return dup_normal + (dup_discarded != (void *)0);
+}
diff --git a/tools/objtool/tests/generic/test-symid-discarded.sh b/tools/objtool/tests/generic/test-symid-discarded.sh
new file mode 100755
index 000000000000..388a24984ec0
--- /dev/null
+++ b/tools/objtool/tests/generic/test-symid-discarded.sh
@@ -0,0 +1,44 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# .klp.symid must not reference symbols in sections the vmlinux link discards.
+# Each such section has been its own bug, found only when someone built a
+# config where a duplicate happened to land there, so cover the whole list
+# rather than whichever one was reported last.
+
+. "$(dirname "$0")/../lib.sh"
+
+setup
+
+# Allocated sections which vmlinux.lds.h discards unconditionally.  A symid
+# referencing one of these fails the vmlinux link outright:
+#
+#   `__exitcall_hid_exit' referenced in section `.klp.symid' of vmlinux.o:
+#   defined in discarded section `.exitcall.exit' of vmlinux.o
+for sec in .exitcall.exit .no_trim_symbol; do
+	build_one symid_discarded.c a.o \
+		-DFUNC_NAME=use_a -DDISCARDED_SEC="\"$sec\""
+	build_one symid_discarded.c b.o \
+		-DFUNC_NAME=use_b -DDISCARDED_SEC="\"$sec\""
+
+	# --klp-symids only runs on a file named vmlinux.o
+	rm -f "$workdir/vmlinux.o"
+	partial_link "$workdir/vmlinux.o" "$workdir/a.o" "$workdir/b.o" ||
+		probe_skip "partial link unavailable"
+
+	"$OBJTOOL" --klp-symids --link "$workdir/vmlinux.o" ||
+		fail "objtool --klp-symids failed"
+
+	symids="$(in_relocs vmlinux.o |
+		  awk '/rela.klp.symid/,/^$/')"
+
+	# Without this the test would also pass if symid generation stopped
+	# entirely.
+	echo "$symids" | grep -q 'dup_normal' ||
+		fail "$sec: no symid for the duplicate in a live section"
+
+	echo "$symids" | grep -q 'dup_discarded' &&
+		fail "symid emitted for a symbol in discarded section $sec"
+done
+
+pass "no symids for symbols in discarded sections"
-- 
2.53.0-Meta

