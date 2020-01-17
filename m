Return-Path: <SRS0=iOSR=3G=vger.kernel.org=live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E5A9C33CB1
	for <live-patching@archiver.kernel.org>; Fri, 17 Jan 2020 08:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B37220728
	for <live-patching@archiver.kernel.org>; Fri, 17 Jan 2020 08:26:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728986AbgAQI0U (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Fri, 17 Jan 2020 03:26:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:32924 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727002AbgAQI0U (ORCPT <rfc822;live-patching@vger.kernel.org>);
        Fri, 17 Jan 2020 03:26:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BA732AD11;
        Fri, 17 Jan 2020 08:26:18 +0000 (UTC)
Date:   Fri, 17 Jan 2020 09:26:17 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Petr Mladek <pmladek@suse.com>
cc:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Nicolai Stange <nstange@suse.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] livepatch/samples/selftest: Clean up show variables
 handling
In-Reply-To: <20200116153145.2392-1-pmladek@suse.com>
Message-ID: <alpine.LSU.2.21.2001170926040.29867@pobox.suse.cz>
References: <20200116153145.2392-1-pmladek@suse.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: live-patching-owner@vger.kernel.org
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

On Thu, 16 Jan 2020, Petr Mladek wrote:

> Dan Carpenter reported suspicious allocations of shadow variables
> in the sample module, see
> https://lkml.kernel.org/r/20200107132929.ficffmrm5ntpzcqa@kili.mountain
> 
> The code did not cause a real problem. But it was indeed misleading
> and semantically wrong. I got confused several times when cleaning it.
> So I decided to split the change into few steps. I hope that
> it will help reviewers and future readers.
> 
> The changes of the sample module are basically the same as in the RFC.
> In addition, there is a clean up of the module used by the selftest.
> 
> 
> Petr Mladek (4):
>   livepatch/sample: Use the right type for the leaking data pointer
>   livepatch/selftest: Clean up shadow variable names and type
>   livepatch/samples/selftest: Use klp_shadow_alloc() API correctly
>   livepatch: Handle allocation failure in the sample of shadow variable
>     API
> 
>  lib/livepatch/test_klp_shadow_vars.c      | 119 +++++++++++++++++-------------
>  samples/livepatch/livepatch-shadow-fix1.c |  39 ++++++----
>  samples/livepatch/livepatch-shadow-fix2.c |   4 +-
>  samples/livepatch/livepatch-shadow-mod.c  |   4 +-
>  4 files changed, 99 insertions(+), 67 deletions(-)

Acked-by: Miroslav Benes <mbenes@suse.cz>

M
