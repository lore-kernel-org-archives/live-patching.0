Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8EF34107D
	for <live-patching@vger.kernel.org>; Fri, 24 Jul 2026 22:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784931465; cv=none; b=csc27/cc3tzNzhjdHpboE6HtKOzPCpvTwu6LUVS3Jr56ZsN+nwZ40eKqVa2/Y6Nv9PDUlkzsC1CaiKzkcxQivV05cPzRqLfmvPcQ/ocGGmHzw52vNFlTJVmEJb6h3MRc1nmlLxp/L49PGsoIhMGxFua+LEv/R4a6d6MNW3+KN44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784931465; c=relaxed/simple;
	bh=/NruI5F7S+zZEoGT1fOt+wR0YlQhA/gIAu7vpe7feR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=ll4HNPx1fRJLS+yx6pncK0RoUkiFLRkQsP0ItA1/rqHqiPxwUC0F2E0PnM/San0sCa6VmYijfOSqZKG/S7OrHJt4xeMWn9Zf4N7F/pK1EZZxcWBj/2IFcluAjhchrNikdg9SeaAYLoVxXiSJzMrN9OFbZWXFVnGw7Ljx9PYiVDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W0i1oPD9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W0i1oPD9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784931462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iwznLleuFUe77MewAtJ2/0W3z1ScjZPgr7xxRXkm1i0=;
	b=W0i1oPD9+VpTbyrnXNIGK/6ItJgxmCvi/jMRoyFZDaI52sWyeYWIfcBWxSCfd0jrIb884Z
	Ia39r9UZp2e+F1hK9utYp9LrVfti3YXshv5aUz2psQhSECjEIm/j5S6qYx2JBUiz/lNZ90
	BiVM9gfeNXE6VjjQZaNoLbWW0HlWKQo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-dXk3zd_UNIa4Lh-aZGx8aQ-1; Fri,
 24 Jul 2026 18:17:39 -0400
X-MC-Unique: dXk3zd_UNIa4Lh-aZGx8aQ-1
X-Mimecast-MFC-AGG-ID: dXk3zd_UNIa4Lh-aZGx8aQ_1784931458
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D83BD1955F76;
	Fri, 24 Jul 2026 22:17:37 +0000 (UTC)
Received: from jolawren-thinkpadp1gen7.ibmlowe.csb (unknown [10.22.80.207])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BDA371800635;
	Fri, 24 Jul 2026 22:17:36 +0000 (UTC)
From: Joe Lawrence <joe.lawrence@redhat.com>
To: live-patching@vger.kernel.org
Cc: Ben Procknow <bprockno@redhat.com>,
	Jiri Kosina <jikos@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>,
	Song Liu <song@kernel.org>
Subject: [PATCH v2 1/1] objtool/klp: compute sympos during checksum phase
Date: Fri, 24 Jul 2026 18:17:30 -0400
Message-ID: <20260724221730.3126529-2-joe.lawrence@redhat.com>
In-Reply-To: <20260724221730.3126529-1-joe.lawrence@redhat.com>
References: <20260724221730.3126529-1-joe.lawrence@redhat.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

The sympos value tells livepatch which instance of a duplicate local
symbol to target.  Previously, klp-diff determined sympos by iterating
through the vmlinux.o symbol table and applying heuristics to infer the
linked binary's ordering.  This was fragile and incorrect for data
symbols whose sections get reordered by the linker script.

Fix this by computing sympos during the checksum phase, while the
original linked objects (vmlinux, .ko) are still intact.  Add a
--linked-obj option to `objtool klp checksum` which opens the linked
binary, determines the correct ordering (by address for vmlinux, by
symbol table index for modules), and writes a .discard.sym_order section
into the checksummed .o file.

Later, `objtool klp diff` reads .discard.sym_order from the orig
checksummed file for sympos lookups.  This replaces the old heuristic
entirely.

Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
---
 scripts/livepatch/klp-build                   |  36 +++-
 .../objtool/include/objtool/checksum_types.h  |   6 +
 tools/objtool/klp-checksum.c                  | 195 +++++++++++++++++-
 tools/objtool/klp-diff.c                      |  88 ++++----
 4 files changed, 267 insertions(+), 58 deletions(-)

diff --git a/scripts/livepatch/klp-build b/scripts/livepatch/klp-build
index c4a7acf8edc3..a5ddde6bf7c4 100755
--- a/scripts/livepatch/klp-build
+++ b/scripts/livepatch/klp-build
@@ -582,7 +582,8 @@ find_objects() {
 		    -printf '%P\n'
 }
 
-# Copy all .o archives to $ORIG_DIR
+# Copy all .o archives to $ORIG_DIR, plus the linked vmlinux/.ko binaries
+# needed later for address-based (vmlinux) / index-based (.ko) sympos.
 copy_orig_objects() {
 	local files=()
 
@@ -602,6 +603,16 @@ copy_orig_objects() {
 
 		mkdir -p "$orig_dir"
 		cp -f "$file" "$orig_dir"
+
+		if [[ "$_file" == "vmlinux.o" ]]; then
+			[[ ! -f "$PWD/vmlinux" ]] && die "missing vmlinux"
+			cp -f "$PWD/vmlinux" "$ORIG_DIR/vmlinux"
+		else
+			local ko="${_file%.*}.ko"
+			[[ ! -f "$PWD/$ko" ]] && die "missing $ko"
+			mkdir -p "$(dirname "$ORIG_DIR/$ko")"
+			cp -f "$PWD/$ko" "$ORIG_DIR/$ko"
+		fi
 	done
 	xtrace_restore
 
@@ -650,13 +661,15 @@ copy_patched_objects() {
 }
 
 # Copy .o files to a separate directory and run "objtool klp checksum" on each
-# copy.  The checksums are written to a .discard.sym_checksum section.
+# copy.  The checksums are written to a .discard.sym_checksum section, and
+# duplicate-symbol sympos values (from --linked-obj) to .discard.sym_order.
 #
 # If match_dir is given, only process files which also exist there.
 generate_checksums() {
 	local src_dir="$1"
 	local dest_dir="$2"
-	local match_dir="${3:-}"
+	local linked_root="$3"
+	local match_dir="${4:-}"
 	local files=()
 	local file
 
@@ -667,12 +680,23 @@ generate_checksums() {
 	for file in "${files[@]}"; do
 		local rel="${file#"$src_dir"/}"
 		local dest="$dest_dir/$rel"
+		local linked_obj
+		local linked_obj_arg=()
 
 		[[ -n "$match_dir" && ! -f "$match_dir/$rel" ]] && continue
 
 		mkdir -p "$(dirname "$dest")"
 		cp -f "$file" "$dest"
-		"$OBJTOOL" klp checksum "$dest"
+
+		if [[ "$rel" == "vmlinux.o" ]]; then
+			linked_obj="$linked_root/vmlinux"
+		else
+			linked_obj="$linked_root/${rel%.*}.ko"
+		fi
+		[[ ! -f "$linked_obj" ]] && die "missing linked object: $linked_obj"
+		linked_obj_arg=(--linked-obj "$linked_obj")
+
+		"$OBJTOOL" klp checksum "${linked_obj_arg[@]}" "$dest"
 	done
 
 	touch "$dest_dir/.complete"
@@ -911,9 +935,9 @@ fi
 
 if (( SHORT_CIRCUIT <= 3 )); then
 	status "Generating original checksums"
-	generate_checksums "$ORIG_DIR" "$ORIG_CSUM_DIR" "$PATCHED_DIR"
+	generate_checksums "$ORIG_DIR" "$ORIG_CSUM_DIR" "$ORIG_DIR" "$PATCHED_DIR"
 	status "Generating patched checksums"
-	generate_checksums "$PATCHED_DIR" "$PATCHED_CSUM_DIR"
+	generate_checksums "$PATCHED_DIR" "$PATCHED_CSUM_DIR" "$PWD"
 fi
 
 if (( SHORT_CIRCUIT <= 4 )); then
diff --git a/tools/objtool/include/objtool/checksum_types.h b/tools/objtool/include/objtool/checksum_types.h
index 507efdd8ab5b..2eb5c1cce0c6 100644
--- a/tools/objtool/include/objtool/checksum_types.h
+++ b/tools/objtool/include/objtool/checksum_types.h
@@ -7,6 +7,12 @@ struct sym_checksum {
 	u64 checksum;
 };
 
+struct sym_sympos {
+	u64 addr;
+	u32 sympos;
+	u32 pad;
+};
+
 #ifdef BUILD_KLP
 
 #include <xxhash.h>
diff --git a/tools/objtool/klp-checksum.c b/tools/objtool/klp-checksum.c
index b8e47f28997e..d16f00a3bb2a 100644
--- a/tools/objtool/klp-checksum.c
+++ b/tools/objtool/klp-checksum.c
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 #include <string.h>
+#include <stdlib.h>
+#include <fcntl.h>
 #include <subcmd/parse-options.h>
 
 #include <objtool/arch.h>
@@ -11,6 +13,10 @@
 #include <objtool/warn.h>
 #include <objtool/checksum.h>
 
+#include <linux/string.h>
+
+static const char *linked_obj_name;
+
 static int checksum_debug_init(struct objtool_file *file)
 {
 	char *dup, *s;
@@ -250,6 +256,183 @@ int calculate_checksums(struct objtool_file *file)
 	return 0;
 }
 
+struct linked_sym_entry {
+	unsigned long key;
+	unsigned int sort_idx;
+	const char *file_name;
+};
+
+static int create_sym_order_section(struct objtool_file *file)
+{
+	struct elf *linked_elf;
+	struct section *sec;
+	struct symbol *sym, *lsym;
+	size_t entsize = sizeof(struct sym_sympos);
+	unsigned int idx = 0;
+	bool by_address;
+	int ret = -1;
+
+	sec = find_section_by_name(file->elf, ".discard.sym_order");
+	if (sec) {
+		WARN("file already has .discard.sym_order section, skipping");
+		return 0;
+	}
+
+	linked_elf = elf_open_read(linked_obj_name, O_RDONLY);
+	if (!linked_elf)
+		return -1;
+
+	/*
+	 * For vmlinux, index by address as per:
+	 * kernel/kallsyms.c:kallsyms_on_each_match_symbol()
+	 *
+	 * For modules, index by symtab index as per:
+	 * kernel/module/kallsyms.c:module_kallsyms_on_each_symbol()
+	 */
+	by_address = str_ends_with(linked_obj_name, "vmlinux");
+
+	/*
+	 * Count local symbols in file.o that have duplicates in the linked
+	 * object (vmlinux or .ko).  Only those need sympos.
+	 */
+	for_each_sym(file->elf, sym) {
+		int nr = 0;
+
+		if (sym->bind != STB_LOCAL)
+			continue;
+		if (!is_func_sym(sym) && !is_object_sym(sym))
+			continue;
+
+		for_each_sym_by_name(linked_elf, sym->name, lsym) {
+			if (lsym->bind != STB_LOCAL)
+				continue;
+			if (!is_func_sym(lsym) && !is_object_sym(lsym))
+				continue;
+			nr++;
+		}
+
+		if (nr > 1)
+			idx++;
+	}
+
+	if (!idx) {
+		ret = 0;
+		goto out;
+	}
+
+	sec = elf_create_section_pair(file->elf, ".discard.sym_order", entsize,
+				      idx, idx);
+	if (!sec)
+		goto out;
+
+	/*
+	 * For each local symbol with homonyms in the linked binary, determine
+	 * its sympos: sort the duplicates by address (vmlinux) or symtab
+	 * index (modules), then find our position by filename.
+	 */
+	idx = 0;
+	for_each_sym(file->elf, sym) {
+		struct linked_sym_entry *entries;
+		const char *sym_file_name;
+		struct sym_sympos *entry;
+		int nr = 0, i;
+		long pos = -1;
+
+		if (sym->bind != STB_LOCAL)
+			continue;
+		if (!is_func_sym(sym) && !is_object_sym(sym))
+			continue;
+
+		/* First pass: count to size entries[] */
+		for_each_sym_by_name(linked_elf, sym->name, lsym) {
+			if (lsym->bind != STB_LOCAL)
+				continue;
+			if (!is_func_sym(lsym) && !is_object_sym(lsym))
+				continue;
+			nr++;
+		}
+
+		if (nr <= 1)
+			continue;
+
+		entries = calloc(nr, sizeof(*entries));
+		if (!entries) {
+			ERROR_GLIBC("calloc");
+			goto out;
+		}
+
+		/* Second pass: collect address/index and filename for dupes */
+		nr = 0;
+		for_each_sym_by_name(linked_elf, sym->name, lsym) {
+			if (lsym->bind != STB_LOCAL)
+				continue;
+			if (!is_func_sym(lsym) && !is_object_sym(lsym))
+				continue;
+			entries[nr].key = by_address ? lsym->sym.st_value : lsym->idx;
+			entries[nr].sort_idx = lsym->idx;
+			entries[nr].file_name = lsym->file ? lsym->file->name : NULL;
+			nr++;
+		}
+
+		/* Insertion sort by key, tie-break by symtab index */
+		for (i = 1; i < nr; i++) {
+			struct linked_sym_entry tmp = entries[i];
+			int j = i - 1;
+
+			while (j >= 0 && (entries[j].key > tmp.key ||
+					  (entries[j].key == tmp.key &&
+					   entries[j].sort_idx > tmp.sort_idx))) {
+				entries[j + 1] = entries[j];
+				j--;
+			}
+			entries[j + 1] = tmp;
+		}
+
+		/* Match our compilation unit's filename against sorted entries */
+		sym_file_name = sym->file ? sym->file->name : NULL;
+		for (i = 0; i < nr; i++) {
+			bool match;
+
+			if (sym_file_name && entries[i].file_name)
+				match = !strcmp(sym_file_name, entries[i].file_name);
+			else if (!sym_file_name && !entries[i].file_name)
+				match = true;
+			else
+				match = false;
+
+			if (match) {
+				pos = i + 1;
+				break;
+			}
+		}
+
+		free(entries);
+
+		if (pos < 0) {
+			ERROR("can't determine sympos for %s", sym->name);
+			goto out;
+		}
+
+		/* Emit reloc pointing to sym, with its sympos in the data entry */
+		if (!elf_init_reloc(file->elf, sec->rsec, idx, idx * entsize,
+				    sym, 0, R_TEXT64))
+			goto out;
+
+		entry = (struct sym_sympos *)sec->data->d_buf + idx;
+		entry->addr = 0; /* reloc */
+		entry->sympos = (u32)pos;
+		entry->pad = 0;
+
+		mark_sec_changed(file->elf, sec, true);
+		idx++;
+	}
+
+	ret = 0;
+out:
+	elf_close(linked_elf);
+	return ret;
+}
+
 int create_sym_checksum_section(struct objtool_file *file)
 {
 	struct section *sec;
@@ -297,7 +480,7 @@ int create_sym_checksum_section(struct objtool_file *file)
 }
 
 static const char * const klp_checksum_usage[] = {
-	"objtool klp checksum [<options>] file.o",
+	"objtool klp checksum --linked-obj <vmlinux|file.ko> [<options>] file.o",
 	NULL,
 };
 
@@ -309,6 +492,7 @@ int cmd_klp_checksum(int argc, const char **argv)
 	const struct option options[] = {
 		OPT_STRING(0,	"debug-checksum", &opts.debug_checksum,	"syms", "enable checksum debug output"),
 		OPT_BOOLEAN(0,	"dry-run", &opts.dryrun, "don't write modifications"),
+		OPT_STRING(0,	"linked-obj", &linked_obj_name, "file", "linked binary (vmlinux or .ko) for sympos ordering"),
 		OPT_END(),
 	};
 
@@ -316,6 +500,11 @@ int cmd_klp_checksum(int argc, const char **argv)
 	if (argc != 1)
 		usage_with_options(klp_checksum_usage, options);
 
+	if (!linked_obj_name) {
+		ERROR("--linked-obj is required");
+		usage_with_options(klp_checksum_usage, options);
+	}
+
 	opts.checksum = true;
 
 	objname = argv[0];
@@ -332,6 +521,10 @@ int cmd_klp_checksum(int argc, const char **argv)
 	if (ret)
 		goto out;
 
+	ret = create_sym_order_section(file);
+	if (ret)
+		goto out;
+
 	ret = create_sym_checksum_section(file);
 
 out:
diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
index f7a02c4a2429..89fb43eb4e71 100644
--- a/tools/objtool/klp-diff.c
+++ b/tools/objtool/klp-diff.c
@@ -242,6 +242,41 @@ static int read_sym_checksums(struct elf *elf)
 	return 0;
 }
 
+/*
+ * Look up a symbol's sympos from the .discard.sym_order section.
+ * Returns > 0 for the position among duplicates, or 0 if the symbol is
+ * unique (either not in the section or the section doesn't exist).
+ */
+static long find_sympos_from_order_section(struct elf *elf, struct symbol *sym)
+{
+	struct section *sec;
+	int nr;
+
+	sec = find_section_by_name(elf, ".discard.sym_order");
+	if (!sec)
+		return 0;
+
+	if (!sec->rsec)
+		return 0;
+
+	nr = sec_size(sec) / sizeof(struct sym_sympos);
+	for (int i = 0; i < nr; i++) {
+		struct sym_sympos *entry;
+		struct reloc *reloc;
+
+		reloc = find_reloc_by_dest(elf, sec, i * sizeof(struct sym_sympos));
+		if (!reloc)
+			continue;
+
+		if (reloc->sym == sym) {
+			entry = (struct sym_sympos *)sec->data->d_buf + i;
+			return (long)entry->sympos;
+		}
+	}
+
+	return 0;
+}
+
 static struct symbol *first_file_symbol(struct elf *elf)
 {
 	struct symbol *sym;
@@ -344,6 +379,7 @@ static bool is_special_section(struct section *sec)
 	static const char * const non_special_discards[] = {
 		".discard.addressable",
 		".discard.sym_checksum",
+		".discard.sym_order",
 	};
 
 	if (is_text_sec(sec))
@@ -898,60 +934,10 @@ static int correlate_symbols(struct elfs *e)
 /* "sympos" is used by livepatch to disambiguate duplicate symbol names */
 static unsigned long find_sympos(struct elf *elf, struct symbol *sym)
 {
-	bool vmlinux = str_ends_with(objname, "vmlinux.o");
-	unsigned long sympos = 0, nr_matches = 0;
-	bool has_dup = false;
-	struct symbol *s;
-
 	if (sym->bind != STB_LOCAL)
 		return 0;
 
-	if (vmlinux && is_func_sym(sym)) {
-		/*
-		 * HACK: Unfortunately, symbol ordering can differ between
-		 * vmlinux.o and vmlinux due to the linker script emitting
-		 * .text.unlikely* before .text*.  Count .text.unlikely* first.
-		 *
-		 * TODO: Disambiguate symbols more reliably (checksums?)
-		 */
-		for_each_sym(elf, s) {
-			if (strstarts(s->sec->name, ".text.unlikely") &&
-			    !strcmp(s->name, sym->name)) {
-				nr_matches++;
-				if (s == sym)
-					sympos = nr_matches;
-				else
-					has_dup = true;
-			}
-		}
-		for_each_sym(elf, s) {
-			if (!strstarts(s->sec->name, ".text.unlikely") &&
-			    !strcmp(s->name, sym->name)) {
-				nr_matches++;
-				if (s == sym)
-					sympos = nr_matches;
-				else
-					has_dup = true;
-			}
-		}
-	} else {
-		for_each_sym(elf, s) {
-			if (!strcmp(s->name, sym->name)) {
-				nr_matches++;
-				if (s == sym)
-					sympos = nr_matches;
-				else
-					has_dup = true;
-			}
-		}
-	}
-
-	if (!sympos) {
-		ERROR("can't find sympos for %s", sym->name);
-		return ULONG_MAX;
-	}
-
-	return has_dup ? sympos : 0;
+	return (unsigned long)find_sympos_from_order_section(elf, sym);
 }
 
 static int clone_sym_relocs(struct elfs *e, struct symbol *patched_sym);
-- 
2.54.0

