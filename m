Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82074AA57F
	for <live-patching@vger.kernel.org>; Fri, 11 Sep 2026 18:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789152235; cv=none; b=mM+hgN7bb86o0BxyQvQVCKSVeF28ocxXldlIvKbEZj4hoQ4WWCKqSxIl3AgdWrD+nUYrt5r5SnZ96lSr2g607wi7KcNBxpG7BJAzquAM9CogYxlEMARtbfEmvx2Ukjl/qdGlHB35oia/VC5dAsre0ifAfBDXFNcUNBmy8lpiymk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789152235; c=relaxed/simple;
	bh=EX2vFQe0pCxHzakARu58ZRuIcyAfuurQv1OfXypV5gI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C1Of9A9sto5CyZ3oL+tpZaWndybrCSLCf5Ec3Lm0gGDvxc3/IBx2A3frbqzPOFpsKFbbImSLNhBexbjRyqas5YcRYIKHHgn6xtmDRVEMlDqNPVnpGt+Eh6mSOGZdjkz1QyGhN9N6ALDQ9d9BghpsVT5LALYrmr2aMnpx/wL3DFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ikcBzU6t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ikcBzU6t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 005A71F000FF;
	Fri, 11 Sep 2026 18:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789152228;
	bh=WBHL6WzWcbnV2cwFRieCAsY4In3R9oWNhQ6UlRaOzfQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ikcBzU6tKFnrZrt+f4Q8ymlBmiQZTolW+UtjIY3RwdvKLHYeufsKve6d4Xr+NdUTB
	 pjNKXWyLUWaFwJ8Tc3o/JLX08L8W4U9dHZOTj41jfNM708E4I4FXMCqnVy6+VVDzrS
	 kEkCak8xh8xRCRQE33WBA+6mzYi4Jtcutm5UsiczC75002CCOSfUI401a/SJlUOVw3
	 5hkcP7CxalE3KRc9raxaLGTCYmdkXwuiYo307IffxnIODbY146BeAgw8tTcHvqIhqC
	 uPpDRnynk+cjmkU4rsaCVC3OvreGLN8DOGOzfve+8GlYDBxfw1Xl1PUJcvlhLwV364
	 BRqpTu2lJbApw==
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
Subject: [PATCH 02/58] objtool/klp: Check the klp test environment once, before any test
Date: Fri, 11 Sep 2026 11:42:09 -0700
Message-ID: <20260911184305.1457308-3-song@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911184305.1457308-1-song@kernel.org>
References: <20260911184305.1457308-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Every test checked for itself that objtool exists, was built with klp
support, and that $CC runs.  Three problems with that: it is the same work
done 40 times, a missing objtool reads as a per-test skip rather than as a
suite which cannot run, and a run in which everything skipped still exits
0.

Do it once, before any test, in preflight.sh, and record the answers where
the tests can read them.  If the suite cannot run the whole run fails and
says why; a test which gets as far as running can assume its environment.

The recorded file is required, not optional: a test which cannot tell where
objtool is or which architecture it is on should say so rather than guess
at an empty value.  It also records which compiler it describes, so a
single test run by hand with a different CC after a full run cannot quietly
inherit the other one's environment.

preflight answers only whether the suite can run at all -- not what the
compiler is capable of.  A test needing a particular compiler feature
probes for it and skips; that costs one compile and keeps the reason next
to the test that has to justify it.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 tools/objtool/Makefile           |   3 +-
 tools/objtool/tests/lib.sh       | 114 ++++++++++++++++++++++++++-----
 tools/objtool/tests/run-tests.sh |   7 ++
 3 files changed, 106 insertions(+), 18 deletions(-)

diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index f4ec9f813a20..2c200d05c276 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -152,7 +152,8 @@ mrproper: clean
 	$(call QUIET_CLEAN, objtool) $(RM) $(OBJTOOL)
 
 tests: $(OBJTOOL)
-	$(Q)OBJTOOL=$(abspath $(OBJTOOL)) $(srctree)/tools/objtool/tests/run-tests.sh
+	$(Q)OBJTOOL=$(abspath $(OBJTOOL)) ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) \
+		$(srctree)/tools/objtool/tests/run-tests.sh
 
 FORCE:
 
diff --git a/tools/objtool/tests/lib.sh b/tools/objtool/tests/lib.sh
index 714371232fa3..6e4e54b10865 100644
--- a/tools/objtool/tests/lib.sh
+++ b/tools/objtool/tests/lib.sh
@@ -11,8 +11,98 @@
 TESTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
 FIXTURES_DIR="$TESTS_DIR/fixtures"
 
+# The kernel's convention: CROSS_COMPILE is the one knob, with per-tool
+# overrides for what it does not cover.  objtool itself is always a host binary
+# -- it is built with HOSTCC and only reads ELF -- so an arm64 machine can run
+# the x86 tests against x86 objects given a compiler that emits them.
+#
+# readelf reads any target, so it rarely needs overriding -- and it must stay
+# GNU readelf, whose column layout the assertions parse; llvm-readelf spaces
+# them differently.  BFD's objcopy is usually built for the host's target
+# alone, and llvm-objcopy is the target-agnostic replacement.
+CROSS_COMPILE="${CROSS_COMPILE:-}"
+CC="${CC:-${CROSS_COMPILE}gcc}"
+LD="${LD:-${CROSS_COMPILE}ld}"
+READELF="${READELF:-${CROSS_COMPILE}readelf}"
+OBJCOPY="${OBJCOPY:-${CROSS_COMPILE}objcopy}"
+
 OBJTOOL="${OBJTOOL:-$TESTS_DIR/../objtool}"
-CC="${CC:-gcc}"
+
+# klp_preflight
+#
+# Check the environment once, before any test runs, and report what was found.
+#
+klp_preflight()
+{
+	local tmp tool cc_version host cc_arch
+
+	bail() { echo "Bail out! $*" >&2; exit 1; }
+
+	# A relative $OBJTOOL is relative to the objtool directory, not tests/.
+	[ -x "$OBJTOOL" ] || [ ! -x "$TESTS_DIR/../$OBJTOOL" ] ||
+		OBJTOOL="$TESTS_DIR/../$OBJTOOL"
+
+	[ -x "$OBJTOOL" ] ||
+		bail "objtool not found at '$OBJTOOL' -- build it first"
+
+	"$OBJTOOL" klp 2>&1 | grep -q checksum ||
+		bail "objtool was built without klp support; install libxxhash (>= 0.8) and rebuild"
+
+	command -v "${CC%% *}" >/dev/null || bail "compiler not found: $CC"
+
+	for tool in "$READELF" "$OBJCOPY" "$LD"; do
+		command -v "$tool" >/dev/null || bail "$tool not found"
+	done
+
+	tmp="$(mktemp -d)" || bail "mktemp failed"
+	echo 'int probe(void) { return 0; }' > "$tmp/probe.c"
+	$CC -c -o "$tmp/probe.o" "$tmp/probe.c" 2>/dev/null ||
+		{ rm -rf "$tmp"; bail "$CC cannot compile a trivial object"; }
+
+	# $CC, $ARCH and objtool have to agree about the target, and cross runs
+	# are where they stop agreeing: plain "CC=clang ARCH=x86_64" on an arm64
+	# box selects the x86 tests and then builds arm64 objects, because clang
+	# needs --target= to emit anything but the host's.
+	#
+	# Ask objtool rather than comparing machine names.  It rejects an object
+	# it was not built for -- "unexpected ELF machine type" -- so one check
+	# covers every way the three can disagree, and says so once instead of
+	# failing every test for the same reason.
+	"$OBJTOOL" klp checksum "$tmp/probe.o" >/dev/null 2>&1 ||
+		{ rm -rf "$tmp"
+		  bail "objtool rejects an object built by '$CC'; they target" \
+		       "different architectures (set CROSS_COMPILE, or" \
+		       "--target= for clang)"; }
+
+	# BFD objcopy is usually built for the host's target alone, and
+	# checksum_of() needs it to read the object under test.
+	$OBJCOPY -O binary --only-section=.text "$tmp/probe.o" "$tmp/probe.bin" 2>/dev/null ||
+		{ rm -rf "$tmp"
+		  bail "$OBJCOPY cannot read objects built by '$CC'; install" \
+		       "binutils-multiarch or set OBJCOPY=llvm-objcopy"; }
+	# $ARCH only chooses which directory of tests runs, so it can disagree
+	# with what $CC builds without objtool noticing -- and the result is the
+	# wrong set of tests, quietly.
+	case "$($READELF -hW "$tmp/probe.o" | sed -n 's/.*Machine: *//p')" in
+	*X86-64*|*Intel*80386*)	cc_arch=x86 ;;
+	*AArch64*)		cc_arch=arm64 ;;
+	*)			cc_arch= ;;
+	esac
+	rm -rf "$tmp"
+
+	KLP_TEST_PREFLIGHT=done
+	export OBJTOOL CC KLP_TEST_PREFLIGHT
+
+	cc_version="$($CC --version 2>/dev/null | head -1)"
+	cat <<EOF
+# preflight
+#   objtool   $OBJTOOL (klp: yes)
+#   compiler  $cc_version
+#   arch      $KLP_TEST_ARCH$([ "$arch" = "$host" ] || echo "  (host $host, cross)")
+EOF
+}
+
+[ -n "${KLP_TEST_PREFLIGHT:-}" ] || klp_preflight
 
 # klp-build compiles the kernel this way; klp diff needs per-symbol sections to
 # extract individual functions.
@@ -30,19 +120,9 @@ cleanup() { [ -n "$workdir" ] && rm -rf "$workdir"; }
 # setup [exported symbol...]
 setup()
 {
-	# A relative $OBJTOOL is relative to the objtool directory, not to the
-	# tests which run from tests/.
-	[ -x "$OBJTOOL" ] || [ ! -x "$TESTS_DIR/../$OBJTOOL" ] ||
-		OBJTOOL="$TESTS_DIR/../$OBJTOOL"
-
-	# Not finding objtool is a broken invocation, not an environment which
-	# cannot run the test.  Skipping here would read as a pass.
-	[ -x "$OBJTOOL" ] || fail "objtool not found at '$OBJTOOL', build it first"
-
-	"$OBJTOOL" klp 2>&1 | grep -q checksum ||
-		skip "objtool built without klp support (needs libxxhash)"
-	command -v "${CC%% *}" >/dev/null || skip "no compiler ($CC)"
-
+	# The environment was checked once when this file was sourced, so there
+	# is nothing to verify here: objtool exists at the resolved path, has
+	# klp support, and $CC works.
 	workdir="$(mktemp -d)" || fail "mktemp failed"
 	trap cleanup EXIT
 
@@ -151,9 +231,9 @@ find_thinlto_toolchain()
 	return 1
 }
 
-out_sections() { readelf -S -W "$workdir/out.o" 2>/dev/null; }
-out_relocs()   { readelf -r -W "$workdir/out.o" 2>/dev/null; }
-out_symbols()  { readelf -s -W "$workdir/out.o" 2>/dev/null; }
+out_sections() { $READELF -S -W "$workdir/out.o" 2>/dev/null; }
+out_relocs()   { $READELF -r -W "$workdir/out.o" 2>/dev/null; }
+out_symbols()  { $READELF -s -W "$workdir/out.o" 2>/dev/null; }
 diff_log()     { cat "$workdir/diff.log"; }
 
 assert_section()
diff --git a/tools/objtool/tests/run-tests.sh b/tools/objtool/tests/run-tests.sh
index ab1dea58811e..f6a3e1b7677e 100755
--- a/tools/objtool/tests/run-tests.sh
+++ b/tools/objtool/tests/run-tests.sh
@@ -2,6 +2,9 @@
 # SPDX-License-Identifier: GPL-2.0
 #
 # Run the objtool klp tests.  Each test-*.sh prints one TAP result line.
+#
+# The harness checks the environment once up front and fails the run if the
+# suite cannot execute, rather than letting every test skip and exit 0.
 
 set -u
 
@@ -10,6 +13,10 @@ cd "$(dirname "$0")" || exit 1
 tests=( test-*.sh )
 [ "${tests[0]}" = "test-*.sh" ] && { echo "1..0 # SKIP no tests found"; exit 0; }
 
+# Sourcing the harness runs its preflight, and exports what it found so the
+# tests inherit it rather than working it out again.
+. ./lib.sh
+
 echo "1..${#tests[@]}"
 
 rc=0
-- 
2.53.0-Meta

