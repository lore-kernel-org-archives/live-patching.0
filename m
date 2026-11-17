Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794874122;
	b=LFsqMP0WXSwrGA2asO944sR+SlTN+rsJy3bwIeXX4Vip19N/OmUsTqAGJuOEirWAA4Ru
	 p2vsrZ1J2A6LAOjexFU4oGdzyH0Wq1ixUxA+Tzl49N9XYB+cZmLOn9V9MmE3m1PdXNhCF
	 GHybia2tE+E3V0MUpHTXF0SUBeHPkfLv6XwnVwVyVyHlOqwlNbJGdjoJ43clxAfoZYvJ9
	 Zh5qUzKzPmWQWz0PaKLQgV8mgS7/odo/CGPlAvaSclNGA9XF7GlAsB/4KVmJF9sVDoHpn
	 8520W3meIwgWhOv29jeUk4ORFPQzBfS8eaLoPvzimPO+nrSkDs4OpCkOOqBtG/Ps7qQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794874122;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=oWMis7rJvxkqS+rj264WdJn+/Y9mj3so8eTBQ0Zbl/s=;
	b=E3gJZqKL4hgb4uDhyZlfh9PqG/Ni/RfkbEIfbzO1CsosfSxJdE3wR64rYWCAmthz7I/U
	 SwSdsADi5WkNL+3ga75LZ7OBYyI7VogyYVIg/M3lrZ7PIfOsoW9gTK9Gsn3ZrXhg8QqiD
	 ZqECxE79iOPBAs+pgY0WMhBt+BpZE5lU4CcBpmKoomm2EuCa+3fTbYARso4UYlQiX1MRc
	 wLfWkmZ8l1NnWnPLWhztdndQmZfWFd704aaG6f0eXtzdEfEmgve/jUjtTzB3tqT8KHEsF
	 yGlcVCNuCaLtyh3y6ZpPkNa663fImZc/e8qJjiWDYkCj+sAfQEPs0y/tydkVJNNYQDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--wfelipe.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=O6Fb7h15;
	arc=none smtp.remote-ip=209.85.210.69
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4870E606A332
	for <live-patching@vger.kernel.org>; Tue, 17 Nov 2026 00:08:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4870E606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wfelipe.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=O6Fb7h15
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-8488f31d754so2922077a34.0
        for <live-patching@vger.kernel.org>; Mon, 16 Nov 2026 16:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794874121; x=1795478921; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oWMis7rJvxkqS+rj264WdJn+/Y9mj3so8eTBQ0Zbl/s=;
        b=O6Fb7h15XBmAtolhjVZ0PMGOTT5pxZ0JwoByJsSQUaBj+d0j9lt28WMbNA1AWiEVB+
         mSIv5ifjeAu+djnBOrYhol0bnwrbAoaM4NlWaFqYuyJ/REWVEf2ScSUlolfI1x7GDjX6
         IFEBo44A1l2HXfZ8ZlsPijzLsdkH24Xpkw431XsWkmPN1GTX5a/bt7IFDx7SPLp4XOqY
         4a8Fn5f/7FYSFkta8tfmgUdet7/54k8cd6oI52CMK1hyOmoIP43gFk9cagYf6AbAIZcN
         7rVmpcj68jPxyQZJ8pixEn9GUBEaaAXLB1Zut8Xzia/B+8onBbm4ipm+rfOndmhVpMPe
         cRoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794874121; x=1795478921;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oWMis7rJvxkqS+rj264WdJn+/Y9mj3so8eTBQ0Zbl/s=;
        b=LR4gt5OnQrAvfnDmGm6gX/E701fuQWbL1nXoXuGwk1dlSbnu8hrnt3l6DYnyvjHQDA
         fges6FDk8JyicsgETDVh0gjdZrmZjbId1iXwxlxfU91eodFytEkz3jsRWebp5SPfZMio
         uwI4Sg/T77HG/M/ulAp9duDb7CXfBw9hXDbv1liX4wbswyRF1GRULbr1tlNqZLzBCLB9
         2oXd/bLO21mbfkSFeliQWrmHw43gIkiV5bVHyZ0H0hGw+NVJx2dC/87ulNyF+RiC5UB8
         lEBjApiuxmKlBMa5Apoy2twwwZMJxFv0018L11J75d632xXTfaP3g1UxcQaIlxlicz+F
         CqTw==
X-Gm-Message-State: APuU4Z/HgCXh6ML+ZR1j3DcWGl19F4VQ6eVMABIscbNsYBuBfTMhuCPG
	n0VZfvUm1gutvYV91MifD6YuuvY8Bl8jUg8dK4dO+aXLHhDj4nkHMAn7hAmRSS9ZhA9yfFDSWDm
	Q14t6tgO75A==
X-Received: from oacff39.prod.google.com ([2002:a05:6871:51e7:b0:4ad:864c:9c16])
 (user=wfelipe job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6808:320d:b0:55c:928:6a0f
 with SMTP id 5614622812f47-56e65c57faemr9880831b6e.52.1794874121014; Mon, 16
 Nov 2026 16:08:41 -0800 (PST)
Date: Tue, 17 Nov 2026 00:08:31 +0000
In-Reply-To: <20261117000835.1992893-1-wfelipe@google.com>
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261117000835.1992893-1-wfelipe@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261117000835.1992893-2-wfelipe@google.com>
Subject: [PATCH 1/2] objtool/klp: Disambiguate global symbols colliding with
 local symbols
From: Wilson Felipe Pereira <wfelipe@google.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, 
	Joe Lawrence <joe.lawrence@redhat.com>, Song Liu <song@kernel.org>
Cc: live-patching@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dylan Hatch <dylanbhatch@google.com>, Yi Zhu <chuyee@google.com>, 
	Wilson Felipe Pereira <wfelipe@google.com>
Content-Type: text/plain; charset="UTF-8"

klp_find_sympos() returns 0 for any non-STB_LOCAL symbol, symid_needed()
skips non-local symbols when emitting .klp.symid entries for vmlinux.o,
and clone_reloc_klp() hardcodes sympos = 0 when a relocation targets a
restricted or module export.

However, a global symbol in one translation unit can share its name with a
static (STB_LOCAL) symbol in another translation unit (for example,
cgroup_storage_lookup in kernel/bpf/local_storage.c vs
kernel/bpf/bpf_cgrp_storage.c). At runtime, both
kallsyms_on_each_match_symbol() and module_kallsyms_on_each_symbol() count
local and global symbols together, so emitting sympos 0 for the global
symbol fails module load in klp_find_object_symbol() with 'unresolvable
ambiguity for symbol'.

Allow defined non-local symbols to receive .klp.symid entries when
duplicate names exist in vmlinux.o, compute sympos for defined non-local
symbols in klp_find_sympos() (returning 0 when unique and skipping
undefined and non-alloc symbols), and resolve sympos via klp_find_sympos()
in clone_reloc_klp() when the exported target is defined in the patched
object.

Signed-off-by: Wilson Felipe Pereira <wfelipe@google.com>
---
 tools/objtool/klp-diff.c   | 11 +++++++++++
 tools/objtool/klp-symid.c  |  2 +-
 tools/objtool/klp-sympos.c |  9 ++++++---
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
index 34da55e45609..37ad315d00af 100644
--- a/tools/objtool/klp-diff.c
+++ b/tools/objtool/klp-diff.c
@@ -1404,9 +1404,20 @@ static int clone_reloc_klp(struct elfs *e, struct reloc *patched_reloc,
 	 */
 
 	if (export) {
+		const char *modname = find_modname(e);
+
+		if (!modname)
+			return -1;
+
 		sym_modname = export->mod;
 		sym_orig_name = export->sym;
 		sympos = 0;
+		if (!strcmp(export->mod, modname) &&
+		    patched_sym->twin && !is_undef_sym(patched_sym->twin)) {
+			sympos = klp_find_sympos(e->orig, patched_sym->twin);
+			if (sympos == ULONG_MAX)
+				return -1;
+		}
 	} else {
 		sym_modname = find_modname(e);
 		if (!sym_modname)
diff --git a/tools/objtool/klp-symid.c b/tools/objtool/klp-symid.c
index b19f76dff13e..d01c13b8ffa8 100644
--- a/tools/objtool/klp-symid.c
+++ b/tools/objtool/klp-symid.c
@@ -52,7 +52,7 @@ static bool symid_needed(struct elf *elf, struct symbol *sym)
 {
 	struct symbol *s;
 
-	if (!is_local_sym(sym) || is_undef_sym(sym))
+	if (is_undef_sym(sym))
 		return false;
 
 	if (!is_func_sym(sym) && !is_object_sym(sym))
diff --git a/tools/objtool/klp-sympos.c b/tools/objtool/klp-sympos.c
index dfca9dd74681..087892ef3593 100644
--- a/tools/objtool/klp-sympos.c
+++ b/tools/objtool/klp-sympos.c
@@ -381,14 +381,14 @@ unsigned long klp_find_sympos(struct elf *elf, struct symbol *sym)
 	bool has_dup = false;
 	struct symbol *s;
 
+	if (is_undef_sym(sym))
+		return 0;
+
 	if (is_init_sym(sym)) {
 		ERROR("%s: can't patch or reference init code/data", sym->name);
 		return ULONG_MAX;
 	}
 
-	if (sym->bind != STB_LOCAL)
-		return 0;
-
 	/*
 	 * vmlinux: the final link reorders symbols relative to vmlinux.o,
 	 * so the position needs to be derived from the linked orig vmlinux via
@@ -403,6 +403,9 @@ unsigned long klp_find_sympos(struct elf *elf, struct symbol *sym)
 	 * module_kallsyms_on_each_symbol().
 	 */
 	for_each_sym(elf, s) {
+		if (is_sec_sym(s) || is_file_sym(s) || is_undef_sym(s) ||
+		    !(s->sec->sh.sh_flags & SHF_ALLOC))
+			continue;
 		if (!strcmp(s->name, sym->name)) {
 			nr_matches++;
 			if (s == sym)
-- 
2.56.1.703.gf848ed807c-goog

