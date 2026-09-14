Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB0139A073
	for <live-patching@vger.kernel.org>; Mon, 14 Sep 2026 23:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789427090; cv=none; b=fFmGzOQX9t8v86HRuS8qauGIveQx2JRzB2+3oR1lYzv4xFD92uKect57hhhOZPW+opJ7yo7nrCILmGq39qSlxHozpGAa/W2a7lTHrVwqshohcapwghKy71gM5FUCE8QsJOjEHJzuSrnxlmq4mxUV+ymiqQIof/V0fjw2fOygUZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789427090; c=relaxed/simple;
	bh=5tmftoX2052NyLvf0giYJkxbeA5WbLaJOPkWwcXXe2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kQneGu2meDUeJZUqV0JxxHQj3j2P4aBGIPHVCMjUzPDm4j2CQ85OLsFo8ARJTaagL1fqCr8MgY9fvzVS2ONC+Gp9Aj2itKfUUIgp4pURiV4n68dkYv/gYIysl1Z47tuHudtM37cu7I5xwIjFHlZ9o9idsWvMlgwkLBjYxjSTHSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UojBD4Eq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UojBD4Eq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C647E1F000FF;
	Mon, 14 Sep 2026 23:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789427088;
	bh=neywwWTmCm/4JT7ldW1cb6QiHU8cyZmApqB8iyXX8uY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UojBD4EqLifEGPM9ETlKrlhxmgPur7/2dSHAr/aUZlvoXc3ueMoNa1mCGa7m7TUjr
	 Eu2j+K5Tb0j5BVsAInkchNupOgtFx2Nfz/UAbqLeyijWLST2xYF3fDI/gx3uiFFuZy
	 nEiUHHeHgQGFkGoahYb1Jh5L7oQbz9rm2Fpw4bXX1Zyz25JnJHoriaP6UMRHtTkDN0
	 VkWrmtXCgF/84c/cvGKiHtblQuH2qP2hEOq9/V+CfLCAXfbpiDxGUrJ1OO8eDyguR5
	 kU4L2fT0f9vjbPubhXNzx2aG5ZRU/hNWwBgB8WG/gvdTnnwCI4bCqS7eOfi75copZV
	 Rrmnlvks2EB6Q==
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
Subject: [PATCH v3 10/58] objtool: Keep failing test workdirs by default
Date: Mon, 14 Sep 2026 16:03:07 -0700
Message-ID: <20260914230355.3422996-11-song@kernel.org>
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

From: Joe Lawrence <joe.lawrence@redhat.com>

The klp test runner deletes each test's working directory when the test
finishes.  On failure that removes diff.log, out.o and the fixture objects
before the developer can look at them, and the only hint was to re-run
(something) with --keep:

  $ make -C tools/objtool tests
  ...
  not ok - test-special-section: expected section '.kcfi_traps' in output
  ...
  # pass:49 fail:1 static-skip:1 probe-skip:0 xfail:0 xpass:0
  # re-run with --keep to hold on to what a failing test built

Change the default behavior to save failing test working directories. This
is friendlier to the drive-by tester.  Provide the power-user with a KEEP
Makefile variable that can optionally retain 'all' or 'none' of those
directories.  run-tests.sh --keep remains an alias for KEEP=all.

Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 .../objtool/Documentation/klp-test-design.txt | 14 ++--
 tools/objtool/Makefile                        |  2 +-
 tools/objtool/tests/lib.sh                    | 47 ++++++++---
 tools/objtool/tests/run-tests.sh              | 78 +++++++++++++++----
 4 files changed, 108 insertions(+), 33 deletions(-)

diff --git a/tools/objtool/Documentation/klp-test-design.txt b/tools/objtool/Documentation/klp-test-design.txt
index ec56bfbc2c93..67d20bf0dc10 100644
--- a/tools/objtool/Documentation/klp-test-design.txt
+++ b/tools/objtool/Documentation/klp-test-design.txt
@@ -199,10 +199,11 @@ source layout::
         generic/test-basic/{orig.o,patched.o,out.o,Module.symvers,...}
         x86/test-kcfi/...
 
-``--keep`` leaves it and reports the one path.  Otherwise each test removes its
-own directory and the runner ``rmdir``s the run's -- which fails if anything
-was left behind, so a test which dies without cleaning up is reported rather
-than silently leaking.
+By default (``KEEP=failed``) only failing tests keep their directories; the
+runner reports where they are.  ``KEEP=all`` keeps every test's directory;
+``KEEP=none`` removes them all.  The runner ``rmdir``s the run directory when
+it is empty -- which fails if anything was left behind unexpectedly, so a test
+which dies without cleaning up is reported rather than silently leaking.
 
 
 Running
@@ -216,7 +217,10 @@ Running
     CC=clang make -C tools/objtool tests  # the other toolchain
     LLVM=1 make -C tools/objtool tests    # and its binutils too
 
-    tools/objtool/tests/run-tests.sh --keep basic   # one test, keep its objects
+    make -C tools/objtool tests KEEP=all    # keep every test's workdir
+    make -C tools/objtool tests KEEP=none   # remove all workdirs
+
+    tools/objtool/tests/run-tests.sh basic  # one test; failures kept by default
 
 A run covers one compiler and one architecture; CI runs the combinations.
 
diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index 2c200d05c276..ed5cf146ef2e 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -153,7 +153,7 @@ mrproper: clean
 
 tests: $(OBJTOOL)
 	$(Q)OBJTOOL=$(abspath $(OBJTOOL)) ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) \
-		$(srctree)/tools/objtool/tests/run-tests.sh
+		KEEP=$(KEEP) $(srctree)/tools/objtool/tests/run-tests.sh
 
 FORCE:
 
diff --git a/tools/objtool/tests/lib.sh b/tools/objtool/tests/lib.sh
index 9dd4967b244f..6735c06bb59d 100644
--- a/tools/objtool/tests/lib.sh
+++ b/tools/objtool/tests/lib.sh
@@ -150,8 +150,8 @@ workdir=
 orig_obj=orig.o
 patched_obj=patched.o
 
-pass() { echo "ok - $test_name${1:+: $1}"; exit 0; }
-fail() { echo "not ok - $test_name: $1"; exit 1; }
+pass() { KLP_TEST_REPORTED=1; echo "ok - $test_name${1:+: $1}"; exit 0; }
+fail() { KLP_TEST_FAILED=1; echo "not ok - $test_name: $*"; exit 1; }
 
 # Two kinds of skip, and the runner tells them apart.
 #
@@ -164,8 +164,19 @@ fail() { echo "not ok - $test_name: $1"; exit 1; }
 #
 # A bare skip() is neither, and the runner counts it as a failure: a test which
 # gives up for a reason it never declared is a hole, not an outcome.
-declared_skip() { echo "ok - $test_name # SKIP (declared) $*"; exit 0; }
-probe_skip()    { echo "ok - $test_name # SKIP (probe) $*"; exit 0; }
+declared_skip()
+{
+	KLP_TEST_REPORTED=1
+	echo "ok - $test_name # SKIP (declared) $*"
+	exit 0
+}
+
+probe_skip()
+{
+	KLP_TEST_REPORTED=1
+	echo "ok - $test_name # SKIP (probe) $*"
+	exit 0
+}
 skip()          { echo "ok - $test_name # SKIP $*"; exit 0; }
 
 # TAP directives.  A test which is known to fail reports it rather than being
@@ -174,12 +185,14 @@ skip()          { echo "ok - $test_name # SKIP $*"; exit 0; }
 # which is the point.
 xfail()
 {
+	KLP_TEST_REPORTED=1
 	echo "not ok - $test_name${1:+: $1} # TODO known failure"
 	exit 0
 }
 
 xpass()
 {
+	KLP_TEST_FAILED=1
 	echo "ok - $test_name${1:+: $1} # TODO expected failure, but passed"
 	exit 1
 }
@@ -188,12 +201,26 @@ cleanup()
 {
 	[ -n "$workdir" ] || return 0
 
-	if [ -n "${KLP_TEST_KEEP:-}" ]; then
-		[ -n "${KLP_TEST_WORKDIR:-}" ] || echo "# kept $workdir"
-		return 0
-	fi
-
-	rm -rf "$workdir"
+	case "${KLP_TEST_KEEP:-failed}" in
+	all)	return 0 ;;
+	none)	rm -rf "$workdir" ;;
+	failed|*)
+		# Keep what the runner is going to point at.  It counts as a
+		# failure anything which did not report an expected outcome --
+		# including a test which died before printing one, and an
+		# undeclared skip -- and none of those set KLP_TEST_FAILED, so
+		# the question to ask is whether a result was reported at all.
+		# An exit status cannot answer it: a test killed by a signal
+		# runs this trap with the status of whatever ran last.
+		[ -n "${KLP_TEST_REPORTED:-}" ] && [ -z "${KLP_TEST_FAILED:-}" ] && {
+			rm -rf "$workdir"
+			return 0
+		}
+		# run on its own there is no runner to say where it was kept
+		[ -n "${KLP_TEST_WORKDIR:-}" ] ||
+			echo "# kept $workdir"
+		;;
+	esac
 }
 
 # setup [exported symbol...]
diff --git a/tools/objtool/tests/run-tests.sh b/tools/objtool/tests/run-tests.sh
index e6f1ac1b5d0d..81dd33f1819b 100755
--- a/tools/objtool/tests/run-tests.sh
+++ b/tools/objtool/tests/run-tests.sh
@@ -31,13 +31,15 @@ A test may be named with or without its "test-" prefix and ".sh" suffix, and is
 looked for in both directories.
 
 Options:
-    -k, --keep    do not delete each test's working directory; print its path,
-                  so the objects a failing test built can be looked at
+    -k, --keep    same as KEEP=all (see below)
 
 Environment:
     OBJTOOL       objtool binary to test (default ../objtool)
     CC            compiler used to build fixtures (default gcc)
     ARCH          architecture the tests are for (default: uname -m)
+    KEEP          failed  keep only failing tests (default)
+                  all     keep every test's working directory
+                  none    remove all working directories
 
 A test which needs something of its own says so in its skip message.
 EOF
@@ -46,16 +48,28 @@ EOF
 
 cd "$(dirname "$0")" || exit 1
 
+keep_from_args=
 while [ $# -gt 0 ]; do
 	case "$1" in
 	-h|--help)	usage ;;
-	-k|--keep)	export KLP_TEST_KEEP=1; shift ;;
+	-k|--keep)	keep_from_args=all; shift ;;
 	--)		shift; break ;;
 	-*)		echo "unknown option: $1" >&2; usage 1 ;;
 	*)		break ;;
 	esac
 done
 
+KLP_TEST_KEEP="${KEEP:-failed}"
+[ -n "$keep_from_args" ] && KLP_TEST_KEEP="$keep_from_args"
+case "$KLP_TEST_KEEP" in
+all|none|failed) ;;
+*)
+	echo "invalid KEEP=$KLP_TEST_KEEP (want failed, all, or none)" >&2
+	exit 1
+	;;
+esac
+export KLP_TEST_KEEP
+
 echo "TAP version 13"
 
 # Sourcing the harness runs its preflight, which decides which architecture
@@ -112,6 +126,7 @@ rundir="$(mktemp -d "${TMPDIR:-/tmp}/klp-tests.XXXXXXXX")" ||
 echo "1..${#tests[@]}"
 
 pass=0 fail=0 static_skip=0 probe_skip=0 xfail=0 xpass=0
+failed_dirs=()
 
 for t in "${tests[@]}"; do
 	out="$(KLP_TEST_WORKDIR="$rundir/${t%.sh}" ./"$t" 2>&1)"
@@ -147,16 +162,16 @@ for t in "${tests[@]}"; do
 		rest="$rest${rest:+$'\n'}was: $result"
 		result="not ok - $(basename "$t" .sh): undeclared skip"
 		result="$result (use gcc_only/clang_only or require_input_*)"
-		fail=$((fail + 1)) ;;
+		fail=$((fail + 1)); failed_dirs+=( "$rundir/${t%.sh}" ) ;;
 	"not ok"*"# TODO"*)	xfail=$((xfail + 1)) ;;
-	"ok"*"# TODO"*)		xpass=$((xpass + 1)) ;;
-	"not ok"*)		fail=$((fail + 1)) ;;
+	"ok"*"# TODO"*)		xpass=$((xpass + 1)); failed_dirs+=( "$rundir/${t%.sh}" ) ;;
+	"not ok"*)		fail=$((fail + 1)); failed_dirs+=( "$rundir/${t%.sh}" ) ;;
 	"ok"*)			pass=$((pass + 1)) ;;
 	*)
 		# No result line at all: the test died before reporting.
 		rest="$rest${rest:+$'\n'}exited $rc without a result line"
 		result="not ok - $(basename "$t" .sh): no TAP result"
-		fail=$((fail + 1)) ;;
+		fail=$((fail + 1)); failed_dirs+=( "$rundir/${t%.sh}" ) ;;
 	esac
 
 	echo "$result"
@@ -167,15 +182,44 @@ done
 echo "# pass:$pass fail:$fail static-skip:$static_skip" \
      "probe-skip:$probe_skip xfail:$xfail xpass:$xpass"
 
-# A failure is the one time the objects matter, and by default they are
-# already gone.  Say so then rather than in the usage text nobody reads while
-# something is broken.
-if [ -n "${KLP_TEST_KEEP:-}" ]; then
-	echo "# working directories kept in $rundir -- inspect, then rm -rf it"
-elif ! rmdir "$rundir"/*/ "$rundir" 2>/dev/null; then
-	echo "# $rundir was not empty; a test did not clean up after itself"
-elif [ "$fail" != 0 ] || [ "$xpass" != 0 ]; then
-	echo "# re-run with --keep to hold on to what a failing test built"
-fi
+case "$KLP_TEST_KEEP" in
+all)
+	echo "# keep=all: workdirs kept in $rundir"
+	echo "# inspect: diff.log, readelf -S out.o under each test-* subdirectory"
+	echo "# cleanup: rm -rf $rundir"
+	;;
+failed)
+	if [ "${#failed_dirs[@]}" -gt 0 ]; then
+		echo "# keep=failed: ${#failed_dirs[@]} failing test(s) kept under $rundir:"
+		for d in "${failed_dirs[@]}"; do
+			echo "#   ${d#"$rundir"/}/"
+		done
+		echo "# inspect: diff.log  readelf -S out.o"
+		echo "# one test: $PWD/run-tests.sh <name>"
+		echo "# cleanup: rm -rf $rundir"
+	else
+		# Two levels: each test's own directory, then the one per source
+		# directory holding them.  Either rmdir may fail -- the glob stays
+		# unexpanded when nothing was created -- so ask the directory
+		# itself whether anything is left rather than trusting the status.
+		rmdir "$rundir"/*/ 2>/dev/null
+		rmdir "$rundir" 2>/dev/null
+		if [ -d "$rundir" ]; then
+			echo "# $rundir was not empty;" \
+			     "a test did not clean up after itself"
+		fi
+	fi
+	;;
+none)
+	if ! rmdir "$rundir"/*/ "$rundir" 2>/dev/null; then
+		if [ "$fail" != 0 ] || [ "$xpass" != 0 ]; then
+			echo "# keep=none: artifacts were removed" \
+			     "(re-run with KEEP=failed or KEEP=all)"
+		elif [ -d "$rundir" ]; then
+			echo "# $rundir was not empty; a test did not clean up after itself"
+		fi
+	fi
+	;;
+esac
 
 [ "$fail" = 0 ] && [ "$xpass" = 0 ]
-- 
2.53.0-Meta

