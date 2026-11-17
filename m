Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794881223;
	b=f7rZ4lJhALAUtWmfoH/2cyH50Or81cmUG5ptPhPAM8PfdYOEf5P/yeJpDpTVr1eRZa4Z
	 4vX2JRFR+Hzstjukfapvi+6hacwP3+tbXphn38caPpFZrYNkV91Mw2T+iKSeESZ+5cVFJ
	 zJgQYZYc40DrxchDEy9SwRHkgjzVHkieohyUCYCJt7z0kyc5GagQhro63urrjhV7LdRgl
	 N7Hg2QaC5RnDvTrnbKGlcKSyBgfe6QNYgX4hXQtUqAla6n/qKANXYK7Nysjm13OYkQJvX
	 OqVAnLuCzx69nFARf+KP7H2hUgkH6lHd6fYV0y67SA2XnSLlPyh48q7UmBqBvqKzjjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794881223;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=F/Wol9k3USBeEqH+PNSDq/iNuPWkX6BY1YLwxrQ5T8w=;
	b=vHFwlCTqsl7HuSXMRkrxpZsyTS0mTDP8+tLEw0gf1b2alMxIKOJunbJVPo15tJX5sDFY
	 igoJLN20LdrN6WQzkn8qByh6S5MP0Gk5dHzdEj5/CdKxErQZjDvXTUw3ZqGaNk0JbWCNm
	 EkUIeMkOxXQKUcosO46dUDotgJUzfNoan+04gdrUmMvAIFbXu7XWYW/Bdzr0dnK18eQwC
	 3567GgavOMbF7IZrNWRT2uBldbHA4xwOsS97ChksfDzQUeHFqbAyNKkRJ0JWtRn+6BfBZ
	 c1ejWeXPaNvYMYs8wJyOc3lHOXFlwSf9B2F42e2gxjFidrJ2BwI+wI1ngrnXEWHVTaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dylanbhatch.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=RzYFZGxP;
	arc=none smtp.remote-ip=209.85.216.71
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74D7606A886
	for <live-patching@vger.kernel.org>; Tue, 17 Nov 2026 02:07:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C74D7606A886
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dylanbhatch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=RzYFZGxP
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3ad30487d55so3083324a91.2
        for <live-patching@vger.kernel.org>; Mon, 16 Nov 2026 18:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794881222; x=1795486022; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F/Wol9k3USBeEqH+PNSDq/iNuPWkX6BY1YLwxrQ5T8w=;
        b=RzYFZGxPOzHz2EwMXmsaaN0w1T/PVCsk1CKNUkjI+L2m/ijO/JdlEUvqv0Y1eMwpen
         7wQmZPz1nW6KAlaIObytdvcyDWO1RxysBoCqL7ekV0c7rooTMj5EE5TI4YK+bIW7GVom
         iQS7XYKNgfVSIYtAJP7RZ3REBVBtmOvRVt/y68Bd8owJN+bjJ2FxifswJWZp/CoHvUEf
         B5xL1GhkVKW1bCk253xSDzdJbzj/qY4NHhZxGEWRv0k/Iip2orzXWqWmN5bhzh9XBEL7
         CdE+NYTEm64QAWrq9HYZ2OyyjQ5nYx2t3Xp8IR4SEGYL3m6OHP+RX1cJsr6NlBgV8hlt
         oJ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794881222; x=1795486022;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F/Wol9k3USBeEqH+PNSDq/iNuPWkX6BY1YLwxrQ5T8w=;
        b=bDzxEAjxKnA5sTM733W37KCNlbK1zb7XqNeO4jKNOmH0NysWNTAu82OeKGMPFg/zwq
         mXkOb0lsq7VMmKk1mhB5xhOwiaXP73AIBe8YXJ7O/iwgapt+3jm7+1KzlyySOvw0dkOs
         hlyE57h77SfJ/m77j4ivKhQR7sJsfrMlKga4ERrnLe033HtSX0zt7K/NFzN3vL+yFT7F
         d6q76i8G8F9CRCQ/XcECtto9FhFvjRABCx8oXoG5JZGLpUbOyknFIK2WSHvTvPE+Jriu
         CxVVYwF3DfWNwuDOqlrL4wuz7ajS1P2l+xBjqxKnbcsDLn3fm4UepBxBOUPzGSkwDR1Q
         uT4Q==
X-Forwarded-Encrypted: i=1; AL+hErGZRaNd+GpJVeYL+44G9bzyuKpC4S5bqEwT5cvLImdKQQynnVsif0AG+d6sMe63DbOMZ8K1RtnuudFeZ6nT@vger.kernel.org
X-Gm-Message-State: APuU4Z/iiJb6ewtx1wN5yKujJIwU4mZ2+4lq6GOrUERKgQldwqMTE+ed
	J/iD/TSeg3L+oDlU26fpHQIxNmx/q7JWI1xzTuKlYJ+elWDvpZbvKNgUVbFmOxobFsGF+zdCYf6
	kLnJUFSIRcnYLoLPI0ORQuOAEGA==
X-Received: from pjbee16.prod.google.com ([2002:a17:90a:fc50:b0:3b3:863e:dcce])
 (user=dylanbhatch job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4b88:b0:3ac:80de:44e8 with SMTP id 98e67ed59e1d1-3b1b0ccc955mr13158300a91.43.1794881221661;
 Mon, 16 Nov 2026 18:07:01 -0800 (PST)
Date: Tue, 17 Nov 2026 02:06:43 +0000
In-Reply-To: <20261117020648.323464-1-dylanbhatch@google.com>
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261117020648.323464-1-dylanbhatch@google.com>
X-Mailer: git-send-email 2.56.0.679.gc527c65306-goog
Message-ID: <20261117020648.323464-7-dylanbhatch@google.com>
Subject: [PATCH v9 06/11] arm64/sframe: Validate IP addresses
From: Dylan Hatch <dylanbhatch@google.com>
To: Roman Gushchin <roman.gushchin@linux.dev>, Weinan Liu <wnliu@google.com>, 
	Will Deacon <will@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Indu Bhagat <ibhagatgnu@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Jiri Kosina <jikos@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Jens Remus <jremus@linux.ibm.com>
Cc: Dylan Hatch <dylanbhatch@google.com>, Prasanna Kumar T S M <ptsm@linux.microsoft.com>, 
	Puranjay Mohan <puranjay@kernel.org>, Song Liu <song@kernel.org>, joe.lawrence@redhat.com, 
	linux-toolchains@vger.kernel.org, linux-kernel@vger.kernel.org, 
	live-patching@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Randy Dunlap <rdunlap@infradead.org>, Mostafa Saleh <smostafa@google.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S . Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"

Validate the given IP and computed function start address against the
known vmlinux and module text address ranges.

This requires arch-specific validation for vmlinux. This is because
arm64 keeps .exit.text (normally discarded) and .rodata.text, both of
both of which lie outside the bounds of .text and .init.text. Note that
.rodata.text contains code that is never executed by the kernel mapping,
but for which the toolchain nonetheless generates sframe data, and needs
to be considered valid at lookup time.

Suggested-by: Jens Remus <jremus@linux.ibm.com>
Signed-off-by: Dylan Hatch <dylanbhatch@google.com>

---

Changes since v8:
 - (sashiko) Mark is_kernel_inittext(), __is_kernel_text(), and
   within_module_mem_type() as __always_inline for noinstr sframe_find().
 - (sashiko) Move <asm/unwind_sframe.h> include in sframe.c to this
   patch, add generic include/asm-generic/unwind_sframe.h fallback, and
   add unwind_sframe.h file patterns to MAINTAINERS.
---
 MAINTAINERS                            |  2 ++
 arch/arm64/include/asm/sections.h      |  1 +
 arch/arm64/include/asm/unwind_sframe.h | 32 +++++++++++++++++++
 arch/arm64/kernel/vmlinux.lds.S        |  2 ++
 include/asm-generic/Kbuild             |  1 +
 include/asm-generic/sections.h         |  4 +--
 include/asm-generic/unwind_sframe.h    |  5 +++
 include/linux/module.h                 |  6 ++--
 kernel/unwind/sframe.c                 | 44 +++++++++++++++++++++++++-
 9 files changed, 91 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm64/include/asm/unwind_sframe.h
 create mode 100644 include/asm-generic/unwind_sframe.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 16e7ab1aea164..dd73e45218531 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26643,6 +26643,8 @@ STACK UNWINDING
 M:	Josh Poimboeuf <jpoimboe@kernel.org>
 M:	Steven Rostedt <rostedt@goodmis.org>
 S:	Maintained
+F:	arch/*/include/asm/unwind_sframe.h
+F:	include/asm-generic/unwind_sframe.h
 F:	include/linux/sframe.h
 F:	include/linux/unwind*.h
 F:	kernel/unwind/
diff --git a/arch/arm64/include/asm/sections.h b/arch/arm64/include/asm/sections.h
index 51b0d594239eb..5edb4304f661e 100644
--- a/arch/arm64/include/asm/sections.h
+++ b/arch/arm64/include/asm/sections.h
@@ -23,6 +23,7 @@ extern char __irqentry_text_start[], __irqentry_text_end[];
 extern char __mmuoff_data_start[], __mmuoff_data_end[];
 extern char __entry_tramp_text_start[], __entry_tramp_text_end[];
 extern char __relocate_new_kernel_start[], __relocate_new_kernel_end[];
+extern char _srodatatext[], _erodatatext[];
 
 static inline size_t entry_tramp_text_size(void)
 {
diff --git a/arch/arm64/include/asm/unwind_sframe.h b/arch/arm64/include/asm/unwind_sframe.h
new file mode 100644
index 0000000000000..1b45d328c746f
--- /dev/null
+++ b/arch/arm64/include/asm/unwind_sframe.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_ARM64_UNWIND_SFRAME_H
+#define _ASM_ARM64_UNWIND_SFRAME_H
+
+#include <linux/module.h>
+#include <linux/sframe.h>
+#include <asm/sections.h>
+
+static __always_inline bool sframe_is_kernel_ip_valid(unsigned long ip)
+{
+	if (__is_kernel_text(ip) || is_kernel_inittext(ip))
+		return true;
+
+	/* .exit.text is retained in vmlinux on arm64. */
+	if (ip >= (unsigned long)__exittext_begin &&
+	    ip < (unsigned long)__exittext_end)
+		return true;
+
+	/*
+	 * .rodata.text is never executed from the kernel mapping, but it still
+	 * has sframe data.
+	 */
+	if (ip >= (unsigned long)_srodatatext &&
+	    ip < (unsigned long)_erodatatext)
+		return true;
+
+	return false;
+}
+
+#define sframe_is_kernel_ip_valid sframe_is_kernel_ip_valid
+
+#endif /* _ASM_ARM64_UNWIND_SFRAME_H */
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 3cfa62249d0b4..62534cc9771a0 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -245,12 +245,14 @@ SECTIONS
 
 	/* code sections that are never executed via the kernel mapping */
 	.rodata.text : {
+		_srodatatext = .;
 		TRAMP_TEXT
 		HIBERNATE_TEXT
 		KEXEC_TEXT
 		IDMAP_TEXT
 		. = ALIGN(PAGE_SIZE);
 	}
+	_erodatatext = .;
 
 	idmap_pg_dir = .;
 	. += PAGE_SIZE;
diff --git a/include/asm-generic/Kbuild b/include/asm-generic/Kbuild
index b7a388bef6ea0..9230bd7878ef8 100644
--- a/include/asm-generic/Kbuild
+++ b/include/asm-generic/Kbuild
@@ -61,6 +61,7 @@ mandatory-y += tlbflush.h
 mandatory-y += topology.h
 mandatory-y += trace_clock.h
 mandatory-y += uaccess.h
+mandatory-y += unwind_sframe.h
 mandatory-y += unwind_user.h
 mandatory-y += vdso/clocksource.h
 mandatory-y += vdso/vsyscall.h
diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.h
index 336d27011a580..c9b0cec9990c1 100644
--- a/include/asm-generic/sections.h
+++ b/include/asm-generic/sections.h
@@ -197,7 +197,7 @@ static inline bool is_kernel_ro_after_init(unsigned long addr)
  *
  * Returns: true if the address is located in .init.text, false otherwise.
  */
-static inline bool is_kernel_inittext(unsigned long addr)
+static __always_inline bool is_kernel_inittext(unsigned long addr)
 {
 	return addr >= (unsigned long)_sinittext &&
 	       addr < (unsigned long)_einittext;
@@ -212,7 +212,7 @@ static inline bool is_kernel_inittext(unsigned long addr)
  * Returns: true if the address is located in .text, false otherwise.
  * Note: an internal helper, only check the range of _stext to _etext.
  */
-static inline bool __is_kernel_text(unsigned long addr)
+static __always_inline bool __is_kernel_text(unsigned long addr)
 {
 	return addr >= (unsigned long)_stext &&
 	       addr < (unsigned long)_etext;
diff --git a/include/asm-generic/unwind_sframe.h b/include/asm-generic/unwind_sframe.h
new file mode 100644
index 0000000000000..f71b3b0f53db9
--- /dev/null
+++ b/include/asm-generic/unwind_sframe.h
@@ -0,0 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_GENERIC_UNWIND_SFRAME_H
+#define _ASM_GENERIC_UNWIND_SFRAME_H
+
+#endif /* _ASM_GENERIC_UNWIND_SFRAME_H */
diff --git a/include/linux/module.h b/include/linux/module.h
index 6793e9feb20a5..964f727a65ff3 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -628,9 +628,9 @@ bool __is_module_percpu_address(unsigned long addr, unsigned long *can_addr);
 bool is_module_percpu_address(unsigned long addr);
 bool is_module_text_address(unsigned long addr);
 
-static inline bool within_module_mem_type(unsigned long addr,
-					  const struct module *mod,
-					  enum mod_mem_type type)
+static __always_inline bool within_module_mem_type(unsigned long addr,
+						   const struct module *mod,
+						   enum mod_mem_type type)
 {
 	unsigned long base, size;
 
diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
index 55b7838bdd485..d5c1c8148dadd 100644
--- a/kernel/unwind/sframe.c
+++ b/kernel/unwind/sframe.c
@@ -16,6 +16,7 @@
 #include <linux/kallsyms.h>
 #include <asm/kprobes.h>
 #include <asm/sections.h>
+#include <asm/unwind_sframe.h>
 
 #include "sframe.h"
 
@@ -45,6 +46,45 @@ struct sframe_fre_internal {
 	unsigned char	dw_size;
 };
 
+#ifndef sframe_is_kernel_ip_valid
+
+static __always_inline bool sframe_is_kernel_ip_valid(unsigned long ip)
+{
+	return __is_kernel_text(ip) || is_kernel_inittext(ip);
+}
+
+#endif
+
+#ifdef CONFIG_MODULES
+
+static __always_inline bool sframe_is_sec_module_ip_valid(struct sframe_section *sec,
+							  unsigned long ip)
+{
+	struct module *mod = container_of(sec, struct module, sframe_sec);
+
+	return within_module_mem_type(ip, mod, MOD_TEXT) ||
+		within_module_mem_type(ip, mod, MOD_INIT_TEXT);
+}
+
+#else
+
+static __always_inline bool sframe_is_sec_module_ip_valid(struct sframe_section *sec,
+							  unsigned long ip)
+{
+	return false;
+}
+
+#endif
+
+static __always_inline bool is_sec_ip_valid(struct sframe_section *sec,
+					    unsigned long ip)
+{
+	if (sec == &kernel_sfsec)
+		return sframe_is_kernel_ip_valid(ip);
+
+	return sframe_is_sec_module_ip_valid(sec, ip);
+}
+
 static __always_inline unsigned char fre_type_to_size(unsigned char fre_type)
 {
 	if (fre_type > 2)
@@ -72,6 +112,8 @@ static __always_inline int __read_fde(struct sframe_section *sec,
 	_fde = (struct sframe_fde_v3 *)fde_addr;
 
 	func_addr = fde_addr + _fde->func_start_off;
+	if (!is_sec_ip_valid(sec, func_addr))
+		return -EINVAL;
 
 	if (check_add_overflow(sec->fres_start, _fde->fres_off, &fda_addr) ||
 	    check_add_overflow(fda_addr, sizeof(struct sframe_fda_v3), &fres_addr) ||
@@ -455,7 +497,7 @@ noinstr int sframe_find(unsigned long ip, struct unwind_frame *frame)
 	if (!frame)
 		return -EINVAL;
 
-	if (__is_kernel_text(ip) || is_kernel_inittext(ip)) {
+	if (sframe_is_kernel_ip_valid(ip)) {
 		if (!sframe_init)
 			return -EINVAL;
 
-- 
2.56.0.679.gc527c65306-goog

