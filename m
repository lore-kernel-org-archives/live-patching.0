Return-Path: <SRS0=6jd/=X2=vger.kernel.org=live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1AADC352AA
	for <live-patching@archiver.kernel.org>; Tue,  1 Oct 2019 12:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A670021A4C
	for <live-patching@archiver.kernel.org>; Tue,  1 Oct 2019 12:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbfJAMbK (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Tue, 1 Oct 2019 08:31:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:52346 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726137AbfJAMbK (ORCPT <rfc822;live-patching@vger.kernel.org>);
        Tue, 1 Oct 2019 08:31:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 96CE5AD95;
        Tue,  1 Oct 2019 12:31:08 +0000 (UTC)
Date:   Tue, 1 Oct 2019 14:30:44 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     jikos@kernel.org, jpoimboe@redhat.com, pmladek@suse.com
cc:     joe.lawrence@redhat.com, nstange@suse.de,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/3] livepatch: Clear relocation targets on a
 module removal
In-Reply-To: <20190905124514.8944-1-mbenes@suse.cz>
Message-ID: <alpine.LSU.2.21.1910011428001.6105@pobox.suse.cz>
References: <20190905124514.8944-1-mbenes@suse.cz>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: live-patching-owner@vger.kernel.org
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

On Thu, 5 Sep 2019, Miroslav Benes wrote:

> Updated version with Petr's feedback. It looks a bit different and
> better now (I would say). Not that it should be considered before we
> decide what to do with late module patching, but I finished it before
> the discussion started and someone could be interested.
> 
> v1: http://lore.kernel.org/r/20190719122840.15353-1-mbenes@suse.cz
> 
> Tested on x86_64, ppc64le and s390x. Cross-compiled on arm64 to verify
> that nothing is broken.
> 
> [1] 20180602161151.apuhs2dygsexmcg2@treble
> [2] 1561019068-132672-1-git-send-email-cj.chengjian@huawei.com
> [3] 20180607092949.1706-1-mbenes@suse.cz
> 
> Miroslav Benes (3):
>   livepatch: Clear relocation targets on a module removal
>   livepatch: Unify functions for writing and clearing object relocations
>   livepatch: Clean up klp_update_object_relocations() return paths
> 
>  arch/powerpc/kernel/module_64.c | 45 +++++++++++++++++++++++++
>  arch/s390/kernel/module.c       |  8 +++++
>  arch/x86/kernel/module.c        | 43 ++++++++++++++++++++++++
>  include/linux/moduleloader.h    |  7 ++++
>  kernel/livepatch/core.c         | 58 ++++++++++++++++++++++++---------
>  5 files changed, 146 insertions(+), 15 deletions(-)

Ping.

If I remember correctly, we decided to have this as a temporary solution 
before better late module patching is implemented. Feedback is welcome.
I'll then resend with arch maintainters CCed.

Thanks
Miroslav
