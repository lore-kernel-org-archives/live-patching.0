Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751403A16B2
	for <live-patching@vger.kernel.org>; Sun,  9 Aug 2026 09:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786267222; cv=none; b=S6bn84nQYqHvX1wRREz1VGLlEDWCYesrvoelBiWuxP48H3nz2AK1cXhJH4ooqyzow6OnHziZ0lybiheUZdFyt2UD/G3irArnKxRioWHw0cN0297rKPemOkaOiKyH+w5B7sAjSlEU52lHZNMotWNfFFFMRMKfObTDdaFnGVHkriY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786267222; c=relaxed/simple;
	bh=T2NWMQLwb2VEpRWgPShAtp5NIAez/S0eOTfg/2+8GA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=blQHhOb51NC40BJ4omad0hx/aKXVwCGE2de/lForWIMuhZlsQr2gBtOV0A51IERWSFvBOxytXesqIkhObSn4ypwZZsNpygA3arUZjWywkK2T708q8LufbsxjxH4b2yqZiSfuLy8W6pIO4Ki9OTnXtddPl12XKc+fbF0evnSc9I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S61xIxzw; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S61xIxzw"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-381b831d535so1183754a91.0
        for <live-patching@vger.kernel.org>; Sun, 09 Aug 2026 02:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786267221; x=1786872021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K/fGIEAQLUNwI7qkLkZcuSEY5HHO9BPb8xFfMjboyTg=;
        b=S61xIxzw1NMELNNYrddduE+VyKgmNmMxav4hUzKIYRGcSauJ0U4/9H0RNvSWTQgxjD
         6yBHrnsQQGV4lpBuMr4wFj9W4GzeX/E5eOm2c/WRZT/TzQO4RRFwOLnGraP9tB/ePCxV
         IYGc0cvgbCEPyt0xa9lF+R+WzBg57yWYTMDx6LUnhd3MTum68uc0kwsDoKa9XECx45XY
         l5y91UPDD/Om5Q+0WNvOvRyE2s9Ew9zeqQJs2Atz8zY1f9TzbCtMDzwGisY+AUXPr47c
         8oTKLb9m0aPojoT1ihzxtv2pRNKLRHZv+MjZ1rVx0vD1zafG078NCRZ/VBQjAm77sbKQ
         Su3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786267221; x=1786872021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=K/fGIEAQLUNwI7qkLkZcuSEY5HHO9BPb8xFfMjboyTg=;
        b=Qipenyd9jl+gwCBagTFyk0oqxwCdbIfv4+5vNTXWmgTCEyr1pY+SoxDNFFyiaKjpUU
         2mav24u1+BECBjkLHQIT541tCx8lBAJPMMq9SlUH2ZcIacuqq0YOL4CTceUTYlbrlW20
         3Ro2JTyPoqj+hmALe5Q233Xl0Vy8RPYeHLQOmXxAuHCnNEVmYjwePrPqyi+HhW9WPSHW
         Hy5HR/cUK4+Lqczd40SERMnDeWgz72uNjns1YDqxsLW1fB8teoysJrEJ0sjkEsegioGq
         tsEv1nM7+q/fNrzb5wxHvk2mTxfUSMLb2lOoejzMIey/Rcmue8mGSW94DPqhQTALNkhS
         Z7/A==
X-Gm-Message-State: AOJu0Yz0TyLLp6upMg9fZzsODDP3w/VlKr6xrv96r9B/4EJYeDLb0922
	rskz0mIU3p58yQQ2rPT8x93PkTxcs6FqtEGP87rMomGD1wF5kVy3j1e/
X-Gm-Gg: AR+sD133aEtXRL1tfQTaOnxFxHIPcSf+UV70nK0gCvsz5/oZxf/2hIlvi2JffmbocS8
	I2YBkdQlofioa9/+X1Ti5yuzZAI2XocCA5rJUxTs0ueYkrLPq39HdlA2KUA0l5tV6u1Dj9y3N1N
	JVOn5Hd4hB30ouvI7RJk0aQGhsF3GNc3rmi4tJ4w5NLO+ZlE4VuyQ4dvyTEujcFfygXaAEWtK6v
	CoYZ9SNEhqPb72gdu06Yh5NhGmxV8MX2Av8AVljPB5YKQINqhneCmM2ijSfxp7l3Q6rfIB9AGso
	jacwY75f8lHFd3UWldiOQRq5ICRhEdQxXy6PjhKYs6YR2KEDBZg4Ggqcn1rgs/CBClQrHymT3Do
	BWRUPo2KZG35BEGH8UscmwpGwGQsYimUx1tItHMQD7Vn2oxG8DD2u43dicaUzaXsJdOZmcTmrLJ
	rACaDJLCBlF+b7slXWmjRcp3FqnEkOPxZAFsoAV8U5Yu9ouP5zv7V4/MsYbq4nVvDWWvgh0W9iY
	R9nTweTNApb+OD6nHw/8E27C5DIF5ICWLW3CwMpoTnNhybQOLDRcyOkqg==
X-Received: by 2002:a17:90b:590d:b0:38f:5801:cd76 with SMTP id 98e67ed59e1d1-39261f71c4cmr17905405a91.3.1786267220889;
        Sun, 09 Aug 2026 02:20:20 -0700 (PDT)
Received: from localhost.localdomain ([240e:46e:ac00:14bc:74c9:c78:94a0:c446])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3908616d21esm11241281a91.17.2026.08.09.02.20.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 09 Aug 2026 02:20:17 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	song@kernel.org
Cc: live-patching@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v5 3/9] livepatch: Call klp_init_patch_early() earlier
Date: Sun,  9 Aug 2026 17:19:47 +0800
Message-ID: <20260809091954.22930-4-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260809091954.22930-1-laoar.shao@gmail.com>
References: <20260809091954.22930-1-laoar.shao@gmail.com>
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
index c34306ecfb0b..3de3940d34b2 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -1145,13 +1145,6 @@ int klp_enable_patch(struct klp_patch *patch)
 
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
@@ -1159,6 +1152,14 @@ int klp_enable_patch(struct klp_patch *patch)
 
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

