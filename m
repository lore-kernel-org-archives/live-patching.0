Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C1C1DED42
	for <live-patching@vger.kernel.org>; Mon, 24 Aug 2026 03:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787542069; cv=none; b=HVUrnKEhCfgZrxmI56W3a1usa5c3XWIw7OJpl1yTWH4HNKbUukkbHoDmTOb4cJRuXY3nzQZt7rFs5T2LXSLWelQKrhRcKGUp6ZPFSUz5A2TcRtzrIYw47Yadr9ZL/XMJEyHkL6wYQsy7joxER0UT48dNoE7B1E3suOYp/+d5rwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787542069; c=relaxed/simple;
	bh=+0p0eQC6sqrrkrZSA/2F0WZ97bcLNL/Ney05AugLWFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ixuQ2CglYcL8vwET0oPNSocoDrrqQxVa1LcddTA1DPzNXxCbgK86OfTf+hOUOjWouVOmLAJ1d5gjIjus8/okJG2hIZ98+8XLco1RPKJ7oCLooOeWSNSURRbS//NoGiZHO/Rp/AUh0I+ZxCzTsjVD8PNiWqbcKkIyJuhhsBLd6us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jT7elyI9; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jT7elyI9"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cab973140bso38441795ad.3
        for <live-patching@vger.kernel.org>; Sun, 23 Aug 2026 20:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787542068; x=1788146868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2OHCOYp2/1VX1Jb0c399EHaC2RCXuVH2D8ykrn6ouwc=;
        b=jT7elyI9TPpkxQt+OBZcXPL95TnxugK0xHdjc1pqqMxTRgJBINf3jumwmcKc3zMWkc
         v3bZemsmQr1qUF8YqdhLYyC7eUnGssvsD9WqIisJjQ+VPJD/Y4EaovhTGGO5DPEhZzSF
         OW/Qp7Ks3Xd3hp8AhqlOVbps9i1b6yegUaLoZC39iOr6/oIred+goSbwfZjGTvDMKaZv
         7+pZ5YCbZF9ZaScYRoBRlFAGZ/OTU1DTrRpn+tLlAjMxkKu9BVNH5QYc7rclXY2s1vd7
         fv0O2JI4vWJgdgZ2T9oRS/e8wj0mHTRea0JqClc01RxPre6Hi+47FVhvN8/UEwZcN8o8
         d2Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787542068; x=1788146868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2OHCOYp2/1VX1Jb0c399EHaC2RCXuVH2D8ykrn6ouwc=;
        b=g38BSEqDayEgmkwqA+QO820lZuE1F9u8VIPDuyPlYY6RPjJfHL1l3liLvR2zQNlyuH
         vt78cPRbTwDzAsrXYpwNzxjkIDifbry+CC7al0hZc1bTxWgJPJXqnt1rvW4n4oLF/nPg
         BxvuIx5jaeP1o5MIbXrjzBWjIotiQoOKVWmPibdJ3mwWFR56j4Szk16LUuVZbLvIxdxq
         OpQQaDTt4rXieY8eIoNx1mKz9Dq5kiUG8NWcgLZzo8BDxsl9aLuJlD8i/ONLgG4x1C/i
         iT/0AkkIJFzZfy7cMy7HMgl+jJIrMCMWRJFCebKgM2H52TpXIvVTky2ODwdSGh2TyoVu
         plzQ==
X-Gm-Message-State: AFuF++nqMU8DAPjIiGKlcXwkNVgR3BHT4hX/k43kqjAk6m9Q+Ur3Zh+C
	LJWrRcxlQmvr4ydrI2pA4KKjXUdEztioDRyOWhYClCjigwP71BjhTb2s
X-Gm-Gg: AR+sD12PYHaCSl+E83gFvG47BstjEMK/vVA+ldf9+LhSpz2Ci9NDw5S/Psfd6iOf3PU
	sxJk669VJXYc2xlbdXcuLfVtNk6u3MTAI3Z/+2vVNah5s3okqmXf7LajqniZiwBJqskH3MYWU+L
	gVX9EM95y0jrNoW0AZv1I6YfFzQKpdHSRibnHhmvdLjMHrHro+BhEm/jDtScQRf+lta2AROcoy0
	etYlfTa/zkWogeFhZauJMrSISPFosr2PVQUf2gGpokGoK7Ds+hJYCd5U5JmjXIRChlrt1/DFlzj
	YRhSJ3vOOpHBat4nhhfwG5NAAgfTbMrNtynAuxY51OJ1k9Yxbp20TygvJmEEnnF0bb2VJBElIEm
	HJFEg3GxOSsSmf6qabRQINl0tPb3H04s6RLo4uBulfcJDjaU80G5ssD3Be8Qn5UFdaQeEaSNF8Y
	En2q0G++CkogoBEjPzR/spkjMgX+VyXFSTTIDrgtzj21z2oRiMVHgPnF2gNRjqxYkgU1RmUQkMh
	3v3yaoI4vX7R62G/eeXMnLuI/xe+/LkwitsSExzF/s=
X-Received: by 2002:a17:90b:4b02:b0:36b:bec8:94c5 with SMTP id 98e67ed59e1d1-395df2595femr24532335a91.10.1787542067622;
        Sun, 23 Aug 2026 20:27:47 -0700 (PDT)
Received: from yafangs-Air ([240e:46d:2600:d2:b0b8:8b52:78f4:9247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395e4b46518sm8496460a91.17.2026.08.23.20.27.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 23 Aug 2026 20:27:47 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	song@kernel.org
Cc: live-patching@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v6 1/8] livepatch: Make klp_find_func() non static
Date: Mon, 24 Aug 2026 11:27:25 +0800
Message-ID: <20260824032732.56686-2-laoar.shao@gmail.com>
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

Make klp_find_func() non static to allow its use in other source files
by an upcoming patch.

While at it, rename the parameter @old_func to @func to better reflect
its generic purpose.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
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

