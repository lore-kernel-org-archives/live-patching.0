Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08273911AB;
	Fri, 28 Aug 2026 03:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787889294; cv=none; b=AsIpFnkiUfs4bRXgxWpWkJV4f37WsuSgi3j5EGhPteJq8vYFc6jcDeMgCaE7j/DdVIrJK4cDfrLJQJH392jdZxnDKJ2UGr8lh0P6h/sQO8ofJrhoNfE3O/hDTLChG9l76eS+41vCne9TC61+6l+El0EewXiv6NB+IzcqZZD88bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787889294; c=relaxed/simple;
	bh=x4BTV2BMpLlEFZdRZaxIWkEVgTiri+cJfoXPXnQhEQA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YnEWojjyxJVKCoSc+XSMHMLnmreT6LJv8AU/emI1bEOUp8Bf2r2XPTLJP6SLcg8xGbSFh1zBJE4rR6fk8rmWVqd3NPLlS+qPKe25/pJOTnXwEz6jzZ1v8jLZJ5E9/EQ/ZNgWt9r7ZsRcoxX/6zI5Vr+35hhMOJTNQ3AVt88cGbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eap+iOm/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eap+iOm/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0430B1F000E9;
	Fri, 28 Aug 2026 03:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787889293;
	bh=aRYUErYZ1ag+ilc/SjchFo8XCqHfsDxVG9hc3Q9SUPE=;
	h=From:To:Cc:Subject:Date;
	b=Eap+iOm/gadOOhK+QlUt9PNSJ7fKbn+xuBMVzPYeH6vNiJ9Qe9uSd2avD+OZc/MCG
	 r/tPcUpPM9CEXkplUuRgvQyvLNaJuk2Ev7BAxqJUtmVaNdvrFc/S5PpywKKJcju0cP
	 JEb42K01nD20IG/RUSnDqYWIuiwJuPJXwGFiJEb5wtzU1V6Lo2zslraiwV+1k63Cpk
	 bOKXXPkOd+fvKJBh/aLf1puW0WMVhg80Lc0gW0e88d9vCU8xoo8Jvg1+OwJZ3rNvlB
	 cjUAmcadFxU2QnfYjbLwTKZ07mOjahRtoFB52TN9QgqFuvtrNmcflxgn9ZMZrK61ZP
	 aUHSC6YYrK2kw==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Song Liu <song@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH] objtool/klp: Fix checksums for constant pool references
Date: Thu, 27 Aug 2026 20:54:50 -0700
Message-ID: <22a92df358195864e83fb4cd16181c5faa63c489.1787889249.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding a line of code to __link_shadow_page() with a literal string
causes a false positive changed function with GCC:

  arch/x86/kvm/kvm.ko.o: changed function: kvm_tdp_mmu_map_private_pfn

While the patch only touched __link_shadow_page(), the string addition
triggered a rename of .LC64 -> .LC65 in kvm_tdp_mmu_map_private_pfn()
even though the underlying referenced constant data didn't change.

So for .LC* symbols, the suffix is arbitrary but the data isn't.  Add
the underlying data to the checksum calculation rather than the symbol
name.

Fixes: 0d83da43b1e1 ("objtool/klp: Add --checksum option to generate per-function checksums")
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/klp-checksum.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/objtool/klp-checksum.c b/tools/objtool/klp-checksum.c
index b8e47f28997e9..359fd27616013 100644
--- a/tools/objtool/klp-checksum.c
+++ b/tools/objtool/klp-checksum.c
@@ -129,6 +129,14 @@ static void checksum_update_insn(struct objtool_file *file, struct symbol *func,
 		goto alts;
 	}
 
+	if (strstarts(sym->name, ".LC")) {
+		void *cst;
+
+		cst = sym->sec->data->d_buf + sym->offset + offset;
+		__checksum_update_insn(func, insn, cst, sym->sec->sh.sh_entsize);
+		goto alts;
+	}
+
 	if (is_sec_sym(sym)) {
 		sym = find_symbol_containing(reloc->sym->sec, offset);
 		if (!sym)
-- 
2.55.0

