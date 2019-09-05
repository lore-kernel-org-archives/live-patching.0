Return-Path: <SRS0=EEVa=XA=vger.kernel.org=live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 826C2C3A5A5
	for <live-patching@archiver.kernel.org>; Thu,  5 Sep 2019 12:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 674952245D
	for <live-patching@archiver.kernel.org>; Thu,  5 Sep 2019 12:46:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732628AbfIEMpR (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Thu, 5 Sep 2019 08:45:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:40652 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731301AbfIEMpR (ORCPT <rfc822;live-patching@vger.kernel.org>);
        Thu, 5 Sep 2019 08:45:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 75543B653;
        Thu,  5 Sep 2019 12:45:16 +0000 (UTC)
From:   Miroslav Benes <mbenes@suse.cz>
To:     jikos@kernel.org, jpoimboe@redhat.com, pmladek@suse.com
Cc:     joe.lawrence@redhat.com, nstange@suse.de,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miroslav Benes <mbenes@suse.cz>
Subject: [RFC PATCH v2 0/3] livepatch: Clear relocation targets on a module removal
Date:   Thu,  5 Sep 2019 14:45:11 +0200
Message-Id: <20190905124514.8944-1-mbenes@suse.cz>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: live-patching-owner@vger.kernel.org
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

Updated version with Petr's feedback. It looks a bit different and
better now (I would say). Not that it should be considered before we
decide what to do with late module patching, but I finished it before
the discussion started and someone could be interested.

v1: http://lore.kernel.org/r/20190719122840.15353-1-mbenes@suse.cz

Tested on x86_64, ppc64le and s390x. Cross-compiled on arm64 to verify
that nothing is broken.

[1] 20180602161151.apuhs2dygsexmcg2@treble
[2] 1561019068-132672-1-git-send-email-cj.chengjian@huawei.com
[3] 20180607092949.1706-1-mbenes@suse.cz

Miroslav Benes (3):
  livepatch: Clear relocation targets on a module removal
  livepatch: Unify functions for writing and clearing object relocations
  livepatch: Clean up klp_update_object_relocations() return paths

 arch/powerpc/kernel/module_64.c | 45 +++++++++++++++++++++++++
 arch/s390/kernel/module.c       |  8 +++++
 arch/x86/kernel/module.c        | 43 ++++++++++++++++++++++++
 include/linux/moduleloader.h    |  7 ++++
 kernel/livepatch/core.c         | 58 ++++++++++++++++++++++++---------
 5 files changed, 146 insertions(+), 15 deletions(-)

-- 
2.23.0

