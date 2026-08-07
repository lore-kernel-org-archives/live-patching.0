Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B7F45516B;
	Fri,  7 Aug 2026 21:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786138723; cv=none; b=j73dknKN8QxMaQrdzua2wiESl/T3UYFnDpOJuy0+fmIH1Of7mXagCcdlNPao7ZaFTtbLCRy16kpNBsdha3e2ivTDpt3ljNxxsCY6Ccj6uf8++H1GYcryKUuWDFLCrPls3OaWCpROePLCz2G/UDeA5fwuqTJmwqizqStHMXsZ/4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786138723; c=relaxed/simple;
	bh=nafCKiDx5wfPWcCW8RykKOt2cUm3pDGNRFonizi2nOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KFkEfehVUIOZeRfa5HWTpktQcGLiS6K4IauYZZy5vxqTOeCmpraA0d/xJNdOxzuKh7THmTMq1BTVWKZJAZJ39lFK174hh3a+6IxD/bq4sH3EW1hnDBwj+s0kyDhDZGznIw8A+0v2XYiNrW0jK+nXz5Ozko/QJYR03BSRNdGlQBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NbgJK0La; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NbgJK0La"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64BEA1F00A3A;
	Fri,  7 Aug 2026 21:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786138721;
	bh=YTz9xOUv3hUl4ccUxxl7Lc5HUhJ0Of4V9r0GYOZtoZ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NbgJK0La6t300VRHLpHWA9GgxmjJ2Nn5pFhAgDtKwPnQZjAsxE5qLij/DLUO6h/mN
	 Q0ND3KHTKdevJCeNRD5N4Up8McI+vaN441pASDeO49a+tiwpTms6rOSRUYLZ3NUIoQ
	 VsuH6Ul8znX6Xi0k7UOrbDDXWr3E5ywz+Uja9LMkcHPu0bFDgADCjET5AYVWO/DZaQ
	 VxeTY1IPZIqdPdm0e6NhgTdYOX7wQ0+iyrTm3/yRRSDi1rVHDJl+Q6h8GlhrTkDbCY
	 pDa7kpkQ/MvGv9Osw1P+djR2QOK+mbHMTpgo3Hm7hX5mYRFBu5JgT4Fw345vDVb2MN
	 l+sfoxzudOvPw==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>,
	Song Liu <song@kernel.org>
Subject: [PATCH v3 6/9] objtool/klp: Don't match local symbols against exports
Date: Fri,  7 Aug 2026 14:37:51 -0700
Message-ID: <dafc7c017d1f62e2190a20dc84a52fbfc4c70210.1786138493.git.jpoimboe@kernel.org>
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
Acked-by: Song Liu <song@kernel.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/klp-diff.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
index e2c6c69dbb4f0..f5d5711623f03 100644
--- a/tools/objtool/klp-diff.c
+++ b/tools/objtool/klp-diff.c
@@ -1101,6 +1101,9 @@ static struct export *find_export(struct symbol *sym)
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

