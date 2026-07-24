Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9264142AFA1
	for <live-patching@vger.kernel.org>; Fri, 24 Jul 2026 11:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784893461; cv=none; b=oLGcdhVQ7dT8o7COBwAuIdr+gxrrbsM7r8sXZkfKcCSvQN8CF3Nx+I8KqKQAeNjwWEyfbtkzlfYXbra62oiA868yLAVGdE+Uzk1TJ/6AlKF4pZWhayKXIlKHEI0da1tsTu53W5Q5ZrlPI+IkotDoHCTqmJxPRp3M7fQHRb/Mha4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784893461; c=relaxed/simple;
	bh=awtKp8GoTpZLRWN4FwmOYGzyrNm8WEnDX2kSQMbAf3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aSv57yGN3knhFvHbxGVnylyMvHgowzFc6E15qmBYv0ivPCeC/3mYgTPcmHG3F0l/I2Fq2Jk3AsaZXMfwiTLf/RIEUiUJ2eYuuWlkdUL0rgp7dKU1l8TYEN69vpYKLyr5j6wMHkhLD2AkrMfsHvuOyM9BXCwNIUH+BWyi6F5F454=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bR5xhC9B; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bR5xhC9B"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784893453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kOBS5OEfLhdRCerIgpAYs/smL6UyfBzQi4+mASVl25M=;
	b=bR5xhC9Bgyt/yKBqDd/C/Wrn9LBAv2aJQootVDKCjJqxRtpe3W5wUTs/AOmBWAbdBooqyv
	u7aOPiUEHwXVpF2RxV+CRK/AgkJwGx0l1ljlsrvx4DXHCI14bDY0E229eR5ZugHyIcEVTK
	/nqOlf2WKj2CJeyuCR0CiF/07YIHbGc=
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
	wangrui@loongson.cn,
	liukexin@kylinos.cn,
	guodongtai@kylinos.cn,
	xry111@xry111.site,
	wangyuli@aosc.io,
	loongarch@lists.linux.dev,
	live-patching@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 09/14] objtool/klp: Convert local label references
Date: Fri, 24 Jul 2026 19:41:22 +0800
Message-ID: <20260724114128.31451-10-dongtai.guo@linux.dev>
In-Reply-To: <20260724114128.31451-1-dongtai.guo@linux.dev>
References: <20260724114128.31451-1-dongtai.guo@linux.dev>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: George Guo <guodongtai@kylinos.cn>

Some toolchains reference an object through a local assembler label (.L*)
rather than a section symbol plus offset.  The assembler keeps the label
because a "section + constant offset" reference would go stale under
linker relaxation, while a symbol reference can be recomputed afterwards.
Such labels are assembler-local, absent from kallsyms, and are never
cloned into the livepatch object.

Two toolchains hit this:

  - GCC/GAS on LoongArch references special section entries (__ex_table,
    __bug_table, __jump_table, .altinstructions) through local text
    labels instead of a section symbol.

  - Clang emits a switch jump table through a local label (.LJTI*) in a
    SHF_MERGE|SHF_STRINGS .rodata section, where the table shares the
    section with the livepatch's klp_func name strings.

convert_reloc_secsym_to_sym() only handled the section symbol form and
returned early for a label reference, so the label was never converted
and the reference resolved incorrectly, with no error at build or load
time:

  - GCC: should_keep_special_sym() cannot correlate the entry with an
    included function and silently drops it, so the livepatch module is
    missing the patched function's __ex_table / __bug_table /
    __jump_table entries.

  - Clang: the jump table is not cloned, and its base label resolves into
    the name strings that occupy the same offset; the switch's indirect
    jump then lands on a wild address and the patched function oopses at
    runtime.

Redirect a local label reference off the label, mirroring the section
symbol case:

  - In a text section, to the containing function symbol.  A label with
    no containing function symbol (e.g. hand-written asm in a plain .text
    section) can't be correlated; skip it rather than failing, since such
    entries belong to unchanged code and are dropped anyway.

  - In a non-text section (e.g. the .rodata jump table), to the section
    symbol plus the full offset.

Reported-by: Joe Lawrence <joe.lawrence@redhat.com>
Suggested-by: Joe Lawrence <joe.lawrence@redhat.com>
Co-developed-by: Kexin Liu <liukexin@kylinos.cn>
Signed-off-by: Kexin Liu <liukexin@kylinos.cn>
Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 tools/objtool/klp-diff.c | 49 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
index b9624bd9439b..3e573b73fe6b 100644
--- a/tools/objtool/klp-diff.c
+++ b/tools/objtool/klp-diff.c
@@ -1423,8 +1423,55 @@ static int convert_reloc_secsym_to_sym(struct elf *elf, struct reloc *reloc)
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
+		if (is_local_label(sym)) {
+			unsigned long offset = sym->offset + reloc_addend(reloc);
+
+			if (is_text_sec(sec)) {
+				sym = find_symbol_containing_inclusive(sec, offset);
+				if (!sym) {
+					/*
+					 * A local label with no containing function
+					 * symbol (e.g. hand-written asm in a plain .text
+					 * section).  It can't be correlated to a function,
+					 * so skip it rather than failing the build; such
+					 * entries belong to unchanged code and are dropped
+					 * anyway.
+					 */
+					return 1;
+				}
+
+				reloc->sym = sym;
+				set_reloc_sym(elf, reloc, sym->idx);
+				set_reloc_addend(elf, reloc, offset - sym->offset);
+			} else {
+				/*
+				 * A local label in a non-text section, e.g. Clang's
+				 * .LJTI* switch jump table in .rodata.  It isn't
+				 * cloned into the livepatch either, so redirect the
+				 * reloc to the section symbol plus the full offset,
+				 * mirroring the section-symbol case below.
+				 */
+				if (!sec->sym && !elf_create_section_symbol(elf, sec))
+					return -1;
+				reloc->sym = sec->sym;
+				set_reloc_sym(elf, reloc, sec->sym->idx);
+				set_reloc_addend(elf, reloc, offset);
+			}
+		}
+
 		return 0;
+	}
 
 	sym = find_symbol_containing_inclusive(sec, arch_adjusted_addend(reloc));
 	if (!sym) {
-- 
2.53.0

