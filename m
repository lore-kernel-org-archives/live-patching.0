Return-Path: <live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC41C19F2D
	for <live-patching@archiver.kernel.org>; Sat,  6 Aug 2022 18:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241905AbiHFSTp (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Sat, 6 Aug 2022 14:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbiHFSTl (ORCPT
        <rfc822;live-patching@vger.kernel.org>);
        Sat, 6 Aug 2022 14:19:41 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3DCAE0D2;
        Sat,  6 Aug 2022 11:19:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5F594CE090C;
        Sat,  6 Aug 2022 18:19:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C7B94C43140;
        Sat,  6 Aug 2022 18:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659809977;
        bh=2jf7XUSSg7NviQ9OXPRCArt3plt/JLaY1yTdNqJhtOM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=C1+eURT6sst36lg1/ch1dMhxIq/AqYqHFMuz8XSjbiOe95Zo8MP8Hqm+arpLd2tXx
         uShh/E2iAmUxcwhIaukiVk2tYmoaGkN6LWmzQrs6fvoC3ZUD7xh6h0JfUps78w/kyv
         cU2qzPhQqhXFGkaKHYg1p4GpToxMNX1qgGTsGj1+9yEnyD/+EFEkFBqHuWwjCDHcJB
         Rgoo7Ys0hFuDCi8XGmdOaAqQGHOSJRDZ+Ib5hwu0zkSEZRo9Z7oNepvRWYT7l11qca
         H+J9RWl46W87JxEqdr1lEzvxpEHzVQJ7CL7J3eYqg4Yd9FoS6FUF9QtVhR6fHv21Qg
         vhccidR/7U7EA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B89D6C43142;
        Sat,  6 Aug 2022 18:19:37 +0000 (UTC)
Subject: Re: [GIT PULL] livepatching for 5.20
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YuvHVUrcraF20aIP@alley>
References: <YuvHVUrcraF20aIP@alley>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YuvHVUrcraF20aIP@alley>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/livepatching/livepatching.git tags/livepatching-for-5.20
X-PR-Tracked-Commit-Id: 55eb9a6c8bf3e2099863118ef53e02d9f44f85a8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 033a94412b6065a21c2ede2f37867e747a84563f
Message-Id: <165980997775.27284.17771686625033146386.pr-tracker-bot@kernel.org>
Date:   Sat, 06 Aug 2022 18:19:37 +0000
To:     Petr Mladek <pmladek@suse.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

The pull request you sent on Thu, 4 Aug 2022 15:19:17 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/livepatching/livepatching.git tags/livepatching-for-5.20

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/033a94412b6065a21c2ede2f37867e747a84563f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
