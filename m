Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B5D1E51E0
	for <live-patching@vger.kernel.org>; Fri, 11 Sep 2026 18:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789152249; cv=none; b=nts7okcEAxE0xIdYvegnBzebV/HuAvEjpKDR6BJftiz9JNGCTTx3/cTTQ+kZRHkKMAJs0FNCQkVQ4X4AgfzcdRU2YPoEzy52ihB2bm/VWA+xufu/GJBZGc1pc8rJKtd2Trua5o+oRMnc7L9cVPQtpia1u0QlMc3IFldwdiBeEfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789152249; c=relaxed/simple;
	bh=UtbA3kDccrKhOUvDPlkUZaFnii7UUd67+Kmi0zZjMCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rjdfvilGlQT1KKhoYp/aRaWyKkVAuAC2gzuIpx4/yzBF0uCbDwkdcJHtiCEGZrqizX2jHwbjIVcMg9hkN2dop2YxhxuF69DnPtJ7fB0GSpM9GdNii3soBWfGYfNqLeR8lesdu/f3XgmdD5UtO8nuLr5UFm9cVe7R4cZ7M7d9nrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LqzSTy6r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LqzSTy6r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F4E61F00893;
	Fri, 11 Sep 2026 18:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789152243;
	bh=yJj3LKAVNzoBCdHb/dFCuUxdV+hkl8YYbS9ZC8Oco4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LqzSTy6r/P84jAqnXz5DsRwk+T7cp8C/MjS822qZV/OrFYaR7kiFdPah27WKBxX23
	 r7+Kf1AgK8QapxXNY35JO139o33HW7UnhDgVRZ5Uy9YFNax3u7ildxEnZJGter5F0I
	 rHMS7/R0eYQSXL/dms6hE/Kk0KUqPF9SGqswlDS2RHUoBANjXn1IO+d8AAYNhn/NQb
	 onOTfBw+DNWw1dVacog4ikGNfWvt2iRx3xSlwYObOBI8zZ49GEhb1sn2bR5dLz8bqH
	 Y3O4G6hS3cuasKS7L9vjpjP1YwtAPowQED9jeXzEBRKPZdbjoiGxi4ZJeZrEkDU8Fc
	 2DEwMoPaPkPqQ==
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
Subject: [PATCH 05/58] objtool/klp: Build klp test fixtures through the harness
Date: Fri, 11 Sep 2026 11:42:12 -0700
Message-ID: <20260911184305.1457308-6-song@kernel.org>
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

Compiling a fixture is the one thing every test does, and it has more
invariants than it looks.

  - The flags describe the kernel a fixture stands in for, and each is
    written down with its reason.  That substitution is the whole mechanism
    by which these tests cover configurations without building a kernel --
    objtool reads no .config, so a configuration reaches it only as
    compiler flags and the bytes they produce -- and a flag with no stated
    motive is indistinguishable from a mistake.

  - -c is not one of them.  Producing an object rather than a program is
    the helper's contract, not something a test may reconsider, so it lives
    at the compile and an override cannot drop it.

  - A fixture which will not compile is a failure, not a skip.  It is far
    more often a mistake in the fixture than a compiler which cannot
    express the construct, and the two are indistinguishable once reported
    as a skip.

  - A newly produced object has no checksums in it, so producing one
    invalidates the record that checksumming has already been done.  Left
    to itself that invariant ends up in each test which rebuilds.

build_one handles a single object for the tests which need more than two or
different names; build_pair and build_module_pair are expressed in terms of
it, so none of the above can be lost by going around them.

run_checksum comes out of run_diff for the same reason: a test which wants
checksums without a diff should not have to run one.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 tools/objtool/tests/lib.sh | 175 +++++++++++++++++++++++++++++++++----
 1 file changed, 156 insertions(+), 19 deletions(-)

diff --git a/tools/objtool/tests/lib.sh b/tools/objtool/tests/lib.sh
index 7185198253bb..0a9da178f4dc 100644
--- a/tools/objtool/tests/lib.sh
+++ b/tools/objtool/tests/lib.sh
@@ -125,13 +125,26 @@ EOF
 
 [ -n "${KLP_TEST_PREFLIGHT:-}" ] || klp_preflight
 
-# klp-build compiles the kernel this way; klp diff needs per-symbol sections to
-# extract individual functions.
-FIXTURE_CFLAGS="-c -O2 -ffunction-sections -fdata-sections -fno-asynchronous-unwind-tables"
+# What every fixture is built with.  These describe the kernel a fixture stands
+# in for; -c is build_one's contract rather than a property of that kernel, so
+# it lives at the compile where an override cannot drop it.
+#
+#   -O2					the kernel's default
+#   -ffunction-sections -fdata-sections	klp-build passes these itself, through
+#					KCFLAGS, whatever the configuration
+#   -fno-asynchronous-unwind-tables	arch/x86/Makefile sets this always, so
+#					kernel objects carry no .eh_frame
+#
+# A test overrides it; see tools/objtool/Documentation/klp-write-tests.txt.
+FIXTURE_CFLAGS="-O2 -ffunction-sections -fdata-sections \
+		-fno-asynchronous-unwind-tables"
 
 test_name="$(basename "$0" .sh)"
 workdir=
 
+orig_obj=orig.o
+patched_obj=patched.o
+
 pass() { echo "ok - $test_name${1:+: $1}"; exit 0; }
 fail() { echo "not ok - $test_name: $1"; exit 1; }
 
@@ -211,17 +224,64 @@ clang_only()
 	declared_skip "clang only${1:+: $1}"
 }
 
+# build_one <fixture.c> <output object> [cflags...]
+build_one()
+{
+	local fixture out
+	fixture="$FIXTURES_DIR/$1"
+	out="$workdir/$2"
+	shift 2
+
+	[ -f "$fixture" ] || fail "missing fixture $fixture"
+
+	# run_checksum only runs once per workdir.  A fresh object has no
+	# checksums in it, so anything built now needs that to happen again.
+	rm -f "$workdir/.checksummed"
+
+	$CC -c $FIXTURE_CFLAGS "$@" -o "$out" "$fixture" 2>"$workdir/cc.log" ||
+		fail "$(basename "$fixture") does not build: $(tail -1 "$workdir/cc.log")"
+}
+
 # build_pair <fixture.c> [cflags...]
 build_pair()
 {
-	local fixture="$FIXTURES_DIR/$1"; shift
+	local fixture="$1"; shift
 
-	[ -f "$fixture" ] || fail "missing fixture $fixture"
+	build_one "$fixture" orig.o "$@"
+	build_one "$fixture" patched.o "$@" -DPATCHED
+}
 
-	$CC $FIXTURE_CFLAGS "$@" -o "$workdir/orig.o" "$fixture" 2>"$workdir/cc.log" ||
-		probe_skip "fixture does not build here: $(tail -1 "$workdir/cc.log")"
-	$CC $FIXTURE_CFLAGS "$@" -DPATCHED -o "$workdir/patched.o" "$fixture" 2>"$workdir/cc.log" ||
-		probe_skip "fixture does not build here: $(tail -1 "$workdir/cc.log")"
+# run_objtool_check <objtool arguments...>
+#
+# Run objtool's ordinary check pass over the pair, as the kernel build does.
+#
+# Some of what klp diff consumes is produced by this pass rather than by the
+# compiler: .static_call_sites, .mcount_loc, .ibt_endbr_seal, ORC.
+#
+# Only module objects see it before klp-build -- with CONFIG_KLP_BUILD the
+# per-object pass is deferred, so built-in objects reach klp diff exactly as
+# the compiler left them.
+run_objtool_check()
+{
+	local obj
+
+	for obj in "$orig_obj" "$patched_obj"; do
+		"$OBJTOOL" "$@" "$workdir/$obj" ||
+			fail "objtool $* failed on $obj"
+	done
+}
+
+run_checksum()
+{
+	# Checksums live in the objects, so only generate them once even when a
+	# test diffs the same pair again with a different Module.symvers.
+	[ -e "$workdir/.checksummed" ] && return 0
+
+	"$OBJTOOL" klp checksum "$workdir/$orig_obj" ||
+		fail "klp checksum $orig_obj failed"
+	"$OBJTOOL" klp checksum "$workdir/$patched_obj" ||
+		fail "klp checksum $patched_obj failed"
+	touch "$workdir/.checksummed"
 }
 
 # run_diff [expected exit status]
@@ -229,18 +289,10 @@ run_diff()
 {
 	local expect="${1:-0}" rc=0
 
-	# Checksums live in the objects, so only generate them once even when a
-	# test diffs the same pair again with a different Module.symvers.
-	if [ ! -e "$workdir/.checksummed" ]; then
-		"$OBJTOOL" klp checksum "$workdir/orig.o" ||
-			fail "klp checksum orig.o failed"
-		"$OBJTOOL" klp checksum "$workdir/patched.o" ||
-			fail "klp checksum patched.o failed"
-		touch "$workdir/.checksummed"
-	fi
+	run_checksum
 
 	# klp diff looks for Module.symvers relative to the working directory.
-	( cd "$workdir" && "$OBJTOOL" klp diff orig.o patched.o out.o ) \
+	( cd "$workdir" && "$OBJTOOL" klp diff "$orig_obj" "$patched_obj" out.o ) \
 		> "$workdir/diff.log" 2>&1 || rc=$?
 
 	[ "$rc" = "$expect" ] ||
@@ -261,10 +313,95 @@ partial_link()
 {
 	local out="$1"; shift
 
+	rm -f "$workdir/.checksummed"
+
 	$CC -r -nostdlib -o "$out" "$@" 2>/dev/null ||
 		$CC -r -nostdlib -fuse-ld=lld -o "$out" "$@" 2>/dev/null
 }
 
+# link_vmlinux <output> <object...>
+#
+# Link objects into an executable, the way the kernel's final link produces
+# vmlinux from vmlinux.o.  Entry point 0 and no libc: nothing runs it, it only
+# has to be a linked image with resolved addresses.
+#
+# The sub-sections have to come out in name order rather than object order,
+# the way the kernel's linker script gathers .text.unlikely and .data.. apart
+# from the rest.  That reordering is the entire reason .klp.symid exists: a
+# link which preserves order cannot tell a correct sympos from one that merely
+# counted, and the caller checks the two orders really did diverge.
+#
+# A linker script rather than --sort-section=name, because lld accepts that
+# option and ignores it -- so on a host where only lld can link the target, the
+# test would quietly stop testing the thing it is named for.
+#
+# Three attempts because a cross run has neither $LD nor the compiler's default
+# linker able to touch the target: on an arm64 host linking x86 objects, only
+# lld will do it.
+link_vmlinux()
+{
+	local out="$1" lds="$workdir/sort.lds"; shift
+
+	echo 'SECTIONS { .data : { *(SORT_BY_NAME(.data.*)) } }' > "$lds"
+
+	$LD -e 0 -T "$lds" -o "$out" "$@" 2>/dev/null ||
+		$CC -nostdlib -Wl,-e,0 -Wl,-T,"$lds" \
+			-o "$out" "$@" 2>/dev/null ||
+		$CC -nostdlib -fuse-ld=lld -Wl,-e,0 -Wl,-T,"$lds" \
+			-o "$out" "$@" 2>/dev/null
+}
+
+# make_vmlinux_pair <orig object...> -- <patched object...>
+#
+# Build the vmlinux.o / vmlinux pair klp diff needs to resolve sympos the way
+# it does for built-in code, and point the diff at it.
+#
+# For a module, sympos is a count in symbol table order, which klp diff can do
+# from the object alone.  vmlinux is different: the final link reorders
+# sub-sections, so the position comes from the linked image, bridged by
+# .klp.symid.  klp diff only looks for that when the object it was handed is
+# called vmlinux.o and a vmlinux sits beside it -- so both the name and the
+# linked image matter.
+make_vmlinux_pair()
+{
+	local orig=() patched=() seen= arg
+
+	for arg in "$@"; do
+		if [ "$arg" = -- ]; then seen=y; continue; fi
+		if [ -n "$seen" ]; then patched+=( "$arg" ); else orig+=( "$arg" ); fi
+	done
+
+	partial_link "$workdir/vmlinux.o" "${orig[@]}" ||
+		probe_skip "partial link unavailable"
+	partial_link "$workdir/patched.o" "${patched[@]}" ||
+		probe_skip "partial link unavailable"
+
+	"$OBJTOOL" --klp-symids --link "$workdir/vmlinux.o" ||
+		fail "objtool --klp-symids failed"
+
+	link_vmlinux "$workdir/vmlinux" "$workdir/vmlinux.o" ||
+		probe_skip "cannot link a vmlinux here"
+
+	orig_obj=vmlinux.o
+}
+
+# build_module_pair <fixture.c> <module name> [cflags...]
+#
+# Build the pair as objects belonging to a module rather than to vmlinux.  klp
+# diff reads the object's module name from .modinfo, and that decides which
+# object a relocation is attributed to and whether a reference counts as
+# cross-module, so a good deal of the code has a module path the vmlinux
+# fixtures never reach.
+#
+# The fixture defines its .modinfo name from MODNAME.  Passing that through
+# -D needs two levels of quoting, which is easy to get wrong at the call site.
+build_module_pair()
+{
+	local fixture="$1" modname="$2"; shift 2
+
+	build_pair "$fixture" -DMODNAME="\"$modname\"" "$@"
+}
+
 # find_thinlto_toolchain
 #
 # Set $THIN_LD to an lld from the same LLVM release as $CC (or THIN_CC).  A
-- 
2.53.0-Meta

