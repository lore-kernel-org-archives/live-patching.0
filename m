Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794274681;
	b=I4IdBwTfZWVZSMEt49Ti3pA0jkj00d3bwm9crb7wupovtev9FTp7dvvcSkb6i4VSDXmY
	 d5ZEwk/TXurhwQ+EWinpB7nV9Nw+tKEXm5S5PP1qmxPdixU9+6jTku4wZ7MefFG9n61/E
	 CSA/r9MbcozhiUvPJlTNNs+syUFyJiY8RhdLd8cwkdeAmTdi1Bb9yeux+o81eddy5+hCF
	 P6b37RqLH7xjbVbfUi2AaQB5c6/BxU+tp1mVmvMJcGauOzHdJKTuNi4Kt2+S4Ge/Msg2+
	 6LpT/xOi+HwKUa8PWbZAjKKVRJw8VwS7xpvMXp3Z2Pg4vN1ad7Fr5i37eW7H79tLpyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794274681;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hparW8e8dCEdVdkvsPSYalHwRzpVNFBZ+OuZJj5uJX0=;
	b=rSN3lUiXWh3NugnsQSQtHOTuDh+bv/CDT5l78AWQWDf+ubCv2CftiyI6DS+3dW+nnuPU
	 6OBvo8aI8lyHYWOye8xboYiyBBRZDvW1SbLm515AWBLrZAxbxgqRerOGAaFCiuWAu/6/C
	 6E6Y55f7lqki5xrZ/q9OhADH0hsK/T50RX1j1FHVZFbjTjKQvKUn7R+MxYp/qnAkyEZ/I
	 F4A8XLXTYSUvDuCfWtG/eNLI+Vc19H9JjLR+ORG38zOtierDWnFoIVlzI+x54RydyGde/
	 EsbdyVknngBsAYzze2AHEE5XCz15ZA2UZaDbqksBcEr3TTVESleNGOMQogiqysd0Ljg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=CywNxalX;
	arc=none smtp.remote-ip=115.124.30.99
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6820B606A31C;
	Tue, 10 Nov 2026 01:37:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6820B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=CywNxalX
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1794274676; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=hparW8e8dCEdVdkvsPSYalHwRzpVNFBZ+OuZJj5uJX0=;
	b=CywNxalXjvZi2M6RYiN7lM0nrQKXS0r23rhDdAU/fk0v/vLJ5i8ij9JPW+H75ix01IXn9PNtEwW7CGQ0OU2hdtfx6McGrDGdIpMQ+osxLMcvou+rKb1esQSJcQ2kAcdjOyB/e7rVKCeT949zzzsMPV+s6d2CBHsmrgLfusO/7p0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=36;SR=0;TI=SMTPD_---0XETOX.U_1794274671;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0XETOX.U_1794274671 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 10 Nov 2026 09:37:53 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: palmer@dabbelt.com,
	pjw@kernel.org,
	aou@eecs.berkeley.edu
Cc: alex@ghiti.fr,
	linux-riscv@lists.infradead.org,
	oleg@redhat.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mark.rutland@arm.com,
	peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	shuah@kernel.org,
	mpdesouza@suse.com,
	martin@kaiser.cx,
	kmehltretter@gmail.com,
	oliver.yang@linux.alibaba.com,
	zhuo.song@linux.alibaba.com,
	xueshuai@linux.alibaba.com,
	jkchen@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	live-patching@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v7 00/10] riscv: Add reliable stack unwinding for livepatch
Date: Tue, 10 Nov 2026 09:37:40 +0800
Message-Id: <20261110013750.36800-1-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260914092648.51254-1-xueshuai@linux.alibaba.com>
References: <20260914092648.51254-1-xueshuai@linux.alibaba.com>
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This is v7 of the RISC-V reliable stack unwinding series for livepatch.

The series starts with three standalone fixes for the existing stack
walkers: Karl Mehltretter's fix for arch_stack_walk() reporting the
walker's own frame, its KUnit test, and a fix for the function-graph
return-address cookie that Martin Kaiser asked to be split out. The
main part of the series then adds explicit frame-record metadata,
preserves the frame pointer through dynamic ftrace, replaces the
open-coded stack walker with a conservative frame-pointer based
unwinder, enables the RISC-V livepatch capability and adds the
syscall-wrapper selftest prefix.

Changes since v6:

* Rebase onto the current riscv/for-next (based on 7.4-rc1).

* Fold in Karl Mehltretter's two patches [1] as 1/10 and 2/10. Patch
  1/10 stops arch_stack_walk() from reporting the walker's own frame as
  the first entry, which corrupts the skip-frame accounting of
  stack_trace_save() users (page_owner, perf), and adjusts
  return_address() level accounting accordingly. Patch 2/10 adds a KUnit
  test for the start frames. Both patches keep their original authorship;
  I added my Reviewed-by/Tested-by and sign-off. I asked Karl on
  3 November whether he would like to see his patches folded into this
  series; he has not replied so far. Since 8/10 reuses the walker
  extraction from 1/10 for its !CONFIG_FRAME_POINTER fallback, his
  patches are included here to keep the series self-contained.

* Split the function-graph return-address cookie change out of the old
  5/7, as suggested by Martin Kaiser. It is now a separate patch (3/10)
  that also fixes the old walker's cookie key, so it stands on its own
  without the rest of the series and can be picked independently; it is
  marked Fixes: and Cc: stable.

* Reworked the !CONFIG_FRAME_POINTER fallback of the unwinder switch
  patch (8/10) to use the __always_inline __walk_stackframe() helper
  from 1/10, so both walkers report the same start frame.

* Collected tags from the v6 review thread: Reviewed-by and Tested-by:
  Martin Kaiser for the patches carried over from v6 (rv64 QEMU and
  rv64 CHERI builds, livepatch working on both).

The patches carried over from v6 are unchanged, except for the
reworked !CONFIG_FRAME_POINTER fallback in 8/10, so the v6 validation
results still apply to them. The v7-specific changes were covered by
the fresh build and boot runs described below:

* Built with riscv64-unknown-linux-gnu-gcc 15.2.0 and binutils 2.46,
  including a CONFIG_IRQ_STACKS=n variant.
* QEMU 8.2.2, 1 and 4 CPUs: livepatch selftests PASS: 7, SKIP: 1,
  FAIL: 0; ftrace function graph 3 passed, 0 failed, 3 unsupported.
* No BUG, WARNING, Oops, panic, unreliable stack or Call Trace found by
  the validation log scans.

Patches 1-2/10 were tested by Karl with the KUnit suite from 2/10 on
QEMU's virt machine with clang 22 (LLVM=1) and GCC 15.2, and on a
BeagleV Ahead (TH1520), where all five test cases pass.

In addition, the combined v7 tree was freshly built and booted:

* Built with riscv64-unknown-linux-gnu-gcc 16.2.0 on top of 7.4-rc1:
  a full livepatch configuration (CONFIG_LIVEPATCH=y with dynamic ftrace
  and function graph tracer) and a !CONFIG_FRAME_POINTER variant both
  link successfully.
* QEMU 11.1.1, rv64 virt, 4 CPUs: the KUnit suite from 2/10 passes
  5/5 on the frame-pointer build; the !CONFIG_FRAME_POINTER build boots
  and its panic backtrace (no initramfs, by design) unwinds cleanly.

Base:
riscv/for-next 6628e7d4c6b2 ("Linux 7.4-rc1")

Previous versions:
v6: https://lore.kernel.org/r/20260914092648.51254-1-xueshuai@linux.alibaba.com
v5: https://lore.kernel.org/r/20260804103626.2803112-1-wanghan@linux.alibaba.com
v4 RESEND: https://lore.kernel.org/r/20260629072713.3273743-1-wanghan@linux.alibaba.com
v3: https://lore.kernel.org/r/cover.194d76e3a15b.v3.riscv-livepatch.wanghan@linux.alibaba.com
v2: https://lore.kernel.org/r/20260528082310.1994388-1-wanghan@linux.alibaba.com
v1: https://lore.kernel.org/r/20260527123530.2593918-1-wanghan@linux.alibaba.com

[1] https://lore.kernel.org/r/20261010132712.46931-1-kmehltretter@gmail.com

Karl Mehltretter (2):
  riscv: stacktrace: do not report the walker's own frame from
    arch_stack_walk()
  riscv: Add KUnit test for stack trace start frames

Shuai Xue (1):
  riscv: ftrace: use the frame pointer as the function graph
    return-address cookie

Wang Han (7):
  riscv: stacktrace: Add frame record metadata
  riscv: stacktrace: disable KASAN and KCOV instrumentation for
    stacktrace.o
  riscv: ftrace: always preserve s0 in dynamic ftrace register frame
  riscv: stacktrace: introduce stack-bound tracking helpers
  riscv: stacktrace: switch to frame-pointer based unwinder
  riscv: Kconfig: enable HAVE_RELIABLE_STACKTRACE and HAVE_LIVEPATCH
  selftests/livepatch: Add RISC-V syscall wrapper prefix

 arch/riscv/Kconfig                            |   4 +
 arch/riscv/include/asm/ptrace.h               |   9 +
 arch/riscv/include/asm/stacktrace.h           |  67 ++-
 arch/riscv/include/asm/stacktrace/common.h    | 159 +++++
 arch/riscv/include/asm/stacktrace/frame.h     |  53 ++
 arch/riscv/kernel/Makefile                    |   6 +
 arch/riscv/kernel/asm-offsets.c               |   6 +
 arch/riscv/kernel/entry.S                     |  39 +-
 arch/riscv/kernel/ftrace.c                    |   6 +-
 arch/riscv/kernel/head.S                      |  23 +
 arch/riscv/kernel/mcount-dyn.S                |   4 -
 arch/riscv/kernel/perf_callchain.c            |   2 +-
 arch/riscv/kernel/process.c                   |  33 +-
 arch/riscv/kernel/return_address.c            |   2 +-
 arch/riscv/kernel/stacktrace.c                | 583 +++++++++++++++---
 arch/riscv/kernel/tests/Kconfig.debug         |  12 +
 arch/riscv/kernel/tests/Makefile              |   1 +
 arch/riscv/kernel/tests/stacktrace_test.c      | 142 +++++
 .../livepatch/test_modules/test_klp_syscall.c |    2 +
 19 files changed, 1043 insertions(+), 110 deletions(-)
 create mode 100644 arch/riscv/include/asm/stacktrace/common.h
 create mode 100644 arch/riscv/include/asm/stacktrace/frame.h
 create mode 100644 arch/riscv/kernel/tests/stacktrace_test.c


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.39.3

