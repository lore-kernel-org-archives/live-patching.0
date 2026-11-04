Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793799193;
	b=J1vFvPVZ1Gvo0UCKgiBEgx8zeniY8CvJYDG8hJQIRM7UxkirANfvjHia+PuArZnO84DL
	 Jnl0P6E8wDYopZL3nMUEz5HWqmbIIskw1p+QR54QWBXzForVnU9jwIaz8Odacmwk9nKGj
	 TEBbZbvps5HSyUI0ZdeFjGeuFjjEvF254Ew3S9p64c4aUV06eLH1FwDoKrxgD79WjMtRi
	 3iHyv1N5CpuxdSekc+q6dmj20RZT2t08WPyhESxB8gXkWFoBmmQPm8IG4Ek9VAcH0pqID
	 HS8JnujmTcDUOYqaIDuwe4rNCJe9Ir9tQ5oXhFYhGwlicKmtCmdLT/bgpFpYul36J1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793799193;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=PdjCOxSuJpKoc4irjT2S/QzhdSHHf0OZ3GVf9cjg2xc=;
	b=ptw88LMfBx63SVWiJRf8ZiE/CQBcg3KnL35xf1lPaYiD06TZR8l6Qk+GWm2l5wsGOmvs
	 s2sH4K7EOBWX1CgQG9HaHRYcmQ453PS93znMeFm8f9ILOhHtMk4+hBVaMa81830p6G+hW
	 5tPQ43hOLQsyjBMUfw9YDr1clG+NPgXOjflJ5IFRXRzQ/G2UbnDTaxZJ/Zu9m3zrti2zK
	 j7kphFjECinDpHOVzxXzCh32D1a2b9vGdWkHyVl9PCmP1v85R1kqWnHiM2qylHKd2m0Ah
	 SvaeK+htXGRAmkiIY6IYvaVqi/D/+4WH5so78LwPIgy0wWnU/ADjQLI63x4Fu9qI6kQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Mub+Nh++;
	arc=none smtp.remote-ip=209.85.210.176
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF777606D803
	for <live-patching@vger.kernel.org>; Wed,  4 Nov 2026 13:33:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF777606D803
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Mub+Nh++
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8a0880a46e7so342936b3a.1
        for <live-patching@vger.kernel.org>; Wed, 04 Nov 2026 05:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793799192; x=1794403992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PdjCOxSuJpKoc4irjT2S/QzhdSHHf0OZ3GVf9cjg2xc=;
        b=Mub+Nh++/YjgKa1YA1MSRM+1pO9tnt9vjCn+3uR0GLxImaYjs9w+Bd9GETuN1rxuqz
         qXtwPKsipv0pqfddMahy/cCHzfNkA40uNhaAf5OgxforQF70gHVNxc7SHvVBfgeqRPp7
         2314+fis0+btesCEPaO+XuqYA1QReUXOGOAckVe2SwGQpKJzZP704ttmKQUWdyHvh420
         tNdImpy9K4OMLa9Kus15ZhtRtueHy8sLHKWnw1q/FxLm/+XMkX5jxps99aOO1KmFH7oT
         DaL4bZ8IouFhqs0yvk7osoUtv2tA4F/iOniohLrB2fJnSKBXBhj4aQ5DwFtzJ7CqyTvs
         gv8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793799192; x=1794403992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PdjCOxSuJpKoc4irjT2S/QzhdSHHf0OZ3GVf9cjg2xc=;
        b=0pyITPjBhLkS8/OElN01Ts/i7h5n+ZhhooRFvOxPtwZmGYemsE/IN9pGiCRoIm90xy
         ZM6QmI1TD/KQyBLi09gSRrc0XchXvzF1qCBM+N4SnWdBMhp6AxWb8gDLoz78lZguFhGg
         HlQiW4xk1ZwKOMyoz54O/PTQXA5Csh9U69uQSMaPuht5kbi+sfOGO/f/Nd5+u5MaBOIP
         eyvt1fm4bdPEhC+dtXndSSa6C1nYJsRb3bINvDPW0h19LAF+22Y9VnbjcIz7CwjXcZ/R
         nf+OzTnzxUu3GewweVodllO/0nPOn+RkNSNAM9dr0obz866cp30KGbQdi+jASm2sfVOf
         wBHA==
X-Forwarded-Encrypted: i=1; AKwUvBzu2Vw+aWaO/wtfiRfQgAaUJihWW0L68qf46B8duoAPgKyAlxWB5jSyNa2vt5QaS65A/g+JTqJhnN/5B41I@vger.kernel.org
X-Gm-Message-State: APuU4Z9VczsXjutc1jboNNN13AQbbRoPF1K+GhePcNDUOHWe75oPxjAK
	hCAV/Y4aYQSYCYke3Opu6Cmx0pfL2bXFAanYsQaJN0xMPPQUs1+uQiib
X-Gm-Gg: AYBFou2+fAvBvIKt++wa0NlYkpV79EeMhERKarfZ6c0e1jNl3vhTc69RLbnbEX8yBsU
	L1/a8hi1VrTWjKJfPSOKXxMUJFS+G+oPLbL4RmnW4GHcsl5RhhawafTEXgc5pUb30tkOGrmFlpy
	wxH9H6spBKyq0XLJw/mUSqzFcSiymaCsbEdV6ZGdfSs6h27QHlOevuu4dX4/yLZMm4FBXgFd5oe
	2Qk9C0d6p6mqkg1efGvujfppKVF7wZRc83Uv/AW1kP+i8lk18swtaX3m+aQd2In2CSVeWtn1vTu
	l0ppTUowbxPa7s1POWu9OW4uHAyctqJZw8vvVRy3KZSwVvyBFnFkQ8JGv0jxVJgNq2EeE11uEVF
	rZI15q2jpK2T1Id8elALOHlFHMao35t+5BorN9scllG+iT+qfviPfdPoTkp0aczg3Amr4Sbjv8O
	wGF+KXy/GWtL69gyM0dU14d3fl4wYKvFpEvYCNJzFnFdSSnQtmgWMNR9uddJVJJklXzZcDuDNwU
	rV3qzOchh7wiJnJF0/6JAkJqp8KzTqQ6Ko44WeHIs0oVgd4idWhD8JD7h56tBNz7dpQXDAGrXaP
	8HsjVO5EpgO2hw71L3o406GJ6UJL/tYu5uIoQ627TiYMoUWXUg==
X-Received: by 2002:a05:6a00:4fc6:b0:8a0:18bd:dd87 with SMTP id d2e1a72fcca58-8a831dbb075mr11758199b3a.18.1793799192144;
        Wed, 04 Nov 2026 05:33:12 -0800 (PST)
Received: from anatasluo-Precision-5560 ([139.226.166.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b09a7ce84fsm911369b3a.13.2026.11.04.05.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 05:33:11 -0800 (PST)
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
Subject: [RFC PATCH v2 10/11] objtool/klp: Check unmatched data references
Date: Wed,  4 Nov 2026 21:31:56 +0800
Message-ID: <20261104133158.3187525-11-luolongjuna@gmail.com>
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

An unmatched data reference can still refer to existing state. Treating
it as new can give old and patched code separate copies of that state.

For ordinary data, allow new storage only when no original identity
candidate exists. For compound literals, reuse a unique unchanged object
in both functions' references. Reject ambiguous or changed compounds;
without a source identity, additions cannot be distinguished from changes.

Report the referencing function and offset for unresolved ordinary data.
Exclude fake special-section symbols created by objtool after correlation.

Validated the available objtool tests with GCC 16.2.1 and Clang
22.1.8. Only local-to-global-flip, sympos and sympos-vmlinux fail,
reflecting the linkage and duplicate-identity policies.

Assisted-by: LLM
Signed-off-by: Longjun Luo <luolongjuna@gmail.com>
---
 tools/objtool/klp-diff.c | 134 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 134 insertions(+)

diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
index e8252e586260..19f5161420cd 100644
--- a/tools/objtool/klp-diff.c
+++ b/tools/objtool/klp-diff.c
@@ -1426,6 +1426,135 @@ static int extend_twins_by_relocations(struct elfs *e)
 	return 0;
 }
 
+static int find_unique_compound_reference(struct elf *elf, struct reloc *relocs,
+					  unsigned int nr, struct symbol *sym,
+					  struct symbol **match)
+{
+	unsigned int i;
+
+	*match = NULL;
+	for (i = 0; i < nr; i++) {
+		struct reloc *reloc = &relocs[i];
+		struct symbol *target;
+
+		if (reloc_type(reloc) == R_NONE || convert_reloc_secsym_to_sym(elf, reloc))
+			continue;
+		target = reloc->sym;
+		if (!is_compound_constant(target) || target->len != sym->len ||
+		    target->csum.checksum != sym->csum.checksum)
+			continue;
+		if (*match && *match != target) {
+			ERROR("unresolved compound reference: %s matches %s[%u] and %s[%u]",
+			      sym->name, (*match)->name, (*match)->idx, target->name, target->idx);
+			return -1;
+		}
+		*match = target;
+	}
+	return 0;
+}
+
+static int resolve_compound_reference(struct elfs *e, struct symbol *sym,
+				      struct reloc *orig_relocs, unsigned int nr_orig,
+				      struct reloc *patched_relocs, unsigned int nr_patched)
+{
+	struct symbol *orig_sym, *patched_sym;
+
+	if (!sym->csum.checksum) {
+		ERROR("%s: missing compound checksum", sym->name);
+		return -1;
+	}
+
+	if (find_unique_compound_reference(e->orig, orig_relocs, nr_orig, sym, &orig_sym))
+		return -1;
+	if (!orig_sym) {
+		/*
+		 * Data changes are unsupported. With no source identity, new and
+		 * changed compound literals cannot be distinguished here.
+		 */
+		ERROR("unresolved compound reference: %s has no unchanged match", sym->name);
+		return -1;
+	}
+
+	if (find_unique_compound_reference(e->patched, patched_relocs, nr_patched,
+					   sym, &patched_sym))
+		return -1;
+	if (patched_sym != sym) {
+		ERROR("unresolved compound reference: %s is not a unique reference in its function",
+		      sym->name);
+		return -1;
+	}
+	if (orig_sym->twin) {
+		ERROR("compound twin conflict: %s[%u] paired with %s[%u]",
+		      orig_sym->name, orig_sym->idx,
+		      orig_sym->twin->name, orig_sym->twin->idx);
+		return -1;
+	}
+	sym->twin = orig_sym;
+	orig_sym->twin = sym;
+	dbg_correlate("%s(): %s[%u] -> %s[%u]", __func__,
+		      orig_sym->name, orig_sym->idx, sym->name, sym->idx);
+	return 0;
+}
+
+/*
+ * Check references to symbols without twins for ambiguity:
+ *
+ * 1. Ordinary data: allow as new only if no original identity candidates exist.
+ *    We assume DWARF identity information is stable across builds with the
+ *    same compiler.
+ * 2. Compound literals (anonymous data with static storage duration):
+ *    - delete: allowed.
+ *    - same: require a unique unchanged match in both functions' references.
+ *    - change: unsupported, to keep old and patched code's data views consistent.
+ *    - new: reject for now; it cannot be distinguished from change.
+ *      Supporting additions requires an explicit mechanism.
+ */
+static int check_unmatched_reference(struct elfs *e, struct reloc *reloc)
+{
+	struct symbol *patched_sym = reloc->sym, *orig_sym, *func;
+	struct reloc *orig_relocs = NULL, *patched_relocs = NULL;
+	unsigned int nr_orig = 0, nr_patched = 0;
+	u32 key;
+
+	if (reference_twin(patched_sym) || patched_sym->dont_correlate ||
+	    !is_object_sym(patched_sym) || is_undef_sym(patched_sym) || !patched_sym->len)
+		return 0;
+
+	if (!is_compound_constant(patched_sym)) {
+		if (!has_dwarf_identity(patched_sym)) {
+			ERROR_FUNC(reloc->sec->base, reloc_offset(reloc),
+				   "unresolved data reference: %s has no DWARF identity",
+				   patched_sym->name);
+			return -1;
+		}
+		key = identity_hash(&patched_sym->identity);
+		/*
+		 * With one old count.N and two patched candidates, the unmatched one
+		 * may still refer to old state, even if the original already has a twin.
+		 */
+		elf_hash_for_each_possible(e->orig, symbol_identity, orig_sym, identity_hash, key) {
+			if (!same_identity(&patched_sym->identity, &orig_sym->identity))
+				continue;
+			ERROR_FUNC(reloc->sec->base, reloc_offset(reloc),
+				   "unresolved data reference: %s (%s, %s, %s), old candidate %s[%u]",
+				   patched_sym->name, patched_sym->identity.source,
+				   patched_sym->identity.scope,
+				   patched_sym->identity.demangled_name,
+				   orig_sym->name, orig_sym->idx);
+			return -1;
+		}
+		return 0;
+	}
+
+	func = find_func_containing(reloc->sec->base, reloc_offset(reloc));
+	if (func && func->included && func->twin && !same_function_checksum(func)) {
+		orig_relocs = get_func_relocs(e->orig, func->twin, &nr_orig);
+		patched_relocs = get_func_relocs(e->patched, func, &nr_patched);
+	}
+	return resolve_compound_reference(e, patched_sym, orig_relocs, nr_orig,
+					  patched_relocs, nr_patched);
+}
+
 /*
  * Check if the original module already has a dependency on dep_mod, i.e. it
  * already references at least one export from that module.
@@ -1629,6 +1758,9 @@ static int clone_reloc(struct elfs *e, struct reloc *patched_reloc,
 	bool klp;
 
 	/* Reject ambiguous data references before treating them as new. */
+	if (check_unmatched_reference(e, patched_reloc))
+		return -1;
+
 	klp = klp_reloc_needed(patched_reloc);
 
 	dbg_clone_reloc(sec, offset, patched_sym, addend, export, klp);
@@ -1781,6 +1913,8 @@ static int create_fake_symbol(struct elf *elf, struct section *sec,
 		return -1;
 
 	sym->fake = 1;
+	/* Special-section entries are copied with the patched code. */
+	sym->dont_correlate = 1;
 	return 0;
 }
 
-- 
2.55.0

