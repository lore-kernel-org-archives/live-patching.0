Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794891184;
	b=OnW3qWB6ICr/Mm43NinK/khyZm6iNQl3Oj+Z41++DV5JZAMhIsfiMySgFMUpz/eAvZES
	 yrVn59j2ScXNJ9XLFHQubvPEg8Z77GTspkw1RMxlQBY1MKLpmOvBAgHwMIQG/AqEQJoi3
	 na8F5mWH28lVeP7ZE9IQMo4+7tL8qaFoJRUhS8+uimOn86Pti9wTKdLOiG+zgwj3/Pb39
	 NsHBW/PHNrF4YCsztXnJIMtaawolM23mZ1pzvy+i46PjEJBf0WNIXcJai3N758Xn8RZtK
	 RlOUDktqxhk9KQdg6tj2mYf1qTXygq/8Xxf9A2Sls3HHxGiyoalds5TlCbxu2tH7uPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794891184;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=uYOWyoTwdGB1zBQKTb94yS19n4vxEQPiG111QSznMfk=;
	b=1IdU4kGhj5bNCy5+qzh2y20cxDXIIJ1BOzAgxCUdoy+Fp33VWTTyGBFd+xu7o/we0ahJ
	 KyHj070Nin0bkVkNT3wrz6vhxK8khKjcLaEjOnVxjnK+8EsKQJT1xfi10BxtVYZ91vjjB
	 UWP/8nKBzJXacsMw80FtN+brQfSht7WIvbt7i+LP9HJZpIslbDnfGoe+ZIhryF0hO1sdI
	 jCsD9LACNdMmtG8L1L51K3cPPoStV+dKZ3Zw2GBlilPPgRsw0OWBDEgRXmkIDriKSrXSr
	 EmvlaZ4cXH4Wf/uCsdG6X07qpPH1vltTWsSLVwqwHjdxI23w34C7imdn6VZVBYgYmQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dylanbhatch.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fLoJXj9U;
	arc=none smtp.remote-ip=209.85.214.197
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD13F606A323
	for <live-patching@vger.kernel.org>; Tue, 17 Nov 2026 04:53:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD13F606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dylanbhatch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fLoJXj9U
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ee184a2474so29856685ad.2
        for <live-patching@vger.kernel.org>; Mon, 16 Nov 2026 20:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794891182; x=1795495982; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uYOWyoTwdGB1zBQKTb94yS19n4vxEQPiG111QSznMfk=;
        b=fLoJXj9UEhu3Vmkbdkou3wYmEHIq6PzMgFNe/gen8xGRbE0bDpPg1AShDFe7A1rylb
         LjYqBJ7Dvix1ae6a51qESzNgaowA123Jq7JSc8r5Af1v1UYVFrJJjoQ8OQo0VNv3RAv/
         pWpA/En94uLZKLSXiJwu42hUqtI3UNmCo4mQOMears0B3IoRwL8L+Luzg61O7DyP5/nv
         IVTsvt83yiF+F62fEgGEtRDKR4H7scIkJq49UimfiEC6ZH2VzGe+YhnXEylah5+tiYrN
         XKHYVqU1WlethUqmQsJF4+X0BODRMf9dQ9ccLZ8fTg4R+hayrPkCiJMxGFj+vTucXZfb
         PBRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794891182; x=1795495982;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uYOWyoTwdGB1zBQKTb94yS19n4vxEQPiG111QSznMfk=;
        b=cAjfAY6biYMZxhzqptsJSYxoPXs54C/YgTVrByPQZqUaoil3pmpykkR1quZB+3sb7x
         B30M8ZvgyzVjtIC33Xaichn2GIQbcB7Qbk1eIy6DQJYu7UVKJOTLhl4dcrgD8+lwY3Gs
         //iKr8AxEFCOvK7gFZk2W+3TeiC1Zqg8nwa/E2Ik172ruJ1gviQhRszzFT9ejEa+mRBy
         MmhJyfTi+K4Uauwr8p1Dl9oMtjwIoShSv+R3mpqarELi75+gvbgbiW9zt6pYgHC7RfSw
         gshoiDTAp2utI6E4pHVgpRcquYvR06W/wWzXagfHhJLTfRyfjlVobUZtI/sLSvXPw6XT
         eoow==
X-Forwarded-Encrypted: i=1; AL+hErGZM7bmZHaUUR7w3E7N87fouPNuomygMyd2usKwc7G59U3vDHVtEgsGqie4LVUzKxepzVVzbOvzMZgwWG48@vger.kernel.org
X-Gm-Message-State: APuU4Z9H4H4IUZ+Nzw4c18DQvGCf90ANQektAg5G1lzaMMMcd4f2qd/H
	u+5tZOldS97y0KGgBK5YmePXIuuuAVWE7GcB7z1yYVSbuJKNqgUFYb0S7yfllXX1Yh6JGFV64tw
	Ixl0qEZ3bPRjtDPU4IIBRfNJYBw==
X-Received: from plbjj10.prod.google.com ([2002:a17:903:48a:b0:2ea:7f9c:2ce])
 (user=dylanbhatch job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:d4c9:b0:2ed:38c0:3328 with SMTP id d9443c01a7336-2ee0dac397dmr120063995ad.28.1794891181828;
 Mon, 16 Nov 2026 20:53:01 -0800 (PST)
Date: Tue, 17 Nov 2026 04:52:52 +0000
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.679.gc527c65306-goog
Message-ID: <20261117045254.1048298-1-dylanbhatch@google.com>
Subject: [PATCH 0/2] sched, livepatch: Fix transition stall for CPU-bound tasks
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
This causes livepatch transitions to stall when CPU-bound kthreads or
PF_USER_WORKER threads (such as vhost-<pid>) spin in a kernel loop with
cond_resched():

1. A sole runnable task on a CPU (cfs_rq->nr_queued == 1) never has
   TIF_NEED_RESCHED set during sched_tick(), and wake_up_state(task,
   TASK_INTERRUPTIBLE) in klp_send_signals() is a no-op for a
   TASK_RUNNING task. Because _cond_resched() is a no-op under
   CONFIG_PREEMPTION=y, the task only enters __schedule(SM_PREEMPT) on
   return from interrupts via irqentry_exit_cond_resched() when
   TIF_NEED_RESCHED is set.
2. Even when __schedule() is entered via preemption or an unfreezable
   sleep (such as PF_NOFREEZE kthreads or PF_USER_WORKER threads
   sleeping in TASK_INTERRUPTIBLE), curr->__state does not have
   TASK_FREEZABLE set, so klp_sched_try_switch() skips the task.

Patch 1 fixes both issues by dropping the TASK_FREEZABLE check from
klp_sched_try_switch() (relying on stack_trace_save_tsk_reliable() in
klp_check_stack()) and calling resched_curr(rq) in sched_tick() when
klp_sched_need_resched() is true for the current task.

Patch 2 adds a livepatch kselftest (test-cond-resched.sh) that spawns
kthreads spinning in a cpu_relax() + cond_resched_tasks_rcu_qs() loop
and verifies that livepatch transitions complete without stalling.

Note on reliable stacktraces across exception boundaries:
Because _cond_resched() is a no-op under CONFIG_PREEMPTION=y, a sole
runnable spinning kthread enters __schedule(SM_PREEMPT) from
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

This series is available on github: [3].

Ref:
[1]: https://lore.kernel.org/all/20261117020648.323464-1-dylanbhatch@google.com/
[2]: https://lore.kernel.org/all/20261117043504.1021063-1-dylanbhatch@google.com/
[3]: https://github.com/dylanbhatch/linux/tree/stall

Dylan Hatch (2):
  sched, livepatch: Fix transition stall for CPU-bound tasks
  selftests/livepatch: Add cond_resched() kthread transition test

 include/linux/livepatch_sched.h               | 13 ++-
 kernel/sched/core.c                           |  3 +-
 tools/testing/selftests/livepatch/Makefile    |  3 +-
 .../selftests/livepatch/test-cond-resched.sh  | 73 ++++++++++++++
 .../selftests/livepatch/test_modules/Makefile |  1 +
 .../test_modules/test_klp_cond_resched.c      | 94 +++++++++++++++++++
 6 files changed, 183 insertions(+), 4 deletions(-)
 create mode 100755 tools/testing/selftests/livepatch/test-cond-resched.sh
 create mode 100644 tools/testing/selftests/livepatch/test_modules/test_klp_cond_resched.c

-- 
2.56.0.679.gc527c65306-goog

