Return-Path: <live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19461C38A2D
	for <live-patching@archiver.kernel.org>; Wed, 26 Oct 2022 19:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234975AbiJZTlo (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Wed, 26 Oct 2022 15:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234994AbiJZTlh (ORCPT
        <rfc822;live-patching@vger.kernel.org>);
        Wed, 26 Oct 2022 15:41:37 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94E1BA908;
        Wed, 26 Oct 2022 12:41:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3BCC321FFC;
        Wed, 26 Oct 2022 19:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1666813295; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=IeeQlPhUw/2ROpMbMT/QHc9rakMBnDEvhQyjwBHr2gw=;
        b=CTNUecuQRTd5R0V8FdqFMQ660QjmXQMAIISAE3hTUaCrKofc27TvkYFpjIrphBDVryTqIS
        1WrFt+oSPrvntwGT2bC/sIOsEJ+/LSsQyhqQrIRaO2J2OPtqIHj0k/IpMCuEwyLNJH2uQu
        5EbVwMgXyYY6ZXydgzOl75yspyOAj0g=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B17D313A77;
        Wed, 26 Oct 2022 19:41:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7AicGmyNWWNlFwAAMHmgww
        (envelope-from <mpdesouza@suse.com>); Wed, 26 Oct 2022 19:41:32 +0000
From:   Marcos Paulo de Souza <mpdesouza@suse.com>
To:     linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Cc:     jpoimboe@redhat.com, joe.lawrence@redhat.com, pmladek@suse.com,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH v2 0/4] livepatch: Add garbage collection for shadow variables
Date:   Wed, 26 Oct 2022 16:41:18 -0300
Message-Id: <20221026194122.11761-1-mpdesouza@suse.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

Hello,

This is the v2 of the livepatch shadow GC patches. The changes are minor since
nobody asked for for big code changes.

Changes from v1:
* Reworked commit messages (Petr)
* Added my SoB which was missing in some patches, or the ordering was wrong. (Josh)
* Change __klp_shadow_get_or_use to __klp_shadow_get_or_add_locked and add a comment (Petr)
* Add lockdep_assert_held on __klp_shadow_get_or_add_locked (Petr)
  about it's meaning (Petr)
* CCing LKML (Josh)

Some observations:
* Petr has reviewed some of the patches that we created. I kept the Reviewed-by
  tags since he wrote the patches some time ago and now he reviewed them again
  on the ML.
* There were questions about possible problems about using klp_shadow_types
  instead of using ids, but Petr already explained that internally it still uses
  the id to find the correct livepatch.
* Regarding the possibility of multiple patches use the same ID, the problem
  already existed before. Petr suggested using a "stringified" version using
  name and id, but nobody has commented yet. I can implement such feature in a
  v3 if necessary.

Marcos Paulo de Souza (2):
  livepatch/shadow: Introduce klp_shadow_type structure
  livepatch/shadow: Add garbage collection of shadow variables

Petr Mladek (2):
  livepatch/shadow: Separate code to get or use pre-allocated shadow
    variable
  livepatch/shadow: Separate code removing all shadow variables for a
    given id

 include/linux/livepatch.h                     |  50 ++-
 kernel/livepatch/core.c                       |  39 +++
 kernel/livepatch/core.h                       |   1 +
 kernel/livepatch/shadow.c                     | 297 +++++++++++++-----
 kernel/livepatch/transition.c                 |   4 +-
 lib/livepatch/test_klp_shadow_vars.c          | 119 ++++---
 samples/livepatch/livepatch-shadow-fix1.c     |  24 +-
 samples/livepatch/livepatch-shadow-fix2.c     |  34 +-
 .../selftests/livepatch/test-shadow-vars.sh   |   2 +-
 9 files changed, 417 insertions(+), 153 deletions(-)

-- 
2.37.3

