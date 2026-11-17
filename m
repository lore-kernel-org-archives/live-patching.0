Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794891186;
	b=GI5cWfkaKEwFbRRDrqNZBXlL7u4NGdXhv479Bzf3+DOihTpLIdPlKJxCazwWbiLeGI3K
	 t6u9ONTQO+L3+LFGkoUFMIZa3KH7JSlqIe7lJigTB/cKb8SEkKbUQov7GxwnNlydPax+f
	 C65KnKJ2fq1Y2cC82dmkxgb8CKZzuYsuSUT4pyQQOeLmD9TP/WbzdNWQ+Ruaq0XVEsPFQ
	 dgY5ZZ+6MdayB+YcAcYzz0LsfKW2Ul/bjAA7jjaV0Gx6bppW4rdTSTyDF9Mzbp+UdEuFo
	 KGjO+Lrh4VmVv5JInIYYgWTyItPIm3gw1XDvU8nwYua4l/4E853tycXBnBJiBedsfZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794891186;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=fN22KBOTScvrwmw++3dnOESml/CWiaCxPlZ9R+mGDfI=;
	b=myLq6o2vGyIAc+cDrmyVBCk+dGDcctTUxFmfMfCb0HfoN9vPs9ZvfxxXyaHEMThO9RMm
	 nYuv6hO3CYsBm1TXujOp+w/Lo5YYDO/P+wVmpOb4iL5Cs0vj6q3fZheczKz/ALeQGkcpn
	 Vf2AlLcP1/ZVHwh7sq9etkplARo1QksNFqlSjgkr78rUdOoAGxYIsabXYL0TqWwOJOdrg
	 VpNC4VUSawQvQR5Q60LbAxzBHCIyRl/GTeuCo6v6qXOhlAG824EL4A+hpvkzsjSlZaSTM
	 p2pwtxN0IGxUBEDyan78qJJsQaSyrXNa6tSWZrupecXpVms5dIDBic+dlJN1ECNGBOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dylanbhatch.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=in6qnkgC;
	arc=none smtp.remote-ip=209.85.215.200
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B272606A337
	for <live-patching@vger.kernel.org>; Tue, 17 Nov 2026 04:53:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B272606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dylanbhatch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=in6qnkgC
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cd66551e02cso4854398a12.2
        for <live-patching@vger.kernel.org>; Mon, 16 Nov 2026 20:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794891185; x=1795495985; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fN22KBOTScvrwmw++3dnOESml/CWiaCxPlZ9R+mGDfI=;
        b=in6qnkgCY9elVezeHjtPo3lzsyuVBhxQMFlh+v/veDnqQqV8A7Unf5023qp94pHz0O
         wGnBOKLLcofjnnHsMxufzS6qXrUPKXLBAO1+az4OTKoOrmgDNKEwPc0UmOSsVr+hK6Ea
         3ub8U/TD0/jht+fuMucHa3Lah75zD0+WahGKiR5PiyESX/EzVZxL51on/ymtorBOv35i
         rzAuNwkSRsbkocZIgk5UuwZp4m/3G8UwcHxNAmbUaD/sUkzxPfz3t7b9NvQNQ6XTQjXQ
         BxdWemp4YkrYzYxnb2/BbGBTj+W9vgKWXNUo40IIY+XsjmUGrbvsCQKmuFE3Pq+lpPWr
         RUhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794891185; x=1795495985;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fN22KBOTScvrwmw++3dnOESml/CWiaCxPlZ9R+mGDfI=;
        b=LSO4CiWHz4f8GqXRRv1ndZhbEOQ4Zya/mnsz7pkpwwKcHEiLLUk8jJmKes+rsQo3Z5
         50T1LeAL56T+KppJVXheuRm2qHwEgXuPxHM00WVhYXLzH1Dvt8EoRTlpMTy8a6Qfj3h2
         zqApmCGonEMMpKkJUgJRVbhsAzl9b6ZGBSZgXmSxi7nxeUyQtS9trf/A4pq5OXHr2MFM
         rI9joBmlBWiaCpxkGcABbtj5PUqLNo/3c10tY9N7SkaSrvUup3mWESZtWdnN+xfYW9iq
         LYkKi/0m19wpNCdeYBk7FCqLYB/sVGe2rFrW/dX1seZLNLYcTiEUSq8X7lOKPTWSUh5q
         PwIQ==
X-Forwarded-Encrypted: i=1; AL+hErFGW8uV+LwBO8SugolLbbnZp+sYOLdGAMfkcHyx140VF7dVP8WWxFDA7t7RfpXBy23vEJ2aj07OQG4PiNIm@vger.kernel.org
X-Gm-Message-State: APuU4Z+ZoLjVXVR6VcaYrlQljyRkomppEk0ibrLd1UPQFAgUskHf1nC4
	/6IqKNLsnTcEKuwshLJBmv7IyTQY4gx7x7QxTGztz99NtTT4hIx4xmJAgyiCh4OtjcQyYlLKWiM
	Ecgu/IRZHRoC+1pJkpcq+IcUyjQ==
X-Received: from pjrx15.prod.google.com ([2002:a17:90a:bc8f:b0:3b3:ad37:918c])
 (user=dylanbhatch job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:380f:b0:3ab:e588:c29b with SMTP id 98e67ed59e1d1-3b1b0816e0dmr12919214a91.5.1794891184644;
 Mon, 16 Nov 2026 20:53:04 -0800 (PST)
Date: Tue, 17 Nov 2026 04:52:53 +0000
In-Reply-To: <20261117045254.1048298-1-dylanbhatch@google.com>
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261117045254.1048298-1-dylanbhatch@google.com>
X-Mailer: git-send-email 2.56.0.679.gc527c65306-goog
Message-ID: <20261117045254.1048298-2-dylanbhatch@google.com>
Subject: [PATCH 1/2] sched, livepatch: Fix transition stall for CPU-bound tasks
From: Dylan Hatch <dylanbhatch@google.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>, Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, 
	Joe Lawrence <joe.lawrence@redhat.com>, Song Liu <song@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Shuah Khan <shuah@kernel.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner <tglx@kernel.org>, live-patching@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dylan Hatch <dylanbhatch@google.com>
Content-Type: text/plain; charset="UTF-8"

Commit 676e8cf70cb0 ("sched,livepatch: Untangle cond_resched() and
live-patching") moved klp_sched_try_switch() from cond_resched() into
__schedule() and gated it on READ_ONCE(curr->__state) & TASK_FREEZABLE.
This causes livepatch transitions to stall when a CPU-bound kthread or
PF_USER_WORKER thread (such as vhost-<pid>) spins in a kernel loop with
cond_resched() for two reasons:

1. A sole runnable task on a CPU (cfs_rq->nr_queued == 1) never has
   TIF_NEED_RESCHED set during sched_tick(), and wake_up_state(task,
   TASK_INTERRUPTIBLE) in klp_send_signals() is a no-op for a
   TASK_RUNNING kthread. Because _cond_resched() is a no-op under
   CONFIG_PREEMPTION=y, the task only enters __schedule(SM_PREEMPT) on
   return from interrupts via irqentry_exit_cond_resched() when
   TIF_NEED_RESCHED is set.
2. Even when __schedule() is entered via preemption or an unfreezable
   sleep (such as PF_NOFREEZE kthreads or PF_USER_WORKER threads
   sleeping in TASK_INTERRUPTIBLE), curr->__state does not have
   TASK_FREEZABLE set, so klp_sched_try_switch() skips the task.
   Livepatch safety in __schedule() is already guaranteed by
   stack_trace_save_tsk_reliable() inside klp_check_stack().

Fix both issues by:
- Removing the TASK_FREEZABLE check from klp_sched_try_switch() and
  checking TIF_PATCH_PENDING inline via klp_sched_need_resched().
- Calling resched_curr(rq) in sched_tick() when klp_sched_need_resched()
  is true for the current task, ensuring CPU-bound tasks with a pending
  livepatch enter __schedule() at the next timer tick.

Note that when a CPU-bound task is the sole runnable task on its CPU,
entering __schedule(SM_PREEMPT) from preempt_schedule_irq() leaves an
in-kernel interrupt pt_regs frame on the stack during
klp_sched_try_switch(). Completing the transition in that context
requires arch_stack_walk_reliable() to support unwinding across
in-kernel exception frames (as CONFIG_UNWINDER_ORC=y does on x86_64);
configs and architectures whose reliable unwinder rejects in-kernel
exception frames (x86 with CONFIG_FRAME_POINTER=y, arm64, powerpc, and
s390) still require another runnable task to context-switch the spinning
task out until exception-boundary reliable unwinding (e.g. via SFrame)
is available.

Fixes: 676e8cf70cb0 ("sched,livepatch: Untangle cond_resched() and live-patching")
Signed-off-by: Dylan Hatch <dylanbhatch@google.com>
---
 include/linux/livepatch_sched.h | 13 +++++++++++--
 kernel/sched/core.c             |  3 ++-
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/include/linux/livepatch_sched.h b/include/linux/livepatch_sched.h
index 065c185f27638..748b6012e2e06 100644
--- a/include/linux/livepatch_sched.h
+++ b/include/linux/livepatch_sched.h
@@ -11,15 +11,24 @@ void __klp_sched_try_switch(void);
 
 DECLARE_STATIC_KEY_FALSE(klp_sched_try_switch_key);
 
+static __always_inline bool klp_sched_need_resched(struct task_struct *curr)
+{
+	return static_branch_unlikely(&klp_sched_try_switch_key) &&
+	       unlikely(test_tsk_thread_flag(curr, TIF_PATCH_PENDING));
+}
+
 static __always_inline void klp_sched_try_switch(struct task_struct *curr)
 {
-	if (static_branch_unlikely(&klp_sched_try_switch_key) &&
-	    READ_ONCE(curr->__state) & TASK_FREEZABLE)
+	if (klp_sched_need_resched(curr))
 		__klp_sched_try_switch();
 }
 
 #else /* !CONFIG_LIVEPATCH */
 static inline void klp_sched_try_switch(struct task_struct *curr) {}
+static inline bool klp_sched_need_resched(struct task_struct *curr)
+{
+	return false;
+}
 #endif /* CONFIG_LIVEPATCH */
 
 #endif /* _LINUX_LIVEPATCH_SCHED_H_ */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 04b62c16fa8ca..fcea9cea3edf1 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5854,7 +5854,8 @@ void sched_tick(void)
 	hw_pressure = arch_scale_hw_pressure(cpu_of(rq));
 	update_hw_load_avg(rq_clock_task(rq), rq, hw_pressure);
 
-	if (dynamic_preempt_lazy() && tif_test_bit(TIF_NEED_RESCHED_LAZY))
+	if ((dynamic_preempt_lazy() && tif_test_bit(TIF_NEED_RESCHED_LAZY)) ||
+	    klp_sched_need_resched(curr))
 		resched_curr(rq);
 
 	donor->sched_class->task_tick(rq, donor, 0);
-- 
2.56.0.679.gc527c65306-goog

