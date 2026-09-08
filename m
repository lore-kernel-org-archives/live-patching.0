Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC91E533593
	for <live-patching@vger.kernel.org>; Tue,  8 Sep 2026 12:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788869019; cv=none; b=BW+aUWdia5CVCoLU1DKp0+a8+fpjvF68f71G8leemWY61EVV5cpVNuI0UKxKYGnFe8kQhZhGVivHKYSTYBm+7FP4aZV39+Lo+GYDi4C8E2NPFhegcGG8DbywPL9u/MRNNwhInmnkY5GT5xGrtW3o/7+zAzd9oWnDg2qAicQNgKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788869019; c=relaxed/simple;
	bh=+ea3yYnkWvkYggstAtARXqN3w6KyrKQX3QazvOPZjRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n5QxUjyyiFk2FpyCtaH3r5kexyvRd/foRWakoLX6LgDMEdVRNuqRXiVx0+VmbTPbIXcrEYaU1qohYozUwh96P7hSJH+YaT9/erIUqGWOwqIxvkey53y5YXf4OIEcKK8ObSQsoVTggkEKItK7zv3Uv74LOA61/DdoerJ1gXad2tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NXGWoYsh; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NXGWoYsh"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49b0d78a801so45734195e9.2
        for <live-patching@vger.kernel.org>; Tue, 08 Sep 2026 05:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1788869015; x=1789473815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=487eRbWP9lyEU/S8kmCpSA9mRITwOfBc17qyoaa0o10=;
        b=NXGWoYsh+I7RR8u52Hc0QMYO0PZPvZLYmyTNkLrQu15Cyult60KzvTgXyMDtwCPNFI
         BkS+OH10pWUxW7tGFVL/dNMYVjAsB0kd/48sJz4H7GnZD46PyubPQ8oxrL3MhkyoCap4
         mLmCKpik4D0Jz9M7Q94a84HzdtTEoPgnzEOmiTJxDQ52iSZAJV0K42767BsyT1M+AEcW
         ebB7n42uoMqlUSeH7lmsY5MY4LAHZMpoToj5MvDNd2A12u92tKP2THTQfElbXKRpbeup
         MAg1wOI9D2lhB9yhsV4rjktZS+WPk/IkH13vkurml/U1e2oYxq/FQKijKzG4/P9u7T/2
         jbEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788869015; x=1789473815;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=487eRbWP9lyEU/S8kmCpSA9mRITwOfBc17qyoaa0o10=;
        b=JSyMaRmZfoaXaaQDP/WcPb4hpIo0PrrxO8bxMpMT77O9NxOdcbk6Z0RfRfcIttf7hE
         uV4YG1R9iUfZBeb36wT0FHGqMuLS0jgk+UwrrAM3X5c8WVuecpOQ97LPzm0HSRrtXTKJ
         JEpORqLmV5ibs22TfCWP6KBoM/lLIDFSHEwdwAjF1/5TepBwNwSlsIMoby2jzC9d3o0m
         vSItfR2qNYlPSgCPQrYwsXxS2L10VkQ/DRa7R6T1FX3P8MLDZ71Mb4tGiRj0WMt2YHQZ
         hxwDcm9T5IlqfpF8JOpbGnjplQsRCD/UIjPwu+kGEcCEcQWFgOQjqhHLBleAzh+eMyrO
         mqLQ==
X-Forwarded-Encrypted: i=1; AKwUvBwXgpzcGCKmRDTvCNs8Xpc47dCsENmJESnUl3DQgD68LGRBrfJV1SlnDHwTm426Heiz1gQgtdmHyPTK0z1r@vger.kernel.org
X-Gm-Message-State: AFuF++koR7Y53GKRPfoh9B2UhTyJ0ttGql3rG4wrXss8OuoO0cgHYYw0
	ulQCUTDwQ0YRVIbSV21iAv7ncNzHh8U/ilY5dzBwewNyFdmbg6HSH2FKH80JYBDpP/g=
X-Gm-Gg: AYBFou0Q0NsmitM/NT3yoJArqeq6h7IUAt/o3OdZ3Usx0XHhnZNs9vuyw23JGMxKXq9
	i7aAMQ4/m2cRnMWGvlPGFGilpxG5nT1Pmdjfbzf6gIXpRsZk1JSpdH87TNmlzEUeEYWA0aMlfld
	91gU6tkdZzeSUjLj/xvrgn+2hpLSCxCnLDjeRBGghXYB/sUCdgn55r2XHX2Z9F6+/f1ynT5xUng
	34JkJ984J61N/yVxuyowjKaS/wtt136yOgRNfR3rEF5FIs0fzOMoLsNKBOYhgEqaodjO6znttJ6
	N0W/P5KJsRn6gZmJwVBpa+JOhqfCBTBGa51JhwlXV9kJ6vXd4yB6ZJv8aSmMNwv9sqWYV5eMZHM
	hghHd+c4LkzYY7UrXRoBM58ilosvcGVjS62xrNzQdQqYHvbkwpuMxRpQQRXrVegFs8Cy837z6Pz
	4Olv1Ap8gazF+tYLTeJt2gsVpkgrVc2gNgGHkcnP7fIsK6R5ZZiRA=
X-Received: by 2002:a05:600c:190d:b0:49d:72d:9ba3 with SMTP id 5b1f17b1804b1-49d072d9bccmr190553905e9.14.1788869014574;
        Tue, 08 Sep 2026 05:03:34 -0700 (PDT)
Received: from pathway ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883a9234sm35538164f8f.14.2026.09.08.05.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 05:03:33 -0700 (PDT)
From: Petr Mladek <pmladek@suse.com>
To: Harry Hsu <x90613@gmail.com>,
	jpoimboe@kernel.org,
	mbenes@suse.cz,
	joe.lawrence@redhat.com
Cc: jikos@kernel.org,
	live-patching@vger.kernel.org,
	shuah@kernel.org,
	song@kernel.org,
	linux-kernel@vger.kernel.org,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH v4 0/5] livepatch: Fail object initialization on duplicate patched function
Date: Tue,  8 Sep 2026 14:03:20 +0200
Message-ID: <20260908120325.299649-1-pmladek@suse.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is v4 of the patch failing object initialization when it patches
the same underlying function twice through two aliased symbols
(functions sharing one address) in the same object.

Changes against [v3]:

  + Add selftest for livepatching aliased symbols [Song, Harry]

  + Only partially revert relocations when failing inside
    klp_apply_object_relocs() [Sashiko]

  + Cleanup changes made by klp_init_object_loaded() for failing
    patch on another failures in klp_module_coming() [Sashiko]

Changes against [v2]:

  + Clarify comments and the commit message [Miroslav]

  + Cleanup when klp_init_object_loaded() fails [Sashiko]


[v2] https://lore.kernel.org/r/20260823060734.58443-1-x90613@gmail.com
[v3] https://lore.kernel.org/r/20260830173343.52759-1-x90613@gmail.com


Harry Hsu (2):
  livepatch: Fail object initialization on duplicate patched function
  selftests/livepatch: Test rejection of aliased symbols in one object

Petr Mladek (3):
  livepatch: Move code for updating livepatch object relocations
  livepatch: Clear relocations when klp_apply_object_relocs() fails
  livepatch: Clean up klp_init_object_loaded() when fails

 kernel/livepatch/core.c                       | 137 ++++++++++++------
 tools/testing/selftests/livepatch/Makefile    |   3 +-
 .../testing/selftests/livepatch/test-alias.sh |  81 +++++++++++
 .../selftests/livepatch/test_modules/Makefile |   4 +-
 .../test_modules/test_klp_alias_patch.c       |  62 ++++++++
 .../test_modules/test_klp_alias_target.c      |  48 ++++++
 6 files changed, 285 insertions(+), 50 deletions(-)
 create mode 100755 tools/testing/selftests/livepatch/test-alias.sh
 create mode 100644 tools/testing/selftests/livepatch/test_modules/test_klp_alias_patch.c
 create mode 100644 tools/testing/selftests/livepatch/test_modules/test_klp_alias_target.c

-- 
2.55.0

