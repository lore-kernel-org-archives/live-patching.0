Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793223960;
	b=fKgNREwUmzbNxEQJwbXrbyFRY64coNRfXgfLnLFHzIaFP2xI+opVDFAc2cZvFJe8FQEI
	 qdHnXf5T6v6IL5tEzGES5qVdUEDo8qjRSKW+AAhr56OutrNv6XhkRIIyj7QeDA4XU4zqb
	 DSPCZgBTQ8Qq8+lZWseljB8W5zxPj3O3gJ02JlNCFcI9+r4N+/8066vSfql2sYG+MfONZ
	 uskQWexHWaEkeAWq+DfxQZI31xJ7UJUyCdovZOSci7wAm5/clJ1s4AO53/xEOvLTzSyMS
	 8RlP2KnEykXXL8PtRHNUlSrsCwY0/0eT/5lBqOYbNHd1+0nZw7JdjJLP8NmMaTfq0YQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793223960;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=6WIKm2UQ+gWvUhkMk0IplQX8MHIXp+L6Inmg8PGoga8=;
	b=ARFF+PcVwscGfhh8Z5YsoHNnpuq/j8GKxtgrazI3v5b/5o03+DJcLHiA/5XoP4Cc7fba
	 p0wBrwn4Bq394+rGm6vjsllLuhivBe1dPM9YUBXKPqVDmFHd15tOsO8K4VRRVlQGs3xkC
	 cISZW86pkqFqVwtmVS7EzIhJLXYUPNSbAs53nX/7bcunY6fMf9jmYQ+p1yIZ1WxAkz9EP
	 LQ/2/8cDumXulWHR+MUkry4U8zpbPniIEN8Okp45P/AZeE1Kg3+NizMLdc9VoUXrrqv4p
	 3382151Dm6cH/AXo3kHx9b8+cTxkCEtD5Yl8sDNVxkrJk65TwCouL2y61b0LOframDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jeNKakq3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D34606A339;
	Wed, 28 Oct 2026 21:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jeNKakq3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 363691F031E3;
	Wed, 28 Oct 2026 21:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793223960;
	bh=6WIKm2UQ+gWvUhkMk0IplQX8MHIXp+L6Inmg8PGoga8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jeNKakq3tUTUxzMMk1q+ddwL8ddn92K4ewHL0RnqvrrfzSGR4hQtqatbNHW0wSnre
	 zMx3PdEd+hu2yTnerLBMbwLUbcUWDlmAtMqxLDk/pMw4Z/wIhS7QXhFKHcJCOYHJUu
	 QnT308nhPDNtVj+LaZq0FebUA9H6lLqMedYa+414UM+ls4U7UZMIoO35OXzEyQvAux
	 ++xx4CqEsW64dOWEaKWP91HRT7PW6efRczyhy/RWIIRrTCveKm5L4DRbB05FQdx9mz
	 W5e2jLQVDItVbrMgt53ftNb55qQfpN7VibWo7huK1cefDO/DiFfdT3X6ll/97bvVOu
	 3NkHAhd4mhdRA==
From: Song Liu <song@kernel.org>
To: live-patching@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	Song Liu <song@kernel.org>
Subject: [PATCH v2 04/12] selftests/livepatch: Add tests for klp-prepare-patch
Date: Wed, 28 Oct 2026 14:45:26 -0700
Message-ID: <20261028214534.1919398-5-song@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028214534.1919398-1-song@kernel.org>
References: <20261028214534.1919398-1-song@kernel.org>
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before building the patched kernel, klp-build runs klp-prepare-patch to
combine the patches it is given into a single patch and add #line
directives to it.  Mistakes there break the build, or make klp-build
include functions which didn't change.

Add a kselftest target, livepatch/test_klp_build, which runs
klp-prepare-patch on patches to a small source tree and checks the patch
it prints.  Nothing is compiled, so the tests don't need a configured
kernel, root, or the livepatch test modules.

Each test creates its source files and patches from heredocs, so it is
self-contained.  functions.sh provides:

- setup_tree() creates a scratch source tree and a patch directory
- add_file() and add_patch() fill them
- run_klp_prepare_patch() runs klp-prepare-patch from the top of the
  tree and checks that it left the tree as it found it
- expect_patch() checks that klp-prepare-patch succeeded without
  warnings and printed the expected patch.  Only what the patch changes
  is compared: trailing whitespace is ignored, so blank context lines
  can be written as empty lines, and so are "diff" lines and timestamps,
  which depend on how the patch was generated.

Installed tests don't have the source tree, so klp-prepare-patch and
fix-patch-lines are installed next to them.  The tests skip if gawk,
recountdiff or GNU patch is missing.

kselftest prints several lines for every test.  For running the tests
by hand, add run-tests.sh and a "tests" make target, which print one
line per test case, the details of any failure, and the totals.

Start with a test of a single patch, which gets a #line directive after
the lines it adds.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/livepatch/README      |  16 +++
 .../livepatch/test_klp_build/Makefile         |  19 +++
 .../livepatch/test_klp_build/functions.sh     | 135 ++++++++++++++++++
 .../livepatch/test_klp_build/run-tests.sh     |  68 +++++++++
 .../livepatch/test_klp_build/test-basic.sh    |  57 ++++++++
 6 files changed, 296 insertions(+)
 create mode 100644 tools/testing/selftests/livepatch/test_klp_build/Makefile
 create mode 100644 tools/testing/selftests/livepatch/test_klp_build/functions.sh
 create mode 100755 tools/testing/selftests/livepatch/test_klp_build/run-tests.sh
 create mode 100755 tools/testing/selftests/livepatch/test_klp_build/test-basic.sh

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 2d960626750e..30d46cb71cbb 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -64,6 +64,7 @@ TARGETS += kvm
 TARGETS += landlock
 TARGETS += lib
 TARGETS += livepatch
+TARGETS += livepatch/test_klp_build
 TARGETS += liveupdate
 TARGETS += lkdtm
 TARGETS += lsm
diff --git a/tools/testing/selftests/livepatch/README b/tools/testing/selftests/livepatch/README
index d2035dd64a2b..b8727d72469e 100644
--- a/tools/testing/selftests/livepatch/README
+++ b/tools/testing/selftests/livepatch/README
@@ -44,6 +44,22 @@ or
   % make kselftest TARGETS=livepatch
 
 
+klp-build tests
+---------------
+
+The test_klp_build directory holds tests for klp-prepare-patch, which
+scripts/livepatch/klp-build uses to prepare the patches it is given.  They
+don't build a kernel or load any modules, so they don't need root, and they
+are a kselftest target of their own:
+
+  % make -C tools/testing/selftests TARGETS=livepatch/test_klp_build run_tests
+
+For one line of output per test case, which is easier to read when running
+them by hand:
+
+  % make -C tools/testing/selftests/livepatch/test_klp_build tests
+
+
 Adding tests
 ------------
 
diff --git a/tools/testing/selftests/livepatch/test_klp_build/Makefile b/tools/testing/selftests/livepatch/test_klp_build/Makefile
new file mode 100644
index 000000000000..71ae793b0595
--- /dev/null
+++ b/tools/testing/selftests/livepatch/test_klp_build/Makefile
@@ -0,0 +1,19 @@
+# SPDX-License-Identifier: GPL-2.0
+
+TEST_PROGS := \
+	test-basic.sh
+
+TEST_PROGS_EXTENDED := functions.sh
+
+# Installed tests run without the source tree, so install the scripts too
+TEST_FILES := \
+	../../../../../scripts/livepatch/klp-prepare-patch \
+	../../../../../scripts/livepatch/fix-patch-lines
+
+include ../../lib.mk
+
+# Run the tests by hand, with one line of output per test case
+tests:
+	@./run-tests.sh $(TEST_PROGS)
+
+.PHONY: tests
diff --git a/tools/testing/selftests/livepatch/test_klp_build/functions.sh b/tools/testing/selftests/livepatch/test_klp_build/functions.sh
new file mode 100644
index 000000000000..6b2f30d72f99
--- /dev/null
+++ b/tools/testing/selftests/livepatch/test_klp_build/functions.sh
@@ -0,0 +1,135 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Shell functions for the klp-build tests.
+#
+# Each test creates a small source tree, adds some patches, runs
+# klp-prepare-patch on them and checks the patch it prints.  Nothing gets
+# compiled, so the source files don't need to build.
+
+export LC_ALL=C
+
+# Kselftest framework requirement - SKIP code is 4
+ksft_skip=4
+
+# skip(msg) - testing can't proceed
+#	msg - explanation
+function skip() {
+	echo "SKIP: $1" >&2
+	exit $ksft_skip
+}
+
+# die(msg) - game over, man
+#	msg - dying words
+function die() {
+	echo "ERROR: $1" >&2
+	exit 1
+}
+
+TEST_DIR="$(cd "$(dirname "$0")" && pwd)"
+
+# Installed tests have copies of the scripts next to them
+if [[ -x "$TEST_DIR/klp-prepare-patch" ]]; then
+	SCRIPT_DIR="$TEST_DIR"
+else
+	SCRIPT_DIR="$TEST_DIR/../../../../../scripts/livepatch"
+fi
+[[ -x "$SCRIPT_DIR/klp-prepare-patch" ]] || skip "klp-prepare-patch not found"
+
+for cmd in gawk recountdiff; do
+	command -v "$cmd" > /dev/null || skip "$cmd not found"
+done
+patch --version 2> /dev/null | grep -q "GNU patch" || skip "GNU patch not found"
+
+# setup_tree() - create an empty source tree for klp-prepare-patch to run in
+#
+# Patches are kept outside the tree.
+function setup_tree() {
+	WORK_DIR="$(mktemp -d)" || die "mktemp failed"
+	trap 'rm -rf "$WORK_DIR"' EXIT
+
+	TREE="$WORK_DIR/tree"
+	PATCH_DIR="$WORK_DIR/patches"
+
+	mkdir -p "$TREE" "$PATCH_DIR"
+}
+
+# add_file(path) - add a source file read from stdin to the tree
+#	path - path of the file, relative to the top of the tree
+function add_file() {
+	mkdir -p "$TREE/$(dirname "$1")"
+	cat > "$TREE/$1"
+}
+
+# add_patch(name) - add a patch read from stdin
+#	name - file name of the patch
+function add_patch() {
+	cat > "$PATCH_DIR/$1"
+}
+
+# start_test(name) - start a test
+#	name - what the test checks
+function start_test() {
+	echo -n "TEST: $1 ... "
+}
+
+# not_ok(msg, [file]) - report a failed test and exit
+#	msg - what went wrong
+#	file - details to show
+function not_ok() {
+	echo -e "not ok\n"
+	echo "$1"
+	[[ $# -gt 1 ]] && cat "$2"
+	echo
+	die "klp-build kselftest(s) failed"
+}
+
+# run_klp_prepare_patch(patch...) - run klp-prepare-patch from the top of the
+# tree, and check that it leaves the tree as it found it
+#	patch - name of a patch added with add_patch()
+function run_klp_prepare_patch() {
+	local patches=()
+	local patch
+
+	for patch in "$@"; do
+		patches+=("$PATCH_DIR/$patch")
+	done
+
+	rm -rf "$WORK_DIR/orig"
+	cp -a "$TREE" "$WORK_DIR/orig"
+
+	STATUS=0
+	(cd "$TREE" && "$SCRIPT_DIR/klp-prepare-patch" "${patches[@]}") \
+		> "$WORK_DIR/stdout" 2> "$WORK_DIR/stderr" || STATUS=$?
+
+	diff -ru "$WORK_DIR/orig" "$TREE" > "$WORK_DIR/tree.diff" ||
+		not_ok "klp-prepare-patch left the source tree modified:" "$WORK_DIR/tree.diff"
+}
+
+# expect_patch() - check that klp-prepare-patch succeeded without warnings, and
+# printed the patch read from stdin
+#
+# Only what the patch changes is compared.  Trailing whitespace is ignored, so
+# blank context lines can be written as empty lines, and so are "diff" lines
+# and timestamps.  A file diffed against an epoch timestamp counts as
+# /dev/null.
+function expect_patch() {
+	local expected="$WORK_DIR/expected"
+	local result="$WORK_DIR/result"
+	local normalize=(sed -E
+		-e '/^diff /d'
+		-e 's/^(---|\+\+\+) [^\t]*\t(1969-12-31|1970-01-01) .*/\1 \/dev\/null/'
+		-e 's/^((---|\+\+\+) [^\t]*)\t.*/\1/'
+		-e 's/[[:space:]]*$//')
+
+	[[ $STATUS -eq 0 ]] || not_ok "klp-prepare-patch failed:" "$WORK_DIR/stderr"
+	[[ -s "$WORK_DIR/stderr" ]] && not_ok "klp-prepare-patch warned:" "$WORK_DIR/stderr"
+
+	"${normalize[@]}" > "$expected"
+	"${normalize[@]}" "$WORK_DIR/stdout" > "$result"
+
+	diff -u --label expected --label result "$expected" "$result" > "$WORK_DIR/result.diff" ||
+		not_ok "unexpected patch:" "$WORK_DIR/result.diff"
+
+	echo "ok"
+}
diff --git a/tools/testing/selftests/livepatch/test_klp_build/run-tests.sh b/tools/testing/selftests/livepatch/test_klp_build/run-tests.sh
new file mode 100755
index 000000000000..d67770006d7f
--- /dev/null
+++ b/tools/testing/selftests/livepatch/test_klp_build/run-tests.sh
@@ -0,0 +1,68 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Run the klp-build tests with less output than "make run_tests": one line
+# per test case, the details of any failure, and the totals.
+#
+# Usage: run-tests.sh [test-*.sh...]
+
+cd "$(dirname "$0")" || exit 1
+
+tests=("$@")
+[[ ${#tests[@]} -eq 0 ]] && tests=(test-*.sh)
+
+pass=0
+fail=0
+skip=0
+
+echo "TAP version 13"
+
+for test in "${tests[@]}"; do
+	name="${test%.sh}"
+	failed=0
+	cases=0
+	status=0
+
+	out="$(./"$test" 2>&1)" || status=$?
+
+	if [[ $status -eq 4 ]]; then
+		echo "ok - $name # SKIP $(sed -n 's/^SKIP: //p' <<< "$out")"
+		skip=$((skip + 1))
+		continue
+	fi
+
+	while IFS= read -r line; do
+		case "$line" in
+		"TEST: "*" ... ok")
+			line="${line#TEST: }"
+			echo "ok - $name: ${line% ... ok}"
+			pass=$((pass + 1))
+			cases=$((cases + 1))
+			;;
+		"TEST: "*" ... not ok")
+			line="${line#TEST: }"
+			echo "not ok - $name: ${line% ... not ok}"
+			failed=1
+			cases=$((cases + 1))
+			;;
+		"ERROR: klp-build kselftest(s) failed" | "")
+			;;
+		*)
+			[[ $failed -eq 1 ]] && echo "#   $line"
+			;;
+		esac
+	done <<< "$out"
+
+	if [[ $failed -eq 0 && ( $status -ne 0 || $cases -eq 0 ) ]]; then
+		echo "not ok - $name: exited with status $status after $cases test case(s)"
+		sed 's/^/#   /' <<< "$out"
+		failed=1
+	fi
+
+	fail=$((fail + failed))
+done
+
+echo "1..$((pass + fail + skip))"
+echo "# pass:$pass fail:$fail skip:$skip"
+
+[[ $fail -eq 0 ]]
diff --git a/tools/testing/selftests/livepatch/test_klp_build/test-basic.sh b/tools/testing/selftests/livepatch/test_klp_build/test-basic.sh
new file mode 100755
index 000000000000..127d678a07ce
--- /dev/null
+++ b/tools/testing/selftests/livepatch/test_klp_build/test-basic.sh
@@ -0,0 +1,57 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. "$(dirname "$0")/functions.sh"
+
+setup_tree
+
+add_file drivers/foo/foo.c <<'EOT'
+int foo(int x)
+{
+	if (x < 0)
+		return -1;
+	return x;
+}
+
+int bar(void)
+{
+	return __LINE__;
+}
+EOT
+
+# - a patch which adds lines to foo() gets a #line directive after them, so
+#   bar() still sees its original __LINE__
+
+start_test "single patch"
+
+add_patch 0001-foo.patch <<'EOT'
+--- a/drivers/foo/foo.c
++++ b/drivers/foo/foo.c
+@@ -1,6 +1,8 @@
+ int foo(int x)
+ {
++	if (!x)
++		return 0;
+ 	if (x < 0)
+ 		return -1;
+ 	return x;
+ }
+EOT
+
+run_klp_prepare_patch 0001-foo.patch
+
+expect_patch <<'EOT'
+--- a/drivers/foo/foo.c
++++ b/drivers/foo/foo.c
+@@ -1,5 +1,8 @@
+ int foo(int x)
+ {
++	if (!x)
++		return 0;
++#line 3
+ 	if (x < 0)
+ 		return -1;
+ 	return x;
+EOT
+
+exit 0
-- 
2.53.0-Meta

