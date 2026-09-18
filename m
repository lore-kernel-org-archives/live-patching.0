Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD933F3273
	for <live-patching@vger.kernel.org>; Fri, 18 Sep 2026 22:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789771333; cv=none; b=ixy1SJHROzRDKoN+7/c2G6MHDgVEZaZob/RlUfv1w55JHvHdkd1VW756yDaXsBg+X1GgBaP7CyKJscwoHQ96rprrKaCeoeBJWFd63+DlbbNDyR5CF2EzIVhJKE17+ZzyFXgzmxh7nSchKFV2K9aUAfgyp4pG+0/WUDIUXziM8ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789771333; c=relaxed/simple;
	bh=qvrqMiHHbRUzKb6xANgXg73bVRN2Z1LhQgXhOP2NgTA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lH/E61nov0Gj+xAD9gFsUD/5nRMtbJAaPG5TtsbAlrWjilutx4IVMTGO8PnwtRW053goGkdFl2Cdx6Iu7bFb5JpdL41j2qV0k1qOqQLilKe1S6LO6ifxh/r6YIcnHhWj4Z9A4/N81nUThw5Sb2ox/MWEQ/S2oHaIjgl1V4v3qfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dylanbhatch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s70XcwCO; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dylanbhatch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s70XcwCO"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc1cdfb337eso1578767a12.0
        for <live-patching@vger.kernel.org>; Fri, 18 Sep 2026 15:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789771331; x=1790376131; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cYreVBH/AVISc3OQPvTRsLxBAk30fKgkR5xyJoFiadU=;
        b=s70XcwCOHwbKNiLRwfVlWZrnRKvh22FA/XLxbPgza53CLCFp2amDc2R09qOvWoIGNn
         cEtrmN+rpjn95aFtv0jstiSLbIqfizyL5cY3vxTYyoJ1bIE10UfSpyZ5TDnywRrxpGBI
         Jcb1DyyFDss10ob8LTtFTFdbQufFPNO1SXeJK7QU69qJCUPFdHJD/8mBQasZLvVnJN12
         BcEqmOl0deuTvDWggrY7/awW2d6xxOaWDjD7kVmC+326kwi1zK5U4sT6+dEXCswpTV9x
         CZnAh11+siPrAM28oHznnq+JxFTkdmdW0l17OX70z47cl2RQnEP/b2WbYfbps8nj8EMu
         a16Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789771331; x=1790376131;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cYreVBH/AVISc3OQPvTRsLxBAk30fKgkR5xyJoFiadU=;
        b=L+TRe3QassfVUEbtIVEZBq+sZex3bVlbNNYgqfwdBwPSJE1EwCQ5EGQS5uNzaOFEht
         g3tNGe1rijRhLDggUIVZywmB8Hg2WfZrTU6IhOatTRJxuxAsJjT0BgVHwOgPRfspAxyg
         wqLTi7ORHc7pr9kw9rdl8E0G2MUAu7sHo44kiKScFQmc2b2Q4plcKFhexUDUDqmo8JZx
         HsMM1bY9AzZmPnZGfN6JA627LUKCezQUHZbNp9+Xo16RzPSDMb11egAKoSZ/eaQJ9K8l
         aBd1iYA72MQSj8BngnbtLwhhwmyWnT5VfyovTcL0YgZvg7yv8hXyzZHGXDTNHUZS+N+c
         aSkw==
X-Forwarded-Encrypted: i=1; AKwUvBzsauA1jTxCPP3GaoFcPIwOUHFOggkvkkRVRudHHiQbVsfPs3VItXJmJTmtDTg5Ra/9maJP2LWK7vSk5rWI@vger.kernel.org
X-Gm-Message-State: AFuF++kkw4WXLomdfvoC209Oi1kL0rcN7OljwiaVvu07zgOIxBgvKcN0
	JPeKtZkfVy/lkZaCj78KW1ZrcW8/Ysx4f16OdOyZ0QFvjAQm2/sHhN44Tp9wRfWaxd0aZdC4IP4
	whK4GOuRzdE/4wQ/3UqcZxNOYSg==
X-Received: from pgdi3.prod.google.com ([2002:a05:6a02:51e3:b0:cc5:253c:a532])
 (user=dylanbhatch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:72aa:b0:3dd:a006:7b36 with SMTP id adf61e73a8af0-3dda0067bbfmr1750743637.53.1789771330766;
 Fri, 18 Sep 2026 15:42:10 -0700 (PDT)
Date: Fri, 18 Sep 2026 22:41:50 +0000
In-Reply-To: <20260918224157.1471085-1-dylanbhatch@google.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260918224157.1471085-1-dylanbhatch@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260918224157.1471085-5-dylanbhatch@google.com>
Subject: [PATCH v7 04/11] sframe: Separate reading of FRE from reading of FRE
 data words
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

From: Jens Remus <jremus@linux.ibm.com>

__find_fre() performs linear search for a matching SFrame FRE for a
given IP.  For that purpose it uses __read_fre(), which reads the whole
FRE.  That is the variable-size FRE structure as well as the trailing
variable-length array of variable-size data words.  For the search logic
to skip over the FRE it would be sufficient to read the variable-size
FRE structure only, which includes the count and size of data words.

Add fields to struct sframe_fre_internal to store the FRE data word's
address, count, and size.  Change __read_fre() to read the variable-
size FRE structure only and populate those new fields.  Change
__read_fre_datawords() to use those new fields.  Change __find_fre()
to use __read_fre_datawords() to read the FRE data words only after a
matching FRE has been found.

[ Dylan Hatch: Adapt for in-kernel unwinding without flexible FDEs. ]

Reviewed-by: Indu Bhagat <ibhagatgnu@gmail.com>
Signed-off-by: Jens Remus <jremus@linux.ibm.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Dylan Hatch <dylanbhatch@google.com>

---

This patch is adapted from commit 745489faa10c ("unwind_user/sframe:
Separate reading of FRE from reading of FRE data words") and squashes
changes from:

 - fdaf91d4fc0d ("unwind_user/sframe: Add support for SFrame V3
   flexible FDEs")
 - 79313210e44e ("unwind_user/sframe: Add support for outermost frame
   indication")

all of which are from Steven's sframe/core branch.

Changes include:
 - Drop support for flexible FDEs (SFRAME_FDE_TYPE_FLEX).
 - Sqaush in creation of __read_default_fre_datawords() and
   __read_fre_datawords().
 - Squash in outermost frame handling logic.
 - Deferred sframe_validate_section() changes to a later patch.
---
 kernel/unwind/sframe.c | 97 +++++++++++++++++++++++++++++++-----------
 1 file changed, 73 insertions(+), 24 deletions(-)

diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
index f3975c7e89493..9aac703f7ce6e 100644
--- a/kernel/unwind/sframe.c
+++ b/kernel/unwind/sframe.c
@@ -36,6 +36,9 @@ struct sframe_fre_internal {
 	s32		ra_off;
 	s32		fp_off;
 	u8		info;
+	unsigned long	dw_addr;
+	unsigned char	dw_count;
+	unsigned char	dw_size;
 };
 
 static __always_inline unsigned char fre_type_to_size(unsigned char fre_type)
@@ -179,6 +182,67 @@ static __always_inline int __find_fde(struct sframe_section *sec,
 		 s32 :	GET_SIGNED_AND_INC(to, from, size),	\
 		 s64 :	GET_SIGNED_AND_INC(to, from, size))
 
+static __always_inline int
+__read_default_fre_datawords(struct sframe_section *sec,
+			     struct sframe_fde_internal *fde,
+			     struct sframe_fre_internal *fre)
+{
+	unsigned char dataword_count = fre->dw_count;
+	unsigned char dataword_size = fre->dw_size;
+	unsigned long cur = fre->dw_addr;
+	s32 cfa_off, ra_off, fp_off;
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
+	fre->cfa_off	= cfa_off;
+	fre->ra_off	= ra_off;
+	fre->fp_off	= fp_off;
+
+	return 0;
+}
+
+static __always_inline int
+__read_fre_datawords(struct sframe_section *sec,
+		     struct sframe_fde_internal *fde,
+		     struct sframe_fre_internal *fre)
+{
+	unsigned char fde_type = SFRAME_V3_FDE_TYPE(fde->info2);
+	unsigned char dataword_count = fre->dw_count;
+
+	if (!dataword_count) {
+		/* A FRE without data words indicates an outermost frame. */
+		fre->cfa_off	= 0;
+		fre->ra_off	= 0;
+		fre->fp_off	= 0;
+
+		return 0;
+	}
+
+	switch (fde_type) {
+	case SFRAME_FDE_TYPE_DEFAULT:
+		return __read_default_fre_datawords(sec, fde, fre);
+	/* Flexible FDEs not supported */
+	default:
+		return -EFAULT;
+	}
+}
+
 static __always_inline int __read_fre(struct sframe_section *sec,
 				      struct sframe_fde_internal *fde,
 				      unsigned long fre_addr,
@@ -188,7 +252,6 @@ static __always_inline int __read_fre(struct sframe_section *sec,
 	unsigned char fde_pctype = SFRAME_V3_FDE_PCTYPE(fde->info);
 	unsigned char fre_type = SFRAME_V3_FDE_FRE_TYPE(fde->info);
 	unsigned char dataword_count, dataword_size;
-	s32 cfa_off, ra_off, fp_off;
 	unsigned long cur = fre_addr;
 	unsigned char addr_size;
 	u32 ip_off;
@@ -208,7 +271,7 @@ static __always_inline int __read_fre(struct sframe_section *sec,
 	GET_AND_INC(info, cur, 1);
 	dataword_count = SFRAME_V3_FRE_DATAWORD_COUNT(info);
 	dataword_size  = dataword_size_enum_to_size(SFRAME_V3_FRE_DATAWORD_SIZE(info));
-	if (!dataword_size || !dataword_count)
+	if (!dataword_size)
 		return -EFAULT;
 
 	if (cur + (dataword_count * dataword_size) > sec->fres_end)
@@ -219,30 +282,11 @@ static __always_inline int __read_fre(struct sframe_section *sec,
 		return -EFAULT;
 
 	fre->size	= addr_size + 1 + (dataword_count * dataword_size);
-
-	GET_AND_INC(cfa_off, cur, dataword_size);
-	dataword_count--;
-
-	ra_off = sec->ra_off;
-	if (!ra_off && dataword_count) {
-		dataword_count--;
-		GET_AND_INC(ra_off, cur, dataword_size);
-	}
-
-	fp_off = sec->fp_off;
-	if (!fp_off && dataword_count) {
-		dataword_count--;
-		GET_AND_INC(fp_off, cur, dataword_size);
-	}
-
-	if (dataword_count)
-		return -EFAULT;
-
 	fre->ip_off	= ip_off;
-	fre->cfa_off	= cfa_off;
-	fre->ra_off	= ra_off;
-	fre->fp_off	= fp_off;
 	fre->info	= info;
+	fre->dw_addr	= cur;
+	fre->dw_count	= dataword_count;
+	fre->dw_size	= dataword_size;
 
 	return 0;
 }
@@ -292,6 +336,7 @@ static __always_inline int __find_fre(struct sframe_section *sec,
 	bool which = false;
 	unsigned int i;
 	u32 ip_off;
+	int ret;
 
 	ip_off = ip - fde->func_addr;
 
@@ -332,6 +377,10 @@ static __always_inline int __find_fre(struct sframe_section *sec,
 		return -EINVAL;
 	fre = prev_fre;
 
+	ret = __read_fre_datawords(sec, fde, fre);
+	if (ret)
+		return ret;
+
 	if (sframe_init_cfa_rule_data(&frame->cfa, fre->info, fre->cfa_off))
 		return -EINVAL;
 
-- 
2.55.0.1082.g2b9226bbc0-goog

