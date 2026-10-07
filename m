Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7272B493D37
	for <live-patching@vger.kernel.org>; Wed,  7 Oct 2026 11:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791373450; cv=none; b=WU6TzAmVWT8vMdbd0fyuDdWnUrTECiAKH5bUMITksG21yxorfs43RnmJqzgpKoWAqJqEF3eiaWYvki7GJVSgmvK4ylydaBQrylBT8x0R/YVxMPh5MHNHVYawyeeZ3GYr3xydoNXM8yBscQ1u/smfPaCJVvTl9BHfZoFJaN06oPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791373450; c=relaxed/simple;
	bh=ECs1j/WilFqBSVcJj3zBPuMPJXRyGn6FnzstqC7lKp8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XdEleIIlOpeXo895JRK6g+d8FHsMpoblxn2xqzRSTDRSxLvEpampPGwSXEedeNfu5gxKoKc2D0c8NItuWxijuNDmfOF1yXtQX/Pa4OWcrfzGLkdUMXV/JL//Xj7J34TeoBEVmvBEAcQUnsPDyrDJBm3OqFhrtLNKL4+N7y7d2K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dylanbhatch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qxFZNLT6; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dylanbhatch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qxFZNLT6"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc1b6f65dacso2494696a12.1
        for <live-patching@vger.kernel.org>; Wed, 07 Oct 2026 04:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791373435; x=1791978235; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N0/74qP1zUPw49XwhZiSOI/DchmHGSPag2WK4nHiIiQ=;
        b=qxFZNLT63HNZbsQCOesn011UbSwPJhLbPuW+Tu15D4L+Hy/Mv45qskhSkicchXgX9u
         dbwnHHwJ4BhuKQDaXxocqTJ1vMVHQKtgzwKlVPz1iYho51hrybGnWtPpJXItr/9zPIQB
         WnMFdh2bmRaR2G7iZ53wFM0LVxR4oEQPQf+3lRhdz3UY8fap8FLh/PRJj99Al4fDyH2S
         samLcd8CmO1bu4rtTvMhMUZP6ew04ttVKNS2hI9JnOBOS0bUfiYYVgEWtRM3o/XQuiBU
         ojOxSJXY4UgRgZlr4djYXItdjnCGEVGCm3UsVr3WTonT9sVnthEWBE254wnjh1o9WAj0
         Fsmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791373435; x=1791978235;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N0/74qP1zUPw49XwhZiSOI/DchmHGSPag2WK4nHiIiQ=;
        b=Ztl6TcePAyEvdkpAOPy/6JmQTVCBrLVuMitzb04fGasLZ960TrErmHQ19ntZ1z72P3
         0SunnCX1cxuDaarbNqfv5HMN96WRT1uOT0l/9OziLW+/SSvs1J/5vqxGovJYAfSRvPHO
         lwVP2hgPPnvOpWWA6t7sELQ0pc/32K5B2dophiLD5cdESW5M0iNshNHgugptNIQ91vEy
         TNEuq1N+I/3uwtSdKQqFJXEOzK/WSjTVhMgLjJYE64MeNZlbAv1W7CkXvDt1CtLs6me8
         ZF2IPaoh64ZgfXJfMh7L5oz9Jfh75LY63SnB0+HqzByS2IIDcEnL20yilhP/AUDqtFT5
         Bouw==
X-Forwarded-Encrypted: i=1; AKwUvBwDF0FgOW9RGkgHYRms6JOCj8tw77sO60SnchIdt6dzM+vM/StHx+a1uWn5c4FZmHE/tN1ifUW4WeEZYkyh@vger.kernel.org
X-Gm-Message-State: AFuF++mVgA5CtR4s5o3XibIUhz6pVFJd1Mq8cpYcQrOhjCka/OfGOYL9
	2hX8QPk/SmE4/WWwIgmPyjdrpD9EFieM4T4+MJ+YfhTdKSQdu7lNNO8ldnpAKELr0dYesgZMSFB
	0L3EldalOa4HeQA6u1IHAen766w==
X-Received: from pfcg21.prod.google.com ([2002:a05:6a00:23d5:b0:890:4202:a41d])
 (user=dylanbhatch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:3995:b0:3e0:b937:8849 with SMTP id adf61e73a8af0-3e13403b4e6mr1538070637.29.1791373435257;
 Wed, 07 Oct 2026 04:43:55 -0700 (PDT)
Date: Wed,  7 Oct 2026 11:43:29 +0000
In-Reply-To: <20261007114335.440322-1-dylanbhatch@google.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261007114335.440322-1-dylanbhatch@google.com>
X-Mailer: git-send-email 2.56.0.360.g66cac248cb-goog
Message-ID: <20261007114335.440322-6-dylanbhatch@google.com>
Subject: [PATCH v8 05/11] module, sframe: Add sframe support for modules
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

Changes since v7:
- (sashiko) Move .sframe module init and sframe section fields to arch
  generic code.
- (sashiko) Make sframe_find() noinstr.
- (sashiko) Add preempt_notrace and instrumentation to
  __sframe_module_find() code path.
---
 arch/arm64/include/asm/module.h |   1 +
 include/linux/module.h          |   5 ++
 include/linux/sframe.h          |   9 +++
 kernel/module/main.c            |  21 ++++++
 kernel/unwind/Makefile          |   4 --
 kernel/unwind/sframe.c          | 118 ++++++++++++++++++++++++++++++--
 6 files changed, 149 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/include/asm/module.h b/arch/arm64/include/asm/module.h
index fb9b88eebeb15..51a8891c24e88 100644
--- a/arch/arm64/include/asm/module.h
+++ b/arch/arm64/include/asm/module.h
@@ -6,6 +6,7 @@
 #define __ASM_MODULE_H
 
 #include <asm-generic/module.h>
+#include <linux/sframe.h>
 
 struct mod_plt_sec {
 	int			plt_shndx;
diff --git a/include/linux/module.h b/include/linux/module.h
index 96cc98568eea5..6b3f3d3cb3e8d 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -26,6 +26,7 @@
 #include <linux/rbtree_latch.h>
 #include <linux/error-injection.h>
 #include <linux/tracepoint-defs.h>
+#include <linux/sframe.h>
 #include <linux/srcu.h>
 #include <linux/static_call_types.h>
 #include <linux/dynamic_debug.h>
@@ -577,6 +578,10 @@ struct module {
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
index c1fe8ac7df7b3..1aa3e07725f4d 100644
--- a/include/linux/sframe.h
+++ b/include/linux/sframe.h
@@ -2,9 +2,12 @@
 #ifndef _LINUX_SFRAME_H
 #define _LINUX_SFRAME_H
 
+#include <linux/elf.h>
 #include <linux/init.h>
 #include <linux/unwind_types.h>
 
+#include <asm-generic/module.h>
+
 #ifdef CONFIG_UNWIND_SFRAME_LOOKUP
 
 struct sframe_section {
@@ -15,6 +18,7 @@ struct sframe_section {
 	unsigned long	fres_start;
 	unsigned long	fres_end;
 	unsigned int	num_fdes;
+	bool		fdes_sorted;
 
 	signed char	ra_off;
 	signed char	fp_off;
@@ -23,12 +27,17 @@ struct sframe_section {
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
index c1b34dc1e89ac..8a4542b7e4a70 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -7,6 +7,7 @@
 
 #define INCLUDE_VERMAGIC
 
+#include <linux/elf.h>
 #include <linux/export.h>
 #include <linux/extable.h>
 #include <linux/moduleloader.h>
@@ -3008,6 +3009,23 @@ static void module_deallocate(struct module *mod, struct load_info *info)
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
@@ -3027,6 +3045,9 @@ static int post_relocation(struct module *mod, const struct load_info *info)
 	/* Setup kallsyms-specific fields. */
 	add_kallsyms(mod, info);
 
+	/* Initialize sframe metadata. */
+	setup_sframe(mod, info);
+
 	/* Arch-specific module finalizing. */
 	return module_finalize(info->hdr, info->sechdrs, mod);
 }
diff --git a/kernel/unwind/Makefile b/kernel/unwind/Makefile
index c5d953e48fe82..13254e6a7bb6d 100644
--- a/kernel/unwind/Makefile
+++ b/kernel/unwind/Makefile
@@ -1,8 +1,4 @@
  obj-$(CONFIG_UNWIND_USER)		+= user.o deferred.o
 
  KCOV_INSTRUMENT_sframe.o	:= n
- KASAN_SANITIZE_sframe.o	:= n
- KCSAN_SANITIZE_sframe.o	:= n
-
- CFLAGS_REMOVE_sframe.o = $(CC_FLAGS_FTRACE)
  obj-$(CONFIG_UNWIND_SFRAME_LOOKUP)	+= sframe.o
diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
index ec81110a36796..33883408581da 100644
--- a/kernel/unwind/sframe.c
+++ b/kernel/unwind/sframe.c
@@ -6,8 +6,10 @@
 #define pr_fmt(fmt)	"sframe: " fmt
 
 #include <linux/mm.h>
+#include <linux/rcupdate.h>
 #include <linux/string_helpers.h>
 #include <linux/sframe.h>
+#include <linux/sort.h>
 #include <linux/unaligned.h>
 #include <linux/unwind_types.h>
 #include <linux/kallsyms.h>
@@ -95,6 +97,9 @@ static __always_inline int __find_fde(struct sframe_section *sec,
 	struct sframe_fde_v3 *first, *low, *high, *found = NULL;
 	int ret;
 
+	if (!sec->fdes_sorted)
+		return -EINVAL;
+
 	first = (void *)sec->fdes_start;
 	low = first;
 	high = first + sec->num_fdes - 1;
@@ -406,12 +411,53 @@ static __always_inline int __sframe_find(struct sframe_section *sec,
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
 
@@ -431,7 +477,6 @@ static int sframe_read_header(struct sframe_section *sec)
 
 	if (shdr->preamble.magic != SFRAME_MAGIC ||
 	    shdr->preamble.version != SFRAME_VERSION_3 ||
-	    !(shdr->preamble.flags & SFRAME_F_FDE_SORTED) ||
 	    !(shdr->preamble.flags & SFRAME_F_FDE_FUNC_START_PCREL) ||
 	    shdr->auxhdr_len) {
 		pr_debug("bad/unsupported sframe header\n");
@@ -455,6 +500,7 @@ static int sframe_read_header(struct sframe_section *sec)
 		return -EINVAL;
 	}
 
+	sec->fdes_sorted	= shdr->preamble.flags & SFRAME_F_FDE_SORTED;
 	sec->num_fdes		= num_fdes;
 	sec->fdes_start		= fdes_start;
 	sec->fres_start		= fres_start;
@@ -471,10 +517,72 @@ void __init init_sframe_table(void)
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
2.56.0.360.g66cac248cb-goog

