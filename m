Return-Path: <SRS0=CImh=75=vger.kernel.org=live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D44C433E1
	for <live-patching@archiver.kernel.org>; Tue, 16 Jun 2020 14:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B607620C56
	for <live-patching@archiver.kernel.org>; Tue, 16 Jun 2020 14:43:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728975AbgFPOnZ (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Tue, 16 Jun 2020 10:43:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:36014 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728183AbgFPOnZ (ORCPT <rfc822;live-patching@vger.kernel.org>);
        Tue, 16 Jun 2020 10:43:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6A01EACAE;
        Tue, 16 Jun 2020 14:43:27 +0000 (UTC)
Date:   Tue, 16 Jun 2020 16:43:22 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Joe Lawrence <joe.lawrence@redhat.com>
Cc:     live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH v2 0/4] selftests/livepatch: small script cleanups
Message-ID: <20200616144322.GP31238@alley>
References: <20200615172756.12912-1-joe.lawrence@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615172756.12912-1-joe.lawrence@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: live-patching-owner@vger.kernel.org
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

On Mon 2020-06-15 13:27:52, Joe Lawrence wrote:
> This is a small collection of tweaks for the shellscript side of the
> livepatch tests.  If anyone else has a small cleanup (or even just a
> suggestion for a low-hanging change) and would like to tack it onto the
> set, let me know.
> 
> based-on: livepatching.git, for-5.9/selftests-cleanup
> merge-thru: livepatching.git
> 
> Joe Lawrence (4):
>   selftests/livepatch: Don't clear dmesg when running tests
>   selftests/livepatch: use $(dmesg --notime) instead of manually
>     filtering
>   selftests/livepatch: refine dmesg 'taints' in dmesg comparison
>   selftests/livepatch: add test delimiter to dmesg

For the series:

Revieved-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
