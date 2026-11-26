Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795704118;
	b=nD0A2G4cRmKIV0b//htLP5J4h4D6PpPeazWeQ58AUdEfv9CAn3fH72v3vESsBKYBybrB
	 9fZC3K9HU5+lAGhLpICfZ1vZJVfNNic1G25LZDX8q5ZqMvJNttK+nUVniiP4U8y5MEhrB
	 8A3uhOh0aHZPRzqz7QNaRBzo1fKEb4C4ccefDvmUhDykeytVolcj3A/2LXCNAOsoNS71B
	 /MvKzSHy5hESD+yY80z7m58zyBpl10Ai8j6PDXqKVIUrvSuOEtRat+FWkGs1kfRq4GHpW
	 rc2qeZFq08ZeC1ANJKWnR5uQqWeRswaPdNbJgcJ954xxz4z+2VaXsUIIYkMVf4qF8KA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795704118;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=rdNueW4QXzChDxHqUnOiyjaxZJ2JAneVGEC0pK9unoo=;
	b=fEBy3OiSNHQHrokqbC67uyry9Wj3XjGbn2v9K3KD6+wAiX2YOXCEUR7LXKkQTh68nq+U
	 dvwNFB6A/PbS6wrDGw0/wKlNCq4hJd+Srw4++Ckr4IRCDwhsooq42F5XQ+/NueOFJ1JIr
	 2xjCfCDRYyuN91ai0DfkRtNz/vMsyAZg1V+dCj8hwbozYruMLQ5zGdiA+XFT7xvRyB9u5
	 X8/+cM1G5p+p8b6zt4Ib09oOzbwlUNR++2EzcgdznSMCHlqTrHCGk2OqdtTnuN4NoJtDu
	 OBqF/pG+TU9JK/8rviR97/d5I3RLJGe3rjmYNC4Va7wLk6JvoqCjXUeUNQUWAG+RsNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=irjBJ4pO;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E7E606A31C;
	Thu, 26 Nov 2026 14:41:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05E7E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=irjBJ4pO
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rdNueW4QXzChDxHqUnOiyjaxZJ2JAneVGEC0pK9unoo=; b=irjBJ4pOaN8hlYqdi9z0/tZ5QE
	T9+aD1Td7neEkAk3fz+FM6LDYPbo9nBVGUAdvGjvdarYhQNG+NlYK1h6aumaKO7FtCJntoqhtgDOm
	VOUyC9rheVuZQmN033KGXuAzQ0F9gMTwF3u+wuCeu1VIgCR2qm5Ce+aBHdXNP67zeYoWnmqO4Nwzk
	5+M7vfYK9XJWC3fQBL0WSYHC+NElfrz/DL4WYaw7MDm/qK7NvoYEayG2L4RiG5t8tbCg70xbRr1NU
	JxjvifuZl1C5RgCEcF87Q/g5KUooFMY36uVFmyMZEoJNO75wd9dJnLsk/63VxxBV9Xdj/JDvss41q
	wbZFYs1g==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWafY-00000005V92-1py9;
	Thu, 26 Nov 2026 14:41:52 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 63146303082; Thu, 26 Nov 2026 15:41:51 +0100 (CET)
Date: Thu, 26 Nov 2026 15:41:51 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Dylan Hatch <dylanbhatch@google.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>,
	Joe Lawrence <joe.lawrence@redhat.com>, Song Liu <song@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Shuah Khan <shuah@kernel.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@kernel.org>, live-patching@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] sched, livepatch: Fix transition stall for
 CPU-bound tasks
Message-ID: <20261126144151.GC83911@noisy.programming.kicks-ass.net>
References: <20261125041900.3243569-1-dylanbhatch@google.com>
 <20261126142919.GG49833@noisy.programming.kicks-ass.net>
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261126142919.GG49833@noisy.programming.kicks-ass.net>

On Thu, Nov 26, 2026 at 03:29:19PM +0100, Peter Zijlstra wrote:
> On Wed, Nov 25, 2026 at 04:18:58AM +0000, Dylan Hatch wrote:
> > Commit 676e8cf70cb0 ("sched,livepatch: Untangle cond_resched() and
> > live-patching") moved klp_sched_try_switch() from _cond_resched() into
> > __schedule() and gated it on READ_ONCE(curr->__state) & TASK_FREEZABLE.
> > This causes livepatch transitions to stall when CPU-bound kthreads,
> > PF_USER_WORKER threads (such as vhost-<pid>), or user tasks in long
> > kernel loops spin with cond_resched():
> > 
> > 1. Even when __schedule() is entered via preemption or an unfreezable
> >    sleep (such as PF_NOFREEZE kthreads or PF_USER_WORKER threads
> >    sleeping in TASK_INTERRUPTIBLE), curr->__state does not have
> >    TASK_FREEZABLE set, so klp_sched_try_switch() skips the task.
> > 2. A sole runnable task spinning in the kernel never gets
> >    TIF_NEED_RESCHED set during sched_tick(). In klp_send_signals(),
> >    wake_up_state(task, TASK_INTERRUPTIBLE) is a no-op for a
> >    TASK_RUNNING task, and set_notify_signal() sets TIF_NOTIFY_SIGNAL
> >    without TIF_NEED_RESCHED, so the resulting reschedule IPI returns to
> >    kernel mode without entering __schedule().
> > 
> > Patch 1 fixes both issues by dropping the TASK_FREEZABLE check from
> > klp_sched_try_switch() (relying on stack_trace_save_tsk_reliable() in
> > klp_check_stack()) and kicking still-running unmigrated tasks via
> > resched_cpu() in klp_send_signals() (as well as waking interruptibly
> > sleeping PF_USER_WORKER tasks).
> 
> So I didn't get a reply on my v1 comment, and I still have the same
> quesiton; how isn't any of this a problem for the freezer?
> 
> The intent was to make sure that a patch problem is a freezer problem
> and we fix both together.
> 
> Both cases above would also delay freezing, no?
> 
> It seems I have overlooked try_to_freezer() /
> kthread_freezable_should_stop(). Those should also do the patching
> thing. And then its a matter of adding either of those to whatever loops
> you think are lacking.

Perhaps something like so?

---
diff --git a/include/linux/freezer.h b/include/linux/freezer.h
index 0a8c6c4d1a82..479e35b4f2cf 100644
--- a/include/linux/freezer.h
+++ b/include/linux/freezer.h
@@ -9,6 +9,7 @@
 #include <linux/wait.h>
 #include <linux/atomic.h>
 #include <linux/jump_label.h>
+#include <linux/livepatch_sched.h>
 
 #ifdef CONFIG_FREEZER
 DECLARE_STATIC_KEY_FALSE(freezer_active);
@@ -56,6 +57,7 @@ extern void thaw_process(struct task_struct *p);
 static inline bool try_to_freeze(void)
 {
 	might_sleep();
+	klp_try_to_freeze();
 	if (likely(!freezing(current)))
 		return false;
 	if (!(current->flags & PF_NOFREEZE))
@@ -87,7 +89,11 @@ static inline void thaw_processes(void) {}
 static inline void thaw_kernel_threads(void) {}
 static inline void thaw_process(struct task_struct *p) {}
 
-static inline bool try_to_freeze(void) { return false; }
+static inline bool try_to_freeze(void)
+{
+	klp_try_to_freeze();
+	return false;
+}
 
 static inline void set_freezable(void) {}
 
diff --git a/include/linux/livepatch_sched.h b/include/linux/livepatch_sched.h
index 065c185f2763..8b9acffa3b64 100644
--- a/include/linux/livepatch_sched.h
+++ b/include/linux/livepatch_sched.h
@@ -18,8 +18,18 @@ static __always_inline void klp_sched_try_switch(struct task_struct *curr)
 		__klp_sched_try_switch();
 }
 
+static __always_inline void klp_try_to_freeze(void)
+{
+	if (static_branch_unlikely(&klp_sched_try_switch_key) &&
+	    !(current->flags & PF_NOFREEZE)) {
+		guard(preempt)();
+		__klp_sched_try_switch();
+	}
+}
+
 #else /* !CONFIG_LIVEPATCH */
 static inline void klp_sched_try_switch(struct task_struct *curr) {}
+static inline void klp_try_to_freeze(void) {}
 #endif /* CONFIG_LIVEPATCH */
 
 #endif /* _LINUX_LIVEPATCH_SCHED_H_ */
diff --git a/kernel/kthread.c b/kernel/kthread.c
index fdb8fb07f40b..87a13421da7a 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -198,6 +198,8 @@ bool kthread_freezable_should_stop(bool *was_frozen)
 
 	might_sleep();
 
+	klp_try_to_freeze();
+
 	if (unlikely(freezing(current)))
 		frozen = __refrigerator(true);
 
