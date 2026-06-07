Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFDA2BE057
	for <live-patching@vger.kernel.org>; Sun,  7 Jun 2026 13:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780838240; cv=none; b=uHbKMwOgabvwpdK6L1HvzB1iyj4j6RDKRQqlFo+T5XwsvmlUegKxNowSEmhqH4wCPYggBIkYavn87bfZpNC3kqs7t4cvmYSogQ2B1O+l55sG78s3MIGXptI3Df/X272Q8Fhv9fK3GkGlxR7Tq9T5sXoOLGguJyd01E+ec9P4G3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780838240; c=relaxed/simple;
	bh=Uus9uEqHaFxeCXrFxg7szeBlfqtYdXD43yCwUabComw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ms1r4AnuH5bXW48diDN+Z9BrTXWAgybM56wTgKn+l4wvvrh0I8GtxgSBnxiNIacFUDkI/oZTOvep1HoNSyHvOMl/8Dgfg4RhIxExSuK1y2nauhUo62T+NzBZPZPGSLM3h18f3lx/MMItlXXy6ooqMzyskVdra7h4fjvhaT1tWqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dR5BaCIB; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dR5BaCIB"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2c0c2c7d45eso30310165ad.1
        for <live-patching@vger.kernel.org>; Sun, 07 Jun 2026 06:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780838239; x=1781443039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/OwaIKOsYlAMzmoOkXAfg3r5aqbJO5czHuvvEZ26DqM=;
        b=dR5BaCIB1NRe8JXVSXAyveMmhH4iTWlFu06X55eieODcWO7L/SJ8VzpXojX2cM34O5
         /VNWlOYVtI8H/CScZmHYqmqK1eSzLWfTxyFZJ2oo83FJwhV8uY+1QFzEbvyuFokgscDP
         JXIhDhCoLIorshIcIeYB0hKxAVD+FNbNtFuUMiDgqZv5mECwyTMxz/EeFljcy0G7ojvu
         o9kYp+tk5x424OC6WJccxGJkiGDhbg9yRTI5gmQeGJuXJsE7xEZK1Z54eBpDxGYlvtJz
         Wbyv8zwOnDF2Eq83LTvYPZJkAcQ7Z2iFDseKFisDOgBsPbxKUfIyGYAALF+6Kor5tjNO
         4TmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780838239; x=1781443039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/OwaIKOsYlAMzmoOkXAfg3r5aqbJO5czHuvvEZ26DqM=;
        b=YLWLOL9C+Jtl3S7dkLtaaP5FPVQSM5aBnREpCgk3W8WAvV40Sw8i+ug8sAOxqjUYYp
         M+LGRjS4HfYH+kR8hZ0VzAGo/u4T1EvMp3Y/FrKmdFlBAtSN9i0kGbK8SeqHvLm3ekDO
         gWRv4nvyx0WSVYIrnTAh3FSptLDJvuWEAk648+TGWK3yj+Evg/0U/8LX62RBsn1H+LuI
         +VEUajAnwMjW7fAaKc4XH2egdfJJdFMLHeGwjV55GA9yRVB0SGqkRcfHdF67K/8VT4qZ
         LjwtIAp4Ye8xt+n4gmcFQ2sBbnYuyB0/jaxw5blE2ywMQfMm+IZln+/+dRZFc7tPwf/X
         7NeQ==
X-Gm-Message-State: AOJu0Yzl+II4GySdhIOBaAiTUFwckI4Glo0hIpLwc44069LRbXOgRqkF
	FfSbLfWmpey0wH3fMrF0eANybnJfUq3fVjFXF7C71wtZJ09u4W4seGsV
X-Gm-Gg: Acq92OHrrrzoQunlCdxqn+lgWUCPIT2Qzfu2dIfgWrAPMrVJTf52wdZwTcsxe3AsKm3
	oOVGbxwYNmX6vsjHpRUSxrBB2c7QdRXisvAzwXo4iCqKtec3StaGJKhD34M6qL5LMiKGkAr5g7g
	oZKX8+jU5tLx/TR8CNZE21BNY5i5PF3wIgw9Itw/+UEnIeYQR2bfsyR7PaPzMDUmKyhhnhrFCzt
	uzm4ZjxstyK19q9b7T1nrTxdGlW70VEEUbdy00VMzpMgTXz9TctwZHQnnn4cAk5onE6p5fSrTk0
	WQVWpRWC7ULM+vBbqPxTsRIMNn/S6yId52oSOKaY350wwDxF9hwm/L/XNIvvB/BN4P1GaDKs3N+
	Ru+eqOMf2x0zj8qO32S+A7nhzHc3IW99CCBIJAjhplRJ5P90njuR2iYMpCZtLR2V0o2qMPDBMd7
	06D21sP472zjZF4X5o5Or8hjjrbDebyBOSnV07GYoldp6baSrfD58RSGgXWPp5FF749U1afuZOK
	OjmqHYeyyRN
X-Received: by 2002:a17:903:15c7:b0:2bf:dd0:c8b1 with SMTP id d9443c01a7336-2c1e78acf24mr131149515ad.0.1780838239019;
        Sun, 07 Jun 2026 06:17:19 -0700 (PDT)
Received: from yafangs-Air ([240e:46c:a410:280:a000:69ce:6442:2055])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609e627sm153004985ad.52.2026.06.07.06.17.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 07 Jun 2026 06:17:18 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	song@kernel.org
Cc: live-patching@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>,
	sashiko-bot <sashiko-bot@kernel.org>
Subject: [PATCH v3 1/7] livepatch: Fix NULL pointer dereference in klp_find_func()
Date: Sun,  7 Jun 2026 21:16:53 +0800
Message-ID: <20260607131659.29281-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260607131659.29281-1-laoar.shao@gmail.com>
References: <20260607131659.29281-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a newly loaded livepatch provides a function entry with a NULL old_name,
func->old_name will be NULL when evaluated in strcmp():

klp_init_patch()
    klp_add_nops()
        klp_find_func()
            strcmp(old_func->old_name, func->old_name)

Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/live-patching/20260529040130.95A9C1F00893@smtp.kernel.org/
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/livepatch/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index 28d15ba58a26..95117f7a5b00 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -92,7 +92,7 @@ static struct klp_func *klp_find_func(struct klp_object *obj,
 		 * Besides identical old_sympos, also consider old_sympos
 		 * of 0 and 1 are identical.
 		 */
-		if ((strcmp(old_func->old_name, func->old_name) == 0) &&
+		if ((func->old_name && strcmp(old_func->old_name, func->old_name) == 0) &&
 		    ((old_func->old_sympos == func->old_sympos) ||
 		     (old_func->old_sympos == 0 && func->old_sympos == 1) ||
 		     (old_func->old_sympos == 1 && func->old_sympos == 0))) {
-- 
2.52.0

