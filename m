Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B8C35E94E
	for <live-patching@vger.kernel.org>; Tue, 23 Jun 2026 09:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782206233; cv=none; b=oa7DY0uY+YMoau3C4F1HINEkZSMUCF4Dv6u63XcJTxyT7ELImFm6KE1r4hHxehKzMeAP7y5QuVmEcJBoMLIZ75GXmAoCW3UfkvAngGGROVSUKuqyEg4JI3uJ7UotPgIlDG7U/xZsg6A760Ly1YLeKGi8vgd5ReOX5NEPyhi9oqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782206233; c=relaxed/simple;
	bh=qUF77RFnQkisgaviBK/8YWpOiXUve9xo2/SaXHn5Ldc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=itLOJxdl3sU2QrWld64MaeED8UMWfCKl8QtXFIxqVEFr0n1h06hzZrgAEyXMQprSpRJe60aYsraCFBK8ZUmJZUygKWPF3JjfHhHmVqxhvqCg8rr1FpKX5wwORl7QrCv0GYenKPbtpwoFaCkO4vFvwuo1CpJKaNIIuaykCirBibE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KGqLig9b; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KGqLig9b"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-37cbcf49deaso2644627a91.1
        for <live-patching@vger.kernel.org>; Tue, 23 Jun 2026 02:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782206231; x=1782811031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1T8Z6wl0dWbJ9JONn56uSBan/WFTn2gAgveEi8sGBjk=;
        b=KGqLig9b6oVyELhdg5mqFzKocf7rwzKSfnJfHWJ/LYOefwaZZLMrY4s1VJXzJx2c6b
         oel/y7CDb8xdkgEWKvirlXEWJaVDNCkg201yrls9XszfciCHmclyh2sxVblosgby/kQ2
         9ZHYSXPEQNuSDKrMIytRA7G9dBOT7fQ5UGzD5injxeW6vWq57Rfz9VmohWaYJsybpKWQ
         elj+99jyyn6zA1uEHgISd+TGQ/Yepj6SOgqf7EezmgvzOTD0xVT+NqQ4vabdxCyIPny8
         axARZK8dvAktOOI/RB0vbmArLWskz3kLky2OipFxoG01y6cCUICLMLgNHxyRRpmaJ37v
         c84A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782206231; x=1782811031;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1T8Z6wl0dWbJ9JONn56uSBan/WFTn2gAgveEi8sGBjk=;
        b=XLlB6PMVx7ed1aDBxB+1QxN1kn98/AtDwPxeHAmfnO9QObF/vAU6Ig7rFCON18D74c
         OTB/HdgsbfW3X5qFWHqFpRnTngcfazYPcQZ1sdjiyJ2TLjpSPBrqyiJ6Jsqct+EL2kso
         JlEavoYtY8j0XiAiOV4RJSV360GwhsVQEt5ySNCSIQsxOKhZXMsNkFONIB0NZOxGhG3D
         MAuoIzvRJMpc0s2WOo98+s65nCv9/ztlHOD9PjCdAaGf+QtQ5XoPz6PmqcSMUgehDRRi
         DfJJ+0l0ofPXlbEOIiB1oDxoMNpUbQSYo1ai4cCWdulG55UvyoY9bH7iohMlpj+nb0od
         Eo8w==
X-Gm-Message-State: AOJu0YyfJPF6QBYrBkBVGpcddVLAXR0O3Zo1f62tD/TiF/r5QJZnQ1eC
	fWunPPhFdKZD/QGnBZ2Qcb3/GhJniJBrHq9cBNjm/MNKDp2PMXQVmTQg
X-Gm-Gg: AfdE7cmYrZPd42o2QqUjug+FgX8gTW1SNflgbjLdn7y+QGxtTM9wD+Y2jg95HFjS68k
	E1b2s319wIL7ApdG+AodWEhdiGQU2t/+xtMe2WOlnVFL/r5WwkT3fcuBN0gdAGSlrKIsfMQsvdd
	6PY4FICqpS9k0kTekOWdKFnIep6WQO/kPp0RZft2tn0s4Ag6lfkz7kDLXZx1o8ky+vbMu+ML9bT
	EnTPnQzN6qLhshP33HPc+pfQboNqwZmHdjTRNDuiOXjCO3LXPxpaDgiUzCLnr1oV+h/Kf18jPex
	DgfGOsDnrF5dKkyrtG4t7CtwhxaNeW5sFKMeMS4JFg1n+lOApRUWVvOxl8VMT2G2M+d0/4vBO/n
	6jRAj2mqxkUWoGt9VCDKUsuH8qC480lGX3kqcT1bB/WtnzLR9Um9HJ4lkLnZc2sYnE/VEI28I7v
	k4pqmbQLCZ2PvvYFjKk1FAyOreXJo/LVaAUQ6FIckEiNUtHG/YkL9VvGkEX30VOxohtUEw
X-Received: by 2002:a17:90b:3fce:b0:36d:b680:3036 with SMTP id 98e67ed59e1d1-37dd16c2668mr1764026a91.4.1782206231176;
        Tue, 23 Jun 2026 02:17:11 -0700 (PDT)
Received: from localhost.localdomain ([58.247.233.220])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37d15de5d3dsm12873778a91.10.2026.06.23.02.17.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 23 Jun 2026 02:17:10 -0700 (PDT)
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
Subject: [PATCH] livepatch: Fix NULL pointer dereference in klp_find_func()
Date: Tue, 23 Jun 2026 17:16:38 +0800
Message-ID: <20260623091638.76648-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.50.1
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

Add a sanity check at the beginning of klp_enable_patch() to reject
patches with NULL old_name before they reach this code path.

Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/live-patching/20260529040130.95A9C1F00893@smtp.kernel.org/
Suggested-by: Petr Mladek <pmladek@suse.com>
Suggested-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
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

