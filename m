Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CEC416865
	for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 23:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789427229; cv=none; b=u2QVq1r8PQVSHlb3jxwnxUmLQc686AAEaXzkhc4X0/un9NlQ41+yNCQe/m5qKwjovICgLjKF8gdLALYO15I2cwEUlq1Ub14e1WGn8mF/r0+GGGFQykpyPiFy/oVFrfy4opKdy/hKwmhpd5BXbZ6IsbNm7Fe9WX1nsVV2ZEJ+X+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789427229; c=relaxed/simple;
	bh=9VkOOa/dxFloPprvA5NLKRjti9MhXwAO7Ym7ZjypavQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=astz9u02b6SUf6Kx8RjYIDWh1zCJ564o1aWfAaTS26HyTr3eCFmq6Q2DRWoxB1IxQQOUIiv4AtaEmjObvDYxmojLy4gmXIVy1KmP2dnb49Wgw1lLqVrMCz2e7P/vdbRBS+lqT7ecOIbR841y1pjccJVmlDZL5h3fFDC/6nqvZME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ica1vAZF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ica1vAZF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00F8D1F000FF;
	Mon, 14 Sep 2026 23:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789427227;
	bh=TytgfA9jV9W804/xZyHJkzNMViFROkvOB+CPuLqpfww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ica1vAZFDSO0upgfDe5bDqqrZmcKQ0glOkQoCD62a3/PzviK/H47tLWYrtkW3zlOy
	 rEgewcI9jnx9XT7oj8TuTdATI2MncT5WgG4ePuOmUm1FW4B2WyZx12qF609mW+fNwR
	 yOOZcBFFPtaB18IBo21LwpP/897K2pffwy7g7zougwx3Vr2vne2lmJ18HKaClJLTpv
	 0cY23ok6n19vjeKSaFRh8/3Daf3aeFajrODr4344AN2t3RxUUBZe2PwP84R+S5vMDL
	 MSK/ClfdJJ8i3EBlW6JW9WCaNiYNSUGLOVoCIEyezlweRMUgptADVd4VjwWDVMS/cu
	 s2xMxa7TMp/TA==
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
Subject: [PATCH v3 38/58] objtool/klp: Add test for sympos resolved against a linked vmlinux
Date: Mon, 14 Sep 2026 16:03:35 -0700
Message-ID: <20260914230355.3422996-39-song@kernel.org>
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

vmlinux is not like a module: the final link reorders sub-sections, so a
symbol's position has to come from the linked image rather than from symbol
table order.  klp diff bridges that with .klp.symid, and looks for it only
when the object it was handed is called vmlinux.o with a vmlinux beside it.

This was assigned to an end-to-end test on the assumption that it needs a
real kernel build.  It needs "ld -r" and "ld -e 0", and takes a fraction of
a second.

The fixture places the static appearing first in the symbol table at the
higher address, and the link passes --sort-section=name to force the
reordering the kernel's linker script performs.  Without that the two ways
of computing sympos agree, and a first version passed with the vmlinux path
disabled.

Assisted-by: Claude:claude-opus-4
Based-on-test-by: Joe Lawrence <joe.lawrence@redhat.com>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 .../tests/generic/fixtures/sympos_vmlinux.c   | 40 +++++++++++++
 .../tests/generic/test-sympos-vmlinux.sh      | 57 +++++++++++++++++++
 2 files changed, 97 insertions(+)
 create mode 100644 tools/objtool/tests/generic/fixtures/sympos_vmlinux.c
 create mode 100755 tools/objtool/tests/generic/test-sympos-vmlinux.sh

diff --git a/tools/objtool/tests/generic/fixtures/sympos_vmlinux.c b/tools/objtool/tests/generic/fixtures/sympos_vmlinux.c
new file mode 100644
index 000000000000..d5e70994c582
--- /dev/null
+++ b/tools/objtool/tests/generic/fixtures/sympos_vmlinux.c
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Two translation units with a same-named static, placed so that the linker
+ * puts them in the opposite order to the one they appear in the symbol table.
+ *
+ * VARSEC selects the section the static lands in.  Linking with
+ * --sort-section=name then orders them alphabetically rather than by object
+ * order, so the first symbol in the symbol table ends up at the *higher*
+ * address.  That is the whole point: counting symbol table order and reading
+ * the linked image's addresses now give different answers, which is what makes
+ * it possible to tell which one klp diff used.
+ *
+ * Only use_a is patched, so exactly one sympos is emitted and there is nothing
+ * to attribute.
+ */
+
+#ifndef FUNC_NAME
+#define FUNC_NAME use_a
+#endif
+#ifndef VARSEC
+#define VARSEC ".data.mmm"
+#endif
+
+#ifndef NO_MODINFO
+static const char __modinfo[]
+	__attribute__((section(".modinfo"), used, aligned(1))) = "\0name=vmlinux";
+#endif
+
+/* volatile so it survives as an STT_OBJECT rather than being folded away */
+static volatile int dup_counter __attribute__((section(VARSEC))) = 1;
+
+int FUNC_NAME(int x)
+{
+	dup_counter += x;
+#ifdef PATCHED
+	return dup_counter + 1;
+#else
+	return dup_counter;
+#endif
+}
diff --git a/tools/objtool/tests/generic/test-sympos-vmlinux.sh b/tools/objtool/tests/generic/test-sympos-vmlinux.sh
new file mode 100755
index 000000000000..b2b44001446f
--- /dev/null
+++ b/tools/objtool/tests/generic/test-sympos-vmlinux.sh
@@ -0,0 +1,57 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# sympos for vmlinux, which is resolved differently from sympos for a module.
+#
+# A module's .ko preserves symbol table order, so klp diff can count -- that is
+# what test-sympos covers.  vmlinux cannot be counted: the final link reorders
+# sub-sections, so the order in vmlinux.o is not the order the running kernel
+# has.  klp diff bridges that with .klp.symid, a table of { id, address }
+# emitted into vmlinux.o whose addresses the linker resolves, read back out of
+# the linked vmlinux.
+#
+# Getting it wrong points the relocation at a different symbol of the same
+# name.  Nothing fails to build or load; the patched code uses the wrong
+# object.
+#
+# The fixture is arranged so the two answers differ: the static that comes
+# first in the symbol table is placed at the *higher* address, so counting
+# gives 1 and reading the linked image gives 2.  Without that, both paths agree
+# and the test cannot tell them apart.
+
+. "$(dirname "$0")/../lib.sh"
+
+setup
+
+# use_a's static sorts last by section name, use_b's first.  Only use_a is
+# patched, so exactly one sympos comes out.
+build_one sympos_vmlinux.c orig_a.o    -DFUNC_NAME=use_a -DVARSEC='".data.zzz"'
+build_one sympos_vmlinux.c patched_a.o -DFUNC_NAME=use_a -DVARSEC='".data.zzz"' -DPATCHED
+build_one sympos_vmlinux.c b.o         -DFUNC_NAME=use_b -DVARSEC='".data.aaa"' -DNO_MODINFO
+
+make_vmlinux_pair "$workdir/orig_a.o" "$workdir/b.o" \
+	       -- "$workdir/patched_a.o" "$workdir/b.o"
+
+[ "$(count_input_symbols vmlinux.o dup_counter)" = 2 ] ||
+	fail "fixture did not produce two dup_counter symbols"
+has_input_section vmlinux.o .klp.symid ||
+	fail "objtool --klp-symids emitted no .klp.symid table"
+has_input_section vmlinux .klp.symid ||
+	fail ".klp.symid did not survive the link"
+
+# The premise: symbol table order and address order must disagree, or the test
+# proves nothing.
+first_addr="$(in_symbols vmlinux | awk '$8 == "dup_counter" { print $2; exit }')"
+low_addr="$(in_symbols vmlinux | awk '$8 == "dup_counter" { print $2 }' | sort | head -1)"
+[ "$first_addr" != "$low_addr" ] ||
+	probe_skip "linker did not reorder the two statics"
+
+assert_input_symbol dup_counter
+run_diff
+
+# Address order says 2.  Counting symbol table order would say 1.
+assert_klp_sympos dup_counter 2
+out_symbols | grep -q 'dup_counter,1' &&
+	fail "sympos 1 emitted: counted symbol table order instead of reading the linked vmlinux"
+
+pass "vmlinux sympos taken from the linked image, not from symbol table order"
-- 
2.53.0-Meta

