Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792689406;
	b=ExxDrfbSWI42xmSnmbI5XOxhu8MUDSXPhk87GKc+2Me9EJrwOpdN87rOJyb3Tdt0Zt6Y
	 mTtrAHXKQpdhP+pHp2y1jcKxILYenaMz47I4WFpkymouithzHxBdskVMevSBaxOJadIkc
	 9S1GsT5C3Zse2MCDKCrxO1KGkF/J/A9SKgIYDBJFZNxpM1ebNgngtPzOj0I2GMNWJIRUW
	 73IehIHRQHWFVjrUkK2uvo32c1uom3T7x8bWkcu73LETRR7+4QlaxFL+TVZEQtFJroHrY
	 sq9+srVBHTejxlH09CeohyBbW9pHuZ42P0AkOfv5kdZk43vlRnk3SFQ8dW9S9vjonEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792689406;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=X8EDNZK3TwiBBv/3UpD8YkVb+QlAU701/SgIOk/BH8k=;
	b=z9kGnlIC1YWsYR/qbgO5ma6OnHhQFTZhsQ9mY7ju8nyTbcWxAwJYj1UkWGTehX72KXRj
	 iWmYK2iJnkaiAJeQ42Jbs6MB5SVSk46gtFTVgU6bbdnwjo/sqbVs+CwPnozgmedeGMQDf
	 Ak8lzvo689POIgzTHOz3wkWYuyjbNR/BUknswwdRp9Be6itqTdKhmDXecJlukkIZwPHqd
	 QTQoj1FAWYYB6Z6YPr7RiE9kfUVMa5K2BTdWE8Tl48Z23Bw0YK1eRk5ejxq5sAyKJ2EJM
	 1SJc1tMrqtf0+O1VLGy3if5G07A28OTCYDo103VNuGEd56KpcL4HI+IoxjA5N7y6rLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZfJOyGHz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA50606A31D
	for <live-patching@vger.kernel.org>; Thu, 22 Oct 2026 17:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZfJOyGHz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32EF51F01825;
	Thu, 22 Oct 2026 17:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792689405;
	bh=X8EDNZK3TwiBBv/3UpD8YkVb+QlAU701/SgIOk/BH8k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZfJOyGHzgtt0+k2PoLUfqoFtyFvYsBlaeLp0Gp4B8/nZ78oiBFBWLSVhO9iefo5uA
	 bnPMaHe+er0sSFgnEhPwmpX9sXA0wVJjSKga9+EEX1Rq00Tv+QT5Kk9VW8ak5Srbx8
	 UTcFrvTgTx4fjI3ig6IngsEuS2eovMwNVe/UFclDp2l8++H7ezyw2MSrLXq2Sz3MxA
	 1kJVmtP9CmQdw3Q2wmw1Ma/y4n/gcP5iGTVE/6m7ANR5+ubJy8/WjiiIdnb6g3+fmH
	 yFY4AWnYEiPGgSmiCXAqfF0bvx68CVhYZ9oNDrRySR4AQ70IKNRfLOeVN1Fk4v3CCN
	 AlPalK5OcbotA==
From: Puranjay Mohan <puranjay@kernel.org>
To: live-patching@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Song Liu <song@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Joe Lawrence <joe.lawrence@redhat.com>
Subject: [PATCH v2 1/3] objtool/klp: Build test fixtures with ftrace
Date: Thu, 22 Oct 2026 10:16:34 -0700
Message-ID: <20261022171637.3298443-2-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261022171637.3298443-1-puranjay@kernel.org>
References: <20261022171637.3298443-1-puranjay@kernel.org>
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
 .../tests/x86/test-special-sections.sh        | 12 +++++-
 6 files changed, 61 insertions(+), 14 deletions(-)

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
index 8dfaa4fc9a360..e3db038b4cdbe 100755
--- a/tools/objtool/tests/x86/test-special-sections.sh
+++ b/tools/objtool/tests/x86/test-special-sections.sh
@@ -15,7 +15,7 @@
 
 
 # section, entry size, relocations per entry
-for spec in "__bug_table 12 1" "__ex_table 12 2" "__mcount_loc 8 1"; do
+for spec in "__bug_table 12 1" "__ex_table 12 2"; do
 	set -- $spec
 	sec=$1
 
@@ -39,4 +39,14 @@ for spec in "__bug_table 12 1" "__ex_table 12 2" "__mcount_loc 8 1"; do
 	cleanup
 done
 
+# __mcount_loc comes from FTRACE_CFLAGS, not from the fixture.
+setup
+build_pair special_sections.c
+assert_input_section __mcount_loc
+run_diff
+
+assert_section __mcount_loc
+assert_reloc_sym __mcount_loc target
+assert_no_reloc_sym __mcount_loc other
+
 pass "__bug_table, __ex_table and __mcount_loc entries extracted"
-- 
2.53.0-Meta

