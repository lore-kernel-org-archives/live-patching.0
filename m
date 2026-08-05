Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A21389114;
	Wed,  5 Aug 2026 14:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785940218; cv=none; b=IE5XxLiSXDd4ymVHggifZfLxdITvWKYKQfTy8eQ2Z8NaM11KNLgDoBeN2vWTU6XVEzHsQfu9wtmFZZZgTtJYh8Rx13WRi3odJobNYTq7RoWocuXOR8QlFsbTD6nfNm5Mp5r8atCga/VdJmRO276ePsydfnUM7GPilDgHfTjlGuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785940218; c=relaxed/simple;
	bh=riYAtnpzpPVjIRWzy2+QlSS01Zoi9vrEjPpMXhmcKRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cyF50cNcDv4+ieayxEqL0GsEVgdAB+cpZEB/iJYXHOREsCpji/MQtl352ITIJ151PNFv7AgEO6sttfn3NNa9EtI9LkeS+dOnquBC1nzAVB2RqJEyxpfwHVFJJt+NWcmQWmTUYurA6tXDV13hythwFON1AhViT7Nxxt7SDliFFIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HwrygccD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HwrygccD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C539F1F00A3D;
	Wed,  5 Aug 2026 14:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785940202;
	bh=SrcSJAJhHPJIPDseZ87e2905Qnx5EaA+xQVuSA2G/o4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HwrygccDcwjD3SaLDy0Vu8tMxNtILyXRcCNxX2wPR8uQPrae+raHMDFcYvjXSrRy9
	 Q+VHWu8LiiMSjTJ9T5pPK3lYf52OGcmasxY5PF/Rl9LteaSz9Zn214JB7Wqo9uPvWn
	 SaxWjaQz5rGgs5g15xOYiWnfmHAa4iNDhIyJ2NQaSaXNnRHTp2KdyX/wnxok6vVo9N
	 QKNEHM15CkHqRB94GhfgEmPVbBcndgO9mPctY8MqfFFabOlOR+cqOhVV9I0884PsXn
	 apZJloiUYUH7QBxab21zxlLglUk+PArKfvHNQsWRPZ8aEzg6GiWFbmqlCUpLzZqufA
	 6OAsh534HORVw==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>,
	Song Liu <song@kernel.org>
Subject: [PATCH v2 6/7] objtool/klp: Don't match local symbols against exports
Date: Wed,  5 Aug 2026 07:29:43 -0700
Message-ID: <e36ef2370ad7ca6bf139b8791a1d2810f55785e6.1785939903.git.jpoimboe@kernel.org>
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
index 91a9562c45a6e..aebe68a401571 100644
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

