Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7FC37475C
	for <live-patching@vger.kernel.org>; Mon, 24 Aug 2026 03:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787542067; cv=none; b=UXwD6xVdSd7wgwo/V4QXn0ifKX/w6jnUK+Y9Fp0Ap+Rwu4QXnwbL1g6uHF0mfkpMpNsGgpZZ4uPlRTdPSDtq1rVm7Yc2eJ9/6aOabFmoiynKJP+VwXRT9FEHTmWJ3hVsf1IdreI/Onv4AHE741Hpbg9rXIcLEbl36CqZdCSoAf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787542067; c=relaxed/simple;
	bh=HYFUioMFhpsm0+KGw2Mmg3FZwzJNFl6Kua1ANedGf/k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IVvdtoskV+nAQjJBBPZKGf+EwSZiEZEcwYfy0oMW4SeX/+IUGmAg82lz7NkpjO6ZNeO9W3P2c1tR5xnZhAJ2TSjuE8Q5K7qVoxiniS7mcAS1JK5Vqr9mTgxviHmVGCXNt/6gS4MhwzsNOf+4ZErY6b3SbvpRbXCyKc0CksCZhtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rHb32UTD; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rHb32UTD"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38a0c7e841fso4115228a91.2
        for <live-patching@vger.kernel.org>; Sun, 23 Aug 2026 20:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787542065; x=1788146865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qzBfH3f//sjS6eSYBkueHVkBGDiiJJ7uLM82pCJhwHM=;
        b=rHb32UTDz5GGGLyUUEttI60ferZPiod8xKS0ifGZD+kH9DRrSXiXbvCrRTtH2v9YMA
         bu5UP2Xohzbd2zOG1XgVkk6f6DJtD2XNL+40qE36ntNjiUg7tnQCk6Am8EwlAOWo/Uf4
         A9RkbJdXWB7VHNWdlBwWfLC0AtBG0kZ2EesMAgQWgd9CU5l1nmZs1yExVR9ELnlUU3Im
         jOLZ8pRKQGgKK9xmIW9QpN6VcNHaZ2gssK/1dExnIl1kWJeKxoa7pNvNdQz6zU+UYUlP
         k7KskLESGUl+PgiUFVvaQNXL3fbmWkbpYke6ARwXww5HpF4iXGLcoF2veDeg4P3uVl0r
         3U+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787542065; x=1788146865;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qzBfH3f//sjS6eSYBkueHVkBGDiiJJ7uLM82pCJhwHM=;
        b=KUm/FZumFwj7dNMLRHlcMpLqgy4Gikg3YnEPWkrNbOOdWo488eRbuQtwJTuHJdpZmB
         dz4SBHPbnVAlDf6uloOQv14Do2dRnrlUEquz5GRjV3wCrDzEkGFNHDHDlYMKCc0iRaQd
         IE+snBPkiMligHaQHXk1JHiqS/efUr2EBsJKTWIQOrLQgRe75JiWXkyJLvH1IAANCsAC
         ia7tq44WkB+Ci7GWiqL2o23pAA+zpWlz6sdHUkDUnFeJw+egmkbvDWAPfuumDLynJmfK
         20FfhTyIf7OCriw+jbq9To7vKBTIRPZ92Ai5QsWcn+hW16EujWEaiyDt7Iu4JihPYzfK
         Di4g==
X-Gm-Message-State: AFuF++mUuTcm8u4UPAY/b1k5vDivb7I7UTxK59VFlyXrud/R93ksfgj/
	RLbMunDoNda/p2gJHK2tIXeb8tj5nhh86YUB+6zuvyFiv+bKEEGUUUbp
X-Gm-Gg: AR+sD13TBK+Z1cYHJAJV6sPOKDvaj/HagmfbtK4wE+GTLGdsqnSIi6ONi9K0548EyJ3
	g8B9lwFt0nztKHumcxAIZHDTyX4gXU9TYCudUBgiZiXHDvCrGrFEfYQVh4dqXvbkuazetpT+UPP
	bGCyN3k4hrz5CSPYpp4H+xtQXm/b/WZkWOFGM/ZiFQqbpbywx56Up8NOX4NOPGml9tWRjqg1Taj
	j6JJgKb7f4Emd3v66g/74rYhNzxu2OFVX7VblKSHb25sPYt16WvIY2rL/w5Lw/DETycXrKpsm0l
	G0o/S5K0j8JNtSQikk5XoSiXK6StdsodQXW4X19sCKpUJuMMvhece7bRgrvnKA3RNxm9wYoCavz
	avdMUhhYb/TI6alNEEgwEvNs7acUw/IW0LuznPikYLqQwNfGB8htBzMMI0bTg9QlxkB9Y7RwTZy
	jVdUOD8d14cMFgGz7djuBfqd5w0t3R6+iBfskBMY0ks+HHbdkBpBK1KRIi7AkEcDi0kO1uF2txq
	Vhh4PwTDkAcJnePERYk3a60p1GAZnilx7Zy6X9mLR8=
X-Received: by 2002:a17:90b:54d0:b0:36d:b424:4f17 with SMTP id 98e67ed59e1d1-395c35188fcmr45520189a91.1.1787542064807;
        Sun, 23 Aug 2026 20:27:44 -0700 (PDT)
Received: from yafangs-Air ([240e:46d:2600:d2:b0b8:8b52:78f4:9247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395e4b46518sm8496460a91.17.2026.08.23.20.27.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 23 Aug 2026 20:27:44 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	song@kernel.org
Cc: live-patching@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v6 0/8] livepatch: Introduce replace set support
Date: Mon, 24 Aug 2026 11:27:24 +0800
Message-ID: <20260824032732.56686-1-laoar.shao@gmail.com>
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
===========

- Allow `provides` and `obsoletes` to be configured dynamically at
  module load time, rather than being fixed at build time.

Notes for sashiko-bot
=====================

In your review of v5, you found the following issues:

- A malformed livepatch module with a missing `old_name` triggers a NULL
  pointer dereference in `klp_find_func()`.

  This has already been addressed by commit 1a921fd13c31e
  ("livepatch: Fix NULL pointer dereference in klp_find_func()").

- When CONFIG_DEBUG_KOBJECT_RELEASE is enabled, an error during patch
  initialization causes a use-after-free during module unload due to the
  delayed kobject release.

  This is addressed by the patch posted at
  https://lore.kernel.org/live-patching/20260821031648.48195-1-laoar.shao@gmail.com/

- Other review issues are addressed in this version; details in the changes
  section.

Changes
=======

v5->v6:
- Check `--provides` argument in `klp-build (sashiko)
- Fix the 'replace' feature detection for OOT kernel builds (sashiko)
- Fix race condition in sysfs polling (sashiko)

v5: https://lore.kernel.org/live-patching/20260809091954.22930-1-laoar.shao@gmail.com

v4(RFC)->v5:
- Add selftests and Remove the RFC
- Fmprove klp_has_function_conflict() (Song)
- Fix a pre-exisiting bug
- Fix bugs reported by sashiko

v4 (RFC): https://lore.kernel.org/live-patching/20260804065010.44922-1-laoar.shao@gmail.com/

v3->v4(RFC):
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

Yafang Shao (8):
  livepatch: Make klp_find_func() non static
  livepatch: Call klp_init_patch_early() earlier
  livepatch: Implement replace set for scoped atomic replace
  livepatch: Deprecate stack_order
  selftests: livepatch: Adapt atomic replace tests to provides/obsoletes
  selftests: livepatch: Add provides/obsoletes test scenarios
  selftests: livepatch: Add test for state ID conflict across provides
  selftests: livepatch: Add test for function conflict across provides

 .../ABI/removed/sysfs-kernel-livepatch        |  16 +
 .../ABI/testing/sysfs-kernel-livepatch        |  27 +-
 .../livepatch/cumulative-patches.rst          |  93 +++--
 Documentation/livepatch/livepatch.rst         |  23 +-
 include/linux/livepatch.h                     |   7 +-
 kernel/livepatch/core.c                       | 114 +++---
 kernel/livepatch/core.h                       |   2 +
 kernel/livepatch/state.c                      |  57 ++-
 kernel/livepatch/transition.c                 |  11 +-
 scripts/livepatch/init.c                      |  71 +++-
 scripts/livepatch/klp-build                   |  79 +++-
 tools/testing/selftests/livepatch/Makefile    |   3 +-
 .../testing/selftests/livepatch/functions.sh  |  15 +
 .../selftests/livepatch/test-callbacks.sh     |   6 +
 .../selftests/livepatch/test-livepatch.sh     |   6 +
 .../livepatch/test-provides-obsoletes.sh      | 370 ++++++++++++++++++
 .../selftests/livepatch/test_modules/Makefile |  15 +
 .../test_modules/test_klp_atomic_replace.c    |  22 ++
 .../test_modules/test_klp_callbacks_demo2.c   |  12 +
 .../test_modules/test_klp_livepatch.c         |   9 +
 .../test_modules/test_klp_provides.c          |  72 ++++
 .../livepatch/test_modules/test_klp_state.c   |  13 +
 .../livepatch/test_modules/test_klp_state2.c  |  23 ++
 23 files changed, 943 insertions(+), 123 deletions(-)
 create mode 100644 Documentation/ABI/removed/sysfs-kernel-livepatch
 create mode 100755 tools/testing/selftests/livepatch/test-provides-obsoletes.sh
 create mode 100644 tools/testing/selftests/livepatch/test_modules/test_klp_provides.c

-- 
2.52.0

