Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4B739A05D;
	Mon,  3 Aug 2026 03:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785727499; cv=none; b=syHjj8QH7vFSkPFmeC7G3ck0y3g7ksUOCvmYnKvAt4cmaoWvAWyt+43HpwEc5dHhXGYDBWLZxEvlBzrFO7H9024i/E1/lkRQO7Hkoi3CXGTsjzYpFtRkCgWMRksUHPbltJOk5ANce3lwiLo/aGAvFjEp4kwTUIs8mseOVBfTQDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785727499; c=relaxed/simple;
	bh=L/hTNykbptfx0H+zY2cUmrueHsOfsVbVLsNT9q/U/us=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j5N14gD6M/Y08EGIPDNA5Jturs8IqhI7pk8+E05hQ9WMOsE2Q9eB308Xw1+u9fT09qMQjErO37Kl1mJ2NSWUgP0KqyaT3HADoAgmGcyF9qZxfq6Rj6WkJiBWusrbPrEfgsj5y4J+Z8w3hLIryhns7NEI5jZzx6zPZs74k1mkkuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YjJ2R+NO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YjJ2R+NO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2DE61F00ACF;
	Mon,  3 Aug 2026 03:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785727497;
	bh=6no+nNQlBtcmRkmVefZUiRJpZdR7owkbYwDomyok6cQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YjJ2R+NOFtGTr834AIMhT2sc3tNi1zkqtpAupU9tA2VCryF28wCHF+I47cjCl21Pp
	 JKzdjCcrNGVRoRKBAZj+PTLZOT3kd94O8C2YSFY/T9IVJ8y4NfkckelfUGoSIF/ANG
	 Tc5aCW/tsUG+CbDPL644KA9LOWRu/55TQtT008acZIpVuq0MKcLvGUGA2QhkDeNPwG
	 DH2AcNwFsHbfr9jLf62RM/nzyvQgbNcUhbr/qrO79+BuptObXs53jIFCS92jisSLz/
	 +cAj+HsEoYHh0HzjnaeuLF0EG5QZpEUh99VgVul/AW3beG00PewximwmZzNGe0XBqz
	 4bv5UQr1YF8Ag==
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
Subject: [PATCH 13/14] objtool/klp: Don't match local symbols against exports
Date: Sun,  2 Aug 2026 20:24:35 -0700
Message-ID: <f196fe39cfed7bc706f9e715cd9a318bdd1bf3bf.1785727106.git.jpoimboe@kernel.org>
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

While cloning a reloc, klp diff calls find_export() to determine whether
the referenced symbol is exported.  That decides whether the reference
needs a klp reloc, which object the klp symbol belongs to, and whether
the symbol's data needs to be copied into the patch module.

But find_export() matches purely on symbol name, so a static function or
variable which happens to share its name with an export is mistaken for
a reference to that export:

  - klp_reloc_needed() creates a klp reloc pointing at the exporting
    module's symbol rather than the local one.  For a vmlinux export it
    skips the klp reloc altogether, leaving a normal reloc which the
    module loader resolves to the vmlinux symbol.

  - clone_reloc() treats the symbol as external and clones it without
    its data, leaving a dangling reference.

  - validate_special_section_klp_reloc() attributes a static branch or
    call key to the wrong module, and for a vmlinux export skips the
    unsupported-key check entirely.

Exports are always global, so ignore local symbols in find_export().

Fixes: dd590d4d57eb ("objtool/klp: Introduce klp diff subcommand for diffing object files")
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/klp-diff.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
index e00dbe053a6e..e0dc22cef2c3 100644
--- a/tools/objtool/klp-diff.c
+++ b/tools/objtool/klp-diff.c
@@ -1102,6 +1102,9 @@ static struct export *find_export(struct symbol *sym)
 {
 	struct export *export;
 
+	if (is_local_sym(sym))
+		return NULL;
+
 	hash_for_each_possible(exports, export, hash, str_hash(sym->name)) {
 		if (!strcmp(export->sym, sym->name))
 			return export;
-- 
2.54.0

