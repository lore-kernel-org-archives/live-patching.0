Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D3B391E43;
	Mon,  3 Aug 2026 03:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785727495; cv=none; b=To8nIFpDOg2gzBJW56mKcousr5v4PBqT7w8QPXNTNN9elohAiWZlL7ahvTUYZihNPJWxo+fm90tcubk4EfvkqBr9EROz4suWK9oeeNCslbl7xU8IwnTzgeST7NrPk6GwkB4ChPMb5G6bStAYDDF4aTraDnZdas+e6D5MI9hYrtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785727495; c=relaxed/simple;
	bh=7UdaWpnVIE736Mk7BnSI2ZSkJ80xsg646MFdfbDpSgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NT014lf67mKdyqTqpWaZTlPrDH85lgETd/LZ8BiV2pVmUUoCaP/xs96tgUcWQ9noFKZV9OsRk60IMSWZLt4DH0ghi6GmBOUkzwpJPYHEIxVAwtqWyJBVd+xn0gVjqKMMAqiLNZI8Mp0+sHNVU4jZemZkF8vPOZDemz2B4ud24+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oyIllUND; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oyIllUND"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90FFE1F00A3A;
	Mon,  3 Aug 2026 03:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785727494;
	bh=6JCZVECoVabjRcONCFF8XMvs1d1PU2OtlptWsM4DRsc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oyIllUND6NpMlZ8jQ6auVdQyxkQ8ByItEj2ENepga4Ljis2JFDe3Qjo25cpswS7ue
	 j4Yvp0RiexEf1Tfov6naJppkoPuLi5xizYwXE2/qyQbJ/1jhO9rTBYtYIH7bvHnUBK
	 TM6mDlUEse1gheC7CPQdSx8O5v4aSvo/ThIhjeUSTGNqApvOEOGVpBHMuBaTiKViiK
	 0e8q1MkXtmAFg9+ftfyO4WB2KuP9WIO4LQFPZwchj5jx6CrvXc6NUyzht8W3xFeA3d
	 sB+zkS4M/2qsSehpmjdr50/soUHrltOCm4flbRn5o02DLuKO4i6HKx/tdWneFsNnuy
	 fUhVs1kxHZg+Q==
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
Subject: [PATCH 08/14] objtool/klp,livepatch: Resolve module symbols against core kallsyms
Date: Sun,  2 Aug 2026 20:24:30 -0700
Message-ID: <5f7b6798592b20c6b4accb725ba87849f3224f2c.1785727106.git.jpoimboe@kernel.org>
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

For patching a module, klp_find_sympos() counts every symbol table entry
whose name matches.  However, the module loader only includes symbols
matched by is_core_symbol().

The runtime count is inconsistent as well.  It's done by
module_kallsyms_on_each_symbol(), which iterates the full init symbol
table until do_init_module() swaps in the cut-down core table, so the
same symbol can have different positions depending on whether init
memory has been freed yet.

Define a module's sympos as its position in the core symbol table, which
is what sympos already means for a live module and what users see in
/proc/kallsyms.  Enforce that on both ends: count with
module_kallsyms_on_each_core_symbol() at runtime, and mirror the
is_core_symbol() filter in objtool with a new mod_sym_in_kallsyms()
helper.

The init-layout half of the filter is only correct if .exit sections are
core sections, which requires CONFIG_MODULE_UNLOAD, otherwise .exit code
is laid out as part of init memory and freed after module init.  Enforce
CONFIG_MODULE_UNLOAD to ensure that behavior is deterministic.

Symbols which exist only in init sections are no longer resolvable, but
they never were once the module went live, and init memory is freed
after module init anyway.

Fixes: dd590d4d57eb ("objtool/klp: Introduce klp diff subcommand for diffing object files")
Fixes: b2b018ef4867 ("livepatch: add old_sympos as disambiguator field to klp_func")
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 kernel/livepatch/core.c     |  2 +-
 scripts/livepatch/klp-build |  3 +++
 tools/objtool/klp-sympos.c  | 22 +++++++++++++++++++++-
 3 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index 28d15ba58a26..a05cd2c38caa 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -168,7 +168,7 @@ static int klp_find_object_symbol(const char *objname, const char *name,
 	};
 
 	if (objname)
-		module_kallsyms_on_each_symbol(objname, klp_find_callback, &args);
+		module_kallsyms_on_each_core_symbol(objname, klp_find_callback, &args);
 	else
 		kallsyms_on_each_match_symbol(klp_match_callback, name, &args);
 
diff --git a/scripts/livepatch/klp-build b/scripts/livepatch/klp-build
index b52a8489d9f6..9b375e018d76 100755
--- a/scripts/livepatch/klp-build
+++ b/scripts/livepatch/klp-build
@@ -265,6 +265,9 @@ validate_config() {
 	[[ -v CONFIG_KLP_BUILD ]] ||			\
 		die "CONFIG_KLP_BUILD not enabled"
 
+	[[ -v CONFIG_MODULE_UNLOAD ]] ||		\
+		die "kernel option 'CONFIG_MODULE_UNLOAD' required"
+
 	[[ -v CONFIG_GCC_PLUGIN_LATENT_ENTROPY ]] &&	\
 		die "kernel option 'CONFIG_GCC_PLUGIN_LATENT_ENTROPY' not supported"
 
diff --git a/tools/objtool/klp-sympos.c b/tools/objtool/klp-sympos.c
index bbfae516d339..34bb8d1971bd 100644
--- a/tools/objtool/klp-sympos.c
+++ b/tools/objtool/klp-sympos.c
@@ -367,6 +367,17 @@ static unsigned long find_vmlinux_sympos(struct symbol *sym)
 	return sympos;
 }
 
+static bool mod_sym_in_kallsyms(struct symbol *sym)
+{
+	if (is_undef_sym(sym))
+		return false;
+
+	if (!(sym->sec->sh.sh_flags & SHF_ALLOC))
+		return false;
+
+	return !strstarts(sym->sec->name, ".init");
+}
+
 /*
  * "sympos" is used by livepatch to disambiguate duplicate symbol names.
  */
@@ -387,12 +398,21 @@ unsigned long klp_find_sympos(struct elf *elf, struct symbol *sym)
 	if (vmlinux.elf)
 		return find_vmlinux_sympos(sym);
 
+	if (!mod_sym_in_kallsyms(sym)) {
+		ERROR("symbol %s is not visible to module kallsyms, can't compute sympos",
+		      sym->name);
+		return ULONG_MAX;
+	}
+
 	/*
 	 * modules: the final .ko preserves symbol table order, so a
 	 * symtab-order count here matches the runtime count done by
-	 * module_kallsyms_on_each_symbol().
+	 * module_kallsyms_on_each_core_symbol().
 	 */
 	for_each_sym(elf, s) {
+		if (!mod_sym_in_kallsyms(s))
+			continue;
+
 		if (!strcmp(s->name, sym->name)) {
 			nr_matches++;
 			if (s == sym)
-- 
2.54.0

