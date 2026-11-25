Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795580363;
	b=Wq72Hy6RTd3L1/xuwIdeauP/R/dj9M2MUBCjWc98sfubELPK5gGCznCU/U/1jhuX1y+w
	 AvMii1oXlMVsdNuzVMaw/c2VzNPgzQjh1v/viZGAowOZ3e35iXTCabZu1oDPNFe/VEDSM
	 TMlrhh5AZBcletU7hKmdbOpdxD8TMq4RWub+yrRzoT/1xSnX1RuqeXBbEwk1iEDgtACmT
	 cDlVQHjDlMUrOemy5V+Kj8Xu5p4d9bH9gDJgt9z3MLq+CEsfo+XliW9AJS2StM1Xg+y4f
	 VEItxVc5Key27BSIIToChKcIT07Xpyw/HEc0e3OEtTRCNcysOKcBPMQvQ+x5TagOpMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795580363;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=RYnkiQyubE+RoSa9gUQ9ASOysahxUWtjtOAnaQCLo/U=;
	b=udI4XaCmc6rExKaw4wS5J1xIi6HYa2lUCX4ZLBAVAse3aPhP1iIby+8THTTMipF1R5U9
	 Dnr2xNVCgWoJ/QqLALP8OKnXdo8XqXYyhbwa9CV/L4cHJGfyeiwL4D+na+zdvEhqxxB+0
	 d8bKQ1FtgiD42qnL/KVyM17DNqCmzB5hNXfNcWGwJADTjj/+39LIVES9msj5ncy7c3J3k
	 CHmDYLjDrtFWlHT1TDW9LpYH+5Aj57cgGqaz6gne1Usa8qQ8LCuzBBjvD9fSDk+urDPGV
	 wuLAweYPk11Yx4Jp3Hm8TjG+5TCH/tChn57JSuD+CW8UUQbDLWu8eg4Z3bAAX1p/OHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dylanbhatch.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=E8RYveAk;
	arc=none smtp.remote-ip=209.85.214.199
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8DF606A323
	for <live-patching@vger.kernel.org>; Wed, 25 Nov 2026 04:19:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B8DF606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dylanbhatch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=E8RYveAk
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2edd25534afso44739585ad.2
        for <live-patching@vger.kernel.org>; Tue, 24 Nov 2026 20:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795580362; x=1796185162; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RYnkiQyubE+RoSa9gUQ9ASOysahxUWtjtOAnaQCLo/U=;
        b=E8RYveAkeEIukDtM/Boc8gSnLVh3QA5sID71kcwgek7WjlJnYphsQ13PNqTHEHeNdS
         crDWnOi2uUMfHbIOX1QZiaxVNAiTHWW2Mu3cWYDWwB8D+NkYJjqUS17lGjHR7rJtO7BE
         UbJZUcp8gVcavT6TC3/E/odyQ3RLMGPOrvokaK3gU5xuUlGWzywpSP65hdudiEJx8ST+
         cUemHtAskDjg//sJLlQidfhvEAR/mBAtJcm1sXNcGkf4zMLl6IU1RyubIbauvXPX0KTg
         qvL319c8wSoyTXrJxO5irh9sORVwWZgwlKjbECw4BmEPvOFIcCClfRdvzLBl4FFOtQW7
         3vYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795580362; x=1796185162;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RYnkiQyubE+RoSa9gUQ9ASOysahxUWtjtOAnaQCLo/U=;
        b=Qdw06nm01z6IydwlS/2ZbBuCkg0OYFHAek7BO/ojW0KLTuKpLdyZlk3uyyXC3XjLOC
         S98R6Pbcstlp8zyxzMIGzTjOkMcY9n8LUar9dLnznJwpXjz4bThkKgpbTq1u/3CrQLxH
         uoOEEbPzfyhnM/ZBjtygiJl0duyZmEe2NmnVxq/tvhSXO5vtaSu2mfJZ2mSlgToj92P+
         3CI7PSEAINB80HqsBSNLQM7ZK7fzlJlGYVFH93DbFr5GvzHzaAa9tAZ6fdYSdkEaFrvp
         ZII0NsGswDtspE715+w1tWUw0/eEhegvXune5qn59BHYrlIbk1bU/mIPleL7HxqGMP3Y
         stNw==
X-Forwarded-Encrypted: i=1; AL+hErEpT7R+M3X4Iee1BkmLHc3E9t883KOlGDSPj8Z8YHkMSuJzqh99qKVK58uiASEfJy9/upeIv47+r6F7/7Wi@vger.kernel.org
X-Gm-Message-State: APuU4Z98uHoyqIFJQYMAwPNwj1cElw31kJhuK2JH/V3NrLyiaCDnR+6M
	+jM87Q5ilSuXq01SWwiLvGZaSOvkjEX0e4e7bMarehtlOyd9XhVZrYMSZ/VFhUm2UTRf+9PL2By
	/Nlu1h7Q6PYkk2WJnzLtRArqQAg==
X-Received: from pglk23-n2.prod.google.com ([2002:a05:6a02:6b97:20b0:cd8:2b49:af45])
 (user=dylanbhatch job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2701:b0:3a4:acde:1e3b with SMTP id 98e67ed59e1d1-3b41c8dd232mr15615461a91.13.1795580361641;
 Tue, 24 Nov 2026 20:19:21 -0800 (PST)
Date: Wed, 25 Nov 2026 04:18:58 +0000
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
Message-ID: <20261125041900.3243569-1-dylanbhatch@google.com>
Subject: [PATCH v2 0/2] sched, livepatch: Fix transition stall for CPU-bound tasks
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
live-patching") moved klp_sched_try_switch() from _cond_resched() into
__schedule() and gated it on READ_ONCE(curr->__state) & TASK_FREEZABLE.
This causes livepatch transitions to stall when CPU-bound kthreads,
PF_USER_WORKER threads (such as vhost-<pid>), or user tasks in long
kernel loops spin with cond_resched():

1. Even when __schedule() is entered via preemption or an unfreezable
   sleep (such as PF_NOFREEZE kthreads or PF_USER_WORKER threads
   sleeping in TASK_INTERRUPTIBLE), curr->__state does not have
   TASK_FREEZABLE set, so klp_sched_try_switch() skips the task.
2. A sole runnable task spinning in the kernel never gets
   TIF_NEED_RESCHED set during sched_tick(). In klp_send_signals(),
   wake_up_state(task, TASK_INTERRUPTIBLE) is a no-op for a
   TASK_RUNNING task, and set_notify_signal() sets TIF_NOTIFY_SIGNAL
   without TIF_NEED_RESCHED, so the resulting reschedule IPI returns to
   kernel mode without entering __schedule().

Patch 1 fixes both issues by dropping the TASK_FREEZABLE check from
klp_sched_try_switch() (relying on stack_trace_save_tsk_reliable() in
klp_check_stack()) and kicking still-running unmigrated tasks via
resched_cpu() in klp_send_signals() (as well as waking interruptibly
sleeping PF_USER_WORKER tasks).

Patch 2 adds a livepatch kselftest (test-cond-resched.sh) exercising the
klp_send_signals() reschedule path for both CPU-bound kthreads and user
tasks spinning in kernel mode.

Note on reliable stacktraces across exception boundaries:
Because _cond_resched() is a no-op under CONFIG_PREEMPTION=y, a sole
runnable spinning task enters __schedule(SM_PREEMPT) from
preempt_schedule_irq() with an in-kernel interrupt pt_regs frame on the
stack. Switching the task in klp_sched_try_switch() therefore requires
arch_stack_walk_reliable() to support unwinding across in-kernel
exception frames. This works on x86_64 with CONFIG_UNWINDER_ORC=y, where
test-cond-resched.sh passes with this series.

On architectures or configurations where arch_stack_walk_reliable()
currently rejects in-kernel exception frames (arm64, powerpc, s390, or
x86 with CONFIG_FRAME_POINTER=y), test-cond-resched.sh exposes this
limitation and will fail until exception-boundary unwinding is
supported. On arm64, the test passes when combined with the proposed
kernel SFrame unwinder series [1] or equivalent .eh_frame-derived
unwind tables [2].

These patches are available on github [3], with an additional commit
containing extra tracepoint validation.

Ref:
[1]: https://lore.kernel.org/all/20261117020648.323464-1-dylanbhatch@google.com/
[2]: https://lore.kernel.org/all/20261117043504.1021063-1-dylanbhatch@google.com/
[3]: https://github.com/dylanbhatch/linux/tree/stall-v2

---
Changes since v1:
https://lore.kernel.org/all/20261117045254.1048298-1-dylanbhatch@google.com/

 - (Josh) Drop the sched_tick() hook and instead force still-running
   tasks through __schedule() from klp_send_signals(), avoiding per-tick
   preemption and reliable stack-walk overhead on unpatched tasks.
 - Use resched_cpu() rather than set_tsk_need_resched() + kick_process()
   when kicking remote tasks in klp_send_signals(), and apply it to all
   still-running tasks (including user tasks spinning in kernel mode).
 - Update test-cond-resched.sh to deterministically exercise the
   klp_send_signals() reschedule path for both kthreads and user tasks
   spinning in kernel mode.
 - (Sashiko) Bounds-check target_cpu against nr_cpu_ids before calling
   cpu_online() in test_klp_cond_resched.

Dylan Hatch (2):
  sched, livepatch: Fix transition stall for CPU-bound tasks
  selftests/livepatch: Add cond_resched() transition tests

 include/linux/livepatch_sched.h               |   2 +-
 include/linux/sched.h                         |   1 +
 kernel/livepatch/transition.c                 |  19 +-
 tools/testing/selftests/livepatch/Makefile    |   3 +-
 .../selftests/livepatch/test-cond-resched.sh  | 204 ++++++++++++++++++
 .../selftests/livepatch/test_modules/Makefile |   1 +
 .../test_modules/test_klp_cond_resched.c      | 141 ++++++++++++
 7 files changed, 365 insertions(+), 6 deletions(-)
 create mode 100755 tools/testing/selftests/livepatch/test-cond-resched.sh
 create mode 100644 tools/testing/selftests/livepatch/test_modules/test_klp_cond_resched.c

-- 
2.56.1.839.g22a8290db9-goog

