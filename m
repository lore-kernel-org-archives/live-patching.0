Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795678137;
	b=SWHJUwCIyeMaTVgGqR9hA1CFG3vZugVFaRKGKd/MEb5Er2cTEbABaQlpdttNCuTY/kpQ
	 TDaEOwFSp36a/5trF1BB/cmkjwVOtTL8HtOz18EpXWV3cAEbaMRFzUaWEcyrAZtJP9FlF
	 Rbdz5LL10dnLYBeKp9L5SuRTL4SRtjyJTsF3Qzikw4S8xX/dwcWxv1P2HumrxCgRCiDzL
	 1WfFxRNZwi6qYM2qcNdZaqNowQnoYhBRas2pI+HX79HyfZTjcsDKChY+BAFHN0buwefKw
	 F8nJrc7N+EgOOMngZd0pZ5+N5Gg6Hr2PqB74hlBCmq3zZ0gqGEy6/kcf3h28J6Xg1LQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795678137;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=kAalqxfxZCZO4sNiFlK3ouIz24MCsQGbMzL88+QHtpw=;
	b=T5XsPFS0oWVd+eUQhSNe6B8w9Rml7hERmFXErKuTCd9Do+aIH/OxHNqFTjY+DN7nUinK
	 AvsSkjf06Ts1VPYbSmTQh9RiIH2vXQI9usvOIGBim4dqWNwUoyjX18u3S19bN+Dvc6ZPc
	 2NGxIScHyTICbU4V/24G19yZKYLtMgJO9AhPyiMxOfiLqTE84VotnCD81a6k7Ghy2rEEM
	 aN0seFeVkBDvK0YonKhD8FHlD72A+epCF7MjircQvZ07gINYkDSmpxLuyIAYg5OjzRxPA
	 cCZSyNuSt04dza9aWQXuBjFtfSWRkssSaMlC5PqpfmpOi+XDdssoxMJjzhg0EeFWp4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nUHlouIf;
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49AF606A323
	for <live-patching@vger.kernel.org>; Thu, 26 Nov 2026 07:28:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C49AF606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nUHlouIf
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3b09a83d12aso4657173a91.2
        for <live-patching@vger.kernel.org>; Wed, 25 Nov 2026 23:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795678136; x=1796282936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kAalqxfxZCZO4sNiFlK3ouIz24MCsQGbMzL88+QHtpw=;
        b=nUHlouIfEWRaW5BM8C4xx9IPmfLhYRQfxvdZrYws7+GyVLmwswxZMAIwV9qv+/WqMy
         gZh7+LdcmmSBeFiny6nudMfGlIknw2BrE2NBONcBeC/lo0Pea7GaCEuCgebaWZeGBdvw
         JaL9cAfAp1LMQsaMSUqM6pBMcGNLAVCl21ChbSgtEbG+qZ6ooZWzniRhsgLts9fK28nb
         1DWHPUD07TSACo3IauAv2dZ0WDMdj0jPtfkzLqvNhaAmjlYn7VSPg6mt2zqcjrWoZTEL
         c6l1dajvcVpvGAsCZHsQn+Ack4xHjA/M6ClGpx+FqkMcvtwShNkAGgD6XfJMAe67aQME
         cJPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795678136; x=1796282936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kAalqxfxZCZO4sNiFlK3ouIz24MCsQGbMzL88+QHtpw=;
        b=JN6UChT6oP0OfXtt/KJCaoAG+M+/cDqKEex6xwvhbgkg9qSfRUwf+QB8Tuk0MBtUMI
         OrdsnLa3zCSVZnJk8i4yJ2ChxmvlBKKpKcdIZ5lzTf7BoxDKqZ8qMh6NNCCrXAgFGqzM
         eosm/9AYqBsi17bYjsi5KIuOgTlB3QE49ZEh94pP2SYfAOP3L+CZeYXJwwA/hT4+7A6L
         ac9TtIIQOpygRIBZa0CzDAYg8VLgpZLUKy45NQfuEeLGW6YLWu80oTWoHP2Up8W44IOd
         SOPJUd8oAniMXpF3w+iFf/AP69UvzC2wEIZbXD+UujVIpCkEuDlz+FX+UbkhhURggYou
         je2g==
X-Gm-Message-State: APuU4Z9icX9Jb239ctwz+QZT2hjntfokV5e3lSrtbF8H0wtAzuUzu7qW
	0onZpIJfl9zBJMraY4EQgYftewTvWm1scXSWKmYOGAeEQCoVZ2UO/F5S
X-Gm-Gg: AZFdTZf3UBejkf+hRZC7oUAnf51p4GJxMlXhVuEair5qGlFKL6RbAn/xgY+Dq7e3s2p
	cZjTRXQPEXDHbno5s2p2Tf+L7eNeLIHSBWdjHHbbrNjI5x1laGuf5nfFpXh/7oADdJP8+5csWaf
	R5DyVEdb21GuJTVlg2gEhkdQrA40IY+5f/r0mY2+/tewZJX9hfWXicbvSN6+JPA7vy5cHlexgC6
	8JRbTU5zRGKnrNcCsBgqbf2Pv5r6izdW8czcDhnabE7M3BayP0pXoZkMRlLlS/rYF6ovtQS0+rY
	Cqh/tLAi9o30bykXP3oYBV2UQP4AfY+zNexZmYK/ZKUwIRYdQqcb3/XnCEFIXqrfP//RgNl65bX
	zOToqsaKS7hRwlQItysC0mlD17zoFbfNYbltpccQetwtSvsOrZ8Q/QOj5oG/LOLzPDIWb+U5AEV
	GkZ8yEzH7LGLdlf9Fgg8KJTfs115gSqoZAZksHylFv3LftkB+kByiVGwAAJd6agiH7CHWJxBH1k
	xw/NqNHMeyaQRzOBgT2lYRXsl2BwzRZ9lgQ69L6ktGezSzPiZtYNdinUHKN/Gs0kUftnmH7+jz9
	7lv1L+d6nEkAbeAanUrZ8uhhkeOotRHz+2X5GrYj6Q0FT/3deSQvbwXD4Rz56Olmyz2u87+sKwR
	ushMej4JHc6EbQeymfiqkxg==
X-Received: by 2002:a17:90b:4a47:b0:3a8:9d0d:ca50 with SMTP id 98e67ed59e1d1-3b41c8fe84amr20623464a91.10.1795678136058;
        Wed, 25 Nov 2026 23:28:56 -0800 (PST)
Received: from localhost.localdomain ([240e:46d:2300:827:b108:4552:5e9:4319])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b44b217a5bsm14772112a91.0.2026.11.25.23.28.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 25 Nov 2026 23:28:55 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: jpoimboe@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	song@kernel.org
Cc: live-patching@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v3 2/2] livepatch: Avoid blocking tasklist_lock too long
Date: Thu, 26 Nov 2026 15:28:29 +0800
Message-ID: <20261126072829.97792-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261126072829.97792-1-laoar.shao@gmail.com>
References: <20261126072829.97792-1-laoar.shao@gmail.com>
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

Problem
=======

As more and more patches accumulate in the cumulative livepatch, we see an
increasing number of latency spikes from latency-sensitive services during
livepatch upgrades. The most recent case is the redis data_server [0].

With some tracing added to the userspace redis code and a hard trace in the
kernel, we finally tracked the root cause down to tasklist_lock contention
during livepatch transition.

When redis flushes data, it clones a new task, which takes the write side
of tasklist_lock. If a livepatch upgrade is in progress at the same time,
tasklist_lock is held for the whole transition. Below is the trace we
captured while reproducing the issue:

=== [2026-11-15 15:18:06] tid=1635309 comm=data_server  WRITE wait=79372 us

        queued_write_lock_slowpath+276
        queued_write_lock_slowpath+276
        _raw_write_lock_irq+69
        copy_process+3474
        kernel_clone+157
        __do_sys_clone+102
        __x64_sys_clone+37
        do_syscall_64+56
        entry_SYSCALL_64_after_hwframe+100

=== [2026-11-15 15:18:06] klp scan held tasklist_lock(read) ~ 96864 us (comm=insmod)

        klp_enable_patch.cold+247
        init_module+477
        do_one_initcall+70
        do_init_module+82
        load_module+2526
        __do_sys_finit_module+200
        __x64_sys_finit_module+24
        do_syscall_64+56
        entry_SYSCALL_64_after_hwframe+100

=== [2026-11-15 15:18:08] klp scan held tasklist_lock(read) ~ 3504145 us (comm=kworker/8:2)

        klp_transition_work_fn+36
        process_one_work+492
        worker_thread+83
        kthread+235
        ret_from_fork+31

  crash> p klp_signals_cnt
  klp_signals_cnt = $1 = 1

The latency budget of our redis workload is 50 ms, while the clone() call
observed during the livepatch transition took ~79 ms.

Environment used for the reproduction
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  server: 256C AMD EPYC server
  tasks: 1000~2000
  number of patched functions: around 80

Solution
========

The redis application can work around this issue by removing the clone()
from its data flush path, but I believe we should improve this in the
kernel if we can.

In 2025, we discussed completely replacing tasklist_lock with RCU [1], but
Petr pointed out that it is far more complicated than we expected [2], so
we ended up abandoning that idea.

We still have a more lightweight way to partially replace this heavy
tasklist_lock with RCU, as Josh suggested [3]:

  : Maybe klp_try_complete_transition() could iterate the tasks in two
  : passes?  The first pass would use rcu_read_lock().  Then if all tasks
  : appear to be patched, try again with tasklist_lock.

This patch implements that suggestion.

Verification
============

I verified this solution on my test server:

  server: 64C AMD virtual server
  tasks: ~2000 processes with ~8000 threads, ~30 running
  number of patched functions: 200

- Before this patch
  the maximum clone() latency during the livepatch transition exceeded
  500 ms.

- After this patch
  the maximum clone() latency during the livepatch transition is below
  20 ms, which is within the range expected by the redis side.

Link: https://github.com/redis/redis [0]
Link: https://lore.kernel.org/all/20250227024733.16989-1-laoar.shao@gmail.com/ [1]
Link: https://lore.kernel.org/all/Z8CRXxfI24E9_IHC@pathway.suse.cz/ [2]
Link: https://lore.kernel.org/all/20250213013603.i6uxtjvc3qxlsqwc@jpoimboe/ [3]
Suggested-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/livepatch/transition.c | 44 +++++++++++++++++++++++++++++------
 1 file changed, 37 insertions(+), 7 deletions(-)

diff --git a/kernel/livepatch/transition.c b/kernel/livepatch/transition.c
index 4739fc170f48..2f3cffa897a8 100644
--- a/kernel/livepatch/transition.c
+++ b/kernel/livepatch/transition.c
@@ -458,12 +458,34 @@ void klp_try_complete_transition(void)
 	 *
 	 * Usually this will transition most (or all) of the tasks on a system
 	 * unless the patch includes changes to a very common function.
+	 *
+	 * To avoid holding the tasklist_lock for too long, we iterate over the
+	 * tasks in two passes. In the first pass, we use the lightweight RCU
+	 * read lock to iterate through most tasks. This pass will cover the
+	 * majority of tasks, except for some newly forked tasks which may be
+	 * added into the tasklist concurrently. In the second pass, we acquire
+	 * the tasklist_lock to handle the tasks missed in the first pass.
 	 */
-	read_lock(&tasklist_lock);
-	for_each_process_thread(g, task)
+
+	/* First pass: Iterate over tasks using the lightweight RCU read lock. */
+	rcu_read_lock();
+	for_each_process_thread(g, task) {
 		if (!klp_try_switch_task(task))
 			complete = false;
-	read_unlock(&tasklist_lock);
+	}
+	rcu_read_unlock();
+
+	/*
+	 * If the first pass succeeded, grab the more heavyweight tasklist lock
+	 * to check any newly forked tasks.
+	 */
+	if (complete) {
+		read_lock(&tasklist_lock);
+		for_each_process_thread(g, task)
+			if (!klp_try_switch_task(task))
+				complete = false;
+		read_unlock(&tasklist_lock);
+	}
 
 	/*
 	 * Ditto for the idle "swapper" tasks.
@@ -695,17 +717,25 @@ void klp_copy_process(struct task_struct *child)
 	 * the thread flag was copied in setup_thread_stack earlier. Bring
 	 * the task flag up to date with the parent here.
 	 *
-	 * The operation is serialized against all klp_*_transition()
-	 * operations by the tasklist_lock. The only exceptions are
-	 * klp_update_patch_state(current) and __klp_sched_try_switch(), but we
-	 * cannot race with them because we are current.
+	 * Disabling preemption explicitly is only needed on CONFIG_PREEMPT_RT:
+	 * there tasklist_lock is a sleeping lock, so write_lock_irq() doesn't
+	 * disables preemption. Without it we could be preempted between the two
+	 * reads below and the RCU pass could switch us, tearing the
+	 * flag/patch_state pair. On !CONFIG_PREEMPT_RT the spinning
+	 * tasklist_lock already disables preemption, so this is a no-op.
+	 *
+	 * The only other updaters are klp_update_patch_state(current) and
+	 * __klp_sched_try_switch(), but we cannot race with them because we
+	 * are current.
 	 */
+	preempt_disable();
 	if (test_tsk_thread_flag(current, TIF_PATCH_PENDING))
 		set_tsk_thread_flag(child, TIF_PATCH_PENDING);
 	else
 		clear_tsk_thread_flag(child, TIF_PATCH_PENDING);
 
 	child->patch_state = current->patch_state;
+	preempt_enable();
 }
 
 /*
-- 
2.52.0

