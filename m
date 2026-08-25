Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0775239FCE
	for <live-patching@vger.kernel.org>; Tue, 25 Aug 2026 11:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787658418; cv=none; b=C6EqDVEPPGRSbmZTOULnnKrGsYpzTEI7rvJFMdjHUgPeV5ZngMuXhVy+LWScbabmLwG28BZ+LwhsZR4MaH5b+mWaM+tv15JVOgQKeBDdoFpEGoBEtddtJ6fiDwhZDKhtjP2NeDcpwQ72dSjPne4nrPYT1kpt86zeh7rZIjP+wvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787658418; c=relaxed/simple;
	bh=9Tph9ChzUIV6JQ2kdTG7Czrw6U9bP0PoRYVS9LSE3H4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HiqH466ERp2hcceIj2nowDElq26Hn+mQ1xF3AOQ3HOzlShvRjR756y6KR0qhI9zJTQkznbima43+H5/aO4z+H7Ryjbtwl5x60M8DFkYnYQ03dMdFGiWcYJ6H5b/WUbdzkkSsez5JPNj3jc1SFPiORrbVNZE4uOmi0hVPThohJ3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OeTNwYmQ; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OeTNwYmQ"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c9eefcf9175so4748408a12.3
        for <live-patching@vger.kernel.org>; Tue, 25 Aug 2026 04:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787658416; x=1788263216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=b2N/zk/oxCH9KqV8fpdhiPusFpw5pdrUCADtBpsvcQ4=;
        b=OeTNwYmQefoe2HfIu8+KqrNxImuSgYYNdVG+BUfgAZ64rbqDLFGkLHxTp6MDKfLvCy
         c33XbOWHHGUZ8dzHiASrXztEkj2uz1/InXcqHPnY/jgekYtExIpndJWgkoNRoue2eReA
         MHVMLkay4BPml3vrAwISQv1u4M8Tspy7Zn2y9pOS/WUMwATP60oMAVJXWqGk4umMi+DM
         RcMgM4KaZpscB44lPGfkoLmkllA977IJz8ONxvFWVYu5mNPcJj9GAxYDZXaYJuiX+vXG
         dzOyHv0umEQ5LCxBrDuS0yPjGdDnZ6qNmVymm7Z30QYpT6bR6/fRNaFnF02QvAhHuzvd
         XGtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787658416; x=1788263216;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b2N/zk/oxCH9KqV8fpdhiPusFpw5pdrUCADtBpsvcQ4=;
        b=S1BThYsrG7adSmDkOM9m9GeRWXK86Eocfj2Pfw+GHHtnko6N9Ows26L9Da89llSsbd
         SY4I2BqLmo2zrfWNRMN2oHGF/SgKpwTqPEfiQSE4KXlq8mijSAf++usnWkuXKCsR25bm
         hnmA2Y7vC0CX3d3ssUf4slESDFob2a0lmuqc069MQFTIoPkRoqkb47X2HA7/C4BvNOL/
         RbF6MAgfTJYyYu5yAl5zA/zF78u3mDJbC9MK+JRCjskwi5MudMF70Vc+itTZ1OntPgQU
         PsrEXF3ItRaxFcW6moZevWvZXuhklN/aK/xziIZ2JJfjtAOYHabJeVwlt3Elt/Hn0VWc
         Iasg==
X-Gm-Message-State: AFuF++ni18kxbqO5lh5H3s+Q3ib0B1hDDH8DduBViAeBSm+eV0qBU31/
	R/aaS0Lk1+ksnd+lHPhKML5Ntzd27XtOg0KnVAGUFM5BhXANKneLlWgh
X-Gm-Gg: AR+sD10HSBtXlmmzk3IAtYQpSEkxWZLgUGEwUGFbU882DlvfXVY1xQTEUOi1vuatCiD
	Wnnjzl5mJHnKj6RL1XXp7rrmdlBZ9NPEm0uyXAFWVQDxB3FGqorDmUIDjTjwVr/y6JiLzs4krQZ
	nelf3ky6s91QTqezKQL6PQMFTk34ovEV+wCyRsvBYQGrO+pHKzzXNe9OFcDnuMkqpBWoLnkaufY
	+yfvLIywrdKYYFgwKDlDbK/hjMZV9Esh2+xi3hckbN9Z9YqREAjsIXnDVTs8gKrdZqoS60ZwI0+
	UxuCnYVPYhbI/iykRoRCo8QQWmWahxE/djvPShChEwkucRpsiToBJRPYXHih1FDFoYCHyXl4D0Q
	VQ1m1vFHDgqoCITgGBpJcZ0EwH+79OIupEm/Ezb4ShfMQbfgRKnjQsO5jBE7d0YLmo/2AUI8uQA
	fXXS0hZV4WmQ6h+l/JRMNvZIHjjrwVKTBSuqWC+oR+f8nJqcOQejoWv2uji4uQBW74D5X1/xoZe
	eKLQoaIs4LXLFfLP1qDvrVi2q+TaWEn9B+3vL4=
X-Received: by 2002:a05:6a21:998e:b0:3c3:89ce:b5bc with SMTP id adf61e73a8af0-3cd9135fcf7mr11167117637.15.1787658416259;
        Tue, 25 Aug 2026 04:46:56 -0700 (PDT)
Received: from yafangs-Air ([240e:46e:1b00:ae5:3473:12aa:8e70:f95d])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc199e5fcaasm1864438a12.24.2026.08.25.04.46.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 25 Aug 2026 04:46:55 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	song@kernel.org
Cc: live-patching@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v7 for-next 0/8] livepatch: Introduce replace set support
Date: Tue, 25 Aug 2026 19:46:33 +0800
Message-ID: <20260825114641.80452-1-laoar.shao@gmail.com>
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

It is based on livepatching tree's for-next branch.

Changes
=======

v6->v7:
- rebase it to livepatching's for-next branch
- rename klp_patch_replaceable() to klp_patch_replaces() (Song)
- remove "[]" around --obsoletes (Song)

v6: https://lore.kernel.org/live-patching/20260607131659.29281-1-laoar.shao@gmail.com/

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
  selftests/livepatch: Adapt atomic replace tests to provides/obsoletes
  selftests/livepatch: Add provides/obsoletes test scenarios
  selftests/livepatch: Add test for state ID conflict across provides
  selftests/livepatch: Add test for function conflict across provides

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
 scripts/livepatch/klp-build                   |  78 +++-
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
 23 files changed, 942 insertions(+), 123 deletions(-)
 create mode 100644 Documentation/ABI/removed/sysfs-kernel-livepatch
 create mode 100755 tools/testing/selftests/livepatch/test-provides-obsoletes.sh
 create mode 100644 tools/testing/selftests/livepatch/test_modules/test_klp_provides.c

-- 
2.52.0

