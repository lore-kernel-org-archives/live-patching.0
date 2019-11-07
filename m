Return-Path: <SRS0=q71e=Y7=vger.kernel.org=live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B2AC5DF60
	for <live-patching@archiver.kernel.org>; Thu,  7 Nov 2019 15:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAB6A21D7B
	for <live-patching@archiver.kernel.org>; Thu,  7 Nov 2019 15:29:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388597AbfKGP3Z (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Thu, 7 Nov 2019 10:29:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:40260 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727142AbfKGP3Z (ORCPT <rfc822;live-patching@vger.kernel.org>);
        Thu, 7 Nov 2019 10:29:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C7F9AB280;
        Thu,  7 Nov 2019 15:29:23 +0000 (UTC)
Date:   Thu, 7 Nov 2019 16:29:23 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Joe Lawrence <joe.lawrence@redhat.com>
Cc:     live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
Subject: Re: [PATCH] selftests/livepatch: filter 'taints' from dmesg
 comparison
Message-ID: <20191107152923.ppvls7zki6ncqww4@pathway.suse.cz>
References: <20191106222801.7541-1-joe.lawrence@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106222801.7541-1-joe.lawrence@redhat.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: live-patching-owner@vger.kernel.org
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

On Wed 2019-11-06 17:28:01, Joe Lawrence wrote:
> The livepatch selftests compare expected dmesg output to verify kernel
> behavior.  They currently filter out "tainting kernel with
> TAINT_LIVEPATCH" messages which may be logged when loading livepatch
> modules.
> 
> Further filter the log to also drop "loading out-of-tree module taints
> kernel" messages in case the klp_test modules have been build without
> the in-tree module flag.

It needs a special way how to build the selftest modules. But it is
clearly possible.

> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>

Reviewed-by: Petr Mladek <pmladek@suse.com>

> ---
> 
> Since there are no related livepatch-core changes, this can go
> through Shuah's kselftest tree if she prefers.

Shuah, would you like to take it via kselftest tree, please?

Or I could add it into livepatch tree if you would prefer it.

Best Regards,
Petr
