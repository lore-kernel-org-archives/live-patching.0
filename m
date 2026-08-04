Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2677233A9E1
	for <live-patching@vger.kernel.org>; Tue,  4 Aug 2026 06:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785826236; cv=none; b=P+5UMT7eLgIi2EpMsr/jrw6YWdAxbOizofjn7b4B4A0qt30YJQdNPgWOm5SGZCvq8u5SulYNIGGVeHV4/T9OVPUJdM3BtzLlKQWhsAoMSxn3nzzWArMG0IRMt4pdZRPmpIZ9or4OxYm5V+YUj22m86yMBWL0fdaBMi2xeG3S/Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785826236; c=relaxed/simple;
	bh=u/XyPBIxx9rIxymJLRAy9BNRRGEzzXtIvkQpC/OfhvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NI8gUrVVZI2xheXI7F4Aq6/crCctT7s0GOoAwyjjg4T0FN+kSi2VY2iDSqVI8wtBj8FupJojNbb7Ekw3R2ijD8/XHjAFSEBBA22bHyby6e9cpKWnv23xCi1loyQk4WsN2xL8m7HdXlIMOIj/dnA08OIJ72Jkr2VhXlmgE48MDwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fa3S5UBf; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fa3S5UBf"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cf452def93so5614295ad.1
        for <live-patching@vger.kernel.org>; Mon, 03 Aug 2026 23:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785826234; x=1786431034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZrfhATUlpra2l968pgYenm6ioNoeDcw4R9QjTIdQcbE=;
        b=Fa3S5UBfqJm5/ZLQzALmDYZESjKeUTp7IPVbvhj/9IVn3RVZEmL3Zf2Rw5Pb4mJom+
         Hxxi7iOA6/UP3yrJBWbNV+Rv5glz7McrJ6K5jFyyJj5gvpqaa3JzcvKCy6Qa8Bnti3Co
         kueBTJvmuqU15+iPIyyvyBTphZIVw69BpbPOuX/bpUtaJH8oOFAUu16vluQC2IIMv4pO
         Jrm6mDqy1TuNrrs0/DdJBynYRwdHfn9froBQMYz6094zpj7dcNf6xNRCCOhj9dSnVMW4
         EeFn4GnVZzvpCvG0pGeJD5IL57sWpLbuM4QgQRWda9n2uvWrAJwQnKhJtJIZJoNQNSyG
         MWfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785826234; x=1786431034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZrfhATUlpra2l968pgYenm6ioNoeDcw4R9QjTIdQcbE=;
        b=Xks2NQ76auRjc2/S/YzCmfaViEI3IbeZL7fQk6+z0JO2Bf1hSH2ig7X5n/2MJUAWYU
         Iq6vbLwCZUWKVgMcwBPcPNyJwffvMIT0ksOdv/ptnYOK+4krSGakO0hTd2eghdxyguU2
         S9w7+D5KdP6xjtQsop4LOho+Vm+KayU13C42stsMoCCU07CVh+XQNOrQ9w2Ga8BmAENa
         jDpg3uwXwGvpL72dEnAoxWyDnOdV8UX589X+RPTIiX0FcripPmT8ZYnT9SEc1hQIArCQ
         wG5mSRQQGURqURpW9Y62ODqy7ATIiYgKNFnlSej5drqLKa8PNLGICnkqxdtQBW6qFPTX
         2QZw==
X-Gm-Message-State: AOJu0YzIXVSWIvKClhFHdwB6qiPds10hhdu3wG2Tuo5QikBsJWpHBwtI
	E2Am/qUEVcBWQz4LctSWTebgNlLpAOQPS6tP0gO4lDuC7djmZQcNLqpk
X-Gm-Gg: AR+sD13uPnESOotNHQm685ZuunYqnhuFhKtNrb3v/vF5scGqDW12zXOjKFchQvtihdJ
	IqXMRieV7PVt3+5FV7c6CnbbF+IJ00gPWTy8yptt3fXBrZMcsxqwJ+sY7LXGiAyjgQXEMS9hYh0
	QjQc3qVA2N59XcARFCm9Xpfv8uIlVfZ+jbZtyapzCXaToAuab6d6LhmgflnsRPOMN41NijSYAtH
	GxSIK9RkQxa2FoYh03dBDFQnY1Iz2KW4f1n/8Q8lrjpJQsBE1p+S4MZi3mnyW4hQ6zwNkWj+Vd7
	1ybjhqzh4VhXuAG/Dv3vDEh7WhDDrYvyHSLtpKdHh0xD4A6Z6SN9wKwTynMzOHmI0qPSUJOFalt
	5dxid9wWBqKEl+sfr22s/4vFIX21aqCMvVwxskQvzQaZxbVL4+XvDJj8+j/qRe1jqekTBtJNEtg
	cGDzJlTdcnqU8DNk0bzJNJtBA6b44bJ4eFwwIJ4rBdPOYe2UGp1YJPaNUayJrRMAijfjMZI8yV6
	UVK5WG1iMa9Ckcdmyo7JGbp6zfc6JlRZFo=
X-Received: by 2002:a17:903:2b07:b0:2c0:d94f:50c7 with SMTP id d9443c01a7336-2d08aa6448dmr23448945ad.7.1785826234471;
        Mon, 03 Aug 2026 23:50:34 -0700 (PDT)
Received: from yafangs-Air ([101.90.159.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d0aa01af84sm1066085ad.36.2026.08.03.23.50.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 03 Aug 2026 23:50:34 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	song@kernel.org
Cc: live-patching@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH v4 2/4] livepatch: Call klp_init_patch_early() earlier
Date: Tue,  4 Aug 2026 14:50:08 +0800
Message-ID: <20260804065010.44922-3-laoar.shao@gmail.com>
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

Invoke klp_init_patch_early() during early initialization to avoid
mixing for_each_() and for_each_*_static() variants later in the code.

No functional change. This prepares the code for an upcoming patch.

Suggested-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/livepatch/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index 0ad778d1006f..5ec30909d382 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -1145,6 +1145,8 @@ int klp_enable_patch(struct klp_patch *patch)
 
 	mutex_lock(&klp_mutex);
 
+	klp_init_patch_early(patch);
+
 	if (!klp_is_patch_compatible(patch)) {
 		pr_err("Livepatch patch (%s) is not compatible with the already installed livepatches.\n",
 			patch->mod->name);
@@ -1157,8 +1159,6 @@ int klp_enable_patch(struct klp_patch *patch)
 		return -ENODEV;
 	}
 
-	klp_init_patch_early(patch);
-
 	ret = klp_init_patch(patch);
 	if (ret)
 		goto err;
-- 
2.52.0

