Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEA137475C
	for <live-patching@vger.kernel.org>; Mon, 24 Aug 2026 03:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787542072; cv=none; b=oNUNuE6UMDLbAeO98nWr1DRXdWN4gSxvOCB7kDTvXIX/HIW3zxRzcZRQEfbz1GolPFuXCWJ4vit7MaloJor5sLknUt7Zn+2EG9ibZH9OcPUDjz9ZV1d99p6SqIzGYVe0Ttb3njAtG/AYJI26J5HDdswLEa/UsPwlkBj+qXlfEQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787542072; c=relaxed/simple;
	bh=+VGWboujBX8RFjytoIsUkHNg1sNcujYYsPZBZlJObOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=is2xshYniZJjhIUfKEztvlCKRSTj0m81/TIvlbPWx3BRqrdFRA/5jmBcFL9W66/EVKEIxz3Hkfz+piQxuE5v5/DCenkm3xGm4GMPRail5YwkpMg2+Cd/NFZXUi393gQXnC0QbX9q8E7qlQeyTUnI20DF2dAbGsSzif/Ku2AW9Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CDxeKH/k; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CDxeKH/k"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cbe6295f05bso2659902a12.1
        for <live-patching@vger.kernel.org>; Sun, 23 Aug 2026 20:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787542071; x=1788146871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G646wyXu5gBD3Cpg1aSW2j+B5DC0EoS3mUzgAKIj/ak=;
        b=CDxeKH/kxTZV1q0WmU4hdpWH/CHPRBL1KojrEoScjcArJaWX0vg2zhKJVGGQridDSk
         VeS79tN+v0J1gR5K3i7nJz8k48uMeMUCuxlBTvNDR896kB86ovFXFxx2Jwgd29uFXgUA
         tTa0NCzwVmyfMz5+mk1supq8wRi3pugIULca6YSdnzF3yoI4N5B8nsPLaeyl9vjoZbxP
         hsmk5QS00GUq219gpbOq5hmYLU1mNzDSXrKAbkrgDqw0Nvd430pltO14mUj6BjsJ1U5q
         L0g51M5TtWzLxVSf6AOMK0tjXg7gDcnMPze5GiV3O6qrxjka1usKAzTdu/JeOQ2x4R7J
         laLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787542071; x=1788146871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=G646wyXu5gBD3Cpg1aSW2j+B5DC0EoS3mUzgAKIj/ak=;
        b=nHLcPijgCKCI8hhtvPrNW/XBJRkaYaFigh2abTuLK6XueMUbc6RyrBITt2Y3NBktxU
         8ZB5PRb9uWgEt7khFboe3kWRRLkOanlYLI4Pz9c3p/YatRVM+Ud7Kc6/n5DGKbdeThZt
         eZeHL7WNdmW1hBy5u9UMQde/T5cqYD2J2jUybn/jm5ejX8q3I/uf1mXfUsFl/MLaVrIs
         gj3Qj8LuMxv3jKI6WgHRHpmgWZmhdfjygoSidV6gFzOxrQEE5d4ie/aePWcc/456Y8lL
         7RUOjqwt/WjVB7CBeT6cLwJNdQkqqsfWJbSOjfcRA21y+LAzw49dE2RtOcAxjRqYUiVH
         qb6g==
X-Gm-Message-State: AFuF++kQktJpmOVlVe4qS5haMPutWaRgiWjq+f1bHbaDy5zIUawxJVWo
	fzMpEyjyYs5/S3x9IMYiVk6QZsFi/5BcsfdvzmYKOarD/NOqmLUP3ha/nXS6VX7Ahes=
X-Gm-Gg: AR+sD136L9B0gMzRQyN+Kc+9ZM9JL4Cd2CC30MQmIlFuoQCUcQsOtcBzEGWMPKsIubs
	mk/GtpDY/2rlYdvzBj/OJ6dq+xF/0T/I9Id+Yi9AkhA5iyuGmF5ihcSu6LDKPQu/C43hmRDEjjL
	2prNzvoeHlxE4UB/H0wrSiVMUvADXQyFBoLUd8ZbMYyss5P+Yy1M+BHM+rk6tgM5JQU5GQttm0a
	bvxV5DovMvzBLqVTJrH2/IvptGZ6aeqYE+AU/0TA54JDWEmYUD7UC7OKJQ2JVxohYs1OnAYod/B
	DwtXz77REoR6Ka/2yiO2UmGIdIfgoRADHweA7f6v1hlyLX4PriZHNPCKDKKwdVjMbr/LA+cf+cs
	XovxTyXNA2JaRtkUyPshBPhyegoynK2tj4h6Z8hO46yJhAHlp1EkwnFop2PuYm8M01d3kuufLKl
	knnRzGfvD+FyNawX30t//3Aol0T10OC4HvDQvpz88ztwNBiB1Xt/J7A6bVC3WBn3CtgOk6ViLk5
	4sMzxJeZBv8CUp9PaN4JQSrTB9Kk3yJJ8SuMPqLHS4=
X-Received: by 2002:a17:90b:4488:b0:38e:7297:a92e with SMTP id 98e67ed59e1d1-395c5114895mr18950394a91.9.1787542070905;
        Sun, 23 Aug 2026 20:27:50 -0700 (PDT)
Received: from yafangs-Air ([240e:46d:2600:d2:b0b8:8b52:78f4:9247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395e4b46518sm8496460a91.17.2026.08.23.20.27.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 23 Aug 2026 20:27:50 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	song@kernel.org
Cc: live-patching@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v6 2/8] livepatch: Call klp_init_patch_early() earlier
Date: Mon, 24 Aug 2026 11:27:26 +0800
Message-ID: <20260824032732.56686-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260824032732.56686-1-laoar.shao@gmail.com>
References: <20260824032732.56686-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Invoke klp_init_patch_early() during early initialization to avoid
mixing for_each_() and for_each_*_static() variants later in the code.

No functional change. This prepares the code for an upcoming patch.

Suggested-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/livepatch/core.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index 89251fafe86e..b69ec29b8708 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -1155,13 +1155,6 @@ int klp_enable_patch(struct klp_patch *patch)
 
 	mutex_lock(&klp_mutex);
 
-	if (!klp_is_patch_compatible(patch)) {
-		pr_err("Livepatch patch (%s) is not compatible with the already installed livepatches.\n",
-			patch->mod->name);
-		mutex_unlock(&klp_mutex);
-		return -EINVAL;
-	}
-
 	if (!try_module_get(patch->mod)) {
 		mutex_unlock(&klp_mutex);
 		return -ENODEV;
@@ -1169,6 +1162,14 @@ int klp_enable_patch(struct klp_patch *patch)
 
 	klp_init_patch_early(patch);
 
+	if (!klp_is_patch_compatible(patch)) {
+		pr_err("Livepatch patch (%s) is not compatible with the already installed livepatches.\n",
+			patch->mod->name);
+		ret = -EINVAL;
+		goto err;
+	}
+
+
 	ret = klp_init_patch(patch);
 	if (ret)
 		goto err;
-- 
2.52.0

