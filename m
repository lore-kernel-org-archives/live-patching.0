Return-Path: <live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5093C433EF
	for <live-patching@archiver.kernel.org>; Thu, 23 Sep 2021 13:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA6D461164
	for <live-patching@archiver.kernel.org>; Thu, 23 Sep 2021 13:22:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbhIWNYR (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Thu, 23 Sep 2021 09:24:17 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:38084 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231380AbhIWNYQ (ORCPT
        <rfc822;live-patching@vger.kernel.org>);
        Thu, 23 Sep 2021 09:24:16 -0400
Received: from relay1.suse.de (relay1.suse.de [149.44.160.133])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0DD042233C;
        Thu, 23 Sep 2021 13:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1632403364; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=91EbWsxBIacBihnMY3CoyaclWbO8k6zHMaDGYXBGc6k=;
        b=bNsG0taIqEIQ78hUE8AudLqClVPQeCRPE7jUo9LBEmNK7lZ0EkyQrl65qWO8lRQQhQQL06
        l/CERk6RdtnciK+35zRW+05oZ3HXwSufhzhli4LruvdHD536Puvu7562x//2t3BiU0ZSDy
        qe8mdE3p390N7qnbwf26hi+qTnPABbI=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay1.suse.de (Postfix) with ESMTPS id E240925D95;
        Thu, 23 Sep 2021 13:22:43 +0000 (UTC)
Date:   Thu, 23 Sep 2021 15:22:43 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     gor@linux.ibm.com, jpoimboe@redhat.com, jikos@kernel.org,
        mbenes@suse.cz, mingo@kernel.org, linux-kernel@vger.kernel.org,
        joe.lawrence@redhat.com, fweisbec@gmail.com, tglx@linutronix.de,
        hca@linux.ibm.com, svens@linux.ibm.com, sumanthk@linux.ibm.com,
        live-patching@vger.kernel.org, paulmck@kernel.org
Subject: Re: [RFC][PATCH 0/7] sched,rcu,context_tracking,livepatch: Improve
 livepatch task transitions for idle and NOHZ_FULL cpus
Message-ID: <YUx/o5yKx8iChHbg@alley>
References: <20210922110506.703075504@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210922110506.703075504@infradead.org>
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

On Wed 2021-09-22 13:05:06, Peter Zijlstra wrote:
> Hi,
> 
> Compile tested only, please consider carefully, esp. the last few patches that
> concern context_tracking and nohz_full.

BTW: The patchset seems to significantly speed up livepatch selftests
     in tools/testing/selftests/livepatch. I haven't measured it.
     But I do not longer have to switch screen and do anything else.

     The transition speed is not our priority. But it is another nice
     win of this patchset. I only hope that we did not introduce
     any race ;-)

Best Regards,
Petr
