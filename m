Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC4E4D5963
	for <live-patching@vger.kernel.org>; Wed, 16 Sep 2026 18:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789584276; cv=none; b=HSCe34+0dW9/MoxKQsnAKiXvEft5jsTMMfee+GlHHOPmi5PtplEDgfsNbbFA/ru0VH2G2FRmpzDSOqQKQ/Q9pK0rRXdx8ftwo/MqvcE9h/r/Sj3motnEbBadQZsgaJxXSCLWKI/B2XtZSsKIIaxFBeEue4fYIr5BkYAAqJQO4K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789584276; c=relaxed/simple;
	bh=1jxSj458SN10njo6hbiPF4D5rry1Hub4x2LcORQjJ8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WEY9WRrkUd9uDQeHZY1Iff44+ViujFA9/xTKdLqGZx4M2foGPoI+asKllbMZl7TytDWXNQHCLIia3vAo8pEEF7Rqr53GWqQFdJq/Bx/xASbl6t8q6j8IJXJRyiTuONSX3wPAnTlTeXx3/QzPgkkZHHNuvwIGRtHam9EU/wTEFyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xy4XbnFi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xy4XbnFi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53E9A1F0089A;
	Wed, 16 Sep 2026 18:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789584257;
	bh=NfvCsarIJHoNeKvJaEfclwwb6gA6ssbBlZUuxWUCyAU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Xy4XbnFimxqqv8MavgvobPHD2xfbNWy3zvhGYhEKh6CbZ1J0pynxZN0iX6RGlhkvk
	 5t7K93Sf9DcWNDVeqZJlaex+VCYAoxaP5u4WOgVrpmlnHMjyWpuFOEKbyHojg9m6/6
	 0w8OuonL0d5l2FuBMSAcXv5eb8hroeTFOTvAgetzPuSenmXoqIrPFXsRkzc1WcA5aj
	 fYtD30nrGNUvTuv2jzbqYxXN+bmsbVTv8fsqN+L0mH7upRfG8/gQBoZ5gaDpSc7XTP
	 krkYmuewh8aTXFpWuKqSItlEa3Ca5TqUpWCTb8F7sSUgQ96ncld/qfGiusQepeIwHg
	 /lFrBO79af6/A==
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
Subject: [PATCH v5 04/58] objtool/klp: Classify klp test outcomes
Date: Wed, 16 Sep 2026 11:42:57 -0700
Message-ID: <20260916184351.2720310-5-song@kernel.org>
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

A test could pass, fail, or skip, and the runner reported only the exit
status of the last one to fail.  Skips are the interesting case: they are
how a suite quietly stops testing anything.

Three kinds, and the runner counts them separately:

  declared   the test said in advance it does not apply here, e.g. gcc_only
             on a clang run.  Expected indefinitely.
  probe      the construct did not turn up in the built object this time.
             Weaker: one which becomes permanent is a fixture that stopped
             testing anything.
  undeclared counted as a failure.  A test which gives up for a reason it
             never declared is a hole, not an outcome.

xfail and xpass come with them, so a known failure is reported rather than
commented out and forgotten, and one which starts passing says so instead
of going quietly green.

The result line is what gets classified, not the whole of a test's output:
objtool warns on stderr and the runner captures it, and a stray line ahead
of the result would otherwise leave the exit status to decide -- counting
an expected failure, which exits 0, as a pass.

Every test owes the plan exactly one result line, so a substituted verdict
replaces the test's own rather than being printed beside it, and a test
which dies before reporting gets a result of its own instead of being
inferred from its exit status.

Also: a TAP version line, LC_ALL=C so the order tests run in and the
behaviour of grep's character ranges inside them do not depend on the
invoking shell's locale, and fail() on stdout with every other verdict.

Co-developed-by: Puranjay Mohan <puranjay@kernel.org>
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 tools/objtool/tests/lib.sh       |  67 ++++++++++++--
 tools/objtool/tests/run-tests.sh | 148 ++++++++++++++++++++++++++-----
 2 files changed, 186 insertions(+), 29 deletions(-)

diff --git a/tools/objtool/tests/lib.sh b/tools/objtool/tests/lib.sh
index fdea9b790c4d..1531caab4627 100644
--- a/tools/objtool/tests/lib.sh
+++ b/tools/objtool/tests/lib.sh
@@ -139,8 +139,38 @@ test_name="$(basename "$0" .sh)"
 workdir=
 
 pass() { echo "ok - $test_name${1:+: $1}"; exit 0; }
-fail() { echo "not ok - $test_name: $1" >&2; exit 1; }
-skip() { echo "ok - $test_name # SKIP $1"; exit 0; }
+fail() { echo "not ok - $test_name: $1"; exit 1; }
+
+# Two kinds of skip, and the runner tells them apart.
+#
+#   declared_skip  the test said in advance it does not apply here, e.g.
+#                  gcc_only on a clang run.  Expected indefinitely.
+#   probe_skip     the construct did not turn up in the built object this
+#                  time.  Weaker: it may appear on another compiler version,
+#                  and one which becomes permanent is a fixture that quietly
+#                  stopped testing anything.
+#
+# A bare skip() is neither, and the runner counts it as a failure: a test which
+# gives up for a reason it never declared is a hole, not an outcome.
+declared_skip() { echo "ok - $test_name # SKIP (declared) $*"; exit 0; }
+probe_skip()    { echo "ok - $test_name # SKIP (probe) $*"; exit 0; }
+skip()          { echo "ok - $test_name # SKIP $*"; exit 0; }
+
+# TAP directives.  A test which is known to fail reports it rather than being
+# commented out and forgotten, and one which starts passing again says so
+# instead of quietly going green: the expectation has to be removed by hand,
+# which is the point.
+xfail()
+{
+	echo "not ok - $test_name${1:+: $1} # TODO known failure"
+	exit 0
+}
+
+xpass()
+{
+	echo "ok - $test_name${1:+: $1} # TODO expected failure, but passed"
+	exit 1
+}
 
 cleanup() { [ -n "$workdir" ] && rm -rf "$workdir"; }
 
@@ -170,6 +200,23 @@ export_syms()
 	done
 }
 
+# gcc_only / clang_only <reason>
+gcc_only()
+{
+	case "$($CC --version 2>/dev/null | head -1)" in
+	*[Gg][Cc][Cc]*)	return 0 ;;
+	esac
+	declared_skip "gcc only${1:+: $1}"
+}
+
+clang_only()
+{
+	case "$($CC --version 2>/dev/null | head -1)" in
+	*clang*)	return 0 ;;
+	esac
+	declared_skip "clang only${1:+: $1}"
+}
+
 # build_pair <fixture.c> [cflags...]
 build_pair()
 {
@@ -178,9 +225,9 @@ build_pair()
 	[ -f "$fixture" ] || fail "missing fixture $fixture"
 
 	$CC $FIXTURE_CFLAGS "$@" -o "$workdir/orig.o" "$fixture" 2>"$workdir/cc.log" ||
-		skip "fixture does not build here: $(tail -1 "$workdir/cc.log")"
+		probe_skip "fixture does not build here: $(tail -1 "$workdir/cc.log")"
 	$CC $FIXTURE_CFLAGS "$@" -DPATCHED -o "$workdir/patched.o" "$fixture" 2>"$workdir/cc.log" ||
-		skip "fixture does not build here: $(tail -1 "$workdir/cc.log")"
+		probe_skip "fixture does not build here: $(tail -1 "$workdir/cc.log")"
 }
 
 # run_diff [expected exit status]
@@ -226,16 +273,20 @@ partial_link()
 
 # find_thinlto_toolchain
 #
-# Set $THIN_CC and $THIN_LD to a clang and lld from the same LLVM release.  A
+# Set $THIN_LD to an lld from the same LLVM release as $CC (or THIN_CC).  A
 # mismatched pair fails with "Invalid summary version", which reads like a
 # broken test rather than a broken environment.
+#
+# ThinLTO is clang-only; callers must use clang_only before calling this.
+# Only $CC (or an explicit THIN_CC override) is consulted -- the harness does
+# not search for a second compiler beside a gcc $CC.
 find_thinlto_toolchain()
 {
-	local cc ld ver
+	local cc ver ld
 
-	for cc in "${THIN_CC:-}" "$CC" clang; do
+	for cc in "${THIN_CC:-}" "$CC"; do
 		[ -n "$cc" ] || continue
-		command -v "${cc%% *}" >/dev/null 2>&1 || continue
+		command -v "${cc%% *}" >/dev/null 2>&1 || return 1
 
 		ver=$($cc -dumpversion 2>/dev/null | cut -d. -f1)
 
diff --git a/tools/objtool/tests/run-tests.sh b/tools/objtool/tests/run-tests.sh
index 48728a98d995..6b937fc7f5bd 100755
--- a/tools/objtool/tests/run-tests.sh
+++ b/tools/objtool/tests/run-tests.sh
@@ -8,13 +8,51 @@
 # apply here is not run rather than reporting a skip; what was left out is
 # reported once, as a comment, so differing coverage is still visible.
 #
+# A run covers one compiler and one architecture; CI runs the combinations.
 # The harness checks the environment once up front and fails the run if the
 # suite cannot execute, rather than letting every test skip and exit 0.
 
 set -u
 
+# Determinism: the order test-*.sh expands in, and how grep's character ranges
+# and sort's collation behave inside the tests, are all locale-dependent.  A
+# suite whose results depend on the invoking shell's locale is a suite whose
+# failures cannot be reproduced.
+export LC_ALL=C
+
+usage()
+{
+	cat <<EOF
+usage: $(basename "$0") [test...]
+
+Run the objtool klp tests for this architecture: everything in generic/, plus
+everything in the directory named for it.  With no arguments, runs all of them.
+A test may be named with or without its "test-" prefix and ".sh" suffix, and is
+looked for in both directories.
+
+Environment:
+    OBJTOOL       objtool binary to test (default ../objtool)
+    CC            compiler used to build fixtures (default gcc)
+    ARCH          architecture the tests are for (default: uname -m)
+
+A test which needs something of its own says so in its skip message.
+EOF
+	exit "${1:-0}"
+}
+
 cd "$(dirname "$0")" || exit 1
 
+while [ $# -gt 0 ]; do
+	case "$1" in
+	-h|--help)	usage ;;
+	--)		shift; break ;;
+	-*)		echo "unknown option: $1" >&2; usage 1 ;;
+	*)		break ;;
+	esac
+done
+
+echo "TAP version 13"
+
 # Sourcing the harness runs its preflight, which decides which architecture
 # this run is for -- so the test list cannot be built before it has, and the
 # tests inherit the answers rather than working them out again.
@@ -23,31 +61,99 @@ cd "$(dirname "$0")" || exit 1
 dirs=( generic )
 [ -d "$KLP_TEST_ARCH" ] && dirs+=( "$KLP_TEST_ARCH" )
 
-tests=()
-for d in "${dirs[@]}"; do
-	for t in "$d"/test-*.sh; do
-		[ -f "$t" ] && tests+=( "$t" )
+if [ $# -gt 0 ]; then
+	tests=()
+	for arg in "$@"; do
+		name="test-${arg#test-}"; name="${name%.sh}.sh"
+		found=
+		for d in "${dirs[@]}"; do
+			[ -f "$d/$name" ] || continue
+			[ -x "$d/$name" ] ||
+				{ echo "not executable: $d/$name" >&2; exit 1; }
+			tests+=( "$d/$name" ); found=y
+		done
+		[ -n "$found" ] ||
+			{ echo "no such test for $KLP_TEST_ARCH: $arg" >&2; exit 1; }
 	done
-done
-[ "${#tests[@]}" -gt 0 ] || { echo "1..0 # SKIP no tests found"; exit 0; }
-
-# Tests for another architecture are absent from this run entirely.  Say how
-# many, so a run which covers less than the tree holds does not look like one
-# that covers all of it.
-for d in */; do
-	d="${d%/}"
-	case "$d" in generic|"$KLP_TEST_ARCH") continue ;; esac
-	n=$(ls "$d"/test-*.sh 2>/dev/null | wc -l)
-	[ "$n" -gt 0 ] || continue
-	echo "# not run: $n test$( [ "$n" = 1 ] || echo s ) in $d/" \
-	     "(this run is $KLP_TEST_ARCH)"
-done
+else
+	tests=()
+	for d in "${dirs[@]}"; do
+		for t in "$d"/test-*.sh; do
+			[ -f "$t" ] && tests+=( "$t" )
+		done
+	done
+	[ "${#tests[@]}" -gt 0 ] ||
+		{ echo "1..0 # SKIP no tests found"; exit 0; }
+
+	# Tests for another architecture are absent from this run entirely.  Say
+	# how many, so a run which covers less than the tree holds does not look
+	# like one that covers all of it.
+	for d in */; do
+		d="${d%/}"
+		case "$d" in generic|"$KLP_TEST_ARCH") continue ;; esac
+		n=$(ls "$d"/test-*.sh 2>/dev/null | wc -l)
+		[ "$n" -gt 0 ] || continue
+		echo "# not run: $n test$( [ "$n" = 1 ] || echo s ) in $d/" \
+		     "(this run is $KLP_TEST_ARCH)"
+	done
+fi
 
 echo "1..${#tests[@]}"
 
-rc=0
+pass=0 fail=0 static_skip=0 probe_skip=0 xfail=0 xpass=0
+
 for t in "${tests[@]}"; do
-	./"$t" || rc=1
+	out="$(./"$t" 2>&1)"
+	rc=$?
+
+	# A test prints one result line, but it is not necessarily the only
+	# thing it prints: objtool warns on stderr, and the runner captures
+	# that.  Classify the result line itself rather than the whole of the
+	# output, or a stray line ahead of it makes every pattern below miss and
+	# the exit status decide -- which would count an expected failure, which
+	# exits 0, as a pass.
+	result="$(printf '%s\n' "$out" | grep -E '^(ok|not ok)' | tail -1)"
+	rest="$(printf '%s\n' "$out" | grep -Ev '^(ok|not ok)')"
+
+	# Classify from the result line, not the exit status: a skip and a pass
+	# both exit 0, and telling them apart is the point of counting.
+	#
+	# The two skip kinds differ in what they promise.  A static skip was
+	# declared before the test ran ("clang does not do this"), so it is
+	# expected indefinitely.  A probe skip means the construct did not turn
+	# up this time, which is weaker and worth watching: one that becomes
+	# permanent is a fixture that quietly stopped testing anything.
+	case "$result" in
+	*"# SKIP (declared)"*)	static_skip=$((static_skip + 1)) ;;
+	*"# SKIP (probe)"*)	probe_skip=$((probe_skip + 1)) ;;
+	*"# SKIP"*)
+		# An undeclared skip: the test gave up for a reason it never
+		# said it might.  That is a hole, not an expected outcome.
+		#
+		# Replace the line rather than adding one.  Every test owes the
+		# plan exactly one result, and a consumer counting them is
+		# entitled to say so when the totals disagree.
+		rest="$rest${rest:+$'\n'}was: $result"
+		result="not ok - $(basename "$t" .sh): undeclared skip"
+		result="$result (use gcc_only/clang_only or require_input_*)"
+		fail=$((fail + 1)) ;;
+	"not ok"*"# TODO"*)	xfail=$((xfail + 1)) ;;
+	"ok"*"# TODO"*)		xpass=$((xpass + 1)) ;;
+	"not ok"*)		fail=$((fail + 1)) ;;
+	"ok"*)			pass=$((pass + 1)) ;;
+	*)
+		# No result line at all: the test died before reporting.
+		rest="$rest${rest:+$'\n'}exited $rc without a result line"
+		result="not ok - $(basename "$t" .sh): no TAP result"
+		fail=$((fail + 1)) ;;
+	esac
+
+	echo "$result"
+	[ -n "$rest" ] && printf '%s\n' "$rest" | sed 's/^[^#]/# &/'
+
 done
 
-exit $rc
+echo "# pass:$pass fail:$fail static-skip:$static_skip" \
+     "probe-skip:$probe_skip xfail:$xfail xpass:$xpass"
+
+[ "$fail" = 0 ] && [ "$xpass" = 0 ]
-- 
2.53.0-Meta

