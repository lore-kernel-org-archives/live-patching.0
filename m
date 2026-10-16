Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953EF348C7D
	for <live-patching@vger.kernel.org>; Fri, 16 Oct 2026 05:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792129063; cv=none; b=tcbQjGOrYqtaAa/OIVJBKwyvMh4WGLp8yg00DdRb/K4XpFwLQLyDfTJ9/tFycKX7piJXK39DS6+Wiqnddypx5Ct5XXaIVoD6wHYAOR00sOGr5AgRKUPhJhkNVighTFdSIJI1SmU+hemHJTNtA4QQ+sLPrduvagWWrkcpctmB68Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792129063; c=relaxed/simple;
	bh=Z6qaIxJaGingMaN4boaRDh9T/UM3Xnfmj7Q0/xVd3ak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sb2BkMp4BQk+6biL2HsR8zX0rc68Iyf4/dVNtYh+35MPeO+Hy0uBHuzcPdF3xhzF58fh2YLC5PSA6Fc9TwYJNs6im160eWh5aalB7AAHf3Zah7pZ1NLzQlH4lDWUFvTOnQ71MmkTAtmqVu4RiuwkCnSXREhCP4lNwRow1Sk6H+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iz/mQOW+; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iz/mQOW+"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2e7e742a2c7so5347665ad.0
        for <live-patching@vger.kernel.org>; Thu, 15 Oct 2026 22:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792129062; x=1792733862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0DcNR8Cbv/4VUc/D14BhTK0gGtmFxfgJ4zGRefSiR7M=;
        b=iz/mQOW+oCef8pBCehaxsYfhqAIsvsRIAH0Xy4XlMR5I0CslHfBuSWYIiAvkMg6f8T
         RUA1cqYlZXqSe6IS8me05iWxen+x/ssWopKm701STwCVa4zx1J1DkRMGZDm2chKbqloD
         4C7N+QuLOFAd9b2hczIj7hd+FpZRVBR4hRlDKMTjWgJUBE2e0OH4InxA5BgKUwfJs5iK
         WokSWV3OF0phfbOOIeG2hkFFvOj992qqmCBfnKWZJOO2lFQZqYKqLEYpxNLB6d/U6o7q
         2LglN+TT+xdoaYCItvH/DiMDFQIkjNEMoO+TSXdefHj/dW/RViDTpPkXvy/uXBaoXhZU
         U8WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792129062; x=1792733862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0DcNR8Cbv/4VUc/D14BhTK0gGtmFxfgJ4zGRefSiR7M=;
        b=nGrTd/QErEHSITLjnljY6J9pVOhBcdCbBrD5JcSJY3B5d9HZ5YxLvi/IjeyAl4B+lT
         LNGS9lq2MdPGVliKhoOaSCtF56kNWnZjFUnWBW7CqXaV5j/oFqxDobZ8BL5v9NiAUbfb
         abzqZIIxJbDeKVEVfARCZkBlmMROPjoVo/6SefdWtersfvBaCgebeB7wqP7evhKgvCU7
         h/O6olhL3O2+7Ar8dKtd2LhvUuCeZEDBrk75i1NfZzubJs39YdzeXGKbHY2sGz8kVh4Y
         27VHFUG0wfZ2dmnnFnBNJHUHQxglSrRFt0BDxbi40vpDMMUTyR8zs+5VFTB410MuKKL+
         1VjQ==
X-Gm-Message-State: AFq9FYI0lv+TCn1LEi0C/xVcl/Rm2zb7eLxC3Ogsv4IDS4Xcg6iVeSu+
	vFtReDLtCyGZZUA9cf9Epft2KJaW9To4h1Uo237uy9X4SVBWOjguniMK
X-Gm-Gg: AYBFou0MLXsrXDnlaeItd7s6JogkBXZbCd6PD/cPSYUI8q44ODrXQ7mhpC8fNNtwSeN
	vhIlEYEA0vgnQAXK1htxehCVyX/Vk/Wj7TpPfJHQX1YTPhv8vlx7J2GNINGi4p3pQ76oUdmFAx2
	jCmZwM5Esf5iN52gLpTG32IL7LRTVs6fnqZ+eC7n/kSllEDgyAqSKnodZqT8bcF5Yz2WIEvW8mX
	vNwtejKCJbUViOc8pLvxHBgjS3Bxu2b8w+rpkDgejB0reOay99Ot+WiusPmb1wLaEO3Qt7aPWgO
	m1Uq5kdx+os8nAVoj2WVlSOCnBNuXorpRsDCUEBfqOHYrM0OXe4YsVYc8TyV8xvIkla1D7Gnwqo
	9AAJUjGSf4h617H97RwJuM7W8CM2+TNgui+ISZu4F4eYwNXWVTSEOvL23i2WwtI2cItDR4Fy4ZX
	BZsAw9oFeVX+TnUlh7ZZQNNj7o+hjtT7SVUd2js4DBLxf+jRt3T1AfDNZr5Fos/yPbLP9CdsYDh
	HITS1YLxGfDfPFlp3dkuAslhgPz9DYl67UIRh82HJSVz5Df1EUPvWkk9IOY4D3k++z+
X-Received: by 2002:a17:903:4405:b0:2cf:7db9:e13e with SMTP id d9443c01a7336-2e977140ed9mr15597125ad.3.1792129061896;
        Thu, 15 Oct 2026 22:37:41 -0700 (PDT)
Received: from localhost.localdomain ([240e:46c:5700:24f:f979:e84b:46de:615c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e804d2dsm4724115ad.17.2026.10.15.22.37.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 15 Oct 2026 22:37:41 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	song@kernel.org
Cc: live-patching@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v12 3/9] livepatch: Make klp_find_func() non static
Date: Fri, 16 Oct 2026 13:37:02 +0800
Message-ID: <20261016053708.47089-4-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261016053708.47089-1-laoar.shao@gmail.com>
References: <20261016053708.47089-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make klp_find_func() non static to allow its use in other source files
by an upcoming patch.

While at it, rename the parameter @old_func to @func to better reflect
its generic purpose.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Acked-by: Song Liu <song@kernel.org>
Acked-by: Miroslav Benes <mbenes@suse.cz>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Tested-by: Petr Mladek <pmladek@suse.com>
---
 kernel/livepatch/core.c | 18 +++++++++---------
 kernel/livepatch/core.h |  1 +
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index 517fe427ff92..89251fafe86e 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -82,21 +82,21 @@ static bool klp_initialized(void)
 	return !!klp_root_kobj;
 }
 
-static struct klp_func *klp_find_func(struct klp_object *obj,
-				      struct klp_func *old_func)
+/* Check if @func is present in @obj. */
+struct klp_func *klp_find_func(struct klp_object *obj, struct klp_func *func)
 {
-	struct klp_func *func;
+	struct klp_func *obj_func;
 
-	klp_for_each_func(obj, func) {
+	klp_for_each_func(obj, obj_func) {
 		/*
 		 * Besides identical old_sympos, also consider old_sympos
 		 * of 0 and 1 are identical.
 		 */
-		if ((strcmp(old_func->old_name, func->old_name) == 0) &&
-		    ((old_func->old_sympos == func->old_sympos) ||
-		     (old_func->old_sympos == 0 && func->old_sympos == 1) ||
-		     (old_func->old_sympos == 1 && func->old_sympos == 0))) {
-			return func;
+		if ((strcmp(obj_func->old_name, func->old_name) == 0) &&
+		    ((obj_func->old_sympos == func->old_sympos) ||
+		     (obj_func->old_sympos == 0 && func->old_sympos == 1) ||
+		     (obj_func->old_sympos == 1 && func->old_sympos == 0))) {
+			return obj_func;
 		}
 	}
 
diff --git a/kernel/livepatch/core.h b/kernel/livepatch/core.h
index 38209c7361b6..361a0917a03f 100644
--- a/kernel/livepatch/core.h
+++ b/kernel/livepatch/core.h
@@ -17,6 +17,7 @@ void klp_free_patch_async(struct klp_patch *patch);
 void klp_free_replaced_patches_async(struct klp_patch *new_patch);
 void klp_unpatch_replaced_patches(struct klp_patch *new_patch);
 void klp_discard_nops(struct klp_patch *new_patch);
+struct klp_func *klp_find_func(struct klp_object *obj, struct klp_func *func);
 
 static inline bool klp_is_object_loaded(struct klp_object *obj)
 {
-- 
2.52.0

