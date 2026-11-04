Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793799145;
	b=TDWu/ifVjc8iVjkNnLIlFwzlQ35POpfS3lKnlX0ptnw4JKDQcFe/KMAld5+1QtBEp4q/
	 dM54KZVrgwW8RobuF/QUzHc1UnLX3vI4g5ouFTcT71vhxjM2mUXQCGDXZnGpsIt3GzBb5
	 clYdzQ9pDkJYXL6e7KcOGVLCVo0/1ne3Fi6SliMuzMEDEASpfULS+ekFjBp8KjXubfX1x
	 fVwNI6TZZfdzHVWfqL3gL2AhF8N9ovR+oy+GsH/9w0ACLZ/z5VsJ1xvIMDDS2LgTxiozW
	 um3poixy0dvy+/wPduaHtol3k4zuHyYPHxtgMXtNvfvB5lbpf3HyBV1aVjH0Vim5hvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793799145;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ZvUnOQZUAvdfLCd2VRF9QUxe4TjAvf7oYVqXhFNQnhg=;
	b=FS9lG2wTy9DL+t+SXoEAxzmDxZ1y/PuZkvWwD1avVey4KM6pGnB8cYuIr2aXG1Ekh8BK
	 OazzLjXEZ3aXSMWPJBq5tz6+en+ANTWcr5wyjQxPBleG/KNKnsVaUBMJuDg9Ku9datrQD
	 qNn0ojypXW+6ts7Of3B1kMjt2k7jckbObfEwajElck88izxTEyON+nOKikZSOm8WNB+IH
	 cplYraoqwomx94TJK5eEx+I/2htIzmDMoBgfNefvRV4/Vzwb1UlicUJsyq7n5up2GdjWk
	 Y+xw8D2zNzgRgD059Jl5qZflNTdjnZirV9nDJUjn0rPbWcDbxgsGZXsNYDZnxcL9C/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Qp3KbvfQ;
	arc=none smtp.remote-ip=209.85.210.179
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9F8606A333
	for <live-patching@vger.kernel.org>; Wed,  4 Nov 2026 13:32:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C9F8606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Qp3KbvfQ
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-89ff475a152so309194b3a.3
        for <live-patching@vger.kernel.org>; Wed, 04 Nov 2026 05:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793799144; x=1794403944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZvUnOQZUAvdfLCd2VRF9QUxe4TjAvf7oYVqXhFNQnhg=;
        b=Qp3KbvfQI881EP16oTf2x8KjwNYb+j/jVxdQkTDBqQRIBmWKu8WFD3ilKbnP9bN1Kr
         M4g3P+nqGXJF216M8tprFUpopZ2lZ0hqpwTouommxTEFCX+nhVobpu0byPCgF8/rPiRI
         zwmN3yPc9KJuj/9my/81QIkEFO/Klytb4Tja9Jnqco45g71pB7rZRT9+G77bp2OSAB2f
         etwK/A3TWsQkA3nQ5CwPDD8uZjeKhFKkE24P4v0qi/E1tT1Wfz+gc8y+ncS+sLq3rJZ/
         WHoDDbexq/iioOEEV8Pa+ogRW6vJtdmxT4ar01O+IunNCiPGpe+z7xHz99x/EVK/p1QC
         lc5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793799144; x=1794403944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZvUnOQZUAvdfLCd2VRF9QUxe4TjAvf7oYVqXhFNQnhg=;
        b=Ql86WqPrY0ZBQ2FDTmpZiOTROvY+l14w7VDr36Y6zRDEuNJ91UUnrHDXn4cmyjtvEK
         m1+aa3/2bZ46/IA19N5BRP//UbjoLQleYsZ0WuT81Hh8hZMcohrDBLg1CjttNUJ4/iLz
         K7/CSWhuyOQRbjjVXFdytplliSPtUEAwaVxZwLbt8qsKv3qwYQ9/+An3efLgmZ/z+NBP
         xisqMRwgaIZLYxXnRAbZuAQI9W4K1wPfaN41vn7I2GqpjgPWl2i4f3AsE10aCFmh+pf8
         /BTRd9zMrG3wQgw4V5y0APLPLHMGe9foOQXwBWOG4nZIJM0HR7WgSdodp/OS5wLI7VvZ
         3+BA==
X-Forwarded-Encrypted: i=1; AKwUvBxRgmXAfpg6n4zH76ts5JO9o6OH/TTP+TnAGTj1dRGfQX1QV+SBe+ZqDAbysupaw19OBjhSFwB+SteEmQv3@vger.kernel.org
X-Gm-Message-State: APuU4Z8PcOhnVDSBP2uFG/37C/KMi3W+qtfFIefYORg0G4VpvYtMn5vc
	jYbpDiR3HNL80fpH+NtWtw6JUFQcMUuKx6kA4XQqWMS3Je4OQgaJqXkv
X-Gm-Gg: AYBFou2UMGQZ7pMMQ/P0rZoXHTGo7Ylmp76NZk1w6RZQ4ffAc+Lc1/CT1bTrGhtMN/e
	c0dIG1JS1+pqQIu+zoDFuB2kzFHRB6CS0JxXYSTO32nNBNxCE/EmL9b4+w3AT8WdQaxbiVAuOYe
	yrWB6nV1Itpx4A2Ercex/rVx4xALSMCeZrbIHbchWGzrZaWnzajFSPOcBb+eCVYc6Xz8trDY44D
	07AtCGnRmYd4FG4DiyMq79tY5Anu2ONOymSOyfrpAmx0Y0pQTJyKMT7REf1gVjSZDcKjsJlzmWT
	nWPM7frLnYwcFOLgGt4vdHvYUaH75uTdUJk+UTH2FekjAxte4PYt8Tk5Hz1zdeshbGGEvMv9B9z
	HWyEhyvtzLCk8CfYaC4E3xH47MaQ/XmYebafFfnnCCHy5q/4YRmfGGQyHuM5gV6hyDp0y3PdMT9
	RzT704nEVUvhJVFX6c47PVE2bUyDsY8ahdQ+0WKkjJ9eRn3b5wOOzuu/9Ucr8G0R2N5AY5SmE5+
	Z0m3skGhFxUesom4RbyDfM0O6+Cu919+U42aXlcIFyU/aNThU4A4Xykht/dSMOCq4IexAi5OR7B
	5nRZ//TJB5tcx5cm4XpZWiqwK7ty3sD92MaGTFlmfFWDKyPY0A==
X-Received: by 2002:a05:6a20:cd46:b0:3eb:39fd:bad9 with SMTP id adf61e73a8af0-3eb39fdda66mr6074874637.49.1793799143604;
        Wed, 04 Nov 2026 05:32:23 -0800 (PST)
Received: from anatasluo-Precision-5560 ([139.226.166.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b09a7ce84fsm911369b3a.13.2026.11.04.05.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 05:32:23 -0800 (PST)
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
Subject: [RFC PATCH v2 02/11] objtool/klp: Hash compound literals by content
Date: Wed,  4 Nov 2026 21:31:48 +0800
Message-ID: <20261104133158.3187525-3-luolongjuna@gmail.com>
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

Compiler-generated names for compound literals do not describe their
contents. Changes to an anonymous array or a callback in an anonymous
structure can leave the referring function's checksum unchanged.

Hash compound contents and relocations recursively, using the resulting
checksum in references. Preserve target offsets and stop at named
objects. Reject cycles and nesting beyond three compound objects.

Recognize GCC and Clang compound literal names in both writable and
read-only sections. Add tests for changed array elements and callbacks.

Validated the available objtool tests with GCC 16.2.1 and Clang
22.1.8. No failures.

Assisted-by: LLM
Signed-off-by: Longjun Luo <luolongjuna@gmail.com>
---
 tools/objtool/include/objtool/klp.h           |   2 +
 tools/objtool/klp-checksum.c                  | 102 +++++++++++++-----
 tools/objtool/klp-diff.c                      |  31 ++++++
 .../generic/fixtures/identity/compound.c      |  65 +++++++++++
 .../tests/generic/test-identity-compound.sh   |  13 +++
 5 files changed, 187 insertions(+), 26 deletions(-)
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/compound.c
 create mode 100755 tools/objtool/tests/generic/test-identity-compound.sh

diff --git a/tools/objtool/include/objtool/klp.h b/tools/objtool/include/objtool/klp.h
index c57775d78c71..90468e141124 100644
--- a/tools/objtool/include/objtool/klp.h
+++ b/tools/objtool/include/objtool/klp.h
@@ -51,6 +51,8 @@ struct objtool_file;
 struct elf;
 struct symbol;
 
+bool is_compound_constant(struct symbol *sym);
+
 int klp_create_symid_sections(struct objtool_file *file);
 
 int klp_sympos_init(struct elf *orig);
diff --git a/tools/objtool/klp-checksum.c b/tools/objtool/klp-checksum.c
index efaf083c03a1..2a515c7e2bf6 100644
--- a/tools/objtool/klp-checksum.c
+++ b/tools/objtool/klp-checksum.c
@@ -11,6 +11,8 @@
 #include <objtool/warn.h>
 #include <objtool/checksum.h>
 
+#define COMPOUND_MAX_DEPTH 3
+
 static int checksum_debug_init(struct objtool_file *file)
 {
 	char *dup, *s;
@@ -67,6 +69,14 @@ static bool is_anonymous_const_data(struct symbol *sym)
 	       (is_sec_sym(sym) || strstarts(sym->name, ".LC"));
 }
 
+static bool is_const_reference(struct symbol *sym)
+{
+	return is_string_sec(sym->sec) || is_anonymous_const_data(sym);
+}
+
+static int checksum_object(struct objtool_file *file, struct symbol *sym,
+			   unsigned int depth);
+
 static int checksum_update_insn(struct objtool_file *file, struct symbol *func,
 				struct instruction *insn)
 {
@@ -74,7 +84,9 @@ static int checksum_update_insn(struct objtool_file *file, struct symbol *func,
 	struct alternative *alt;
 	unsigned long offset;
 	struct symbol *sym;
+	const void *data;
 	static bool in_alt;
+	ssize_t size;
 
 	if (insn->fake)
 		return 0;
@@ -134,10 +146,9 @@ static int checksum_update_insn(struct objtool_file *file, struct symbol *func,
 	sym = reloc->sym;
 	offset = arch_insn_adjusted_addend(insn, reloc);
 
-	if (is_string_sec(sym->sec)) {
-		ssize_t size = elf_string_len(sym->sec, sym->offset + offset);
-		const void *data;
-
+	if (is_const_reference(sym)) {
+		size = is_string_sec(sym->sec) ? elf_string_len(sym->sec, sym->offset + offset) :
+					      sym->sec->sh.sh_entsize;
 		if (size < 0)
 			return -1;
 		data = sym->sec->data->d_buf + sym->offset + offset;
@@ -145,14 +156,6 @@ static int checksum_update_insn(struct objtool_file *file, struct symbol *func,
 		goto alts;
 	}
 
-	if (is_anonymous_const_data(sym)) {
-		void *cst;
-
-		cst = sym->sec->data->d_buf + sym->offset + offset;
-		__checksum_update_insn(func, insn, cst, sym->sec->sh.sh_entsize);
-		goto alts;
-	}
-
 	if (is_sec_sym(sym)) {
 		sym = find_symbol_containing(reloc->sym->sec, offset);
 		if (!sym)
@@ -161,8 +164,15 @@ static int checksum_update_insn(struct objtool_file *file, struct symbol *func,
 		offset -= sym->offset;
 	}
 
-	__checksum_update_insn(func, insn, sym->demangled_name,
-			       strlen(sym->demangled_name));
+	if (is_compound_constant(sym)) {
+		if (checksum_object(file, sym, 1))
+			return -1;
+		__checksum_update_insn(func, insn, &sym->csum.checksum,
+				       sizeof(sym->csum.checksum));
+	} else {
+		__checksum_update_insn(func, insn, sym->demangled_name,
+				       strlen(sym->demangled_name));
+	}
 	__checksum_update_insn(func, insn, &offset, sizeof(offset));
 
 alts:
@@ -198,7 +208,8 @@ static int checksum_update_insn(struct objtool_file *file, struct symbol *func,
 	return 0;
 }
 
-static int checksum_update_object(struct objtool_file *file, struct symbol *sym)
+static int checksum_update_object(struct objtool_file *file, struct symbol *sym,
+				  unsigned int depth)
 {
 	struct reloc *reloc;
 
@@ -212,38 +223,79 @@ static int checksum_update_object(struct objtool_file *file, struct symbol *sym)
 	sym_for_each_reloc(file->elf, sym, reloc) {
 		unsigned long sym_offset = reloc_offset(reloc) - sym->offset;
 		struct symbol *target = reloc->sym;
+		unsigned int type = reloc_type(reloc);
+		const void *data;
+		ssize_t size;
 		s64 offset;
 
 		offset = reloc_addend(reloc);
 
-		if (is_string_sec(target->sec)) {
-			ssize_t size = elf_string_len(target->sec, target->offset + offset);
-			const void *data;
+		__checksum_update_object(sym, sym_offset, "reloc type",
+					 &type, sizeof(type));
 
+		if (is_const_reference(target)) {
+			size = is_string_sec(target->sec) ?
+				elf_string_len(target->sec, target->offset + offset) :
+				target->sec->sh.sh_entsize;
 			if (size < 0)
 				return -1;
 			data = target->sec->data->d_buf + target->offset + offset;
-			__checksum_update_object(sym, sym_offset, "reloc string", data, size);
+			__checksum_update_object(sym, sym_offset, "reloc constant", data, size);
 			continue;
 		}
 
 		if (is_sec_sym(target)) {
 			target = find_symbol_containing(reloc->sym->sec, offset);
-			if (!target)
+			if (!target) {
+				if (is_compound_constant(sym)) {
+					ERROR("%s+%#lx: unresolved compound constant reference",
+					      sym->name, sym_offset);
+					return -1;
+				}
 				continue;
+			}
 
 			offset -= target->offset;
 		}
 
-		__checksum_update_object(sym, sym_offset, "reloc name",
-					 target->demangled_name,
-					 strlen(target->demangled_name));
+		if (is_compound_constant(target)) {
+			if (checksum_object(file, target, depth + 1))
+				return -1;
+			__checksum_update_object(sym, sym_offset, "reloc compound",
+						 &target->csum.checksum,
+						 sizeof(target->csum.checksum));
+		} else {
+			__checksum_update_object(sym, sym_offset, "reloc name",
+						 target->demangled_name,
+						 strlen(target->demangled_name));
+		}
 		__checksum_update_object(sym, sym_offset, "reloc addend",
 					 &offset, sizeof(offset));
 	}
 	return 0;
 }
 
+/* Count only consecutive compound constants; named targets use their identity. */
+static int checksum_object(struct objtool_file *file, struct symbol *sym,
+			   unsigned int depth)
+{
+	if (depth > COMPOUND_MAX_DEPTH) {
+		ERROR("%s: compound constant nesting exceeds %u levels",
+		      sym->name, COMPOUND_MAX_DEPTH);
+		return -1;
+	}
+	if (sym->csum.state) {
+		ERROR("%s: cyclic compound constant reference", sym->name);
+		return -1;
+	}
+
+	checksum_init(sym);
+	if (checksum_update_object(file, sym, depth))
+		return -1;
+	checksum_finish(sym);
+	return 0;
+}
+
 int calculate_checksums(struct objtool_file *file)
 {
 	struct instruction *insn;
@@ -272,10 +324,8 @@ int calculate_checksums(struct objtool_file *file)
 			checksum_finish(sym);
 
 		} else if (is_object_sym(sym)) {
-			checksum_init(sym);
-			if (checksum_update_object(file, sym))
+			if (checksum_object(file, sym, is_compound_constant(sym) ? 1 : 0))
 				return -1;
-			checksum_finish(sym);
 		}
 
 	}
diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
index 6321f691adbb..0391f91a8d31 100644
--- a/tools/objtool/klp-diff.c
+++ b/tools/objtool/klp-diff.c
@@ -438,6 +438,37 @@ static bool is_anonymous_rodata(struct symbol *sym)
 	       (!is_object_sym(sym) || strstarts(sym->sec->name, ".rodata.cst"));
 }
 
+/* GCC and Clang give compound literals generated names, not source identities. */
+bool is_compound_constant(struct symbol *sym)
+{
+	const char *name = sym->name;
+
+	if (!is_object_sym(sym) || is_undef_sym(sym) || !sym->len ||
+	    !sym->sec)
+		return false;
+
+	if (strstarts(name, ".compoundliteral"))
+		name += strlen(".compoundliteral");
+	else if (strstarts(name, "__compound_literal"))
+		name += strlen("__compound_literal");
+	else
+		return false;
+
+	while (*name == '.' && isdigit((unsigned char)name[1])) {
+		name++;
+		while (isdigit((unsigned char)*name))
+			name++;
+	}
+	if (strstarts(name, ".llvm.")) {
+		name += strlen(".llvm.");
+		if (!isdigit((unsigned char)*name))
+			return false;
+		while (isdigit((unsigned char)*name))
+			name++;
+	}
+	return !*name;
+}
+
 /*
  * These symbols should never be correlated, so their local patched versions
  * are used instead of linking to the originals.
diff --git a/tools/objtool/tests/generic/fixtures/identity/compound.c b/tools/objtool/tests/generic/fixtures/identity/compound.c
new file mode 100644
index 000000000000..bf607bdd6093
--- /dev/null
+++ b/tools/objtool/tests/generic/fixtures/identity/compound.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2026 Longjun Luo <luolongjuna@gmail.com> */
+#include "common.h"
+MODINFO;
+extern void observe(int value);
+
+NOIPA int read_value(int value)
+{
+	return value + 1;
+}
+
+NOIPA int other_value(int value)
+{
+	return value + 2;
+}
+
+#ifdef WRITABLE
+#define CONST
+#else
+#define CONST const
+#endif
+
+struct config {
+	CONST unsigned int *values;
+	const char *label;
+	int (*read)(int value);
+};
+
+#if defined(PATCHED) && defined(CHANGE_LEAF)
+#define FIRST 12
+#else
+#define FIRST 11
+#endif
+#if defined(PATCHED) && defined(CHANGE_TARGET)
+#define READ other_value
+#else
+#define READ read_value
+#endif
+
+static CONST struct config *const first = &(CONST struct config) {
+	(CONST unsigned int[]) { FIRST, 22, 33, 44, 55, 66, 77, 88 }, "table", READ
+};
+static CONST struct config *const second = &(CONST struct config) {
+	(CONST unsigned int[]) { 11, 22, 33, 44, 55, 66, 77, 88 }, "table", read_value
+};
+
+NOIPA CONST struct config *target(int value)
+{
+#if defined(PATCHED) && defined(CHANGE_FUNCTION)
+	if (value < 0)
+		return (void *)0;
+#endif
+	observe(value);
+#ifdef AMBIGUOUS
+	return value ? first : second;
+#else
+	return first;
+#endif
+}
+
+NOIPA CONST struct config *unchanged(int value)
+{
+	observe(value);
+	return second;
+}
diff --git a/tools/objtool/tests/generic/test-identity-compound.sh b/tools/objtool/tests/generic/test-identity-compound.sh
new file mode 100755
index 000000000000..76b16616b32c
--- /dev/null
+++ b/tools/objtool/tests/generic/test-identity-compound.sh
@@ -0,0 +1,13 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2026 Longjun Luo <luolongjuna@gmail.com>
+# Array contents and callbacks contribute to the referring function's checksum.
+. "$(dirname "$0")/../identity-lib.sh"
+
+setup
+for change in CHANGE_LEAF CHANGE_TARGET; do
+	build_pair identity/compound.c "-D$change"
+	assert_checksum_differs target
+done
+
+pass "compound contents contribute to reference checksums"
-- 
2.55.0

