Return-Path: <SRS0=8L+z=3C=vger.kernel.org=live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2AEAC33CAE
	for <live-patching@archiver.kernel.org>; Mon, 13 Jan 2020 12:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9332721569
	for <live-patching@archiver.kernel.org>; Mon, 13 Jan 2020 12:49:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbgAMMtN (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Mon, 13 Jan 2020 07:49:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:44106 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728863AbgAMMtM (ORCPT <rfc822;live-patching@vger.kernel.org>);
        Mon, 13 Jan 2020 07:49:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7B175AF87;
        Mon, 13 Jan 2020 12:49:10 +0000 (UTC)
From:   Miroslav Benes <mbenes@suse.cz>
To:     jpoimboe@redhat.com, jikos@kernel.org, pmladek@suse.com,
        joe.lawrence@redhat.com, shuah@kernel.org
Cc:     live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH 2/2] selftests/livepatch: Remove unused local variable in set_ftrace_enabled()
Date:   Mon, 13 Jan 2020 13:49:07 +0100
Message-Id: <20200113124907.11086-3-mbenes@suse.cz>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200113124907.11086-1-mbenes@suse.cz>
References: <20200113124907.11086-1-mbenes@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: live-patching-owner@vger.kernel.org
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

set_ftrace_enabled() contains unused local variable "sysctl". Remove it.

Signed-off-by: Miroslav Benes <mbenes@suse.cz>
---
 tools/testing/selftests/livepatch/functions.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
index a6e3d5517a6f..2aab9791791d 100644
--- a/tools/testing/selftests/livepatch/functions.sh
+++ b/tools/testing/selftests/livepatch/functions.sh
@@ -64,7 +64,6 @@ function set_dynamic_debug() {
 }
 
 function set_ftrace_enabled() {
-	local sysctl="$1"
 	result=$(sysctl kernel.ftrace_enabled="$1" 2>&1 | paste --serial --delimiters=' ')
 	echo "livepatch: $result" > /dev/kmsg
 }
-- 
2.24.1

