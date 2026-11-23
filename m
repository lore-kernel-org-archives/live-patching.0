Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795475056;
	b=YL1Emt17g8WRT1UnnUoBhSe4bfUc/dUiRut561SS5fZmohG4IVaan3r8D9jvpjVjUEZF
	 uoK6vDSWYjbVUfiLyAkkHQvNKWlKeuRemoomkx7AcKRSTaM1Jk22qsU+6niyhyb4WuWwu
	 sWURS0m3doaSBRtyoW+apbHL7ZtMvtGv2RcsWTmlGsFJ5tSk+i1/jz4jNZyWVybGDf1kj
	 8si/jPXacZrBtlker5j66MxJ1PqMf66Jd6MlM8edjp5/PFBn0pB74CsL+taHEPR8hQAfK
	 IphYK3wBhPbHUHBwFCq51AFMY35AgeFWl32JG1js2BlyCIbxwYrCis1fILdlDvwg2dA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795475056;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=Yj2xF4o4PUTSiM+FTkNnN1xMYf/ZEDA5Uxdvg8HZkxQ=;
	b=YqjLMP4e77bXpOZhm/8A0L0sG8BEzylsTVo8ozg/FGVgS1JCgNkCWNBWNOgNqnWNvmJX
	 Eq1xOpLGsWtLyfWAR/c26c/Ov/is/ZP7Hoo0/WZx/TxRSRW54hSjRcz82+RUD5YI0x6d/
	 cqXkQJVNnS6daKBezoKTBmE0a19CmWufGaEW2AyvOVRyyZ75yc54JL7q1P1VdRoRx2lXd
	 W2EL4d3Xr3z52VsTQNPhGnP+/FHNeETzcjqJ0Ey9lYlzxCeMdC/u68/0XHlaIYGIRJZsK
	 6gG15gOD2LYgUFqAJFTqytPfC9iiOyyGlt5gJFp7e5prefQmpKqwm4BcfJ2Y7bRG31A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--wfelipe.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=A9MexrRa;
	arc=none smtp.remote-ip=209.85.167.197
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A723606A321
	for <live-patching@vger.kernel.org>; Mon, 23 Nov 2026 23:04:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A723606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wfelipe.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=A9MexrRa
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-5384e381fbbso3516604b6e.2
        for <live-patching@vger.kernel.org>; Mon, 23 Nov 2026 15:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795475055; x=1796079855; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Yj2xF4o4PUTSiM+FTkNnN1xMYf/ZEDA5Uxdvg8HZkxQ=;
        b=A9MexrRaEfcWUl6dMLWjvNT87mpo2E/wfahrmCUgkEUpi/lxq66BZnr2k7tx3iRRr0
         /HS3zryelnqdwF72Eh+/3W7GvTrjh2H4QFfsTnotDheymkNm2yz0Zx/UH99CpaHoQzE7
         vB4VKvoU08fa/H9yCUTMgIconkgDsDnuIeGfiAgyds/QiyywbBc7U46X8vY1z4kqGiyM
         1VYUD1AzNdDeeI2mUhi5FrTaHjbpWvf7bhAFJ0yv5hhv96BxMtgPxlkHPbHbXho5TgaI
         RLxiNvYQbf3yylBCNYCrcO2xWN9p1Muj1CxxVz32FG4prrWS3isLiodUsYq3S4KKkGzz
         NegA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795475055; x=1796079855;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Yj2xF4o4PUTSiM+FTkNnN1xMYf/ZEDA5Uxdvg8HZkxQ=;
        b=eD0FAoQsHqOd3QEnl/eD/LTat2dQKxt3xMOtMQSWFBXTV+LkNGLGgpVn5WzF9+xIOw
         8gi0wlgP8TRpMHzTxYVqwVAohIYGcPwJf/8yUN3btrUU0W4Vdko6c+YDi8yL2+TJivrO
         2J0zHWSsK1sMtSIOnwT/zPwgc8cGrM8LouQloYavqrUrDGUoFkPHaMWGG76FUdTAHYMp
         giSzrDGRkeK+JWG+UGli/gs7vofh8Y1y65XIPYzEgThm+H+cCSOWiusCZmhQRBzjsh0S
         n+XCq1fPbiB8B7GWDXy7MZ8ih14Hjqrjhx8Cbfl6gd4hvCRy7wblhJuQzX6kWsvbsDtA
         QkSw==
X-Gm-Message-State: APuU4Z9Nvja9vOmiwrWkbK/vcK5c/Vw+xr/+SoLjLJ4GpcCs1+g6O2kb
	E0ME2MUXSM9GHwmEgWU0zmtfXbVuu11YdjzEdzxxF8de/LMoWmY0HPAcA3NxVpLTL+Iv4NbW/V7
	meeI3EgBAgg==
X-Received: from ilbeb19.prod.google.com ([2002:a05:6e02:4613:b0:54f:d1e:e6f6])
 (user=wfelipe job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6808:6d92:b0:574:93c0:5aea
 with SMTP id 5614622812f47-57a0c6c050dmr12342269b6e.63.1795475054837; Mon, 23
 Nov 2026 15:04:14 -0800 (PST)
Date: Mon, 23 Nov 2026 23:04:06 +0000
In-Reply-To: <20261123230410.3206378-1-wfelipe@google.com>
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261123230410.3206378-1-wfelipe@google.com>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
Message-ID: <20261123230410.3206378-2-wfelipe@google.com>
Subject: [PATCH v2 1/2] objtool/klp: Disambiguate global symbols colliding
 with local symbols
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
in clone_reloc_klp() whenever patched_sym->twin exists.

Signed-off-by: Wilson Felipe Pereira <wfelipe@google.com>
---
v1 -> v2:
- Simplify clone_reloc_klp() by unifying klp_find_sympos() below the
  export/non-export branch (Josh Poimboeuf).
- Rebase onto v7.4-rc4 (b6a9fa34ce41).

v1: https://lore.kernel.org/all/20261117000835.1992893-2-wfelipe@google.com/

 tools/objtool/klp-diff.c   | 5 ++++-
 tools/objtool/klp-symid.c  | 2 +-
 tools/objtool/klp-sympos.c | 9 ++++++---
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
index 34da55e45609..fad4cfea9c9b 100644
--- a/tools/objtool/klp-diff.c
+++ b/tools/objtool/klp-diff.c
@@ -1406,13 +1406,16 @@ static int clone_reloc_klp(struct elfs *e, struct reloc *patched_reloc,
 	if (export) {
 		sym_modname = export->mod;
 		sym_orig_name = export->sym;
-		sympos = 0;
 	} else {
 		sym_modname = find_modname(e);
 		if (!sym_modname)
 			return -1;
 
 		sym_orig_name = patched_sym->twin->name;
+	}
+
+	sympos = 0;
+	if (patched_sym->twin) {
 		sympos = klp_find_sympos(e->orig, patched_sym->twin);
 		if (sympos == ULONG_MAX)
 			return -1;
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
2.56.1.750.gf70dc682cf-goog

