Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793799170;
	b=1SieyO5ztcA0NOPP9vR02PN49gWz+KprUT813Iz7tPs0dWZeGiOjaxDEYwu2q+h6YZQa
	 FMG7VNWsn6v7KDiaYNHB6SVVl0cxg57KmQjeQKpMIFCVfIaza70H6p58q2LG0/FyXIN5b
	 85LehY1qKLo4ykjnFERXpzQ9v9wfdxEZSn+1e+tLYdqPiPThBY8tGG3NaneX1dGhFOZ4g
	 Q6+ljL+AlopWq/T2+5uoVfdE5ghau2HiVygyerhiG49XWBhlZj4Qn2YnqvgGU9GWyatPM
	 /teo7tooNdA5snW9gf2tb+snLz1EDhF1OqVenJj/Kjybl9jmy8R0cFs2TQzmG4ryiTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793799170;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=NHrXeDMm3qDspSdmiyISYSVqXsqYRkHWDw+hommVmRE=;
	b=T52CxioGAUb5QCJPEOupJV9CWsqTdO8mZagBnCO/1g5t0sQlakQkTLl9+CTjHVJuHenW
	 w5vrTRTh9vI02hAGlr1bh9U8AjOX0RRso3pqNaCPSL99mIitH9efM52Kvg7lXlAP+nf42
	 VWVfqe6z4SEp012+9C2Z+y1Ib7l/SdtWlMKSfRbOO2wK1M9ZpuQxebYsLr5/mGsEShteW
	 odedeiXwPSpjw37vVHQD1K7sB1+6FDzQ5Tomp0TmbNjEJqqyGSVE24TiLW6TCzOeOi/Ax
	 vXS9vNybxK2jiWtrrbmYjFYIXe0REnmJ/JmAdq1Bjzm7Nx2MD0Z+xrOJ1l4l6115j7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yxfw6gUK;
	arc=none smtp.remote-ip=209.85.210.170
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08A4606D802
	for <live-patching@vger.kernel.org>; Wed,  4 Nov 2026 13:32:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C08A4606D802
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yxfw6gUK
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8a070b3f44aso288276b3a.2
        for <live-patching@vger.kernel.org>; Wed, 04 Nov 2026 05:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793799169; x=1794403969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NHrXeDMm3qDspSdmiyISYSVqXsqYRkHWDw+hommVmRE=;
        b=yxfw6gUKwfJp2UuyU25pLCXVj/iCyT+5tv9yXKrls2QPKSimGidfBfI4TSWq5BeRHO
         8TEIMOFanL3bpYnyC97U5Lk1UDoZtVyYGZKc1/D+Ha6eikJCDz72yl+vzBlYvvuMQDT5
         CvN0uUdLOdFQGLAk2joRxrWH2kUbJYuvJjsjohO0vhGwPpz1gAB1OZTPQ5RKc2n58Lq1
         mBdvap4nFtCUCDoiNpO4HkksG3UZbhnf4+J+IpRTP7HXHKTMPl2N1mWsC2KxL6/8WJmD
         SM66mvlfOdq6UkDY5CdHibP3dQMlALDXtuV0mj6v0SF6TYgribEE7episefpDKZDrzU9
         Ae/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793799169; x=1794403969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NHrXeDMm3qDspSdmiyISYSVqXsqYRkHWDw+hommVmRE=;
        b=u47+Qy4C43TTx+Sz8lrVUplt6S1t0RdzlF1R1jEHyKjQaKY6uwBXugbMNEvcZFiKRM
         zlbzQP80U+bSSRsG/Hf/NOhTh713Qwr4Jg8mTsujGDiQ/UtP4ULT0eI3DPeTAQr4pg8m
         lu9zM001fXjwPieXsNBusKrNJ0EeHx4FIhpvDexJN0rieoejcYGH3/GENsWUu//iILtw
         QPxR94nMHpLg5X/4kkvXLnTK+YiqNEpgvGqYPbb1Q2FcpQVVgGK4PhVKj4lbSnamMgIp
         D0sFdA9U+6ODA5rn66G91WuGbaF8bogM9HzRTj3Rwsm4MktL6CrU7CQx72U+IB48KEGn
         9vVQ==
X-Forwarded-Encrypted: i=1; AKwUvBzhSLrc95qPb0KJ9RYfXNen9L8I7oZY7f16VDes8vMzdCqsfaZcAGZU1XiHZuFcUD/WmbSFHcpUvWBj3lg7@vger.kernel.org
X-Gm-Message-State: APuU4Z8o0dfOsVAIz64CAFBrCdQhrgr35EvasOb00etSroJwyK9/jIFg
	CzMKSPOCTJJdlxgLyJ8Mj5ARbaUAyBiZU6asj3y8HujDAjoCA2N0fYen
X-Gm-Gg: AYBFou1DnTg4d3V2pPllq8haOHc0yYx9DLagzC9FIyk+qy5nMgPZdME8+4lQzpoHOVP
	3fEMTcf8ajKcCWkVprFacQLWGz92CtyuOShU/Ml6h0FdQLHML/UBFvjTyoyamjoxMgTQ8XjXgIQ
	dIUlPOvXT8fsUXPcPH3LkUgbY9hC+Stb5QOYs78A7zCqdz0yPJyB/6Xaygz3o0oPbe0Opr+eSIh
	ua1OKMRw2NQuErn8ryPHTQrcRPI52HjrUg/k2/G/9gz0Ci2artzXeEtrExrHIgpFiCwxQlvi6je
	6OCATvlQeJakmxgxinKCTM9O8kEYyzikGAeH18rV56z5nzMUw0tWyHBF3qvjmbc5mjB2drE4knw
	nPgG99cqgjHfZKlgdQdeJfAjb1JWwk3tNodAiLGfo5mz0Q4lDjuhPHCiyggV2+/wrJBksYBgEJJ
	4475pqCpKIlRkJmB63J0TsDPXJDDpXgsl4ISPtK3xtysgT0YKAIN2mZWKL5q1dPDVxeCEs/YNSv
	9bGYoGkmRjuhyJ9rnpdOvaMCUgfF6RDRjF0rv6NPLrvsGgXa3LoMqtNMRIinqmMvYg/xyiPVQis
	39KSkCUAIjpRpnJHzb2nLjBA9/mvBA6CKxFDAiJEliyCF3mWYZVootv12yfdZJkRUL688LI=
X-Received: by 2002:a05:6a00:2d12:b0:880:a842:bb0a with SMTP id d2e1a72fcca58-8a9be58910cmr12485773b3a.9.1793799169033;
        Wed, 04 Nov 2026 05:32:49 -0800 (PST)
Received: from anatasluo-Precision-5560 ([139.226.166.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b09a7ce84fsm911369b3a.13.2026.11.04.05.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 05:32:48 -0800 (PST)
From: Longjun Luo <luolongjuna@gmail.com>
To: jpoimboe@kernel.org,
	peterz@infradead.org
Cc: mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	song@kernel.org,
	puranjay@kernel.org,
	nathan@kernel.org,
	ndesaulniers@google.com,
	morbo@google.com,
	justinstitt@google.com,
	live-patching@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Longjun Luo <luolongjuna@gmail.com>
Subject: [RFC PATCH v2 06/11] klp-build: Require CONFIG_DEBUG_INFO
Date: Wed,  4 Nov 2026 21:31:52 +0800
Message-ID: <20261104133158.3187525-7-luolongjuna@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261104133158.3187525-1-luolongjuna@gmail.com>
References: <20261104133158.3187525-1-luolongjuna@gmail.com>
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Require the kernel's debug information configuration for DWARF-based
symbol correlation. Use the C and assembly flags supplied by Kbuild
instead of adding separate -g flags in klp-build.

Reduced and split DWARF are supported by the reader and saved-object
handling introduced earlier in this series.

Validated the available objtool tests with GCC 16.2.1 and Clang
22.1.8. No failures.

Suggested-by: Josh Poimboeuf <jpoimboe@kernel.org>
Assisted-by: LLM
Signed-off-by: Longjun Luo <luolongjuna@gmail.com>
---
 scripts/livepatch/klp-build | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/livepatch/klp-build b/scripts/livepatch/klp-build
index 95bea5b2057e..da55e1028fe3 100755
--- a/scripts/livepatch/klp-build
+++ b/scripts/livepatch/klp-build
@@ -266,6 +266,9 @@ validate_config() {
 	[[ -v CONFIG_KLP_BUILD ]] ||			\
 		die "CONFIG_KLP_BUILD not enabled"
 
+	[[ -v CONFIG_DEBUG_INFO ]] ||			\
+		die "CONFIG_DEBUG_INFO not enabled"
+
 	if [[ -v CONFIG_DEBUG_INFO_SPLIT ]]; then
 		command -v "$DWP" &>/dev/null ||
 			die "split DWARF requires llvm-dwp (or set DWP)"
-- 
2.55.0

