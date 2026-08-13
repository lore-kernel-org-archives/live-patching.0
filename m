Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CDB33A9CF
	for <live-patching@vger.kernel.org>; Thu, 13 Aug 2026 03:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786590268; cv=none; b=bqSFWBZkqYIYowEMZJl2ofQ/jtQpTLbKaQFgfb3LI7SqWZwfIZA2yNnhdSZETbmdXYpayBAMQYLFEToi1IdydIaMVrj29tmXYQYRq0bP9LshsuAAmOHQF6J0vzA875DIUxfcG65aieUhqnhBjWg5h6ULJSKM+gR33wnwrcN048U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786590268; c=relaxed/simple;
	bh=dpAnt8SJx0l5lSvI4VTA3RqWdqVUdLWAqXO8kti6i7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FVXDzQAzwXV3JOBKv7no0a5qhYHChtXf4+GtTB12I7RC6FElYanhyr1mpeED1nWKC+qJ2Zv75ksBj6U8JFotpWlzknQ/2+2aqZOSWqsSFVnWiE7nv7Ef0cHmmoB29Onc/o3aqcEvDDOq+3jJCtXZMry+uhNdz9z9mpq6nybaXZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XJnAv2e2; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJnAv2e2"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cedda2ce6fso11086465ad.1
        for <live-patching@vger.kernel.org>; Wed, 12 Aug 2026 20:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786590266; x=1787195066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+C0vUq2l93qy5o728G9cXHL0Wh7g0iwysMrNsJ+DbuM=;
        b=XJnAv2e2K5n1uEpt06qRaQULY752dbNszHuFHz8JFzKVpjJeyQrvl3pCufM6o+ZZ+B
         GlL0nVS8zuAG/zTzsuoCzo6ASa9bLLZMoUG/rPwbGQyCz/KjWSRTKsynAVOEZB+7tLuK
         Oty3mWyoe2PSkAoKNArsTPQjr1CdiSjHAWM7jNkSlyCN/vXVQ18aQD4BL3y+odh3Oohg
         IbJNFRKG3W6VBKp8U63FpqxUv8P6Q4zRQ2M4NR7HGIGa1qNIdHrOSBvOgslF/1y9hOws
         n1jqLBOV53sbmiJQ66giO92pSuphwUyaPCeSY0YFZwLhkaOq1m7yRM4LfZ72ZNXcOibg
         H8QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786590266; x=1787195066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+C0vUq2l93qy5o728G9cXHL0Wh7g0iwysMrNsJ+DbuM=;
        b=oRDuek5IX5+LaDURnYSVMdRj9pbo2EMHU6azzdfuolBNhz9ORlF/qmFmH4YP+UmNzT
         d4TZpLVQ9TS0+7sE/GZbmJlQlczKL4rHjbZ+6WehA8Uu8N0BUoe2G8NAu5bs+ngUXkhM
         fQm0O193x5j0uTGvifZuar6uXeyvZBmYr6up1HD7zHsWptIBX/OM2BkrbOOXOfC5bNSf
         UejPFDMzo1XjeoFfKxlHHTpRNR1aCGlWc4Q57e8T+QfrA1kGD6uC4ZuLnFiWc7PlxQc3
         l5icN9p9gfTYR/ypjaN+D4fya8O9yheEjXyZv9hBRzavL4KknkSUzSxjaR0v1TFozqQD
         ycpQ==
X-Gm-Message-State: AOJu0Yw7z+0v8I8bn1UaM3FoI0ZJCiC/tZ38K8f1BLxpP5FdzwDyHw7w
	OQMhoetC9lOztlC0F9Hwpeyh+Uw3UyIBkRBGk/t7/IOAum1bo8lJYbYV
X-Gm-Gg: AR+sD12+LlYH3CpAlgAPXrO6ugscfXaIvGmi9Grr+e86TekRW1/k3lkSJiLsK9LgSGk
	+4BmUrNVFNHCxSkpFLjDumxGr4k+FH4vOJzY74qmBqG/SCgwJP0n5sNGazxkZ0vQemiKEWv3s3G
	ccYIfBKbrg34jknGB87QLCaw8IMaP6Q6Vpw0P1ZTdvnKVjCB78Hwy48QvNOR9q9/g/W26f0+CmU
	Wg8CQhhofTh+vt5bA3t+WzGt9JCskSyoWa/lrWak/soKOxMGrcmB9KrnOPwUDlw/c3WosEk01pY
	+zn6pZNKoTeOl1Xla1haWkJP7+dF4OwLdAYPohOsI4mM0aBI9tHe+nnu0BVQ83rd1uyxsYwkJ7g
	DupceRfXkXd3rkOJCqoIutrLPoceQZCOLDtPYyLakwBWnHKad2ntKcOCeR4arJcxJEHCaiERHf9
	Xh918gF1zJTXuVDnlgjuFNucotX7Y/q6EvO2FiiaVCgT33niRYirirA4w0k0bgw1fvOoEb7669z
	7aJMbPrWs9w18mH0DG8eA0mqmCTzwyy/aUghhTxGGByLrQCB2SaaDYJpQWHnoLKFA3sTQ==
X-Received: by 2002:a17:902:ffcf:b0:2cf:afe8:b722 with SMTP id d9443c01a7336-2d37e8a1cebmr30595055ad.11.1786590266329;
        Wed, 12 Aug 2026 20:04:26 -0700 (PDT)
Received: from localhost.localdomain ([240e:46d:2200:5cce:f1e9:7eb6:cffe:ce35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d37c200cf3sm3173905ad.4.2026.08.12.20.04.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 12 Aug 2026 20:04:26 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	song@kernel.org
Cc: live-patching@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH 1/2] livepatch: Fix wrong index in funcs cleanup error path
Date: Thu, 13 Aug 2026 11:04:07 +0800
Message-ID: <20260813030408.9761-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260813030408.9761-1-laoar.shao@gmail.com>
References: <20260813030408.9761-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the object allocation loop, when kzalloc() for funcs fails, the
cleanup loop uses `objs[i].funcs` instead of `objs[j].funcs`. Since
`objs[i].funcs` is still NULL at that point, it repeatedly calls
kfree(NULL) and leaks all previously allocated funcs arrays.

Fixes: 59adee07b568 ("livepatch/klp-build: Add stub init code for livepatch modules")
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 scripts/livepatch/init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/livepatch/init.c b/scripts/livepatch/init.c
index f14d8c8fb35f..77746984aa57 100644
--- a/scripts/livepatch/init.c
+++ b/scripts/livepatch/init.c
@@ -50,8 +50,6 @@ static int __init livepatch_mod_init(void)
 		funcs = kzalloc(sizeof(struct klp_func) * (nr_funcs + 1), GFP_KERNEL);
 		if (!funcs) {
 			ret = -ENOMEM;
-			for (int j = 0; j < i; j++)
-				kfree(objs[i].funcs);
 			goto err_free_objs;
 		}
 
@@ -81,6 +79,8 @@ static int __init livepatch_mod_init(void)
 	return klp_enable_patch(patch);
 
 err_free_objs:
+	for (int i = 0; i < nr_objs; i++)
+		kfree(objs[i].funcs);
 	kfree(objs);
 err_free_patch:
 	kfree(patch);
-- 
2.52.0

