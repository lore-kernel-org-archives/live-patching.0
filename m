Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B031F2380;
	Mon,  3 Aug 2026 05:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785736185; cv=none; b=VHA9VWM6zAjwpQf8TU9binxRupHQ5kDSsJos/14lAyGl2r+Era1Xc9/XL7nLA0WQ9OnrXoovtJQUHvnn3IZILbMEKy4rCGzRGaEH2yW7ObTrHKVyBYKnjqBZNZvNeac/ushHPWqAliaE0Nfov7syBREtvECiT4TUHaZytPT6tqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785736185; c=relaxed/simple;
	bh=R0puDksdVmGbg+2iiwvA3XtyzuSTQVDmvCTH/EBIsk0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=YT/fTE92yZwk2fm+QVd5MMFhuAjNCO30ZZ7y5x08EB7PIxVNy+0m9snHmeQ409SVix6hUeJKhQBTBEenH7Qj182L4U7R2doy8TemOyRXKYo17fZhWfFSNvY2MkqvkVcFBCB6BOvoP/UoYsooQceVgAUjJuHN6+lb5z3MceL/vRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2J0K2Jw9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZuwoMrZ4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2J0K2Jw9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZuwoMrZ4"
Date: Mon, 03 Aug 2026 05:49:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1785736179;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M9jDmxB85s4lkFPdBqobI0HlBs+DPkl1gmKy36z+Vcc=;
	b=2J0K2Jw9dRC4Rhn2Z+oOHWwjdZYG+cuyGcWw6Lhgl6+kH+qY1XjHnGfDhbDoyG3KfCERoG
	ksxeGNo9tlQnPdCC7QvJLt7/++o2kiF7o09+wRq5EGiBevDWoTlwmeNDfJyNqHD173CcTF
	PLY3FH2ZOoPEpu5I56qMqPccGb/hNww2JK7z0e4iIhQgLUG7DwBAiob4nrFEUJdZ6ip4ih
	mVAdovLN0wrOUPX1KxLz1/Yd0DZFLRoBsD/crGapCGTtBncc1xwu9lbskJwpcrGyCmVm5C
	0sJZhNelUZfExd7VYGD0Hfgvg7YE3Zl24wc68A6cge/EVH7FzLpxLD5adD44Bg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1785736179;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M9jDmxB85s4lkFPdBqobI0HlBs+DPkl1gmKy36z+Vcc=;
	b=ZuwoMrZ41f4caxICdrUdVagYRoe7V2kApA9KLFWp8ZZnhAF2q5SiUn2K+Y0xA7FRFSbFF8
	hh850WHqs+QQIvDQ==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool/klp: Fix symbol resolution for duplicate
 data symbols
Cc: Ben Procknow <bprockno@redhat.com>, Joe Lawrence <joe.lawrence@redhat.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 live-patching@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To:
 <919785e3bf2245db02ff6391e735d9cb139170b1.1785727106.git.jpoimboe@kernel.org>
References:
 <919785e3bf2245db02ff6391e735d9cb139170b1.1785727106.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <178573617749.1210945.8900250328764526482.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     15fa203ef91e8a303c322eaaa8ca01a6ddaf94dc
Gitweb:        https://git.kernel.org/tip/15fa203ef91e8a303c322eaaa8ca01a6dda=
f94dc
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Sun, 02 Aug 2026 20:24:28 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 03 Aug 2026 07:12:39 +02:00

objtool/klp: Fix symbol resolution for duplicate data symbols

find_sympos() calculates a sympos used by livepatch to disambiguate
duplicately-named symbols.  For function symbols, there's a hack which
counts .text.unlikely symbols before other .text symbols, matching the
linker script's section ordering.

Not only is the hack fragile, data symbols can have the same problem.
So for example, adding a reference to pwq_cache in
ep_unregister_pollwait() can trigger a corrupt sympos and a relocation
to the wrong pwq_cache symbol in the livepatch module, resulting in a
crash or undefined behavior.

Remove the existing hack in favor of a fully deterministic solution,
using the new .klp.symid table to derive the symbol-to-id mapping from
the original vmlinux.o and the id-to-address mapping from the
corresponding vmlinux, which can then be used to determine the exact
sympos associated with the original vmlinux.

Modules don't need any special treatment: the .ko has the same
section/symbol ordering as the original whole-archive symbol table.

Fixes: dd590d4d57eb ("objtool/klp: Introduce klp diff subcommand for diffing =
object files")
Reported-by: Ben Procknow <bprockno@redhat.com>
Reported-by: Joe Lawrence <joe.lawrence@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: live-patching@vger.kernel.org
Link: https://lore.kernel.org/20260710153042.3156788-1-joe.lawrence@redhat.com
Link: https://lore.kernel.org/20260724221730.3126529-1-joe.lawrence@redhat.com
Link: https://patch.msgid.link/919785e3bf2245db02ff6391e735d9cb139170b1.17857=
27106.git.jpoimboe@kernel.org
---
 scripts/livepatch/klp-build         |   4 +-
 tools/objtool/Build                 |   3 +-
 tools/objtool/include/objtool/klp.h |   5 +-
 tools/objtool/klp-diff.c            |  66 +----
 tools/objtool/klp-sympos.c          | 411 +++++++++++++++++++++++++++-
 5 files changed, 427 insertions(+), 62 deletions(-)
 create mode 100644 tools/objtool/klp-sympos.c

diff --git a/scripts/livepatch/klp-build b/scripts/livepatch/klp-build
index f94e324..b52a848 100755
--- a/scripts/livepatch/klp-build
+++ b/scripts/livepatch/klp-build
@@ -611,6 +611,8 @@ copy_orig_objects() {
 	done
 	xtrace_restore
=20
+	cp -f "$PWD/vmlinux" "$ORIG_DIR" || die "missing vmlinux"
+
 	mv -f "$TMP_DIR/build.log" "$ORIG_DIR"
 	touch "$TIMESTAMP"
 	touch "$ORIG_DIR/.complete"
@@ -681,6 +683,8 @@ generate_checksums() {
 		"$OBJTOOL" klp checksum "$dest"
 	done
=20
+	[[ -f "$src_dir/vmlinux" ]] && cp -f "$src_dir/vmlinux" "$dest_dir"
+
 	touch "$dest_dir/.complete"
 }
=20
diff --git a/tools/objtool/Build b/tools/objtool/Build
index 506f89b..59f9486 100644
--- a/tools/objtool/Build
+++ b/tools/objtool/Build
@@ -13,7 +13,8 @@ objtool-$(BUILD_DISAS) +=3D disas.o
 objtool-$(BUILD_DISAS) +=3D trace.o
=20
 objtool-$(BUILD_ORC) +=3D orc_gen.o orc_dump.o
-objtool-$(BUILD_KLP) +=3D builtin-klp.o klp-checksum.o klp-diff.o klp-post-l=
ink.o
+objtool-$(BUILD_KLP) +=3D builtin-klp.o klp-checksum.o klp-diff.o \
+			klp-post-link.o klp-sympos.o
=20
 objtool-y +=3D libstring.o
 objtool-y +=3D libctype.o
diff --git a/tools/objtool/include/objtool/klp.h b/tools/objtool/include/objt=
ool/klp.h
index 4d3c3bd..0118c2c 100644
--- a/tools/objtool/include/objtool/klp.h
+++ b/tools/objtool/include/objtool/klp.h
@@ -43,9 +43,14 @@ struct klp_symid {
 };
=20
 struct objtool_file;
+struct elf;
+struct symbol;
=20
 int klp_create_symid_sections(struct objtool_file *file);
=20
+int klp_sympos_init(struct elf *orig);
+unsigned long klp_find_sympos(struct elf *elf, struct symbol *sym);
+
 int cmd_klp_checksum(int argc, const char **argv);
 int cmd_klp_diff(int argc, const char **argv);
 int cmd_klp_post_link(int argc, const char **argv);
diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
index 75ba0e0..c5284d2 100644
--- a/tools/objtool/klp-diff.c
+++ b/tools/objtool/klp-diff.c
@@ -898,65 +898,6 @@ static int correlate_symbols(struct elfs *e)
 	return 0;
 }
=20
-/* "sympos" is used by livepatch to disambiguate duplicate symbol names */
-static unsigned long find_sympos(struct elf *elf, struct symbol *sym)
-{
-	bool vmlinux =3D str_ends_with(objname, "vmlinux.o");
-	unsigned long sympos =3D 0, nr_matches =3D 0;
-	bool has_dup =3D false;
-	struct symbol *s;
-
-	if (sym->bind !=3D STB_LOCAL)
-		return 0;
-
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
-				if (s =3D=3D sym)
-					sympos =3D nr_matches;
-				else
-					has_dup =3D true;
-			}
-		}
-		for_each_sym(elf, s) {
-			if (!strstarts(s->sec->name, ".text.unlikely") &&
-			    !strcmp(s->name, sym->name)) {
-				nr_matches++;
-				if (s =3D=3D sym)
-					sympos =3D nr_matches;
-				else
-					has_dup =3D true;
-			}
-		}
-	} else {
-		for_each_sym(elf, s) {
-			if (!strcmp(s->name, sym->name)) {
-				nr_matches++;
-				if (s =3D=3D sym)
-					sympos =3D nr_matches;
-				else
-					has_dup =3D true;
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
-}
-
 static int clone_sym_relocs(struct elfs *e, struct symbol *patched_sym);
=20
 static struct symbol *__clone_symbol(struct elf *elf, struct symbol *patched=
_sym,
@@ -1418,7 +1359,7 @@ static int clone_reloc_klp(struct elfs *e, struct reloc=
 *patched_reloc,
 			return -1;
=20
 		sym_orig_name =3D patched_sym->twin->name;
-		sympos =3D find_sympos(e->orig, patched_sym->twin);
+		sympos =3D klp_find_sympos(e->orig, patched_sym->twin);
 		if (sympos =3D=3D ULONG_MAX)
 			return -1;
 	}
@@ -2036,7 +1977,7 @@ static int create_klp_sections(struct elfs *e)
=20
 		/* klp_func_ext.sympos */
 		BUILD_BUG_ON(sizeof(sympos) !=3D sizeof_field(struct klp_func_ext, sympos)=
);
-		sympos =3D find_sympos(e->orig, sym->clone->twin);
+		sympos =3D klp_find_sympos(e->orig, sym->clone->twin);
 		if (sympos =3D=3D ULONG_MAX)
 			return -1;
 		memcpy(func_data + offsetof(struct klp_func_ext, sympos), &sympos,
@@ -2190,6 +2131,9 @@ int cmd_klp_diff(int argc, const char **argv)
 	if (!e.orig || !e.patched)
 		return -1;
=20
+	if (klp_sympos_init(e.orig))
+		return -1;
+
 	if (read_exports())
 		return -1;
=20
diff --git a/tools/objtool/klp-sympos.c b/tools/objtool/klp-sympos.c
new file mode 100644
index 0000000..bbfae51
--- /dev/null
+++ b/tools/objtool/klp-sympos.c
@@ -0,0 +1,411 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Compute "sympos", the position used by livepatch to disambiguate
+ * duplicate symbol names in the patched object.
+ */
+#include <stdlib.h>
+#include <string.h>
+#include <fcntl.h>
+
+#include <objtool/objtool.h>
+#include <objtool/warn.h>
+#include <objtool/endianness.h>
+#include <objtool/klp.h>
+
+#include <linux/string.h>
+
+struct vmlinux_sym {
+	struct hlist_node hash;
+	const char *name;
+	u64 addr;
+};
+
+struct vmlinux_symid {
+	struct hlist_node hash;
+	u64 id;
+	u64 addr;
+};
+
+struct vmlinux_o_symid {
+	struct hlist_node hash;
+	u64 id;
+	unsigned int sym_idx;
+};
+
+static DEFINE_HASHTABLE(vmlinux_o_symids, 16);
+
+/*
+ * The original linked kernel, found next to the orig vmlinux.o.  Read with =
raw
+ * libelf rather than elf_open_read(): only the symbol table and the resolved
+ * .klp.symid table are needed, not the (huge) instruction/reloc machinery.
+ *
+ * Both tables are built once by read_orig_vmlinux().  The Elf handle stays
+ * open because the hashed names point into its mmapped string table.
+ */
+static struct {
+	Elf *elf;
+	DECLARE_HASHTABLE(syms, 16);	/* name -> address */
+	DECLARE_HASHTABLE(symids, 16);	/* .klp.symid id -> address */
+} vmlinux;
+
+/*
+ * Would the symbol be visible to the runtime's kallsyms-based symbol lookup?
+ */
+static bool vmlinux_sym_in_kallsyms(Elf *elf, GElf_Sym *sym)
+{
+	unsigned int type =3D GELF_ST_TYPE(sym->st_info);
+	GElf_Shdr shdr;
+	Elf_Scn *scn;
+
+	if (sym->st_shndx =3D=3D SHN_UNDEF || sym->st_shndx >=3D SHN_LORESERVE)
+		return false;
+
+	if (type =3D=3D STT_SECTION || type =3D=3D STT_FILE)
+		return false;
+
+	scn =3D elf_getscn(elf, sym->st_shndx);
+	if (!scn || !gelf_getshdr(scn, &shdr))
+		return false;
+
+	return shdr.sh_flags & SHF_ALLOC;
+}
+
+static int read_orig_vmlinux(const char *filename)
+{
+	size_t shstrndx, nr_syms =3D 0, nr_symids =3D 0, strtab_idx =3D 0;
+	Elf_Data *symtab_data =3D NULL, *symid_data =3D NULL;
+	struct klp_symid *symids;
+	Elf_Scn *scn =3D NULL;
+	GElf_Ehdr ehdr;
+	int fd;
+
+	fd =3D open(filename, O_RDONLY);
+	if (fd =3D=3D -1) {
+		ERROR_GLIBC("can't open '%s'", filename);
+		return -1;
+	}
+
+	if (elf_version(EV_CURRENT) =3D=3D EV_NONE) {
+		ERROR_ELF("elf_version");
+		return -1;
+	}
+
+	vmlinux.elf =3D elf_begin(fd, ELF_C_READ_MMAP, NULL);
+	if (!vmlinux.elf) {
+		ERROR_ELF("elf_begin");
+		return -1;
+	}
+
+	if (!gelf_getehdr(vmlinux.elf, &ehdr)) {
+		ERROR_ELF("gelf_getehdr");
+		return -1;
+	}
+
+	if (elf_getshdrstrndx(vmlinux.elf, &shstrndx)) {
+		ERROR_ELF("elf_getshdrstrndx");
+		return -1;
+	}
+
+	while ((scn =3D elf_nextscn(vmlinux.elf, scn))) {
+		const char *name;
+		GElf_Shdr shdr;
+
+		if (!gelf_getshdr(scn, &shdr)) {
+			ERROR_ELF("gelf_getshdr");
+			return -1;
+		}
+
+		if (shdr.sh_type =3D=3D SHT_SYMTAB) {
+			symtab_data =3D elf_getdata(scn, NULL);
+			if (!symtab_data) {
+				ERROR_ELF("elf_getdata");
+				return -1;
+			}
+			nr_syms =3D shdr.sh_size / shdr.sh_entsize;
+			strtab_idx =3D shdr.sh_link;
+			continue;
+		}
+
+		name =3D elf_strptr(vmlinux.elf, shstrndx, shdr.sh_name);
+		if (name && !strcmp(name, KLP_SYMID_SEC)) {
+			if (shdr.sh_size % sizeof(struct klp_symid)) {
+				ERROR("%s: %s: struct klp_symid size mismatch",
+				      filename, KLP_SYMID_SEC);
+				return -1;
+			}
+			symid_data =3D elf_getdata(scn, NULL);
+			if (!symid_data) {
+				ERROR_ELF("elf_getdata");
+				return -1;
+			}
+			nr_symids =3D shdr.sh_size / sizeof(struct klp_symid);
+		}
+	}
+
+	if (!symtab_data) {
+		ERROR("%s: missing symbol table", filename);
+		return -1;
+	}
+
+	if (!symid_data) {
+		ERROR("%s: missing %s section, kernel not built with CONFIG_KLP_BUILD?",
+		      filename, KLP_SYMID_SEC);
+		return -1;
+	}
+
+	for (size_t i =3D 0; i < nr_syms; i++) {
+		struct vmlinux_sym *vsym;
+		const char *name;
+		GElf_Sym s;
+
+		if (!gelf_getsym(symtab_data, i, &s)) {
+			ERROR_ELF("gelf_getsym");
+			return -1;
+		}
+
+		if (!vmlinux_sym_in_kallsyms(vmlinux.elf, &s))
+			continue;
+
+		name =3D elf_strptr(vmlinux.elf, strtab_idx, s.st_name);
+		if (!name)
+			continue;
+
+		vsym =3D calloc(1, sizeof(*vsym));
+		if (!vsym) {
+			ERROR_GLIBC("calloc");
+			return -1;
+		}
+
+		vsym->name =3D name;
+		vsym->addr =3D s.st_value;
+		hash_add(vmlinux.syms, &vsym->hash, str_hash(name));
+	}
+
+	symids =3D symid_data->d_buf;
+
+	for (size_t i =3D 0; i < nr_symids; i++) {
+		struct vmlinux_symid *vsymid;
+
+		vsymid =3D calloc(1, sizeof(*vsymid));
+		if (!vsymid) {
+			ERROR_GLIBC("calloc");
+			return -1;
+		}
+
+		vsymid->id =3D __bswap_if_needed(&ehdr, symids[i].id);
+		vsymid->addr =3D __bswap_if_needed(&ehdr, symids[i].addr);
+		hash_add(vmlinux.symids, &vsymid->hash, vsymid->id);
+	}
+
+	/* the fd and Elf handle stay open, the hashed names live in the mmap */
+	return 0;
+}
+
+/*
+ * Read the orig vmlinux.o's .klp.symid table, an array of entries whose 'ad=
dr'
+ * fields have relocs to the symbols they describe.
+ */
+static int read_vmlinux_o_symids(struct elf *vmlinux_o)
+{
+	struct section *sec;
+
+	for_each_sec(vmlinux_o, sec) {
+		unsigned long nr;
+
+		if (strcmp(sec->name, KLP_SYMID_SEC))
+			continue;
+
+		if (sec_size(sec) % sizeof(struct klp_symid)) {
+			ERROR("%s: %s: struct klp_symid size mismatch",
+			      vmlinux_o->name, KLP_SYMID_SEC);
+			return -1;
+		}
+
+		nr =3D sec_size(sec) / sizeof(struct klp_symid);
+
+		for (unsigned long i =3D 0; i < nr; i++) {
+			unsigned long offset =3D i * sizeof(struct klp_symid);
+			struct vmlinux_o_symid *entry;
+			struct klp_symid *symid;
+			struct reloc *reloc;
+
+			entry =3D calloc(1, sizeof(*entry));
+			if (!entry) {
+				ERROR_GLIBC("calloc");
+				return -1;
+			}
+
+			symid =3D sec->data->d_buf + offset;
+			entry->id =3D bswap_if_needed(vmlinux_o, symid->id);
+
+			reloc =3D find_reloc_by_dest(vmlinux_o, sec,
+						   offset + offsetof(struct klp_symid, addr));
+			if (!reloc) {
+				ERROR("%s: missing reloc for %s entry",
+				      vmlinux_o->name, KLP_SYMID_SEC);
+				return -1;
+			}
+			entry->sym_idx =3D reloc->sym->idx;
+
+			hash_add(vmlinux_o_symids, &entry->hash, entry->sym_idx);
+		}
+	}
+
+	return 0;
+}
+
+int klp_sympos_init(struct elf *orig)
+{
+	char *filename;
+	int ret;
+
+	if (!str_ends_with(objname, "vmlinux.o"))
+		return 0;
+
+	if (read_vmlinux_o_symids(orig))
+		return -1;
+
+	filename =3D strndup(objname, strlen(objname) - 2);
+	if (!filename) {
+		ERROR_GLIBC("strndup");
+		return -1;
+	}
+
+	ret =3D read_orig_vmlinux(filename);
+	free(filename);
+
+	return ret;
+}
+
+/* Find the symbol's id in the orig vmlinux.o's .klp.symid table */
+static int find_vmlinux_o_symid(struct symbol *sym, u64 *id)
+{
+	struct vmlinux_o_symid *entry;
+
+	hash_for_each_possible(vmlinux_o_symids, entry, hash, sym->idx) {
+		if (entry->sym_idx =3D=3D sym->idx) {
+			*id =3D entry->id;
+			return 0;
+		}
+	}
+
+	ERROR("no %s entry for symbol %s in orig vmlinux.o", KLP_SYMID_SEC,
+	      sym->name);
+	return -1;
+}
+
+/* Find the symbol's final address in the orig vmlinux's .klp.symid table */
+static int find_vmlinux_symid_addr(u64 id, u64 *addr)
+{
+	struct vmlinux_symid *symid;
+
+	hash_for_each_possible(vmlinux.symids, symid, hash, id) {
+		if (symid->id =3D=3D id) {
+			*addr =3D symid->addr;
+			return 0;
+		}
+	}
+
+	return -1;
+}
+
+/*
+ * Find the sympos of a vmlinux-local symbol by ranking its final address
+ * among the duplicately named symbols in the linked orig vmlinux, replicati=
ng
+ * the order in which kallsyms_on_each_match_symbol() counts them.
+ */
+static unsigned long find_vmlinux_sympos(struct symbol *sym)
+{
+	unsigned long nr_matches =3D 0, sympos =3D 1;
+	u32 key =3D str_hash(sym->name);
+	struct vmlinux_sym *vsym;
+	bool found =3D false;
+	u64 id, addr;
+
+	hash_for_each_possible(vmlinux.syms, vsym, hash, key)
+		if (!strcmp(vsym->name, sym->name))
+			nr_matches++;
+
+	if (!nr_matches) {
+		ERROR("can't find symbol %s in orig vmlinux", sym->name);
+		return ULONG_MAX;
+	}
+
+	/*
+	 * Unique symbols don't need disambiguating.  They also have no
+	 * .klp.symid entry, which is only emitted for names duplicated in
+	 * vmlinux.o, so the lookups below would fail.
+	 */
+	if (nr_matches =3D=3D 1)
+		return 0;
+
+	if (find_vmlinux_o_symid(sym, &id))
+		return ULONG_MAX;
+
+	if (find_vmlinux_symid_addr(id, &addr)) {
+		ERROR("no %s entry for symbol %s in orig vmlinux", KLP_SYMID_SEC,
+		      sym->name);
+		return ULONG_MAX;
+	}
+
+	hash_for_each_possible(vmlinux.syms, vsym, hash, key) {
+		if (strcmp(vsym->name, sym->name))
+			continue;
+
+		if (vsym->addr < addr)
+			sympos++;
+		else if (vsym->addr =3D=3D addr)
+			found =3D true;
+	}
+
+	if (!found) {
+		ERROR("%s address mismatch for symbol %s, stale orig vmlinux?",
+		      KLP_SYMID_SEC, sym->name);
+		return ULONG_MAX;
+	}
+
+	return sympos;
+}
+
+/*
+ * "sympos" is used by livepatch to disambiguate duplicate symbol names.
+ */
+unsigned long klp_find_sympos(struct elf *elf, struct symbol *sym)
+{
+	unsigned long sympos =3D 0, nr_matches =3D 0;
+	bool has_dup =3D false;
+	struct symbol *s;
+
+	if (sym->bind !=3D STB_LOCAL)
+		return 0;
+
+	/*
+	 * vmlinux: the final link reorders symbols relative to vmlinux.o,
+	 * so the position needs to be derived from the linked orig vmlinux via
+	 * the .klp.symid table.
+	 */
+	if (vmlinux.elf)
+		return find_vmlinux_sympos(sym);
+
+	/*
+	 * modules: the final .ko preserves symbol table order, so a
+	 * symtab-order count here matches the runtime count done by
+	 * module_kallsyms_on_each_symbol().
+	 */
+	for_each_sym(elf, s) {
+		if (!strcmp(s->name, sym->name)) {
+			nr_matches++;
+			if (s =3D=3D sym)
+				sympos =3D nr_matches;
+			else
+				has_dup =3D true;
+		}
+	}
+
+	if (!sympos) {
+		ERROR("can't find sympos for %s", sym->name);
+		return ULONG_MAX;
+	}
+
+	return has_dup ? sympos : 0;
+}
