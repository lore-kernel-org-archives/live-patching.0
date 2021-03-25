Return-Path: <live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E47C433DB
	for <live-patching@archiver.kernel.org>; Thu, 25 Mar 2021 01:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38AFE61A12
	for <live-patching@archiver.kernel.org>; Thu, 25 Mar 2021 01:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235770AbhCYBsv (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Wed, 24 Mar 2021 21:48:51 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:14887 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235750AbhCYBsp (ORCPT
        <rfc822;live-patching@vger.kernel.org>);
        Wed, 24 Mar 2021 21:48:45 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4F5Sdh3lYzzkfHH;
        Thu, 25 Mar 2021 09:47:04 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.43) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Thu, 25 Mar 2021 09:48:40 +0800
From:   Dong Kai <dongkai11@huawei.com>
To:     <jpoimboe@redhat.com>, <jikos@kernel.org>, <mbenes@suse.cz>,
        <pmladek@suse.com>, <joe.lawrence@redhat.com>
CC:     <axboe@kernel.dk>, <live-patching@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] livepatch: klp_send_signal should treat PF_IO_WORKER like PF_KTHREAD
Date:   Thu, 25 Mar 2021 09:48:36 +0800
Message-ID: <20210325014836.40649-1-dongkai11@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.43]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

commit 15b2219facad ("kernel: freezer should treat PF_IO_WORKER like
PF_KTHREAD for freezing") is to fix the freezeing issue of IO threads
by making the freezer not send them fake signals.

Here live patching consistency model call klp_send_signals to wake up
all tasks by send fake signal to all non-kthread which only check the
PF_KTHREAD flag, so it still send signal to io threads which may lead to
freezeing issue of io threads.

Here we take the same fix action by treating PF_IO_WORKERS as PF_KTHREAD
within klp_send_signal function.

Signed-off-by: Dong Kai <dongkai11@huawei.com>
---
note:
the io threads freeze issue links:
[1] https://lore.kernel.org/io-uring/YEgnIp43%2F6kFn8GL@kevinlocke.name/
[2] https://lore.kernel.org/io-uring/d7350ce7-17dc-75d7-611b-27ebf2cb539b@kernel.dk/

 kernel/livepatch/transition.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/livepatch/transition.c b/kernel/livepatch/transition.c
index f6310f848f34..0e1c35c8f4b4 100644
--- a/kernel/livepatch/transition.c
+++ b/kernel/livepatch/transition.c
@@ -358,7 +358,7 @@ static void klp_send_signals(void)
 		 * Meanwhile the task could migrate itself and the action
 		 * would be meaningless. It is not serious though.
 		 */
-		if (task->flags & PF_KTHREAD) {
+		if (task->flags & (PF_KTHREAD | PF_IO_WORKER)) {
 			/*
 			 * Wake up a kthread which sleeps interruptedly and
 			 * still has not been migrated.
-- 
2.17.1

