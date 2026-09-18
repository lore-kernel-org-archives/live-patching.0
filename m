Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793C03C9EF1
	for <live-patching@vger.kernel.org>; Fri, 18 Sep 2026 22:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789771335; cv=none; b=krwTmJ5Bw7WIjFnOqikFZTxGbLSaoH8fVcp+JKNrCdRWWW93809QiruZpfDuRplbFmDis6Z+gtr+LP0wHKblvYTkULIaPphFSNO/btwRX1WnVON4gGxuDi38CoqEmRf1aNm1GW1EgMaRbdSiQvK04dxOgzfufngAdHmCWGsMaSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789771335; c=relaxed/simple;
	bh=G0B3n3HttM85BxKzpdGDQ/Sa46IhXCJT6pxzpuEG6Dk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tfgRzJRGrHSht0jhzOaJpEDOww3oVSRO79Tq1eoLDAiVTlMs3gh0FqS/8l7DCnlKq1FVJ5EqiJAoyUgP1EFetk8n7OVAz9BR9x1gPPPrKlKSgEbuD1rZ4TF6IRLEjbu/U+BU0OutHFsCH2cl7LckVkBXl8+TYK6VRlwjUY8Ku9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dylanbhatch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WY3h/HY9; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dylanbhatch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WY3h/HY9"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2d9057fab9eso18761825ad.1
        for <live-patching@vger.kernel.org>; Fri, 18 Sep 2026 15:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789771333; x=1790376133; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CTb/bQrCRYnLoC7JXti+nF/OM9r1CuOvnuv+yzx0Eyg=;
        b=WY3h/HY95sBwRgwtwk9Po6GqxmDPHs8KnG+cDY7lk5WHTqqkvHuHv/XdmIInZv7Gf2
         +jagdDWQBXzj212LndzVH3maoCDKWbLd3DGzlHYg6dF4xrqWJ4E/SlQy2sbHzO3e1KPh
         HYKuCb7pR2bbHB7gx9qzmjsgTCcxmwiFHm3SUNS42CNQuXr/UmxBjMC15CpedNQ6UU/5
         cX58jYnTnluqnpc2DJ3nJ1AiljnFMKdw1L9RhyJJeug2GOwiCJY31ocavGn6dELHRgtD
         1DNy4PQCplZ1j7nWthXOxxEtJghtnrZi+1S65Tug2bSRrfjbim1U7Kz0FKE2c32giCJr
         1H1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789771333; x=1790376133;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CTb/bQrCRYnLoC7JXti+nF/OM9r1CuOvnuv+yzx0Eyg=;
        b=LvpJgzngjfGJwtmKqePW/GLPwu6mPrhGQA7Ka9OlV/vCBM8oQLhHOm99ZUU78Negom
         nnRag+x2dNtz6OUbaldXsUYoip6h+1R8+YR6WxS4suSFCY+/i2HOBE2aQWGbL0KZkpcx
         wGjsHGopJRlVWnc7ii+CD4SMT5ykfcXE9D2KaMHx2LKHpiwMM9aKIH/taG/v/LW9Mmus
         whMgwmn4PUVKFCygn+++WYo8I7OjUJ3iPtg360woROSPE8yH2maK3Ua4SEeWYM9uwRNQ
         Z5XgvqxQ8C9RxBqi7OU60XMh/5F+Hxrl8umUmgHq0/N8Yug1oOACq8KU/P6QYBa99T1M
         ocLw==
X-Forwarded-Encrypted: i=1; AKwUvBzuuMm3zuzMFTnJatSi0cqMnpcCA3i8tvIHoyu6lZ/0Eo9Qt3RBxqEOk/z0a3/CCfK5kf2Xl4EBEUbK2+7u@vger.kernel.org
X-Gm-Message-State: AFuF++kORG8lwNIVv/TpFpHYGhKpYfX44vTu2+Su/x5Bhv0jEPPmlPOd
	Cc+X3JOXWajcIf9MI1p1Bwpc2g02Eq+Al5/qSpV0EqNm5jCYDk35cp7Kld5l++eW2QoZVaJo1cQ
	oXNzhyryuoG1BK/POYs503Gvq4Q==
X-Received: from pldy4.prod.google.com ([2002:a17:902:cac4:b0:2dc:ff56:3f4c])
 (user=dylanbhatch job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:c944:b0:2d6:ffa1:429b with SMTP id d9443c01a7336-2ddb1adf381mr78672525ad.7.1789771332693;
 Fri, 18 Sep 2026 15:42:12 -0700 (PDT)
Date: Fri, 18 Sep 2026 22:41:51 +0000
In-Reply-To: <20260918224157.1471085-1-dylanbhatch@google.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260918224157.1471085-1-dylanbhatch@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260918224157.1471085-6-dylanbhatch@google.com>
Subject: [PATCH v7 05/11] arm64/module, sframe: Add sframe support for modules
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

Add sframe table to mod_arch_specific and support sframe PC lookups when
an .sframe section can be found on incoming modules. SFRAME_F_FDE_SORTED
is not set for module .sframe, so FDEs are sorted right after the sframe
header is read.

Co-developed-by: Weinan Liu <wnliu@google.com>
Signed-off-by: Weinan Liu <wnliu@google.com>
Suggested-by: Jens Remus <jremus@linux.ibm.com>
Reviewed-by: Jens Remus <jremus@linux.ibm.com>
Signed-off-by: Dylan Hatch <dylanbhatch@google.com>

---

Changes since v6:
 - (sashiko) Check section flag SHF_ALLOC before reading in module
   .sframe.
 - (sashiko) Use READ_ONCE/WRITE_ONCE to enforce memory barrier when
   checking mod->arch.sframe_init.
 - Change IP range checks to strictly check text sections of
   vmlinux/module (instead of is_ksym_addr(ip) / __module_address(ip)).
 - (sashiko) Check kernel_sfsec.fdes_sorted during init, since
   SFRAME_F_FDE_SORTED is no longer required (in order to support
   modules).
 - (sashiko) Drop WARN_ON to pr_warn() when module sframe header read
   fails.
 - Drop sec->sec_type check in sframe_sort_fdes(), return void.
---
 arch/arm64/include/asm/module.h |   6 ++
 arch/arm64/kernel/module.c      |   5 ++
 include/linux/sframe.h          |   7 +++
 kernel/unwind/sframe.c          | 105 ++++++++++++++++++++++++++++++--
 4 files changed, 119 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/module.h b/arch/arm64/include/asm/module.h
index fb9b88eebeb15..07f309c51eee6 100644
--- a/arch/arm64/include/asm/module.h
+++ b/arch/arm64/include/asm/module.h
@@ -6,6 +6,7 @@
 #define __ASM_MODULE_H
 
 #include <asm-generic/module.h>
+#include <linux/sframe.h>
 
 struct mod_plt_sec {
 	int			plt_shndx;
@@ -17,6 +18,11 @@ struct mod_arch_specific {
 	struct mod_plt_sec	core;
 	struct mod_plt_sec	init;
 
+#ifdef CONFIG_HAVE_UNWIND_KERNEL_SFRAME
+	struct sframe_section sframe_sec;
+	bool sframe_init;
+#endif
+
 	/* for CONFIG_DYNAMIC_FTRACE */
 	struct plt_entry	*ftrace_trampolines;
 	struct plt_entry	*init_ftrace_trampolines;
diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
index 24adb581af0eb..69334e22be34e 100644
--- a/arch/arm64/kernel/module.c
+++ b/arch/arm64/kernel/module.c
@@ -18,6 +18,7 @@
 #include <linux/moduleloader.h>
 #include <linux/random.h>
 #include <linux/scs.h>
+#include <linux/sframe.h>
 
 #include <asm/alternative.h>
 #include <asm/insn.h>
@@ -515,5 +516,9 @@ int module_finalize(const Elf_Ehdr *hdr,
 		}
 	}
 
+	s = find_section(hdr, sechdrs, ".sframe");
+	if (s && (s->sh_flags & SHF_ALLOC))
+		sframe_module_init(me, (void *)s->sh_addr, s->sh_size);
+
 	return module_init_ftrace_plt(hdr, sechdrs, me);
 }
diff --git a/include/linux/sframe.h b/include/linux/sframe.h
index c1fe8ac7df7b3..58a68de1396af 100644
--- a/include/linux/sframe.h
+++ b/include/linux/sframe.h
@@ -15,6 +15,7 @@ struct sframe_section {
 	unsigned long	fres_start;
 	unsigned long	fres_end;
 	unsigned int	num_fdes;
+	bool		fdes_sorted;
 
 	signed char	ra_off;
 	signed char	fp_off;
@@ -23,12 +24,18 @@ struct sframe_section {
 extern struct sframe_section kernel_sfsec __ro_after_init;
 
 void __init init_sframe_table(void);
+void sframe_module_init(struct module *mod, void *sframe, size_t sframe_size);
+
 extern int sframe_find(unsigned long ip, struct unwind_frame *frame);
 
 #else /* !CONFIG_UNWIND_SFRAME_LOOKUP */
 
 static inline void __init init_sframe_table(void) {}
+static inline void sframe_module_init(struct module *mod, void *sframe,
+				      size_t sframe_size) {}
+
 static inline int sframe_find(unsigned long ip, struct unwind_frame *frame) { return -EINVAL; }
+
 #endif /* CONFIG_UNWIND_SFRAME_LOOKUP */
 
 #endif /* _LINUX_SFRAME_H */
diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
index 9aac703f7ce6e..503d4a2beb50e 100644
--- a/kernel/unwind/sframe.c
+++ b/kernel/unwind/sframe.c
@@ -8,6 +8,7 @@
 #include <linux/mm.h>
 #include <linux/string_helpers.h>
 #include <linux/sframe.h>
+#include <linux/sort.h>
 #include <linux/unaligned.h>
 #include <linux/unwind_types.h>
 #include <linux/kallsyms.h>
@@ -94,6 +95,9 @@ static __always_inline int __find_fde(struct sframe_section *sec,
 	struct sframe_fde_v3 *first, *low, *high, *found = NULL;
 	int ret;
 
+	if (!sec->fdes_sorted)
+		return -EINVAL;
+
 	first = (void *)sec->fdes_start;
 	low = first;
 	high = first + sec->num_fdes - 1;
@@ -405,12 +409,43 @@ static __always_inline int __sframe_find(struct sframe_section *sec,
 	return __find_fre(sec, &fde, ip, frame);
 }
 
+#ifdef CONFIG_MODULES
+
+static __always_inline int __sframe_find_module(unsigned long ip,
+						struct unwind_frame *frame)
+{
+	struct module *mod;
+
+	mod = __module_text_address(ip);
+	if (!mod || !READ_ONCE(mod->arch.sframe_init))
+		return -EINVAL;
+
+	return  __sframe_find(&mod->arch.sframe_sec, ip, frame);
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
 int sframe_find(unsigned long ip, struct unwind_frame *frame)
 {
-	if (!frame || !sframe_init)
+	if (!frame)
 		return -EINVAL;
 
-	return  __sframe_find(&kernel_sfsec, ip, frame);
+	if (is_kernel_text(ip) || is_kernel_inittext(ip)) {
+		if (!sframe_init)
+			return -EINVAL;
+
+		return __sframe_find(&kernel_sfsec, ip, frame);
+	}
+
+	return  __sframe_find_module(ip, frame);
 }
 
 static int sframe_read_header(struct sframe_section *sec)
@@ -429,7 +464,6 @@ static int sframe_read_header(struct sframe_section *sec)
 
 	if (shdr->preamble.magic != SFRAME_MAGIC ||
 	    shdr->preamble.version != SFRAME_VERSION_3 ||
-	    !(shdr->preamble.flags & SFRAME_F_FDE_SORTED) ||
 	    !(shdr->preamble.flags & SFRAME_F_FDE_FUNC_START_PCREL) ||
 	    shdr->auxhdr_len) {
 		pr_debug("bad/unsupported sframe header\n");
@@ -453,6 +487,7 @@ static int sframe_read_header(struct sframe_section *sec)
 		return -EINVAL;
 	}
 
+	sec->fdes_sorted	= shdr->preamble.flags & SFRAME_F_FDE_SORTED;
 	sec->num_fdes		= num_fdes;
 	sec->fdes_start		= fdes_start;
 	sec->fres_start		= fres_start;
@@ -469,10 +504,72 @@ void __init init_sframe_table(void)
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
+void sframe_module_init(struct module *mod, void *sframe, size_t sframe_size)
+{
+	struct sframe_section *sec = &mod->arch.sframe_sec;
+
+	sec->sframe_start = (unsigned long)sframe;
+	sec->sframe_end   = (unsigned long)sframe + sframe_size;
+
+	if (sframe_read_header(sec)) {
+		pr_warn("invalid SFrame header in module %s\n", mod->name);
+		return;
+	}
+	sframe_sort_fdes(sec);
+
+	/* Ensure SFrame is initialized when sframe_find() happens */
+	WRITE_ONCE(mod->arch.sframe_init, true);
+}
+
+#endif
-- 
2.55.0.1082.g2b9226bbc0-goog

