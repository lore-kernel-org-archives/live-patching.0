Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2F341DEC9;
	Mon, 14 Sep 2026 09:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789378034; cv=none; b=e0nPosGGzRFbfYcxP42fxjWLhwCWJ/BdhDnnIrXxKQdBZgJcR+Cgb3SIb+R7iR+9ogzaOdTq8qjK1gkCtBYo0skm7IzEPH715/OFwMzRJMFOLqB57uxlS33XwzZSsZBt9csjAvNWqYtxOI1zwTh+likS8gJy6kN9IjBHu5a0G0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789378034; c=relaxed/simple;
	bh=/BKgtVOuQ2qgw22qpzAOkHztTTsjeX3prCxWtKLlTac=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N/jzfalkXErtPM0tVi5Mtw68YOCZYO+2w6Z9yl+RK0n37L+VtIVO7ioLZ8RFnlKVJA45nITHThdPIA+HLh9N4NfHsxa+t35yjtVUlKTG95oF+35KjqjrTmm8P+rPII0HobgLe5c53XEdldR0Z8xHF7JiX0hqEalZVc32NupJyv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=i8r8UpHA; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="i8r8UpHA"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1789378021; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=jYjFQWHS7zv+XprgIgV3x6FJiEuRmhHyfb5LEr80eCs=;
	b=i8r8UpHA7n83OVKbEGQW69I7yiO3HbNaB53aua/mFu9SXmjZEEVo4DoHzvTomW+Tz6tW/irMUFLiaDCro+aKZVPhpHBa56Bm6WLXtPc1G51ffLoS83cWx81hVb+L6TForVLerHfCdN/jMytBzln1m7kTiP/NbQ6RjTIGGv0oHyM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=34;SR=0;TI=SMTPD_---0XAuO-nk_1789378017;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0XAuO-nk_1789378017 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 14 Sep 2026 17:26:58 +0800
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
Subject: [PATCH v6 3/7] riscv: ftrace: always preserve s0 in dynamic ftrace register frame
Date: Mon, 14 Sep 2026 17:26:44 +0800
Message-Id: <20260914092648.51254-4-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260914092648.51254-1-xueshuai@linux.alibaba.com>
References: <20260914092648.51254-1-xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wang Han <wanghan@linux.alibaba.com>

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
Assisted-by: Qoder:Qwen-3.8-MAX-Preview
Signed-off-by: Wang Han <wanghan@linux.alibaba.com>
Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 arch/riscv/kernel/mcount-dyn.S | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/riscv/kernel/mcount-dyn.S b/arch/riscv/kernel/mcount-dyn.S
index 082fe0b0e3c08..26c55fba8fec7 100644
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
2.39.3

