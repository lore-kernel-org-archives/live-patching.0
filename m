Return-Path: <SRS0=ySN2=EF=vger.kernel.org=live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1311FC61DD8
	for <live-patching@archiver.kernel.org>; Fri, 30 Oct 2020 21:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C152022253
	for <live-patching@archiver.kernel.org>; Fri, 30 Oct 2020 21:40:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbgJ3VkQ (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Fri, 30 Oct 2020 17:40:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:46966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727383AbgJ3VkQ (ORCPT <rfc822;live-patching@vger.kernel.org>);
        Fri, 30 Oct 2020 17:40:16 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AAD0D22245;
        Fri, 30 Oct 2020 21:40:15 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kYc86-00649V-9d; Fri, 30 Oct 2020 17:40:14 -0400
Message-ID: <20201030214014.167613723@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 30 Oct 2020 17:31:49 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        live-patching@vger.kernel.org
Subject: [PATCH 07/11 v2] livepatch: Trigger WARNING if livepatch function fails due to
 recursion
References: <20201030213142.096102821@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

If for some reason a function is called that triggers the recursion
detection of live patching, trigger a warning. By not executing the live
patch code, it is possible that the old unpatched function will be called
placing the system into an unknown state.

Link: https://lore.kernel.org/r/20201029145709.GD16774@alley

Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Miroslav Benes <mbenes@suse.cz>
Cc: Joe Lawrence <joe.lawrence@redhat.com>
Cc: live-patching@vger.kernel.org
Suggested-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/livepatch/patch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/livepatch/patch.c b/kernel/livepatch/patch.c
index 6c0164d24bbd..15480bf3ce88 100644
--- a/kernel/livepatch/patch.c
+++ b/kernel/livepatch/patch.c
@@ -50,7 +50,7 @@ static void notrace klp_ftrace_handler(unsigned long ip,
 	ops = container_of(fops, struct klp_ops, fops);
 
 	bit = ftrace_test_recursion_trylock();
-	if (bit < 0)
+	if (WARN_ON_ONCE(bit < 0))
 		return;
 	/*
 	 * A variant of synchronize_rcu() is used to allow patching functions
-- 
2.28.0


