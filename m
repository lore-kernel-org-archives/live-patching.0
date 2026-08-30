Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8972D5937
	for <live-patching@vger.kernel.org>; Sun, 30 Aug 2026 17:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788111231; cv=none; b=kQTVK3VANtHUjwVVX1xUP1c3VKl0utr/Mjlbn6F7yqWD9YywqGI50aMdoXtchc+S3OsHYLYRBqURoiBq+VArYznl/tjiMvL+KZz4ypWJDX0aizvPZKAYAmJ81AIRswm4il0g7x5ftRH0nWSrrF3gNrLviJi51kppQYj5rbdHciQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788111231; c=relaxed/simple;
	bh=TByE+cFHkN88dDuBl+Ud78hUPGn9v39quj45oHZsxGo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B7Napf58uYnwCF+PkR+CaCzoExGwwPWRXwcKQnYpzlHSlc+LYL5QIMm4zt/c5GjOgGRyRd9g/vxzNOPQDRo3euxZD4F3puI4akSmQwFbZRGXP6d1YbkrhCJo+kyxosu2L6TMq0ZYbWZADrY4QWMyjnPEacPafsU1Et27geeryIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ol0dvHzo; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ol0dvHzo"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3964dfb5b9aso2765171a91.1
        for <live-patching@vger.kernel.org>; Sun, 30 Aug 2026 10:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788111230; x=1788716030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aIrgjdjScg7nld7Ey4Dlfd+00beZRs0A8XzyvdJn2jE=;
        b=Ol0dvHzoRwj1pvB5C2LcUi4x7GEAjaCvEm34b9hOFFrGIrDegCfFo6xanJa0VEgG7t
         4Q3pxvTca5IJOZrxTDP47/LQwL5cHHqugnKMLMqAZThkh6XR6XX05an+T+H68+trqT6H
         yEPyuIppjaSxTWvaGDq+Pna61+QQSJzHwy/clnFwlgJwSZf8SbRT1mwWoEGAIxrsgpQx
         Srzy1OQ9SwOloHKrCA/YCpQgBxMcdYyOhQ0q5dPc+a9oTc99+Ln0n9coAOoTdktEz4Uk
         36d3Rgz8qbjWayhK7ZQk3yYs9vOm3NHXoDsGacqRdQYRKTbrMrHuBPpPnd2arErDMwBF
         B7VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788111230; x=1788716030;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aIrgjdjScg7nld7Ey4Dlfd+00beZRs0A8XzyvdJn2jE=;
        b=hM8JpuCsDF7/RZ3gFxW4q5Od7OrKGaLwhsaN23CeGW00wVW2mAYiuxg9paOKN9yRVm
         kLfKT5Kux+3y9GX1X16eWPZZQxyvGh0xQs5/uJ90m4tqzlTRlvT1FrjRtMDA+76A76fq
         mmtEo5QkPb3zq5Lc04QEQ0iMJVtkH1b2e6fkHRWiLWBa7qaKXbExfMWPlUQ7I2IF9AOQ
         zOIHv7QdDZBqp88tPKBRziOVGNAaJyhQQe9PqImLTD814UGvOugHtPx3N7NbLUlHduEZ
         uKImsq8bK6/HSt1rmf3QktQkvkzn5LzNLB9tjzJTzH0gmhOwjG8R+OMVz8B3XNgqB4AR
         oZCA==
X-Forwarded-Encrypted: i=1; AKwUvByKdHBPv78maVUdgQVz9ceY53xS8tXVy+MJvgr2q++grRTTmcZo43Wn7MTeNjqwWCscprZXDdcFQeyzpEKc@vger.kernel.org
X-Gm-Message-State: AFuF++nD7VArO7cu7+kpD/SmRvOP5yD8AplYPcIeh04D+yTN4McoK791
	9dADLbUwS4VVLxgYvM2Vln9n5U0lpy77DcdFTdxS6PwFIQ3kaak57R5J
X-Gm-Gg: AYBFou10f7S7SbXxtAYmXR2C/LXUeAM1Q0PifXq1BOavDZdanlIJYdgqeOcGcP2RWJN
	mni/eGg5frwz5jAozRC8MZsAsTeu//WOJlB/Jr4FnOKtQWB5sGP9iC6iJNPGvWZqiCDA9Evp9aW
	9mfguryflh2MR8KXKBhDmH7D+zGcE5lM6CSHD8qn/PU/81KFariz+hHKWMfDKJyk8adidlk8eOK
	2ouqqITLBRT1CQD4/kZRQrLWPfNAiNGbj0Aw7umGp2ghAt6GQmcohIiCTxDM1Rmx2hV/pJfGbUl
	laEdg56CUCMqe1rGnK/Uva7MjlVTLvS8k9kcq6GgihnarTtMWhl7szgWqadAdHP8hom6OyG8a/J
	4SKcmqS/R0jgKepHTu48Um7V+1YdrUu6Pv/jbsb41Mw7z4XLJG1MZV95Ax+sPBiY4BKswJVD4yL
	T6qSYIQUkr0sdgaUyJaAXI7ISpfwutqBUhFPjsgaZm+DBJ/pOI1CKIPZDpI82cd8/Qk5fBpQ89y
	j+b3uIkkMfXIfQRE/6XBxVy8/Rx7iM=
X-Received: by 2002:a17:90b:4a90:b0:38d:b36e:9813 with SMTP id 98e67ed59e1d1-396d0f8e9f9mr31394165a91.11.1788111229611;
        Sun, 30 Aug 2026 10:33:49 -0700 (PDT)
Received: from localhost.localdomain ([2407:4d00:6c05:13e8:a91f:d3ab:5c4:f6ed])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396b186809dsm17237749a91.10.2026.08.30.10.33.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 30 Aug 2026 10:33:49 -0700 (PDT)
From: Harry Hsu <x90613@gmail.com>
To: pmladek@suse.com
Cc: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	joe.lawrence@redhat.com,
	live-patching@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Harry Hsu <x90613@gmail.com>
Subject: [PATCH v3 0/3] livepatch: Fail object initialization on duplicate patched function
Date: Mon, 31 Aug 2026 01:33:05 +0800
Message-ID: <20260830173343.52759-1-x90613@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is v3 of the patch failing object initialization when it patches
the same underlying function twice through two aliased symbols
(functions sharing one address) in the same object [1].

Per Miroslav's review, the changelog and title have been reworded to
avoid implying this is livepatch-specific validation: the check runs
during object initialization, which klp_module_coming() also triggers
for a module still being loaded.

Petr found that the error path in klp_init_object_loaded() -- taken
by this new check, among others -- leaves stale object state behind
on failure. His two patches (2/3, 3/3) fix that by routing all of
klp_init_object_loaded()'s error returns through proper cleanup, and
are included in this series since they touch the same code and would
otherwise conflict with patch 1/3.

[1] https://lore.kernel.org/all/20260823060734.58443-1-x90613@gmail.com/

Harry Hsu (1):
  livepatch: Fail object initialization on duplicate patched function

Petr Mladek (2):
  livepatch: Move code for updating livepatch object relocations
  livepatch: Clean up klp_init_object_loaded() when fails

 kernel/livepatch/core.c | 117 ++++++++++++++++++++++++----------------
 1 file changed, 71 insertions(+), 46 deletions(-)

-- 
2.43.0

