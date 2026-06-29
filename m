Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0210539A80E;
	Mon, 29 Jun 2026 06:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782715379; cv=none; b=iVTJ4pEefQdJcYuRoH4/Kdm5hk04GZuUrm/PzKr9O/G2QUXWCKeL/lei+bLpwp+SfuiRwu4IUl5dx3dOoQ5JnSj+SDjFkETP7h8GxO00rUMof52Xy3ccNzSwhyomIbLVKPN2rMfwe5/FfdvLRUyfbGrkzC4qnJudCI1VGXrVhvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782715379; c=relaxed/simple;
	bh=08k0xw9LFq6C72qks0xPJ3bNAKGrB4AtmqLfkB/CTks=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sY3Xtcyf5xzSSi+JcTdp8uk4VW9WronRvnvG+mFD6KszIrq04/mO5/HrjwyBu2x36Ln2+mOlG4KS1WDVCm6K1/BEzEvW4njCRySQRAzTnzpB3QPUKckzeHN6pr8dWIlh6eLuquuViOhzGPJKnJxgXKKiQ7SEnR41oWLchdFAmQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=M8Zka5JU; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="M8Zka5JU"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782715367; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=MQtuIWmKp0yK/pGFuoUioKxVm/GbD9KEgakpTzJtQ9I=;
	b=M8Zka5JUbmaEsTfjD65otIl3JcR5HejQ+IwpvNi81y3CE+qsFv8BCOx2qgfGc+r30MzpLcxSsqIiZKctwYrbr6LnPqm6l2FK7pdDNruh/R9FSh03yYelX5M40OxcZKCLfYGazZDK8T2EVUjvQyvVUxWZZ5+Kgk18LadzV36TBP4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R301e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=wanghan@linux.alibaba.com;NM=1;PH=DS;RN=34;SR=0;TI=SMTPD_---0X5nWteH_1782715361;
Received: from wanghan-Workstation..(mailfrom:wanghan@linux.alibaba.com fp:SMTPD_---0X5nWteH_1782715361 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 29 Jun 2026 14:42:42 +0800
From: Wang Han <wanghan@linux.alibaba.com>
To: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Alexandre Ghiti <alex@ghiti.fr>,
	linux-riscv@lists.infradead.org,
	Oleg Nesterov <oleg@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	oliver.yang@linux.alibaba.com,
	xueshuai@linux.alibaba.com,
	zhuo.song@linux.alibaba.com,
	jkchen@linux.alibaba.com,
	Marcos Paulo de Souza <mpdesouza@suse.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	live-patching@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v4 6/7] riscv: Kconfig: enable HAVE_RELIABLE_STACKTRACE and HAVE_LIVEPATCH
Date: Mon, 29 Jun 2026 14:42:27 +0800
Message-ID: <20260629064228.3195856-7-wanghan@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that the metadata frame records, the kunwind state machine and
arch_stack_walk_reliable() are all in place, advertise the capability
to the rest of the kernel:

  * select HAVE_RELIABLE_STACKTRACE under FRAME_POINTER && 64BIT, so
    only the configurations with the tested metadata records and
    FP-based reliable walker enable it.
  * select HAVE_LIVEPATCH under the same condition and source
    kernel/livepatch/Kconfig so the livepatch menu is reachable from
    the RISC-V configuration.

The 64BIT dependency is conservative scoping rather than a hard
technical requirement: the metadata frame record, kunwind state machine
and arch_stack_walk_reliable() also build on RV32, and the IRQ-stack
frame-record adjustment fixes a latent RV32 issue. However, the syscall
livepatch selftest and module relocation path have only been exercised
on RV64 QEMU virt so far. The 64BIT gate can be relaxed in a follow-up
once RV32 has equivalent coverage.

This is split out from the unwinder change so the policy decision and
the implementation can be reviewed and reverted independently.

Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
Signed-off-by: Wang Han <wanghan@linux.alibaba.com>
---
 arch/riscv/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index cb3d85abf595..4d09fab682ac 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -186,6 +186,7 @@ config RISCV
 	select HAVE_KRETPROBES
 	# https://github.com/ClangBuiltLinux/linux/issues/1881
 	select HAVE_LD_DEAD_CODE_DATA_ELIMINATION if !LD_IS_LLD
+	select HAVE_LIVEPATCH if FRAME_POINTER && 64BIT
 	select HAVE_MOVE_PMD
 	select HAVE_MOVE_PUD
 	select HAVE_PAGE_SIZE_4KB
@@ -196,6 +197,7 @@ config RISCV
 	select HAVE_POSIX_CPU_TIMERS_TASK_WORK
 	select HAVE_PREEMPT_DYNAMIC_KEY
 	select HAVE_REGS_AND_STACK_ACCESS_API
+	select HAVE_RELIABLE_STACKTRACE if FRAME_POINTER && 64BIT
 	select HAVE_RETHOOK
 	select HAVE_RSEQ
 	select HAVE_RUST if RUSTC_SUPPORTS_RISCV && CC_IS_CLANG
@@ -1392,3 +1394,5 @@ endmenu # "CPU Power Management"
 source "arch/riscv/kvm/Kconfig"
 
 source "drivers/acpi/Kconfig"
+
+source "kernel/livepatch/Kconfig"
-- 
2.43.0
