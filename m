Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAAC4C8C6B
	for <live-patching@vger.kernel.org>; Tue, 15 Sep 2026 23:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789515338; cv=none; b=hupVeRi9gRHFvN29QNNxiiHrqfbTAJt/RBtZmxsTFSULQIabXn6jSR1xadylFlOKdLaTMXlSFsi1yYj6oHwkzQQvkdYFaZro1KwrsRQw/WZykZwOgTBNNuKfGeCns1Kkkq2r+ggpet8pZkeDSA8lxKByDTFRE2fhVEltnl7kffs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789515338; c=relaxed/simple;
	bh=AgQ034alz305eh6BJDEm1qfJZzAzXP1Ks6sAsSr+j1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OP+/YFd0Iv2R0tY+YDEOlf51bmoCybNSxAn+K0lo2OdPEpCgT/6hsfkmf7EUS3yRPoS/yY/VEqW4PIw5nHiCgQt1198nbYmgMyMImS7400UQKiSA35hxeVTvqSbSxJYpq42wg9ETJ3SbU7it2wrB86WCoO2jHRTfsNyxX6/YFdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nnOsOyyc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nnOsOyyc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D31B1F000FF;
	Tue, 15 Sep 2026 23:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789515335;
	bh=Tqk6LKHMq+VnOuOpCz/VwhhQa+qlSkEXjwnHt3+sUkU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nnOsOyycp0MPFFnLGWalasX9HHTfVu4jfB9xoBIDr2HVvMoNCAK0Cr3/+vwzJaPMO
	 On+tqNBedTjX6e9KscvuLDt7uOw5mMh7eK/upix5uppDA3eFV1y2GkeKPQSoQTSn6G
	 70H+8Mtn0FC8KBnyGbc37zWpAmNOA/UHhPswR36hX4Dzub/+1srPIWPhDTr5NGcTS2
	 0rQZMRvsWzp83FaN/0/YwHugx9dn6cppB30/fLesC1x7zIrKmi+/zOc/5Z60o4de/+
	 D43U8i/1DBrHAw5M6l5pbWjX4Hnu5rVYnrYW3oHjE7g9U6uP/iEy+naHEGQWbBK62R
	 R4kHSOXQUvCOA==
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
Subject: [PATCH v4 06/58] objtool/klp: Grow the klp test harness vocabulary
Date: Tue, 15 Sep 2026 16:34:02 -0700
Message-ID: <20260915233454.2405019-7-song@kernel.org>
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

Assertions for what klp diff produces, and for what went into it.

The output side covers the things a livepatch is made of: cloned sections
and symbols, klp symbols and their sympos, tombstones, relocations by
section and by count, the converted .klp.rela sections and their
SHF_RELA_LIVEPATCH flag, SHN_LIVEPATCH symbols, recorded checksums, and klp
diff's own diagnostics -- a rejection for the wrong reason is not a pass.

The input side matters just as much, and is easier to forget.  A test which
asserts only on the output passes when the compiler never emitted the
construct under test, and reads as coverage it does not have.  So there are
two forms, and the difference between them is a statement about why the
thing might be absent:

  require_*  the compiler cannot produce it here     -> skip
  assert_*   the fixture is supposed to produce it   -> fail

Names are quoted before they reach grep.  Nearly every name here contains
dots -- .text.target, .klp.rela.vmlinux -- and an unescaped dot matches any
character, so an assertion for one section could be satisfied by a
different one whose name merely lines up.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 tools/objtool/tests/lib.sh | 364 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 360 insertions(+), 4 deletions(-)

diff --git a/tools/objtool/tests/lib.sh b/tools/objtool/tests/lib.sh
index 9330d839ff85..ffc1efb06233 100644
--- a/tools/objtool/tests/lib.sh
+++ b/tools/objtool/tests/lib.sh
@@ -211,9 +211,42 @@ setup()
 export_syms()
 {
 	: > "$workdir/Module.symvers"
+	add_exports vmlinux "$@"
+}
+
+# add_exports <object> [symbol...]
+#
+# Append exports owned by one object, without clearing what is already there,
+# so a test can describe a kernel where several objects export things.
+#
+# Which object owns a symbol is not cosmetic: a reference to a vmlinux symbol
+# is applied when the patch module loads, and a reference to a module's symbol
+# when that patched module loads, so klp diff files them in different sections.
+add_exports()
+{
+	local owner="$1"; shift
+
+	add_exports_ns "$owner" "" "$@"
+}
+
+# add_exports_ns <object> <namespace> [symbol...]
+#
+# Exports in a symbol namespace, the last field of a Module.symvers line.
+#
+# A "module:<names>" namespace is EXPORT_SYMBOL_FOR_MODULES(), where the module
+# loader grants access by matching the importing module's name against the
+# list.  A livepatch module is never on that list, so such a symbol has to be
+# referenced the way an unexported one is.  Ordinary namespaces are not
+# special here.
+add_exports_ns()
+{
+	local owner="$1" ns="$2"; shift 2
+
+	local sym
+
 	for sym in "$@"; do
-		printf '0x00000000\t%s\tvmlinux\tEXPORT_SYMBOL\t\n' \
-			"$sym" >> "$workdir/Module.symvers"
+		printf '0x00000000\t%s\t%s\tEXPORT_SYMBOL\t%s\n' \
+			"$sym" "$owner" "$ns" >> "$workdir/Module.symvers"
 	done
 }
 
@@ -476,12 +509,87 @@ out_relocs()   { $READELF -r -W "$workdir/out.o" 2>/dev/null; }
 out_symbols()  { $READELF -s -W "$workdir/out.o" 2>/dev/null; }
 diff_log()     { cat "$workdir/diff.log"; }
 
+# out_strings <section>
+#
+# The strings in one section of the output, for the names livepatch matches on.
+out_strings() { $READELF -p "$1" "$workdir/out.o" 2>/dev/null; }
+
+# Checks on the input objects, to run before klp diff.  The two forms differ in
+# what an absent construct means:
+#
+#   require_*  the compiler cannot produce it here	-> skip
+#   assert_*   the fixture is supposed to produce it	-> fail
+
+in_sections() { $READELF -S -W "$workdir/$1" 2>/dev/null; }
+in_symbols()  { $READELF -s -W "$workdir/$1" 2>/dev/null; }
+in_relocs()   { $READELF -r -W "$workdir/$1" 2>/dev/null; }
+
+# count_input_symbols <object> <name>
+#
+# How many object symbols of exactly that name the input has.  Deliberately not
+# a grep: readelf lists section symbols too, and a newer binutils prints their
+# name -- ".data.<name>" -- where an older one leaves the column blank.  A dot
+# is not a word character, so "grep -w <name>" counts that line as well, and
+# the same object gives a different answer depending on which readelf reads it.
+count_input_symbols()
+{
+	in_symbols "$1" | awk -v n="$2" '$4 == "OBJECT" && $8 == n' | wc -l
+}
+
+# re_quote <string>
+#
+# A string as a literal basic regular expression.  Nearly every name these
+# assertions match on contains a dot -- .text.target, .klp.rela.vmlinux -- and
+# an unescaped dot matches any character, so an assertion for one section can be
+# satisfied by a different one whose name merely lines up.
+re_quote() { printf '%s' "$1" | sed 's/[].[^$*\\/]/\\&/g'; }
+
+has_input_section() { in_sections "$1" | grep -q "[[:space:]]$(re_quote "$2")[[:space:]]"; }
+has_input_symbol()  { in_symbols "$1" | awk -v n="$2" '$NF == n' | grep -q .; }
+
+assert_input_section()
+{
+	local obj
+
+	for obj in "$orig_obj" "$patched_obj"; do
+		has_input_section "$obj" "$1" ||
+			fail "fixture produced no section '$1' in $obj"
+	done
+}
+
+assert_input_symbol()
+{
+	local obj
+
+	for obj in "$orig_obj" "$patched_obj"; do
+		has_input_symbol "$obj" "$1" ||
+			fail "fixture produced no symbol '$1' in $obj"
+	done
+}
+
+require_input_section()
+{
+	local obj
+
+	for obj in "$orig_obj" "$patched_obj"; do
+		has_input_section "$obj" "$1" ||
+			probe_skip "compiler produced no section '$1' here"
+	done
+}
+
 assert_section()
 {
-	out_sections | grep -q "[[:space:]]$1[[:space:]]" ||
+	out_sections | grep -q "[[:space:]]$(re_quote "$1")[[:space:]]" ||
 		fail "expected section '$1' in output"
 }
 
+assert_no_section()
+{
+	out_sections | grep -q "[[:space:]]$(re_quote "$1")[[:space:]]" &&
+		fail "unexpected section '$1' in output"
+	return 0
+}
+
 assert_patched()
 {
 	assert_section ".text.$1"
@@ -489,7 +597,255 @@ assert_patched()
 
 assert_not_patched()
 {
-	out_sections | grep -q "[[:space:]].text.$1[[:space:]]" &&
+	out_sections | grep -q "[[:space:]]$(re_quote ".text.$1")[[:space:]]" &&
 		fail "function '$1' should not have been cloned"
 	return 0
 }
+
+# section_relocs <section>
+#
+# The relocations against one section.  readelf prints every relocation section
+# in turn, so a test asking about ".smp_locks" has to cut its block out of the
+# listing first.
+section_relocs()
+{
+	local sec="${1//./\\.}"
+
+	out_relocs | awk "/rela$sec'/,/^\$/"
+}
+
+assert_reloc_sym()
+{
+	section_relocs "$1" | awk -v n="$2" '$5 == n' | grep -q . ||
+		fail "expected a relocation to '$2' in '$1'"
+}
+
+assert_no_reloc_sym()
+{
+	section_relocs "$1" | awk -v n="$2" '$5 == n' | grep -q . &&
+		fail "unexpected relocation to '$2' in '$1'"
+	return 0
+}
+
+# assert_reloc_count <section> <count>
+#
+# Counts relocation entries, not header or blank lines: whether a special
+# section entry was extracted once, twice or not at all is usually the whole
+# question.
+#
+# A count of zero is ambiguous on its own -- a section with no relocations and
+# no section at all both read as zero -- so require the section to exist.  A
+# test expecting nothing there wants assert_no_section.
+assert_reloc_count()
+{
+	local n
+
+	assert_section "$1"
+
+	n="$(section_relocs "$1" | grep -cE '^[0-9a-f]{8,}')"
+	[ "$n" = "$2" ] ||
+		fail "expected $2 relocations in '$1', found $n"
+}
+
+# assert_klp_sym <symbol> [object]
+#
+# A klp symbol is named .klp.sym.<object>.<symbol>,<sympos>.  The object
+# defaults to any, since most tests care that the reference was converted at
+# all rather than which object it resolved against.
+assert_klp_sym()
+{
+	out_symbols | grep -q "\.klp\.sym\.${2:-[^.]*}\.$(re_quote "$1")," ||
+		fail "expected klp symbol for '$1'"
+}
+
+# assert_klp_sympos <symbol> <sympos>
+#
+# The number after the comma in .klp.sym.<object>.<symbol>,<sympos> says which
+# of several same-named symbols livepatch should resolve to, counting from 1;
+# 0 means the name is unique and no disambiguation is needed.  Resolving to the
+# wrong one is not a load failure, it is a patch quietly wired to the wrong
+# object.
+assert_klp_sympos()
+{
+	out_symbols | grep -qE "\.klp\.sym\.[^.]+\.$(re_quote "$1"),$2([[:space:]]|\$)" ||
+		fail "expected klp symbol for '$1' with sympos $2, found:$(
+			out_symbols | grep -o "\.klp\.sym\.[^.]*\.$(re_quote "$1"),[0-9]*" |
+			sort -u | tr '\n' ' ')"
+}
+
+assert_no_klp_sym()
+{
+	out_symbols | grep -q "\.klp\.sym\.${2:-[^.]*}\.$(re_quote "$1")," &&
+		fail "unexpected klp symbol for '$1'"
+	return 0
+}
+
+assert_tombstone()
+{
+	out_symbols | grep -qE "\.klp\.tombstone\.$(re_quote "$1")([[:space:]]|\$)" ||
+		fail "expected a tombstone for '$1'"
+}
+
+assert_symbol()
+{
+	out_symbols | awk -v n="$1" '$NF == n' | grep -q . ||
+		fail "expected symbol '$1' in output"
+}
+
+assert_no_symbol()
+{
+	out_symbols | awk -v n="$1" '$NF == n' | grep -q . &&
+		fail "unexpected symbol '$1' in output"
+	return 0
+}
+
+# assert_diff_log <regex>
+#
+# klp diff's combined output, for tests asserting on a diagnostic.  Error
+# messages are part of the interface when the whole point is that a construct
+# gets rejected, and a rejection for the wrong reason is not a pass.
+assert_diff_log()
+{
+	diff_log | grep -qE -- "$1" ||
+		fail "expected '$1' in klp diff output: $(tail -2 "$workdir/diff.log")"
+}
+
+# checksum_of <object> <symbol>
+#
+# The checksum "klp checksum" recorded for one symbol, as a hex string.
+#
+# .discard.sym_checksum is an array of { u64 addr; u64 checksum; }, where addr
+# is the target of a relocation naming the symbol.  Nothing in the section
+# itself says which symbol an entry belongs to, so the relocation is what
+# locates the entry; the checksum is the eight bytes after it.
+# Callers use this in a command substitution, where fail() would only exit the
+# subshell and the test would carry on with an empty checksum.  So this returns
+# non-zero and prints nothing, and the assertions below check for that.  For
+# the same reason it does not run run_checksum() itself: that one does call
+# fail(), and from in here the message would be captured as the checksum
+# rather than ending the test.  The caller runs it first.
+checksum_of()
+{
+	local obj="$workdir/$1" sym="$2" off
+
+	off="$($READELF -rW "$obj" 2>/dev/null |
+	       awk -v s="$sym" '/rela\.discard\.sym_checksum/,/^$/ {
+			if ($5 == s) { print $1; exit }
+	       }')"
+
+	[ -n "$off" ] || return 1
+
+	$OBJCOPY -O binary --only-section=.discard.sym_checksum \
+		"$obj" "$workdir/checksums.bin" 2>/dev/null || return 1
+
+	dd if="$workdir/checksums.bin" bs=1 skip=$((16#$off + 8)) count=8 \
+		status=none | od -An -tx1 | tr -d ' \n'
+}
+
+# assert_checksum_differs <symbol> / assert_checksum_matches <symbol>
+#
+# Compare what klp checksum recorded for a symbol in the original against the
+# patched object.  This is what decides whether klp diff treats a function as
+# changed, so a test asserting only that the right functions were cloned cannot
+# tell a correct checksum from one which happens to differ.
+checksum_pair()
+{
+	run_checksum
+
+	orig_checksum="$(checksum_of "$orig_obj" "$1")"
+	patched_checksum="$(checksum_of "$patched_obj" "$1")"
+
+	[ -n "$orig_checksum" ] ||
+		fail "no checksum recorded for '$1' in $orig_obj"
+	[ -n "$patched_checksum" ] ||
+		fail "no checksum recorded for '$1' in $patched_obj"
+}
+
+assert_checksum_differs()
+{
+	checksum_pair "$1"
+
+	[ "$orig_checksum" != "$patched_checksum" ] ||
+		fail "checksum for '$1' unchanged at $orig_checksum, expected it to differ"
+}
+
+assert_checksum_matches()
+{
+	checksum_pair "$1"
+
+	[ "$orig_checksum" = "$patched_checksum" ] ||
+		fail "checksum for '$1' changed from $orig_checksum to" \
+		     "$patched_checksum, expected no change"
+}
+
+# run_post_link [expected exit status]
+#
+# klp post-link runs last in a livepatch build, converting the intermediate
+# __klp_relocs.* sections into the .klp.rela.* form the kernel consumes.  It
+# needs nothing but an object containing those sections, which is what klp diff
+# produces, so it runs on out.o here rather than on a built module.  Rewrites
+# out.o in place, so the out_* helpers show the result afterwards.
+run_post_link()
+{
+	local expect="${1:-0}" rc=0
+
+	"$OBJTOOL" klp post-link "$workdir/out.o" \
+		> "$workdir/post-link.log" 2>&1 || rc=$?
+
+	[ "$rc" = "$expect" ] ||
+		fail "klp post-link exited $rc, expected $expect:" \
+		     "$(tail -2 "$workdir/post-link.log")"
+}
+
+# The flags readelf prints for a section, or nothing when it has none.  The
+# leading "[nn]" index is stripped first so the columns can be counted.
+section_flags()
+{
+	out_sections | sed 's/^ *\[[ 0-9]*\] *//' |
+		awk -v s="$1" '$1 == s && $7 ~ /^[A-Za-z]+$/ { print $7 }'
+}
+
+# assert_section_flag <section> <letter>
+#
+# SHF_RELA_LIVEPATCH is OS-specific, so readelf renders it as "o".  A klp rela
+# section which lost it is an ordinary rela section, which the linker may apply
+# and the livepatch code will not.
+assert_section_flag()
+{
+	local flags; flags="$(section_flags "$1")"
+
+	[ -n "$flags" ] ||
+		fail "section '$1' has no flags, expected '$2'"
+	case "$flags" in
+	*"$2"*)	;;
+	*)	fail "section '$1' has flags '$flags', expected '$2'" ;;
+	esac
+}
+
+# assert_klp_rela <object> <section>
+#
+# post-link names the converted sections .klp.rela.<object>.<section>, one per
+# base section.  Also checks SHF_RELA_LIVEPATCH, since the name alone is not
+# what makes the kernel process it.
+assert_klp_rela()
+{
+	local name=".klp.rela.$1.$2"
+
+	out_sections | grep -q "[[:space:]]$(re_quote "$name")[[:space:]]" ||
+		fail "expected section '$name' in output"
+
+	assert_section_flag "$name" o
+}
+
+# assert_livepatch_sym <symbol>
+#
+# Symbols a klp relocation resolves against live in SHN_LIVEPATCH, which
+# readelf prints as "OS [0xff20]" -- llvm-readelf without the space, so match
+# either.  The kernel resolves these itself at patch load; anything else is a
+# symbol the module loader will try, and fail, to resolve normally.
+assert_livepatch_sym()
+{
+	out_symbols | grep -E 'OS ?\[0xff20\]' |
+		grep -qE "\.klp\.sym\.[^.]+\.$(re_quote "$1")," ||
+		fail "expected a klp symbol for '$1' in SHN_LIVEPATCH"
+}
-- 
2.53.0-Meta

