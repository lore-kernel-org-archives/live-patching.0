Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B312A339361
	for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 06:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789367137; cv=none; b=hpeP9J5tTIP3z2kAtlRawidLnbYDEvk7HJDpqwYmrtoC4RLdPN/kYt0kJ9HfzubGtogIpPrM8VfJTd/E9e8Rveq+bbDvZBwY58nlJ6/BKXRKf4XJzRc6c+1s1uABWSN1JidP8KRy/EbkRD3EdokayT5f9VXIqnTjuJGXUaIkupU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789367137; c=relaxed/simple;
	bh=eMgT1i8fVvri0Pp4BldY55aolB5TMpcd2cvfStTdZW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oq5d7CYMUTqS3BXL+0lnDByYA6ttcucnylHbE1mTaQOh8h37arQ5qL+McWdMHkxiPmgxL5ov1mmyy7QFZ4uyLIAV8mdnWAX4U1Ci7pDt5zlFnvKqmQ0Rez4h6uTfntwZc7z0ul8YbcLi0klVDsdV0vk2JhG0YDwEe06WQoI3ooo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JEbYSyTq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JEbYSyTq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 160B81F000FF;
	Mon, 14 Sep 2026 06:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789367135;
	bh=zyOihA3JEylPD0Fgu3MS6ugPwtI2O9Tw4oIAH+5B6Ek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JEbYSyTqR6xfhXaAQ0Dpo2yFBcLnyzp68ZplQKZphAyAfe+le57xEvpULn6t7A00h
	 QKb0tcIw/BrUt/4Uop9vFTgDv6pk6DkDIvJNXbsTqFSoKc1wvNOst3EMOECMZ4W705
	 ZTZyH0PCmDh5es1cd0m9KyB11x8CvAn30BqeiSBXN6MruTQRLnFdUf74lzEQK4a6az
	 h/49rH6MMNWUSnIXu6ej+AgDkFsZORRZ5AxrFxwC6VyXCznXOmuys5JLOQtJUiQ9qP
	 CYKIjx54vuTzwBN3qxRNwvUrO15hWvPb7LV7aqgOVKeFhDzwjD7Scu3UCErwZLWvyf
	 NvRcXAuukW41w==
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
Subject: [PATCH v2 01/58] objtool: Add test harness for the klp subcommands
Date: Sun, 13 Sep 2026 23:24:17 -0700
Message-ID: <20260914062514.926997-2-song@kernel.org>
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

From: Puranjay Mohan <puranjay@kernel.org>

"objtool klp checksum" and "objtool klp diff" work on object files alone,
with no kernel, vmlinux or configuration involved, so they can be tested
directly. That is worth doing: most klp generation bugs so far have been in
symbol correlation, special section extraction and relocation conversion,
and several of them failed silently, producing a livepatch which built
cleanly but was missing data.

A test compiles a fixture twice, as the original and (with -DPATCHED) the
patched object, runs both through klp checksum, diffs them and asserts on
the result.  Fixtures are compiled at test time rather than committed as
binaries: codegen varies between compilers and architectures, and that
variation is where a good number of these bugs come from.

Assertions check properties rather than compare against recorded output.
Golden files would need re-recording for every compiler change and would
report churn instead of regressions.

klp diff resolves symbols against Module.symvers, so the harness writes
one. Whether a symbol is listed there decides between an ordinary
relocation and a klp relocation, which makes it the main knob tests use.

Run with:

  make -C tools/objtool tests

Tests skip when objtool was built without klp support or when a fixture
does not build for the target architecture.  A missing objtool binary fails
instead of skipping, since that means a broken invocation rather than an
environment which cannot run the test.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
Co-developed-by: Joe Lawrence <joe.lawrence@redhat.com>
Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 tools/objtool/Makefile               |   5 +-
 tools/objtool/tests/fixtures/basic.c |  20 +++
 tools/objtool/tests/lib.sh           | 175 +++++++++++++++++++++++++++
 tools/objtool/tests/run-tests.sh     |  20 +++
 tools/objtool/tests/test-basic.sh    |  17 +++
 5 files changed, 236 insertions(+), 1 deletion(-)
 create mode 100644 tools/objtool/tests/fixtures/basic.c
 create mode 100644 tools/objtool/tests/lib.sh
 create mode 100755 tools/objtool/tests/run-tests.sh
 create mode 100755 tools/objtool/tests/test-basic.sh

diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index a4484fd22a96..f4ec9f813a20 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -151,6 +151,9 @@ clean: $(LIBSUBCMD)-clean
 mrproper: clean
 	$(call QUIET_CLEAN, objtool) $(RM) $(OBJTOOL)
 
+tests: $(OBJTOOL)
+	$(Q)OBJTOOL=$(abspath $(OBJTOOL)) $(srctree)/tools/objtool/tests/run-tests.sh
+
 FORCE:
 
-.PHONY: clean mrproper FORCE
+.PHONY: clean mrproper tests FORCE
diff --git a/tools/objtool/tests/fixtures/basic.c b/tools/objtool/tests/fixtures/basic.c
new file mode 100644
index 000000000000..811529e7bfb1
--- /dev/null
+++ b/tools/objtool/tests/fixtures/basic.c
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+/* One changed function and one unchanged function. */
+
+/* klp diff takes the object's module name from .modinfo */
+static const char __modinfo[]
+	__attribute__((section(".modinfo"), used, aligned(1))) = "\0name=vmlinux";
+
+int untouched(int x)
+{
+	return x * 3;
+}
+
+int changed(int x)
+{
+#ifdef PATCHED
+	return x + 2;
+#else
+	return x + 1;
+#endif
+}
diff --git a/tools/objtool/tests/lib.sh b/tools/objtool/tests/lib.sh
new file mode 100644
index 000000000000..714371232fa3
--- /dev/null
+++ b/tools/objtool/tests/lib.sh
@@ -0,0 +1,175 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Helpers for the objtool klp tests.  A test builds a fixture twice, as the
+# original and (with -DPATCHED) the patched object, runs both through
+# "klp checksum" and diffs them, then asserts on the result.
+#
+# Assertions check properties rather than compare against recorded output:
+# codegen varies between compilers and golden files would report churn instead
+# of regressions.
+
+TESTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
+FIXTURES_DIR="$TESTS_DIR/fixtures"
+
+OBJTOOL="${OBJTOOL:-$TESTS_DIR/../objtool}"
+CC="${CC:-gcc}"
+
+# klp-build compiles the kernel this way; klp diff needs per-symbol sections to
+# extract individual functions.
+FIXTURE_CFLAGS="-c -O2 -ffunction-sections -fdata-sections -fno-asynchronous-unwind-tables"
+
+test_name="$(basename "$0" .sh)"
+workdir=
+
+pass() { echo "ok - $test_name${1:+: $1}"; exit 0; }
+fail() { echo "not ok - $test_name: $1" >&2; exit 1; }
+skip() { echo "ok - $test_name # SKIP $1"; exit 0; }
+
+cleanup() { [ -n "$workdir" ] && rm -rf "$workdir"; }
+
+# setup [exported symbol...]
+setup()
+{
+	# A relative $OBJTOOL is relative to the objtool directory, not to the
+	# tests which run from tests/.
+	[ -x "$OBJTOOL" ] || [ ! -x "$TESTS_DIR/../$OBJTOOL" ] ||
+		OBJTOOL="$TESTS_DIR/../$OBJTOOL"
+
+	# Not finding objtool is a broken invocation, not an environment which
+	# cannot run the test.  Skipping here would read as a pass.
+	[ -x "$OBJTOOL" ] || fail "objtool not found at '$OBJTOOL', build it first"
+
+	"$OBJTOOL" klp 2>&1 | grep -q checksum ||
+		skip "objtool built without klp support (needs libxxhash)"
+	command -v "${CC%% *}" >/dev/null || skip "no compiler ($CC)"
+
+	workdir="$(mktemp -d)" || fail "mktemp failed"
+	trap cleanup EXIT
+
+	export_syms "$@"
+}
+
+# export_syms [symbol...]
+#
+# Rewrite Module.symvers so exactly these symbols are exported by vmlinux.
+# Whether a symbol is listed decides between an ordinary relocation and a klp
+# relocation, so tests flip it to cover both.
+export_syms()
+{
+	: > "$workdir/Module.symvers"
+	for sym in "$@"; do
+		printf '0x00000000\t%s\tvmlinux\tEXPORT_SYMBOL\t\n' \
+			"$sym" >> "$workdir/Module.symvers"
+	done
+}
+
+# build_pair <fixture.c> [cflags...]
+build_pair()
+{
+	local fixture="$FIXTURES_DIR/$1"; shift
+
+	[ -f "$fixture" ] || fail "missing fixture $fixture"
+
+	$CC $FIXTURE_CFLAGS "$@" -o "$workdir/orig.o" "$fixture" 2>"$workdir/cc.log" ||
+		skip "fixture does not build here: $(tail -1 "$workdir/cc.log")"
+	$CC $FIXTURE_CFLAGS "$@" -DPATCHED -o "$workdir/patched.o" "$fixture" 2>"$workdir/cc.log" ||
+		skip "fixture does not build here: $(tail -1 "$workdir/cc.log")"
+}
+
+# run_diff [expected exit status]
+run_diff()
+{
+	local expect="${1:-0}" rc=0
+
+	# Checksums live in the objects, so only generate them once even when a
+	# test diffs the same pair again with a different Module.symvers.
+	if [ ! -e "$workdir/.checksummed" ]; then
+		"$OBJTOOL" klp checksum "$workdir/orig.o" ||
+			fail "klp checksum orig.o failed"
+		"$OBJTOOL" klp checksum "$workdir/patched.o" ||
+			fail "klp checksum patched.o failed"
+		touch "$workdir/.checksummed"
+	fi
+
+	# klp diff looks for Module.symvers relative to the working directory.
+	( cd "$workdir" && "$OBJTOOL" klp diff orig.o patched.o out.o ) \
+		> "$workdir/diff.log" 2>&1 || rc=$?
+
+	[ "$rc" = "$expect" ] ||
+		fail "klp diff exited $rc, expected $expect: $(tail -2 "$workdir/diff.log")"
+}
+
+cc_supports()
+{
+	echo 'int f(void) { return 0; }' > "$workdir/flagtest.c"
+	$CC $1 -c "$workdir/flagtest.c" -o "$workdir/flagtest.o" 2>/dev/null
+}
+
+# partial_link <output> <object...>
+#
+# "ld -r" through the compiler driver so the link targets the same
+# architecture as the objects.
+partial_link()
+{
+	local out="$1"; shift
+
+	$CC -r -nostdlib -o "$out" "$@" 2>/dev/null ||
+		$CC -r -nostdlib -fuse-ld=lld -o "$out" "$@" 2>/dev/null
+}
+
+# find_thinlto_toolchain
+#
+# Set $THIN_CC and $THIN_LD to a clang and lld from the same LLVM release.  A
+# mismatched pair fails with "Invalid summary version", which reads like a
+# broken test rather than a broken environment.
+find_thinlto_toolchain()
+{
+	local cc ld ver
+
+	for cc in "${THIN_CC:-}" "$CC" clang; do
+		[ -n "$cc" ] || continue
+		command -v "${cc%% *}" >/dev/null 2>&1 || continue
+
+		ver=$($cc -dumpversion 2>/dev/null | cut -d. -f1)
+
+		for ld in "${THIN_LD:-}" "ld.lld-$ver" ld.lld; do
+			[ -n "$ld" ] || continue
+			command -v "$ld" >/dev/null 2>&1 || continue
+
+			echo 'int probe(void) { return 0; }' > "$workdir/probe.c"
+			$cc -flto=thin -O2 -c "$workdir/probe.c" \
+				-o "$workdir/probe.o" 2>/dev/null || continue
+			"$ld" -r "$workdir/probe.o" -o "$workdir/probe.elf" \
+				2>/dev/null || continue
+
+			THIN_CC="$cc"
+			THIN_LD="$ld"
+			return 0
+		done
+	done
+
+	return 1
+}
+
+out_sections() { readelf -S -W "$workdir/out.o" 2>/dev/null; }
+out_relocs()   { readelf -r -W "$workdir/out.o" 2>/dev/null; }
+out_symbols()  { readelf -s -W "$workdir/out.o" 2>/dev/null; }
+diff_log()     { cat "$workdir/diff.log"; }
+
+assert_section()
+{
+	out_sections | grep -q "[[:space:]]$1[[:space:]]" ||
+		fail "expected section '$1' in output"
+}
+
+assert_patched()
+{
+	assert_section ".text.$1"
+}
+
+assert_not_patched()
+{
+	out_sections | grep -q "[[:space:]].text.$1[[:space:]]" &&
+		fail "function '$1' should not have been cloned"
+	return 0
+}
diff --git a/tools/objtool/tests/run-tests.sh b/tools/objtool/tests/run-tests.sh
new file mode 100755
index 000000000000..ab1dea58811e
--- /dev/null
+++ b/tools/objtool/tests/run-tests.sh
@@ -0,0 +1,20 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Run the objtool klp tests.  Each test-*.sh prints one TAP result line.
+
+set -u
+
+cd "$(dirname "$0")" || exit 1
+
+tests=( test-*.sh )
+[ "${tests[0]}" = "test-*.sh" ] && { echo "1..0 # SKIP no tests found"; exit 0; }
+
+echo "1..${#tests[@]}"
+
+rc=0
+for t in "${tests[@]}"; do
+	./"$t" || rc=1
+done
+
+exit $rc
diff --git a/tools/objtool/tests/test-basic.sh b/tools/objtool/tests/test-basic.sh
new file mode 100755
index 000000000000..6b769962399a
--- /dev/null
+++ b/tools/objtool/tests/test-basic.sh
@@ -0,0 +1,17 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Only functions whose code changed get cloned into the patch.
+
+. "$(dirname "$0")/lib.sh"
+
+setup
+build_pair basic.c
+run_diff
+
+assert_patched     changed
+assert_not_patched untouched
+assert_section     ".init.klp_funcs"
+assert_section     ".init.klp_objects"
+
+pass "changed function cloned, unchanged function left alone"
-- 
2.53.0-Meta

