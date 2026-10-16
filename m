Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226E239656C
	for <live-patching@vger.kernel.org>; Fri, 16 Oct 2026 05:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792129069; cv=none; b=BatxBR8ZON2NmScX6GaFdy4Jm+CJtx5adsl8JoUaibgwusihqAVbRYGl4qcShqmCU4HO2RUI0aCCKAEqiGECDSm8WjWz1KyphENcz3uMy4OIqaAm7AizDzMlk67wsQ/EElOsqAxzAnw9o+yw6d7HdZjbW+LrFDIUqBYknmnQ/Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792129069; c=relaxed/simple;
	bh=GFuLkfK4lxs3mDOS7RtEdGThemMaY0j+LMNlf9wngn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CsJ/kJCahCK/yZKzCIdco4/vfPEphUU+QrakwOzolAppblqgjR4SKvrJ7KlBiTg10/25NoaG3XtEUquZhrU7zRwQCT2OdRzXNgHghdhHZaGE2K7T+MtoY9gk8F2TfoWS1QbvfQq1m/CvchCziEZ4IfUGFf6ThAHR9oLE0P9puCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gs/gjeBe; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gs/gjeBe"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2dd1dcdcf95so4262865ad.1
        for <live-patching@vger.kernel.org>; Thu, 15 Oct 2026 22:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792129067; x=1792733867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/mt0CRA7LFCfvbN90avDkf2CrVHUWq3hqZcA+p6fqK4=;
        b=gs/gjeBeM047l3asAxw6bIsP/O4vebErX3TLHHqUHTlaHOJITyVjCAbZ6JNocc/jA5
         TxVpnoT6txnGV6V81EAded0zjOzdub5mtFQ2sAEb8R5oUZO0djOlCwTmCYUFFU/pBqLx
         +BTr6p1xhHD4ygoKSdjASCbPytIKpEVb2mHCXlALvZOYbuFvGkPIJZ6qHkNBjFfx2Vrr
         7IC8hSFhSe06gmpJaO3lwqjhn0RU5eVt1H2wVj46/kVaB7lMar2BQvSPuLS6Mxa1Am7O
         6IGNiXTX2ki4IQ6JCY5TGEQ/jvkfVVL96IL1/1YxCRsTz37gEmXDBCtCGy0oMV3Aq8Ui
         mFPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792129067; x=1792733867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/mt0CRA7LFCfvbN90avDkf2CrVHUWq3hqZcA+p6fqK4=;
        b=ZPBk6zqNHfbPiPUN6fC8Y4JMp5r+Ts6SHt57SzxMhCVAB+i+ff7/xCepXPSsp36iOe
         4YtbVB69+pr8U+fSOcLzA6DOtBMoGpkoS92Yf6pH96ZlxjKSoAL4aMv4wcvPKfmoYC/e
         tquoZGfpFjaJT+B8d+DTJ7vg1NkezdlhfLn8V4YTcMYsaCHBkVAcZrQ8z5yst77MVoZo
         knMaizV1XtYYppxjAFcf38wcDPj9ljqbUYbNC37K+jX08LeAVX7PAL/uZW7edsBUIc90
         bw8clB+D+MtMLyCOQQcoYkjzPfg6JNKdwosYb/hPv04CgnTi8WiUbWmOcU4FnxIK/pmi
         mzpw==
X-Gm-Message-State: AFq9FYIvww7Qqft98/WLBhAs480zMGFpD+1wWMUkZIMzRxapxCFA2UtF
	S69DS3QWtZ9MZpsv9ECut/2cPOOa9J3MrVauGBxTOPrfDKnnfRqwJyGm6KsyBcaWbnw=
X-Gm-Gg: AYBFou3flnVzhVkTNvkJ6wI68aihCNyUYAtHDQdvB6ZqknyQJuYTqFZY9+HRPC/Ht8/
	fGKikyZM7cGxiCl44Fbw4R2PIefzRvoIOl6S/s2I9ykZaRT9T3b8++28O6GfqPC5Pg7qchj2ZTl
	hMligl+wEg6+GD2ULKkU19ECnWfxpO2/BWgX5PVpToJGa0456qfiG7pR/YKLaF3rNa0ilPTQbBE
	IcktJ69wuNP80XVrg+KHpM+AYfuwpK2ZfJccPqpOmBEz8KZ1wwh9BCHsQ/5UI1RoGf4NvXR19P8
	cgeqrwd1lPr7nT8ugDbTS+1SlxYao2YI0A3DaQoNV8A1YWmHIVCH8+2kZvPwCqa64KjdB5700kb
	ZrLk06LMpQAB1QP8IUwEaUOGzUMLXnAKFJO8QXgcw101lNeyXUYovl2OUNBl30ubF408nFYg+hL
	TNeYTcFaHno5B+kQlR18p4U6Fj5CUrVi0M232W0oRF8ZQJOvO31g70DooD4X1E2VkMJWb0RDU71
	gJR//yoBN7i5NYMCrBCVGWge0hzw17Iqh65PDuHz1NquKjI0Q/NJZZeOkyfHH2/yJpy
X-Received: by 2002:a17:902:d54c:b0:2e9:569a:214d with SMTP id d9443c01a7336-2e9773d539amr14940305ad.43.1792129067375;
        Thu, 15 Oct 2026 22:37:47 -0700 (PDT)
Received: from localhost.localdomain ([240e:46c:5700:24f:f979:e84b:46de:615c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e804d2dsm4724115ad.17.2026.10.15.22.37.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 15 Oct 2026 22:37:47 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	song@kernel.org
Cc: live-patching@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v12 4/9] livepatch: Call klp_init_patch_early() earlier
Date: Fri, 16 Oct 2026 13:37:03 +0800
Message-ID: <20261016053708.47089-5-laoar.shao@gmail.com>
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

Invoke klp_init_patch_early() during early initialization to avoid
mixing for_each_() and for_each_*_static() variants later in the code.

No functional change. This prepares the code for an upcoming patch.

Suggested-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Acked-by: Song Liu <song@kernel.org>
Acked-by: Miroslav Benes <mbenes@suse.cz>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/livepatch/core.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index 89251fafe86e..c0879b5d9dc0 100644
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
@@ -1169,6 +1162,13 @@ int klp_enable_patch(struct klp_patch *patch)
 
 	klp_init_patch_early(patch);
 
+	if (!klp_is_patch_compatible(patch)) {
+		pr_err("Livepatch patch (%s) is not compatible with the already installed livepatches.\n",
+			patch->mod->name);
+		ret = -EINVAL;
+		goto err;
+	}
+
 	ret = klp_init_patch(patch);
 	if (ret)
 		goto err;
-- 
2.52.0

