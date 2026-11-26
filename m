Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795690424;
	b=Ynjh15y3Vd7DAja/xljAnVhTgzWLy34+u4JlP2oXYLdw5Aai3ENwNkVu/FYFeYB9dmZJ
	 Lzkrme57bcjwcuhvvYJht1HuFp3PnnJADBn6HdBOaV2vND7UehfLOFNX1Qihg/wnGaZhP
	 42+Hdfjo3jlcFcrASaOdZHRd7rgg0XVGK2vgePSXKH4VVv6TDnCr2A23SDd08WJ71mwGz
	 3kuujXrQqSNDqgUaJXvon5Pgq+9oMhaSs3mahjUtrD+EcLe8l1MoRaezcNOKgI1W4WK40
	 7IHTToZrBoqb2gC8fDv5kJ81LnTq9go6xYL1yPprobVWBjxhR33thmKj1kiKpjpnUiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795690424;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8RnxPSTHJj6ssbwJH49Q6KtCPv2E9H09AK7eDPufzS8=;
	b=uR4PoVlXCugtTNW0B2xSLKSJrCVfX9rGqo4JOgt4SQdO59Yf9A+/RrLBLc/B/Jr1awvk
	 WGP76v7cddmgkpUYI+dRmcdvZmVJugWUYnS7/OWMSe2uzZceIWEdf51hFDmiCIcelARq8
	 KpdTx80Mc6s+XXJK7XpLdw+H5VHZwy4ct43p+7LeQSEVD5lB+qS0slht4a4rXuUdd2DB0
	 06UPG0XkXwWDKABIIixckBbA+8fQlk3BVMFPSyXVQwzN4cPOgGLMgfGAQqFzRfQFsfxuo
	 GCXJvU9JB1IaWtOHY38WPJF93Vknbkp2IPO4UopAlFLS79lxn3srPz2t0MxGsYA2Cxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UHzlEe+O;
	arc=none smtp.remote-ip=209.85.215.169
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944B9606A327
	for <live-patching@vger.kernel.org>; Thu, 26 Nov 2026 10:53:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 944B9606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UHzlEe+O
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cdd9d0c9bbdso3968981a12.1
        for <live-patching@vger.kernel.org>; Thu, 26 Nov 2026 02:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795690423; x=1796295223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8RnxPSTHJj6ssbwJH49Q6KtCPv2E9H09AK7eDPufzS8=;
        b=UHzlEe+O6HUZfKiZmTvjD3BKEi7wPYWRNQaRDqsQ+srgles2kuwJvCixsBGAjYuI4X
         +cvUoqdUY3EgUTiKUUDvVOwEuNhfNPVYSMe3mTWqS9JQp58isO/WzRwes0LUgrJPWUBw
         vGt/X+8oW28vIzuXmlTqtN92HJFrwC2yR28yGZ/e2MQsuh/zLudXngsEI141eB0cXTYb
         UI/LfwPOtK+itWTpRVqZBulVDqIL34X9pTrPm0OBEMkkZ49dVfujLXK7csJH41I+xV4f
         Fr3tX5V060HYFSFMM3uhJ5u0jcG8TJ7BVwMobox6N7YeLUjOlZamCvIHEVoCUw48Ez5C
         LDSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795690423; x=1796295223;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8RnxPSTHJj6ssbwJH49Q6KtCPv2E9H09AK7eDPufzS8=;
        b=yayoPjU6QEfprJEl8VyZvNN9kUazq6/I12wrIzDuTWOUUpJlYHxhpOS9ZxvYPmqczm
         +KYacs5dBMy85o/lVi4aQhfD8fRo8eUrTyUwuMCWjVRul6i1Ju+dPh5BPaE6sJAjVINe
         fAgPdQ7oDhLe9lbiVpFBhlodSS7j7+Jb0xLnF9WFbVAhflgKUBO/64x7L2rllQwxL959
         OKQ4vwZwLzEdt9/n79NFmVjQVExPq3pW0Q2l4Ro1Yk/5dbPm1mLJC59C0qj/UZ3WIcn2
         cF01b0VMRhO5wx9FRUY7b/jbvjciAqlH3RC8FJpxrnYXqcL2LC1TR/oTUbbVqTifnS/A
         RIkg==
X-Forwarded-Encrypted: i=1; AL+hErFMzWHmRlc71wmqcITLYtgYPpkPFN+TT+32zImyiB/n2gBDcOiq2yF2pK04W2goBtwTjVX4qsz0fKaLDX3K@vger.kernel.org
X-Gm-Message-State: APuU4Z9KbJijHQfpNv76Jtp6H5/btwCAoQozxkmI50S8TkzuBhIrqUpM
	Q/gYVjUI69dQtM8e1YdRJtmKQvESO2hTCVvo6areij4gizXMNF8hVyIC
X-Gm-Gg: AZFdTZfIOtOvq04dPSygnO7HtlwVXo2ZnocGpLatmhiaUPp7qNWMtRV6wdEoq+zgxNp
	+7HJ1yUmw7XfLYR7GMeMHyjyxZ1Dk87X2SJNo/SNa4pkG5+RASoe9Wv94u84/W/9lsBthDBNxNH
	PYHnlDAdfuQufHbW0ZwHzBsMf6ZQMbdyhWPGR+5hyQ0GX9nwy/F7rGJNlTocttKuVmTlCwZzDN1
	+k7PK6wrMit5JbFrVwcdNVzZdQQUPLql84Q49tR2PxfE46ikYm+62xWtioMzVBKyVmc6Mmw9MK9
	+N0bu1w41dDNSsTUWW/bBGmxO2wTIczbbJi+vVxYQi3/PGwr+FFDJB+f4OlGVxfe/7nlGn1zG8I
	FJpKQWBBOCRBoV9uXmvzScxQ5Qlc1/BfGY8WwQSb/+NEyQQ29Yf6EEHSwky+iTdjMywxSUOfqut
	qeoTc9Klv1/Km7nxcbBrF4QHfeFLDyV80O8elm/m3NZbeBOVdDn13VUUTGyLwpfX+X3QhKgiOvi
	O6jb2RWwD9h6PirctOICsv6CWcpJfFJ/E0+mc/Fhb96XgMzaS6EQnN/d1v/9jjpneUj9RSauffG
	xNfvCOXCRcS+GuonjQxf+ubWbcMTA9FVsr/eRhcJNpSh0JW4DUsa
X-Received: by 2002:a17:90b:4b:b0:3ab:e588:c2a8 with SMTP id 98e67ed59e1d1-3b41c9ba0e4mr18519397a91.64.1795690422704;
        Thu, 26 Nov 2026 02:53:42 -0800 (PST)
Received: from anatasluo-Precision-5560 ([2408:820c:d29:db90:58ff:756e:834a:9b39])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b40578dca0sm35469676a91.2.2026.11.26.02.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 02:53:42 -0800 (PST)
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
Subject: [PATCH 1/2] objtool/klp: Fix the offset and length used to read SHF_STRINGS data
Date: Thu, 26 Nov 2026 18:53:24 +0800
Message-ID: <20261126105325.2521938-1-luolongjuna@gmail.com>
X-Mailer: git-send-email 2.53.0
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

For offset, handle PC-relative references, like the one in
proc_ns_dir_lookup() with Clang ThinLTO. Use arch_adjusted_addend()
to read the string, and generate symbol-based relocations when needed.

For length, add support for wide strings. The u16 psr_setup_time_us[]
table is placed in a wide-string section by Clang. The table
occupies 14 bytes, while strlen() gives objtool a length of only 5 bytes.

With GCC and Clang, the test catches both wide string truncation and a
missing PC-relative adjustment.

Fixes: 0d83da43b1e1 ("objtool/klp: Add --checksum option to generate per-function checksums")
Fixes: dd590d4d57eb ("objtool/klp: Introduce klp diff subcommand for diffing object files")
Fixes: 873a2208ea31 ("objtool/klp: Calculate object checksums")
Signed-off-by: Longjun Luo <luolongjuna@gmail.com>
---
Ran the test suite on x86-64 (tip/objtool/core, b99a5337da3c).
Same results with patch 1 alone and with both patches.

GCC 12.2.0 (-fno-pie)  49 passed, 4 skipped
Clang 17.0.6           51 passed, 2 skipped

With this GCC's default PIE, the same 35 tests fail with or without
the patches.

Codex helped write the new tests.

 tools/objtool/elf.c                           | 27 +++++++++++++-
 tools/objtool/include/objtool/elf.h           |  1 +
 tools/objtool/klp-checksum.c                  |  6 ++-
 tools/objtool/klp-diff.c                      | 37 ++++++++++++++++---
 .../tests/generic/fixtures/checksum_insn.c    | 11 ++++++
 .../tests/generic/test-checksum-insn.sh       | 18 +++++++++
 6 files changed, 91 insertions(+), 9 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index a791f4ea6ec1..4a8698114666 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -1382,9 +1382,32 @@ struct elf *elf_create_file(GElf_Ehdr *ehdr, const char *name)
 	return elf;
 }
 
+static size_t __elf_strlen(const char *str, size_t width, size_t size)
+{
+	size_t len;
+
+	for (len = 0; size - len >= width; len += width) {
+		if (!memchr_inv(str + len, 0, width))
+			return len;
+	}
+	return 0;
+}
+
+/*
+ * Same as strlen, add support for wide strings like:
+ *   u16 psr_setup_time_us[] from the DRM DisplayPort helpers.
+ * Clang puts this data into a wide string section with sh_entsize = 2.
+ */
+size_t elf_strlen(struct section *sec, unsigned long offset)
+{
+	return __elf_strlen(sec->data->d_buf + offset, sec->sh.sh_entsize ?: 1,
+			    sec_size(sec) - offset);
+}
+
 unsigned int elf_add_string(struct elf *elf, struct section *strtab, const char *str)
 {
 	unsigned int offset;
+	size_t width, len;
 
 	if (!strtab)
 		strtab = find_section_by_name(elf, ".strtab");
@@ -1399,8 +1422,10 @@ unsigned int elf_add_string(struct elf *elf, struct section *strtab, const char
 	}
 
 	offset = ALIGN(sec_size(strtab), strtab->sh.sh_addralign);
+	width = strtab->sh.sh_entsize ?: 1;
+	len = __elf_strlen(str, width, SIZE_MAX);
 
-	if (!elf_add_data(elf, strtab, str, strlen(str) + 1))
+	if (!elf_add_data(elf, strtab, str, len + width))
 		return -1;
 
 	return offset;
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index f7e6a652ee78..50d5b17907c8 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -180,6 +180,7 @@ struct symbol *elf_create_section_symbol(struct elf *elf, struct section *sec);
 void *elf_add_data(struct elf *elf, struct section *sec, const void *data,
 		   size_t size);
 
+size_t elf_strlen(struct section *sec, unsigned long offset);
 unsigned int elf_add_string(struct elf *elf, struct section *strtab, const char *str);
 
 struct reloc *elf_create_reloc(struct elf *elf, struct section *sec,
diff --git a/tools/objtool/klp-checksum.c b/tools/objtool/klp-checksum.c
index ebe25f9c5260..2547e142794b 100644
--- a/tools/objtool/klp-checksum.c
+++ b/tools/objtool/klp-checksum.c
@@ -138,7 +138,8 @@ static void checksum_update_insn(struct objtool_file *file, struct symbol *func,
 		char *str;
 
 		str = sym->sec->data->d_buf + sym->offset + offset;
-		__checksum_update_insn(func, insn, str, strlen(str));
+		__checksum_update_insn(func, insn, str,
+				       elf_strlen(sym->sec, sym->offset + offset));
 		goto alts;
 	}
 
@@ -215,7 +216,8 @@ static void checksum_update_object(struct objtool_file *file, struct symbol *sym
 
 			str = target->sec->data->d_buf + target->offset + offset;
 			__checksum_update_object(sym, sym_offset,
-						 "reloc string", str, strlen(str));
+						 "reloc string", str,
+						 elf_strlen(target->sec, target->offset + offset));
 			continue;
 		}
 
diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
index 95d0d86666d7..dd5c4d604be3 100644
--- a/tools/objtool/klp-diff.c
+++ b/tools/objtool/klp-diff.c
@@ -1584,18 +1584,43 @@ static int clone_reloc(struct elfs *e, struct reloc *patched_reloc,
 		return -1;
 
 	/*
-	 * For strings, all references use section symbols, thanks to
-	 * convert_reloc_sym().  clone_symbol() has cloned an empty
-	 * version of the string section.  Now copy the string itself.
+	 * For string relocations, in some cases, compilers generate
+	 * PC-relative code like:
+	 *
+	 *   xorw 0(%rip), %dx    # "mnt", R_X86_64_PC32, addend -4
+	 *   (from proc_ns_dir_lookup(), Clang ThinLTO).
+	 *
+	 * In that case, str_off is not equal to the addend.
+	 * To read the string, use arch_adjusted_addend instead.
+	 *
+	 * To write the string, we could use out_off + (addend - str_off)
+	 * as the section-based addend.
+	 * The addend may become negative, and make lld report
+	 * "offset is outside the section".
+	 * So for this case, create temp symbol to use symbol-based relocation.
 	 */
 	if (is_string_sec(patched_sym->sec)) {
-		const char *str = patched_sym->sec->data->d_buf + addend;
+		long str_off = arch_adjusted_addend(patched_reloc);
+		const char *str = patched_sym->sec->data->d_buf + str_off;
+		struct section *out_sec = out_sym->sec;
+		unsigned int out_off;
 
 		__dbg_clone("\"%s\"", escape_str(str));
 
-		addend = elf_add_string(e->out, out_sym->sec, str);
-		if (addend == -1)
+		out_off = elf_add_string(e->out, out_sec, str);
+		if (out_off == -1)
 			return -1;
+
+		if (addend != str_off) {
+			out_sym = elf_create_symbol(e->out, ".L.str", out_sec,
+						    STB_LOCAL, STT_NOTYPE, out_off, 0);
+			if (!out_sym)
+				return -1;
+
+			addend -= str_off;
+		} else {
+			addend = out_off;
+		}
 	}
 
 	if (!elf_create_reloc(e->out, sec, offset, out_sym, addend,
diff --git a/tools/objtool/tests/generic/fixtures/checksum_insn.c b/tools/objtool/tests/generic/fixtures/checksum_insn.c
index 10f70a74a976..70c2e9106f8a 100644
--- a/tools/objtool/tests/generic/fixtures/checksum_insn.c
+++ b/tools/objtool/tests/generic/fixtures/checksum_insn.c
@@ -76,3 +76,14 @@ int target(int x)
 
 	return r;
 }
+
+#ifdef WIDE_STRING
+unsigned short wide_string(void)
+{
+#ifdef PATCHED
+	return *(const volatile unsigned short *)u"\u0200";
+#else
+	return *(const volatile unsigned short *)u"\u0100";
+#endif
+}
+#endif
diff --git a/tools/objtool/tests/generic/test-checksum-insn.sh b/tools/objtool/tests/generic/test-checksum-insn.sh
index e1c04a1f518a..692ab1b174b2 100755
--- a/tools/objtool/tests/generic/test-checksum-insn.sh
+++ b/tools/objtool/tests/generic/test-checksum-insn.sh
@@ -46,4 +46,22 @@ build_pair checksum_insn.c
 run_checksum
 assert_checksum_matches target
 
+# The wide character changes while its low byte stays zero.
+build_pair checksum_insn.c -DWIDE_STRING -fno-pic
+assert_checksum_differs wide_string
+run_diff
+for obj in patched out; do
+	$OBJCOPY -O binary --only-section='*.str2.*' "$workdir/$obj.o" \
+		"$workdir/$obj.bin" || fail "cannot extract wide string from $obj.o"
+done
+[ -s "$workdir/patched.bin" ] || fail "fixture produced no two-byte string section"
+cmp -s "$workdir/patched.bin" "$workdir/out.bin" ||
+	fail "wide string was copied incorrectly"
+
+# The x86-64 RIP-relative load needs a string label with addend -4.
+if $READELF -h "$workdir/patched.o" | grep -q 'Machine:.*X86-64'; then
+	section_relocs .text.wide_string | grep -Eq 'R_X86_64_PC32.* \.L[^ ]* - 4$' ||
+		fail "wide_string() lost its PC-relative string reference"
+fi
+
 pass "instruction checksums cover reloc targets, addends and string contents"
-- 
2.53.0

