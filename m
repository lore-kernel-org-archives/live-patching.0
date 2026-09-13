Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42BE1D7E5C
	for <live-patching@vger.kernel.org>; Sun, 13 Sep 2026 02:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789267402; cv=none; b=EILEvmd2MfFJjOow7dzEPdAl/09lir49WXBLbHlaquON3HYq/0iMoH67xZmaW4mGxnP9+igjPYiCPNQgl5ovoZzwLKvYPjqEDlHJ8W1zNCW0c0ve54J28vON9ZWC7M2zatxJPYT1P/jdJuudsFv9A5+bgCRVbxh0WyI8AeraP08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789267402; c=relaxed/simple;
	bh=iiL28SUO2mY4taZkG0YRiXZxQc7LKFG27IMlfjMGXAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T7RSRAmKIZj+WGvoWi7s+KutKmDtr1KlmoiOIRHCDs3LQ/zpDcM79PM9uBJx/drP+9UYk5gZRTwjoxjYvukV5OBUQseAHdLdb7DkdBP9TrmrlHpgWMgbWAeA6bzNELb32LVMNQs9Ye4SPQXx3JjMJ8Q7ZKvzFBhrU98dA+Ap9eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o3BUIEHF; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o3BUIEHF"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-381b831d535so4174562a91.0
        for <live-patching@vger.kernel.org>; Sat, 12 Sep 2026 19:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789267400; x=1789872200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DJkYz2mx0NoqY3hOX7fVHlRh9iFKQSnWueTSB7O14lI=;
        b=o3BUIEHFzzS8D4LSo43u3kQAsuLfpPeZOJmqEll8W3FNgWDmjtdD3V72A9drK31xyS
         Z83lxhqSLmUvvsYZzzqYyda+mnSkPM8HVd/mbI9t2w92c0BYAHYY0ic6L8spQYXMHKkt
         AGkYZ7/ixch6vHUeH0+4g466KcAijB4OEF1ka4RD7UheFwYAycOvUzv5PQVVg8juCURC
         OyZ+RV3jQEZOyCKyFzgdURAHzgC4jwxcdjtZeFKo9NsUnFUnCJQHjPb+ihXz4RsluHo8
         TdaQe+0DeimfJcvcN/QNsaYsHE1yAHuLtX+MXz3WSi49UVQ80ombURFelrzNeEl0/xE7
         wBxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789267400; x=1789872200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DJkYz2mx0NoqY3hOX7fVHlRh9iFKQSnWueTSB7O14lI=;
        b=VfA/mcksjSpDGJrslH15yENc5214GOvPlpiFu3pCIuO40LcAVb+ui+w5ZfUVQT5MT0
         IEF7X1TmhYQmrAKh3u09a1Av6MR121qNXaPCgWH9E+VdO1vy49W8q4M4FXRMFpkg59AW
         KLgKlFrxCibc7BRqfFQhkUzv/wktoxNamFv+WmVCg7QpIC8w7LqZZquPeWGkjZGuFWAx
         1/Il0BnxS4aPcACCswqaAxx02eFKH3u/q66Y0sR8rYG3zMJqpTfOS5GmSaNSjAyjAADh
         vf5ltMUTa97cD0/yiM8lMTMGABjv65rA8tOrXIisxkuogauyYhiCOKBjQ9BRon/gR/nP
         Ze0g==
X-Gm-Message-State: AFuF++lfcdXdjUtUV5SdUqEo92Bz8eZt1Cu67LC96uwhtNt4/R/dZbW6
	8aVCNLilWmC84m0QE5d2a0+1mIpDYGaEYcpvWasbuDGJm6TmA3B06ydH
X-Gm-Gg: AYBFou3XgjME0cT80km8ZecB1hmOdIqBN535rYGvA1SvxXFShNvIqlA3IRXI2HHgIBp
	lwFNc3b2N9ICRpyIRJ6tqr4cBN5FZjf+03ypP2Pe5mN3NB/1c2yCurhsU5VU3GGJOjU6lD6NR52
	2zSkCxS24ztTo3xkMqA0CvdDGz1+dgjgP3XC+FXIIS9XfKP9YxbtXAWXl/gfFaZHUQQOmVt3qud
	jz1SEpZ7n5lpd0VGvjiuR9MNtJja8EWMnQypQJyT+6XdMqESPy+1d86BIWSILanEfYqwK1wBI8v
	v5TGdIu7SPE9Von69XbwiPyB1ylWAtzHiue6Ris6rpB06qtrvbXu36LbXs9DMyuV5sc+qXec+BO
	PxOuzd7BuQoLQuPz0HbVLzMgHrkQTF3iy0Tm0LDCCcnL2f8ZmNhGIb7IeH9iROj0GnFSznnwQUS
	AoxDTACPqIXtO6He6KFPeTIiPpKLEztabopema5mFiqaBA0muKI1Ld7t0aptehsyfK7iRRYi0nu
	QfhOdfauRBWPgBQgwUD96HORRam6+xcqt71NrpPaNdyRLdlKC7GlFrS3u/2IpzoIqcB9Q==
X-Received: by 2002:a17:90b:280e:b0:395:5eec:b932 with SMTP id 98e67ed59e1d1-39d9beb7248mr20658608a91.11.1789267400276;
        Sat, 12 Sep 2026 19:43:20 -0700 (PDT)
Received: from localhost.localdomain ([240e:46d:2000:1e66:594b:84e9:394f:396d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d994cc978sm12730756a91.9.2026.09.12.19.43.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 12 Sep 2026 19:43:19 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	song@kernel.org
Cc: live-patching@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v9 4/9] livepatch: Call klp_init_patch_early() earlier
Date: Sun, 13 Sep 2026 10:42:23 +0800
Message-ID: <20260913024228.72317-5-laoar.shao@gmail.com>
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

