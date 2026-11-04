Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793799187;
	b=aLUheGowEjIj23hM8JTMWRC5gP0jcQPxOEr3r7y6GuTbKqrAs959MMGPZxCHtmPurQe6
	 C/NIWzEXaFz99djPhgnudgx0jABUcyaOhrVQg/hDKn4jZ9/Tz8pUrmOTdyWQYCMmpqDBE
	 U0/gy0fq4qT3TsIEOwB8FI/90PgWXW8TiXhxUC3BzbBtY+qM2lrqTGMbertV/OhB1GwN+
	 GSQNPSJ936TvwYOUyrg5IY/9soqjbvFRNpxWQGvo9uwP+4RpMlifQGpbJhwI/Y7shIn7i
	 oH1eyZe2QUuWdLl5FOZl5Vaab0ChX41BJ/0BpuBpddCcB224i9BuLAFbqUtv8Igd1nw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793799187;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ZKK8ogIigAwbu6aj9RHAOLGoDBejAMO+iSP8oypaMds=;
	b=DnOYpUQ44x64WKS0lbsfnqnFl1YtLf7bCXn4DjCm49fo5xdXNaU/lghLmrZkY8iNAGNW
	 zbimO127zQmUlvttKfdstud1T5wzd7/BZ50xQNiJa1b5otGmkv8Ku6QNu0E0M3xQ2Pbyp
	 Ln779t20ZLXkxgbXDkus33a8Mf6wA1P9j+WwoJbvH1jjibOjTmT5Y0ju+1jcQs/vLAu4q
	 UqrQAdbdVBgg+/AboZQo+OaSiFrYiPPX5U1Dp86pv6XrAAEWDO9olKS5IBp09vK2ILkG9
	 T0Rk5gelokzwzKraesVDmanGgGWqp6HHUwUAT8qoXGmRPV6Vn6bXQYWbQyUGb0FUTLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L8UuXzsD;
	arc=none smtp.remote-ip=209.85.215.181
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD42606D811
	for <live-patching@vger.kernel.org>; Wed,  4 Nov 2026 13:33:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DDD42606D811
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L8UuXzsD
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cd8ba7c2694so273842a12.1
        for <live-patching@vger.kernel.org>; Wed, 04 Nov 2026 05:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793799186; x=1794403986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZKK8ogIigAwbu6aj9RHAOLGoDBejAMO+iSP8oypaMds=;
        b=L8UuXzsD8Xv64zZJ9+Z5jXXKybyicX6vsI6Xol7vMbnaucBI3jxP8az883sTeFGTH6
         iVlOwUqq9dvxKMspisWmHgzzkULy3t/UPi7m6M14+nSNwQnSp8OSAzBNoux5SqxgTGmd
         R07AXmj2JDVuzwVvknm7ifOu/xmSJUINDK0E6NfOV6BVpmMhJPDMpTM0BYiHXD8JbUGB
         hEzyzEIHZYJzkVBE0goqAtVcUXBfALVREh9RVwTGPYUopPbb74qjrOrA2j4t3g9Pz/2f
         hAscVfEU4oDKXgGMIzQVET8nN7aEmZVAsXWHzwBLhsnTwy2oLSFWS8gqAe90CkojVVrS
         cdpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793799186; x=1794403986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZKK8ogIigAwbu6aj9RHAOLGoDBejAMO+iSP8oypaMds=;
        b=o7gZTohlOwWrPoKWrWxeYi1jB4JbQBn7Jt5Ai9N7yIfPHgXOPKUJ4UXQQj2PYXUWjS
         0F5tP/A1Ff8Sw9vJkLGj5hLqHQfAJscYnJUaGJj5AIkUPvv8dSzTPwK8RdA+pC4ihXwy
         gQjBRJO8UbLE5N7TpPMlxuJJCC1o9N/nXW47YuKQkWE4DjDu/ILX5xfeQwLmxjlwvjbo
         52TWOZi8sV1sQjuQvz7BjIKYjkx/R2fa0oKefdom/VIsXVZsfN1d0YDymQJaS0AWR4T6
         2zacQPI6hQUVRmaFPNfuNqfkEQjUQlW3oZdOtSSLzoDM5ng37tgKBLKCbG/zQAM/aYgO
         xK5g==
X-Forwarded-Encrypted: i=1; AKwUvBx9K295Zyt7SE+VlljDtyoRXzvStb0aEydoZ3gDfbR3ZOJViu1NB48lxF1Nq9g6Oizey1+n4JuMeMkqgtAy@vger.kernel.org
X-Gm-Message-State: APuU4Z/zONsgQDFPJAqWpMY5+jX5EHu1IY2uHmcsqywVKhlEs7uPz9hz
	0Vux64UA+q8kpowQEwDlFkTFJXOXTS6vBpXOTMGAkUqqoWwnXQe7VNp5
X-Gm-Gg: AYBFou3HryiF+/MHEnbjgCIxfua51Do9yN4WMkILhL4LegUMW5ZZSFeQF+wiCBBcTo+
	lWCwM8Fj2AO4i43WDxOgSiZBuFkcnDd2eJhUurL/GhbJxrYs9DJyhoaqAa+aj+z0dDyWA4mn+JP
	mz1A2D7t6DVC6B19XBSiDWuqpV+7yhWVwaToU1qIFaD1Yj5pyO4ehNMF20vS3mzj1WAZ+0wvosN
	hovYfoQCw2DioZIzlG9Cb4MrexG9ikzMLjPtav3OyncefLttj8L3gA/aYWLArZxNYZIXVdFNuV2
	oflW+kL+a8UuhG1D09XN+oFDL7E7TogIrs8RSsKbZSenYJ89w4COP7CJPhc/3VqwUAhoCEEA6PM
	V7wplF198HYtx+03dZ1LzYS2hJHOs+peFFiOGE/Jaz13QzFrSQlLjv6qigo0GVb/JZYgVfdZ9ZK
	SzsvsKBCjgs53EYSANXIiCD43Fj5m28CVV6XqNY/eYPNonj3ATrbAGAa5wvbIYWbCnAZ71PFRZ4
	6U9t60WQvZHTL0ew0s5o0XGGTQPh7awxhjefY6TysyMhSs7rIrDlZGKFyBYY3wi8hBXu5VqNBYb
	JdORFs9YxdrTpotw33hWjeNNnitoPXXzPJylGBZmqwkOADPaHQ==
X-Received: by 2002:a05:6a21:3113:b0:3dd:f9ff:f5a with SMTP id adf61e73a8af0-3e928aab8damr12500818637.9.1793799186070;
        Wed, 04 Nov 2026 05:33:06 -0800 (PST)
Received: from anatasluo-Precision-5560 ([139.226.166.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b09a7ce84fsm911369b3a.13.2026.11.04.05.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 05:33:05 -0800 (PST)
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
Subject: [RFC PATCH v2 09/11] objtool/klp: Extend twins through unchanged function references
Date: Wed,  4 Nov 2026 21:31:55 +0800
Message-ID: <20261104133158.3187525-10-luolongjuna@gmail.com>
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

Repeated statics and optimized variable pieces can share an identity
and checksum, leaving them uncorrelated after identity matching.

For paired functions with equal checksums, compare their relocation
entries and extend twins to the referenced symbols. Require matching
reference layouts and compatible targets, and reject twin conflicts.

This also checks the correlation against the function checksum: equal
checksums can hide a switch between instances sharing one identity, and
a conflicting reference must stop patch generation.

Validated the available objtool tests with GCC 16.2.1 and Clang
22.1.8. Only local-to-global-flip, sympos and sympos-vmlinux fail,
reflecting the linkage and duplicate-identity policies.

Assisted-by: LLM
Signed-off-by: Longjun Luo <luolongjuna@gmail.com>
---
 tools/objtool/klp-diff.c | 132 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 132 insertions(+)

diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
index 468b8654b687..e8252e586260 100644
--- a/tools/objtool/klp-diff.c
+++ b/tools/objtool/klp-diff.c
@@ -826,6 +826,8 @@ static int validate_symbol_twins(struct elfs *e)
 	return ret;
 }
 
+static int extend_twins_by_relocations(struct elfs *e);
+
 /*
  * Correlate symbols between the orig and patched objects.  This is a
  * prerequisite for detecting changed functions, as well as for properly
@@ -845,6 +847,7 @@ static int correlate_symbols(struct elfs *e)
 
 	if (correlate_by_identity(e) ||
 	    extend_same_twins_by_checksum(e) ||
+	    extend_twins_by_relocations(e) ||
 	    validate_symbol_twins(e))
 		return -1;
 
@@ -1294,6 +1297,135 @@ static int convert_reloc_sym(struct elf *elf, struct reloc *reloc)
 	return convert_reloc_secsym_to_sym(elf, reloc);
 }
 
+static int correlate_reloc(struct elfs *e, struct symbol *func,
+			   struct reloc *orig_reloc, struct reloc *patched_reloc)
+{
+	struct symbol *orig_sym, *patched_sym;
+	unsigned long offset = reloc_offset(orig_reloc) - func->offset;
+
+	if (offset != reloc_offset(patched_reloc) - func->twin->offset ||
+	    reloc_type(orig_reloc) != reloc_type(patched_reloc)) {
+		ERROR("%s+%#lx: relocation mismatch in unchanged function", func->name, offset);
+		return -1;
+	}
+
+	if (reloc_type(orig_reloc) == R_NONE ||
+	    is_uncorrelated_section(orig_reloc->sym->sec) ||
+	    is_uncorrelated_section(patched_reloc->sym->sec))
+		return 0;
+
+	/* Section symbols have no twins; resolve the target symbol first. */
+	if (convert_reloc_secsym_to_sym(e->orig, orig_reloc) ||
+	    convert_reloc_secsym_to_sym(e->patched, patched_reloc))
+		return 0;
+
+	orig_sym = orig_reloc->sym;
+	patched_sym = patched_reloc->sym;
+	if (orig_sym->dont_correlate || patched_sym->dont_correlate)
+		return 0;
+
+	if (reloc_addend(orig_reloc) != reloc_addend(patched_reloc)) {
+		ERROR("%s+%#lx: reference offset mismatch: %s[%u]%+lld and %s[%u]%+lld",
+		      func->name, offset,
+		      orig_sym->name, orig_sym->idx, (long long)reloc_addend(orig_reloc),
+		      patched_sym->name, patched_sym->idx, (long long)reloc_addend(patched_reloc));
+		return -1;
+	}
+
+	if (orig_sym->twin == patched_sym && patched_sym->twin == orig_sym)
+		return 0;
+
+	if (orig_sym->twin || patched_sym->twin) {
+		ERROR("%s+%#lx: twin conflict: orig %s[%u]->%s[%u], patched %s[%u]->%s[%u]",
+		      func->name, offset,
+		      orig_sym->name, orig_sym->idx,
+		      orig_sym->twin ? orig_sym->twin->name : "<none>",
+		      orig_sym->twin ? orig_sym->twin->idx : 0,
+		      patched_sym->name, patched_sym->idx,
+		      patched_sym->twin ? patched_sym->twin->name : "<none>",
+		      patched_sym->twin ? patched_sym->twin->idx : 0);
+		return -1;
+	}
+
+	/* Compound target checksums are independent of their defining TU. */
+	if (is_compound_constant(orig_sym) && is_compound_constant(patched_sym)) {
+		if (!orig_sym->csum.checksum || orig_sym->len != patched_sym->len ||
+		    orig_sym->csum.checksum != patched_sym->csum.checksum) {
+			ERROR("%s+%#lx: compound content mismatch in unchanged function",
+			      func->name, offset);
+			return -1;
+		}
+	} else if (!is_twin_candidate(orig_sym, patched_sym)) {
+		ERROR("%s+%#lx: incompatible reference targets: %s[%u] and %s[%u]",
+		      func->name, offset, orig_sym->name, orig_sym->idx,
+		      patched_sym->name, patched_sym->idx);
+		return -1;
+	}
+
+	orig_sym->twin = patched_sym;
+	patched_sym->twin = orig_sym;
+	dbg_correlate("%s(): %s+%#lx: %s[%u] -> %s[%u]",
+		      __func__, func->name, offset,
+		      orig_sym->name, orig_sym->idx, patched_sym->name, patched_sym->idx);
+	return 0;
+}
+
+static struct reloc *get_func_relocs(struct elf *elf, struct symbol *func, unsigned int *nr)
+{
+	struct reloc *first, *reloc;
+
+	first = find_reloc_by_dest_range(elf, func->sec, func->offset, func->len);
+	*nr = 0;
+	for (reloc = first; reloc && reloc_offset(reloc) < func->offset + func->len;
+	     reloc = rsec_next_reloc(func->sec->rsec, reloc))
+		(*nr)++;
+	return first;
+}
+
+/* Use unchanged functions' references to resolve ambiguous symbol identities. */
+static int extend_twin_by_relocations(struct elfs *e, struct symbol *func)
+{
+	struct reloc *orig_relocs, *patched_relocs;
+	unsigned int nr_orig, nr_patched, i;
+
+	orig_relocs = get_func_relocs(e->orig, func, &nr_orig);
+	patched_relocs = get_func_relocs(e->patched, func->twin, &nr_patched);
+	if (nr_orig != nr_patched) {
+		ERROR("%s: relocation count mismatch in unchanged function: %u != %u",
+		      func->name, nr_orig, nr_patched);
+		return -1;
+	}
+
+	for (i = 0; i < nr_orig; i++)
+		if (correlate_reloc(e, func, &orig_relocs[i], &patched_relocs[i]))
+			return -1;
+	return 0;
+}
+
+static bool same_function_checksum(struct symbol *func)
+{
+	/* Cold subfunctions have no separate checksum; use their parent's. */
+	struct symbol *parent = func->pfunc;
+	struct symbol *parent_twin = func->twin->pfunc;
+
+	return parent->twin == parent_twin && parent->csum.checksum &&
+	       parent->csum.checksum == parent_twin->csum.checksum;
+}
+
+static int extend_twins_by_relocations(struct elfs *e)
+{
+	struct symbol *sym;
+
+	for_each_sym(e->orig, sym) {
+		if (!is_func_sym(sym) || sym->dont_correlate || !sym->twin ||
+		    !same_function_checksum(sym))
+			continue;
+		if (extend_twin_by_relocations(e, sym))
+			return -1;
+	}
+	return 0;
+}
+
 /*
  * Check if the original module already has a dependency on dep_mod, i.e. it
  * already references at least one export from that module.
-- 
2.55.0

