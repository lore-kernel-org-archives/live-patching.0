Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BCE3B9D99
	for <live-patching@vger.kernel.org>; Mon, 20 Jul 2026 14:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784559431; cv=none; b=D4J4D9uAHIweWm0PSZIThoSC2daB/FLpz+oq4LRorL23an2eFDBewxL0rB50LgEpMXObOcSBt9y06oIZC6i2NCsvzdNwVH4n4rP7LB4lVqiFPBohnxP0cAzCjEKJaVkO0vFAEvsY9SjRlD3pWQKFhGAYDXD70q4OnptjoslDm1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784559431; c=relaxed/simple;
	bh=ccOTXCloV3Q8Y9+ZidxjG4P446U0/Oq1O23ST+SPoJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=ggkxtAFX+tw+MmHy/y4LQcsuh0hg/4OuMKetrECDWLoqrwyfEsuc8fr3LyvWCACi+80U0i91hINF0ZZ+7E5m4R5JQyPLqjrF0PXMHUGMRydW8w6dyxEfNBZXrUh43DHQM2Lz/M0fIOesxGpBiRHFJpLoDjFx/CV+zlmvsUr8CRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GYJXB42z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GYJXB42z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784559428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JwDPRVkzqg0QoROJHAR7xhshkzmLC5Chs0EiSVtmE7A=;
	b=GYJXB42znAXXSTt+ZMfT2KR5pt6WO/jI0yjfKy0F49OiF91S/J/inlXfFL3fmX1a9lXnse
	IJ+PHrgx47WnZsI7W/9QWLKc6upUYZZSeK9cVoT3oqYNSyedsq+qZ0AbYfOwXnwXj2rxAb
	mGvr5R7+vTSs9dgyUu7LZhqlXV99qVg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-31-4AVDySb-N06B7q1aGd3_Bw-1; Mon,
 20 Jul 2026 10:57:04 -0400
X-MC-Unique: 4AVDySb-N06B7q1aGd3_Bw-1
X-Mimecast-MFC-AGG-ID: 4AVDySb-N06B7q1aGd3_Bw_1784559423
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D452B193E88A;
	Mon, 20 Jul 2026 14:57:02 +0000 (UTC)
Received: from jolawren-thinkpadp1gen7.ibmlowe.csb (unknown [10.22.80.207])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C7AE1300418D;
	Mon, 20 Jul 2026 14:57:01 +0000 (UTC)
From: Joe Lawrence <joe.lawrence@redhat.com>
To: live-patching@vger.kernel.org
Cc: Jiri Kosina <jikos@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>,
	Song Liu <song@kernel.org>
Subject: [PATCH 1/4] objtool/klp: use patched module name for klp-relocation section naming
Date: Mon, 20 Jul 2026 10:56:55 -0400
Message-ID: <20260720145658.1103243-2-joe.lawrence@redhat.com>
In-Reply-To: <20260720145658.1103243-1-joe.lawrence@redhat.com>
References: <20260720145658.1103243-1-joe.lawrence@redhat.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Documentation/livepatch/module-elf-format.rst states (and the kernel
currently implements) that the name of a livepatch relocation section
must conform to the following format:

    .klp.rela.objname.section_name

where "objname" determines when the kernel applies the relocations in
this section (i.e., when the "objname" module loads).  This allows
relocations not only for currently loaded kernel objects (like vmlinux
and loaded device drivers), but also for lazy resolution to facilitate
late-module livepatching (for modules loaded after the livepatch).

Previously, objtool's KLP post-link step derived the "objname" from the
klp symbol name, which encoded where the symbol *lives* rather than
which module is being *patched*.  This broke cross-module references
(e.g., can_isotp.ko calling can_rx_unregister() from can.ko),
incorrectly placing them in the .klp.rela.can..text section instead of
.klp.rela.can_isotp..text.

Fix this by adding an 'obj_name' field to the intermediate 'klp_reloc'
struct.  klp-diff populates this field using find_modname(), and
klp-post-link reads it directly to generate the .klp.rela section name.
As a result, each relocation correctly carries its own target module,
regardless of where the referenced symbol originates.

Fixes: dd590d4d57eb ("objtool/klp: Introduce klp diff subcommand for diffing object files")
Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
---
 tools/objtool/include/objtool/klp.h |  1 +
 tools/objtool/klp-diff.c            | 66 +++++++++++++++++++++++------
 tools/objtool/klp-post-link.c       | 20 +++++----
 3 files changed, 65 insertions(+), 22 deletions(-)

diff --git a/tools/objtool/include/objtool/klp.h b/tools/objtool/include/objtool/klp.h
index 6f60cf05db86..bf655b2a7590 100644
--- a/tools/objtool/include/objtool/klp.h
+++ b/tools/objtool/include/objtool/klp.h
@@ -26,6 +26,7 @@
 struct klp_reloc {
 	void *offset;
 	void *sym;
+	void *obj_name;
 	u32 type;
 };
 
diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
index 819f6f167e8c..c5cc54ee562e 100644
--- a/tools/objtool/klp-diff.c
+++ b/tools/objtool/klp-diff.c
@@ -1518,13 +1518,15 @@ static int clone_reloc_klp(struct elfs *e, struct reloc *patched_reloc,
 {
 	struct symbol *patched_sym = patched_reloc->sym;
 	s64 addend = reloc_addend(patched_reloc);
-	const char *sym_modname, *sym_orig_name;
-	static struct section *klp_relocs;
+	const char *sym_modname, *sym_orig_name, *patched_modname;
+	static struct section *klp_relocs, *klp_strs;
+	static struct symbol *klp_strs_sym;
 	struct symbol *sym, *klp_sym;
 	unsigned long klp_reloc_off;
 	char sym_name[SYM_NAME_LEN];
 	struct klp_reloc klp_reloc;
 	unsigned long sympos;
+	s64 str_addend;
 
 	if (!patched_sym->twin) {
 		ERROR("unexpected klp reloc for new symbol %s", patched_sym->name);
@@ -1603,6 +1605,24 @@ static int clone_reloc_klp(struct elfs *e, struct reloc *patched_reloc,
 						0, SHT_PROGBITS, 8, SHF_ALLOC);
 		if (!klp_relocs)
 			return -1;
+
+		klp_strs = find_section_by_name(e->out, KLP_STRINGS_SEC);
+		if (!klp_strs) {
+			klp_strs = elf_create_section(e->out, KLP_STRINGS_SEC,
+						      0, 0, SHT_PROGBITS, 1,
+						      SHF_ALLOC | SHF_STRINGS | SHF_MERGE);
+			if (!klp_strs)
+				return -1;
+			if (elf_add_string(e->out, klp_strs, "") == -1)
+				return -1;
+		}
+
+		klp_strs_sym = klp_strs->sym;
+		if (!klp_strs_sym) {
+			klp_strs_sym = elf_create_section_symbol(e->out, klp_strs);
+			if (!klp_strs_sym)
+				return -1;
+		}
 	}
 
 	klp_reloc_off = sec_size(klp_relocs);
@@ -1627,6 +1647,20 @@ static int clone_reloc_klp(struct elfs *e, struct reloc *patched_reloc,
 			      klp_sym, addend, R_ABS64))
 		return -1;
 
+	/* klp_reloc.obj_name: the patched module, for .klp.rela section naming */
+	patched_modname = find_modname(e);
+	if (!patched_modname)
+		return -1;
+
+	str_addend = elf_add_string(e->out, klp_strs, patched_modname);
+	if (str_addend == -1)
+		return -1;
+
+	if (!elf_create_reloc(e->out, klp_relocs,
+			      klp_reloc_off + offsetof(struct klp_reloc, obj_name),
+			      klp_strs_sym, str_addend, R_ABS64))
+		return -1;
+
 	return 0;
 }
 
@@ -2177,18 +2211,24 @@ static int create_klp_sections(struct elfs *e)
 	if (!funcs_sym)
 		return -1;
 
-	str_sec = elf_create_section(e->out, KLP_STRINGS_SEC, 0, 0,
-				     SHT_PROGBITS, 1,
-				     SHF_ALLOC | SHF_STRINGS | SHF_MERGE);
-	if (!str_sec)
-		return -1;
-
-	if (elf_add_string(e->out, str_sec, "") == -1)
-		return -1;
+	/* clone_reloc_klp() may have already created this section */
+	str_sec = find_section_by_name(e->out, KLP_STRINGS_SEC);
+	if (!str_sec) {
+		str_sec = elf_create_section(e->out, KLP_STRINGS_SEC, 0, 0,
+					     SHT_PROGBITS, 1,
+					     SHF_ALLOC | SHF_STRINGS | SHF_MERGE);
+		if (!str_sec)
+			return -1;
+		if (elf_add_string(e->out, str_sec, "") == -1)
+			return -1;
+	}
 
-	str_sym = elf_create_section_symbol(e->out, str_sec);
-	if (!str_sym)
-		return -1;
+	str_sym = str_sec->sym;
+	if (!str_sym) {
+		str_sym = elf_create_section_symbol(e->out, str_sec);
+		if (!str_sym)
+			return -1;
+	}
 
 	/* allocate klp_object_ext */
 	obj_data = elf_add_data(e->out, obj_sec, NULL, obj_size, true);
diff --git a/tools/objtool/klp-post-link.c b/tools/objtool/klp-post-link.c
index c013e39957b1..141b0a46ca52 100644
--- a/tools/objtool/klp-post-link.c
+++ b/tools/objtool/klp-post-link.c
@@ -39,7 +39,7 @@ static int fix_klp_relocs(struct elf *elf)
 		struct section *sec, *tmp, *klp_rsec;
 		unsigned long offset;
 		struct reloc *reloc;
-		char sym_modname[64];
+		const char *sec_objname;
 		char rsec_name[SEC_NAME_LEN];
 		u64 addend;
 		struct symbol *sym, *klp_sym;
@@ -73,18 +73,20 @@ static int fix_klp_relocs(struct elf *elf)
 		klp_sym = reloc->sym;
 		addend = reloc_addend(reloc);
 
-		/* symbol format: .klp.sym.modname.sym_name,sympos */
-		if (sscanf(klp_sym->name + strlen(KLP_SYM_PREFIX), "%55[^.]", sym_modname) != 1)
-			ERROR("can't find modname in klp symbol '%s'", klp_sym->name);
-
-		/*
-		 * Create the KLP rela:
-		 */
+		/* klp_reloc.obj_name: the patched module name */
+		reloc = find_reloc_by_dest(elf, klp_relocs,
+					   klp_reloc_off + offsetof(struct klp_reloc, obj_name));
+		if (!reloc) {
+			ERROR("malformed " KLP_RELOCS_SEC " section");
+			return -1;
+		}
+		sec_objname = (const char *)reloc->sym->sec->data->d_buf +
+			      reloc_addend(reloc);
 
 		/* section format: .klp.rela.sec_objname.section_name */
 		if (snprintf_check(rsec_name, SEC_NAME_LEN,
 				   KLP_RELOC_SEC_PREFIX "%s.%s",
-				   sym_modname, sec->name))
+				   sec_objname, sec->name))
 			return -1;
 
 		klp_rsec = find_section_by_name(elf, rsec_name);
-- 
2.54.0

