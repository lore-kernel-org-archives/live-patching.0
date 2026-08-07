Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED3D44B66B;
	Fri,  7 Aug 2026 21:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786138722; cv=none; b=Z/wW3i8H/TvBeGvxklHcXMGbiJ9EvVPaooq4JPdlf8xmuzVJ1CeIYIG2rSuyWU1jhcsJf7pYpsoFiGlO4zyQhP4Opl+NttjTMN5ZqIzIagjvKZdHdkF4RkkVj1Al/VTpNmNRjLRYrwm460xDjNZ/ksONT6OFGrMTXWPGSIuQ6ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786138722; c=relaxed/simple;
	bh=Oj0MZAFIPqcVhMYlFk7DZYnkLbGBbL1KOnHgLtS/EKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cv8x5O28Y6egY78a/NeVKoi1Bl2JBfVOP7eMj35/RUiT0g/U/6BVF4YxhiLpVK25saAzw+4P36MkD8Gh16VKC+t0p81sxGrkrP02Cz3Djwk9NW69KnNhoQRQi6qbt70/gPHk+0pd75apnfZ8y9XdarOaKLuDnE9rhgyWhN3XT1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lw2ml4nc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lw2ml4nc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C41D1F00A3D;
	Fri,  7 Aug 2026 21:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786138720;
	bh=6wmt6zx3S/sVJejR7/3VdUFxd34zawTVy2v30WJBpzY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lw2ml4ncZukbNeWdzrZWCshMdjGy8qeVMv71sPHou5ZY54q/Gyj1/X4o8Jtvu2KQ9
	 BZzR0TDPu0DgHeJTpqP32rn/dYCmDQ+Kaculh7YU64LS1pfp3U94/2OgVpuzSFqqoS
	 suYy+ZekDOo3pM78qw9zLIkAuGRgSy+nl4KsBsxxP9hiRdfs6mnjRuPUkVl3FaW2s4
	 eeNU888Hlf9XRfbX4xcZPm0KODCzt4z4ymkMFBguFF0Eg5h7cF1KVDiqF3RFjOqt/K
	 Z/lcLJjGwH2QqzYjxNLpl3OC7o6wCinSeG6T9epKFqTPALE1vpa9TDKM5fGkSFOisR
	 TQ+HE0zdiKJUg==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>,
	Song Liu <song@kernel.org>
Subject: [PATCH v3 3/9] objtool/klp: Ignore replacement offset of empty x86 alternatives
Date: Fri,  7 Aug 2026 14:37:48 -0700
Message-ID: <7a885b70974795c3417f3358869e62aafd4ef783.1786138493.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1786138493.git.jpoimboe@kernel.org>
References: <cover.1786138493.git.jpoimboe@kernel.org>
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
Acked-by: Song Liu <song@kernel.org>
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
index 38fae861d12c7..3923fabc13331 100644
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

