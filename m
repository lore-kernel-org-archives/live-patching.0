Return-Path: <live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD04C4332F
	for <live-patching@archiver.kernel.org>; Mon, 12 Dec 2022 14:58:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbiLLO6a (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Mon, 12 Dec 2022 09:58:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232390AbiLLO62 (ORCPT
        <rfc822;live-patching@vger.kernel.org>);
        Mon, 12 Dec 2022 09:58:28 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB222656C;
        Mon, 12 Dec 2022 06:58:27 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 67D881F8B3;
        Mon, 12 Dec 2022 14:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1670857106; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=R/8X7O5xD4y0+p+ZS3irGgqXxUCtysr8GPX03Pzflvk=;
        b=GvRp7/NKqUPWJyyhvLovYeDXQkt4oLI+qwyCimrzL2s3WtLUJ0Y8GVk1r7bpVYzRUS5c6X
        JNFfyaeHk2cqlrubHLSM8WItVK886KBHVo9bX/sZOcq4310m1YCZfzJCZe61xbyoN399pq
        ByXfGPQggzuEjf0rmpvoLXSwIebMpBk=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 44C742C141;
        Mon, 12 Dec 2022 14:58:26 +0000 (UTC)
Date:   Mon, 12 Dec 2022 15:58:23 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Subject: [GIT PULL] livepatching for 6.2
Message-ID: <Y5dBjz3g1V0exuIp@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170912 (1.9.0)
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

Hi Linus,

please pull the latest livepatching changes from

  git://git.kernel.org/pub/scm/linux/kernel/git/livepatching/livepatching.git tags/livepatching-for-6.2

======================================

- code cleanup

----------------------------------------------------------------
Zhen Lei (1):
      livepatch: Move the result-invariant calculation out of the loop

 kernel/livepatch/transition.c | 54 +++++++++++++++++++++----------------------
 1 file changed, 27 insertions(+), 27 deletions(-)
