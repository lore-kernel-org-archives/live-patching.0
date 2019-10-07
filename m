Return-Path: <SRS0=jYRv=YA=vger.kernel.org=live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C074ECE58D
	for <live-patching@archiver.kernel.org>; Mon,  7 Oct 2019 08:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BC5A21655
	for <live-patching@archiver.kernel.org>; Mon,  7 Oct 2019 08:17:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbfJGIRU (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Mon, 7 Oct 2019 04:17:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:56290 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727448AbfJGIRU (ORCPT <rfc822;live-patching@vger.kernel.org>);
        Mon, 7 Oct 2019 04:17:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 82668AE8D;
        Mon,  7 Oct 2019 08:17:18 +0000 (UTC)
From:   Miroslav Benes <mbenes@suse.cz>
To:     rostedt@goodmis.org, mingo@redhat.com, jpoimboe@redhat.com,
        jikos@kernel.org, pmladek@suse.com, joe.lawrence@redhat.com
Cc:     linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
        Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH 3/3] livepatch: Use FTRACE_OPS_FL_PERMANENT
Date:   Mon,  7 Oct 2019 10:17:14 +0200
Message-Id: <20191007081714.20259-4-mbenes@suse.cz>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191007081714.20259-1-mbenes@suse.cz>
References: <20191007081714.20259-1-mbenes@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: live-patching-owner@vger.kernel.org
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

Use FTRACE_OPS_FL_PERMANENT flag to be immune to toggling the
'ftrace_enabled' sysctl knob.

Signed-off-by: Miroslav Benes <mbenes@suse.cz>
---
 kernel/livepatch/patch.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/livepatch/patch.c b/kernel/livepatch/patch.c
index bd43537702bd..b552cf2d85f8 100644
--- a/kernel/livepatch/patch.c
+++ b/kernel/livepatch/patch.c
@@ -196,7 +196,8 @@ static int klp_patch_func(struct klp_func *func)
 		ops->fops.func = klp_ftrace_handler;
 		ops->fops.flags = FTRACE_OPS_FL_SAVE_REGS |
 				  FTRACE_OPS_FL_DYNAMIC |
-				  FTRACE_OPS_FL_IPMODIFY;
+				  FTRACE_OPS_FL_IPMODIFY |
+				  FTRACE_OPS_FL_PERMANENT;
 
 		list_add(&ops->node, &klp_ops);
 
-- 
2.23.0

