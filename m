Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530654D09F4
	for <live-patching@vger.kernel.org>; Tue, 15 Sep 2026 23:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789515558; cv=none; b=O3ST+QWghQwSDkK9U6qzBWLXe+2j81ZCqsrRGnB22iJA/Ie11Vp3zX3uAVj9hrhel5VtuADf7G529kjPXQ/e6hQ/1ZgKNVfB57qgoT0Lu4xQzG4e+mZFIWB8zQxbyQ0tC3zqQpY4P+hQIsGazmPUH7FWdJLKFyl/1Yc+0D1G6NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789515558; c=relaxed/simple;
	bh=ha2j3D/e6XIkNPOz4ElxWb1u69psoZKFym68nHq0y4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dKivuLFMyumatDC2FB0hGi9dzhRQdz6EGLoms/OX94JhddxCVmF2CrKB7ZtexzKVn0HrbvGAN1HKZrgdJKsodHYyW+xtQKsALUF2KGdt48mi4HBOGRFCDNkPd8KNDrAEM20Od32bpbUUCQ/6jIQrUsjwnQ2JbE/r+IpUvSJUXUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=deBQMHdO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="deBQMHdO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0591F1F000FF;
	Tue, 15 Sep 2026 23:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789515557;
	bh=/HU4aPOVrXte0M4++toz3r7qo41DyjK3t7DMHb2SN5U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=deBQMHdOjm+LzcaKk582bCl1J0cDSpUzCkh3ZbAOK98ga9VkBzpw2EBKwEdY3p27F
	 Xh7QLc/b5e9frtr/LXlWORNgptEG8PMcuTS1rp+12t8dn9aN+0LBLDFWmSHZHZSiYX
	 xeh8awt65UN4pZ+NS4Q6Lnu1v1wXaqm0sURbcKlGnr3NMckVzcA4bcT9qO/6qVHrzE
	 I6QyTL4nRBm7JHuvTeOU9tYDIe77YxMgek2R9m/Cke5DKUbnXHb6LdZZz7vfnixFQO
	 h0zQhZ+RVIPA8l6q6ShntW/ycrNxKjkhQIC1QWeYJqebGW2CjYB9nkGh0t1TuOSQVT
	 bIqdMuDuqY1kw==
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
Subject: [PATCH v4 47/58] objtool/klp: Add test for symbols with no checksum entry of their own
Date: Tue, 15 Sep 2026 16:34:43 -0700
Message-ID: <20260915233454.2405019-48-song@kernel.org>
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

.discard.sym_checksum is an array of { address, checksum } looked up by the
address a relocation points at, so the invariant is one entry per address.
calculate_checksums() skips zero-length symbols, aliases and cold parts to
keep it, and nothing checked that it does.

A duplicate entry is not a build failure.  It makes the lookup ambiguous,
and whichever checksum loses is never consulted again -- so a function
whose code changed can be read as unchanged and dropped from the patch.

The alias skip is verified the usual way: remove it and the test fails.
The other two are not isolated, and the test says so rather than implying
otherwise.  A zero-length symbol is excluded by several of the guards at
once -- its section has no data either -- so removing any one of them
changes nothing observable; the assertion stands as a check on the
behaviour, not on the line that produces it.  The cold-part skip needs a
compiler that splits functions and is not reached here at all.

Which of an aliased pair keeps the entry falls out of symbol table order,
so the test requires exactly one of the two rather than naming a winner --
as written first it named real_function and failed, because gcc kept the
alias.

Assisted-by: Claude:claude-opus-4
Based-on-test-by: Joe Lawrence <joe.lawrence@redhat.com>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 .../tests/generic/fixtures/checksum_skip.c    | 47 +++++++++++
 .../tests/generic/test-checksum-skip.sh       | 81 +++++++++++++++++++
 2 files changed, 128 insertions(+)
 create mode 100644 tools/objtool/tests/generic/fixtures/checksum_skip.c
 create mode 100755 tools/objtool/tests/generic/test-checksum-skip.sh

diff --git a/tools/objtool/tests/generic/fixtures/checksum_skip.c b/tools/objtool/tests/generic/fixtures/checksum_skip.c
new file mode 100644
index 000000000000..973bdc10295d
--- /dev/null
+++ b/tools/objtool/tests/generic/fixtures/checksum_skip.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Symbols calculate_checksums() must not give an entry of their own.
+ *
+ * Three kinds are skipped, for two different reasons:
+ *
+ *   zero-length   there is nothing to hash, and an entry keyed on the
+ *                 symbol's address would collide with whatever really lives
+ *                 there.
+ *   alias         a second name for an address already checksummed.
+ *   cold part     hashed as part of its parent, which func_for_each_insn()
+ *                 walks into, so a separate entry would double-count it.
+ *
+ * An entry per address is the invariant: .discard.sym_checksum is looked up by
+ * the address a relocation points at, so two entries for one address make the
+ * lookup ambiguous and one of the two checksums unreachable.
+ */
+
+static const char __modinfo[]
+	__attribute__((section(".modinfo"), used, aligned(1))) = "\0name=vmlinux";
+
+/* Zero-length: an object symbol of size 0, in a section of its own. */
+extern char empty_marker[];
+__asm__(".pushsection .data.empty_marker,\"aw\",@progbits\n"
+	".globl empty_marker\n"
+	".type empty_marker, @object\n"
+	"empty_marker:\n"
+	".size empty_marker, 0\n"
+	".popsection\n");
+
+int real_function(int x);
+int real_function(int x)
+{
+#ifdef PATCHED
+	return x + 2;
+#else
+	return x + 1;
+#endif
+}
+
+/* Alias: a second name for real_function's address. */
+int alias_function(int x) __attribute__((alias("real_function")));
+
+int target(int x)
+{
+	return real_function(x) + alias_function(x) + (int)(long)empty_marker;
+}
diff --git a/tools/objtool/tests/generic/test-checksum-skip.sh b/tools/objtool/tests/generic/test-checksum-skip.sh
new file mode 100755
index 000000000000..f245535a0f36
--- /dev/null
+++ b/tools/objtool/tests/generic/test-checksum-skip.sh
@@ -0,0 +1,81 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Symbols which must not get a checksum entry of their own.
+#
+# .discard.sym_checksum is an array of { address, checksum } looked up by the
+# address a relocation points at, so the invariant is one entry per address.
+# calculate_checksums() skips three kinds of symbol to keep it:
+#
+#   zero-length   nothing to hash, and its address belongs to whatever really
+#                 lives there
+#   alias         a second name for an address already covered
+#   cold part     hashed into its parent, which func_for_each_insn() walks
+#                 into, so its own entry would double-count
+#
+# A duplicate entry is not a build failure.  It makes the lookup ambiguous, and
+# whichever checksum loses is simply never consulted again -- so a function
+# whose code changed can be read as unchanged and dropped from the patch.
+#
+# Of the three, only the alias skip is isolated here: removing it makes this
+# test fail.  A zero-length symbol is excluded by more than one of the guards
+# at once -- its section has no data either -- so no single change makes that
+# assertion fail, and it stands as a check on the behaviour rather than on the
+# line which produces it.  Nothing here reaches the cold-part skip, which
+# wants a compiler that splits functions; test-cold-function covers that
+# symbol surviving into the patch, not its checksum.
+#
+# Covers the same ground as corpus/x86_64/checksum-zero-len-sym,
+# checksum-alias-skip and checksum-cold-skip in Joe Lawrence's klp-build unit
+# test corpus.
+
+. "$(dirname "$0")/../lib.sh"
+
+setup
+build_pair checksum_skip.c
+
+assert_input_symbol empty_marker
+assert_input_symbol alias_function
+run_checksum
+
+# entries_for <object> [-t]
+#
+# The symbol names .discard.sym_checksum has an entry for, one per line.  With
+# -t, what each entry points at instead: the name and its addend, which is the
+# address the kernel looks the entry up by.  A name alone is not that address,
+# since a relocation against a section symbol names the section and puts the
+# offset in the addend, and several entries can then share a name honestly.
+entries_for()
+{
+	in_relocs "$1" | awk -v target="${2:-}" '/rela\.discard\.sym_checksum/,/^$/ {
+		if ($1 !~ /^[0-9a-f]{8,}/)
+			next
+		if (target == "-t")
+			print $5, $6, $7
+		else
+			print $5
+	}'
+}
+
+entries="$(entries_for orig.o)"
+
+# The control: something real did get an entry, so an empty listing cannot
+# make the rest of this pass by default.
+echo "$entries" | grep -qx target ||
+	fail "no checksum entry for target"
+
+echo "$entries" | grep -qx empty_marker &&
+	fail "zero-length symbol got a checksum entry"
+
+# One of the two names for that address is kept and the other skipped; which
+# one falls out of symbol table order and is not the point.  Two would be.
+n="$(echo "$entries" | grep -cxE 'real_function|alias_function')"
+[ "$n" = 1 ] ||
+	fail "expected 1 checksum entry across real_function and its alias, found $n"
+
+# One entry per address, which is what the skipping is for.
+dupes="$(entries_for orig.o -t | sort | uniq -d)"
+[ -z "$dupes" ] ||
+	fail "two checksum entries for one address: $dupes"
+
+pass "zero-length symbols and aliases get no checksum entry of their own"
-- 
2.53.0-Meta

