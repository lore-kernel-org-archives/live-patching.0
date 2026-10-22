Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792689409;
	b=iHVlZSvvOvn1JA62+UfhizRtP/q/ICbsk7eZCSJwmQp9nKVsfxfJSUa13r2QARa6RLDt
	 DYw3wN0+jOotXEqEGVeh+N9ES/NMAVGzi7V5Vx0xsFXKS/pERKIvv+KClYpcpw0LhQfcO
	 sZKZ/qMQWLtqM5RTOoJoEu62GKHF/QjXfa6GNWhex4awXtsGm9Lz1KD+/6vumO30d0Z2E
	 4Tmuq3Sb41iwRnQAa9DEurrbLySTLtDaItiwW2ge57fjeC+MRocul5uwVhB2Y/f4cug1T
	 qqR+Llhplk2E3UgRd25VgEyL8q9B/EcmggWskRCX8soE/MY3ormcQHRkGYhoZwW3icg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792689409;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=fBR9+hGPssfkKjtK54f65uyHgrCL12nO0UksYWugPtY=;
	b=fKVU4CJ7ewJtaEZc3snMyqF+Cl0FQE3ZKrCYRD1Onw4lg54XtikMB9xpcaC+bxf9CL0c
	 KkF+QRGon2AtEe9BrW2RtLXRHCJsGLDVEeMy2t51w8sPJrv7SCWbxsEUFDKY/YW/MsRro
	 OI3SEO1S6jidggf1eIKSj6B/AzJC7U6d+aQKTTyDrKjk8eQ32VL1i0W5y1sy2RJz/EUEj
	 9nf/F9u4dUPDX81Wk2LO2zuj/oTtVXtsYwYaeJiKCCHQZIDsOSX9jBbMLXBoIn+kCUAkY
	 xggWFqS+SbhM0Argc0KrTgFFsZyiPRCgQt795ctSt9ZF7DgcjT8z6Y76stMdAVN+JoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f4uvV1IU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853BC606A319
	for <live-patching@vger.kernel.org>; Thu, 22 Oct 2026 17:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f4uvV1IU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA06D1F01825;
	Thu, 22 Oct 2026 17:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792689409;
	bh=fBR9+hGPssfkKjtK54f65uyHgrCL12nO0UksYWugPtY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=f4uvV1IUt15mFX4wndyfyxDfNYmGIMiGlmij2FOZx9b2Z8KztVnL4pbun6wwpq7VL
	 le2NpZNf4qmm/UOEIvtYQ9ufcJYzYfav5Wb3r2PuVKE12ms6ceYBQidQ1MUE88LGLD
	 HthcW53wYS/SiBd+80AbpMkG8Dze1DlBavBYnZnM6OofXYWBvIyvIi9pY++XCF0R0n
	 zAjbjDbdoZ6tBEHaXuzHa8Sq6h6i6nx1IDr5Z5ttyy2TiIT0TDI16zxEjpU8pElCNL
	 SEK9Csm+3XIzxgglm/CBmmDS44H4amZHd1XkcXzvcb7TTp8hZ7znSPgL29xKf1kYLm
	 sQztoEo6b8qfQ==
From: Puranjay Mohan <puranjay@kernel.org>
To: live-patching@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Song Liu <song@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Joe Lawrence <joe.lawrence@redhat.com>
Subject: [PATCH v2 2/3] objtool/klp: Reject changed functions without an ftrace call site
Date: Thu, 22 Oct 2026 10:16:35 -0700
Message-ID: <20261022171637.3298443-3-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261022171637.3298443-1-puranjay@kernel.org>
References: <20261022171637.3298443-1-puranjay@kernel.org>
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Livepatch redirects a function through its ftrace call site.  If a
changed function doesn't have one, klp-build succeeds but the patch
module fails to load:

  livepatch: failed to find location for function 'nsproxy_free'
  livepatch: failed to patch object 'vmlinux'
  livepatch: failed to enable patch 'livepatch_nsproxy'

This is easy to hit because the kernel's 'inline' implies notrace, so
any inline function which the compiler emits out of line can't be
patched.

Make klp diff fail for any changed function which has no __mcount_loc
entry in the original object.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
Acked-by: Joe Lawrence <joe.lawrence@redhat.com>
---
 tools/objtool/include/objtool/elf.h |  1 +
 tools/objtool/klp-diff.c            | 47 +++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index a82517a76a0f6..f7e6a652ee788 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -98,6 +98,7 @@ struct symbol {
 	u8 klp		     : 1;
 	u8 dont_correlate    : 1;
 	u8 fake		     : 1;
+	u8 traceable	     : 1;
 	struct list_head pv_target;
 	struct reloc *relocs;
 	struct section *group_sec;
diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
index 34da55e456097..f8659950ec9a9 100644
--- a/tools/objtool/klp-diff.c
+++ b/tools/objtool/klp-diff.c
@@ -1098,6 +1098,50 @@ static int mark_changed_functions(struct elfs *e)
 	return !changed ? 1 : 0;
 }
 
+/*
+ * Like ftrace_location(), accept an ftrace call site anywhere in the function.
+ */
+static void mark_traceable_functions(struct elf *elf)
+{
+	struct section *sec;
+	struct reloc *reloc;
+
+	sec = find_section_by_name(elf, "__mcount_loc");
+	if (!sec || !sec->rsec)
+		return;
+
+	for_each_reloc(sec->rsec, reloc) {
+		struct symbol *func;
+
+		func = find_func_containing(reloc->sym->sec,
+					    reloc->sym->offset + reloc_addend(reloc));
+		if (func)
+			func->traceable = 1;
+	}
+}
+
+/*
+ * Livepatch redirects functions through their ftrace call sites, so a function
+ * without one can't be patched.
+ */
+static int validate_traceable_functions(struct elfs *e)
+{
+	struct symbol *patched_sym;
+	bool error = false;
+
+	mark_traceable_functions(e->orig);
+
+	for_each_sym(e->patched, patched_sym) {
+		if (!patched_sym->changed || patched_sym->twin->traceable)
+			continue;
+
+		ERROR("%s: no ftrace call site, can't patch", patched_sym->twin->name);
+		error = true;
+	}
+
+	return error ? -1 : 0;
+}
+
 static int clone_included_functions(struct elfs *e)
 {
 	struct symbol *patched_sym;
@@ -2260,6 +2304,9 @@ int cmd_klp_diff(int argc, const char **argv)
 	if (ret > 0)
 		return 0;
 
+	if (validate_traceable_functions(&e))
+		return -1;
+
 	e.out = elf_create_file(&e.orig->ehdr, argv[2]);
 	if (!e.out)
 		return -1;
-- 
2.53.0-Meta

