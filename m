Return-Path: <SRS0=W3Ma=7R=vger.kernel.org=live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F96AC433DF
	for <live-patching@archiver.kernel.org>; Thu,  4 Jun 2020 18:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F245206A2
	for <live-patching@archiver.kernel.org>; Thu,  4 Jun 2020 18:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591295147;
	bh=8HdutrTK2rIVgEo9ymomel05ls+Kt2dkvSFndR5e5jo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Q93P2AfVwe5zojxVPYPgNsNJ1QaNhmneqzW9lBh3df/03PhyzXEaeW7IsNMbh3XyC
	 JYzYRVpqjYkjSgacWY5h4oXzGY/cKIaQ9K2FaTh18+t3RDsfkwv6yfEH5o2OpiRYTl
	 tOVwRHHFYDvJXyAvjzKjOCU8t7ihiXWHOZcZeM7s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730900AbgFDSZl (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Thu, 4 Jun 2020 14:25:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:44766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730813AbgFDSZM (ORCPT <rfc822;live-patching@vger.kernel.org>);
        Thu, 4 Jun 2020 14:25:12 -0400
Subject: Re: [GIT PULL] livepatching for 5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591295112;
        bh=8HdutrTK2rIVgEo9ymomel05ls+Kt2dkvSFndR5e5jo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=M/Ee3UkZCQcaGR9OuKqypLJMOflEtXeBUi6tqgpZ5B9K9aRTBakV+HTR+UGZ9bvDp
         xNib6dd7fUcysV6zpCAea6lv0wjN+1tnluKz4sPfXPC4twe9oSxjP4LMrwFM2DwJNW
         Jye/GyO4SGkifjRz0pDQAIhnsu4aP9ZWjtZ9mpN4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <nycvar.YFH.7.76.2006032232540.13242@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2006032232540.13242@cbobk.fhfr.pm>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <nycvar.YFH.7.76.2006032232540.13242@cbobk.fhfr.pm>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/livepatching/livepatching.git
 for-linus
X-PR-Tracked-Commit-Id: f55d9895884b1e816f95b5109b4b3827ae18c4ab
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9fb4c5250f10dc4d8257cd766991be690eb25c5b
Message-Id: <159129511262.18772.3769609124837919224.pr-tracker-bot@kernel.org>
Date:   Thu, 04 Jun 2020 18:25:12 +0000
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Sender: live-patching-owner@vger.kernel.org
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

The pull request you sent on Wed, 3 Jun 2020 22:42:14 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/livepatching/livepatching.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9fb4c5250f10dc4d8257cd766991be690eb25c5b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
