Return-Path: <SRS0=ZVZp=YD=vger.kernel.org=live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83063ECE596
	for <live-patching@archiver.kernel.org>; Thu, 10 Oct 2019 13:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64DCE214E0
	for <live-patching@archiver.kernel.org>; Thu, 10 Oct 2019 13:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbfJJNpB (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Thu, 10 Oct 2019 09:45:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:39486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726237AbfJJNpB (ORCPT <rfc822;live-patching@vger.kernel.org>);
        Thu, 10 Oct 2019 09:45:01 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B3CF208C3;
        Thu, 10 Oct 2019 13:45:00 +0000 (UTC)
Date:   Thu, 10 Oct 2019 09:44:58 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     Petr Mladek <pmladek@suse.com>, jikos@kernel.org,
        Joe Lawrence <joe.lawrence@redhat.com>, jpoimboe@redhat.com,
        mingo@redhat.com, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org
Subject: Re: [PATCH 0/3] ftrace: Introduce PERMANENT ftrace_ops flag
Message-ID: <20191010094458.3336fdd4@gandalf.local.home>
In-Reply-To: <20191010094352.35056c84@gandalf.local.home>
References: <20191007081714.20259-1-mbenes@suse.cz>
        <20191008193534.GA16675@redhat.com>
        <20191009112234.bi7lvp4pvmna26vz@pathway.suse.cz>
        <20191009102654.501ad7c3@gandalf.local.home>
        <20191010085035.emsdks6xecazqc6k@pathway.suse.cz>
        <20191010091403.5ecf0fdb@gandalf.local.home>
        <alpine.LSU.2.21.1910101535310.32665@pobox.suse.cz>
        <20191010094352.35056c84@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: live-patching-owner@vger.kernel.org
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

On Thu, 10 Oct 2019 09:43:52 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> 
> Yes, but let's still add the patch that does the permanent check. And
> then I'll put the "remove this flag" patch on top (and revert
> everything else). This way, if somebody complains, and Linus reverts
> the removal patch, we don't end up breaking live kernel patching
> again ;-)


Not to mention, the PERMANENT flag patch can be marked as stable. The
removal of the switch, not so.

-- Steve

