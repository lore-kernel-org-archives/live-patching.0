Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794881220;
	b=yCvwjcTyxKwI2IWLRNQfCZxY5Ko8RDZDe7JoASvXylXKbo0chMFnWoYa8P7pT3xhE2o3
	 tEefMFqPzxhJWjQidHZGOg9tKNJZ3bgbuREtN8iy6RApmk63a5i3lSBfGQhyA0zNKxPFb
	 Doo/JBpkVCKvPs1wZ5t6MYHug+ep//b7nlEP1F4XhN3DYCRCcGwfH707Jt2OAb/dolY0L
	 xaOptE8+6NSmqeBwL56opNCasc38aMKA7VCtOYygtOMP5k5w1Slfq2LEEhcYgmw4lxxCx
	 B4nGeUGpV2MImB8EBZPGFiaIbN8GG188k1JUN8t+YqmKL/+6Hl3lZbkqqOl1wP1Czlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794881220;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=Wu/NN4dqsDscYK6J12nkPIxZlOHkGY0u8c3baZ+fClg=;
	b=VCEAuWsayS79eu+fleSoQYCyzTMkg8vhrbyR4Q9ztNfjC9tEvv9fzbaP9vBrtn8vSiit
	 NkSoUYHpWY2sMFHGB0xnTy6grmmPFqeZlWJllctOxJKEdklO/2H//wqRgCt1vVg8gQHA5
	 KgQHHvsVo3XoHnDDSeQPkvwZfVF5h74eG4FofoSsoYsHlQlfFiJz/woJOcvHdmEzRNlCh
	 JMJ2hJaBeazoSsVbQhnzSwqxIpf1HonEaq9UsIj3+0vw468SQgYSU/Ok4dILRruMSgvEn
	 /hNWc/Sf/xKXqwy9a3wo4kGHjBy4+joC5eSwV1Qk6M0BJRmTKOSuu5f4BoCsbekgguw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dylanbhatch.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=izraIsgW;
	arc=none smtp.remote-ip=209.85.214.198
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DDC606A883
	for <live-patching@vger.kernel.org>; Tue, 17 Nov 2026 02:06:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7DDC606A883
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dylanbhatch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=izraIsgW
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ed08be1c84so63273195ad.3
        for <live-patching@vger.kernel.org>; Mon, 16 Nov 2026 18:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794881219; x=1795486019; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Wu/NN4dqsDscYK6J12nkPIxZlOHkGY0u8c3baZ+fClg=;
        b=izraIsgW8oM6nm2a/o3X5H5+wy3N+RolIEiKKfKgeohQEeqng4+PSrD/o/VFDOoLEP
         eXAM6niXT2EYv0HX/4ruUn2UmD2manHPf9gtP5GI+NG/1vMuHDHYdkMUIvlvEUVay8Pv
         vF+4CaTmEzFpghymAeLsw4GnV+DxXs0c1AEFurFdJVTQTF93lyERa+DWz3VUboPz5Crs
         kLaQRjgyOu53PfeHqQBBtRRvUsAyQeH4T6Lf5arP+elhTsyCycOkV80thvKFETsfFp5x
         fHR/F2qAXU9nejDwgZ8PLlYqCvpOgVB8AZwjfWvQ6iOOx1t+BtC9VGQM9KUXAlBhQH1H
         uOIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794881219; x=1795486019;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Wu/NN4dqsDscYK6J12nkPIxZlOHkGY0u8c3baZ+fClg=;
        b=GpHCx5bAv4fMqaR4nLyoXiOT7jIZsPbcQF+JnYotbi7Jkjxwm7Rp7PzN1F28CVtEt1
         rnBcR+3upyv4haSJsOWjfJLvGortWBkb5mspYSbBQ+QMbhmRXHyEhjkprfwQfGYRc7ET
         r8uv8BXB5aaEmdD1r06I/rUpMrhBdoNrNyn0QXrVys2pSnT6lSa83GunVOIiROCmYu9s
         6jIk0bcLJn1FzjPnwswLaN405nfk2Cc+jtjxfI1DlgfqqyA6TSG9lI7TeMDs9PODZMii
         PCJy+cGfDkheXLK2vnlaVRbdm7SwCtS82UJLjp9g8VX35OdnqsNgoWEmJ4lOQlz4MmiC
         /SsA==
X-Forwarded-Encrypted: i=1; AL+hErGMfBYEPi8FvJXNpnif+SNc90RmqpzLvP9eWQMB/CPjCIP1pcb2vuq8beKKeqgYCwVLoPTkWtzLZAX3i4T3@vger.kernel.org
X-Gm-Message-State: APuU4Z9xeHSYFqFy8dnuIQZ7YYHtP6gNqUGRo+NF7Rc/xVH7DrvJU5vH
	pGz4mG2SZozn2CvreWEKK/XDUiXa6lcw8vaa2UDnE/MDMeT3o3ZYmFhNWV6Xwmcf+nNQpRh6kd9
	czOdZYpDnNHyBY5md8H5U/eXWYg==
X-Received: from plpw11.prod.google.com ([2002:a17:902:9a8b:b0:2e8:bfd5:b889])
 (user=dylanbhatch job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:1aab:b0:2ed:3ca1:848d with SMTP id d9443c01a7336-2ee0ddb1fc5mr125024925ad.25.1794881219009;
 Mon, 16 Nov 2026 18:06:59 -0800 (PST)
Date: Tue, 17 Nov 2026 02:06:41 +0000
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
Message-ID: <20261117020648.323464-5-dylanbhatch@google.com>
Subject: [PATCH v9 04/11] sframe: Separate reading of FRE from reading of FRE
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
	Herbert Xu <herbert@gondor.apana.org.au>, "David S . Miller" <davem@davemloft.net>
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
index 93dea710d3bfc..50afaed9a0c93 100644
--- a/kernel/unwind/sframe.c
+++ b/kernel/unwind/sframe.c
@@ -38,6 +38,9 @@ struct sframe_fre_internal {
 	s32		ra_off;
 	s32		fp_off;
 	u8		info;
+	unsigned long	dw_addr;
+	unsigned char	dw_count;
+	unsigned char	dw_size;
 };
 
 static __always_inline unsigned char fre_type_to_size(unsigned char fre_type)
@@ -183,6 +186,67 @@ static __always_inline int __find_fde(struct sframe_section *sec,
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
@@ -192,7 +256,6 @@ static __always_inline int __read_fre(struct sframe_section *sec,
 	unsigned char fde_pctype = SFRAME_V3_FDE_PCTYPE(fde->info);
 	unsigned char fre_type = SFRAME_V3_FDE_FRE_TYPE(fde->info);
 	unsigned char dataword_count, dataword_size;
-	s32 cfa_off, ra_off, fp_off;
 	unsigned long cur = fre_addr;
 	unsigned char addr_size;
 	u32 ip_off;
@@ -213,7 +276,7 @@ static __always_inline int __read_fre(struct sframe_section *sec,
 	GET_AND_INC(info, cur, 1);
 	dataword_count = SFRAME_V3_FRE_DATAWORD_COUNT(info);
 	dataword_size  = dataword_size_enum_to_size(SFRAME_V3_FRE_DATAWORD_SIZE(info));
-	if (!dataword_size || !dataword_count)
+	if (!dataword_size)
 		return -EFAULT;
 
 	if (cur + (dataword_count * dataword_size) > sec->fres_end ||
@@ -225,30 +288,11 @@ static __always_inline int __read_fre(struct sframe_section *sec,
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
@@ -298,6 +342,7 @@ static __always_inline int __find_fre(struct sframe_section *sec,
 	bool which = false;
 	unsigned int i;
 	u32 ip_off;
+	int ret;
 
 	ip_off = ip - fde->func_addr;
 
@@ -338,6 +383,10 @@ static __always_inline int __find_fre(struct sframe_section *sec,
 		return -EINVAL;
 	fre = prev_fre;
 
+	ret = __read_fre_datawords(sec, fde, fre);
+	if (ret)
+		return ret;
+
 	if (sframe_init_cfa_rule_data(&frame->cfa, fre->info, fre->cfa_off))
 		return -EINVAL;
 
-- 
2.56.0.679.gc527c65306-goog

