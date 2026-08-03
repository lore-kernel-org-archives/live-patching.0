Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8261F39B956;
	Mon,  3 Aug 2026 03:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785727500; cv=none; b=a5tfwHCviLD7I+KrGR41Wt5vAJ5E0a21ABfxTFbrptzq2z4WLw8DgTjZewmfPWqpi2/gm1KSestymWO6CKO4hEKeKq23Ou9hKClSdMR4lomIKp5x4zsFY54oIMRRgb1Qz84nPKGpviKHUDUQXBCtrjFnssZx6RTcrsV1Qurq/ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785727500; c=relaxed/simple;
	bh=QUx6wchJN4Hl6eWMl5CKdGrUcSL3kOTde+E6rwAcB/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EQ2QyKBL9Z2+KrVcGqvzp+EF/smcTXNAE/24MctDOWgPl0E8mTkRnqIEbPprdQcxlmwcdXt3LMI7gSYu9nALplJjrogCWBjxx/uST7h/96KYt7/iCIxe5P626ZEs02x17HMpQF71JbqPsKpSmjf22jtRzSSG0lQ528vrqS/4oX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lwrFIUWI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lwrFIUWI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBCA21F000E9;
	Mon,  3 Aug 2026 03:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785727498;
	bh=+WKufg9eSEaRNm0MCodUsNa/KDoTTSQQZMyrlWd3a1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lwrFIUWIk8/3iBP54i1FULAgXTejfI+Y70/gR6RPGWEvZircCdmbrY4NfhzEjIh9/
	 60iw2bfZIV0DpPjlvV4AZ6QWQkpPSoRheTHVDeiIExzDW3K3zDKEPUtQLLJJ8PUpH7
	 hLxIhFJeTj9i7Z7UKw27AHFlffEmKv4LwTpCmc2CJqPqGUPNhxCkBMJNimtN7kHZiq
	 9IWtt+Ekc/SE9Kes5FY4rVG17aKrIUo0kbU+CXryOXtdtM3ak27+O/zinafdRND9fk
	 fL9DD80kYcHvZfdM7bDo3GQ++ogQAEmsxOKJnzSihMmXDEulWY9YXN3dsylIv0cjcv
	 DmtUV69nGEIgQ==
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
	linux-modules@vger.kernel.org
Subject: [PATCH 14/14] objtool/klp: Allow new references to module exports
Date: Sun,  2 Aug 2026 20:24:36 -0700
Message-ID: <e48a822b6a3dcdf56835ab047926e437e7119b73.1785727106.git.jpoimboe@kernel.org>
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

From: Joe Lawrence <joe.lawrence@redhat.com>

klp_reloc_needed() returns true for module exports to support
late-module patching.  However, clone_reloc_klp() unconditionally
rejects symbols without a twin (i.e., new references added by the
patch), even when the symbol is a known export from Module.symvers.

Relax the check: allow new references to exported symbols by only
erroring on !twin when there is no export.  The export metadata from
Module.symvers provides sufficient context to emit the klp-relocation
without a twin.

For a module export that isn't sufficient on its own though, as the
resulting klp relocation will only be resolved at patch-enable time if
the exporting module is loaded.

If the original (unpatched) module already depends on the exporting
module, the dependency is safe: the module loader ensures the dependency
is satisfied before the patched module can be loaded, so the
klp relocation target will exist.

However, if the patch introduces a reference to a module that the
original doesn't depend on, there is no such guarantee.  The exporting
module could be absent or could be unloaded at any time, leading to a
relocation failure or use-after-free.

So also add a build-time check: when a new symbol reference (no twin)
targets a module export, verify that the original module already has at
least one UNDEF symbol resolving to that same exporting module.  If not,
error out with a diagnostic message.

Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/klp-diff.c | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
index e0dc22cef2c3..abda2e5c17f7 100644
--- a/tools/objtool/klp-diff.c
+++ b/tools/objtool/klp-diff.c
@@ -1295,6 +1295,28 @@ static int convert_reloc_sym(struct elf *elf, struct reloc *reloc)
 	return convert_reloc_secsym_to_sym(elf, reloc);
 }
 
+/*
+ * Check if the original module already has a dependency on dep_mod, i.e. it
+ * already references at least one export from that module.
+ */
+static bool has_module_dep(struct elfs *e, const char *dep_mod)
+{
+	struct symbol *sym;
+
+	for_each_sym(e->orig, sym) {
+		struct export *exp;
+
+		if (!is_undef_sym(sym) || is_weak_sym(sym))
+			continue;
+
+		exp = find_export(sym);
+		if (exp && !strcmp(exp->mod, dep_mod))
+			return true;
+	}
+
+	return false;
+}
+
 /*
  * Convert a regular relocation to a klp relocation (sort of).
  */
@@ -1314,8 +1336,17 @@ static int clone_reloc_klp(struct elfs *e, struct reloc *patched_reloc,
 	unsigned long sympos;
 
 	if (!patched_sym->twin) {
-		ERROR("unexpected klp reloc for new symbol %s", patched_sym->name);
-		return -1;
+		if (!export) {
+			ERROR("unexpected klp reloc for new symbol %s", patched_sym->name);
+			return -1;
+		}
+
+		if (strcmp(export->mod, "vmlinux") &&
+		    !has_module_dep(e, export->mod)) {
+			ERROR("%s: new reference to %s (exported by %s) would create an undeclared module dependency",
+			      patched_sym->name, export->sym, export->mod);
+			return -1;
+		}
 	}
 
 	/*
-- 
2.54.0

