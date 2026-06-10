Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1C12D0C72;
	Wed, 10 Jun 2026 01:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781055452; cv=none; b=qZkzvhKgVLZZ1h5MU86e+Ms1VmN94G3qmNTu1H9XbR3J0l1GOymZ2F9/79Z2nkn3W192BhlzAWihXG3GQWT18U78r+pQEF6lbCbxAECvxICA6MDde+Wtl8spLZIrNSouGN3gqOW60OGpxAY59DMHP/sgVuZQlq+C5OVzqOBABb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781055452; c=relaxed/simple;
	bh=0EJIh8+ZTp1QVJEf/l9vyxcyEI/1RpP1pN26Zm4qSHo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NoTyomu3URlkW0EoCRoGaPfz122Sxr181bgMDXG/5G62H9Y0SYA8sgnsReCZK2tHtNHYZ2znLoYLxILCxHkdUWLg6GJc06PL6g30qXXQg0rJH/nokU3PEbwNDpdd7cGfnIH3pNpd7y2MS0HZ8e+BCyRGxDIXAPCahcbTxE8cpOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gZpKR14g4zKHMKD;
	Wed, 10 Jun 2026 09:36:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 8543E4056E;
	Wed, 10 Jun 2026 09:37:19 +0800 (CST)
Received: from huawei.com (unknown [7.197.88.80])
	by APP4 (Coremail) with SMTP id gCh0CgD3S4DIvyhqbecCBQ--.23582S2;
	Wed, 10 Jun 2026 09:37:18 +0800 (CST)
From: Tengda Wu <wutengda@huaweicloud.com>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Petr Mladek <pmladek@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Alexei Starovoitov <ast@kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org,
	Tengda Wu <wutengda@huaweicloud.com>
Subject: [PATCH v4] rethook: Remove the running task check in rethook_find_ret_addr()
Date: Wed, 10 Jun 2026 09:36:58 +0800
Message-Id: <20260610013658.1837963-1-wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3S4DIvyhqbecCBQ--.23582S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZF15CF1UAry8CFWUGF15urg_yoW5XF4fpF
	4xKw1FkF1qyr10yw1qvw4rZ3y5ZrZ5tw43WanrGw1Fkrs0qr4q9ry2g3WYvF4rurZ7G34a
	qFW2vrWDCFnrZa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIda
	VFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

The current check in rethook_find_ret_addr() prevents obtaining a return
address when the target task is marked as running. However, this condition
is both insufficient for correctness and unnecessary for its intended
purpose.

The check is inherently racy: a task can begin running on another CPU
immediately after task_is_running() returns false, potentially leading to
concurrent modification of rethook data structures while the iteration is
in progress.

Rather than trying to fix this unreliable check deep in the unwinding
path, simply remove it. The iteration is already safe from crashes because
unwind_next_frame() holds RCU and rethook_node structures are RCU-freed;
even if the iteration goes off the rails and returns invalid information,
it will not crash. Callers that require consistency must provide a safe
context themselves.

Fixes: 54ecbe6f1ed5 ("rethook: Add a generic return hook")
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
v4: Also update the function description in the comment.
v3: https://lore.kernel.org/all/20260609084953.901576-1-wutengda@huaweicloud.com/
v2: https://lore.kernel.org/all/20260609005728.458962-1-wutengda@huaweicloud.com/
v1: https://lore.kernel.org/all/20260525132253.1889726-1-wutengda@huaweicloud.com/

 kernel/trace/rethook.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/rethook.c b/kernel/trace/rethook.c
index 5a8bdf88999a..1e7fdebe3cd5 100644
--- a/kernel/trace/rethook.c
+++ b/kernel/trace/rethook.c
@@ -233,9 +233,10 @@ NOKPROBE_SYMBOL(__rethook_find_ret_addr);
  *
  * Find the correct return address modified by a rethook on @tsk in unsigned
  * long type.
- * The @tsk must be 'current' or a task which is not running. @frame is a hint
- * to get the currect return address - which is compared with the
- * rethook::frame field. The @cur is a loop cursor for searching the
+ * @tsk can be any task (any state). If not 'current', the result may be
+ * unreliable. Callers requiring reliability must ensure a safe context.
+ * @frame is a hint to get the correct return address - which is compared with
+ * the rethook::frame field. The @cur is a loop cursor for searching the
  * kretprobe return addresses on the @tsk. The '*@cur' should be NULL at the
  * first call, but '@cur' itself must NOT NULL.
  *
@@ -250,9 +251,6 @@ unsigned long rethook_find_ret_addr(struct task_struct *tsk, unsigned long frame
 	if (WARN_ON_ONCE(!cur))
 		return 0;
 
-	if (tsk != current && task_is_running(tsk))
-		return 0;
-
 	do {
 		ret = __rethook_find_ret_addr(tsk, cur);
 		if (!ret)
-- 
2.34.1

