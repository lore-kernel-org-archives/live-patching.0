Return-Path: <SRS0=1VHJ=CQ=vger.kernel.org=live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99306C43461
	for <live-patching@archiver.kernel.org>; Mon,  7 Sep 2020 08:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FFC12145D
	for <live-patching@archiver.kernel.org>; Mon,  7 Sep 2020 08:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbgIGIUj (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Mon, 7 Sep 2020 04:20:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:36690 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727907AbgIGIUi (ORCPT <rfc822;live-patching@vger.kernel.org>);
        Mon, 7 Sep 2020 04:20:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D57DBAE16;
        Mon,  7 Sep 2020 08:20:37 +0000 (UTC)
Date:   Mon, 7 Sep 2020 10:20:36 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Subject: [GIT PULL] livepatching for 5.9-rc5
Message-ID: <20200907082036.GC8084@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: live-patching-owner@vger.kernel.org
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

Linus,

please pull the latest livepatching changes from

  git://git.kernel.org/pub/scm/linux/kernel/git/livepatching/livepatching tags/livepatching-for-5.9-rc5

======================================

- Workaround "unreachable instruction" objtool warnings that happen
  with some compiler versions.

----------------------------------------------------------------
Josh Poimboeuf (1):
      Revert "kbuild: use -flive-patching when CONFIG_LIVEPATCH is enabled"

 Makefile | 4 ----
 1 file changed, 4 deletions(-)


Best Regards,
Petr
