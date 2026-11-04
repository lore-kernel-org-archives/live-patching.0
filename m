Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793799177;
	b=qxKSuqPvU5BMKGfXIq7doWw+yswne1BFDs1olQPChD1OJ56VxNWbgE/wZoxnKlZyL939
	 eSfddzfFXozdGIws2enwZZ+FX9XIP9CPi37EXXstfURyV0mpxwJbyelQFRYhFECOkwDY3
	 DplMLGUGHeYNin6VdXCGZVtyfqtpsEkQxafwz/7+tSTjGMmG7khfguiN2YVXbL+AtsXvq
	 WALyf0mouQ62qMFIrvBZrl1Ng+RaIgpgZeVUXKLJxc1nzzeaa00K7cj5pvaP/vmUhVLqz
	 C91EbKAm0lTpL6MYoVCieE8/yTX+dTdCDHq7KmGgyuncE9Hamv1LWFkq8wayV3cM2Pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793799177;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=1/DJ4PbXWMSa06hjFJtt9MtTFEgJJ+zBsVbZrqqRFuQ=;
	b=kpK2NwoZEsTXUkyXuY0/Fi1CKKuXqvmWiuBeOg+J0N/24tuxiRyvXuqY9mQcKuatvC+Z
	 ijdXxXF7hW6KWMcxIcDWBp6/urz26bs34bhE7GT6dCNlF/FPe75wi88k7AKLSNzUzk30m
	 t6VbMWnnIVfbLdOW/LJVFUsvhbC6Xo+q0S537iZvL+yKJzdUEsDBMay+vGHNgVu6QtVxa
	 uO/BBOLz5RqvZUyJhWW1eqEXA7fWDL2rVm/0r+wrey/x7qBfZwm5M8BgmeurCl4PA3tcn
	 lwpe63LkyGRM8mETJysxt1/NSa5HNPyKYs2hX7xLsQZHBGHGGb1SB8qud017+gPOmzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TcQQw8Ku;
	arc=none smtp.remote-ip=209.85.210.169
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFBC606D807
	for <live-patching@vger.kernel.org>; Wed,  4 Nov 2026 13:32:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0DFBC606D807
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TcQQw8Ku
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8a06b44bd01so513623b3a.0
        for <live-patching@vger.kernel.org>; Wed, 04 Nov 2026 05:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793799175; x=1794403975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1/DJ4PbXWMSa06hjFJtt9MtTFEgJJ+zBsVbZrqqRFuQ=;
        b=TcQQw8Ku9AoocpXoru5Ql8eVkF92JAGopEdIGJ1UId2hHVJD8n6jfbpmDU+AfIVUDD
         WFDZhG97KzYeSPqSA6fwx/5IrQkjVN1SXxa0z0Afv8wEkUqclyONhPv1hf69aoHr3LY9
         VM5ye7GkZ4e43hwi7d2lHMMNnQMi/HysSrusTeRNV0hsArCy7crBMKuBoQysSfQT7aBV
         KyiafiEnaMvUshlH8/MOmKPtph7tBnrm8zrcjTBg5ybKwrCpMwE+kEAwc52lJqCnp0Yw
         VRdEwuPWNcQq0I82dcw9kVLzyHEudqI/J3l21WroGyVOObbVgHGLLwx5V+Rk1viT19bU
         lOBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793799175; x=1794403975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1/DJ4PbXWMSa06hjFJtt9MtTFEgJJ+zBsVbZrqqRFuQ=;
        b=2aeesOVrp2gY7fvHsCl4vupc4Z+P7uVZRVOY7PteXXP6rPx/5tDDuL3fNn7YSjeOeo
         9aA0ChoaSbKEIly37X4SOB3d1vKIwA7fmwVmOszD/An8UV+5AyRQ3qEm7mVBnZP1+NuG
         NomPFOEzeD63lEc2zjq+dI7oC4//yL5HuhXdTsaqD8TE6gu7S/b0ax2VqBvrA0wcnkQ2
         rBtBC7UqTbeGHQUWt5919GucujSPNED5sFXJHkc8mRrba0VH/OPMsq5XD1Pm1u6jFWGa
         /H7rS7CxNctHcvumCrvI2+1DGlcPQXF00zoXgAOeDY3ON2zInMIJh5NV5QhOru05Fngp
         q3yw==
X-Forwarded-Encrypted: i=1; AKwUvBy1HxJHpQavuqDMjsy9q08QGKAY53L/jh4jh41Be9kJAsWGvZJpmxYnY0NeOesSw8CdJD/Nx7CvIBVE3VWJ@vger.kernel.org
X-Gm-Message-State: APuU4Z+q8oi0cnCJVqTFzmgtZS7uqDFg17d7Nps1m/YOd8FTSp4ddldM
	MfyoTf5yrg5nBwTBnyZyroXuiYN0WUp2FH9asl1BLQqAdtDb07rqJQkK
X-Gm-Gg: AYBFou2A1qrE0zrZR2+Z5m+fB5171gBbN1AMNkrOgMi/2Eboel+av/k84jEllvu5+ea
	XUBXi61wYV3oYSbeX/5Og3vXfghZ+7J+lvWqOn2gpMLO05W70ukB1rX8Vv0Z7uuxS8u1+PxhWlJ
	Sgxryd7idwvcSpE/SE3/nPwPdHCPPOgBgBOC/dxqa/HbgtKaQAFynpy4vCi0jn+RuEpH2QXi+jf
	qNmk3KlexNA4s32ohLSHUAhDjpsKHa3MD4+we3Gc3t+3TvdENVjsYe36Tal+4SJ1DN7lg943chp
	rjSGTgDIkrAHmG5YJxzI1zcv6Rh6GkAxw0QZleQmoRHAICIyMIEFKahKkgFVPqDa/uu0BNCsyg/
	A80ACIGiqWUyMb6jTq0ZyhfH23O2xh0GMO6bcKLPra5urCvxXUSrYDbI39xW2kMQ9O6hfoRyCKV
	Bd8fru7Ix0+/eZv1Xn8LEVQvt2WVH1myG6jWvj7CeoURBo/FPuiRpDhCtNA++gNlLVCzbnx3xV6
	LYy9L52sLiQ3Zb42e5+Zbu/F7fLYznGit0Z2GtnWnQBgFzpitroMr45YrhEISsAAQGw9VL7r3rm
	72a3RGU84d2W1wWIkknJxOrwY9OElfokqYrKkXzH0l6f5h2fNQ==
X-Received: by 2002:a05:6a00:3915:b0:890:a995:1f4f with SMTP id d2e1a72fcca58-8a9bb7a0dfcmr12750206b3a.20.1793799175197;
        Wed, 04 Nov 2026 05:32:55 -0800 (PST)
Received: from anatasluo-Precision-5560 ([139.226.166.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b09a7ce84fsm911369b3a.13.2026.11.04.05.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 05:32:54 -0800 (PST)
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
Subject: [RFC PATCH v2 07/11] objtool/klp: Correlate symbols using DWARF identities
Date: Wed,  4 Nov 2026 21:31:53 +0800
Message-ID: <20261104133158.3187525-8-luolongjuna@gmail.com>
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

Matching local symbols by compiler suffixes or symbol-table position
can pair unrelated state or copy existing state into a patch.

Match unique DWARF identities in both directions. Use checksums to
resolve remaining candidates within the same identity. Leave ambiguous
symbols uncorrelated instead of pairing them by position.

Compare __UNIQUE_ID data names without their counters. Use identity
and checksum uniqueness to preserve the original debug descriptors
when an earlier macro shifts their counters. Add a regression test.

Reuse data aliases through their representative twins. Retain a separate
unique FILE/name fallback with warnings for unknown cases, and exclude
link-time metadata from correlation.

Reject linkage changes because later name-based resolution can disagree
with the changed identity. Reject duplicate identities when the same
source is compiled into multiple objects; distinguishing those instances
would require another qualifier such as link order.

Validated the available objtool tests with GCC 16.2.1 and Clang
22.1.8. Only local-to-global-flip, sympos and sympos-vmlinux fail,
reflecting the linkage and duplicate-identity policies.

Assisted-by: LLM
Signed-off-by: Longjun Luo <luolongjuna@gmail.com>
---
 tools/objtool/include/objtool/klp.h           |   1 +
 tools/objtool/klp-diff.c                      | 728 ++++++++----------
 .../generic/fixtures/identity/unique_id.c     |  50 ++
 .../tests/generic/test-identity-unique-id.sh  |  31 +
 .../tests/generic/test-thinlto-ambiguity.sh   |   2 +-
 .../tests/generic/test-thinlto-local.sh       |   4 +-
 tools/objtool/tests/lib.sh                    |   5 +-
 7 files changed, 429 insertions(+), 392 deletions(-)
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/unique_id.c
 create mode 100755 tools/objtool/tests/generic/test-identity-unique-id.sh

diff --git a/tools/objtool/include/objtool/klp.h b/tools/objtool/include/objtool/klp.h
index 90468e141124..fa794bab116f 100644
--- a/tools/objtool/include/objtool/klp.h
+++ b/tools/objtool/include/objtool/klp.h
@@ -51,6 +51,7 @@ struct objtool_file;
 struct elf;
 struct symbol;
 
+bool dont_correlate(struct symbol *sym);
 bool is_compound_constant(struct symbol *sym);
 
 int klp_create_symid_sections(struct objtool_file *file);
diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
index cd5e683d6468..468b8654b687 100644
--- a/tools/objtool/klp-diff.c
+++ b/tools/objtool/klp-diff.c
@@ -3,14 +3,15 @@
 #include <subcmd/parse-options.h>
 #include <stdlib.h>
 #include <string.h>
-#include <libgen.h>
 #include <stdio.h>
 #include <ctype.h>
+#include <fnmatch.h>
 
 #include <objtool/objtool.h>
 #include <objtool/warn.h>
 #include <objtool/arch.h>
 #include <objtool/klp.h>
+#include <objtool/klp-identity.h>
 #include <objtool/util.h>
 #include <objtool/special.h>
 
@@ -19,7 +20,7 @@
 #include <linux/livepatch_external.h>
 #include <linux/stringify.h>
 #include <linux/string.h>
-#include <linux/jhash.h>
+#include <linux/hashtable.h>
 
 #define sizeof_field(TYPE, MEMBER) sizeof((((TYPE *)0)->MEMBER))
 
@@ -260,28 +261,6 @@ static int read_sym_checksums(struct elf *elf)
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
@@ -469,11 +448,19 @@ bool is_compound_constant(struct symbol *sym)
 	return !*name;
 }
 
+/* __tracepoint_check records build-time checks and is discarded by the linker. */
+static bool is_metadata_section(struct section *sec)
+{
+	return !strcmp(sec->name, ".modinfo") ||
+	       !strcmp(sec->name, ".no_trim_symbol") ||
+	       !strcmp(sec->name, "__tracepoint_check");
+}
+
 /*
  * These symbols should never be correlated, so their local patched versions
  * are used instead of linking to the originals.
  */
-static bool dont_correlate(struct symbol *sym)
+bool dont_correlate(struct symbol *sym)
 {
 	return is_file_sym(sym) ||
 	       is_null_sym(sym) ||
@@ -486,361 +473,357 @@ static bool dont_correlate(struct symbol *sym)
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
+	const char *suffix = strstr(name, ".llvm."), *p;
+
+	if (!suffix || !isdigit((unsigned char)suffix[6]))
+		return strlen(name);
+	for (p = suffix + 6; isdigit((unsigned char)*p); p++)
+		;
+	return *p ? strlen(name) : (size_t)(suffix - name);
 }
 
-static bool is_llvm_sym(struct symbol *sym)
+/* Keep object-fragment numbers, e.g. amd_northbridges.0. */
+static bool same_llvm_name(const char *a, const char *b)
 {
-	return llvm_suffix(sym->name);
+	size_t a_len = llvm_name_len(a), b_len = llvm_name_len(b);
+
+	return a_len == b_len && !strncmp(a, b, a_len);
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
+static const char *skip_lto_priv(const char *name)
 {
-	if (!sym1->file || !sym2->file)
-		return true;
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
- * Similar to maybe_same_file(), but strict: no scope changes allowed.
- *
- * Works for both same-ELF (direct pointer compare) and cross-ELF
- * (compare via file->twin) cases.
- */
-static bool same_file(struct symbol *sym1, struct symbol *sym2)
+static bool is_numeric_suffix(const char *name)
 {
-	if (llvm_suffix(sym1->name) && llvm_suffix(sym2->name))
-		return true;
-	if (!sym1->file && !sym2->file)
-		return true;
-	if (!sym1->file || !sym2->file)
+	if (*name++ != '.' || !isdigit((unsigned char)*name))
 		return false;
-	if (sym1->file == sym2->file)
+	while (isdigit((unsigned char)*name))
+		name++;
+	return !*name;
+}
+
+/* Allow compiler counters and GCC partition renames to change. */
+static bool same_compiler_name(const char *a, const char *b)
+{
+	for (;;) {
+		const char *next_a = skip_lto_priv(a), *next_b = skip_lto_priv(b);
+
+		if (next_a != a || next_b != b) {
+			a = next_a;
+			b = next_b;
+			continue;
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
+	}
+
+	/* A trailing counter may be absent on one side. */
+	return (!*a && is_numeric_suffix(b)) || (!*b && is_numeric_suffix(a));
+}
+
+/* Keep clone tags such as .cold, .isra and .part distinct. */
+static bool compatible_symbol_name(const char *a, const char *b)
+{
+	if (same_llvm_name(a, b))
 		return true;
-	return sym1->file->twin == sym2->file;
+	if (strchr(a, '@') || strchr(b, '@') || strstr(a, ".str1."))
+		return !strcmp(a, b);
+	return same_compiler_name(a, b);
 }
 
-/*
- * Is it a local symbol, or at least was it local in the translation unit
- * before LLVM promoted it?
- */
-static bool is_tu_local_sym(struct symbol *sym)
+static bool is_twin_candidate(struct symbol *sym1, struct symbol *sym2)
 {
-	return is_local_sym(sym) || is_llvm_sym(sym);
+	if (sym1->type != sym2->type)
+		return false;
+	/* Relocations can also reach targets without DWARF identities. */
+	if (has_dwarf_identity(sym1) && has_dwarf_identity(sym2) &&
+	    !same_identity(&sym1->identity, &sym2->identity))
+		return false;
+	/* Don't match zero-length labels with sized symbols. */
+	if (!is_undef_sym(sym1) && !is_undef_sym(sym2) &&
+	    (!sym1->len != !sym2->len))
+		return false;
+	/* __UNIQUE_ID counters shift when an earlier macro is added. */
+	if (is_object_sym(sym1) &&
+	    (strstarts(sym1->name, "__UNIQUE_ID_") || strstr(sym1->name, ".__UNIQUE_ID_")) &&
+	    (strstarts(sym2->name, "__UNIQUE_ID_") || strstr(sym2->name, ".__UNIQUE_ID_")))
+		return !strcmp(sym1->identity.demangled_name, sym2->identity.demangled_name);
+	return compatible_symbol_name(sym1->name, sym2->name);
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
+static struct symbol *find_twin(struct elf *elf, struct symbol *sym1)
 {
-	struct symbol *name_last = NULL, *scope_last = NULL,
-		      *file_last = NULL, *csum_last = NULL;
-	unsigned int name_orig = 0, name_patched = 0;
-	unsigned int scope_orig = 0, scope_patched = 0;
-	unsigned int file_orig = 0, file_patched = 0;
-	unsigned int csum_orig = 0, csum_patched = 0;
 	struct symbol *sym2, *match = NULL;
+	unsigned int candidates = 0;
+	u32 key;
 
-	/* Count orig candidates */
-	for_each_sym_by_demangled_name(e->orig, sym1->identity.demangled_name, sym2) {
-		if (sym2->twin || sym1->type != sym2->type || sym2->dont_correlate ||
-		    (!maybe_same_file(sym1, sym2)))
+	if (!has_dwarf_identity(sym1))
+		return NULL;
+	key = identity_hash(&sym1->identity);
+
+	elf_hash_for_each_possible(elf, symbol_identity, sym2, identity_hash, key) {
+		if (sym2->twin || !is_twin_candidate(sym1, sym2))
 			continue;
+		match = sym2;
+		candidates++;
+	}
 
-		/* Level 1: name match (widest filter)  */
-		name_orig++;
+	return candidates == 1 ? match : NULL;
+}
 
-		/* Level 2: scope (scope changes allowed) */
-		if (is_tu_local_sym(sym1) != is_tu_local_sym(sym2))
-			continue;
-		scope_orig++;
+/* Checksums can disambiguate only unchanged symbols. */
+static struct symbol *find_twin_by_identity_and_checksum(struct elf *elf, struct symbol *sym1)
+{
+	struct symbol *sym2, *match = NULL;
+	unsigned int candidates = 0;
+	u32 key;
 
-		/* Level 3: file (scope changes disallowed) */
-		if (!same_file(sym1, sym2))
-			continue;
-		file_orig++;
+	if (!has_dwarf_identity(sym1) || !sym1->csum.checksum)
+		return NULL;
+	key = identity_hash(&sym1->identity);
 
-		/* Level 4: checksum (unchanged symbols) */
-		if (sym1->len != sym2->len || !sym1->csum.checksum ||
+	elf_hash_for_each_possible(elf, symbol_identity, sym2, identity_hash, key) {
+		if (!is_twin_candidate(sym1, sym2))
+			continue;
+		if (sym2->twin || sym1->len != sym2->len ||
 		    sym1->csum.checksum != sym2->csum.checksum)
 			continue;
-		csum_orig++;
+		match = sym2;
+		candidates++;
 	}
 
-	/* Count patched candidates */
-	for_each_sym_by_demangled_name(e->patched, sym1->identity.demangled_name, sym2) {
-		if (sym2->twin || sym1->type != sym2->type || sym2->dont_correlate ||
-		    !maybe_same_file(sym1, sym2))
-			continue;
-
-		/* Level 1 */
-		name_patched++;
-		name_last = sym2;
+	return candidates == 1 ? match : NULL;
+}
 
-		/* Level 2 */
-		if (is_tu_local_sym(sym1) != is_tu_local_sym(sym2))
-			continue;
-		scope_patched++;
-		scope_last = sym2;
+static int correlate_by_identity(struct elfs *e)
+{
+	struct symbol *sym, *match;
 
-		/* Level 3 */
-		if (!same_file(sym1, sym2))
+	for_each_sym(e->orig, sym) {
+		/* Compound literal names are compiler counters, not stable identities. */
+		if (sym->twin || sym->dont_correlate || is_compound_constant(sym))
 			continue;
-		file_patched++;
-		file_last = sym2;
-
-		/* Level 4 */
-		if (sym1->len != sym2->len || !sym1->csum.checksum ||
-		    sym1->csum.checksum != sym2->csum.checksum)
+		match = find_twin(e->patched, sym);
+		/* Two originals can share the same sole patched candidate. */
+		if (!match || find_twin(e->orig, match) != sym)
 			continue;
-		csum_patched++;
-		csum_last = sym2;
+		sym->twin = match;
+		match->twin = sym;
+		dbg_correlate("%s(): %s -> %s", __func__, sym->name, match->name);
 	}
+	return 0;
+}
 
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
+static int extend_same_twins_by_checksum(struct elfs *e)
+{
+	struct symbol *sym, *match;
 
-	if (name_orig != 1 || name_patched != 1)
-		dbg_correlate("find_twin(): %s%s -> %s%s",
-			      sym1->name, is_func_sym(sym1) ? "()" : "",
-			      match->name, is_func_sym(match) ? "()" : "");
+	for_each_sym(e->orig, sym) {
+		if (sym->twin || sym->dont_correlate)
+			continue;
+		match = find_twin_by_identity_and_checksum(e->patched, sym);
+		/* Two originals can share the same sole patched candidate. */
+		if (!match || find_twin_by_identity_and_checksum(e->orig, match) != sym)
+			continue;
+		sym->twin = match;
+		match->twin = sym;
+		dbg_correlate("%s(): %s -> %s", __func__, sym->name, match->name);
+	}
+	return 0;
+}
 
-	return match;
+/* Data aliases can reuse the representative's storage without another twin. */
+static struct symbol *reference_twin(struct symbol *sym)
+{
+	if (!sym->twin && is_object_sym(sym))
+		return sym->alias->twin;
+	return sym->twin;
 }
 
-struct llvm_suffix_pair {
+struct symtab_entry {
 	struct hlist_node hash;
-	const char *orig;
-	const char *patched;
+	const char *file, *name;
+	struct symbol *sym;
+	bool is_unique;
+};
+
+struct symtab_hash {
+	DECLARE_HASHTABLE(entries, 12);
 };
 
-static DECLARE_HASHTABLE(suffix_map, 7);
+static struct symtab_entry *find_symtab_entry(struct symtab_hash *table, struct symbol *sym)
+{
+	const char *file = sym->file ? sym->file->name : "";
+	const char *name = sym->identity.demangled_name;
+	u32 key = jhash_2words(str_hash(file), str_hash(name), 0);
+	struct symtab_entry *entry;
 
-/*
- * Build a mapping of known orig-to-patched LLVM suffixes based on
- * already-correlated symbol pairs.  All promoted symbols from the same TU
- * share the same .llvm.<hash> suffix, so one correlated pair seeds the map
- * for the entire TU.
- */
-static int update_suffix_map(struct elf *elf)
+	hash_for_each_possible(table->entries, entry, hash, key) {
+		if (!strcmp(entry->file, file) && !strcmp(entry->name, name))
+			return entry;
+	}
+	return NULL;
+}
+
+static int build_symtab_hash(struct elf *elf, struct symtab_hash *table)
 {
-	struct llvm_suffix_pair *entry;
+	struct symtab_entry *entry;
 	struct symbol *sym;
+	u32 key;
 
+	hash_init(table->entries);
 	for_each_sym(elf, sym) {
-		const char *s1, *s2;
-		bool found;
-
-		if (!sym->twin)
+		if (!sym->len || is_undef_sym(sym) || sym->dont_correlate ||
+		    is_compound_constant(sym))
 			continue;
-
-		s1 = llvm_suffix(sym->name);
-		s2 = llvm_suffix(sym->twin->name);
-
-		if (!s1 || !s2)
+		/* Already matched symbols still count against uniqueness. */
+		entry = find_symtab_entry(table, sym);
+		if (entry) {
+			entry->is_unique = false;
 			continue;
-
-		found = false;
-		hash_for_each_possible(suffix_map, entry, hash, str_hash(s1)) {
-			if (!strcmp(entry->orig, s1)) {
-				found = true;
-				break;
-			}
 		}
-		if (found)
-			continue;
-
-		entry = calloc(1, sizeof(*entry));
+		entry = malloc(sizeof(*entry));
 		if (!entry) {
-			ERROR_GLIBC("calloc");
+			ERROR_GLIBC("malloc symtab entry");
 			return -1;
 		}
-
-		entry->orig = s1;
-		entry->patched = s2;
-		hash_add(suffix_map, &entry->hash, str_hash(s1));
+		/* Assembly may inherit FILE from the preceding input. */
+		entry->file = sym->file ? sym->file->name : "";
+		entry->name = sym->identity.demangled_name;
+		entry->sym = sym;
+		entry->is_unique = true;
+		key = jhash_2words(str_hash(entry->file), str_hash(entry->name), 0);
+		hash_add(table->entries, &entry->hash, key);
 	}
-
 	return 0;
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
+static void free_symtab_hash(struct symtab_hash *table)
 {
-	const char *suffix, *patched_suffix = NULL;
-	struct symbol *sym2, *match = NULL;
-	char name[SYM_NAME_LEN];
-	struct llvm_suffix_pair *entry;
-	int count = 0;
-
-	suffix = llvm_suffix(sym1->name);
-	if (!suffix)
-		return NULL;
+	struct symtab_entry *entry;
+	struct hlist_node *tmp;
+	unsigned int bucket;
 
-	hash_for_each_possible(suffix_map, entry, hash, str_hash(suffix)) {
-		if (!strcmp(entry->orig, suffix)) {
-			patched_suffix = entry->patched;
-			break;
-		}
+	hash_for_each_safe(table->entries, bucket, tmp, entry, hash) {
+		hash_del(&entry->hash);
+		free(entry);
 	}
-	if (!patched_suffix)
-		return NULL;
+}
 
-	if (snprintf_check(name, SYM_NAME_LEN, "%s%s",
-			   sym1->identity.demangled_name, patched_suffix))
-		return NULL;
+static bool known_symtab_fallback(struct symbol *sym)
+{
+	static const struct {
+		unsigned char bind, type;
+		const char *section, *name;
+	} whitelist[] = {
+		/* Local data defined in relocate_kernel_64.S. */
+		{ STB_LOCAL,  STT_OBJECT, ".data..relocate_kernel", "*" },
+		/* Static-call and paravirt macros emit top-level assembly. */
+		{ STB_GLOBAL, STT_FUNC,   ".static_call.text", "__SCT__*" },
+		{ STB_GLOBAL, STT_FUNC,   ".text", "__raw_callee_save_*" },
+		{ STB_GLOBAL, STT_FUNC,   ".entry.text", "paravirt_ret0" },
+		/* The VERW selector is assembly data placed in entry text. */
+		{ STB_GLOBAL, STT_NOTYPE, ".entry.text", "x86_verw_sel" },
+		/* Boot page tables defined in arch/x86/kernel/head_64.S. */
+		{ STB_GLOBAL, STT_OBJECT, ".data", "level4_kernel_pgt" },
+		{ STB_GLOBAL, STT_OBJECT, ".data", "level3_kernel_pgt" },
+		{ STB_GLOBAL, STT_OBJECT, ".data", "level2_kernel_pgt" },
+		{ STB_GLOBAL, STT_OBJECT, ".data", "level2_fixmap_pgt" },
+		{ STB_GLOBAL, STT_OBJECT, ".data", "level1_fixmap_pgt" },
+		/* CPU startup state defined in head_64.S. */
+		{ STB_GLOBAL, STT_OBJECT, ".ref.data", "initial_code" },
+		{ STB_GLOBAL, STT_OBJECT, ".data", "smpboot_control" },
+	};
+	unsigned int i;
 
-	for_each_sym_by_name(elf, name, sym2) {
-		if (sym2->twin || sym1->type != sym2->type || sym2->dont_correlate)
-			continue;
-		count++;
-		match = sym2;
+	for (i = 0; i < ARRAY_SIZE(whitelist); i++) {
+		if (sym->bind == whitelist[i].bind && sym->type == whitelist[i].type &&
+		    !strcmp(sym->sec->name, whitelist[i].section) &&
+		    !fnmatch(whitelist[i].name, sym->name, 0))
+			return true;
 	}
-
-	if (count != 1)
-		return NULL;
-
-	dbg_correlate("find_suffixed_twin(): %s%s -> %s%s",
-		      sym1->name, is_func_sym(sym1) ? "()" : "",
-		      match->name, is_func_sym(match) ? "()" : "");
-
-	return match;
+	return false;
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
+/* Audit unmatched symbols and pair unique FILE/name candidates. */
+static int validate_symbol_twins(struct elfs *e)
 {
-	unsigned int idx_orig = 0, idx_patched = 0;
-	unsigned int sym1_pos = 0;
-	struct symbol *sym2, *match = NULL;
+	struct symtab_hash orig_table = {}, patched_table = {};
+	struct symtab_entry *orig_entry, *patched_entry;
+	struct symbol *orig_sym, *patched_sym;
+	int ret = -1;
 
-	for_each_sym_by_demangled_name(e->orig, sym1->identity.demangled_name, sym2) {
-		if (sym2->twin || sym1->type != sym2->type || sym2->dont_correlate ||
-		    !maybe_same_file(sym1, sym2))
+	if (build_symtab_hash(e->orig, &orig_table) ||
+	    build_symtab_hash(e->patched, &patched_table))
+		goto out;
+
+	for_each_sym(e->patched, patched_sym) {
+		if (!patched_sym->len || is_undef_sym(patched_sym) ||
+		    patched_sym->dont_correlate || reference_twin(patched_sym))
 			continue;
-		if (is_tu_local_sym(sym1) != is_tu_local_sym(sym2) ||
-		    is_llvm_sym(sym1) != is_llvm_sym(sym2))
+		patched_entry = find_symtab_entry(&patched_table, patched_sym);
+		if (!patched_entry || !patched_entry->is_unique)
 			continue;
-		if (sym1 == sym2)
-			sym1_pos = idx_orig;
-		idx_orig++;
-	}
-
-	for_each_sym_by_demangled_name(e->patched, sym1->identity.demangled_name, sym2) {
-		if (sym2->twin || sym1->type != sym2->type || sym2->dont_correlate ||
-		    !maybe_same_file(sym1, sym2))
+		orig_entry = find_symtab_entry(&orig_table, patched_sym);
+		if (!orig_entry || !orig_entry->is_unique)
 			continue;
-		if (is_tu_local_sym(sym1) != is_tu_local_sym(sym2) ||
-		    is_llvm_sym(sym1) != is_llvm_sym(sym2))
+		orig_sym = orig_entry->sym;
+		if (reference_twin(orig_sym))
 			continue;
-		if (idx_patched == sym1_pos)
-			match = sym2;
-		idx_patched++;
-	}
-
-	if (idx_orig != idx_patched)
-		return NULL;
-
-	dbg_correlate("find_twin_positional(): %s%s -> %s%s",
-	    sym1->name, is_func_sym(sym1) ? "()" : "",
-	    match->name, is_func_sym(match) ? "()" : "");
-
-	return match;
+		if (strcmp(orig_sym->name, patched_sym->name) ||
+		    orig_sym->bind != patched_sym->bind ||
+		    !is_twin_candidate(orig_sym, patched_sym))
+			continue;
+		if (has_dwarf_identity(orig_sym) != has_dwarf_identity(patched_sym)) {
+			WARN("unmatched symbol %s (FILE %s): DWARF identity is missing on the %s side",
+			     patched_sym->name,
+			     *patched_entry->file ? patched_entry->file : "<none>",
+			     has_dwarf_identity(orig_sym) ? "patched" : "original");
+			continue;
+		}
+		if (!known_symtab_fallback(orig_sym) || !known_symtab_fallback(patched_sym))
+			WARN("ELF FILE/name fallback outside known rules: %s (FILE %s, binding %u, DWARF %s), orig[%u] -> patched[%u]",
+			     patched_sym->name,
+			     *patched_entry->file ? patched_entry->file : "<none>",
+			     patched_sym->bind, has_dwarf_identity(patched_sym) ? "yes" : "no",
+			     orig_sym->idx, patched_sym->idx);
+		orig_sym->twin = patched_sym;
+		patched_sym->twin = orig_sym;
+		dbg_correlate("%s(): %s (FILE %s)", __func__,
+			      patched_sym->name, patched_entry->file);
+	}
+	ret = 0;
+out:
+	free_symtab_hash(&orig_table);
+	free_symtab_hash(&patched_table);
+	return ret;
 }
 
 /*
@@ -850,96 +833,61 @@ static struct symbol *find_twin_positional(struct elfs *e, struct symbol *sym1)
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
-
-	for (; ; file1_sym = next_file_symbol(e->orig, file1_sym),
-		 file2_sym = next_file_symbol(e->patched, file2_sym)) {
-
-		if (!file1_sym && file2_sym) {
-			ERROR("FILE symbol mismatch: NULL != %s", file2_sym->name);
-			return -1;
-		}
+	struct symbol *sym;
 
-		if (file1_sym && !file2_sym) {
-			ERROR("FILE symbol mismatch: %s != NULL", file1_sym->name);
-			return -1;
-		}
+	for_each_sym(e->orig, sym)
+		sym->dont_correlate = dont_correlate(sym);
+	for_each_sym(e->patched, sym)
+		sym->dont_correlate = dont_correlate(sym);
 
-		if (!file1_sym)
-			break;
+	if (prepare_identities(e->orig) || prepare_identities(e->patched))
+		return -1;
 
-		if (strcmp(file1_sym->name, file2_sym->name)) {
-			ERROR("FILE symbol mismatch: %s != %s", file1_sym->name, file2_sym->name);
-			return -1;
-		}
+	if (correlate_by_identity(e) ||
+	    extend_same_twins_by_checksum(e) ||
+	    validate_symbol_twins(e))
+		return -1;
 
-		file1_sym->twin = file2_sym;
-		file2_sym->twin = file1_sym;
+	for_each_sym(e->orig, sym) {
+		if (!sym->len || is_compound_constant(sym))
+			continue;
+		if (!reference_twin(sym) && !sym->dont_correlate)
+			WARN("no correlation: %s", sym->name);
 	}
 
+	return 0;
+}
 
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
-				continue;
-			sym2 = find_twin(e, sym1);
-			if (!sym2)
-				continue;
-			sym1->twin = sym2;
-			sym2->twin = sym1;
-			progress = true;
-		}
+static int check_linkage_changes(struct elfs *e)
+{
+	struct symbol *orig_sym, *patched_sym;
 
-		if (update_suffix_map(e->orig))
-			return -1;
+	for_each_sym(e->orig, orig_sym) {
+		if (orig_sym->twin || orig_sym->dont_correlate ||
+		    !has_dwarf_identity(orig_sym) || is_undef_sym(orig_sym) || !orig_sym->len)
+			continue;
 
-		for_each_sym(e->orig, sym1) {
-			if (sym1->twin || sym1->dont_correlate)
+		/*
+		 * Identities distinguish linkage changes, but later name-based
+		 * resolution can bind references to the wrong state. Reject them.
+		 */
+		for_each_sym_by_demangled_name(e->patched, orig_sym->identity.demangled_name,
+					       patched_sym) {
+			if (patched_sym->twin || patched_sym->dont_correlate ||
+			    !has_dwarf_identity(patched_sym) ||
+			    is_undef_sym(patched_sym) || !patched_sym->len)
 				continue;
-			sym2 = find_twin_suffixed(e->patched, sym1);
-			if (!sym2)
+			if (orig_sym->type != patched_sym->type ||
+			    strcmp(orig_sym->identity.scope, patched_sym->identity.scope) ||
+			    orig_sym->identity.external == patched_sym->identity.external)
 				continue;
-			sym1->twin = sym2;
-			sym2->twin = sym1;
-			progress = true;
+			ERROR("unsupported linkage change (%s, %s): original %s symtab[%u] (external=%d), patched %s symtab[%u] (external=%d)",
+			      orig_sym->identity.scope, orig_sym->identity.demangled_name,
+			      orig_sym->name, orig_sym->idx, orig_sym->identity.external,
+			      patched_sym->name, patched_sym->idx, patched_sym->identity.external);
+			return -1;
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
 	}
-
-	for_each_sym(e->orig, sym1) {
-		if (sym1->twin || sym1->dont_correlate)
-			continue;
-		WARN("no correlation: %s", sym1->name);
-	}
-
 	return 0;
 }
 
@@ -1110,7 +1058,8 @@ static int mark_changed_functions(struct elfs *e)
 
 	/* Find added functions and print them */
 	for_each_sym(e->patched, patched_sym) {
-		if (!is_func_sym(patched_sym) || patched_sym->dont_correlate)
+		if (!is_func_sym(patched_sym) || patched_sym->dont_correlate ||
+		    is_undef_sym(patched_sym))
 			continue;
 
 		if (!patched_sym->twin) {
@@ -1231,7 +1180,7 @@ static bool klp_reloc_needed(struct reloc *patched_reloc)
 		return export->mod_ns;
 	}
 
-	if (!patched_sym->twin) {
+	if (!reference_twin(patched_sym)) {
 		/*
 		 * Presumably the symbol and its reference were added by the
 		 * patch.  The symbol could be defined in this .o or in another
@@ -1376,6 +1325,7 @@ static int clone_reloc_klp(struct elfs *e, struct reloc *patched_reloc,
 {
 	const char *sym_modname, *sym_orig_name, *sec_objname;
 	struct symbol *patched_sym = patched_reloc->sym;
+	struct symbol *orig_sym = reference_twin(patched_sym);
 	s64 addend = reloc_addend(patched_reloc);
 	char tombstone_name[SYM_NAME_LEN];
 	struct symbol *sym, *klp_sym;
@@ -1386,7 +1336,7 @@ static int clone_reloc_klp(struct elfs *e, struct reloc *patched_reloc,
 	struct klp_reloc klp_reloc;
 	unsigned long sympos;
 
-	if (!patched_sym->twin) {
+	if (!orig_sym) {
 		if (!export) {
 			ERROR("unexpected klp reloc for new symbol %s", patched_sym->name);
 			return -1;
@@ -1443,8 +1393,8 @@ static int clone_reloc_klp(struct elfs *e, struct reloc *patched_reloc,
 		if (!sym_modname)
 			return -1;
 
-		sym_orig_name = patched_sym->twin->name;
-		sympos = klp_find_sympos(e->orig, patched_sym->twin);
+		sym_orig_name = orig_sym->name;
+		sympos = klp_find_sympos(e->orig, orig_sym);
 		if (sympos == ULONG_MAX)
 			return -1;
 	}
@@ -1546,6 +1496,7 @@ static int clone_reloc(struct elfs *e, struct reloc *patched_reloc,
 	struct symbol *out_sym;
 	bool klp;
 
+	/* Reject ambiguous data references before treating them as new. */
 	klp = klp_reloc_needed(patched_reloc);
 
 	dbg_clone_reloc(sec, offset, patched_sym, addend, export, klp);
@@ -2291,6 +2242,9 @@ int cmd_klp_diff(int argc, const char **argv)
 	if (correlate_symbols(&e))
 		return -1;
 
+	if (check_linkage_changes(&e))
+		return -1;
+
 	ret = mark_changed_functions(&e);
 	if (ret < 0)
 		return -1;
diff --git a/tools/objtool/tests/generic/fixtures/identity/unique_id.c b/tools/objtool/tests/generic/fixtures/identity/unique_id.c
new file mode 100644
index 000000000000..df79605bc192
--- /dev/null
+++ b/tools/objtool/tests/generic/fixtures/identity/unique_id.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2026 Longjun Luo <luolongjuna@gmail.com> */
+#include "common.h"
+MODINFO;
+
+#define PASTE0(a, b) a##b
+#define PASTE(a, b) PASTE0(a, b)
+#define UNIQUE_ID(name) PASTE(__UNIQUE_ID_, PASTE(name, PASTE(_, __COUNTER__)))
+#define MAX_VALUE(a, b, id) ({ __typeof__(a) id = (a); id > (b) ? id : (b); })
+#define MAX(a, b) MAX_VALUE(a, b, UNIQUE_ID(max))
+
+struct descriptor {
+	const char *function;
+	const char *file;
+	const char *format;
+	unsigned int line;
+	unsigned int flags;
+};
+
+extern void emit(struct descriptor *desc, int value);
+
+/* pr_debug() descriptors carry a per-TU counter in their names. */
+#define DEBUG_CALL(id, fmt, value) do { \
+	static struct descriptor id __attribute__((used, aligned(8), section("__dyndbg"))) = { \
+		__func__, __FILE__, fmt, __LINE__, 0 \
+	}; \
+	if (id.flags) \
+		emit(&id, value); \
+} while (0)
+#define DEBUG(fmt, value) DEBUG_CALL(UNIQUE_ID(ddebug), fmt, value)
+
+NOIPA int clamp_value(int value)
+{
+#ifdef PATCHED
+	return MAX(value, 1);
+#else
+	return value > 0 ? value : 0;
+#endif
+}
+
+NOIPA void report(int value)
+{
+#if defined(PATCHED) && defined(CHANGE_REPORT)
+	value++;
+#endif
+	DEBUG("first", value);
+#ifdef TWO
+	DEBUG("second", value + 1);
+#endif
+}
diff --git a/tools/objtool/tests/generic/test-identity-unique-id.sh b/tools/objtool/tests/generic/test-identity-unique-id.sh
new file mode 100755
index 000000000000..d4dbaafbe575
--- /dev/null
+++ b/tools/objtool/tests/generic/test-identity-unique-id.sh
@@ -0,0 +1,31 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2026 Longjun Luo <luolongjuna@gmail.com>
+# Adding a counter-using macro must preserve existing dynamic debug descriptors.
+. "$(dirname "$0")/../identity-lib.sh"
+
+setup
+for flags in "" "-DTWO" "-DTWO -DCHANGE_REPORT"; do
+	build_pair identity/unique_id.c $flags
+	if [[ "$flags" != *CHANGE_REPORT* ]]; then
+		assert_checksum_matches report
+	fi
+	run_diff
+	assert_patched clamp_value
+	assert_no_section __dyndbg
+	diff_log | grep -q 'no correlation:' && fail "dynamic debug descriptor lost correlation"
+	if [[ "$flags" == *CHANGE_REPORT* ]]; then
+		assert_patched report
+		old="$(in_symbols orig.o |
+			awk '$4 == "OBJECT" && $8 ~ /__UNIQUE_ID_ddebug_/ { print $8 }')"
+		[ "$(echo "$old" | wc -w)" = 2 ] || fail "expected two original descriptors"
+		run_post_link
+		for sym in $old; do
+			assert_original_reference report "$sym"
+		done
+	else
+		assert_not_patched report
+	fi
+done
+
+pass "counter shifts preserve descriptors in unchanged and changed functions"
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
index 8e1aa7614dc6..44ce670c4a6c 100644
--- a/tools/objtool/tests/lib.sh
+++ b/tools/objtool/tests/lib.sh
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
2.55.0

