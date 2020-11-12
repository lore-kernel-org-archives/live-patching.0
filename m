Return-Path: <live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E7F7C388F9
	for <live-patching@archiver.kernel.org>; Thu, 12 Nov 2020 01:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E75BF20791
	for <live-patching@archiver.kernel.org>; Thu, 12 Nov 2020 01:33:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbgKLBdy (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Wed, 11 Nov 2020 20:33:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:38966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728084AbgKLAfh (ORCPT <rfc822;live-patching@vger.kernel.org>);
        Wed, 11 Nov 2020 19:35:37 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BA1321D91;
        Thu, 12 Nov 2020 00:33:35 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kd0YQ-00029M-4m; Wed, 11 Nov 2020 19:33:34 -0500
Message-ID: <20201112003334.032370380@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 11 Nov 2020 19:32:50 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        live-patching@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Miroslav Benes <mbenes@suse.cz>
Subject: [for-next][PATCH 06/17] livepatch/ftrace: Add recursion protection to the ftrace callback
References: <20201112003244.764326960@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

If a ftrace callback does not supply its own recursion protection and
does not set the RECURSION_SAFE flag in its ftrace_ops, then ftrace will
make a helper trampoline to do so before calling the callback instead of
just calling the callback directly.

The default for ftrace_ops is going to change. It will expect that handlers
provide their own recursion protection, unless its ftrace_ops states
otherwise.

Link: https://lkml.kernel.org/r/20201028115613.291169246@goodmis.org
Link: https://lkml.kernel.org/r/20201106023547.122802424@goodmis.org

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Joe Lawrence <joe.lawrence@redhat.com>
Cc: live-patching@vger.kernel.org
Reviewed-by: Petr Mladek <pmladek@suse.com>
Acked-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/livepatch/patch.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/livepatch/patch.c b/kernel/livepatch/patch.c
index b552cf2d85f8..6c0164d24bbd 100644
--- a/kernel/livepatch/patch.c
+++ b/kernel/livepatch/patch.c
@@ -45,9 +45,13 @@ static void notrace klp_ftrace_handler(unsigned long ip,
 	struct klp_ops *ops;
 	struct klp_func *func;
 	int patch_state;
+	int bit;
 
 	ops = container_of(fops, struct klp_ops, fops);
 
+	bit = ftrace_test_recursion_trylock();
+	if (bit < 0)
+		return;
 	/*
 	 * A variant of synchronize_rcu() is used to allow patching functions
 	 * where RCU is not watching, see klp_synchronize_transition().
@@ -117,6 +121,7 @@ static void notrace klp_ftrace_handler(unsigned long ip,
 
 unlock:
 	preempt_enable_notrace();
+	ftrace_test_recursion_unlock(bit);
 }
 
 /*
-- 
2.28.0


