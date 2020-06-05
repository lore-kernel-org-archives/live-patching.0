Return-Path: <SRS0=4/XI=7S=vger.kernel.org=live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 399F7C433E0
	for <live-patching@archiver.kernel.org>; Fri,  5 Jun 2020 13:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E32B206E6
	for <live-patching@archiver.kernel.org>; Fri,  5 Jun 2020 13:06:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgFENF7 (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Fri, 5 Jun 2020 09:05:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:33080 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726854AbgFENF6 (ORCPT <rfc822;live-patching@vger.kernel.org>);
        Fri, 5 Jun 2020 09:05:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1F23BAEE8;
        Fri,  5 Jun 2020 13:05:59 +0000 (UTC)
Date:   Fri, 5 Jun 2020 15:05:55 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Yannick Cote <ycote@redhat.com>
cc:     live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        joe.lawrence@redhat.com, linux-kernel@vger.kernel.org,
        pmladek@suse.com, kamalesh@linux.vnet.ibm.com
Subject: Re: [PATCH v2 1/4] selftests/livepatch: simplify test-klp-callbacks
 busy target tests
In-Reply-To: <20200603182058.109470-2-ycote@redhat.com>
Message-ID: <alpine.LSU.2.21.2006051505230.23532@pobox.suse.cz>
References: <20200603182058.109470-1-ycote@redhat.com> <20200603182058.109470-2-ycote@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: live-patching-owner@vger.kernel.org
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

On Wed, 3 Jun 2020, Yannick Cote wrote:

> From: Joe Lawrence <joe.lawrence@redhat.com>
> 
> The test-klp-callbacks script includes a few tests which rely on kernel
> task timings that may not always execute as expected under system load.
> These may generate out of sequence kernel log messages that result in
> test failure.
> 
> Instead of using sleep timing windows to orchestrate these tests, add a
> block_transition module parameter to communicate the test purpose and
> utilize flush_queue() to serialize the test module's task output.
> 
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>

Acked-by: Miroslav Benes <mbenes@suse.cz>

M
