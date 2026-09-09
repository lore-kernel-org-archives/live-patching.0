Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC37B326951
	for <live-patching@vger.kernel.org>; Wed,  9 Sep 2026 02:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788921839; cv=none; b=d0zfwy9xaUuaNdiga/GIc2BOrReIk0B4CKhmjHEl2FPLaAtV+WdutI/EaOV9BQCEDYN8pJjaAMTeTyxWKGpID5AJEVqXhcP/h+4+hxzU6mRD1PqfBX7vNm6wecja/y8kl1h5Z8hf/35wU6T4WaEVIY6qnxMMPeKa00WuxlF+jvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788921839; c=relaxed/simple;
	bh=8KyAr6SsYt5rnqXZLuJZbxn6+K8vhacM6G1DgiU1q1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PXFz9HbDMIsTng8GZ0iLFqn8M0rrDVXPb5+RJpl6LcuMmrBuunMeWxyhNA+zq3bk1iHcqIxFGkx53ztLNOcMVSVpcyIc0oAYJJvlD6qtYq35GhyPDXxq9FJAW7ud6w9SwZwIS5lwKR/zZg2wwHCn/LLSKLWGwaUarKUZGNgk51A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pQB/8wne; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pQB/8wne"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2dcff8f44f2so2161755ad.1
        for <live-patching@vger.kernel.org>; Tue, 08 Sep 2026 19:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788921837; x=1789526637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/0UB2ckCy0xZFwMNpDkgYeeY2ZpOcF+oqY2TuGLQWSw=;
        b=pQB/8wneHMuSwDD5fSZ3RNaptePeEvrwX15GQU8isnvjqSIp+Xu9jP+MKMIu7yiX/A
         RMr7qksYoRZZKM0k5+urD94XMAAVZ4K9ChxB1F+PUljy9vwgPCNgiySqY8OHpeWKiQr7
         9OhSfLeqvAr6hK66aGixIsd7VdH1neYxUjOoHuJ0SzeKGkwUeS7fFRSm8t+VCMY9bEYl
         kPhj8C8WF8EV/5TxcAB3G/z6pNC9ys21YK4Ro0daDg6p2KVDXp7j2GTu2ARAY22nMuGY
         E2A50dXxDILcIvEE5NXe6xum238P8xS+W46kBE07zkPEk/XWiRWI7vx99quBA5EpPzIX
         clGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788921837; x=1789526637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/0UB2ckCy0xZFwMNpDkgYeeY2ZpOcF+oqY2TuGLQWSw=;
        b=PevEyBbMF46rRF1lZAf4i3NhmSt7e6Acap+fPrF0OSDKWScSDkRHIiRvUIhR9S01LD
         ImWBFTT/FoPrpw1WZh7UXLrr9gI0NeMr6eDZNdT4hMr0wnFd1bmUDnxE8awiWFN0bI7g
         U+I8MCcMS11uqhaThY0APUP2PImEVfRLC/KwykSYvobmsbWJdisEiQuUmyfTfVP+DSFf
         5oHzArp36smfjp2j8z2LFJRMsijIpWp93eKz/ypgr3RbuCXPk4daLQIkiTiCzh09Q5kG
         gLTuUCdSpLWMFlnpUwJkxuPJQ8jqoxxYSr9N+QCoOMAwqnv4er2OgOiqJclHyY8pXw9Z
         6Avg==
X-Gm-Message-State: AFuF++nCTIfdh/9n2BEBYHWQ1rmQ+JJZH+YXPdGCd5Dk6Tv49fWf+Hmg
	0PcGypNxdpJgVhNRdcIF6IZzuuaqjms9UPnwd3w/+VHFU0zfqmNytG5g
X-Gm-Gg: AYBFou0qhJVTfGmNAyBWbvBhwjHUkysRAE96VSMz0vm4OyzlWPaRhHVYIjfgdeQSEPH
	+DpoKuN9rmjdeFC9G9XFrgWl1fJe//vbdu9po9j4F5U9ekdDSx3W0J9FoDDxLyqfIRUHN/OZ74e
	qzsY672NN+d/M7EjMWnR+v31u840KvN0lHLRQwTtmUQ1m711eSq2I1/9+ANu4tHluE0k5g30InV
	EMRZq/SphEtjofMR+IVpGXVdTmNhWlV0iZgQFx0pf+Ls0NA9omXvFkiX/eFWXC2izlZRzJcY7Wa
	fzXIbrcQXlhlrFinS5G+5frCjSyxCmeZWOp0MLPwcJ2BF2joMRtCKR3Q+qOHbyCtbrvfBsw15O+
	j3klonx+pvzBQk2o59bZ/kBdC8AeMrfBORiFslxm9xwVElYC8KSVLsCdHDBXa0sNZT0tkaVCM9s
	GwG25hxqrQeZUAFP9WDKY/PYdsGGM+pZ2iTs4IxnzBDm9xFszn03Wz3yLpNiVTQfC9lwVP1CnYB
	eKfppEa8/iT8CNOgTBj5Answco5d4+bbiBK4Rxrf5Fndr4o1WLM0dd7L4zCaSyhMbOmrQ==
X-Received: by 2002:a17:90a:dfd0:b0:396:61f1:da5c with SMTP id 98e67ed59e1d1-39b260de667mr48303936a91.4.1788921836764;
        Tue, 08 Sep 2026 19:43:56 -0700 (PDT)
Received: from localhost.localdomain ([240e:46d:2100:5b4d:69bd:afbf:d6ca:3462])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b260cd15asm29292957a91.4.2026.09.08.19.43.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 08 Sep 2026 19:43:56 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	song@kernel.org
Cc: live-patching@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v8 3/9] livepatch: Make klp_find_func() non static
Date: Wed,  9 Sep 2026 10:43:18 +0800
Message-ID: <20260909024324.16002-4-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260909024324.16002-1-laoar.shao@gmail.com>
References: <20260909024324.16002-1-laoar.shao@gmail.com>
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

