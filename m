Return-Path: <SRS0=MLKB=BQ=vger.kernel.org=live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCFEBC433E0
	for <live-patching@archiver.kernel.org>; Thu,  6 Aug 2020 19:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDD79221E5
	for <live-patching@archiver.kernel.org>; Thu,  6 Aug 2020 19:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596743690;
	bh=PvFDB25rT0Rn8EmFv571YNgGV/SoRouG9j9H2iWeAA4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=M9SCdEzdrZTY+5ojSdAT1bGGXOxW/IBMzLmDSmoO7B7u2WM63PM34CkCGTJv7xORO
	 Hs3mc0iKxJB883qAk0xL/IJ2vZLW1LHNS2I1QN9RCa60cK1Te+FvU515Lw/wlzywHQ
	 dWwFEUUOqyQwB6xYm2BAFOYaJxitlFPo4qOwYHFE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726058AbgHFTyu (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Thu, 6 Aug 2020 15:54:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:58324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725875AbgHFTyu (ORCPT <rfc822;live-patching@vger.kernel.org>);
        Thu, 6 Aug 2020 15:54:50 -0400
Subject: Re: [GIT PULL] livepatching for 5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596743690;
        bh=PvFDB25rT0Rn8EmFv571YNgGV/SoRouG9j9H2iWeAA4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=n4AjJk3B2lwIzpjmjFpnbMtCVbogZXvlALxYrX9J3rp1sHWQR/xLXibw/VAXWNvb8
         DTDRZHGVqbFjTILuIlhfCLVJ5Ypsz/wTLcdm9rbVslynKrjoKVWQf02ER04ssaADgw
         YZEXpYeoXj/cXSOPzthVAPnBL4tFnJ+jIStCUt/U=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200806082437.GK24529@alley>
References: <20200806082437.GK24529@alley>
X-PR-Tracked-List-Id: <live-patching.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200806082437.GK24529@alley>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/livepatching/livepatching tags/livepatching-for-5.9
X-PR-Tracked-Commit-Id: 5e4d46881f29a93f35f3aefeebc80cebfb44ef71
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1e21b5c73912a516bb13aec0ff69205b0b33568f
Message-Id: <159674368994.25191.1307493752244719342.pr-tracker-bot@kernel.org>
Date:   Thu, 06 Aug 2020 19:54:49 +0000
To:     Petr Mladek <pmladek@suse.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Sender: live-patching-owner@vger.kernel.org
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

The pull request you sent on Thu, 6 Aug 2020 10:24:37 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/livepatching/livepatching tags/livepatching-for-5.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1e21b5c73912a516bb13aec0ff69205b0b33568f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
