Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858994D2ECE
	for <live-patching@vger.kernel.org>; Tue, 15 Sep 2026 23:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789515521; cv=none; b=M66CYMFbazcnbsLuxEoMWHnAM1U3Sfrm2iQAP/28NTT5MwlY8ZF/QJcrox6m98j6OqVbnxz9mqzZvoisGu8Nc27T88zehS+9G151fQmBUfog+s0EBTiiimmbaz8cGSqTfSJv6iRJrm0EUHrqYhO+kTEqaa+nNWd+BvIoPSFXTO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789515521; c=relaxed/simple;
	bh=tUoVne96ehJd+QvGOb0OXpfSfIIbrRKSyXKMvUvdOcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sxEz0DoJCH54ojw/uiIGBJ2Qla5IrXp+oZkmUs/9xTwEWWszC3V3Ar7h/5NCCjTJxXS3EXE5zZpncroSrIiq3nU3XQSpvHCPBMLeoWNhuvBCIYQZc/CE0yySZonBA08WhhQM/990N0XidThr4vrI9zRcC2Tv0PXKLHY7ONB4KvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xkl4eudP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xkl4eudP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DB2C1F000FF;
	Tue, 15 Sep 2026 23:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789515520;
	bh=J5t5oTyOWAgasVDMf8QOuTh0d/t/ywtRowxjFQPFLXk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Xkl4eudPGzNo7BxKomddo+YXFfcgM5e2HSpLQUfWDrOAHXVXghGq761MvL2V8wchR
	 6y6TWAQ8SOIbkyasqJMlHaQs4bhUzZsnP5Pn/7KKLV2jx3qPasiXMu9WYIkrH2BqHz
	 APXMGQYw4OmJiIhmsUfiHSKC4/cYgxZwjGdHfwQBMq5V6vL2Kvi8d60jza+oH6o4qW
	 4dHeNKBnq4ObCYJsW4gZaKSxQtTOv38pJ6SzxKi+Sxr+ljMhTl9l/MBFbyAiKMajWd
	 8pr+A484NXbdlq+n4wrAgdLRtc9OwTx9hUmtu+Mi4XN1o6g2Y7QtL4eLOUjXm+oKtw
	 MiTOSd6dutU7g==
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
Subject: [PATCH v4 40/58] objtool/klp: Add test for __bug_table, __ex_table and __mcount_loc extraction
Date: Tue, 15 Sep 2026 16:34:36 -0700
Message-ID: <20260915233454.2405019-41-song@kernel.org>
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

Three special sections with no coverage.  An entry that is not carried into
the patch is not a build failure: the patched function simply loses its
WARN_ON location, its exception fixup, or its ftrace callsite, and nobody
finds out until one of them is needed.

Assisted-by: Claude:claude-opus-4
Based-on-test-by: Joe Lawrence <joe.lawrence@redhat.com>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 .../tests/x86/fixtures/special_sections.c     | 77 +++++++++++++++++++
 .../tests/x86/test-special-sections.sh        | 42 ++++++++++
 2 files changed, 119 insertions(+)
 create mode 100644 tools/objtool/tests/x86/fixtures/special_sections.c
 create mode 100755 tools/objtool/tests/x86/test-special-sections.sh

diff --git a/tools/objtool/tests/x86/fixtures/special_sections.c b/tools/objtool/tests/x86/fixtures/special_sections.c
new file mode 100644
index 000000000000..d42798848fda
--- /dev/null
+++ b/tools/objtool/tests/x86/fixtures/special_sections.c
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * A special section entry belonging to a patched function.  SPECIAL_SEC picks
+ * which section, since klp diff treats eight of them alike and each needs
+ * extracting for the patched function and no other.
+ *
+ * The entry is written out by hand so the fixture builds without kernel
+ * headers.  Only the leading relocation matters to klp diff; the rest is
+ * padded to the section's real entry size, because the entries have to be the
+ * right length for the boundaries between them to fall in the right places.
+ *
+ * SPECIAL_RELOCS covers __ex_table, whose entries relocate both the faulting
+ * instruction and its fixup; objtool rejects one with only the first.
+ */
+
+#ifndef SPECIAL_SEC
+#define SPECIAL_SEC "__bug_table"
+#endif
+#ifndef SPECIAL_ENTSIZE
+#define SPECIAL_ENTSIZE 12
+#endif
+#ifndef SPECIAL_RELOCS
+#define SPECIAL_RELOCS 1
+#endif
+
+#define STR_(x) #x
+#define STR(x) STR_(x)
+
+static const char __modinfo[]
+	__attribute__((section(".modinfo"), used, aligned(1))) = "\0name=vmlinux";
+
+/*
+ * other() gets an entry of its own, so that "the untouched function's entry
+ * was not dragged in" is a question the section can actually answer.  With
+ * only target() contributing, there is nothing for klp diff to leave behind
+ * and the negative assertion holds however the extraction behaves.
+ */
+int other(int x)
+{
+	asm volatile(
+		"3:	nop\n\t"
+		"4:\n\t"
+		".pushsection " SPECIAL_SEC ", \"aM\", @progbits, "
+			STR(SPECIAL_ENTSIZE) "\n\t"
+		".long 3b - .\n\t"
+#if SPECIAL_RELOCS > 1
+		".long 4b - .\n\t"
+		".fill " STR(SPECIAL_ENTSIZE) " - 8, 1, 0\n\t"
+#else
+		".fill " STR(SPECIAL_ENTSIZE) " - 4, 1, 0\n\t"
+#endif
+		".popsection\n\t");
+
+	return x + 9;
+}
+
+int target(int x)
+{
+	asm volatile(
+		"1:	nop\n\t"
+		"2:\n\t"
+		".pushsection " SPECIAL_SEC ", \"aM\", @progbits, "
+			STR(SPECIAL_ENTSIZE) "\n\t"
+		".long 1b - .\n\t"
+#if SPECIAL_RELOCS > 1
+		".long 2b - .\n\t"
+		".fill " STR(SPECIAL_ENTSIZE) " - 8, 1, 0\n\t"
+#else
+		".fill " STR(SPECIAL_ENTSIZE) " - 4, 1, 0\n\t"
+#endif
+		".popsection\n\t");
+#ifdef PATCHED
+	return x + 2;
+#else
+	return x + 1;
+#endif
+}
diff --git a/tools/objtool/tests/x86/test-special-sections.sh b/tools/objtool/tests/x86/test-special-sections.sh
new file mode 100755
index 000000000000..8dfaa4fc9a36
--- /dev/null
+++ b/tools/objtool/tests/x86/test-special-sections.sh
@@ -0,0 +1,42 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# klp diff extracts entries from eight special sections.  Between them the
+# existing tests reach .kcfi_traps, __jump_table, .static_call_sites and
+# .altinstructions; __bug_table, __ex_table and __mcount_loc are covered by
+# nothing, though the same extraction code serves all of them.
+#
+# Losing an entry is quiet in every case and wrong in a different way for each:
+# a WARN() in patched code that no longer reports where it came from, an
+# exception fixup that is simply not there when the faulting instruction traps,
+# a function ftrace can no longer see.
+
+. "$(dirname "$0")/../lib.sh"
+
+
+# section, entry size, relocations per entry
+for spec in "__bug_table 12 1" "__ex_table 12 2" "__mcount_loc 8 1"; do
+	set -- $spec
+	sec=$1
+
+	# A fresh workdir per section: run_diff caches its checksums.
+	setup
+	build_pair special_sections.c \
+		-DSPECIAL_SEC="\"$1\"" -DSPECIAL_ENTSIZE="$2" -DSPECIAL_RELOCS="$3"
+
+	assert_input_section "$sec"
+	run_diff
+
+	# Extracted, and pointing at the function that was patched.
+	assert_section "$sec"
+	assert_reloc_sym "$sec" target
+	assert_patched target
+
+	# Nothing belonging to the function that was not.
+	assert_not_patched other
+	assert_no_reloc_sym "$sec" other
+
+	cleanup
+done
+
+pass "__bug_table, __ex_table and __mcount_loc entries extracted"
-- 
2.53.0-Meta

