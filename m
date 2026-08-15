Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62209126BE1;
	Sat, 15 Aug 2026 02:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786761410; cv=none; b=V3iShhwjmbiFAwUv+TBgPqjhaS+KpCQlCF4WGTQ51xA82Hl6oZ79qPT2sian0ftqrjqL4230vs+xKRHAgM3SOTvnpn0k9JWJUC/1Nrix4g7XAcOvhoABhGVnLDAigvwPEIsWl5zgKhSRIZU7p4wnvSsP8uDq9vtPH9jr68v9flQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786761410; c=relaxed/simple;
	bh=V4DuRohvVpu4ak3SrmioRuWcRpMHdH2Y+Agg9sFi5B8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uLTIzF5x8P3FBEs5CvfNDQfjPMTVc8o4i0DzAFNj6teAULLwiF+3GX/nR3hhZwSMmz7NARpXvK/znXy3D8rEyVNA5CXFmn4s2MrN1pQ21JCGLdnLMDmX3Zs6/AL/D4qYsWQMjzgSfVhEaLCKrTDY7+RnFMuP/gdiX7oPH/VrlK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nqr6eTwG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nqr6eTwG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A3CA1F000E9;
	Sat, 15 Aug 2026 02:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786761408;
	bh=1FwLSkMQZTpYypZi0pct+h/7VlhZ6I+lTAJPP9Ipzco=;
	h=From:To:Cc:Subject:Date;
	b=nqr6eTwG52sxByLZD1avQuwrFdEiUTver9fJkoxBguLIB6HaNqt/F9hqS8r5oFpdI
	 37k8dvAba52xJvu/uoU9S6AbOkWO9xRUJOc/Grd93XWxDR8VKDDoIQXIs5IaOjJNdb
	 5/yqHxF+pJYVzERET02HRzOcTBvDOGNrO86W9YpsuHLE3zfOm4SRimT+MM0vT/PCgj
	 61ZAMf4iCS+5u74X8PoxCwbhEZ2XW+FbtTa2oZmilV7PGSj9EmApQupbrcZJYTOBz3
	 S9VHD3u+EBRUbt+C2noIRyECnd5QyP55arNvxSGEX/OC4Mp34VY1nmxUFQD+LGk37Q
	 ybr7Qt/gTdFoA==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Song Liu <song@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>,
	Dylan Hatch <dylanbhatch@google.com>
Subject: [PATCH] objtool/klp: Fix vmlinux klp relocations for EXPORT_SYMBOL_FOR_MODULES()
Date: Fri, 14 Aug 2026 19:36:34 -0700
Message-ID: <f8e3b9fae109903a6aafb2a33310e4afdcebf58e.1786761327.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a module function references a vmlinux symbol which is exported
with EXPORT_SYMBOL_FOR_MODULES(), a patch to that function needs to use
a klp reloc.

Currently, livepatch fails to load such a module:

  livepatch: invalid access to vmlinux symbol 'get_task_policy' from module-specific livepatch relocation section
  livepatch: failed to initialize patch 'livepatch_test' for module 'testmod' (-22)
  livepatch: patch 'livepatch_test' failed for module 'testmod', refusing to load module 'testmod'

klp diff puts all klp relocs in __klp_relocs.<patched object>, so
post-link names the section .klp.rela.<patched object>.<secname>, which the
kernel rejects for vmlinux symbols.

Commit 07f14d6af9d77 ("objtool/klp: Fix cross-module klp relocation
section naming") changed the meaning of objname in the klp rela section
name to be where the referenced symbol is referenced rather than where
it lives.  That premise only holds for symbols in a module: the relocs
get applied when the patched module gets patched, and the module
dependency guarantees the referenced module is loaded by then.

A vmlinux symbol needs the opposite.  It's always resolvable, and it has
to be applied when the patch module loads, before the module loader
initializes the patch module's special sections, which may reference it.
That's why livepatch rejects vmlinux symbols in module-specific
sections.

Use "vmlinux" as the section objname when the referenced symbol lives in
vmlinux.  This moves such klp relocs from .klp.rela.kvm..text to
.klp.rela.vmlinux..text.

Fixes: 07f14d6af9d77 ("objtool/klp: Fix cross-module klp relocation section naming")
Reported-by: Dylan Hatch <dylanbhatch@google.com>
Closes: https://lore.kernel.org/CADBMgpz7iWC0=t=_gE-tfvv0mTPq4kg0qQ2zgPH8DVPE6eQ9Kw@mail.gmail.com
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/include/objtool/klp.h |  5 +++--
 tools/objtool/klp-diff.c            | 35 ++++++++++++++++++-----------
 2 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/tools/objtool/include/objtool/klp.h b/tools/objtool/include/objtool/klp.h
index 646d8e1f12eff..c57775d78c71e 100644
--- a/tools/objtool/include/objtool/klp.h
+++ b/tools/objtool/include/objtool/klp.h
@@ -20,8 +20,9 @@
  * SHF_RELA_LIVEPATCH, nor does it support having two RELA sections for a
  * single PROGBITS section.
  *
- * "objname" is the name of the object being patched ("vmlinux" or a module
- * name).  post-link uses it to name the resulting
+ * "objname" is the object whose loading gates the relocation: "vmlinux" for
+ * references to vmlinux symbols, otherwise the name of the module being
+ * patched.  post-link uses it to name the resulting
  * .klp.rela.objname.section_name sections.
  */
 #define KLP_RELOCS_SEC	"__klp_relocs"
diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
index a66049e0726a6..16681a76f13d0 100644
--- a/tools/objtool/klp-diff.c
+++ b/tools/objtool/klp-diff.c
@@ -1344,13 +1344,14 @@ static int clone_reloc_klp(struct elfs *e, struct reloc *patched_reloc,
 			   struct section *sec, unsigned long offset,
 			   struct export *export)
 {
+	const char *sym_modname, *sym_orig_name, *sec_objname;
 	struct symbol *patched_sym = patched_reloc->sym;
 	s64 addend = reloc_addend(patched_reloc);
-	const char *sym_modname, *sym_orig_name;
-	static struct section *klp_relocs;
 	char tombstone_name[SYM_NAME_LEN];
 	struct symbol *sym, *klp_sym;
 	unsigned long klp_reloc_off;
+	struct section *klp_relocs;
+	char sec_name[SEC_NAME_LEN];
 	char sym_name[SYM_NAME_LEN];
 	struct klp_reloc klp_reloc;
 	unsigned long sympos;
@@ -1441,20 +1442,28 @@ static int clone_reloc_klp(struct elfs *e, struct reloc *patched_reloc,
 	 * This intermediate step is necessary to prevent corruption by the
 	 * linker, which doesn't know how to properly handle two rela sections
 	 * applying to the same base section.
+	 *
+	 * The objname decides when the reloc gets applied.  A reference to a
+	 * vmlinux symbol goes in the vmlinux section so it gets applied when
+	 * the patch module loads.  Everything else goes in the patched
+	 * object's section, applied when the patched module is loaded.
 	 */
 
+	if (!strcmp(sym_modname, "vmlinux")) {
+		sec_objname = "vmlinux";
+	} else {
+		sec_objname = find_modname(e);
+		if (!sec_objname)
+			return -1;
+	}
+
+	/* section format: __klp_relocs.objname */
+	if (snprintf_check(sec_name, SEC_NAME_LEN,
+			   KLP_RELOCS_SEC ".%s", sec_objname))
+		return -1;
+
+	klp_relocs = find_section_by_name(e->out, sec_name);
 	if (!klp_relocs) {
-		const char *objname = find_modname(e);
-		char sec_name[SEC_NAME_LEN];
-
-		if (!objname)
-			return -1;
-
-		/* section format: __klp_relocs.objname */
-		if (snprintf_check(sec_name, SEC_NAME_LEN,
-				   KLP_RELOCS_SEC ".%s", objname))
-			return -1;
-
 		klp_relocs = elf_create_section(e->out, sec_name, 0,
 						0, SHT_PROGBITS, 8, SHF_ALLOC);
 		if (!klp_relocs)
-- 
2.55.0

