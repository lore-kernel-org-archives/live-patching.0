Return-Path: <SRS0=4vjg=CR=vger.kernel.org=live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2133C433E2
	for <live-patching@archiver.kernel.org>; Tue,  8 Sep 2020 18:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF0842087C
	for <live-patching@archiver.kernel.org>; Tue,  8 Sep 2020 18:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599589578;
	bh=UcQ6oyelFO/ob62Zfez22RKtcrEYHZiJgxaNj7c4m/s=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=hyqdQG80rQtBJnPZzD1DS+OY99nl69ni/FQqrYilduADXVnjSo1st2bj8C9zPVN3M
	 8Bcoo2Ut+mUkbBngBsLSnWKlIs1wOeDcktnTkzsjXUU/aO0e2AUolygPc5mUuCigaF
	 J/+sqHrBPmX+G8stArjuEdiqUPux6AAaBvj/QtAg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731555AbgIHSTf (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Tue, 8 Sep 2020 14:19:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:59950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730508AbgIHSQP (ORCPT <rfc822;live-patching@vger.kernel.org>);
        Tue, 8 Sep 2020 14:16:15 -0400
Subject: Re: [GIT PULL] livepatching for 5.9-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599588975;
        bh=UcQ6oyelFO/ob62Zfez22RKtcrEYHZiJgxaNj7c4m/s=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Ilt36w+jMlpP706pX2pd4BT1Eo1gU3+tMIbOdEZzoE1TljrKowSKqQVcE6iu49hcV
         jIeIrzbjN2uzGKkPG20cpmb0bsBWEHQ/cIxs+2dpypAo+nvonbYBMI7+uma+nj49T7
         68M7LHGTLj7+9J8I11Z+jxJMmlecW6NAAbaCujSI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200907082036.GC8084@alley>
References: <20200907082036.GC8084@alley>
X-PR-Tracked-List-Id: <live-patching.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200907082036.GC8084@alley>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/livepatching/livepatching tags/livepatching-for-5.9-rc5
X-PR-Tracked-Commit-Id: 318af7b80b6a6751520cf2b71edb8c45abb9d9d8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 612ab8ad64140f0f291d7baae45982ce7119839a
Message-Id: <159958897520.17639.5239334876489305639.pr-tracker-bot@kernel.org>
Date:   Tue, 08 Sep 2020 18:16:15 +0000
To:     Petr Mladek <pmladek@suse.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Sender: live-patching-owner@vger.kernel.org
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

The pull request you sent on Mon, 7 Sep 2020 10:20:36 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/livepatching/livepatching tags/livepatching-for-5.9-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/612ab8ad64140f0f291d7baae45982ce7119839a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
