Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795711319;
	b=2sSqQQRqUR02dfM76DuFlXaDkTPD3KdUmEullhk5gKiXUthieNtjQhNDVj8q89gVmUeg
	 FGLA+YMTw5fo2muNYw8zlAb5BH7smP/iP4STUeqZj83bjx0Qi3m4UJEwxZyMhHUiRc3JL
	 eKv/WT4MbaMP8HX6c96ClFJLXLuNLmh+SDoAIOg4o/UOPN3Vi/+JDb4Br3iycdW7zCXKO
	 +m3Sf5h4evRxl7XWxW8GBzm68lNVn3zad/pJPqwRprdrLdnSPkxPdos5x9wt6x2euAlns
	 NAOwUc3lnSe3dJrVRMstXtonkeurZSRwSNW6oJC8Ni1/0EhdeUGb4TFyne2jSLEIRWQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795711319;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=29ppr+FS8gAhEeC5lh8pBVXFhlYmrdczXyjTit/yuw8=;
	b=BbsX7V3/5cAv3Ht3dxQfSelA6PJt2oDqvrRvDzSMT4mddSvUHXmvFkZH0LxA6rZSadmp
	 p0kPmLTU+SKYYpKMM+u/jX+lhnxjMoIj7MnT9qXXQQmFWDKmYDYDBVr9gE5jU6u6Y/g9Y
	 G8AQraPPZU8fUvDq+QXhX25Wmsw5wfdEuUI4LzqWTLDu7MRMLfA1A03TPCKtAh0EXsRZr
	 8XCYvHQIbMR/Odke0po+4WyfAB4t17InDU4S+8lZe8yF52FLRkBhvolCttdfo3BWMO/Mw
	 MiRSjod5IEH8ffB44XZgd8oyrmQ0voAFKx3xN3wdRJLcz+rfHvCBvpUjTTpM6kUBj8A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xk8IK1Pj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9870606A681;
	Thu, 26 Nov 2026 16:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xk8IK1Pj
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795711318;
	b=dnl6jeGMylLCBjjZ+4vKl4q57vYWeLiX67lNvtqi/Swp7yA6hO3wkeNfLYMZS3uz45ME
	 hVlRFEsSwSvuYJAJIx4oJ8oIVwpz/gu1noi2i4cGrvs/kOSC46kt0yxMAVfPJirRsW4ai
	 tnHtLGBLrmwSX93XyCQ8IFVSpr1t4UcAxlXp4XeM4qodwozLFbGF+dO/PHLhTiZBG0mW0
	 8Q2HcSwdbMMAY84UCh4VFLKUs9O0kztznLvLwn2w7be1QsoaLcRmssl9SxVyaGean4u29
	 AWFRB2VW8pcMJzEHZvZheFtVDsBMyzW/6Ta4z7jmBuJDVx0cq7hcoB/J8WrwuZlXNHg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795711318;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=29ppr+FS8gAhEeC5lh8pBVXFhlYmrdczXyjTit/yuw8=;
	b=acEKdGrAH37UQeHbEo0PX56l98/0HQNnq9i63gYOmAm/gax0Bi7fuYDo0cjmgl12niaK
	 VNH0ZRz33m6SHkOSWB5ZU19ky2XmCS1wzx/JNxTwqrJwkzN3fGkpHWeql7iuVRU5Ayoub
	 AzB144Ucg3v0Jq2rvKeC4go2GGtkOsQYdb3WAkMOesWeVUpbctqZUVRNuPupjHsmSCQ1n
	 cA2kPZQg82Rwq29p4ZnrP5Y8h8j2Qd+4hPkslcsIvh0WMtQbp82p98VG91WunXPEAUq4c
	 6+d7S97ThH2GkxqFKqbbyRc5Ckh285hFT6SnwLHCXFwhj7JzzBIEl0+18t74Q7IW7QA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C62141F000EB;
	Thu, 26 Nov 2026 16:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795711318;
	bh=29ppr+FS8gAhEeC5lh8pBVXFhlYmrdczXyjTit/yuw8=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=Xk8IK1PjsS7qxtWD5Vfg3J9GxMpW9u2A/9gSwcTzn3ao4eYjER+Ui+po8NufJdqIX
	 AKkvniGC3Svv3Cw32ZFwNABtAVhxyWQvDZOXvxjTmVksCkxV1DbDM3rSjkS1RhIfV9
	 TT/SeAPBsSSKI27kFFuu9h3YASxG4iMxWAHHFbsJhz3xWgOH47L5fxtw7peHrsSNBj
	 Yi0erlEVGcLwKQmYfgmEpYWajpHiFfEZ4laC/ReBpDHd3a+TLYHRYWrcdgVhymu9Ab
	 F4MgD8uFPQpbZfyjG4u8O++1F69oWtl8eTTUH66S2TcV4evIjQ0DDf5v9I9cs7L1/l
	 Kh2zcHf0gfsyA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 55A694D710;
	Thu, 26 Nov 2026 16:41:46 +0000 (UTC)
From: Binoy Ravindran via B4 Relay <devnull+binoy.vt.edu@kernel.org>
Subject: [PATCH v4 0/3] livepatch: Do not lose exiting tasks during a
 transition
Date: Thu, 26 Nov 2026 11:41:31 -0500
Message-Id: <20261126-klp-series-v3-v4-0-2ad73e9c9254@vt.edu>
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
X-B4-Tracking: v=1; b=H4sIADthCGsC/3XN0Q6CIBTG8VdxXEeDg4h01Xu0LlQgqaYOlNWc7
 x7q1syty287v/8ZkdfOao9OyYicDtbbtokjPSSoqovmprFVcSMgkFEKDD+eHV4NDgwrDkJmFeG
 SGBRN57Sxr6V3ua7bD+VdV/0cmS9q6/vWvZeHgc53/9qBYoJTEJXkOaVKlufQH7Ua0BwOsKXpn
 kKknCggOciCMfFD2ZbyPWWRllQTI2RhGKNfOk3TByVsDgovAQAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795711306; l=5640;
 i=binoy@vt.edu; s=20261123; h=from:subject:message-id;
 bh=owghUpoMKcs8kn/ujSS+lkNRIJ9HYyY76FyRwl3nOD4=;
 b=kzGjs5bFhzI8wzojgQ7Tr9OC6hwnIelmln9xX4LQilQA3j4He+NrOrk3m5/lkDfNf3/su1AmU
 KI7nw7cGiUdAbfL7VO9D9cb2A6oTj/CQzUq0cHXyJ3GNpfw17vP3lMd
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
livepatches that each replace do_exit() and replace each other ten times
per run, and a debug-only 2 s sleep after exit_notify(). Without the
series, 9 of 12 runs crashed; with it, all 12 completed their 120
replace cycles. With lockdep, PROVE_RCU and DEBUG_ATOMIC_SLEEP enabled,
the series ran 180 replace cycles, 120 of them with the sleep, with no
reports. Without the sleep, 20,000 replace cycles with the series, in
both the default and preempt=full modes, completed without a fault.
Transition times matched v7.4-rc2 alone: medians of 7 ms (default) and
11 ms (preempt=full) against 8 ms, and 90th and 99th percentiles of
about 1.6 s and 1.8 s in both. Each commit builds without new warnings
with and without CONFIG_LIVEPATCH. A reproducer and the logs are
available on request.

checkpatch.pl in v7.4-rc2 reports the Assisted-by: trailer as
non-standard. The trailer follows
Documentation/process/coding-assistants.rst.

[1] https://lore.kernel.org/all/20250127063526.76687-1-laoar.shao@gmail.com/
[2] https://lore.kernel.org/live-patching/20250124010848.pdcxokfsk2ngrowl@jpoimboe/

---
Changes in v4:
- Wait out the do_exit() tail with klp_synchronize_transition() again,
  as in v2. synchronize_rcu() can return while the dying task still runs
  traceable code in __schedule(), because the quiescent state is
  reported before switch_to() (Sashiko). This also restores the v2
  transition times.
- Keep klp_try_switch_exiting_tasks() from v3 (Yafang Shao).
- Link to v3: https://patch.msgid.link/20261125-klp-series-v3-v3-0-b1e0f79af331@vt.edu

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

 include/linux/rcupdate.h      |   9 ++++
 kernel/livepatch/Kconfig      |   1 +
 kernel/livepatch/transition.c | 102 ++++++++++++++++++++++++++++++++++++++++++
 kernel/rcu/tasks.h            |  69 +++++++++++++++++++++++++---
 4 files changed, 175 insertions(+), 6 deletions(-)
---
base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
change-id: 20261123-klp-series-v3-d52796c0590f

Best regards,
--  
Binoy Ravindran <binoy@vt.edu>


