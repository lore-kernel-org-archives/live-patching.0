Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380692BE057
	for <live-patching@vger.kernel.org>; Sun,  7 Jun 2026 13:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780838247; cv=none; b=M5OWpUIoSwa5Em1ghBVIJ3aefB8KE49lbVbZGBn6y7hpC0cINj8EmHhAVPttjYud9s39iELr8MLC81KtZ/24QJ9LtGykKi2TshSQdok/lJcfS4BI3aVDKgpTgl5bvBVNtF5Tp5UA66Cy/d+3667A/xYi83tL5RTreuGYBnFvKQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780838247; c=relaxed/simple;
	bh=TqL7LC6nSandMigOXTmIEVLuKdrjDxIpzhi0iHruLa8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oozCnOjTJmbikWgkDAF6IhVZjRpoXhEBI/zMNxyuYiBrprOdI0VB9s9etaOd4cjj4jg5lLR7YY1Hdh7Yh/Sb+vhgEhyZWHI2EQi7FSGsM2WAJJaOEe4semjilvxd44Y6WzoAV3RXZwroWS+FnCnp1PLJYv2amsXMwekvvT68k18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N4vkXzTY; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N4vkXzTY"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2bf30d530bdso35211285ad.3
        for <live-patching@vger.kernel.org>; Sun, 07 Jun 2026 06:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780838245; x=1781443045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I/eMZXFrUGd2qyFDkC3LAipZucgO5pKo2WUYzom7bf0=;
        b=N4vkXzTYpyUA9yKtvnu4Vj1u+Lg4ux9iDz12E7gbUndClaTNlJgHMLQ9fWbCsfLyJz
         4eiLr0BJM1K4kO04ZLiSIOKKho61QdE08cDh6l8jrfaMjkR5lzZ13AUkpVEJ3sWN3IEl
         zAExKYAHlRMFZfNsThxU0BZAmcRItFTlKKAhPWucnR3VH1NEJoWc6/O3gFJPqX4G2Gs6
         6gNjKI/O8a3GwqGHtDvIMWn9kQO0CBJzFLCRvXPj0mg7M1lDCWhjPWy+4zAe/Hq9gM2b
         jTSDBS8GYtWjRH3oqA1n4q7KGezmBeY1+ZAcPniiOB9K9dfdrf/1IhvT+Ye/jWf7NgFx
         mKhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780838245; x=1781443045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I/eMZXFrUGd2qyFDkC3LAipZucgO5pKo2WUYzom7bf0=;
        b=KHtAmp1QOa2MToMexSFRPtL3FI0T4W2uXSM6owC/6ASJ9g2YDmKtqPub/KCsGyBcum
         SjZsQQZRGYRO1opiV+6AsYzkUmmBrHfK7aYTIfcDmMcTafk9v6D7fyG50ZWej8k6NfuZ
         etn5UACROAls1JLJ6O3oejbK033WNutjfv+Tz5UIyrj9RcGXOcNYRR2E+R03P+L3yc9S
         mFI10MouOjfOOQ+gbK3MiYyODvM+paL9VTg+qklBQIvoprKFFyT9WYYqynbL4iyQ8MmJ
         Kk9Laky0I4mAXqOwDMwZcGaAhB1Ygc30PBUPFqj6zfsFD8dIutFjUVrBPEPeYsA2sFac
         00pQ==
X-Gm-Message-State: AOJu0YzcGPy1nzlUOml8ZUGYqbF11cgvAsCHhCd6BlbXMLRzfcV/qeG+
	kp+3cBAwuBXHYtpRV0ltuIsmlorwnMZ9s9eyMLy3U1505DVD0nQWpoAt
X-Gm-Gg: Acq92OHM/vnpXhv2JMwB21Ei4S1258H+mMNNu03b161V7D3+qa3aFqdcaomLMxZ/LOl
	c1VX3+uxpdRYczShP0zowDJk6huVPI1nEomQlueFBzxaQ5+LE1qlr90Wwn4Crf5xny96cKJ8NSg
	J03LZvNQFx4QqlirgUnQYJwODq6W188SK9VKbz5uS1N0v9NWFYJwGOtCDurceMLNtybrfk6dwid
	+YOKCpLF3hJrBJFaTpJ5yMsRd6/uFfyXRI+ZBUzqkeDqXF4imBpU6L8UJS4VHX8M67P1KhRLhDt
	XbKsyFsGwOcE1Qr4oVGc+HBlrmtyileYXlw71hPI2wMYYGD4GnkMs8j81oDDmM7HCs2Ilg/s4iw
	Ag/Yi6c52Bmg4GWFOJciqFUvMKYSXv+mKeDajCFmNfIsGKyDs6gqPD6t+++Cvc8c8c5MxY4AVeC
	qaE1uuocTqq89BjAIglHc6Mr4DWLC4j3wDrZROk4zUiXxBfPy4I569F7e8jgXAP+q1KtP8W0oaO
	8TwutNQCKqd
X-Received: by 2002:a17:902:fc4c:b0:2c2:1982:527a with SMTP id d9443c01a7336-2c2198254f0mr73959005ad.16.1780838245391;
        Sun, 07 Jun 2026 06:17:25 -0700 (PDT)
Received: from yafangs-Air ([240e:46c:a410:280:a000:69ce:6442:2055])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609e627sm153004985ad.52.2026.06.07.06.17.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 07 Jun 2026 06:17:24 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	song@kernel.org
Cc: live-patching@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v3 2/7] livepatch: Move klp_find_func() into core.h
Date: Sun,  7 Jun 2026 21:16:54 +0800
Message-ID: <20260607131659.29281-3-laoar.shao@gmail.com>
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

This function will be used in other source file in the following patch.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/livepatch/core.c | 21 ---------------------
 kernel/livepatch/core.h | 21 +++++++++++++++++++++
 2 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index 95117f7a5b00..6e15ae96a0a7 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -82,27 +82,6 @@ static bool klp_initialized(void)
 	return !!klp_root_kobj;
 }
 
-static struct klp_func *klp_find_func(struct klp_object *obj,
-				      struct klp_func *old_func)
-{
-	struct klp_func *func;
-
-	klp_for_each_func(obj, func) {
-		/*
-		 * Besides identical old_sympos, also consider old_sympos
-		 * of 0 and 1 are identical.
-		 */
-		if ((func->old_name && strcmp(old_func->old_name, func->old_name) == 0) &&
-		    ((old_func->old_sympos == func->old_sympos) ||
-		     (old_func->old_sympos == 0 && func->old_sympos == 1) ||
-		     (old_func->old_sympos == 1 && func->old_sympos == 0))) {
-			return func;
-		}
-	}
-
-	return NULL;
-}
-
 static struct klp_object *klp_find_object(struct klp_patch *patch,
 					  struct klp_object *old_obj)
 {
diff --git a/kernel/livepatch/core.h b/kernel/livepatch/core.h
index 38209c7361b6..8f01eae875eb 100644
--- a/kernel/livepatch/core.h
+++ b/kernel/livepatch/core.h
@@ -56,4 +56,25 @@ static inline void klp_post_unpatch_callback(struct klp_object *obj)
 	obj->callbacks.post_unpatch_enabled = false;
 }
 
+static inline struct klp_func *klp_find_func(struct klp_object *obj,
+					     struct klp_func *old_func)
+{
+	struct klp_func *func;
+
+	klp_for_each_func(obj, func) {
+		/*
+		 * Besides identical old_sympos, also consider old_sympos
+		 * of 0 and 1 are identical.
+		 */
+		if ((func->old_name && strcmp(old_func->old_name, func->old_name) == 0) &&
+		    ((old_func->old_sympos == func->old_sympos) ||
+		     (old_func->old_sympos == 0 && func->old_sympos == 1) ||
+		     (old_func->old_sympos == 1 && func->old_sympos == 0))) {
+			return func;
+		}
+	}
+
+	return NULL;
+}
+
 #endif /* _LIVEPATCH_CORE_H */
-- 
2.52.0

