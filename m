Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C14456E01;
	Fri,  7 Aug 2026 21:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786138725; cv=none; b=F3yseoPDHJVvvmE+KG45MelWAngqRPm3BEp2qfbMOvkUUXKDQVfOl0G8+FcXtow2Adv7hIXpBKeIwBQcE8T38qpnYM3WYoss0V2+8q9gp+u62rkHOiiqnyfCil53rXSjOV/I4OWrtIl0TxVnw3w2L0778EpM7QG3JziNOgThMfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786138725; c=relaxed/simple;
	bh=yfT83NfMmxwDWXpL0sZ8AgbRR1EuYgUXMPYYRIaEFsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KaXqdjolrJbmV0gdEcyps6ZQ1Ix2nnSxnuwHZerHn/iO1uMkFLwH2ysh+rMah7JBMj7wYDV/X0/AjpFdk9gp6tqvaP3tFwiHJemT+5OZ9oz0OCf84kfYuG5qHBXjNfHPkX11i7IOhj3fkszuIHlM41l4L8eFFCpBuF8wpsm9wtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F+31Xlz3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+31Xlz3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 572581F000E9;
	Fri,  7 Aug 2026 21:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786138722;
	bh=kMHbMszEw8NgGlWDhFr8v0jHezHZ3bKkdPIBbxKNYvE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F+31Xlz3Qz8WMuh2N/NSYc4tedQ3T07bpT/nNw8kmbeLj8BhT6y1gOAG+9Eyd3/me
	 DJLWcXRabvBMSsaHAnFmSbNqiEyq2RySDfUDjyYFc6OCLLQT9mcl5XBF6szvKnX00k
	 KIK1qeZTnNgR2L0XQADe3lt5WOFmMFSr7NGECjiaIGSlwUH5/2mJJTBTJSjPDNG7gK
	 oItRGoIZwZGqQaC3Q8Vep2bB8d44qwpkEJcwYQUfH+QvbROeyWkWI76jj8dfaOiSY9
	 U9o/NpvvcGTBLgAmp17GZI3fXcqLLUDneCilh5q4aaORif16Lhgo81mkyWuU4hdJgq
	 0MykqNNsRvrUQ==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>,
	Song Liu <song@kernel.org>
Subject: [PATCH v3 8/9] objtool/klp: Fix relocations for EXPORT_SYMBOL_FOR_MODULES() symbols
Date: Fri,  7 Aug 2026 14:37:53 -0700
Message-ID: <fe5a00818e06ec613344d41d5944de054fcd8832.1786138493.git.jpoimboe@kernel.org>
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

EXPORT_SYMBOL_FOR_MODULES() puts a symbol in a "module:<names>"
namespace, which the module loader grants access to by matching the
importing module's name against that list.

klp_reloc_needed() only creates a klp reloc for module-owned exports; a
vmlinux export gets a normal reloc.  For a vmlinux symbol exported with
EXPORT_SYMBOL_FOR_MODULES(), using a normal reloc results in a modpost
failure in klp-build:

  ERROR: modpost: module livepatch-foo uses symbol mpol_shared_policy_lookup from namespace module:kvm, but does not import it.

And the modpost error is correct: even with that error removed, the
patch module would fail to load:

  livepatch_foo: module uses symbol (mpol_shared_policy_lookup) from namespace module:kvm, but does not import it.
  livepatch_foo: Unknown symbol mpol_shared_policy_lookup (err -22)

Treat it like an unexported symbol by using a klp reloc.

Note this only affects "module:" namespaces.  Ordinary namespaced
exports continue to work with normal relocs thanks to copy_import_ns(),
which propagates the patched object's import_ns tags to the patch
module.

Fixes: dd590d4d57eb ("objtool/klp: Introduce klp diff subcommand for diffing object files")
Reported-by: Joe Lawrence <joe.lawrence@redhat.com>
Link: https://lore.kernel.org/6a6608f4-0a05-4d75-8b7f-edddfac9c5d4@redhat.com
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/klp-diff.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
index 6d34186d8b24c..0f135b74a5b0c 100644
--- a/tools/objtool/klp-diff.c
+++ b/tools/objtool/klp-diff.c
@@ -30,7 +30,9 @@ struct elfs {
 
 struct export {
 	struct hlist_node hash;
-	char *mod, *sym;
+	char *mod;
+	char *sym;
+	bool mod_ns;
 };
 
 bool debug, debug_correlate, debug_clone;
@@ -135,7 +137,7 @@ static int read_exports(void)
 	}
 
 	while (fgets(line, 1024, file)) {
-		char *sym, *mod, *type;
+		char *sym, *mod, *type, *namespace;
 		struct export *export;
 
 		sym = strchr(line, '\t');
@@ -162,6 +164,14 @@ static int read_exports(void)
 
 		*type++ = '\0';
 
+		namespace = strchr(type, '\t');
+		if (!namespace) {
+			ERROR("malformed Module.symvers (namespace) at line %d", line_num);
+			return -1;
+		}
+
+		*namespace++ = '\0';
+
 		if (*sym == '\0' || *mod == '\0') {
 			ERROR("malformed Module.symvers at line %d", line_num);
 			return -1;
@@ -188,6 +198,9 @@ static int read_exports(void)
 			return -1;
 		}
 
+		/* EXPORT_SYMBOL_FOR_MODULES() */
+		export->mod_ns = strstarts(namespace, "module:");
+
 		hash_add(exports, &export->hash, str_hash(sym));
 	}
 
@@ -1174,11 +1187,16 @@ static bool klp_reloc_needed(struct reloc *patched_reloc)
 	 * clusterfunk that is late module patching, the patch module is
 	 * allowed to be loaded before any modules it depends on.
 	 *
-	 * If exported by vmlinux, a normal reloc will do.
+	 * If exported by vmlinux to all modules, a normal reloc will do.
 	 */
 	export = find_export(patched_sym);
-	if (export)
-		return strcmp(export->mod, "vmlinux");
+	if (export) {
+		if (strcmp(export->mod, "vmlinux"))
+			return true;
+
+		/* EXPORT_SYMBOL_FOR_MODULES() gets a klp reloc */
+		return export->mod_ns;
+	}
 
 	if (!patched_sym->twin) {
 		/*
-- 
2.54.0

