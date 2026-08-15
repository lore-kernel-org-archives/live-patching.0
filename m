Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656BF2E8DEB;
	Sat, 15 Aug 2026 04:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786769145; cv=none; b=lbVxIyy1hnQ9hOVU8xuW1JZseDIDwTbj5dYXLZ9V7Nd7/tL5py4TcaHwKi043gAlVNXeawJ99ei5bGNQOFL+tJ9+HKR1+SXi0jXvQdBbD646uv610A2kf9F9YyMjOs9HEFTAuKydZsew+E2cRO5YHCd0T7vJNKDondWWq4MfpFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786769145; c=relaxed/simple;
	bh=5+2v3xzRRPM2g3ZS5UgEZ+QEO21isz1ppDAGo2uEPMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UwhYT3/FtpKSCX9j+HIiU3nJZTYzGGyFiOB+29k6iZhNdBOweVditEnVggUmlaLt59J8VY0H3b5e2SnVN72vR3S5RJTyOhR6KFGChk/xLgJhK88aCJ5KzgCLzX027dTpRzT2xPZ33eoQ/1rk9BOQusuxWEIvfh376jN0Uwyog6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eXcvx5u7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eXcvx5u7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96D691F00ADE;
	Sat, 15 Aug 2026 04:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786769144;
	bh=Nh6+iOz6P0x9Gy9tGfnUR7uYUyFR6FMVvpIxe/ECC8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eXcvx5u77fONLhKjmIiOZseXPxSjRgqbh6+vfvoRJ92yY8GBN4XJLYjLJatsvP9Ts
	 6IgmA35bg8PJJt5DD3QYgUURx270joU7X+roBR7AfWoqgXJBcrtsdLFu9Di+TPfEy3
	 24zTxMFe+XPMOWciZB2PrRvGRsPcPGx02DONPb3VoWovtpotahF8l5CAwsDdUFvNHQ
	 VCxKU4L7p3L28IoslkLXlfSKWn+8O6p9341gD/Yv+zNOtuPmZL2UhBPGVdk7qfHhOe
	 GNGDQnfrzY+OjWUxghNT0MKCXQe0G7u07N8c7sK/fIOO0lb90CQR6/qeivzQZf8O/a
	 SQSVTkhmEOB6w==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	live-patching@vger.kernel.org,
	Song Liu <song@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Mark Brown <broonie@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Kees Cook <kees@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	linux-toolchains@vger.kernel.org
Subject: [PATCH 02/12] arm64/module: Fix BTI exceptions caused by omitted landing pads in Clang 21
Date: Fri, 14 Aug 2026 21:45:19 -0700
Message-ID: <2ff1b2482406c61ca5979d6284ba5f948a3fbc20.1786768375.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1786768375.git.jpoimboe@kernel.org>
References: <cover.1786768375.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following BTI exception was seen when loading a livepatch module:

  Internal error: Oops - BTI: 0000000036000001 [#1]  SMP
  pstate: 634004c9 (nZCv daIF +PAN -UAO +TCO +DIT -SSBS BTYPE=jc)
  pc : kill_orphaned_pgrp+0x0/0x150
  lr : do_exit+0x498/0xaf0 [livepatch_combined]

The problem is that the patch module's do_exit() is branching to a
static function in vmlinux using a module PLT veneer (indirect branch),
but the target function doesn't have a BTI landing pad.

Clang 21+ omits the landing pad for static functions which can only be
reached by a direct branch.  But livepatch modules use klp relocations
to reference arbitrary kernel symbols, and with
CONFIG_RANDOMIZE_MODULE_REGION_FULL the module is far enough away that
every call to vmlinux needs a PLT.

Note this problem is actually not specific to livepatch.  It's possible
for any module's .init section to be allocated > 128MB away from its
.text section.  So calls from .init to .text via a PLT can trigger a BTI
exception when the target function doesn't have a landing pad.

GCC has always omitted the landing pad when possible, so kernel BTI is
already considered incompatible with GCC since commit c0a454b9044f
("arm64/bti: Disable in kernel BTI when cross section thunks are
broken").

When missing landing pads are detected, allocate a page close to the
target which can be used to hold BTI veneers which receive PLT veneer
indirect branches and direct branch to the final target:

	bti	c
	b	<target>

Fixes: fd1e0fd71f65 ("arm64: Implement HAVE_LIVEPATCH")
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/arm64/include/asm/module.h |   5 +
 arch/arm64/kernel/module-plts.c | 186 ++++++++++++++++++++++++++++++++
 2 files changed, 191 insertions(+)

diff --git a/arch/arm64/include/asm/module.h b/arch/arm64/include/asm/module.h
index fb9b88eebeb15..f705cbec4463f 100644
--- a/arch/arm64/include/asm/module.h
+++ b/arch/arm64/include/asm/module.h
@@ -13,10 +13,15 @@ struct mod_plt_sec {
 	int			plt_max_entries;
 };
 
+struct bti_veneer_page;
+
 struct mod_arch_specific {
 	struct mod_plt_sec	core;
 	struct mod_plt_sec	init;
 
+	/* for CONFIG_ARM64_BTI_KERNEL */
+	struct bti_veneer_page	*bti_veneers;
+
 	/* for CONFIG_DYNAMIC_FTRACE */
 	struct plt_entry	*ftrace_trampolines;
 	struct plt_entry	*init_ftrace_trampolines;
diff --git a/arch/arm64/kernel/module-plts.c b/arch/arm64/kernel/module-plts.c
index 7afd370da9f48..4ba31e336deb6 100644
--- a/arch/arm64/kernel/module-plts.c
+++ b/arch/arm64/kernel/module-plts.c
@@ -3,12 +3,18 @@
  * Copyright (C) 2014-2017 Linaro Ltd. <ard.biesheuvel@linaro.org>
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/elf.h>
 #include <linux/ftrace.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/moduleloader.h>
+#include <linux/slab.h>
 #include <linux/sort.h>
+#include <linux/vmalloc.h>
+#include <asm/cpufeature.h>
+#include <asm/text-patching.h>
 
 static struct plt_entry __get_adrp_add_pair(u64 dst, u64 pc,
 					    enum aarch64_insn_register reg)
@@ -66,6 +72,180 @@ static bool plt_entries_equal(const struct plt_entry *a,
 	       (q + aarch64_insn_adrp_get_offset(le32_to_cpu(b->adrp)));
 }
 
+/*
+ * The compiler may omit a function's BTI landing pad if it's a static function
+ * with no pointers referencing it.  That breaks two cases where a PLT might be
+ * needed to call such a function:
+ *
+ *   1) module cross-section call (e.g., .init to .text)
+ *
+ *   2) livepatch module using a klp relocation
+ *
+ * Fix up such cases with a second veneer which lives close to the target.
+ */
+struct bti_veneer {
+	__le32	bti_c;
+	__le32	b;
+};
+
+struct bti_veneer_page {
+	struct bti_veneer_page	*next;
+	struct bti_veneer	*veneers;
+	unsigned int		used;
+};
+
+#define BTI_VENEERS_PER_PAGE	(PAGE_SIZE / sizeof(struct bti_veneer))
+
+static bool plt_target_has_landing_pad(u64 target)
+{
+	u32 insn;
+
+	if (!system_supports_bti_kernel())
+		return true;
+
+	if (aarch64_insn_read((void *)target, &insn))
+		return true;
+
+	if (!aarch64_insn_is_hint(insn))
+		return false;
+
+	switch (insn & 0xFE0) {
+	case AARCH64_INSN_HINT_BTIC:
+	case AARCH64_INSN_HINT_BTIJ:
+	case AARCH64_INSN_HINT_BTIJC:
+	case AARCH64_INSN_HINT_PACIASP:
+	case AARCH64_INSN_HINT_PACIBSP:
+		return true;
+	}
+
+	return false;
+}
+
+static void *bti_veneer_vmalloc(u64 start, u64 end, gfp_t gfp)
+{
+	pgprot_t prot = __pgprot(pgprot_val(PAGE_KERNEL_ROX) | PTE_MAYBE_GP);
+
+	return __vmalloc_node_range(PAGE_SIZE, PAGE_SIZE, PAGE_ALIGN(start),
+				    ALIGN_DOWN(end, PAGE_SIZE), gfp, prot,
+				    VM_FLUSH_RESET_PERMS, NUMA_NO_NODE,
+				    __builtin_return_address(0));
+}
+
+static bool bti_veneer_in_range(const struct bti_veneer *veneer, u64 target)
+{
+	s64 offset = (s64)target - (s64)&veneer->b;
+
+	return offset >= -SZ_128M && offset < SZ_128M;
+}
+
+static struct bti_veneer_page *bti_veneer_page_alloc(struct module *mod,
+						     u64 target)
+{
+	struct bti_veneer_page *page;
+	void *p;
+
+	/*
+	 * vmalloc allocates at the lowest free address in the given range, so
+	 * try the range above the target first so it will be as close as
+	 * possible, making it more likely to be reusable for other targets in
+	 * the same object.
+	 */
+	p = bti_veneer_vmalloc(target, target + SZ_128M,
+			       GFP_KERNEL | __GFP_NOWARN);
+	if (!p)
+		p = bti_veneer_vmalloc(target - SZ_128M, target,
+				       GFP_KERNEL | __GFP_NOWARN);
+	if (!p) {
+		pr_err("%s: no address space within branch range of %pS for a BTI veneer\n",
+		       mod->name, (void *)target);
+		return NULL;
+	}
+
+	/* Don't leave unused slots executable */
+	aarch64_insn_set(p, AARCH64_BREAK_FAULT, PAGE_SIZE);
+
+	page = kzalloc_obj(*page, GFP_KERNEL);
+	if (!page) {
+		vfree(p);
+		return NULL;
+	}
+
+	page->veneers = p;
+	page->next = mod->arch.bti_veneers;
+	mod->arch.bti_veneers = page;
+
+	return page;
+}
+
+static u64 module_emit_bti_veneer(struct module *mod, u64 target)
+{
+	struct bti_veneer_page *page;
+	struct bti_veneer *veneer, insns;
+	u32 insn;
+
+	/* Look for an existing veneer for the target */
+	for (page = mod->arch.bti_veneers; page; page = page->next) {
+		for (unsigned int i = 0; i < page->used; i++) {
+			s32 offset;
+
+			veneer = &page->veneers[i];
+			insn = le32_to_cpu(veneer->b);
+			offset = aarch64_get_branch_offset(insn);
+
+			if ((u64)&veneer->b + offset == target)
+				return (u64)veneer;
+		}
+	}
+
+	/* Look for a free slot in range of the target */
+	for (page = mod->arch.bti_veneers; page; page = page->next) {
+		if (page->used == BTI_VENEERS_PER_PAGE)
+			continue;
+
+		veneer = &page->veneers[page->used];
+		if (bti_veneer_in_range(veneer, target))
+			goto emit;
+	}
+
+	page = bti_veneer_page_alloc(mod, target);
+	if (!page)
+		return 0;
+
+	veneer = &page->veneers[0];
+
+emit:
+	insn = aarch64_insn_gen_branch_imm((u64)&veneer->b, target,
+					   AARCH64_INSN_BRANCH_NOLINK);
+	if (WARN_ON(insn == AARCH64_BREAK_FAULT))
+		return 0;
+
+	insns.bti_c = cpu_to_le32(aarch64_insn_gen_hint(AARCH64_INSN_HINT_BTIC));
+	insns.b	    = cpu_to_le32(insn);
+
+	if (!aarch64_insn_copy(veneer, &insns, sizeof(insns))) {
+		pr_err("%s: failed to write BTI veneer for %pS\n",
+		       mod->name, (void *)target);
+		return 0;
+	}
+
+	page->used++;
+
+	return (u64)veneer;
+}
+
+void module_arch_cleanup(struct module *mod)
+{
+	struct bti_veneer_page *page, *next;
+
+	for (page = mod->arch.bti_veneers; page; page = next) {
+		next = page->next;
+		vfree(page->veneers);
+		kfree(page);
+	}
+
+	mod->arch.bti_veneers = NULL;
+}
+
 u64 module_emit_plt_entry(struct module *mod, Elf64_Shdr *sechdrs,
 			  void *loc, const Elf64_Rela *rela,
 			  Elf64_Sym *sym)
@@ -77,6 +257,12 @@ u64 module_emit_plt_entry(struct module *mod, Elf64_Shdr *sechdrs,
 	int j = i - 1;
 	u64 val = sym->st_value + rela->r_addend;
 
+	if (!plt_target_has_landing_pad(val)) {
+		val = module_emit_bti_veneer(mod, val);
+		if (!val)
+			return 0;
+	}
+
 	if (is_forbidden_offset_for_adrp(&plt[i].adrp))
 		i++;
 
-- 
2.55.0

