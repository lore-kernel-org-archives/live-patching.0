Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200DC3D34BD;
	Thu, 23 Apr 2026 04:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776917069; cv=none; b=f7fu5d9i49FzAbPn1seqNPMypOt+SCYIZ5l8gP/Q3HzZHEGGzw+D27F0FbfuejuPsC/LlBRRB0rJ7waNkXFsuUJSGruh6V2DJKa5Z1wXWB/VrUGGsjtrZnpSndRXl6FzLowkFi5G45VxN5tFtoNBOHX/o+HvJpeXbFar7VJ5ayU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776917069; c=relaxed/simple;
	bh=rVqo26BEtqzWbHDo8Y040gyqac0pVZ43mNsABwPmsbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rm69iApn6uEeKmT6ApHpkHZ5Gq1RRzFdDOiKVnUWi6S7sdgn8igNK1av6qT1vV+tegbvHv67WqNOX1mJU+96rUqi6D/L/yf+bvZoXyBNr5FiLdATC+jjP86Eh5KItjXDd91Nq5NM72Sh4wTKt5E2I6LQKtpERU3N2G4LWOv8c70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aH8wP7S9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aH8wP7S9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54727C2BCC4;
	Thu, 23 Apr 2026 04:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776917068;
	bh=rVqo26BEtqzWbHDo8Y040gyqac0pVZ43mNsABwPmsbo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aH8wP7S9CD5PYdEeKRrY6ahQtBMMGjFFTal1JFXBMeH7eteOe08Z26VfR8gcJRU4X
	 kkW2+O2BVuVYGecNMGGlI0wixMeLazkB7nB9XKpjzaw5SqZ8Rwy99SrpmopWhGbshK
	 rZr6M0TvAKQo/yQ9kF3L4TWlFtuupRLxeFwPxPw1+nXRyMmRP+FJRmEyLBtgwvdla7
	 NeIC4V6FexEKNe2W/fzq1ovv2mhdisznZKCxQeCLzGnnBMt/qTGdfDQ2wFLufRAosE
	 fLXUkAeGyBzhsEU1HSjAK+7ayCakJgqDxs6TciwBhQIGISRDCsvhVvmTDYspVrrpoU
	 mIdXNJBslmflg==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Song Liu <song@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH 10/48] objtool/klp: Fix --debug-checksum for duplicate symbol names
Date: Wed, 22 Apr 2026 21:03:38 -0700
Message-ID: <7fd49264db4f5a9c654ad162cca96ce575e77ae4.1776916871.git.jpoimboe@kernel.org>
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

find_symbol_by_name() only returns the first match, so
--debug-checksum=<func> silently ignores any subsequent duplicately
named functions after the first.

Add a new iterate_sym_by_name() to fix that.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/check.c               | 19 ++++++++++++++-----
 tools/objtool/elf.c                 | 12 ++++++++++++
 tools/objtool/include/objtool/elf.h |  3 +++
 3 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 5722d4568401..f14212a8c179 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3657,6 +3657,17 @@ static bool skip_alt_group(struct instruction *insn)
 	return alt_insn->type == INSN_CLAC || alt_insn->type == INSN_STAC;
 }
 
+static void enable_debug_checksum_cb(struct symbol *sym, void *d)
+{
+	bool *found = d;
+
+	if (!is_func_sym(sym))
+		return;
+
+	sym->debug_checksum = 1;
+	*found = true;
+}
+
 static int checksum_debug_init(struct objtool_file *file)
 {
 	char *dup, *s;
@@ -3672,18 +3683,16 @@ static int checksum_debug_init(struct objtool_file *file)
 
 	s = dup;
 	while (*s) {
-		struct symbol *func;
+		bool found = false;
 		char *comma;
 
 		comma = strchr(s, ',');
 		if (comma)
 			*comma = '\0';
 
-		func = find_symbol_by_name(file->elf, s);
-		if (!func || !is_func_sym(func))
+		iterate_sym_by_name(file->elf, s, enable_debug_checksum_cb, &found);
+		if (!found)
 			WARN("--debug-checksum: can't find '%s'", s);
-		else
-			func->debug_checksum = 1;
 
 		if (!comma)
 			break;
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index ac9da81a7a2f..a5486e172e5c 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -335,6 +335,18 @@ void iterate_global_symbol_by_demangled_name(const struct elf *elf,
 	}
 }
 
+void iterate_sym_by_name(const struct elf *elf, const char *name,
+			 void (*process)(struct symbol *sym, void *data),
+			 void *data)
+{
+	struct symbol *sym;
+
+	elf_hash_for_each_possible(symbol_name, sym, name_hash, str_hash_demangled(name)) {
+		if (!strcmp(sym->name, name))
+			process(sym, data);
+	}
+}
+
 struct reloc *find_reloc_by_dest_range(const struct elf *elf, struct section *sec,
 				     unsigned long offset, unsigned int len)
 {
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index c61bd57767f9..cd5844c7b4e2 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -189,6 +189,9 @@ struct symbol *find_global_symbol_by_name(const struct elf *elf, const char *nam
 void iterate_global_symbol_by_demangled_name(const struct elf *elf, const char *demangled_name,
 					     void (*process)(struct symbol *sym, void *data),
 					     void *data);
+void iterate_sym_by_name(const struct elf *elf, const char *name,
+			 void (*process)(struct symbol *sym, void *data),
+			 void *data);
 struct symbol *find_symbol_containing(const struct section *sec, unsigned long offset);
 int find_symbol_hole_containing(const struct section *sec, unsigned long offset);
 struct reloc *find_reloc_by_dest(const struct elf *elf, struct section *sec, unsigned long offset);
-- 
2.53.0

