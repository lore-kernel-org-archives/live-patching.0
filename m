Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CB8257845
	for <live-patching@vger.kernel.org>; Tue, 25 Aug 2026 11:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787658421; cv=none; b=hYM2wutLApA3iE7v2+23opZKNfYaMVoRvpqmEwjoi+fm2DApASqCIfq4E9tnITjwzgmYFejmyLrAZbnAEv7ywuVbKj0y9VF186BZvwYXg+FZY6oJKieu0GZV/L2V1QY+YDCu2lMkiPTq/9OSWSPNB/8uQDIhgYhPR6C3KAghT0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787658421; c=relaxed/simple;
	bh=Tf2FAH/fB+9FAKtWvLXjwIdKn33txFzqVGE2vRGLQBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bfmi82g5cAMuFpLaXokN913OSBjLeZbYWkl5UKi5NaFWEp25AUsykX2IQRl2SH5YMGBNnkQyYU9Qx+MRI1JTzrwhID1T9GhVaiT4wgpslUHX3uqY5xDl8tKYmt/GRn4zfudhgKqZXL5shSx7EknKj91KrBk73X/8p1vad9vNOm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cyke+awf; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cyke+awf"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8487b7b3fc8so4895933b3a.3
        for <live-patching@vger.kernel.org>; Tue, 25 Aug 2026 04:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787658420; x=1788263220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=91bCgabMa6GOJd+OnR0+tZEKWf9NOv2pOU0gEQTgkAo=;
        b=cyke+awf6u+Y3wpRB0LLPKw/f859y2Zz1E21ONnEpCR+cBf5sFWG6Q8X53knpHxrG4
         +uFm88Rs2/KqLFhIs7H5lLyD/MLSSZkaEioLjvgz0DtDsjhqfdQJBgkUB6itpg1P1/Dt
         fWiA9eEK1Lo4lKDKlTBHOB0xiV2vG1NljlOtN/dTRbL7CvRizZplBigeMIA7kOOKbGzX
         JxQ/3oUGItPT7+ghzNP2DgFfb+qjRMrtCBhBQwGzDSwwLQYFe3WcNNhdyK9piyvBNnh9
         T9bxUvXP979L1lQ85HVEPaBIE9Twc0ya2cT15fOzwR5lbMZ3XeDCVJ/S6o1ha1RcWUoe
         oWYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787658420; x=1788263220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=91bCgabMa6GOJd+OnR0+tZEKWf9NOv2pOU0gEQTgkAo=;
        b=j63ApRowex5y2NtvwBJ8nYsIlKIIe2Mwk2gVNWEsL+Ws3ufADz9AfzG07zlwoP2ltJ
         q6APwrhonqVvyG+U0DD9LCEczMnIG9fw6Jm2vgbV8wya05CMdTxDJZKNsjtBFZgPa45P
         tXLNlJ3WLgBEP087pX2y3oYc9yhpNMTYa+v/NA9MPfjbr2FUpFkwgqVpqE4/bNt5A3k3
         /0CqTamCzmV9PTD6M7LUeI/Dw9Hq9qNEi8V0IymBxVebRrYeiXoXWMKVoqzQvPcr25Nj
         AtbOqJ6SEdjoIwwkoZsVrX6KSaqMpzJhICm2rcBHh0EqY4H6Lchs6QsdkGLZeidsb2dF
         JDSQ==
X-Gm-Message-State: AFuF++mf7EHpn2ryF/qSezqkGKTazVFRPnXWIEFwAcoKtiXWyaxgMIBW
	RqC+G4p4mxvcbzOZcMEQeulIVSwUksDiS2aMzv+X+VWtMmoOQS7Mb9RE
X-Gm-Gg: AR+sD10zJhn8yFZlfwKuPRzPMvBgFfjBcb4d/+Bpd99JvCM62NnC9Zof0e97qOVfKap
	PZdUeIn5rNUENFC9oYTVWUMhg1KTLeF7RlPbFt7K9vv5i1HrKq/E+emZgeoceGMVlcJDK29CUI8
	lWLj0Nq/L6sObb+WLiP62zOmikzETOC6Z8qog9xcP7xmhZnD5xzTrdf5E/orLOlGNB9BJhJnWxt
	pggUGUlZ/KS7oN/hvXtnQ8V7yROsD71l08DbNt6S5RXbx0LsN5jO4l4tt/q8V10+cPT/alrAb2N
	6kLxMHDg6i9xjdWaFJ6Bc2Bul/f9tSMweRsSbFq22xmTjFgMy8wrFIrn9EnvLa/VyjBFkmQjISP
	zKg+vNRZET+o8mCRVtq1z2+DajJ6KpNWvNJKCYTDpZv5vi8MWqCgI31Ye4CDYa6qm+Eex+A6c5m
	kMXDC/hsVmqNVBby6cLMFLXuMShtFuyDMp5JIffttMIJRyedaLbY3nfde7T6aKZtQfByKVIC/lc
	ob85LfpDS0bMkx3LDodks01wBbpPGMyNw/zm9Yva4cWmjK4lA==
X-Received: by 2002:a05:6a21:398c:b0:3c4:36ef:3dc9 with SMTP id adf61e73a8af0-3cd30182e4bmr19838090637.17.1787658419849;
        Tue, 25 Aug 2026 04:46:59 -0700 (PDT)
Received: from yafangs-Air ([240e:46e:1b00:ae5:3473:12aa:8e70:f95d])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc199e5fcaasm1864438a12.24.2026.08.25.04.46.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 25 Aug 2026 04:46:59 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	song@kernel.org
Cc: live-patching@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v7 for-next 1/8] livepatch: Make klp_find_func() non static
Date: Tue, 25 Aug 2026 19:46:34 +0800
Message-ID: <20260825114641.80452-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260825114641.80452-1-laoar.shao@gmail.com>
References: <20260825114641.80452-1-laoar.shao@gmail.com>
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
Acked-by: Song Liu <song@kernel.org>
---
 kernel/livepatch/core.c | 18 +++++++++---------
 kernel/livepatch/core.h |  1 +
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index a240d1144e89..c34306ecfb0b 100644
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

