Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1031F480DEB
	for <live-patching@vger.kernel.org>; Fri, 16 Oct 2026 12:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792153493; cv=none; b=PXpOFFCJzHJJBzOK5lhlHODo13zGqXzEDcbUywld10I6dMoBczS9+r1f98/W2wknEQlfM9z30dq94fA3UUXsw11XG60674p1lEwxEUovq/+eJCyrV7v+6BJ/Me/EkSNOmvgn8ca4novpCljatfNB1UQVq+1U88/Ec7SC4alZ96U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792153493; c=relaxed/simple;
	bh=VC4sNe1X6iAb2yPaUjz03oMmGXuxnQ8+8LNaYTSTyIY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dS2pztd7hyzOEv0v3pEcO5MVe7VVuQyWjYbJ+g/59Oky7EU+HcuOnT3N8P3V4CDaZM1Z6+odAO+0T7JU4r/sbBjHso1uyOuBLmcM9qRxMqZcsEIKOIqrYRJaG9sE61WS0agPn9jS7r0b6ov/NlI+bCZExN3X9QXh4x7khyeBtoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fPoJBApA; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fPoJBApA"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2e608cd460eso34986905ad.3
        for <live-patching@vger.kernel.org>; Fri, 16 Oct 2026 05:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792153489; x=1792758289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Oh5sgg/8Wcm7Sy7xw+sd6a/6SFhAR+Yy8Mm3m/0UHV8=;
        b=fPoJBApAkwhxp+AoIKDo2kyrc2zH5XmPK+7BXfEvMUlmDKpMKZigpehwnr6EDhC1sG
         WqEE2T0A6D1Jks2m/UoeRDTIKtvVVmvLw0aUqj/SRtKrD7oO2dcj5rzsWp0TqC1luQ5V
         1OyYzFkXqKlIrTgffNg4q9lBlxnR/UHKjtD58IyXq6Rzr+BNejYe87C/3WCkhcf69M4/
         /9gwS8UjxmJoLlZK2yNokOb2ijLLpMGQ0msV+qmwx7opKy2+u8nSCDio88ZILRBM/WjC
         hPeDc7R9PaTbLvnSMzQPDIZtTajvjtwZ+vyeE2+6SYwZVYjTEzFKi5hCUk9XqZEYPhrN
         fJOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792153489; x=1792758289;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Oh5sgg/8Wcm7Sy7xw+sd6a/6SFhAR+Yy8Mm3m/0UHV8=;
        b=Y27emsfq9hvzviOKb1U/iQqC4br+EmNqCbR5Xiq3YMcqwYGbatFXQ7PzMH6Mmu2WPX
         2UFgY9ZQTc5LIB5dQGnBfY7/JX8OoyyjbnvbhRDyP9QqpuE535eLFrCt0Ryo4qLAX7UX
         KixKZQ5xF52KPxGcLLg7qZUkkJCzUKiG8nP3WDKqJ3d3UVtnP6TxpEmUzyge2XKP3W/x
         BnSCQvPKQg6j6/0DtuBzb90K4/v2ppIxmnDP//FLgMDSxylM9jS8eLAjxg2d8+0UHayP
         VUI1L49OiL9Kqw5Sz2glsGZXJCGu+QM8HPfAiQiI72FD6FIkQ+9e7LMD0JgSXAQ3vnTS
         gcpA==
X-Gm-Message-State: AFq9FYK4srvzTDxRK+Hz9Fh4RAGB4upc0MZtKFG68bAY/LmdV9BJXcvv
	bnHNCDr2pVbJtau5F4TEOAsfljq6MIfGXLcJ+wfEQ4M8qDtGDJdIpFtk
X-Gm-Gg: AYBFou2JD/TpMlB3002OBwYUxl/LVukqpJuKBH8wq2g36oU0LpmPY7exQW03s5iJsaY
	igeKIPwpSiyaLl2W26QqHYN1xpqlUfTxrBq/pT2dL1o50+pZ0liFjTIZoAEZxvDHNvfbOYwoPXr
	0+P+U6fPdEKwgPGDKnCs+Xmkce9SyeSu6nY8U3cH4noiijA2yMHCnryuNtqO/c3GEHBvOzEus69
	+hW0au92n1VNd33gHBSuoh33kJLsPfK8MZ8d9Ae414CPDFsFr/zPbo92JSINd7Eh/SvTYL95l/H
	5BjfF1gEf2ugKB63KqNK+bhr1l8deXngla7lmcF45Th5e2mc6qzVvFjaAnhi2QlXXpRRaN1ADYf
	1GKpjxIMkuoi8GPmSZC/gbJ4vfz3WzRiyHhBp0FCQAf9wVyL86JNqlnJpabOIZIdjhemnveJsAD
	ce1jma5d+hSWmblqv/E87JZNEmKnfMrYnWiv3Q/jurel3zNQojCrju6fV1+hh2cf/W7oSeb20Lv
	tNNrImukVV20m6/FE4xBfzpcMm8wvaSp0f+6Re/4gleFJKvVwudgnYR
X-Received: by 2002:a17:902:dacd:b0:2dd:ad73:5b6f with SMTP id d9443c01a7336-2e8429ade93mr185433745ad.31.1792153489196;
        Fri, 16 Oct 2026 05:24:49 -0700 (PDT)
Received: from yafangs-Air ([240e:46c:5700:24f:b9fd:c639:2cdd:8b37])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e8b98a9sm9455815ad.74.2026.10.16.05.24.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 16 Oct 2026 05:24:48 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	song@kernel.org
Cc: live-patching@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>,
	sashiko-bot <sashiko-bot@kernel.org>
Subject: [PATCH objtool/urgent] klp-build: Fix memory leak when enabling the generated livepatch fails
Date: Fri, 16 Oct 2026 20:23:14 +0800
Message-ID: <20261016122314.81476-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The klp-build generated livepatch module allocates the patch structure,
the array of objects, and the per-object arrays of functions with
kzalloc() in livepatch_mod_init().

The result of klp_enable_patch() is returned directly. It bypasses
the err_free_objs cleanup path when the call fails. As a result, all the
allocated structures leak.

Save the return value and go into the error path on failure.

The per-object arrays of functions must be freed in the shared
err_free_objs path as well. The cleanup loop in the funcs allocation
failure path is removed instead. Otherwise, it would cause a double
free when the new error path jumps into the shared cleanup.

Fixes: 59adee07b568 ("livepatch/klp-build: Add stub init code for livepatch modules")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/sashiko-outbox-173837@kernel.org/
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 scripts/livepatch/init.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

---

It is based on tip's objtool/urgent branch.

diff --git a/scripts/livepatch/init.c b/scripts/livepatch/init.c
index 16aff8f..a1f6993 100644
--- a/scripts/livepatch/init.c
+++ b/scripts/livepatch/init.c
@@ -50,8 +50,6 @@ static int __init livepatch_mod_init(void)
 		funcs = kzalloc(sizeof(struct klp_func) * (nr_funcs + 1), GFP_KERNEL);
 		if (!funcs) {
 			ret = -ENOMEM;
-			for (int j = 0; j < i; j++)
-				kfree(objs[j].funcs);
 			goto err_free_objs;
 		}
 
@@ -78,9 +76,14 @@ static int __init livepatch_mod_init(void)
 	patch->replace = true;
 #endif
 
-	return klp_enable_patch(patch);
+	ret = klp_enable_patch(patch);
+	if (ret)
+		goto err_free_objs;
+	return 0;
 
 err_free_objs:
+	for (int i = 0; i < nr_objs; i++)
+		kfree(objs[i].funcs);
 	kfree(objs);
 err_free_patch:
 	kfree(patch);
-- 
1.8.3.1

