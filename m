Return-Path: <SRS0=yIww=UU=vger.kernel.org=live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 079D5C43613
	for <live-patching@archiver.kernel.org>; Fri, 21 Jun 2019 14:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB7A12083B
	for <live-patching@archiver.kernel.org>; Fri, 21 Jun 2019 14:19:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbfFUOTh (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Fri, 21 Jun 2019 10:19:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43540 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbfFUOTh (ORCPT <rfc822;live-patching@vger.kernel.org>);
        Fri, 21 Jun 2019 10:19:37 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 307E93003A4D;
        Fri, 21 Jun 2019 14:19:34 +0000 (UTC)
Received: from redhat.com (ovpn-121-168.rdu2.redhat.com [10.10.121.168])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 44F5C60CA3;
        Fri, 21 Jun 2019 14:19:33 +0000 (UTC)
Date:   Fri, 21 Jun 2019 10:19:26 -0400
From:   Joe Lawrence <joe.lawrence@redhat.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Nicolai Stange <nstange@suse.de>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 5/5] livepatch: Selftests of the API for tracking system
 state changes
Message-ID: <20190621141926.GE20356@redhat.com>
References: <20190611135627.15556-1-pmladek@suse.com>
 <20190611135627.15556-6-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611135627.15556-6-pmladek@suse.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Fri, 21 Jun 2019 14:19:37 +0000 (UTC)
Sender: live-patching-owner@vger.kernel.org
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

On Tue, Jun 11, 2019 at 03:56:27PM +0200, Petr Mladek wrote:
> 
> [ ... snip ... ]
> 
> diff --git a/lib/livepatch/test_klp_state.c b/lib/livepatch/test_klp_state.c
> new file mode 100644
> index 000000000000..c43dc2f2e01d
> --- /dev/null
> +++ b/lib/livepatch/test_klp_state.c
> @@ -0,0 +1,161 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2019 SUSE
> 
> [ ... snip ... ]
> 
> +MODULE_AUTHOR("Joe Lawrence <joe.lawrence@redhat.com>");

Feel free to update the module author for these.

-- Joe
