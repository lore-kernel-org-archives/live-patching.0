Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1B33128D4;
	Fri,  1 May 2026 04:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777608535; cv=none; b=oR88yAKTDKVpqY3sTZuhpapDgg/cvHT/V8RZKCQLI/8h83n+WuvF3CtxNUnbys8Hz8ymstJQCRb1RAY3G7hgm0o+DdAnCOZmbJES5dCcu4/szxZM86T9ermxsrPna/5YrYZWNePQNHp8UyFErfpq9LxernWv+t0G1htYTSk3O78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777608535; c=relaxed/simple;
	bh=xrqI9AmsCre03ULrPQ3iszwiwGHge+FkRf5Hhx9yY8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u1pFYYxMIcwONk+ec0bQcRM4KU8rJrsYwz6UNdq6tgWI1Iel/Yp4vNl+UMMT1EQgMG4EncDk0sFWcEj52lnc+NdaV+39R2R3XXMNjZ/Mca0tTAYpovvFKjqPzN4QNDIMYW1IoB/crHKaeb3ZKaNVmGFRokdbcU2bdorHv2ym8Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IHPZRN32; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IHPZRN32"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97DD2C2BCB8;
	Fri,  1 May 2026 04:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777608535;
	bh=xrqI9AmsCre03ULrPQ3iszwiwGHge+FkRf5Hhx9yY8M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IHPZRN32rmVKqO0yMgLbFKDLzwlyIlVyOAm9BFNP77ga0JarFi2mlnp5+Rmk8S1qV
	 QnEAYhyMlpF5TJT7WXvMiM2lwXt26fyu2lK+Kj6sM5J6oXHOM4sTaQSVJVtMU2/TOF
	 SiBar8ugMyx6HPfpyX43Y8sduVGJA8KyCbbDbHYhyM0ED/RW0ZW+yNTNX7WLLc+B0m
	 iJdY3lhY5EXx2KJTEhNmIbD0SL5hXvNo4oK/KtX46GGK3S6WfxH+AyDO0fkJqD/E7s
	 sEvc4BhKk9NpZgg1ZH6/t0IfJiJPBeKP0oVBeefu6tB/DO2q2bm9GTvGKlORw5VMSX
	 +IsrnseMep+Ow==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Song Liu <song@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH v2 10/53] objtool/klp: Fix --debug-checksum for duplicate symbol names
Date: Thu, 30 Apr 2026 21:07:58 -0700
Message-ID: <83781c62e85a35d641b7d793b133195e3a4abba7.1777575752.git.jpoimboe@kernel.org>
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

find_symbol_by_name() only returns the first match, so
--debug-checksum=<func> silently ignores any subsequent duplicately
named functions after the first.

Fix that, along with a new for_each_sym_by_name() helper.

Acked-by: Song Liu <song@kernel.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/check.c               | 15 ++++++++++-----
 tools/objtool/include/objtool/elf.h |  5 +++++
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 9b11cf3193b9..e3604b1201f9 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3677,18 +3677,23 @@ static int checksum_debug_init(struct objtool_file *file)
 
 	s = dup;
 	while (*s) {
-		struct symbol *func;
+		bool found = false;
+		struct symbol *sym;
 		char *comma;
 
 		comma = strchr(s, ',');
 		if (comma)
 			*comma = '\0';
 
-		func = find_symbol_by_name(file->elf, s);
-		if (!func || !is_func_sym(func))
+		for_each_sym_by_name(file->elf, s, sym) {
+			if (!is_func_sym(sym))
+				continue;
+			sym->debug_checksum = 1;
+			found = true;
+		}
+
+		if (!found)
 			WARN("--debug-checksum: can't find '%s'", s);
-		else
-			func->debug_checksum = 1;
 
 		if (!comma)
 			break;
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index b142984eb9b5..00b04029023e 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -489,6 +489,11 @@ static inline void set_sym_next_reloc(struct reloc *reloc, struct reloc *next)
 #define for_each_sym_continue(elf, sym)					\
 	list_for_each_entry_continue(sym, &elf->symbols, global_list)
 
+#define for_each_sym_by_name(elf, _name, sym)				\
+	elf_hash_for_each_possible(elf, symbol_name, sym, name_hash,	\
+				   str_hash_demangled(_name))		\
+		if (strcmp(sym->name, _name)) {} else
+
 #define for_each_sym_by_demangled_name(elf, name, sym)			\
 	elf_hash_for_each_possible(elf, symbol_name, sym, name_hash,	\
 				   str_hash(name))			\
-- 
2.53.0

