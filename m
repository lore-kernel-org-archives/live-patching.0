Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEA336B046;
	Fri,  1 May 2026 04:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777608549; cv=none; b=usCqQT/ZPKUwnYDANBvP4JTVKDiwNEyL/L67pB7coif2eFbR8GIby3ihDH/57mRa0ZfX1fAtwgZUCnd6ggyjvnQ5g0Ol3ZI7wT0Bxd5fVosnDrxMNeF/X4tDCRBDPjuQqis90wL59Fju5tfOibAsn0/0kR79L8esIZO/QWjmGUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777608549; c=relaxed/simple;
	bh=m/ozg1EAde/Oq0i+pAtSNUYhLnhNOg5iFqi9kLnbM7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FDIjEpqCEDDXzv1ZxVOBDdkyQ0UFgLNTcAupmQXBMv1x2gCgVTSIFOnegnh0/3bPiLt70YVX7X6IqnRW3uzZOtUrqgqM2mH6i921Kz2lfwsMm27NLr8j3NxL23U+EExCsAYvgOXkwvaQqp9VfBqTwzWM/uxB+RKSJsChsWhCv4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S2MoqPvL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S2MoqPvL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEC68C2BCB7;
	Fri,  1 May 2026 04:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777608549;
	bh=m/ozg1EAde/Oq0i+pAtSNUYhLnhNOg5iFqi9kLnbM7k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S2MoqPvLjobCDFbBephCUsWbaz29eUSsOx653JSjD6cgk1BM7YIJDJQ3kbfp0xnrt
	 hxtBhCVHDiC/f0KUpgze6hG4twAxT8gsLPCh1Xdk+7SNDRJhZMrmlW/SQhvwwblCIv
	 fVDZOOL1fjxVv3DvNQAlLS/f167BoxyZYGV2/XdXJ02N/NU3VVVr98/np/hjhozjEu
	 PBHOx+zpwmeYzlZl2e+5WBE4RchJ0BAtFu7P7qNT4D3XH7EYPggpx2fzHXoKp5fh4U
	 cTuQwWPxomwUPwMT/Ag5XvAm9I64O37O83g1YdTX3Y6UkclCoIfzZCnFNpwNov4Thd
	 UVBe4iSwQ5jjg==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Song Liu <song@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH v2 40/53] objtool: Consolidate file decoding into decode_file()
Date: Thu, 30 Apr 2026 21:08:28 -0700
Message-ID: <36478f25bee19c8acbff3992e27436b544c4e26b.1777575752.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1777575752.git.jpoimboe@kernel.org>
References: <cover.1777575752.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

decode_sections() relies on CFI and cfi_hash initialization done
separately in check(), making it unusable outside of check().

Consolidate the initialization into decode_sections() and rename it to
decode_file(), and make it global along with free_insns() and
insn_reloc() for use by other objtool components -- namely, the checksum
code which will be moving to another file.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Song Liu <song@kernel.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/check.c                 | 36 +++++++++++++--------------
 tools/objtool/include/objtool/check.h |  5 ++++
 2 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index f019e1f06780..49171ddc6f54 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1346,7 +1346,7 @@ __weak bool arch_is_embedded_insn(struct symbol *sym)
 	return false;
 }
 
-static struct reloc *insn_reloc(struct objtool_file *file, struct instruction *insn)
+struct reloc *insn_reloc(struct objtool_file *file, struct instruction *insn)
 {
 	struct reloc *reloc;
 
@@ -2633,8 +2633,21 @@ static bool alts_needed(void)
 	       opts.checksum;
 }
 
-static int decode_sections(struct objtool_file *file)
+int decode_file(struct objtool_file *file)
 {
+	arch_initial_func_cfi_state(&initial_func_cfi);
+	init_cfi_state(&init_cfi);
+	init_cfi_state(&func_cfi);
+	set_func_state(&func_cfi);
+	init_cfi_state(&force_undefined_cfi);
+	force_undefined_cfi.force_undefined = true;
+
+	if (!cfi_hash_alloc(1UL << (file->elf->symbol_bits - 3)))
+		return -1;
+
+	cfi_hash_add(&init_cfi);
+	cfi_hash_add(&func_cfi);
+
 	file->klp = is_livepatch_module(file);
 
 	mark_rodata(file);
@@ -4998,7 +5011,7 @@ struct insn_chunk {
  * which can trigger more allocations for .debug_* sections whose data hasn't
  * been read yet.
  */
-static void free_insns(struct objtool_file *file)
+void free_insns(struct objtool_file *file)
 {
 	struct instruction *insn;
 	struct insn_chunk *chunks = NULL, *chunk;
@@ -5045,22 +5058,7 @@ int check(struct objtool_file *file)
 		objtool_disas_ctx = disas_ctx;
 	}
 
-	arch_initial_func_cfi_state(&initial_func_cfi);
-	init_cfi_state(&init_cfi);
-	init_cfi_state(&func_cfi);
-	set_func_state(&func_cfi);
-	init_cfi_state(&force_undefined_cfi);
-	force_undefined_cfi.force_undefined = true;
-
-	if (!cfi_hash_alloc(1UL << (file->elf->symbol_bits - 3))) {
-		ret = -1;
-		goto out;
-	}
-
-	cfi_hash_add(&init_cfi);
-	cfi_hash_add(&func_cfi);
-
-	ret = decode_sections(file);
+	ret = decode_file(file);
 	if (ret)
 		goto out;
 
diff --git a/tools/objtool/include/objtool/check.h b/tools/objtool/include/objtool/check.h
index 5f2f77bd9b41..6489e52ea2f2 100644
--- a/tools/objtool/include/objtool/check.h
+++ b/tools/objtool/include/objtool/check.h
@@ -155,6 +155,11 @@ struct instruction *next_insn_same_sec(struct objtool_file *file, struct instruc
 	     insn && insn->offset < sym->offset + sym->len;		\
 	     insn = next_insn_same_sec(file, insn))
 
+struct reloc *insn_reloc(struct objtool_file *file, struct instruction *insn);
+
+int decode_file(struct objtool_file *file);
+void free_insns(struct objtool_file *file);
+
 const char *objtool_disas_insn(struct instruction *insn);
 
 extern size_t sym_name_max_len;
-- 
2.53.0

