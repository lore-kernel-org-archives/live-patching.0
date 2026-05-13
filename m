Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B44399359;
	Wed, 13 May 2026 03:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778643282; cv=none; b=CbmstN37w/PdgxP6ZeqxDcK7UA/3A28J9wDRtp00px5Y32ta/wwuZzRZKj+SfgaWuvP0F/3IrcJvDWH3y53IWYxHQ6d2qw/p2o4D1pnRhXLsqdcsPBH0Fg3lCKWbVTon/ZzVRFtrs7YVBHfhERheNYT78koxqlTV9KA+jjaDK9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778643282; c=relaxed/simple;
	bh=OGkHFIyLNKCb25myeDpCNSwUOYdeu6CUYnno4eQa9zw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gz7aev/yQ4J+jqg3SA19I76781KN37XvU/dl6QPebzUEp7JqPdlQKtvt4aheKZYNaT0Z3vS3AeGSYwOEWcT/60ra8GKx8DMGwVkQFpWcKGj3umFKwzX0JVkYPR9ei3lHRRJLQrSOyh8FtV6XwzayFh8qS84ZmLOgjpj+Zj3OPk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ah2axMr4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ah2axMr4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9505C2BCC7;
	Wed, 13 May 2026 03:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778643279;
	bh=OGkHFIyLNKCb25myeDpCNSwUOYdeu6CUYnno4eQa9zw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ah2axMr4EVLERHF+dnOZr5VI9jvDAdtuAyWJTRuQv9RnMa1jfIlqLPyK5QlrfsxyQ
	 KrENRLOm7JudFMwOaZTSb+QyQhCxSIjwtY2Pmy9TXIKyt8dQNjYqH9W7Y/ROuee/Gg
	 uPRGCMrXfqU1NRhss9+jN456TRlkTTglLYF847XUEA5Qp9SgDQNRepqBd2ujY81gs6
	 i0eekvEvXdGD5zpnQoi58wG8WnQU6f41xd0sL+LeVmOEEfrn68ZhC/s7ob4Jdsq+gE
	 y9lCdnw8g+SQeQZ6ULMyoTOOKvUQm8H7eyvtwJtM05au6lJ+DSXNEthqskxsLj0S7P
	 FLFsy4ZGARSWA==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Song Liu <song@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH v3 14/21] objtool: Prevent kCFI hashes from being decoded as instructions
Date: Tue, 12 May 2026 20:33:48 -0700
Message-ID: <b1d50c9fc9e6b9bca43833cc4ccbd88a31fed84b.1778642120.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1778642120.git.jpoimboe@kernel.org>
References: <cover.1778642120.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On arm64 with CONFIG_CFI=y, Clang places a 4-byte kCFI type hash
immediately before each address-taken function entry.  Since these
hashes are in the text section, objtool tries to decode them, leading to
unpredictable results (e.g., "unannotated intra-function call").

arm64 uses mapping symbols to annotate where code ends and data begins
(and vice versa).  Use those to just mark such "instructions" as NOP so
objtool will ignore them.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/check.c               | 15 +++++++++++++++
 tools/objtool/include/objtool/elf.h |  3 +++
 2 files changed, 18 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index e05dc7a93dc1e..2b03a2d6fc952 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -25,6 +25,7 @@
 #include <linux/kernel.h>
 #include <linux/static_call_types.h>
 #include <linux/string.h>
+#include <linux/kconfig.h>
 
 static unsigned long nr_cfi, nr_cfi_reused, nr_cfi_cache;
 
@@ -428,6 +429,8 @@ static int decode_instructions(struct objtool_file *file)
 
 	for_each_sec(file->elf, sec) {
 		struct instruction *insns = NULL;
+		struct symbol *map_sym;
+		bool is_data = false;
 		u8 prev_len = 0;
 		u8 idx = 0;
 
@@ -454,6 +457,8 @@ static int decode_instructions(struct objtool_file *file)
 		if (!strcmp(sec->name, ".init.text") && !opts.module)
 			sec->init = true;
 
+		map_sym = list_first_entry(&sec->symbol_list, struct symbol, list);
+
 		for (offset = 0; offset < sec_size(sec); offset += insn->len) {
 			if (!insns || idx == INSN_CHUNK_MAX) {
 				insns = calloc(INSN_CHUNK_SIZE, sizeof(*insn));
@@ -478,6 +483,16 @@ static int decode_instructions(struct objtool_file *file)
 
 			prev_len = insn->len;
 
+			/* Use mapping symbols to skip data in text sections */
+			sec_for_each_sym_from(sec, map_sym) {
+				if (map_sym->offset > offset)
+					break;
+				if (is_mapping_sym(map_sym))
+					is_data = is_data_mapping_sym(map_sym);
+			}
+			if (is_data)
+				insn->type = INSN_NOP;
+
 			/*
 			 * By default, "ud2" is a dead end unless otherwise
 			 * annotated, because GCC 7 inserts it for certain
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index d895023674673..9d36b14f420e2 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -507,6 +507,9 @@ static inline void set_sym_next_reloc(struct reloc *reloc, struct reloc *next)
 #define sec_for_each_sym(sec, sym)					\
 	list_for_each_entry(sym, &sec->symbol_list, list)
 
+#define sec_for_each_sym_from(sec, sym)					\
+	list_for_each_entry_from(sym, &sec->symbol_list, list)
+
 #define sec_prev_sym(sym)						\
 	sym->sec && sym->list.prev != &sym->sec->symbol_list ?		\
 	list_prev_entry(sym, list) : NULL
-- 
2.53.0

