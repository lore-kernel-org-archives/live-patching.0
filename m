Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795648346;
	b=QB1G0+bdvJLK8Bsnnr4eCKehPe1dmbOIQDJvofeIE8jujw0KY7xf5DP8nsUKm+bAhCCi
	 AxWXYED7nY+RzkAuQHbtN/S8vDMlDoMeBCM1QRDGNWZLT7da3b4nVDPQE9ohUG/BEWZSf
	 PFSXtd0qKkAFB32ZpoHSIAOoFF2ElkA2GIa5IB4XwKoVVp04KcpYPHerHEz1SEO/Q4G20
	 IfC4AsXGgMVwjGVjZTd+dG3lv4TdmXZtbCo628h4IJy/IUEc6sgshAeD8iKWqu0Axg5X0
	 Xd9Mb3wYr7WlQwxKuCzUxCl3mfJCcIxRr8pyDltFXaiqmE3fA9uI36H+wcW+RFtJDag==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795648346;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=WAL9GS8gm4ZhwTck2VGOi+Qh7YlizBKQQ4wMZbwKUqE=;
	b=MDb/9vlMZ0q/c2ysbny1r0zvTVQEr3k5SpeDCUCauPolAc9tnE7qhOHH7qEU/kBYTQu5
	 8ZSptAEMBMtmpT6SJlPIr3QqrIklbhvKk8YuwPPgdmr1LavjOdfp9MZ03ZnihQXSkLNz6
	 Lb28due4Mpe2UFowYzdSpYGVvPnji3mcAR0eiaNHGwM7mRHnnTh66fE0Zvsj7YbqlnuyF
	 HpnKlBGt1l/ztueElpxAlnpJ8b0gmS+MILLhMUxXI42NyC1fAvfpGvdKNakXp+urNwPZC
	 rF4xNi70TyL8MwYsbfzhNmnEQJQwFEWhU++NwNwIXRxEPTdA7XkzUNdWOwYXaWOTJZA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IA4OtX+M;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4A9606A33A;
	Wed, 25 Nov 2026 23:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IA4OtX+M
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795648346;
	b=EcbwUCvSaAl9gf1OOPeMDgDaAIWL7vIQJcY9MtS+TrsIDs/JxgbKyxU2NwIcbBwj4WiD
	 JtJv+OEUDgb15jM8+oKbSGg8hAMk06QBqYpoEi6B6yaAaR+605INmOodS5tyXHE9FH7WK
	 ibY8QGqeEt0O0EJPcM3pttdWonMXsv/KNVKPrtMlQDEl68Rc9RDnzK3pWIfcD9d3GRvPl
	 HqdYyZReLLW7Q6vAASAw2oRa2MURvYhh0qGSwlAKNtmucp+T5aY2hKha1jsdIMhqAyoMj
	 bBHrZYBqYGjGCAsBR9a2rWjfBSuE+jtZHPbhrw3lJuF8Sqjc+J9RFJ4DUkKc5QHbIwg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795648346;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=WAL9GS8gm4ZhwTck2VGOi+Qh7YlizBKQQ4wMZbwKUqE=;
	b=no9X+ZsbOjxI/ckSGCCRpog0YPB6ZmL6YSynztKmyn05/kY+Wa7lUcnEm7nsxfnL9wXc
	 y6jbgCCOLg1Q5Mr6eVNj00Z3eo+yeerN9LUkIm6McBqI2NOMIO3qjVQaCWiO1tWhwHgHy
	 vKurzEPhE9X2jLWs6GaVH+o3ntNBDrnhFePKJc+6qgKkdJnhxzLj17Xr9iBqNf0lQkZvn
	 xISKyjElj+21tft7ON8mXWn5ICZu0gCqRgd7XCO3Sr5T+9t5MxmMqitgoL2YtAz2irqem
	 m/3aLqAf+2DU6VIcWOKVjb8oPh7Tp2/Nj68TbhJovKW0zluPFM6eYnUOpeBorWxVYug==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id D856F1F00ADE;
	Wed, 25 Nov 2026 23:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795648346;
	bh=WAL9GS8gm4ZhwTck2VGOi+Qh7YlizBKQQ4wMZbwKUqE=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=IA4OtX+MQ52e1dEIayGOUYywB4aai9RLwFsmUSX5V/fhHY7jxvJMnI/u6E7SjD6PP
	 oAyXbpVEJX6nZ+eWVcB6PC5OSNpYjpaDqgbmARfGE2DMhzBWqrUGuSs+PrEq3gVo8G
	 QRKpDxcQHVHQnjCIcd8gKTZHidxi/mgbEaY25kwNLSDgGvIBTgNMmy8ltNxF0P5yQZ
	 E0QK3sJlywywyHZ4QQ/Ky/I3NDZ74xstIzhlgPuO+pvuxuBaTl04GMvSJtaN5yr8VK
	 ZG73djBPfYjlfBZcS17tuP1iDsH2Z1NiBQzeUEg3UVJsrFbLbKr+6T7vszYrIKAXG7
	 VMyW9SZOgBOJg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 34B654D0A6;
	Wed, 25 Nov 2026 23:12:07 +0000 (UTC)
From: Binoy Ravindran via B4 Relay <devnull+binoy.vt.edu@kernel.org>
Subject: [PATCH v3 0/3] livepatch: Do not lose exiting tasks during a
 transition
Date: Wed, 25 Nov 2026 18:11:45 -0500
Message-Id: <20261125-klp-series-v3-v3-0-b1e0f79af331@vt.edu>
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADFrB2sC/3WN0QqCMBhGXyX+6xbbP6euq94jutBt5ipUNh2F+
 O5tChFBlwe+c74ZvHHWeDjuZnAmWG/7LgLf70C1VXc1xOrIgBRzxpCT+2Mgm0MCJ1pgIXNFhaQ
 NRGdwprHPtXe+bOyn+mbUmCJp0Vo/9u61HgaWdv/agRFKMiyUFCVjWtanMB6MniCFA36r2a+KU
 RVUIy1RVpwXH3VZljeaGyBj9AAAAA==
X-Change-ID: 20261123-klp-series-v3-d52796c0590f
To: "Paul E. McKenney" <paulmck@kernel.org>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
 Joel Fernandes <joelagnelf@nvidia.com>, 
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>, 
 Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
 Josh Poimboeuf <jpoimboe@kernel.org>, Miroslav Benes <mbenes@suse.cz>, 
 Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>, 
 Song Liu <song@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
 Jiri Kosina <jikos@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, 
 live-patching@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>, 
 Jaidev Shastri <jaidevshastri@vt.edu>, Binoy Ravindran <binoy@vt.edu>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795648326; l=5443;
 i=binoy@vt.edu; s=20261123; h=from:subject:message-id;
 bh=oeulflrpaOtQWHSfhsh+UIlfdExERenQnmbTmiZ3tNo=;
 b=lwnaW0EwcTZ9LN4bkX3r57sXyi/w/nY9K3ax+AWLdjGPp6Tbg+iUpFS482LiYSX9dqWOFt2NK
 tG2NjOltWmUAOi/O3gMdhyjwcicOMslD5u0BihtC+2OcaO8WTA0RoMf
X-Developer-Key: i=binoy@vt.edu; a=ed25519;
 pk=4cNdKPHP0InmhK/9bb7Tm2ZMUXUvLGfw1pmVt5b98fA=
X-Endpoint-Received: by B4 Relay for binoy@vt.edu/20261123 with
 auth_id=1622
X-Original-From: Binoy Ravindran <binoy@vt.edu>
Reply-To: binoy@vt.edu

After exit_notify(), a self-reaping task is unhashed from the task list
but keeps running the rest of do_exit(). The livepatch transition walks
the task list, so it can complete while such a task still runs code from
a patch module that atomic replace is about to free. Yafang Shao and
Petr Mladek discussed this race in [1], and Josh Poimboeuf suggested a
similar approach in [2]. The race is hard to hit, but any livepatch that
replaces a function on the exit path can reach it, for example a fix to
do_exit() itself.

Every exiting task is on an RCU-tasks exit list from
exit_tasks_rcu_start(), before exit_notify(), until
exit_tasks_rcu_finish(). Patch 1 adds helpers to visit the tasks on
these lists. Patch 2 makes every transition step, including reverse and
force, visit them too. After exit_tasks_rcu_finish(), do_exit() runs
with preemption disabled until the task's final switch. Patch 2 waits
that stretch out with synchronize_rcu() before func->transition is set
and before the transition completes. The exit
path itself is unchanged. Patch 3, suggested by Yafang, makes LIVEPATCH
select TASKS_RCU, which every livepatch kernel already builds, so that
the exit lists are always there.

Tested on v7.4-rc2, x86-64, under QEMU/KVM, with two klp-build
livepatches that each replace do_exit() and replace each other ten
times per run, and a debug-only 2 s sleep after exit_notify(). Without
the series, 9 of 12 runs crashed; with it, all 12 completed their 120
replace cycles. With lockdep, PROVE_RCU and DEBUG_ATOMIC_SLEEP
enabled, the series ran 180 replace cycles, 120 of them with the sleep,
with no reports. Without the sleep, 20,000 replace cycles with the
series, in both the default and preempt=full modes, completed without a
fault. Compared with v7.4-rc2 alone (about 30,000 transitions per
mode), the median transition time rose from 8 to 12 ms in the default
mode and from 8 ms to 0.8 s with preempt=full, while the 90th and 99th
percentiles stayed at about 1.6 s and 1.8 s. v2, which waited with
klp_synchronize_transition(), kept the median at 7 to 8 ms in both
modes. The wait is the only functional change from v2, so we attribute
the increase to the synchronize_rcu() calls. Each commit
builds without new warnings with and without CONFIG_LIVEPATCH. A
reproducer and the logs are available on request.

checkpatch.pl in v7.4-rc2 reports the Assisted-by: trailer as
non-standard. The trailer follows
Documentation/process/coding-assistants.rst.

[1] https://lore.kernel.org/all/20250127063526.76687-1-laoar.shao@gmail.com/
[2] https://lore.kernel.org/live-patching/20250124010848.pdcxokfsk2ngrowl@jpoimboe/

---
Changes in v3:
- Wait out the do_exit() tail with synchronize_rcu() instead of
  klp_synchronize_transition(), as rcu_tasks_postgp() does
  (Yafang Shao). With preempt=full this raises the median transition
  time in our test from 8 ms to 0.8 s; the 90th and 99th
  percentiles stay about the same. See the test notes above.
- Replace the callback-based snapshot walk, which had a single user,
  with klp_try_switch_exiting_tasks() (Yafang Shao).
- Link to v2: https://patch.msgid.link/20261124-klp-series-v3-v2-0-50d20829a337@vt.edu

Changes in v2:
- Walk the exit lists under tasklist_lock and skip tasks that are
  still hashed, so that each task is visited exactly once (Sashiko).
- Call klp_synchronize_transition() after initializing the transition,
  before func->transition is set, and before completing it, to wait
  out tasks past exit_tasks_rcu_finish() (Sashiko).
- Document rtp_exit_cursor in the kernel-doc comment (Sashiko).
- Add patch 3, which makes LIVEPATCH select TASKS_RCU (Yafang Shao).
- Test on v7.4-rc2 instead of v6.12.1, including lockdep and
  natural-timing runs.
- Link to v1: https://patch.msgid.link/20261123-klp-series-v3-v1-0-427c95811d9b@vt.edu

To: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
To: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
To: Josh Triplett <josh@joshtriplett.org>
To: Boqun Feng <boqun@kernel.org>
To: Uladzislau Rezki <urezki@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Lai Jiangshan <jiangshanlai@gmail.com>
To: Zqiang <qiang.zhang@linux.dev>
To: Josh Poimboeuf <jpoimboe@kernel.org>
To: Miroslav Benes <mbenes@suse.cz>
To: Petr Mladek <pmladek@suse.com>
To: Joe Lawrence <joe.lawrence@redhat.com>
To: Song Liu <song@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
To: Jiri Kosina <jikos@kernel.org>
Cc: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: live-patching@vger.kernel.org
Cc: Yafang Shao <laoar.shao@gmail.com>
Cc: Jaidev Shastri <jaidevshastri@vt.edu>

---
Binoy Ravindran (3):
      rcu-tasks: Add helpers to visit tasks on the exit lists
      livepatch: Include exiting tasks in the transition
      livepatch: Select TASKS_RCU

 include/linux/rcupdate.h      |  9 ++++
 kernel/livepatch/Kconfig      |  1 +
 kernel/livepatch/transition.c | 99 +++++++++++++++++++++++++++++++++++++++++++
 kernel/rcu/tasks.h            | 69 +++++++++++++++++++++++++++---
 4 files changed, 172 insertions(+), 6 deletions(-)
---
base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
change-id: 20261123-klp-series-v3-d52796c0590f

Best regards,
--  
Binoy Ravindran <binoy@vt.edu>


