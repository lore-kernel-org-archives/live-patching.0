Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795475057;
	b=gjT67FOJXAbZKZNAQ13D3F9lJIoiKFp3IlWoGbQJff4mMpSpdiT2kcYjf4yjvBBug+FL
	 m0LQWhz4GVOxYVkuVEq82s0JPWIfE3EOoY0V6EqWoVxSyZOiruOGHvCk55GVvYh+aQO4Y
	 tLQ4+h0rEmq1fq16OqpE+a/LjYCgn8SyN4BMCMewwU1Dk+JHEGYWVvnMVS0SrpxbQ1G72
	 rpHRGSf9iv7gKGLUKhOmDOo3/7VUkzuaWXnGkeKE9+GN6EgKS90T9Yq2LWu4CqrH965gj
	 prMHeiC5XGMvc5PA4JWQYxnNMsFfWMHZArPdKAWKOLtPQ6iElgX7LjQ1l3TKEuwnO6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795475057;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=4yDRG5T3/nqj3sc11Kfkhvh3W/UkTXF80tXbsjVfcrk=;
	b=0OAxhSlthOdvYIjkTGIXxXPbBf/vT/AkX8cSGr6UJc5HGxPKex2j50m47LLX748+tn+8
	 cPSJtgSEs4BcGl61dKPScoozo/zxfJjme6asPmJh959SyJtCXm+d1zsS3G/mCXvB+rgGi
	 oijTsGqnEi0WcxVOvvsMBNIkrCsckkkfXGIWOsrB3nJuokf+jpDwN0y2C3Mia4GFm7uyR
	 4AzcstRIt2dyUYoKu0m+K/NKvBdB+fMfdFy4/JfOksKKNHpv1Ls6H9jNTC1mAUys2rNFD
	 Qh06Pi7vv7LaZ8TD8bN7D94PRoBQe0aKG3wAAFtkyue6XyY+SFvmKlp2TUkxg4cbgnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--wfelipe.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=YYMeKV2p;
	arc=none smtp.remote-ip=209.85.160.70
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691C8606A33C
	for <live-patching@vger.kernel.org>; Mon, 23 Nov 2026 23:04:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 691C8606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wfelipe.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=YYMeKV2p
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-47d75bcf3ebso3129289fac.0
        for <live-patching@vger.kernel.org>; Mon, 23 Nov 2026 15:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795475056; x=1796079856; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4yDRG5T3/nqj3sc11Kfkhvh3W/UkTXF80tXbsjVfcrk=;
        b=YYMeKV2p84vYEkN4c6fR8RZq9CXwoz9xd1oIT6aVPZoTq4KsIi5EBVdooUn5OJjR+9
         TkIJhuzV6C2DUCzAy2KHlayY0xzjijwfrZVNYss4kTsdHwsTjBo1cBE5FjoUk0+QOyDf
         McBVxh6ntYlFZs1RBNFAmwmvMu3voLqCBlrXQ+U/dPdwN6izjahJTQy0UInNYQ3rxUgV
         hxvRWWsn3cdPH6LHJAcIMS4VrQqi3E2gbk0zurs8CAjX33q+9yQUJArp0ypMk1r0wrJI
         vMpYt7zHCP3wd4jEC2sTf4DlOG7LuaTYuFItgl0hbCn6Qf7ZjsBwALvHlCJv+micFall
         cEjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795475056; x=1796079856;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4yDRG5T3/nqj3sc11Kfkhvh3W/UkTXF80tXbsjVfcrk=;
        b=a/rKK+fT/en6cBIwuUiob5q8XhPs7fRz9tL5BJ3Giv2iCwzfPtCKxsFxYRAg0KfG6M
         H49lmB4jDAZ5EMdDf1ewjJ2h91rtT3Fr4maAtzfqs8MKrz4qJE4cOsP6Ka2IJsBTbONP
         M21nHskOmidys8ZEnXOxoWo+PS/gO4xqYUEP3wfewwSSAJhsjTZu8OArOPmNNBDJ21gg
         rsO25R+SP0S6TTWMSWxHx4ziCcRZ+O3dyBDtmXHcjIuBS7puTQrUYVw1OQ0CS1E/sH1u
         jpSGemcDgTsoI09EBT2AH6KeYN2oZJvAFyCP6dZ9DkOPcjjiRWA4aiQrWRHOv0oPDX5o
         Ib0Q==
X-Gm-Message-State: APuU4Z85Ezyp+pd0F7GV4/w0JI1EhZSGuUbLkus2vPXCjRxPmSTnI1bA
	ABRZqyvJLzpcUN2uReuz2NvPOjaoC5H3hOx0vS512FgJsGvSKTpZvAOgt78Q9mq1UcMMkUqLD1O
	vc4MWSllBMA==
X-Received: from jaic5.prod.google.com ([2002:a05:6638:e0c5:b0:61d:1a3b:cb30])
 (user=wfelipe job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6808:3505:b0:572:6179:36b2
 with SMTP id 5614622812f47-57a0a4056f9mr13122521b6e.10.1795475056001; Mon, 23
 Nov 2026 15:04:16 -0800 (PST)
Date: Mon, 23 Nov 2026 23:04:07 +0000
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
Message-ID: <20261123230410.3206378-3-wfelipe@google.com>
Subject: [PATCH v2 2/2] objtool/klp: Add test for global/local symbol name collisions
From: Wilson Felipe Pereira <wfelipe@google.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, 
	Joe Lawrence <joe.lawrence@redhat.com>, Song Liu <song@kernel.org>
Cc: live-patching@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dylan Hatch <dylanbhatch@google.com>, Yi Zhu <chuyee@google.com>, 
	Wilson Felipe Pereira <wfelipe@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a test covering sympos disambiguation when a defined STB_GLOBAL symbol
shares its name with a static STB_LOCAL symbol in another translation
unit:
- A unique non-exported global continues to emit sympos 0.
- On the module path, a static in the first TU and a non-exported global
  in the second TU emit sympos 1 and 2 in .symtab order.
- On the vmlinux (.klp.symid) path, placing the global at a lower address
  than the static emits sympos 1 in linked address order, both for an
  unexported global and for an EXPORT_SYMBOL_FOR_MODULES() export.

Verified by reverting each hunk in klp-sympos.c, klp-symid.c, and
klp-diff.c individually and confirming the corresponding subtest fails.

Signed-off-by: Wilson Felipe Pereira <wfelipe@google.com>
---
v1 -> v2:
- Rebase onto v7.4-rc4 (b6a9fa34ce41); no functional changes.

v1: https://lore.kernel.org/all/20261117000835.1992893-3-wfelipe@google.com/

 .../tests/generic/fixtures/sympos_vmlinux.c   |  6 ++
 .../tests/generic/test-sympos-global-dup.sh   | 99 +++++++++++++++++++
 2 files changed, 105 insertions(+)
 create mode 100755 tools/objtool/tests/generic/test-sympos-global-dup.sh

diff --git a/tools/objtool/tests/generic/fixtures/sympos_vmlinux.c b/tools/objtool/tests/generic/fixtures/sympos_vmlinux.c
index d5e70994c582..68d6fca414e4 100644
--- a/tools/objtool/tests/generic/fixtures/sympos_vmlinux.c
+++ b/tools/objtool/tests/generic/fixtures/sympos_vmlinux.c
@@ -26,8 +26,14 @@ static const char __modinfo[]
 	__attribute__((section(".modinfo"), used, aligned(1))) = "\0name=vmlinux";
 #endif
 
+#ifdef GLOBAL_DUP
+int dup_counter = 2;
+#elif defined(EXTERN_DUP)
+extern int dup_counter;
+#else
 /* volatile so it survives as an STT_OBJECT rather than being folded away */
 static volatile int dup_counter __attribute__((section(VARSEC))) = 1;
+#endif
 
 int FUNC_NAME(int x)
 {
diff --git a/tools/objtool/tests/generic/test-sympos-global-dup.sh b/tools/objtool/tests/generic/test-sympos-global-dup.sh
new file mode 100755
index 000000000000..b309b1f3f7f8
--- /dev/null
+++ b/tools/objtool/tests/generic/test-sympos-global-dup.sh
@@ -0,0 +1,99 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# A defined STB_GLOBAL symbol in one translation unit can share its name with a
+# static (STB_LOCAL) symbol in another translation unit (for example,
+# cgroup_storage_lookup in kernel/bpf/local_storage.c vs
+# kernel/bpf/bpf_cgrp_storage.c).
+#
+# At runtime, kallsyms_on_each_match_symbol() and
+# module_kallsyms_on_each_symbol() count both local and global symbols of that
+# name, so emitting sympos 0 for the global reference fails module load with
+# "unresolvable ambiguity for symbol". Both the module path (symtab order) and
+# the vmlinux path (.klp.symid address order) must disambiguate the global
+# symbol with its 1-based position while still emitting 0 when the global name
+# is unique.
+
+. "$(dirname "$0")/../lib.sh"
+
+# 1. Unique non-exported global: sympos must remain 0.
+setup
+build_one sympos_vmlinux.c def_g.o     -DFUNC_NAME=def_g -DGLOBAL_DUP
+build_one sympos_vmlinux.c use_orig.o  -DFUNC_NAME=caller -DEXTERN_DUP -DNO_MODINFO
+build_one sympos_vmlinux.c use_patch.o -DFUNC_NAME=caller -DEXTERN_DUP -DNO_MODINFO \
+	-DPATCHED
+
+partial_link "$workdir/orig.o"    "$workdir/def_g.o" "$workdir/use_orig.o" ||
+	probe_skip "partial link unavailable"
+partial_link "$workdir/patched.o" "$workdir/def_g.o" "$workdir/use_patch.o" ||
+	probe_skip "partial link unavailable"
+
+run_diff
+assert_klp_sympos dup_counter 0
+cleanup
+
+# 2. Module path: STB_LOCAL in first TU + non-exported STB_GLOBAL in second TU.
+#    In ELF .symtab, STB_LOCAL symbols precede STB_GLOBAL symbols, so the local
+#    is position 1 and the global is position 2.
+setup
+for p in "" "-DPATCHED"; do
+	# shellcheck disable=SC2086
+	build_one sympos_vmlinux.c "loc$p.o" -DFUNC_NAME=use_local $p
+	# shellcheck disable=SC2086
+	build_one sympos_vmlinux.c "glob$p.o" -DFUNC_NAME=use_global \
+		-DGLOBAL_DUP -DNO_MODINFO $p
+done
+
+partial_link "$workdir/orig.o"    "$workdir/loc.o"         "$workdir/glob.o" ||
+	probe_skip "partial link unavailable"
+partial_link "$workdir/patched.o" "$workdir/loc-DPATCHED.o" "$workdir/glob-DPATCHED.o" ||
+	probe_skip "partial link unavailable"
+
+[ "$(count_input_symbols orig.o dup_counter)" = 2 ] ||
+	fail "fixture did not produce two dup_counter symbols"
+
+run_diff
+assert_klp_sympos dup_counter 1
+assert_klp_sympos dup_counter 2
+out_symbols | grep -qE '\.klp\.sym\.[^.]+\.dup_counter,0([[:space:]]|$)' &&
+	fail "sympos 0 emitted for global symbol colliding with local symbol"
+cleanup
+
+# 3. vmlinux path (.klp.symid): with -fdata-sections the STB_GLOBAL lands in
+#    .data.dup_counter (lower address) while the STB_LOCAL lands in .data.zzz
+#    (higher address), opposite to ELF .symtab order where locals come first.
+#    Patching only the global caller must emit sympos 1 (address order).
+setup
+build_one sympos_vmlinux.c loc.o -DFUNC_NAME=use_local -DVARSEC='".data.zzz"'
+build_one sympos_vmlinux.c glob_orig.o -DFUNC_NAME=use_global -DGLOBAL_DUP \
+	-DNO_MODINFO
+build_one sympos_vmlinux.c glob_patch.o -DFUNC_NAME=use_global -DGLOBAL_DUP \
+	-DNO_MODINFO -DPATCHED
+
+make_vmlinux_pair "$workdir/loc.o" "$workdir/glob_orig.o" \
+	       -- "$workdir/loc.o" "$workdir/glob_patch.o"
+
+[ "$(count_input_symbols vmlinux.o dup_counter)" = 2 ] ||
+	fail "vmlinux fixture did not produce two dup_counter symbols"
+
+# Premise: in ELF .symtab the local comes first (higher address .data.zzz),
+# while in address order the global comes first (.data.aaa).
+first_addr="$(in_symbols vmlinux | awk '$8 == "dup_counter" { print $2; exit }')"
+low_addr="$(in_symbols vmlinux | awk '$8 == "dup_counter" { print $2 }' | sort | head -1)"
+[ "$first_addr" != "$low_addr" ] ||
+	probe_skip "linker did not place global before local in address order"
+
+run_diff
+assert_klp_sympos dup_counter 1
+out_symbols | grep -qE '\.klp\.sym\.[^.]+\.dup_counter,(0|2)([[:space:]]|$)' &&
+	fail "wrong sympos emitted for vmlinux global colliding with higher-addr local"
+
+# 4. Same vmlinux collision when the global uses EXPORT_SYMBOL_FOR_MODULES(),
+#    which takes the export branch in clone_reloc_klp().
+add_exports_ns vmlinux "module:other" dup_counter
+run_diff
+assert_klp_sympos dup_counter 1
+out_symbols | grep -qE '\.klp\.sym\.[^.]+\.dup_counter,(0|2)([[:space:]]|$)' &&
+	fail "wrong sympos emitted for module-restricted export colliding with local"
+
+pass "global symbol colliding with static local gets disambiguated sympos"
-- 
2.56.1.750.gf70dc682cf-goog

