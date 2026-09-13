Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381681D7E5C
	for <live-patching@vger.kernel.org>; Sun, 13 Sep 2026 02:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789267397; cv=none; b=nJlryUxjAUkk3EO5Z1mhaJukCWd/4BFMBD5ms+g7PldQQCGx4vCMkirKG34Y7S87QfZ5e61PbSVBdcW7q8grphEu+JNKCUcvP4gWt7gZh8I4tPpybN2t6qKdGSASc8tC5zjGVX7T1GRo056YKgq+7EASrfmzDZ3jjQzbKJUQJs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789267397; c=relaxed/simple;
	bh=8KyAr6SsYt5rnqXZLuJZbxn6+K8vhacM6G1DgiU1q1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kH21F0p2w4JGaf8QdZ6qg8sh5IuyIxur98z/Wya7JfrUSr5q2HgZbaHGAIGW7pyx4LyEvqEKRJrrhGNFk3RtWCK5koUqFh49uuudksEQ46bR1uZ0Biefqbv4Mt5CtuLXkciwlpGwJknhqvUHX+K46KegI8mJdSsA4GIY5KewLio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aROElVEG; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aROElVEG"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2dcff8f44f2so32571625ad.1
        for <live-patching@vger.kernel.org>; Sat, 12 Sep 2026 19:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789267395; x=1789872195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/0UB2ckCy0xZFwMNpDkgYeeY2ZpOcF+oqY2TuGLQWSw=;
        b=aROElVEGYczDYMpIus/L1LDbJKmWNJQClQRVFEqJdIipfJ8GSP4/u3WijbS/QIVuCs
         N+EGeE8NnhKgQkvQZaDRVU95hguUyHyb+LFLGstYk3CsAhidqg0SBREva4SvgjY7rs7s
         4thrxiaiM5iY+eYSdkZ5Hps/TFjKgJ8ue9fjwXXMyQZTKdY+FacQ6DFafoTTCm5cYO2B
         0IsI0RLL/XZ/of3MHfU6n5RX5VgHNg5DssXu1kUFSMXXNSSpHtrGdK1A/CUGTKkKtZoM
         xgX5EP4hssxMKDrgGUmLz+i7v0bR3ar/bdbNsxCaQEKU2TimbZ1jeGk/+FQbzPsSeAEC
         1Ysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789267395; x=1789872195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/0UB2ckCy0xZFwMNpDkgYeeY2ZpOcF+oqY2TuGLQWSw=;
        b=jc28MfXW/Yxc63tl8KR/xBR7wOHu3/3Iw7pWbthGAtjOzuQ8A+Neo6rTqFS77kL8Y5
         u+uLytqOyc3/YJGRNG3RrFhiK3pkX3516DxUmhTDaKBAIGLxHWNYuBlOUMk5a1vnY4km
         kZNmH1iQxyf5i2G8gznZfbw7cIQ2dejSf7ImVHRZEamtl5G10ylv0a/1IamLsCgNZH18
         SeWGcfbYdHn5EendlOISc60qtpDTA1URlWOfC8w+uWwH7fanOpsYBmW3b1Vty5n71cBl
         tOba3tVLHl/Mno0mSUX5vrXyNQsSEZEIpaZQddq/ZkEq1NDQhdPGIkYrIDul9k4IL7wl
         TXWg==
X-Gm-Message-State: AFuF++m6kX7/Gx7CFWPqfY7xr3NvaWTj8RwhfOZixaYqBqg03inD9x5B
	Hgs8/UhCF1oJvhWEj2rwUeWMt/HUiRnDwyX4+y7J+BP+PjyXakYTXzqY
X-Gm-Gg: AYBFou0XoDPzRXJTLIKutieZV6jzxy5nDBER6MCoEba+kJSkqGcZiboW8SiuXAzXkgq
	9Qp4EsBwVMW8rrN0ZiRswYBShsgqV3Gr3ZnKXJWPW+xNYhnWfCydRygqnYLWZbdbNodljdOGlEY
	beXJbLGYZfhWYFX/oZGLPRDQ7nJI5GpW/tRENS3g3WzABDOryN9/EKmmWf5Qc9NUfqDEWM3bvoE
	Nc3HiwrOlnaDwwKFAJFuRMO6fgwOblfevYFF8ge9ayTqkGRU+ZcdLSz7tyGbVoy+L7+EF1P4NmE
	g5rAKVch1lgKMlh3f73pPetIB3g90YQ2nsDNQuEHI0+VAqY23TxtCklG7qohnE9U6sr0tHCzfua
	ZM1abXiRy/rHO63C2IDnP9tGxIxzI68W9s5fRZ10r6WExcIktVeWDd9M8vSgf7O8HbCWhYjeY8f
	w1nTaITEOrWbB0c2LAgfvECGrfOgDf4He/QRze8OSmvJGVApnH6vpapV+w0StPL6t1G1QOgo48b
	IH2GZ1VYqXbT9XQ9bFtdNpLN6mCB/+BDGypWV6LcEtZ9/Q/GY5Q23DTU6r0f7M+XYlcCQ==
X-Received: by 2002:a17:90b:586f:b0:39b:66ee:a14 with SMTP id 98e67ed59e1d1-39d9c374d49mr18323490a91.25.1789267395460;
        Sat, 12 Sep 2026 19:43:15 -0700 (PDT)
Received: from localhost.localdomain ([240e:46d:2000:1e66:594b:84e9:394f:396d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d994cc978sm12730756a91.9.2026.09.12.19.43.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 12 Sep 2026 19:43:15 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	song@kernel.org
Cc: live-patching@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v9 3/9] livepatch: Make klp_find_func() non static
Date: Sun, 13 Sep 2026 10:42:22 +0800
Message-ID: <20260913024228.72317-4-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260913024228.72317-1-laoar.shao@gmail.com>
References: <20260913024228.72317-1-laoar.shao@gmail.com>
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
Acked-by: Miroslav Benes <mbenes@suse.cz>
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

