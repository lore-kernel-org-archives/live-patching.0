Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C26351C20
	for <live-patching@vger.kernel.org>; Sun,  9 Aug 2026 09:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786267213; cv=none; b=E3okyGKZBH1jTAXkq6bYgF7FNMn2JQqff3kch1PEwNRcPoZVcWD9r+2LUoepoYpDoXnTrcWjovZThFQwgKHmXgugJNy5iQm1YjGO875btNazY2Gyv8U7lU6MdkpiZyufUPX9kVIMKyrdk9yFRew44O2WzPS2a4wA2RZMp21T//0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786267213; c=relaxed/simple;
	bh=j3/7rLliBgFjbFKrdSTVw6H4oQDM2ynLMr7Or4M3HGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NTgPUkTYRz6aqqaaEyzzUXqmvKyaaLfdxSZZ+iglL6mS3a4rtfxXMiw0kJHjY0w64jpCdEyrvVnYw6wBrGR5JV6pt6HTexGJjc+L5NXDDKeiOpDF8Hj2/XfNcrYBl778ztTUWvCEJaM6X/NU6/6WIj8RrP5AuYwkn4kaCujm+VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LDbrtT+X; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LDbrtT+X"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38dc69c74b8so852347a91.0
        for <live-patching@vger.kernel.org>; Sun, 09 Aug 2026 02:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786267212; x=1786872012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vkqUWdMQnV7i9tWVmHI0YkaUym+jZSi2oSsA+jIqy2E=;
        b=LDbrtT+XQtiKwfLD6eFsIhAo9nAy2wwe3WDK32q+To2FSS0QActmApggQmlv0Dz0Ox
         yEpkP1ZGC22h1dUL1gJEI4AtA/9u00x1MKQzDVbX2OyFvRddHsdmMNtRIbvEfxChcg/6
         dOFf/BS4pqjAktpJiduny0xpTs9WBykno+FR6TsOyB8QTCcE6FQWE+qsLlrhZcWnJJuK
         7exQrmpo27cEP9MLNrTq2e3R5RrHPYBKmlylu/PwYV5HeOy3MDDonvilLTySRqBTPJPF
         SXIAMIj5XKXx8HZICVjI6dQtXOouokAZA82sZ1xRn8CDk/ucgOy5xkOMuN8tub4HwbIB
         wilg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786267212; x=1786872012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vkqUWdMQnV7i9tWVmHI0YkaUym+jZSi2oSsA+jIqy2E=;
        b=rPMND+gn/IaNObn+9+qmIymT98s7o+5Knqexx8asRVwukyjzXnPc8zzC7mIKJCZWr/
         lCLoeAwSrc885QICHbp6mb9/D5WbyZmY6tcosi1DqF82cfZu1PvXGb5efEe7v4u4oZ+/
         vu9lDtGi5kyGbPav5oaikRs6xatYlU8aAZMg9ZesRCY21hHNWcTD1VoR+jvqB0hCMHp9
         zfV71VE99nErHbujXp2GlHCzOOlgIdHv20w5oqLoYlSWtsbecioda1eE/jEBDuh2A9Dc
         VitP9rPDenPo1oXKHR1qZOh6eTaaUw4qnawqCJgOrE66iOyujF3JhKi9dPGAr1ThTJnz
         wNcg==
X-Gm-Message-State: AOJu0YxVYnRviWsJ2IEwHj6jW1xLSiNG8YuGYrpAyp0Nm52VBUwlpbMy
	GpzwLmgY8U3wnkBIzCwHUMI7fjtckr8hCorEKuZc/+h5ltdxZnU6PQ9hQRQZ7yoj50NcXA==
X-Gm-Gg: AR+sD113yeCt2CyM+U5i1OCW2h0OdgujpzONX4aVAA0YgxUGRoz7uKl3zZAeizk29WY
	/c+g/K3gRY1Mh74l9PBzVqgPDTOockXDOJNE9Vk6vn1ukAIxtDx4tgtnLbG3RAENvxx+/rQ8VVY
	CDhpo5Qp3wgora/7nV0Q/uSAjd+xGyBQoNNuk6nwB9eSPvhE86bmv2AQp7ypkKA+U282i5Gta6n
	IzSBmKjGWQsJGoTjquhqc6Ls/IEl+7SZxmvhvqiVsw3wB9QxkkHW0euSFr5zhNhmi1tYznE0Am3
	aP85fo2bG2MN069w97sgeYn3zxSuPRW6AaBzQhRSLtf4zzFgwB0WsuIeunWuwo2dZHVRIO4wjXF
	pzLe396uTCNAo/LMMu8cQAv6tTuPWTXMYycEqjR7f9B9/WBYTt6YRMZInzwHq9TNk+Ks7+c9KFW
	Z7DCV7TV5y2+vmL8n6NsZw154nNVuVdmVjxYwojPOVbATppTamzkeyNSJp5YdfIksUFOtB9n4R/
	c/HnPQurIkRoYDc3lNTxL1vbjMven3U4ba5jS1VSZruUNs2/uy50Q3xeu0w1Ea+HLO1
X-Received: by 2002:a17:90a:ec8e:b0:37f:be6c:f3f2 with SMTP id 98e67ed59e1d1-3903c53827bmr37609416a91.2.1786267211967;
        Sun, 09 Aug 2026 02:20:11 -0700 (PDT)
Received: from localhost.localdomain ([240e:46e:ac00:14bc:74c9:c78:94a0:c446])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3908616d21esm11241281a91.17.2026.08.09.02.20.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 09 Aug 2026 02:20:11 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	song@kernel.org
Cc: live-patching@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v5 1/9] livepatch: Fix wrong index in funcs cleanup error path
Date: Sun,  9 Aug 2026 17:19:45 +0800
Message-ID: <20260809091954.22930-2-laoar.shao@gmail.com>
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

In the object allocation loop, when kzalloc() for funcs fails, the
cleanup loop uses `objs[i].funcs` instead of `objs[j].funcs`. Since
`objs[i].funcs` is still NULL at that point, it repeatedly calls
kfree(NULL) and leaks all previously allocated funcs arrays.
Fix by using the correct loop variable `j`.

Fixes: 59adee07b568 ("livepatch/klp-build: Add stub init code for livepatch modules")
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 scripts/livepatch/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/livepatch/init.c b/scripts/livepatch/init.c
index f14d8c8fb35f..16aff8f736eb 100644
--- a/scripts/livepatch/init.c
+++ b/scripts/livepatch/init.c
@@ -51,7 +51,7 @@ static int __init livepatch_mod_init(void)
 		if (!funcs) {
 			ret = -ENOMEM;
 			for (int j = 0; j < i; j++)
-				kfree(objs[i].funcs);
+				kfree(objs[j].funcs);
 			goto err_free_objs;
 		}
 
-- 
2.52.0

