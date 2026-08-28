Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AF230F81A;
	Fri, 28 Aug 2026 17:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787939342; cv=none; b=hZn8HgMIbrjt5MLnoiONswqZXFuTpjTaHHtnnq4TptBb44POTUhEQR8eBpCt6JeYXIriaL3mevV9JU19dMJFKPFv0HGCCf16qajDQqfthFM5v6BftWjCGmLukMOddyVtLIbaCjqQAgRz8hG7z+5l5ivIB595pbjxGZpvndIlEHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787939342; c=relaxed/simple;
	bh=sJj3ENhQK7v1h1vch3Sowy/bLVtrCKXVBK9XIYoFSXo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DMqlUgbj3SUZwuhev8mB1li+QRAKm0JzAPU6a64hmZTKEdknzmGYkV8H3RIolPwMJf5EXs6PotWzbrk57eLdKeilPq+CON1KLTc4FV3t+LkyouvTfZd5oAFJB0golIM9C9MOfe7J/JJW3On9QeF32GmrKqlbNryUusp1nDgcckI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K/Y3gAwO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K/Y3gAwO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 794F21F00AC4;
	Fri, 28 Aug 2026 17:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787939340;
	bh=cOccTRve1LXvxs2Rwy6f/9k13lyxoJErpAXMpSVSD8c=;
	h=From:To:Cc:Subject:Date;
	b=K/Y3gAwO16vimIKkFmHFSleb2U7aFKbLRY0FakziG7Ja+GdjknHynMwqzeeinCV48
	 0H9f6AmUdlDHGl7JZmM74EtJzAVi3VfDl1qHyfkY8mpjc8fE7wQCX+nuBi/aNW2uXp
	 wUAVqltpMnuW2BpPsVlnoG4JYB7UO5tCFHJgSlLaHbEHWAC04bRlWebA1k6PRHSpyY
	 arj6UMOwGdG69aQGRRjEyKlj0YPuKwvzBGiCxQ44kzqPFvNxeukiPlGK7ISf2mnuCk
	 jGD6FVjliOJ8eN3P/nqkOlwqTF1xGJ0OBeYZwncXhzEfOtrcK1n2VjPHqk4BbWBvvG
	 gjCMo8ohMEUFw==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Song Liu <song@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH v2] objtool/klp: Fix checksums for constant pool references
Date: Fri, 28 Aug 2026 10:48:50 -0700
Message-ID: <f3a9e74ceebc6475ce94bcfe985401140857814a.1787939301.git.jpoimboe@kernel.org>
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

Clang also uses .LC* symbols, but also uses anonymous data.  Both
compilers put this data in .rodata.cst<num> sections.

Fixes: 0d83da43b1e1 ("objtool/klp: Add --checksum option to generate per-function checksums")
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/klp-checksum.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/objtool/klp-checksum.c b/tools/objtool/klp-checksum.c
index b8e47f28997e9..ebe25f9c5260a 100644
--- a/tools/objtool/klp-checksum.c
+++ b/tools/objtool/klp-checksum.c
@@ -54,6 +54,19 @@ static int checksum_debug_init(struct objtool_file *file)
 	return 0;
 }
 
+/*
+ * Detect a reference to anonymous constant pool data which the compiler places
+ * in .rodata.cst<num> and which either has an .LC<num> symbol associated with
+ * it or (with Clang) no symbol at all.  These are typically initializers for
+ * local function stack data, so they're considered part of the function rather
+ * than data per se.
+ */
+static bool is_anonymous_const_data(struct symbol *sym)
+{
+	return strstarts(sym->sec->name, ".rodata.cst") &&
+	       (is_sec_sym(sym) || strstarts(sym->name, ".LC"));
+}
+
 static void checksum_update_insn(struct objtool_file *file, struct symbol *func,
 				 struct instruction *insn)
 {
@@ -129,6 +142,14 @@ static void checksum_update_insn(struct objtool_file *file, struct symbol *func,
 		goto alts;
 	}
 
+	if (is_anonymous_const_data(sym)) {
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

