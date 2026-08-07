Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4315C344D8C;
	Fri,  7 Aug 2026 21:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786139188; cv=none; b=C/Kk3bChbYK1pAtx0fsaZlreUIFx3MDZllqxkHnzYxGM8Z+ClmkBPTAeXpjqZxjb7aW7+nO/Ys025iNCH9EHf6vZiyozoJjjo75C0rKtYAClzCQwf5FrI3FruDky8e6q4BE41T18Zn0SpVw7QdAiMAl1XfcLERjhUu49uUCNzaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786139188; c=relaxed/simple;
	bh=NAuVlVMg/3BKHIfxekYdbzCnV0awbMbkKff4RSjbxk0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f64QTnhGbf/BDZFbsZVDvyPiPhLiEfZAMYQlDdLPbmrlkdwNgKR8pJCK+7SJLbvtIv5Qc7609UDCQzuALYvvbJlGZgqLOtV5dVCWrly52EpfIO7+j56ri/EYtfeozz++IXh8qoDESHEW4zaaDaTL1jzBSWOpUbJrs29b8uIkXyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJ4htbuN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJ4htbuN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9351F1F000E9;
	Fri,  7 Aug 2026 21:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786139187;
	bh=HCF3AJAFvd9TbF92Uz5JD/tHMuVssxRfNJR6KDeyZNI=;
	h=From:To:Cc:Subject:Date;
	b=UJ4htbuNksS2v3U0v/ahPS8ggF6uU+BYl9maNVaXsw8V3Py229dD49ro+Ui/fF7GG
	 U62xpzHN8bawYyofTHTsLhADJM/wCvRAjGEuPGGHA4OISjZvW4apvRhecChjinxUan
	 ZW0u7ytVm+JgbCZtlcoaTl5r/FsF2wm25nslQBh8ByNpuAgXO7uePEzFKeABNselZL
	 i2G/P+iceEDKpoGvIIr5NAmEChvPYNo4/U4gCjvLPn3QhyqtbJi2F8RN9neul8XPwl
	 d7ygGTk3UuFzcVzgpenablS+9HzU59tKZa1N0o5GYZaR9PTYJYvBklYzZZAA22I/I8
	 7hR9MakkKa33A==
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
	Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH] arm64/module: Fix livepatch BTI exceptions with Clang 21+
Date: Fri,  7 Aug 2026 14:46:11 -0700
Message-ID: <ed4fe1f95071897859ec7fbe9176246cbd4962bf.1786138806.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.54.0
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
reached by a direct branch.  That's fine for ordinary modules which only
branch to global exported functions.  But livepatch modules use klp
relocations to reference arbitrary kernel symbols, and with
CONFIG_RANDOMIZE_MODULE_REGION_FULL the module is far enough from the
kernel that every R_AARCH64_CALL26 needs a PLT.

RET is exempt from BTI checking, so use it instead of BR when the target
has no landing pad, similar to what ftrace and BPF do.

This was found by testing with klp-build and Clang 21, but the issue is
not specific to klp-build.  It's inherent to any livepatch module use of
klp relocations.

Previous tests with Clang 20 did not show this problem, as older Clang
unconditionally emits "bti c" for every C function.

Fixes: fd1e0fd71f65 ("arm64: Implement HAVE_LIVEPATCH")
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/arm64/kernel/module-plts.c | 42 +++++++++++++++++++++++++++++----
 1 file changed, 38 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/module-plts.c b/arch/arm64/kernel/module-plts.c
index 7afd370da9f48..4249b477daa8b 100644
--- a/arch/arm64/kernel/module-plts.c
+++ b/arch/arm64/kernel/module-plts.c
@@ -10,6 +10,9 @@
 #include <linux/moduleloader.h>
 #include <linux/sort.h>
 
+#include <asm/cpufeature.h>
+#include <asm/text-patching.h>
+
 static struct plt_entry __get_adrp_add_pair(u64 dst, u64 pc,
 					    enum aarch64_insn_register reg)
 {
@@ -23,14 +26,45 @@ static struct plt_entry __get_adrp_add_pair(u64 dst, u64 pc,
 	return (struct plt_entry){ cpu_to_le32(adrp), cpu_to_le32(add) };
 }
 
+static bool plt_target_has_landing_pad(u64 dst)
+{
+	u32 insn;
+
+	if (!system_supports_bti_kernel())
+		return true;
+
+	if (aarch64_insn_read((void *)dst, &insn))
+		return false;
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
 struct plt_entry get_plt_entry(u64 dst, void *pc)
 {
+	enum aarch64_insn_branch_type type;
 	struct plt_entry plt;
-	static u32 br;
+	u32 br;
 
-	if (!br)
-		br = aarch64_insn_gen_branch_reg(AARCH64_INSN_REG_16,
-						 AARCH64_INSN_BRANCH_NOLINK);
+	/*
+	 * Livepatch modules can branch to static functions without landing
+	 * pads, in which case RET is needed.
+	 */
+	type = plt_target_has_landing_pad(dst) ? AARCH64_INSN_BRANCH_NOLINK
+					       : AARCH64_INSN_BRANCH_RETURN;
+
+	br = aarch64_insn_gen_branch_reg(AARCH64_INSN_REG_16, type);
 
 	plt = __get_adrp_add_pair(dst, (u64)pc, AARCH64_INSN_REG_16);
 	plt.br = cpu_to_le32(br);
-- 
2.54.0

