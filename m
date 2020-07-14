Return-Path: <SRS0=ct9w=AZ=vger.kernel.org=live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D101C433E0
	for <live-patching@archiver.kernel.org>; Tue, 14 Jul 2020 07:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27C4B2145D
	for <live-patching@archiver.kernel.org>; Tue, 14 Jul 2020 07:53:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgGNHxJ (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Tue, 14 Jul 2020 03:53:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:36686 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725793AbgGNHxJ (ORCPT <rfc822;live-patching@vger.kernel.org>);
        Tue, 14 Jul 2020 03:53:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 76B3AAD81;
        Tue, 14 Jul 2020 07:53:10 +0000 (UTC)
Date:   Tue, 14 Jul 2020 09:53:07 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Joe Lawrence <joe.lawrence@redhat.com>
Cc:     live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: Re: [PATCH] selftests/livepatch: Use "comm" instead of "diff" for
 dmesg
Message-ID: <20200714075307.GF20226@alley>
References: <20200710183745.19730-1-joe.lawrence@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710183745.19730-1-joe.lawrence@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: live-patching-owner@vger.kernel.org
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

On Fri 2020-07-10 14:37:45, Joe Lawrence wrote:
> BusyBox diff doesn't support the GNU diff '--LTYPE-line-format' options
> that were used in the selftests to filter older kernel log messages from
> dmesg output.
> 
> Use "comm" which is more available in smaller boot environments.
> 
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>

The patch is committed in livepatch.git, branch
for-5.9/selftests-cleanup.

Best Regards,
Petr
