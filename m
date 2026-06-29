Received: from out199-13.us.a.mail.aliyun.com (out199-13.us.a.mail.aliyun.com [47.90.199.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EE33AE188;
	Mon, 29 Jun 2026 06:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.199.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782715706; cv=none; b=DYJRO4Gl8o9TkXNP6PvOiJ0ea4JDSWgFf/J8SoPHntOtJZNk9z0JGeVSDUBvjV0RKlam3tsB5XbiajwM6AeQhy0lPGR5A0/hrDHP68q9f+2Quep+xHDU7R2O78osymf8TLobh79QOaIzdoLisp9QBVy/Y5j9nEDM908knO3F6Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782715706; c=relaxed/simple;
	bh=S9PPBd03nshTXdebHu0IRlNHz4qa/HrTIvMxXIyLevQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A0phZaABrFuQ2vyfkMFzFj5jj7RARkvACAPK7TnGpsWeHTZPkrXgskbT/JYvGg9Xut2NMv2Xvnn9jgTHjKFro9sZAJFVofjn2DKu2aTft2XYTmd+ETCDflBu6wf1P4S/tkq+RatFZYCnM01t1IbsQSor2f5yaSbkJ85O680QNzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=RMnGm7bG; arc=none smtp.client-ip=47.90.199.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="RMnGm7bG"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782715689; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=cs5txbx9bpKaRI7bmx5ga6+SdBKGKPqwgmoXTwT+GtE=;
	b=RMnGm7bGVVXeA52sHPH5YIYUBBBDtE6zrwfryltfVAt1PtVhGj0UefGc9IlY4gSyg3iQ2T1udaWTPKFqHDQxAe0EtD6Ic9nJfoJKeo6rAuJ8/ePC35kMOQL5QqsFeZdLKrZNHCfw+ANQZnnEpqtyfaIh4iVtImo5rksqyltPo+k=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=wanghan@linux.alibaba.com;NM=1;PH=DS;RN=34;SR=0;TI=SMTPD_---0X5nWtcO_1782715355;
Received: from wanghan-Workstation..(mailfrom:wanghan@linux.alibaba.com fp:SMTPD_---0X5nWtcO_1782715355 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 29 Jun 2026 14:42:36 +0800
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
Subject: [PATCH v4 3/7] riscv: ftrace: always preserve s0 in dynamic ftrace register frame
Date: Mon, 29 Jun 2026 14:42:24 +0800
Message-ID: <20260629064228.3195856-4-wanghan@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct __arch_ftrace_regs declares s0 unconditionally, and both
ftrace_regs_get_frame_pointer() and ftrace_partial_regs() read it
unconditionally. But the SAVE_ABI_REGS / RESTORE_ABI_REGS macros in
mcount-dyn.S only stored s0 under HAVE_FUNCTION_GRAPH_FP_TEST
(CONFIG_FUNCTION_GRAPH_TRACER && CONFIG_FRAME_POINTER). With
CONFIG_FRAME_POINTER=n the slot held whatever was on the stack before,
so any callback going through ftrace_partial_regs() saw a garbage
regs->s0. RISC-V kernels default to FRAME_POINTER=y, which is why this
has not bitten in practice.

Save and restore s0 unconditionally in the dynamic ftrace ABI register
frame. This fixes the latent garbage-s0 case, brings the dynamic ftrace
path in line with the static _mcount path (mcount.S SAVE_ABI_STATE
already saves s0 unconditionally), and matches the frame layout already
documented in the comment above SAVE_ABI_REGS. It is also a prerequisite
for the upcoming reliable unwinder, which reads
ftrace_regs_get_frame_pointer(fregs) directly.

The cost is one extra REG_S/REG_L pair per traced call, negligible
compared to the overall ftrace cost; the existing FREGS_SIZE_ON_STACK
already reserved the slot, so no extra stack space is used.

Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
Signed-off-by: Wang Han <wanghan@linux.alibaba.com>
---
 arch/riscv/kernel/mcount-dyn.S | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/riscv/kernel/mcount-dyn.S b/arch/riscv/kernel/mcount-dyn.S
index 082fe0b0e3c0..26c55fba8fec 100644
--- a/arch/riscv/kernel/mcount-dyn.S
+++ b/arch/riscv/kernel/mcount-dyn.S
@@ -85,9 +85,7 @@
 	addi	sp, sp, -FREGS_SIZE_ON_STACK
 	REG_S	t0,  FREGS_EPC(sp)
 	REG_S	x1,  FREGS_RA(sp)
-#ifdef HAVE_FUNCTION_GRAPH_FP_TEST
 	REG_S	x8,  FREGS_S0(sp)
-#endif
 	REG_S	x6,  FREGS_T1(sp)
 #ifdef CONFIG_CC_IS_CLANG
 	REG_S	x7,  FREGS_T2(sp)
@@ -113,9 +111,7 @@
 	.macro RESTORE_ABI_REGS
 	REG_L	t0, FREGS_EPC(sp)
 	REG_L	x1, FREGS_RA(sp)
-#ifdef HAVE_FUNCTION_GRAPH_FP_TEST
 	REG_L	x8, FREGS_S0(sp)
-#endif
 	REG_L	x6,  FREGS_T1(sp)
 #ifdef CONFIG_CC_IS_CLANG
 	REG_L	x7,  FREGS_T2(sp)
-- 
2.43.0
