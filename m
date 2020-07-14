Return-Path: <SRS0=ct9w=AZ=vger.kernel.org=live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B52C433E4
	for <live-patching@archiver.kernel.org>; Tue, 14 Jul 2020 13:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6772422507
	for <live-patching@archiver.kernel.org>; Tue, 14 Jul 2020 13:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgGNN6D (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Tue, 14 Jul 2020 09:58:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:49504 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726793AbgGNN6A (ORCPT <rfc822;live-patching@vger.kernel.org>);
        Tue, 14 Jul 2020 09:58:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 08CECADE2;
        Tue, 14 Jul 2020 13:58:01 +0000 (UTC)
Date:   Tue, 14 Jul 2020 15:57:57 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Petr Mladek <pmladek@suse.com>
cc:     Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Shuah Khan <shuah@kernel.org>, live-patching@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests/livepatch: adopt to newer sysctl error
 format
In-Reply-To: <20200714091030.1611-1-pmladek@suse.com>
Message-ID: <alpine.LSU.2.21.2007141557420.5393@pobox.suse.cz>
References: <20200714091030.1611-1-pmladek@suse.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: live-patching-owner@vger.kernel.org
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

On Tue, 14 Jul 2020, Petr Mladek wrote:

> With procfs v3.3.16, the sysctl command doesn't print the set key and
> value on error.  This change breaks livepatch selftest test-ftrace.sh,
> that tests the interaction of sysctl ftrace_enabled:
> 
> Make it work with all sysctl versions using '-q' option.
> 
> Explicitly print the final status on success so that it can be verified
> in the log. The error message is enough on failure.
> 
> Reported-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
> Signed-off-by: Petr Mladek <pmladek@suse.com>

Acked-by: Miroslav Benes <mbenes@suse.cz>

M
