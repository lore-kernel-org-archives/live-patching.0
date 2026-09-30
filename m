Received: from mail-pz2-f37.google.com (mail-pz2-f37.google.com [74.125.228.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D012F12DA
	for <live-patching@vger.kernel.org>; Wed, 30 Sep 2026 03:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790737444; cv=none; b=p7Q90ZQb0ozS8i6NV4SidbpeTlOya7PcBSo22WSH+k7zdrothSPRSxUq3Sy2IN/G6HCf3K4y2nJsNfd1l9XVn6O1hhqSevQdiTrqWEqkeRpwJlJDV08Y8lZJB2V7k9NyIo2WSm0AZCEN6TIzca7I4JvyKYknDJAIFJmMLmoFjuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790737444; c=relaxed/simple;
	bh=8KyAr6SsYt5rnqXZLuJZbxn6+K8vhacM6G1DgiU1q1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n7lea6O0wlEXOgbj7CJXRYtTn88/NNAi6SqsEWfwkEZBexnhgykmLDEnPJwtk0TITZ2UqfGWYlTKui0lTemX5CEeDq/Lje4+iW1y2p26/VgaJ56isS+Uetox+Kxio+Fl5hso7IH0Ju/jcmu5zf4/aAw23KLsXgZAQoN+ShnAMH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=glWPEuG0; arc=none smtp.client-ip=74.125.228.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="glWPEuG0"
Received: by mail-pz2-f37.google.com with SMTP id 41be03b00d2f7-cc7cc70890fso560630a12.1
        for <live-patching@vger.kernel.org>; Tue, 29 Sep 2026 20:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790737443; x=1791342243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/0UB2ckCy0xZFwMNpDkgYeeY2ZpOcF+oqY2TuGLQWSw=;
        b=glWPEuG0k8xCz4LT4U4MGZ2KHE3Rdp0oipBGaUU8EIwFVb1x2B8wk1/EI0VOztYCF6
         8YkSztX0G7IP0aRdkDh4EHtdFg122DJu1UV5SL561U0uy66D9c1bXhjnF0uuODAmPtWZ
         v/7sqKR4dWubYW0Ad8sESvJBmQY35dVw138cTtYMtF2ldVmwvb2PKbb7+yGCN20Cj0Br
         9bInqVjp0V9bibuP5E6A6ChslWhJVlURqcPn/LYZiB4QVJ+i77IGdY4GDj4h9GuVAFVA
         AUqxgqueYEFk8zmpSzCeKwQypmlfEH58obWk5OQVipBJJGV49Pj2OGWmpE6kx5WSObnG
         9Zqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790737443; x=1791342243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/0UB2ckCy0xZFwMNpDkgYeeY2ZpOcF+oqY2TuGLQWSw=;
        b=KyoONh+3atuPgcxL/MBbnGiWMfpUQvWzdqedyiDvggkH5UlU/4krEK3UUSMqhbeRld
         l86RRk8yQj89YCXBANbqffUTZZCm//oek6gaOXMwcaY5HSgL/oUeUy5DC6826pywIH58
         RIlqwPnbenYcgxkqCpFIjepdn0WCQbcJVD8MU8gOiucMGlAZZ3R637JiB4aLQjEh0p6J
         CwT26TqtovLzsVad2lsUik9yOZEre8DknK9WXshu8Yoev7LSmy395TYEve6xBDnqyIxv
         uCCGXslQYB09aVLQsgGicqwdbfYUQM6veGJjVwWxywescZL2y4w81+2ZrWT9CmJ6TbqK
         76Cg==
X-Gm-Message-State: AFq9FYLoBsnfXmaW0wuosPW7wcATiYjsWpL9TtiNp34H/eIA5VZUWfZs
	tpR0PGH3Sn3v7ZJIspuw0DQaq2ng0UbGHvqxicxBHTXJczHQf+zCANmP
X-Gm-Gg: AYBFou0qDLK9dP+gjyigwUy7lMVC9Jj+exbdyJfYYkK8duci/nw7vdEMkwhBravv3Se
	qXUd8x5Bme+bUa/D6pXoXtdUyeeVRgqofdLP781H0Am1480MHhXjt8qmm+vgc50Xi9spIg9dTE4
	qfnrt9BjWFUvlcl2RfK+wqTzWCwrZuVqoT10bM7d1WSbnh29DGCVzdQd4Q9tElooOv9i2Nov7s+
	oZnyQB21EzgRWK4zaNvC9Ga2qIeYEB4ItStHw8OeHHKDVd0SXP6BvLItGXzrpd0UB4b32KFwXcy
	HWCLu+Q6dGEEOupLJcDWHpYo4o3+LH//27l/NtWANGwyfQqC/KWnqd4WFnW9nrIkYFwejT431be
	ltAC0xMsfu3kMRwP7vx9Jx5aj1EqkwzuTKw+6TIlmFYFVljeqQROQpkfNGIqF5v6eY3IdmpQszk
	Asq+Ws0FSXFygCzgCmA4smZ1Dc4fN7pia7PEbaeVeSsXfmTigrgFihI3skPd5loXQpbAwgsMszu
	w8JUP3vn1zr22VM+wuthbGVeg88zS5/mNoGu8SEGUSQVlBC9OxjLPCrn/nlOTtqFaHj9CWPyEhN
	egRZ
X-Received: by 2002:a17:90b:4a8d:b0:3a4:ac7a:2903 with SMTP id 98e67ed59e1d1-3a4d15008e8mr68836a91.12.1790737442877;
        Tue, 29 Sep 2026 20:04:02 -0700 (PDT)
Received: from localhost.localdomain ([240e:46d:2100:5cb1:9131:1918:6e98:b864])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4cabe63c0sm911937a91.9.2026.09.29.20.03.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 29 Sep 2026 20:04:02 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	song@kernel.org
Cc: live-patching@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v10 3/9] livepatch: Make klp_find_func() non static
Date: Wed, 30 Sep 2026 11:03:17 +0800
Message-ID: <20260930030323.14396-4-laoar.shao@gmail.com>
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

