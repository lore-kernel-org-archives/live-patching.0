Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2038E492E2A
	for <live-patching@vger.kernel.org>; Thu,  8 Oct 2026 09:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791453547; cv=none; b=tYkQdtAk/XWyxmkmq+kced0JODXpEw0LFhzC+IXuovXwV5rzrdHWb37ImYvbmF0iP4RGJHZBQcyPySWohHrVz9uPZKsLWCKMQ6AZVuQ5CyFe6JlmBN3yi8KX9mw7HlQ4uXoM5PGj1mIv4Xra61C9xFiMCysHapVQOR6y/QzXIOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791453547; c=relaxed/simple;
	bh=GFuLkfK4lxs3mDOS7RtEdGThemMaY0j+LMNlf9wngn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j4k6N5CDDfs9ODErqhKphST6psk7Vmq55LJhJjRlCXu8Z12SQEm/c30WbOHcgQdPmH3Zo2fR/PvkOsEqJ5FxFnjxmxzgvBZJKr2RtCAqMiNWJpOxmKTQec3ZO8B8LJkVglL1qNSm+1I/Y48MBn0XzXssBq/tZzvA5Rl3rdoB3nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J2V9EjZu; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J2V9EjZu"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-383b4a3755fso3543824a91.3
        for <live-patching@vger.kernel.org>; Thu, 08 Oct 2026 02:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791453542; x=1792058342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/mt0CRA7LFCfvbN90avDkf2CrVHUWq3hqZcA+p6fqK4=;
        b=J2V9EjZuD0ujgcsZKwydM6UNtS7OgVID+uNMv9yGweab0EMIsZ4u28LzoboMOz0aoB
         oeU3ukPIiOgQ1PgDAG8Qu2EQSzicmFmcXCFlsxJUhBo/9jccR+bu8U/PfLJ6cgTlZWWM
         9huopyFuS9/Iq0jGt5J8OYhJ1+z6v8S3xKv/uy/mA99929ztxDn0HIjlaplOEGm04zXg
         eoL6BdVyE4gZjeFlrvaZrZroYl+RKlGbwFf4tX8MJjzit1mRs3Iq4QsBG5W3E9A9JxHH
         vkB/Bj+ML8BmMUBB0U1g4hOIwYri4DKcDZLTnnByqMe2nWKtFFkGBlnWIDSwfmDBlHFR
         xYLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791453542; x=1792058342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/mt0CRA7LFCfvbN90avDkf2CrVHUWq3hqZcA+p6fqK4=;
        b=jAYgJmxQqkh7jB5CX41J3LQEQ03DhyaBIqQpIRpI1dKmhrrZl4ac/JmFT+K5E4xDBe
         SwSqUIopGq7TjsjIk/FbeoaenvyYsCRe/FMW3K0ZmimoWlZe01f/ZGV9RyX8hLzlwJIb
         MPugkhmThk/goYioZIYzlFImPXGKK8D1QdBrD47JWDByRTzq/mLWOxJAlEl8wMU7fo05
         JSbt9LTa3khuB6y+jmkuyRGZ54htKxpIlZr2fx/TcN0SqR/d5Atm2NHzM8TEIqJjigKK
         eZtgDcjqnBphOQeSr3k9dPBTxJ6u3jlIo6pXRC2RfO51DPdhlGmilBQnxUeEPM4mmn7W
         hKXg==
X-Gm-Message-State: AFq9FYKo3of4OkSfNfRft+m6BJErtoJVhz/T2Xz18f4Qeo128bnj1+jJ
	ge12QdPppnrX+DP+++dQUza35Ja8VoQeBgd7l3lhDzd78eG5JTEzrQEx
X-Gm-Gg: AYBFou2CdYqkMJ+nyzzQk8ocY6Y91rja59BuW3K+ZcIwHsnR06IR9oXnhFbzmVI9j6T
	6jdCL1AAEcMEPdnnENw4uDwqiCQ2lVZietC0Fr+P49pYmYGfnMGVs+/IHabca6B+z5slNzTX7/q
	PTCKa7ldrZavtbHMqkZ+4Z78c5a018GzHk/cn87X2Vfdbbpfe0TB4LGnkOeN0K2urxDQKBK9R2b
	GbZG0XFwSzdDbi1s4sonJXO2agnRxpofjA5VMmaMeZnyOlWojP4dI77qsQKyXlYoC0PH13+cB5f
	28TM73zeYPg+t51iPkVkLMXTs/Cm8VhxaM1TKjaYG2lz0UFKKG89dHAK90e//OjUxqm9GyS8+86
	piJtU6RANqCA7Pfw0Oy1d9VIx3t0dYu5TWaF2fpkK39GAo46C8N9eJ60rFQ4FJSfjFo2O9xaoUT
	2dNskaFjL06h5/zFOdpgS7LFS+7fS6h/NK+nBlxbPaUettOI07Ox7YHpNM9Wrs370u1TZjbOuw8
	Rg+bnS8PnpCb9Fmr8ovtVgRLw8rkw3yLuRAwaS5xb7EOK1XRyTkgjgg
X-Received: by 2002:a17:90a:d00b:b0:3ab:4f1:4f7e with SMTP id 98e67ed59e1d1-3ab04f15107mr885794a91.28.1791453542004;
        Thu, 08 Oct 2026 02:59:02 -0700 (PDT)
Received: from yafangs-Air ([240e:46c:2100:3ace:b801:9432:769f:ff9d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a9ff7ff13esm3422790a91.7.2026.10.08.02.58.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 08 Oct 2026 02:59:01 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	song@kernel.org
Cc: live-patching@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v11 4/9] livepatch: Call klp_init_patch_early() earlier
Date: Thu,  8 Oct 2026 17:58:25 +0800
Message-ID: <20261008095830.26308-5-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261008095830.26308-1-laoar.shao@gmail.com>
References: <20261008095830.26308-1-laoar.shao@gmail.com>
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

