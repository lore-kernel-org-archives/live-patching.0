Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EF145518E;
	Fri,  7 Aug 2026 21:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786138724; cv=none; b=bUfsQBhF9MuCu+e4yor6de8TTpZNDGJRptAAdROlJ90MxpB7+GlV32Vv7o5Qb3p8EQVXP/i62HaPHSeLc4na/BdzpdmQlaanQ3gXs5/XmIng0ta+XiU0AtYlWN6up4V/PZN6IBbpXd0EDWG7fkHsDb30NyG1kXwDYHivILDIH1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786138724; c=relaxed/simple;
	bh=asFX3CX0rlaBJ4ZrCVCjnhKEqTe/DPQwTAkuxFEeNIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HOaz4731PRB0/mBcrKdnZWBBLMwqcXPuhgoskrMnVahNe3q4Kke+JujIoM2v2KDwtpMGcjdWPmgbfJ6PTL5C514FiFb9KmHzDwC9ejvOx85WUkI5CDNQbfXUP8uZcaANETnJCOPVdUFptqVv90nl2GR55Ietkvm9rFt1gEK+mtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DV3zP+Dw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DV3zP+Dw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D75041F00AC4;
	Fri,  7 Aug 2026 21:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786138722;
	bh=LbQAr6NzwALX9OiU99ghM44FeYC8mo3sdfunpkYkV80=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DV3zP+DwNOyUE3AAA4OlS1fUrgTwLL9AS5ozgsxo+2O8qatube3QPve7KKbGIKtqQ
	 l/LCf3qgzS4UOb71xgZ6+eGWgoSxx+yUu010FRLxNt6HxZVIsq07hVLqZ48BmQ4MdE
	 zyQpiDKUq6KBgNOTSOi9IN/v2ydmIGx/NLAq+iNSFOSHYBs+pZg9+rNfV8+XpGNVkN
	 TEyq/CmpmBgVoVo4iSPQKjuG4nkdErGHClrChH8CtCLyyAwXQGw0UnR51tPivYJ4OH
	 /pxGMGAsfOKlw3S9M4RJfHSGFW4GxTNGznlLdu6M02vq3cdXfOjcmaXL1DFAISU/cD
	 ElkcABwgkpvPg==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>,
	Song Liu <song@kernel.org>
Subject: [PATCH v3 7/9] objtool/klp: Allow new references to module exports
Date: Fri,  7 Aug 2026 14:37:52 -0700
Message-ID: <e0d725acb4774747f0e271308b4ca33daae2d5db.1786138493.git.jpoimboe@kernel.org>
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
Acked-by: Song Liu <song@kernel.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/klp-diff.c | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
index f5d5711623f03..6d34186d8b24c 100644
--- a/tools/objtool/klp-diff.c
+++ b/tools/objtool/klp-diff.c
@@ -1294,6 +1294,28 @@ static int convert_reloc_sym(struct elf *elf, struct reloc *reloc)
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
@@ -1313,8 +1335,17 @@ static int clone_reloc_klp(struct elfs *e, struct reloc *patched_reloc,
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

