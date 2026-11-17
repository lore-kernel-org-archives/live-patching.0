Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794920939;
	b=UUi594Eoe0fmG+00ZPmNZGRWYgdh4wWRbu2v/YWfCZN+BmNV0kEUEKOl3HwtFQ5gGHhh
	 kPtE/UpHXanMaQDthb7O4ziHLJubzhwICjws1Pc5+Nqe5+RqRTnl2LmWUbseRTEvIZGlR
	 nDrc8SIb/Rzd6MCjNqpIHKUpHkzgJlav5pvHCTh2LNB/aav8KYQ9sZj/H6+TvK8tARP3f
	 mmZB4CJNFXushqtGNxeVpKrNowbGzPoJ8RbUuC4/kpnf+ES3b5Z817AQEUVkVckxs3mIw
	 WI25m0SBr263q5QxRCBT+9dwHyq8Ucb3jp07OkpF4RYhDZemlCm6wLsJFo49NcV6jag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794920939;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=zLGf8KUZuW/usvSDo+03rw0B1b6iNYcd3o+HeVzu1IQ=;
	b=DRFNJFGEKMzEtLcbATjOxf24ETW7oviP7CaeCi1Wq4bzzZLn6Lx3n5rHsKHCsGZlJmNF
	 Xi2jPZq/ZS6tP1HGve/6ni4qAYW/3gx40vibvTY5QAawEyHCJzEcNo7sfWHC3lmT8Xfav
	 7iIKOXfb6vYKbkORBf5x2GOF4t+TNR6yPERfG6mlztpS88Z67Ul2rbozwn1jbxTqkCpjD
	 JcvyWtDZFZ93ITjx6k0i+yeIxTV7+J7x9IH45Eg6arO0d9lHnrkAa2l3phAr+SfeCzmuw
	 UdCtARhZX//hJzmboMvxujmxLWBrYEy8CKEY1kOgnCUBS6mLHlnml2XuSdMBi7BG9NA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hvErPGdj;
	arc=none smtp.remote-ip=209.85.210.174
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D1D606AF47
	for <live-patching@vger.kernel.org>; Tue, 17 Nov 2026 13:08:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88D1D606AF47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hvErPGdj
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8a4c72951b8so3484096b3a.3
        for <live-patching@vger.kernel.org>; Tue, 17 Nov 2026 05:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794920939; x=1795525739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zLGf8KUZuW/usvSDo+03rw0B1b6iNYcd3o+HeVzu1IQ=;
        b=hvErPGdjlqSxww+dtsCmlOkBwZxMl0eE72ju7mL+/olfCxGbqR4E8DGSz4q8jk52U8
         vZOdv5YnjgNS4m/TVZk0l8otSrVL+hJYbpjmCwa2XbOLvZaeyung4rekSKvlDrmpW6+s
         euRUdWy7b2eRWAGk/+iycJHC0uMu0/z+UXQMK6ifeSU5JkIY+kFs6EU44HcMbKDMJXi2
         /NVHo/f2sd3a6yn9f/Fsndh/J+Iu0XiqDwGkk0zrGg/45GlEZUrCzipd7+68upBCvt16
         D+5mAYViZD2UcsmzHb2qkJPymvZLbLih6UDav6Z0UptJzbdVdCgyYpjcPU6HOH48vVIx
         Gt4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794920939; x=1795525739;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zLGf8KUZuW/usvSDo+03rw0B1b6iNYcd3o+HeVzu1IQ=;
        b=YQU56GvhQnvm2sI9utTueDstyudDhEjmfPQgK+SB+w+4PRWuz1U13vWQYs65O2vTkb
         1PYsiqZ5+qShd3z0dx+peceEvxFRI46WekgMwibVjYNAcUxEajQqjmwCvlibFT28feYR
         oS2CwUaclX+Pl3QYS5tMWWCjPDtQBIWfLS1468Yvht4cVsPEfbTkcOUznCaRXzSoFVRc
         ugHdguF1CpSbbgPeI60m8seNQmXIgAsALRpAkfTI2Dn5ipv0NuPI7oJvgqpENjQZNe/7
         MhGWBkBgsV5AYlccjFnaR3xkwhKExxdX2/q8nUPYNzkz0T9Lj1aC6Tl48NX0PbmR5jDV
         91uw==
X-Gm-Message-State: APuU4Z+XINZie8VaWFzgDxS8mA5suK9NR9M0Lk8rFBIyHYupqS8RXWXy
	cjxAE6kFwi+cvowldK+/DpBgac5iArKRFNrP+9VmTFkR2PIpLJYOEdqM
X-Gm-Gg: AYBFou1vGwki4jWRzkEKI7CLuElFQ/IbaMhqdAgY5TD4o4ltW525lldtZn/MowTtdc9
	Kvtdy2wlee5pa9Polss3OwxiUwOcJrP/P159fAxO1LDbwktEGwPomDV3zBaTPUSRmTbEFJetAl2
	7YDdYJW+SNYIqt9IR81RB6xxY08m0EVisoyEbzpBly3LixZ0AmeTln/UIQNQTPRHEKZPx7BjNz9
	nlbzlJ9HmU+IPPWI2XIOT+EU2bpOXwHHeCOTWC6voh4sIT+ObHTvg2Uk0GZkk+Y973j/fGPgIeZ
	9j0inzbn/7mNz6CQdClz6gseE5G8i8/q/YTtlNL+uFclcE4JWJ5weWRmG8BmMNG/dXEeg3Jhupg
	6Y4t56AguPI28+Z937xOLOnKK+8KDzi7hRAYLR2jGZcIf7VWZUkA7XMUzVG4hfSz0decEOp0YGo
	35Sanpmkh/Db3d/DBARxcMudbeN6Rh9MQcuiQqRw74oSNZodYVVA+6zeRtyQiyQBvJXvx33Z/kr
	646MMHPOidyGPzGhINNNfi7mpCPtJ1kWmYHml6u6RjN61fsE22Das2ZivCs5N33CfycaG7D4JNZ
	V4yBWrm6PIBTZITJc2Wd/8Sp9073Njb8OWgY1yyQ4pV4h2Ji2QW61frH0Zjc0fQmv2zrLK3wYKG
	nS3CSZVyiSanDyBnabfTLnNs=
X-Received: by 2002:a05:6a00:bd8a:b0:8b5:a10a:a3e7 with SMTP id d2e1a72fcca58-8beb86e00edmr12154929b3a.49.1794920938603;
        Tue, 17 Nov 2026 05:08:58 -0800 (PST)
Received: from localhost.localdomain ([240e:46c:1e00:31e:79e3:78cb:ff60:3b63])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bed12a7edbsm5161292b3a.18.2026.11.17.05.08.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 17 Nov 2026 05:08:58 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: jpoimboe@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	song@kernel.org
Cc: live-patching@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH] livepatch: Avoid blocking tasklist_lock too long
Date: Tue, 17 Nov 2026 21:08:48 +0800
Message-ID: <20261117130848.65142-1-laoar.shao@gmail.com>
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

When redis flushes data, it clones a new task, which takes the write side of
tasklist_lock. If a livepatch upgrade is in progress at the same time,
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
from its data flush path, but I believe we should improve this in the kernel
if we can.

In 2025, we discussed completely replacing tasklist_lock with RCU [1], but
Petr pointed out that it is far more complicated than we expected [2], so we
ended up abandoning that idea.

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
 kernel/livepatch/transition.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/kernel/livepatch/transition.c b/kernel/livepatch/transition.c
index 2351a19ac2a9..e058d21d84b7 100644
--- a/kernel/livepatch/transition.c
+++ b/kernel/livepatch/transition.c
@@ -444,7 +444,27 @@ void klp_try_complete_transition(void)
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
+
+	/* First pass: Iterate over tasks using the lightweight RCU read lock. */
+	rcu_read_lock();
+	for_each_process_thread(g, task) {
+		/* klp_check_stack() requires preemption to be disabled */
+		if (task == current)
+			continue;
+
+		klp_try_switch_task(task);
+	}
+	rcu_read_unlock();
+
+	/* Second pass: Iterate over missed tasks, holding tasklist_lock. */
 	read_lock(&tasklist_lock);
 	for_each_process_thread(g, task)
 		if (!klp_try_switch_task(task))
-- 
2.52.0

