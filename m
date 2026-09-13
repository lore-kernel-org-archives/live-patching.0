Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FB81D7E5C
	for <live-patching@vger.kernel.org>; Sun, 13 Sep 2026 02:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789267386; cv=none; b=ngRD+RThNPJSQdH05JUiccxysCrDLc7t6Mu1vjFnybtu1xdJWWArV9pVKmfYoMIDu7RVO+LpbERmeE/ggKb7kmIoayTx0A6tkBMQIGgIkPj+t8a0Y+DlivR/Aio38Iz1IXrpcfJiUeNuIDsexhZI7/h8KTKlIpbn4BpJkLMLWlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789267386; c=relaxed/simple;
	bh=QIvXaOHubwVFkmIfNhr9Fhr2XRx61hVJemnGUQomFhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HSPTl4FVHW1OfNSSfbSUq4qk7AX1i2WfEa1b8HMtoDuqBtj9y2tj7a1USsiW9rLQ4pOu4v2dsO9btCGyNITAsGRSToKzZ11kpdqFGtoYQWqCDodgtZZKA67OP3ARbr/9ZfAyzL+OfkLRuRc94gEmXFYpGArXlS/w2eB/g2NeWN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CFcQ/NSv; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFcQ/NSv"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cc4aa02a269so1743888a12.2
        for <live-patching@vger.kernel.org>; Sat, 12 Sep 2026 19:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789267384; x=1789872184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zHPuNLoUeHsVtKkuKbIVaw65czHDimgeu+zYCrNuSZ8=;
        b=CFcQ/NSvlUd96p6/zWqySbtXV6wpO8Yd/VDCmdN39SKDFjT5HRgiQbmPeXN5qKRpse
         4EW2yBFS3lj62ddMx4FQgQfE9OTxXtU3PkuMlZNaJGu/9Ibw0GNnFWMEmiXFco0N9hlH
         tf6rAH3vs4QjHYEJmBTqrbpIoqP4tlbhCsQtfnHiE1PENqEzQu6SD7b0DhkEjiDAjQKp
         JwEOL1znv4JQZvjXegwYuloMMWlhDi8DUX5/sHO0eGH13Ppn7OVmwRIyNBeOHARMn/Wi
         kdC5Z/tqCEZF0HiPK1KZXjdzdMIcy/gSgHl9Q0BeuNCGTkGYeUkoInG4HYffjRNDHx28
         GEoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789267384; x=1789872184;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zHPuNLoUeHsVtKkuKbIVaw65czHDimgeu+zYCrNuSZ8=;
        b=S1LpEyVQS3q7fh+YqtcE7TLl7N8qWeUilUPg6REXlFx2Y06TdG1by4izAGmdZ6DP8c
         Y1IUz0DaKH8cfzVQcLl6uS0arzEk895hA9DQdLdfITuCchJvwmzdvXEZyP5Cv07YMvnM
         eE30SFuAbQbdMVPRlGXylWNpnxsHdUJrJS0ejvIy5Zok4i6mW2/cxKGiGPK4mPpd/tx0
         CWgUGBiHib3eS2dOP5KdbuHdNfSPWyCO9VWTfENx4VHFteUOMcxg98fHpDoS9gUADzgw
         jKauNkZDWi0+kR0wEXTSeS07JcTOQGgGs2Y6dkBdJsKuJfAHelhBmUgMPb1wbLeczljJ
         0DuA==
X-Gm-Message-State: AFuF++niUkIUrQAHl0oAWPcflQgzGYbLeXqhB61b5lsQQvGYz/JX8O7C
	dWZRB8PahPGniviCdqYbdPSEYsoYybGtTB1UKBcXyrwNQEy4GynkQTDT
X-Gm-Gg: AYBFou3UQYQ7bbBqrvn+aS4ZjV4N7RpvLBL/CCyFrlwrw3FadMq/IgesZezxiXF91nJ
	wFbKeDNgMR7XLMxM+1g0L3b7UTf8LBxLx/875866alhZMhVyhRkrWm4Efg/BT86wyzdFAbar5XY
	CYNRha39P88XMGeCIc7SKkTIOF9zwtUt1Y6TrWX0waUMr3CNIv0DveDm12OE55bQhNmdd01UmuW
	OF/zHfkZUKaiESesuXomBPpnnTVa4DP+u0DNbYTV7dofkaf6t01iModpf1qPUbCwlDoVHMYYJ/P
	IltUan23nBWp60xRyd3wel153LSTqcfIAaF16fBYjjOpStGc+giEYh7jyHidjzw664HzxKhqqqf
	Ndeai8DVIcoL0UZCE2g7n9guA/TVDf5e+s1bVQBclDPOH2do1+w8092vyV3u0wBH31+S6AdcMXU
	tvwqlswjZvYIzg58qDtjqeG6VnLsRyQ74xhPQrLmiyUTkcwFtYzNSFgbFC7kS6a7RoxHwwTPo2x
	rmAy8N3QFKxgUPqCcHAtOS4PPr0Q/7wB32eQD6EQQCQz77F7OyK2xr5/EGIMvw7GKPGLQ==
X-Received: by 2002:a17:90b:588d:b0:399:1f8b:d255 with SMTP id 98e67ed59e1d1-39d9bbc823fmr19930702a91.5.1789267383920;
        Sat, 12 Sep 2026 19:43:03 -0700 (PDT)
Received: from localhost.localdomain ([240e:46d:2000:1e66:594b:84e9:394f:396d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d994cc978sm12730756a91.9.2026.09.12.19.43.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 12 Sep 2026 19:43:03 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	song@kernel.org
Cc: live-patching@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v9 0/9] livepatch: Add support for scoped atomic replace
Date: Sun, 13 Sep 2026 10:42:19 +0800
Message-ID: <20260913024228.72317-1-laoar.shao@gmail.com>
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

v8->v9:
- extract the replace-related test scenarios into functions in patch #2
  (Song)
- make the state module parameters read-only to avoid a potential
  state leak if tampered with after load (sashiko-bot)
- verify that /proc/meminfo is no longer patched after the atomic
  replacement (sashiko-bot)
- unload the coexisting state livepatches in LIFO order so that the
  console_loglevel is properly restored (sashiko-bot)

v8: https://lore.kernel.org/all/20260909024324.16002-1-laoar.shao@gmail.com/

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
 .../selftests/livepatch/test-callbacks.sh     |  43 +-
 .../selftests/livepatch/test-ftrace.sh        |   2 +-
 .../selftests/livepatch/test-kprobe.sh        |  12 +-
 .../selftests/livepatch/test-livepatch.sh     | 108 +--
 .../livepatch/test-provides-obsoletes.sh      | 643 ++++++++++++++++++
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
 30 files changed, 1215 insertions(+), 238 deletions(-)
 create mode 100644 Documentation/ABI/removed/sysfs-kernel-livepatch
 create mode 100755 tools/testing/selftests/livepatch/test-provides-obsoletes.sh
 rename tools/testing/selftests/livepatch/test_modules/{test_klp_kprobe.c => test_klp_cmdline_kp.c} (78%)
 rename tools/testing/selftests/livepatch/test_modules/{test_klp_livepatch.c => test_klp_cmdline_lp.c} (66%)
 rename tools/testing/selftests/livepatch/test_modules/{test_klp_atomic_replace.c => test_klp_meminfo_lp.c} (57%)
 create mode 100644 tools/testing/selftests/livepatch/test_modules/test_klp_meminfo_lp2.c
 rename tools/testing/selftests/livepatch/test_modules/{test_klp_syscall.c => test_klp_syscall_getpid.c} (95%)

-- 
2.52.0

