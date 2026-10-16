Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CE9348C7D
	for <live-patching@vger.kernel.org>; Fri, 16 Oct 2026 05:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792129047; cv=none; b=cFxxbyfyfTC6aZgdCSSPo58FFasW2ZlW+ksXJ7iRd2Zn5rUhmxuFLx2iAEa7Yxs4i8lg8c+6GEJCt4NQ07t3iqYtXK/+rpfzr9ngfBrPR1M3TZ8qU9fSt/iim6IK7A7lWFHWj2d5Tm5T3vABIElLZM/B1lUBB15AsfVqPExhZ+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792129047; c=relaxed/simple;
	bh=RUkzYtGPjT2WAtI/jQXbUbMf+qWTTzAKreitklQZ2Fg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EdyHJxRv2rUVftQK3DgJbWMJ5jN4kyT+gbjwucCpwtHi//PS7OMgKfqUPRI34ZOsmImlux14Dky45xM2O8YeoaJoLFtL9nuqiUf51DPsxZk/08Zcr38uJ3JQT//OYsKWvlpHxzS1U/4pYOvnBeWNx1ifzb1/p1I60MNv80ARVng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pK9l08Kw; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pK9l08Kw"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2e49fbf92aaso36089425ad.0
        for <live-patching@vger.kernel.org>; Thu, 15 Oct 2026 22:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792129045; x=1792733845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JKliuj2KN2RDS6IuscIb23va8VANwq5YgN/BtmMA/KY=;
        b=pK9l08KwUoQ2gLjroWciJ4g1lIFCs8Apw2YkoUBfUOd0VuYbIyE5K2RHo0koI7FYOY
         OzMdb9qkQpFvcm6Psqkygt10hGDy/KyDHpeh4CC1DfsiCmgsw7I0y6I4/pvDRJS1jAlE
         FxsMlXR5JXpNpDyN4z8PyXNj7u2eoTr/HaV3NCk5A0PKT5pTjR/rj6z5HcgaC8Ef7W5r
         5MTzNqVK0vTcctmPzV73N3l7WkbFu7+TJ0WxkRW+5g890dP+XpRRBaxSTmGR7wUro0Gd
         9s9NVlou3+4Ou17eCTZwGk/8O84ewfiH57/qcObmx/4Satmt5fyjp+i+LtpqnZ04AMyE
         p5Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792129045; x=1792733845;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JKliuj2KN2RDS6IuscIb23va8VANwq5YgN/BtmMA/KY=;
        b=KNhAZQlUMqAbB7zLBMuVtYfXyPQxieblznuyngxzlP3AdbUDHOvTO6Sd1HxgtViE69
         4nm0T2DzG2URnOQUCaill02z4O5q9dZ2e6NwrOBag0ZxyL6C3BWgg6L/4WaaFYU8rOAH
         r+BxIwy4kgkYZbk+B6CL1FSuphyJ2TBEiW68c+BWYQ31KPAIi7xs96mCPAGFTN0V1WDq
         Gj5fJzQQLt14SGSzoRlV9/7uhYoW2NCpVyJatYVlPKh0uNAKJFPV3Orn8IhtkmlsWFzc
         zQiv1LjCwMLc4nfDM/+fBiGRom8HljtU0+hs+Er7Hy3bINch6QAShDLEQZs13pqpdDZR
         Q2lw==
X-Gm-Message-State: AFq9FYK8CwqnA9x9aiYPFdL5E2f7eK3/d5YIY7GqS6oYIMHYIol4+KqA
	pGFBfelbKYjYzi+nmM28Gc3vHTC5luRx0zvp9nz+PBNOJJKSb/DXWLqN
X-Gm-Gg: AYBFou0GXtjQa9fmmBfDGURqCi0Na+/5Du//mOEi6k84XAryWTDyZud4wLPCM45VEaV
	6gG1VWHTC1DxmM1vF9FuOLhEXWQDsbluykoRCESD2M/KFl/9QGiPbAHLJq829y5J6rtC7habZKB
	5V0aVof2pWvqZ4g+ZBpfIdFNS5b4iiBpFEnJNF+NQTxsodh28BOnlKbOxbzLXvnFNAk6lJT+gik
	4U2DF/62tpg4VsoY1AVevYpQhtV9aNCAuTaMHESAQoonXkcNP7Cs3AFDR/QUTp4JE0qko4NzFEY
	VeE1GvktazIAPAA79HpVEa+VRRGNTKQxpRQ8xQpnH5CiZ7cRU0zJiaqEHmJ7s7jWV8ZWIrlJFVO
	BYuJJIXPxa29JDJZG036PXPsknkcZzJE2dxI1jZRocnw2/vs8lK7MM2ukBoriMos8xDfUJKMB+b
	FEC3MDaODAxMRjgdzHn2CwpLlb/pE7PwghrRvwu7rq2eZnZiLnUxyavzM2JC5TciwO0zmeD+hAT
	zixMgDDVNG/ygFI92CDjZa/sjzfB2fBhqEQB8SiO/vlx5bA/nsmLdde/Z5Ag6BK1Z30lekxeNg6
	00E=
X-Received: by 2002:a17:902:d2c5:b0:2e5:a355:56e4 with SMTP id d9443c01a7336-2e8428a1d5cmr180287365ad.11.1792129044842;
        Thu, 15 Oct 2026 22:37:24 -0700 (PDT)
Received: from localhost.localdomain ([240e:46c:5700:24f:f979:e84b:46de:615c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e804d2dsm4724115ad.17.2026.10.15.22.37.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 15 Oct 2026 22:37:24 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	song@kernel.org
Cc: live-patching@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v12 0/9] livepatch: Add support for scoped atomic replace
Date: Fri, 16 Oct 2026 13:36:59 +0800
Message-ID: <20261016053708.47089-1-laoar.shao@gmail.com>
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
satisfies either of the following conditions:

  1. it has the same provides id as the new patch,
  2. its provides id is listed in the new patch's obsoletes list.

A new livepatch that does not replace an existing one can coexist
with it. In this case, the two livepatches must not modify the same
function, or use the state with the same id. Any attempt to load an
incompatible livepatch will be rejected by the kernel.

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

At present, KLP state, shadow variables, and callbacks are not
integrated with the new provides/obsoletes mechanism in this patchset.
Support for these features is deferred until Petr's klp-state-transfer
infrastructure is completed and merged:

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

v11->v12:
Comments from Petr after the LPC discussion:
- document the rollback pitfalls in #5
- warn about installing more livepatches in parallel in #5

v11: https://lore.kernel.org/live-patching/20261008095830.26308-1-laoar.shao@gmail.com/

v10->v11:
- check $HAS_PROVIDES_ATTR positively in #2 (Petr)
- document the conflict semantics in #5 (Petr)
- per the LPC discussion, drop the symmetric obsoletes semantics

v10: https://lore.kernel.org/live-patching/20260930030323.14396-1-laoar.shao@gmail.com/

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
 .../ABI/testing/sysfs-kernel-livepatch        |  27 +-
 .../livepatch/cumulative-patches.rst          | 127 +++-
 Documentation/livepatch/livepatch.rst         |  29 +-
 include/linux/livepatch.h                     |   8 +-
 kernel/livepatch/Kconfig                      |  14 +
 kernel/livepatch/core.c                       | 124 ++--
 kernel/livepatch/core.h                       |   2 +
 kernel/livepatch/state.c                      |  57 +-
 kernel/livepatch/transition.c                 |  15 +-
 scripts/livepatch/init.c                      |  19 +-
 scripts/livepatch/klp-build                   |  23 +-
 tools/testing/selftests/livepatch/Makefile    |   3 +-
 .../testing/selftests/livepatch/functions.sh  |  42 +-
 .../selftests/livepatch/test-callbacks.sh     |  43 +-
 .../selftests/livepatch/test-ftrace.sh        |   2 +-
 .../selftests/livepatch/test-kprobe.sh        |  14 +-
 .../selftests/livepatch/test-livepatch.sh     | 108 +--
 .../livepatch/test-provides-obsoletes.sh      | 656 ++++++++++++++++++
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
 30 files changed, 1270 insertions(+), 245 deletions(-)
 create mode 100644 Documentation/ABI/removed/sysfs-kernel-livepatch
 create mode 100755 tools/testing/selftests/livepatch/test-provides-obsoletes.sh
 rename tools/testing/selftests/livepatch/test_modules/{test_klp_kprobe.c => test_klp_cmdline_kp.c} (78%)
 rename tools/testing/selftests/livepatch/test_modules/{test_klp_livepatch.c => test_klp_cmdline_lp.c} (66%)
 rename tools/testing/selftests/livepatch/test_modules/{test_klp_atomic_replace.c => test_klp_meminfo_lp.c} (57%)
 create mode 100644 tools/testing/selftests/livepatch/test_modules/test_klp_meminfo_lp2.c
 rename tools/testing/selftests/livepatch/test_modules/{test_klp_syscall.c => test_klp_syscall_getpid.c} (95%)

-- 
2.52.0

