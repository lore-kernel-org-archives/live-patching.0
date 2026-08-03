Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBD93264E7;
	Mon,  3 Aug 2026 05:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785736187; cv=none; b=nDa+w54+3Sm82Tyd9ckBiKr84jd53Ma23g3scz5FjjY62bs9MrDhVpyO6RRgwUCKb+KaBZRFN+dDyFzN/WXSp33OGg188gFVP0/pyTIn8saf5RwAg1kFaFNagtLwLDwmQ4hpm0390Yl0pXL7X2S9fTvaf1wGnHjD52E0FNdpUvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785736187; c=relaxed/simple;
	bh=SyI+IQNica6Ubz+9SeZEzB5MRU1E41rRPUygY/icCxA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=BFgpI83jBfpQFnLv0XrWFavNP7nvFxFy7e6t/MslQyc/ONWlN8dTTuPdc6i6WFcl8gxYnDBLRdbxJ6OuKbPkiajdj4Iz1GtFB65Ya5vM0+CoBLIX5sNbCwGF0uLqRVhHERMXgU8Jr4D2zTT4hj3bgt2QZa3SzPbAt8l3GbGZRhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BM5PS3Yb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dO11yhMg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BM5PS3Yb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dO11yhMg"
Date: Mon, 03 Aug 2026 05:49:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1785736183;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EYF5c+Y+ipD6ak9TezylXNi/8RkEbu9Is9KUtzuJjf4=;
	b=BM5PS3YbBcSSbfgUI+PWjikxvmXZq1Rj1fFhk/gMp9uf2+R1ZndE9OqmCgjwO0y8HeRf6Z
	L/JYxe/MLTGM4UWNUbJdroQBtRcHKSDHlhPXXpMvKubpaJy6d5mgFyILfrfaubzb/HlefE
	JQn+Ig26co2KWM3HjGTj9aFuU8cngMMb7lT458kY5Kcu5yHp2tbtkokz9qjrmfReVJqQ5N
	yG3CsFqHxl/tFcj9aKxA4XgzJQUfwyo76Hvy1HUAaYuh3NHRTuGqEnbZiiy5iEeF/D7Mmg
	P4jAh6A5Svw54Wjk7BWjGyYfVD6I3ovVeIYlpPRCRVK9dk2zlqfmf2H3WKaBrA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1785736183;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EYF5c+Y+ipD6ak9TezylXNi/8RkEbu9Is9KUtzuJjf4=;
	b=dO11yhMghS18JAm1q72tUKDXYHUGN/zOzjNFpzL+yNNfJH1YzC+W0i3NRgnAbYL2vCQExv
	JJwoYzpRmv5kKxBw==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool/klp: Fix false module dependencies caused
 by dead relocs
Cc: Ben Procknow <bprockno@redhat.com>, Joe Lawrence <joe.lawrence@redhat.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 live-patching@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To:
 <9548393f4d89ec3b498f4f69aa6ef6b9bb7150fe.1785727106.git.jpoimboe@kernel.org>
References:
 <9548393f4d89ec3b498f4f69aa6ef6b9bb7150fe.1785727106.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <178573618216.1210945.4485019859591624931.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     5ca8c91d1ea6534842e7e0065d15104d802506cd
Gitweb:        https://git.kernel.org/tip/5ca8c91d1ea6534842e7e0065d15104d802=
506cd
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Sun, 02 Aug 2026 20:24:25 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 03 Aug 2026 07:12:38 +02:00

objtool/klp: Fix false module dependencies caused by dead relocs

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

Fixes: dd590d4d57eb ("objtool/klp: Introduce klp diff subcommand for diffing =
object files")
Reported-by: Ben Procknow <bprockno@redhat.com>
Reported-by: Joe Lawrence <joe.lawrence@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: live-patching@vger.kernel.org
Link: https://lore.kernel.org/20260720145658.1103243-5-joe.lawrence@redhat.com
Link: https://patch.msgid.link/9548393f4d89ec3b498f4f69aa6ef6b9bb7150fe.17857=
27106.git.jpoimboe@kernel.org
---
 tools/objtool/elf.c                 | 13 +++++++++++++
 tools/objtool/include/objtool/klp.h |  2 ++
 tools/objtool/klp-diff.c            | 16 ++++++++++++----
 3 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 33c95a7..a791f4e 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -23,6 +23,7 @@
 #include <linux/log2.h>
 #include <objtool/builtin.h>
 #include <objtool/elf.h>
+#include <objtool/klp.h>
 #include <objtool/warn.h>
=20
 static ssize_t demangled_name_len(const char *name);
@@ -626,6 +627,18 @@ static int read_symbols(struct elf *elf)
 			return -1;
 		}
=20
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
+			sym->name +=3D strlen(KLP_TOMBSTONE_PREFIX);
+
 		if ((sym->sym.st_shndx > SHN_UNDEF &&
 		     sym->sym.st_shndx < SHN_LORESERVE) ||
 		    (shndx_data && sym->sym.st_shndx =3D=3D SHN_XINDEX)) {
diff --git a/tools/objtool/include/objtool/klp.h b/tools/objtool/include/objt=
ool/klp.h
index 6f60cf0..aab6db4 100644
--- a/tools/objtool/include/objtool/klp.h
+++ b/tools/objtool/include/objtool/klp.h
@@ -23,6 +23,8 @@
 #define KLP_RELOCS_SEC	"__klp_relocs"
 #define KLP_STRINGS_SEC	".rodata.klp.str1.1"
=20
+#define KLP_TOMBSTONE_PREFIX	".klp.tombstone."
+
 struct klp_reloc {
 	void *offset;
 	void *sym;
diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
index 15d37d9..75ba0e0 100644
--- a/tools/objtool/klp-diff.c
+++ b/tools/objtool/klp-diff.c
@@ -1362,6 +1362,7 @@ static int clone_reloc_klp(struct elfs *e, struct reloc=
 *patched_reloc,
 	s64 addend =3D reloc_addend(patched_reloc);
 	const char *sym_modname, *sym_orig_name;
 	static struct section *klp_relocs;
+	char tombstone_name[SYM_NAME_LEN];
 	struct symbol *sym, *klp_sym;
 	unsigned long klp_reloc_off;
 	char sym_name[SYM_NAME_LEN];
@@ -1376,15 +1377,22 @@ static int clone_reloc_klp(struct elfs *e, struct rel=
oc *patched_reloc,
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
=20
 	sym =3D patched_sym->clone;
 	if (!sym) {
-		/* STB_WEAK: avoid modpost undefined symbol warnings */
-		sym =3D elf_create_symbol(e->out, patched_sym->name, NULL,
+		if (snprintf_check(tombstone_name, SYM_NAME_LEN,
+				   KLP_TOMBSTONE_PREFIX "%s", patched_sym->name))
+			return -1;
+
+		sym =3D elf_create_symbol(e->out, tombstone_name, NULL,
 					STB_WEAK, patched_sym->type, 0, 0);
 		if (!sym)
 			return -1;
