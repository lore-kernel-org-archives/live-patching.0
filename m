Received: from mail-pj2-f38.google.com (mail-pj2-f38.google.com [74.125.227.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DD42F12DA
	for <live-patching@vger.kernel.org>; Wed, 30 Sep 2026 03:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790737433; cv=none; b=Na4uro1rYjudSVWh8P/PU3g5cPOb97F+1RypYwse10kafQaEE6dSvckDaKujB3jSL8z5p94m+3m87uq367VdIGTapUiupMw0IPj5Ampp/Xn2XeE3INyppJnVC0L7UtQTrcXOk5itsoKRiD79HycTEeqr9ljTKpdnoZZqw3N8FPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790737433; c=relaxed/simple;
	bh=ep00U39hbTFUwRlN8IfNQL3j4umFl7h4AnzXjtPgnAM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T8B4+cu5SYtidvhVbjjB8arzK8PsS70kTpjzwaVax+1meM3DrE3vYq9o7VVa9wOCC9VkhgN452zIWXcsECUzdr/q9oLjcgwytAsjdUdEz3KBAKRWBEqHR6gl5O4y5Bin7665iKlQAKRL2+5VqEYPDTmtFdDT8Zx6rofdvZHHTSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cXgAs41V; arc=none smtp.client-ip=74.125.227.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cXgAs41V"
Received: by mail-pj2-f38.google.com with SMTP id 98e67ed59e1d1-3a4b940d3d7so383557a91.1
        for <live-patching@vger.kernel.org>; Tue, 29 Sep 2026 20:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790737431; x=1791342231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=j7GRrGF3v7lk2bQhIPckOujZMCftFPp447HrdTLq26Y=;
        b=cXgAs41VU+Xek9W780JexNuhn7ZkYnp1rcZGyXysJwuakHpSJ0C5MT3lv/ZCHzDitD
         MWBk5K7naP9r3W1fZImjctQNleLMFhf524OrjsoAhBKC89mnpgUSO70AstjxDlFRkXAn
         VOQKOWHy0kup4+ci8RJC2W6pKu2uXe2+ZPmwYvbyl6Fkna3vF/9i82RIbLIGNn9O9bVM
         VR/PzwpnTiTChbkK85nE0bsgc5uuUhgimp9+x50Omrdzg9OaRUq/0bsHZCz/aWS0BPUe
         MWOs0gL+aFh4X+uAGReQhvGLCAo3QUB8pSnB4n1FErCJEFjWqHyMs9pLaqaJEa8dV9zL
         3/Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790737431; x=1791342231;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j7GRrGF3v7lk2bQhIPckOujZMCftFPp447HrdTLq26Y=;
        b=baEZiG0Kceb7mzFNelJNKsYQVfaa9MB2iRSAFhip4S0wRVS+qS/lU8vMHxVJq7R7Zr
         zBuwhUcgoPT+Hg/7opyORy3VwHJPRb9xsTiPsCkH/g/NF3l5HSFA1dV9BfHCmCsuh49j
         a13NqD91sd0zs4jrZbjVDt4VWrT8eHih4cYuIGSuFkY4AOw/9bp8p6pN46GK+II0EbzT
         dtM6hTi8j1j2kvABwnhdwUXzB+b/Z1yomXeHSM1P0E6ohuMnDk/3v+HMgU53NtIFOV9s
         L7w2hEHvmQaJgm3J3zj7MJjFdmbb8z9w8w8rNl7HdVm0Rl6JQx2u1hqCvHxcAcqvUqSY
         17Yw==
X-Gm-Message-State: AFq9FYLfMTMkOmPo891kyQ69Qq/VocSX5aBe/+7x7ch3VaT3J+VgYFj3
	lZluZ0ASFUWGBHiVH1OOjO1q32gr012yFqqjYG1LdZQCL//2RNIEX1JKgYG7c9DWLxg=
X-Gm-Gg: AYBFou0lsfgvQ1Zimx9POOJ91qH2LKPe9NoO3eynSkPWR1eMSgoJ7gEnmTZMzQPMVaa
	hC19WMKGTeoTovPpcQiZ+83U0Hod+DqEjZZRWYnMIzqd+5hN4YnwKIthOS1w5GcDd+xWGajPqKw
	erL4QkhsjwzwdkgqDCS+EPUU+rDVxYpRmal8x14/zRAKMmox/GxQUUqDGmVXxxexY77PCpQSFAt
	h96e2To5WeqZ5LuDcS0SPFXnpJwusxM5wuEmQGoPGdh/N54y7nnIs8VUIW0Zjr0GX4N9uohP9Ul
	R+yfuIYbLXMsF4e79fgDY8RlEYqtNLhwtSj+J8PJShyKH0ceBnlMaJdc8wa2EQJn5kersk0wD7j
	fy9rKwhEIm91yikWiB5/NGb8rs3jElN1vsB/B1LKuqs5DeZECpO1oCY0i/x1xQu2r2secFs+XUg
	J9Wka0DTZdNJLh/7aI1gaS03DJplr5SjtOvjKRRZqtW0oo+O1bvN+sdGCgG4YLCGHBf+LgWBF2t
	dijmZxkjfiSxSAGTmOZGPw2aS4hjiunHqEH8OXqrZE2FMhvlr+h+qS1t1KyUKNN5BNBXQ==
X-Received: by 2002:a17:90b:4fd1:b0:39e:6c69:f46e with SMTP id 98e67ed59e1d1-3a4d18aa534mr54917a91.45.1790737430804;
        Tue, 29 Sep 2026 20:03:50 -0700 (PDT)
Received: from localhost.localdomain ([240e:46d:2100:5cb1:9131:1918:6e98:b864])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4cabe63c0sm911937a91.9.2026.09.29.20.03.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 29 Sep 2026 20:03:50 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	song@kernel.org
Cc: live-patching@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v10 0/9] livepatch: Add support for scoped atomic replace
Date: Wed, 30 Sep 2026 11:03:14 +0800
Message-ID: <20260930030323.14396-1-laoar.shao@gmail.com>
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

v9->v10:
Various comments from Miroslav:
- rename skip() to skip_exit() and skip_test() to skip() in #2
- define CONFIG_KLP_HAS_PROVIDES in #2
- add a comment about the CONFIG_IKCONFIG_PROC fallback in #2
- adjust the order around `CONFIG_KLP_HAS_PROVIDES`
- update the comment above klp_add_nops() and
  klp_unpatch_replaced_patches()
- add verification step for `provides 0 coexists with provides 1` in #7

v9: https://lore.kernel.org/all/20260913024228.72317-1-laoar.shao@gmail.com/

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
 kernel/livepatch/core.c                       | 136 ++--
 kernel/livepatch/core.h                       |   2 +
 kernel/livepatch/state.c                      |  58 +-
 kernel/livepatch/transition.c                 |  15 +-
 scripts/livepatch/init.c                      |  19 +-
 scripts/livepatch/klp-build                   |  23 +-
 tools/testing/selftests/livepatch/Makefile    |   3 +-
 .../testing/selftests/livepatch/functions.sh  |  42 +-
 .../selftests/livepatch/test-callbacks.sh     |  43 +-
 .../selftests/livepatch/test-ftrace.sh        |   2 +-
 .../selftests/livepatch/test-kprobe.sh        |  14 +-
 .../selftests/livepatch/test-livepatch.sh     | 108 +--
 .../livepatch/test-provides-obsoletes.sh      | 648 ++++++++++++++++++
 .../selftests/livepatch/test-syscall.sh       |   2 +-
 .../testing/selftests/livepatch/test-sysfs.sh |   6 +-
 .../selftests/livepatch/test_modules/Makefile |   9 +-
 .../test_modules/test_klp_callbacks_demo2.c   |  12 +
 ...est_klp_kprobe.c => test_klp_cmdline_kp.c} |  10 +-
 ..._klp_livepatch.c => test_klp_cmdline_lp.c} |  21 +-
 ...atomic_replace.c => test_klp_meminfo_lp.c} |  32 +-
 .../test_modules/test_klp_meminfo_lp2.c       |   2 +
 .../livepatch/test_modules/test_klp_state.c   |  40 +-
 .../livepatch/test_modules/test_klp_state2.c  |  48 +-
 ...lp_syscall.c => test_klp_syscall_getpid.c} |   4 +-
 30 files changed, 1246 insertions(+), 245 deletions(-)
 create mode 100644 Documentation/ABI/removed/sysfs-kernel-livepatch
 create mode 100755 tools/testing/selftests/livepatch/test-provides-obsoletes.sh
 rename tools/testing/selftests/livepatch/test_modules/{test_klp_kprobe.c => test_klp_cmdline_kp.c} (78%)
 rename tools/testing/selftests/livepatch/test_modules/{test_klp_livepatch.c => test_klp_cmdline_lp.c} (66%)
 rename tools/testing/selftests/livepatch/test_modules/{test_klp_atomic_replace.c => test_klp_meminfo_lp.c} (57%)
 create mode 100644 tools/testing/selftests/livepatch/test_modules/test_klp_meminfo_lp2.c
 rename tools/testing/selftests/livepatch/test_modules/{test_klp_syscall.c => test_klp_syscall_getpid.c} (95%)

-- 
2.52.0

