Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D5D2FB084
	for <live-patching@vger.kernel.org>; Sun, 16 Aug 2026 09:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786871099; cv=none; b=h3hBmXnmZRZ4woTvSYrM5YrHXUURxOuPRj3TPNmpRIT56q767o7AzvsQxbYITylimZyGoBdaOvqrGZcS/Ti9v3Ucg4VVYfwN1jkSGcQX2tz90iKvF/geSXkwvY6kMJeCVVVF37ZuTqsw9ATGDc/AUJcOzZ8eq6/3zoKPI4alVQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786871099; c=relaxed/simple;
	bh=qPrwKtlBo6GrPO/BNpbGXe2PrNNi4fXGOuW1g2MBWbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sNJiAe+WfDoeER32H5zAi3a2LeyTIu80GLQtAYiZUI8EfzLJ0aGGozk5KQOhN/xcdRBPStetnhgPgcAMIuZ35zkeCxsMvxNzjNgpW5lDh7xeNjIvv1UZZZ5BXUaQGlGt0lqaGTgqlDVvICk8QeUh83Kh6GQ95lePSQZgpuTxwgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YRre+Uh9; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YRre+Uh9"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cf27856f9cso22104825ad.2
        for <live-patching@vger.kernel.org>; Sun, 16 Aug 2026 02:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786871097; x=1787475897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h4GbmyXvIcXf11nUAXfV70jbM7k61bSzJfYo3rDpJiE=;
        b=YRre+Uh9ZTHTtNyBjKJ296977+OnJCPojCZg3GebN2mDt8p5krIDazWusupOmmPZoW
         bpfIRF/OicUVC7E6pdNs5ciGej2DMIlulq5DQ2r7IjdzOzj2Poo+FyZvG3UucUjMsz0X
         xtJul91+8q76Wauxz6XRYNZwB8XsG2JZhmTxZgF+RHAy8M8+z8siXN8W0FWDFIMq/Wsv
         CLRHcBmCnhI+IPrcFkvxQiI6Hg1sGfulkaSVdfJf8PmU55/SnP/sAeRZQ1ZYbyQuiB0h
         KnTvLUD+07rMLPzlfSk1/umzcWkkmMZDb3lIDXswqobe1+OsyNopTU/dGAPwSFbMwRQz
         DJmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786871097; x=1787475897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=h4GbmyXvIcXf11nUAXfV70jbM7k61bSzJfYo3rDpJiE=;
        b=WQ+VCORK6FjZU+0i/i5uP1+kD4k0Apem3BFkTw30B9nzn+3Kx2bkiqOTGdjQ41r5Wb
         J9hAwPxgomLmx2vicvI7Ol9T2Dux2cAfXRqJ7DdSLWWZAM/5+IHoqZof9OnaHi6rDoKY
         6kgmKbhbPsTaV7Lb3kHd0JU/wZLDZ2XItbxAVmsyb4P6jczA2s6eWZW+mfZBeQC1H0Cm
         IJPNyW5i92WwflclmoDQyuZr//lLSqT9RuSexXze8OLA59ZSeDW85sv4Ff0K2XEnkEJk
         zT3BNRIyhh/Z0AmWTiCrZ6aB5FnOTlq0v5iXcsmz5x2dpeWa9tyxGDR6nDUdTABSMSwg
         POXQ==
X-Gm-Message-State: AOJu0Yznk1J10PtsLE6YiNyCtitb9XXWWRlRKdLg2uzvHkGqk+kN4ed/
	wrTaq2ODv5CRILXRpJnNpaI2pvbR+JCO/6mltxzdY5smyzTTNMfdfXLp
X-Gm-Gg: AR+sD11zIqnwJ8GiQTSy2O5QwcrdUE/o1b20nVhmyM8TkT7QhqekMMSKZ7eLZtxsB/i
	aZvAWigTbabhvrPGQOo5/Y+0mFC72PH0PHwPFlnpbhIC5SEpdiVAiDZ/em7QqAU6Syc3hjGAxKE
	we//94Q6tXmXsoXx1rDaxDqyFpVD6hKwE8ylwhT08o4LU9O8yEKwLY/IL69n2KaBA7SiX9rvS4a
	nULab6WgfvpVE2vDZ9b1TYf3bvioQkoiT7MI6QVkltynHhHnzbCmPh6HdpERwECLw210HxZCJTg
	Bo5+1J7v9c19airwe3kismyEd0sahdOHhoiudCz1aJrtpDL2Yn3qKd7UHqaZ/2/2uOstaW4Txja
	9ALPXqubF/fvI7JHl++PPSwPt2Bq9sQ7aflONujE5mqJ1C2BNd1CydFv5mjSv/E2g5EabIoIadp
	3aygYcj3GWNcXP/LkNULubgVFX9Dh6PPAfjR0VGZqBDOVOKtnscgtZqxWMk7uKlYUfzVX6UqrAi
	DVTulPpmsD2l1ce0gPPXh3zb/vni0sdMDpxLzu0ctMgOQ==
X-Received: by 2002:a17:902:d4c5:b0:2cf:8131:75e8 with SMTP id d9443c01a7336-2d3b0c813f6mr185286375ad.13.1786871097075;
        Sun, 16 Aug 2026 02:04:57 -0700 (PDT)
Received: from yafangs-Air ([240e:46d:2100:4077:60c3:e9ee:3774:36cb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d3aeb8869asm24466485ad.60.2026.08.16.02.04.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 16 Aug 2026 02:04:56 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	song@kernel.org
Cc: live-patching@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v2 1/2] livepatch: Fix wrong index in funcs cleanup error path
Date: Sun, 16 Aug 2026 17:04:41 +0800
Message-ID: <20260816090442.18128-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260816090442.18128-1-laoar.shao@gmail.com>
References: <20260816090442.18128-1-laoar.shao@gmail.com>
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

Fixes: 59adee07b568 ("livepatch/klp-build: Add stub init code for livepatch modules")
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Acked-by: Song Liu <song@kernel.org>
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

