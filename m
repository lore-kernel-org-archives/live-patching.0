Return-Path: <live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95899C433F5
	for <live-patching@archiver.kernel.org>; Mon,  9 May 2022 16:00:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238713AbiEIQEl (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Mon, 9 May 2022 12:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238726AbiEIQEk (ORCPT
        <rfc822;live-patching@vger.kernel.org>);
        Mon, 9 May 2022 12:04:40 -0400
X-Greylist: delayed 483 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 09 May 2022 09:00:45 PDT
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0472F0D;
        Mon,  9 May 2022 09:00:44 -0700 (PDT)
Received: from [2603:3005:d05:2b00:6e0b:84ff:fee2:98bb] (helo=imladris.surriel.com)
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <riel@shelob.surriel.com>)
        id 1no5gT-0002xt-UY; Mon, 09 May 2022 11:52:29 -0400
Date:   Mon, 9 May 2022 11:52:27 -0400
From:   Rik van Riel <riel@surriel.com>
To:     Song Liu <song@kernel.org>
Cc:     <linux-kernel@vger.kernel.org>, <live-patching@vger.kernel.org>,
        <mingo@redhat.com>, <peterz@infradead.org>,
        <vincent.guittot@linaro.org>, <jpoimboe@redhat.com>,
        <joe.lawrence@redhat.com>, <kernel-team@fb.com>
Subject: [RFC] sched,livepatch: call stop_one_cpu in
 klp_check_and_switch_task
Message-ID: <20220509115227.6075105e@imladris.surriel.com>
In-Reply-To: <20220507174628.2086373-1-song@kernel.org>
References: <20220507174628.2086373-1-song@kernel.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: riel@shelob.surriel.com
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

After talking with Peter, this seems like it might be a potential approach
to fix the issue for kernels both with PREEMPT enabled and disabled.

If this looks like a reasonable approach to people, we can run experiments
with this patch on a few thousand systems, and compare it with the kernel
live patch transition latencies (and number of failures) on a kernel without
that patch.

Does this look like an approach that could work?

---8<---
sched,livepatch: call stop_one_cpu in klp_check_and_switch_task

If a running task fails to transition to the new kernel live patch after the
first attempt, use the stopper thread to preempt it during subsequent attempts
at switching to the new kernel live patch.

<INSERT EXPERIMENTAL RESULTS HERE>

Signed-off-by: Rik van Riel <riel@surriel.com>

diff --git a/kernel/livepatch/transition.c b/kernel/livepatch/transition.c
index 5d03a2ad1066..26e9e5f09822 100644
--- a/kernel/livepatch/transition.c
+++ b/kernel/livepatch/transition.c
@@ -9,6 +9,7 @@
 
 #include <linux/cpu.h>
 #include <linux/stacktrace.h>
+#include <linux/stop_machine.h>
 #include "core.h"
 #include "patch.h"
 #include "transition.h"
@@ -281,6 +282,11 @@ static int klp_check_and_switch_task(struct task_struct *task, void *arg)
 	return 0;
 }
 
+static int kpatch_dummy_fn(void *dummy)
+{
+	return 0;
+}
+
 /*
  * Try to safely switch a task to the target patch state.  If it's currently
  * running, or it's sleeping on a to-be-patched or to-be-unpatched function, or
@@ -315,6 +321,9 @@ static bool klp_try_switch_task(struct task_struct *task)
 	case -EBUSY:	/* klp_check_and_switch_task() */
 		pr_debug("%s: %s:%d is running\n",
 			 __func__, task->comm, task->pid);
+		/* Preempt the task from the second KLP switch attempt. */
+		if (klp_signals_cnt)
+			stop_one_cpu(task_cpu(task), kpatch_dummy_fn, NULL);
 		break;
 	case -EINVAL:	/* klp_check_and_switch_task() */
 		pr_debug("%s: %s:%d has an unreliable stack\n",

