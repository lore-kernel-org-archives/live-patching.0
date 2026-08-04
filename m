Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9681154788
	for <live-patching@vger.kernel.org>; Tue,  4 Aug 2026 06:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785826229; cv=none; b=qLvAitH5C+222mLbk263+ACnb+PauVcm+ydQ5MxySF4ovkXWjtj6KrvnYlKFmOECs7hs4KIG6xux+upBu9RogUIsEQG2rnjD/lP1M1koC1/uVnpP3MuEwaQycTueb21oTHkeW4P70ie1YR6O/JGZY/DcS0mkSj/aMxZWyWYNRFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785826229; c=relaxed/simple;
	bh=t6ksLzZ0JzKyuLMXFlKzflQuNXzZf1GtSBVNY56V0hw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qz4dhMhwKaLaaWTCpaKRw/hVezu+ob0z1AipYX2eIQWdYWQDmcAT6WUexdQnTpScSf24RKN8gdgyKC34Da9J+Krxw03MdI1z9xTuUIMlot+9WId8Yz+UOgaiWuhjwMqscC809Xla2FYem3HjGHbllsuKJf0X/g2qZ2z9Mkrg2hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bxe9jkf2; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bxe9jkf2"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ceb096e675so50104515ad.0
        for <live-patching@vger.kernel.org>; Mon, 03 Aug 2026 23:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785826228; x=1786431028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ngIhS8hW7nyc120/4h5mCMWdwFabM3dktutJT6nzp8o=;
        b=bxe9jkf2Us+tGdtaV00VSxUnVn5685yO/8Z5uCN/vYldlhdaT1EwNDCSTZvQn6O3be
         9Li+FtEzDg225mqZGrgqW/qjyPYkINbpUaOji49ure8Ip68rsxvK38YKhVTQC6WNk1IV
         QWHHYeiVbLnhRd4u5lIUFQLgvlCINMVbDmOM0tXljopGVe18KRaPeOCbfCBJ2yt3l57Q
         +IhwZ7inEqiY5BLcN/5uKseZGQ59vAbSNe4TNHsxi1nOs4YzXcIB7tSeV7t0BdCq0Tyk
         rld5/v0jhFnhk1XPTmOxQRULrOngqHn6RCMYsSOgHDIGcG7y4OqVsIJYV6X/PwbJgC2x
         Yqnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785826228; x=1786431028;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ngIhS8hW7nyc120/4h5mCMWdwFabM3dktutJT6nzp8o=;
        b=l0uMQlkot3mZTTOcvPQ92yURArxXufAD0Up3PsffMr1QoBpGQ4NrXkW3HRpYlUpgGA
         baRwnxPUMgzdYLqJo0NhWXnWf7fdrqaNlBZ2Ko+JXJtN3+PpT8BqMgL59qn1nPJNw7MM
         kIhHrma8orUw2/7pQVqzFZbJOXnytuL80BSWG2vgALpySyy8EDqRYPNmSaGdTgBz6FCl
         Rdd2cFGioYlDguLX/D+THjwzG2yITRJ1eJLEFMMHdeLrJk7hpiO7gi9bWCdNj1rx2aqq
         ErLar3+7mFQ7XI1K0fYS/Lkfr8cXfMkpoCP1ZK0K5cvCIYnY7vZTdKW1cmF52LvhAZiY
         ZDRQ==
X-Gm-Message-State: AOJu0YwnwgTpgxLyNlZ9qZATgqg31ilJT4WRVQU3LTkQkFK1tERO+5DZ
	MZRhkIYAwxcM9VoeqE8+yy34MxrCbakMfgmF+z7EtBrL1T/D2cyNaaa5cpuOfKkeRuc=
X-Gm-Gg: AR+sD132RpFTcxYSSEkd9Fq5h5PNuNy7DRQSplKB21n1SykC8cQLYKuqzCHBbYAPmFp
	Z7pKIWyQCkuItUZcTqD5uaZbmFhrVQEF83gcerdFfmRJ+i4xAN3e2ObTDWtDQYhXSlvTUEhcIvl
	gyzWW2C5jdncfDruqKe7dus5dqwGoTVTh8cVgx05+q5AcsoEpszB25A2gwllQ7abQhnVZZY6ix3
	Pbhbv+kWyLRu+tYrhkZD+eWLWchOmN+Ql5F3P1KTA2MSUPZ0QImOCVpcc/tpGgXA3jSf4YM9+WB
	aCZ+H62BZ+h6vnp+d3ZvRvzby4v8cvgdjJ3ToRmcXEha8GcNBWuy84Cg2Y3CnI8JQ8+RctKN4KI
	5GsWTFixG0HooN8A07X95L2TJCsPDFOFYqLxfllm5ipfNd+HGB6ifZNazYGECSxPD/M/Tvwhz5w
	hyQhuMLoxOINFtXOnXw4Sj0bRABeq65JSDYYTcJ82hgBJ13x9Ytmks6i3nLdqwkyZEWCNoZQ/9I
	EYhXrIE8LQcPhHRYF/Lr3M0LwlpKZX6MKA=
X-Received: by 2002:a17:902:ce0b:b0:2cc:f4d4:299f with SMTP id d9443c01a7336-2d05229b34fmr136697875ad.27.1785826227734;
        Mon, 03 Aug 2026 23:50:27 -0700 (PDT)
Received: from yafangs-Air ([101.90.159.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d0aa01af84sm1066085ad.36.2026.08.03.23.50.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 03 Aug 2026 23:50:27 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	song@kernel.org
Cc: live-patching@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH v4 0/4] livepatch: Introduce replace set support
Date: Tue,  4 Aug 2026 14:50:06 +0800
Message-ID: <20260804065010.44922-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We previously proposed a BPF+livepatch method to enable rapid
experimentation with new kernel features without interrupting production
workloads:

  https://lore.kernel.org/live-patching/20260402092607.96430-1-laoar.shao@gmail.com/

In the resulting discussion, Song and Petr suggested adding a "replace set"
to support scenarios where specific livepatches can be selectively replaced
or skipped.

This patchset introduces a more flexible model using two new fields in
struct klp_patch:

- provides: an unsigned int id identifying the patch replace set.
  By default (provides=0), any livepatch replaces any other livepatch.

- obsoletes: an optional array of unsigned int ids specifying
  additional provides ids to be replaced. This allows a new patch
  to explicitly obsolete patches from different replace sets.

A new livepatch atomically replaces any existing livepatch whose
provides id matches either:
  1. The new patch provides id (same replace set), or
  2. Any id in the new patch obsoletes list

Additionally, this design deprecates the traditional non-atomic-replace
model. Previously, setting 'replace' to 0 was the only way to keep
certain livepatches persistent on the system, forcing developers to
disable atomic replacement entirely. With the introduction of replace set,
developers now have a selective option to keep specific livepatches
persistent while maintaining atomic replacement capabilities elsewhere.

At present, KLP state, shadow variables, and callbacks are not integrated
with the new replace_set mechanism in this patchset. Support for these
features is deferred until Petr's klp-state-transfer infrastructure is
completed and merged:

  https://github.com/pmladek/linux/tree/klp-state-transfer-v1-iter12

Future Work
----------
- Allow `provides` and `obsoletes` to be configured dynamically at
  module load time, rather than being fixed at build time.

v3->v4 (RFC):
- Allow a livepatch to replace livepatches with different provides IDs.
  Replace the single `replace_set` field with two separate fields,
  `provides` and `obsoletes`, for more flexible replacement semantics.
  (Petr, Joe)

v3: https://lore.kernel.org/live-patching/20260607131659.29281-1-laoar.shao@gmail.com/

v2->v3:
- Address the feedback from Sachiko AI
 - Fix the pre-existing NULL pointer dereference issue
 - Move klp_find_func into core.h
 - Don't deprecate stack_order completely

v2: https://lore.kernel.org/live-patching/20260529034542.68766-1-laoar.shao@gmail.com/

v1->v2:
- Incorporate feedback from Petr:
  - Initialize replace_set to 0 by default
  - Improve documentation
  - Enforce that livepatches in different replace_sets cannot use the same
    state->id.
  - Enforce that livepatches in different replace_sets cannot modify the
    same function.
  - Ensure consistent capitalization and naming usage of KLP_REPLACE_SET.
- Incorporate feedback from Sachiko AI:
  - Skip the klp_transition patch during klp_force_transition().

v1 (RFC): https://lore.kernel.org/live-patching/20260513143321.26185-1-laoar.shao@gmail.com/

Yafang Shao (4):
  livepatch: Make klp_find_func() non static
  livepatch: Call klp_init_patch_early() earlier
  livepatch: Implement replace set for scoped atomic replace
  livepatch: Deprecate stack_order

 .../ABI/removed/sysfs-kernel-livepatch        |  16 +++
 .../ABI/testing/sysfs-kernel-livepatch        |  27 ++---
 .../livepatch/cumulative-patches.rst          |  93 +++++++++++-----
 Documentation/livepatch/livepatch.rst         |  23 ++--
 include/linux/livepatch.h                     |   7 +-
 kernel/livepatch/core.c                       | 101 +++++++++++-------
 kernel/livepatch/core.h                       |   2 +
 kernel/livepatch/state.c                      |  56 ++++++++--
 kernel/livepatch/transition.c                 |  11 +-
 scripts/livepatch/init.c                      |  71 +++++++++++-
 scripts/livepatch/klp-build                   |  87 +++++++++++++--
 11 files changed, 380 insertions(+), 114 deletions(-)
 create mode 100644 Documentation/ABI/removed/sysfs-kernel-livepatch

-- 
2.52.0

