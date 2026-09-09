Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EDE2F3621
	for <live-patching@vger.kernel.org>; Wed,  9 Sep 2026 02:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788921824; cv=none; b=IircYHb6cjL1shfxSLtGYN0bnp8tdMLVRwHv7NB16a6477zag6Deft59J/2LoYZc3gV4aSFFFkShOqtZLxDjmmXqRUj/2/vAiGcmqYOKNEvqSyFMo0nPu9FeNNcf6tF79Y5ED/q12g2zNoD9fwtcjEl561bkprIGD/r0KFdMgdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788921824; c=relaxed/simple;
	bh=MG+AKZRdwd7wJKJETFX5f1nUcljFCEfqs62QYrAo7ic=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MOkguCR3dzDFdrvdxcYALoUNhOuBypCpyQvz5R7BiJfzK0Y0buEZeqoSqq1+pt1s7fvZne4oQyl7m2Ub2RcVVvPtFIQqZA4g+yygQ3VSyelqOLWH1un7nvmjeohiD6u2EnykegKdk4SY999fFpsxoKdCvSeVnkl1EZdHmojIl2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=et9uS/Sw; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="et9uS/Sw"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-39b9a99469fso1298207a91.3
        for <live-patching@vger.kernel.org>; Tue, 08 Sep 2026 19:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788921822; x=1789526622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XDP2V8qIY49+9T9tBX3aQ8uFSu3NK9G8e3NGCpBZAmE=;
        b=et9uS/Sw/S5fTXKrURYuI/+FaPgzR3c4xhefgWhCVtMJ4scxoUZURVgHx057oIboVq
         gtufgVon5VAl5EBViuJshVrcEKM8Y5eEq2VEgKCKtXjHuQc+TfSlyRTIw7t8Ukh8GPKx
         DoVP9388NJDLJsACZJIT1LQY6irEBKqhzUsQs2pbN05x9DyI7t/fVggOuDDCh6uNnPmX
         04rmYlT4fT6UA565pcQ7PZFcyRrXpJwankqizxtrkahXNYEd04qm5cWUC7Fy+0SFeyfu
         L+nBgPHgGh9Jt+XnbFav5E2eoUHQuXjuNmoLeBXEj+WFTnF+T9xkUnOkgWXNztt9DBvo
         khxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788921822; x=1789526622;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XDP2V8qIY49+9T9tBX3aQ8uFSu3NK9G8e3NGCpBZAmE=;
        b=svpSRMQ7jTvgMxdLirbPpxLPoGpRklpATDMaaZB2SP3SHqOfkzbJ1jcTVN+gDne457
         XEKtHOCYE9/bQdn8ndTLcC6izC24ABvnauS2jLsZJgaRjt2O/lO0b1HSZDgM2q4d1APq
         zME0DcHttdUcqJKDteQBNqzT+QqUxH4ZjnjcUcuZIjjd7LUu2c/qVgurBjQUS1xh6q4i
         ADzhrmT0ie/UXn6efNA6S4ukZomN/5zxe3umTbFI0kYn1S/7SMCvqg5MLPIZd+XWQbXb
         XfirAMJ6LwkRiYQDy+3BICb54DRdDOPg4qfxfvHvG7X8GZphi/Gtk+aGCVN3BJRVz7Aa
         1eGw==
X-Gm-Message-State: AFuF++nZ96hXZFeBoR7jaj2kS3lzWKjMbbFQobGFz5clXd/+1g/wDybE
	xV275v+Xv6Pv8QM6ONUoX8EQAWPpGDhfAjFDzk79HiymeaDqXrpwTzVs
X-Gm-Gg: AYBFou1/sEgJkkyMBkj2gJ5gKLjzb/apKmxQSDm2/fOLc1cUXiCmUvgsVzfd4hPcjsh
	jF7j67OoFH9xdY3Tbj010KIGfsEGu0xPjkh4Fo4HRajbRnTjRdiVHjpJrw8ekWl3PvkAgI7BLM7
	uN6k3kYoa1YdM+9eQVbllz7Vg55n7xgQgk967o7YDR6WLOtVn17rTMbWMw+I4c80cQrkFev7fSk
	lyz2UtSIaeWQLm2PR5XYqefBajRCEeODDNGJknENJedXR7cBmANn1/HYJV42pLXXekyB57T+tAd
	0/NXZ1Hac3Gedn2Yq9STjOxYLFMMy7opfjY+C+TMIxyyggC2J23Pz+BQr13st0OW1miNJfYtxZZ
	LR+yLD5XwwOZ09gWy+PoF8jxwebVifngP8Jvnuc2jGGBes6vBipQ0K3W5XDMiHBqgCLyxkB0uRx
	6n8u2xrlC1OH3ve15WgMChRwEEKPIgVRNxwX/8Ltl+Bl9ZkJzXAWjodPh0H4Ht6ojMmsbMjJZn7
	K1+QsPFkoyFvmgu1fBjGOdzUzWl7UJF9pRh4gPidumBzGrEGnxZx6kHfCm2EexxgNAgUg==
X-Received: by 2002:a17:90b:2542:b0:398:9beb:5c17 with SMTP id 98e67ed59e1d1-39b2620a2bfmr45266255a91.18.1788921822122;
        Tue, 08 Sep 2026 19:43:42 -0700 (PDT)
Received: from localhost.localdomain ([240e:46d:2100:5b4d:69bd:afbf:d6ca:3462])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b260cd15asm29292957a91.4.2026.09.08.19.43.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 08 Sep 2026 19:43:41 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	song@kernel.org
Cc: live-patching@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v8 0/9] livepatch: Add support for scoped atomic replace
Date: Wed,  9 Sep 2026 10:43:15 +0800
Message-ID: <20260909024324.16002-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Atomic replacement is currently all-or-nothing: a livepatch with
"replace" set either atomically replaces all previously installed
livepatches, or - with "replace" disabled - it replaces none. There
is no way to atomically replace only a selected set of livepatches
while keeping the rest running untouched.

We previously proposed a BPF+livepatch method to enable rapid
experimentation with new kernel features without interrupting production
workloads:

  https://lore.kernel.org/live-patching/20260402092607.96430-1-laoar.shao@gmail.com/

In the resulting discussion, Song and Petr suggested that it should be
possible to selectively replace or skip individual livepatches.

This patchset introduces a more flexible model using two new fields in
struct klp_patch:

- provides: an unsigned int id identifying the replacement scope of
  the livepatch. Livepatches that share the same provides id replace
  each other, so at most one livepatch of each provides id can be
  enabled at a time. By default (provides=0), every livepatch that
  does not declare an explicit provides id belongs to the same scope:
  loading a new provides=0 livepatch atomically replaces the
  previously enabled one.

- obsoletes: an optional array of unsigned int ids specifying
  additional provides ids to be replaced. This allows a new patch
  to explicitly obsolete patches from different scopes.

A new livepatch atomically replaces any existing livepatch that
satisfies any of the following conditions:

  1. it has the same provides id as the new patch,
  2. its provides id is listed in the new patch's obsoletes list, or
  3. the new patch's provides id is listed in its obsoletes list
     (the obsoletes relationship is symmetric).

Condition 3 keeps the model symmetric: a patch that declares "I
obsolete provides id X" implicitly accepts that any future patch with
provides id X may also replace it.

Previously, setting 'replace' to 0 was the only way to keep
certain livepatches persistent on the system, forcing developers to
disable atomic replacement entirely. With the introduction of provides
and obsoletes, developers now have a selective option to keep specific
livepatches persistent while maintaining atomic replacement capabilities
elsewhere.

IMPORTANT:
- this design deprecates the traditional non-atomic-replace model.
- the behavior of replacing all non-atomic-replace livepatches with a
  single atomic-replace livepatch is also deprecated.

The new "provides" and "obsoletes" attributes are exposed through
sysfs and the kselftests cover the replacement and coexistence
semantics described above.

At present, KLP state, shadow variables, and callbacks are not integrated
with the new provides/obsoletes mechanism in this patchset. Support for these
features is deferred until Petr's klp-state-transfer infrastructure is
completed and merged:

  https://github.com/pmladek/linux/tree/klp-state-transfer-v1-iter12

It is based on livepatching tree's for-next branch.

Future work
===========

For backward compatibility with the old non-atomic-replace model, we
might consider adding a new "noreplace" flag. A livepatch with this
flag set would not replace any other livepatch, but it could still
be replaced by an atomic-replace livepatch. This would preserve the
behavior of the original non-atomic-replace model.

We can revisit this once a real use case for the non-atomic-replace
model emerges.

Changes
=======

v7->v8:
- fix the commit log and documentation regarding `--obsoletes`
  (sashiko-bot)
- remove the `--obsoletes` validation requirement from klp-build (Josh)
- explicitly log the skip info for the deprecated `replace` attribute on
  the new kernel
- implement symmetric obsoletes (Petr)
- rename test module files for clarity (Petr)
- add CONFIG_KLP_HAS_PROVIDES (Petr)
- avoid duplicate test module source files (Petr)
- documentation and commit log improvement (Petr)
- add more selftests for provides/obsoletes (Petr) 
- other code cleanups (Petr, Josh)

v7: https://lore.kernel.org/all/20260825114641.80452-1-laoar.shao@gmail.com/

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

Yafang Shao (9):
  selftests/livepatch: Clarify test module file names
  selftests/livepatch: Adapt atomic replace tests to provides/obsoletes
  livepatch: Make klp_find_func() non static
  livepatch: Call klp_init_patch_early() earlier
  livepatch: Implement provides and obsoletes for scoped atomic replace
  livepatch: Deprecate stack_order
  selftests/livepatch: Add provides/obsoletes test scenarios
  selftests/livepatch: Add state test for provides/obsoletes
  selftests/livepatch: Add function test for provides/obsoletes

 .../ABI/removed/sysfs-kernel-livepatch        |  16 +
 .../ABI/testing/sysfs-kernel-livepatch        |  30 +-
 .../livepatch/cumulative-patches.rst          |  99 ++-
 Documentation/livepatch/livepatch.rst         |  25 +-
 include/linux/livepatch.h                     |   8 +-
 kernel/livepatch/Kconfig                      |  14 +
 kernel/livepatch/core.c                       | 124 ++--
 kernel/livepatch/core.h                       |   2 +
 kernel/livepatch/state.c                      |  58 +-
 kernel/livepatch/transition.c                 |  15 +-
 scripts/livepatch/init.c                      |  19 +-
 scripts/livepatch/klp-build                   |  23 +-
 tools/testing/selftests/livepatch/Makefile    |   3 +-
 .../testing/selftests/livepatch/functions.sh  |  30 +
 .../selftests/livepatch/test-callbacks.sh     | 209 +++---
 .../selftests/livepatch/test-ftrace.sh        |   2 +-
 .../selftests/livepatch/test-kprobe.sh        |  12 +-
 .../selftests/livepatch/test-livepatch.sh     | 309 +++++----
 .../livepatch/test-provides-obsoletes.sh      | 628 ++++++++++++++++++
 .../selftests/livepatch/test-syscall.sh       |   2 +-
 .../testing/selftests/livepatch/test-sysfs.sh |   6 +-
 .../selftests/livepatch/test_modules/Makefile |   9 +-
 .../test_modules/test_klp_callbacks_demo2.c   |  12 +
 ...est_klp_kprobe.c => test_klp_cmdline_kp.c} |  10 +-
 ..._klp_livepatch.c => test_klp_cmdline_lp.c} |  21 +-
 ...atomic_replace.c => test_klp_meminfo_lp.c} |  32 +-
 .../test_modules/test_klp_meminfo_lp2.c       |   1 +
 .../livepatch/test_modules/test_klp_state.c   |  37 +-
 .../livepatch/test_modules/test_klp_state2.c  |  45 +-
 ...lp_syscall.c => test_klp_syscall_getpid.c} |   4 +-
 30 files changed, 1385 insertions(+), 420 deletions(-)
 create mode 100644 Documentation/ABI/removed/sysfs-kernel-livepatch
 create mode 100755 tools/testing/selftests/livepatch/test-provides-obsoletes.sh
 rename tools/testing/selftests/livepatch/test_modules/{test_klp_kprobe.c => test_klp_cmdline_kp.c} (78%)
 rename tools/testing/selftests/livepatch/test_modules/{test_klp_livepatch.c => test_klp_cmdline_lp.c} (66%)
 rename tools/testing/selftests/livepatch/test_modules/{test_klp_atomic_replace.c => test_klp_meminfo_lp.c} (57%)
 create mode 100644 tools/testing/selftests/livepatch/test_modules/test_klp_meminfo_lp2.c
 rename tools/testing/selftests/livepatch/test_modules/{test_klp_syscall.c => test_klp_syscall_getpid.c} (95%)

-- 
2.52.0

