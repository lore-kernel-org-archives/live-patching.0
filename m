Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE95941F375;
	Mon, 14 Sep 2026 09:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789378023; cv=none; b=aRcaXRixPLtBU5SlC4m/UcdfYz35MsDK5A5b2/jiOnFoB9l7JLSiQJm8ajB1d70ZUvBwh/hY9mN6uWKN3FA+5/4QXrwABRJxUsKbRfvQNfFHeFZFQIjb6eDyrM/N37t+LB7H7L5n2nDdRy5lunUhe/WLOv7hblJoxw25q7zInTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789378023; c=relaxed/simple;
	bh=ps2OuDZrxXJjM0qRGCt2VxBUZ2GkNMrAMVJaEuGI6Hk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z4ng4dMUzG5lqJIAR+QmW5BmPgkTQuzp/MPlQoC102tQE2wcbXnIZC3bexj+tjChDNmeI8rLFsOOEQ+Y7/Lbp375KdlItN4GD6b9GOFzImZmqwq1s5tcDQskVHHFWfJ4MT6TMYKMf/4YyzhT0LSZWrM1vprMA3tCHsd34NISXEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=odbYtClV; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="odbYtClV"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1789378013; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=P8sYn4OtnNWo+w2hJIg0kIU0ugjITLBiiIHDjl7eYks=;
	b=odbYtClVXrsFIzs2aUvmmmGYlpcgatdh7tPjlLOBOup0YNl8bZDc4ApFuY/EPeb48izp8F4ccRv1fGqOHRFxs3nMHC82Ht8uMRR8EYU1iBJ/WiPxZ8N5tvxH5ZjiQ8bsClItuFOZsznJcLR03vR7r+dZVQscin1yZPZ/nDmnPo4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=34;SR=0;TI=SMTPD_---0XAuO-lA_1789378009;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0XAuO-lA_1789378009 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 14 Sep 2026 17:26:51 +0800
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
	oliver.yang@linux.alibaba.com,
	zhuo.song@linux.alibaba.com,
	xueshuai@linux.alibaba.com,
	jkchen@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	live-patching@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v6 0/7] riscv: Add reliable stack unwinding for livepatch
Date: Mon, 14 Sep 2026 17:26:41 +0800
Message-Id: <20260914092648.51254-1-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This is v6 of the RISC-V reliable stack unwinding series for livepatch.
Wang Han has left our team, so I am taking over this series from now on.

The series adds explicit frame-record metadata, preserves the frame
pointer through dynamic ftrace, and replaces the open-coded stack walker
with a conservative frame-pointer based unwinder. It then enables the
RISC-V livepatch capability and adds the syscall-wrapper selftest prefix.

Changes since v5:
* Rebase onto the current riscv/for-next; no functional changes.
* Fold in the tags collected from the v5 thread:
  - Reviewed-by: Shuai Xue on 2/7, 3/7, 4/7 and 6/7
  - Acked-by: Miroslav Benes on 7/7
* Add my sign-off as the new sender.

Since the patches are otherwise identical to v5, the v5 validation
results still apply. For reference, from the v5 cover letter:
* Built Linux 7.2.0-rc6 with riscv64-unknown-linux-gnu-gcc 15.2.0
  and binutils 2.46.
* Standard livepatch configuration built successfully, including
  Image, vmlinux, modules, compile_commands.json and GDB scripts.
* CONFIG_IRQ_STACKS=n variant linked successfully with GCC.
* QEMU 8.2.2, 1 CPU: livepatch selftests PASS: 7, SKIP: 1,
  FAIL: 0; ftrace function graph 3 passed, 0 failed, 3 unsupported.
* QEMU 8.2.2, 4 CPUs: livepatch selftests PASS: 7, SKIP: 1,
  FAIL: 0; ftrace function graph 3 passed, 0 failed, 3 unsupported.
* No BUG, WARNING, Oops, panic, unreliable stack or Call Trace found
  by the validation log scans. Expected negative livepatch errors are
  part of the selftests.

v5 was posted in early August and has been quiet since then. I would
appreciate it if the series could be considered for the upcoming merge
window. Happy to address any remaining feedback.

Base:
riscv/for-next 77ae27fd98f3 ("Merge tag 'printk-for-7.3' of git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux")

Previous versions:
v5: https://lore.kernel.org/r/20260804103626.2803112-1-wanghan@linux.alibaba.com
v4 RESEND: https://lore.kernel.org/r/20260629072713.3273743-1-wanghan@linux.alibaba.com
v3: https://lore.kernel.org/r/cover.194d76e3a15b.v3.riscv-livepatch.wanghan@linux.alibaba.com
v2: https://lore.kernel.org/r/20260528082310.1994388-1-wanghan@linux.alibaba.com
v1: https://lore.kernel.org/r/20260527123530.2593918-1-wanghan@linux.alibaba.com

Assisted-by: Qoder:Qwen-3.8-MAX-Preview

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
 arch/riscv/kernel/stacktrace.c                | 561 +++++++++++++++---
 .../livepatch/test_modules/test_klp_syscall.c |   2 +
 15 files changed, 868 insertions(+), 106 deletions(-)
 create mode 100644 arch/riscv/include/asm/stacktrace/common.h
 create mode 100644 arch/riscv/include/asm/stacktrace/frame.h

base-commit: 77ae27fd98f3b9ab376239051ec7f9ee34c2c072
-- 
2.39.3

