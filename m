Return-Path: <SRS0=K5wt=VI=vger.kernel.org=live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 686A3C742A1
	for <live-patching@archiver.kernel.org>; Thu, 11 Jul 2019 22:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27F58216C8
	for <live-patching@archiver.kernel.org>; Thu, 11 Jul 2019 22:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562885113;
	bh=T9hjZeVkNdRpWOVn06WZ3sowWNuRtNjxDP3EB1+CnzA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=DV2IuZpxl8jkhHqMoUIEAPwBGemJ633QX7/13RO2MmVtNozYUuAzEAJbOwdKr6Efp
	 wOCyfD6C7ezpfECcYcpS1JDdpeiJ1etf4yT7qGJnr07DEyJ7TPpbmn0fSQdLvs/1Cd
	 wYO0F1ENn9yCsjmfubAtKCoERLhvop+Zl/iKt2aE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729468AbfGKWpL (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Thu, 11 Jul 2019 18:45:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:39730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729461AbfGKWpL (ORCPT <rfc822;live-patching@vger.kernel.org>);
        Thu, 11 Jul 2019 18:45:11 -0400
Subject: Re: [GIT PULL] livepatching for 5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562885111;
        bh=T9hjZeVkNdRpWOVn06WZ3sowWNuRtNjxDP3EB1+CnzA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=vQhxGoZf193c6u5OMq5FZR9sDHwECS9p0k7twWQ/1Z3Gko+qGp2mxZsvROJF7Dzqb
         4+QfOV05y9aPEDPkxmOnTyC446dW3oiOKrGvoidHqv3tfOK4Y2u9CtSjVbDAIGGRRd
         LBuUvEzN4e3MlvScgob79wtM5sm8DJnap8HdAMV8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <nycvar.YFH.7.76.1907100127250.5899@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1907100127250.5899@cbobk.fhfr.pm>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <nycvar.YFH.7.76.1907100127250.5899@cbobk.fhfr.pm>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/livepatching/livepatching.git
 for-linus
X-PR-Tracked-Commit-Id: 38195dd5e916f3e55aec585703f2432562c2db02
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: db0457338ece7482378d88e50ad298191c3e6947
Message-Id: <156288511109.25905.4136973094169718102.pr-tracker-bot@kernel.org>
Date:   Thu, 11 Jul 2019 22:45:11 +0000
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Sender: live-patching-owner@vger.kernel.org
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

The pull request you sent on Wed, 10 Jul 2019 01:34:19 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/livepatching/livepatching.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/db0457338ece7482378d88e50ad298191c3e6947

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
