Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2364915BF
	for <live-patching@vger.kernel.org>; Wed,  7 Oct 2026 11:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791373445; cv=none; b=Upho8NSnP4IpL3VhI5IVJdbHgC+YDUcoH4u1UHgrFlIwqiT6J6FK+FMd7WdhvAKiPLS3fCGW2U57MrjTF0bZGhCYlJX5+mmUis4ESSl7iTkLMHO+GLkgO6/JC09mfEMgL31LNjC5wGC30LxJodS4DNN+ayUBFEgIONCfqP0xq3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791373445; c=relaxed/simple;
	bh=MDt34iPcv9xrwC+bYRZ63+Q8p2PgoqNgjRax9To4r7U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pBum4BiYsnqlr/M/uCxSaKupdGpzv6BDn+adnXnJIcgrXoyO7Ek5Z5gc8iQHexC4eEz3dMJBOtMOURMyWGYoNbtKvbx22DllXEyVMsSOP8Q/hjGlS930SgsMd3+5c9yuTf5P+/8VLEqNWT4gCxn2auVgeP8K/FBhEbTju++s1Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dylanbhatch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z3PZfX7X; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dylanbhatch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z3PZfX7X"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cbb20f82a0eso2473716a12.0
        for <live-patching@vger.kernel.org>; Wed, 07 Oct 2026 04:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791373432; x=1791978232; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3mRnx/KsI1aNZGEUB8H+APpTdzLMlXu8cZAmjhfZjsM=;
        b=Z3PZfX7XqBO7cCVA6VSOBMx3D10PqFaBDWftYAogp+3JrgF0s6V3P9RO4oLuJ7SX2V
         /7a5sSKKR5rh+oOstr+3SXeNoIAW2U2jKaDeV/MOM3f8JVJjK1NCbAwjGy+qDvPv6SMO
         08fjTwgJzsxjFqKcVJv2ji2VllaZZcz7Igd1aIKZV0MBK4aan0i7uaNVt0HPoMhCa0I+
         l5QuYIP0k28ZrkkwSgIF4EysgP0q3RmYABPkKHws+6n74dP1G8HUglex+rYK6Ecj5ga2
         A+JMQwKsa+FIB3NvWL+KvEraHIxMI2W4gA4mCEJUikYGFbrMp2RnMEOJfU+bTx4bzwRi
         136w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791373432; x=1791978232;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3mRnx/KsI1aNZGEUB8H+APpTdzLMlXu8cZAmjhfZjsM=;
        b=FTgAGzrveShO6LAUcVWBdrFGTDF06fBJIsvlGNYVZywl29NCivNfOXszhvQJmT2Vt6
         K6EGlZy+WJoYp22/1VumWJld+zDHj92Uk2pCqXPQrISYLSCyDW2wrhG9pIYZRKHtczWa
         RmJxG38O5uO4QHCak/C0MZBlGMV6u9JTOJWwzDh6rVa2m0yg+XJa+ZAJRVeXhWdzbxkN
         8Qc8HYLmX2pNVc3w/ALlvzEcskymsFQ+AImPGTEHhkrVxJ8tYeXmoPFUCDii9XcdJ0I1
         nsHtA7gXAasrS4xWCgrxGGp/btRD7teuK1uDiXlrhkWZmWNInw64YtOw+MOp+2PF/WFP
         gLhQ==
X-Forwarded-Encrypted: i=1; AKwUvBx+2pN96/e7KXEBdiVSQv7Fo1e6H1lJnV9Ek8+BJ0xpQ0hA1lgSPbQ6jLVKe6e8I2oe5UQn9VPXggD/G31s@vger.kernel.org
X-Gm-Message-State: AFuF++lCGB5sc4AKPdtZaizfSzeOOvlw1PMlxXcdKMOqWhEAXEQsvsx7
	jMtUU/nwWAGH7kXJw78p69nzWmD02yoB/TYe1jVUag1uvQaPO5JnUF85hYy8aw5xPZV/BjbIRFY
	AcJcnzZHq289lTYAGybgh0Jokew==
X-Received: from pfgr2.prod.google.com ([2002:a05:6a00:c482:b0:88f:2ad7:b21c])
 (user=dylanbhatch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:4510:b0:888:4f06:903f with SMTP id d2e1a72fcca58-891b50d0145mr1504055b3a.38.1791373431585;
 Wed, 07 Oct 2026 04:43:51 -0700 (PDT)
Date: Wed,  7 Oct 2026 11:43:27 +0000
In-Reply-To: <20261007114335.440322-1-dylanbhatch@google.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261007114335.440322-1-dylanbhatch@google.com>
X-Mailer: git-send-email 2.56.0.360.g66cac248cb-goog
Message-ID: <20261007114335.440322-4-dylanbhatch@google.com>
Subject: [PATCH v8 03/11] sframe: Add support for reading vmlinux .sframe contents
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

From: Josh Poimboeuf <jpoimboe@kernel.org>

In preparation for using sframe to unwind kernel space stacks, add an
sframe_find() interface for finding the sframe information associated
with a given vmlinux text address.

Treat a RA offset from CFA of zero as indication that the RA is not
saved (on the stack).  For the topmost frame treat it as indication that
the RA is in the link/RA register, such as on arm64 and s390, and obtain
it from there.  For non-topmost frames treat it as error, as the RA must
be saved.

[ Jens Remus: Add initial support for SFrame V3 (limited to regular
FDEs).  Add support for PC-relative FDE function start offset.  Simplify
logic by using an internal FDE representation.  Rename struct sframe_fre
to sframe_fre_internal to align with struct sframe_fde_internal.
Cleanup includes.  Fix checkpatch errors "spaces required around that
':'". ]

[ Dylan Hatch: Adapt for in-kernel unwinding. Squash parts of patches by
Jens Remus <jremus@linux.ibm.com>:
 - "unwind_user: Enable archs that pass RA in a register"
 - "unwind_user: Flexible FP/RA recovery rules"
 - "unwind_user: Flexible CFA recovery rules"
 - "unwind_user/sframe: Add support for outermost frame indication" ]

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Co-developed-by: Jens Remus <jremus@linux.ibm.com>
Signed-off-by: Jens Remus <jremus@linux.ibm.com>
Reviewed-by: Indu Bhagat <ibhagatgnu@gmail.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Co-developed-by: Dylan Hatch <dylanbhatch@google.com>
Signed-off-by: Dylan Hatch <dylanbhatch@google.com>

---

Changes since v7:
 - (sashiko) Block tracing and kprobe on the sframe_find code path.
---
 include/linux/sframe.h       |   4 +-
 include/linux/unwind_types.h |  34 ++++
 kernel/unwind/sframe.c       | 351 +++++++++++++++++++++++++++++++++++
 kernel/unwind/sframe.h       |   1 +
 4 files changed, 389 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/unwind_types.h

diff --git a/include/linux/sframe.h b/include/linux/sframe.h
index 54e5cb76cb92c..c1fe8ac7df7b3 100644
--- a/include/linux/sframe.h
+++ b/include/linux/sframe.h
@@ -3,6 +3,7 @@
 #define _LINUX_SFRAME_H
 
 #include <linux/init.h>
+#include <linux/unwind_types.h>
 
 #ifdef CONFIG_UNWIND_SFRAME_LOOKUP
 
@@ -22,11 +23,12 @@ struct sframe_section {
 extern struct sframe_section kernel_sfsec __ro_after_init;
 
 void __init init_sframe_table(void);
+extern int sframe_find(unsigned long ip, struct unwind_frame *frame);
 
 #else /* !CONFIG_UNWIND_SFRAME_LOOKUP */
 
 static inline void __init init_sframe_table(void) {}
-
+static inline int sframe_find(unsigned long ip, struct unwind_frame *frame) { return -EINVAL; }
 #endif /* CONFIG_UNWIND_SFRAME_LOOKUP */
 
 #endif /* _LINUX_SFRAME_H */
diff --git a/include/linux/unwind_types.h b/include/linux/unwind_types.h
new file mode 100644
index 0000000000000..d0e69189af2ab
--- /dev/null
+++ b/include/linux/unwind_types.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_UNWIND_TYPES_H
+#define _LINUX_UNWIND_TYPES_H
+
+enum unwind_cfa_rule {
+	UNWIND_CFA_RULE_SP_OFFSET,		/* CFA = SP + offset */
+	UNWIND_CFA_RULE_FP_OFFSET,		/* CFA = FP + offset */
+	/* REG and DEREF variants not implemented -- flex FDEs not supported. */
+};
+
+struct unwind_cfa_rule_data {
+	enum unwind_cfa_rule rule;
+	s32 offset;
+	unsigned int regnum;
+};
+
+enum unwind_rule {
+	UNWIND_RULE_RETAIN,		/* entity = entity */
+	UNWIND_RULE_CFA_OFFSET_DEREF,	/* entity = *(CFA + offset) */
+};
+
+struct unwind_rule_data {
+	enum unwind_rule rule;
+	s32 offset;
+};
+
+struct unwind_frame {
+	struct unwind_cfa_rule_data cfa;
+	struct unwind_rule_data ra;
+	struct unwind_rule_data fp;
+	bool outermost;
+};
+
+#endif /* _LINUX_UNWIND_TYPES_H */
diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
index d43a3b2367fca..2a188373be857 100644
--- a/kernel/unwind/sframe.c
+++ b/kernel/unwind/sframe.c
@@ -8,6 +8,10 @@
 #include <linux/mm.h>
 #include <linux/string_helpers.h>
 #include <linux/sframe.h>
+#include <linux/unaligned.h>
+#include <linux/unwind_types.h>
+#include <linux/kallsyms.h>
+#include <asm/kprobes.h>
 #include <asm/sections.h>
 
 #include "sframe.h"
@@ -15,6 +19,353 @@
 static bool sframe_init __ro_after_init;
 struct sframe_section kernel_sfsec __ro_after_init;
 
+struct sframe_fde_internal {
+	unsigned long	func_addr;
+	u32		func_size;
+	u32		fda_off;
+	u32		fres_off;
+	u32		fres_num;
+	u8		info;
+	u8		info2;
+	u8		rep_size;
+};
+
+struct sframe_fre_internal {
+	unsigned int	size;
+	u32		ip_off;
+	s32		cfa_off;
+	s32		ra_off;
+	s32		fp_off;
+	u8		info;
+};
+
+static __always_inline unsigned char fre_type_to_size(unsigned char fre_type)
+{
+	if (fre_type > 2)
+		return 0;
+	return 1 << fre_type;
+}
+
+static __always_inline unsigned char dataword_size_enum_to_size(unsigned char dataword_size)
+{
+	if (dataword_size > 2)
+		return 0;
+	return 1 << dataword_size;
+}
+
+static __always_inline int __read_fde(struct sframe_section *sec,
+				      unsigned int fde_num,
+				      struct sframe_fde_internal *fde)
+{
+	unsigned long fde_addr, fda_addr, func_addr;
+	struct sframe_fde_v3 *_fde;
+	struct sframe_fda_v3 *_fda;
+
+	fde_addr = sec->fdes_start + (fde_num * sizeof(struct sframe_fde_v3));
+	_fde = (struct sframe_fde_v3 *)fde_addr;
+
+	func_addr = fde_addr + _fde->func_start_off;
+
+	fda_addr = sec->fres_start + _fde->fres_off;
+	if (fda_addr + sizeof(struct sframe_fda_v3) > sec->fres_end ||
+	    fda_addr + sizeof(struct sframe_fda_v3) < sec->fres_start)
+		return -EINVAL;
+	_fda = (struct sframe_fda_v3 *)fda_addr;
+
+	fde->func_addr	= func_addr;
+	fde->func_size	= _fde->func_size;
+	fde->fda_off	= _fde->fres_off;
+	fde->fres_off	= _fde->fres_off + sizeof(struct sframe_fda_v3);
+	fde->fres_num	= _fda->fres_num;
+	fde->info	= _fda->info;
+	fde->info2	= _fda->info2;
+	fde->rep_size	= _fda->rep_size;
+
+	return 0;
+}
+
+static __always_inline int __find_fde(struct sframe_section *sec,
+				      unsigned long ip,
+				      struct sframe_fde_internal *fde)
+{
+	unsigned long func_addr_low = 0, func_addr_high = ULONG_MAX;
+	struct sframe_fde_v3 *first, *low, *high, *found = NULL;
+	int ret;
+
+	first = (void *)sec->fdes_start;
+	low = first;
+	high = first + sec->num_fdes - 1;
+
+	while (low <= high) {
+		struct sframe_fde_v3 *mid;
+		s64 func_off;
+		unsigned long func_addr;
+
+		mid = low + ((high - low) / 2);
+
+		func_off = get_unaligned((s64 *)mid);
+		func_addr = (unsigned long)mid + func_off;
+
+		if (ip >= func_addr) {
+			if (func_addr < func_addr_low)
+				return -EFAULT;
+
+			func_addr_low = func_addr;
+
+			found = mid;
+			low = mid + 1;
+		} else {
+			if (func_addr > func_addr_high)
+				return -EFAULT;
+
+			func_addr_high = func_addr;
+
+			high = mid - 1;
+		}
+	}
+
+	if (!found)
+		return -EINVAL;
+
+	ret = __read_fde(sec, found - first, fde);
+	if (ret)
+		return ret;
+
+	/* make sure it's not in a gap */
+	if (ip < fde->func_addr || ip >= fde->func_addr + fde->func_size)
+		return -EINVAL;
+
+	return 0;
+}
+
+#define ____GET_AND_INC(to, from, type)					\
+({									\
+	type __to;							\
+	(__to) = get_unaligned((type *)(from));				\
+	from += sizeof(__to);						\
+	to = __to;							\
+})
+
+#define __GET_AND_INC(to, from, size, u_or_s)			\
+({								\
+	switch (size) {						\
+	case 1:							\
+		____GET_AND_INC(to, from, u_or_s##8);		\
+		break;						\
+	case 2:							\
+		____GET_AND_INC(to, from, u_or_s##16);		\
+		break;						\
+	case 4:							\
+		____GET_AND_INC(to, from, u_or_s##32);		\
+		break;						\
+	default:						\
+		return -EFAULT;					\
+	}							\
+})
+
+#define GET_UNSIGNED_AND_INC(to, from, size)			\
+	__GET_AND_INC(to, from, size, u)
+
+#define GET_SIGNED_AND_INC(to, from, size)			\
+	__GET_AND_INC(to, from, size, s)
+
+#define GET_AND_INC(to, from, size)				\
+	_Generic(to,						\
+		 u8 :	GET_UNSIGNED_AND_INC(to, from, size),	\
+		 u16 :	GET_UNSIGNED_AND_INC(to, from, size),	\
+		 u32 :	GET_UNSIGNED_AND_INC(to, from, size),	\
+		 u64 :	GET_UNSIGNED_AND_INC(to, from, size),	\
+		 s8 :	GET_SIGNED_AND_INC(to, from, size),	\
+		 s16 :	GET_SIGNED_AND_INC(to, from, size),	\
+		 s32 :	GET_SIGNED_AND_INC(to, from, size),	\
+		 s64 :	GET_SIGNED_AND_INC(to, from, size))
+
+static __always_inline int __read_fre(struct sframe_section *sec,
+				      struct sframe_fde_internal *fde,
+				      unsigned long fre_addr,
+				      struct sframe_fre_internal *fre)
+{
+	unsigned char fde_type = SFRAME_V3_FDE_TYPE(fde->info2);
+	unsigned char fde_pctype = SFRAME_V3_FDE_PCTYPE(fde->info);
+	unsigned char fre_type = SFRAME_V3_FDE_FRE_TYPE(fde->info);
+	unsigned char dataword_count, dataword_size;
+	s32 cfa_off, ra_off, fp_off;
+	unsigned long cur = fre_addr;
+	unsigned char addr_size;
+	u32 ip_off;
+	u8 info;
+
+	addr_size = fre_type_to_size(fre_type);
+	if (!addr_size)
+		return -EFAULT;
+
+	if (fre_addr + addr_size + 1 > sec->fres_end)
+		return -EFAULT;
+
+	GET_AND_INC(ip_off, cur, addr_size);
+	if (fde_pctype == SFRAME_FDE_PCTYPE_INC && ip_off > fde->func_size)
+		return -EFAULT;
+
+	GET_AND_INC(info, cur, 1);
+	dataword_count = SFRAME_V3_FRE_DATAWORD_COUNT(info);
+	dataword_size  = dataword_size_enum_to_size(SFRAME_V3_FRE_DATAWORD_SIZE(info));
+	if (!dataword_size || !dataword_count)
+		return -EFAULT;
+
+	if (cur + (dataword_count * dataword_size) > sec->fres_end)
+		return -EFAULT;
+
+	/* Flexible FDEs not supported */
+	if (fde_type != SFRAME_FDE_TYPE_DEFAULT)
+		return -EFAULT;
+
+	fre->size	= addr_size + 1 + (dataword_count * dataword_size);
+
+	GET_AND_INC(cfa_off, cur, dataword_size);
+	dataword_count--;
+
+	ra_off = sec->ra_off;
+	if (!ra_off && dataword_count) {
+		dataword_count--;
+		GET_AND_INC(ra_off, cur, dataword_size);
+	}
+
+	fp_off = sec->fp_off;
+	if (!fp_off && dataword_count) {
+		dataword_count--;
+		GET_AND_INC(fp_off, cur, dataword_size);
+	}
+
+	if (dataword_count)
+		return -EFAULT;
+
+	fre->ip_off	= ip_off;
+	fre->cfa_off	= cfa_off;
+	fre->ra_off	= ra_off;
+	fre->fp_off	= fp_off;
+	fre->info	= info;
+
+	return 0;
+}
+
+static __always_inline int
+sframe_init_cfa_rule_data(struct unwind_cfa_rule_data *cfa_rule_data,
+			  u8 info, s32 offset)
+{
+	switch (SFRAME_V3_FRE_CFA_BASE_REG_ID(info)) {
+	case SFRAME_BASE_REG_SP:
+		cfa_rule_data->rule = UNWIND_CFA_RULE_SP_OFFSET;
+		break;
+	case SFRAME_BASE_REG_FP:
+		cfa_rule_data->rule = UNWIND_CFA_RULE_FP_OFFSET;
+		break;
+	default:
+		/* Flex FDEs not supported; base can't be another register */
+		return -EINVAL;
+	}
+
+	cfa_rule_data->offset = offset;
+
+	return 0;
+}
+
+static __always_inline void
+sframe_init_rule_data(struct unwind_rule_data *rule_data, s32 offset)
+{
+	if (!offset) {
+		rule_data->rule = UNWIND_RULE_RETAIN;
+		return;
+	}
+	/* Flex FDEs not supported; always deref */
+	rule_data->rule = UNWIND_RULE_CFA_OFFSET_DEREF;
+	rule_data->offset = offset;
+}
+
+static __always_inline int __find_fre(struct sframe_section *sec,
+				      struct sframe_fde_internal *fde,
+				      unsigned long ip,
+				      struct unwind_frame *frame)
+{
+	unsigned char fde_pctype = SFRAME_V3_FDE_PCTYPE(fde->info);
+	struct sframe_fre_internal *fre, *prev_fre = NULL;
+	struct sframe_fre_internal fres[2];
+	unsigned long fre_addr;
+	bool which = false;
+	unsigned int i;
+	u32 ip_off;
+
+	ip_off = ip - fde->func_addr;
+
+	if (fde_pctype == SFRAME_FDE_PCTYPE_MASK) {
+		if (!fde->rep_size)
+			return -EFAULT;
+		ip_off %= fde->rep_size;
+	}
+
+	fre_addr = sec->fres_start + fde->fres_off;
+
+	for (i = 0; i < fde->fres_num; i++) {
+		int ret;
+
+		/*
+		 * Alternate between the two fre_addr[] entries for 'fre' and
+		 * 'prev_fre'.
+		 */
+		fre = which ? fres : fres + 1;
+		which = !which;
+
+		ret = __read_fre(sec, fde, fre_addr, fre);
+		if (ret)
+			return ret;
+
+		fre_addr += fre->size;
+
+		if (prev_fre && fre->ip_off <= prev_fre->ip_off)
+			return -EFAULT;
+
+		if (fre->ip_off > ip_off)
+			break;
+
+		prev_fre = fre;
+	}
+
+	if (!prev_fre)
+		return -EINVAL;
+	fre = prev_fre;
+
+	if (sframe_init_cfa_rule_data(&frame->cfa, fre->info, fre->cfa_off))
+		return -EINVAL;
+
+	sframe_init_rule_data(&frame->ra, fre->ra_off);
+	sframe_init_rule_data(&frame->fp, fre->fp_off);
+	frame->outermost = SFRAME_V3_FRE_RA_UNDEFINED_P(fre->info);
+
+	return 0;
+}
+
+static __always_inline int __sframe_find(struct sframe_section *sec,
+					 unsigned long ip,
+					 struct unwind_frame *frame)
+{
+	struct sframe_fde_internal fde;
+	int ret;
+
+	ret = __find_fde(sec, ip, &fde);
+	if (ret)
+		return ret;
+
+	return __find_fre(sec, &fde, ip, frame);
+}
+
+notrace int sframe_find(unsigned long ip, struct unwind_frame *frame)
+{
+	if (!frame || !sframe_init)
+		return -EINVAL;
+
+	return  __sframe_find(&kernel_sfsec, ip, frame);
+}
+NOKPROBE_SYMBOL(sframe_find);
+
 static int sframe_read_header(struct sframe_section *sec)
 {
 	unsigned long header_end, fdes_start, fdes_end, fres_start, fres_end;
diff --git a/kernel/unwind/sframe.h b/kernel/unwind/sframe.h
index bf895107c2070..17daf68309e61 100644
--- a/kernel/unwind/sframe.h
+++ b/kernel/unwind/sframe.h
@@ -74,5 +74,6 @@ struct sframe_fda_v3 {
 #define SFRAME_V3_FRE_DATAWORD_COUNT(info)		(((info) >> 1) & 0xf)
 #define SFRAME_V3_FRE_DATAWORD_SIZE(info)		(((info) >> 5) & 0x3)
 #define SFRAME_V3_AARCH64_FRE_MANGLED_RA_P(info)	(((info) >> 7) & 0x1)
+#define SFRAME_V3_FRE_RA_UNDEFINED_P(info)		(SFRAME_V3_FRE_DATAWORD_COUNT(info) == 0)
 
 #endif /* _SFRAME_H */
-- 
2.56.0.360.g66cac248cb-goog

