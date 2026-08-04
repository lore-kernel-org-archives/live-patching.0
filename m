Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C9354788
	for <live-patching@vger.kernel.org>; Tue,  4 Aug 2026 06:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785826233; cv=none; b=GvyPu3oSav5LXD9oHMJklB57Hw1uZY5uruUR4aC0UpGUbYeTW3OCu6zcMhOqN98NcDQmThMBeB8ZeGMQu+rTtyOzl4zLpOmi5MQbMLbn/CbluZ32hom0iRnneq4unBEK7OPtHomIPkGnnDFuR0NszkGjw5kh6QZhkTX91CoJmQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785826233; c=relaxed/simple;
	bh=QWpzyPK9lHuzi+bIuzwPpipycGxzPYXqk99bjOnTPAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K3c6eQD042B85cOMwKSGKtuTCKOKh7BfV2A/em4jOlwoEjdshQy7gqncVqEAuJx8KAU14OEAfXQiS/KMociOIB+bwTD1+CAFV30m5WAU+0X4st5VbrYgOSQKsvcqmmxiZVsAxERb7uHRxehaLtX+AtItGkUFGslSY7SJMf65Ybs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PdBNeXvw; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PdBNeXvw"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ccf2360620so37810985ad.3
        for <live-patching@vger.kernel.org>; Mon, 03 Aug 2026 23:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785826231; x=1786431031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GUfRUt2Hhv5RncbH53vq1rXbkRuqwpctH6bFEMgHfP4=;
        b=PdBNeXvwzahpK/J699Xk1q1anocpn6XssmrgWqOgDI/jwnbSAiUcJ66kO4K52qiXkk
         nHbS6g0hPAD7Wn+XwtXDVBdhfZXa3KQJracDgHjxUoBLNEObpelMXppFhmpEtr2ZILIT
         4rkxFXZod9YAnlSbTcoqfPeT2nAyBYQXaOu+ZyifOSZjMkVpYYI1V9DT59eanY4bPHm6
         wPl60cQEtdYQ3oqT8haeAbOBwnTcobyLyliWo+eH5wOWhPNLXIE0zwBN3113n7X4j1d+
         IViwQjztMm6/hwAMTO8/oozOEGNyGJnVqj/mj6zGomSobQl4E2rNFJnFMdC4FYKPwBLX
         EA3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785826231; x=1786431031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GUfRUt2Hhv5RncbH53vq1rXbkRuqwpctH6bFEMgHfP4=;
        b=B+eMZOXZchWsppEh7WdNfYDAvVQRZMuiP2KEgTMg86iHWSGmla3Oew1T9vvpVC5ptI
         RtHU8SftIRq+VIVeOpCO6CpUrSOP5l8gmzp1UDpuIze0l6a0uYxnpoLqxSyGWMepFSco
         3KrAecbItWmjrS3jKbuh9s3e5eaWYMCDRbIJG3BKTV2cC7FZzqr/b++XVepkVgy9tZN3
         Jf680su0V/6VTlkmkKUhljQHnaKs2CokTLhuyQ2+iKQBRwzg+8WBWIWJUJ+7YrrsD2qW
         aJ5J9hHMx17lkt76/3xMO3WykrYP1M0PWJJYFCQUb9OCSV1SUjJb+51UTyTZh6UuC2Sk
         MS1A==
X-Gm-Message-State: AOJu0YwIpG/vivs1sITTem/eXShdzOcIuJqgxohoshnUyOLEXC78192L
	f/kalKbSUgdu/vVkC/Axo8uDEI/MyMgCSxK0A4Li9Renj+DJlTfoqVI+
X-Gm-Gg: AR+sD10KVjq4P5p29pQ+DRr7elo+GuWCLssirFw04FjlDOqkUMw6j2bO8CnwTe/IsKL
	zMODYpbQ2/cbjIEmP3Nq2Cs1MTYzHSCGZAu9DkAA7QMCIT+VlQJG1cTyYUcdjEL31kElxM4pZyI
	jH0oKsB6n8/O1oPISRFJ6JxCmRIqLzF9iJ6nUwsk/n46eVd6T/7pBPgE6uAD7S/NContpJOnxRk
	8IjUO9YNXnT2A5kv3DRu0ZbFOtbPl5a96PY4UjwMlAohr/edlDb8Jqm5X8KFUJWBdZV3CzD5xdx
	jJwkx9U6W7gWjPP26KaXlnfyFBzEWpFm2YLYVO7jc3Spy+1fq8IPbtmTdwJE/6tRSRry6mj/nAE
	0OKi3yABPf5o31aeC/U29cuLGePB2PhycvK7/q+660d5lEHIxYCIiDRDFD6dMAH4Wl37ywgVp61
	FoSsOUrViGIimWiLZOVZaqmAY8+oHblnBae0C+LgTVK9TCgkwpzdI6o4wPFiih24LmINM7ncQze
	g5iWxao4CdMa1cZtZySHeL/akRZ68ZVMWc=
X-Received: by 2002:a17:902:cf0b:b0:2cc:777f:d67c with SMTP id d9443c01a7336-2d0521e27d5mr128832055ad.13.1785826231488;
        Mon, 03 Aug 2026 23:50:31 -0700 (PDT)
Received: from yafangs-Air ([101.90.159.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d0aa01af84sm1066085ad.36.2026.08.03.23.50.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 03 Aug 2026 23:50:31 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	song@kernel.org
Cc: live-patching@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH v4 1/4] livepatch: Make klp_find_func() non static
Date: Tue,  4 Aug 2026 14:50:07 +0800
Message-ID: <20260804065010.44922-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260804065010.44922-1-laoar.shao@gmail.com>
References: <20260804065010.44922-1-laoar.shao@gmail.com>
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
 kernel/livepatch/core.c | 16 ++++++++--------
 kernel/livepatch/core.h |  1 +
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index a240d1144e89..0ad778d1006f 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -82,20 +82,20 @@ static bool klp_initialized(void)
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
+		if ((strcmp(obj_func->old_name, func->old_name) == 0) &&
+		    ((obj_func->old_sympos == func->old_sympos) ||
+		     (obj_func->old_sympos == 0 && func->old_sympos == 1) ||
+		     (obj_func->old_sympos == 1 && func->old_sympos == 0))) {
 			return func;
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

