Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3AC30E84D;
	Mon,  3 Aug 2026 05:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785736184; cv=none; b=Myfg8ulmqnFK1mEEZPzIyaOGuLMaTwSHB2lqpMNr7wxC/WksoFPAurahDa3s2gfz3ui7B6mBOZ/3CgM17MjZ1g6+5mGQVDYxAL4OsXwoS1ytcGx3wKU0eW5G3fZBv0mBhBX2qdazbee6tAgnLM5ECa/LolF3tFVBmGAICXp2eEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785736184; c=relaxed/simple;
	bh=LlL5+Zjwsl2vlmUClW70ZXSovSUz9vKiqO2ovwkrOig=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HWZVSjA7b2KWcw0ZjPzFR5PNE89mQSVsDacJUAgfmUxPD3Z6R1pavmdsV7cCWrJ+kPqCCENaqfuokjGmkub2//S4ujWQ1+OY1JCjuMkoDkkuLFYuKYA2XR8M3rwUasy47wZ/MVfQmwBqxU8LPwSBQ2Mz4bPuU/njFwlfggZr4vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CVaizHTl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0Fco9AyD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CVaizHTl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0Fco9AyD"
Date: Mon, 03 Aug 2026 05:49:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1785736180;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lrZhfUm61c2OXw/YMUYMnAHvEgXuVwWZrCyG0+8SC+M=;
	b=CVaizHTlS8r2OGE45LRbnmkiCUhlNEAV+hhQJCLTCxmopJGs8CgLtek3v/L+Ad3b+mS3NR
	Kyb+m/GnvHjghQf8UNWJ2/vaBNFiIFt0U5b6J6qOghWiGHI0xgmKNEbEMX2Tg4pWzrLRD+
	UCV6Jm1zWCH/nDruK9x8uw2lpshW1mDWMlwgNVaRTRns7xaIj0i9QuEU99FNN8ddbipizd
	Fp/zf6K6DVPG6YqXStbkEJntYF3HyT/qV16s0r+WFUdv3Gx1wBGzzDMWAFYJ/MEfx4mS7p
	AObuMaXmHU8pNiO0Cif4bOu/Paju5XKTxYaujBBSwrSSEvLa9+dsxEqLPbnY6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1785736180;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lrZhfUm61c2OXw/YMUYMnAHvEgXuVwWZrCyG0+8SC+M=;
	b=0Fco9AyDBqur6fIlNf+yR9zAb/OaQ5kOwVVfhU+aE/IwXOoZxDHNWWe9nhnM+F7L6C//JS
	tE7o1Mm+s6k0FlAg==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: objtool/core] objtool/klp: Add .klp.symid for sympos disambiguation
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 live-patching@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To:
 <64d50f077b569f47883c015cdb7079edb068efe8.1785727106.git.jpoimboe@kernel.org>
References:
 <64d50f077b569f47883c015cdb7079edb068efe8.1785727106.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <178573617913.1210945.4137827646322421739.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     029223d301620bc4e1086696047b0d5d6eba5edd
Gitweb:        https://git.kernel.org/tip/029223d301620bc4e1086696047b0d5d6eb=
a5edd
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Sun, 02 Aug 2026 20:24:27 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 03 Aug 2026 07:12:39 +02:00

objtool/klp: Add .klp.symid for sympos disambiguation

Livepatch identifies a duplicate-named symbol by its position (sympos)
among same-named kallsyms entries, which for vmlinux are counted in
ascending address order in the final linked kernel.  That order can't be
reliably derived from vmlinux.o: the final link reorders sub-sections
(.text.unlikely*, .data..*, etc).

Bridge the gap with a new .klp.symid section which can be used to
correlate symbols between vmlinux.o and vmlinux so that klp-diff can
reliably determine the sympos.

The table can't survive --gc-sections: keeping it alive would keep every
duplicate-named symbol's section alive, so the reference kernel would
stop matching the one which ships.  klp-build rejects
CONFIG_LD_DEAD_CODE_DATA_ELIMINATION instead.  Nothing is lost today:
x86_64 is the only HAVE_KLP_BUILD arch and doesn't select
HAVE_LD_DEAD_CODE_DATA_ELIMINATION, arm64 and s390 have never selected
it either, and on powerpc, it's still EXPERIMENTAL and disabled by every
distro kernel.

This is the build-time half of reliable vmlinux sympos computation;
"objtool klp diff" will consume the table in a subsequent commit.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: live-patching@vger.kernel.org
Link: https://patch.msgid.link/64d50f077b569f47883c015cdb7079edb068efe8.17857=
27106.git.jpoimboe@kernel.org
---
 include/asm-generic/vmlinux.lds.h       |  10 +-
 scripts/Makefile.vmlinux_o              |   3 +-
 scripts/livepatch/klp-build             |   5 +-
 scripts/mod/modpost.c                   |   1 +-
 tools/objtool/Build                     |   1 +-
 tools/objtool/builtin-check.c           |   7 +-
 tools/objtool/check.c                   |   7 +-
 tools/objtool/include/objtool/builtin.h |   1 +-
 tools/objtool/include/objtool/klp.h     |  15 +++-
 tools/objtool/klp-symid.c               | 117 +++++++++++++++++++++++-
 10 files changed, 166 insertions(+), 1 deletion(-)
 create mode 100644 tools/objtool/klp-symid.c

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.=
lds.h
index 5659f4b..ee9c5d3 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -839,12 +839,20 @@
 		.stab.index 0 : { *(.stab.index) }			\
 		.stab.indexstr 0 : { *(.stab.indexstr) }
=20
+#ifdef CONFIG_KLP_BUILD
+#define KLP_SYMID							\
+		.klp.symid 0 : { *(.klp.symid) }
+#else
+#define KLP_SYMID
+#endif
+
 /* Required sections not related to debugging. */
 #define ELF_DETAILS							\
 		.comment 0 : { *(.comment) }				\
 		.symtab 0 : { *(.symtab) }				\
 		.strtab 0 : { *(.strtab) }				\
-		.shstrtab 0 : { *(.shstrtab) }
+		.shstrtab 0 : { *(.shstrtab) }				\
+		KLP_SYMID
=20
 #define MODINFO								\
 		.modinfo : { *(.modinfo) . =3D ALIGN(8); }
diff --git a/scripts/Makefile.vmlinux_o b/scripts/Makefile.vmlinux_o
index 527352c..24a3a4f 100644
--- a/scripts/Makefile.vmlinux_o
+++ b/scripts/Makefile.vmlinux_o
@@ -47,6 +47,9 @@ endif
 vmlinux-objtool-args-$(CONFIG_NOINSTR_VALIDATION)	+=3D --noinstr \
 							   $(if $(or $(CONFIG_MITIGATION_UNRET_ENTRY),$(CONFIG_MITIGATION_SRS=
O)), --unret)
=20
+# Only used for builds initiated by klp-build
+vmlinux-objtool-args-$(if $(KLP_SYMIDS),y)		+=3D --klp-symids
+
 objtool-args =3D $(vmlinux-objtool-args-y) --link
=20
 # Link of vmlinux.o used for section mismatch analysis
diff --git a/scripts/livepatch/klp-build b/scripts/livepatch/klp-build
index a8c103c..f94e324 100755
--- a/scripts/livepatch/klp-build
+++ b/scripts/livepatch/klp-build
@@ -271,6 +271,9 @@ validate_config() {
 	[[ -v CONFIG_GCC_PLUGIN_RANDSTRUCT ]] &&	\
 		die "kernel option 'CONFIG_GCC_PLUGIN_RANDSTRUCT' not supported"
=20
+	[[ -v CONFIG_LD_DEAD_CODE_DATA_ELIMINATION ]] &&		\
+		die "kernel option 'CONFIG_LD_DEAD_CODE_DATA_ELIMINATION' not supported"
+
 	[[ -v CONFIG_AS_IS_LLVM ]] &&				\
 		[[ "$CONFIG_AS_VERSION" -lt 200000 ]] &&	\
 		die "Clang assembler version < 20 not supported"
@@ -555,6 +558,8 @@ build_kernel() {
 	#
 	cmd+=3D("KBUILD_MODPOST_WARN=3D1")
=20
+	cmd+=3D("KLP_SYMIDS=3D1")
+
 	if [[ -v VERBOSE ]]; then
 		cmd+=3D("V=3D1")
 	else
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index a7b72a8..027944f 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -767,6 +767,7 @@ static const char *const section_white_list[] =3D
 	".llvm.call-graph-profile",	/* call graph */
 	"__llvm_covfun",
 	"__llvm_covmap",
+	".klp.symid",			/* objtool --klp-symids */
 	NULL
 };
=20
diff --git a/tools/objtool/Build b/tools/objtool/Build
index 93a37b0..506f89b 100644
--- a/tools/objtool/Build
+++ b/tools/objtool/Build
@@ -6,6 +6,7 @@ objtool-y +=3D check.o
 objtool-y +=3D special.o
 objtool-y +=3D builtin-check.o
 objtool-y +=3D elf.o
+objtool-y +=3D klp-symid.o
 objtool-y +=3D objtool.o
=20
 objtool-$(BUILD_DISAS) +=3D disas.o
diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index 118c3de..75b11dc 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -76,6 +76,7 @@ static const struct option check_options[] =3D {
 	OPT_STRING_OPTARG('d',	 "disas", &opts.disas, "function-pattern", "disassem=
ble functions", "*"),
 	OPT_CALLBACK_OPTARG('h', "hacks", NULL, NULL, "jump_label,noinstr,skylake",=
 "patch toolchain bugs/limitations", parse_hacks),
 	OPT_BOOLEAN('i',	 "ibt", &opts.ibt, "validate and annotate IBT"),
+	OPT_BOOLEAN(0,		 "klp-symids", &opts.klp_symids, "generate .klp.symids for =
duplicate symbol disambiguation"),
 	OPT_BOOLEAN('m',	 "mcount", &opts.mcount, "annotate mcount/fentry calls for=
 ftrace"),
 	OPT_BOOLEAN(0,		 "noabs", &opts.noabs, "reject absolute references in alloc=
atable sections"),
 	OPT_BOOLEAN('n',	 "noinstr", &opts.noinstr, "validate noinstr rules"),
@@ -174,10 +175,16 @@ static bool opts_valid(void)
 		return false;
 	}
=20
+	if (opts.klp_symids && !opts.link) {
+		ERROR("--klp-symids requires --link");
+		return false;
+	}
+
 	if (opts.disas			||
 	    opts.hack_jump_label	||
 	    opts.hack_noinstr		||
 	    opts.ibt			||
+	    opts.klp_symids		||
 	    opts.mcount			||
 	    opts.noabs			||
 	    opts.noinstr		||
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index f03dd59..a98d758 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -15,6 +15,7 @@
 #include <objtool/arch.h>
 #include <objtool/disas.h>
 #include <objtool/check.h>
+#include <objtool/klp.h>
 #include <objtool/special.h>
 #include <objtool/trace.h>
 #include <objtool/warn.h>
@@ -4923,6 +4924,12 @@ int check(struct objtool_file *file)
 			goto out;
 	}
=20
+	if (opts.klp_symids) {
+		ret =3D klp_create_symid_sections(file);
+		if (ret)
+			goto out;
+	}
+
 	if (opts.noabs)
 		warnings +=3D check_abs_references(file);
=20
diff --git a/tools/objtool/include/objtool/builtin.h b/tools/objtool/include/=
objtool/builtin.h
index e844e9c..349690b 100644
--- a/tools/objtool/include/objtool/builtin.h
+++ b/tools/objtool/include/objtool/builtin.h
@@ -16,6 +16,7 @@ struct opts {
 	bool hack_noinstr;
 	bool hack_skylake;
 	bool ibt;
+	bool klp_symids;
 	bool mcount;
 	bool noabs;
 	bool noinstr;
diff --git a/tools/objtool/include/objtool/klp.h b/tools/objtool/include/objt=
ool/klp.h
index aab6db4..4d3c3bd 100644
--- a/tools/objtool/include/objtool/klp.h
+++ b/tools/objtool/include/objtool/klp.h
@@ -31,6 +31,21 @@ struct klp_reloc {
 	u32 type;
 };
=20
+/*
+ * .klp.symid is used to correlate symbols between vmlinux.o and vmlinux, for
+ * calculating sympos to disambiguate duplicately-named symbols.
+ */
+#define KLP_SYMID_SEC	".klp.symid"
+
+struct klp_symid {
+	u64 id;
+	u64 addr;
+};
+
+struct objtool_file;
+
+int klp_create_symid_sections(struct objtool_file *file);
+
 int cmd_klp_checksum(int argc, const char **argv);
 int cmd_klp_diff(int argc, const char **argv);
 int cmd_klp_post_link(int argc, const char **argv);
diff --git a/tools/objtool/klp-symid.c b/tools/objtool/klp-symid.c
new file mode 100644
index 0000000..cf188cd
--- /dev/null
+++ b/tools/objtool/klp-symid.c
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Emit the .klp.symid table which allows "objtool klp diff" to reliably
+ * disambiguate duplicate-named local symbols in vmlinux.
+ *
+ * Livepatch identifies a duplicate-named symbol by its position (sympos)
+ * among the same-named kallsyms entries, counted in ascending address order
+ * in the final linked vmlinux.  That order can't be derived from vmlinux.o
+ * alone: the final link reorders sub-sections (.text.unlikely*, .data..*,
+ * etc).
+ *
+ * Bridge the gap with a table which survives the final link: a single
+ * non-alloc section containing an array of { id, addr } entries, where
+ * 'id' is a unique counter identifier and 'addr' has a relocation to the
+ * symbol.  The linker copies 'id' verbatim and resolves 'addr' to the symbo=
l's
+ * final address.
+ *
+ * The table is only emitted for vmlinux.o, and only when klp-build asks for=
 it
+ * with KLP_SYMIDS=3D1, which adds --klp-symids to the vmlinux.o objtool run.
+ *
+ * It can't survive --gc-sections, which sweeps the whole section; klp-build
+ * rejects CONFIG_LD_DEAD_CODE_DATA_ELIMINATION.
+ */
+#include <linux/string.h>
+
+#include <objtool/objtool.h>
+#include <objtool/warn.h>
+#include <objtool/endianness.h>
+#include <objtool/klp.h>
+
+static const char * const discarded_secs[] =3D {
+	".discard",
+	".modinfo",
+	"__tracepoint_check",
+};
+
+static bool discarded_sec(struct section *sec)
+{
+	if (!(sec->sh.sh_flags & SHF_ALLOC))
+		return true;
+
+	for (int i =3D 0; i < ARRAY_SIZE(discarded_secs); i++)
+		if (strstarts(sec->name, discarded_secs[i]))
+			return true;
+
+	return false;
+}
+
+static bool symid_needed(struct elf *elf, struct symbol *sym)
+{
+	struct symbol *s;
+
+	if (!is_local_sym(sym) || is_undef_sym(sym))
+		return false;
+
+	if (!is_func_sym(sym) && !is_object_sym(sym))
+		return false;
+
+	if (is_prefix_func(sym))
+		return false;
+
+	if (discarded_sec(sym->sec))
+		return false;
+
+	for_each_sym_by_name(elf, sym->name, s) {
+		if (s =3D=3D sym || is_sec_sym(s) || is_file_sym(s) || is_undef_sym(s))
+			continue;
+		return true;
+	}
+
+	return false;
+}
+
+int klp_create_symid_sections(struct objtool_file *file)
+{
+	struct elf *elf =3D file->elf;
+	struct klp_symid *symids;
+	struct section *sec;
+	struct symbol *sym;
+	u64 nr =3D 0, i =3D 0;
+
+	if (!str_ends_with(objname, "vmlinux.o"))
+		return 0;
+
+	for_each_sym(elf, sym)
+		if (symid_needed(elf, sym))
+			nr++;
+
+	if (!nr)
+		return 0;
+
+	sec =3D elf_create_section(elf, KLP_SYMID_SEC, 0, sizeof(struct klp_symid),
+				 SHT_PROGBITS, 8, 0);
+	if (!sec)
+		return -1;
+
+	symids =3D elf_add_data(elf, sec, NULL, nr * sizeof(struct klp_symid));
+	if (!symids)
+		return -1;
+
+	for_each_sym(elf, sym) {
+		if (!symid_needed(elf, sym))
+			continue;
+
+		symids[i].id =3D bswap_if_needed(elf, i);
+
+		if (!elf_create_reloc(elf, sec,
+				      i * sizeof(struct klp_symid) +
+				      offsetof(struct klp_symid, addr),
+				      sym, 0, R_ABS64))
+			return -1;
+
+		i++;
+	}
+
+	return 0;
+}
