Return-Path: <SRS0=ks2W=DW=vger.kernel.org=live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAAB5C433E7
	for <live-patching@archiver.kernel.org>; Thu, 15 Oct 2020 22:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C86E207C4
	for <live-patching@archiver.kernel.org>; Thu, 15 Oct 2020 22:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602800367;
	bh=AmD9eF7iGEc0dwK/aaxxnC31vs9NAjgaesdQHjBBHsE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=wwv3inCG5ziDLiiP0t6lHsT6oIjV7R3isD4A9F3FM+i4bpKyamHXb45K83bvS8l+l
	 HnM7u7t5JT0F2eboTHAtT9SdcoMd6+z5b4KovxyphcQNQMZgryEDcks7c4igudSUho
	 AoDswTY8BgegENUc1oa4XiFOJaS4hIL+hBYIkXI8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731645AbgJOWT0 (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Thu, 15 Oct 2020 18:19:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:54950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731189AbgJOWTZ (ORCPT <rfc822;live-patching@vger.kernel.org>);
        Thu, 15 Oct 2020 18:19:25 -0400
Subject: Re: [GIT PULL] livepatching for 5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602800364;
        bh=AmD9eF7iGEc0dwK/aaxxnC31vs9NAjgaesdQHjBBHsE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=fcWiFlGsQIkIcfqfvbL0eV2qD9NOHaHE6mrLgYHikHYIQFSAlD0Pz8fPlNgD2t3Md
         yiPP9dpyeQnwk7Iv2PU/fQS32ooXPw+n4ZHxpsqXkbSbjPzAmgXGQiwVSNaYcqSEZJ
         9USRAYsj8vyLuDRZF5/j2RimskNLChW/+HrHoz3w=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <nycvar.YFH.7.76.2010151950140.18859@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2010151950140.18859@cbobk.fhfr.pm>
X-PR-Tracked-List-Id: <live-patching.vger.kernel.org>
X-PR-Tracked-Message-Id: <nycvar.YFH.7.76.2010151950140.18859@cbobk.fhfr.pm>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/livepatching/livepatching for-linus
X-PR-Tracked-Commit-Id: 884ee754f5aedbe54406a4d308a6cc57335747ce
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0cd7d9795fa82226e7516d38b474bddae8b1ff26
Message-Id: <160280036480.16623.4178503158509734625.pr-tracker-bot@kernel.org>
Date:   Thu, 15 Oct 2020 22:19:24 +0000
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

The pull request you sent on Thu, 15 Oct 2020 20:31:55 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/livepatching/livepatching for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0cd7d9795fa82226e7516d38b474bddae8b1ff26

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
