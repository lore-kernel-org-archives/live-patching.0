Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793010016;
	b=4rGElp4gwRItytSMhsWFXG+2v/2gb52Q4NWsnUVT2DoPFukCQQAEzogNaG6H2QGfxBje
	 AyuMFKBvWSyF2yMElXJuSNbcKmLgl/duQUYX5WgKc1hjg0mqMmOSMLMsAYTufWnlB38D2
	 6fzXYVO1JxdOwdlWa7UDemJzSBc6G24NCFcnl7LLY1IUHEdYAr3W5jfRzFxP+7iwTgZbZ
	 aZuxCscji0Ak464AluAXxUQewd8ekQtH/q69eYVHztBACq2nsCGLWCFjrG0ShjwKRyley
	 OPmwKLWyr7IxjKppRX0xj70G3QzWkp4C0TpKWH/F/sDqVIo4c55yBI7napSYpdva5FA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793010016;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=kSt0+19ZtRH8Z5jzlg5YWJl+R3gwXhIgznAOUesFi6U=;
	b=R4vQktHUxJ8kYC3yPZsgbjYKDHiL4IR3LmVYGNl13H/LUnET/2XELtdzYlUoiQ4/EvK9
	 DfXRC386JeZyNchU5EWZSry+F9A3Fs5gAFugXhUkYHUd/w1wHlnZB7q3yqBGkf4zCdCw8
	 04VO7iCOlyrlPuuOD8YCYits2SA3aqBFCgQjjoXm206C9tVlTOWDop2KLtAYI6+2PuXXZ
	 7Y0oGGnRADwzDnzv7E8dIMaR7zuWptF6aQFJVOeWZ67ghE/gcZExrCiHNQsT+L4Rz3HXe
	 3Ptdu4/PACMNf6swip2sobllycynoH/WimPj6boD/FdSQ7EbcTo6yAzGh5FG0zCX88w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VIspCf0M;
	arc=none smtp.remote-ip=209.85.215.180
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52591606A321
	for <live-patching@vger.kernel.org>; Mon, 26 Oct 2026 10:20:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52591606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VIspCf0M
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cd5e2d696e0so1479995a12.1
        for <live-patching@vger.kernel.org>; Mon, 26 Oct 2026 03:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793010016; x=1793614816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kSt0+19ZtRH8Z5jzlg5YWJl+R3gwXhIgznAOUesFi6U=;
        b=VIspCf0MojuuX+Xyew0Ahe22Tkhv8ei+zLMzSEwRSQS3Y7kp8bnIT731C1rd0DXYdD
         yeAC5eg6XCqE9xzDTunOqXBGaCQMJr5A4STdqJUec8tpVN/uWUSS9pasy0JFJhQSZx2e
         kqinAn3EEzV+rb1RRFn4SQJtrxKlG20CCMDpY3UvmpTg9d9YhsD3oDsQsb7TL2kYtvK7
         80D/+yCtXgZq0DVX98xYZaTuSUfn38YoLC2fvbi5x0CYRPpoO2rRtKvN5RkFspm5AWQ2
         +yBxt3dsJjNim0do3Hz8ZclDGly3s5Qlme6xlcmdG50xeUYoiXIcsErOV/4XbfkK2Rhq
         jhIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793010016; x=1793614816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kSt0+19ZtRH8Z5jzlg5YWJl+R3gwXhIgznAOUesFi6U=;
        b=Z5BuKU0mKF88naPnvQD0GMiUg1sATM5Yo8pw7mXSyk5XX09kugV3uar0/ecPiqx5NN
         v+rfGbndoe587ym/2xevp1jrwHxzRTeGsC1kAbJXBy6lMH/c3oDoWhJTiPte2Y3+wvoM
         cs9R+ucAESy+8JB7I+TYtIVvsAY7jLwVjLCnaink38i7YvNjG2igNdgO2kqbYgufAIk3
         QYRqwmy/wXp4DdEN71W/Z1wl5gBqNfsf6Jl4G9ok5ejUavDt8Xu+DJYcjJ+WYzw0ZI9X
         2NEAVVCU7nNAOxY9AjcdsYHbyNmnAOry4YlZ+r36EOz/50LVDHrfWZPqnNDDafMtkaHJ
         ysBw==
X-Forwarded-Encrypted: i=1; AKwUvBxXm3tJW15lKPnhC+2t9d0QAZYKLDwuN5OZge6+GUpj0aoUIaBAwrLkUaFteOZGRYgCs9ncZRuMCjX7dc71@vger.kernel.org
X-Gm-Message-State: AFq9FYLeHEo3U+7+dM3aNSyIhpSnss1wIrPgsx/OqKJAsouQM7Dh26z5
	z6VyC3BNOeUU8RKWe1G5b0SgwOUXWHy7hX9Qm5GJUFS86QDU44e4poXS
X-Gm-Gg: AYBFou1JHHBr1+zIlfQ6T+AefXpi/soq/3xX22WjdFG+hOwu2dU5sfEWr7lrgm26W7u
	OBO3NuUQEesL5nyOl+DphgWhYoG1XykEUn0VL4K3GnCnxtBqEcjhiozvvmhXH5JkeOLYrpAYRpe
	Rwgt2exp6MFYtjTojZY4vqsjVqte+MS2MbzkJQGPHTLgEshqePHCb1tjOuZXW3l77R950Q3+obC
	ylR8FJ9tI27qL+vu8grZlLMTHvvqit/dp3IlM36DdtaIMh1GrLKToehluiJKtdL7462zHxV08KW
	5bjtPOCqjYUX3uoUO5HDHaTR7XeIua3GDGFIAL2Jc1mq2sCregU+FdAIigCq/PnP2Rk9YXQOqbu
	iTZoanJOyd9crnx3vCV0DvwGBthtoldAILW70MF+Vpu3Fvbn/Yw7tfsqeghiTDJRZuzb/dsAtX0
	X4H3j046y6sxu+Ksg8/LqIgoo8O4gpv7qXWeHj0iDJ2CNa/4s4J0rmNj1lJ9U6waHyJY5GNp8/8
	ITo1DLFVTU12CsWDRYo8brWOiPuJ+bc54xucwOZlA9wtTU2Bt7XBKopMAp5BdX3w8K9MS3pJc2i
	Tg==
X-Received: by 2002:a17:90b:2891:b0:3ab:24b2:9016 with SMTP id 98e67ed59e1d1-3adead488d1mr5543829a91.25.1793010015616;
        Mon, 26 Oct 2026 03:20:15 -0700 (PDT)
Received: from anatasluo-Precision-5560 ([2408:820c:d29:db90:8486:5157:635e:e0f0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adeba32e38sm8477565a91.2.2026.10.26.03.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 03:20:15 -0700 (PDT)
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
Subject: [RFC PATCH 2/3] objtool/klp: Include symbol identities in reference checksums
Date: Mon, 26 Oct 2026 18:19:15 +0800
Message-ID: <20261026101916.3823942-3-luolongjuna@gmail.com>
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

A call or data reference can switch to a same-named symbol without
changing the target's demangled name. Hashing that name alone can miss
the change, even when the symbols have been correlated correctly.

Prepare identities before calculating checksums and hash the target's
source/scope/demangled_name path. This distinguishes TU-local and
external targets while allowing compiler suffixes to change. Keep the
single-object checksum command and its on-disk format unchanged.

Tested with GCC and Clang, including same-named call/data targets,
function-pointer tables, and four full-kernel vmlinux.o build pairs.
This patch introduces no new test failures. The three policy
rejections from the identity correlation patch remain; sympos and
sympos-vmlinux now fail earlier, in klp checksum, because identities
are prepared there.

Assisted-by: LLM
Signed-off-by: Longjun Luo <luolongjuna@gmail.com>
---
 tools/objtool/include/objtool/klp-identity.h |  1 +
 tools/objtool/include/objtool/klp.h          |  2 ++
 tools/objtool/klp-checksum.c                 | 25 +++++++++++++-------
 tools/objtool/klp-diff.c                     |  2 +-
 tools/objtool/klp-identity.c                 |  7 ++++++
 5 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/tools/objtool/include/objtool/klp-identity.h b/tools/objtool/include/objtool/klp-identity.h
index 0c7be8cfd49b..8483ce92f2e5 100644
--- a/tools/objtool/include/objtool/klp-identity.h
+++ b/tools/objtool/include/objtool/klp-identity.h
@@ -14,6 +14,7 @@ struct identity {
 	const char *source;		/* physical defining TU path, or "" */
 	const char *scope;		/* slash-delimited enclosing scopes */
 	const char *demangled_name;	/* suffix-stripped symbol name */
+	const char *path;		/* source/scope/demangled_name */
 	bool external;
 };
 
diff --git a/tools/objtool/include/objtool/klp.h b/tools/objtool/include/objtool/klp.h
index c57775d78c71..564890cd1d5f 100644
--- a/tools/objtool/include/objtool/klp.h
+++ b/tools/objtool/include/objtool/klp.h
@@ -51,6 +51,8 @@ struct objtool_file;
 struct elf;
 struct symbol;
 
+bool dont_correlate(struct symbol *sym);
+
 int klp_create_symid_sections(struct objtool_file *file);
 
 int klp_sympos_init(struct elf *orig);
diff --git a/tools/objtool/klp-checksum.c b/tools/objtool/klp-checksum.c
index 1f1b5f068168..54b89c3e6d1b 100644
--- a/tools/objtool/klp-checksum.c
+++ b/tools/objtool/klp-checksum.c
@@ -98,8 +98,8 @@ static void checksum_update_insn(struct objtool_file *file, struct symbol *func,
 			__checksum_update_insn(func, insn, buf, len);
 
 			if (call_dest) {
-				__checksum_update_insn(func, insn, call_dest->identity.demangled_name,
-						       strlen(call_dest->identity.demangled_name));
+				__checksum_update_insn(func, insn, call_dest->identity.path,
+						       strlen(call_dest->identity.path));
 
 			} else if (jump_dest) {
 				struct symbol *dest_sym;
@@ -115,8 +115,8 @@ static void checksum_update_insn(struct objtool_file *file, struct symbol *func,
 				if (!dest_sym)
 					goto alts;
 
-				__checksum_update_insn(func, insn, dest_sym->identity.demangled_name,
-						       strlen(dest_sym->identity.demangled_name));
+				__checksum_update_insn(func, insn, dest_sym->identity.path,
+						       strlen(dest_sym->identity.path));
 
 				offset = jump_dest->offset - dest_sym->offset;
 				__checksum_update_insn(func, insn, &offset, sizeof(offset));
@@ -158,8 +158,8 @@ static void checksum_update_insn(struct objtool_file *file, struct symbol *func,
 		offset -= sym->offset;
 	}
 
-	__checksum_update_insn(func, insn, sym->identity.demangled_name,
-			       strlen(sym->identity.demangled_name));
+	__checksum_update_insn(func, insn, sym->identity.path,
+			       strlen(sym->identity.path));
 	__checksum_update_insn(func, insn, &offset, sizeof(offset));
 
 alts:
@@ -227,9 +227,9 @@ static void checksum_update_object(struct objtool_file *file, struct symbol *sym
 			offset -= target->offset;
 		}
 
-		__checksum_update_object(sym, sym_offset, "reloc name",
-					 target->identity.demangled_name,
-					 strlen(target->identity.demangled_name));
+		__checksum_update_object(sym, sym_offset, "reloc identity",
+					 target->identity.path,
+					 strlen(target->identity.path));
 		__checksum_update_object(sym, sym_offset, "reloc addend",
 					 &offset, sizeof(offset));
 	}
@@ -325,6 +325,7 @@ static const char * const klp_checksum_usage[] = {
 int cmd_klp_checksum(int argc, const char **argv)
 {
 	struct objtool_file *file;
+	struct symbol *sym;
 	int ret;
 
 	const struct option options[] = {
@@ -349,6 +350,12 @@ int cmd_klp_checksum(int argc, const char **argv)
 	if (ret)
 		goto out;
 
+	for_each_sym(file->elf, sym)
+		sym->dont_correlate = dont_correlate(sym);
+	ret = prepare_identities(file->elf);
+	if (ret)
+		goto out;
+
 	ret = calculate_checksums(file);
 	if (ret)
 		goto out;
diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
index 957e589b6603..b86886c41950 100644
--- a/tools/objtool/klp-diff.c
+++ b/tools/objtool/klp-diff.c
@@ -425,7 +425,7 @@ static bool is_metadata_section(struct section *sec)
  * These symbols should never be correlated, so their local patched versions
  * are used instead of linking to the originals.
  */
-static bool dont_correlate(struct symbol *sym)
+bool dont_correlate(struct symbol *sym)
 {
 	return is_file_sym(sym) ||
 	       is_null_sym(sym) ||
diff --git a/tools/objtool/klp-identity.c b/tools/objtool/klp-identity.c
index 627eda694389..ca8e65d5d392 100644
--- a/tools/objtool/klp-identity.c
+++ b/tools/objtool/klp-identity.c
@@ -156,12 +156,19 @@ int prepare_identities(struct elf *elf)
 
 	for_each_sym(elf, sym) {
 		struct identity *identity = &sym->identity;
+		char *path;
 
 		/* Default to STT_FILE and "/" for missing DWARF information. */
 		if (!identity->external && !*identity->source && sym->file)
 			identity->source = sym->file->identity.source;
 		if (!identity->scope)
 			identity->scope = "/";
+		if (asprintf(&path, "%s%s%s", identity->source, identity->scope,
+			     identity->demangled_name) < 0) {
+			ERROR_GLIBC("asprintf");
+			return -1;
+		}
+		identity->path = path;
 		if (!sym->dont_correlate)
 			elf_hash_add(symbol_identity, &sym->identity_hash, identity_hash(identity));
 	}
-- 
2.53.0

