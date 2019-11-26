Return-Path: <SRS0=8lKs=ZS=vger.kernel.org=live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B8C2C432C3
	for <live-patching@archiver.kernel.org>; Tue, 26 Nov 2019 04:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73B9D2084B
	for <live-patching@archiver.kernel.org>; Tue, 26 Nov 2019 04:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574742328;
	bh=rU5bCIB3n7nIB+6CSpyRTeoRcfcR9fgwXeAA8vDEO/0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=mdD0TFQRcI4N9LqZTzDnVV9ewHfLS+Tj45IAgjcfmMQ1z1xWX0b71l1bHGEpN/7zy
	 kesUyQBsjUBVG0ZVDz9Rz7XccOiZ9790PsPTFMcvtFtwJ/SyE5BiRo/xDyYrXB1UpW
	 u3QPxbpY7ZXUppHYnZb3szwzPF034oxwq/AoCKf8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbfKZEZM (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Mon, 25 Nov 2019 23:25:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:59888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727678AbfKZEZK (ORCPT <rfc822;live-patching@vger.kernel.org>);
        Mon, 25 Nov 2019 23:25:10 -0500
Subject: Re: [GIT PULL] livepatching for 5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574742310;
        bh=rU5bCIB3n7nIB+6CSpyRTeoRcfcR9fgwXeAA8vDEO/0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=mvvQHcdfS77aC6Q4ND8VSnxtDZMYXC9GFOKemkaIB5tndF04JuxArfSoV0wmuqDoQ
         3gdwsc503IBdiPryIshZwWKQy6kRhl4Y5KPoaylUsu9edMYL4t6INx2wvH0PU+fWsX
         LGnzblyuWYlVCE6HQwjbt0aWzB1e6qd8PIaBSRUM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191125141425.qlda25sth5zj66pn@pathway.suse.cz>
References: <20191125141425.qlda25sth5zj66pn@pathway.suse.cz>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191125141425.qlda25sth5zj66pn@pathway.suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/livepatching/livepatching
 tags/livepatching-for-5.5
X-PR-Tracked-Commit-Id: 0e672adc87e5ae1758b6e0571b42d743a8324327
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f838767555d40f29bc4771c5c8cc63193094b7cc
Message-Id: <157474231022.2264.1059004263943125355.pr-tracker-bot@kernel.org>
Date:   Tue, 26 Nov 2019 04:25:10 +0000
To:     Petr Mladek <pmladek@suse.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Sender: live-patching-owner@vger.kernel.org
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

The pull request you sent on Mon, 25 Nov 2019 15:14:25 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/livepatching/livepatching tags/livepatching-for-5.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f838767555d40f29bc4771c5c8cc63193094b7cc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
