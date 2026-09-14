Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEDF3E1204
	for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 06:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789367276; cv=none; b=R7mzIEp/EL49uQ1Dr8/DVNKntsfADaTyGXfT/grEDqDtsYLQGBn2b1PuOMrslLCtpZBEoM6/T//Ve4RswRimYxTYEZJ053190qhE6cgi2QFCIOKc5DfgHBxatZJJJX5JZLwOJJim9nldsSU/aYbCO+qhRK76NgwiAv4uUMQZ9A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789367276; c=relaxed/simple;
	bh=o6UlRJyebFu+i0s006kG3vY0GvfCc/aGDeY0wnWbHk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GrK+9G6dSyDqccuCxHyHVdf5AVxy9ETyGIY758lVnCUAbDIMWaut0vDCOxUlZZY2jCAU/RBKVgYI9qzPoMwzxkexFdnROHCYZRa1e/9FoedEqjanOOSGG33apRBLKFSvHPcZ0nfHk128WH/tF8E0tw9nMiclN/JuI8QwZ7jTJj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hKWzHmq7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hKWzHmq7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 098131F00893;
	Mon, 14 Sep 2026 06:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789367273;
	bh=8elmpGyQ8ilAdmRaFe5Zkryll+bVm9RZGnkETrCUr5Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hKWzHmq7q+AhnCJzygVsJ4PST753D7+ZO1qht3bbzLT4jJ008zNVP2rKqeoT2pQ7+
	 fSrRwICHS6nS4lb3urJ0Qa01wuY2/lcNdLSiHm1VXHemdNPTsojZeHtkp4EJZ9Y0TP
	 xZEEuVNwgabgT+4ca01ar4lKsV8YKzhricNvCL0c9Drpc9W8w4MgVG42X6s66STGiL
	 IOiKpj0GkdCaiH+CoDt3azXRmQyMBxH0bdq+59yxYMHo2/c4AdSwZ6pXpjFulqDFB3
	 TGojBL3fr52NC9lL4O8WlA7KwN3KbwhsYHl5DhV2eli48oS2OEsRcnBQSgamuNNroH
	 ZWBShD8czTgJg==
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
Subject: [PATCH v2 27/58] objtool/klp: Add klp diff and post-link regression tests
Date: Sun, 13 Sep 2026 23:24:43 -0700
Message-ID: <20260914062514.926997-28-song@kernel.org>
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

Five tests covering behaviour the harness could reach but nothing
exercised.  Each was verified to fail against the code it guards, by
reverting the fix or sabotaging the exact line; where a first attempt
passed against broken code, the fixture was wrong and was rebuilt.

  post-link                    first coverage of the subcommand at all
  local-vs-export              local symbols must not match exports
  symvers-parse-error          Module.symvers parse error line numbers
  checksum-debug               the --debug-checksum format klp-build reads
  function-removal             the "no correlation" path

local-vs-export tests the behavior of commit 86a697572c62 ("objtool/klp:
Don't match local symbols against exports"), and symvers-parse-error that
of commit 51c1de134863 ("objtool/klp: Fix line numbers in Module.symvers
parse errors").

Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 .../tests/generic/fixtures/function_removal.c | 25 ++++++++++
 .../tests/generic/test-checksum-debug.sh      | 49 +++++++++++++++++++
 .../tests/generic/test-function-removal.sh    | 34 +++++++++++++
 .../tests/generic/test-local-vs-export.sh     | 32 ++++++++++++
 tools/objtool/tests/generic/test-post-link.sh | 39 +++++++++++++++
 .../tests/generic/test-symvers-parse-error.sh | 23 +++++++++
 6 files changed, 202 insertions(+)
 create mode 100644 tools/objtool/tests/generic/fixtures/function_removal.c
 create mode 100755 tools/objtool/tests/generic/test-checksum-debug.sh
 create mode 100755 tools/objtool/tests/generic/test-function-removal.sh
 create mode 100755 tools/objtool/tests/generic/test-local-vs-export.sh
 create mode 100755 tools/objtool/tests/generic/test-post-link.sh
 create mode 100755 tools/objtool/tests/generic/test-symvers-parse-error.sh

diff --git a/tools/objtool/tests/generic/fixtures/function_removal.c b/tools/objtool/tests/generic/fixtures/function_removal.c
new file mode 100644
index 000000000000..d65ff604c2c5
--- /dev/null
+++ b/tools/objtool/tests/generic/fixtures/function_removal.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * A function the patch deletes, along with its only caller's use of it.  The
+ * original has a symbol which the patched object simply does not, so there is
+ * nothing to correlate it against.
+ */
+
+static const char __modinfo[]
+	__attribute__((section(".modinfo"), used, aligned(1))) = "\0name=vmlinux";
+
+#ifndef PATCHED
+int going_away(int x)
+{
+	return x + 7;
+}
+#endif
+
+int caller(int x)
+{
+#ifdef PATCHED
+	return x + 1;
+#else
+	return going_away(x);
+#endif
+}
diff --git a/tools/objtool/tests/generic/test-checksum-debug.sh b/tools/objtool/tests/generic/test-checksum-debug.sh
new file mode 100755
index 000000000000..78856b191636
--- /dev/null
+++ b/tools/objtool/tests/generic/test-checksum-debug.sh
@@ -0,0 +1,49 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# "klp checksum --debug-checksum" prints a per-instruction checksum stream,
+# and klp-build -f (--show-first-changed) parses it to report where a function
+# first differs between the original and patched builds.
+#
+# It is a debugging aid, so nothing fails when it breaks: klp-build greps the
+# stream, and an unmatched grep just yields no output, which reads as "no
+# instruction changed".  That is exactly how the format drifted out from under
+# it once already.  Pin the shape klp-build depends on:
+#
+#   DEBUG: <object>: checksum: <func>(): <sym>+0x<offset> <16 hex digits>
+#
+# and that --dry-run leaves the object alone, since klp-build runs this against
+# objects it is going to checksum again for real.
+
+. "$(dirname "$0")/../lib.sh"
+
+setup
+build_pair basic.c
+
+before="$(md5sum < "$workdir/orig.o")"
+
+"$OBJTOOL" klp checksum --dry-run --debug-checksum=changed \
+	"$workdir/orig.o" > "$workdir/debug.log" 2>&1 ||
+	fail "klp checksum --debug-checksum failed"
+
+# --dry-run has to mean it: klp-build checksums these objects again afterwards,
+# and "already has .discard.sym_checksum, skipping" would lose the real run.
+[ "$(md5sum < "$workdir/orig.o")" = "$before" ] ||
+	fail "--dry-run modified the object"
+has_input_section orig.o .discard.sym_checksum &&
+	fail "--dry-run created .discard.sym_checksum"
+
+grep -qE '^DEBUG: .*: checksum: changed\(\): [^ ]+\+0x[0-9a-f]+ [0-9a-f]{16}$' \
+	"$workdir/debug.log" ||
+	fail "unexpected --debug-checksum format: $(head -1 "$workdir/debug.log")"
+
+# This is the pattern klp-build greps with.  Keep it working verbatim.
+grep -qE "^DEBUG: .*checksum: changed\(\): " "$workdir/debug.log" ||
+	fail "klp-build's --show-first-changed pattern no longer matches"
+
+# Only the requested function, or klp-build attributes instructions to the
+# wrong one.
+grep -qE 'checksum: untouched\(\)' "$workdir/debug.log" &&
+	fail "--debug-checksum=changed also dumped untouched()"
+
+pass "--debug-checksum format is the one klp-build -f parses"
diff --git a/tools/objtool/tests/generic/test-function-removal.sh b/tools/objtool/tests/generic/test-function-removal.sh
new file mode 100755
index 000000000000..df76e81e3936
--- /dev/null
+++ b/tools/objtool/tests/generic/test-function-removal.sh
@@ -0,0 +1,34 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# A patch which deletes a function leaves a symbol in the original with no
+# counterpart in the patched object.  klp diff cannot correlate it, and must
+# say so and carry on: livepatching cannot remove code from a running kernel,
+# so what matters is that the surviving caller is patched and the deleted
+# function is not dragged into the patch module.
+#
+# Cloning it would be worse than useless -- dead code in the patch, plus
+# whatever it references, resolved against a kernel where it may not exist.
+
+. "$(dirname "$0")/../lib.sh"
+
+setup
+build_pair function_removal.c
+
+# One-sided by construction: present in the original, gone from the patched.
+has_input_symbol orig.o going_away ||
+	fail "fixture has no going_away in the original"
+has_input_symbol patched.o going_away &&
+	fail "fixture still has going_away in the patched object"
+
+run_diff
+
+assert_diff_log 'no correlation: going_away'
+
+# The caller changed, so it is patched ...
+assert_patched caller
+# ... and the deleted function comes along in no form at all.
+assert_not_patched going_away
+assert_no_symbol going_away
+
+pass "deleted function reported as uncorrelated and left out of the patch"
diff --git a/tools/objtool/tests/generic/test-local-vs-export.sh b/tools/objtool/tests/generic/test-local-vs-export.sh
new file mode 100755
index 000000000000..5b91101dadd6
--- /dev/null
+++ b/tools/objtool/tests/generic/test-local-vs-export.sh
@@ -0,0 +1,32 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# find_export() matched on symbol name alone, so a static function or variable
+# sharing a name with an export was mistaken for a reference to that export.
+# For a vmlinux export that means no klp relocation at all: the normal
+# relocation left behind is resolved by the module loader to the vmlinux
+# symbol, and the patched code quietly reads and writes the wrong object.
+#
+# Exports are always global, so a local symbol is never one.
+
+. "$(dirname "$0")/../lib.sh"
+
+setup
+build_pair static_local.c
+
+# The static the fixture uses.  Compilers mangle statics variously -- gcc says
+# counter.0, clang says target.counter -- so find what this one produced rather
+# than assuming a shape.
+local_sym="$(in_symbols orig.o |
+	awk '$4 == "OBJECT" && $5 == "LOCAL" && $8 ~ /counter/ { print $8; exit }')"
+[ -n "$local_sym" ] ||
+	fail "fixture produced no local 'counter' symbol"
+
+# Contrive the collision: something else exports that same name.
+export_syms "$local_sym" counter
+run_diff
+
+# Still treated as the local it is, not as the export.
+assert_klp_sym "$local_sym" vmlinux
+
+pass "local symbol not mistaken for an export of the same name"
diff --git a/tools/objtool/tests/generic/test-post-link.sh b/tools/objtool/tests/generic/test-post-link.sh
new file mode 100755
index 000000000000..39c6cab9db1e
--- /dev/null
+++ b/tools/objtool/tests/generic/test-post-link.sh
@@ -0,0 +1,39 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# klp post-link converts the intermediate __klp_relocs.* sections into the
+# .klp.rela.* form the kernel applies at patch load.  Getting this wrong is
+# invisible at build time: the module links and loads, and the relocations are
+# simply never applied.
+
+. "$(dirname "$0")/../lib.sh"
+
+setup
+build_pair static_local.c
+
+# An unexported symbol is what produces a klp relocation in the first place.
+assert_input_symbol counter
+run_diff
+assert_section __klp_relocs.vmlinux
+
+# Nothing has converted them yet.
+assert_no_section ".klp.rela.vmlinux..text.target"
+
+# The original relocation is neutralised by pointing it at a tombstone, which
+# is what stops the module loader resolving it behind livepatch's back.
+#
+# Compilers mangle a static local differently -- gcc says counter.0, clang
+# target.counter -- so find what this one produced rather than assuming.
+local_sym="$(in_symbols orig.o |
+	     awk '$4 == "OBJECT" && $5 == "LOCAL" && $8 ~ /counter/ { print $8; exit }')"
+[ -n "$local_sym" ] || fail "fixture produced no local 'counter' symbol"
+assert_tombstone "$local_sym"
+
+run_post_link
+
+# One .klp.rela section per base section, carrying SHF_RELA_LIVEPATCH, against
+# a symbol in SHN_LIVEPATCH for the kernel to resolve.
+assert_klp_rela vmlinux .text.target
+assert_livepatch_sym counter
+
+pass "klp relocations converted to .klp.rela with SHN_LIVEPATCH symbols"
diff --git a/tools/objtool/tests/generic/test-symvers-parse-error.sh b/tools/objtool/tests/generic/test-symvers-parse-error.sh
new file mode 100755
index 000000000000..d597f28e5617
--- /dev/null
+++ b/tools/objtool/tests/generic/test-symvers-parse-error.sh
@@ -0,0 +1,23 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# A malformed Module.symvers has to be reported against the line it is on.
+# Module.symvers has tens of thousands of lines and is generated, so a wrong
+# line number sends whoever has to fix it to the wrong place, and "line 1" is
+# wrong in a way that looks plausible.
+
+. "$(dirname "$0")/../lib.sh"
+
+setup
+build_pair basic.c
+
+# Three well-formed lines, then one with no tabs at all.
+export_syms a b c
+echo 'this line has no fields' >> "$workdir/Module.symvers"
+
+run_diff 255
+
+assert_diff_log 'malformed Module.symvers'
+assert_diff_log 'at line 4'
+
+pass "malformed Module.symvers reported against the offending line"
-- 
2.53.0-Meta

