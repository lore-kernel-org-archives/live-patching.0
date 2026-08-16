Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CC62FB084
	for <live-patching@vger.kernel.org>; Sun, 16 Aug 2026 09:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786871095; cv=none; b=NdU3UyW7S2esk+OW5kElYiDf9e7s3kPSIgfKYUaH263ZCalgbUn84R4c77n5J2ScIkGEwi7hwkkJf+mK/bkMkfYn7zHoK8mYJbCoAnXvRjyEb3tsuKZ8fFGGoxjBuBGo9gA5BWG7m2ZI2ucIFKp5AZtYAaM276ZQPncC14RIRBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786871095; c=relaxed/simple;
	bh=82UwZfjS36SOe3IWW0m4OcL8gSl8El8bYhbm1tcHRmA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F78sOtZk+StVTJf6Qkm0KdR6xOL6S+2YvI4elHumEaJJ/TY24jSwLEODazBfZf470830+pgTtF9/TLvoofSh3YMP9l6WUXEgq/0BtuzuiRMFkEqe3J7UldVA+RTKcf3k+/iqZM9wHprqcrNousY6RmFEbhIFj+FZY280sCf+vG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N3ufolT7; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3ufolT7"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cf50c6f235so29411035ad.0
        for <live-patching@vger.kernel.org>; Sun, 16 Aug 2026 02:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786871093; x=1787475893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Gs9UaCWLOz/6j9OxrNkInDAXLG06L2eqyt2KYk+HRps=;
        b=N3ufolT7Q/6B+KJXVRKeuxJnF3BNxpiXlHWmMfbnos7bGElVLHjOm35ZnXj+1ktAV9
         wO/TUCzot/203XytwUjqN3GqtaoXCh+bVTx/itgGRAx5m2rJv7xrM30YsqgPuI5h17nz
         8miLhu6EVpF0mBaSfp5EKVQVcvrDhbfKO30tXi+PxOH5uHq36VpJR0r44li6MKh/l6FQ
         J4y91+rGEqEollcyu2dIG6IxTBgr6w2/whHoLHJnigTatxI3bzVHkHbl2WyUbofKATvq
         Vs0IutWKQaMFoXv6MFNN3wJG/jW3vr0fMXhSeQVXUGu5GpYUBstx1GER1aRletDWLODr
         0bpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786871093; x=1787475893;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Gs9UaCWLOz/6j9OxrNkInDAXLG06L2eqyt2KYk+HRps=;
        b=MBmIwtIakqdxsK4WgSyEOL4bdxWl3IhyM10wEtCw+NFIpYCR1gcnVKYK126cMYTU34
         jWPhxmLshjgE49ZA+1Hn+C9giy8/OduUwx7wabCpI4x/MhWNetWXqards4vmeeiwAmmn
         y6eqZq/b0aY2gE0lELboh3WxujO1T96DBZuOM1a17CWPQ0Gin2KHZNxCWSQi0h8RwuFi
         s8oNo6QPp1/BWGYRYJnpHlohY8OvuYk9QT+YGylUJCduWpTr5n98NCgqtmyWM0LPLoqm
         6AC/hzULr1pFsERKiA4jLQAbw2pktjUmdME35VURbvisvHH2/VI/QnNShOmVizbuKmB2
         MUxQ==
X-Gm-Message-State: AOJu0YwW3MgJTjTsFhjseueoZBiozUXOLQEv3lxtG55XcC0PE4eZHZl2
	ejCJzjnDWO6jZL50hcx0ODtOgOSsYLToBid+IxP5bblIy6Ea0MAviios
X-Gm-Gg: AR+sD11KhYkO0KSIaxeHelpFssoVDhGi/ayKkcR+9aEi/rcSV3o9u9JWZPVuxXut/Wf
	RVhDsiLslMeBX6A3IeI/i+yAdM/F8yF0DSLjTp9pDjp5jMpl2xcNCPZdhhTEgsD08OyalHhXE6D
	vabnl8GUArqCo0ZkSy8ploOKJyQAtwIZpR1oeMJuueJiiyXtcDQyAJO4e6ULEtT4wD6w+yY2Lz5
	CDoDonHLloQAYls/dbzifhcTJPOvIQeT5aJBGkNjEOBqnUvBHH4nne0hkzWuq2MJfan4ZgIID/E
	1tpWAgYQgb2/nxbytF4b/O2hjZByZcNUZ+Cbspt4qWZh2bU7ga0gaXSFlSvBAGChsXLvPtTFxUQ
	oaLIwnjLdYdrrEOGbiZNZ+2tkO5i1sJhT/nrMZhD1VIfknARF0R/tP+4wxkAa6rUWE0qs9St761
	dIDIRLI4x+UXniWA8r+4TzFJe3er7E9GW9RA+cmnt0mMxtuHmH6XZAFs6zHVo4utbENQHrkW/4K
	iO9cWQqL5KWv6zYd9N59N+xgRXwtvhW1TQEpXAn4qcFIQ==
X-Received: by 2002:a17:903:2305:b0:2cf:4c0f:5129 with SMTP id d9443c01a7336-2d3b0cd91a1mr179073065ad.17.1786871093105;
        Sun, 16 Aug 2026 02:04:53 -0700 (PDT)
Received: from yafangs-Air ([240e:46d:2100:4077:60c3:e9ee:3774:36cb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d3aeb8869asm24466485ad.60.2026.08.16.02.04.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 16 Aug 2026 02:04:52 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	song@kernel.org
Cc: live-patching@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v2 0/2] ivepatch: Fix several bugs found during replace set implementation
Date: Sun, 16 Aug 2026 17:04:40 +0800
Message-ID: <20260816090442.18128-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These fixes were found while implementing the replace set series [0].
They are independent of that series and can be applied separately.

Link: https://lore.kernel.org/live-patching/20260809091954.22930-1-laoar.shao@gmail.com [0]

Changes:
v1->v2:
- minor improvements and acked-by (Song)
- fix issues reported by sashiko

v1: https://lore.kernel.org/live-patching/20260813030408.9761-1-laoar.shao@gmail.com/

Yafang Shao (2):
  livepatch: Fix wrong index in funcs cleanup error path
  livepatch: Fix UAF of unregistered patch kobjects

 include/linux/livepatch.h |  6 +++++
 kernel/livepatch/core.c   | 50 ++++++++++++++++++++++++++++++++++++---
 scripts/livepatch/init.c  |  2 +-
 3 files changed, 54 insertions(+), 4 deletions(-)

-- 
2.52.0

