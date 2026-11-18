Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.77.101.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795013497;
	b=YY7xUDhs4jQGfe/oy7ClpfAnZTRP/V7lrdZ9uxhMZmsrR0/46t07k+GqPxqOl0c9sIvM
	 HX+RzfnhxDKXHlInVCVmMkkr7HaKFHkl0A1SiVtwG20Jji/MGh3m3wfFCID2gl7ewHoDn
	 xi6JkWswPjeZzuDBXiQlBPq75aoolA5arpk0omGl56ik9LFV5eI1rpkIZ/uFdn8F9VJU/
	 mlOIG0pdOT9Nexr+ZyAVwK0Skv/dyc3uyZkOFHSMFWSgh9x34aAUIGcsfcoh9g5vAuZId
	 SqY4TFMK774UP6NelNJTpCkxUyDSYduow3ktFUGRQb84azVbzJi8lrpUFzXwZ14nXdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795013497;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-WP-MailID:X-WP-AV:X-WP-SPAM;
	bh=+IwXfmebtoDWz6vZ7BjYGq9l4ESEj1bdwausC1zZ2jA=;
	b=RsOqXykqpMqXe6CiCVCIQCkonnQh75psOg4ThnRPXVrfm9G1NXxetbOK/BnVD7YaFBhG
	 HbJdixCi0RblDFOm/XjA67R9FSzoHFruwAWnYNCxGJRenOXRS1dfM/imblwh80g6NNNMS
	 WdJ2ZXp0+8zu3K1t0LbNNoAglxh9xYXZpxBc9sJjg4XmOp3XKF8k8vcil/Djq5Clw5njt
	 Gfdoo/R4JngqtPKIq+h8QtTACb5o9iUXYIw2RzCBDCzLrDTcN+tO6Oj+igHHHEKR7RjmE
	 YqDkrlrT9Zcl3OqgOCqHvOpHWYMxAHjKd4qFP+SDlEMw+BukrBH1kdq/GdoODlidc0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wp.pl;
	spf=pass smtp.mailfrom=wp.pl;
	dkim=pass header.d=wp.pl header.i=@wp.pl header.a=rsa-sha256 header.s=s20261001 header.b=j9txVf7o;
	arc=none smtp.remote-ip=212.77.101.9
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CEC60A2605
	for <live-patching@vger.kernel.org>; Wed, 18 Nov 2026 14:51:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92CEC60A2605
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.a=rsa-sha256 header.s=s20261001 header.b=j9txVf7o
Received: (wp-smtpd smtp.wp.pl 30757 invoked from network); 18 Nov 2026 15:51:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=s20261001;
          t=1795013488; bh=+IwXfmebtoDWz6vZ7BjYGq9l4ESEj1bdwausC1zZ2jA=;
          h=From:To:Cc:Subject;
          b=j9txVf7oKJ1GHax4SXiO65TXf6gmRrdQhbIyzzDRs4Uuh153TuVjnEeAiX7D2O9UL
           YsvrhyQ4C9ZEE120dFKRJfeRvxdFJMd12TNJqlpriq58JklNkf/TGBbeATSziqenJ+
           g0meOf/E5W0wHFWjGKdnZy8vp75tDwWXiuNRRYiFFhoIF89rqCSoUm0ldoam4a8vdI
           75+uf6PO76h4SwfQcRr7mqWA6GKDBmu9ozAjTS+0H7fK6uJdLha+U4kbnrVLOv+gWf
           r+Y7NsP1WQPsnfZ1sUAAkDYj/TsBpFDEFqHhV3xqmQPbnPuECdq4PtrUO+upJ8hnVQ
           1a7/JPKJHsgsg==
Received: from localhost (77-236-5-223.static.play.pl [77.236.5.223])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
          for <linux-modules@vger.kernel.org>; 18 Nov 2026 15:51:28 +0100
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: linux-modules@vger.kernel.org,
	Sami Tolvanen <samitolvanen@google.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	live-patching@vger.kernel.org,
	Daniel Gomez <da.gomez@kernel.org>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Jordan Rome <linux@jordanrome.com>,
	Viktor Malik <vmalik@redhat.com>,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH v3 2/3] module/kallsyms: sort text symbol indices and use binary search
Date: Wed, 18 Nov 2026 15:51:24 +0100
Message-ID: <20261118145125.29399-3-stf_xl@wp.pl>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261118145125.29399-1-stf_xl@wp.pl>
References: <20261118145125.29399-1-stf_xl@wp.pl>
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
X-WP-MailID: 61291c39f894fda1f23b0b38f94e26ef
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 000000A [wTNE]                               

Module symbol lookup via find_kallsyms_symbol() performs a linear scan
over the entire symtab when resolving an address. The number of symbols
in module symtabs has grown over the years, largely due to additional
metadata in non-standard sections, making this lookup very slow.

Build a separate array of indices to core text symbols and sort it by
resolved address during module load. Binary-search this array for core
text address lookups to avoid scanning the entire symbol table.
Sorting only the index array preserves symbol-table order for existing
consumers.

The additional module load overhead is small. In repeated module load
tests [1], this change increased load time by up to 4%, depending on the
kernel configuration. No measurable increase was observed with cold
caches or with configurations enabling other features that increase
module load time.

Sorting could theoretically be done at build time, but would require
reproducing the kernel's symbol address resolution. Keeping that logic
in sync with the module loader would be error-prone. Build-time sorting
would also increase kernel build time, contrary to recent efforts to
reduce it [2].

The improvement can be observed when listing ftrace filter functions.

Before:

root@nano:~# time cat /sys/kernel/tracing/available_filter_functions | wc -l
74908

real	0m1.315s
user	0m0.000s
sys	0m1.312s

After:

root@nano:~# time cat /sys/kernel/tracing/available_filter_functions | wc -l
74911

real	0m0.167s
user	0m0.004s
sys	0m0.175s

(there are three more symbols introduced by the patch)

Link: https://gist.github.com/sgruszka/09f3fb1dad53a97b1aad96e1927ab117 [1]
Link: https://lwn.net/Articles/1105642/ [2]
Signed-off-by: Stanislaw Gruszka <stf_xl@wp.pl>
---
 include/linux/module.h   |   2 +
 kernel/module/internal.h |   2 +
 kernel/module/kallsyms.c | 194 ++++++++++++++++++++++++++++++---------
 3 files changed, 154 insertions(+), 44 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index f6f90cd88f15..8e9d049d1e07 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -374,8 +374,10 @@ struct module_memory {
 struct mod_kallsyms {
 	Elf_Sym *symtab;
 	unsigned int num_symtab;
+	unsigned int num_text_syms;
 	char *strtab;
 	char *typetab;
+	unsigned int *text_idxtab;
 };
 
 #ifdef CONFIG_LIVEPATCH
diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index 061161cc79d9..00538644772f 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -71,6 +71,8 @@ struct load_info {
 	bool sig_ok;
 #ifdef CONFIG_KALLSYMS
 	unsigned long mod_kallsyms_init_off;
+	unsigned long num_text_syms;
+	unsigned long text_idxtab_off;
 #endif
 #ifdef CONFIG_MODULE_DECOMPRESS
 #ifdef CONFIG_MODULE_STATS
diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
index 5dae0832714a..4e7a1c5a3b8b 100644
--- a/kernel/module/kallsyms.c
+++ b/kernel/module/kallsyms.c
@@ -10,6 +10,7 @@
 #include <linux/kallsyms.h>
 #include <linux/buildid.h>
 #include <linux/bsearch.h>
+#include <linux/sort.h>
 #include "internal.h"
 
 /* Lookup exported symbol in given range of kernel_symbols */
@@ -75,26 +76,27 @@ static char elf_type(const Elf_Sym *sym, const struct load_info *info)
 	return '?';
 }
 
-static bool is_core_symbol(struct module *mod, const struct load_info *info,
-			   unsigned int symnum, const Elf_Sym *src)
+static unsigned int is_core_symbol(struct module *mod,
+				   const struct load_info *info,
+				   unsigned int symnum, const Elf_Sym *src)
 {
 	const Elf_Shdr *sec;
 	enum mod_mem_type type;
 
 	if (symnum == 0 || is_livepatch_module(mod))
-		return true;
+		return 1;
 
 	if (src->st_shndx == SHN_UNDEF ||
 	    src->st_shndx >= info->hdr->e_shnum ||
 	    !src->st_name)
-		return false;
+		return 0;
 
 	if (is_ignored_kernel_symbol(&info->strtab[src->st_name]))
-		return false;
+		return 0;
 
 #ifdef CONFIG_KALLSYMS_ALL
 	if (src->st_shndx == info->index.pcpu)
-		return true;
+		return 1;
 #endif
 
 	sec = info->sechdrs + src->st_shndx;
@@ -104,9 +106,96 @@ static bool is_core_symbol(struct module *mod, const struct load_info *info,
 	    || !(sec->sh_flags & SHF_EXECINSTR)
 #endif
 	    || mod_mem_type_is_init(type))
-		return false;
+		return 0;
+
+	return 1 << (type == MOD_TEXT);
+}
+
+static unsigned int bsearch_text_symbol(struct mod_kallsyms *kallsyms,
+					unsigned long addr,
+					unsigned long *bestval,
+					unsigned long *nextval)
+
+{
+	unsigned int mid, low = 1, high = kallsyms->num_text_syms + 1;
+	unsigned int sym_idx, best = 0;
+	unsigned long thisval;
+
+	while (low < high) {
+		mid = low + (high - low) / 2;
+		sym_idx = kallsyms->text_idxtab[mid - 1];
+		thisval = kallsyms_symbol_value(&kallsyms->symtab[sym_idx]);
+
+		if (thisval <= addr) {
+			*bestval = thisval;
+			best = sym_idx;
+			low = mid + 1;
+		} else {
+			*nextval = thisval;
+			high = mid;
+		}
+	}
+
+	return best;
+}
+
+static const char *kallsyms_symbol_name(struct mod_kallsyms *kallsyms,
+					unsigned int symnum)
+{
+	return kallsyms->strtab + kallsyms->symtab[symnum].st_name;
+}
+
+static unsigned int search_kallsyms_symbol(struct mod_kallsyms *kallsyms,
+					   unsigned long addr,
+					   unsigned long *bestval,
+					   unsigned long *nextval)
+{
+	unsigned int i, best = 0;
+
+	/*
+	 * Scan for closest preceding symbol, and next symbol. (ELF
+	 * starts real symbols at 1).
+	 */
+	for (i = 1; i < kallsyms->num_symtab; i++) {
+		const Elf_Sym *sym = &kallsyms->symtab[i];
+		unsigned long thisval = kallsyms_symbol_value(sym);
+
+		if (sym->st_shndx == SHN_UNDEF)
+			continue;
+
+		if (is_ignored_kernel_symbol(kallsyms_symbol_name(kallsyms, i)))
+			continue;
+
+		if (thisval <= addr && thisval > *bestval) {
+			best = i;
+			*bestval = thisval;
+		}
+		if (thisval > addr && thisval < *nextval)
+			*nextval = thisval;
+	}
 
-	return true;
+	return best;
+}
+
+static int sym_idx_cmp(const void *a, const void *b, const void *priv)
+{
+	const Elf_Sym *syms = priv;
+
+	unsigned int idx_a = (*(unsigned int *)a);
+	unsigned int idx_b = (*(unsigned int *)b);
+
+	unsigned long val_a = kallsyms_symbol_value(&syms[idx_a]);
+	unsigned long val_b = kallsyms_symbol_value(&syms[idx_b]);
+
+	if (val_a < val_b)
+		return -1;
+	if (val_a > val_b)
+		return 1;
+	/*
+	 * For equal-address symbols (aliases), make bsearch_text_symbol()
+	 * select the same symbol as linear search.
+	 */
+	return (idx_a < idx_b) - (idx_a > idx_b);
 }
 
 /*
@@ -121,7 +210,7 @@ void layout_symtab(struct module *mod, struct load_info *info)
 	Elf_Shdr *symsect = info->sechdrs + info->index.sym;
 	Elf_Shdr *strsect = info->sechdrs + info->index.str;
 	const Elf_Sym *src;
-	unsigned int i, nsrc, ndst, strtab_size = 0;
+	unsigned int i, nsrc, ndst, ntxt, strtab_size = 0;
 	struct module_memory *mod_mem_data = &mod->mem[MOD_DATA];
 	struct module_memory *mod_mem_init_data = &mod->mem[MOD_INIT_DATA];
 
@@ -135,9 +224,14 @@ void layout_symtab(struct module *mod, struct load_info *info)
 	nsrc = symsect->sh_size / sizeof(*src);
 
 	/* Compute total space required for the core symbols' strtab. */
-	for (ndst = i = 0; i < nsrc; i++) {
-		if (!is_core_symbol(mod, info, i, src + i))
+	for (ndst = ntxt = i = 0; i < nsrc; i++) {
+		unsigned int sym_type;
+
+		sym_type = is_core_symbol(mod, info, i, src + i);
+		if (sym_type == 0)
 			continue;
+		if (sym_type == 2)
+			ntxt++;
 
 		strtab_size += strlen(&info->strtab[src[i].st_name]) + 1;
 		ndst++;
@@ -147,7 +241,11 @@ void layout_symtab(struct module *mod, struct load_info *info)
 	info->symoffs = ALIGN(mod_mem_data->size, symsect->sh_addralign ?: 1);
 	info->stroffs = mod_mem_data->size = info->symoffs + ndst * sizeof(Elf_Sym);
 	mod_mem_data->size += strtab_size;
-	/* Note add_kallsyms() computes strtab_size as core_typeoffs - stroffs */
+	/* Note add_kallsyms() computes strtab_size as text_idxtab_off - stroffs */
+	info->text_idxtab_off =
+		ALIGN(mod_mem_data->size, __alignof__(unsigned int));
+	mod_mem_data->size =
+		info->text_idxtab_off + ntxt * sizeof(unsigned int);
 	info->core_typeoffs = mod_mem_data->size;
 	mod_mem_data->size += ndst * sizeof(char);
 
@@ -161,12 +259,28 @@ void layout_symtab(struct module *mod, struct load_info *info)
 	mod_mem_init_data->size = ALIGN(mod_mem_init_data->size,
 					__alignof__(struct mod_kallsyms));
 	info->mod_kallsyms_init_off = mod_mem_init_data->size;
+	info->num_text_syms = ntxt;
 
 	mod_mem_init_data->size += sizeof(struct mod_kallsyms);
 	info->init_typeoffs = mod_mem_init_data->size;
 	mod_mem_init_data->size += nsrc * sizeof(char);
 }
 
+// static void pr_tab(unsigned int *tab, unsigned int n, Elf_Sym *syms)
+// {
+// 	int i;
+// 	// printk("\n");
+// 	for (i = 0; i < n; i++) {
+// 		printk(KERN_CONT "%d,", tab[i]);
+// 	}
+// 	printk("VALUES \n");
+// 	for (i = 0; i < n; i++) {
+// 		printk(KERN_CONT "0x%08llx,",
+// 		       (unsigned long long)syms[tab[i]].st_value);
+// 	}
+// 	printk("\n");
+// }
+//
 /*
  * We use the full symtab and strtab which layout_symtab arranged to
  * be appended to the init section.  Later we switch to the cut-down
@@ -174,7 +288,7 @@ void layout_symtab(struct module *mod, struct load_info *info)
  */
 void add_kallsyms(struct module *mod, const struct load_info *info)
 {
-	unsigned int i, ndst;
+	unsigned int i, ntxt, ndst;
 	const Elf_Sym *src;
 	Elf_Sym *dst;
 	char *s;
@@ -199,15 +313,20 @@ void add_kallsyms(struct module *mod, const struct load_info *info)
 	mod->core_kallsyms.symtab = dst = data_base + info->symoffs;
 	mod->core_kallsyms.strtab = s = data_base + info->stroffs;
 	mod->core_kallsyms.typetab = data_base + info->core_typeoffs;
-	strtab_size = info->core_typeoffs - info->stroffs;
+	mod->core_kallsyms.text_idxtab = data_base + info->text_idxtab_off;
+	strtab_size = info->text_idxtab_off - info->stroffs;
 	src = kallsyms->symtab;
-	for (ndst = i = 0; i < kallsyms->num_symtab; i++) {
+	for (ndst = ntxt = i = 0; i < kallsyms->num_symtab; i++) {
+		unsigned int sym_type;
 		ssize_t ret;
 
 		kallsyms->typetab[i] = elf_type(src + i, info);
 
-		if (!is_core_symbol(mod, info, i, src + i))
+		sym_type = is_core_symbol(mod, info, i, src + i);
+		if (sym_type == 0)
 			continue;
+		if (sym_type == 2)
+			mod->core_kallsyms.text_idxtab[ntxt++] = ndst;
 
 		mod->core_kallsyms.typetab[ndst] = kallsyms->typetab[i];
 		dst[ndst] = src[i];
@@ -219,9 +338,14 @@ void add_kallsyms(struct module *mod, const struct load_info *info)
 		strtab_size -= ret + 1;
 	}
 
+	WARN_ON_ONCE(ntxt != info->num_text_syms);
+	sort_r(mod->core_kallsyms.text_idxtab, ntxt, sizeof(unsigned int),
+	       sym_idx_cmp, NULL, dst);
+
 	/* Set up to point into init section. */
 	rcu_assign_pointer(mod->kallsyms, kallsyms);
 	mod->core_kallsyms.num_symtab = ndst;
+	mod->core_kallsyms.num_text_syms = ntxt;
 }
 
 #if IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID)
@@ -244,11 +368,6 @@ void init_build_id(struct module *mod, const struct load_info *info)
 }
 #endif
 
-static const char *kallsyms_symbol_name(struct mod_kallsyms *kallsyms, unsigned int symnum)
-{
-	return kallsyms->strtab + kallsyms->symtab[symnum].st_name;
-}
-
 /*
  * Given a module and address, find the corresponding symbol and return its name
  * while providing its size and offset if needed.
@@ -258,7 +377,10 @@ static const char *find_kallsyms_symbol(struct module *mod,
 					unsigned long *size,
 					unsigned long *offset)
 {
-	unsigned int i, best = 0;
+	unsigned int (*search)(struct mod_kallsyms *kallsyms,
+			       unsigned long addr, unsigned long *bestval,
+			       unsigned long *nextval);
+	unsigned int best;
 	unsigned long nextval, bestval;
 	struct mod_kallsyms *kallsyms = rcu_dereference(mod->kallsyms);
 	struct module_memory *mod_mem = NULL;
@@ -269,6 +391,11 @@ static const char *find_kallsyms_symbol(struct module *mod,
 			continue;
 #endif
 		if (within_module_mem_type(addr, mod, type)) {
+			if (type == MOD_TEXT && kallsyms->num_text_syms > 0)
+				search = bsearch_text_symbol;
+			else
+				search = search_kallsyms_symbol;
+
 			mod_mem = &mod->mem[type];
 			break;
 		}
@@ -281,28 +408,7 @@ static const char *find_kallsyms_symbol(struct module *mod,
 	nextval = (unsigned long)mod_mem->base + mod_mem->size;
 	bestval = (unsigned long)mod_mem->base - 1;
 
-	/*
-	 * Scan for closest preceding symbol, and next symbol. (ELF
-	 * starts real symbols at 1).
-	 */
-	for (i = 1; i < kallsyms->num_symtab; i++) {
-		const Elf_Sym *sym = &kallsyms->symtab[i];
-		unsigned long thisval = kallsyms_symbol_value(sym);
-
-		if (sym->st_shndx == SHN_UNDEF)
-			continue;
-
-		if (is_ignored_kernel_symbol(kallsyms_symbol_name(kallsyms, i)))
-			continue;
-
-		if (thisval <= addr && thisval > bestval) {
-			best = i;
-			bestval = thisval;
-		}
-		if (thisval > addr && thisval < nextval)
-			nextval = thisval;
-	}
-
+	best = search(kallsyms, addr, &bestval, &nextval);
 	if (!best)
 		return NULL;
 
-- 
2.52.0

