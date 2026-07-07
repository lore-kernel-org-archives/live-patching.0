Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EE43C555B
	for <live-patching@vger.kernel.org>; Tue,  7 Jul 2026 07:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783409001; cv=none; b=gshZ/FPMG9V/dvCEq5PC+P8NHu6TpqXpMmVOslRwxHZgkWr6rHA4QYvgwyIfyLqN+jFC7ad9iwEPXp86iSOkC0y5z8I+SG3a8ScXfatPq22pLDk7DSZn/sFyd+OY195i9P0qUuJkU0d3xeXUdQ77rfGweSDCZDml5SJyCs9BigE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783409001; c=relaxed/simple;
	bh=oJfRTd/YfCpRQIlHUU0EhRdn+cxmTArmqxlE5cFyjUE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N1nkWiH3ouT2sF48otLBhuxI811uSLL9HVUGrsIyiuGuhODf4alhZVeuC6DEiJyP3B6vbEW/+DuiXyIHR1ERzG2iUSXm1SOh7aLkuwPvlIShXvfLAi98yrS49k6DbxCUeXTUQgS/sx/zozWJttibBnwhFjoZJZyVNdrgKFm7duE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fmAjCcjR; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fmAjCcjR"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783408991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=omd/IYAr8HFNM9DotDwvj76ZFJM2G5dGzr6lUjILi60=;
	b=fmAjCcjR9cbDf5NazGB/ImTERibPDSjn9Ub1+5xRAqpo43QWGh3HW0nVZWTuJG0Z5kfIwO
	y4lMf8IUDE1iyves59uzlfmsHwGZi16xNW0N86d3z81HmuWCMg7U0pIoDaGlpXbS+qMwWd
	tscN0Pw7zXDfVvLzjg5o0Qrj/tuOrN4=
From: George Guo <dongtai.guo@linux.dev>
To: chenhuacai@kernel.org,
	jpoimboe@kernel.org,
	peterz@infradead.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com
Cc: kernel@xen0n.name,
	joe.lawrence@redhat.com,
	rostedt@goodmis.org,
	ardb@kernel.org,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	yangtiezhu@loongson.cn,
	jiaxun.yang@flygoat.com,
	liukexin@kylinos.cn,
	guodongtai@kylinos.cn,
	xry111@xry111.site,
	wangyuli@aosc.io,
	loongarch@lists.linux.dev,
	live-patching@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 10/12] objtool/klp: Convert local label references in special sections
Date: Tue,  7 Jul 2026 15:20:29 +0800
Message-Id: <20260707072031.231066-11-dongtai.guo@linux.dev>
In-Reply-To: <20260707072031.231066-1-dongtai.guo@linux.dev>
References: <20260707072031.231066-1-dongtai.guo@linux.dev>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: George Guo <guodongtai@kylinos.cn>

GCC/GAS on LoongArch references special section entries (__ex_table,
__bug_table, __jump_table, .altinstructions) through local text labels
(.L*) instead of a section symbol plus offset.  The assembler keeps the
label because of linker relaxation: a "section + constant offset"
reference would go stale when the linker deletes or shrinks
instructions, while a symbol reference can be recomputed after
relaxation.

convert_reloc_secsym_to_sym() only handles the section symbol form and
returns early for such label references.  The label is never cloned
into the livepatch object, so should_keep_special_sym() cannot
correlate the entry with an included function and silently drops it: a
GCC-built livepatch module ends up missing the patched function's
__ex_table / __bug_table / __jump_table entries, with no error at
build or load time.

Redirect label references in text sections to the containing function
symbol, mirroring the section symbol case.  A label with no containing
function symbol (e.g. hand-written asm in a plain .text section) can't
be correlated; skip it rather than failing, since such entries belong
to unchanged code and are dropped anyway.

Reported-by: Joe Lawrence <joe.lawrence@redhat.com>
Suggested-by: Joe Lawrence <joe.lawrence@redhat.com>
Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 tools/objtool/klp-diff.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
index b9624bd9439b..05fd70e24326 100644
--- a/tools/objtool/klp-diff.c
+++ b/tools/objtool/klp-diff.c
@@ -1423,8 +1423,41 @@ static int convert_reloc_secsym_to_sym(struct elf *elf, struct reloc *reloc)
 	if (!strcmp(reloc->sec->name, ".rela__patchable_function_entries"))
 		return convert_pfe_reloc(elf, reloc);
 
-	if (!is_sec_sym(sym))
+	if (!is_sec_sym(sym)) {
+		/*
+		 * Most toolchains reference special-section entries via the
+		 * section symbol plus an offset.  GCC/GAS on LoongArch instead
+		 * references a local text label (.L*): LoongArch linker
+		 * relaxation is the reason GAS keeps the label rather than
+		 * reducing it to a section symbol reference.  Such a label is
+		 * never cloned into the livepatch object, so the entry would be
+		 * silently dropped.  Redirect the relocation to the containing
+		 * function, mirroring the section-symbol case below.
+		 */
+		if (is_local_label(sym) && is_text_sec(sec)) {
+			unsigned long offset = sym->offset + reloc_addend(reloc);
+
+			sym = find_symbol_containing_inclusive(sec, offset);
+			if (!sym) {
+				/*
+				 * A local label with no containing function
+				 * symbol (e.g. hand-written asm in a plain .text
+				 * section).  It can't be correlated to a function,
+				 * so skip it rather than failing the build; such
+				 * entries belong to unchanged code and are dropped
+				 * anyway.
+				 */
+				return 1;
+			}
+
+			reloc->sym = sym;
+			set_reloc_sym(elf, reloc, sym->idx);
+			set_reloc_addend(elf, reloc, offset - sym->offset);
+			return 0;
+		}
+
 		return 0;
+	}
 
 	sym = find_symbol_containing_inclusive(sec, arch_adjusted_addend(reloc));
 	if (!sym) {
-- 
2.25.1

