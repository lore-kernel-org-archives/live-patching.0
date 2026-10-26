Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793010008;
	b=Dpy3caVskirYY2TDXoqtqsFIyl/bkBZm1jebVctDDiNrxkz2SMfobz6FkbqVFHFUtFwQ
	 0sVP2S3lZYh1lseLKXJQDqO2G+Jt+UBi7vLI0ql9QR8fLX6kdPV71jVMP3XtPdKjLuqAQ
	 yt9AWw3w9uIoAL4hfDSFKFDdmILec/WvEzQ5CDSXNq0fee58eVgO/Kn3n65is7Wt5/yje
	 6HAvMFwHLNEYx/WzI1hmLtBrx5Ve3/4yOyXkurXPW2i734J44gY5yKhUMPZaGJPa0MbjG
	 WmJghZvX7g2xTAYlJbXCQ5+NkA9zC3vBAyWKg4cOPntPpH157f0SGC+cXizTfn2EQLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793010008;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=R7ayfwP1J9HUgf0k7UUFM4rYuWVmZxgPnlIQ6JtyqtE=;
	b=awRSvOBXYC0ei4AKcUrN4I2S0bq2w5Uxxmr77LX0/uo6YuL2eD+tJAMqu/IRPM0S3TIF
	 +HUzAQmJqdgdyiv6M9wVcNUi+wueWw0DsjOEP8sWv5O79gcRUWJ7WlTNDY84/uDu/5U+g
	 6pSEc/QvD3fcSqfcNxc0ddDU3isx2ZGphbwRR7C5U2MmJbrS5UfrLmluzVfJfOvAisK6B
	 GxAntAIGNIzkuYjOLEH0SYQy+MwW8Ii+W6i9oxYqfmmudyLcb1KoQeVXf6npzyNOPG6MM
	 bRqXDeh8z/8xDMpSVmsjcHeV21dGaIs5X5kL5d3Z3pdJbVqj5A9FubcFIfPDvFLwPuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=R3+aIr6F;
	arc=none smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675E6606A32D
	for <live-patching@vger.kernel.org>; Mon, 26 Oct 2026 10:20:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 675E6606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=R3+aIr6F
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2e9d1114320so21089745ad.3
        for <live-patching@vger.kernel.org>; Mon, 26 Oct 2026 03:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793010007; x=1793614807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R7ayfwP1J9HUgf0k7UUFM4rYuWVmZxgPnlIQ6JtyqtE=;
        b=R3+aIr6FdPmV5CcxskwzBfeMz0IgFXfFNcYU4/zpq6xH9LleNnhMD0684DQK/o0a/e
         RPzq03/0Ya/sa/x8IaG0jXanoP4W1EMV+D0Q9gF9o6wwzP1ioaG8EQ0FBLAdmOxb+unT
         1Yo9+QyBgN89nQWbLt2EE7wVMHgLOeTIItb9k8FZiMKGwINDK3f6e90o63LkbYBrO9U+
         nyf/wfKgIb/+xObeazdp0KyjH6eyyxyrIK1vQ9lbrBZdN0T3r8IX0u7TeCIEw/Gmg+lG
         ETLKo4Yx6ESIJoHeyi2BXLF3Lzae91amU+2NW6Rk/gH7IgGvbnIHXMH7qwOu2KTW8eMh
         DbvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793010007; x=1793614807;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=R7ayfwP1J9HUgf0k7UUFM4rYuWVmZxgPnlIQ6JtyqtE=;
        b=HYPEJa8wtYSXRVCjQMk/kbrKAkUK+CT4HAoNsZ16XY9+/ql8aT9g7JFCvkiZyFp4mM
         8BDQ2yWMGHsTN09oobBi3LiwkFmIyBRnUWmvvU83PhtBFrBBMgNYxBUMFSz/X+XR8wC6
         8JLox3lSUFs8WRG2D/LGqBWavdac8Qw7j3G0mfZ7TQ5FOO+YLcb83B5T33/pQp5Y9KNq
         OPURSAw2GjGjTKsiEwmeBizr1e6O+aisqCoPxK1oL6I3gbKSEZw5p6zewGxrXR/p+3V7
         jgvW+li2tuXYi6Iqpy7p74rDFZVtHgBjbBrMFT7hwyGgPUSHlJy3dR1x9+wRd90FgfMu
         ZUEw==
X-Forwarded-Encrypted: i=1; AKwUvBwTcZyQJ2dpXiZ94j6XvglS0vCCSPdWa381VmuXZ7wQGyHPSJ4Gdl4VyVraNFloEF8f4hDOFVy3LMId2mUb@vger.kernel.org
X-Gm-Message-State: AFq9FYIZAbr1xb0yUId7Vk2HXi4n06Qc9lKiyrTMzXAo2hJl885pws3h
	t15YWltbV2/O8DVmCLxul3t3W20sA1YeK40N93sp8a8Ei1YC1F1BzvzJ
X-Gm-Gg: AYBFou1m4X1soh+jU8j/CtjWt2iIQmcc5In7m4M8HRPI8Wt5+FR038fAQuOWKCHab0S
	PlIKTzCVARx4SleYuSHLkoVeYliFdz+3GcQ2MDY9Iozod8C2Ltp6LTDDMRZnb2sOsWaG6tHjKXp
	0SEwjSKNBdEf26ErkSGHXSGFpWKOUL0LQjRG/RGQlofPmFswuTnmFtNlEvHNe9ppqw6aGttem8E
	DzJwpFeX+lV+y/NvSJC5S2WCuEaIWOXuz3E67/qbFp1fSlavm8Le83EaixDw7w3+/HVW35GCkeZ
	X3iiqi/GkUn+s71wu97ZyYah64AspmEwjllW0hS9IBFuT349H56HrI+4HC/kXWK/UvndFfWHDvl
	lESyP4GoNpiEM04xtLGCcX6Al0P4cpO7BxMdjnpe2/dcFbKAmc25jGBJjqbL9krGak8Ys2rDN/A
	/soQbky8TIfqLj1I6bTTfOoMNo5xOam0Avf6w7BVgU/O6byos1dOrhy3wlwrkR+H+8j26xdYR5e
	kEZg9tzrBT+c4wZjaiRxx6abnDaAjjmyK3XgJ0Pmr9mYH3asRGEzbGAAAvUrEndTRtorYnLos74
	g3R6OKA2giguhJLB/syccKg=
X-Received: by 2002:a17:90b:134b:b0:3ab:5758:3766 with SMTP id 98e67ed59e1d1-3adeb10f19cmr5339105a91.51.1793010005230;
        Mon, 26 Oct 2026 03:20:05 -0700 (PDT)
Received: from anatasluo-Precision-5560 ([2408:820c:d29:db90:8486:5157:635e:e0f0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adeba32e38sm8477565a91.2.2026.10.26.03.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 03:20:04 -0700 (PDT)
From: Longjun Luo <luolongjuna@gmail.com>
To: jpoimboe@kernel.org,
	peterz@infradead.org
Cc: mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	song@kernel.org,
	puranjay@kernel.org,
	nathan@kernel.org,
	ndesaulniers@google.com,
	morbo@google.com,
	justinstitt@google.com,
	live-patching@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Longjun Luo <luolongjuna@gmail.com>
Subject: [RFC PATCH 1/3] objtool/klp: Correlate symbols using DWARF identity
Date: Mon, 26 Oct 2026 18:19:14 +0800
Message-ID: <20261026101916.3823942-2-luolongjuna@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261026101916.3823942-1-luolongjuna@gmail.com>
References: <20261026101916.3823942-1-luolongjuna@gmail.com>
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

ELF names and STT_FILE entries do not provide enough context to
distinguish symbols across builds. Compiler renumbering and LTO can
cause missed matches or silently pair unrelated symbols.

Extend symbol correlation to (source, scope, name). Use DWARF to
recover the defining translation unit and named scope, with STT_FILE
as a fallback. Retain checksums to resolve remaining ambiguity.
Accept only unique matches. Report ambiguous symbols and leave them
uncorrelated instead of pairing them by position.

Building objtool's klp support now requires libdw. klp-build compiles
the kernel with -g (KCFLAGS and KAFLAGS) so that DWARF is available
regardless of the kernel's debug-info configuration, and the klp test
fixtures do the same. Split DWARF is rejected for now.

Tested independently on x86-64 with tools/objtool/tests/run-tests.sh:

  GCC 16.2.1: 45 passed, 3 failed, 4 skipped.
  Clang 22.1.8: 48 passed, 3 failed, 1 skipped.

The three failures reflect deliberate rejections:

- local-to-global-flip: the patch changes a symbol's source-level
  linkage (DW_AT_external, not ELF st_bind, so LTO promotion is not
  affected). A static symbol's identity carries its defining CU while
  an external one's does not, so the two are different identities.
  Pairing them would need a rule outside the identity model; the patch
  can instead keep the static symbol and add a global wrapper.

- sympos, sympos-vmlinux: the same source is compiled into multiple
  objects, producing instances with identical (source, scope, name).
  Telling them apart would depend on object or link order, which this
  series deliberately avoids. This does not occur in the audited
  vmlinux.o builds.

Assisted-by: LLM
Signed-off-by: Longjun Luo <luolongjuna@gmail.com>
---
 scripts/livepatch/klp-build                   |   5 +-
 tools/objtool/Build                           |   4 +-
 tools/objtool/Makefile                        |  12 +-
 tools/objtool/elf.c                           |  33 +-
 tools/objtool/include/objtool/elf.h           |  34 +-
 tools/objtool/include/objtool/klp-dwarf.h     |  21 +
 tools/objtool/include/objtool/klp-identity.h  |  25 +
 tools/objtool/klp-checksum.c                  |  16 +-
 tools/objtool/klp-diff.c                      | 561 ++++---------
 tools/objtool/klp-dwarf.c                     | 778 ++++++++++++++++++
 tools/objtool/klp-identity.c                  | 170 ++++
 .../tests/generic/test-thinlto-ambiguity.sh   |   2 +-
 .../tests/generic/test-thinlto-local.sh       |   4 +-
 tools/objtool/tests/lib.sh                    |   7 +-
 14 files changed, 1217 insertions(+), 455 deletions(-)
 create mode 100644 tools/objtool/include/objtool/klp-dwarf.h
 create mode 100644 tools/objtool/include/objtool/klp-identity.h
 create mode 100644 tools/objtool/klp-dwarf.c
 create mode 100644 tools/objtool/klp-identity.c

diff --git a/scripts/livepatch/klp-build b/scripts/livepatch/klp-build
index b52a8489d9f6..0f141dc06fd2 100755
--- a/scripts/livepatch/klp-build
+++ b/scripts/livepatch/klp-build
@@ -279,7 +279,7 @@ validate_config() {
 		die "Clang assembler version < 20 not supported"
 
 	[[ -x "$OBJTOOL" ]] && "$OBJTOOL" klp 2>&1 | command grep -q "not implemented" && \
-		die "objtool not built with KLP support; install xxhash-devel/libxxhash-dev (version >= 0.8) and recompile"
+		die "objtool not built with KLP support; install xxhash-devel/libxxhash-dev (version >= 0.8) and elfutils-devel/libdw-dev and recompile"
 
 	return 0
 }
@@ -566,7 +566,8 @@ build_kernel() {
 		cmd+=("-s")
 	fi
 	cmd+=("-j$JOBS")
-	cmd+=("KCFLAGS=-ffunction-sections -fdata-sections")
+	cmd+=("KCFLAGS=-g -ffunction-sections -fdata-sections")
+	cmd+=("KAFLAGS=-g")
 	cmd+=("vmlinux")
 	cmd+=("modules")
 
diff --git a/tools/objtool/Build b/tools/objtool/Build
index 59f948628098..84139709a2dd 100644
--- a/tools/objtool/Build
+++ b/tools/objtool/Build
@@ -13,8 +13,8 @@ objtool-$(BUILD_DISAS) += disas.o
 objtool-$(BUILD_DISAS) += trace.o
 
 objtool-$(BUILD_ORC) += orc_gen.o orc_dump.o
-objtool-$(BUILD_KLP) += builtin-klp.o klp-checksum.o klp-diff.o \
-			klp-post-link.o klp-sympos.o
+objtool-$(BUILD_KLP) += builtin-klp.o klp-checksum.o klp-diff.o klp-dwarf.o \
+			klp-post-link.o klp-sympos.o klp-identity.o
 
 objtool-y += libstring.o
 objtool-y += libctype.o
diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index db99c4759b2c..e2fbd778bb74 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -14,7 +14,12 @@ endif
 ifeq ($(ARCH_HAS_KLP),y)
 	HAVE_XXHASH = $(shell printf "$(pound)include <xxhash.h>\nXXH3_state_t *state;int main() {}" | \
 		      $(HOSTCC) $(HOSTCFLAGS) -xc - -o /dev/null -lxxhash 2> /dev/null && echo y || echo n)
-	ifeq ($(HAVE_XXHASH),y)
+	LIBDW_CFLAGS := $(shell $(HOSTPKG_CONFIG) libdw --cflags 2>/dev/null)
+	LIBDW_LIBS := $(shell $(HOSTPKG_CONFIG) libdw --libs 2>/dev/null || echo -ldw)
+	HAVE_LIBDW = $(shell printf "$(pound)include <elfutils/libdwfl.h>\nint main(void) { return !dwfl_begin(0); }" | \
+		     $(HOSTCC) $(HOSTCFLAGS) $(LIBDW_CFLAGS) -xc - -o /dev/null \
+		     $(HOSTLDFLAGS) $(LIBDW_LIBS) 2>/dev/null && echo y || echo n)
+	ifeq ($(HAVE_XXHASH)$(HAVE_LIBDW),yy)
 		BUILD_KLP	 := y
 		LIBXXHASH_CFLAGS := $(shell $(HOSTPKG_CONFIG) libxxhash --cflags 2>/dev/null) \
 				    -DBUILD_KLP
@@ -65,6 +70,11 @@ OBJTOOL_CFLAGS  := -std=gnu11 -fomit-frame-pointer -O2 -g $(WARNINGS)	\
 
 OBJTOOL_LDFLAGS := $(LIBSUBCMD) $(LIBELF_LIBS) $(LIBXXHASH_LIBS) $(HOSTLDFLAGS)
 
+ifeq ($(BUILD_KLP),y)
+OBJTOOL_CFLAGS += $(LIBDW_CFLAGS)
+OBJTOOL_LDFLAGS += $(LIBDW_LIBS)
+endif
+
 # Allow old libelf to be used:
 elfshdr := $(shell echo '$(pound)include <libelf.h>' | $(HOSTCC) $(OBJTOOL_CFLAGS) -x c -E - 2>/dev/null | grep elf_getshdr)
 OBJTOOL_CFLAGS += $(if $(elfshdr),,-DLIBELF_USE_DEPRECATED)
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index a791f4ea6ec1..2602e6956993 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -9,7 +9,6 @@
 
 #include <sys/types.h>
 #include <sys/stat.h>
-#include <sys/mman.h>
 #include <fcntl.h>
 #include <stdio.h>
 #include <stdlib.h>
@@ -20,7 +19,6 @@
 #include <linux/align.h>
 #include <linux/kernel.h>
 #include <linux/interval_tree_generic.h>
-#include <linux/log2.h>
 #include <objtool/builtin.h>
 #include <objtool/elf.h>
 #include <objtool/klp.h>
@@ -33,13 +31,6 @@ u32 str_hash_demangled(const char *str)
 	return jhash(str, demangled_name_len(str), 0);
 }
 
-#define elf_hash_add(name, node, key)					\
-({									\
-	struct elf_hash_node *__node = node;				\
-	__node->next = __elf_table_entry(elf, name, key);		\
-	__elf_table_entry(elf, name, key) = __node;			\
-})
-
 static inline void __elf_hash_del(struct elf_hash_node *node,
 				  struct elf_hash_node **head)
 {
@@ -61,20 +52,6 @@ static inline void __elf_hash_del(struct elf_hash_node *node,
 #define elf_hash_del(name, node, key) \
 	__elf_hash_del(node, &__elf_table_entry(elf, name, key))
 
-#define elf_alloc_hash(name, size)					\
-({									\
-	__elf_bits(elf, name) = max(10, ilog2(size));			\
-	__elf_table(elf, name) = mmap(NULL,				\
-				 sizeof(struct elf_hash_node *) << __elf_bits(elf, name), \
-				 PROT_READ|PROT_WRITE,			\
-				 MAP_PRIVATE|MAP_ANON, -1, 0);		\
-	if (__elf_table(elf, name) == (void *)-1L) {			\
-		ERROR_GLIBC("mmap fail " #name);			\
-		__elf_table(elf, name) = NULL;				\
-	}								\
-	__elf_table(elf, name);						\
-})
-
 static inline unsigned long __sym_start(struct symbol *s)
 {
 	return s->offset;
@@ -538,13 +515,13 @@ static int elf_add_symbol(struct elf *elf, struct symbol *sym)
 		entry = &sym->sec->symbol_list;
 	list_add(&sym->list, entry);
 
-	sym->demangled_name = demangle_name(sym);
-	if (!sym->demangled_name)
+	sym->identity.demangled_name = demangle_name(sym);
+	if (!sym->identity.demangled_name)
 		return -1;
 
 	list_add_tail(&sym->global_list, &elf->symbols);
 	elf_hash_add(symbol, &sym->hash, sym->idx);
-	elf_hash_add(symbol_name, &sym->name_hash, str_hash(sym->demangled_name));
+	elf_hash_add(symbol_name, &sym->name_hash, str_hash(sym->identity.demangled_name));
 
 	if (is_func_sym(sym) &&
 	    (strstarts(sym->name, "__pfx_") ||
@@ -660,6 +637,10 @@ static int read_symbols(struct elf *elf)
 		if (elf_add_symbol(elf, sym))
 			return -1;
 
+		/*
+		 * FIXME: Assembly inputs without STT_FILE can inherit the preceding
+		 * input's FILE after partial linking.
+		 */
 		if (is_file_sym(sym))
 			file = sym;
 		else if (sym->bind == STB_LOCAL && !is_sec_sym(sym))
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index a82517a76a0f..ef5d74751a9e 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -7,15 +7,18 @@
 #define _OBJTOOL_ELF_H
 
 #include <stdio.h>
+#include <sys/mman.h>
 #include <gelf.h>
 #include <linux/string.h>
 #include <linux/list.h>
 #include <linux/hashtable.h>
+#include <linux/log2.h>
 #include <linux/rbtree.h>
 #include <linux/jhash.h>
 
 #include <objtool/endianness.h>
 #include <objtool/checksum_types.h>
+#include <objtool/klp-identity.h>
 #include <arch/elf.h>
 
 #define SEC_NAME_LEN		1024
@@ -70,9 +73,11 @@ struct symbol {
 	struct rb_node node;
 	struct elf_hash_node hash;
 	struct elf_hash_node name_hash;
+	struct elf_hash_node identity_hash;
 	GElf_Sym sym;
 	struct section *sec;
-	const char *name, *demangled_name;
+	const char *name;
+	struct identity identity;
 	unsigned int idx, len;
 	unsigned long offset;
 	unsigned long __subtree_last;
@@ -125,12 +130,16 @@ struct elf {
 
 	int symbol_bits;
 	int symbol_name_bits;
+	int symbol_identity_bits;
+	int dwarf_address_bits;
 	int section_bits;
 	int section_name_bits;
 	int reloc_bits;
 
 	struct elf_hash_node **symbol_hash;
 	struct elf_hash_node **symbol_name_hash;
+	struct elf_hash_node **symbol_identity_hash;
+	struct elf_hash_node **dwarf_address_hash;
 	struct elf_hash_node **section_hash;
 	struct elf_hash_node **section_name_hash;
 	struct elf_hash_node **reloc_hash;
@@ -145,6 +154,27 @@ struct elf {
 #define __elf_table_entry(elf, name, key) \
 	__elf_table(elf, name)[hash_min(key, __elf_bits(elf, name))]
 
+#define elf_alloc_hash(name, size)					\
+({									\
+	__elf_bits(elf, name) = max(10, ilog2(size));			\
+	__elf_table(elf, name) = mmap(NULL,				\
+				 sizeof(struct elf_hash_node *) << __elf_bits(elf, name), \
+				 PROT_READ|PROT_WRITE,			\
+				 MAP_PRIVATE|MAP_ANON, -1, 0);		\
+	if (__elf_table(elf, name) == (void *)-1L) {			\
+		ERROR_GLIBC("mmap fail " #name);			\
+		__elf_table(elf, name) = NULL;				\
+	}								\
+	__elf_table(elf, name);						\
+})
+
+#define elf_hash_add(name, node, key)					\
+({									\
+	struct elf_hash_node *__node = node;				\
+	__node->next = __elf_table_entry(elf, name, key);		\
+	__elf_table_entry(elf, name, key) = __node;			\
+})
+
 #define elf_list_entry(ptr, type, member)				\
 ({									\
 	typeof(ptr) __ptr = (ptr);					\
@@ -516,7 +546,7 @@ static inline void set_sym_next_reloc(struct reloc *reloc, struct reloc *next)
 #define for_each_sym_by_demangled_name(elf, name, sym)			\
 	elf_hash_for_each_possible(elf, symbol_name, sym, name_hash,	\
 				   str_hash(name))			\
-		if (strcmp(sym->demangled_name, name)) {} else
+		if (strcmp(sym->identity.demangled_name, name)) {} else
 
 #define rsec_next_reloc(rsec, reloc)					\
 	reloc_idx(reloc) < sec_num_entries(rsec) - 1 ? reloc + 1 : NULL
diff --git a/tools/objtool/include/objtool/klp-dwarf.h b/tools/objtool/include/objtool/klp-dwarf.h
new file mode 100644
index 000000000000..566f79f54c63
--- /dev/null
+++ b/tools/objtool/include/objtool/klp-dwarf.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2026 Longjun Luo <luolongjuna@gmail.com>
+ */
+
+#ifndef _OBJTOOL_KLP_DWARF_H
+#define _OBJTOOL_KLP_DWARF_H
+
+struct elf;
+struct symbol;
+
+int init_identity_cache(struct elf *elf);
+
+/*
+ * Set source, scope and external in sym->identity from DWARF.
+ * Return 0 if found, 1 if unavailable, or -1 for invalid/conflicting DWARF.
+ * Returned strings belong to elf and must not be freed by the caller.
+ */
+int get_identity_for_symbol(struct elf *elf, struct symbol *sym);
+
+#endif
diff --git a/tools/objtool/include/objtool/klp-identity.h b/tools/objtool/include/objtool/klp-identity.h
new file mode 100644
index 000000000000..0c7be8cfd49b
--- /dev/null
+++ b/tools/objtool/include/objtool/klp-identity.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2026 Longjun Luo <luolongjuna@gmail.com>
+ */
+
+#ifndef _OBJTOOL_KLP_IDENTITY_H
+#define _OBJTOOL_KLP_IDENTITY_H
+
+#include <linux/types.h>
+
+struct elf;
+
+struct identity {
+	const char *source;		/* physical defining TU path, or "" */
+	const char *scope;		/* slash-delimited enclosing scopes */
+	const char *demangled_name;	/* suffix-stripped symbol name */
+	bool external;
+};
+
+/* The caller must set symbol->dont_correlate before preparing identities. */
+int prepare_identities(struct elf *elf);
+u32 identity_hash(const struct identity *identity);
+bool same_identity(const struct identity *a, const struct identity *b);
+
+#endif
diff --git a/tools/objtool/klp-checksum.c b/tools/objtool/klp-checksum.c
index ebe25f9c5260..1f1b5f068168 100644
--- a/tools/objtool/klp-checksum.c
+++ b/tools/objtool/klp-checksum.c
@@ -98,8 +98,8 @@ static void checksum_update_insn(struct objtool_file *file, struct symbol *func,
 			__checksum_update_insn(func, insn, buf, len);
 
 			if (call_dest) {
-				__checksum_update_insn(func, insn, call_dest->demangled_name,
-						       strlen(call_dest->demangled_name));
+				__checksum_update_insn(func, insn, call_dest->identity.demangled_name,
+						       strlen(call_dest->identity.demangled_name));
 
 			} else if (jump_dest) {
 				struct symbol *dest_sym;
@@ -115,8 +115,8 @@ static void checksum_update_insn(struct objtool_file *file, struct symbol *func,
 				if (!dest_sym)
 					goto alts;
 
-				__checksum_update_insn(func, insn, dest_sym->demangled_name,
-						       strlen(dest_sym->demangled_name));
+				__checksum_update_insn(func, insn, dest_sym->identity.demangled_name,
+						       strlen(dest_sym->identity.demangled_name));
 
 				offset = jump_dest->offset - dest_sym->offset;
 				__checksum_update_insn(func, insn, &offset, sizeof(offset));
@@ -158,8 +158,8 @@ static void checksum_update_insn(struct objtool_file *file, struct symbol *func,
 		offset -= sym->offset;
 	}
 
-	__checksum_update_insn(func, insn, sym->demangled_name,
-			       strlen(sym->demangled_name));
+	__checksum_update_insn(func, insn, sym->identity.demangled_name,
+			       strlen(sym->identity.demangled_name));
 	__checksum_update_insn(func, insn, &offset, sizeof(offset));
 
 alts:
@@ -228,8 +228,8 @@ static void checksum_update_object(struct objtool_file *file, struct symbol *sym
 		}
 
 		__checksum_update_object(sym, sym_offset, "reloc name",
-					 target->demangled_name,
-					 strlen(target->demangled_name));
+					 target->identity.demangled_name,
+					 strlen(target->identity.demangled_name));
 		__checksum_update_object(sym, sym_offset, "reloc addend",
 					 &offset, sizeof(offset));
 	}
diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
index 34da55e45609..957e589b6603 100644
--- a/tools/objtool/klp-diff.c
+++ b/tools/objtool/klp-diff.c
@@ -3,7 +3,6 @@
 #include <subcmd/parse-options.h>
 #include <stdlib.h>
 #include <string.h>
-#include <libgen.h>
 #include <stdio.h>
 #include <ctype.h>
 
@@ -11,6 +10,7 @@
 #include <objtool/warn.h>
 #include <objtool/arch.h>
 #include <objtool/klp.h>
+#include <objtool/klp-identity.h>
 #include <objtool/util.h>
 #include <objtool/special.h>
 
@@ -19,7 +19,7 @@
 #include <linux/livepatch_external.h>
 #include <linux/stringify.h>
 #include <linux/string.h>
-#include <linux/jhash.h>
+#include <linux/hashtable.h>
 
 #define sizeof_field(TYPE, MEMBER) sizeof((((TYPE *)0)->MEMBER))
 
@@ -260,28 +260,6 @@ static int read_sym_checksums(struct elf *elf)
 	return 0;
 }
 
-static struct symbol *first_file_symbol(struct elf *elf)
-{
-	struct symbol *sym;
-
-	for_each_sym(elf, sym) {
-		if (is_file_sym(sym))
-			return sym;
-	}
-
-	return NULL;
-}
-
-static struct symbol *next_file_symbol(struct elf *elf, struct symbol *sym)
-{
-	for_each_sym_continue(elf, sym) {
-		if (is_file_sym(sym))
-			return sym;
-	}
-
-	return NULL;
-}
-
 /*
  * Certain static local variables should never be correlated.  They will be
  * used in place rather than referencing the originals.
@@ -438,6 +416,11 @@ static bool is_anonymous_rodata(struct symbol *sym)
 	       (!is_object_sym(sym) || strstarts(sym->sec->name, ".rodata.cst"));
 }
 
+static bool is_metadata_section(struct section *sec)
+{
+	return !strcmp(sec->name, ".modinfo");
+}
+
 /*
  * These symbols should never be correlated, so their local patched versions
  * are used instead of linking to the originals.
@@ -455,361 +438,157 @@ static bool dont_correlate(struct symbol *sym)
 	       is_anonymous_rodata(sym) ||
 	       is_initcall_sym(sym) ||
 	       is_addressable_sym(sym) ||
+	       is_metadata_section(sym->sec) ||
 	       is_special_section(sym->sec) ||
 	       is_special_section_aux(sym->sec);
 }
 
-static const char *llvm_suffix(const char *name)
+static size_t llvm_name_len(const char *name)
 {
-	return strstr(name, ".llvm.");
-}
+	const char *suffix = strstr(name, ".llvm."), *p;
 
-static bool is_llvm_sym(struct symbol *sym)
-{
-	return llvm_suffix(sym->name);
+	if (!suffix || !isdigit((unsigned char)suffix[6]))
+		return strlen(name);
+	for (p = suffix + 6; isdigit((unsigned char)*p); p++)
+		;
+	return *p ? strlen(name) : (size_t)(suffix - name);
 }
 
-/*
- * Determine if two symbols have compatible source file origins:
- *
- *   - If both symbols are local, only return true if they belong to the same
- *     ELF file symbol.
- *
- *   - If both symbols are global, always return true, as globals don't have
- *     file associations.
- *
- *   - If they have different scopes, also return true, as the patch might have
- *     changed the symbol's scope.
- *
- * Works for both same-ELF (direct pointer compare) and cross-ELF
- * (compare via file->twin) cases.
- */
-static bool maybe_same_file(struct symbol *sym1, struct symbol *sym2)
+/* Keep object-fragment numbers, e.g. amd_northbridges.0. */
+static bool same_llvm_name(const char *a, const char *b)
 {
-	if (!sym1->file || !sym2->file)
-		return true;
-	if (sym1->file == sym2->file)
-		return true;
-	return sym1->file->twin == sym2->file;
+	size_t a_len = llvm_name_len(a), b_len = llvm_name_len(b);
+
+	return a_len == b_len && !strncmp(a, b, a_len);
 }
 
-/*
- * Similar to maybe_same_file(), but strict: no scope changes allowed.
- *
- * Works for both same-ELF (direct pointer compare) and cross-ELF
- * (compare via file->twin) cases.
- */
-static bool same_file(struct symbol *sym1, struct symbol *sym2)
+static const char *skip_lto_priv(const char *name)
 {
-	if (llvm_suffix(sym1->name) && llvm_suffix(sym2->name))
-		return true;
-	if (!sym1->file && !sym2->file)
-		return true;
-	if (!sym1->file || !sym2->file)
-		return false;
-	if (sym1->file == sym2->file)
-		return true;
-	return sym1->file->twin == sym2->file;
+	if (!strstarts(name, ".lto_priv.") || !isdigit((unsigned char)name[10]))
+		return name;
+	name += 10;
+	while (isdigit((unsigned char)*name))
+		name++;
+	return name;
 }
 
-/*
- * Is it a local symbol, or at least was it local in the translation unit
- * before LLVM promoted it?
- */
-static bool is_tu_local_sym(struct symbol *sym)
+static bool is_numeric_suffix(const char *name)
 {
-	return is_local_sym(sym) || is_llvm_sym(sym);
+	if (*name++ != '.' || !isdigit((unsigned char)*name))
+		return false;
+	while (isdigit((unsigned char)*name))
+		name++;
+	return !*name;
 }
 
-/*
- * Try to find sym1's twin in patched using deterministic matching.
- *
- * Multiple symbols can share a demangled name (e.g., static functions in
- * different TUs).  This function counts same-named candidates through a
- * funnel of progressively tighter filters.  Each level is a strict subset
- * of the previous one.
- *
- * The widest level that yields a 1:1 match wins.  Narrower levels are only
- * needed when the wider level is ambiguous (count > 1).
- *
- * Candidates are pre-filtered by maybe_same_file(), which narrows most
- * local symbols to their own TU.  For example, 19 different static
- * type_show() functions across vmlinux.o each see only one candidate after
- * pre-filtering, so they match immediately at Level 1.
- *
- * Level 1 (name): Works when the demangled name is unique after
- * pre-filtering.  Handles most symbols: unique globals like copy_signal(),
- * or per-TU locals like pcspkr_probe().
- *
- * Level 2 (scope): Filters by local-vs-global (TU-local-vs-not).  Example:
- * parse_header() exists as both a static and a global function.  Level 1
- * sees both (same demangled name), but Level 2 separates them by scope.
- *
- * Level 3 (file): Strict file matching via same_file(), which rejects scope
- * changes.  Example: LLVM-promoted foo.llvm.12345 (global, no FILE symbol)
- * vs genuine local foo (has FILE symbol).  Both are TU-local so Level 2
- * can't distinguish them, but same_file() rejects the pair because one has
- * a file association and the other doesn't.
- *
- * Level 4 (checksum): Distinguishes by function checksum.  Example:
- * usb_devnode.llvm.AAA and usb_devnode.llvm.BBB are two LLVM-promoted
- * functions from different TUs with the same demangled name.  After a TU
- * change, the .llvm. hashes change but the functions themselves may be
- * unchanged.  Level 4 matches each to the patched candidate with the
- * same checksum.
- */
-static struct symbol *find_twin(struct elfs *e, struct symbol *sym1)
+/* Allow compiler counters and GCC partition renames to change. */
+static bool same_compiler_name(const char *a, const char *b)
 {
-	struct symbol *name_last = NULL, *scope_last = NULL,
-		      *file_last = NULL, *csum_last = NULL;
-	unsigned int name_orig = 0, name_patched = 0;
-	unsigned int scope_orig = 0, scope_patched = 0;
-	unsigned int file_orig = 0, file_patched = 0;
-	unsigned int csum_orig = 0, csum_patched = 0;
-	struct symbol *sym2, *match = NULL;
-
-	/* Count orig candidates */
-	for_each_sym_by_demangled_name(e->orig, sym1->demangled_name, sym2) {
-		if (sym2->twin || sym1->type != sym2->type || sym2->dont_correlate ||
-		    (!maybe_same_file(sym1, sym2)))
-			continue;
-
-		/* Level 1: name match (widest filter)  */
-		name_orig++;
-
-		/* Level 2: scope (scope changes allowed) */
-		if (is_tu_local_sym(sym1) != is_tu_local_sym(sym2))
-			continue;
-		scope_orig++;
-
-		/* Level 3: file (scope changes disallowed) */
-		if (!same_file(sym1, sym2))
-			continue;
-		file_orig++;
-
-		/* Level 4: checksum (unchanged symbols) */
-		if (sym1->len != sym2->len || !sym1->csum.checksum ||
-		    sym1->csum.checksum != sym2->csum.checksum)
-			continue;
-		csum_orig++;
-	}
-
-	/* Count patched candidates */
-	for_each_sym_by_demangled_name(e->patched, sym1->demangled_name, sym2) {
-		if (sym2->twin || sym1->type != sym2->type || sym2->dont_correlate ||
-		    !maybe_same_file(sym1, sym2))
-			continue;
-
-		/* Level 1 */
-		name_patched++;
-		name_last = sym2;
-
-		/* Level 2 */
-		if (is_tu_local_sym(sym1) != is_tu_local_sym(sym2))
-			continue;
-		scope_patched++;
-		scope_last = sym2;
+	for (;;) {
+		const char *next_a = skip_lto_priv(a), *next_b = skip_lto_priv(b);
 
-		/* Level 3 */
-		if (!same_file(sym1, sym2))
+		if (next_a != a || next_b != b) {
+			a = next_a;
+			b = next_b;
 			continue;
-		file_patched++;
-		file_last = sym2;
-
-		/* Level 4 */
-		if (sym1->len != sym2->len || !sym1->csum.checksum ||
-		    sym1->csum.checksum != sym2->csum.checksum)
-			continue;
-		csum_patched++;
-		csum_last = sym2;
+		}
+		if (*a != *b)
+			break;
+		if (!*a)
+			return true;
+		if (*a == '.' && isdigit((unsigned char)a[1])) {
+			if (!isdigit((unsigned char)b[1]))
+				return false;
+			for (a++; isdigit((unsigned char)*a); a++)
+				;
+			for (b++; isdigit((unsigned char)*b); b++)
+				;
+		} else {
+			a++;
+			b++;
+		}
 	}
 
-	/* Return the widest level that yields a unique (1:1) match */
-	if (name_orig == 1 && name_patched == 1)
-		match = name_last;
-	else if (scope_orig == 1 && scope_patched == 1)
-		match = scope_last;
-	else if (file_orig == 1 && file_patched == 1)
-		match = file_last;
-	else if (csum_orig == 1 && csum_patched == 1)
-		match = csum_last;
-
-	if (!match)
-		return NULL;
-
-	if (name_orig != 1 || name_patched != 1)
-		dbg_correlate("find_twin(): %s%s -> %s%s",
-			      sym1->name, is_func_sym(sym1) ? "()" : "",
-			      match->name, is_func_sym(match) ? "()" : "");
-
-	return match;
+	/* A trailing counter may be absent on one side. */
+	return (!*a && is_numeric_suffix(b)) || (!*b && is_numeric_suffix(a));
 }
 
-struct llvm_suffix_pair {
-	struct hlist_node hash;
-	const char *orig;
-	const char *patched;
-};
-
-static DECLARE_HASHTABLE(suffix_map, 7);
-
-/*
- * Build a mapping of known orig-to-patched LLVM suffixes based on
- * already-correlated symbol pairs.  All promoted symbols from the same TU
- * share the same .llvm.<hash> suffix, so one correlated pair seeds the map
- * for the entire TU.
- */
-static int update_suffix_map(struct elf *elf)
+/* Keep clone tags such as .cold, .isra and .part distinct. */
+static bool compatible_symbol_name(const char *a, const char *b)
 {
-	struct llvm_suffix_pair *entry;
-	struct symbol *sym;
-
-	for_each_sym(elf, sym) {
-		const char *s1, *s2;
-		bool found;
-
-		if (!sym->twin)
-			continue;
+	if (same_llvm_name(a, b))
+		return true;
+	if (strchr(a, '@') || strchr(b, '@') || strstr(a, ".str1."))
+		return !strcmp(a, b);
+	return same_compiler_name(a, b);
+}
 
-		s1 = llvm_suffix(sym->name);
-		s2 = llvm_suffix(sym->twin->name);
+static bool is_twin_candidate(struct symbol *sym1, struct symbol *sym2)
+{
+	if (sym1->type != sym2->type || !same_identity(&sym1->identity, &sym2->identity))
+		return false;
+	/* Don't match zero-length labels with sized symbols. */
+	if (!is_undef_sym(sym1) && !is_undef_sym(sym2) &&
+	    (!sym1->len != !sym2->len))
+		return false;
+	return compatible_symbol_name(sym1->name, sym2->name);
+}
 
-		if (!s1 || !s2)
-			continue;
+static struct symbol *find_twin(struct elf *elf, struct symbol *sym1)
+{
+	struct symbol *sym2, *match = NULL;
+	unsigned int candidates = 0;
+	u32 key = identity_hash(&sym1->identity);
 
-		found = false;
-		hash_for_each_possible(suffix_map, entry, hash, str_hash(s1)) {
-			if (!strcmp(entry->orig, s1)) {
-				found = true;
-				break;
-			}
-		}
-		if (found)
+	elf_hash_for_each_possible(elf, symbol_identity, sym2, identity_hash, key) {
+		if (sym2->twin || !is_twin_candidate(sym1, sym2))
 			continue;
-
-		entry = calloc(1, sizeof(*entry));
-		if (!entry) {
-			ERROR_GLIBC("calloc");
-			return -1;
-		}
-
-		entry->orig = s1;
-		entry->patched = s2;
-		hash_add(suffix_map, &entry->hash, str_hash(s1));
+		match = sym2;
+		candidates++;
 	}
 
-	return 0;
+	return candidates == 1 ? match : NULL;
 }
 
-/*
- * Match by translating the symbol's .llvm.<hash> suffix through the suffix
- * map to find the corresponding hash suffix for the patched object.
- *
- * Example: In the original kernel, TU drivers/base/core.c contains
- * foo.llvm.12345 and bar.llvm.12345 (same TU, same hash).  After patching,
- * they become foo.llvm.67890 and bar.llvm.67890.  If foo was already
- * correlated by find_twin() (e.g., unique by name), the suffix map records
- * .llvm.12345 -> .llvm.67890.  When processing bar.llvm.12345, this
- * function looks up .llvm.12345, gets .llvm.67890, constructs the name
- * bar.llvm.67890, and finds the match.
- */
-static struct symbol *find_twin_suffixed(struct elf *elf, struct symbol *sym1)
+/* Checksums can disambiguate only unchanged symbols. */
+static struct symbol *find_twin_checksum(struct elf *elf, struct symbol *sym1)
 {
-	const char *suffix, *patched_suffix = NULL;
 	struct symbol *sym2, *match = NULL;
-	char name[SYM_NAME_LEN];
-	struct llvm_suffix_pair *entry;
-	int count = 0;
+	unsigned int candidates = 0;
+	u32 key = identity_hash(&sym1->identity);
 
-	suffix = llvm_suffix(sym1->name);
-	if (!suffix)
+	if (!sym1->csum.checksum)
 		return NULL;
 
-	hash_for_each_possible(suffix_map, entry, hash, str_hash(suffix)) {
-		if (!strcmp(entry->orig, suffix)) {
-			patched_suffix = entry->patched;
-			break;
-		}
-	}
-	if (!patched_suffix)
-		return NULL;
-
-	if (snprintf_check(name, SYM_NAME_LEN, "%s%s",
-			   sym1->demangled_name, patched_suffix))
-		return NULL;
-
-	for_each_sym_by_name(elf, name, sym2) {
-		if (sym2->twin || sym1->type != sym2->type || sym2->dont_correlate)
+	elf_hash_for_each_possible(elf, symbol_identity, sym2, identity_hash, key) {
+		if (!is_twin_candidate(sym1, sym2))
+			continue;
+		if (sym2->twin || sym1->len != sym2->len ||
+		    sym1->csum.checksum != sym2->csum.checksum)
 			continue;
-		count++;
 		match = sym2;
+		candidates++;
 	}
 
-	if (count != 1)
-		return NULL;
-
-	dbg_correlate("find_suffixed_twin(): %s%s -> %s%s",
-		      sym1->name, is_func_sym(sym1) ? "()" : "",
-		      match->name, is_func_sym(match) ? "()" : "");
-
-	return match;
+	return candidates == 1 ? match : NULL;
 }
 
-/*
- * Last-resort positional matching.
- *
- * Finds a symbol with the same position in the symbol table among
- * same-demangled-name candidates, similar to livepatch sympos.  Note that
- * LLVM-promoted symbols are globals, which come after locals in the symbol
- * table, so we have to be careful not to compare different scopes.
- *
- * Example: arch/x86/events/intel/core.c defines many __quirk variables via
- * X86_MATCH_*() macros.  In the symbol table they appear as __quirk.90,
- * __quirk.97, __quirk.101, etc., all with demangled name __quirk, same
- * scope, and same FILE symbol.  No deterministic filter can distinguish
- * them, so they're matched by position: the 1st __quirk in orig matches the
- * 1st in patched, the 2nd matches the 2nd, etc.
- *
- * This is less deterministic than the other strategies, so it's done last.
- */
-static struct symbol *find_twin_positional(struct elfs *e, struct symbol *sym1)
+static void correlate_pass(struct elfs *e,
+			   struct symbol *(*find)(struct elf *, struct symbol *))
 {
-	unsigned int idx_orig = 0, idx_patched = 0;
-	unsigned int sym1_pos = 0;
-	struct symbol *sym2, *match = NULL;
-
-	for_each_sym_by_demangled_name(e->orig, sym1->demangled_name, sym2) {
-		if (sym2->twin || sym1->type != sym2->type || sym2->dont_correlate ||
-		    !maybe_same_file(sym1, sym2))
-			continue;
-		if (is_tu_local_sym(sym1) != is_tu_local_sym(sym2) ||
-		    is_llvm_sym(sym1) != is_llvm_sym(sym2))
-			continue;
-		if (sym1 == sym2)
-			sym1_pos = idx_orig;
-		idx_orig++;
-	}
+	struct symbol *sym, *match;
 
-	for_each_sym_by_demangled_name(e->patched, sym1->demangled_name, sym2) {
-		if (sym2->twin || sym1->type != sym2->type || sym2->dont_correlate ||
-		    !maybe_same_file(sym1, sym2))
+	for_each_sym(e->orig, sym) {
+		if (sym->twin || sym->dont_correlate)
 			continue;
-		if (is_tu_local_sym(sym1) != is_tu_local_sym(sym2) ||
-		    is_llvm_sym(sym1) != is_llvm_sym(sym2))
+		match = find(e->patched, sym);
+		/* Two originals can share the same sole patched candidate. */
+		if (!match || find(e->orig, match) != sym)
 			continue;
-		if (idx_patched == sym1_pos)
-			match = sym2;
-		idx_patched++;
+		sym->twin = match;
+		match->twin = sym;
+		dbg_correlate("%s(): %s -> %s", __func__, sym->name, match->name);
 	}
-
-	if (idx_orig != idx_patched)
-		return NULL;
-
-	dbg_correlate("find_twin_positional(): %s%s -> %s%s",
-	    sym1->name, is_func_sym(sym1) ? "()" : "",
-	    match->name, is_func_sym(match) ? "()" : "");
-
-	return match;
 }
 
 /*
@@ -819,96 +598,55 @@ static struct symbol *find_twin_positional(struct elfs *e, struct symbol *sym1)
  */
 static int correlate_symbols(struct elfs *e)
 {
-	struct symbol *file1_sym, *file2_sym;
-	struct symbol *sym1, *sym2;
-	bool progress;
-
-	for_each_sym(e->orig, sym1)
-		sym1->dont_correlate = dont_correlate(sym1);
-	for_each_sym(e->patched, sym2)
-		sym2->dont_correlate = dont_correlate(sym2);
-
-	/* Correlate FILE symbols */
-	file1_sym = first_file_symbol(e->orig);
-	file2_sym = first_file_symbol(e->patched);
+	struct symbol *sym;
 
-	for (; ; file1_sym = next_file_symbol(e->orig, file1_sym),
-		 file2_sym = next_file_symbol(e->patched, file2_sym)) {
+	for_each_sym(e->orig, sym)
+		sym->dont_correlate = dont_correlate(sym);
+	for_each_sym(e->patched, sym)
+		sym->dont_correlate = dont_correlate(sym);
 
-		if (!file1_sym && file2_sym) {
-			ERROR("FILE symbol mismatch: NULL != %s", file2_sym->name);
-			return -1;
-		}
+	if (prepare_identities(e->orig) || prepare_identities(e->patched))
+		return -1;
 
-		if (file1_sym && !file2_sym) {
-			ERROR("FILE symbol mismatch: %s != NULL", file1_sym->name);
-			return -1;
-		}
+	correlate_pass(e, find_twin);
+	correlate_pass(e, find_twin_checksum);
 
-		if (!file1_sym)
-			break;
+	for_each_sym(e->orig, sym)
+		if (!sym->twin && !sym->dont_correlate)
+			WARN("no correlation: %s", sym->name);
 
-		if (strcmp(file1_sym->name, file2_sym->name)) {
-			ERROR("FILE symbol mismatch: %s != %s", file1_sym->name, file2_sym->name);
-			return -1;
-		}
+	return 0;
+}
 
-		file1_sym->twin = file2_sym;
-		file2_sym->twin = file1_sym;
-	}
+static int check_linkage_changes(struct elfs *e)
+{
+	struct symbol *orig_sym, *patched_sym;
 
+	for_each_sym(e->orig, orig_sym) {
+		if (orig_sym->twin || orig_sym->dont_correlate ||
+		    is_undef_sym(orig_sym) || !orig_sym->len)
+			continue;
 
-	/*
-	 * Correlate in two phases: loop deterministic levels until no more
-	 * progress, then use positional fallback for the rest.  This prevents
-	 * the nondeterministic positional matching from stealing symbols that
-	 * have deterministic matches.
-	 */
-	hash_init(suffix_map);
-	do {
-		progress = false;
-		for_each_sym(e->orig, sym1) {
-			if (sym1->twin || sym1->dont_correlate)
+		/*
+		 * Identities distinguish linkage changes, but later name-based
+		 * resolution can bind references to the wrong state. Reject them.
+		 */
+		for_each_sym_by_demangled_name(e->patched, orig_sym->identity.demangled_name,
+					       patched_sym) {
+			if (patched_sym->twin || patched_sym->dont_correlate ||
+			    is_undef_sym(patched_sym) || !patched_sym->len)
 				continue;
-			sym2 = find_twin(e, sym1);
-			if (!sym2)
+			if (orig_sym->type != patched_sym->type ||
+			    strcmp(orig_sym->identity.scope, patched_sym->identity.scope) ||
+			    orig_sym->identity.external == patched_sym->identity.external)
 				continue;
-			sym1->twin = sym2;
-			sym2->twin = sym1;
-			progress = true;
-		}
-
-		if (update_suffix_map(e->orig))
+			ERROR("unsupported linkage change (%s, %s): original %s symtab[%u] (external=%d), patched %s symtab[%u] (external=%d)",
+			      orig_sym->identity.scope, orig_sym->identity.demangled_name,
+			      orig_sym->name, orig_sym->idx, orig_sym->identity.external,
+			      patched_sym->name, patched_sym->idx, patched_sym->identity.external);
 			return -1;
-
-		for_each_sym(e->orig, sym1) {
-			if (sym1->twin || sym1->dont_correlate)
-				continue;
-			sym2 = find_twin_suffixed(e->patched, sym1);
-			if (!sym2)
-				continue;
-			sym1->twin = sym2;
-			sym2->twin = sym1;
-			progress = true;
 		}
-	} while (progress);
-
-	for_each_sym(e->orig, sym1) {
-		if (sym1->twin || sym1->dont_correlate)
-			continue;
-		sym2 = find_twin_positional(e, sym1);
-		if (!sym2)
-			continue;
-		sym1->twin = sym2;
-		sym2->twin = sym1;
-	}
-
-	for_each_sym(e->orig, sym1) {
-		if (sym1->twin || sym1->dont_correlate)
-			continue;
-		WARN("no correlation: %s", sym1->name);
 	}
-
 	return 0;
 }
 
@@ -1079,7 +817,8 @@ static int mark_changed_functions(struct elfs *e)
 
 	/* Find added functions and print them */
 	for_each_sym(e->patched, patched_sym) {
-		if (!is_func_sym(patched_sym) || patched_sym->dont_correlate)
+		if (!is_func_sym(patched_sym) || patched_sym->dont_correlate ||
+		    is_undef_sym(patched_sym))
 			continue;
 
 		if (!patched_sym->twin) {
@@ -1206,6 +945,9 @@ static bool klp_reloc_needed(struct reloc *patched_reloc)
 		 * patch.  The symbol could be defined in this .o or in another
 		 * .o in the patch module.
 		 *
+		 * FIXME: Failed correlation can duplicate existing data, breaking
+		 * shared state or pointer identity.
+		 *
 		 * This check needs to be *after* the export check due to the
 		 * possibility of the patch adding a new UNDEF reference to an
 		 * exported symbol.
@@ -2254,6 +1996,9 @@ int cmd_klp_diff(int argc, const char **argv)
 	if (correlate_symbols(&e))
 		return -1;
 
+	if (check_linkage_changes(&e))
+		return -1;
+
 	ret = mark_changed_functions(&e);
 	if (ret < 0)
 		return -1;
diff --git a/tools/objtool/klp-dwarf.c b/tools/objtool/klp-dwarf.c
new file mode 100644
index 000000000000..eff054f2864b
--- /dev/null
+++ b/tools/objtool/klp-dwarf.c
@@ -0,0 +1,778 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 Longjun Luo <luolongjuna@gmail.com>
+ *
+ * Compute DWARF identity information for ELF symbols by walking the DIE
+ * tree and following abstract_origin/specification references.
+ *
+ *   - source: physical translation unit (CU) of the definition/origin
+ *   - scope: slash-delimited chain of named enclosing scopes
+ */
+#define _GNU_SOURCE
+#include <ctype.h>
+#include <dwarf.h>
+#include <elfutils/libdwfl.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include <linux/list.h>
+
+#include <objtool/elf.h>
+#include <objtool/klp-dwarf.h>
+#include <objtool/warn.h>
+
+#define IDENTITY_HASH_BITS 18
+#define IDENTITY_MAX_DEPTH 256
+
+struct identity_cu {
+	struct list_head list;
+	char *path;
+};
+
+struct identity_die {
+	struct hlist_node hash;
+	Dwarf_Die die;
+	struct identity_cu *cu;
+	struct identity_die *parent, *definition;
+	void *abstract_origin, *specification;
+	const char *name;
+	char *scope;
+	bool declaration;
+};
+
+struct address_identity {
+	struct elf_hash_node hash;
+	unsigned int section;
+	unsigned long offset;
+	char *source, *scope, *name;
+	bool external;
+};
+
+struct identity_reader {
+	struct elf *elf;
+	Dwfl_Module *module;
+	Dwarf *dwarf;
+	Dwarf_Addr bias;
+	struct list_head cus;
+	DECLARE_HASHTABLE(dies, IDENTITY_HASH_BITS);
+};
+
+static int die_error(Dwarf_Die *die, const char *message)
+{
+	ERROR("DWARF identity: DIE %#llx: %s", (unsigned long long)dwarf_dieoffset(die), message);
+	return -1;
+}
+
+static bool is_unit(int tag)
+{
+	return tag == DW_TAG_compile_unit || tag == DW_TAG_partial_unit || tag == DW_TAG_type_unit;
+}
+
+static bool is_symbol(int tag)
+{
+	return tag == DW_TAG_subprogram || tag == DW_TAG_variable || tag == DW_TAG_constant;
+}
+
+static bool is_scope(Dwarf_Die *die)
+{
+	int tag = dwarf_tag(die);
+
+	return is_unit(tag) || is_symbol(tag) || tag == DW_TAG_lexical_block ||
+	       tag == DW_TAG_namespace || tag == DW_TAG_class_type ||
+	       tag == DW_TAG_structure_type || tag == DW_TAG_union_type ||
+	       tag == DW_TAG_module ||
+	       (tag == DW_TAG_member && dwarf_hasattr(die, DW_AT_declaration));
+}
+
+static struct identity_die *find_die(struct identity_reader *reader, void *address)
+{
+	struct identity_die *entry;
+
+	hash_for_each_possible(reader->dies, entry, hash, (unsigned long)address)
+		if (entry->die.addr == address)
+			return entry;
+	return NULL;
+}
+
+/* Normalize source paths for identity comparison without filesystem access. */
+static void normalize_source(char *path)
+{
+	char *root = path + (*path == '/');
+	char *read = root, *write = root, *part, *previous;
+	size_t len;
+
+	while ((part = strsep(&read, "/"))) {
+		if (!*part || !strcmp(part, "."))
+			continue;
+		if (!strcmp(part, "..")) {
+			previous = write;
+			while (previous > root && previous[-1] != '/')
+				previous--;
+			if (previous < write &&
+			    !(write - previous == 2 && !memcmp(previous, "..", 2))) {
+				write = previous > root ? previous - 1 : root;
+				continue;
+			}
+			if (root != path)
+				continue;
+		}
+		len = strlen(part);
+		if (write > root)
+			*write++ = '/';
+		memmove(write, part, len);
+		write += len;
+	}
+	*write = '\0';
+}
+
+static int read_unit_source(struct identity_cu *cu, Dwarf_Die *die)
+{
+	Dwarf_Attribute attr;
+	const char *name = NULL, *dir = NULL;
+	char *path;
+
+	if (dwarf_tag(die) != DW_TAG_compile_unit)
+		return 0;
+	if (dwarf_attr(die, DW_AT_name, &attr)) {
+		name = dwarf_formstring(&attr);
+		if (!name)
+			return die_error(die, "invalid compilation unit name");
+	}
+	if (dwarf_attr(die, DW_AT_comp_dir, &attr)) {
+		dir = dwarf_formstring(&attr);
+		if (!dir)
+			return die_error(die, "invalid compilation directory");
+	}
+	if (!name || !*name || (*name != '/' && !dir))
+		return 0;
+	if (*name == '/')
+		path = strdup(name);
+	else if (asprintf(&path, "%s/%s", dir, name) < 0)
+		return -1;
+	if (!path)
+		return -1;
+	normalize_source(path);
+	cu->path = path;
+	return 0;
+}
+
+static int read_reference(struct identity_reader *reader, Dwarf_Die *die,
+			  unsigned int attribute, void **address)
+{
+	Dwarf_Attribute attr;
+	Dwarf_Die reference;
+
+	if (!dwarf_attr(die, attribute, &attr))
+		return 0;
+	if (!dwarf_formref_die(&attr, &reference))
+		return die_error(die, "invalid declaration reference");
+	if (dwarf_cu_getdwarf(reference.cu) != reader->dwarf)
+		return die_error(die, "references to supplementary DWARF files are unsupported");
+	*address = reference.addr;
+	return 0;
+}
+
+static int read_attributes(struct identity_reader *reader, struct identity_die *entry)
+{
+	Dwarf_Die *die = &entry->die;
+	Dwarf_Attribute attr;
+	int tag = dwarf_tag(die);
+
+	if (dwarf_attr(die, DW_AT_name, &attr)) {
+		entry->name = dwarf_formstring(&attr);
+		if (!entry->name || (!is_unit(tag) && strchr(entry->name, '/')))
+			return die_error(die, "invalid or unsupported scope name");
+	}
+	if (!is_symbol(tag) && tag != DW_TAG_member)
+		return 0;
+	if (dwarf_attr(die, DW_AT_declaration, &attr)) {
+		if (dwarf_formflag(&attr, &entry->declaration))
+			return die_error(die, "invalid declaration flag");
+		if (entry->declaration &&
+		    (dwarf_hasattr(die, DW_AT_location) || dwarf_hasattr(die, DW_AT_low_pc)))
+			return die_error(die, "declaration has a concrete address");
+	}
+	if (tag == DW_TAG_member)
+		return 0;
+	if (read_reference(reader, die, DW_AT_abstract_origin, &entry->abstract_origin) ||
+	    read_reference(reader, die, DW_AT_specification, &entry->specification))
+		return -1;
+	if (entry->abstract_origin && entry->specification)
+		return die_error(die, "both origin and specification are unsupported");
+	return 0;
+}
+
+static int scan_attribute(Dwarf_Attribute *attr, void *unused)
+{
+	return DWARF_CB_OK;
+}
+
+static int index_dies(struct identity_reader *reader, struct identity_cu *cu,
+		      Dwarf_Die *die, struct identity_die *parent, unsigned int depth)
+{
+	struct identity_die *entry;
+	Dwarf_Die child;
+	int ret;
+
+	if (!dwarf_tag(die) || dwarf_getattrs(die, scan_attribute, NULL, 0) < 0)
+		return die_error(die, "invalid DIE attributes");
+	if (depth > IDENTITY_MAX_DEPTH)
+		return die_error(die, "DIE nesting exceeds the supported depth");
+	if (is_scope(die)) {
+		entry = calloc(1, sizeof(*entry));
+		if (!entry)
+			return -1;
+		entry->die = *die;
+		entry->cu = cu;
+		entry->parent = parent;
+		hash_add(reader->dies, &entry->hash, (unsigned long)die->addr);
+		if (read_attributes(reader, entry))
+			return -1;
+		if (dwarf_tag(die) != DW_TAG_member)
+			parent = entry;
+	}
+	ret = dwarf_child(die, &child);
+	if (ret)
+		return ret < 0 ? die_error(die, "cannot read child") : 0;
+	do {
+		if (index_dies(reader, cu, &child, parent, depth + 1))
+			return -1;
+		ret = dwarf_siblingof(&child, &child);
+	} while (!ret);
+	return ret < 0 ? die_error(die, "cannot read sibling") : 0;
+}
+
+static struct identity_cu *read_cu(struct identity_reader *reader, Dwarf_Die *die)
+{
+	struct identity_die *entry;
+	struct identity_cu *cu;
+	Dwarf_Die root;
+
+	if (!dwarf_diecu(die, &root, NULL, NULL) || !is_unit(dwarf_tag(&root)))
+		return NULL;
+	entry = find_die(reader, root.addr);
+	if (entry)
+		return entry->cu;
+	cu = calloc(1, sizeof(*cu));
+	if (!cu)
+		return NULL;
+	list_add_tail(&cu->list, &reader->cus);
+	if (read_unit_source(cu, &root) || index_dies(reader, cu, &root, NULL, 0))
+		return NULL;
+	return cu;
+}
+
+/* Follow abstract_origin/specification chains to find the name and defining DIE. */
+static int resolve_definition(struct identity_reader *reader, struct identity_die *entry)
+{
+	struct identity_die *cur = entry, *definition = NULL;
+	const char *name = NULL;
+	unsigned int depth = 0;
+	void *reference;
+
+	while (cur) {
+		if (++depth > IDENTITY_MAX_DEPTH)
+			return die_error(&entry->die,
+					 "declaration lookup exceeds the supported depth");
+		if (cur->name) {
+			if (name && strcmp(name, cur->name))
+				return die_error(&entry->die,
+						 "conflicting names in declaration chain");
+			name = cur->name;
+		}
+		if (!cur->declaration && !cur->abstract_origin) {
+			if (definition)
+				return die_error(&entry->die,
+						 "multiple definitions in declaration chain");
+			definition = cur;
+		}
+		reference = cur->abstract_origin ?: cur->specification;
+		if (!reference)
+			break;
+		cur = find_die(reader, reference);
+		if (!cur)
+			return die_error(&entry->die, "unavailable declaration reference");
+	}
+	entry->definition = definition;
+	entry->name = name;
+	return 0;
+}
+
+/*
+ * Build the slash-delimited scope string from enclosing named parents.
+ *
+ * FIXME: Unnamed lexical scopes are not distinguished. Reject ambiguous
+ * local statics rather than relying on compiler-generated suffixes.
+ */
+static int resolve_parent_scope(struct identity_die *entry, unsigned int depth)
+{
+	struct identity_die *parent = entry->parent;
+	int tag;
+
+	if (entry->scope)
+		return 0;
+	if (depth > IDENTITY_MAX_DEPTH)
+		return die_error(&entry->die, "scope lookup exceeds the supported depth");
+	if (!parent || is_unit(dwarf_tag(&parent->die))) {
+		entry->scope = strdup("/");
+	} else {
+		if (resolve_parent_scope(parent, depth + 1))
+			return -1;
+		tag = dwarf_tag(&parent->die);
+		if (parent->name && tag != DW_TAG_lexical_block) {
+			if (asprintf(&entry->scope, "%s%s/", parent->scope, parent->name) < 0)
+				return -1;
+		} else {
+			entry->scope = strdup(parent->scope);
+		}
+	}
+	return entry->scope ? 0 : -1;
+}
+
+/* If completed by a DW_AT_specification, use the declaration's enclosing scope. */
+static int resolve_definition_scope(struct identity_reader *reader, struct identity_die *entry,
+				    const char **scope)
+{
+	struct identity_die *start = entry->definition;
+
+	if (start->specification) {
+		start = find_die(reader, start->specification);
+		if (!start)
+			return die_error(&entry->die, "unavailable declaration scope");
+	}
+	if (resolve_parent_scope(start, 0))
+		return -1;
+	*scope = start->scope;
+	return 0;
+}
+
+static const char *resolve_definition_source(struct identity_die *entry)
+{
+	return entry->definition->cu->path;
+}
+
+/* Translate libdwfl's relocated address back to objtool's section/offset pair. */
+static int address_section(struct identity_reader *reader, Dwarf_Addr *address,
+			   unsigned int *section)
+{
+	struct elf *elf = reader->elf;
+	struct section *sec;
+	Dwarf_Addr absolute = *address, bias;
+	GElf_Shdr sh;
+	Elf *file;
+	GElf_Word index;
+	size_t nr, i;
+	int base;
+
+	base = dwfl_module_relocate_address(reader->module, address);
+	if (base < 0)
+		return 1;
+	if (!dwfl_module_relocation_info(reader->module, base, &index))
+		return -1;
+	if (sec_size(&elf->section_data[index])) {
+		*section = index;
+		return 0;
+	}
+	/* Empty sections can share the following nonempty section's synthetic address. */
+	file = dwfl_module_getelf(reader->module, &bias);
+	if (!file || elf_getshdrnum(file, &nr))
+		return -1;
+	for (i = 1; i <= nr; i++) {
+		sec = &elf->section_data[(index + i) % nr];
+		if (!(sec->sh.sh_flags & SHF_ALLOC) || !sec_size(sec))
+			continue;
+		if (!gelf_getshdr(elf_getscn(file, sec->idx), &sh))
+			return -1;
+		if (absolute >= sh.sh_addr + bias && absolute - sh.sh_addr - bias < sh.sh_size) {
+			*section = sec->idx;
+			*address = absolute - sh.sh_addr - bias;
+			return 0;
+		}
+	}
+	return 1;
+}
+
+static int add_address(struct identity_reader *reader, Dwarf_Addr address,
+		       const char *source, const char *scope, const char *name, bool external)
+{
+	struct elf *elf = reader->elf;
+	struct address_identity *entry;
+	Dwarf_Addr offset = address;
+	unsigned int section;
+	int ret = address_section(reader, &offset, &section);
+
+	if (ret)
+		return ret < 0 ? -1 : 0;
+	entry = calloc(1, sizeof(*entry));
+	if (!entry)
+		return -1;
+	entry->section = section;
+	entry->offset = offset;
+	entry->external = external;
+	entry->scope = scope ? strdup(scope) : NULL;
+	entry->source = source ? strdup(source) : NULL;
+	entry->name = name ? strdup(name) : NULL;
+	if ((scope && !entry->scope) || (source && !entry->source) ||
+	    (name && !entry->name))
+		return -1;
+	elf_hash_add(dwarf_address, &entry->hash, offset ^ section);
+	return 0;
+}
+
+/*
+ * The empty features[] in virtio_input.c can share an address with the
+ * nonempty features[] in trans_virtio.c. Exclude the empty object's DIE
+ * from address lookup. libdw rejects GCC's upper_bound=-1 encoding, so
+ * check array bounds too.
+ */
+static bool is_empty_type(Dwarf_Die *type)
+{
+	Dwarf_Die array, range;
+	Dwarf_Attribute attr;
+	Dwarf_Word size;
+	Dwarf_Sword lower, upper;
+
+	if (!dwarf_aggregate_size(type, &size))
+		return !size;
+	if (dwarf_peel_type(type, &array) || dwarf_tag(&array) != DW_TAG_array_type ||
+	    dwarf_child(&array, &range))
+		return false;
+	do {
+		if (dwarf_tag(&range) != DW_TAG_subrange_type)
+			continue;
+		if (dwarf_attr(&range, DW_AT_count, &attr) &&
+		    !dwarf_formudata(&attr, &size) && !size)
+			return true;
+		lower = 0;
+		if (dwarf_attr(&range, DW_AT_lower_bound, &attr) &&
+		    dwarf_formsdata(&attr, &lower))
+			continue;
+		if (dwarf_attr(&range, DW_AT_upper_bound, &attr) &&
+		    !dwarf_formsdata(&attr, &upper) && upper < lower)
+			return true;
+	} while (!dwarf_siblingof(&range, &range));
+	return false;
+}
+
+static int collect_addresses(struct identity_reader *reader, struct identity_die *entry)
+{
+	Dwarf_Die *die = &entry->die, type;
+	Dwarf_Attribute attr, address_attr;
+	Dwarf_Addr base, start, end, address;
+	Dwarf_Op *ops;
+	const char *source, *scope;
+	size_t count;
+	ptrdiff_t off = 0;
+	bool external = false;
+	int tag = dwarf_tag(die);
+
+	if (!entry->definition || (tag != DW_TAG_subprogram && tag != DW_TAG_variable))
+		return 0;
+	if (dwarf_attr_integrate(die, DW_AT_external, &attr) && dwarf_formflag(&attr, &external))
+		return die_error(die, "invalid external flag");
+	/*
+	 * External identities do not need source. DWARF relocations for overridden
+	 * weak definitions can bind to the selected strong definition, giving the
+	 * same address conflicting source CUs (GDB PR 34741):
+	 * https://sourceware.org/bugzilla/show_bug.cgi?id=34741
+	 */
+	source = external ? NULL : resolve_definition_source(entry);
+	if (tag == DW_TAG_subprogram) {
+		if (!dwarf_hasattr(die, DW_AT_low_pc) && !dwarf_hasattr(die, DW_AT_ranges))
+			return 0;
+		if (resolve_definition_scope(reader, entry, &scope))
+			return -1;
+		while ((off = dwarf_ranges(die, off, &base, &start, &end)) > 0)
+			if (start != end && add_address(reader, start + reader->bias,
+							source, scope, entry->name, external))
+				return -1;
+		return off < 0 ? die_error(die, "invalid code ranges") : 0;
+	}
+	if (!dwarf_attr(die, DW_AT_location, &attr))
+		return 0;
+	/* Location lists may vary with the PC; index only fixed storage. */
+	if (dwarf_whatform(&attr) == DW_FORM_sec_offset ||
+	    dwarf_whatform(&attr) == DW_FORM_loclistx)
+		return 0;
+	if (dwarf_getlocation(&attr, &ops, &count))
+		return die_error(die, "invalid location expression");
+	if (!count)
+		return 0;
+	if (dwarf_attr_integrate(die, DW_AT_type, &address_attr)) {
+		if (!dwarf_formref_die(&address_attr, &type))
+			return die_error(die, "invalid variable type reference");
+		if (is_empty_type(&type))
+			return 0;
+	}
+	if (resolve_definition_scope(reader, entry, &scope))
+		return -1;
+	if (ops[0].atom == DW_OP_addr) {
+		address = ops[0].number;
+	} else if (ops[0].atom == DW_OP_addrx || ops[0].atom == DW_OP_GNU_addr_index) {
+		if (dwarf_getlocation_attr(&attr, ops, &address_attr) ||
+		    dwarf_formaddr(&address_attr, &address))
+			return die_error(die, "invalid location address");
+	} else {
+		return 0;
+	}
+	return add_address(reader, address + reader->bias, source,
+			   count == 1 ? scope : NULL, entry->name, external);
+}
+
+/*
+ * libdwfl permits partial relocation, leaving unapplied entries in place.
+ * Check only sections read for identities; unused indexes may retain relocations.
+ */
+static int check_relocations(Dwarf *dwarf)
+{
+	static const char * const sections[] = {
+		".debug_info", ".debug_types", ".debug_abbrev",
+		".debug_str", ".debug_line_str", ".debug_str_offsets",
+		".debug_addr", ".debug_ranges", ".debug_rnglists",
+	};
+	Elf *elf = dwarf_getelf(dwarf);
+	Elf_Scn *scn = NULL;
+	GElf_Shdr sh, target;
+	const char *name;
+	size_t strings, i;
+
+	if (!elf || elf_getshdrstrndx(elf, &strings))
+		return -1;
+	while ((scn = elf_nextscn(elf, scn))) {
+		if (!gelf_getshdr(scn, &sh))
+			return -1;
+		if (!sh.sh_size || (sh.sh_type != SHT_REL && sh.sh_type != SHT_RELA))
+			continue;
+		if (!gelf_getshdr(elf_getscn(elf, sh.sh_info), &target))
+			return -1;
+		name = elf_strptr(elf, strings, target.sh_name);
+		if (!name)
+			return -1;
+		for (i = 0; i < ARRAY_SIZE(sections); i++)
+			if (!strcmp(name, sections[i])) {
+				ERROR("DWARF identity: unapplied relocations for %s", name);
+				return -1;
+			}
+	}
+	return 0;
+}
+
+static int build_identities(struct identity_reader *reader)
+{
+	static const Dwfl_Callbacks callbacks = { .section_address = dwfl_offline_section_address };
+	Dwfl *dwfl = dwfl_begin(&callbacks);
+	Dwarf_CU *cu = NULL, *next;
+	Dwarf_Die die;
+	Dwarf *dwarf;
+	struct identity_die *entry;
+	unsigned int bucket;
+	uint8_t unit_type;
+	int ret = -1;
+
+	if (!dwfl)
+		return -1;
+	reader->module = dwfl_report_offline(dwfl, reader->elf->name, reader->elf->name, -1);
+	if (!reader->module || dwfl_report_end(dwfl, NULL, NULL))
+		goto out;
+	dwarf = dwfl_module_getdwarf(reader->module, &reader->bias);
+	if (!dwarf || check_relocations(dwarf))
+		goto out;
+	reader->dwarf = dwarf;
+	while (!(ret = dwarf_get_units(dwarf, cu, &next, NULL, &unit_type, &die, NULL))) {
+		if (unit_type == DW_UT_skeleton ||
+		    unit_type == DW_UT_split_compile ||
+		    unit_type == DW_UT_split_type) {
+			ret = die_error(&die, "split DWARF is not supported yet");
+			goto out;
+		}
+		if (!is_unit(dwarf_tag(&die))) {
+			ret = die_error(&die, "invalid unit root");
+			goto out;
+		}
+		if (!read_cu(reader, &die)) {
+			ret = -1;
+			goto out;
+		}
+		cu = next;
+	}
+	if (ret < 0)
+		goto out;
+	ret = -1;
+	hash_for_each(reader->dies, bucket, entry, hash)
+		if (is_symbol(dwarf_tag(&entry->die)) && resolve_definition(reader, entry))
+			goto out;
+	hash_for_each(reader->dies, bucket, entry, hash)
+		if (collect_addresses(reader, entry))
+			goto out;
+	ret = 0;
+out:
+	dwfl_end(dwfl);
+	return ret;
+}
+
+int init_identity_cache(struct elf *elf)
+{
+	struct identity_reader *reader;
+	struct identity_die *die;
+	struct identity_cu *cu, *next;
+	struct hlist_node *tmp;
+	const char *saved_objname = objname;
+	unsigned int bucket;
+	int ret;
+
+	if (elf->dwarf_address_hash)
+		return 0;
+
+	if (elf->ehdr.e_type != ET_REL) {
+		ERROR("%s: DWARF identity requires an ET_REL object", elf->name);
+		return -1;
+	}
+	if (!find_section_by_name(elf, ".debug_info")) {
+		ERROR("%s: missing DWARF debug information; build with -g", elf->name);
+		return -1;
+	}
+	reader = calloc(1, sizeof(*reader));
+	if (!reader)
+		return -1;
+	if (!elf_alloc_hash(dwarf_address, 1UL << IDENTITY_HASH_BITS))
+		return -1;
+	reader->elf = elf;
+	INIT_LIST_HEAD(&reader->cus);
+	objname = elf->name;
+	ret = build_identities(reader);
+	hash_for_each_safe(reader->dies, bucket, tmp, die, hash) {
+		free(die->scope);
+		free(die);
+	}
+	list_for_each_entry_safe(cu, next, &reader->cus, list) {
+		free(cu->path);
+		free(cu);
+	}
+	free(reader);
+	if (ret)
+		ERROR("DWARF identity: input cannot be parsed");
+	objname = saved_objname;
+	return ret;
+}
+
+/* Match DW_AT_name verbatim; accept compiler suffixes only on the ELF name. */
+static bool matches_name(const char *name, const char *identifier)
+{
+	size_t len = strlen(identifier);
+
+	if (strncmp(name, identifier, len))
+		return false;
+	name += len;
+	while (*name) {
+		if (strstarts(name, ".llvm."))
+			name += 5;
+		if (*name++ != '.' || !isdigit((unsigned char)*name))
+			return false;
+		while (isdigit((unsigned char)*name))
+			name++;
+	}
+	return true;
+}
+
+static bool matches_dwarf_name(struct address_identity *entry, const char *name)
+{
+	const char *scope;
+
+	if (!entry->name || !entry->scope)
+		return false;
+	if (matches_name(name, entry->name))
+		return true;
+	/*
+	 * Clang names function-local statics as func.var[.suffix]. Constant merging
+	 * can leave one such ELF symbol for several variable DIEs, as with oldpiix's
+	 * timings tables. Match the encoded function scope as well as the variable.
+	 */
+	for (scope = entry->scope + 1; *scope; scope++, name++)
+		if (*name != (*scope == '/' ? '.' : *scope))
+			return false;
+	return matches_name(name, entry->name);
+}
+
+int get_identity_for_symbol(struct elf *elf, struct symbol *sym)
+{
+	struct identity *identity = &sym->identity;
+	struct section *sec = sym->sec;
+	struct address_identity *entry;
+	unsigned int nr = 0, nr_named = 0;
+	bool filter_name = false, unavailable = false, source_unavailable = false;
+	const char *error, *saved_objname = objname;
+
+	identity->source = "";
+	identity->scope = NULL;
+	identity->external = false;
+	elf_hash_for_each_possible(elf, dwarf_address, entry, hash, sym->offset ^ sec->idx) {
+		if (entry->section != sec->idx || entry->offset != sym->offset)
+			continue;
+		nr++;
+		if (is_rodata_sec(sec) && matches_dwarf_name(entry, sym->name))
+			nr_named++;
+	}
+	if (!nr)
+		return 1;
+
+	/* Only folded read-only storage needs name-based disambiguation. */
+	if (nr > 1 && is_rodata_sec(sec)) {
+		filter_name = true;
+		if (!nr_named)
+			return 1;
+		/*
+		 * ICF/constant merging can leave several definitions after name
+		 * filtering. FIXME: Folded objects can remain uncorrelated when
+		 * their checksums change.
+		 */
+		if (nr_named > 1 && strstarts(sec->name, ".rodata"))
+			return 1;
+	}
+
+	objname = elf->name;
+	elf_hash_for_each_possible(elf, dwarf_address, entry, hash, sym->offset ^ sec->idx) {
+		if (entry->section != sec->idx || entry->offset != sym->offset)
+			continue;
+		if (filter_name && !matches_dwarf_name(entry, sym->name))
+			continue;
+		/* Scope cannot be resolved from the first address of a compound expression. */
+		if (!entry->scope) {
+			unavailable = true;
+			/* Keep scanning: later entries may conflict. */
+			continue;
+		}
+		error = "conflicting declarations";
+		if (identity->scope && strcmp(identity->scope, entry->scope))
+			goto failed;
+		error = "conflicting external declarations";
+		if (identity->scope && identity->external != entry->external)
+			goto failed;
+		/* Source is omitted for external symbols or unavailable from the CU. */
+		if (!entry->source) {
+			source_unavailable = true;
+		} else {
+			error = "conflicting source CUs";
+			if (*identity->source && strcmp(identity->source, entry->source))
+				goto failed;
+			identity->source = entry->source;
+		}
+		identity->scope = entry->scope;
+		identity->external = entry->external;
+	}
+	if (unavailable) {
+		identity->source = "";
+		identity->scope = NULL;
+		identity->external = false;
+	}
+	if (source_unavailable)
+		identity->source = "";
+	objname = saved_objname;
+	return identity->scope ? 0 : 1;
+failed:
+	ERROR("DWARF identity: %s at %s+%#lx", error, sec->name, sym->offset);
+	identity->source = "";
+	identity->scope = NULL;
+	identity->external = false;
+	objname = saved_objname;
+	return -1;
+}
diff --git a/tools/objtool/klp-identity.c b/tools/objtool/klp-identity.c
new file mode 100644
index 000000000000..627eda694389
--- /dev/null
+++ b/tools/objtool/klp-identity.c
@@ -0,0 +1,170 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 Longjun Luo <luolongjuna@gmail.com>
+ */
+#define _GNU_SOURCE
+#include <string.h>
+
+#include <linux/jhash.h>
+
+#include <objtool/elf.h>
+#include <objtool/klp-dwarf.h>
+#include <objtool/klp-identity.h>
+#include <objtool/warn.h>
+
+static bool is_dwarf_identity_candidate(struct symbol *sym)
+{
+	return !sym->dont_correlate && sym->len && !is_undef_sym(sym) &&
+	       (is_func_sym(sym) || is_object_sym(sym));
+}
+
+static bool known_file_name_mismatch(const char *file, const char *source)
+{
+	const char *file_ext, *source_ext;
+
+	/* Full LTO combines TUs under one synthetic FILE name. */
+	if (!strcmp(file, "ld-temp.o"))
+		return true;
+
+	/* Startup objects prefix FILE names without renaming their DWARF CUs. */
+	if (strstarts(file, "__pi_") && !strcmp(file + 5, source))
+		return true;
+
+	/*
+	 * GNU AS misidentifies retpoline.S's CU as GEN-for-each-reg.h:
+	 * https://sourceware.org/pipermail/binutils/2026-October/152209.html
+	 */
+	if (!strcmp(file, "retpoline.o") && !strcmp(source, "GEN-for-each-reg.h"))
+		return true;
+
+	/* Ignore extension differences, e.g. foo.o versus foo.S. */
+	file_ext = strrchr(file, '.');
+	source_ext = strrchr(source, '.');
+	if (!file_ext || !source_ext)
+		return false;
+	return file_ext - file == source_ext - source &&
+	       !strncmp(file, source, file_ext - file);
+}
+
+/* Fill STT_FILE paths from DWARF, never the reverse. */
+static int complete_file_source(struct symbol *sym, const char *source)
+{
+	struct symbol *file = sym->file;
+	const char *file_name, *source_name;
+
+	if (!file || !*source)
+		return 0;
+
+	file_name = basename(file->name);
+	source_name = basename(source);
+	if (strcmp(file_name, source_name)) {
+		if (!known_file_name_mismatch(file_name, source_name) && !file->warned) {
+			WARN("FILE %s symtab[%u] disagrees with DWARF source %s for %s; skipping source completion",
+			     file->name, file->idx, source, sym->name);
+			file->warned = true;
+		}
+		return 0;
+	}
+
+	/* Symbols sharing an STT_FILE must agree on the CU path. */
+	if (file->identity.source != file->name &&
+	    strcmp(file->identity.source, source)) {
+		ERROR("FILE %s symtab[%u] has conflicting DWARF sources: %s and %s",
+		      file->name, file->idx, file->identity.source, source);
+		return -1;
+	}
+	file->identity.source = source;
+	return 0;
+}
+
+u32 identity_hash(const struct identity *identity)
+{
+	return jhash_3words(str_hash(identity->source), str_hash(identity->scope),
+			   str_hash(identity->demangled_name), 0);
+}
+
+bool same_identity(const struct identity *a, const struct identity *b)
+{
+	return !strcmp(a->source, b->source) &&
+	       !strcmp(a->scope, b->scope) &&
+	       !strcmp(a->demangled_name, b->demangled_name);
+}
+
+/* Only accept identities from DWARF for uniqueness validation. */
+static int validate_dwarf_identity(struct elf *elf, struct symbol *sym)
+{
+	struct symbol *other;
+	u32 key = identity_hash(&sym->identity);
+
+	elf_hash_for_each_possible(elf, symbol_identity, other, identity_hash, key) {
+		if (same_identity(&sym->identity, &other->identity) &&
+		    !strcmp(sym->name, other->name)) {
+			ERROR("%s: duplicate symbol identity (%s, %s, %s): symtab[%u] %s+%#lx (%u bytes) and symtab[%u] %s+%#lx (%u bytes)",
+			      elf->name, sym->identity.source, sym->identity.scope, sym->name,
+			      other->idx, other->sec->name, other->offset, other->len,
+			      sym->idx, sym->sec->name, sym->offset, sym->len);
+			return -1;
+		}
+	}
+	elf_hash_add(symbol_identity, &sym->identity_hash, key);
+	return 0;
+}
+
+int prepare_identities(struct elf *elf)
+{
+	struct symbol *sym;
+	int ret;
+
+	if (init_identity_cache(elf) ||
+	    !elf_alloc_hash(symbol_identity, 1UL << elf->symbol_bits))
+		return -1;
+
+	for_each_sym(elf, sym) {
+		struct identity *identity = &sym->identity;
+
+		/* Keep the FILE name for complete_file_source() and fallback identities. */
+		identity->source = is_file_sym(sym) ? sym->name : "";
+		if (!is_dwarf_identity_candidate(sym))
+			continue;
+		ret = get_identity_for_symbol(elf, sym);
+		if (ret < 0)
+			return -1;
+	}
+
+	for_each_sym(elf, sym) {
+		struct identity *identity = &sym->identity;
+
+		/* A scope here means the identity was obtained from DWARF. */
+		if (!identity->scope)
+			continue;
+		/*
+		 * DW_AT_external describes source linkage, independent of LTO
+		 * promotion/internalization of ELF binding. Omit source for
+		 * external symbols so their definitions can move between TUs.
+		 */
+		if (identity->external)
+			identity->source = "";
+		else if (complete_file_source(sym, identity->source))
+			return -1;
+		if (validate_dwarf_identity(elf, sym))
+			return -1;
+	}
+
+	/* FILE fallback may change keys; rebuild the index below. */
+	memset(elf->symbol_identity_hash, 0,
+	       sizeof(*elf->symbol_identity_hash) << elf->symbol_identity_bits);
+
+	for_each_sym(elf, sym) {
+		struct identity *identity = &sym->identity;
+
+		/* Default to STT_FILE and "/" for missing DWARF information. */
+		if (!identity->external && !*identity->source && sym->file)
+			identity->source = sym->file->identity.source;
+		if (!identity->scope)
+			identity->scope = "/";
+		if (!sym->dont_correlate)
+			elf_hash_add(symbol_identity, &sym->identity_hash, identity_hash(identity));
+	}
+
+	return 0;
+}
diff --git a/tools/objtool/tests/generic/test-thinlto-ambiguity.sh b/tools/objtool/tests/generic/test-thinlto-ambiguity.sh
index 34f4f3a58e20..4e0e49a9fc56 100755
--- a/tools/objtool/tests/generic/test-thinlto-ambiguity.sh
+++ b/tools/objtool/tests/generic/test-thinlto-ambiguity.sh
@@ -38,7 +38,7 @@ build_thinlto()		# $1 output object, $2 extra flags
 {
 	local t
 	for t in "" -DTU_B -DTU_C; do
-		$THIN_CC -flto=thin -O2 -ffunction-sections -fdata-sections \
+		$THIN_CC -flto=thin -O2 -g -ffunction-sections -fdata-sections \
 			$2 $t -c "$FIXTURES_DIR/thinlto_ambiguity.c" \
 			-o "$workdir/tu$t.o" 2>/dev/null || return 1
 	done
diff --git a/tools/objtool/tests/generic/test-thinlto-local.sh b/tools/objtool/tests/generic/test-thinlto-local.sh
index a266263676ed..71156e0b59ce 100755
--- a/tools/objtool/tests/generic/test-thinlto-local.sh
+++ b/tools/objtool/tests/generic/test-thinlto-local.sh
@@ -15,9 +15,9 @@ find_thinlto_toolchain ||
 
 build_thinlto()		# $1 output object, $2 extra flags
 {
-	$THIN_CC -flto=thin -O2 -ffunction-sections -fdata-sections $2 \
+	$THIN_CC -flto=thin -O2 -g -ffunction-sections -fdata-sections $2 \
 		-c "$FIXTURES_DIR/thinlto_local.c" -o "$workdir/tu_a.o" 2>/dev/null || return 1
-	$THIN_CC -flto=thin -O2 -ffunction-sections -fdata-sections $2 -DTU_B \
+	$THIN_CC -flto=thin -O2 -g -ffunction-sections -fdata-sections $2 -DTU_B \
 		-c "$FIXTURES_DIR/thinlto_local.c" -o "$workdir/tu_b.o" 2>/dev/null || return 1
 	"$THIN_LD" -r "$workdir/tu_a.o" "$workdir/tu_b.o" -o "$1" 2>/dev/null || return 1
 }
diff --git a/tools/objtool/tests/lib.sh b/tools/objtool/tests/lib.sh
index 4da168d0ddca..44ce670c4a6c 100644
--- a/tools/objtool/tests/lib.sh
+++ b/tools/objtool/tests/lib.sh
@@ -57,7 +57,7 @@ klp_preflight()
 	OBJTOOL="$(realpath "$OBJTOOL")"
 
 	"$OBJTOOL" klp 2>&1 | grep -q checksum ||
-		bail "objtool was built without klp support; install libxxhash (>= 0.8) and rebuild"
+		bail "objtool was built without klp support; install libxxhash (>= 0.8) and libdw development files and rebuild"
 
 	command -v "${CC%% *}" >/dev/null || bail "compiler not found: $CC"
 
@@ -67,7 +67,7 @@ klp_preflight()
 
 	tmp="$(mktemp -d)" || bail "mktemp failed"
 	echo 'int probe(void) { return 0; }' > "$tmp/probe.c"
-	$CC -c -o "$tmp/probe.o" "$tmp/probe.c" 2>/dev/null ||
+	$CC -g -c -o "$tmp/probe.o" "$tmp/probe.c" 2>/dev/null ||
 		{ rm -rf "$tmp"; bail "$CC cannot compile a trivial object"; }
 
 	# $CC, $ARCH and objtool have to agree about the target, and cross runs
@@ -139,6 +139,7 @@ EOF
 # it lives at the compile where an override cannot drop it.
 #
 #   -O2					the kernel's default
+#   -g					required for DWARF symbol identity
 #   -ffunction-sections -fdata-sections	klp-build passes these itself, through
 #					KCFLAGS, whatever the configuration
 #   -fno-asynchronous-unwind-tables	arch/x86/Makefile sets this always, so
@@ -150,7 +151,7 @@ EOF
 #					checksum
 #
 # A test overrides it; see tools/objtool/Documentation/klp-write-tests.txt.
-FIXTURE_CFLAGS="-O2 -ffunction-sections -fdata-sections -fno-common \
+FIXTURE_CFLAGS="-O2 -g -ffunction-sections -fdata-sections -fno-common \
 		-fno-asynchronous-unwind-tables"
 
 test_name="$(basename "$0" .sh)"
-- 
2.53.0

