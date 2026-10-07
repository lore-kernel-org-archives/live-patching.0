Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A6648F01D
	for <live-patching@vger.kernel.org>; Wed,  7 Oct 2026 11:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791373446; cv=none; b=Big0NGM3yh0+uP8kEyQ2G59DetVZY2LXcuYhEWtYLCII8Vyhq3KkZVrsGNRGp/+xufWGhxuLxO2sqh0depTS12LRc79qHlnWPj2HYXwMdp7mhUWL1wCLAgMgfDzhzYlo+f1bn/bQIjrBVUwxPmA5zwa/OEu8JT6Cu0VCZxxFa5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791373446; c=relaxed/simple;
	bh=yJy1EBg28WQ5YKwdEmo/ACnNMCxIucKPCLam3cc82EM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=drHmBhsvi/ZXcaB/jPHIGk838ZwkBBaF+gNImILuoEegckCLLo8aNAuhloEKsgvmrtnNaCQNDy4Iwid1aQg9xi5djtcOA7BJUOYiovzoJc+gTtFfpRZou5h/8IMqj07Agev0npx70A1QWcRG79QPhE0aTrFGhwHvqlROxilIex4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dylanbhatch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bva9DVTg; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dylanbhatch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bva9DVTg"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38f97b3f853so5261753a91.3
        for <live-patching@vger.kernel.org>; Wed, 07 Oct 2026 04:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791373434; x=1791978234; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3+gTABO3yLvwj5zpCn1iXwAc4V2b2f6GGlKwYK5Pnws=;
        b=bva9DVTgpPWqDSLbdh9d0luLyBTFhugfkIixNysyapVbLh2bMkLU9XJL82tOb0q+GJ
         VeFkLQh4e27LyMQ3C18sY/9prquDZLKvZLJ7FUvwGqbX+vsu/2rsQK/EBIyDkAOeSlwD
         IRPUQp/Ted00SaIt4xVn6Bfa8weY06pvz2qyhNMGUZnRvECQcQnQ/o7TspAdQPn8rJPV
         6hWH/2z7k5Z663JciS6IuSJh9MxM+yWbNVaIovflqHPyw2d0oMtvxlF29vCsd3dB4AaN
         VU2hlF5lF5fteki8LJNTx3/arA4ioSXKnHj1KPSt5JafGt4APEweJZvw6UuHhG2AtpFa
         Reew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791373434; x=1791978234;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3+gTABO3yLvwj5zpCn1iXwAc4V2b2f6GGlKwYK5Pnws=;
        b=LgYTi6uIPhE0NKWzg1zp7R4xNvghPJr8QOPnCJ3VCt4BnytOVTADZVFYvE1fJ0o7cy
         TindMuG35VazoAEwa/iCegB4mO8+rMoTSel638VaW63G2C7qhvSCG9YDVqyL3D74TXj4
         7chIjVZ9C1g73i0R6XwFfHyiQs2Xp/u+hV6MV3GxleC+cDxtVEvf2Qkn0RP0AXI8yiH5
         XvmOnkz1Mod+tQ6HAKsu8DwQLQnFslNfAM8IxfpTlWyUEh301wunkLgxrcoP5O1fzFWR
         aRUDWAbBFZdghMEFgXH25X5IkK1wB7q5GtWkPjXII7/97R+RG/sQMgheme/MFq+S3ebW
         lvBA==
X-Forwarded-Encrypted: i=1; AKwUvByZ27x1s+l7b5AmgT1GhihP59zxuMPi7AmuYYGoG3zZe+qhYyiV+E+Q2W2oYEF0tD4PFKuL6HzI/UkhcQy4@vger.kernel.org
X-Gm-Message-State: AFq9FYIfkcS1F5+l3jh2uL5BmTMShw7YU2mnxRO24VrlvzRZ9gd3mv6E
	wQ7EIYb60cO2LoD1Av0TN6uZtjTIA0Nx4MHk/XhD8SRj4pX/u9fg40JQYkjr8mdI5gy0qMP0Gn9
	c0v2Kto4/rEq5jIoT+oFZKj3z5w==
X-Received: from pgaa8-n1.prod.google.com ([2002:a05:6a02:6488:10b0:cc7:b6ea:3094])
 (user=dylanbhatch job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:258b:b0:3a8:96cb:fe8 with SMTP id 98e67ed59e1d1-3a89f6494d7mr1748991a91.9.1791373433404;
 Wed, 07 Oct 2026 04:43:53 -0700 (PDT)
Date: Wed,  7 Oct 2026 11:43:28 +0000
In-Reply-To: <20261007114335.440322-1-dylanbhatch@google.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261007114335.440322-1-dylanbhatch@google.com>
X-Mailer: git-send-email 2.56.0.360.g66cac248cb-goog
Message-ID: <20261007114335.440322-5-dylanbhatch@google.com>
Subject: [PATCH v8 04/11] sframe: Separate reading of FRE from reading of FRE
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
 kernel/unwind/sframe.c | 97 +++++++++++++++++++++++++++++++-----------
 1 file changed, 73 insertions(+), 24 deletions(-)

diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
index 2a188373be857..ec81110a36796 100644
--- a/kernel/unwind/sframe.c
+++ b/kernel/unwind/sframe.c
@@ -37,6 +37,9 @@ struct sframe_fre_internal {
 	s32		ra_off;
 	s32		fp_off;
 	u8		info;
+	unsigned long	dw_addr;
+	unsigned char	dw_count;
+	unsigned char	dw_size;
 };
 
 static __always_inline unsigned char fre_type_to_size(unsigned char fre_type)
@@ -180,6 +183,67 @@ static __always_inline int __find_fde(struct sframe_section *sec,
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
@@ -189,7 +253,6 @@ static __always_inline int __read_fre(struct sframe_section *sec,
 	unsigned char fde_pctype = SFRAME_V3_FDE_PCTYPE(fde->info);
 	unsigned char fre_type = SFRAME_V3_FDE_FRE_TYPE(fde->info);
 	unsigned char dataword_count, dataword_size;
-	s32 cfa_off, ra_off, fp_off;
 	unsigned long cur = fre_addr;
 	unsigned char addr_size;
 	u32 ip_off;
@@ -209,7 +272,7 @@ static __always_inline int __read_fre(struct sframe_section *sec,
 	GET_AND_INC(info, cur, 1);
 	dataword_count = SFRAME_V3_FRE_DATAWORD_COUNT(info);
 	dataword_size  = dataword_size_enum_to_size(SFRAME_V3_FRE_DATAWORD_SIZE(info));
-	if (!dataword_size || !dataword_count)
+	if (!dataword_size)
 		return -EFAULT;
 
 	if (cur + (dataword_count * dataword_size) > sec->fres_end)
@@ -220,30 +283,11 @@ static __always_inline int __read_fre(struct sframe_section *sec,
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
@@ -293,6 +337,7 @@ static __always_inline int __find_fre(struct sframe_section *sec,
 	bool which = false;
 	unsigned int i;
 	u32 ip_off;
+	int ret;
 
 	ip_off = ip - fde->func_addr;
 
@@ -333,6 +378,10 @@ static __always_inline int __find_fre(struct sframe_section *sec,
 		return -EINVAL;
 	fre = prev_fre;
 
+	ret = __read_fre_datawords(sec, fde, fre);
+	if (ret)
+		return ret;
+
 	if (sframe_init_cfa_rule_data(&frame->cfa, fre->info, fre->cfa_off))
 		return -EINVAL;
 
-- 
2.56.0.360.g66cac248cb-goog

