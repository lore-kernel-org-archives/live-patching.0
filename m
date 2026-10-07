Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C1048D879
	for <live-patching@vger.kernel.org>; Wed,  7 Oct 2026 11:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791373451; cv=none; b=ac9lM1zI4YskKOcYXkRDHwrS65MHYMGmKqxZGfIhCwIRtFzLmSoRSyovxswnsa376MhJOBu1K6nGEZ75fTHc17bSkGwhr7ani8qxtxXwl9Oy7B/kDPkz02MJufbfcLqOZ9u1Cx2htruSnqJknHq7oCTbGD83NLalm053CumhhtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791373451; c=relaxed/simple;
	bh=AymkOFYhpuoaYlczb6jgOItl+WSRrFMCpchS7hx5hZE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=m5mTg7MVdGZHlUMh5L6MenoeypBya/bfA0NB4Y5E1JW2CXzL/oT0sgrxZOP2Xw1yBLF/7Si0tsRjCiVUMkj/ltHgEMSAtUO7h73Z6A8tXgrLGK4+OkdMKStCBYxgu0rdtB9W8Au4aAUl9MqDDvbuJQ//ffQN8Xl3SeXoaxVxuwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dylanbhatch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iTN9AwN+; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dylanbhatch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iTN9AwN+"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2df8484f12cso41379095ad.3
        for <live-patching@vger.kernel.org>; Wed, 07 Oct 2026 04:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791373437; x=1791978237; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fgc8jaasabhbUwfJLQvrAFQRGkLXxRtpOJ5ukzG0TY4=;
        b=iTN9AwN+M0FYprp9JToqDwwZTjUWBYLpcMPDNMczEgjLCwydKX+QKcBjKx7IFcSWI2
         5QQAzdJaJcYFeTbr01EJrOS8ufrrO+uPhD62RkoT/ZSNBQwCdzuPgC7eHt3uehgRl473
         ZBNSTNmXoyBWMQeQeekjfsNluDiOynEXnzVKSMUvzVAYZnI5DOu4GUXedUGeK/RvrhoO
         TOQ52tlDwST9dNaAAUmyrq9gEyba5uBBJIL2nux40ppkIRFQg1xvrFQQiqreylcnLEr0
         j2yBUEgpURt8Y1gqZDZVaxbpb1H2brdNtRyjaLxtgorXNp/phl7z/myJUA9NKZdKfrId
         1P0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791373437; x=1791978237;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fgc8jaasabhbUwfJLQvrAFQRGkLXxRtpOJ5ukzG0TY4=;
        b=ZEQp4KSieLNnNZqO+8teLvnHYeGh0bPxH/LFrx7QkgxFl62xPY8xbrFWyiMGUr40u/
         6mdpST+FKRYQkN327n4HRJfsBgBIHDtOlpf7NAFBBsgJeGkgJr1U5U9krDd0YS0HiC7m
         njDM3w+JzH9MMmEGmdr2YKmHhW0nMS2+km0DnOx9AYw5TiKKfVdNmZKhtUtJ5Ojf7+Oz
         3LBKJYgXn3KeCmxzG5oAfnYHUrBrr6fAGPKvWsubusK3gyvaWWuGkuE2mGdxCtRJt3Ri
         OLfOeYK1NBES7fYFsDkkxzGs9KfLBtrdDnsMUrlC+MmH9wxMtNvXxOdSU3w3xLhSk77a
         7N9w==
X-Forwarded-Encrypted: i=1; AKwUvBykuWs9HxjfyacR/ohsZTN8ZTicaVqlxsw1cbUHKS0o7WIax+UeR1zP7Yoar+xi0QVFL6PKc6x+o6Ms+Wrz@vger.kernel.org
X-Gm-Message-State: AFq9FYIpaB6WsYRwAQXQrfqG8rOd2Yb/49lseYfHd1PbU+ZbDbAlpQWb
	ULis0+46zU9CWZU2h8vt26K8hN0i0j9tPhC4lCiVY2XSBW4ndcrHG0t/SlzU58kdh0wCsy5n/Ws
	LTQkFkwKVeywdXB0HjmuSClzpQw==
X-Received: from ploh5.prod.google.com ([2002:a17:902:f705:b0:2e6:14d:bd91])
 (user=dylanbhatch job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:4b24:b0:2dd:c0ff:e72e with SMTP id d9443c01a7336-2e60054be54mr15589775ad.64.1791373437250;
 Wed, 07 Oct 2026 04:43:57 -0700 (PDT)
Date: Wed,  7 Oct 2026 11:43:30 +0000
In-Reply-To: <20261007114335.440322-1-dylanbhatch@google.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261007114335.440322-1-dylanbhatch@google.com>
X-Mailer: git-send-email 2.56.0.360.g66cac248cb-goog
Message-ID: <20261007114335.440322-7-dylanbhatch@google.com>
Subject: [PATCH v8 06/11] arm64/sframe: Validate IP addresses
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
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>
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

Changes since v7:
 - (sashiko) Use __always_inline for IP validation helper.
---
 arch/arm64/include/asm/sections.h      |  1 +
 arch/arm64/include/asm/unwind_sframe.h | 32 +++++++++++++++++++
 arch/arm64/kernel/vmlinux.lds.S        |  2 ++
 kernel/unwind/sframe.c                 | 43 +++++++++++++++++++++++++-
 4 files changed, 77 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/include/asm/unwind_sframe.h

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
index eb1f54829503c..82fd20ccb7c43 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -237,12 +237,14 @@ SECTIONS
 
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
diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
index 33883408581da..c95fcb63e7eaf 100644
--- a/kernel/unwind/sframe.c
+++ b/kernel/unwind/sframe.c
@@ -44,6 +44,45 @@ struct sframe_fre_internal {
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
@@ -70,6 +109,8 @@ static __always_inline int __read_fde(struct sframe_section *sec,
 	_fde = (struct sframe_fde_v3 *)fde_addr;
 
 	func_addr = fde_addr + _fde->func_start_off;
+	if (!is_sec_ip_valid(sec, func_addr))
+		return -EINVAL;
 
 	fda_addr = sec->fres_start + _fde->fres_off;
 	if (fda_addr + sizeof(struct sframe_fda_v3) > sec->fres_end ||
@@ -450,7 +491,7 @@ noinstr int sframe_find(unsigned long ip, struct unwind_frame *frame)
 	if (!frame)
 		return -EINVAL;
 
-	if (__is_kernel_text(ip) || is_kernel_inittext(ip)) {
+	if (sframe_is_kernel_ip_valid(ip)) {
 		if (!sframe_init)
 			return -EINVAL;
 
-- 
2.56.0.360.g66cac248cb-goog

