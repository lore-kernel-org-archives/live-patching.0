Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3111448BB0;
	Tue,  4 Aug 2026 10:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785839829; cv=none; b=efCH0VWAbMg8PUW6ZMSPoPRjdl2/G6n5RthpSswDi1c3PJ9Lm91PjZr/YbBbz/cS+6XuHTcMYVj62MVWdFKbFnCzQda0BMdIvRAZUpC1mc69YYXMFUexWACPlRcFHdhp8B4xKEUgDetXsXgU1n3WBgJFCgojUNA+bG2siHgaIjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785839829; c=relaxed/simple;
	bh=frv7TVUQxrzZXf94KmbtysyYUaRLeK9SbLYWWX5/SDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cfBgOJH4VVpEipoo56990tt3y3tF4NYc0WW30pah9+m8j5uFrGup3xwiz39+Jrf7dQ6xWYkiXujVQzcMN2j1yDY28hWYAOLeAHTWicdkcoZ+nNwrd1ydoHj8ZKomWrxPRXdI1pIyCqYlStKYDWmOrTWQpZDkzpKO+AcvxdUkATc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=gFkrD48O; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="gFkrD48O"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1785839819; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=7hpONqRjO5c0M/yKXJ6veooXI3+oa4S7WBEo4b9UHV4=;
	b=gFkrD48O/eYFjHkUyWZtdkmNF40d727CcGsKkdmp19VzahTwV1JAk3VmXJnNB84bc52U7ZmUbg/R65IZijTRCTzcKLnB61G4mWWGYiq58fnztYhSOfzThcr+RhTUoXe9sAJOEgyNoCkxwbZB14M0UFEFnOPzZohvS5siIZmohlk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R971e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=wanghan@linux.alibaba.com;NM=1;PH=DS;RN=34;SR=0;TI=SMTPD_---0X8Nlqct_1785839815;
Received: from wanghan-Workstation..(mailfrom:wanghan@linux.alibaba.com fp:SMTPD_---0X8Nlqct_1785839815 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 04 Aug 2026 18:36:57 +0800
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
Subject: [PATCH v5 6/7] riscv: Kconfig: enable HAVE_RELIABLE_STACKTRACE and HAVE_LIVEPATCH
Date: Tue,  4 Aug 2026 18:36:25 +0800
Message-ID: <20260804103626.2803112-7-wanghan@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260804103626.2803112-1-wanghan@linux.alibaba.com>
References: <20260804103626.2803112-1-wanghan@linux.alibaba.com>
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
index c2c2f5f3ed5e..b36f711ecf45 100644
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

