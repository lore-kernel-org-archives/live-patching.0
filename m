Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EFF36D9E9;
	Mon,  3 Aug 2026 03:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785727492; cv=none; b=W8ZVZPTh+Qg11KA1rqekAavFO5bO9hJs17350/+/QRaxYnBmy4sC7GCLhWEAeEVpODbMMPi7bu4ZSUKLuwbWCUHJXwd+pL9De0pcpRKf+bLCmvOjy7Y5r5OAlRldwQw2rJEJS0nbJt9n7VfkRJogkovRDbgaUOS8Rb1A0XwohkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785727492; c=relaxed/simple;
	bh=7y0GrduXLKZDzurZAP7lv1oZJSopq852CcGlQwj1CEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PnLZrDghpOAUWEIGoqoW6nblB+pU3VKtKQMOQA4Ciz18aSdFn+0bSe6mi28YsmPnAc2mCoTkLThdoG/gQqPw2VijYh9B1EMDyPArC60VLY9HDmTVZvvjpzT1MbZQJWUGSuQkj9RcYmSd+v8XhgycXNyd5yJ2DhWTuhDTfMfsKJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I1j2Idpt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I1j2Idpt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 130FF1F000E9;
	Mon,  3 Aug 2026 03:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785727490;
	bh=p0WYRp2P3qcbTs2R+rOqZR35qVFQPjC9GnzYF8If2ls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I1j2IdptB5P9bWV+OSKoiQD1As3wywHTZCC7VxnJ36+a6uQkyv1LmOvWxIr8KBMwr
	 wjO8sTxDleWizj56AZBHJh6FwjzJwNjuOJKPcLrOSV1KPBaqIhQexBtEeZTBPMPQHQ
	 RA6Ef3OSSLfQjMteEYFACaCb5yD4hMbRSGiH8va97M7LefciUpEf1bBMABB1ExDB3q
	 8/5GffA0Aoc4ktITb2Ae0WX7E600TCIGXomqK0P8sNlyc80cKmBkL37Gfw3mIlgJtZ
	 qsJbB+EF8pA88k0EX7ZWINupfyrkSugA0EmCa+ayR2QMBgj9VNVTCJVIiw1FKmRbM2
	 us7X09hXMAc7A==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>,
	Song Liu <song@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	linux-modules@vger.kernel.org,
	Ben Procknow <bprockno@redhat.com>
Subject: [PATCH 03/14] objtool/klp: Fix false module dependencies caused by dead relocs
Date: Sun,  2 Aug 2026 20:24:25 -0700
Message-ID: <9548393f4d89ec3b498f4f69aa6ef6b9bb7150fe.1785727106.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1785727106.git.jpoimboe@kernel.org>
References: <cover.1785727106.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When creating a klp reloc, klp-diff keeps the original relocation but
converts the referenced symbol to an UNDEF/WEAK placeholder tombstone
symbol, which gets fully disabled later by klp post-link.  The tombstone
symbol is only needed to avoid confusing objtool when it does the final
run on the patch module.

However, for references to exported symbols, modpost sees the reference
to the tombstone symbol as a real reference to an exported symbol,
resulting in a false module dependency getting created.

Further, for a reference to a tombstone symbol which is exported into a
module namespace, e.g. via EXPORT_SYMBOL_FOR_KVM_INTERNAL(), modpost
can't satisfy the dependency, resulting in a warning like the following:

  module ... uses symbol kvm_flush_remote_tlbs from namespace
  module:kvm-amd,kvm-intel, but does not import it.

Rename the placeholder tombstone symbols to ".klp.tombstone.<name>" so
modpost no longer recognizes them.

Fixes: dd590d4d57eb ("objtool/klp: Introduce klp diff subcommand for diffing object files")
Reported-by: Ben Procknow <bprockno@redhat.com>
Reported-by: Joe Lawrence <joe.lawrence@redhat.com>
Link: https://lore.kernel.org/20260720145658.1103243-5-joe.lawrence@redhat.com
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/elf.c                 | 13 +++++++++++++
 tools/objtool/include/objtool/klp.h |  2 ++
 tools/objtool/klp-diff.c            | 16 ++++++++++++----
 3 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 33c95a74a51b..a791f4ea6ec1 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -23,6 +23,7 @@
 #include <linux/log2.h>
 #include <objtool/builtin.h>
 #include <objtool/elf.h>
+#include <objtool/klp.h>
 #include <objtool/warn.h>
 
 static ssize_t demangled_name_len(const char *name);
@@ -626,6 +627,18 @@ static int read_symbols(struct elf *elf)
 			return -1;
 		}
 
+		/*
+		 * "klp diff" renames the placeholder symbols of KLP relocs to
+		 * hide them from modpost.  Hide the prefix from the rest of
+		 * objtool so its many name-based heuristics (noreturns,
+		 * uaccess safe list, ...) still see the original symbol name.
+		 *
+		 * st_name is left alone, so the renamed symbol is preserved in
+		 * the output file.
+		 */
+		if (strstarts(sym->name, KLP_TOMBSTONE_PREFIX))
+			sym->name += strlen(KLP_TOMBSTONE_PREFIX);
+
 		if ((sym->sym.st_shndx > SHN_UNDEF &&
 		     sym->sym.st_shndx < SHN_LORESERVE) ||
 		    (shndx_data && sym->sym.st_shndx == SHN_XINDEX)) {
diff --git a/tools/objtool/include/objtool/klp.h b/tools/objtool/include/objtool/klp.h
index 6f60cf05db86..aab6db42052d 100644
--- a/tools/objtool/include/objtool/klp.h
+++ b/tools/objtool/include/objtool/klp.h
@@ -23,6 +23,8 @@
 #define KLP_RELOCS_SEC	"__klp_relocs"
 #define KLP_STRINGS_SEC	".rodata.klp.str1.1"
 
+#define KLP_TOMBSTONE_PREFIX	".klp.tombstone."
+
 struct klp_reloc {
 	void *offset;
 	void *sym;
diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
index 15d37d955af0..75ba0e060a34 100644
--- a/tools/objtool/klp-diff.c
+++ b/tools/objtool/klp-diff.c
@@ -1362,6 +1362,7 @@ static int clone_reloc_klp(struct elfs *e, struct reloc *patched_reloc,
 	s64 addend = reloc_addend(patched_reloc);
 	const char *sym_modname, *sym_orig_name;
 	static struct section *klp_relocs;
+	char tombstone_name[SYM_NAME_LEN];
 	struct symbol *sym, *klp_sym;
 	unsigned long klp_reloc_off;
 	char sym_name[SYM_NAME_LEN];
@@ -1376,15 +1377,22 @@ static int clone_reloc_klp(struct elfs *e, struct reloc *patched_reloc,
 	/*
 	 * Keep the original reloc intact for now to avoid breaking objtool run
 	 * which relies on proper relocations for many of its features.  This
-	 * will be disabled later by "objtool klp post-link".
+	 * reloc now targets a functionally dead tombstone symbol and will be
+	 * disabled later by "objtool klp post-link".
 	 *
-	 * Convert it to UNDEF (and WEAK to avoid modpost warnings).
+	 * Convert the symbol to UNDEF/WEAK and rename to
+	 * .klp.tombstone.sym_name to prevent modpost from printing warnings or
+	 * creating false module dependencies.  The prefix is hidden from the
+	 * objtool run itself by read_symbols().
 	 */
 
 	sym = patched_sym->clone;
 	if (!sym) {
-		/* STB_WEAK: avoid modpost undefined symbol warnings */
-		sym = elf_create_symbol(e->out, patched_sym->name, NULL,
+		if (snprintf_check(tombstone_name, SYM_NAME_LEN,
+				   KLP_TOMBSTONE_PREFIX "%s", patched_sym->name))
+			return -1;
+
+		sym = elf_create_symbol(e->out, tombstone_name, NULL,
 					STB_WEAK, patched_sym->type, 0, 0);
 		if (!sym)
 			return -1;
-- 
2.54.0

