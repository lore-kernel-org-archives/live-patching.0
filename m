Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792671965;
	b=vTpDPIF5MfxU+/Jj3zIJhDPLKBEYIBzmbNHuHQ9C2RLMlY1TsHQAns5Qe8SIsl+Q38x4
	 PD5yfkPCPNGfEsB9H/Y2G/lSCoCJgiznuhrGrmNi0c93IOI5wxHEbUASjbaZEBgyPY4Oh
	 bliLKkI+D0OXNIgHhS76dzsr/HDEmZaOoR5KhmeN+vy7fbm3adTaNKz4qkYJAbSCu3eaz
	 OO8Mjqnh8RemPmW6ymynLHZzxffgXB0Nblgqo+TgQWT7rUZKHO3X5sj0HpubhmnSdu6+D
	 xIX1rlMCedHaBxzmP4wl+0DUDdIyOnsFo9DliiM8s55R/dME/TlfSgCJdmW1BX9SxDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792671965;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=JM1VgtUG4vpigIvZQHoVorwtbzhtQfFQCuqe9Xbt9SY=;
	b=ZsOLKQglJM6JzCkrr3tDHvj54DkQidLvTgMZIDwpZLGAmQEjs3xr9bDwFBdeZLXDrTtc
	 RF5zydG+mZcAL4jrlNqhGUCBZJIBhxkUeRVQcuMiLEwahVLG2NQJ70lxnXFMeWfZmdiFJ
	 AJGVFrTL4tpCn3ovQYzg9uVEbnD4ycLJb5QP/VgqATRoOs2AA6yZaJitw3PxfwmnRbqy+
	 lGHYmDrhB9iJGCDSTu4pnIp6+kCFG6rsp1cYek+7fYi4i+ky5qobLpPB+QsYf+nxHdNvS
	 ASZWBT2V60PEHm8TS+4aDgu8UxGTvIj4RuvmSJvjxuO6upNx39B1XdWHdSd9++BzH5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mEko9ofL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62917606A319
	for <live-patching@vger.kernel.org>; Thu, 22 Oct 2026 12:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mEko9ofL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A90A91F000C3;
	Thu, 22 Oct 2026 12:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792671964;
	bh=JM1VgtUG4vpigIvZQHoVorwtbzhtQfFQCuqe9Xbt9SY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mEko9ofL/y1oVbt70IIRqx2pWeukDQ/xEKI+X6lMG3VI/iPcUgd0oXKuat/6Tw8se
	 OJnlN9Otc1PN7GZj9eiqWt+Y+BYCgE4jGHFnVtM+DXlYgF499P9G1eKI/+cmT8gGnN
	 f5i5hcYDfw8WH0Azr6yrcRLGlkiFGBwbxXrf6zVe6/xRjXjup8uZFnZ/POsbkgOm/Z
	 uSGFjFVHdDs5pUdEqRteQ4WMWMgehY2nO8Uv8+06ToiEbWCeTlOVNbgFpu3LLVGq4j
	 IX/kdKU2ieHMueE8fGZxrkqSKIxcrJjFvGSEYuZewcrpZ6QaY8hkEzA8KheVzfgaD9
	 sCNu2x1vpbIQg==
From: Puranjay Mohan <puranjay@kernel.org>
To: live-patching@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Song Liu <song@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Joe Lawrence <joe.lawrence@redhat.com>
Subject: [PATCH 1/3] objtool/klp: Build test fixtures with ftrace
Date: Thu, 22 Oct 2026 05:25:36 -0700
Message-ID: <20261022122544.125305-2-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261022122544.125305-1-puranjay@kernel.org>
References: <20261022122544.125305-1-puranjay@kernel.org>
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

Livepatch depends on ftrace, so the kernel klp-build operates on always
has __mcount_loc, but the test fixtures are built without it.

On x86, build them with -pg -mfentry and generate __mcount_loc like the
kernel does: with -mrecord-mcount -mnop-mcount if the compiler supports
it (FTRACE_MCOUNT_USE_CC), otherwise with objtool --mcount --mnop
(FTRACE_MCOUNT_USE_OBJTOOL).

test-checksum-alt ran objtool --mcount only to get insn->alts, which
"klp checksum" builds by itself, and that now warns about the existing
__mcount_loc.  Remove it.

test-special-sections can now check the real __mcount_loc instead of a
hand-written one.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 .../objtool/Documentation/klp-write-tests.txt |  9 ++--
 .../tests/generic/test-thinlto-ambiguity.sh   |  3 +-
 .../tests/generic/test-thinlto-local.sh       |  5 ++-
 tools/objtool/tests/lib.sh                    | 42 +++++++++++++++++--
 tools/objtool/tests/x86/test-checksum-alt.sh  |  4 --
 .../tests/x86/test-special-sections.sh        | 23 ++++++----
 6 files changed, 64 insertions(+), 22 deletions(-)

diff --git a/tools/objtool/Documentation/klp-write-tests.txt b/tools/objtool/Documentation/klp-write-tests.txt
index eb2cacaf57207..7cc2148083cc2 100644
--- a/tools/objtool/Documentation/klp-write-tests.txt
+++ b/tools/objtool/Documentation/klp-write-tests.txt
@@ -116,9 +116,12 @@ Traps that have bitten before
   section entsize or annotations".  Their targets need real (global) symbols,
   or it reports "failed to convert reloc sym".
 * **Prefer letting objtool generate what objtool generates.**
-  ``.static_call_sites``, ``.mcount_loc``, ``.ibt_endbr_seal`` and ORC come
-  from its check pass.  Call ``run_objtool_check --mcount`` and let it build
-  them; a hand-written copy tests your reading of the format, not the format.
+  ``.static_call_sites``, ``.ibt_endbr_seal`` and ORC come from its check
+  pass.  Call ``run_objtool_check`` with the option for what you need and let
+  it build them; a hand-written copy tests your reading of the format, not the
+  format.
+* **Fixtures are built with ftrace.**  Objects not built with ``build_one``
+  need ``$FTRACE_CFLAGS`` and ``record_mcount`` too.
 
   Write one by hand only when the test needs a shape objtool will not produce,
   and say so in the fixture.  generic/fixtures/static_call.c does: objtool
diff --git a/tools/objtool/tests/generic/test-thinlto-ambiguity.sh b/tools/objtool/tests/generic/test-thinlto-ambiguity.sh
index 34f4f3a58e201..73740c804d54f 100755
--- a/tools/objtool/tests/generic/test-thinlto-ambiguity.sh
+++ b/tools/objtool/tests/generic/test-thinlto-ambiguity.sh
@@ -38,12 +38,13 @@ build_thinlto()		# $1 output object, $2 extra flags
 {
 	local t
 	for t in "" -DTU_B -DTU_C; do
-		$THIN_CC -flto=thin -O2 -ffunction-sections -fdata-sections \
+		$THIN_CC -flto=thin -O2 -ffunction-sections -fdata-sections $FTRACE_CFLAGS \
 			$2 $t -c "$FIXTURES_DIR/thinlto_ambiguity.c" \
 			-o "$workdir/tu$t.o" 2>/dev/null || return 1
 	done
 	"$THIN_LD" -r "$workdir/tu.o" "$workdir/tu-DTU_B.o" "$workdir/tu-DTU_C.o" \
 		-o "$1" 2>/dev/null || return 1
+	record_mcount "$1"
 }
 
 build_thinlto "$workdir/orig.o" "" ||
diff --git a/tools/objtool/tests/generic/test-thinlto-local.sh b/tools/objtool/tests/generic/test-thinlto-local.sh
index a266263676ed5..090c6df75ad64 100755
--- a/tools/objtool/tests/generic/test-thinlto-local.sh
+++ b/tools/objtool/tests/generic/test-thinlto-local.sh
@@ -15,11 +15,12 @@ find_thinlto_toolchain ||
 
 build_thinlto()		# $1 output object, $2 extra flags
 {
-	$THIN_CC -flto=thin -O2 -ffunction-sections -fdata-sections $2 \
+	$THIN_CC -flto=thin -O2 -ffunction-sections -fdata-sections $FTRACE_CFLAGS $2 \
 		-c "$FIXTURES_DIR/thinlto_local.c" -o "$workdir/tu_a.o" 2>/dev/null || return 1
-	$THIN_CC -flto=thin -O2 -ffunction-sections -fdata-sections $2 -DTU_B \
+	$THIN_CC -flto=thin -O2 -ffunction-sections -fdata-sections $FTRACE_CFLAGS $2 -DTU_B \
 		-c "$FIXTURES_DIR/thinlto_local.c" -o "$workdir/tu_b.o" 2>/dev/null || return 1
 	"$THIN_LD" -r "$workdir/tu_a.o" "$workdir/tu_b.o" -o "$1" 2>/dev/null || return 1
+	record_mcount "$1"
 }
 
 build_thinlto "$workdir/orig.o" "" ||
diff --git a/tools/objtool/tests/lib.sh b/tools/objtool/tests/lib.sh
index 4da168d0ddca3..d07eb07d15611 100644
--- a/tools/objtool/tests/lib.sh
+++ b/tools/objtool/tests/lib.sh
@@ -41,7 +41,7 @@ OBJTOOL="${OBJTOOL:-$TESTS_DIR/../objtool}"
 #
 klp_preflight()
 {
-	local tmp tool cc_version arch host cc_arch
+	local tmp tool cc_version arch host cc_arch mcount=
 
 	bail() { echo "Bail out! $*" >&2; exit 1; }
 
@@ -99,6 +99,16 @@ klp_preflight()
 	*AArch64*)		cc_arch=arm64 ;;
 	*)			cc_arch= ;;
 	esac
+
+	# Same test as FTRACE_MCOUNT_USE_CC.
+	if [ "$cc_arch" = x86 ]; then
+		if $CC -pg -mfentry -mrecord-mcount -mnop-mcount -c \
+			-o "$tmp/probe.o" "$tmp/probe.c" 2>/dev/null; then
+			mcount=cc
+		else
+			mcount=objtool
+		fi
+	fi
 	rm -rf "$tmp"
 
 	# Normalize to the kernel's SRCARCH.
@@ -119,8 +129,9 @@ klp_preflight()
 		     "the $arch tests would run against the wrong architecture"
 
 	KLP_TEST_ARCH="$arch"
+	KLP_TEST_MCOUNT="$mcount"
 	KLP_TEST_PREFLIGHT=done
-	export OBJTOOL CC KLP_TEST_ARCH KLP_TEST_PREFLIGHT
+	export OBJTOOL CC KLP_TEST_ARCH KLP_TEST_MCOUNT KLP_TEST_PREFLIGHT
 
 	cc_version="$($CC --version 2>/dev/null | head -1)"
 	cat <<EOF
@@ -128,6 +139,7 @@ klp_preflight()
 #   objtool   $OBJTOOL (klp: yes)
 #   compiler  $cc_version
 #   arch      $KLP_TEST_ARCH$([ "$arch" = "$host" ] || echo "  (host $host, cross)")
+#   mcount    ${KLP_TEST_MCOUNT:-n/a}
 #   tmpdir    ${TMPDIR:-/tmp}  (each test builds in a fresh directory here)
 EOF
 }
@@ -153,6 +165,16 @@ EOF
 FIXTURE_CFLAGS="-O2 -ffunction-sections -fdata-sections -fno-common \
 		-fno-asynchronous-unwind-tables"
 
+# Build with ftrace, which livepatch depends on.  Objects not built with
+# build_one() need FTRACE_CFLAGS and record_mcount() too.
+FTRACE_CFLAGS=
+if [ "$KLP_TEST_ARCH" = x86 ]; then
+	FTRACE_CFLAGS="-pg -mfentry"
+	[ "$KLP_TEST_MCOUNT" = cc ] &&
+		FTRACE_CFLAGS="$FTRACE_CFLAGS -mrecord-mcount -mnop-mcount"
+fi
+FIXTURE_CFLAGS="$FIXTURE_CFLAGS $FTRACE_CFLAGS"
+
 test_name="$(basename "$0" .sh)"
 workdir=
 
@@ -343,6 +365,20 @@ build_one()
 
 	$CC -c $FIXTURE_CFLAGS "$@" -o "$out" "$fixture" 2>"$workdir/cc.log" ||
 		fail "$(basename "$fixture") does not build: $(tail -1 "$workdir/cc.log")"
+
+	record_mcount "$out"
+}
+
+# record_mcount <object>
+#
+# FTRACE_MCOUNT_USE_OBJTOOL.  CONFIG_KLP_BUILD always runs objtool with --link.
+record_mcount()
+{
+	[ "$KLP_TEST_MCOUNT" = objtool ] || return 0
+
+	"$OBJTOOL" --mcount --mnop --link "$1" 2>"$workdir/objtool.log" ||
+		fail "objtool --mcount failed on $(basename "$1"):" \
+		     "$(tail -1 "$workdir/objtool.log")"
 }
 
 # build_pair <fixture.c> [cflags...]
@@ -365,7 +401,7 @@ build_pair()
 # Run objtool's ordinary check pass over the pair, as the kernel build does.
 #
 # Some of what klp diff consumes is produced by this pass rather than by the
-# compiler: .static_call_sites, .mcount_loc, .ibt_endbr_seal, ORC.
+# compiler: .static_call_sites, .ibt_endbr_seal, ORC.
 #
 # Only module objects see it before klp-build -- with CONFIG_KLP_BUILD the
 # per-object pass is deferred, so built-in objects reach klp diff exactly as
diff --git a/tools/objtool/tests/x86/test-checksum-alt.sh b/tools/objtool/tests/x86/test-checksum-alt.sh
index 74ebfca2b3ff3..eb9864c4bf825 100755
--- a/tools/objtool/tests/x86/test-checksum-alt.sh
+++ b/tools/objtool/tests/x86/test-checksum-alt.sh
@@ -16,9 +16,6 @@
 # the feature bit, so the failure looks like a machine-specific bug rather than
 # a missing patch.
 #
-# insn->alts exists only after objtool's check pass, so the pair goes through
-# that first -- the compiler emits none of this structure itself.
-#
 # Covers the same ground as corpus/x86_64/checksum-alt-group,
 # checksum-alt-no-group and checksum-alt-recursion-guard in Joe Lawrence's
 # klp-build unit test corpus.
@@ -31,7 +28,6 @@ check()
 {
 	build_pair checksum_alt.c "-D$1"
 	assert_input_section .altinstructions
-	run_objtool_check --mcount
 	run_checksum
 
 	assert_checksum_differs target
diff --git a/tools/objtool/tests/x86/test-special-sections.sh b/tools/objtool/tests/x86/test-special-sections.sh
index 8dfaa4fc9a360..b05d43cdc8aa4 100755
--- a/tools/objtool/tests/x86/test-special-sections.sh
+++ b/tools/objtool/tests/x86/test-special-sections.sh
@@ -15,26 +15,31 @@
 
 
 # section, entry size, relocations per entry
-for spec in "__bug_table 12 1" "__ex_table 12 2" "__mcount_loc 8 1"; do
+for spec in "__bug_table 12 1" "__ex_table 12 2"; do
 	set -- $spec
-	sec=$1
 
 	# A fresh workdir per section: run_diff caches its checksums.
 	setup
 	build_pair special_sections.c \
 		-DSPECIAL_SEC="\"$1\"" -DSPECIAL_ENTSIZE="$2" -DSPECIAL_RELOCS="$3"
 
-	assert_input_section "$sec"
+	# __mcount_loc comes from FTRACE_CFLAGS, not from the fixture.
+	for sec in "$1" __mcount_loc; do
+		assert_input_section "$sec"
+	done
 	run_diff
 
-	# Extracted, and pointing at the function that was patched.
-	assert_section "$sec"
-	assert_reloc_sym "$sec" target
 	assert_patched target
-
-	# Nothing belonging to the function that was not.
 	assert_not_patched other
-	assert_no_reloc_sym "$sec" other
+
+	for sec in "$1" __mcount_loc; do
+		# Extracted, and pointing at the function that was patched.
+		assert_section "$sec"
+		assert_reloc_sym "$sec" target
+
+		# Nothing belonging to the function that was not.
+		assert_no_reloc_sym "$sec" other
+	done
 
 	cleanup
 done
-- 
2.53.0-Meta

