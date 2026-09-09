Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39C42F3621
	for <live-patching@vger.kernel.org>; Wed,  9 Sep 2026 02:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788921843; cv=none; b=kjtYTQPlv6/ljFt/265Y2LZtteifcL86kiKd1mmfzrDDcEFu7VHw6T6YWck2jJ6j5DjfTQschVy8RLI7IzZVM6oxs+4NPxC5xUtGt9Z63z4zLDJ1ke/gC0bsNY7GTIj7UvewVUkp3qA8CNIAeFY+h4oadoik6Nle/KpgAxkeU5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788921843; c=relaxed/simple;
	bh=iiL28SUO2mY4taZkG0YRiXZxQc7LKFG27IMlfjMGXAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cCssZpDEPKCK9MXp+cezRq64ikoUsOiWEC3c05AuwhVFbTZzPS99LSwqYWMl9KO6R7t9JZalEtU+kGsA7csKp800YhEx+bNTAFrhNlUG2W75JQQHfISHXjvTTg+nG1bP6/WkflXtea7k9JriDK8ZPhNrJplCZtW0YynwJdtR1uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bdqTpCIA; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdqTpCIA"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3969e82ff8fso5620336a91.0
        for <live-patching@vger.kernel.org>; Tue, 08 Sep 2026 19:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788921841; x=1789526641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DJkYz2mx0NoqY3hOX7fVHlRh9iFKQSnWueTSB7O14lI=;
        b=bdqTpCIAdakSVJdioNUy8G7XTqKs4VEmj+6EHMwTJuJM07UBOevDiPu9SaEdQahxjD
         vNifnGL5TDWd4yVHRiReN/NVSVM63BI4I+4ecjongm7rBA0XEzEhvhcGlMg80tK+6CWf
         oknZxHgk4TyyMGcLBsgyOubWy1SSmzokMa4Qzh/WZ+C0HorlZR0yDTu4QkEGpjWVc2HU
         Nx+cAwSZ9hAbUJLKb27BCwyROQ4gtJq5rrO8AxImdtIWeP2j32pXKrYurXB3N5woSc7r
         OeFMIJei735TE95CmU6hxiyqje+VDypsXN0L6f9Anj9c1sLd7XIGS5Zzg74Pvg0xw9XG
         26BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788921841; x=1789526641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DJkYz2mx0NoqY3hOX7fVHlRh9iFKQSnWueTSB7O14lI=;
        b=Qnc83OqnEqdFrYjjor/hzP+FqNF3W/HVjXjvJMOzXNtKKoCvqiJgOdMCGuFKW2fxy5
         GRwvk/5tMtPPwHFIKDYlWOg2LMqVyLR0enenz1vVnShDwxel6MLkRz4NhFRuOyXlDpwi
         oV9ukmNwK0iG/8RmYKTt6eZG7EBuP+Cg4fMyCItoLpcqMw6GEkbFHw45Ch3JPJqWhBWB
         lHcQJPBJcCJiXTdhFfkfON70yzx+T4yHItH+mwrsFcOvhfe70LJJ9tSHy7r9cPs6L1M8
         vs7eflVZsTip+Cc1xxxJSqexBERWnexk+pK9X6J8RVD6lstO2wZ2FR5CuWG5Wt2W1/IV
         YOEA==
X-Gm-Message-State: AFuF++lxID7KyDL+nmoBqBs5fqiZH7c19DQzTOfkl6xe/suYHnhygImp
	44v2v9GARoIP1RAS9UNkF67HQraBavUjk/tSsXOTlDY5pn3JEeAMmjrZ
X-Gm-Gg: AYBFou3HP+G3yGY8Csg/dYI54r4u3JaUAPe+0xFuFg6rCUp0qePRoUhg51A+rtUVPFu
	tptdSTvJPAEC5/Nu2Uai6jiCnhBk1Q2sO2rfZCv+oiIF8H5eylJcxy1EqUPpxCKWmdbrHc2Zjq4
	iunTv+5dsUkRoCuHmfx9PgRhd0tKg584uP6dLw8QMSvSqDWNdbj+7HVf4p9t4+uQA37Auhcr5OQ
	gK2hs7enm8ha4SH8FIj4d1AJVjPugVq0wd1rsLTiPnE4aNJREPzswwFUVR0LWicHfGu0kWhQ1qc
	rdiMNXOyv2KuaKqjdWDBd+/22ipbVfEV01ccFR2AwT5k+gy6Lh1wu9+ZF8xddfyYiUIr0u5f0yz
	cyokThO3nWvZk8EsWeYAY84XTIPhhgzTJgtSOlcygb+souh58cFY1rBVNMMthRNfgCCI0vAV2C1
	eZz1kqyC2zgR6Satrkn4Ahg+MCtLO5/o2/CF5E18aJBzJ5ia68YH+C+vpzS66IUd5WY0Jxxy/xz
	rAFhIy8/c/rXm7qIzEERaTVjmJzI/rHcJwC/0soiDWSwnx6t9sLidigXditz1kjC52IzCI=
X-Received: by 2002:a17:90a:750:b0:39b:92bb:9eef with SMTP id 98e67ed59e1d1-39b92bbac84mr7615185a91.22.1788921840845;
        Tue, 08 Sep 2026 19:44:00 -0700 (PDT)
Received: from localhost.localdomain ([240e:46d:2100:5b4d:69bd:afbf:d6ca:3462])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b260cd15asm29292957a91.4.2026.09.08.19.43.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 08 Sep 2026 19:44:00 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	song@kernel.org
Cc: live-patching@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v8 4/9] livepatch: Call klp_init_patch_early() earlier
Date: Wed,  9 Sep 2026 10:43:19 +0800
Message-ID: <20260909024324.16002-5-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260909024324.16002-1-laoar.shao@gmail.com>
References: <20260909024324.16002-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Invoke klp_init_patch_early() during early initialization to avoid
mixing for_each_() and for_each_*_static() variants later in the code.

No functional change. This prepares the code for an upcoming patch.

Suggested-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Acked-by: Song Liu <song@kernel.org>
Acked-by: Miroslav Benes <mbenes@suse.cz>
---
 kernel/livepatch/core.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index 89251fafe86e..c0879b5d9dc0 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -1155,13 +1155,6 @@ int klp_enable_patch(struct klp_patch *patch)
 
 	mutex_lock(&klp_mutex);
 
-	if (!klp_is_patch_compatible(patch)) {
-		pr_err("Livepatch patch (%s) is not compatible with the already installed livepatches.\n",
-			patch->mod->name);
-		mutex_unlock(&klp_mutex);
-		return -EINVAL;
-	}
-
 	if (!try_module_get(patch->mod)) {
 		mutex_unlock(&klp_mutex);
 		return -ENODEV;
@@ -1169,6 +1162,13 @@ int klp_enable_patch(struct klp_patch *patch)
 
 	klp_init_patch_early(patch);
 
+	if (!klp_is_patch_compatible(patch)) {
+		pr_err("Livepatch patch (%s) is not compatible with the already installed livepatches.\n",
+			patch->mod->name);
+		ret = -EINVAL;
+		goto err;
+	}
+
 	ret = klp_init_patch(patch);
 	if (ret)
 		goto err;
-- 
2.52.0

