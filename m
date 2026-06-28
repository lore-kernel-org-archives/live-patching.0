Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A630040D579
	for <live-patching@vger.kernel.org>; Sun, 28 Jun 2026 11:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782647211; cv=none; b=Yy5TGZoEMXMmP7nyAXjXu/NUkz27+rqSQo+ORwIzsLtXfwncRqqTiZgAvRyTIqOX3yZaCYwp0sFGovjOOWV6pJ0/PT+Tbw3N93Sq7f4UM8+Hr3WdDdlRQsaUV7hWXKvD9yEIpTi8zqcgXizl8XnlN7K3qMhmBdzullpWT6zYWvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782647211; c=relaxed/simple;
	bh=npevS0g+Qb1DmEe/P3T10TcG9H/zLbRVndpiO/6/k1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dlZo+tVhn8qbzVU/Co0xUOMg3bhuh+i/K0QPJJh8fCKnXXKPF7Ck/3KQT1qwotT/F4LajA+ERzkYGV5C9V8vHCz333RXVO7ayMPQj4XoL/XvVMPTCkgdeLUxbin6QC1I2zmT8EL9fII5c5xnEVibund6z63ZqIyR1XJkzOFFt4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hKBdtDUC; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hKBdtDUC"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2c9f44ddf26so464925ad.3
        for <live-patching@vger.kernel.org>; Sun, 28 Jun 2026 04:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782647209; x=1783252009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=25C7IirL8rOn5zwPULJZIDdW9SkThkTR+uI3t1if5BQ=;
        b=hKBdtDUCX/KB5YwDd8PqUR60sZ7pLjN04upKMxe2Uw6WF47R/vJJFfexykRbtMai7L
         sbMIrP8Kz8Ir4Yp3cpxn4ZaGyKcPWDlyaCJnDo+zDb+TQhVPYIlJcWjHeTnp45Cu8Pgt
         15lHYJfnNvuL79fgvKCh2PRMgph6R008AvWv4YSQDy3aExxRf2ajt8Zjw93w/mOuZSy7
         cl9fgb2dQThkn1/bmIh5Y4Dqy6VpJQLXMbX/r4RHY4bJuXhgTFDt4COuHDk/IPo7B/+v
         AJtfwTClICV+Nh2M4KkhwdVztHewIrYkdmzEnVLgch3X4Q8OPEScWkv7zwW13Z0Vd3v+
         2Tyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782647209; x=1783252009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=25C7IirL8rOn5zwPULJZIDdW9SkThkTR+uI3t1if5BQ=;
        b=s0LOwdeEzfbHWRtsiGtu3CngAy35J+vZeQtIowqKWSkRK/HFhw/5ru0C9i4GowiOYI
         niFEIw6myp8JDjUwtjG2jeaeOS3YaDYCYNQnZVHFKHRZRDtGzOHP5mva4vEUHndE2fpg
         q6FSFjvS4vfkw5mpOcXQOqtmbH39Ba537aX4Hm/HlstoS7oaITrA9ihRczeDAtXemlH8
         Xp+2/duV2VQEU9EsQNykFDwRniDXnewuJbvztPXXhIh6KiRBbOuCWKkEPzLev6sQuIIz
         ziozlPRz/S8htOVgfPyzbA6gyLj5MsqI4u19liYDgG/pJ9IhgHTqB/8z21U0mq6Jq5UO
         p63w==
X-Forwarded-Encrypted: i=1; AHgh+RqQK8bu3e6nwYpf7LgCeaM6tHYUM5zCJFOcvA2xsbq+QXJ9wq6zo/Jl/5iDe3XhxIpTsspN3Fep+kCWBXWb@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ+HW2T/jmvIj/EPchCddi0ksuQLrx6XiBwsqyZMp6UnYWf69L
	0rnkGAJBsR2w9pkY9eXqKGVm7yjeMi1qdLOaVEtUeFtiBv39YQYxajOC
X-Gm-Gg: AfdE7clSIhWDUmFPfQjjwdGj5iyI/2eIgMZAPXFUcjivxITeXKSatbQrjIc9iPaszRf
	U+JrW5ttFLYZ8bTjFAjmv7UZAxh1Zrki0LtLq462WHzYT5k0RSGJhS0HOGhRyVfY0AVLW8wl0Mk
	S2X3V2e/A6MepxUwHxIULzK3lHdzoi4t/SKnaEaCt6OZu1nErTxqiR9qh/5GqHZcKSJoJNI2kCx
	RvDj9E70YtmO90VXjdHz5oOMGqqjTxk2thtVGglNrYdMtQnO0+t1a2KGWK/Wc0oLQwkKOHrFKQb
	BV0JAKDRC32S63vFhErwJdoTcLKpzdLL31T6tEYoMxI5jiuAmw3IXdZr7c6Aqe3SLMvcIcO5KB6
	QRencb3bIDZj361wlNsPsUzFTWdkhiQNKTP5Wi3E2krBkc3UO79se0g2UWiPbozU3tvhFyX5Rj6
	i+KNmKfKn+HuErA+lb+dy00IT79Uu6BhMgXLe4Y+MyKZmbZ4SCr+Yponb6B3BRKlM4
X-Received: by 2002:a17:903:946:b0:2c7:ef3b:e17f with SMTP id d9443c01a7336-2c7fc791633mr120783835ad.36.1782647209535;
        Sun, 28 Jun 2026 04:46:49 -0700 (PDT)
Received: from yafangs-Air ([240e:46d:2600:2cf1:e090:433d:67ed:863a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7f5ae2092sm72767235ad.20.2026.06.28.04.46.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 28 Jun 2026 04:46:49 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: mbenes@suse.cz
Cc: jikos@kernel.org,
	joe.lawrence@redhat.com,
	jpoimboe@kernel.org,
	laoar.shao@gmail.com,
	live-patching@vger.kernel.org,
	pmladek@suse.com,
	sashiko-bot@kernel.org,
	song@kernel.org
Subject: [PATCH v2] livepatch: Fix NULL pointer dereference in klp_find_func()
Date: Sun, 28 Jun 2026 19:46:35 +0800
Message-ID: <20260628114635.33572-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <alpine.LSU.2.21.2606251523310.18862@pobox.suse.cz>
References: <alpine.LSU.2.21.2606251523310.18862@pobox.suse.cz>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A NULL old_name in a newly loaded livepatch's function entry causes a
NULL pointer dereference in strcmp():

  klp_init_patch()
    klp_add_nops()
      klp_find_func()
        strcmp(old_func->old_name, func->old_name)

Add klp_check_patch() at the beginning of klp_enable_patch() to reject
patches with NULL old_name before they reach this code path.

Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/live-patching/20260529040130.95A9C1F00893@smtp.kernel.org/
Suggested-by: Petr Mladek <pmladek@suse.com>
Suggested-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Acked-by: Miroslav Benes <mbenes@suse.cz>
---
 kernel/livepatch/core.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index 28d15ba58a26..a240d1144e89 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -799,9 +799,6 @@ void klp_free_replaced_patches_async(struct klp_patch *new_patch)
 
 static int klp_init_func(struct klp_object *obj, struct klp_func *func)
 {
-	if (!func->old_name)
-		return -EINVAL;
-
 	/*
 	 * NOPs get the address later. The patched module must be loaded,
 	 * see klp_init_object_loaded().
@@ -1092,6 +1089,25 @@ static int __klp_enable_patch(struct klp_patch *patch)
 	return ret;
 }
 
+static int klp_check_patch(struct klp_patch *patch)
+{
+	struct klp_object *obj;
+	struct klp_func *func;
+
+	if (!patch || !patch->mod || !patch->objs)
+		return -EINVAL;
+
+	klp_for_each_object_static(patch, obj) {
+		if (!obj->funcs)
+			return -EINVAL;
+		klp_for_each_func_static(obj, func) {
+			if (!func->old_name)
+				return -EINVAL;
+		}
+	}
+	return 0;
+}
+
 /**
  * klp_enable_patch() - enable the livepatch
  * @patch:	patch to be enabled
@@ -1108,16 +1124,10 @@ static int __klp_enable_patch(struct klp_patch *patch)
 int klp_enable_patch(struct klp_patch *patch)
 {
 	int ret;
-	struct klp_object *obj;
-
-	if (!patch || !patch->mod || !patch->objs)
-		return -EINVAL;
-
-	klp_for_each_object_static(patch, obj) {
-		if (!obj->funcs)
-			return -EINVAL;
-	}
 
+	ret = klp_check_patch(patch);
+	if (ret)
+		return ret;
 
 	if (!is_livepatch_module(patch->mod)) {
 		pr_err("module %s is not marked as a livepatch module\n",
-- 
2.52.0

