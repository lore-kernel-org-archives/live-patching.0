Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795467175;
	b=hNPS+f1/u/hdO8f2tqxQyn2Sva0Y3r3SC/ha8DLQi4LldTqSBy/ZatcWXRLQRglH6QhV
	 0cgRMb3RvxQxOphy+ejLXlcdWnDnRwDAK+Oe3u+eqM1ICJzMBoG5OAOl9bMOh81wOp8W2
	 MxhlNV57zebw8TRzsTy8HPUejbyuCeXSB5g/fjdEKZOFUTD+yva5uvRt/s8BaPvmYqf+L
	 eCwULLm0/1yKt3KBseBhL9xhO9U5U6GL4P+A+53O0NmHfWhbQd6F2UER2VxFBnoEafRn3
	 t0LS75Jw39PmZZS6BIQVnWBNF/IoxiLkRQkgTm9ONB28qlS5OM4biVaw/IHTWTGZCDQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795467175;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Uk/Nx9AqOgbIP3+/mGNkZuIOYeo78ZScYOlbWVpMcH4=;
	b=1/xLiiOtkIWOXXIQ2wY1HkoWPHBXA+BeVhbn/25UTFZKMOhxTjha4KaaFq7gk/WHy9JJ
	 aooGjNDz7w2kdWxlhgVf8B1x01Jte+h+K8lt+NVWURm5BeqOlBtPQFgz7mZmpF8g5MTit
	 VKpKUXbYRxQlW5ebXKyjP9zMzIpl7ROsU0yOpqA9Xz864K5oAGvcv8hK+hG0OVXO9QsNI
	 8SxShADwPV5lRtg9ZvtVTaCzjtDTpOqVUqxkE+bmxOK8Yi8vbol+BkZIkSwErn79oxlxQ
	 WP83ah7FCEIeI5If158GZMUK9HJPl3+H4D3VYn2uGDIxJpnGPz7nAZ4tR3i/rVPLW3A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BHZBqkoh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D9C606A332;
	Mon, 23 Nov 2026 20:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BHZBqkoh
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795467174;
	b=uA/RXrLFOQ5SkOGXriK8QiCw1X7DFGLgZgEvTpx7lCaBCQFc86EdvxhX7obz+0XeKGN1
	 fy6IB31hfD5cxAi61Twj+UxNOWBMDGTKnrAl0DricxbdTT1nAsLIth6UOmRWUQ3AJlC7i
	 3joCNC/wZszST+oXcgdQ9FrSPgFS63BTnCTwbxdAmZW5mIGi6eG/A9fNZ8nNJ7q72zlBv
	 6pfuxs2INFAVFjGsAyzKriI9uCsWNSisjkikl+8GOPzCUg/9jaFLu08yy+oJIfTQN34+q
	 rZqvCfVWzpLK1kSDNGrrGGn9kQm/SupoUImYfoZQwu8pkWZpOond/6Lamp+5slVL9Hg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795467174;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Uk/Nx9AqOgbIP3+/mGNkZuIOYeo78ZScYOlbWVpMcH4=;
	b=QlEKjvaP7K1vZbMYM+U9/zH9getNArhbWDrhNLwe1K0e8+QeWIX6yBE0s90n6OE3Vlnw
	 t55VJfoRf5wNNRtNhn/tv3urO+Ry8kT8EtsVbreNNjZOchj3v46jIzFjcW2KT/YWsd9qo
	 lCjPmges6JaF8BEVOEKCFAwOLANBRtUBb4XIXbjhFEzjl4Se2k4mfG4RXl209Y9LMgN86
	 RrV1jm2ADlRo3c5AugDJI8ykAHhPAFIQdT9169CyIWoRcJd9dm09AnU54OOKHqq9Xm7/C
	 hzJV/2TrVnUEphHWSicAx0EPbCB4cXTpM7hbmwEc0qmWVufY2R1/f2NcPTy4HqM/fRw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 062621F000C6;
	Mon, 23 Nov 2026 20:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795467174;
	bh=Uk/Nx9AqOgbIP3+/mGNkZuIOYeo78ZScYOlbWVpMcH4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=BHZBqkohVUsHt/7ihArBqmF/x8Gz8c+L5Hiw6SgagRn6lnFbQSMp7IkY4KDIgo2B+
	 g6UefixIZo12Ss32XU3rLosAigNOSO2I0zf+D6mX2WDzBXh4YQmVEusWWGwXTu27b8
	 PiAIhu2WmjS0hk+D3W1fLT8ZC7xmd7Gtc8EEqvdfkojOS80ahKMhE3tzlmlY5K4HIO
	 9lj3jXACSuqRek68V0iyEAGWrbwxHa7DbbdVNR7OheGBMWlTijBG3xifaqEyeW0DS5
	 KKwWG/Xsu73sAIkhTTaTZ3vMA4jDq+8Rr7kBOZywvZbkSh7DgNt4rt9gjmUFccLbmc
	 q1E8A7PBOidVw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 8BF644C72D;
	Mon, 23 Nov 2026 20:52:43 +0000 (UTC)
From: Binoy Ravindran via B4 Relay <devnull+binoy.vt.edu@kernel.org>
Date: Mon, 23 Nov 2026 15:52:15 -0500
Subject: [PATCH 1/2] rcu-tasks: Add helpers to visit tasks on the exit
 lists
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
Message-Id: <20261123-klp-series-v3-v1-1-427c95811d9b@vt.edu>
References: <20261123-klp-series-v3-v1-0-427c95811d9b@vt.edu>
In-Reply-To: <20261123-klp-series-v3-v1-0-427c95811d9b@vt.edu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795467163; l=6044;
 i=binoy@vt.edu; s=20261123; h=from:subject:message-id;
 bh=rqHs0w3UOy9Xw9vI+yBkCYnZ7G4WelNoCJGsuFqHgcE=;
 b=mw7+imUXCQaN0xhkxXztOeUYmcI0mZEeexUYx3DRVCPx3OEFWkWTTcNi/dWaXA1NlgDU6pubi
 j067hk+6sycDhX+3Li0PuX6lxHgu4qT9Uu0GlrPsNiZlrLGxUh/G88f
X-Developer-Key: i=binoy@vt.edu; a=ed25519;
 pk=4cNdKPHP0InmhK/9bb7Tm2ZMUXUvLGfw1pmVt5b98fA=
X-Endpoint-Received: by B4 Relay for binoy@vt.edu/20261123 with
 auth_id=1622
X-Original-From: Binoy Ravindran <binoy@vt.edu>
Reply-To: binoy@vt.edu
Content-Transfer-Encoding: 7bit

From: Binoy Ravindran <binoy@vt.edu>

A task joins its CPU's RCU-tasks exit list in exit_tasks_rcu_start(),
before exit_notify() unhashes it from the task list, and leaves it in
exit_tasks_rcu_finish(), after do_exit() has disabled preemption for the
final switch. While on the list the task is no longer found by
for_each_process_thread(), but it still runs do_exit() and may sleep
there. Code that must reach every task that can still be descheduled,
such as the livepatch transition, has no way to find it.

Add two helpers. rcu_tasks_visit_exiting() calls a function on each
task on the exit lists under the list locks, without allocating.
rcu_tasks_snapshot_exiting() copies the tasks into a caller-supplied
array with a reference held on each, for callers that must sleep or take
other locks while examining them. Without CONFIG_TASKS_RCU there are no
exit lists, and the helpers do nothing.

rcu_tasks_postscan() keeps its place in an exit list with a bare
list_head while it drops the lock to reschedule, relying on nobody else
traversing the list. Move that cursor into struct rcu_tasks_percpu,
next to the list it marks, so that the new helpers can recognize and
skip it. Only the grace-period kthread runs postscan, one CPU's list at
a time, so one cursor per CPU suffices.

Reviewed-by: Jaidev Shastri <jaidevshastri@vt.edu>
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Binoy Ravindran <binoy@vt.edu>
---
 include/linux/rcupdate.h |  9 +++++++
 kernel/rcu/tasks.h       | 67 +++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 70 insertions(+), 6 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 3f74ae6d6e1f..55b8b4a0fa94 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -214,6 +214,15 @@ static inline void exit_tasks_rcu_start(void) { }
 static inline void exit_tasks_rcu_finish(void) { }
 #endif /* #else #ifdef CONFIG_TASKS_RCU_GENERIC */
 
+typedef void (*rcu_tasks_exiting_fn_t)(struct task_struct *t, void *arg);
+#ifdef CONFIG_TASKS_RCU
+void rcu_tasks_visit_exiting(rcu_tasks_exiting_fn_t fn, void *arg);
+int rcu_tasks_snapshot_exiting(struct task_struct **buf, int max);
+#else
+static inline void rcu_tasks_visit_exiting(rcu_tasks_exiting_fn_t fn, void *arg) { }
+static inline int rcu_tasks_snapshot_exiting(struct task_struct **buf, int max) { return 0; }
+#endif
+
 /**
  * cond_resched_tasks_rcu_qs - Report potential quiescent states to RCU
  *
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index fcac7361ec51..a231d30ebf81 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -49,6 +49,7 @@ struct rcu_tasks_percpu {
 	struct rcu_head barrier_q_head;
 	struct list_head rtp_blkd_tasks;
 	struct list_head rtp_exit_list;
+	struct list_head rtp_exit_cursor;
 	int cpu;
 	int index;
 	struct rcu_tasks *rtpp;
@@ -1068,7 +1069,6 @@ static void rcu_tasks_postscan(struct list_head *hop)
 		struct rcu_tasks_percpu *rtpcp = per_cpu_ptr(rcu_tasks.rtpcpu, cpu);
 		struct task_struct *t;
 		struct task_struct *t1;
-		struct list_head tmp;
 
 		raw_spin_lock_irq_rcu_node(rtpcp);
 		list_for_each_entry_safe(t, t1, &rtpcp->rtp_exit_list, rcu_tasks_exit_list) {
@@ -1081,14 +1081,15 @@ static void rcu_tasks_postscan(struct list_head *hop)
 				continue;
 
 			// Keep our place in the list while pausing.
-			// Nothing else traverses this list, so adding a
-			// bare list_head is OK.
-			list_add(&tmp, &t->rcu_tasks_exit_list);
+			// The cursor lives in rtpcp so that the exit-list
+			// visitors can recognize and skip it.
+			list_add(&rtpcp->rtp_exit_cursor, &t->rcu_tasks_exit_list);
 			raw_spin_unlock_irq_rcu_node(rtpcp);
 			cond_resched(); // For CONFIG_PREEMPT=n kernels
 			raw_spin_lock_irq_rcu_node(rtpcp);
-			t1 = list_entry(tmp.next, struct task_struct, rcu_tasks_exit_list);
-			list_del(&tmp);
+			t1 = list_entry(rtpcp->rtp_exit_cursor.next, struct task_struct,
+					rcu_tasks_exit_list);
+			list_del(&rtpcp->rtp_exit_cursor);
 			j = jiffies + 1;
 		}
 		raw_spin_unlock_irq_rcu_node(rtpcp);
@@ -1332,6 +1333,60 @@ void exit_tasks_rcu_finish(void)
 	raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
 }
 
+/*
+ * Call fn on every task on the exit lists, in place, with the per-CPU list
+ * lock held and interrupts disabled. fn must not sleep. Does not allocate.
+ * These are the tasks that have passed exit_tasks_rcu_start() but not
+ * exit_tasks_rcu_finish(). Once exit_notify() has run they are no longer on
+ * the task list, but they still run do_exit() and may sleep there.
+ */
+void rcu_tasks_visit_exiting(rcu_tasks_exiting_fn_t fn, void *arg)
+{
+	int cpu;
+	unsigned long flags;
+	struct task_struct *t;
+
+	for_each_possible_cpu(cpu) {
+		struct rcu_tasks_percpu *rtpcp = per_cpu_ptr(rcu_tasks.rtpcpu, cpu);
+
+		raw_spin_lock_irqsave_rcu_node(rtpcp, flags);
+		list_for_each_entry(t, &rtpcp->rtp_exit_list, rcu_tasks_exit_list) {
+			if (&t->rcu_tasks_exit_list == &rtpcp->rtp_exit_cursor)
+				continue;
+			fn(t, arg);
+		}
+		raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
+	}
+}
+
+/*
+ * Copy up to max tasks on the exit lists into buf, taking a reference on
+ * each. Returns the number of tasks on the lists, which may exceed max.
+ */
+int rcu_tasks_snapshot_exiting(struct task_struct **buf, int max)
+{
+	int cpu, n = 0;
+	unsigned long flags;
+	struct task_struct *t;
+
+	for_each_possible_cpu(cpu) {
+		struct rcu_tasks_percpu *rtpcp = per_cpu_ptr(rcu_tasks.rtpcpu, cpu);
+
+		raw_spin_lock_irqsave_rcu_node(rtpcp, flags);
+		list_for_each_entry(t, &rtpcp->rtp_exit_list, rcu_tasks_exit_list) {
+			if (&t->rcu_tasks_exit_list == &rtpcp->rtp_exit_cursor)
+				continue;
+			if (n < max) {
+				get_task_struct(t);
+				buf[n] = t;
+			}
+			n++;
+		}
+		raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
+	}
+	return n;
+}
+
 #else /* #ifdef CONFIG_TASKS_RCU */
 void exit_tasks_rcu_start(void) { }
 void exit_tasks_rcu_finish(void) { }

-- 
2.39.5


