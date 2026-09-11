Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32153F8898
	for <live-patching@vger.kernel.org>; Fri, 11 Sep 2026 18:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789152823; cv=none; b=JCRTXDdgh46zTWdFfBPfIds+Md8XFbUsosFt8PZg0nkDPxI5rpaVsYc02Qk0+c8AdXq4BpG/FM8Dk/XL7e0ll+eIDsNcxQwf8dK+ySGxRHBd3zZkr6Evir5145NLE7aK7xDiwlrcXsldI6OBOwscDpY+VWxvxfAHYSjU0n2X1pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789152823; c=relaxed/simple;
	bh=MFYri9wncVANzN37jjvDcsxBjSBjZDYAaDGVhLwU9VE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RSeYp6028BiJB4yTwmE4+mBBotAp0pRFQiP0Eeq9tBhfgU7uyQLy0NPV0OHBdlL5SBfEEdpMufveO/GQMMxCkFMQTFS1yahOxy1uIrCCEdKrOLHdNbuHsNJQ4tn+otws9VnFHMrOQR3yuAuWO1etnDgyPyVPTKS259rO0XJf5TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XKHzbWX4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XKHzbWX4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E55F1F00893;
	Fri, 11 Sep 2026 18:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789152807;
	bh=EMlRYgFfinADI3BghOMUENOFinoQY9kdSD+jcov+/Ps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XKHzbWX4r+y6DecFIbjwpcP7JZRUGTROQtIZqFiLi8qwRrJ6HNUJp2s1isUr/+fGS
	 Mt4+4gdtRgjG2IHktyl5BZcRnwXcAFsHkZYR0G/X+SdwLr8pBafx//NpTAPhim9MI/
	 i1Ig5es4RH044HrOjt/fR93QW9/dwrhUh7cPhDcoKPFhq82tDs9RQLDEoF/dLKAkdb
	 6yzdZ8pP83pvgjiMaOdvF9T5O9GO9S0nT33SnWFz6+bxWdnUH0JJSxoq1RHMuqYZLf
	 nbpWrOZ7de+XTA2g2TNuuPMDx6PXXWdTG253jU/zmZaSUg3H8gF1BTSIoe8tYYRr3t
	 2qe4JlxmSv4vQ==
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
Subject: [PATCH 58/58] objtool/klp: Add test for ThinLTO symbols sharing a demangled name
Date: Fri, 11 Sep 2026 11:50:31 -0700
Message-ID: <20260911185031.1534046-33-song@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911185031.1534046-1-song@kernel.org>
References: <20260911184305.1457308-1-song@kernel.org>
 <20260911185031.1534046-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A file-local symbol which ThinLTO has to make visible is renamed
helper.llvm.<hash>.  With two such helpers in one link, the original and
the patched object hold two each, all four spelled differently, and
demangling gives "helper" for every one of them -- so the name alone cannot
say which corresponds to which.

Three translation units, two with a static helper of the same name and a
third calling into both, which is what forces the promotion.  Only one
helper changes: paired correctly that means exactly one is cloned, and
paired the wrong way round the other is, or both are.  Had both bodies
changed, both would be cloned either way and the test would prove nothing
-- which is how the first version of this was written.

The outcome is asserted, not the machinery.  With the clang tested here the
pairing survives disabling the .llvm.<hash> suffix map and stubbing out
llvm_suffix() entirely, so no single-line sabotage distinguishes it; the
tiered matcher this case was written for is not needed for this shape.  The
test says so rather than implying otherwise.

Assisted-by: Claude:claude-opus-4
Based-on-test-by: Joe Lawrence <joe.lawrence@redhat.com>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 .../generic/fixtures/thinlto_ambiguity.c      | 55 +++++++++++++
 .../tests/generic/test-thinlto-ambiguity.sh   | 77 +++++++++++++++++++
 2 files changed, 132 insertions(+)
 create mode 100644 tools/objtool/tests/generic/fixtures/thinlto_ambiguity.c
 create mode 100755 tools/objtool/tests/generic/test-thinlto-ambiguity.sh

diff --git a/tools/objtool/tests/generic/fixtures/thinlto_ambiguity.c b/tools/objtool/tests/generic/fixtures/thinlto_ambiguity.c
new file mode 100644
index 000000000000..4a87bc92ea2e
--- /dev/null
+++ b/tools/objtool/tests/generic/fixtures/thinlto_ambiguity.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Three translation units linked with ThinLTO, two of which have a file-local
+ * helper of the same name.
+ *
+ * TU_C calls into both of the others, so ThinLTO imports entry_a and entry_b
+ * and with them the static helper each one calls.  A file-local symbol which
+ * has to become visible is renamed helper.llvm.<hash>, and the hash is content
+ * derived -- so the two helpers get different hashes from each other, and
+ * different ones again after the patch changes them both.
+ *
+ * That leaves klp diff with two symbols in the original and two in the patched
+ * object, all four named differently, which have to be paired up correctly.
+ * Demangling alone gives "helper" for all of them; something else has to
+ * decide which is which.
+ *
+ * Only TU_A's helper changes.  That is what makes a wrong pairing observable:
+ * paired correctly, one helper is changed and the other is not, so exactly one
+ * is cloned.  Paired the wrong way round, both look changed -- or the wrong
+ * one does.  If both bodies changed the outcome would be the same either way
+ * and the test would prove nothing.
+ *
+ * BASE differs between the two so their bodies are not identical to begin
+ * with.
+ */
+
+#if defined(TU_C)
+extern int entry_a(int x);
+extern int entry_b(int x);
+int glue(int x) { return entry_a(x) + entry_b(x + 1); }
+#else
+#ifdef TU_B
+#define ENTRY entry_b
+#define BASE 5
+#else
+#define ENTRY entry_a
+#define BASE 10
+static const char __modinfo[]
+	__attribute__((section(".modinfo"), used, aligned(1))) = "\0name=vmlinux";
+#endif
+static __attribute__((noinline)) int helper(int x, int len)
+{
+	int sum = 0, i;
+
+	for (i = 0; i < len; i++)
+#if defined(PATCHED) && !defined(TU_B)
+		sum += i * 2 + BASE;	/* only TU_A's helper changes */
+#else
+		sum += i + BASE;
+#endif
+	return sum + x;
+}
+
+int ENTRY(int x) { return helper(x, 4); }
+#endif
diff --git a/tools/objtool/tests/generic/test-thinlto-ambiguity.sh b/tools/objtool/tests/generic/test-thinlto-ambiguity.sh
new file mode 100755
index 000000000000..34f4f3a58e20
--- /dev/null
+++ b/tools/objtool/tests/generic/test-thinlto-ambiguity.sh
@@ -0,0 +1,77 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Two ThinLTO-promoted symbols sharing a demangled name must be paired up
+# correctly.
+#
+# A file-local symbol which ThinLTO has to make visible is renamed
+# helper.llvm.<hash>.  With two such helpers in one link the original and the
+# patched object hold two each, all four spelled differently, and demangling
+# gives "helper" for all of them -- so the name is not enough to say which
+# corresponds to which.
+#
+# Getting it wrong is silent and specific: the patch is built against the wrong
+# body, so one call site gets the other helper's arithmetic.  Nothing fails to
+# build and nothing fails to load.
+#
+# test-thinlto-local covers the unambiguous case, one promoted symbol whose
+# hash moved.  This is the case where demangling alone is not an answer.
+#
+# The outcome is asserted, not the machinery: with the clang tested here the
+# pairing succeeds even with the .llvm.<hash> suffix map disabled and with
+# llvm_suffix() stubbed out, so no single-line sabotage distinguishes it.  The
+# tiered matcher this case was written for is not needed for this shape.
+#
+# Covers the same ground as corpus/x86_64-llvm-thinlto/
+# thin-lto-demangled-ambiguity and thin-lto-demangled-global-match in Joe
+# Lawrence's klp-build unit test corpus.
+
+. "$(dirname "$0")/../lib.sh"
+
+setup
+clang_only "ThinLTO requires clang"
+
+find_thinlto_toolchain ||
+	probe_skip "no matching clang/lld pair for a ThinLTO link; set THIN_LD to one"
+
+build_thinlto()		# $1 output object, $2 extra flags
+{
+	local t
+	for t in "" -DTU_B -DTU_C; do
+		$THIN_CC -flto=thin -O2 -ffunction-sections -fdata-sections \
+			$2 $t -c "$FIXTURES_DIR/thinlto_ambiguity.c" \
+			-o "$workdir/tu$t.o" 2>/dev/null || return 1
+	done
+	"$THIN_LD" -r "$workdir/tu.o" "$workdir/tu-DTU_B.o" "$workdir/tu-DTU_C.o" \
+		-o "$1" 2>/dev/null || return 1
+}
+
+build_thinlto "$workdir/orig.o" "" ||
+	probe_skip "ThinLTO build failed ($THIN_CC, $THIN_LD)"
+build_thinlto "$workdir/patched.o" -DPATCHED ||
+	probe_skip "ThinLTO build failed ($THIN_CC, $THIN_LD)"
+
+# The premise: two promoted helpers per object, and exactly one of them kept
+# its hash -- the one the patch did not touch.  Without that there is nothing
+# to disambiguate.
+orig_syms="$(in_symbols orig.o    | grep -oE 'helper\.llvm\.[0-9]+' | sort -u)"
+new_syms="$( in_symbols patched.o | grep -oE 'helper\.llvm\.[0-9]+' | sort -u)"
+[ "$(echo "$orig_syms" | wc -l)" = 2 ] && [ "$(echo "$new_syms" | wc -l)" = 2 ] ||
+	probe_skip "ThinLTO did not promote two distinct helpers here"
+
+kept="$(comm -12 <(echo "$orig_syms") <(echo "$new_syms"))"
+moved="$(comm -13 <(echo "$orig_syms") <(echo "$new_syms"))"
+[ "$(echo "$kept" | wc -w)" = 1 ] && [ "$(echo "$moved" | wc -w)" = 1 ] ||
+	probe_skip "expected one helper to keep its hash and one to move"
+
+run_diff
+
+# Exactly one helper is cloned, and it is the one whose body changed.  Cloning
+# the other, or both, is what a wrong pairing looks like.
+assert_not_patched "$kept"
+
+n="$(out_sections | grep -cE '[[:space:]]\.text\.helper\.llvm\.[0-9]+[[:space:]]')"
+[ "$n" = 1 ] ||
+	fail "expected 1 cloned helper, found $n"
+
+pass "ThinLTO helpers sharing a demangled name paired up correctly"
-- 
2.53.0-Meta

