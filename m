Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795648338;
	b=wI6VxV39xDaJDOqoNflQJt2V1ZEiw9Yu+ZQKER2a1JIptNTgY+wlZ1wivS8vSKeuLyzt
	 1GZdooduEn71jteGLiNfzq+8goKqhUMp8iRqxf3TXvXLMbrpthjBdb97t/9KIc13a4l75
	 bWVZPh/Ma3FRJR60bgpXOJdA/X7H94Ij7x9A1a7fszNoMlKJnEl31GMw3iYXZV9810Njd
	 2GO/5G5PU7nZBgoCRiXhlwVviuaZaNVYvMOZhDwSMyqSpUBt7ymPkXrifJgc/F8m2AFC+
	 e0y82OR3mwI/bkkDleyc1CxCsDxj+IjdMfnK/r7fds1No+g4FwUxvzBDfDqDuIN6J/w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795648338;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=SnbLSbwDaxbndvuN9w0MQTAlHWDN7GnfIYAnnCNuEeM=;
	b=5LME4l8oA1JvASUiDX5Ug0Xak12HoOz2W2rLQovK8FZHJCbegawy+riEYoCqMP+Yw4w3
	 Eag86wAMWIR/XD80dj+TZQULQQpMGz+kFNLJfDGWLdQWlpwOhGvSsogyT9Xh3PFLipcfD
	 n+SAQvZ1GKMRJIr2A/R10s2yBlRtcfRBbwLqMEgB6wV8TgEajq4lXMgOkjvwQU5JOmDs5
	 9tWsPk4T9ohUfyI1UAsAI5JP6UjRoCwuNEw02057jXR5ekb2PXTFyrI3K4xn7E068y5p3
	 l0cqZI5HR/HDJT6wp/6B2g7VqL2JUNQZx9uMOUObx/ARCwRflwdEvn+kpH0Ko8Xxifw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eYgU9WxT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D512A606A331;
	Wed, 25 Nov 2026 23:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eYgU9WxT
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795648338;
	b=gqkNaod5AV91D4lELXrH1s4SVmGw3g4+UT2X7JQ3NePQh1pAZIvAC0e/o2p2W0HcL7Uq
	 LZjwsORWQBr9KnqDW3xoQdUwaQOD7iXFcuO4DB5XswU2fEJha9tJiYu44zNz/dot5kxcI
	 BOKCiIKpHgqi8VZZz74R1fptkAx2wzkrbmje2h420Rg2W3uAhgPNxSliOdsnSUTGyrgc6
	 LBY1lMy+AbNCSLGqxJfhOVRvdWzsR4b0WOAR7O/5XJIaHr1b9ptexlh994XRNE3uzKJa6
	 6jn+IFnsrICEs/EnTNBvh9Lj59y99n6AFMD2sAN+B3UB/FXkrsoSHL14XLfhKf7hVHw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795648338;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=SnbLSbwDaxbndvuN9w0MQTAlHWDN7GnfIYAnnCNuEeM=;
	b=elAWnHNVyaHRtVikraSAoml+4+SYjZqFlqLZb8c4Qg6atjrzxSAb+F9tS+MFX31dXmg0
	 QA3vVQxYJxDqYs/SYwZJz329xC7oz+G9tzj3O0ODVAScmTMwSQaXkRpuJPXsJ4Jv9oBir
	 Z3TdPK4JpWpN7kRhyhNurvLqTjQM6xfmYQxUjAE3/SPTq513mEJUCPhLYJRTx8YC0DxAR
	 nBfgVykasWZfwCqJ79Q1Ev/lpq0Y+341ot9d19aq8GSbTKe2pFrHZvk60eOAjydjUuGwS
	 RxE1Muk8igPlqGDYhjpCoBtb9XN24OJTfpa2LnB/yoFzsOnCa01q51ydyJdm+vFQRmg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 03BDB1F000D2;
	Wed, 25 Nov 2026 23:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795648338;
	bh=SnbLSbwDaxbndvuN9w0MQTAlHWDN7GnfIYAnnCNuEeM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=eYgU9WxTQ1OwKDy2bR8uyvRVTNUZxGrGGRDEpIW5tKwxLeDfV0+4lek8vOwcHlwuB
	 fHjrhjqqKh0qTmQYuSVemu8JZMJAygVoawQWt2OgJ74Usu43LupYnumzwSTyy+kZ0C
	 1Nlooh56HPWzqtoqXb/2rDNay0DfOD+vZnyLZ3aNwTT7IeiPRPjO7+kPo+TcYEvUvz
	 Wq9rvvKoj1CTmVSDOvOfYBC9C/rBALF+/AHzIysEMUCereWn3M6OreRaZF8R0cqKs6
	 036eeerto9iUXutOFNGCm854xNwJaEm95FYyzONoadPmBnsckaGKufd7X9/QQm2umb
	 Wmz1JrzC0l5yg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 8082F4D0AA;
	Wed, 25 Nov 2026 23:12:07 +0000 (UTC)
From: Binoy Ravindran via B4 Relay <devnull+binoy.vt.edu@kernel.org>
Date: Wed, 25 Nov 2026 18:11:47 -0500
Subject: [PATCH v3 2/3] livepatch: Include exiting tasks in the transition
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
Message-Id: <20261125-klp-series-v3-v3-2-b1e0f79af331@vt.edu>
References: <20261125-klp-series-v3-v3-0-b1e0f79af331@vt.edu>
In-Reply-To: <20261125-klp-series-v3-v3-0-b1e0f79af331@vt.edu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795648326; l=9961;
 i=binoy@vt.edu; s=20261123; h=from:subject:message-id;
 bh=V2dq+b4ATpvDNDknHHomGPFtb6lfK0S2rvX2l20zECo=;
 b=v3BG+eHGiq839Tttmd0+Vv94Uu/zIQkwYqf0Y7p7saDVyXbd3QKYNQnJ4xZO8vLtyex/AM/0b
 k5z9Sxd1ihkDGd5pkVcHM5Sjbt33ffDnMjzu+qwtj1tdrIR9dyqhKNs
X-Developer-Key: i=binoy@vt.edu; a=ed25519;
 pk=4cNdKPHP0InmhK/9bb7Tm2ZMUXUvLGfw1pmVt5b98fA=
X-Endpoint-Received: by B4 Relay for binoy@vt.edu/20261123 with
 auth_id=1622
X-Original-From: Binoy Ravindran <binoy@vt.edu>
Reply-To: binoy@vt.edu
Content-Transfer-Encoding: 7bit

From: Binoy Ravindran <binoy@vt.edu>

The transition walks tasks with for_each_process_thread(). A
self-reaping task is unhashed in exit_notify() but keeps running the rest
of do_exit(), so the walk never sees it. The transition can then
complete, and with atomic replace the previous patch module can be
freed, while that task is still executing, or about to return into, the
previous module's copy of a patched function. This is the race discussed
in the thread linked below.

An exiting task is on an RCU-tasks exit list from exit_tasks_rcu_start(),
before exit_notify(), until exit_tasks_rcu_finish(). Make every step of
a transition also visit the tasks on these lists, using the helpers from
the previous patch. klp_init_transition(), klp_start_transition(),
klp_complete_transition(), klp_reverse_transition() and
klp_force_transition() only set fields and flags. They walk the exit
lists in place, under tasklist_lock, and skip tasks that are still
hashed, so that each task is visited exactly once.
klp_try_complete_transition() may inspect a task's stack, so it takes a
snapshot with a reference on each task. If the snapshot cannot be
allocated, or more tasks start exiting than it has room for, the
transition is treated as incomplete and retried. An exiting task must
therefore switch, like any other task, before the transition can
complete.

After exit_tasks_rcu_finish() the task may be on neither list, but it
can still run patched code until its final switch. do_exit() disables
preemption before exit_tasks_rcu_finish(), so from then on the task
cannot sleep, be preempted or migrate, and the next context switch on
its CPU is its last. This stretch is an RCU read-side critical section,
so synchronize_rcu() waits it out, as rcu_tasks_postgp() already relies
on. Call it in two places:

- In klp_init_transition(), after patch_state has been set on every
  task and before func->transition is set. An exiting task that the
  walks did not visit had left the exit lists before or during them,
  so it is gone before any function enters the transition.

- In klp_try_complete_transition(), before klp_complete_transition().
  A task that left the exit lists unswitched after the snapshot is gone
  before func->transition is cleared and before the previous patch can
  be freed.

Covering the initialization and completion steps matters as well:
otherwise an exiting task keeps a stale patch_state from an earlier
transition, which can equal the new target. Likewise, the reverse path
clears TIF_PATCH_PENDING on exiting tasks and the force path updates
their patch state, so neither leaves an exiting task behind.
klp_send_signals() is not extended: a task that has passed exit_notify()
never returns to user space, so a fake signal cannot help it switch.

The exit lists exist only with CONFIG_TASKS_RCU, which every kernel
that can enable LIVEPATCH builds today. A following patch makes
LIVEPATCH select it.

Tested on v7.4-rc2, x86-64, under QEMU/KVM. Two klp-build livepatches
that each replace do_exit() replace each other ten times per run while
self-reaping tasks exit continuously, with a debug-only msleep() after
exit_notify() to widen the window. Without this series, 9 of 12 runs
crashed executing freed module memory after the previous patch was
removed. With it, all 12 runs completed their 120 replace cycles
without a fault. Without the delay, both kernels completed 60 cycles
without a fault.

Fixes: d83a7cb375ee ("livepatch: change to a per-task consistency model")
Link: https://lore.kernel.org/all/20250127063526.76687-1-laoar.shao@gmail.com/
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Binoy Ravindran <binoy@vt.edu>
---
 kernel/livepatch/transition.c | 99 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/kernel/livepatch/transition.c b/kernel/livepatch/transition.c
index 2351a19ac2a9..0edcb9f9c663 100644
--- a/kernel/livepatch/transition.c
+++ b/kernel/livepatch/transition.c
@@ -10,6 +10,7 @@
 #include <linux/cpu.h>
 #include <linux/stacktrace.h>
 #include <linux/static_call.h>
+#include <linux/slab.h>
 #include "core.h"
 #include "patch.h"
 #include "transition.h"
@@ -74,6 +75,54 @@ static void klp_synchronize_transition(void)
 	schedule_on_each_cpu(klp_sync);
 }
 
+/*
+ * Tasks past exit_notify() are off the task list but still run do_exit() and its
+ * callees, possibly from this patch's or a replaced patch's code, so the
+ * transition must cover them too. The try step inspects stacks, which needs a
+ * reference on each task, so klp_try_switch_exiting_tasks() works on a
+ * snapshot of the exit lists.
+ *
+ * The other steps run with tasklist_lock held and skip tasks that are still
+ * hashed, so every task is visited exactly once: an exiting task can be on
+ * both lists until release_task() unhashes it.
+ */
+static void klp_exiting_init(struct task_struct *t, void *arg)
+{
+	if (pid_alive(t))
+		return;	/* still on the task list: already visited */
+	t->patch_state = *(int *)arg;
+}
+
+static void klp_exiting_start(struct task_struct *t, void *arg)
+{
+	if (pid_alive(t))
+		return;	/* still on the task list: already visited */
+	if (t->patch_state != klp_target_state)
+		set_tsk_thread_flag(t, TIF_PATCH_PENDING);
+}
+
+static void klp_exiting_complete(struct task_struct *t, void *arg)
+{
+	if (pid_alive(t))
+		return;	/* still on the task list: already visited */
+	clear_tsk_thread_flag(t, TIF_PATCH_PENDING);
+	t->patch_state = KLP_TRANSITION_IDLE;
+}
+
+static void klp_exiting_clear_pending(struct task_struct *t, void *arg)
+{
+	if (pid_alive(t))
+		return;	/* still on the task list: already visited */
+	clear_tsk_thread_flag(t, TIF_PATCH_PENDING);
+}
+
+static void klp_exiting_force(struct task_struct *t, void *arg)
+{
+	if (pid_alive(t))
+		return;	/* still on the task list: already visited */
+	klp_update_patch_state(t);
+}
+
 /*
  * The transition to the target patch state is complete.  Clean up the data
  * structures.
@@ -123,6 +172,7 @@ static void klp_complete_transition(void)
 		WARN_ON_ONCE(test_tsk_thread_flag(task, TIF_PATCH_PENDING));
 		task->patch_state = KLP_TRANSITION_IDLE;
 	}
+	rcu_tasks_visit_exiting(klp_exiting_complete, NULL);
 	read_unlock(&tasklist_lock);
 
 	for_each_possible_cpu(cpu) {
@@ -419,6 +469,35 @@ static void klp_send_signals(void)
 	read_unlock(&tasklist_lock);
 }
 
+/*
+ * Try to switch every task on the exit lists. Returns false if one of them
+ * could not be switched yet, or if the snapshot could not be taken in full.
+ */
+static bool klp_try_switch_exiting_tasks(void)
+{
+	struct task_struct **xt;
+	bool complete = true;
+	int i, n, max;
+
+	/*
+	 * Size the array from a count taken now, plus slack for tasks that
+	 * start exiting before the copy is made. If even more arrive, report
+	 * an incomplete walk: klp_try_complete_transition() runs again later.
+	 */
+	max = rcu_tasks_snapshot_exiting(NULL, 0) + 64;
+	xt = kvmalloc_array(max, sizeof(*xt), GFP_KERNEL);
+	if (!xt)
+		return false;
+	n = rcu_tasks_snapshot_exiting(xt, max);
+	for (i = 0; i < min(n, max); i++) {
+		if (!klp_try_switch_task(xt[i]))
+			complete = false;
+		put_task_struct(xt[i]);
+	}
+	kvfree(xt);
+	return complete && n <= max;
+}
+
 /*
  * Try to switch all remaining tasks to the target patch state by walking the
  * stacks of sleeping tasks and looking for any to-be-patched or
@@ -450,6 +529,8 @@ void klp_try_complete_transition(void)
 		if (!klp_try_switch_task(task))
 			complete = false;
 	read_unlock(&tasklist_lock);
+	if (!klp_try_switch_exiting_tasks())
+		complete = false;
 
 	/*
 	 * Ditto for the idle "swapper" tasks.
@@ -489,6 +570,12 @@ void klp_try_complete_transition(void)
 	/* Done!  Now cleanup the data structures. */
 	klp_resched_disable();
 	patch = klp_transition_patch;
+	/*
+	 * A task can leave the exit lists unswitched after the snapshot. It
+	 * runs with preemption disabled until its final switch, so
+	 * synchronize_rcu() waits it out, as in rcu_tasks_postgp().
+	 */
+	synchronize_rcu();
 	klp_complete_transition();
 
 	/*
@@ -526,6 +613,7 @@ void klp_start_transition(void)
 	for_each_process_thread(g, task)
 		if (task->patch_state != klp_target_state)
 			set_tsk_thread_flag(task, TIF_PATCH_PENDING);
+	rcu_tasks_visit_exiting(klp_exiting_start, NULL);
 	read_unlock(&tasklist_lock);
 
 	/*
@@ -579,6 +667,7 @@ void klp_init_transition(struct klp_patch *patch, int state)
 		WARN_ON_ONCE(task->patch_state != KLP_TRANSITION_IDLE);
 		task->patch_state = initial_state;
 	}
+	rcu_tasks_visit_exiting(klp_exiting_init, &initial_state);
 	read_unlock(&tasklist_lock);
 
 	/*
@@ -590,6 +679,14 @@ void klp_init_transition(struct klp_patch *patch, int state)
 		task->patch_state = initial_state;
 	}
 
+	/*
+	 * A task that has passed exit_tasks_rcu_finish() is on neither list but
+	 * may still call patched code until its final switch. It runs with
+	 * preemption disabled, so synchronize_rcu() returns only after every
+	 * such task is gone, as in rcu_tasks_postgp().
+	 */
+	synchronize_rcu();
+
 	/*
 	 * Enforce the order of the task->patch_state initializations and the
 	 * func->transition updates to ensure that klp_ftrace_handler() doesn't
@@ -642,6 +739,7 @@ void klp_reverse_transition(void)
 	read_lock(&tasklist_lock);
 	for_each_process_thread(g, task)
 		clear_tsk_thread_flag(task, TIF_PATCH_PENDING);
+	rcu_tasks_visit_exiting(klp_exiting_clear_pending, NULL);
 	read_unlock(&tasklist_lock);
 
 	for_each_possible_cpu(cpu)
@@ -714,6 +812,7 @@ void klp_force_transition(void)
 	read_lock(&tasklist_lock);
 	for_each_process_thread(g, task)
 		klp_update_patch_state(task);
+	rcu_tasks_visit_exiting(klp_exiting_force, NULL);
 	read_unlock(&tasklist_lock);
 
 	for_each_possible_cpu(cpu)

-- 
2.39.5


