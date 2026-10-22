Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792671969;
	b=U2iK3uf6c0qZnmRoXJMBF8wGb7zgW6Zjx2DXv4pxuzzmrVKCQ2073/yJw5xY0jX7RYNs
	 MaKPhHRfmcmzLxChbsdKzH5OjyusOShCHAhEMeY2a+sOY01EhmbqnuAo0brW4UiDA1oZ2
	 p4AZydebmK+ogN+ypvSw8SzDEJLgKQfL5U6sGNkiXPKS84/+eniF7eoA/z50vQm2tGSs8
	 7A0Esc43xRaMaepIMA7eK0FDCUhdEH/Iv4gvMGUembUh9ZunkAxaJuy3Q064hVblew2hE
	 vdxxXD+7cGFQFYWTqofUHNHW9oQCTrG4DqPM7PC8s9gzBGwtBsyCAghOXQ/KM+F/Hww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792671969;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=FJ3iljMkCkcUr6G7DlUi0VEVk8Cw4mQkULvl1SvpDms=;
	b=mXaiZlE+QbjUe4ggTs7/+yIWmF4iU6/twN3iUrcV7dkJeJxmcyXdtgDndaGtCOySyfnt
	 FVCElPYICoOwaSWyZ8xgn2u5Blk7883IcxXxkpQVIC2oiYODLMidVXFN91pU7gJe37nMb
	 9utKUKEGb6pblAvbppX5C6aaFTNxTYwviSu2D8G5XgmrhBdvEg32a+/zfSsBwI2HjLWj/
	 Ckp2xmxOPmPQdf+h5w1S8uM2BXZAx9mzp1AI8dMN2yPgR+pLTr6TkZTIDLy7GO8pGJsxr
	 k/i3qguT6puTJWWC3BvTTARC4QQ6QZ5OWg3C0j763E4Z9FHmcVcs48ASvEkABBpSYjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="RO/bLDyy";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2BE606A31B
	for <live-patching@vger.kernel.org>; Thu, 22 Oct 2026 12:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RO/bLDyy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E39A01F000C1;
	Thu, 22 Oct 2026 12:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792671969;
	bh=FJ3iljMkCkcUr6G7DlUi0VEVk8Cw4mQkULvl1SvpDms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RO/bLDyygOtIaLZTQpDrmW8j2oyw0oblIoTkomoIZaRkXAMYjg1vgcrmfv/10mVFe
	 n6JlFyrs0/b6mOVIf1W3Hf6CqhLXjFKCZ3KyGQdbupMJG/2tCh+efcBkiRw88oddPH
	 oNro2L6R/RxUz8ZSVgqqGlriqO9cR+ZjrfLDRyG4gou/d5wbbEPITyERXwOWZTW7Gb
	 dg1ot1FBAwj8wdzBkZ6tJ3L7cjC9Uj0H4YH0SATFuHe3B+o6hSZu25EgYd7SmqNYxI
	 3l2VdSB6W6/k2+E7DESLZS4h391NEnEnGdIyPpB79Jb1/vUp5R4lwgw+MnyxS84l9g
	 d4XBouyiIC26w==
From: Puranjay Mohan <puranjay@kernel.org>
To: live-patching@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Song Liu <song@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Joe Lawrence <joe.lawrence@redhat.com>
Subject: [PATCH 2/3] objtool/klp: Reject changed functions without an ftrace call site
Date: Thu, 22 Oct 2026 05:25:37 -0700
Message-ID: <20261022122544.125305-3-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261022122544.125305-1-puranjay@kernel.org>
References: <20261022122544.125305-1-puranjay@kernel.org>
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

