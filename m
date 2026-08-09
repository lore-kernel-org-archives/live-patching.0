Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03779351C20
	for <live-patching@vger.kernel.org>; Sun,  9 Aug 2026 09:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786267217; cv=none; b=PF6XHSAgbMgaK9ELohrSMYmPKD39Idd7VvcCvfSQQWMa9jcuQKu+Zj+WXxAWmR46jpVwhat1zF6U1fedK+gR21a0/kBy8ZR0Ct7sA0wquNqWWKMIPQTMWDxXXcIyERYQNsNo8r1byhs8M8BqIS4P1p/SGz4j95CqGhZQeKIp2LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786267217; c=relaxed/simple;
	bh=3p8keaIJ2Dv39gJ4UsKNaaPQTYQcJX9h0VPcuW+z6Y4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iOrRDSNZpb1p85nrMZ9Ejjra+xm3CVSZS4prPdloREtfKfA7mXFndXY0AIHImGLGa5euVWmYdsIoWT5EE+vrFSJ/+gtu51yxUngCrWzk1FSomYU+pkP7F2XBgYNd8zfJW0PCWbx1GuJlPV6Db2u2bKoR1gHL5WAdbuaILHFPQN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mfwJqYR9; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mfwJqYR9"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38ec1402b05so610149a91.2
        for <live-patching@vger.kernel.org>; Sun, 09 Aug 2026 02:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786267215; x=1786872015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HGAWOIW19QfJPq8w46j/viRocMxhvJelCqz8z5IyYyM=;
        b=mfwJqYR9G3Kyb+BZSSQ8VcTjyjxw0fJinz89xTCDQWIITYb09WPXoAiJjCRsLrfL/6
         ciDB68Mzy8ha7N8E4O5qnUiO5Bl5QoFWibyhySe8jslM1EjBhRM0vDQXB2upmvy4+Oa4
         WcZilkI2/+MD/Li0LRbJa+gYX8CjQvCe7w/gGJ0kwjd7JGDSASixTOTgiBVsHQvc1ePC
         rSPR87/fO0Xk5876DlpKUN+UeoEmJOHjsXETNcqW/ZmXR8a2dQJUYFZ5Xe5ULUgS5NSt
         SwVLsmGF3YqB5+CvJUu/hYbMSCtiR1eh9NTPF3QNy6NSB2L32haq9L5b4fNgFh7VFAG+
         jdlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786267215; x=1786872015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HGAWOIW19QfJPq8w46j/viRocMxhvJelCqz8z5IyYyM=;
        b=tHOJeOar3NRdREEf42Imvc6BC/ds9eEC+qAhmWRRQEwhGHKgl24X0SelPU+yhjW5a2
         tHSRBZWu6ce8KCTfOkbzgNk//Toj2x410WP64LR/M2tZd9d9gsDFaAjnzvfYF94h348v
         UgDZsV6DS/K+HmZBBrFTk6VxbLv1+r5KnAR2o5RMuRlW60p9DHvFySJMv75tI5h9QW+S
         2ns4w/NNw8xWiy/K0q3K9TYz0MMmmT0yBCQZv4JB9P496cLa9rxJUXTwoxGH3VvA+2Mk
         uUCxp7nK9sdFT2i6sWg0HEFBefpcar874u53wLJCzs6t2EJoMVcXDt0XDHwr5ziEMNpM
         uybw==
X-Gm-Message-State: AOJu0Yyf/CLMINdeKBqtFkLl5ODtDav06UxrM2F1CRUvH+Q6urs21G4I
	06panYTih7vBBz6pH7J05kOsRHCpqe5iCu/NYYKmbv8iIG19hTO+yYN/
X-Gm-Gg: AR+sD10kgUFSeiiuEag56DhoohGAU2gVEENQzhd+3sqzisEiCcJOloXZYPw011A4fsd
	59ZTXgdmn1brHf2e9cgonoFlyeo7kycYwnl9uMHNR6z7rOnRVRagQ/k9I94ecuvjckJUP6FrXFR
	EolfDQmhqV35HNDxDYaAPvpLGPHDjgTg9wYXOEuKhEu3yYaSFlY8XWzbaWf1Ig5e950t/1vf9VQ
	g10zx3NGFFp1sqSqOBtj2MGPgANctGb9MzzpclgQsdHZdF368756nfYnNDmWu5MueyT8bi3SXJr
	pbFIOwQ4uSV4vkHm5WFZcuueFNpUlM14Y/inVH9UZkd6pWAp9P5cnV/XBGgGogn/gewvSi90R5L
	Pf+/TbkNs/iAB0zke5uNeCVZHjdcDDpQ1eR5J2bFptn4valeMb/BrO459Ljs+KfPyVMittgtyd/
	pZ3qn6rV1ktro8KJjyz61DNMKtt0tu4U24AGmwe1ZxR5lGPZVuofwCEmQMzzjvV8oOA4Gr6vZZ5
	LYO+TLw7AI7j4NbCPEInEUpkbyB4x4DYaZfhIsOTuosZU38QMEmCM1Kbw==
X-Received: by 2002:a17:90b:3b4a:b0:38f:23d6:b4ad with SMTP id 98e67ed59e1d1-3909d8172edmr19770465a91.8.1786267215220;
        Sun, 09 Aug 2026 02:20:15 -0700 (PDT)
Received: from localhost.localdomain ([240e:46e:ac00:14bc:74c9:c78:94a0:c446])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3908616d21esm11241281a91.17.2026.08.09.02.20.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 09 Aug 2026 02:20:14 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	song@kernel.org
Cc: live-patching@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v5 2/9] livepatch: Make klp_find_func() non static
Date: Sun,  9 Aug 2026 17:19:46 +0800
Message-ID: <20260809091954.22930-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260809091954.22930-1-laoar.shao@gmail.com>
References: <20260809091954.22930-1-laoar.shao@gmail.com>
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

