Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BF02BE057
	for <live-patching@vger.kernel.org>; Sun,  7 Jun 2026 13:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780838235; cv=none; b=n5942PivjXc0MSRMPPuqo4SseSf/5L3I75f36FpEnwMGsDHFrxDKHpJZWyM+lbCHjgSw/uWEWikqwhN+c3H2gah8DtXuQ72+3lS1dmpwjX3HvcenL/I0iErebqfHnjMOqAXpZc9NM425p65Y/U83yF9hNlfeUV52UesYRVnA2M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780838235; c=relaxed/simple;
	bh=r2w38YDm6Jo6C7DT8vrRDWab3RrMzn7vMAhPgOHdBRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KBMTFz7/VnKFHbiLYt0Srfd3Mlojtz6GApFYNz07nJ3+40YCKGv17p6oMTAwMy6Q10DBZfYX2ictHHFOGO0sHZZaobZHHFNKJnL/69llJcFRUHgu5j6GddTtL9JNSEIEjGxCSuB3lIIdCmzSMD++CGRvOFiwoLqQnqDbb7RRvXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RilAj29S; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RilAj29S"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2c0c2d792c8so22526225ad.1
        for <live-patching@vger.kernel.org>; Sun, 07 Jun 2026 06:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780838233; x=1781443033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ud8s9dgAQKP2pYmXcaHwmrljESzep5Y677MGUAKzEMc=;
        b=RilAj29Sz/WIjrXdN4L4KW39d/65Iq8hOJNhHoIa8Pm1w0XcipJN50AZt56XNsPPJa
         N7B93K+BbrKIFTkQGM5khQpb5f+spvsOSpYvZRv6mbRnVHB3cMJ5InWOpSXEI0YYgUka
         4Rev5NzV1r0z0ZBKg/VZfbaYbGaGiEJxRO6MHLbg4tjT5m+cX/d5tmhmbyWv+Ggq6Fm1
         QilFjEK+Y9CAdiGID0h8MJRaB5js//hOkzJNMvg3M1YSxERn/z5ZHBcadJpTp8KFKhZg
         rOxXsTwCphehZYdajXGvrlCs6aI1YSgVJGuAOsEnfhOKMLh1h1CsNqD4ya/uOMG2yS79
         GHUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780838233; x=1781443033;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ud8s9dgAQKP2pYmXcaHwmrljESzep5Y677MGUAKzEMc=;
        b=LAV17W8JiHe10Ip15BXIYsykTyDcuKMEwfoldD2Fl63sbRiUW9l5M7N81GxDREC/f5
         HKCZAf/4mMWlGjBYgGFeHhbLkQyArKUyHHPmhGw6uC++C5UjQGTvkhOkSS12kp37cUkV
         EMwzXYKbv/wr9ec+8kPaAqXBg6u+Hcv3KBRR0nD+U65gLF6C3mdnpgSuWrRM2M51Dy7r
         Fng8C6zpzyjxq1BIZ+QjaqN+FqXsG3IBqJrLjQ7iHkJloenJEnEtP6NwU7y7CHs5KM2x
         mtM+GDSfA5/mXBB0WS3VKnNOtzmpOm/4kMiUzn5QA0yhw3JQa+CPvOQ3rjFCu5lG7eYb
         vTxg==
X-Gm-Message-State: AOJu0Yxf2CfvxWs7cnhLnUd4HobnsQsXtFplsPeaw6VIUKDvfbBntYm2
	HgWL5gXYca3i3xWgkUuKBhzjsmotVkTJeZjFdiYE+QAi4xbdbVorXADc
X-Gm-Gg: Acq92OFbQMWvfw5LOgbo+MczJIOmsvxvgzhgIkXXVfAojjilC8cWmue4RCXQ+CIvhiM
	lrU2+R2shzomqwUXaFV9ME4bDUCI0uUA4WjGRg4JzvZpvyz8bYEJ8K8wtlg2zTTe/m9ibgmL36g
	/bpghuq6siZcTz3Q3aWgMEcOel3uLhm6swY1/XrNIUfh93GkD1XGI7uwakN6G0gi9KROnWzobGW
	5zupQhQNF/rZpWNFbrucF33yDBen+QwdXHgYoHPdqE0j8S9xLnsQTDwiUo0JerB5dF/2mhfs5Hn
	Kq1cwAa8UMO18t9PDC2ZKabczcaNL+oBzmrqI2gKYNgS1qyompQFel573qqFimnDxGDHbAQ/SO8
	yuop5Ym3OwTmWZBzLh67Clea55jQsDqk3NluPRfm3CwM5668kDazXBxaCkZwAJ8ccbecgwv3v/I
	WS2iuEFcIbpW2QggO7cpR7XWRbjMvNT3RsVjLtOHmkxkRFEDPD09Pcep9ffn6kMgSRNXPXIo0MT
	5gzAuA0G+FQ
X-Received: by 2002:a17:902:d58f:b0:2bf:195d:21d2 with SMTP id d9443c01a7336-2c1e7e44e91mr130091865ad.16.1780838232944;
        Sun, 07 Jun 2026 06:17:12 -0700 (PDT)
Received: from yafangs-Air ([240e:46c:a410:280:a000:69ce:6442:2055])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609e627sm153004985ad.52.2026.06.07.06.17.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 07 Jun 2026 06:17:12 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	song@kernel.org
Cc: live-patching@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v3 0/7] livepatch: Introduce replace set support
Date: Sun,  7 Jun 2026 21:16:52 +0800
Message-ID: <20260607131659.29281-1-laoar.shao@gmail.com>
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

This patch introduces 'replace_set' to provide finer-grained control over
livepatch management. The core rules and behaviors of a replace_set are
defined as follows:
- Livepatches sharing the same replace_set can mutually replace each
  other.
- Only one livepatch within a given replace_set can be active at a time.
- Livepatches belonging to different replace_sets can coexist on the
  system.
- Livepatches in different replace_sets are prohibited from modifying the
  same function.
- Livepatches in different replace_sets cannot use the same state ID.

Additionally, this design deprecates the traditional non-atomic-replace
model. Previously, setting 'replace' to 0 was the only way to keep
certain livepatches persistent on the system, forcing developers to
disable atomic replacement entirely. With the introduction of replace_set,
developers now have a selective option to keep specific livepatches
persistent while maintaining atomic replacement capabilities elsewhere.

At present, KLP state, shadow variables, and callbacks are not integrated
with the new replace_set mechanism in this patchset. Support for these
features is deferred until Petr's klp-state-transfer infrastructure is
completed and merged:

  https://github.com/pmladek/linux/tree/klp-state-transfer-v1-iter12

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

Yafang Shao (7):
  livepatch: Fix NULL pointer dereference in klp_find_func()
  livepatch: Move klp_find_func() into core.h
  livepatch: Support scoped atomic replace using replace_set
  livepatch: Deprecate stack_order
  selftests/livepatch: Update tests for replace_set
  selftests/livepatch: Add test for state ID conflict across
    replace_sets
  selftests/livepatch: Add test for function conflict across
    replace_sets

 .../ABI/removed/sysfs-kernel-livepatch        |   9 +
 .../ABI/testing/sysfs-kernel-livepatch        |  14 +-
 .../livepatch/cumulative-patches.rst          |  23 ++-
 Documentation/livepatch/livepatch.rst         |  21 ++-
 include/linux/livepatch.h                     |   5 +-
 kernel/livepatch/core.c                       |  65 ++-----
 kernel/livepatch/core.h                       |  21 +++
 kernel/livepatch/state.c                      |  51 ++++--
 kernel/livepatch/transition.c                 |  11 +-
 scripts/livepatch/init.c                      |   6 +-
 scripts/livepatch/klp-build                   |  16 +-
 .../selftests/livepatch/test-callbacks.sh     |  33 ++--
 .../selftests/livepatch/test-livepatch.sh     | 159 +++++++----------
 .../testing/selftests/livepatch/test-state.sh |  34 ++++
 .../testing/selftests/livepatch/test-sysfs.sh |  91 ++--------
 .../selftests/livepatch/test_modules/Makefile |   2 +
 .../test_modules/test_klp_atomic_replace.c    |  10 +-
 .../test_modules/test_klp_atomic_replace2.c   |  55 ++++++
 .../test_modules/test_klp_callbacks_demo.c    |   6 +
 .../test_modules/test_klp_callbacks_demo2.c   |  10 +-
 .../test_modules/test_klp_livepatch.c         |   6 +
 .../livepatch/test_modules/test_klp_state.c   |   4 +-
 .../livepatch/test_modules/test_klp_state2.c  |   4 +-
 .../livepatch/test_modules/test_klp_state4.c  | 163 ++++++++++++++++++
 24 files changed, 507 insertions(+), 312 deletions(-)
 create mode 100644 Documentation/ABI/removed/sysfs-kernel-livepatch
 create mode 100644 tools/testing/selftests/livepatch/test_modules/test_klp_atomic_replace2.c
 create mode 100644 tools/testing/selftests/livepatch/test_modules/test_klp_state4.c

-- 
2.52.0

