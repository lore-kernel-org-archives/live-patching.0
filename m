Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF1E3DA7DA;
	Thu, 23 Apr 2026 04:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776917079; cv=none; b=XV1e0UqMpqJX9hOlvbAHdzx5za8gTUNfTS5lRHy7kOUA8yiGSvJl8cAhA7trl2HaDg0ZUAM7n4ug23Nw4ATHTKQphg8552G6BO2uhSHWnash3AwHgzoaLgxxa1rs64EWTlUbfBVy1XaiN05GG9V57DdCaIdJwIXeDN/HmdhvKEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776917079; c=relaxed/simple;
	bh=7tLQh+7OETPl9KIZz6uVG5pJs5EnZZ9Aues+hP46pQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nkOFNjXpIBo3+36knykMKgw2504X+IEleTwsZzppvoMtFq3pEU++9v2bGZMmrg8mtdYjJc6G0Vu/QaT71fjOtxpnWiuGuCc8AnFeiJLuqjdar7CLFlagt7Ng1JHBZ0k1AnJQMFyMHIgNrjdzcJk4MgmntylAFyQZb9GW0AeZaKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=glGmYpJg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="glGmYpJg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4624C2BCB7;
	Thu, 23 Apr 2026 04:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776917079;
	bh=7tLQh+7OETPl9KIZz6uVG5pJs5EnZZ9Aues+hP46pQU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=glGmYpJgfLF9atIcpDOB50iD65TuVCr1JiRY4g9B2dV4kXcR2l272p1gs/g4EzLNH
	 tkcYnfQEkvx1jkNzSKN4EJpF5/ERyQV5jdxdRTrzcZYzuCuyDtof4h/BEHOTdWvlDh
	 uZ4c1ZpGakWKGZnf5Jo2yuSptYvV6M9q3hVoKb2L0v/7xon3fE3VJs0f0b1BKaAR+e
	 qj8Nzft92flHFtH1JEaZSEQ3NcGxXnZTKIsPCexND6ImlYlWrA/qjwM4Rnw+iTm9er
	 c1arNO7QWRbZeaZcAuBhXjTYj2s33MtB30t/dZs4TD2G3Idq08ldteTeB61mmwCxiD
	 X23wnWbz4kc4w==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Song Liu <song@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH 31/48] objtool: Add is_alias_sym() helper
Date: Wed, 22 Apr 2026 21:03:59 -0700
Message-ID: <360097539ed947aea82ce5392548a898a346ffa7.1776916871.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1776916871.git.jpoimboe@kernel.org>
References: <cover.1776916871.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Improve readability with a new is_alias_sym() helper.

No functional changes intended.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/check.c               | 6 +++---
 tools/objtool/include/objtool/elf.h | 5 +++++
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 54ceac857979..4c18d6e7f6c3 100644
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
@@ -4527,7 +4527,7 @@ static int validate_symbol(struct objtool_file *file, struct section *sec,
 		return 1;
 	}
 
-	if (sym->pfunc != sym || sym->alias != sym)
+	if (sym->pfunc != sym || is_alias_sym(sym))
 		return 0;
 
 	insn = find_insn(file, sec, sym->offset);
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index cd5844c7b4e2..3abe4cbc584c 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -279,6 +279,11 @@ static inline bool is_local_sym(struct symbol *sym)
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

