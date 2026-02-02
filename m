Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10167376498;
	Mon,  2 Feb 2026 18:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770055286; cv=none; b=kwtjnwDN+UuoL2wuRMj44lN2yncGLy6vbJV735/NrwXt/ZdaIVW9tTwhg+gWVFDSz/VCrfjlC2jhv7kwpz66AEdxwuwu9dAuIxUUMyH6dzlAIT61RLsGdKRYoaNHOBtI+0UxpnDzg3ri8+vAefF5x7MVGA6SSbE4nK9fwgLEH3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770055286; c=relaxed/simple;
	bh=bxS4LYmsZDEdGZDSBA18gbQaB9IvnUzePe5VAUD6GzE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ayyr4Slc/o/hXRmoh7DCJlWb+EOrnht4ZMPBZ1gdlOcw3WYQgkO9zkzj3WFfhsZ8pZFrDRZ0TUKGt4vy8kFivtyhiGEwcDgCC6OON+FvWOxW/gw0EDicn4tDIuN6YVjlmKYS4izkjpx6tNqgttV0ESeFT7/a0lzbPiLIGLXjz4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y0Od5W7N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y0Od5W7N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59F0FC2BC86;
	Mon,  2 Feb 2026 18:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770055285;
	bh=bxS4LYmsZDEdGZDSBA18gbQaB9IvnUzePe5VAUD6GzE=;
	h=From:To:Cc:Subject:Date:From;
	b=Y0Od5W7NWDrf09mEBKW28vrk0BV+RM7NCGnOwYV8Oj9RnMW0/9Rl2EEWH9PnXQVB6
	 t53W7O63LiZRfsk53Gi4Gdw8mN1mNWyQVFc6+SLlIZJNEr6ejHZq/IpDOXsUzefgf2
	 qYrQftw2AGHsl1uvUFnsSPl/B13JZ62Tuk5cQ1w/xngvA24uPgD3UM+pNF47GJ6IZ/
	 05oUlrKFhDrbppdTEYt+4nnuaBpY8VvgsmUfumQlRGoVF0F6K6/am4uISRUoK+Pyl7
	 yxZ/Cl+mjo1567h1JavzZMxg/PtV8s/W/J+I4VmTbLs0us1pxswNDaqedjhPkSqTCj
	 4NAARbnMEcirw==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Song Liu <song@kernel.org>
Subject: [PATCH] objtool/klp: Fix symbol correlation for orphaned local symbols
Date: Mon,  2 Feb 2026 10:01:08 -0800
Message-ID: <e21ec1141fc749b5f538d7329b531c1ab63a6d1a.1770055235.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When compiling with CONFIG_LTO_CLANG_THIN, vmlinux.o has
__irf_[start|end] before the first FILE entry:

  $ readelf -sW vmlinux.o
  Symbol table '.symtab' contains 597706 entries:
     Num:    Value          Size Type    Bind   Vis      Ndx Name
       0: 0000000000000000     0 NOTYPE  LOCAL  DEFAULT  UND
       1: 0000000000000000     0 NOTYPE  LOCAL  DEFAULT   18 __irf_start
       2: 0000000000000200     0 NOTYPE  LOCAL  DEFAULT   18 __irf_end
       3: 0000000000000000     0 SECTION LOCAL  DEFAULT   17 .text
       4: 0000000000000000     0 SECTION LOCAL  DEFAULT   18 .init.ramfs

This causes klp-build warnings like:

  vmlinux.o: warning: objtool: no correlation: __irf_start
  vmlinux.o: warning: objtool: no correlation: __irf_end

The problem is that Clang LTO is stripping the initramfs_data.o FILE
symbol, causing those two symbols to be orphaned and not noticed by
klp-diff's correlation logic.  Add a loop to correlate any symbols found
before the first FILE symbol.

Fixes: dd590d4d57eb ("objtool/klp: Introduce klp diff subcommand for diffing object files")
Reported-by: Song Liu <song@kernel.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/klp-diff.c | 39 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
index 1e649a3eb4cd..9f1f4011eb9c 100644
--- a/tools/objtool/klp-diff.c
+++ b/tools/objtool/klp-diff.c
@@ -364,11 +364,40 @@ static int correlate_symbols(struct elfs *e)
 	struct symbol *file1_sym, *file2_sym;
 	struct symbol *sym1, *sym2;
 
-	/* Correlate locals */
-	for (file1_sym = first_file_symbol(e->orig),
-	     file2_sym = first_file_symbol(e->patched); ;
-	     file1_sym = next_file_symbol(e->orig, file1_sym),
-	     file2_sym = next_file_symbol(e->patched, file2_sym)) {
+	file1_sym = first_file_symbol(e->orig);
+	file2_sym = first_file_symbol(e->patched);
+
+	/*
+	 * Correlate any locals before the first FILE symbol.  This has been
+	 * seen when LTO inexplicably strips the initramfs_data.o FILE symbol
+	 * due to the file only containing data and no code.
+	 */
+	for_each_sym(e->orig, sym1) {
+		if (sym1 == file1_sym || !is_local_sym(sym1))
+			break;
+
+		if (dont_correlate(sym1))
+			continue;
+
+		for_each_sym(e->patched, sym2) {
+			if (sym2 == file2_sym || !is_local_sym(sym2))
+				break;
+
+			if (sym2->twin || dont_correlate(sym2))
+				continue;
+
+			if (strcmp(sym1->demangled_name, sym2->demangled_name))
+				continue;
+
+			sym1->twin = sym2;
+			sym2->twin = sym1;
+			break;
+		}
+	}
+
+	/* Correlate locals after the first FILE symbol */
+	for (; ; file1_sym = next_file_symbol(e->orig, file1_sym),
+		 file2_sym = next_file_symbol(e->patched, file2_sym)) {
 
 		if (!file1_sym && file2_sym) {
 			ERROR("FILE symbol mismatch: NULL != %s", file2_sym->name);
-- 
2.52.0

