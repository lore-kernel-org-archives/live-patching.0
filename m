Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794274682;
	b=I+7anf1MuMBYS/VUHuSXxnR5aqWwyJk2dYOWMyGeFmwjdYYbwt5RB3jt7r1wPRHJc/kS
	 tbph13dcYJZ/R0CMZQbKgVB7YNORcvAylacd6CegDOtmYXt+wJhjoJo2TP5IUaypLvnpd
	 VAXDjbEmiPfPg3GwqGoZ6BlTqAb09u9dT+oy2bxouZbDJwTSoOIsJesZpGR2HP3XRhxX9
	 1E2Qjun6BmjEqLSVgxXJgLqQaeY2SsAhdMjbVEZQmPut+9XbqR10cNY0jR8qOVc6+/Hxg
	 dzC+NWB+JkCe6XOa6yOHt31tbxeZUr3BxJCOpYysLuNDqlwvwIUXEhXSqDUpuHAQJ/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794274682;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=gxJalAltFJ+mzwybO3QEc8bbloiNp6J964VtBr6AK/M=;
	b=cZY0EOqvnGBsgffLysEd2FJYds5NWGOFTwAezbk55xbM62O/cH9veEalzl6aaGsEfn9v
	 BBQ88dfJpDmNshwqk3cNx0BKPvLpGshnstJZSnmDTmX0fbW21W7TbNXyKHjSJ0D/3vjvL
	 Z7F9pWjZI7/XUFsYGGyObpvTPoFlUzKuL94fTKJD1Ip3U0au4w/M1M9h90dA0fab41MX1
	 jL8LjuAtk/A1oj3Asuj+1f6wgc2lwlUyQ00T3K2l7BmqJfCuzRSF/2v9jH5ZrHDtO+ynG
	 L9WD1NN8/N60lvlMbkqZOqElOeYR8tWcx8pmLWXQjbCvKQOSzvC7wQtLyrQGIC+oaGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=d4l7ZaYo;
	arc=none smtp.remote-ip=115.124.30.100
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1E1606A321;
	Tue, 10 Nov 2026 01:37:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E1E1606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=d4l7ZaYo
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1794274678; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=gxJalAltFJ+mzwybO3QEc8bbloiNp6J964VtBr6AK/M=;
	b=d4l7ZaYo2DtEK8kYTAca12mqQ2CZhYxlTdTbfQ0o8sMq9pNsMJWeuEaEhaIeXDE6HPuyV8dqn2FnqV1wAoyjASolMbc3Aa1U5oPN60Jom+2uNkBR/jwggZ0qm2vETAtauEPdf5lEKmVU0MufI3AuRSfUxGXxVW89LJ/xZ9cs9GY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=36;SR=0;TI=SMTPD_---0XETOX1E_1794274674;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0XETOX1E_1794274674 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 10 Nov 2026 09:37:56 +0800
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
Subject: [PATCH v7 01/10] riscv: stacktrace: do not report the walker's own frame from arch_stack_walk()
Date: Tue, 10 Nov 2026 09:37:41 +0800
Message-Id: <20261110013750.36800-2-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261110013750.36800-1-xueshuai@linux.alibaba.com>
References: <20260914092648.51254-1-xueshuai@linux.alibaba.com>
 <20261110013750.36800-1-xueshuai@linux.alibaba.com>
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

From: Karl Mehltretter <kmehltretter@gmail.com>

stack_trace_save() uses skipnr + 1 because arch_stack_walk() is expected
to first report the return into stack_trace_save(). With FRAME_POINTER,
the RISC-V arch_stack_walk() calls walk_stackframe(), which starts from
its own frame and first reports the return into arch_stack_walk().
stack_trace_save() therefore starts one frame too early. For example,
page_owner records begin at __set_page_owner() instead of the allocation
site.

Move the walker into an always-inlined helper and call it directly from
arch_stack_walk(). Keep walk_stackframe() as a wrapper for its existing
callers.

return_address() skips level + 3 entries, while the arm64 implementation
skips level + 2. After removing the extra frame, use level + 2 so
ftrace_return_address() and CALLER_ADDR results do not shift by one caller.

Fixes: 6a00ef449370 ("riscv: eliminate unreliable __builtin_frame_address(1)")
Link: https://lore.kernel.org/r/20261010132712.46931-1-kmehltretter@gmail.com
Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
Tested-by: Shuai Xue <xueshuai@linux.alibaba.com>
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 arch/riscv/kernel/return_address.c |  2 +-
 arch/riscv/kernel/stacktrace.c     | 40 ++++++++++++++++++++++++++----
 2 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/kernel/return_address.c b/arch/riscv/kernel/return_address.c
index c8115ec8fb30..4da1cfd249d3 100644
--- a/arch/riscv/kernel/return_address.c
+++ b/arch/riscv/kernel/return_address.c
@@ -33,7 +33,7 @@ noinline void *return_address(unsigned int level)
 {
 	struct return_address_data data;
 
-	data.level = level + 3;
+	data.level = level + 2;
 	data.addr = NULL;
 
 	arch_stack_walk(save_return_addr, &data, current, NULL);
diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrace.c
index c7555447149b..28c5744889ba 100644
--- a/arch/riscv/kernel/stacktrace.c
+++ b/arch/riscv/kernel/stacktrace.c
@@ -45,8 +45,16 @@ static inline int fp_is_valid(unsigned long fp, unsigned long sp)
 	return !(fp < low || fp > high || fp & 0x07);
 }
 
-void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
-			     bool (*fn)(void *, unsigned long), void *arg)
+/*
+ * Always inlined so that the frame the walk starts from is the caller's own,
+ * and the first entry reported for the current task is the caller's return
+ * address.  arch_stack_walk() relies on that to report the same frames as
+ * the other architectures, see the comment there.
+ */
+static __always_inline void __walk_stackframe(struct task_struct *task,
+					      struct pt_regs *regs,
+					      bool (*fn)(void *, unsigned long),
+					      void *arg)
 {
 	unsigned long fp, sp, pc;
 	int graph_idx = 0;
@@ -59,6 +67,7 @@ void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
 	} else if (task == NULL || task == current) {
 		fp = (unsigned long)__builtin_frame_address(0);
 		sp = current_stack_pointer;
+		/* Placeholder for the frame the walk starts from, never reported. */
 		pc = (unsigned long)walk_stackframe;
 		level = -1;
 	} else {
@@ -102,10 +111,18 @@ void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
 	}
 }
 
+void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
+			     bool (*fn)(void *, unsigned long), void *arg)
+{
+	__walk_stackframe(task, regs, fn, arg);
+}
+
 #else /* !CONFIG_FRAME_POINTER */
 
-void notrace walk_stackframe(struct task_struct *task,
-	struct pt_regs *regs, bool (*fn)(void *, unsigned long), void *arg)
+static __always_inline void __walk_stackframe(struct task_struct *task,
+					      struct pt_regs *regs,
+					      bool (*fn)(void *, unsigned long),
+					      void *arg)
 {
 	unsigned long sp, pc;
 	unsigned long *ksp;
@@ -133,6 +150,12 @@ void notrace walk_stackframe(struct task_struct *task,
 	}
 }
 
+void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
+			     bool (*fn)(void *, unsigned long), void *arg)
+{
+	__walk_stackframe(task, regs, fn, arg);
+}
+
 #endif /* CONFIG_FRAME_POINTER */
 
 static bool print_trace_address(void *arg, unsigned long pc)
@@ -176,10 +199,17 @@ unsigned long __get_wchan(struct task_struct *task)
 	return pc;
 }
 
+/*
+ * The generic code expects the first entry for the current task to be the
+ * return address of arch_stack_walk() itself, the way x86 and arm64 report
+ * it, and stack_trace_save() sizes its skip count accordingly.  Walking from
+ * inside a called walk_stackframe() adds that function's own frame on top,
+ * so inline the walker here and start from this frame instead.
+ */
 noinline noinstr void arch_stack_walk(stack_trace_consume_fn consume_entry, void *cookie,
 		     struct task_struct *task, struct pt_regs *regs)
 {
-	walk_stackframe(task, regs, consume_entry, cookie);
+	__walk_stackframe(task, regs, consume_entry, cookie);
 }
 
 /*
-- 
2.39.3

