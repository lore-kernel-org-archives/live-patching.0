Return-Path: <SRS0=fiSE=EM=vger.kernel.org=live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28625C388F7
	for <live-patching@archiver.kernel.org>; Fri,  6 Nov 2020 02:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC9FC206F7
	for <live-patching@archiver.kernel.org>; Fri,  6 Nov 2020 02:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725950AbgKFCgV (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Thu, 5 Nov 2020 21:36:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:40884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbgKFCft (ORCPT <rfc822;live-patching@vger.kernel.org>);
        Thu, 5 Nov 2020 21:35:49 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6C102224D;
        Fri,  6 Nov 2020 02:35:48 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1karbP-007WMF-ET; Thu, 05 Nov 2020 21:35:47 -0500
Message-ID: <20201106023547.312639435@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 05 Nov 2020 21:32:42 -0500
From:   Steven Rostedt (VMware) <rostedt@goodmis.org>
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
Subject: [PATCH 07/11 v3] livepatch: Trigger WARNING if livepatch function fails due to
 recursion
References: <20201106023235.367190737@goodmis.org>
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
Cc: Joe Lawrence <joe.lawrence@redhat.com>
Cc: live-patching@vger.kernel.org
Suggested-by: Miroslav Benes <mbenes@suse.cz>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
Changes since v2:

 - Blame Miroslav instead of Petr ;-)

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


