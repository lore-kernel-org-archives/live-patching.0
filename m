Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793799158;
	b=NCkZvZq3luWYCT0wjiZQeZ7JcFW9rLFYFDFaOh/h8Mhv9HmG7qWbmfpqM/Kctn4K5NfP
	 LiWuZEpb445+1M3O5ymZJWi92rKq1i2emqh/SXQ2EB8n3f1eUNjQ6ri0kJ6fglk0KxFZ/
	 nJAfh5D1NRXg7s8iArO7vATqwlABXV/oQlRXSR6fKgdqip3aZGqTpNrIW+qSSTW8/4eeb
	 8+plQAm5d5PpQ+2Udysup0uxudRL2oTVtz3Ahra4InaECBUyhBldsr6rOd8kRvFVzVFUE
	 8nx7z1/ysO6a7uNQ+HrpbdplZrfw00HSQHkwab9NSaTv7eugmOyI5jP04T4SEjaPSBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793799158;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=CK5lHk9SZOE0PmNhpyj2Tx1ZNKr7EJm3HnsqqQ/w2LE=;
	b=QgT+AvuYmG4FBF6+Umxmi8VfbE+bnWUBUcOFPEigZDHDHOrWhNKwfGig0O0fo2SqQh+U
	 m5UrR/iyK1sgBqAztsFZUJUzgPfCYmGfzHocrx4VcG6wJ2A1O0E1QkWxQUe7cL9GQqvlD
	 APjWa6pOeqEXhvuPsB/WHBtbXt3F5CyhRqITlpB2D70Gl+SBwWQ7WNoDsFLBQ5Y0YXlQj
	 c7G+wFlTCAR86ny3Fhu6m4J99GbdF/qrsF5/03u9rtZKDy8dsliOrrKUj1fwoFsj1Uwxu
	 A9aMHYjuTVZGcQRBdJDuXVNNNEaPe5/2efXFlqAZxHIrA+foYNlZ7FmdDHktHzPPCqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LYSAi8Wm;
	arc=none smtp.remote-ip=209.85.210.178
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137F3606D80E
	for <live-patching@vger.kernel.org>; Wed,  4 Nov 2026 13:32:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 137F3606D80E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LYSAi8Wm
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8a06210b29fso383874b3a.1
        for <live-patching@vger.kernel.org>; Wed, 04 Nov 2026 05:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793799156; x=1794403956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CK5lHk9SZOE0PmNhpyj2Tx1ZNKr7EJm3HnsqqQ/w2LE=;
        b=LYSAi8WmMbPrflHr88NMNplOi4WfWUyaWbLy1LO4DEEHiQ31YUtUy57kW53TG5TJFS
         uCf6mEfJLTBUBTUZSCyqSzlF1JhZc3MAp0FqZZexXRtVSnRhlM0FCNdcBUeg5fUrMtG4
         qVLf5xKyGwaYZL7tnyUbg/lytuPvUjkGuSYbLauUs59RG6uB2Kh0mpfV1D5DLdEkEYOp
         6U5ytnfM+V/zdWNc+bs3F0wT7QDhyLBE8Clo/5MTR6jDmdxpwr/UHDbD06DcX1nPMefD
         OAw2fUEBpzxV8cPKUqdXBZpBIw4rXQV4onvODiK1xpl7vzul92uqc4LGopF3PjAK1Esm
         NnsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793799156; x=1794403956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CK5lHk9SZOE0PmNhpyj2Tx1ZNKr7EJm3HnsqqQ/w2LE=;
        b=2OgQrERiHgZW7EfpaPPA6t+szYHCloHDUe6z/5J/E4SazE+Ev4jzld+B3dOEWbyjKA
         R0Er5Fsfunh/H/kXjDA+DfhsGpYxhmXH+U5Tt84DXVbi0kR9Mkq+ErYDY04gjh+Vai4Q
         6nzcxTCuYh+6rcPRhRys7juN7ISN1R/XJpzZRW8UYzF1mkehnjQ1HfJRd7unLL+X21H3
         t6mvCd0irBERDWRY9dBEFZezKFgiRz69VOxuEr3kFY8hZQLCbaAoImmnrkG89bmxaOGW
         /xzYnem9WBfxZlRw7sy6hv+R4ei+n1RzjlnR4gQldp/1BQwxplX32S6GI9jPBeK88waj
         zGGg==
X-Forwarded-Encrypted: i=1; AKwUvBypNI7pM5z7gCpIpN31LBocXdxmzgm/Oa4EcXBHIV4jigyp6oXtsMMm9vse7Uy3Oq7vGZpODSgodXWCLzQs@vger.kernel.org
X-Gm-Message-State: APuU4Z/uLA/hSvpgSjASuTaMNB4e8UEy7ETv1x+WwTx4q0Sd4a9llAqS
	vlKli2EAlchRYnuD5iRPU+TF9gfvjW89B5KKyMJoCZohzFVaLiXIGyKI
X-Gm-Gg: AYBFou14ZYIlsZul23x50Mts9SOuHUrfW03WvaEMvc/TbAaiFvBpvoJmx8P8IHIV+ck
	wQRe3HXake2S+yfXToLeNL1QaQaHkyG1u4iaTEIYvDUTob7jFm7Zwy9UpEVv4GHN5Ug3Z3JNsK1
	DGObitObA9STELTMFXRL8jP/CuHHM5Xj1uuBoAF3tTmmbKYJFBVWxfOirmLgNRWO/iijYXqUV+O
	YcKXUhm31TMzsFRslYCQ3S2RnEARdwBoYkP1keFjXMYfiyQCAkgL1AkP61GJ177mRNrMAwD64Gw
	tNPnucQ3fNie7tZ67XaEqtro6gRIxd5yF9ztthpbZICJLbjU0ZvKlGjksts4wV7GcXm+AM2G3S0
	krHxrgQoH6K0g92fq+abbplndFa6HyQyAeFEjPNkEKCvLay54WGrUX359P21yO+RQbIi+hRyksb
	iTnalq62AShiRWY+GvGmAKEKLKMKR2inq9G2c1Ts/nLZLS8a29YU7lchhK6Urm4KoVtxEVSTgIC
	p+js5whSsdaojKvoQh4iNLj8veqDlILYmoAya39hyIRa7TXLknzl12yRFYED3sCpR6tXxR/cJch
	vqVDLSHzTGjhmX9ZXA1dXkNj8qbEXCPpXx8eJ2g1qr+6agxrpA==
X-Received: by 2002:aa7:9a1c:0:b0:848:77b3:579a with SMTP id d2e1a72fcca58-8aafd55957cmr7997419b3a.17.1793799155862;
        Wed, 04 Nov 2026 05:32:35 -0800 (PST)
Received: from anatasluo-Precision-5560 ([139.226.166.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b09a7ce84fsm911369b3a.13.2026.11.04.05.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 05:32:35 -0800 (PST)
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
Subject: [RFC PATCH v2 04/11] objtool/klp: Read symbol identities from DWARF
Date: Wed,  4 Nov 2026 21:31:50 +0800
Message-ID: <20261104133158.3187525-5-luolongjuna@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261104133158.3187525-1-luolongjuna@gmail.com>
References: <20261104133158.3187525-1-luolongjuna@gmail.com>
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

Compiler-generated names and ELF FILE symbols can change between builds.
Read each symbol's defining translation unit and named scope from DWARF
and combine them with its suffix-stripped name.

- Prefer DIEs matching the symbol's address and use names to narrow them.
- Fall back to names and FILE, using CU ranges to constrain functions.
- Handle address pieces, shrunk storage and assembly CU ranges.
- Cross-check DWARF sources against FILE and reject conflicting identities.
- Keep the resulting identities and release the temporary DIE indexes.

Only omit source for external definitions with GLOBAL or WEAK ELF
binding. Local clones retain their CU even when their DIE has
DW_AT_external. Record the existing cold-parent ambiguity after weak
overrides in a FIXME.

Add the libdw build dependency. This introduces the reader without
changing symbol correlation or checksum calculation.

Validated the available objtool tests with GCC 16.2.1 and Clang
22.1.8. No failures.

Assisted-by: LLM
Signed-off-by: Longjun Luo <luolongjuna@gmail.com>
---
 scripts/livepatch/klp-build                   |    2 +-
 tools/objtool/Build                           |    4 +-
 .../objtool/Documentation/klp-test-design.txt |    6 +-
 tools/objtool/Makefile                        |   12 +-
 tools/objtool/elf.c                           |   38 +-
 tools/objtool/include/objtool/elf.h           |   42 +-
 tools/objtool/include/objtool/klp-dwarf.h     |   22 +
 tools/objtool/include/objtool/klp-identity.h  |   26 +
 tools/objtool/klp-checksum.c                  |   16 +-
 tools/objtool/klp-diff.c                      |   10 +-
 tools/objtool/klp-dwarf.c                     | 1181 +++++++++++++++++
 tools/objtool/klp-identity.c                  |   94 ++
 tools/objtool/tests/lib.sh                    |    2 +-
 13 files changed, 1406 insertions(+), 49 deletions(-)
 create mode 100644 tools/objtool/include/objtool/klp-dwarf.h
 create mode 100644 tools/objtool/include/objtool/klp-identity.h
 create mode 100644 tools/objtool/klp-dwarf.c
 create mode 100644 tools/objtool/klp-identity.c

diff --git a/scripts/livepatch/klp-build b/scripts/livepatch/klp-build
index b52a8489d9f6..e373928123e8 100755
--- a/scripts/livepatch/klp-build
+++ b/scripts/livepatch/klp-build
@@ -279,7 +279,7 @@ validate_config() {
 		die "Clang assembler version < 20 not supported"
 
 	[[ -x "$OBJTOOL" ]] && "$OBJTOOL" klp 2>&1 | command grep -q "not implemented" && \
-		die "objtool not built with KLP support; install xxhash-devel/libxxhash-dev (version >= 0.8) and recompile"
+		die "objtool not built with KLP support; install xxhash-devel/libxxhash-dev (version >= 0.8) and elfutils-devel/libdw-dev and recompile"
 
 	return 0
 }
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
diff --git a/tools/objtool/Documentation/klp-test-design.txt b/tools/objtool/Documentation/klp-test-design.txt
index 2082c277197f..e63aad0f4324 100644
--- a/tools/objtool/Documentation/klp-test-design.txt
+++ b/tools/objtool/Documentation/klp-test-design.txt
@@ -17,8 +17,8 @@ TL;DR
 =====
 
 One run covers one compiler and one architecture; CI runs the combinations.
-Build objtool first -- it needs libelf and libxxhash -- and the same ARCH is
-used for both steps.
+Build objtool first -- it needs libelf, libxxhash and libdw -- and use the
+same ARCH for both steps.
 
 Natively, with gcc::
 
@@ -211,7 +211,7 @@ Running
 
 ::
 
-    make -C tools/objtool                 # needs libelf and libxxhash
+    make -C tools/objtool                 # needs libelf, libxxhash and libdw
     make -C tools/objtool tests
 
     CC=clang make -C tools/objtool tests  # the other toolchain
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
index 3ddbf5143260..ee7422364810 100644
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
@@ -545,13 +522,13 @@ static int elf_add_symbol(struct elf *elf, struct symbol *sym)
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
@@ -667,6 +644,10 @@ static int read_symbols(struct elf *elf)
 		if (elf_add_symbol(elf, sym))
 			return -1;
 
+		/*
+		 * FIXME: Assembly inputs without STT_FILE can inherit the preceding
+		 * input's FILE after partial linking.
+		 */
 		if (is_file_sym(sym))
 			file = sym;
 		else if (sym->bind == STB_LOCAL && !is_sec_sym(sym))
@@ -710,6 +691,11 @@ static int read_symbols(struct elf *elf)
 				return -1;
 			}
 
+			/*
+			 * FIXME: Weak and strong definitions can leave two local foo.cold symbols.
+			 * Both resolve to the surviving foo, so the last one overwrites cfunc and
+			 * can make the checksum miss changes to the active cold fragment.
+			 */
 			sym->pfunc = pfunc->alias;
 			pfunc->cfunc = sym;
 			pfunc->alias->cfunc = sym;
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index 5d7ddadf9471..f84d670e48a2 100644
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
@@ -121,16 +126,23 @@ struct elf {
 	unsigned int num_files;
 	struct list_head sections;
 	struct list_head symbols;
+	struct identity_reader *identity_reader;
 	unsigned long num_relocs;
 
 	int symbol_bits;
 	int symbol_name_bits;
+	int symbol_identity_bits;
+	int dwarf_address_bits;
+	int dwarf_name_bits;
 	int section_bits;
 	int section_name_bits;
 	int reloc_bits;
 
 	struct elf_hash_node **symbol_hash;
 	struct elf_hash_node **symbol_name_hash;
+	struct elf_hash_node **symbol_identity_hash;
+	struct elf_hash_node **dwarf_address_hash;
+	struct elf_hash_node **dwarf_name_hash;
 	struct elf_hash_node **section_hash;
 	struct elf_hash_node **section_name_hash;
 	struct elf_hash_node **reloc_hash;
@@ -145,6 +157,27 @@ struct elf {
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
@@ -317,6 +350,11 @@ static inline bool is_cold_func(struct symbol *sym)
 	return sym->cold;
 }
 
+static inline bool has_dwarf_identity(const struct symbol *sym)
+{
+	return sym->identity.scope != NULL;
+}
+
 static inline bool is_reloc_sec(struct section *sec)
 {
 	return sec->sh.sh_type == SHT_RELA || sec->sh.sh_type == SHT_REL;
@@ -517,7 +555,7 @@ static inline void set_sym_next_reloc(struct reloc *reloc, struct reloc *next)
 #define for_each_sym_by_demangled_name(elf, name, sym)			\
 	elf_hash_for_each_possible(elf, symbol_name, sym, name_hash,	\
 				   str_hash(name))			\
-		if (strcmp(sym->demangled_name, name)) {} else
+		if (strcmp(sym->identity.demangled_name, name)) {} else
 
 #define rsec_next_reloc(rsec, reloc)					\
 	reloc_idx(reloc) < sec_num_entries(rsec) - 1 ? reloc + 1 : NULL
diff --git a/tools/objtool/include/objtool/klp-dwarf.h b/tools/objtool/include/objtool/klp-dwarf.h
new file mode 100644
index 000000000000..ba6029bd2235
--- /dev/null
+++ b/tools/objtool/include/objtool/klp-dwarf.h
@@ -0,0 +1,22 @@
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
+void free_identity_cache(struct elf *elf);
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
index 000000000000..ffbc2bb906b1
--- /dev/null
+++ b/tools/objtool/include/objtool/klp-identity.h
@@ -0,0 +1,26 @@
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
+	const char *scope;		/* enclosing scopes, NULL without DWARF identity */
+	const char *demangled_name;	/* suffix-stripped symbol name */
+	const char *path;		/* source/scope/demangled_name, or NULL */
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
index 2a515c7e2bf6..1a5f2fa89baa 100644
--- a/tools/objtool/klp-checksum.c
+++ b/tools/objtool/klp-checksum.c
@@ -110,8 +110,8 @@ static int checksum_update_insn(struct objtool_file *file, struct symbol *func,
 			__checksum_update_insn(func, insn, buf, len);
 
 			if (call_dest) {
-				__checksum_update_insn(func, insn, call_dest->demangled_name,
-						       strlen(call_dest->demangled_name));
+				__checksum_update_insn(func, insn, call_dest->identity.demangled_name,
+						       strlen(call_dest->identity.demangled_name));
 
 			} else if (jump_dest) {
 				struct symbol *dest_sym;
@@ -127,8 +127,8 @@ static int checksum_update_insn(struct objtool_file *file, struct symbol *func,
 				if (!dest_sym)
 					goto alts;
 
-				__checksum_update_insn(func, insn, dest_sym->demangled_name,
-						       strlen(dest_sym->demangled_name));
+				__checksum_update_insn(func, insn, dest_sym->identity.demangled_name,
+						       strlen(dest_sym->identity.demangled_name));
 
 				offset = jump_dest->offset - dest_sym->offset;
 				__checksum_update_insn(func, insn, &offset, sizeof(offset));
@@ -170,8 +170,8 @@ static int checksum_update_insn(struct objtool_file *file, struct symbol *func,
 		__checksum_update_insn(func, insn, &sym->csum.checksum,
 				       sizeof(sym->csum.checksum));
 	} else {
-		__checksum_update_insn(func, insn, sym->demangled_name,
-				       strlen(sym->demangled_name));
+		__checksum_update_insn(func, insn, sym->identity.demangled_name,
+				       strlen(sym->identity.demangled_name));
 	}
 	__checksum_update_insn(func, insn, &offset, sizeof(offset));
 
@@ -266,8 +266,8 @@ static int checksum_update_object(struct objtool_file *file, struct symbol *sym,
 						 sizeof(target->csum.checksum));
 		} else {
 			__checksum_update_object(sym, sym_offset, "reloc name",
-						 target->demangled_name,
-						 strlen(target->demangled_name));
+						 target->identity.demangled_name,
+						 strlen(target->identity.demangled_name));
 		}
 		__checksum_update_object(sym, sym_offset, "reloc addend",
 					 &offset, sizeof(offset));
diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
index 0391f91a8d31..cd5e683d6468 100644
--- a/tools/objtool/klp-diff.c
+++ b/tools/objtool/klp-diff.c
@@ -600,7 +600,7 @@ static struct symbol *find_twin(struct elfs *e, struct symbol *sym1)
 	struct symbol *sym2, *match = NULL;
 
 	/* Count orig candidates */
-	for_each_sym_by_demangled_name(e->orig, sym1->demangled_name, sym2) {
+	for_each_sym_by_demangled_name(e->orig, sym1->identity.demangled_name, sym2) {
 		if (sym2->twin || sym1->type != sym2->type || sym2->dont_correlate ||
 		    (!maybe_same_file(sym1, sym2)))
 			continue;
@@ -626,7 +626,7 @@ static struct symbol *find_twin(struct elfs *e, struct symbol *sym1)
 	}
 
 	/* Count patched candidates */
-	for_each_sym_by_demangled_name(e->patched, sym1->demangled_name, sym2) {
+	for_each_sym_by_demangled_name(e->patched, sym1->identity.demangled_name, sym2) {
 		if (sym2->twin || sym1->type != sym2->type || sym2->dont_correlate ||
 		    !maybe_same_file(sym1, sym2))
 			continue;
@@ -766,7 +766,7 @@ static struct symbol *find_twin_suffixed(struct elf *elf, struct symbol *sym1)
 		return NULL;
 
 	if (snprintf_check(name, SYM_NAME_LEN, "%s%s",
-			   sym1->demangled_name, patched_suffix))
+			   sym1->identity.demangled_name, patched_suffix))
 		return NULL;
 
 	for_each_sym_by_name(elf, name, sym2) {
@@ -809,7 +809,7 @@ static struct symbol *find_twin_positional(struct elfs *e, struct symbol *sym1)
 	unsigned int sym1_pos = 0;
 	struct symbol *sym2, *match = NULL;
 
-	for_each_sym_by_demangled_name(e->orig, sym1->demangled_name, sym2) {
+	for_each_sym_by_demangled_name(e->orig, sym1->identity.demangled_name, sym2) {
 		if (sym2->twin || sym1->type != sym2->type || sym2->dont_correlate ||
 		    !maybe_same_file(sym1, sym2))
 			continue;
@@ -821,7 +821,7 @@ static struct symbol *find_twin_positional(struct elfs *e, struct symbol *sym1)
 		idx_orig++;
 	}
 
-	for_each_sym_by_demangled_name(e->patched, sym1->demangled_name, sym2) {
+	for_each_sym_by_demangled_name(e->patched, sym1->identity.demangled_name, sym2) {
 		if (sym2->twin || sym1->type != sym2->type || sym2->dont_correlate ||
 		    !maybe_same_file(sym1, sym2))
 			continue;
diff --git a/tools/objtool/klp-dwarf.c b/tools/objtool/klp-dwarf.c
new file mode 100644
index 000000000000..99b098ee7904
--- /dev/null
+++ b/tools/objtool/klp-dwarf.c
@@ -0,0 +1,1181 @@
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
+struct cu_range {
+	unsigned int section;
+	unsigned long start, end;
+};
+
+struct identity_cu {
+	struct list_head list;
+	char *path;
+	struct cu_range *ranges;
+	unsigned int nr_ranges;
+	bool assembly;
+};
+
+/* A DIE may describe multiple addresses through ranges or pieces. */
+struct die_address {
+	struct elf_hash_node hash;
+	struct identity_die *die;
+	unsigned int section;
+	unsigned long offset;
+	/* Piece or shrunk storage size; zero for an ordinary location. */
+	Dwarf_Word piece_size;
+};
+
+struct identity_die {
+	struct hlist_node hash;
+	struct elf_hash_node name_hash;
+	Dwarf_Die die;
+	struct identity_cu *cu;
+	struct identity_die *parent, *definition;
+	void *abstract_origin, *specification;
+	const char *name, *source, *scope;
+	char *parent_scope;
+	struct die_address *addresses;
+	unsigned int nr_addresses;
+	unsigned char type;
+	bool declaration, external;
+};
+
+struct identity_reader {
+	struct elf *elf;
+	Dwfl_Module *module;
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
+static int read_reference(Dwarf_Die *die, unsigned int attribute, void **address)
+{
+	Dwarf_Attribute attr;
+	Dwarf_Die reference;
+
+	if (!dwarf_attr(die, attribute, &attr))
+		return 0;
+	if (!dwarf_formref_die(&attr, &reference))
+		return die_error(die, "invalid declaration reference");
+	if (dwarf_cu_getdwarf(reference.cu) != dwarf_cu_getdwarf(die->cu))
+		return die_error(die, "references to supplementary DWARF files are unsupported");
+	*address = reference.addr;
+	return 0;
+}
+
+static int read_attributes(struct identity_die *entry)
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
+	if (read_reference(die, DW_AT_abstract_origin, &entry->abstract_origin) ||
+	    read_reference(die, DW_AT_specification, &entry->specification))
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
+		if (read_attributes(entry))
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
+static inline bool is_assembly_cu(Dwarf_Die *die, const char *source)
+{
+	return dwarf_srclang(die) == DW_LANG_Mips_Assembler ||
+	       (source && (str_ends_with(source, ".S") || str_ends_with(source, ".s")));
+}
+
+static int collect_cu_ranges(struct identity_reader *reader,
+			     struct identity_cu *cu, Dwarf_Die *die);
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
+	if (read_unit_source(cu, &root) || index_dies(reader, cu, &root, NULL, 0))
+		return NULL;
+	cu->assembly = is_assembly_cu(&root, cu->path);
+	if (collect_cu_ranges(reader, cu, &root))
+		return NULL;
+	list_add_tail(&cu->list, &reader->cus);
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
+static int resolve_parent_scope(struct identity_die *entry, unsigned int depth)
+{
+	struct identity_die *parent = entry->parent;
+	int tag;
+
+	if (entry->parent_scope)
+		return 0;
+	if (depth > IDENTITY_MAX_DEPTH)
+		return die_error(&entry->die, "scope lookup exceeds the supported depth");
+	if (!parent || is_unit(dwarf_tag(&parent->die))) {
+		entry->parent_scope = strdup("/");
+	} else {
+		if (resolve_parent_scope(parent, depth + 1))
+			return -1;
+		tag = dwarf_tag(&parent->die);
+		if (parent->name && tag != DW_TAG_lexical_block) {
+			if (asprintf(&entry->parent_scope, "%s%s/",
+				     parent->parent_scope, parent->name) < 0)
+				return -1;
+		} else {
+			entry->parent_scope = strdup(parent->parent_scope);
+		}
+	}
+	return entry->parent_scope ? 0 : -1;
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
+	*scope = start->parent_scope;
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
+static int collect_cu_ranges(struct identity_reader *reader,
+			     struct identity_cu *cu, Dwarf_Die *die)
+{
+	struct cu_range *ranges, *range;
+	Dwarf_Addr base, start, end, first, last;
+	unsigned int first_section, last_section;
+	ptrdiff_t off = 0;
+	int ret;
+
+	while ((off = dwarf_ranges(die, off, &base, &start, &end)) > 0) {
+		if (start == end)
+			continue;
+		if (end < start)
+			return die_error(die, "invalid CU range");
+		first = start + reader->bias;
+		last = end - 1 + reader->bias;
+		ret = address_section(reader, &first, &first_section);
+		if (ret < 0)
+			return -1;
+		if (ret)
+			continue;
+		ret = address_section(reader, &last, &last_section);
+		if (ret < 0)
+			return -1;
+		if (ret || first_section != last_section)
+			continue;
+		ranges = realloc(cu->ranges, (cu->nr_ranges + 1) * sizeof(*ranges));
+		if (!ranges)
+			return -1;
+		cu->ranges = ranges;
+		range = &ranges[cu->nr_ranges++];
+		range->section = first_section;
+		range->start = first;
+		range->end = last + 1;
+	}
+	return off < 0 ? die_error(die, "invalid CU ranges") : 0;
+}
+
+static int add_address(struct identity_reader *reader, struct identity_die *entry,
+		       Dwarf_Addr address, Dwarf_Word piece_size)
+{
+	struct die_address *addresses, *location;
+	Dwarf_Addr offset = address;
+	unsigned int section;
+	int ret = address_section(reader, &offset, &section);
+
+	if (ret)
+		return ret < 0 ? -1 : 0;
+	addresses = realloc(entry->addresses, (entry->nr_addresses + 1) * sizeof(*addresses));
+	if (!addresses)
+		return -1;
+	entry->addresses = addresses;
+	location = &addresses[entry->nr_addresses++];
+	memset(location, 0, sizeof(*location));
+	location->die = entry;
+	location->section = section;
+	location->offset = offset;
+	location->piece_size = piece_size;
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
+/*
+ * Optimizers can encode a variable's two values in one byte. The location
+ * expression reads that byte and reconstructs the source value.
+ */
+static bool is_shrunk_location(const Dwarf_Op *ops, size_t count)
+{
+	size_t i, depth = 1;
+
+	if (count < 3 || ops[1].atom != DW_OP_deref_size || ops[1].number != 1 ||
+	    ops[count - 1].atom != DW_OP_stack_value)
+		return false;
+	if (ops[0].atom != DW_OP_addr && ops[0].atom != DW_OP_addrx &&
+	    ops[0].atom != DW_OP_GNU_addr_index)
+		return false;
+
+	/* After the byte load, allow only constants and arithmetic. */
+	for (i = 2; i + 1 < count; i++) {
+		unsigned int op = ops[i].atom;
+
+		if ((op >= DW_OP_lit0 && op <= DW_OP_lit31) ||
+		    (op >= DW_OP_const1u && op <= DW_OP_consts)) {
+			depth++;
+			continue;
+		}
+		switch (op) {
+		case DW_OP_nop:
+		case DW_OP_abs:
+		case DW_OP_neg:
+		case DW_OP_not:
+		case DW_OP_plus_uconst:
+			break;
+		case DW_OP_plus:
+		case DW_OP_minus:
+		case DW_OP_mul:
+		case DW_OP_div:
+		case DW_OP_mod:
+		case DW_OP_and:
+		case DW_OP_or:
+		case DW_OP_xor:
+		case DW_OP_shl:
+		case DW_OP_shr:
+		case DW_OP_shra:
+		case DW_OP_eq:
+		case DW_OP_ge:
+		case DW_OP_gt:
+		case DW_OP_le:
+		case DW_OP_lt:
+		case DW_OP_ne:
+			if (depth < 2)
+				return false;
+			depth--;
+			break;
+		default:
+			return false;
+		}
+	}
+	return depth == 1;
+}
+
+/*
+ * Limit location decoding to fixed addresses. Other location descriptions
+ * rely on name lookup to keep the reader manageable.
+ */
+static int collect_location(struct identity_reader *reader, struct identity_die *entry,
+			    Dwarf_Attribute *attr, Dwarf_Op *ops, size_t count,
+			    Dwarf_Word piece_size)
+{
+	Dwarf_Attribute address_attr;
+	Dwarf_Addr address;
+	size_t i;
+
+	for (i = 0; i < count; i++)
+		if (ops[i].atom == DW_OP_piece || ops[i].atom == DW_OP_bit_piece)
+			return die_error(&entry->die, "unterminated location piece");
+	/* The decoded piece can be wider than its physical storage. */
+	if (is_shrunk_location(ops, count))
+		piece_size = ops[1].number;
+	else if (count != 1)
+		return 0;
+	switch (ops[0].atom) {
+	case DW_OP_addr:
+		address = ops[0].number;
+		break;
+	case DW_OP_addrx:
+	case DW_OP_GNU_addr_index:
+		if (dwarf_getlocation_attr(attr, ops, &address_attr) ||
+		    dwarf_formaddr(&address_attr, &address))
+			return die_error(&entry->die, "invalid location address");
+		break;
+	default:
+		/* Values and locations requiring runtime state are not addresses. */
+		return 0;
+	}
+	return add_address(reader, entry, address + reader->bias, piece_size);
+}
+
+static int collect_pieces(struct identity_reader *reader, struct identity_die *entry,
+			  Dwarf_Attribute *attr, Dwarf_Op *ops, size_t count)
+{
+	size_t first = 0, i;
+
+	for (i = 0; i < count; i++) {
+		if (ops[i].atom != DW_OP_piece && ops[i].atom != DW_OP_bit_piece)
+			continue;
+		/* Index only nonempty, byte-sized storage pieces. */
+		if (ops[i].atom == DW_OP_piece && ops[i].number &&
+		    collect_location(reader, entry, attr, ops + first, i - first, ops[i].number))
+			return -1;
+		first = i + 1;
+	}
+	return 0;
+}
+
+static int resolve_identity(struct identity_reader *reader, struct identity_die *entry)
+{
+	Dwarf_Attribute attr;
+	int tag = dwarf_tag(&entry->die);
+
+	if (!entry->definition || !is_symbol(tag))
+		return 0;
+	if (dwarf_attr_integrate(&entry->die, DW_AT_external, &attr) &&
+	    dwarf_formflag(&attr, &entry->external))
+		return die_error(&entry->die, "invalid external flag");
+	entry->source = resolve_definition_source(entry);
+	entry->type = tag == DW_TAG_subprogram ? STT_FUNC : STT_OBJECT;
+	return resolve_definition_scope(reader, entry, &entry->scope);
+}
+
+static int collect_addresses(struct identity_reader *reader, struct identity_die *entry)
+{
+	Dwarf_Die *die = &entry->die, type;
+	Dwarf_Attribute attr, address_attr;
+	Dwarf_Addr base, start, end;
+	Dwarf_Op *ops;
+	size_t count;
+	ptrdiff_t off = 0;
+	int tag = dwarf_tag(die);
+
+	if (!entry->definition || (tag != DW_TAG_subprogram && tag != DW_TAG_variable))
+		return 0;
+	if (tag == DW_TAG_subprogram) {
+		if (!dwarf_hasattr(die, DW_AT_low_pc) && !dwarf_hasattr(die, DW_AT_ranges))
+			return 0;
+		while ((off = dwarf_ranges(die, off, &base, &start, &end)) > 0)
+			if (start != end && add_address(reader, entry, start + reader->bias, 0))
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
+
+	if (dwarf_attr_integrate(die, DW_AT_type, &address_attr)) {
+		if (!dwarf_formref_die(&address_attr, &type))
+			return die_error(die, "invalid variable type reference");
+		if (is_empty_type(&type))
+			return 0;
+	}
+	if (ops[count - 1].atom == DW_OP_piece || ops[count - 1].atom == DW_OP_bit_piece)
+		return collect_pieces(reader, entry, &attr, ops, count);
+	return collect_location(reader, entry, &attr, ops, count, 0);
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
+static int index_identities(struct identity_reader *reader)
+{
+	struct elf *elf = reader->elf;
+	struct identity_die *entry;
+	struct die_address *address;
+	unsigned int bucket, i;
+
+	hash_for_each(reader->dies, bucket, entry, hash) {
+		if (!entry->scope)
+			continue;
+		/* Names must outlive libdw; source and scope are already owned. */
+		if (entry->name) {
+			entry->name = strdup(entry->name);
+			if (!entry->name)
+				return -1;
+		}
+		/* Build the address index after the arrays have stopped growing. */
+		for (i = 0; i < entry->nr_addresses; i++) {
+			address = &entry->addresses[i];
+			elf_hash_add(dwarf_address, &address->hash,
+				     address->offset ^ address->section);
+		}
+		/*
+		 * Index named definitions, not instances referring to them.
+		 * External definitions do not require a source path.
+		 */
+		if (entry->definition == entry && entry->name && (entry->source || entry->external))
+			elf_hash_add(dwarf_name, &entry->name_hash, str_hash(entry->name));
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
+	while (!(ret = dwarf_get_units(dwarf, cu, &next, NULL, &unit_type, &die, NULL))) {
+		if (unit_type == DW_UT_skeleton ||
+		    unit_type == DW_UT_split_compile || unit_type == DW_UT_split_type) {
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
+		if (resolve_identity(reader, entry) || collect_addresses(reader, entry))
+			goto out;
+	ret = index_identities(reader);
+out:
+	dwfl_end(dwfl);
+	return ret;
+}
+
+int init_identity_cache(struct elf *elf)
+{
+	struct identity_reader *reader;
+	const char *saved_objname = objname;
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
+	if (!elf_alloc_hash(dwarf_address, 1UL << IDENTITY_HASH_BITS) ||
+	    !elf_alloc_hash(dwarf_name, 1UL << IDENTITY_HASH_BITS))
+		return -1;
+	reader->elf = elf;
+	INIT_LIST_HEAD(&reader->cus);
+	elf->identity_reader = reader;
+	objname = elf->name;
+	ret = build_identities(reader);
+	if (ret)
+		ERROR("DWARF identity: input cannot be parsed");
+	objname = saved_objname;
+	return ret;
+}
+
+void free_identity_cache(struct elf *elf)
+{
+	struct identity_reader *reader = elf->identity_reader;
+	struct identity_die *entry;
+	struct identity_cu *cu, *next;
+	struct hlist_node *tmp;
+	unsigned int bucket;
+
+	hash_for_each_safe(reader->dies, bucket, tmp, entry, hash) {
+		if (entry->scope)
+			free((char *)entry->name);
+		free(entry->parent_scope);
+		free(entry->addresses);
+		free(entry);
+	}
+	list_for_each_entry_safe(cu, next, &reader->cus, list) {
+		free(cu->path);
+		free(cu->ranges);
+		free(cu);
+	}
+	munmap(elf->dwarf_address_hash,
+	       sizeof(*elf->dwarf_address_hash) << elf->dwarf_address_bits);
+	munmap(elf->dwarf_name_hash, sizeof(*elf->dwarf_name_hash) << elf->dwarf_name_bits);
+	free(reader);
+	elf->dwarf_address_hash = NULL;
+	elf->dwarf_name_hash = NULL;
+	elf->identity_reader = NULL;
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
+static bool matches_dwarf_name(struct identity_die *entry, const char *name)
+{
+	const char *scope;
+
+	if (!entry->name)
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
+static bool address_matches_symbol(struct die_address *entry, struct symbol *sym)
+{
+	/* Assembly code labels can be STT_NOTYPE when no .type is emitted. */
+	if (sym->type == STT_NOTYPE && !entry->die->cu->assembly)
+		return false;
+	if (entry->section != sym->sec->idx || entry->offset != sym->offset)
+		return false;
+	/* The recorded storage must cover the whole ELF symbol. */
+	return !entry->piece_size || sym->len <= entry->piece_size;
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
+	/* objcopy prefixes startup FILE names without changing their DWARF CUs. */
+	if (strstarts(file, "__pi_") && !strcmp(file + 5, source))
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
+static int complete_file_source(struct symbol *sym, const char *source, bool assembly)
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
+		/* Assembly CUs can name an included file instead of the input. */
+		if (assembly) {
+			dbg_correlate("FILE %s disagrees with assembly CU %s for %s; "
+				      "skipping source completion",
+				      file->name, source, sym->name);
+			return 0;
+		}
+		if (!known_file_name_mismatch(file_name, source_name) && !file->warned) {
+			WARN("FILE %s symtab[%u] disagrees with DWARF source %s for %s; skipping source completion",
+			     file->name, file->idx, source, sym->name);
+			file->warned = true;
+		}
+		return 0;
+	}
+
+	/* Symbols sharing an STT_FILE must agree on the CU path. */
+	if (file->identity.source != file->name) {
+		if (strcmp(file->identity.source, source)) {
+			ERROR("FILE %s symtab[%u] has conflicting DWARF sources: %s and %s",
+			      file->name, file->idx, file->identity.source, source);
+			return -1;
+		}
+		return 0;
+	}
+	file->identity.source = strdup(source);
+	if (!file->identity.source)
+		return -1;
+	return 0;
+}
+
+/*
+ * Omit source for external definitions which retain global or weak binding.
+ * They can move between CUs, and DWARF relocations for overridden weak
+ * definitions can bind to the selected definition:
+ * https://sourceware.org/bugzilla/show_bug.cgi?id=34741
+ *
+ * Local symbols keep their CU, including foo.cold and foo.part.0 which
+ * inherit DW_AT_external from their source definition.
+ */
+static bool needs_identity_source(struct symbol *sym, bool external)
+{
+	return !external || (!is_global_sym(sym) && !is_weak_sym(sym));
+}
+
+static void get_die_identity(struct identity_die *entry, struct symbol *sym,
+			     struct identity *identity)
+{
+	const char *source = entry->source;
+
+	identity->scope = entry->scope;
+	identity->external = entry->external;
+	if (entry->cu->assembly) {
+		source = entry->cu->path;
+		identity->scope = "/";
+		/* Assembly linkage is not subject to LTO promotion/internalization. */
+		identity->external = sym->bind != STB_LOCAL;
+	}
+	identity->source = needs_identity_source(sym, identity->external) ? source : "";
+}
+
+static bool cu_contains_symbol(struct identity_cu *cu, struct symbol *sym)
+{
+	struct cu_range *range;
+	unsigned int i;
+
+	for (i = 0; i < cu->nr_ranges; i++) {
+		range = &cu->ranges[i];
+		if (range->section == sym->sec->idx && sym->offset >= range->start &&
+		    sym->offset < range->end && sym->len <= range->end - sym->offset)
+			return true;
+	}
+	return false;
+}
+
+static int check_if_assembly(struct elf *elf, struct symbol *sym, struct identity_cu **matched_cu)
+{
+	struct identity_cu *cu, *match = NULL;
+
+	if (!(sym->sec->sh.sh_flags & SHF_EXECINSTR) ||
+	    (!is_func_sym(sym) && sym->type != STT_NOTYPE))
+		return 1;
+	list_for_each_entry(cu, &elf->identity_reader->cus, list) {
+		if (!cu->assembly || !cu->path || !cu_contains_symbol(cu, sym))
+			continue;
+		if (match && strcmp(match->path, cu->path)) {
+			ERROR("%s: conflicting assembly CUs for %s: %s and %s",
+			      elf->name, sym->name, match->path, cu->path);
+			return -1;
+		}
+		match = cu;
+	}
+	if (!match)
+		return 1;
+	*matched_cu = match;
+	sym->identity.scope = "/";
+	sym->identity.external = sym->bind != STB_LOCAL;
+	sym->identity.source = needs_identity_source(sym, sym->identity.external) ?
+			       match->path : "";
+	return 0;
+}
+
+/* GCC may omit address attributes for IPA-ICF wrappers such as msr_event_del. */
+static int fallback_by_name(struct elf *elf, struct symbol *sym, struct identity_cu **matched_cu)
+{
+	const char *name = sym->pfunc->identity.demangled_name;
+	const char *file = sym->file ? basename(sym->file->name) : NULL;
+	struct identity_die *entry, *match = NULL;
+	struct identity candidate, matched;
+
+	if (!is_func_sym(sym) && !(is_object_sym(sym) && is_rodata_sec(sym->sec)))
+		return 1;
+	elf_hash_for_each_possible(elf, dwarf_name, entry, name_hash, str_hash(name)) {
+		if (entry->type != sym->type || strcmp(name, entry->name))
+			continue;
+		/* Different CUs can have the same FILE basename and function name. */
+		if (is_func_sym(sym) && !cu_contains_symbol(entry->cu, sym))
+			continue;
+		get_die_identity(entry, sym, &candidate);
+		if (!candidate.source)
+			return 1;
+		if (!entry->cu->assembly && !candidate.external && file &&
+		    strcmp(file, basename(candidate.source)) &&
+		    !known_file_name_mismatch(file, basename(candidate.source)))
+			continue;
+		if (match) {
+			get_die_identity(match, sym, &matched);
+			if (strcmp(matched.source, candidate.source) ||
+			    strcmp(matched.scope, candidate.scope) ||
+			    matched.external != candidate.external)
+				return 1;
+		}
+		match = entry;
+	}
+	if (!match)
+		return 1;
+	*matched_cu = match->cu;
+	get_die_identity(match, sym, &sym->identity);
+	return 0;
+}
+
+int get_identity_for_symbol(struct elf *elf, struct symbol *sym)
+{
+	struct identity *identity = &sym->identity, candidate;
+	struct section *sec = sym->sec;
+	struct identity_cu *cu = NULL;
+	struct die_address *address;
+	struct identity_die *entry;
+	unsigned int nr = 0, nr_both_matched = 0;
+	bool source_unavailable = false;
+	const char *error, *saved_objname = objname;
+
+	identity->source = "";
+	identity->scope = NULL;
+	identity->external = false;
+	elf_hash_for_each_possible(elf, dwarf_address, address, hash, sym->offset ^ sec->idx) {
+		if (!address_matches_symbol(address, sym))
+			continue;
+		entry = address->die;
+		nr++;
+		if (matches_dwarf_name(entry, sym->name))
+			nr_both_matched++;
+	}
+	if (!nr) {
+		int ret = fallback_by_name(elf, sym, &cu);
+
+		if (ret == 1)
+			ret = check_if_assembly(elf, sym, &cu);
+		if (ret)
+			return ret;
+		goto found;
+	}
+
+	/*
+	 * ICF/constant merging can leave several definitions after name
+	 * filtering. FIXME: Folded objects can remain uncorrelated when
+	 * their checksums change.
+	 */
+	if (nr_both_matched > 1 && strstarts(sec->name, ".rodata"))
+		return 1;
+
+	/*
+	 * Prefer address and name. Compiler clones, syscall/weak aliases and
+	 * objcopy's __pi_ prefix can differ from DW_AT_name. If no name matches,
+	 * accept address candidates only when their identities agree below.
+	 */
+	objname = elf->name;
+	elf_hash_for_each_possible(elf, dwarf_address, address, hash, sym->offset ^ sec->idx) {
+		if (!address_matches_symbol(address, sym))
+			continue;
+		entry = address->die;
+		if (nr_both_matched && !matches_dwarf_name(entry, sym->name))
+			continue;
+		get_die_identity(entry, sym, &candidate);
+		error = "conflicting declarations";
+		if (identity->scope && strcmp(identity->scope, candidate.scope))
+			goto failed;
+		error = "conflicting external declarations";
+		if (identity->scope && identity->external != candidate.external)
+			goto failed;
+		/* The CU may omit its source path. */
+		if (!candidate.source) {
+			source_unavailable = true;
+		} else {
+			error = "conflicting source CUs";
+			if (*identity->source && strcmp(identity->source, candidate.source))
+				goto failed;
+			identity->source = candidate.source;
+		}
+		identity->scope = candidate.scope;
+		identity->external = candidate.external;
+		cu = entry->cu;
+	}
+	if (source_unavailable) {
+		identity->source = "";
+		identity->scope = NULL;
+	}
+	objname = saved_objname;
+	if (!identity->scope)
+		return 1;
+found:
+	if (complete_file_source(sym, identity->source, cu->assembly))
+		return -1;
+	/* Symbol identities outlive the DWARF lookup indexes. */
+	identity->source = strdup(identity->source);
+	identity->scope = strdup(identity->scope);
+	if (!identity->source || !identity->scope)
+		return -1;
+	return 0;
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
index 000000000000..4b777571c715
--- /dev/null
+++ b/tools/objtool/klp-identity.c
@@ -0,0 +1,94 @@
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
+	       (is_func_sym(sym) || is_object_sym(sym) ||
+		(sym->type == STT_NOTYPE && (sym->sec->sh.sh_flags & SHF_EXECINSTR)));
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
+		/* complete_file_source() replaces this FILE name with its DWARF path. */
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
+		char *path;
+
+		if (!has_dwarf_identity(sym))
+			continue;
+		if (asprintf(&path, "%s%s%s", identity->source, identity->scope,
+			     identity->demangled_name) < 0) {
+			ERROR_GLIBC("asprintf");
+			return -1;
+		}
+		identity->path = path;
+		if (validate_dwarf_identity(elf, sym))
+			return -1;
+	}
+
+	free_identity_cache(elf);
+	return 0;
+}
diff --git a/tools/objtool/tests/lib.sh b/tools/objtool/tests/lib.sh
index 4da168d0ddca..8e1aa7614dc6 100644
--- a/tools/objtool/tests/lib.sh
+++ b/tools/objtool/tests/lib.sh
@@ -57,7 +57,7 @@ klp_preflight()
 	OBJTOOL="$(realpath "$OBJTOOL")"
 
 	"$OBJTOOL" klp 2>&1 | grep -q checksum ||
-		bail "objtool was built without klp support; install libxxhash (>= 0.8) and rebuild"
+		bail "objtool was built without klp support; install libxxhash (>= 0.8) and libdw development files and rebuild"
 
 	command -v "${CC%% *}" >/dev/null || bail "compiler not found: $CC"
 
-- 
2.55.0

