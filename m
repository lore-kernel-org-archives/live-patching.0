Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795401690;
	b=p/wN/Op3qoEmd8mdDGddsEaww26c9aJutRqwp4n1G/kzFEdjegyuCt5SZZz6wVGVU7WB
	 YpXa1+RPSjUuAktNwCTLfUMIT4fT7ufrULPLKKcBXrTmqOysR6tXB+g3VT7R1twVDtlEN
	 3ZqFRNHQx+7yNWy4qkpD4s9vYJqTiDfFqNfFPtAW6R+0G6JJsk2UvzR+qq7/JGl2i+5nt
	 DMDG9qTcteXS7UsBWSWez1Z7s5kTDRTMb4NTaLwyJG8OfF9/+mKSvcINUFGVQtsSjyfvZ
	 uv0mR9JpuM173BVsy3U+29eEvlL4ky3M5mFI5i/wQQUgyKCoMklbqbO61payGEOsK8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795401690;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=DCR5n0TbPRkgr0wo/HBC8V7L6UUpxciDosZVJpsgNo4=;
	b=JjzTr1TmLVpMs9BnSBDYpZMSnf2ZWCWAgIEp8YNFHflW2+taWzsgPR3CDs5NyDni7X++
	 5kw8OUGFwZ3ZVh+ssf1+kBgLN+eTw53FCGTsR0LGMLApva9cM3Ll+28yRjgAU9nJeLWh4
	 B/3/BaH+4gXUw0kBq2UIUrCMdfg0nLMPBvpRhI4WlcdDD0J2siZLn/NjIGFCDxEIuLqmK
	 f2p90oLQcMvEVo9buENQ7WmCKmesryqRJj5aoUYg/nblxKFKkmn41ED6TOqlA3mRXd6XE
	 Y+PGjUooM3+oKmVt01pFccgLMQ9aERbJ3nuh3WJAW+qbPkPLjWxuNmNsTq4LEpBAkfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xlIlDPv6;
	arc=none smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88BA606A31E
	for <live-patching@vger.kernel.org>; Mon, 23 Nov 2026 02:41:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D88BA606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xlIlDPv6
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2f0458cc9easo19607025ad.3
        for <live-patching@vger.kernel.org>; Sun, 22 Nov 2026 18:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795401689; x=1796006489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DCR5n0TbPRkgr0wo/HBC8V7L6UUpxciDosZVJpsgNo4=;
        b=xlIlDPv67XPYULIFOaX4co/fFKiXdHOFa6LiQwo6g8rb6SCWpxerQXmsmE5IdzJ2sH
         h46V/emgEHVLlpczAOB0WpLo9fXwq0Z73I4voLNt7wgJfRp3DK3O+PfvII3Lf0USlF1y
         BmHj+imZrqNDNglQKaNrSi7YvloxECE+jLmgH42A8HsBRG92G220ndS9FvMfwfA9/lfD
         6WsgZcHcKR/jBxRsOET6Cl3Dk/bWpvZJzBhHrUIWcd+3UeO6vSJtG8gid9GBls/b5TGL
         NHyI2zcQ6Sf7zCe+3zPgX2Qnne9EBj1b7mDJjs5Q9EdyoGSj/HfXBKn2FxXEqFlStUgG
         MQkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795401689; x=1796006489;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DCR5n0TbPRkgr0wo/HBC8V7L6UUpxciDosZVJpsgNo4=;
        b=A/QUiLngSnApoSc5T/tgoPSvciB0USuHDeqsjlfZxsdLzBFS0krjr2safYFdSjfStj
         +ka2UdQX/CoV8yijidjVTjDmLfuMbAhm9usuEZMXnAWyYjDMT5grI8w2UxF2kOGjawbf
         mrCqTxSlG+GeNJQrF2RyeVqCYdF3Qs3d51b7PzfjVFKeanjKVhV4oBOhJB4vQKQ2ARPS
         9jeLFfAzrRxj4mC5/t4QHokYOp7WOQ9Y6rIaXRydLpwg/ER6vwj+ybNbkz7N5je21Zqv
         00CJ9UmZLA9kGVyfsTetxTcor8Mpg7fWWYMK+sxd3t+e0+4tbNNDoWqJ1H00rVLRxf9C
         CvKg==
X-Gm-Message-State: APuU4Z/ojctw+rya6bsRsJ//9P3uktvEEnyMVCvIUMvL8vcZGksPspkj
	oIdpALl22asNFzWROi6OLlTCu4zgn0bp6UOMo5hQ+bjpCrIc93fFltwk
X-Gm-Gg: AZFdTZdL4A4T+VcS+111cOVcr2D0Gj55Bc0mV0GGGSsQ7EXtNVmX1GkNlQqwGEgFKV5
	d80Epw0hBSZABiE+PgXIoAFKdhk2pCNQo11cHX6ZSglwO8T1QRMMx+vqlIyQbbDtJ0Ut3RirRV7
	shLJY+7V33CxKcqXR3nRdbKeIISbpeuMFrO7e0nq7q8dLPjbLzRvpTGjtj8nWkQWI0trfYLOE5b
	W1kA/ZKkXi2czmf2EXQSHHhInfey7PNi5Fi/w+SkpnUqhIe5Fz7SWWQF4ZntNMy2I7YS481hf4n
	w8uAkA3j7iPOLqCZhruKIa7luFqLb5r7vB0Z98iYb3Cun8Oa36HH3nXMLZCo9NDrlMDpgmT6p3h
	m8zZF+71lh0J2knKlk2xm6ijqyp3H5yDxzNIhPlbG40Kby6kivAcI6zxUFvNiX/iAdL+11TvBkI
	i02b1JNxuFN6s523pb23rB0GQZFL5I9lEcG+Fd6rv9hJwwH3ANGHZW3BK7a5tVUGUVUfJUx/AFJ
	eME4MXE4mP3bt1tDlyxsg9QL2ZNVIKB910Ore7MViz2FKAVTN6d1RIG+kTJv8eNjoq6jh31nZax
	UX4YeH5X/TBxDseXV38usX/7PrusvkarALae/IsK1pB6FCHjjhiTgij7TjHtDX5OeTSPh8DKbzR
	07WTK1cQlNtGBzrEvpCCGew0=
X-Received: by 2002:a17:903:1ce:b0:2ef:d157:e128 with SMTP id d9443c01a7336-2f03f1e8493mr100110335ad.52.1795401689016;
        Sun, 22 Nov 2026 18:41:29 -0800 (PST)
Received: from localhost.localdomain ([240e:46c:1b00:720:54e4:b505:2937:4e95])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f0c1a69sm42783495ad.18.2026.11.22.18.41.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 22 Nov 2026 18:41:28 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: jpoimboe@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	song@kernel.org
Cc: live-patching@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v2] livepatch: Avoid blocking tasklist_lock too long
Date: Mon, 23 Nov 2026 10:41:19 +0800
Message-ID: <20261123024119.16154-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.50.1
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
 kernel/livepatch/transition.c | 48 ++++++++++++++++++++++++++++++-----
 1 file changed, 41 insertions(+), 7 deletions(-)

---

v1->v2: improve further by skipping the second pass if the first pass fail
	(Josh)

diff --git a/kernel/livepatch/transition.c b/kernel/livepatch/transition.c
index 2351a19ac2a9..0953372359b7 100644
--- a/kernel/livepatch/transition.c
+++ b/kernel/livepatch/transition.c
@@ -444,12 +444,38 @@ void klp_try_complete_transition(void)
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
+		/* klp_check_stack() requires preemption to be disabled */
+		if (task == current)
+			continue;
+
 		if (!klp_try_switch_task(task))
 			complete = false;
-	read_unlock(&tasklist_lock);
+	}
+	rcu_read_unlock();
+
+	/*
+	 * If the first pass succeeded, grab the more heavyweight tasklist lock
+	 * to check current and any newly forked tasks.
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
@@ -681,17 +707,25 @@ void klp_copy_process(struct task_struct *child)
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

