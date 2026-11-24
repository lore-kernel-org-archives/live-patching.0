Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795534516;
	b=PA9vuWcYTI46Z2ph9PUbQWUEypAi27R1hjHGxYTZBf+biQ4xTofteo7TYSK+N0fpF+C+
	 Lk+slWe+wMasuObhheq4hctIrY+W38WGyO3nPZlG3x3NRQ271qKBL2UW9bHbO/cBqHKfS
	 mWOreZp5gm8EmQ1uBO3DWClIujuUPBiocvyfUInqvGFQUn08ipzqXBGhMpzMlBLSjxP07
	 LMBZWEdhF7IquvoR0drUbYfkq7HEv9rnMht99QZE8xFwu9XbwjwdXyxLiQTpJ31J5hJk+
	 WwArNRE+F6DcmXnAIrL7LuRLK9NLlSyPPOQRRj8JCS+eM+/T5e76pELs7fQ1Sva+xng==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534516;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=FKSCge0UbaLmXYN2+r5z/H5+g0K7qubya+9y+riTAII=;
	b=1gCqsWlBXAhR2Zc8sXXeLawA9r30krPzvnHbeQzWftEP2OoLdDU/d4SCCwBdl9iMvVI8
	 Nq8W3JFVZi2mkQFcQ+xYFOnS7JzME7F/mEa5VHyImAiRKkS6Nyg3emeul8CkHT+b2itKg
	 dLdm3Hwr3a3X0rCNknCv+R0MvRQSOionkA7xc8J4vUzsEHUC69j54VhOZFNXv46oMMAbG
	 CCluMjX9eNk1xXKGLzg7ciWkDVPvBK9anngeJZHsj+8L8EQ4rDY5Ib5ooDak80YjrYQaz
	 2wv5Z0IyYU271Y0HI3wr8MuWCdp8EGsvNXJyTVSn3bjg62OiiijPO1+IkvzSOq8qRfA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Eu7xdcR/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6600F606A6B1;
	Tue, 24 Nov 2026 15:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Eu7xdcR/
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795534515;
	b=igo0HLgwPfnENhdww77MdwVZe25pqni6Ghjq7XdiHqsYuS+6a8jT6AFPVwIJqD1mxEd0
	 lQChJZG8U3A0W7M/DXRLIVKr+2qlFnMKuP4XFL49RJ8pzzFsogtDBUjzPjQhR+CvelSCX
	 CN0a7lbr2GW4dT2f7lrYPgTyf2445sF6td+LOjiCk/QIx8Zq6t5oLLKfdHbPZn89eVeuZ
	 E3kJopI7eCBQFJE9yK50CA8AQhP0IQgBDR4Y3wmVEEq6Kd38BARL518/TtY3tUgUygiO5
	 rpnAx57s+zaJPQ7TmqQKA4V5fNYRjL9NqxoihOl4vnvRkwpV5gse93BwUzNrUlINVNw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795534515;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=FKSCge0UbaLmXYN2+r5z/H5+g0K7qubya+9y+riTAII=;
	b=Ogw4FPpDbK1mcgjg8MHwT7fd/LB8Z5fpzUfhJDSDPGYa82V8HvXukBRBNq6sw0a436sS
	 5F+MY7VG6+A+CDpLHlw5yBRmucHJn9fXPd9wRI3t8KXu/YjPmYxbv12SowINvlfxr5Wjj
	 O87qabo+70ND9Xl7m/qS/zvLC3vhUKGGddg8TcXNG4zlqtVvyznduzcWn3qHCUghlJHYR
	 fjni8zp2jlaxpBNQFi0inFyQa11ZQ7H51ri2SA4nn2nMUoGsUtNBP0rPO41RN3mxdPDiC
	 Fuj6xwHQLarMEbvN//NlHUlixodbKmkR5IZAQlS/fXp72UXqHeAvISsv8mwfwINjU2w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 3A49D1F000C6;
	Tue, 24 Nov 2026 15:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795534515;
	bh=FKSCge0UbaLmXYN2+r5z/H5+g0K7qubya+9y+riTAII=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=Eu7xdcR/ctp0JuHVSNsE2IFCRT2Yjf7UTC6tgOjCwpEh0UWp+KlZeQmc1IpUOFYjA
	 rJNrSZl4nimL+buykV1bReijU+arimpSDMUOWZwH/ENsA0O6XrVnvlzdSFjlu8LmoX
	 7BXhZb8fs3Cx1uiAGFegrXiy6YRRVmz+MFBB9WkbILGztzc1inM1QBGqwcOrc1w330
	 jkC72NVCweSV4Qon/N+dEePD/RMtLqjG4ucVSABh0YSgC4erm5uRCc0iYHvshaMkNx
	 6FGwWbeqZxN4XsGuzX1AxhJlfq5EvWA0beEYrGQIhCoccujuNYVrTJpcuhk03jFg4X
	 l0IEzCWV8uW0w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 8C5ED4CA98;
	Tue, 24 Nov 2026 15:35:04 +0000 (UTC)
From: Binoy Ravindran via B4 Relay <devnull+binoy.vt.edu@kernel.org>
Subject: [PATCH v2 0/3] livepatch: Do not lose exiting tasks during a
 transition
Date: Tue, 24 Nov 2026 10:34:26 -0500
Message-Id: <20261124-klp-series-v3-v2-0-50d20829a337@vt.edu>
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
X-B4-Tracking: v=1; b=H4sIAIKuBWsC/3WNwQ6CMBAFf4Xs2TVtsWA9+R+Gg7SLVA2QtjQa0
 n+XwtnjJPPmLeDJWfJwKRZwFK2347CCOBSg+/vwILRmZRBMVJyLEl/vCfcNxhKNFLWqNJOKdbB
 uJked/Wy9W7Ozn9sn6ZAj2eitD6P7boeRZ+9fO3JkeBK1VvLMuVHtNYYjmRmalNIPdISPJLkAA
 AA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795534504; l=4570;
 i=binoy@vt.edu; s=20261123; h=from:subject:message-id;
 bh=LGI/65cS8E2ms+CwnotqgWFG5CU8Q8b8+4merdNRrwQ=;
 b=PjWkt4tHgrraL96yN207yqC+HLVFy64wBCIkw7qG7ErWqqECaK56L+VOUrsF1b5XtADDl3Jvd
 8ZghwNM+zR3CfVOYdldXMH/IWiqAnMUwgoc0zufrSzAZbC9ywIUfrRi
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
that stretch out with klp_synchronize_transition() before
func->transition is set and before the transition completes. The exit
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
fault, and transition times were the same as without the series:
medians of 7 to 9 ms and 90th percentiles of about 1.5 s. Each commit
builds without new warnings with and without CONFIG_LIVEPATCH. A
reproducer and the logs are available on request.

checkpatch.pl in v7.4-rc2 reports the Assisted-by: trailer as
non-standard. The trailer follows
Documentation/process/coding-assistants.rst.

[1] https://lore.kernel.org/all/20250127063526.76687-1-laoar.shao@gmail.com/
[2] https://lore.kernel.org/live-patching/20250124010848.pdcxokfsk2ngrowl@jpoimboe/

---
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
 kernel/livepatch/transition.c | 98 +++++++++++++++++++++++++++++++++++++++++++
 kernel/rcu/tasks.h            | 69 +++++++++++++++++++++++++++---
 4 files changed, 171 insertions(+), 6 deletions(-)
---
base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
change-id: 20261123-klp-series-v3-d52796c0590f

Best regards,
--  
Binoy Ravindran <binoy@vt.edu>


