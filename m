Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793021848;
	b=CGQcD6mJhcvSKv5zMd02j2GsEcriXQQw/8c46khuEHrSuUA/L1ArT/l5+M96DoPfRuhB
	 hHpLwChpC7a2QdkaPQ4Ln0dSz4rH3CK+YhKzmfGMANnI1OeN75dv542h46a2EsnIQ9aHI
	 wj3/rfKPzxhY5pJPI/4nMk0BW9VD6mlNJEoDgxlaIPGuQC+FMHw7Z+18Nh5scqueLC6JK
	 K8INna2nT1LmeVFrzV0rd/HFBQraN2azbkvi3QQXB1mFAFxz+vI+OrVmyf6RDaJztigEI
	 /bQCG95MCdcGgxkfhaDZoPxUn3Gg8f8r9M6IcYy0TACToKaUqr6uw8bMrYWifgaTBrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793021848;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5/nDEjYNgzKRTDu0EMcZtv3+LL0G8CbjHSauZYoB2v8=;
	b=KvbXhrfST8+cvV5or2Wsr2CjcMfssJhoGTNLHTzbRdZvvM72KmqxyWeWjyx7r3YZ+XCJ
	 lTDVeCvIG0L6Gjwxzy8vyC2ABgwIQWXznML5AEDDwWMe6FVjASYXVcExYcLXhjl9tHEkt
	 RxmMSpqcZqUSNS2AmsOEIyggT1WPWQMgZfsGcpNGEOr909H4FYBu9Hl9JMVM0T0bXHCyC
	 tbUSB4v2V4+tDFT/k9I3aasbWUX2kEMqqN2D6zE4SZiVANlX8/DfElsFyBRaXXPz2bxuu
	 I0LV4kKsxPh/oVaiEYlH4EG6wIBVn7l28srFTMElK+Xc1/FQF/AMkDGDNJ5xrhTVAtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=c+k62WVc;
	arc=none smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8AE606A32C
	for <live-patching@vger.kernel.org>; Mon, 26 Oct 2026 13:37:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE8AE606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=c+k62WVc
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2e9d1114320so22798565ad.3
        for <live-patching@vger.kernel.org>; Mon, 26 Oct 2026 06:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793021847; x=1793626647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5/nDEjYNgzKRTDu0EMcZtv3+LL0G8CbjHSauZYoB2v8=;
        b=c+k62WVcM2EQidn0PH9A8dwqGTw3K3bRtvDZEDgP3V7ABXDe7UsOiG4QMTrfKDzl+n
         T/Xtp2A1P3L3fYQlVncj0ZiAEjOTZKjN7rhxBN0C3hmZ6CgEsEVR8HdvDzWm1MZv7brn
         yLsojyQbtA3aeVFLdk/1RzAi8SAYHT0+oAju07FYm/Y2bsrDg1RuUY01C1eFxqSU6NCX
         kEAYDya1FOjjzyz+pDiZ0vLS4eqf4Q1pjhnAEhAtsrmTRH4KvLHhOI96WWjSLpa6ZLQB
         6fpYBxzI7Bc72jZs6aYVlt87KYgyynTJlwlCKxMLR/Vz2M7Zj/jT+b11lQeJ9bdNtLXh
         nQxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793021847; x=1793626647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5/nDEjYNgzKRTDu0EMcZtv3+LL0G8CbjHSauZYoB2v8=;
        b=qbwaVUG8gR8qGjuwPuLnXdZpndbij6+SrX5KIsXPEayaHUmdBRvoxx3vthIhDw+f1D
         Wo5oXBX+1QX408hmpofzrKdkca6jO/YC+G0A4w8nDGWXcYvWt2lBT+h1Ls7FuzQ4tZ9L
         9bADOn2YzA5APR8vakTF5qO9M7ZmVM8ziEPoQdHhySiZQ7vZDVxbLEsxrfT7/UqxJF90
         iOlpnJdMDxc7GezTl6T3SpML/oW7I3rnPgVv73yZlSneILsxjNkK+AHnPK31fON1p8KH
         dnbJ8GJBWdS3ibUDeuth+Isx4vD3td5Ioiv3vTxumpizeavIeqBVc+tNMnSxDEgxtgJ6
         Hxfg==
X-Gm-Message-State: AFq9FYIhnrPYDagr0mm0jp2d0vduSxf/km44oJ7KhiLNjoIwgVfKR+3r
	VpCqXB0vTPXRcUS9WnFi7b5HgvF54K5GaGaqo7lKZBQEfjn6TwlU/9wn
X-Gm-Gg: AYBFou2Sq5Lvpg+p7xGfK6jHZ0XxNafwYI/q1r56PfMHCgf+vmzYFfnIzK0qkHSPc4E
	TNMWijnJ/V+QpRzuheFvpU9OYB5iHfiauKptQ/PVWYTJEHiZ6VimAkVziehfN2nkUcOPF1ff7Wi
	H3mGw336LD3GK9ULL7H2jDcRLzT0QY0nQhOGWAPJsgCJ9Sq82oqc/dDzE2CSBMGkh7phR8Rn7NK
	1eba9f5B9oxfpoUWFfNdW8nlB0+69K5O9TWrtg82CGUob7iRrSDhzLt50W11YLDXoRo5iHlcP0N
	PesNO0dnsRIH3AYcHMnaBUyBO2YG/A7Avy8jkTUTybhRCXC/+nuYavTHjS0s5906Vfg/WrHRchi
	wQfbTTFN8RvGWZJsMxWHwgEHWYm3ekjdq/+HjKdUVzn0BT2rqezaUI116cdYTw+RV98Mv/brhtX
	k04cujR7mVYzmGTUTIfFdEx9SpC4fVCuLNtVFj0VuosN8WruIUNlJxFKm9+rPPy6Tpwt41z1a7S
	M797jXWUmP16gQpGOTaEeMihchVDQXoqub3Mmk2w3g6rqv3SBDCDEVoOwzlq2eo6XK6jnrLB06c
	k7DU1ea3GZQ9FDPsfp6W6Bq3z6uqQITtIG73aDY=
X-Received: by 2002:a17:903:2c0e:b0:2e6:1c21:158d with SMTP id d9443c01a7336-2ea9c80fc23mr67941085ad.50.1793021847107;
        Mon, 26 Oct 2026 06:37:27 -0700 (PDT)
Received: from yafangs-Air ([240e:46d:2600:484d:51ee:4f49:b5a8:aabd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea9b1a5cf0sm17447055ad.52.2026.10.26.06.37.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 26 Oct 2026 06:37:26 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: jpoimboe@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	song@kernel.org
Cc: live-patching@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v13 3/9] livepatch: Make klp_find_func() non static
Date: Mon, 26 Oct 2026 21:36:45 +0800
Message-ID: <20261026133651.40061-4-laoar.shao@gmail.com>
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

Make klp_find_func() non static to allow its use in other source files
by an upcoming patch.

While at it, rename the parameter @old_func to @func to better reflect
its generic purpose.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Acked-by: Song Liu <song@kernel.org>
Acked-by: Miroslav Benes <mbenes@suse.cz>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Tested-by: Petr Mladek <pmladek@suse.com>
---
 kernel/livepatch/core.c | 18 +++++++++---------
 kernel/livepatch/core.h |  1 +
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index 517fe42..9d25685 100644
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
+		    (obj_func->old_sympos == func->old_sympos ||
+		     (obj_func->old_sympos == 0 && func->old_sympos == 1) ||
+		     (obj_func->old_sympos == 1 && func->old_sympos == 0))) {
+			return obj_func;
 		}
 	}
 
diff --git a/kernel/livepatch/core.h b/kernel/livepatch/core.h
index 38209c7..361a091 100644
--- a/kernel/livepatch/core.h
+++ b/kernel/livepatch/core.h
@@ -17,6 +17,7 @@
 void klp_free_replaced_patches_async(struct klp_patch *new_patch);
 void klp_unpatch_replaced_patches(struct klp_patch *new_patch);
 void klp_discard_nops(struct klp_patch *new_patch);
+struct klp_func *klp_find_func(struct klp_object *obj, struct klp_func *func);
 
 static inline bool klp_is_object_loaded(struct klp_object *obj)
 {
-- 
1.8.3.1

