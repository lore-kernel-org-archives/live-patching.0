Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3F6386424
	for <live-patching@vger.kernel.org>; Tue, 25 Aug 2026 11:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787658428; cv=none; b=V1Ts1vKc8DQj3Hh+yLK7nEipeEHlWNwgJb8bia8ZIHOojeP4dicveeBtmfquLj56tV1iC1kCoPIQVmlnElR6PKrAgVs0FDZGHF+RsNVRck+VQKVnMKwbmM6jAnJxuC1CZQDNfUWaM1PXX5tL2OEzkInvT15qaiuXZ2wAAnQOBTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787658428; c=relaxed/simple;
	bh=fgN7dZonxrIMkBOWwONZRHkuNFzLRzs0/u8JpaWaOSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ko57TnzQ/504sGN9dhloJ1Id42CDjaFzjXy1C5risGNmwELxB+wBkO6vgaRnBgSRcV3UI4DrrmoxMOGGcAWW8Vk5oZU0OStfGYZEghXb2j6vegCLPwlSLQcmn5VqqLpjw44wmvuTJUc/XlU3IXNOqmwcIAYg9iCuw2EmIrFLwRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gFxlZufE; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gFxlZufE"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-ca766c1c9ccso3187208a12.0
        for <live-patching@vger.kernel.org>; Tue, 25 Aug 2026 04:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787658426; x=1788263226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4+hymES8NhMtFP+RTp188DxvtdKdq/r7+MzYyMf69xI=;
        b=gFxlZufEl3KcnCkIJt1G2LHZ8FOGR7tN9Oh6w6ob1sQAQ+16O8zIjD3JJqe9F3uI9a
         HUFC7H7oG2iuUNq5n0x0Bn9+VLFDBNYtfhF+NQeWm1WX0McRUtKmRENUcQlTSlZq1r5s
         TGgMWKze955OLeNtOMzDr6ZtKIUSgrP2BXlbqiRyDWOwzHSksY+6wnJ+Dbp3guw86291
         xrKIzfwP1mXH5lAPT8V0GzX/4WvpnguMbS7qpXGl9PMAcvkX9IjeEDRcTaaeNUhyLpm8
         M3KR6+rWT3dyvsSuMeIhUJg5JjbbhgWMOpFQRUA7FvUHUdoDxq7+g4vrUeIl1LWXlAwU
         FDUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787658426; x=1788263226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4+hymES8NhMtFP+RTp188DxvtdKdq/r7+MzYyMf69xI=;
        b=ruQPaNdqEdhEVj4G0gH9zrTYQ0jQ36+eiurCZCB36wm1Ip4uiN3/ddh0snRHVas4g8
         MLBgGnA8DQ9HvLGY7cgmz3pnQ89jFoYe26PZbxCINAsNEah8+dIl5mocUdoi1mm4D6VO
         3KrQ0ClTUW0GFfYq3YhWFEW75MoUTjRQmkkZZE/LMhBF8BKqrGUlGO9Yo0/EsJY8WFmS
         LQD6PVVN86XAanh/6ZJ8JHoopKsbzNjwrT3SlWUyLAm71vRr7Jym1Zl17IafV5OAJaeu
         Vm467XzHoKP6AV0dGz0kzTSTP4Kgd4BgSURqed4qss/gnix/3KwUHYmCFuVUCJNi8clE
         y3XA==
X-Gm-Message-State: AFuF++mIMmZj0MrTTLkjj8DCQ90DPhneBzxQKPruT0Ouf8YNnw9H/AbB
	xqqbDtofbJeUsTB1u6Z3oOsbNY5TTQDzJtM3PCyxdDlJUG8l/ebggRQF
X-Gm-Gg: AR+sD11A6t82rX+jU4ksgzgGzfSBhCvMDKbDmsnCpup/2MIK5nZA3k08aNyf3+vHRKQ
	SRHmAkarosiJDFdfYTISSdBzxj+u5D3h4d4nVsUd/2kYolokFdiGJsjjlOp0et7y0JZ+pHyiKI2
	+URDM6Wtlm6Vocvg3fwDkYccRay1my/qLiKLafdP//p/jFRLFaPazo0b86gRl8Q8eQdnHtH2qlO
	DhozB9HftREpMjpTFqt6yZyfKWUuR+rBBE15KyN6Dyob4IUFXHJNuxmqP2MZCfVckTWZj6hWDD6
	c9S6ENMsSWhFNnEjFO6yTPW50ggrbqoqKbH0icu8mb/8LnB4WeSA5Mkrw2wWbidtfegpBt08/q3
	l2ARB5HA9nrxoCJ5uZDQiZ7Oy048R47xcaYHQi9tr1UWPLVrzh4dTmvoniyHQmatTQlupKjm70J
	CfpRQ1M+jyD1o3/OZexZqxoXf0PEW7eCqajzai+fr6EWu2QqFqBJOwU8pb434R8CwJprmGzRB94
	idl8n6JqwvLkFsWHFw6TrP3jOhO62N2+JyW6wyS2o8u1QpVVw==
X-Received: by 2002:a05:6a21:3293:b0:3cc:9618:f51a with SMTP id adf61e73a8af0-3cd4ba80d89mr42106054637.8.1787658426305;
        Tue, 25 Aug 2026 04:47:06 -0700 (PDT)
Received: from yafangs-Air ([240e:46e:1b00:ae5:3473:12aa:8e70:f95d])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc199e5fcaasm1864438a12.24.2026.08.25.04.47.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 25 Aug 2026 04:47:05 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	song@kernel.org
Cc: live-patching@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v7 for-next 2/8] livepatch: Call klp_init_patch_early() earlier
Date: Tue, 25 Aug 2026 19:46:35 +0800
Message-ID: <20260825114641.80452-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260825114641.80452-1-laoar.shao@gmail.com>
References: <20260825114641.80452-1-laoar.shao@gmail.com>
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
---
 kernel/livepatch/core.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index c34306ecfb0b..3de3940d34b2 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -1145,13 +1145,6 @@ int klp_enable_patch(struct klp_patch *patch)
 
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
@@ -1159,6 +1152,14 @@ int klp_enable_patch(struct klp_patch *patch)
 
 	klp_init_patch_early(patch);
 
+	if (!klp_is_patch_compatible(patch)) {
+		pr_err("Livepatch patch (%s) is not compatible with the already installed livepatches.\n",
+			patch->mod->name);
+		ret = -EINVAL;
+		goto err;
+	}
+
+
 	ret = klp_init_patch(patch);
 	if (ret)
 		goto err;
-- 
2.52.0

