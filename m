Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3890037F006;
	Wed,  5 Aug 2026 14:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785940218; cv=none; b=N7RrkqmFxNmu2qK2+nPDh4pxSjZGeS6EoVD3GbC7mvQPvbS3WsXqTV/hx0UgeEhHTSif0QCzAtX6E49jfdywVf3bFhDp/UgwMvguk6BfgqsqTYBl4uc8AxM1ioAksinPDpXcBcapS8nHYvx8ZDU0uR/NkxL6AkyayagoEdhdbHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785940218; c=relaxed/simple;
	bh=F7T66tTukzip4fOwYqJmTsqHngKkKtvLvr0BdRdbskk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o/x9rHX8iYor/0NNMC2IljNuooJ1N/uR8GYz+np4ZgAb/3mLxnBnJILAbMZJMKEtT+RMbuVFbg8Rs0J9h8GQuTPLxjZ9E+6emuB/sr4v4KaUj8+TitJZDMOVuTFFqJHfJv6OsIXTD5xf45Sv6xX7o1e7MvQRDmKZe6GYlFJ7xCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YP1UY0ss; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YP1UY0ss"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E8C81F00ACF;
	Wed,  5 Aug 2026 14:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785940201;
	bh=pf7PkdqsX0tRjfepkpmlOqNdpDamvDu5Itlxqz/dhFY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YP1UY0ssqsdYQ7TXWyLQiTx+T8bEPbNZ/2hwus+ByidHkEW8EWLBP57rq/VjIu6od
	 4kEX21mDVznghHQa6WwgkKTYrFbPThuOL8Gwvs+Fg/gmzNgR8uYYGbnGYVfl6VjBcT
	 PM5bzeq7EcIwZEoxsfmFhps2QxSIYNp5g3XZdkXrUkbekorP+RqD9qi+sc9Iz3IYBY
	 HZgZxv7ooifKGxItrSm4uawgGJ31JaTu3EX1SE9zc97hSGNUoJ0bo3yTTFRgR25d19
	 X+GGzGzp9IJc0QwFsGbBNjPG7PsdvsUH4IY9gy0wTSsuAFFqV1BKnnv8ch3JNqSaJF
	 Fbe/Ifc89xJ4w==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>,
	Song Liu <song@kernel.org>
Subject: [PATCH v2 5/7] objtool/klp: Fix cross-module klp relocation section naming
Date: Wed,  5 Aug 2026 07:29:42 -0700
Message-ID: <e5a665072e9b5b63cfe95d5a4ca1d11dd0a7a96a.1785939903.git.jpoimboe@kernel.org>
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

A klp relocation section is .klp.rela.<objname>.<secname>, where objname
is the object being patched.

klp-build wrongly derives objname from where the referenced symbol
lives, not where it's referenced.  For a cross-module reference like
patched can_isotp code calling can.ko's can_rx_unregister(), that gives
.klp.rela.can..text rather than .klp.rela.can_isotp..text.  Unless the
patch happens to patch can.ko as well, the relocation never gets applied
and the call goes off into the weeds.

Name the intermediate section __klp_relocs.<objname> so post-link can
read the patched object's name from there.

Fixes: dd590d4d57eb ("objtool/klp: Introduce klp diff subcommand for diffing object files")
Reported-by: Joe Lawrence <joe.lawrence@redhat.com>
Link: https://lore.kernel.org/20260720145658.1103243-2-joe.lawrence@redhat.com
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/include/objtool/klp.h | 10 ++++--
 tools/objtool/klp-diff.c            | 17 +++++++--
 tools/objtool/klp-post-link.c       | 53 +++++++++++++++++------------
 3 files changed, 52 insertions(+), 28 deletions(-)

diff --git a/tools/objtool/include/objtool/klp.h b/tools/objtool/include/objtool/klp.h
index 0118c2c170c3f..646d8e1f12eff 100644
--- a/tools/objtool/include/objtool/klp.h
+++ b/tools/objtool/include/objtool/klp.h
@@ -14,11 +14,15 @@
 #define KLP_FUNCS_SEC	".init.klp_funcs"
 
 /*
- * __klp_relocs is an intermediate section which are created by klp diff and
- * converted into KLP symbols/relas by "objtool klp post-link".  This is needed
- * to work around the linker, which doesn't preserve SHN_LIVEPATCH or
+ * __klp_relocs.<objname> are intermediate sections which are created by klp
+ * diff and converted into KLP symbols/relas by "objtool klp post-link".  This
+ * is needed to work around the linker, which doesn't preserve SHN_LIVEPATCH or
  * SHF_RELA_LIVEPATCH, nor does it support having two RELA sections for a
  * single PROGBITS section.
+ *
+ * "objname" is the name of the object being patched ("vmlinux" or a module
+ * name).  post-link uses it to name the resulting
+ * .klp.rela.objname.section_name sections.
  */
 #define KLP_RELOCS_SEC	"__klp_relocs"
 #define KLP_STRINGS_SEC	".rodata.klp.str1.1"
diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
index 07cc8e2703260..91a9562c45a6e 100644
--- a/tools/objtool/klp-diff.c
+++ b/tools/objtool/klp-diff.c
@@ -1380,8 +1380,8 @@ static int clone_reloc_klp(struct elfs *e, struct reloc *patched_reloc,
 	}
 
 	/*
-	 * Create the __klp_relocs entry.  This will be converted to an actual
-	 * KLP rela by "objtool klp post-link".
+	 * Create the __klp_relocs.<objname> entry.  This will be converted to
+	 * an actual KLP rela by "objtool klp post-link".
 	 *
 	 * This intermediate step is necessary to prevent corruption by the
 	 * linker, which doesn't know how to properly handle two rela sections
@@ -1389,7 +1389,18 @@ static int clone_reloc_klp(struct elfs *e, struct reloc *patched_reloc,
 	 */
 
 	if (!klp_relocs) {
-		klp_relocs = elf_create_section(e->out, KLP_RELOCS_SEC, 0,
+		const char *objname = find_modname(e);
+		char sec_name[SEC_NAME_LEN];
+
+		if (!objname)
+			return -1;
+
+		/* section format: __klp_relocs.objname */
+		if (snprintf_check(sec_name, SEC_NAME_LEN,
+				   KLP_RELOCS_SEC ".%s", objname))
+			return -1;
+
+		klp_relocs = elf_create_section(e->out, sec_name, 0,
 						0, SHT_PROGBITS, 8, SHF_ALLOC);
 		if (!klp_relocs)
 			return -1;
diff --git a/tools/objtool/klp-post-link.c b/tools/objtool/klp-post-link.c
index c013e39957b11..350d20495897b 100644
--- a/tools/objtool/klp-post-link.c
+++ b/tools/objtool/klp-post-link.c
@@ -19,19 +19,11 @@
 #include <objtool/util.h>
 #include <linux/livepatch_external.h>
 
-static int fix_klp_relocs(struct elf *elf)
+static int fix_klp_reloc_sec(struct elf *elf, struct section *symtab,
+			     struct section *klp_relocs)
 {
-	struct section *symtab, *klp_relocs;
-
-	klp_relocs = find_section_by_name(elf, KLP_RELOCS_SEC);
-	if (!klp_relocs)
-		return 0;
-
-	symtab = find_section_by_name(elf, ".symtab");
-	if (!symtab) {
-		ERROR("missing .symtab");
-		return -1;
-	}
+	/* section format: __klp_relocs.sec_objname */
+	const char *sec_objname = klp_relocs->name + strlen(KLP_RELOCS_SEC ".");
 
 	for (int i = 0; i < sec_size(klp_relocs) / sizeof(struct klp_reloc); i++) {
 		struct klp_reloc *klp_reloc;
@@ -39,7 +31,6 @@ static int fix_klp_relocs(struct elf *elf)
 		struct section *sec, *tmp, *klp_rsec;
 		unsigned long offset;
 		struct reloc *reloc;
-		char sym_modname[64];
 		char rsec_name[SEC_NAME_LEN];
 		u64 addend;
 		struct symbol *sym, *klp_sym;
@@ -55,7 +46,7 @@ static int fix_klp_relocs(struct elf *elf)
 		reloc = find_reloc_by_dest(elf, klp_relocs,
 					   klp_reloc_off + offsetof(struct klp_reloc, offset));
 		if (!reloc) {
-			ERROR("malformed " KLP_RELOCS_SEC " section");
+			ERROR("malformed %s section", klp_relocs->name);
 			return -1;
 		}
 
@@ -66,17 +57,13 @@ static int fix_klp_relocs(struct elf *elf)
 		reloc = find_reloc_by_dest(elf, klp_relocs,
 					   klp_reloc_off + offsetof(struct klp_reloc, sym));
 		if (!reloc) {
-			ERROR("malformed " KLP_RELOCS_SEC " section");
+			ERROR("malformed %s section", klp_relocs->name);
 			return -1;
 		}
 
 		klp_sym = reloc->sym;
 		addend = reloc_addend(reloc);
 
-		/* symbol format: .klp.sym.modname.sym_name,sympos */
-		if (sscanf(klp_sym->name + strlen(KLP_SYM_PREFIX), "%55[^.]", sym_modname) != 1)
-			ERROR("can't find modname in klp symbol '%s'", klp_sym->name);
-
 		/*
 		 * Create the KLP rela:
 		 */
@@ -84,7 +71,7 @@ static int fix_klp_relocs(struct elf *elf)
 		/* section format: .klp.rela.sec_objname.section_name */
 		if (snprintf_check(rsec_name, SEC_NAME_LEN,
 				   KLP_RELOC_SEC_PREFIX "%s.%s",
-				   sym_modname, sec->name))
+				   sec_objname, sec->name))
 			return -1;
 
 		klp_rsec = find_section_by_name(elf, rsec_name);
@@ -134,10 +121,32 @@ static int fix_klp_relocs(struct elf *elf)
 	return 0;
 }
 
+static int fix_klp_relocs(struct elf *elf)
+{
+	struct section *symtab, *sec;
+
+	symtab = find_section_by_name(elf, ".symtab");
+	if (!symtab) {
+		ERROR("missing .symtab");
+		return -1;
+	}
+
+	for_each_sec(elf, sec) {
+		if (strncmp(sec->name, KLP_RELOCS_SEC ".",
+			    strlen(KLP_RELOCS_SEC ".")))
+			continue;
+
+		if (fix_klp_reloc_sec(elf, symtab, sec))
+			return -1;
+	}
+
+	return 0;
+}
+
 /*
  * This runs on the livepatch module after all other linking has been done.  It
- * converts the intermediate __klp_relocs section into proper KLP relocs to be
- * processed by livepatch.  This needs to run last to avoid linker wreckage.
+ * converts the intermediate __klp_relocs.* sections into proper KLP relocs to
+ * be processed by livepatch.  This needs to run last to avoid linker wreckage.
  * Linkers don't tend to handle the "two rela sections for a single base
  * section" case very well, nor do they appreciate SHN_LIVEPATCH.
  */
-- 
2.54.0

