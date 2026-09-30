Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F003655F0
	for <live-patching@vger.kernel.org>; Wed, 30 Sep 2026 03:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790737447; cv=none; b=jr1/TOi+pI0bDReE5HKt9Cv7cyzKOuxHcqzVk53X7d8dYjOPg8xr9R81t7FO2R8aZTB7p/0YYGRtwZpSC7WhHKxdQh4dFGNXylfgYwYj03qaTRzOf1Qe6MgF5KYXFoZ2sqLL0chU+3m03kzdHI8ahV1HuU4GQBUvkwY1CjizvP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790737447; c=relaxed/simple;
	bh=iiL28SUO2mY4taZkG0YRiXZxQc7LKFG27IMlfjMGXAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JpcKTZh2aPlMO2v4f90hJUyDad7jM9/2hgPza41keOpcvkypLOiVw1I+5Oc6DNL5oSTBkyQz7UenjYkwbLuR05B/w6TS/12Ays0p0+mXQvv7G60aoa50ER6QdITxHOrGr3ld5DM0l0xn25vblvSqxyC6YACmKHi6gygh7Hqb+t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jkKhDD3G; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jkKhDD3G"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-398beb616f5so2257975a91.1
        for <live-patching@vger.kernel.org>; Tue, 29 Sep 2026 20:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790737446; x=1791342246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DJkYz2mx0NoqY3hOX7fVHlRh9iFKQSnWueTSB7O14lI=;
        b=jkKhDD3GvgxtN8OGxYehLuU+m90jgwWAOp3ElvzUw27pvdd+EvGdTjRA5hQWvhZMky
         B725uFBd5xP1PuNOICjSWXvEiB++uy3eUNKfdDv4gKF6m9BfFPCi/tuj8xupqfOIOHs9
         GdXnjGL8waQ99YqD76KXLio/Nz4JgBCNsL2OGAjUO5JxqIysuRKkVzF4l0Z0zOc9CMB9
         Qrb97Z0F8qZGDLqBB/0un1c0YBrSbvfurTuoIlYCk+kcmdnCmvGdrEnDyjTE4ACVrlbF
         gzysIrVIKh19wImiZwqvMksXWrS4ju/yQ6/vSLyosITe3t8eO455WOnRmUl8kKXwEa+o
         3kgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790737446; x=1791342246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DJkYz2mx0NoqY3hOX7fVHlRh9iFKQSnWueTSB7O14lI=;
        b=Oziwx45QUqN1kNUmpHgWv08LwT8y0QWS/j8MN0xL5gKBCvx21+Tk47saUaeSg9cfin
         DitPzgielyZkBg5juiMx7nSSSNk7bV1Fikd3nDiyVV3lZ9owIkUpD/11u/LsnWi4LAs7
         7xzXb+DvgguP0HEYgTeZ9h8APtk4xvUz42TOYZMdyjEI0TUTdgiqr8bPOX30mAxk58B4
         FVStlQY12wLAclY2ulqJ5kk+7vPfJhNfLDq2Kx4xBFcx5g05+pGekGvGOq8I2GxP7qgu
         z/tgKNfnkFFtWqqjgOA/1wmICuBcWaSVhc4COqt89ZzqyOVECpx+9Xhdoj4PIRCuqeMR
         zWJg==
X-Gm-Message-State: AFq9FYKOcnPAuctbFBpzTu3mj0CPIu6pdiQqXVpGh59PQk6L+uFvyApc
	syBbrF/nXn9D3h15Uufdj7RRkc7nxQPUI/SCG/nqWaS/pKgss1ntCNj7
X-Gm-Gg: AYBFou3jg6baJ29+lBmKCtddX+weWto64JcKfmeWwc2GvZPk00uR0Ss0i7eJQs3aA3/
	fhRQVQ811tgMLmTrWlbquFL91Vj9GfmURLz/8+TlejgLr5mUujzLHbAbNCaN3p4j6RMPIWAdmQi
	TONHvtQqrT2+sQ+koORQkNZ+WFBeBoLw8dMadO3woQWPL5S1313IqgVxVPuqiwSdWJ7nrPf4jOV
	SZgkyuD9dVxmk935ooQtkt5/YY7V/PT+G8SmgSLYj2VvFoKPT0d3rwfbI93tq9x1WvwQqBhhOXO
	m5iCRFT9cr2z/h1Yr3u8/Vc/STMl+16V8gJOxYq73p31xcTdG8dbSiQgvPaabhjFfFUtTJSCkNq
	a5P59loEKTLPzp9MMqwVSODGXJq9mWEbB01LLXiMKK4JN1PDZ8Et2vPiNK1HaRWy1dnku/QeS54
	02D2/y6ZEgbTo5DGtCRnoXQOpTN3c072OxjWIOONIyJ7z7aHKugowkWmvnOCOb5dg1MPDgEkmBY
	d510eyaDfmgYghUGuBJ+aqxCLJYaKbfeityWyCS1ZnINMGI5X5KNvNmpcW0jpaYmFajOQ==
X-Received: by 2002:a17:90b:2548:b0:39e:6c68:fd91 with SMTP id 98e67ed59e1d1-3a4d28f26cfmr7673a91.38.1790737445856;
        Tue, 29 Sep 2026 20:04:05 -0700 (PDT)
Received: from localhost.localdomain ([240e:46d:2100:5cb1:9131:1918:6e98:b864])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4cabe63c0sm911937a91.9.2026.09.29.20.04.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 29 Sep 2026 20:04:05 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	song@kernel.org
Cc: live-patching@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v10 4/9] livepatch: Call klp_init_patch_early() earlier
Date: Wed, 30 Sep 2026 11:03:18 +0800
Message-ID: <20260930030323.14396-5-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260930030323.14396-1-laoar.shao@gmail.com>
References: <20260930030323.14396-1-laoar.shao@gmail.com>
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

