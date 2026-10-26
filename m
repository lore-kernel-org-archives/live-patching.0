Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793021853;
	b=KYSOf7e4TA3xYZUrvWZfE+PBsYD/1xumA4/sYzJoOwEzkdK9t21pmMtJ+QOIBhOTmW6z
	 fyC6+5OZnjR56+ckXFcIdnuMACUNezFZYBAlgrgQ2tJ8fMeLOm57IQR5/d8yHbqOap78H
	 P9Vsd2DFgozO/tXUregP2qUkecUscc3E6CoiAs7p2F1oWPsDhnT5muPxAySznkCMpSocM
	 rzZk1QtsuTotD1Ejd31wFSsDzvg/uRbzW/z+pmX5wQLwtBJdGxMIyqroagl32X4T9xT4G
	 Dg+HNAJBDereZI4AP4ps575hJrOu7lJ6LcTVBenKWv0/+aVHy3drEI8w3dpqCHUDpVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793021853;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=nBY1mmCwepedk2iyITEBFuHFNNd7QJHmRZc1xMAKEUQ=;
	b=inA0w3r3MqN8XsIUdGZMMOQT14usf7JuNLUtGmBYS49UYZEb4h0XFz4u+BOSXW5+YJdg
	 2jYPv8kW1Cpo9WxpzjtY4gWAhfa5evDo2JAybhaeHZgu0+WWDShMqY8aXSeGtFYQDVj0+
	 4jsRXiE2Sjc8sPFxKnPK63lXYDHSTQ65Dg+La+y4WHbGKY1R35YSKzFQETh5sKOxVa9PT
	 7yN2jjV+nEdyor/x3m+sLgPL4H+z+Xaf4iDvAUbkrMTVfPQpamuHFRqLVhVTTUr92HPOZ
	 9qnuWMEigj4hMxgBunpJLIRAAaiEzL8vXjuZnZq3yXFh3Iu2gOo+Q33kFiqMRGrhkQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AzhIqonQ;
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBF560A261D
	for <live-patching@vger.kernel.org>; Mon, 26 Oct 2026 13:37:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3EBF560A261D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AzhIqonQ
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e985106c0cso25568665ad.2
        for <live-patching@vger.kernel.org>; Mon, 26 Oct 2026 06:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793021853; x=1793626653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nBY1mmCwepedk2iyITEBFuHFNNd7QJHmRZc1xMAKEUQ=;
        b=AzhIqonQL5Uz86TyKnTmu0FB0HM0uW4V7dOpLLwi3iM0SwtC3kaTVxq9rRL0fzec+k
         sFY23eSRJ8JAptFl6fqJ1+tUdlhkmVpoMshX8RebnNCU89+6QKFtets1ud0IVrI9udwJ
         keGhbdwFhwdA4pxUvLW3b/rhSFp9Kdz9bcdbJOHM2DljAycRkyX2lUoSHTq1T3cWdvoW
         fxtlNizoqrdaUxCpvKdLpnrxa+weP6Hd6q1i1J+uendBjvcUrNvh0lqexZIWc7j16QDB
         xOi3EIS3YA1mhNPDw5e9EsuJ+JRlTni2Zbv7N0/1xSnWiDSfEvG/ZjcW2uMbIt5PNnti
         7fRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793021853; x=1793626653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nBY1mmCwepedk2iyITEBFuHFNNd7QJHmRZc1xMAKEUQ=;
        b=dNDcKMkSFo8t8VNdufybK0bgIVW2Jc4ItI7L/Kd+atjqX+pdsNnJ/kkV9KLM86Kz24
         1mKqKNSe6EV5FVLfFVeEPBRtCp0C1dB7VB0C23nI7Z4CqAFUsEbD/fBlrQBmQbzpCJvZ
         kDDV8spOvMcYwlip+4hQpzh20C+P7OiOZUZiqFEoCT05Bc40yHL3v2gcNc7zd6RJzT1r
         sdCRuJT8Y9DGIpVgKrq0cKMiyS8rDkWqHnurvBSAw0Hq6jsgDRmK49+Ub/59w6cKo4FV
         8bL9ncyuXiItNQq4DxVYZaaQV7jGgW7S6t4fga3CALnTXtAHRg1nynqVlp66g2szPn7m
         3PGg==
X-Gm-Message-State: AFq9FYJIZ/UNI1rcH5F6dSSWOWKkS8IQTRl2HC8t3v0gjt4qHF7OP8ve
	lzz2z2P8tyhkoM0YueLOdb0Njq+2uMsu9M1ybSnsEYkQdmgR0+XftBZN
X-Gm-Gg: AYBFou2qWLn/f9SqvzzwGbQiZIr1r9dh6yZHn2rSRMptY64vpQBQEwZHWlvHISxZlAf
	zwbST4LKC60U9OKgToTVq14rEpFqyVpdv5eVBRrZ1KYcrvv/wpy2d8b0b2tQKL2/bq85NNxXInf
	ZUS7UYOwuLahj/7+0oOdyPrWYU0X+0osGcP3oKb5XGaec1u8Ybjk3xN5LFXPxAPz4M/z978igwq
	z1Lqe8mnFYMyXv0h+t0dqCpHjIOna6eHVPmNXBP0BtQUwCRWa7UBcHIyHoCkh8OmuiUjihF95VD
	/eHSDxB7Xct9NQtyu2bT2ulEpZeF2FUA0YrIXN8e7Lg9MS+5hKGkVQllHuhy9C1MZViaP8vjlI/
	NXJzDCs3u67OEss10TI+f9y7XFj4tXb99U7CFzXp6KpkEI6F4jct1Ro0Il8gUFmI3Z4unGOJaSe
	z03AW6FWcIJYoG4KVkeO189s8eyytvUuraQpoPMu1PjsLXyxBmJyrY25R7UacurlH6pZPCdrq5z
	HUx/R6dQkuC2bl5LC/g86sZQ6hYGcBBDvcJ6wkWTlVdr6Y8UqE9Xsz3tZurwtiYXIYJh98jduIA
	/2mUTZLzH0lpOQYFOQY0HbIukgwVibcwFPDqyxdBxDkSLfOu9ctJ2PVIIls=
X-Received: by 2002:a17:903:2c0e:b0:2e2:c995:b00a with SMTP id d9443c01a7336-2ea9c83f0acmr63903965ad.48.1793021852505;
        Mon, 26 Oct 2026 06:37:32 -0700 (PDT)
Received: from yafangs-Air ([240e:46d:2600:484d:51ee:4f49:b5a8:aabd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea9b1a5cf0sm17447055ad.52.2026.10.26.06.37.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 26 Oct 2026 06:37:31 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: jpoimboe@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	song@kernel.org
Cc: live-patching@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v13 4/9] livepatch: Call klp_init_patch_early() earlier
Date: Mon, 26 Oct 2026 21:36:46 +0800
Message-ID: <20261026133651.40061-5-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261026133651.40061-1-laoar.shao@gmail.com>
References: <20261026133651.40061-1-laoar.shao@gmail.com>
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Invoke klp_init_patch_early() during early initialization to avoid
mixing for_each_() and for_each_*_static() variants later in the code.

No functional change. This prepares the code for an upcoming patch.

Suggested-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Acked-by: Song Liu <song@kernel.org>
Acked-by: Miroslav Benes <mbenes@suse.cz>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/livepatch/core.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index 9d25685..7240e72 100644
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
+		       patch->mod->name);
+		ret = -EINVAL;
+		goto err;
+	}
+
 	ret = klp_init_patch(patch);
 	if (ret)
 		goto err;
-- 
1.8.3.1

