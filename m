Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36F0419314
	for <live-patching@vger.kernel.org>; Mon, 20 Jul 2026 14:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784559433; cv=none; b=B98Hwl2BlrgpKO52FfVv0HhYRj/K9Zhcc3n6yohe/ZBep7e7D1ME70pZqZYOCiZCZon8Aukwa0TdC2GRsivQKTEnzko/G7TI77lii/i6S0FPRY0D1k8y5due3r/0scJ1w37eI1g7yTR5ywoOL0fYSjzQcCtSlq+g1z6ZPVIhxnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784559433; c=relaxed/simple;
	bh=YYdMgWgQnZsBmWaX9yGGAiep/mvRfSJxI9gPef22LY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=eKFa8cQjMv755At0bHZQPF7284ITK71ijLUj8cZxLar0W3hd0zpdquTzE4itNyWPI1K/q666xbyfzSKZ5mRGbDnWo1RU2pCVqgbcoiD+Oj3ZccnAxylxjesPFO20425oNUyzYudHCgTP9MsSuQbNRfCXTCfLv+JoWWW0V8ZluK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Op7JxOpV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Op7JxOpV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784559430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5LA79ihH6GZbeVoJRzpQbnpAwiH3tRQ885V8rRC/ed0=;
	b=Op7JxOpV4RRHhjTq62CGjEK45tImv/SezMGoeH8iCJjVDkh7tBH1OCKSLu9fgt1ES5C55z
	2DOrI15KfAY/rc7THU/lNyoJKbB4katQL2vnXZf2vWyxJs95dLlD9LtE6GV+w55gkfzuX7
	71sDUVT+o17hNWf+1CnA1+enHSATxk8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-424-3BM2YiOiP4q4RTAcDlwrVw-1; Mon,
 20 Jul 2026 10:57:09 -0400
X-MC-Unique: 3BM2YiOiP4q4RTAcDlwrVw-1
X-Mimecast-MFC-AGG-ID: 3BM2YiOiP4q4RTAcDlwrVw_1784559426
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CDB881953988;
	Mon, 20 Jul 2026 14:57:06 +0000 (UTC)
Received: from jolawren-thinkpadp1gen7.ibmlowe.csb (unknown [10.22.80.207])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D0B0B30001BE;
	Mon, 20 Jul 2026 14:57:05 +0000 (UTC)
From: Joe Lawrence <joe.lawrence@redhat.com>
To: live-patching@vger.kernel.org
Cc: Jiri Kosina <jikos@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>,
	Song Liu <song@kernel.org>
Subject: [PATCH 4/4] objtool/klp: strip klp-induced module dependencies from livepatch modules
Date: Mon, 20 Jul 2026 10:56:58 -0400
Message-ID: <20260720145658.1103243-5-joe.lawrence@redhat.com>
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

The klp-diff pipeline creates weak UNDEF placeholder symbols for
cross-module references that will become klp-relocations.  When modpost
runs on the linked livepatch .ko, it sees these UNDEF symbols, resolves
them via Module.symvers, and adds the providing modules to the depends=
field in .modinfo.

These dependencies are unnecessary: klp-relocations are resolved by the
livepatch infrastructure at patch-enable time, not by the module loader.
Adding hard module dependencies defeats late-module patching, since the
kernel will refuse to load the livepatch module unless all depended
modules are already present.

Fix this by having klp-post-link strip any depends= entry that is only
the result of klp-symbol (.klp.sym.<mod>.*).  The check is conservative:
if any remaining SHN_UNDEF symbol matches a known export name from that
module, the dependency is kept (indicating a legitimate non-KLP
reference).

Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
---
 tools/objtool/klp-post-link.c | 175 ++++++++++++++++++++++++++++++++++
 1 file changed, 175 insertions(+)

diff --git a/tools/objtool/klp-post-link.c b/tools/objtool/klp-post-link.c
index 141b0a46ca52..8bdec0b38f65 100644
--- a/tools/objtool/klp-post-link.c
+++ b/tools/objtool/klp-post-link.c
@@ -19,6 +19,178 @@
 #include <objtool/util.h>
 #include <linux/livepatch_external.h>
 
+static bool modnames_match(const char *a, const char *b, size_t len)
+{
+	for (size_t i = 0; i < len; i++) {
+		char ca = a[i] == '-' ? '_' : a[i];
+		char cb = b[i] == '-' ? '_' : b[i];
+		if (ca != cb)
+			return false;
+	}
+	return true;
+}
+
+/*
+ * Extract the export name length from a KLP symbol name suffix: "<name>,<pos>"
+ */
+static size_t klp_sym_name_len(const char *name_start)
+{
+	const char *comma = strrchr(name_start, ',');
+	return comma ? (size_t)(comma - name_start) : strlen(name_start);
+}
+
+/*
+ * Check if the dependency on 'mod' is purely from KLP relocations.
+ *
+ * Returns true only if:
+ *  (a) .klp.sym.<mod>.* symbols exist (the dep is KLP-related), AND
+ *  (b) no remaining SHN_UNDEF symbol shares a name with any of those exports
+ *      (which would indicate a non-KLP reference to the same module)
+ */
+static bool is_klp_only_dep(struct elf *elf, const char *mod)
+{
+	const char *exports[1024];
+	size_t export_lens[1024];
+	int nr_exports = 0;
+	struct symbol *sym;
+	size_t prefix_len = strlen(KLP_SYM_PREFIX);
+
+	/* Collect export names from .klp.sym.<mod>.* symbols */
+	for_each_sym(elf, sym) {
+		const char *name = sym->name;
+		const char *dot;
+
+		if (!strstarts(name, KLP_SYM_PREFIX))
+			continue;
+
+		dot = strchr(name + prefix_len, '.');
+		if (!dot)
+			continue;
+
+		if (strlen(mod) != (size_t)(dot - name - prefix_len) ||
+		    !modnames_match(name + prefix_len, mod, dot - name - prefix_len))
+			continue;
+
+		if (nr_exports >= 1024) {
+			WARN("too many KLP exports for module %s, skipping dependency stripping", mod);
+			return false;
+		}
+
+		exports[nr_exports] = dot + 1;
+		export_lens[nr_exports] = klp_sym_name_len(dot + 1);
+		nr_exports++;
+	}
+
+	if (!nr_exports)
+		return false;
+
+	/*
+	 * Verify no remaining UNDEF symbol matches an export name from this
+	 * module.  After fix_klp_relocs(), KLP placeholder symbols have been
+	 * converted to SHN_LIVEPATCH.  Any leftover UNDEF with a matching name
+	 * indicates a legitimate non-KLP dependency.
+	 */
+	for_each_sym(elf, sym) {
+		const char *name = sym->name;
+
+		if (sym->sym.st_shndx != SHN_UNDEF)
+			continue;
+		if (!name || !*name)
+			continue;
+
+		for (int i = 0; i < nr_exports; i++) {
+			if (strlen(name) == export_lens[i] &&
+			    !strncmp(name, exports[i], export_lens[i]))
+				return false;
+		}
+	}
+
+	return true;
+}
+
+/*
+ * Remove modules from .modinfo depends= that are only referenced via KLP
+ * relocations.  These dependencies are an artifact of the placeholder symbols
+ * created by klp-diff for the linker/objtool and should not constrain module
+ * load ordering (which would break late-module patching).
+ */
+static int fix_modinfo_depends(struct elf *elf)
+{
+	struct section *sec;
+	char *data, *data_end, *depends = NULL;
+	char *new_depends, *p;
+	char *tok, *save;
+	char *dep_val, *dep_copy;
+	size_t old_entry_len, new_entry_len;
+
+	sec = find_section_by_name(elf, ".modinfo");
+	if (!sec || !sec->data || !sec->data->d_buf)
+		return 0;
+
+	data = sec->data->d_buf;
+	data_end = data + sec->data->d_size;
+
+	for (char *s = data; s < data_end; s += strlen(s) + 1) {
+		if (strstarts(s, "depends=")) {
+			depends = s;
+			break;
+		}
+	}
+
+	if (!depends)
+		return 0;
+
+	dep_val = depends + strlen("depends=");
+	if (!*dep_val)
+		return 0;
+
+	new_depends = strdup(dep_val);
+	if (!new_depends) {
+		ERROR_GLIBC("strdup");
+		return -1;
+	}
+
+	dep_copy = strdup(dep_val);
+	if (!dep_copy) {
+		ERROR_GLIBC("strdup");
+		free(new_depends);
+		return -1;
+	}
+
+	p = new_depends;
+	*p = '\0';
+
+	tok = strtok_r(dep_copy, ",", &save);
+	while (tok) {
+		if (!is_klp_only_dep(elf, tok)) {
+			if (p != new_depends)
+				*p++ = ',';
+			strcpy(p, tok);
+			p += strlen(tok);
+		}
+		tok = strtok_r(NULL, ",", &save);
+	}
+
+	old_entry_len = strlen(depends) + 1;
+	new_entry_len = strlen("depends=") + strlen(new_depends) + 1;
+
+	if (strcmp(dep_val, new_depends) && new_entry_len <= old_entry_len) {
+		snprintf(depends, old_entry_len, "depends=%s", new_depends);
+		memset(depends + new_entry_len, '\0',
+		       old_entry_len - new_entry_len);
+		mark_sec_changed(elf, sec, true);
+	} else if (new_entry_len > old_entry_len) {
+		ERROR("new depends= string exceeds original size (shouldn't happen)");
+		free(dep_copy);
+		free(new_depends);
+		return -1;
+	}
+
+	free(dep_copy);
+	free(new_depends);
+	return 0;
+}
+
 static int fix_klp_relocs(struct elf *elf)
 {
 	struct section *symtab, *klp_relocs;
@@ -163,6 +335,9 @@ int cmd_klp_post_link(int argc, const char **argv)
 	if (fix_klp_relocs(elf))
 		return -1;
 
+	if (fix_modinfo_depends(elf))
+		return -1;
+
 	if (elf_write(elf))
 		return -1;
 
-- 
2.54.0

