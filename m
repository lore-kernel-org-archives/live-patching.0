Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792481251;
	b=z0ct+vp38a1cswQNS3xKGqb4dA2xN1BAi4aikCz45yr+kRXs2816dcz1e7qTp5fJ8vMW
	 o0pmGymEYTNMNnVqkD0PMC9ZHBVioIP2L9cFGRdjE/ZQ9P6yIgB5l3IKUvLWCIfKqBlMu
	 FMhjU1p7WDQkSFRk8qkCTeKFf5lVz3DXZPeaRyhKy/QONnlvYmXq6DM1WbyskoIJUDp5w
	 2UYVwpc9B0gI7ejYOu8GcmcjVW1rT2jtOoDfU915XOE6qgIuP7dWQ6kpPw7IkjMBE9cdq
	 93EG0asfMwk+nG5HLFIyMgW9zCpHzio8GCfotaKLQAVyzuEK+EoISRZV7vkR9U6BsJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792481251;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0zrJsy6+pFWfHViBKa8dcpiN0fO/uxJvY/CktxDW/j0=;
	b=1FA5icifjOb3c1tO7Hkm+bLbwCoF76TiPFUCHMJt58xRWskD6fDnlQbpCdM3dRLd13VP
	 yDdB4sE2Hef0KkvOJp3rDAe5A0MCms5H4S1Cg7mwMb+WamdB6Gfz6Kz48qa/G91hPmUXL
	 WwkmlUnj7bapwKFIxUewj/Bdtm5le2ZGF2JNYWIhJf3cu6l5+TvUt5WaE3ILEmhUzUDjV
	 rPL/u0aS9uutYKuppjVfFAdXIuZoWdUq0hXGbaXbff/WhmgIavyQgZDpmX8pvDwHJlhQu
	 u3nCZEZK1m6CdpNpKfHwGEpkuu7V+nei3vO+WQ9PbJwIg284ioc28qbMoGM9nPWibWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CAdKwYDi;
	arc=none smtp.remote-ip=74.125.229.6
Received: from mail-dy2-f6.google.com (mail-dy2-f6.google.com [74.125.229.6])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07963606A320
	for <live-patching@vger.kernel.org>; Tue, 20 Oct 2026 07:27:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07963606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CAdKwYDi
Received: by mail-dy2-f6.google.com with SMTP id 5a478bee46e88-3537dfdcabaso4669075eec.1
        for <live-patching@vger.kernel.org>; Tue, 20 Oct 2026 00:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792481249; x=1793086049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0zrJsy6+pFWfHViBKa8dcpiN0fO/uxJvY/CktxDW/j0=;
        b=CAdKwYDieH/mM+qs+HVjyvwmt4OrcxXllqKFOPPXkDeVV4qNhYTyqJMJcrQwaev7If
         BetT3yLcc5xRJCWCUInP5oLzcBjzH8t5mFlSvZbJipgfZfevw1yK9xuYiHZ8YtlGccz3
         VBJwK4la/A4r5uVjf+8/PO/LBlgWmKFMUn0j1kY7WHtiXbrG0gzyW4yH+8JFrfaN4pep
         fI/GRuIW9ieXiPv/elFHUYZucl3lun3Bp+5Tlb1SpF9KXmjHSNqhZteX5MvuGrTF1igI
         B1s27oEw6ht+c5uE3iBQoiur1u6G999iY7nN4Bnk2/6z08lgKZ6iVJ2G9+4dxJrQLTAL
         bsvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792481249; x=1793086049;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0zrJsy6+pFWfHViBKa8dcpiN0fO/uxJvY/CktxDW/j0=;
        b=z8MKjA2psxMkgCCF8lsgYWuBJ2+Fly1LAhLUYURnO4AMy5J0XrNnfd6RUbpuuXOfpm
         S5bpewxSU2stKkVIPV2wMBF+LHJ82Vvn+z7pzGLwEt5umoBcMoYphM0z1D8u2dEWgaJq
         bUoYYOt0aqn+zIR5Zqy41p9jHotTIgD1o8MG3OVd0C/4UPusi1ooo5+wocWVeHI9xVH6
         L5XRWvE7W68KTjpEmtUYAMF5I49IFVRMb8+Ge8U1oRc0jKegfndbAKnQpPP+puN2gU2R
         Uc5AhmfyF3ufTSa79NsF0PB98YnYarx0KQHpN8Xi20P1L+XogSgV7e/xyqEqlUUTCeUC
         h4Lw==
X-Forwarded-Encrypted: i=1; AKwUvByvbbc7njqsmbeP6V88eR+cLV+xt/KNV/dHf8m1n+HXSdZxm1Syzoy1TrngFum6+EnUdcRjpDE46aYS5ht7@vger.kernel.org
X-Gm-Message-State: AFq9FYJnEGDzJMLvikjRSfD7dL1GEvW5zaVXCwSqS7oznfxOIPA+P7Tt
	vmQMin+a9+egwg/9Lc9EKOUEIyLAOphgCr8wOrOVrh8gPL4DWX9nB87Z
X-Gm-Gg: AYBFou1uYEoqVfDnCMzSIPlPWTqA9x0O4wt+pFnGPd5bIi9CiBiSO5/oNV1Ujb151HW
	XAcVZDhIA9mdEGBr2+31ooJfPJwGEo5TsLZV60lf4j0NrvYTEHHds9cBUvdPXUdqfsIOh8a2CTM
	fNVyaXRdJPgUbsy6h6+4euaoODEaPTrb6YBTyrwkhIBAj4Frb7hK+JkLV/OggNVrVDQknitKqdj
	Ljs7S45cN3CWLpXWU6ZIB2ptpp7qBE8Ie81tw9Jp4GBmm3jgYTXEDuIxeJhRV4rwEek+EIjqA/Y
	JQrSLhl+D/vDRl7/2wP+EEtjIfeHboI6VBquI9RqQMh4uPSleALZEE2FdggsJQGvkQ7gPOgu7Nk
	FcwT8zWNUAGL3N6VKcfPrHj0HH6bFD1IeQj0OBFr80ZOq7+RMu2sOcVxp/17ojo/hy5eyH6SK5p
	FrGahXNtTuCXDn8ZO5OAmfgwO8hl8CcnuphLVlfkxSNp2LnhAdfFyV0ddwf9oLuj7Kgvk+Dvrfv
	umsM4NogO6sSoWpICPMRqVbBqwYYHwGpnl+
X-Received: by 2002:a05:693c:8244:b0:366:8efb:bab9 with SMTP id 5a478bee46e88-3668efbc174mr439554eec.11.1792481249125;
        Tue, 20 Oct 2026 00:27:29 -0700 (PDT)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360819bc569sm37090220eec.11.2026.10.20.00.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 00:27:28 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Song Liu <song@kernel.org>,
	live-patching@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH] klp-build: Use kzalloc_objs() for object and function arrays
Date: Tue, 20 Oct 2026 07:27:12 +0000
Message-ID: <20261020072712.12633-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Allocate the object and function arrays with kzalloc_objs() so their
element sizes are derived from the destination types and multiplication
overflow is handled by the allocation helper.

Keep the extra zeroed entry used to terminate each array. The default
allocation flags remain GFP_KERNEL.

Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 scripts/livepatch/init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/livepatch/init.c b/scripts/livepatch/init.c
index f14d8c8fb35f..908676d6d07d 100644
--- a/scripts/livepatch/init.c
+++ b/scripts/livepatch/init.c
@@ -34,7 +34,7 @@ static int __init livepatch_mod_init(void)
 		goto err;
 	}
 
-	objs = kzalloc(sizeof(struct klp_object) * (nr_objs + 1),  GFP_KERNEL);
+	objs = kzalloc_objs(*objs, nr_objs + 1);
 	if (!objs) {
 		ret = -ENOMEM;
 		goto err_free_patch;
@@ -47,7 +47,7 @@ static int __init livepatch_mod_init(void)
 		struct klp_func *funcs = objs[i].funcs;
 		struct klp_object *obj = objs + i;
 
-		funcs = kzalloc(sizeof(struct klp_func) * (nr_funcs + 1), GFP_KERNEL);
+		funcs = kzalloc_objs(*funcs, nr_funcs + 1);
 		if (!funcs) {
 			ret = -ENOMEM;
 			for (int j = 0; j < i; j++)

base-commit: f663062d717eac2c01f77eaf321fa630528e672d
