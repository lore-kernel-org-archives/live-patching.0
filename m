Return-Path: <SRS0=BLy0=VQ=vger.kernel.org=live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E1CC76188
	for <live-patching@archiver.kernel.org>; Fri, 19 Jul 2019 12:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E14A21851
	for <live-patching@archiver.kernel.org>; Fri, 19 Jul 2019 12:28:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbfGSM2n (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Fri, 19 Jul 2019 08:28:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:49110 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727552AbfGSM2n (ORCPT <rfc822;live-patching@vger.kernel.org>);
        Fri, 19 Jul 2019 08:28:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8591BAF37;
        Fri, 19 Jul 2019 12:28:42 +0000 (UTC)
From:   Miroslav Benes <mbenes@suse.cz>
To:     jikos@kernel.org, jpoimboe@redhat.com, pmladek@suse.com
Cc:     joe.lawrence@redhat.com, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>
Subject: [RFC PATCH 0/2] livepatch: Clear relocation targets on a module removal
Date:   Fri, 19 Jul 2019 14:28:38 +0200
Message-Id: <20190719122840.15353-1-mbenes@suse.cz>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: live-patching-owner@vger.kernel.org
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

The second attempt to resolve the issue reported by Josh last year [1]
and also reported earlier this year again [2]. The first attempt [3]
tried to deny the patched modules to be removed. It did not solve the
issue completely. It would be possible, but we decided to try the
arch-specific approach first, which I am sending now.

Sending early as RFC, because I am leaving on holiday tomorrow and it
would be great if you took a look meanwhile.

- I decided not to CC the arch maintainers yet. If we decide that the
  approach is feasible first on our livepatch side, I will split the
  second patch and resend properly.
- the first patch could go in regardless the rest, I guess.
- I am not sure about the placement in
  klp_cleanup_module_patches_limited(). I think it is the best possible,
  but I would really appreciate double-checking.
- I am also not sure about the naming, so ideas also welcome

Lightly tested on both x86_64 and ppc64le and it looked ok.

[1] 20180602161151.apuhs2dygsexmcg2@treble
[2] 1561019068-132672-1-git-send-email-cj.chengjian@huawei.com
[3] 20180607092949.1706-1-mbenes@suse.cz

Miroslav Benes (2):
  livepatch: Nullify obj->mod in klp_module_coming()'s error path
  livepatch: Clear relocation targets on a module removal

 arch/powerpc/kernel/Makefile    |  1 +
 arch/powerpc/kernel/livepatch.c | 75 +++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/module.h    | 15 +++++++
 arch/powerpc/kernel/module_64.c |  7 +--
 arch/x86/kernel/livepatch.c     | 67 +++++++++++++++++++++++++++++
 include/linux/livepatch.h       |  5 +++
 kernel/livepatch/core.c         | 18 +++++---
 7 files changed, 177 insertions(+), 11 deletions(-)
 create mode 100644 arch/powerpc/kernel/livepatch.c
 create mode 100644 arch/powerpc/kernel/module.h

-- 
2.22.0

