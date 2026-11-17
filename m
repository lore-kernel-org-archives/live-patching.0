Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794881221;
	b=ZIAqlglXjfBNym9+oKXNvLAZAoj8L3iXVnXB5IxNKAh6LjTXXszY5cxkX0I+jAyX4QRl
	 cOcg9S7Hl82Le1gDkzB/rnrvk/UhCRYmcVmQLP+ExVZzCMhRSL9ux0q8Y19rzkQF6aXId
	 Ol78itQGYmXSDptb0BonPsuen87KOrY3/S8Eze7oD9TwmlK4UmtqPMj9KmcEA4eJ4tTzT
	 JW2bpn8Cmhk33MYekYFQTad3N21kY/aIAhNTokcuMgGP2IExt4M8ywlQz+LpuKv1KEG87
	 VlJKLPo2tg/IUs1WlSSk42suXtY7IHHTidIxJG9sY9O2C7aRnWaV9gFEeMejQSS8lRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794881221;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=MKrCvWPM8oTt1xTdSWVSXvg0CX0IDLCZJIWYopBqA58=;
	b=BrV9uVjV+R+r4YU/5LiD2n5H8OKm2y/sy6B2H0k3wB5T1xL5Ymp3GvGoj4MFjbdjWXuz
	 c0nLHDOPEyLmZoXjk6pipQq/Bmt/4LOp7J1CqpY7d4/6xHyqFDHNGtp3cyaVck4BaxcCR
	 Nu3dGPFGzFBOuk+PwbPI6S3RrWxinvpm0dhb3KgvHL+0dCMPyomnP5ddUpTWmr6CaxHNG
	 Z4ZcmU2eRqqvRIQNOFgGFepJRinpBpdj3mMkdqP2yTcERYNNJN6XdMYh1cifH7A1Lw8mN
	 q/5m0X4CMxewTgA+IzYmCshi46XntFsnNeB317RwfvpujErA4J4OsExgxkA0pNUZ6Kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dylanbhatch.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZZLPjIyU;
	arc=none smtp.remote-ip=209.85.216.71
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534B6606A882
	for <live-patching@vger.kernel.org>; Tue, 17 Nov 2026 02:07:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 534B6606A882
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dylanbhatch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZZLPjIyU
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3b3a9826f6dso520647a91.1
        for <live-patching@vger.kernel.org>; Mon, 16 Nov 2026 18:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794881221; x=1795486021; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MKrCvWPM8oTt1xTdSWVSXvg0CX0IDLCZJIWYopBqA58=;
        b=ZZLPjIyUStoK5CVbuAsQDSeHBIyVsvO1CwebkUxdTsGUt59ZVP5x709OHWA/0ddowv
         7W8MbzYsEvCIJc+tFbzCPfIOsSdWbygRTeLsDBP8ofqQrZjNLQrRGzayNNL3YNfOAxrm
         gAv+RzrLjVWdqheEmspbZYN2x4HKdB0LGv23cgL8ew6qAlL4xPHYgznx7DdIGVBZN/Ji
         hzm6YIHUSp82kAJG2VFtMKD+ZANH/60o/O0BBh/Toc4p6Y+aNAEYlHKwKMER+KIJhRTQ
         jxtOvLZ08l8tnQGHJx5VQWx/TynIwvZzyopZmxWWG5nfJ1sXjXtmX+3KvQ1s62+YY5zX
         +gZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794881221; x=1795486021;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MKrCvWPM8oTt1xTdSWVSXvg0CX0IDLCZJIWYopBqA58=;
        b=UR3d8+euDu6f3QXaINa7BK9vRQ/7OKlQUlDodrZyJHNoEUtockaOawjvi7DTnP1tKY
         98o4kQ4lU5LXwmghxAIO5I92U8p4EpevFlmK33zxivfHO2XervQvT0QOQgyg/XtIyz3S
         jIQ+3CV7yP9a2DZHi2p7hRr99HKw43AuFkxSfzFndGiSC+WXJrAl5p3lr14G/FuRaO5O
         sZI39c29/5zxx310S2yeAKj09L17Up3P+ZiRiS2HqR/CYYAnYeVIX1kHbMAO+70jB8u8
         4kW6Do9VWwAqT2jr2T9ZkfAYW5Qp+11MdGTu6ExXF4+F7NtViu0cZ0HwBvzqd5hM4OM0
         xYnA==
X-Forwarded-Encrypted: i=1; AL+hErGmNNuVHdfL6JoGg3hXfAwTdZJ8YimU4CrHxizD7KbgEvBJqaX93wDLJ72N8Cw+paUsIc8bcS8PDw/agckR@vger.kernel.org
X-Gm-Message-State: APuU4Z+MtadwgQwcOiJEtQyAIHXx0sxj/MByQIV5IhTV1AcbQedI43DO
	CIGpV8cp+s7FRgU8l2iXR38t8U4Ng2y6ffucbJb46U7kKlJKxuI0W1Rl9EJLbQ6HZXkHCWxaS5S
	PAKpfdB07zaKxiL6CvBdsO86YxA==
X-Received: from pgjk26-n1.prod.google.com ([2002:a05:6a02:81da:10b0:cdd:bfcd:be0a])
 (user=dylanbhatch job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4a:b0:3ad:544f:81e9 with SMTP id 98e67ed59e1d1-3b1b09fa382mr9942186a91.15.1794881220412;
 Mon, 16 Nov 2026 18:07:00 -0800 (PST)
Date: Tue, 17 Nov 2026 02:06:42 +0000
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
Message-ID: <20261117020648.323464-6-dylanbhatch@google.com>
Subject: [PATCH v9 05/11] module, sframe: Add sframe support for modules
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

Add sframe table to struct module and support sframe PC lookups when an
.sframe section can be found on incoming modules. SFRAME_F_FDE_SORTED is
not set for module .sframe, so FDEs are sorted right after the sframe
header is read.

Co-developed-by: Weinan Liu <wnliu@google.com>
Signed-off-by: Weinan Liu <wnliu@google.com>
Suggested-by: Jens Remus <jremus@linux.ibm.com>
Reviewed-by: Jens Remus <jremus@linux.ibm.com>
Signed-off-by: Dylan Hatch <dylanbhatch@google.com>

---

Changes since v8:
 - (sashiko) Preserve KASAN_SANITIZE_sframe.o, KCSAN_SANITIZE_sframe.o,
   and CFLAGS_REMOVE_sframe.o in kernel/unwind/Makefile.
 - (sashiko) Replace unused includes in include/linux/sframe.h with
   'struct module;' forward declaration and drop redundant includes in
   arch/arm64/include/asm/module.h and kernel/module/main.c.
---
 include/linux/module.h |   5 ++
 include/linux/sframe.h |   8 +++
 kernel/module/main.c   |  20 +++++++
 kernel/unwind/sframe.c | 118 +++++++++++++++++++++++++++++++++++++++--
 4 files changed, 146 insertions(+), 5 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index 76f4f35964773..6793e9feb20a5 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -25,6 +25,7 @@
 #include <linux/export.h>
 #include <linux/rbtree_latch.h>
 #include <linux/tracepoint-defs.h>
+#include <linux/sframe.h>
 #include <linux/srcu.h>
 #include <linux/static_call_types.h>
 #include <linux/dynamic_debug.h>
@@ -581,6 +582,10 @@ struct module {
 #ifdef CONFIG_DYNAMIC_DEBUG_CORE
 	struct _ddebug_info dyndbg_info;
 #endif
+#ifdef CONFIG_HAVE_UNWIND_KERNEL_SFRAME
+	struct sframe_section sframe_sec;
+	bool sframe_init;
+#endif
 } ____cacheline_aligned __randomize_layout;
 #ifndef MODULE_ARCH_INIT
 #define MODULE_ARCH_INIT {}
diff --git a/include/linux/sframe.h b/include/linux/sframe.h
index c1fe8ac7df7b3..ad6d693c6f059 100644
--- a/include/linux/sframe.h
+++ b/include/linux/sframe.h
@@ -5,6 +5,8 @@
 #include <linux/init.h>
 #include <linux/unwind_types.h>
 
+struct module;
+
 #ifdef CONFIG_UNWIND_SFRAME_LOOKUP
 
 struct sframe_section {
@@ -15,6 +17,7 @@ struct sframe_section {
 	unsigned long	fres_start;
 	unsigned long	fres_end;
 	unsigned int	num_fdes;
+	bool		fdes_sorted;
 
 	signed char	ra_off;
 	signed char	fp_off;
@@ -23,12 +26,17 @@ struct sframe_section {
 extern struct sframe_section kernel_sfsec __ro_after_init;
 
 void __init init_sframe_table(void);
+void sframe_module_init(struct module *mod, void *addr, unsigned int size);
+
 extern int sframe_find(unsigned long ip, struct unwind_frame *frame);
 
 #else /* !CONFIG_UNWIND_SFRAME_LOOKUP */
 
 static inline void __init init_sframe_table(void) {}
+static inline void sframe_module_init(struct module *mod, void *addr, unsigned int size) {}
+
 static inline int sframe_find(unsigned long ip, struct unwind_frame *frame) { return -EINVAL; }
+
 #endif /* CONFIG_UNWIND_SFRAME_LOOKUP */
 
 #endif /* _LINUX_SFRAME_H */
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 34e0204ea37c1..ea7e49e294291 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -3024,6 +3024,23 @@ static void module_deallocate(struct module *mod, struct load_info *info)
 	free_mod_mem(mod);
 }
 
+#ifdef CONFIG_HAVE_UNWIND_KERNEL_SFRAME
+
+static void setup_sframe(struct module *mod, const struct load_info *info)
+{
+	unsigned int sframe_size;
+	void *sframe = section_objs(info, ".sframe", 1, &sframe_size);
+
+	if (sframe)
+		sframe_module_init(mod, sframe, sframe_size);
+}
+
+#else
+
+static void setup_sframe(struct module *mod, const struct load_info *info) {}
+
+#endif
+
 int __weak module_finalize(const Elf_Ehdr *hdr,
 			   const Elf_Shdr *sechdrs,
 			   struct module *me)
@@ -3043,6 +3060,9 @@ static int post_relocation(struct module *mod, const struct load_info *info)
 	/* Setup kallsyms-specific fields. */
 	add_kallsyms(mod, info);
 
+	/* Initialize sframe metadata. */
+	setup_sframe(mod, info);
+
 	/* Arch-specific module finalizing. */
 	return module_finalize(info->hdr, info->sechdrs, mod);
 }
diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
index 50afaed9a0c93..55b7838bdd485 100644
--- a/kernel/unwind/sframe.c
+++ b/kernel/unwind/sframe.c
@@ -7,8 +7,10 @@
 
 #include <linux/mm.h>
 #include <linux/overflow.h>
+#include <linux/rcupdate.h>
 #include <linux/string_helpers.h>
 #include <linux/sframe.h>
+#include <linux/sort.h>
 #include <linux/unaligned.h>
 #include <linux/unwind_types.h>
 #include <linux/kallsyms.h>
@@ -98,6 +100,9 @@ static __always_inline int __find_fde(struct sframe_section *sec,
 	struct sframe_fde_v3 *first, *low, *high, *found = NULL;
 	int ret;
 
+	if (!sec->fdes_sorted)
+		return -EINVAL;
+
 	first = (void *)sec->fdes_start;
 	low = first;
 	high = first + sec->num_fdes - 1;
@@ -411,12 +416,53 @@ static __always_inline int __sframe_find(struct sframe_section *sec,
 	return __find_fre(sec, &fde, ip, frame);
 }
 
-notrace int sframe_find(unsigned long ip, struct unwind_frame *frame)
+#ifdef CONFIG_MODULES
+
+static __always_inline int __sframe_find_module(unsigned long ip,
+						struct unwind_frame *frame)
+{
+	struct module *mod;
+	int ret;
+
+	if (!rcu_is_watching())
+		return -EINVAL;
+
+	instrumentation_begin();
+	scoped_guard(preempt_notrace) {
+		mod = __module_text_address(ip);
+		if (mod && smp_load_acquire(&mod->sframe_init))
+			ret = __sframe_find(&mod->sframe_sec, ip, frame);
+		else
+			ret = -EINVAL;
+	}
+	instrumentation_end();
+
+	return ret;
+}
+
+#else
+
+static __always_inline int __sframe_find_module(unsigned long ip,
+						struct unwind_frame *frame)
+{
+	return -EINVAL;
+}
+
+#endif
+
+noinstr int sframe_find(unsigned long ip, struct unwind_frame *frame)
 {
-	if (!frame || !sframe_init)
+	if (!frame)
 		return -EINVAL;
 
-	return  __sframe_find(&kernel_sfsec, ip, frame);
+	if (__is_kernel_text(ip) || is_kernel_inittext(ip)) {
+		if (!sframe_init)
+			return -EINVAL;
+
+		return __sframe_find(&kernel_sfsec, ip, frame);
+	}
+
+	return  __sframe_find_module(ip, frame);
 }
 NOKPROBE_SYMBOL(sframe_find);
 
@@ -436,7 +482,6 @@ static int sframe_read_header(struct sframe_section *sec)
 
 	if (shdr->preamble.magic != SFRAME_MAGIC ||
 	    shdr->preamble.version != SFRAME_VERSION_3 ||
-	    !(shdr->preamble.flags & SFRAME_F_FDE_SORTED) ||
 	    !(shdr->preamble.flags & SFRAME_F_FDE_FUNC_START_PCREL) ||
 	    shdr->auxhdr_len) {
 		pr_debug("bad/unsupported sframe header\n");
@@ -459,6 +504,7 @@ static int sframe_read_header(struct sframe_section *sec)
 		return -EINVAL;
 	}
 
+	sec->fdes_sorted	= shdr->preamble.flags & SFRAME_F_FDE_SORTED;
 	sec->num_fdes		= num_fdes;
 	sec->fdes_start		= fdes_start;
 	sec->fres_start		= fres_start;
@@ -475,10 +521,72 @@ void __init init_sframe_table(void)
 	kernel_sfsec.sframe_start	= (unsigned long)__start_sframe;
 	kernel_sfsec.sframe_end		= (unsigned long)__end_sframe;
 
-	if (sframe_read_header(&kernel_sfsec)) {
+	if (sframe_read_header(&kernel_sfsec) || !kernel_sfsec.fdes_sorted) {
 		pr_warn("invalid vmlinux SFrame header\n");
 		return;
 	}
 
 	sframe_init = true;
 }
+
+#ifdef CONFIG_MODULES
+
+static int sframe_sort_cmp_fde(const void *a, const void *b)
+{
+	const struct sframe_fde_v3 *fde_a = a, *fde_b = b;
+	unsigned long func_start_a, func_start_b;
+
+	func_start_a = (unsigned long)fde_a + fde_a->func_start_off;
+	func_start_b = (unsigned long)fde_b + fde_b->func_start_off;
+
+	return cmp_int(func_start_a, func_start_b);
+}
+
+static void sframe_sort_swap_fde(void *a, void *b, int size)
+{
+	struct sframe_fde_v3 *fde_a = a, *fde_b = b;
+	struct sframe_fde_v3 temp;
+	long delta;
+
+	/* Swap potentially unaligned FDE */
+	memcpy(&temp, fde_a, sizeof(struct sframe_fde_v3));
+	memcpy(fde_a, fde_b, sizeof(struct sframe_fde_v3));
+	memcpy(fde_b, &temp, sizeof(struct sframe_fde_v3));
+
+	/* Adjust FDE function start offset from FDE */
+	delta = (long)((unsigned long)fde_b - (unsigned long)fde_a);
+	fde_a->func_start_off += delta;
+	fde_b->func_start_off -= delta;
+}
+
+static void sframe_sort_fdes(struct sframe_section *sec)
+{
+	void *fdes = (void *)sec->fdes_start;
+	size_t num_fdes = sec->num_fdes;
+
+	if (sec->fdes_sorted)
+		return;
+
+	sort(fdes, num_fdes, sizeof(struct sframe_fde_v3),
+	     sframe_sort_cmp_fde, sframe_sort_swap_fde);
+	sec->fdes_sorted = true;
+}
+
+void sframe_module_init(struct module *mod, void *addr, unsigned int size)
+{
+	struct sframe_section *sec = &mod->sframe_sec;
+
+	sec->sframe_start = (unsigned long)addr;
+	sec->sframe_end   = (unsigned long)addr + size;
+
+	if (sframe_read_header(sec)) {
+		pr_warn("invalid SFrame header in module %s\n", mod->name);
+		return;
+	}
+	sframe_sort_fdes(sec);
+
+	/* Ensure SFrame is initialized when sframe_find() happens */
+	smp_store_release(&mod->sframe_init, true);
+}
+
+#endif
-- 
2.56.0.679.gc527c65306-goog

