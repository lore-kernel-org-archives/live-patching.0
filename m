Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A35C38886A;
	Wed,  5 Aug 2026 14:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785940212; cv=none; b=nZA/6VBujN5GEsnOXOTgxsSZTNzPqmfttgn096JqrSdrI8ccJ9agkbr5qc5Eef+HvmmJgNEIUMP3SNFOzod8UAqTvDYXrzrJn28shYbnW9f5MnvsHRTjDzwxYBG+DwPb/ATdQQARIie6aswAHBE3sIMxKtU/ki98RnIoAK05ZbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785940212; c=relaxed/simple;
	bh=EYNuaF6doaxxQJyOIofIXN8oHkPcU316iaavUCAc9KQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e7Urwp8Ouf9JwUIgF5LL+ifoUA7R/mvTdGzDiyowZII3mjJjRenVe5z2JfVNBJTZ6M3QKGELLOEp5ZIypIQfL7uvABrKK9shNrG4yAhRD+bKV3xDAAuHq20I80IIGwBRs1vcspG7Ejyc7QkkN6V/g5VX4zGHKDhsLhZMA0WbvKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=er/NksyN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="er/NksyN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8B861F00ACA;
	Wed,  5 Aug 2026 14:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785940200;
	bh=8C1aQofDV7HsvKHeAFCooZp2csmiOoW6Cpz9YcY4RoM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=er/NksyN5Ta4Z2qymms4Xly4o57Eu5urtHfVV1lHdZP22WqeD0ijqOrMJwc6/q9WA
	 WIEnvNx5oaqh+TdUUtWG8x7dpv7lUAqnF05TK85IPUwCoDibItrnGIiggv2c6EBcVE
	 zUVGGGFKHSzuaFHIrE0MbiaLz0iyzyVsTO1O93D4ebRpy3aOCZB2/juD0J9AjiTKRV
	 J1JXqDZM9HuTop9w+m235cOnG6e/qXREsQXSJU1RORMfLffHfJR80q+4bZr5FnyNVC
	 oAEE6WC5KPBmiFCBjvISgcZV7SQs2DwPodd7awMABOwBLRRSJeH4XxrLhdzc/V1Iyx
	 RoiAlkQgZCOVg==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>,
	Song Liu <song@kernel.org>
Subject: [PATCH v2 3/7] objtool/klp: Ignore replacement offset of empty x86 alternatives
Date: Wed,  5 Aug 2026 07:29:40 -0700
Message-ID: <9f9c0c444e078869f2bceac7ecc72fe7310e188f.1785939903.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1785939903.git.jpoimboe@kernel.org>
References: <cover.1785939903.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An x86 alternative with an empty replacement, e.g. the second entry of

  ALTERNATIVE_2("orig", "repl", ft1, "", ft2)

has a replacementlen of zero.  Its replacement offset still gets a
relocation, but the label it points at is the end of the previous
replacement, which is also the beginning of the *next* alternative's
replacement.  The value is meaningless; get_alt_entry() already ignores
it for that reason.

klp diff doesn't ignore it.  When such an alternative belongs to a
changed function, cloning its relocations drags in the unrelated
neighboring replacement, along with everything that replacement
references.  On an x86 clang/lto build an empty alternative in
meminfo_proc_show() pulled in the replacement of an alternative in
proc_kcore_init(), silently emitting a klp relocation against init text
which has long since been freed by the time the patch is applied.

Add arch_alt_ignore_new_reloc() and skip such relocations when cloning.
This has to be arch specific: on arm64 a zero-length replacement instead
identifies an alternative callback, whose replacement offset points at
the callback function and must be preserved.

Fixes: dd590d4d57eb ("objtool/klp: Introduce klp diff subcommand for diffing object files")
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/arch/x86/special.c        | 27 +++++++++++++++++++++++++
 tools/objtool/include/objtool/special.h |  7 +++++++
 tools/objtool/klp-diff.c                |  6 +++++-
 3 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/arch/x86/special.c b/tools/objtool/arch/x86/special.c
index e817a3fff4491..1e84c81bfcd81 100644
--- a/tools/objtool/arch/x86/special.c
+++ b/tools/objtool/arch/x86/special.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 #include <string.h>
 
+#include <arch/special.h>
 #include <objtool/special.h>
 #include <objtool/builtin.h>
 #include <objtool/warn.h>
@@ -9,6 +10,32 @@
 /* cpu feature name array generated from cpufeatures.h */
 #include "cpu-feature-names.c"
 
+/*
+ * An alternative with an empty replacement, e.g. the second entry of
+ *
+ *   ALTERNATIVE_2("orig", "repl", ft1, "", ft2)
+ *
+ * still gets a relocation for its replacement offset.  But the label it points
+ * at is the end of the previous entry's replacement, which is also the
+ * beginning of the *next* entry's replacement.  The value is meaningless: it's
+ * only ever used with a length of zero.
+ */
+bool arch_alt_ignore_new_reloc(struct section *sec, unsigned long offset)
+{
+	unsigned long entry_off;
+
+	if (strcmp(sec->name, ".altinstructions"))
+		return false;
+
+	entry_off = offset - (offset % ALT_ENTRY_SIZE);
+
+	if (offset - entry_off != ALT_NEW_OFFSET)
+		return false;
+
+	return !*(unsigned char *)(sec->data->d_buf + entry_off +
+				   ALT_NEW_LEN_OFFSET);
+}
+
 void arch_handle_alternative(struct special_alt *alt)
 {
 	static struct special_alt *group, *prev;
diff --git a/tools/objtool/include/objtool/special.h b/tools/objtool/include/objtool/special.h
index 121c3761899c1..620dbf6cb0e58 100644
--- a/tools/objtool/include/objtool/special.h
+++ b/tools/objtool/include/objtool/special.h
@@ -32,6 +32,13 @@ int special_get_alts(struct elf *elf, struct list_head *alts);
 
 void arch_handle_alternative(struct special_alt *alt);
 
+/*
+ * Should the reloc at @offset -- the "new" (replacement) field of a special
+ * section group entry -- be ignored?  The meaning of a zero-length replacement
+ * is arch specific, so the arch decides.
+ */
+bool arch_alt_ignore_new_reloc(struct section *sec, unsigned long offset);
+
 bool arch_support_alt_relocation(struct special_alt *special_alt,
 				 struct instruction *insn,
 				 struct reloc *reloc);
diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
index 11e8f3ddbb0e6..07cc8e2703260 100644
--- a/tools/objtool/klp-diff.c
+++ b/tools/objtool/klp-diff.c
@@ -12,7 +12,7 @@
 #include <objtool/arch.h>
 #include <objtool/klp.h>
 #include <objtool/util.h>
-#include <arch/special.h>
+#include <objtool/special.h>
 
 #include <linux/align.h>
 #include <linux/objtool_types.h>
@@ -1537,6 +1537,10 @@ static int clone_sym_relocs(struct elfs *e, struct symbol *patched_sym)
 		    !strcmp(patched_reloc->sym->sec->name, ".altinstr_aux"))
 			continue;
 
+		if (arch_alt_ignore_new_reloc(patched_sym->sec,
+					      reloc_offset(patched_reloc)))
+			continue;
+
 		ret = convert_reloc_sym(e->patched, patched_reloc);
 		if (ret < 0) {
 			ERROR_FUNC(patched_rsec->base, reloc_offset(patched_reloc),
-- 
2.54.0

