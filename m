Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B590D31283E;
	Fri,  1 May 2026 04:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777608547; cv=none; b=MFcD0Lc45miTKylysw/FTF9Fj0/0fqFjDsYLApjQDt4NSxd6RbHErXn90W5TE8jlGNCTWH1nDeqdIa8KUmVPrmjVe5gdIhuJshY9l7M8oAABCEUlLKPznLsGgOuaF4saAhdm4mPcvyVkGSpxsIVLwJc/ml2Hos+o42k6mwv92oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777608547; c=relaxed/simple;
	bh=U1/zXTGHmGDeZk5zmEiLTowFn8oD8+hWbudhQLdzfVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oOQQT3MCqyWXPFV3IUkb4Qyre1KltTAi/r8gR0vGS6U2XbhXAg5gHehhPA0Ku4FVJY90cFaP+VsiJpJpHSoj3J5bh7yav6Jtp9aJdUuJ97uKW5z55zGM7V/QtWdPYFUFXz886j/BC/yeW6Douem+nIwry6wbMUGTilrOmiNo98o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mPGiSoAV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mPGiSoAV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5526EC2BCB9;
	Fri,  1 May 2026 04:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777608547;
	bh=U1/zXTGHmGDeZk5zmEiLTowFn8oD8+hWbudhQLdzfVA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mPGiSoAVujosCaTs7qHYIAu7SdocyUdJIJp0ZbHB52+AinDT8Gknd14LlPrsoZoa7
	 hKq5Ffeync370AxGSPmVbC3As+T/96vu68N69edcCrA6u3DzDHKDGfgL/RfgKBWaK7
	 rvD3XXXh0nvIARIGTX2SPrwRH71yD6YlW1Iu09AdQFXM+Yw3joqI/z4yVOtRQIzfeP
	 55lp9OE8r6Oedzsm1rzWRXEsmfi4gTcnRoDRfTMBPIcZxTZ68SIBOxjGeId+ug8v2k
	 3TX6jmmJJ09ilmMx5IC2IxChGuF5Bm5Ba6wFHvdxCMm7FmsbGbngX4yVO++23p77Of
	 XgMEpDggOpd/A==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Song Liu <song@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH v2 37/53] objtool: Add is_alias_sym() helper
Date: Thu, 30 Apr 2026 21:08:25 -0700
Message-ID: <87cfee570bfffb35961d9b6e5abfbfeae6d903dc.1777575752.git.jpoimboe@kernel.org>
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

Improve readability with a new is_alias_sym() helper.

No functional changes intended.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Song Liu <song@kernel.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/check.c               | 6 +++---
 tools/objtool/include/objtool/elf.h | 5 +++++
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index f020f21f94a7..6c94eb32c090 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -491,7 +491,7 @@ static int decode_instructions(struct objtool_file *file)
 				return -1;
 			}
 
-			if (func->embedded_insn || func->alias != func)
+			if (func->embedded_insn || is_alias_sym(func))
 				continue;
 
 			if (!find_insn(file, sec, func->offset)) {
@@ -2229,7 +2229,7 @@ static int add_jump_table_alts(struct objtool_file *file)
 		return 0;
 
 	for_each_sym(file->elf, func) {
-		if (!is_func_sym(func) || func->alias != func)
+		if (!is_func_sym(func) || is_alias_sym(func))
 			continue;
 
 		mark_func_jump_tables(file, func);
@@ -4523,7 +4523,7 @@ static int validate_symbol(struct objtool_file *file, struct section *sec,
 		return 1;
 	}
 
-	if (sym->pfunc != sym || sym->alias != sym)
+	if (sym->pfunc != sym || is_alias_sym(sym))
 		return 0;
 
 	insn = find_insn(file, sec, sym->offset);
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index 8a543cea43b9..ccc72a692d9a 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -298,6 +298,11 @@ static inline bool is_local_sym(struct symbol *sym)
 	return sym->bind == STB_LOCAL;
 }
 
+static inline bool is_alias_sym(struct symbol *sym)
+{
+	return sym->alias != sym;
+}
+
 static inline bool is_prefix_func(struct symbol *sym)
 {
 	return sym->prefix;
-- 
2.53.0

