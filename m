Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794874124;
	b=UUrSIFbiaw6X+LOsEZcJXq95obh6+NkxqS8t95xLo5x/IoUvLx27/5bI27WykhH2Of3l
	 wy8W+STEXOM5lmig5WajcjGOnj7gFjSuGmi66ywctkRb8guV8N3V06I3fc8C6w8cTJUBu
	 MlmUyHi187lLgnxMDfRnvlrT4/I6mvnmcZvqGPUlgynUjBg2e0lORpQ95ZLERPH6V9vjP
	 +X5i++JCXrwKMIaH15HiwP1PRCuhesd4JNr4HA51o3rca/lxk+4Rfp5IommdGedNTxUKU
	 p11b7/gqMKvZhI0ioKgHWHzKIIvx9Q9PVEXW6A787DOo15PAzSeVBGuYinA8uN5wPKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794874124;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=M8VsiQr91jw4RdzaOSHDXAxpS85+QdzLOQpKPeTp+Vw=;
	b=Kf9OcowFcJsQJnWBq8jq8V/UoUNisyBDxgKmbEdmxp3ZzGKBnabDz4IuZ6m/HJXk5QmP
	 ZzNDWEtfUNTQq0fAHtEmE5NFkHffKH+6baX9DbkJ2wavzi9VxvAiCPjdb4R73PGaj2x7H
	 rmiX0CMLCT1cGGEYRv3SLaEPvk17ewsG2YeatsP6gnb+ZmYSbZdKv/TeezNZgXI90r5AK
	 cUXsbixE7fohAeseLzpPqYvW9Q+8+0iHrRqEMzEeRietlvAITNZBydz0xodS6SLrGM/TJ
	 EglhS4kYSQ9O64TP4E9Ay25NW0Ztz+XYczq9MemSE/0Bt4gM8+HFbqJhJ118kpMaD/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--wfelipe.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PaXVB2Ud;
	arc=none smtp.remote-ip=209.85.167.197
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A41606A337
	for <live-patching@vger.kernel.org>; Tue, 17 Nov 2026 00:08:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2A41606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wfelipe.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PaXVB2Ud
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-5735cd94235so1700928b6e.0
        for <live-patching@vger.kernel.org>; Mon, 16 Nov 2026 16:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794874122; x=1795478922; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M8VsiQr91jw4RdzaOSHDXAxpS85+QdzLOQpKPeTp+Vw=;
        b=PaXVB2Ud2Xnra8Eo4+OabH12DmgJH4mWt+VX/E7RSodzrv4Lk/86tK9T4P2lsPc5sj
         xuC5kTzFcFlYnlcUeb8qi0z8sS8qSEofV7lwzpQcXWW9fChWeO2qewe+QrT4WdEDeKX9
         QD2JOKOdKfyEsp4XJM7vV4ihqR+P6/OZlMRDN6Fhhgb+q1ZcfgXRHwings5PH4FFPJ4Z
         y3y8YRCckM3JSvC3Nvl2fq0DnsIIdZD7kCh9vb7Vn75D5xsnovi8ZE8JlLdQMZaM0f57
         dks/Pro8iafvGMc36G8zZrIKgHkAEkyFJcpk9vKem5PFUNsVRus81bH4Tr4KenjQwUbo
         PERw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794874122; x=1795478922;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M8VsiQr91jw4RdzaOSHDXAxpS85+QdzLOQpKPeTp+Vw=;
        b=AegWlLpLOY69RLizxbptn7xlGIGkGIAcWzqXMkss80aZ47eou81EjjY+jf+ukr7M/e
         m6m2AMkx9prmtgsIqVuFNBTSPruhMXUXEN1vBeFka2rWCRFDtV3iwRrnOML8vOcE88so
         u9b61OyQthTHF6K3/uFQR5MoH8GveI834e3vNfDDF6aB0P1yj5in5QThenFt5bqAnOaS
         ghfhXLjwZZrISNAY6+UoqXpn/uroDL5zjLhmWuY1Wy46gNrtkohtmdcFitV0IFI0yM/e
         Y5sd4k00zkd1c1N7jGvoXjQbl7pPYGHYO4RFA+hTlueNQQSAL4SICMt2i4hQHB7pwQPn
         1/IA==
X-Gm-Message-State: APuU4Z/GBws2UOWkUlM+64B/hlQNLF0Yt72GWoVeYtSmbLKiK5fHdu36
	hzGiGD2oKy8QeLagBE4QF3wjvmF75yq1UtZfVDKkqW1L3dYmj/VsJhW19t9hejmNUztaU3eS9Hp
	lJvvJSTCo0A==
X-Received: from ilx12.prod.google.com ([2002:a05:6e02:16cc:b0:53b:d747:38b5])
 (user=wfelipe job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6808:150b:b0:4cb:f21c:a794
 with SMTP id 5614622812f47-56e641c9fe8mr8362109b6e.28.1794874122181; Mon, 16
 Nov 2026 16:08:42 -0800 (PST)
Date: Tue, 17 Nov 2026 00:08:32 +0000
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
Message-ID: <20261117000835.1992893-3-wfelipe@google.com>
Subject: [PATCH 2/2] objtool/klp: Add test for global/local symbol name collisions
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
2.56.1.703.gf848ed807c-goog

