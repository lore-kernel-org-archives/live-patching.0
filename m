Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB2B3BC69E
	for <live-patching@vger.kernel.org>; Sun,  9 Aug 2026 09:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786267210; cv=none; b=lFd8oEa3NL2r3oq4ZuGkwqGtd2ogJp8B6y7kSEhq7q7AFimxXaWx3NKYT7PL9SvbxpRAdNuHPemRmiYEgVW0TM5zUn1cMaJJXKmg0NKs6iV+BPhEnuqsVQL0pNaQUp6R9ps1TgexzObeuL1LJ+lDtLLbV9oo4PoZ4wPDNJbOCko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786267210; c=relaxed/simple;
	bh=QEOJAZ96hZw5xPg0VNffuwd6z/nbtc47xFo4CrgzryQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gfPA1j2CBW6U5mj2LSYLKPNAkbM7zKNfx3IgSy5WBsBtO4TLe9KapCYba0QigyuhUE7H6DpaYtsXsxY/6KQLOOiglWa30zYelUxgIeXbSaG/QQVMnV0Y8Tq+zxxBUSLMfncClhLFnuRAG0nlnSa4NuVJuDRWfPTvDPBTNIA4UVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qSlmWnQp; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qSlmWnQp"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38dfe910e9dso912176a91.3
        for <live-patching@vger.kernel.org>; Sun, 09 Aug 2026 02:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786267208; x=1786872008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=r/nP4EVvORkMslSmJA5WHN2zM4rkIFeQIc/agJcr37k=;
        b=qSlmWnQpSGOnl8f8rEjP9giqBTTBSjqz0KZBVHStPfeCBnB64skiseJlwYWsT8um97
         nuNWXaPhHGCATUuTmI7UuyX4Kk0SDisgG/s9fZ0Ofb/Bq2O/jrqeAyH2V9s0xKLsHiW2
         I0uyCR7g5izuhG5MleqPUYQnq/IVpzZxwl9NfUiQBVgfs5CSXTTMLoEhZdsZxgtwXoX/
         bzulOJfAWrA6LeP9h97ui5Rj2gU/zyjdc8fEPtl58Be+lBGxBGoA07yasmu9v3CrXSUb
         nJed9ZVGXNZWm5xoKoDYannnKO7fW9Mlc5FUH7wHwfsPuU3xOyvFqCi+RxWpK+vSARAU
         ocrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786267208; x=1786872008;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r/nP4EVvORkMslSmJA5WHN2zM4rkIFeQIc/agJcr37k=;
        b=tWgNkLIa9l61G7aItyksJc1Cyu7U4RCG0X1BW248VLTuKm01hEx/Fa1es4Y7NSOomr
         ZB9VXfdEsD5orH9V1r3MA79D615by50ZhFGqPHrNVA1LQdwKvFAwVhbKXiV2VFXXWj+q
         CnFRrUbio1NfogNgu4Ep2aCcXT8uh3oLKQG/3R+2xNgz2fsguu41eZOElX4pWSGV6SM3
         VSAjybzUeFkXLbvV0ePumh5JQT9C85CZWkzQyxfkJSyS/U0CA4Uhntftsa6bp6HVFnoX
         cZ/klRBBZvVSKVlntLA/rw0RSjqGvQoxtffvzDR8hoAFQREq/Tq4Uju9/ogHuvSLyjcQ
         taFQ==
X-Gm-Message-State: AOJu0Yy4aKXxUH8awjCOBOT+dOp4hMKOHOOV0ygV3Nr5fOzz0mN4wKiR
	wTDNNlGHsGnH/LfBqOd08Tgi1ZSCQXhoE4pleyE7egxOc75cZWpJNX0H
X-Gm-Gg: AR+sD10/Y8YeYpBNTIaEx6xj9DgFCSimSsssRbwmLwgelrzGROxLU0u9HSOnOHHPTur
	gWbmWeKMTv25nidlKjS+v3tF84OPi1r/oOH3SmA0GYeVzwDysHm5jTjz62xIsTws+ajSTHE2v22
	BTb2sKwnXTLefL17KmMuRPo+27vHca6IwO2F9suYFxT3TOGKVAoBN0sgJvqwUFKZSdwPKXXcR/z
	jBkWa7zSgjmZXiRrcXmqqNx2Ad5OR3tGP3O1L9n/J7FPvPOrBHR+oq5GM4uoIl0ODaI/Cukgk2J
	trI3ESyAcrdud3zV/O28IRMZUrPTmAYiOKdpDIu/iMWDD7/xw7sCw8g4rQ/SYDG7FbBGKw2rruX
	p+LzjkFuQvTCZHiiyRG3xagSILZ8QXUIAYHtCSfgN3xCUb5qqILMsr8ijc3vRQZLYWZdSbzyQ38
	zmSvZYXzgONCO6Lojh77sk9A8RO14u35+EjGGZiGLNPHLvBQA4KuCZaflhR4v2F5nUmkXXQ/e/5
	m2siBFDntib/T9wpVTWlbz93TIQEQZfEwSIJyuNynKlUyHdQfacBQfcDqshpW11nZQC
X-Received: by 2002:a17:90b:2785:b0:37d:ee77:78ac with SMTP id 98e67ed59e1d1-3903c5e70c3mr34898448a91.19.1786267207827;
        Sun, 09 Aug 2026 02:20:07 -0700 (PDT)
Received: from localhost.localdomain ([240e:46e:ac00:14bc:74c9:c78:94a0:c446])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3908616d21esm11241281a91.17.2026.08.09.02.20.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 09 Aug 2026 02:20:07 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	song@kernel.org
Cc: live-patching@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v5 0/9] livepatch: Introduce replace set support
Date: Sun,  9 Aug 2026 17:19:44 +0800
Message-ID: <20260809091954.22930-1-laoar.shao@gmail.com>
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

Changes
=======

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

Yafang Shao (9):
  livepatch: Fix wrong index in funcs cleanup error path
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
 .../livepatch/cumulative-patches.rst          |  93 ++--
 Documentation/livepatch/livepatch.rst         |  23 +-
 include/linux/livepatch.h                     |   7 +-
 kernel/livepatch/core.c                       | 114 +++--
 kernel/livepatch/core.h                       |   2 +
 kernel/livepatch/state.c                      |  57 ++-
 kernel/livepatch/transition.c                 |  11 +-
 scripts/livepatch/init.c                      |  71 +++-
 scripts/livepatch/klp-build                   |  77 +++-
 tools/testing/selftests/livepatch/Makefile    |   3 +-
 .../testing/selftests/livepatch/functions.sh  |  15 +
 .../selftests/livepatch/test-callbacks.sh     |   6 +
 .../selftests/livepatch/test-livepatch.sh     |   6 +
 .../livepatch/test-provides-obsoletes.sh      | 401 ++++++++++++++++++
 .../selftests/livepatch/test_modules/Makefile |  11 +
 .../test_modules/test_klp_atomic_replace.c    |  22 +
 .../test_modules/test_klp_callbacks_demo2.c   |  12 +
 .../test_modules/test_klp_livepatch.c         |   9 +
 .../test_modules/test_klp_provides.c          |  72 ++++
 .../livepatch/test_modules/test_klp_state.c   |  13 +
 .../livepatch/test_modules/test_klp_state2.c  |  23 +
 23 files changed, 968 insertions(+), 123 deletions(-)
 create mode 100644 Documentation/ABI/removed/sysfs-kernel-livepatch
 create mode 100755 tools/testing/selftests/livepatch/test-provides-obsoletes.sh
 create mode 100644 tools/testing/selftests/livepatch/test_modules/test_klp_provides.c

-- 
2.52.0

